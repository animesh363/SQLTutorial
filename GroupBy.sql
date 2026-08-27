-- GROUP BY = groups/aggregates rows based on a specific column
-- Often used with aggregate functions
-- ex. SUM(), MAX(), MIN(), AVG(), COUNT()

CREATE TABLE transactions (
    transaction_id INTEGER,
    amount DECIMAL(10,2),
    customer_id INTEGER,
    order_date DATE
);

INSERT INTO transactions (transaction_id, amount, customer_id, order_date)
VALUES
(1000, 4.99, 3, '2023-01-01'),
(1001, 2.89, 2, '2023-01-01'),
(1002, 3.38, 3, '2023-01-02'),
(1003, 4.99, 1, '2023-01-02'),
(1004, 1.00, NULL, '2023-01-03'),
(1005, 2.49, 4, '2023-01-03'),
(1006, 5.48, NULL, '2023-01-03');

SELECT * FROM transactions;

SELECT SUM(amount), order_date
FROM transactions
GROUP BY order_date;

-- maximum by date

SELECT MAX(amount), order_date
FROM transactions
GROUP BY order_date;
-- min by date
SELECT MIN(amount), order_date
FROM transactions
GROUP BY order_date;

-- how many transactions happen each day
SELECT COUNT(amount), order_date
FROM transactions
GROUP BY order_date;
