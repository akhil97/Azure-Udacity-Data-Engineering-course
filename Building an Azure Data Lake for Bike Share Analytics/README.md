# Building an Azure Data Lake for Bike Share Analytics

This project implements a lakehouse-style analytics platform for Divvy bike share data using **Azure Databricks**, **Delta Lake**, and **PySpark**. The goal is to ingest raw bike-share data into a Bronze layer, transform it into curated Delta tables, and model it into an analytics-ready star schema that supports business questions about ride duration, station usage, rider behaviour, and spending patterns. 

## Overview

The project is based on Divvy bikeshare data published by the City of Chicago and is structured around Azure Databricks lakehouse principles. Instead of loading everything directly into a warehouse, the solution uses Delta Lake tables to organise raw and transformed data into layered stores, then exposes a dimensional model for downstream analytics. 

Udacity describes this project as implementing lakehouse architecture on Azure Databricks, and public project implementations consistently show a Bronze-to-Gold pattern using Delta Lake and star-schema transformation. 

## Project objectives

- Design a star schema based on the target business outcomes. 
- Import the bike share data into Azure Databricks. 
- Store raw data in Delta Lake as a Bronze data store.
- Transform curated source data into Gold Delta tables. 
- Build dimension and fact tables for analytical workloads.
- Support business analysis around trip duration, rider activity, and revenue-related questions.

## Business questions answered

The project is designed to support questions such as:

- How much time is spent per ride? 
- How ride duration varies by date and time factors such as day of week or time of day. 
- How usage varies by starting and ending station.
- How rider behaviour changes by demographic or membership-related attributes. 
- How much money is spent overall and per member? 
- How many rides and how many ride minutes a rider averages per month.

These outcomes drive the star-schema design and explain why the project uses fact and dimension tables instead of leaving the data in raw transactional form. 

## Architecture

The lakehouse flow for this project is:

1. Upload raw source files into Azure Databricks storage, commonly under DBFS `/FileStore/tables/`. 
2. Ingest the raw files into Delta Lake Bronze tables.
3. Clean, standardize, and transform the data using PySpark notebooks.
4. Create curated analytical tables in the Gold layer.
5. Transform the curated data into a star schema with dimension and fact tables.
6. Query the final Delta tables for reporting and analytics.

This architecture follows a medallion-style pattern, where Bronze captures raw source fidelity, and Gold provides analytics-ready structures optimized for downstream consumption.

## Technology stack

- **Azure Databricks** for notebook-based development and distributed Spark execution. 
- **Delta Lake** for reliable table storage and ACID transactions in the lakehouse. 
- **PySpark** for data ingestion, cleaning, transformation, and table creation. 
- **DBFS** or Databricks-accessible storage for raw file upload and staging. 
- **Hive metastore** in public implementations for registering the resulting Bronze and Gold tables. 

## Data model

A common design for this project centers on ride activity as the core business event. The analytical layer is typically modelled with a central trip fact table and supporting dimensions such as rider, station, date, time, and account or membership context. Some implementations also include payment-related facts to support spending analysis. 

This dimensional design is important because it makes common analytical queries simpler and more performant than working directly against raw source files. It also aligns the storage model with the business outcomes defined in the project. 

## Layered storage design

### Bronze

The Bronze layer stores the raw source files with minimal transformation. In public implementations of this project, the raw bike share files are uploaded into Databricks storage and then written into Delta format as the first persistent layer. 

### Gold

The Gold layer contains curated Delta tables designed for analytics. These tables hold transformed data and the final star-schema outputs used for business analysis and reporting. 

Some project variations also mention an intermediate cleaned layer, but the public Udacity-aligned descriptions most consistently emphasize Bronze and Gold for this assignment.

## Typical workflow

A practical implementation usually follows this sequence:

1. Create the Azure Databricks workspace and cluster.
2. Upload the raw Divvy bike share files to DBFS.
3. Use a notebook to ingest the files into Bronze Delta tables. 
4. Apply PySpark transformations to clean data types, standardize timestamps, and derive analytics attributes.
5. Build Gold Delta tables for dimensions and facts.
6. Register the resulting tables in the metastore and validate analytical queries.

This flow reflects the standard Databricks pattern of landing raw files first, transforming them with Spark, and exposing the final data model through Delta tables.

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

Public repositories for this project commonly include separate notebooks for loading and transformation, with naming similar to `__ Load.ipynb` and a transformation notebook for star-schema creation. 

## How to run

### 1. Provision Azure Databricks

Create an Azure Databricks workspace and attach a cluster suitable for notebook execution. This is the core compute environment for the entire project. 

### 2. Upload the source data

Upload the Divvy bike share source files into Databricks-accessible storage. Public implementations of this project commonly use the DBFS path `/FileStore/tables/` for this step. 

### 3. Ingest data into Bronze Delta tables

Run the load notebook to read the raw CSV files and persist them as Delta Lake Bronze tables. This creates the raw-but-queryable foundation for all downstream transformations.

### 4. Transform and model the data

Run the transformation notebook to clean the data and build the final fact and dimension tables in Delta format. This is where the business-oriented star schema is produced.

### 5. Validate analytical queries

Query the final Gold tables to verify that the data model supports the required analyses, such as ride duration by time, station utilization, member trends, and spending metrics.

## Why Delta Lake is used

Delta Lake is a natural fit for this project because it combines data lake flexibility with table reliability features such as ACID transactions and schema-aware table storage. In the context of Azure Databricks, it allows raw and transformed layers to be managed consistently while keeping the workflow notebook-friendly and scalable. 

## Skills demonstrated

This project demonstrates practical experience with:

- Designing a lakehouse data architecture on Azure Databricks. 
- Building Delta Lake Bronze and Gold data stores. 
- Using PySpark for distributed ETL transformations. 
- Translating business questions into a star schema. 
- Working with bike share operational data for analytical reporting.
- Organizing analytics data for downstream BI or warehouse-style querying.

## Potential enhancements

Possible improvements for this repository include:

- Adding a Silver layer for cleaned intermediate transformations.
- Storing raw files in ADLS Gen2 instead of DBFS for a more production-oriented Azure architecture.
- Adding Delta optimization steps such as partitioning and maintenance commands.
- Including architecture diagrams and table lineage documentation.
- Providing sample dashboards or BI queries against the Gold tables.
- Parameterizing notebook paths and input sources for easier reuse.

## Acknowledgments

This project follows Udacity’s Azure Databricks lakehouse assignment for Divvy bike share analytics, where learners design a star schema, import source data into Databricks, create Bronze and Gold Delta stores, and transform the data into analytics-ready fact and dimension tables.
