-- 1. Highest grossing pizza per month using window function
SELECT month, pizza_name, monthly_revenue
FROM (
  SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
         pizza_name,
         SUM(total_price) AS monthly_revenue,
         RANK() OVER (PARTITION BY DATE_FORMAT(order_date, '%Y-%m') ORDER BY SUM(total_price) DESC) AS rnk
  FROM pizza_sales
  GROUP BY month, pizza_name
) ranked_pizzas
WHERE rnk = 1;

-- 2. Identify top 10% revenue orders using NTILE()
WITH order_values AS (
  SELECT order_id, SUM(total_price) AS total_order_value
  FROM pizza_sales
  GROUP BY order_id
),
ranked_orders AS (
  SELECT *, NTILE(10) OVER (ORDER BY total_order_value) AS decile
  FROM order_values
)
SELECT * FROM ranked_orders WHERE decile = 10;

-- 3. Identify pizza categories with revenue increasing month-over-month
WITH monthly_category_revenue AS (
  SELECT pizza_category, DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(total_price) AS revenue
  FROM pizza_sales
  GROUP BY pizza_category, month
),
revenue_growth AS (
  SELECT *,
         LAG(revenue) OVER (PARTITION BY pizza_category ORDER BY month) AS prev_revenue
  FROM monthly_category_revenue
)
SELECT * FROM revenue_growth WHERE revenue > prev_revenue;

-- 4. Total revenue vs average unit price by size using CTE
WITH stats AS (
  SELECT pizza_size, SUM(total_price) AS total_revenue, AVG(unit_price) AS avg_price
  FROM pizza_sales
  GROUP BY pizza_size
)
SELECT * FROM stats ORDER BY total_revenue DESC;

-- 5. Number of distinct pizzas sold per category
SELECT pizza_category, COUNT(DISTINCT pizza_name) AS pizza_count
FROM pizza_sales
GROUP BY pizza_category;

-- 6. Difference in revenue between highest and lowest selling pizza
WITH revenues AS (
  SELECT pizza_name, SUM(total_price) AS revenue
  FROM pizza_sales
  GROUP BY pizza_name
),
min_max AS (
  SELECT MAX(revenue) AS max_revenue, MIN(revenue) AS min_revenue FROM revenues
)
SELECT max_revenue - min_revenue AS revenue_difference FROM min_max;

-- 7. Top 3 pizza categories by average revenue per order
SELECT pizza_category, 
       ROUND(SUM(total_price) / COUNT(DISTINCT order_id), 2) AS avg_revenue_per_order
FROM pizza_sales
GROUP BY pizza_category
ORDER BY avg_revenue_per_order DESC
LIMIT 3;

-- 8. Daily revenue change using LAG
WITH daily_revenue AS (
  SELECT order_date, SUM(total_price) AS daily_total
  FROM pizza_sales
  GROUP BY order_date
)
SELECT *, 
       daily_total - LAG(daily_total) OVER (ORDER BY order_date) AS revenue_change
FROM daily_revenue;

-- 9. Pizza sold every day
SELECT pizza_name
FROM pizza_sales
GROUP BY pizza_name
HAVING COUNT(DISTINCT order_date) = (SELECT COUNT(DISTINCT order_date) FROM pizza_sales);

-- 10. Count of repeat orders (same order ID on multiple days)
SELECT order_id, COUNT(DISTINCT order_date) AS repeat_days
FROM pizza_sales
GROUP BY order_id
HAVING repeat_days > 1;

-- 11. First and last order date for each pizza
SELECT pizza_name, 
       MIN(order_date) AS first_order, 
       MAX(order_date) AS last_order
FROM pizza_sales
GROUP BY pizza_name;

-- 12. Percentage change in monthly revenue
WITH monthly AS (
  SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(total_price) AS revenue
  FROM pizza_sales
  GROUP BY month
),
monthly_change AS (
  SELECT *,
         LAG(revenue) OVER (ORDER BY month) AS previous_month
  FROM monthly
)
SELECT month, revenue, previous_month,
       ROUND(((revenue - previous_month) / previous_month) * 100, 2) AS pct_change
FROM monthly_change
WHERE previous_month IS NOT NULL;

-- 13. Day with highest average revenue per order
SELECT order_date,
       ROUND(SUM(total_price) / COUNT(DISTINCT order_id), 2) AS avg_revenue_per_order
FROM pizza_sales
GROUP BY order_date
ORDER BY avg_revenue_per_order DESC
LIMIT 1;

-- 14. Pizza with most consistent sales (lowest stddev across days)
WITH daily_sales AS (
  SELECT pizza_name, order_date, SUM(quantity) AS daily_qty
  FROM pizza_sales
  GROUP BY pizza_name, order_date
),
stddev_sales AS (
  SELECT pizza_name, STDDEV(daily_qty) AS stddev_qty
  FROM daily_sales
  GROUP BY pizza_name
)
SELECT * FROM stddev_sales ORDER BY stddev_qty ASC LIMIT 1;

-- 15. Daily rank of pizzas by revenue
SELECT order_date, pizza_name,
       SUM(total_price) AS revenue,
       RANK() OVER (PARTITION BY order_date ORDER BY SUM(total_price) DESC) AS daily_rank
FROM pizza_sales
GROUP BY order_date, pizza_name
ORDER BY order_date, daily_rank;

-- 16. Average quantity ordered by pizza size across all days
SELECT pizza_size, ROUND(AVG(quantity), 2) AS avg_quantity
FROM pizza_sales
GROUP BY pizza_size
ORDER BY avg_quantity DESC;

-- 17. Rank pizza categories by total revenue using window function
SELECT pizza_category, 
       SUM(total_price) AS total_revenue,
       RANK() OVER (ORDER BY SUM(total_price) DESC) AS category_rank
FROM pizza_sales
GROUP BY pizza_category;

-- 18. Most common pizza ingredients (flattened count)
SELECT ingredient, COUNT(*) AS count
FROM (
  SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(pizza_ingredients, ',', numbers.n), ',', -1)) AS ingredient
  FROM pizza_sales
  JOIN (
    SELECT a.N + b.N * 10 AS n
    FROM (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a
    CROSS JOIN (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b
  ) numbers ON CHAR_LENGTH(pizza_ingredients) - CHAR_LENGTH(REPLACE(pizza_ingredients, ',', '')) >= numbers.n - 1
) sub
GROUP BY ingredient
ORDER BY count DESC
LIMIT 10;

-- 19. Total number of pizzas sold by hour of day
SELECT HOUR(order_time) AS hour_of_day, SUM(quantity) AS total_pizzas
FROM pizza_sales
GROUP BY hour_of_day
ORDER BY total_pizzas DESC;

-- 20. Monthly revenue share of each pizza category
WITH monthly_totals AS (
  SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(total_price) AS total_monthly_revenue
  FROM pizza_sales
  GROUP BY month
),
category_revenue AS (
  SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, pizza_category, SUM(total_price) AS category_rev
  FROM pizza_sales
  GROUP BY month, pizza_category
)
SELECT c.month, c.pizza_category, 
       ROUND((c.category_rev / t.total_monthly_revenue) * 100, 2) AS category_share
FROM category_revenue c
JOIN monthly_totals t ON c.month = t.month
ORDER BY c.month, category_share DESC;
