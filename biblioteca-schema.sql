DROP SCHEMA IF EXISTS library;
CREATE DATABASE library;

USE library;

CREATE TABLE library_user (
	user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL,
    address VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE author (
	author_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(50) NOT NULL
);

CREATE TABLE category (
	category_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE book (
	isbn INT NOT NULL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author_id INT,
    category_id INT,
    publication_date DATE,
    FOREIGN KEY (author_id) REFERENCES author(author_id) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (category_id) REFERENCES category(category_id) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE loan (
	loan_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    isbn INT,
    loan_date DATE,
    return_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES library_user(user_id),
    FOREIGN KEY (isbn) REFERENCES book(isbn) ON UPDATE CASCADE
);

CREATE TABLE fine (
	fine_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    loan_id INT,
    fine_amount FLOAT,
    issued_date DATE,
    paid BOOLEAN,
    FOREIGN KEY (loan_id) REFERENCES loan(loan_id)
);

CREATE TABLE loan_log (
	log_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    loan_id INT,
    action_type VARCHAR(20),
    session_user VARCHAR(50), 
	session_date DATE,
    session_time TIME
);

CREATE TABLE fine_log (
	log_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fine_id INT,
    action_type VARCHAR(20),
	session_user VARCHAR(50), 
    session_date DATE,
    session_time TIME
);