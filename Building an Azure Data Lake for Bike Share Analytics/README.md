# Building an Azure Data Lake for Bike Share Analytics

This project implements a lakehouse-style analytics platform for Divvy bike share data using **Azure Databricks**, **Delta Lake**, and **PySpark**. The goal is to ingest raw bike share data into a Bronze layer, transform it into curated Delta tables, and model it into an analytics-ready star schema that supports business questions about ride duration, station usage, rider behavior, and spending patterns. [web:66][web:68]

## Overview

The project is based on Divvy bikeshare data published by the City of Chicago and is structured around Azure Databricks lakehouse principles. Instead of loading everything directly into a warehouse first, the solution uses Delta Lake tables to organize raw and transformed data into layered stores and then exposes a dimensional model for downstream analytics. [web:66][web:72]

Udacity describes this project as implementing lakehouse architecture on Azure Databricks, and public project implementations consistently show a Bronze-to-Gold pattern using Delta Lake and star-schema transformation. [web:68][web:66][web:41]

## Project objectives

- Design a star schema based on the target business outcomes. [web:66][web:72]
- Import the bike share data into Azure Databricks. [web:66]
- Store raw data in Delta Lake as a Bronze data store. [web:66]
- Transform curated source data into Gold Delta tables. [web:66][web:68]
- Build dimension and fact tables for analytical workloads. [web:66][web:69]
- Support business analysis around trip duration, rider activity, and revenue-related questions. [web:66][web:72]

## Business questions answered

The project is designed to support questions such as:

- How much time is spent per ride. [web:66]
- How ride duration varies by date and time factors such as day of week or time of day. [web:66]
- How usage varies by starting and ending station. [web:66]
- How rider behavior changes by demographic or membership-related attributes. [web:66][web:69]
- How much money is spent overall and per member. [web:66]
- How many rides and how many ride minutes a rider averages per month. [web:66]

These outcomes drive the star-schema design and explain why the project uses fact and dimension tables instead of leaving the data in raw transactional form. [web:66][web:72]

## Architecture

The lakehouse flow for this project is:

1. Upload raw source files into Azure Databricks storage, commonly under DBFS `/FileStore/tables/`. [web:66]
2. Ingest the raw files into Delta Lake Bronze tables. [web:66][web:68]
3. Clean, standardize, and transform the data using PySpark notebooks. [web:67][web:72]
4. Create curated analytical tables in the Gold layer. [web:66]
5. Transform the curated data into a star schema with dimension and fact tables. [web:66][web:69]
6. Query the final Delta tables for reporting and analytics. [web:68][web:72]

This architecture follows a medallion-style pattern, where Bronze captures raw source fidelity and Gold provides analytics-ready structures optimized for downstream consumption. [web:68][web:69]

## Technology stack

- **Azure Databricks** for notebook-based development and distributed Spark execution. [web:68][web:72]
- **Delta Lake** for reliable table storage and ACID transactions in the lakehouse. [web:66][web:68]
- **PySpark** for data ingestion, cleaning, transformation, and table creation. [web:67][web:69]
- **DBFS** or Databricks-accessible storage for raw file upload and staging. [web:66]
- **Hive metastore** in public implementations for registering the resulting Bronze and Gold tables. [web:66]

## Data model

A common design for this project centers on ride activity as the core business event. The analytical layer is typically modeled with a central trip fact table and supporting dimensions such as rider, station, date, time, and account or membership context. Some implementations also include payment-related facts to support spending analysis. [web:66][web:69]

This dimensional design is important because it makes common analytical queries simpler and more performant than working directly against raw source files. It also aligns the storage model with the business outcomes defined in the project. [web:66][web:72]

## Layered storage design

### Bronze

The Bronze layer stores the raw source files with minimal transformation. In public implementations of this project, the raw bike share files are uploaded into Databricks storage and then written into Delta format as the first persistent layer. [web:66][web:68]

### Gold

The Gold layer contains curated Delta tables designed for analytics. These tables hold transformed data and the final star-schema outputs used for business analysis and reporting. [web:66][web:69]

