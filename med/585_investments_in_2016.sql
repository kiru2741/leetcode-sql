/*
LeetCode 585
Investments in 2016

Concepts:
- Correlated Subquery
- EXISTS
- NOT EXISTS
- Aggregate Functions
- Conditional Filtering
- SUM()

Key Idea:
1. Find policyholders whose tiv_2015 value appears in another record.
2. Ensure the policyholder's (lat, lon) combination is unique.
3. Use EXISTS to check for duplicate tiv_2015 values.
4. Use NOT EXISTS to ensure no other record shares the same location.
5. Sum tiv_2016 for qualifying policyholders.
6. Round the final result to 2 decimal places.

Pattern Category:
- EXISTS / NOT EXISTS Pattern
- Duplicate vs Unique Detection
- Correlated Subquery Pattern
- Aggregation After Filtering
*/

SELECT ROUND(SUM(tiv_2016),2) AS tiv_2016 
FROM Insurance i1 
WHERE EXISTS (
    SELECT 1 
    FROM Insurance i2 
    WHERE i1.tiv_2015 = i2.tiv_2015 AND i1.pid <> i2.pid
    ) 
    AND 
    NOT EXISTS (
        SELECT 1 
        FROM Insurance i3 
        WHERE i1.lat = i3.lat AND i1.lon = i3.lon AND i1.pid <> i3.pid
    )