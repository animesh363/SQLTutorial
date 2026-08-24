create DATABASE myDb;
use myDb;

drop DATABASE myDb;

Create DATABASE myDb;
use myDb; 

-- ALTER
ALTER DATABASE myDb READ ONLY = 1;  -- myDb set as read only mlode we can't update but we can still acess
DROP DATABASE myDb; -- We cant perform this because: Error Code: 3989. Schema 'nvdb' is in read only mode

-- To disable read only mode
ALTER DATABASE myDb READ ONLY = 0;

-- tables

CREATE TABLE  employees(
	employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hourly_pay DECIMAL(5,2),
    hire_date DATE
);
-- Selecting a table
SELECT * FROM employees;

-- renaming a table
RENAME TABLE employees To workers;
RENAME TABLE workers TO employees;

ALTER TABLE employees
ADD phone_number VARCHAR(15); -- Adding a new colum phone_number to the table

SELECT * FRoM employees;

-- rename phone_number to email
ALTER TABLE employees
RENAME COLUMN phone_number TO email
SELECT * FROM employees; 

-- modifying the email column
ALTER TABLE employees
MODIFY COLUMN email VARCHAR(100);

-- email column is in last so lets change the position of email column 
ALTER TABLE employees
MODIFY COLUMN email VARCHAR(100)
AFTER last_name;

SELECT * FROM employees;

-- for First position
ALTER TABLE employees
MODIFY COLUMN email VARCHAR(100)
FIRST;

SELECT * FROM employees;

-- dropping email column
ALTER TABLE employees
DROP COLUMN email;

SELECT * FROM employees;


		-- Insertion --

-- 1) Single line insertion
INSERT INTO employees
VALUES ( 1, "Animesh", "Anand", 100.46, "2025-01-08");

SELECT * FROM employees;

-- 2) Multi line insertion
INSERT INTO employees
VALUES	(2, "pranav", "piyush", 120.77, "2026-01-07"),
		(3, "sunjit", "bsk", 130.7743, "2026-06-30"),
        (4, "Gaurav", "singh", 140.655, "2026-01-16"),
        (5, "Harshit", "Sharma", 150.07, "2026-01-12");
        
SELECT * FROM employees;

-- what if we will try to insert a row with incomplete data
INSERT INTO employees
VALUES ( 6, "Yoga", "Nand" ); -- Error Code: 1136, Column count doesn't match value at row 1 1/1

SELECT * FROM employees; -- No insertion happened

-- special method for incomplete data
INSERT INTO employees (employee_id, first_name, last_name )
VALUES ( 6, "Yoga", "Nand" ); -- incomplete data will consider as null

SELECT * FROM employees;



		-- Selection --

-- 1) selecting a whole table
SELECT * FROM employees;

SELECT first_name, last_name  -- only first name and last name will be printed  
FROM employees;

-- in which order yu will write column name in that order column will be printed
SELECT last_name, first_name
FROM employees;

-- finding some specific employees
SELECT *
FROM employees
WHERE employee_id = 1;

SELECT * 
FROM employees
WHERE first_name = "Animesh"; -- if value will not match it will return nothing


SELECT *
FROM employees
WHERE hourly_pay >=130;

SELECT *
FROM employees
WHERE hourly_pay <=120;

SELECT *
FROM employees
WHERE employee_id != 1;

SELECT *
FROM employees
WHERE hire_date IS NULL;

SELECT *
FROM employees
WHERE hire_date IS NOT NULL;

SELECT * FROM employees;


		-- Updation --
UPDATE employees
SET hourly_pay = 90.54
WHERE employee_id = 4;

SELECT * FROM employees;

-- updating multiple values
UPDATE employees
SET hourly_pay = 175.99,
	hire_date = "2025-06-23"
WHERE employee_id = 1;

SELECT * FROM employees;

-- updating the whole column at once
UPDATE employees
SET hourly_pay= 100.12; -- this will hourly_pay = 100.12 for all the emplotyee

SELECT * FROM employees;



		-- Deletation --
        
DELETE FROM employees
WHERE employee_id = 6;  -- 6th row will be deleted

SELECT * FROM employees;

DELETE FROM employees; -- this will delete whole table


		--	DATE, TIME, DATETIME	--
        
CREATE TABLE test(
	my_date DATE,
    my_Time TIME,
    my_datetime DATETIME
	);
    
