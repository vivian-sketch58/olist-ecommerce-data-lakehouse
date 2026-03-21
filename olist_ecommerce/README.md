[⬅️ Back to Main Project](../README.md)
# 💎 Data Transformation: dbt Star Schema & Marts

## 📖 Overview
This component handles the **Transformation (T)** layer of the ELT pipeline. Using **dbt (data build tool)**, we transform raw tabular data from BigQuery into a clean, high-performance **Star Schema** optimized for Business Intelligence and analytical querying.

## 🏗️ Modeling Architecture
The project follows a modular, multi-layered approach to ensure data integrity and clear lineage:

1.  **Staging Layer (`olist_dwh_stg`)**
    * **Source:** Raw `.csv` imports in `olist_raw`.
    * **Actions:** Initial cleaning, field renaming for consistency, casting data types (e.g., strings to timestamps), and basic deduplication.
2.  **Core Layer (`olist_dwh`)**
    * **Structure:** Implementation of **Star Modeling**.
    * **Fact Tables:** Centralized transactional data (e.g., `fact_orders`) and logistics data (e.g. fact_geolocation).
    * **Dimension Tables:** Descriptive attributes (e.g., `dim_products`, `dim_customers`, `dim_sellers`) and time serial (i.e. `dim_date`).
3.  **Marts Layer (`olist_dwh_marts`)**
    * **Structure:** Wide, "Business-Ready" tables.
    * **Purpose:** Aggregations designed specifically for Tableau and Looker dashboards, such as Monthly Sales Growth and Logistics Performance KPIs.

## 🛠️ Technical Stack
* **Transformation Engine:** `dbt-core` (v1.x)
* **Warehouse:** Google BigQuery
* **Adapter:** `dbt-bigquery`
* **Language:** Templated SQL (Jinja)

## 🏗️ Development Workflow
The implementation followed a structured, professional dbt lifecycle to build a scalable data warehouse:

### 1. Environment & Project Initialization
* **Project Setup:** Initialized to establish the standard directory structure.
```bash
pip freeze > requirements.txt
```
* **Dependency Management:** Configured packages.yml (v2.7+) to leverage dbt_utils to ensure the required dbt packages (like dbt_utils) installed:
```bash
dbt init
dbt deps
```
### 2. Security & Connectivity: 
Configured `profiles.yml` for secure BigQuery authentication and verified to ensure service account key and Project ID are correct:
```bash
dbt debug
```

### 3. Architecture & Layering
* **Macros:** Implemented `generate_schema_name` macros to automate environment-specific schema routing.
* **Directory Structure:** Organized models into a multi-layered architecture:
    * `staging/`: Initial cleaning and casting.
    * `dwh/`: Core Dimensional Modeling (Facts & Dimensions).
    * `marts/`: Business-ready analytical views.
    * `snapshots/`: Historical state tracking.

### 4. Staging & Data Cleaning
* **Source Declaration:** Created `sources.yml` to map the `olist_raw` dataset, providing clear lineage and freshness tracking.
* **Type Casting:**  Developed SQL models to cast the raw **STRING** data types into proper `INT`, `DATETIME`, `NUMERIC`formats and Currency (BRL or USD$), ensuring data integrity from the start.

### 5. Dimensional Modeling (The Star Schema)
* **Core Modeling:** Built optimized **Fact** and **Dimension** tables using surrogate keys and normalized attributes.
* **Documentation:** Built corresponding `schema.yml` files for every layer to document column descriptions and metadata.

### 6. Historical Tracking (Snapshots)
* **Snapshots - Slowly Changing Dimensions (SCD Type 2):** Implemented historical state tracking for products. (for architectural demonstration only even there is no data update from olist data)
* **Target:** `products_snapshot`
* **Strategy:** Tracking changes in product attributes over time.
```bash
dbt snapshot --select products_snapshot
```
### 7. Pipeline Execution
Execute the models layer by layer or run the entire project:
```bash
# Run all models
dbt run

# Run a specific layer
dbt run --select staging

# Run a specific file
dbt run --select stg_customers 
```
### 8. Marts layer (Please refer to ~/marts/README.md)

## 🧪 Data Quality & Testing

To ensure the Olist Lakehouse remains a **Single Source of Truth**, I implemented a multi-layered testing strategy covering both structural integrity and business logic.

### 1. dbt Core Tests (Schema & Relationship Validation)
We have leverage **79+ automated tests** that execute during the transformation layer to catch upstream data issues before they reach the Marts.

* **Generic Tests:** `unique`, `not_null`, and `relationships` (referential integrity) across all primary and foreign keys.
* **Singular Tests:** Custom SQL validations to catch business logic errors (e.g., ensuring `order_delivered_customer_date` is after `order_purchase_timestamp`).

**Run tests via CLI:**
```bash
dbt test
```
### 2. Great Expectations (Data Contract Validation)
For the **Bronze (Raw) to Silver (Staging)** transition, I utilized Great Expectations to enforce data contracts and prevent "Data Drift."

* **Column Statistics:** Validated that payment_value is always positive and within expected standard deviations.

* **Schema Enforcement:** Ensured that the raw ingestion from Meltano matches the expected types before hitting BigQuery.

* **Data Completeness:** Verified that critical dimensions (like zip_code_prefix) maintain a 99%+ population rate.

## 📂 Documentation & Discovery
We use dbt’s native documentation engine to provide a transparent view of the data's journey.

📊 Accessing the Lineage Graph
1. Generate and serve the documentation:

```bash
dbt docs generate
dbt docs serve
```
Catalog written to /home/vivian/M2-olist-data-engineering/olist_ecommerce/target/catalog.json

 http://localhost:8080: 

* Navigate to the **Project** tab in the sidebar.

* Click the **Lineage Graph** icon in the bottom-right corner to view the end-to-end flow from raw CSV to the final Marts.

## 📦 Portable Documentation
For client submission, a standalone, static version of the documentation is generated here:
~/M2-olist-data-engineering/olist_ecommerce/target/static_index.html
```bash
dbt docs generate --static
````

## 🗂️ Project Structure

```bash
tree -L 2
```
.
├── README.md
├── analyses
├── dbt_packages
│   ├── dbt_date
│   ├── dbt_expectations
│   └── dbt_utils
├── dbt_project.yml
├── dim_date.csv
├── logs
│   └── dbt.log
├── macros
│   └── generate_schema_name.sql
├── models
│   ├── fact_geolocation.sql
│   ├── fact_order_items.sql
│   ├── fact_orders.sql
│   ├── fact_payments.sql
│   ├── fact_reviews.sql
│   ├── marts
│   ├── packages.yml
│   ├── schema.yml
│   ├── sources.yml
│   ├── staging
│   └── star
├── package-lock.yml
├── packages.yml
├── profiles.yml
├── seeds
├── snapshots
│   └── products_snapshot.sql
├── target
│   ├── compiled
│   ├── graph.gpickle
│   ├── graph_summary.json
│   ├── manifest.json
│   ├── partial_parse.msgpack
│   ├── run
│   ├── run_results.json
│   └── semantic_manifest.json
└── tests
