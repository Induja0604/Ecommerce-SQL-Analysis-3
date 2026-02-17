create database ecommerce;
use ecommerce;
CREATE TABLE orders (
    order_id INT,
    customer_name VARCHAR(50),
    product VARCHAR(50),
    category VARCHAR(50),
    price INT,
    quantity INT,
    order_date DATE
);
-- a.Use SELECT, WHERE, ORDER BY, GROUP BY--------
select * from orders;                         #select
SELECT * FROM orders WHERE price > 300;       #where
SELECT *, price * quantity AS total_amount FROM orders ORDER BY total_amount DESC;          #orderby
SELECT SUM(price * quantity) AS total_revenue FROM orders;                                  #aggregatefunction-sum
SELECT category,avg(price * quantity) AS revenue FROM orders GROUP BY category;             #aggregatefunction-avg&&group by
-- b.Use JOINS (INNER, LEFT, RIGHT)----
CREATE TABLE customers (
    cust_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers VALUES
('Alice','New York'),
('Bob','London'),
('Charlie','Delhi'),
('David','Paris');
select * from customers;
SELECT customer_name, product, city
FROM orders 
INNER JOIN customers 
ON orders.customer_name = customers.cust_name;        #inner
SELECT customer_name, city
FROM orders 
LEFT JOIN customers 
ON orders.customer_name = customers.cust_name;  #left join
SELECT customer_name, city
FROM orders 
RIGHT JOIN customers 
ON orders.customer_name = customers.cust_name;  #right join
-- c.Write subqueries----
-- highest price product
SELECT *
FROM orders
WHERE price = (
    SELECT MAX(price)
    FROM orders
);                                           #subquery
-- d.Use aggregate functions (SUM, AVG)---
select sum(quantity) from orders;   #sum
select avg(quantity) from orders;   #avg
-- e.Create views for analysis--
CREATE VIEW sales_summary AS
SELECT
    category,
    SUM(quantity) AS total_qty,
    SUM(price * quantity) AS total_sales
FROM orders
GROUP BY category;
SELECT * FROM sales_summary;                  #views
-- f.Optimize queries with indexes----
CREATE INDEX idx_customer
ON orders(customer_name);
CREATE INDEX idx_category
ON orders(category);
SHOW INDEX FROM orders;                     #indexs