INSERT INTO test
VALUES(CURRENT_DATE(), CURRENT_TIME(), NOW() );

SELECT * FROM test;


-- UNIQUE

CREATE TABLE products(
	product_id INT,
    product_name VARCHAR(25) UNIQUE, -- we cant add more than one product with the same name
    price DECIMAL(4,2)
	);

-- if we forgot to add constraint to add in any column then we can add like this
CREATE TABLE products(
	product_id INT,
    product_name VARCHAR(25),
    price DECIMAL(4,2)
	);
    
ALTER TABLE products
ADD CONSTRAINT 
UNIQUE(product_name);

SELECT * FROM products;


INSERT INTO products
VALUES	(101, "Burger", 3.99),
		(102, "Sandwithch", 3.99),
        (103, "Paneer ROll", 4.19),
        (104, "Dosa", 1.45);
    
SELECT * FROM products;

-- we can't add product with same name 
INSERT INTO products
VALUES		(105, "Burger", 2.99); -- Error Code: 1062. Duplicate entry 'Burgee for key •products.product_narne•

DROP TABLE products;


		-- NOT NULL -- 
    
CREATE TABLE products(
	product_id INT,
    product_name VARCHAR(25) UNIQUE,
    price DECIMAL(4,2) NOT NULL
	);
SELECT * FROM products;

INSERT INTO products
VALUES	(101, "Burger", 3.99),
		(102, "Sandwithch", 3.99),
        (103, "Paneer ROll", 4.19);

-- try to inser row with null value for price 
INSERT INTO products -- Error Code: 1364. Field 'price' doesn't have a default value
VALUES	(104, "Dosa", NULL );

INSERT INTO products 
VALUES	(104, "Dosa",5.88 ); -- now its got added

-- If we forget then we can add later NOTNULL constraint by

ALTER TABLE products
MODIFY price DECIMAL(4,2) NOT NULL;

SELECT * FROM employees


-- CHECK constrain --
-- CHECK constraint ensures that only values satisfying a specified condition are allowed in a column.
        
-- 1) adding while creating the table
CREATE TABLE students (
	id INT,
    name VARCHAR(50),
    age INT,
    CONSTRAINT chk_Age CHECK (age>=18)
);
SELECT * FROM students;

INSERT INTO students
VALUES  (1, "Animesh", 22);

INSERT INTO students
VALUES  (2, "Pranav", 16);  -- age not greater than 18 so -> Error Code: 3819. Check constraint 'chk_Agei is violated.


INSERT INTO students
VALUES  (2, "pranav", 20),
	    (3,"harshit",22);
        
	-- 1) adding in existing table
    
SELECT * FROM employees;

ALTER TABLE employees
ADD CONSTRAINT chk_hourly CHECK (hourly_pay >=100);
        
INSERT INTO employees
VALUES	(6, "Gaurav", "Singh",103.00, "2026-03-11");

INSERT INTO employees
VALUES	(4, "Shubham", "Singh",107.00, "2026-09-11");

SELECT * FROM employees
ORDER BY employee_id;


--	DEFAULT --
-- DEFAULT constraint automatically assigns a specified value when no value is provided for a column.

SELECT * FROM students

-- 1)adding while creating a new table 
CREATE TABLE yova (
    student_id INT,
    student_name VARCHAR(50),
    course VARCHAR(50),
    status VARCHAR(20) DEFAULT 'Active'
);
INSERT INTO  yova
VALUES	(1, "Animesh", "BTech","Inactive");
		
        
INSERT INTO  yova
VALUES	(2, "Pranav", "ECE",DEFAULT);

SELECT * FROM yova;

-- 2) adding in existing table
ALTER TABLE products
ALTER price SET DEFAULT 0;

INSERT INTO products(product_id, product_name)  -- by default price will set to 0
VALUES	(105, "Straw"),
		(106, "napkin"),
        (107, "spoon"),
        (108, "fork");

SELECT * FROM products; 



CREATE TABLE transactions(
	transaction_id INT,
    amount DECIMAL,  -- missed (5,2) digit and presition so it taken as int
    transaction_date DATETIME DEFAULT NOW()
);
ALTER TABLE transactions
MODIFY amount DECIMAL(5,2);

DELETE FROM transactions 
WHERE transaction_id=1;

