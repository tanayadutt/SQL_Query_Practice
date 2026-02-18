-- Assignment 3 DATA MANIPULATION LANGUAGE

CREATE DATABASE edutechpro_db;

USE edutechpro_db;

-- creating tables for our database
CREATE TABLE students(
	id INT PRIMARY KEY AUTO_INCREMENT,
    studentname VARCHAR(100),
    email VARCHAR(150),
    phone VARCHAR(15),
    status_student VARCHAR(50) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE courses (
	id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    fees DECIMAL(10,2),
    status VARCHAR(50) DEFAULT 'active'
);

CREATE TABLE enrollments (
	id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SHOW TABLES;

DESCRIBE students;

-- Task 1 : Insert Single Student
INSERT INTO students (studentname, email, phone)
VALUES ('Tanaya Dutt', 'tanaydutt02@gmail.com', '9264467008');

SELECT * FROM students;

-- Task 2: Insert Multiple Students Records

INSERT INTO students (studentname, email, phone)
VALUES 
	('Abhishek Sharma', 'Abhishek123@gmail.com','9876543218'),
    ('Ishan Kishan','Ishan123@gmail.com','9273546279'),
    ('Suryakumar Yadav','Suryakumar123@gmail.com','9898778786');

-- Task 3: Inserting records in courses

INSERT INTO courses (course_name, fees)
VALUES 
	('Data Analysis','40000'),
    ('Fullstack Programming','45000'),
    ('UI/UX Design','35000');
    
SELECT * FROM courses;

-- Task 4 : Updating Student info using WHERE

SET SQL_SAFE_UPDATES = 0;
UPDATE students
SET phone = '9274476008'
WHERE studentname = 'Tanaya Dutt';

SELECT * FROM students WHERE studentname = 'Tanaya Dutt';

-- Task 5 : Bulk Update Course Status

UPDATE courses 
SET status = 'inactive'
WHERE course_name = 'UI/UX Design';

-- Task 6 : Delete One Student 

DELETE FROM students
WHERE studentname = 'Tanaya Dutt';

SELECT * FROM students;

-- Task 8: Delete Multiple Records

DELETE FROM courses
WHERE status = 'inactive';

SELECT * FROM courses;


-- Task 8: TRUNCATE Test Data Table

CREATE TABLE test_import (
	id INT AUTO_INCREMENT PRIMARY KEY,
    dataa VARCHAR(100)
);



TRUNCATE TABLE test_import;

DELETE FROM students;

SELECT * FROM students;