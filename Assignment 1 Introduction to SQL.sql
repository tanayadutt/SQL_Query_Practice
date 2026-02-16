-- Created a database named training_db
CREATE DATABASE training_db;

-- Used the USE command to ensure we are working in the training_db database
USE training_db;

-- Created a table named students with four columns
CREATE TABLE students (
		id INT PRIMARY KEY auto_increment,
        studentname VARCHAR(100),
        email VARCHAR(150),
        created_at DATE

);

-- The SHOW command shows the existing tables within the database
SHOW TABLES;

-- The DESCRIBE command describes the tables, what columns it contains and their data types as well
DESCRIBE students;

-- The INSERT INTO statement inserts records into the table
INSERT INTO students (id, studentname, email, created_at)
VALUES (1, 'Tanaya Dutt', 'tanayadutt@gmail.com', '2026-02-12'),
	(2, 'Jyoti Dutt','jyotidutt@gmail.com', '2026-02-12'),
    (3, 'Yash Sharma', 'yashsharma@gmail.com','2026-02-12');
    

-- The SELECT * FROM statement selects all the records from the tables
SELECT * FROM students;

-- The SELECT statement selects records from the particular column that you want and the table 
SELECT studentname, email FROM students;


SELECT studentname, email, created_at FROM students;


