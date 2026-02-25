-- SQL Joins
CREATE DATABASE marketbridge_db;
USE marketbridge_db;

-- Creating Tables

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


CREATE TABLE sales (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    quantity INT,
    total_amount DECIMAL(10,2),
    sale_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);


-- Inserting Data into tables

INSERT INTO customers (full_name, email, city) VALUES
('Amit Shah', 'amit@gmail.com', 'Ahmedabad'),
('Priya Patel', 'priya@gmail.com', 'Surat'),
('Rohit Mehta', 'rohit@gmail.com', 'Delhi'),
('Neha Joshi', 'neha@gmail.com', 'Mumbai'),
('Karan Desai', 'karan@gmail.com', 'Bangalore');

SELECT * FROM customers;


INSERT INTO products (product_name, category, price) VALUES
('iPhone 14', 'Electronics', 75000),
('Samsung TV', 'Electronics', 55000),
('Nike Shoes', 'Fashion', 5000),
('Laptop HP', 'Electronics', 65000),
('Office Chair', 'Furniture', 7000);


SELECT * FROM products;


INSERT INTO sales (customer_id, product_id, quantity, total_amount, sale_date) VALUES
(1, 1, 1, 75000, '2024-03-01'),
(2, 3, 2, 10000, '2024-03-02'),
(3, 2, 1, 55000, '2024-03-03'),
(1, 4, 1, 65000, '2024-03-04'),
(4, 5, 3, 21000, '2024-03-05');

SELECT * FROM sales;

-- Task 1: Display customer name and total_amount for each sale
SELECT full_name, sales.total_amount FROM customers
JOIN sales
	ON customers.id = sales.customer_id;
    
-- Task 2: Customers orders even with no sale
SELECT full_name, sales.total_amount FROM customers
LEFT JOIN sales
ON customers.id = sales.customer_id;

-- Task 3: All sales with customer info even if null

SELECT customers.full_name, customers.email, customers.city, sales.product_id, sales.quantity FROM customers
RIGHT JOIN sales
	ON customers.id = sales.customer_id;
    
-- Task 4: Using UNION between LEFT and RIGHT JOIN

SELECT full_name, email, city,customers.id, sales.total_amount,sales.id AS sales_id FROM customers
LEFT JOIN sales
ON customers.id = sales.customer_id
UNION
SELECT full_name, email, city, customers.id, sales.total_amount,sales.id AS sales_id FROM customers
RIGHT JOIN sales
ON customers.id = sales.customer_id;

-- Task 5: Revenue Per Customer

SELECT DISTINCT full_name, SUM(sales.total_amount) FROM customers
JOIN sales
ON customers.id = sales.customer_id
GROUP BY full_name;

-- Task 6: Product Sales Analysis

SELECT DISTINCT products.product_name, SUM(sales.quantity) FROM products
JOIN sales
ON products.id = sales.product_id
GROUP BY product_name;

-- Task 7 : Category Revenue

SELECT category, SUM(sales.total_amount) FROM products
JOIN sales
ON products.id = sales.product_id
GROUP BY category;

-- Task 8: Multi-Table Join

SELECT customers.full_name, products.product_name, products.category, sales.total_amount FROM sales
JOIN customers
ON sales.customer_id = customers.id
JOIN products
ON sales.product_id = products.id;

-- Task 9: City-Wise Revenue

SELECT city, SUM(sales.total_amount) FROM customers
JOIN sales
ON customers.id = sales.customer_id
GROUP BY city;

-- Task 10: Find customers who have never placed an order

SELECT full_name, sales.customer_id FROM customers
LEFT JOIN sales
ON customers.id = sales.customer_id
WHERE sales.customer_id IS NULL;

-- Task 11: Top 2 Highest Revenue Customers
SELECT full_name, SUM(sales.total_amount) AS total_revenue FROM customers
JOIN sales
ON customers.id = sales.customer_id
GROUP BY full_name
ORDER BY SUM(sales.total_amount) DESC
LIMIT 2;


-- Task 12: Revenue per category per city
SELECT city, products.category, SUM(sales.total_amount) FROM sales
JOIN customers
ON sales.customer_id = customers.id
JOIN products 
ON sales.product_id = products.id
GROUP BY category,city;



-- Task 13: Categories generating revenue more than 100000

SELECT category, SUM(sales.total_amount) FROM products
JOIN sales
ON products.id = sales.product_id
GROUP BY category
HAVING SUM(sales.total_amount) > 100000;





