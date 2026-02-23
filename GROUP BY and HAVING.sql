-- GROUP BY AND HAVING ASSIGNMENT

CREATE DATABASE salesvista_db;
USE salesvista_db;

-- craeting Tables customers, products,


CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    region VARCHAR(100),
    city VARCHAR(100)
);

SELECT * FROM customers;

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

-- Inserting Sample Data 

INSERT INTO customers (full_name, region, city) VALUES
('Amit Shah', 'West', 'Ahmedabad'),
('Priya Patel', 'West', 'Surat'),
('Rohit Mehta', 'North', 'Delhi'),
('Neha Joshi', 'North', 'Chandigarh'),
('Karan Desai', 'South', 'Bangalore'),
('Simran Kaur', 'South', 'Chennai');

SELECT * FROM customers;


INSERT INTO products (product_name, category, price) VALUES
('iPhone 14', 'Electronics', 75000),
('Samsung TV', 'Electronics', 55000),
('Nike Shoes', 'Fashion', 5000),
('Laptop HP', 'Electronics', 65000),
('Office Chair', 'Furniture', 7000),
('Sofa Set', 'Furniture', 25000);

SELECT * FROM products;

INSERT INTO orders (customer_id, product_id, quantity, total_amount, order_date) VALUES
(1, 1, 1, 75000, '2024-03-01'),
(2, 3, 2, 10000, '2024-03-02'),
(3, 2, 1, 55000, '2024-03-03'),
(4, 5, 3, 21000, '2024-03-04'),
(5, 4, 1, 65000, '2024-03-05'),
(6, 6, 1, 25000, '2024-03-06'),
(1, 4, 1, 65000, '2024-03-07'),
(3, 3, 1, 5000,  '2024-03-08'),
(5, 2, 1, 55000, '2024-03-09');


SELECT * FROM orders;

-- Task 1: Total Sales Per Region

SELECT customers.region, sum(orders.total_amount)  AS total_sales FROM customers
JOIN orders 
ON customers.id = orders.customer_id
GROUP BY region
ORDER BY total_sales DESC;

-- Task 2: Total Orders per region

SELECT customers.region, COUNT(orders.id) AS total_orders FROM customers
JOIN orders
ON customers.id = orders.customer_id
GROUP BY region;

-- Task 3 : Total Revenue Per Category

SELECT category, SUM(orders.total_amount) FROM products
JOIN orders
ON products.id = orders.product_id
GROUP BY category;

-- Task 4: Average Order Value per Region

SELECT customers.region, avg(orders.total_amount) AS Average_Amount FROM customers
JOIN orders
ON customers.id = orders.customer_id
GROUP BY region;

-- Task 4: Show regions with revenue about 1,00,000

SELECT customers.region, SUM(orders.total_amount) AS total_revenue FROM customers
JOIN orders
ON customers.id = orders.customer_id
GROUP BY region
HAVING SUM(total_amount) > 100000;


-- High Performing Regions

SELECT customers.region, SUM(orders.total_amount) AS total_revenue FROM customers
JOIN orders
ON customers.id = orders.customer_id
GROUP BY region
HAVING SUM(total_amount) > 150000;

-- Categories with more than 2 orders

SELECT category, COUNT(orders.id) FROM products
JOIN orders
ON products.id = orders.product_id
GROUP BY category
HAVING COUNT(orders.id) > 1;

-- Yearly and Monthly Revenue

SELECT region,MONTH(orders.order_date),YEAR(orders.order_date),SUM(orders.total_amount) FROM customers
JOIN orders
ON customers.id = orders.customer_id
GROUP BY region, YEAR(orders.order_date),MONTH(orders.order_date);

-- Revenue per City

SELECT city, SUM(orders.total_amount) from customers
JOIN orders
ON customers.id = orders.customer_id
GROUP BY city
ORDER BY SUM(total_amount) DESC;

-- Top 2 regions revenue-wise

SELECT region, SUM(orders.total_amount) AS Revenue FROM customers
JOIN orders
ON customers.id = orders.customer_id
GROUP BY region
ORDER BY Revenue DESC
LIMIT 2;

-- Regions where average order value is above company average

SELECT region, AVG(orders.total_amount) as regional_average FROM customers
JOIN orders
ON customers.id = orders.customer_id
GROUP BY region
HAVING AVG(orders.total_amount) > 
	(SELECT AVG(total_amount) FROM orders);
    
-- Show categories contributing more than 30% of total company revenue

SELECT category, SUM(orders.total_amount) FROM products
JOIN orders
ON products.id = orders.product_id
GROUP BY category
HAVING SUM(orders.total_amount) >
	(SELECT SUM(total_amount) * 0.30 FROM orders);
    
-- Debugging

SELECT region, SUM(total_amount)
FROM customers
JOIN orders
ON customers.id = orders.customer_id
GROUP BY region
HAVING SUM(total_amount) > 100000;


-- Identify regions with at least 2 customers placing orders.

SELECT region, COUNT(DISTINCT customers.id) FROM customers
JOIN orders
ON customers.id = orders.customer_id
GROUP BY region
HAVING COUNT(DISTINCT customers.id) > 2;

-- REGIONAL PERFORMANCE REPORT

-- Build a Regional Performance Report Query that includes:

-- Region
-- Total Orders
-- Total Revenue
-- Average Order Value
-- Highest Order
-- Lowest Order
-- Constraints:
SELECT region, COUNT(orders.id) AS  No_orders, SUM(orders.total_amount) AS total_revenue, AVG(orders.total_amount) AS average_revenue,
	MAX(orders.total_amount) AS Max, MIN(orders.total_amount) AS Min
FROM customers
JOIN orders
ON customers.id = orders.customer_id
GROUP BY region
HAVING SUM(orders.total_amount) > 100000;
-- Must use GROUP BY--
-- Must use aggregate functions
-- Must apply HAVING to filter revenue > ₹1,00,000--
-- Must format cleanly






