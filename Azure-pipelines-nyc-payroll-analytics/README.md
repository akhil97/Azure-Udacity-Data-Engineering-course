# Azure Pipelines NYC Payroll Analytics

This project implements an Azure-based payroll analytics pipeline using **Azure Data Factory-style pipeline artifacts**, **Mapping Data Flows**, **Azure Data Lake Storage Gen2**, and **Azure SQL Database**. The solution appears to ingest NYC payroll source files for multiple fiscal years, build master and fact-style outputs, and generate summary-level analytical datasets for downstream reporting and analysis.

## Overview

The project is organized as an exported Azure pipeline workspace with folders for linked services, datasets, mapping data flows, pipeline orchestration, and screenshots. This structure suggests a metadata-driven ingestion and transformation workflow built in Azure Data Factory or Synapse pipelines, where raw payroll files land in Data Lake Storage and are then transformed into curated SQL tables and summary outputs.

The visible assets indicate that the project processes NYC payroll datasets for at least **2020** and **2021**, derives master datasets such as employee, title, and agency reference tables, and produces an aggregated payroll summary table.

## Architecture

The project uses two core data platforms:

- **Azure Data Lake Storage Gen2** for storing source and staging files.
- **Azure SQL Database** for storing curated payroll tables and analytical outputs.

From the linked service definitions, the data lake connection is configured as an **AzureBlobFS** endpoint, and the SQL target is an **Azure SQL Database** using **System Assigned Managed Identity** authentication.

### End-to-end flow

The workflow implied by the pipeline and data flow definitions is:

1. Read raw NYC payroll CSV files from Azure Data Lake Storage.
2. Create or populate master/reference datasets such as employee, agency, and title.
3. Load fiscal-year-specific payroll data for 2020 and 2021.
4. Combine annual payroll datasets into a unified summary transformation.
5. Write curated outputs into Azure SQL tables.
6. Optionally write summary-stage outputs back into Azure Data Lake staging storage.

## Repository Structure

```text
Azure-pipelines-nyc-payroll-analytics/
│
├── dataflows/
│   ├── aggregated_df.json
│   ├── df_emp_master.json
│   ├── df_load_payroll_2020.json
│   ├── df_load_payroll_2021.json
│   ├── df_payroll_agency.json
│   ├── df_summary.json
│   └── df_title.json
│
├── datasets/
│   ├── ds_agencymaster.json
│   ├── ds_empmaster.json
│   ├── ds_nycpayroll_2020.json
│   ├── ds_nycpayroll_2021.json
│   ├── ds_sql_payroll.json
│   ├── ds_sql_payroll_2020.json
│   ├── ds_sql_payroll_2021.json
│   ├── ds_sql_payroll_agency.json
│   ├── ds_sql_payroll_summary.json
│   ├── ds_sql_payroll_title.json
│   ├── ds_staging_summary.json
│   └── ds_titlemaster.json
│
├── linkedService/
│   ├── LS_AzureDataLakeStorage.json
│   └── LS_AzureSqlDatabase1.json
│
├── pipeline/
│   └── pipleine.json
│
├── screenshots/
└── .gitignore
