# Database Schema Documentation – FlexiMart

This document describes the relational database schema used for FlexiMart’s operational system. The schema is designed to store customer, product, and sales transaction data and follows Third Normal Form (3NF) principles.

---

## ENTITY: customers

**Purpose:**  
Stores customer personal and contact information required for sales and order tracking.

**Attributes:**
- **customer_id** (INT, PK)  
  Unique identifier for each customer.
- **first_name** (VARCHAR)  
  Customer’s first name.
- **last_name** (VARCHAR)  
  Customer’s last name.
- **email** (VARCHAR, UNIQUE)  
  Customer’s email address used for communication.
- **phone** (VARCHAR)  
  Customer contact number.
- **city** (VARCHAR)  
  City where the customer resides.
- **registration_date** (DATE)  
  Date when the customer registered.

**Relationships:**
- One customer can place **many orders**  
  (1 : M relationship with the `orders` table)

---

## ENTITY: products

**Purpose:**  
Stores product catalog information available for sale.

**Attributes:**
- **product_id** (INT, PK)  
  Unique identifier for each product.
- **product_name** (VARCHAR)  
  Name of the product.
- **category** (VARCHAR)  
  Product category (e.g., Electronics, Fashion).
- **price** (DECIMAL)  
  Selling price of the product.
- **stock_quantity** (INT)  
  Available inventory quantity.

**Relationships:**
- One product can appear in **many order items**  
  (1 : M relationship with the `order_items` table)

---

## ENTITY: orders

**Purpose:**  
Stores order-level transaction details for each customer purchase.

**Attributes:**
- **order_id** (INT, PK)  
  Unique identifier for each order.
- **customer_id** (INT, FK)  
  References `customers.customer_id`.
- **order_date** (DATE)  
  Date on which the order was placed.
- **total_amount** (DECIMAL)  
  Total value of the order.
- **status** (VARCHAR)  
  Order status (e.g., Pending, Completed).

**Relationships:**
- Each order belongs to **one customer**
- One order can have **many order items**

---

## ENTITY: order_items

**Purpose:**  
Stores item-level details for each order, enabling multiple products per order.

**Attributes:**
- **order_item_id** (INT, PK)  
  Unique identifier for each order line item.
- **order_id** (INT, FK)  
  References `orders.order_id`.
- **product_id** (INT, FK)  
  References `products.product_id`.
- **quantity** (INT)  
  Number of units ordered.
- **unit_price** (DECIMAL)  
  Price per unit at the time of purchase.
- **subtotal** (DECIMAL)  
  Calculated as quantity × unit_price.

---

## Normalization Explanation (Third Normal Form – 3NF)

The FlexiMart database schema is designed in **Third Normal Form (3NF)** to eliminate redundancy and maintain data integrity.

Each table contains attributes that depend only on the **primary key** of that table. For example, in the `customers` table, attributes such as first_name, last_name, email, and city depend solely on customer_id. There are no partial dependencies because all primary keys are single-column keys.

Transitive dependencies are avoided by separating data into logically distinct tables. Product details are stored only in the `products` table, while order-specific information is stored in `orders`, and item-level details are stored in `order_items`. This separation ensures that changes to product prices or customer details do not cause update anomalies.

The design prevents:
- **Update anomalies:** Product or customer data is updated in only one place.
- **Insert anomalies:** New customers or products can be added independently of orders.
- **Delete anomalies:** Deleting an order does not remove customer or product data.

Thus, the schema satisfies all conditions of 3NF and supports reliable and scalable transaction processing.

