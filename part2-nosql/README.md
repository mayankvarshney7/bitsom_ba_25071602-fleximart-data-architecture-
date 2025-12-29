# Part 2: NoSQL Database Analysis and Implementation

This module evaluates the suitability of a NoSQL database for FlexiMart’s expanding and highly diverse product catalog. It includes a theoretical analysis comparing relational databases with MongoDB and a practical implementation demonstrating core MongoDB operations.

---

## Files Description

- **nosql_analysis.md**  
  Provides a theoretical justification for using MongoDB, covering:
  - Limitations of relational databases
  - Benefits of NoSQL and MongoDB features
  - Trade-offs and disadvantages of using MongoDB

- **mongodb_operations.js**  
  Contains MongoDB commands and queries that demonstrate:
  - Loading JSON data into MongoDB
  - Basic filtering queries
  - Aggregation for review analysis
  - Update operations on embedded documents
  - Complex aggregations for analytical insights

- **products_catalog.json**  
  Sample product catalog data stored in JSON format.  
  The dataset includes products from multiple categories with nested structures such as specifications and customer reviews, illustrating schema flexibility.

---

## Execution Instructions

1. Ensure MongoDB is running locally
2. Import the product catalog data:
   ```bash
   mongoimport --db fleximart --collection products --file products_catalog.json --jsonArray
   ```
3. Run MongoDB operations:
   ```bash
   mongosh < mongodb_operations.js
   ```

## Outcome

### After executing this module:

1. Product data is stored as flexible MongoDB documents
2. Embedded reviews enable efficient retrieval without joins
3. Aggregation queries provide insights such as average ratings and category-wise pricing

This module demonstrates how MongoDB effectively supports flexible schemas, nested data, and scalable product catalog management.