INSERT INTO transactions(transaction_id, amount)
VALUES	(1, 2.99);

INSERT INTO transactions(transaction_id, amount)
VALUES	(2, 3.99),
		(3, 4.99),
        (4,5.99999);

SELECT * FROM transactions;

DROP TABLE transactions;

--	PRIMARY KEY
-- 1) adding while creqting the table 
CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY,
    amount DECIMAL(5,2)
);
DROP TABLE transactions;
-- 1) adding in existing table
CREATE TABLE transactions(
	transaction_id INT,
    amount DECIMAL(5,2)
);

ALTER TABLE transactions
ADD CONSTRAINT PRIMARY KEY(transaction_id);

INSERT INTO transactions
VALUES	(1001, 3.99);

INSERT INTO transactions
VALUES	(1001, 4.99); -- Error Code: 1062. Duplicate entry '1001 ' for key transactions.PRlMARY

INSERT INTO transactions
VALUES	(NULL, 5.99); -- Error Code: 1048. Column •transaction id cannot be null

INSERT INTO transactions
VALUES	(1002, 4.99),
		(1003,5.99),
        (1004,6.99);

SELECT amount 
FROM transactions
WHERE transaction_id = 1003;


SELECT * FROM transactions;

DROP TABLE transactions;

--	AUTO_INCREMENT  --
CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY  AUTO_INCREMENT,
    amount DECIMAL(5,2)
);

INSERT INTO transactions(amount)
VALUES (4.99);

INSERT INTO transactions(amount)
VALUES	(5.99),
		(6.99),
        (5.89);
	
SELECT * FROM transactions;

DELETE FROM transactions;

-- starting from a specific number
-- 1)after creation
ALTER TABLE transactions
AUTO_INCREMENT = 1000;

INSERT INTO transactions(amount)
VALUES	(5.99),
		(6.99),
        (5.89);
DROP TABLE transactions;
-- 2) while  creating the table

CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(5,2)
)AUTO_INCREMENT = 100;

INSERT INTO transactions(amount)
VALUES	(5.99),
		(6.99),
        (5.89);
        
SELECT * FROM transactions;

