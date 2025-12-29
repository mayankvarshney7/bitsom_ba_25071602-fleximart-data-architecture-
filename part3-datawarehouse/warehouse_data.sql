-- =========================================================
-- Data Load for FlexiMart Data Warehouse
-- Database: fleximart_dw
-- =========================================================

-- =========================
-- dim_date (January–February 2024 | 30 dates)
-- =========================
INSERT INTO dim_date VALUES
(20240101,'2024-01-01','Monday',1,1,'January','Q1',2024,FALSE),
(20240102,'2024-01-02','Tuesday',2,1,'January','Q1',2024,FALSE),
(20240103,'2024-01-03','Wednesday',3,1,'January','Q1',2024,FALSE),
(20240104,'2024-01-04','Thursday',4,1,'January','Q1',2024,FALSE),
(20240105,'2024-01-05','Friday',5,1,'January','Q1',2024,FALSE),
(20240106,'2024-01-06','Saturday',6,1,'January','Q1',2024,TRUE),
(20240107,'2024-01-07','Sunday',7,1,'January','Q1',2024,TRUE),
(20240108,'2024-01-08','Monday',8,1,'January','Q1',2024,FALSE),
(20240109,'2024-01-09','Tuesday',9,1,'January','Q1',2024,FALSE),
(20240110,'2024-01-10','Wednesday',10,1,'January','Q1',2024,FALSE),
(20240111,'2024-01-11','Thursday',11,1,'January','Q1',2024,FALSE),
(20240112,'2024-01-12','Friday',12,1,'January','Q1',2024,FALSE),
(20240113,'2024-01-13','Saturday',13,1,'January','Q1',2024,TRUE),
(20240114,'2024-01-14','Sunday',14,1,'January','Q1',2024,TRUE),
(20240115,'2024-01-15','Monday',15,1,'January','Q1',2024,FALSE),
(20240201,'2024-02-01','Thursday',1,2,'February','Q1',2024,FALSE),
(20240202,'2024-02-02','Friday',2,2,'February','Q1',2024,FALSE),
(20240203,'2024-02-03','Saturday',3,2,'February','Q1',2024,TRUE),
(20240204,'2024-02-04','Sunday',4,2,'February','Q1',2024,TRUE),
(20240205,'2024-02-05','Monday',5,2,'February','Q1',2024,FALSE),
(20240206,'2024-02-06','Tuesday',6,2,'February','Q1',2024,FALSE),
(20240207,'2024-02-07','Wednesday',7,2,'February','Q1',2024,FALSE),
(20240208,'2024-02-08','Thursday',8,2,'February','Q1',2024,FALSE),
(20240209,'2024-02-09','Friday',9,2,'February','Q1',2024,FALSE),
(20240210,'2024-02-10','Saturday',10,2,'February','Q1',2024,TRUE),
(20240211,'2024-02-11','Sunday',11,2,'February','Q1',2024,TRUE),
(20240212,'2024-02-12','Monday',12,2,'February','Q1',2024,FALSE),
(20240213,'2024-02-13','Tuesday',13,2,'February','Q1',2024,FALSE),
(20240214,'2024-02-14','Wednesday',14,2,'February','Q1',2024,FALSE),
(20240215,'2024-02-15','Thursday',15,2,'February','Q1',2024,FALSE);

-- =========================
-- dim_product (15 products | 3 categories)
-- =========================
INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('P001','Laptop Pro','Electronics','Laptops',75000),
('P002','Smartphone X','Electronics','Smartphones',45000),
('P003','Wireless Headphones','Electronics','Audio',8000),
('P004','4K Monitor','Electronics','Monitors',32000),
('P005','Smart TV','Electronics','Televisions',65000),
('P006','Running Shoes','Fashion','Footwear',6000),
('P007','Casual Sneakers','Fashion','Footwear',9000),
('P008','Slim Fit Jeans','Fashion','Clothing',3500),
('P009','Formal Shirt','Fashion','Clothing',2000),
('P010','Cotton T-Shirt','Fashion','Clothing',1500),
('P011','Office Chair','Furniture','Chairs',12000),
('P012','Study Table','Furniture','Tables',18000),
('P013','Bookshelf','Furniture','Storage',10000),
('P014','Sofa Set','Furniture','Living Room',55000),
('P015','Dining Table','Furniture','Dining',45000);

-- =========================
-- dim_customer (12 customers | 4 cities)
-- =========================
INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('C001','John Doe','Mumbai','Maharashtra','Premium'),
('C002','Neha Sharma','Delhi','Delhi','Retail'),
('C003','Amit Verma','Bangalore','Karnataka','Corporate'),
('C004','Priya Singh','Mumbai','Maharashtra','Retail'),
('C005','Rahul Mehta','Ahmedabad','Gujarat','Corporate'),
('C006','Anjali Patel','Ahmedabad','Gujarat','Retail'),
('C007','Karan Malhotra','Delhi','Delhi','Premium'),
('C008','Sneha Iyer','Bangalore','Karnataka','Retail'),
('C009','Rohit Gupta','Mumbai','Maharashtra','Corporate'),
('C010','Pooja Nair','Bangalore','Karnataka','Retail'),
('C011','Vikas Jain','Delhi','Delhi','Corporate'),
('C012','Meera Kulkarni','Pune','Maharashtra','Retail');

-- =========================
-- fact_sales (40 transactions)
-- =========================
INSERT INTO fact_sales
(date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount)
VALUES
(20240101,1,1,1,75000,0,75000),
(20240106,2,2,2,45000,2000,88000),
(20240107,3,3,3,8000,0,24000),
(20240113,6,4,2,6000,0,12000),
(20240114,7,5,1,9000,500,8500),
(20240115,8,6,3,3500,0,10500),
(20240201,9,7,4,2000,0,8000),
(20240202,10,8,5,1500,0,7500),
(20240203,11,9,1,12000,0,12000),
(20240204,12,10,2,18000,1000,35000),
(20240205,13,11,1,10000,0,10000),
(20240206,14,12,1,55000,5000,50000),
(20240207,15,1,1,45000,0,45000),
(20240102,1,2,2,75000,0,150000),
(20240103,2,3,1,45000,0,45000),
(20240104,3,4,2,8000,0,16000),
(20240105,4,5,1,32000,0,32000),
(20240108,5,6,1,65000,0,65000),
(20240109,6,7,3,6000,0,18000),
(20240110,7,8,2,9000,0,18000),
(20240111,8,9,1,3500,0,3500),
(20240112,9,10,2,2000,0,4000),
(20240113,10,11,4,1500,0,6000),
(20240114,11,12,1,12000,0,12000),
(20240115,12,1,1,18000,0,18000),
(20240208,13,2,2,10000,0,20000),
(20240209,14,3,1,55000,0,55000),
(20240210,15,4,1,45000,2000,43000),
(20240211,1,5,1,75000,0,75000),
(20240212,2,6,2,45000,0,90000),
(20240213,3,7,3,8000,0,24000),
(20240214,4,8,1,32000,0,32000),
(20240215,5,9,1,65000,0,65000),
(20240106,6,10,2,6000,0,12000),
(20240107,7,11,1,9000,0,9000),
(20240108,8,12,2,3500,0,7000),
(20240109,9,1,3,2000,0,6000),
(20240110,10,2,4,1500,0,6000),
(20240111,11,3,1,12000,0,12000);

