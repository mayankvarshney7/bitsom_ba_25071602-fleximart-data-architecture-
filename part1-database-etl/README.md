# Part 1: Database Design and ETL Pipeline

This module implements an end-to-end ETL (Extract, Transform, Load) pipeline for FlexiMart’s operational database.  
It extracts raw CSV files, applies data cleansing and transformation logic to address data quality issues, and loads the cleaned data into a relational database using the schema provided in the assignment.

---

## Files Description

- **etl_pipeline.py**  
  Python script that performs Extract, Transform, and Load operations.  
  It handles duplicate removal, missing value treatment, data standardization, and database insertion with logging and error handling.

- **schema_documentation.md**  
  Describes the database entities, relationships, and explains why the schema follows Third Normal Form (3NF).

- **business_queries.sql**  
  Contains SQL queries that answer the given business questions using joins, aggregations, grouping, and filtering.

- **data_quality_report.txt**  
  Auto-generated report summarizing:
  - Number of records processed  
  - Duplicates removed  
  - Missing values handled  
  - Records successfully loaded  

- **requirements.txt**  
  Lists the Python dependencies required to run the ETL pipeline.

---

## Execution Order

1. Create the `fleximart` database and tables using the schema provided in the assignment  
2. Run the ETL pipeline:
   ```bash
   python etl_pipeline.py
   ```
3. Execute the business queries:
   ```bash
   mysql -u root -p fleximart < business_queries.sql
   ```

## Outcome

### After successful execution:

1. Cleaned and standardized customer, product, and sales data is stored in the relational database.
2. Data quality metrics are captured in `data_quality_report.txt`
3. Business queries return accurate analytical results based on the transformed data.