Some project variations also mention an intermediate cleaned layer, but the public Udacity-aligned descriptions most consistently emphasize Bronze and Gold for this assignment. [web:66][web:68]

## Typical workflow

A practical implementation usually follows this sequence:

1. Create the Azure Databricks workspace and cluster. [web:66]
2. Upload the raw Divvy bike share files to DBFS. [web:66]
3. Use a notebook to ingest the files into Bronze Delta tables. [web:66][web:67]
4. Apply PySpark transformations to clean data types, standardize timestamps, and derive analytics attributes. [web:67][web:72]
5. Build Gold Delta tables for dimensions and facts. [web:66][web:69]
6. Register the resulting tables in the metastore and validate analytical queries. [web:66]

This flow reflects the standard Databricks pattern of landing raw files first, transforming them with Spark, and exposing the final data model through Delta tables. [web:68][web:72]

## Suggested repository structure

```text
Building an Azure Data Lake for Bike Share Analytics/
│
├── data/                                   # Raw bike share source files, if included locally
├── notebooks/                              # Databricks notebooks for load and transformation
├── sql/                                    # Optional SQL queries for validation or reporting
├── images/                                 # Architecture, lineage, or star-schema diagrams
├── __ Load.ipynb                           # Bronze ingestion notebook
├── bikeshare-transformation Notebook.ipynb # Transformation notebook for Gold/star schema
└── README.md
```

Public repositories for this project commonly include separate notebooks for loading and transformation, with naming similar to `__ Load.ipynb` and a transformation notebook for star-schema creation. [web:42][web:67]

## How to run

### 1. Provision Azure Databricks

Create an Azure Databricks workspace and attach a cluster suitable for notebook execution. This is the core compute environment for the entire project. [web:66][web:68]

### 2. Upload the source data

Upload the Divvy bike share source files into Databricks-accessible storage. Public implementations of this project commonly use the DBFS path `/FileStore/tables/` for this step. [web:66]

### 3. Ingest data into Bronze Delta tables

Run the load notebook to read the raw CSV files and persist them as Delta Lake Bronze tables. This creates the raw-but-queryable foundation for all downstream transformations. [web:66][web:42]

### 4. Transform and model the data

Run the transformation notebook to clean the data and build the final fact and dimension tables in Delta format. This is where the business-oriented star schema is produced. [web:66][web:67]

### 5. Validate analytical queries

Query the final Gold tables to verify that the data model supports the required analyses, such as ride duration by time, station utilization, member trends, and spending metrics. [web:66][web:69]

## Why Delta Lake is used

Delta Lake is a natural fit for this project because it combines data lake flexibility with table reliability features such as ACID transactions and schema-aware table storage. In the context of Azure Databricks, it allows raw and transformed layers to be managed consistently while keeping the workflow notebook-friendly and scalable. [web:66][web:68]

## Skills demonstrated

This project demonstrates practical experience with:

- Designing a lakehouse data architecture on Azure Databricks. [web:68][web:72]
- Building Delta Lake Bronze and Gold data stores. [web:66]
- Using PySpark for distributed ETL transformations. [web:67][web:69]
- Translating business questions into a star schema. [web:66][web:72]
- Working with bike share operational data for analytical reporting. [web:66][web:69]
- Organizing analytics data for downstream BI or warehouse-style querying. [web:68][web:72]

## Potential enhancements

Possible improvements for this repository include:

- Adding a Silver layer for cleaned intermediate transformations.
- Storing raw files in ADLS Gen2 instead of DBFS for a more production-oriented Azure architecture.
- Adding Delta optimization steps such as partitioning and maintenance commands.
- Including architecture diagrams and table lineage documentation.
- Providing sample dashboards or BI queries against the Gold tables.
- Parameterizing notebook paths and input sources for easier reuse.

## Acknowledgments

This project follows Udacity’s Azure Databricks lakehouse assignment for Divvy bike share analytics, where learners design a star schema, import source data into Databricks, create Bronze and Gold Delta stores, and transform the data into analytics-ready fact and dimension tables. [web:66][web:68]
EOF && cp output/README_bike_share_data_lake.md output/README.md