-- Foreign key --
CREATE TABLE customers(
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

SELECT * FROM customers;

INSERT INTO customers(first_name, last_name)
VALUES  ("Rockey","Thakur"),
		("Sunu","Sharma"),
        ("Pranav","Piyush");
        
INSERT INTO customers(first_name, last_name)
VALUES  ("Harshit","Sharma");
        
        
DROP TABLE transactions;

CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(5,2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

-- dropping foreignkey
ALTER TABLE transactions
DROP FOREIGN KEY transactions_ibfk_1;
-- adding new name to that foreign_key
ALTER TABLE transactions
ADD CONSTRAINT fk_customer_id
FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

DELETE FROM transactions;
SELECT * FROM transactions;

ALTER TABLE transactions
AUTO_INCREMENT =100;

INSERT INTO transactions(amount, customer_id)
VALUES	(4.99, 3),
		(3.99, 2),
        (3.38, 3),
        (4.99, 1);

INSERT INTO transactions(amount,customer_id)
VALUES (1.00, NULL);

SELECT * FROM transactions;


-- Foreign key --
CREATE TABLE customers(
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

SELECT * FROM customers;

INSERT INTO customers(first_name, last_name)
VALUES  ("Rockey","Thakur"),
		("Sunu","Sharma"),
        ("Pranav","Piyush");
        
INSERT INTO customers(first_name, last_name)
VALUES  ("Harshit","Sharma");
        
        
DROP TABLE transactions;

CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(5,2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

-- dropping foreignkey
ALTER TABLE transactions
DROP FOREIGN KEY transactions_ibfk_1;
-- adding new name to that foreign_key
ALTER TABLE transactions
ADD CONSTRAINT fk_customer_id
FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

DELETE FROM transactions;
SELECT * FROM transactions;

ALTER TABLE transactions
AUTO_INCREMENT =100;

INSERT INTO transactions(amount, customer_id)
VALUES	(4.99, 3),
		(3.99, 2),
        (3.38, 3),
        (4.99, 1);

INSERT INTO transactions(amount,customer_id)
VALUES (1.00, NULL);

SELECT * FROM transactions;

-- inner join 
SELECT *
FROM transactions INNER JOIN customers
ON transactions.customer_id = customers.customer_id;

SELECT transaction_id, amount,customers.customer_id, first_name, last_name
FROM transactions INNER JOIN customers
ON transactions.customer_id = customers.customer_id;

-- left join


-- Right join 
SELECT *
FROM transactions RIGHT JOIN customers
ON transactions.customer_id = customers.customer_id; 

SELECT * FROM transactions;

SELECT COUNT(amount)
FROM transactions;

-- we can give a column header
SELECT COUNT(amount) As "total no of transactions"
FROM transactions;

SELECT MAX(amount) AS "maximum amount"
FROM transactions;

SELECT MIN(amount) AS "minimum amount"
FROM transactions;

SELECT AVG(amount) AS "Average amount"
FROM transactions;

SELECT SUM(amount) AS Sum
FROM transactions;

SELECT * FROM employees;
SELECT CONCAT(first_name, " ", last_name) AS full_name
FROM employees; 

-- Logical AND OR NOT oprators

SELECT * FROM employees;

ALTER TABLE employees 
ADD column job VARCHAR(25) AFTER hourly_pay;

UPDATE employees
SET JOB = 
	CASE
		WHEN employee_id=1 THEN 'Developer'  -- i have inserted wrong before
        WHEN employee_id=2 THEN 'Manager'
        WHEN employee_id=3 THEN 'Designer'
        WHEN employee_id=4 THEN 'Tester'
        WHEN employee_id=5 THEN 'HR'
        WHEN employee_id=6 THEN 'Developer'
	END;
    
UPDATE employees
SET job='Developer'
WHERE employee_id=1;
    
    
SELECT *
FROM employees
WHERE hire_date <= "2026-03-11"  AND job='Developer';

SELECT *
FROM employees
WHERE job='Developer';

SELECT *
FROM employees
WHERE job='Developer' OR job='HR';

SELECT *
FROM employees
WHERE NOT job='Developer';

-- TILL LOGICAL OPRATOR

SELECT *
FROM employees
WHERE hire_date BETWEEN "2026-01-07" AND "2026-09-11";

SELECT *
FROM employees
WHERE JOB IN("Developer","Manager");

-- ORDER BY --
-- ORDER BY is used to sort the result of a query.

SELECT * FROM employees
ORDER BY last_name; -- by default it arrange in ascendinng order

SELECT * FROM employees
ORDER BY first_name ASC; -- ASC not needed

SELECT * FROM employees
ORDER BY hourly_pay DESC;

SELECT * FROM transactions
ORDER BY amount;

SELECT * FROM transactions
ORDER BY amount DESC;

SELECT * FROM transactions
ORDER BY amount DESC, customer_id; -- if amount is same for 2 then it will order on the basis of customer_id

-- LIMIT --
-- LIMIT is used to control how many rows are returned by a query.
-- REAL INDUSTRY USES:
-- Pagination
-- Top products
-- Latest orders
-- Leaderboards
-- Latest posts

SELECT * FROM customers; 

SELECT * FROM customers
LIMIT 1;

SELECT * FROM customers
ORDER BY first_name DESC LIMIT 3;

-- with OFFSET
SELECT * FROM customers
LIMIT 1, 2;  -- OFFSET 1 LIMIT 2 skip 1 rows and return next 2 rows

-- OFFSET->  is used to skip a specific number of rows before returning the result.
SELECT * FROM customers
LIMIT 2 OFFSET 2;


-- UNION combines the results of two or more SELECT statement
-- ->Removes Duplicate,-> should be same no of coluls
CREATE TABLE income(
	income_name VARCHAR(50),
    amount INT
);

INSERT INTO income
VALUES	("orders",10000),
		("kart",12000),
        ("service",15000);
SELECT * FROM income;

CREATE TABLE expences(
	expance_name VARCHAR(50),
    amount INT
);
INSERT INTO expences
VALUES	("wages",-10000),
		("tax",-8000),
        ("repairs",-4000);
SELECT * FROM income;
-- UNION
SELECT * FROM income
UNION
SELECT * FROM expences;

SELECT first_name, last_name FROM employees
UNION
select first_name, last_name FROM customers;

-- UNION ALL -> keeps duplicates.
SELECT first_name, last_name FROM employees
UNION ALL
select first_name, last_name FROM customers;
