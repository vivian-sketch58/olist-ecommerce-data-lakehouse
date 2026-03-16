# 📦 Olist E-Commerce Data Lakehouse

## 📑 Project Title
**Strategic Implementation of an End-to-End Google Cloud Data Lakehouse and Pipeline Architecture for E-Commerce Analytics**

---

## 🚀 Executive Summary
This project delivers a robust, automated Data Engineering pipeline that transforms raw Brazilian E-Commerce data (Olist) into actionable business intelligence. By leveraging a Modern Data Stack (Meltano, BigQuery, dbt), the system converts fragmented transaction logs into a high-performance **Star Schema** designed for executive-level reporting.

## 🎯 Value Proposition & Goals
* **Centralized Truth:** Consolidates 9+ disparate data sources into a single source of truth in BigQuery.
* **Operational Efficiency:** Automates the ELT process, reducing manual data preparation time by 100%.
* **Decision Support:** Provides pre-aggregated "Marts" for immediate analysis of product performance, seller efficiency, logistics performance, and customer lifetime value.

## 🛠️ Technical Approach
A modular **ELT (Extract, Load, Transform)** architecture was implemented:
1. **Analysis & Design:** Deep-dive analysis of Olist raw data to map relationships and define the grain for Staging, Core, and Marts layers.
2. **Ingestion (EL):** Automated extraction via **Meltano**, ensuring reproducible and version-controlled data movement.
3. **Storage:** Cloud-native warehousing in **Google BigQuery** for infinite scalability.
4. **Transformation (T):** A multi-layered **dbt** project creating a Star Schema (Fact & Dimension) optimized for analytical queries.
    * **Staging:** Data cleaning, renaming, and standardization of raw source data.
    * **Core:** Implementation of Dimensional Modeling (Fact & Dimension tables).
    * **Marts:** High-level business-logic aggregations for final reporting and analytics.
5. **Quality Assurance:** **79+ automated tests** verifying data integrity at every step of the pipeline.

## 🏁 Milestones & Progress

* **[Milestone 1] Project Design & Planning ✅**
    * Data profiling and relationship mapping of raw Olist datasets.
    * Architectural blueprinting for Staging, Core, and Marts layers.
    * **Status:** Client Approved.

* **[Milestone 2] Infrastructure & Ingestion ✅**
    * **Environment Setup:** BigQuery project structure and IAM security configuration.
    * **Automated Ingestion:** Meltano pipelines implemented for robust EL (Extract & Load).
    * **Status:** Raw data successfully landed in `BigQuery/olist_raw` (Initial landing in JSON format before Warehouse load).

* **[Milestone 3] Transformation & Quality Assurance ✅**
    * **Core Modeling:** dbt transformation logic and Star Schema build.
    * **Data Quality:** Implementation of 79+ automated tests and documentation.
    * **Status:** Staging data in `olist_dwh_stg`; Fact and Dim tables live in `olist_dwh`.

* **[Milestone 4] Analytics & Business Intelligence 🏗️**
    * **Marts Modeling:** Developing business-ready tables.
    * **Visualization:** Building high-fidelity dashboards.
    * **Status:** Marts tables in `olist_dwh_marts`; Tableau mockup is ready for review.

* **[Milestone 5] Orchestration & Observability 📅**
    * **Workflow Management:** Integrating **Dagster** for end-to-end pipeline automation.
    * **Monitoring:** Establishing data SLAs and pipeline health alerts.
    * **Status:** Planning phase for workflow automation.

* **[Milestone 6] Presentation & Final Delivery 🚀**
    * **Executive Handover:** Presentation to technical (CTOs, Engineering Directors) and business leadership (CFOs, COOs).
    * **Final Review:** Delivery of insights and project sign-off.
    * **Status:** Awaiting Final Client Approval.

---

## 📂 Project Components

* **[Data Ingestion (Meltano)](./meltano-ingest-olist/)**
    * Detailed documentation of the **Extract & Load (EL)** process, including source-to-target mapping and Meltano configuration.
* **[Data Transformation (dbt)](./olist_ecommerce/)**
    * Core logic for the **Star Schema** implementation. Includes staging models, fact/dimension builds, and the dbt test suite.
* **[Project Planning & Design](./docs/)**
    * Comprehensive **Project Proposal** and **Data Analytics Design** documents covering the initial profiling and architectural strategy.
* **[Presentation & Insights](./docs/)**
    * Executive presentation slides and **Tableau Storytelling** dashboards showcasing key business insights and logistics performance.