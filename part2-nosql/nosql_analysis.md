# NoSQL Database Analysis – FlexiMart

This document analyzes the suitability of MongoDB for managing FlexiMart’s diverse and evolving product catalog and compares it with the existing relational database approach.

---

## Section A: Limitations of RDBMS 

Relational database management systems (RDBMS) such as MySQL are built around fixed schemas, which makes them less suitable for handling highly diverse product data. In FlexiMart’s catalog, different product types require different attributes. For example, laptops need specifications such as RAM, processor, and storage, while shoes require size, color, and material. Representing all these variations in a single relational table would result in many nullable columns, leading to wasted storage and reduced clarity. Alternatively, creating separate tables for each product type increases schema complexity and maintenance effort.

Frequent schema changes also present a challenge. Adding new product types or attributes requires ALTER TABLE operations, which are expensive and risky in production environments. Additionally, storing customer reviews in an RDBMS requires separate review tables and multiple joins to retrieve product details with reviews. These joins increase query complexity and reduce performance, especially as data volume grows. Overall, rigid schemas and poor support for hierarchical data limit the flexibility of RDBMS for such use cases.

---

## Section B: NoSQL Benefits 

MongoDB overcomes these limitations through its document-oriented and schema-flexible design. Each product can be stored as a JSON-like document containing only the attributes relevant to that product. Electronics items can include technical specifications, while fashion products can store size and material information without affecting other documents. This flexibility eliminates the need for frequent schema changes and allows the product catalog to evolve easily.

MongoDB also supports embedded documents, enabling customer reviews to be stored directly inside the product document. This structure reflects real-world data access patterns, as reviews are typically accessed along with product details, reducing the need for joins and improving read performance. Furthermore, MongoDB is designed for horizontal scalability using sharding, allowing FlexiMart to handle rapid growth in product data and user traffic. These features make MongoDB well-suited for managing large, dynamic, and heterogeneous product catalogs.

---

## Section C: Trade-offs 

Despite its advantages, MongoDB has certain drawbacks compared to relational databases. One limitation is weaker support for complex multi-table transactions. Although MongoDB supports transactions, they are generally more complex and less efficient than traditional ACID transactions in RDBMS, making MongoDB less ideal for highly transactional systems such as order processing.

Another drawback is the lack of enforced schema constraints at the database level. While flexibility is beneficial, it can lead to inconsistent data if validation rules are not properly implemented in the application layer. In contrast, relational databases enforce strict schemas and constraints that naturally protect data integrity.

