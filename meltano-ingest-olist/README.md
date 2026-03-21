[⬅️ Back to Main Project](../README.md)

# 📥 Data Ingestion & Load: Meltano Pipeline

## 📖 Project Overview
This component manages the end-to-end data pipeline orchestration for the **Extraction and Loading (EL)** phases. By landing data in a centralized warehouse before transformation, we adhere to a modern **ELT (Extract, Load, Transform)** architecture.

* **Meltano:** Handles the robust extraction and loading of 9+ Olist datasets.
* **BigQuery:** Serves as the centralized Data Lakehouse landing zone.
* **Dagster (Future Phase):** Will be implemented for advanced orchestration, scheduling, and pipeline observability.

## 🛠️ Ingestion Stack
* **Orchestrator:** Meltano
* **Extractor (Tap):** `tap-csv`
* **Loader (Target):** `target-bigquery`
* **Destination:** Google BigQuery (`olist_raw` dataset)

## 🚀 Pipeline Architecture
The pipeline follows a decoupled **Extract-Load-Transform (ELT)** pattern. Data is pulled from local CSV sources and landed in BigQuery without immediate transformation. This approach ensures that the ingestion layer remains lightweight and highly available, while the heavy processing is deferred to the data warehouse.

## 📋 Configuration & Setup

### 1. Prerequisites
* **Python:** 3.11
* **Conda Environment:** Create the environment using the `elt-environment.yml` located in the `/environment` folder.
* **Meltano:** `pip install meltano`
* **Cloud:** A Google Cloud Platform (GCP) account with the [gcloud CLI installed](https://cloud.google.com/sdk/docs/install).

### 2. Initial Workspace Setup
To ensure the environment supports Meltano and BigQuery requirements, activate the environment and verify versions:

```bash
conda activate elt
meltano config set meltano python python3.11
meltano --version
python --version
```
### 3. Data Preparation
First, download the [Brazilian E-Commerce Dataset (Olist)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) from Kaggle.

### 4. Project Folder & Local Staging
Create the necessary directory structure and move the raw CSV files into the project's local landing zone:

```bash
# Navigate to project root
cd M2-olist-data-engineering

# Create a sub-folder for raw CSV files
mkdir -p data/raw # create a sub folder for .csv

# Copy CSV files from your local downloads to the project sub-folder
cp /mnt/c/Users/Family/Downloads/archive/*.csv ./data/raw/ 

# Verify the files are in place
ls ./data/raw
```

## 🔧 Implementation Steps
### 1. Initialize Meltano

```bash
meltano init meltano-ingest-olist
cd meltano-ingest-olist
```
### 2. Configure Extraction (tap-csv) : add extractor tap-csv

```bash
meltano add tap-csv
# Configure tap-csv in meltano.yml with file paths and keys
meltano select tap-csv --list
```

### 3. Configure a Dummy Loader to Dump Data into JSON

We add a JSON target to test our pipeline. The JSON target will dump the data into a JSON file.

```bash
meltano add target-jsonl
```

### 4. Test Run Github to JSON

We can now test run the pipeline to see if it works.

```bash
meltano run tap-github target-jsonl
```

The extracted data will be dumped into a JSON file in the `output/` directory.

### 5. Configure BigQuery Loader 
We will now add a loader to load the data into BigQuery.

```bash
meltano add target-bigquery
```

```bash
meltano config set target-bigquery --interactive
```

Set the following options:

- batch_size: 104857600  # to spead up data loading
- `credentials_path`: _full path to the service account key file_
- `dataset`: `olist_raw`
- `denormalized`: `true`
- `flattening_enabled`: `true`
- `flattening_max_depth`: `1`
- `method`: `batch_job`
- `project`: *your_gcp_project_id*

### 6. Run data/raw/*.csv to BigQuery

We can now run the full ingestion (extract-load) pipeline.

```bash
meltano run tap-cvs target-bigquery
```

## 🛠️ Troubleshooting

The initial ingestion failed two times:

### 1. Workspace Environment Conflict
#### The Problem:
Using Python 3.12 caused dependency conflicts when executing meltano add tap-csv.

```bash
meltano add tap-csv
```
#### Solution: 
Reverted to Python 3.11 to ensure compatibility with Meltano's current plugin ecosystem.

#### Reflection: 
Environment consistency (matching Python versions to framework requirements) is foundational for efficient data engineering.

### 2. Data Integrity & Encoding Issues
Hidden characters in the source CSV files (product_category_name_translation.csv) prevented successful loading into BigQuery.

#### The Problem:
Headers contained a UTF-8 BOM (M-oM-;M-?) and Windows Carriage Returns (^M), which are invalid characters for BigQuery column names.

```bash
M-oM-;M-?product_category_name,product_category_name_english^M$
```
There are two hidden issues:
M-oM-;M-? → UTF-8 BOM (Byte Order Mark) at the start of the file
^M → Windows carriage return (\r)
Both make Google BigQuery think the column name is invalid.

#### Solution: 
utilized shell utilities to clean the files before ingestion:

```bash
# Remove UTF-8 BOM (Byte Order Mark)
sed -i '1s/^\xEF\xBB\xBF//' product_category_name_translation.csv

# Convert Windows carriage returns to Unix format
dos2unix product_category_name_translation.csv

# Verify clean headers
head -n 1 product_category_name_translation.csv | cat -A
product_category_name,product_category_name_english$
```
#### Result:
Headers were successfully cleaned (output: product_category_name,product_category_name_english$). The data was then successfully loaded.

## 🏃 Execution & Results
With the environment stabilized and data sanitized, the full ingestion pipeline was executed:

```bash
meltano run tap-cvs target-bigquery
```
### Result: 
All 9 CSV files successfully landed in BigQuery as JSON-formatted records in the olist_raw dataset. The foundation is now ready for dbt transformation.

---

## 💡 Technical Note: Automatic Type Inference & Resilience
By default, the Meltano loader brings all data into BigQuery as **STRING** types. While this is an automatic behavior, it serves as a critical strategic advantage for this pipeline:

* **Ingestion Stability:** Using `STRING` as the "lowest common denominator" ensures that 100% of the data loads successfully. The pipeline will not crash if a numeric column contains unexpected text or symbols.
* **Schema-on-Read:** This architecture adopts a "Schema-on-Read" philosophy. We capture the raw data exactly as it exists in the source, preserving every character for downstream auditing.
* **Separation of Concerns:** * **Meltano** is dedicated to **Data Movement**.
    * **dbt** is dedicated to **Data Integrity** (casting these strings into proper `INT`, `DATETIME`, and `FLOAT` types during the Staging phase).