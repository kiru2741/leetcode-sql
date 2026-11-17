/*
LeetCode 1321. Restaurant Growth

Concepts:
- Window Functions
- Rolling Window

*/

With DailyRevenue AS (
    SELECT visited_on,
    SUM(amount) AS amount
    FROM Customer
    GROUP BY visited_on
),

RT AS (
    SELECT
    visited_on,
    SUM(amount) OVER(ORDER BY visited_on ROWS 6 PRECEDING) AS amount,
    ROUND(AVG(amount) OVER(ORDER BY visited_on ROWS 6 PRECEDING), 2) AS average_amount,
    COUNT(*) OVER(ORDER BY visited_on ROWS 6 PRECEDING) AS count
    FROM DailyRevenue
)

SELECT visited_on, amount, average_amount
FROM RT
WHERE count = 7
ORDER BY visited_on;