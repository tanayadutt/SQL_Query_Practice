-- Subqueries and Nested Queries

-- Creating Database
CREATE DATABASE datanova_db;
USE datanova_db;

-- Creating Tables

-- Customers

CREATE TABLE customers (
	id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    region VARCHAR(100)
);

-- Products
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150),
    category VARCHAR(100),
    price DECIMAL(10,2)
);

-- Sales
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


-- Inserting Data into Tables

-- Customer Data

INSERT INTO customers (full_name, region) VALUES
('Tanaya Dutt', 'West'),
('Priya Shah', 'West'),
('Hardik Mehta', 'North'),
('Sneh Joshi', 'North'),
('Aheen Subedar', 'South');

SELECT * FROM customers;
-- Products Data

INSERT INTO products (product_name, category, price) VALUES
('iPhone 14', 'Electronics', 75000),
('Samsung TV', 'Electronics', 55000),
('Nike Shoes', 'Fashion', 5000),
('Laptop HP', 'Electronics', 65000),
('Office Chair', 'Furniture', 7000);


-- Sales Data
INSERT INTO sales (customer_id, product_id, quantity, total_amount, sale_date) VALUES
(1, 1, 1, 75000, '2024-03-01'),
(2, 3, 2, 10000, '2024-03-02'),
(3, 2, 1, 55000, '2024-03-03'),
(1, 4, 1, 65000, '2024-03-04'),
(4, 5, 3, 21000, '2024-03-05');

SELECT * FROM sales;

-- Task 1: Find Customers whose total spending is above company average
SELECT full_name,SUM(total_amount) AS total_spending FROM customers
JOIN sales
ON customers.id = sales.customer_id
GROUP BY full_name
HAVING SUM(total_amount) >
	(
		SELECT AVG(customer_total)
        FROM (
			SELECT SUM(total_amount) AS customer_total
            FROM sales
            GROUP BY customer_id
			) AS avg_table
);

-- Task 2: Show customer name and total Number of Orders

SELECT full_name, COUNT(customer_id) FROM customers
JOIN sales
ON customers.id = sales.customer_id
GROUP BY full_name;

-- Task 3: Derived Table called customer_revenue

SELECT * FROM (
				SELECT customer_id, SUM(total_amount) AS total_spending
                FROM sales
                GROUP BY customer_id
				) AS customer_summary
WHERE total_spending > 50000;

-- Task 4: Show customers who placed at least one order

SELECT full_name FROM customers
WHERE id IN 
				(SELECT DISTINCT customer_id
                FROM sales);
                
-- Task 5: Show customers with sales records using EXIST

SELECT full_name FROM customers
WHERE EXISTS 
			( SELECT 1
            FROM sales
           WHERE customers.id = sales.customer_id);
           
    
-- Task 6: Show products priced above their category average.
-- (Correlated Subqueries)
SELECT product_name, price FROM products
WHERE price >
			(SELECT AVG(price) 
            FROM products
            WHERE category = products.category);
	
-- Task 7: Regions above Average Revenue

SELECT region, SUM(total_amount) as region_revenue FROM customers
JOIN sales
ON customers.id = sales.customer_id
GROUP BY region
HAVING SUM(total_amount) > 
		(SELECT AVG(region_total)
        FROM (
				SELECT SUM(total_amount) AS region_total
                FROM customers
                JOIN sales
                ON customers.id = sales.customer_id
                GROUP BY region
                ) AS r
	);
    
-- Task 8: Show products priced higher than ANY Electronics product.

SELECT product_name, category, price
FROM products
WHERE price > ANY (
	SELECT price
    FROM products
    WHERE category = 'Electronics'
);


-- Using ALL ( No product is higher that the cost of the hightes electronics

SELECT product_name, category, price
FROM products
WHERE price > ALL (
	SELECT price
    FROM products
    WHERE category = 'Electronics'
);


-- Task 9: Customers with Highest Spending

SELECT full_name, sales.total_amount FROM customers
JOIN sales
ON customers.id = sales.customer_id
GROUP BY full_name
ORDER BY sales.total_amount DESC
LIMIT 1;


-- Task 10: Interview Task 1

SELECT c.full_name, SUM(s.total_amount) AS total_spending
FROM customers c
JOIN sales s
ON c.id = s.customer_id
GROUP BY c.id, c.full_name
HAVING SUM(s.total_amount) >
(
    SELECT AVG(customer_total)
    FROM
    (
        SELECT SUM(total_amount) AS customer_total
        FROM sales
        GROUP BY customer_id
    ) AS customer_totals
);


-- Task 11: Interview Task 2

SELECT p.product_name, p.category, p.price
FROM products p
WHERE NOT EXISTS
(
    SELECT 1
    FROM sales s
    WHERE s.product_id = p.id
);

-- Task 13: Performance Testing

SELECT * 
FROM customers
WHERE id IN 
			(SELECT customer_id FROM sales);


-- DASHBOARD

SELECT 
    c.full_name AS customer_name,
    customer_summary.total_orders,
    customer_summary.total_revenue,
    CASE 
        WHEN customer_summary.total_revenue > 
            (
                SELECT AVG(total_revenue)
                FROM 
                (
                    SELECT SUM(total_amount) AS total_revenue
                    FROM sales
                    GROUP BY customer_id
                ) AS avg_table
            )
        THEN 'Yes'
        ELSE 'No'
    END AS above_average_flag
FROM customers c
LEFT JOIN 
(
    SELECT 
        customer_id,
        COUNT(*) AS total_orders,
        SUM(total_amount) AS total_revenue
    FROM sales
    GROUP BY customer_id
) AS customer_summary
ON c.id = customer_summary.customer_id;


