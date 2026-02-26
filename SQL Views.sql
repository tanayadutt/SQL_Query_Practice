-- VIEWS
DROP DATABASE techcart_db;

CREATE DATABASE insightgrid_db;
USE insightgrid_db;

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    email VARCHAR(150),
    city VARCHAR(100)
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150),
    category VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    quantity INT,
    total_amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Inserting Data into these Tables

INSERT INTO customers (full_name, email, city) VALUES
('Amit Shah', 'amit@gmail.com', 'Ahmedabad'),
('Priya Patel', 'priya@gmail.com', 'Surat'),
('Rohit Mehta', 'rohit@gmail.com', 'Delhi'),
('Neha Joshi', 'neha@gmail.com', 'Mumbai');



INSERT INTO products (id,product_name, category, price) VALUES
(1,'iPhone 14', 'Electronics', 75000),
(2,'Nike Shoes', 'Fashion', 5000),
(3,'Samsung TV', 'Electronics', 55000),
(4,'Office Chair', 'Furniture', 7000);

INSERT INTO orders (customer_id, product_id, quantity, total_amount, order_date) VALUES
(1, 1, 1, 75000, '2024-03-01'),
(2, 2, 2, 10000, '2024-03-02'),
(3, 3, 1, 55000, '2024-03-03'),
(1, 3, 1, 55000, '2024-03-04'),
(4, 4, 3, 21000, '2024-03-05');

-- What is a view? A view is mainly created to protect the data from other users. A view consists only of the data required 
-- for an individual to work on, the rest of the data is kept hidden for security reasons

-- Create a view that shows customer name, product name, and total_amount


-- Task 1: Create order_summary as View

CREATE VIEW order_summary AS
SELECT customers.full_name, products.product_name, orders.total_amount FROM orders
JOIN products
ON orders.product_id = products.id
JOIN customers
ON orders.customer_id = customers.id;


-- Task 3: Query Data From View

SELECT * FROM order_summary;

-- Task 4: Replace View

CREATE OR REPLACE VIEW order_summary AS
SELECT customers.full_name, products.product_name, orders.total_amount, orders.order_date
FROM orders
JOIN products
ON orders.product_id = products.id
JOIN customers
ON orders.customer_id = customers.id;

-- Task 5: Dropping the View order_summary

DROP VIEW order_summary;


-- Task 6: Revenue Summary View

SET SESSION sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));
SELECT @@sql_mode;

CREATE OR REPLACE VIEW revenue_summary AS
SELECT customers.id, customers.full_name, orders.total_amount, orders.quantity
FROM orders
JOIN customers
ON orders.customer_id = customers.id;

SELECT * FROM revenue_summary;

-- Task 7: Category Revenue View

CREATE VIEW category_revenue AS
SELECT products.category, orders.total_amount, orders.quantity
FROM orders
JOIN products 
ON orders.product_id = products.id;

SELECT * FROM category_revenue;

-- Task 8: View for Security Reasons

CREATE VIEW basic_info AS 
SELECT full_name, city
FROM customers;

SELECT * FROM basic_info;

-- Task 9: Monthly Revenue View

CREATE OR REPLACE VIEW monthly_revenue AS
SELECT YEAR(orders.order_date), MONTH(orders.order_date), SUM(total_amount)
FROM orders
GROUP BY YEAR(order_date),MONTH(order_date);

SELECT * FROM monthly_revenue;

-- Task 10: Create a view for top customers (revenue > ₹1,00,000).

CREATE VIEW top_customers AS
SELECT customers.full_name, SUM(orders.total_amount)
FROM orders
JOIN customers
ON orders.customer_id = customers.id
GROUP BY customers.full_name
HAVING SUM(orders.total_amount) > 100000;

SELECT * FROM top_customers;

-- Task 11: Nested Views (DOUBT)

-- Task 12: Views with Filtering (orders only from 2024)

CREATE OR REPLACE VIEW filtered AS
SELECT * FROM orders
WHERE order_date >= '2024-01-01'
AND order_date < '2025-01-01';

SELECT * FROM filtered;
