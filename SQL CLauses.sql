-- Assignment 4 SQL_CLAUSES

CREATE DATABASE techcart_db;

USE techcart_db;

-- Creating Tables
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    email VARCHAR(150),
    city VARCHAR(100),
    status VARCHAR(50),
    created_at DATE
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150),
    category VARCHAR(100),
    price DECIMAL(10,2),
    rating DECIMAL(3,2),
    stock INT
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    quantity INT,
    total_amount DECIMAL(10,2),
    order_date DATE
);

-- Inserting data

INSERT INTO customers (full_name, email, city, status, created_at) VALUES
	('Amit Shah', 'amit@gmail.com', 'Ahmedabad', 'active', '2024-01-10'),
	('Priya Patel', 'priya@gmail.com', 'Surat', 'active', '2024-02-05'),
	('Rohit Mehta', 'rohit@gmail.com', 'Mumbai', 'inactive', '2024-01-20'),
	('Neha Joshi', 'neha@gmail.com', 'Delhi', 'active', '2024-03-01'),
	('Karan Desai', 'karan@gmail.com', 'Ahmedabad', 'active', '2024-02-15');
    
    
SELECT * FROM customers;

INSERT INTO products (product_name, category, price, rating, stock) VALUES
	('iPhone 14', 'Electronics', 75000, 4.7, 20),
	('Samsung TV', 'Electronics', 55000, 4.5, 15),
	('Nike Shoes', 'Fashion', 5000, 4.3, 50),
	('Laptop HP', 'Electronics', 65000, 4.6, 10),
	('Office Chair', 'Furniture', 7000, 4.1, 30);
    
SELECT * FROM products;

INSERT INTO orders (customer_id, product_id, quantity, total_amount, order_date) VALUES
	(1, 1, 1, 75000, '2024-03-10'),
	(2, 3, 2, 10000, '2024-03-12'),
	(5, 2, 1, 55000, '2024-03-15'),
	(1, 4, 1, 65000, '2024-03-18'),
	(4, 5, 3, 21000, '2024-03-20');

SELECT * FROM orders;


-- Task 1: Fetch all active customers

SELECT full_name, city FROM customers
WHERE status = 'active';


-- Task 2: Show Unique Cities

SELECT DISTINCT city FROM customers;

-- Task 3: Products above Rs. 50,000

SELECT product_name, price FROM products
WHERE price > 50000;

-- Task 4 : Sorting based on price

SELECT product_name, price FROM products
ORDER BY price DESC;


-- Task 5: Top 3 rated products

SELECT * FROM products
ORDER BY rating DESC
LIMIT 3;


-- Task 6: Latest Orders

SELECT * FROM orders
ORDER BY order_date
LIMIT 3;

-- Task 7: Products with stock less than 20

SELECT * FROM products
WHERE stock < 20;


-- Task 8: Show top 2 Expensive Products
SELECT * FROM products
ORDER BY price DESC
LIMIT 2;


-- Task 9: total_amount > 60000

SELECT * FROM orders
WHERE total_amount > 60000;


-- Task 9: Which cities have active customers

SELECT distinct city FROM customers
WHERE status = 'active';

-- Task 10: Fetch top 2 most expensive products but only show product_name and price.

SELECT product_name, price FROM products
ORDER BY price DESC
LIMIT 2;

-- Task 11: Show unique product categories sorted alphabetically.

SELECT DISTINCT product_name FROM products
ORDER BY product_name;


-- Task 12 : Product Debugging Scenario

SELECT product_name, rating
FROM products
ORDER BY rating DESC
LIMIT 10;


-- Task 13 : Show top 10 highest rated Electronics products.

SELECT product_name, rating FROM products
WHERE category = 'Electronics'
ORDER BY rating DESC
LIMIT 10;


SELECT product_name, price, rating FROM products
WHERE category = 'Electronics'
AND price BETWEEN 50000 AND 75000
ORDER BY rating DESC
LIMIT 5 OFFSET 0;


-- Optimizing KPI

SELECT id, full_name, city, created_at FROM customers
WHERE status = 'active'
ORDER BY created_at DESC
LIMIT 5 OFFSET 0;

