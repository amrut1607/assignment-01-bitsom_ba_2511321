# Assignment 1: Data Engineering & Analytics
## Overview
This repository contains my submission for Assignment 1 of the Business Analytics course. The project explores fundamental data engineering concepts, transitioning from traditional relational databases to modern data lakehouse architectures and vector embeddings.

## Objective
The main goal of this assignment is to design, query, and critically evaluate different data storage solutions (RDBMS, NoSQL, Data Warehouse, Vector DB, and Data Lake) using practical datasets. It concludes with a capstone architecture design for a multimodal healthcare system.

## Repository Structure
- ```datasets/:``` The raw data files provided for the assignment (CSV, JSON, Parquet).
- ```part1-rdbms/:``` 3NF schema design, anomaly analysis, and SQL queries.
- ```part2-nosql/:``` MongoDB sample document design and query operations.
- ```part3-datawarehouse/:``` Star schema design, ETL decision documentation, and analytical SQL queries.
- ```part4-vector-db/:``` Semantic search embeddings generated via Google Colab, and a reflection on vector databases.
- ```part5-datalake/:``` Direct cross-format querying using DuckDB and a data lakehouse architecture recommendation.
- ```part6-capstone/:``` Visual architecture diagram and system design justification for a hospital network.

## Project Breakdown
Part 1: RDBMS
Analyzed a flat CSV file to identify Insert, Update, and Delete anomalies. Designed a fully normalized Third Normal Form (3NF) relational schema to resolve these data integrity issues, and wrote SQL queries to extract key business metrics.

Part 2: NoSQL Databases
Designed nested JSON documents for a diverse e-commerce catalog (electronics, clothing, groceries). Wrote MongoDB commands for insertion, filtering, indexing, and updating, and justified RDBMS vs NoSQL choices using the CAP theorem.

Part 3: Data Warehouses
Designed a Star Schema (Fact and Dimension tables) to model retail transactions for business intelligence reporting. Included a breakdown of the ETL data cleansing steps required to standardize dates and categorical string values.

Part 4: Vector Databases
Utilized Python and sentence-transformers to convert sentences into vector embeddings. Calculated cosine similarity to build a heatmap matrix and demonstrated how semantic search effectively retrieves contextually relevant results compared to rigid keyword searches.

Part 5: Data Lake & DuckDB
Wrote DuckDB queries to directly query and join raw .csv, .json and .parquet files without pre-loading them into a central database (zero-ETL). Evaluated Data Lakehouse architectures for handling fast-growing, multimodal data.

Part 6: Capstone Architecture Design
Designed an end-to-end conceptual data architecture for a hospital network. The design integrates OLTP, Vector, Data Warehouse, and Streaming databases to support real-time ICU vitals, plain-English doctor queries, and predictive modeling.

## Tools & Technologies Used
- Relational SQL engines (schema design and querying)
- MongoDB / JSON Document modeling
- DuckDB
- Python (sentence-transformers, numpy, seaborn)
- Jupyter Notebooks (Google Colab)
- Markdown & Mermaid diagrams
- Datasets
    - orders_flat.csv
    - retail_transactions.csv
    - customers.csv
    - orders.json
    - products.parquet
