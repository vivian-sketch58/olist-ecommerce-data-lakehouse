## 📊 Data Marts: Business Intelligence Layer

### 📖 Overview

The **Marts layer** is the final destination in our dbt pipeline. While the **dwh layer** focuses on normalization and a **star schema structure**, the **Marts layer** focuses on usability.

These **“wide tables”** are designed to be plugged directly into BI tools such as Tableau or Looker without requiring complex joins by the business user.

---

### 🏗️ Model Directory

We have developed **five core business-ready models**:

| Model                       | Description                                                   |
| --------------------------- | ------------------------------------------------------------- |
| `mart_customer_orders`      | Customer-level summary of purchase behavior                   |
| `mart_product_performance`  | Product sales, revenue, and popularity metrics                |
| `mart_seller_performance`   | Seller performance including revenue and order volume         |
| `mart_delivery_performance` | Shipping and delivery performance metrics                     |
| `mart_payment_analysis`     | Payment types, installment patterns, and revenue contribution |

---

### 🎯 Purpose

These models serve as the **Business Intelligence layer**, providing:

* Pre-aggregated metrics for faster dashboards
* Simplified schemas for analysts and business users
* Consistent business logic across reports
* Direct integration with BI tools

## 🚀 Execution & Validation
To build the analytical layer after the staging and core layers are complete:
```bash
# Run all models in the marts folder
dbt run --select marts

# Run a specific mart (e.g., Delivery Metrics)
dbt run --select mart_delivery_performance
```

## Data Quality Assurance
Every mart is tested for grain integrity and relationship consistency using the schema.yml configurations:
```bash
dbt test --select marts
```
## 📈 Data Lineage & Flow

The Marts layer represents the final stage of our ELT Pipeline. By utilizing dbt docs, we can visualize the full dependency graph:raw (BigQuery) $\rightarrow$ staging (Cleaning) $\rightarrow$ dwh (Dimensions/Facts) $\rightarrow$ marts (BI Ready)

## 🛠️ Implementation Details

- **Materialization:** Most marts are materialized as **tables** to ensure high performance for dashboard users.
- **Documentation:** Built corresponding `schema.yml` files to document **column descriptions** and **metadata** for every field.
- **Logic:** Business logic (such as calculating **"Days to Deliver"** or **"Sales Growth"**) is encapsulated here, ensuring a **single source of truth** across all reports.

---

## 📂 Final Project Architecture

Your BigQuery project is now organized into **functional datasets**, representing the full data lifecycle:

| Dataset | Description |
|---------|-------------|
| `olist_raw` | Untouched source data (CSV, external sources). |
| `olist_dwh_stg` | Cleaned and type-cast data (staging layer). |
| `olist_dwh` | Core **Star Schema** with Facts and Dimensions. |
| `olist_dwh_marts` | Gold-standard data for **business users and BI tools** (final marts layer). |

## 📂 Turn Marts tables to a Actionable Insight

### 1.Query sales summary table from Marts in BigQuery

 SELECT *,
  FORMAT_DATE('%Y%m%d', order_date) AS join_key_int, -- Creates 20160913
  CAST(order_date AS STRING) AS join_key_str        -- Creates 2016-09-13
  FROM `marine-bebop-488207-j2.olist_dwh_marts.mart_sales_summary` LIMIT 5000

  ### 2. Query dim_date table from core of warehouse

-- This shifts the scale so Monday = 1
MOD(EXTRACT(DAYOFWEEK FROM full_date) + 5, 7) + 1 AS day_of_week_monday_start





  ### "Scheduled Extract"

  **Manual Refresh:** On your desktop, you can right-click the BigQuery data source and select Extract > Refresh. This will pull the latest data from BigQuery into your local .hyper file.