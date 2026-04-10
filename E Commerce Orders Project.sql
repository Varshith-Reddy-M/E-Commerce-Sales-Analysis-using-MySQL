CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    quantity INT,
    total_amount DECIMAL(10,2),
    city VARCHAR(50),
    payment_method VARCHAR(50)
);
LOAD DATA LOCAL INFILE "C:\Users\varsh\OneDrive\Desktop\MySQL\ecommerce_orders_10k_updated.csv"
INTO TABLE orders
FIELDS terminated by ','
enclosed by '"'
LINES terminated by '\n'
IGNORE 1 ROWS;

SELECT *
FROM orders;

/*Dropping Column with NULL Value*/
ALTER TABLE orders
DROP column product_name;

/*Renaming Columns*/
ALTER TABLE orders
RENAME COLUMN city TO country,
RENAME COLUMN payment_method TO customer_segment;

/*Checking for NULL Values*/
SELECT *
FROM orders WHERE price IS NULL;

/*TOTAL REVENUE*/
SELECT SUM(total_amount) AS total_revenue FROM orders;
/*1595831.17*/

/*Top 5 Selling Categories*/
SELECT category, SUM(quantity) AS total_sold
FROM orders
GROUP BY category
ORDER BY total_sold DESC
LIMIT 5;

/*Revenue by Category*/
SELECT category, SUM(total_amount) AS revenue
FROM orders
GROUP BY category;

/*Monthly Sales Trend*/
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(total_amount) AS revenue
FROM orders
GROUP BY month
ORDER BY month;

/*Top 5 Countries by Sales*/
SELECT country, SUM(total_amount) AS revenue
FROM orders
GROUP BY country
ORDER BY revenue DESC
LIMIT 5;

/*Customer Lifetime Value*/
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC;