# Star Schema Design – FlexiMart Data Warehouse

This document describes the star schema designed for FlexiMart’s data warehouse to support historical sales analysis and business intelligence reporting.

---

## Section 1: Schema Overview

### FACT TABLE: fact_sales

**Business Process:** Sales transactions  
**Grain:** One row per product per order line item  

**Measures (Numeric Facts):**
- **quantity_sold**  
  Number of units sold for a specific product in an order.
- **unit_price**  
  Price per unit at the time of sale.
- **discount_amount**  
  Discount applied to the transaction, if any.
- **total_amount**  
  Final sales amount calculated as  
  *(quantity_sold × unit_price − discount_amount)*

**Foreign Keys:**
- **date_key** → dim_date  
- **product_key** → dim_product  
- **customer_key** → dim_customer  

---

### DIMENSION TABLE: dim_date

**Purpose:**  
Provides a standardized date reference for time-based analysis such as daily, monthly, quarterly, and yearly reporting.

**Type:**  
Conformed dimension

**Attributes:**
- **date_key (PK)** – Surrogate key in YYYYMMDD format  
- **full_date** – Actual calendar date  
- **day_of_week** – Name of the day (Monday, Tuesday, etc.)  
- **day_of_month** – Day number within the month  
- **month** – Numeric month (1–12)  
- **month_name** – Month name (January, February, etc.)  
- **quarter** – Calendar quarter (Q1–Q4)  
- **year** – Calendar year  
- **is_weekend** – Boolean flag indicating weekend  

---

### DIMENSION TABLE: dim_product

**Purpose:**  
Stores descriptive attributes of products for sales analysis by product and category.

**Attributes:**
- **product_key (PK)** – Surrogate key  
- **product_id** – Product identifier from source system  
- **product_name** – Name of the product  
- **category** – High-level product category (e.g., Electronics, Fashion)  
- **subcategory** – Detailed product classification  
- **unit_price** – Standard product price  

---

### DIMENSION TABLE: dim_customer

**Purpose:**  
Stores customer-related descriptive data for customer-level analysis.

**Attributes:**
- **customer_key (PK)** – Surrogate key  
- **customer_id** – Customer identifier from source system  
- **customer_name** – Full name of the customer  
- **city** – Customer’s city  
- **state** – Customer’s state  
- **customer_segment** – Customer classification (e.g., Retail, Corporate, Premium)  

---

## Section 2: Design Decisions

The star schema is designed at the transaction line-item level to ensure maximum analytical flexibility. This granularity allows analysts to perform detailed analysis, such as product-level sales trends, customer purchasing behavior, and time-based drill-downs, without losing detail. It supports both summary reporting and detailed exploration of sales data.

Surrogate keys are used instead of natural keys to decouple the data warehouse from operational systems. Source system identifiers may change or be reused over time, whereas surrogate keys remain stable and ensure consistent historical tracking. They also improve join performance within the data warehouse.

This design supports drill-down and roll-up operations efficiently. Users can roll up sales data from day to month, quarter, or year using the date dimension, and drill down from category to subcategory and individual products using the product dimension. The separation of facts and dimensions simplifies queries and improves performance for OLAP workloads.

---

## Section 3: Sample Data Flow

### Source Transaction
Order #101  
Customer: John Doe  
Product: Laptop  
Quantity: 2  
Unit Price: ₹50,000  

---

### Data Warehouse Representation

**fact_sales**
~~~bash
date_key: 20240115
product_key: 5
customer_key: 12
quantity_sold: 2
unit_price: 50000
discount_amount: 0
total_amount: 100000
~~~
**dim_date**
~~~bash
date_key: 20240115
full_date: 2024-01-15
month: 1
month_name: January
quarter: Q1
year: 2024
is_weekend: FALSE
~~~
**dim_product**
~~~bash
product_key: 5
product_name: Laptop
category: Electronics
subcategory: Laptops
unit_price: 50000
~~~
**dim_customer**
~~~bash
customer_key: 12
customer_name: John Doe
city: Mumbai
state: Maharashtra
customer_segment: Premium
~~~
---

## Conclusion

The proposed star schema provides a scalable and efficient foundation for FlexiMart’s analytical requirements. It enables fast querying, supports complex OLAP operations, and ensures consistent historical analysis of sales performance across time, products, and customers.



