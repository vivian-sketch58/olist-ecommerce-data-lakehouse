![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![SQL](https://img.shields.io/badge/sql-4479A1?style=for-the-badge&logo=postgresql&logoColor=white)
![Meltano](https://img.shields.io/badge/Meltano-FF3E3E?style=for-the-badge&logo=Meltano&logoColor=white)
![dbt](https://img.shields.io/badge/dbt-FF694B?style=for-the-badge&logo=dbt&logoColor=white)
![Great Expectations](https://img.shields.io/badge/Great_Expectations-FF6600?style=for-the-badge&logo=great-expectations&logoColor=white)
![BigQuery](https://img.shields.io/badge/Google_BigQuery-4285F4?style=for-the-badge&logo=google-cloud&logoColor=white)
![Tableau](https://img.shields.io/badge/Tableau-E97627?style=for-the-badge&logo=tableau&logoColor=white)
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
    * **Status:** Senior Management Approved.

* **[Milestone 2] Infrastructure & Ingestion ✅**
    * **Environment Setup:** BigQuery project structure and IAM security configuration.
    * **Automated Ingestion:** Meltano pipelines implemented for robust EL (Extract & Load).
    * **Status:** Bronze Layer - Raw data successfully landed in `BigQuery/olist_raw` (Initial landing in JSON format before Warehouse load).

* **[Milestone 3] Transformation & Quality Assurance ✅**
    * **Staging models** (Silver Layers)
    * **Core Modeling:** dbt transformation logic and Star Schema build (Gold Layers).
    * **Data Quality:** Implementation of 79+ automated tests and documentation.
    * **Status:** Staging data in `olist_dwh_stg`; Fact and Dim tables live in `olist_dwh`.

* **[Milestone 4] Analytics & Business Intelligence ✅**
    * **Marts Modeling:** Developing business-ready tables.
    * **Visualization:** Building high-fidelity dashboards.
    * **Status:** Marts tables in `olist_dwh_marts`; Tableau mockup is ready for review.

* **[Milestone 5] Orchestration & Observability 📅**
    * **Workflow Management:** Integrating **Dagster** for end-to-end pipeline automation.
    * **Monitoring:** Establishing data SLAs and pipeline health alerts.
    * **Status:** Planning phase for workflow automation.

* **[Milestone 6] Presentation & Final Delivery ✅**
    * **Executive Handover:** Presentation to technical (CTOs, Engineering Directors) and business leadership (CFOs, COOs).
    * **Final Review:** Delivery of insights and project sign-off.
    * **Status:** Awaiting Final Client Approval.

---

## 📂 Project Navigation & Documentation

This repository is organized into **modular layers**, following the **Modern Data Stack** architecture to ensure scalability and data integrity.

---

### 🏗️ Technical Blueprint
The **Master Design Document** outlines the architectural foundation of the lakehouse:

- **ELT Pipeline Design:** Mapping the flow from Source to BigQuery.
- **Source-to-Target Mapping:** Detailed schema definitions and transformations.
- **Conceptual Lineage Graph:** Visualization of data dependencies from Bronze to Gold.
- 📘 **[Olist Data Lakehouse Technical Blueprint](./docs/Olist_Technical_Blueprint.pdf)**

---

### 📥 Data Ingestion (Meltano)
The **Extract & Load (EL) layer**.  
This directory contains the **Meltano configuration** used to automate the movement of raw Brazilian e-commerce data into the **BigQuery Lakehouse**. It manages the initial "Landing Zone" or Bronze layer.

---

### 🔄 Data Transformation (dbt)
The **Transformation (T) layer**.  
This is the core logic for the **Star Schema** implementation. It includes:

- **Staging Models:** Initial cleaning, casting, and renaming of raw fields.
- **Dimension and Fact Builds:** The "Gold Layer" optimized for high-performance BI queries.
- **Data Quality:** **79+ automated tests** (Generic and Singular) to guarantee the single source of truth.

---

### 📊 Final Deliverables
The final "Business-Ready" deliverables for executive decision-making:

- **Executive Presentation:** A comprehensive slide deck covering pipeline architecture and key insights.
- 📑 [**View: Executive Presentation Slides**](./docs/Olist%20E-Commerce%20Data%20Lakehouse%20Presentation.pdf)

- **Tableau Storytelling:** This demo illustrates the pipeline from Rose Marts to BI, enabling leadership to perform root-cause analysis.
- 🔗 **[Dashboard: Blue Rose Marts Preview](./docs/Olist%20-%20Rose%20Marts%20Preview.pdf)**


---

## 🏁 Conclusion & Key Takeaways

This project served as a comprehensive application of the **Modern Data Stack** to solve real-world e-commerce data challenges. 

### 🧠 Lessons Learned
- **Data Quality as a Standard:** Implementing **79+ automated dbt tests** taught me that data reliability is the foundation of business trust.
- **Architectural Efficiency:** Transitioning from normalized sources to a **Star Schema** (Gold Layer) significantly optimized query performance for Tableau.
- **End-to-End Orchestration:** Leveraging **Meltano** and **dbt** demonstrated the power of "Analytics as Code" for repeatable, scalable data pipelines.

### 🚀 Future Roadmap
- **CI/CD Integration:** Automating dbt runs and testing via GitHub Actions.
- **Advanced Analytics:** Integrating a machine learning layer for customer churn prediction.
- **Real-time Processing:** Exploring streaming ingestion for live sales tracking.

---
*Developed by Vivian — [[My LinkedIn Profile](https://www.linkedin.com/in/vivian-%E5%BE%AE-cao-b00a6592/)]*

