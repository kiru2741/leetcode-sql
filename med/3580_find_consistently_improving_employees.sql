/*
LeetCode 3580. Find Consistently Improving Employees

Concepts:
- Window Functions
- ROW_NUMBER()
- LEAD()
- Aggregation

Pattern Category:
- Top N Per Group
- Compare adjacent rows

Reusable Pattern:
Rank Recent Records
↓
Keep Latest N Rows
↓
Compare Consecutive Rows
↓
Measure Trend
↓
Aggregate & Filter
*/

WITH emp_reviews AS (
    SELECT p.*, e.name,
    COUNT(*) OVER(PARTITION BY p.employee_id) AS reviews_count,
    ROW_NUMBER() OVER(PARTITION BY p.employee_id ORDER BY p.review_date DESC) AS rn,
    LEAD(rating) OVER(PARTITION BY p.employee_id ORDER BY p.review_date) AS next_rating
    FROM performance_reviews p
    INNER JOIN employees e
    ON p.employee_id = e.employee_id
)

SELECT employee_id, name,
MAX(rating) - MIN(rating) AS improvement_score 
FROM emp_reviews 
WHERE reviews_count >= 3 AND rn <= 3
GROUP BY employee_id, name
HAVING SUM(rating < next_rating) = 2
ORDER BY improvement_score DESC, name ASC;