-- Top Customers by Spending

SELECT
c.customer_name,
SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

-- Revenue by Category

SELECT
p.category,
SUM(oi.quantity * p.price) AS revenue
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY revenue DESC;

-- Best Selling Products

SELECT
p.product_name,
SUM(oi.quantity) AS total_sold
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

-- Customer Ranking

SELECT
customer_name,
SUM(total_amount) AS total_spent,
RANK() OVER (
ORDER BY SUM(total_amount) DESC
) AS customer_rank
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY customer_name;

-- Top 3 Customers

SELECT
customer_name,
total_spent
FROM customer_spending
ORDER BY total_spent DESC
LIMIT 3;

-- Average Order Value

SELECT
ROUND(AVG(total_amount),2) AS average_order_value
FROM orders;

-- Monthly Revenue

SELECT
DATE_TRUNC('month', order_date) AS month,
SUM(total_amount) AS revenue
FROM orders
GROUP BY month
ORDER BY month;

-- CTE Example

WITH customer_totals AS (
    SELECT
        c.customer_name,
        SUM(o.total_amount) AS total_spent
    FROM customers c
    JOIN orders o
    ON c.customer_id = o.customer_id
    GROUP BY c.customer_name
)
SELECT *
FROM customer_totals
WHERE total_spent > 1000;