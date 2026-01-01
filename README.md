# FlexiMart Data Architecture Project

**Student Name:** Mayank Varshney  
**Student ID:** bitsom_ba_25071602  
**Email:** mayankvv11954321@gmail.com  
**Date:** 08/01/2026

---

## Project Overview

This project implements an end-to-end data architecture solution for FlexiMart, an e-commerce platform. It covers data ingestion and cleansing using an ETL pipeline, NoSQL modeling with MongoDB for flexible product catalogs, and a dimensional data warehouse for analytical reporting and OLAP queries.

---

## Repository Structure

├── part1-database-etl/

    ├── etl_pipeline.py
    ├── schema_documentation.md
    ├── business_queries.sql
    └── data_quality_report.txt

├── part2-nosql/

    ├── nosql_analysis.md
    ├── mongodb_operations.js
    └── products_catalog.json

├── part3-datawarehouse/

    ├── star_schema_design.md
    ├── warehouse_schema.sql
    ├── warehouse_data.sql
    └── analytics_queries.sql
└── README.md

---

## Technologies Used

- Python 3.x, pandas, mysql-connector-python  
- MySQL 8.0 / PostgreSQL 14  
- MongoDB 6.0  

---

## Setup Instructions

### Database Setup

```bash
# Create databases
mysql -u root -p -e "CREATE DATABASE fleximart;"
mysql -u root -p -e "CREATE DATABASE fleximart_dw;"

# Run Part 1 - ETL Pipeline
python part1-database-etl/etl_pipeline.py

# Run Part 1 - Business Queries
mysql -u root -p fleximart < part1-database-etl/business_queries.sql

# Run Part 3 - Data Warehouse
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_schema.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_data.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/analytics_queries.sql
```

### MongoDB Setup
```bash
mongosh < part2-nosql/mongodb_operations.js
```

## Key Learnings

Through this project, I gained practical experience in designing ETL pipelines, handling real-world data quality issues, and implementing relational and NoSQL data models. I learned how dimensional modeling supports analytical workloads and how MongoDB enables schema flexibility for diverse product data.

## Challenges Faced

1. Handling inconsistent and incomplete source data
Solved by implementing robust transformation logic, standardization rules, and validation checks in the ETL pipeline.

2. Designing a scalable analytical model
Addressed by selecting appropriate fact granularity, using surrogate keys, and applying star schema best practices.

