# Building an Azure Data Warehouse for Bike Share Data Analytics

This project implements an end-to-end cloud data warehousing solution for bike share analytics using **Azure Synapse Analytics**. The workflow covers resource provisioning, data extraction from PostgreSQL, loading data into Azure storage and external staging tables, and transforming the data into a star schema using CETAS for analytical reporting.

## Overview

The project simulates a common analytics architecture where operational bike share data lives in PostgreSQL and must be moved into an analytical warehouse for reporting. The final solution is built in Azure and centers on Synapse serverless SQL, external tables, and star-schema modelling to answer business questions about ride behaviour, riders, stations, and payments.

This project is part of Udacity’s Microsoft Azure data engineering curriculum, where the stated goal is to build a data warehouse solution with Azure Synapse Analytics to analyze bike share data.

## Project objectives

- Create the required Azure resources, including PostgreSQL and Synapse workspace components.
- Model the source data into a star schema aligned with business outcomes. 
- Extract source data from PostgreSQL into Azure Blob Storage through Synapse ingestion. 
- Load the extracted files into external staging tables in Synapse serverless SQL.
- Transform staging data into final fact and dimension tables using `CREATE EXTERNAL TABLE AS SELECT` (CETAS).
- Support downstream analytics and reporting from the final warehouse model.

## Business outcomes

The warehouse is designed to support analysis such as:

- Time spent per ride.
- Ride behaviour by date and time.
- Usage by starting and ending station.
- Usage by rider demographics and membership status.
- Money spent per member.
- Monthly rides and ride minutes per rider.

These business outcomes are repeatedly described in public implementations of this Udacity project and are the basis for the star-schema design.

## Architecture

The end-to-end flow is:

1. Load the source bike share data into Azure Database for PostgreSQL to simulate an OLTP system.
2. Use Synapse ingestion to extract the PostgreSQL tables into Azure Blob Storage as text files. 
3. Create external staging tables over the extracted files in Synapse serverless SQL.
4. Transform the staging data into a dimensional model using CETAS.
5. Query the final star schema for analytics and reporting. 

This design reflects a standard ELT pattern where raw extracted data lands in cloud storage first, then is shaped into analytical structures inside the warehouse layer.

## Azure services used

- **Azure Database for PostgreSQL** as the source operational database. 
- **Azure Blob Storage** as the extraction landing zone for raw files.
- **Azure Synapse Analytics** as the data warehousing and transformation environment. 
- **Serverless SQL pool** for external table creation and analytical querying.

These are the core services explicitly described for the project in the Udacity-aligned walkthroughs and public repositories.

## Data modeling approach

The analytical model follows a star schema because it simplifies reporting and aligns better with business questions than the normalized PostgreSQL source model. The design typically centers on trip and payment facts, with dimensions such as rider, station, account or membership, and date or time context.

Because Synapse serverless SQL does not provide local table storage, the transformation stage uses CETAS to create external, queryable outputs backed by files in storage. This is a defining technical constraint of the project and shapes how the warehouse objects are built.

## Typical project tasks

Public versions of this project usually follow this sequence:

1. Create Azure resources.
2. Design the star schema. 
3. Populate PostgreSQL with the provided bike share source data using a Python script. 
4. Extract PostgreSQL tables to Blob Storage through Synapse. 
5. Load the extracted files into external staging tables. 
6. Transform the staging data into final fact and dimension outputs with CETAS.

That sequence mirrors the official project framing and the implementations documented in related repositories.

## Suggested repository structure

```text
Building an Azure Data Warehouse for Bike Share Data Analytics/
│
├── data/                               # Source or extracted bike share data files, if included
├── sql/                                # SQL scripts for external tables, CETAS, and validation queries
├── notebooks/                          # Optional notebooks used for exploration or transformation
├── images/                             # Architecture diagrams or star-schema images
├── ProjectDataToPostgres.py            # Script to load source data into PostgreSQL
├── Load.txt                            # Notes or generated SQL for load steps
├── Transform.txt                       # Notes or SQL for CETAS transformations
└── README.md
```

This structure reflects the file types and steps commonly referenced in public solutions for the project, including the PostgreSQL loader script and load or transform SQL artefacts. 

## How to run

### 1. Provision Azure resources

Create the Azure resources required for the project, especially an Azure Database for PostgreSQL instance and an Azure Synapse workspace. In the Udacity lab context, the built-in serverless SQL pool is typically the available warehouse engine. 

### 2. Load the source data into PostgreSQL

Use the provided Python script to load the bike share source files into PostgreSQL. This step simulates the operational source system from which the warehouse pipeline extracts data. 

### 3. Extract data into Blob Storage

Use the Synapse ingest wizard to create a one-time pipeline from PostgreSQL to Azure Blob Storage. The output should be raw text files representing the source tables.

### 4. Create external staging tables

Use Synapse-generated or hand-written SQL to create external tables over the extracted files. These staging tables serve as the input layer for downstream transformations. 

### 5. Transform staging data with CETAS

Write CETAS statements that materialize the final dimension and fact outputs in external form. This produces the final warehouse model in storage-backed tables that can be queried from serverless SQL.

### 6. Validate analytical queries

Run reporting queries against the star schema to confirm the model supports the target business outcomes, such as ride duration trends, station usage, rider activity, and spending analysis. 
## Why CETAS is used

`CREATE EXTERNAL TABLE AS SELECT` is used because Synapse serverless SQL does not support persistent local tables in the same way a dedicated SQL pool does. CETAS both writes query results to storage and registers external table metadata, making it a practical way to build a warehouse-style model in a serverless environment.

## Skills demonstrated

This project demonstrates practical experience with:

- Cloud data warehousing on Azure. 
- ELT design using PostgreSQL, Blob Storage, and Synapse. 
- Star schema modelling for analytics. 
- External table design in Synapse serverless SQL.
- CETAS-based transformation workflows. 
- Translating business questions into dimensional models and analytical SQL. 

## Future improvements

Possible enhancements for this repository include:

- Adding an architecture diagram and a star-schema diagram.
- Including a setup guide for Azure resource creation.
- Organizing SQL scripts into `staging`, `dimensions`, `facts`, and `validation` folders.
- Adding sample analytical queries and screenshots of query outputs.
- Documenting cost-conscious options for using Synapse serverless SQL in student environments.

## Acknowledgments

This project follows the structure of Udacity’s Azure data warehouse project, which asks learners to create Azure resources, design a star schema, extract bike share data from PostgreSQL, load it into Synapse external tables, and transform it using CETAS for analytics.
