/*
LeetCode 3554
Find Category Recommendation Pairs

Concepts:
- Self Join
- Pair Generation
- Aggregation

Key Idea:
1. Reduce the data to unique User - Category relationships.
2. Generate all category pairs purchased by the same user.
3. Keep only one pair direction (category1 < category2) to avoid duplicates.
4. Treat each user as a single vote for a category pair.
5. Count customers who purchased from both categories.
6. Keep only category pairs purchased by at least 3 customers.
7. Sort by customer count and category names.

Pattern Category:
Pair Analysis using Self Join
*/

WITH UserCategory AS (
    SELECT DISTINCT pp.user_id,
    pin.category
    FROM ProductPurchases pp
    INNER JOIN 
    ProductInfo pin
    ON pp.product_id = pin.product_id
)

SELECT
u1.category AS category1, 
u2.category AS category2,
COUNT(DISTINCT u1.user_id) AS customer_count
FROM UserCategory u1
INNER JOIN
UserCategory u2
ON u1.user_id = u2.user_id AND
u1.category < u2.category
GROUP BY u1.category, u2.category
HAVING COUNT(DISTINCT u1.user_id) > 2
ORDER BY COUNT(DISTINCT u1.user_id) DESC, u1.category, u2.category;