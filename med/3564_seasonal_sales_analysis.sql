/*
LeetCode 3564. Seasonal Sales Analysis

Concepts:
- CASE Expression
- Aggregation
- ROW_NUMBER()
- Ranking
- Tie Breaking

Pattern Category:
- Aggregate → Rank
- Top 1 Per Group
- Window Function Ranking
*/

WITH salesseason AS (
    SELECT
    s.*, p.category,
    CASE
    WHEN MONTH(s.sale_date) IN (12, 1, 2) THEN 'Winter'
    WHEN MONTH(s.sale_date) IN (3, 4, 5) THEN 'Spring'
    WHEN MONTH(s.sale_date) IN (6, 7, 8) THEN 'Summer'
    ELSE 'Fall'
    END AS season
    FROM sales s
    INNER JOIN
    products p
    ON s.product_id = p.product_id
),

grouped AS (
    SELECT season, category,
    SUM(quantity) AS total_quantity,
    SUM(price * quantity) AS total_revenue
    FROM salesseason
    GROUP BY season, category
),

ranked AS (
    SELECT *,
    ROW_NUMBER() OVER(PARTITION BY season ORDER BY total_quantity DESC, total_revenue DESC, category) AS rn
    FROM grouped
)

SELECT season, 
category,
total_quantity,
total_revenue 
FROM ranked
WHERE rn = 1
ORDER BY season;