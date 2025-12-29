# Part 3: Data Warehouse and Analytics

This module implements a data warehouse for FlexiMart to support historical sales analysis and business intelligence reporting. It includes the design of a star schema, population of dimension and fact tables, and execution of OLAP queries to generate analytical insights.

---

## Files Description

- **star_schema_design.md**  
  Documents the star schema design, including fact and dimension tables, design decisions, and sample data flow.

- **warehouse_schema.sql**  
  SQL script to create the data warehouse schema, including dimension tables and the fact table.

- **warehouse_data.sql**  
  SQL script containing INSERT statements to populate the data warehouse with realistic sample data that meets the minimum volume requirements.

- **analytics_queries.sql**  
  SQL queries that perform OLAP analysis, such as:
  - Time-based drill-down (Year → Quarter → Month)
  - Product performance analysis
  - Customer segmentation analysis

---

## Execution Instructions

1. Create the data warehouse database:
   ```bash
   mysql -u root -p -e "CREATE DATABASE fleximart_dw;"
   ```
2. Create schema tables:
   ```bash
   mysql -u root -p fleximart_dw < warehouse_schema.sql
   ```
3. Load warehouse data:
   ```bash
   mysql -u root -p fleximart_dw < warehouse_data.sql
   ```
4. Run analytical queries:
   ```bash
   mysql -u root -p fleximart_dw < analytics_queries.sql
   ```
   
## Outcome
### After completing this module:

1. Sales data is organized in a star schema optimized for analytics
2. Dimensional modeling enables fast and flexible OLAP queries
3. Business users can analyze sales trends, product performance, and customer value efficiently

This module demonstrates practical application of data warehousing concepts and analytical SQL techniques.
