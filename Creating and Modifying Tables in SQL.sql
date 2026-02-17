-- Creating, Modifying and Getting to know more about tables

CREATE DATABASE troopystack_lms;

-- using the database I just created
USE troopystack_lms;

SHOW DATABASES;

-- Creating table called students

CREATE TABLE students (
	id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE,
    phone VARCHAR(15),
    dob DATE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

SHOW TABLES;
DESCRIBE students;

-- creating table called courses
CREATE TABLE courses (
	id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description_course TEXT,
    fee DECIMAL(10,2),
    is_active BOOLEAN DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

SHOW TABLES;

-- creating faculties tables
CREATE TABLE faculties(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE,
    phone VARCHAR(15),
    joining_date DATE
    );
    
SHOW TABLES;

-- Modifying Schema

ALTER TABLE students
ADD status VARCHAR(20) DEFAULT 'active';

SHOW TABLES;

-- renaming tables using RENAME TABLE
RENAME TABLE faculties TO trainers;

SHOW TABLES;

-- Modifying columns 
ALTER TABLE students
MODIFY phone VARCHAR(20);

-- testing and verifying table structures

DESCRIBE students;
DESCRIBE courses;
DESCRIBE trainers;

-- DROP TABLE 

DROP TABLE trainers;