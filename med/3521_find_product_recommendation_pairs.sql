/*
LeetCode 3521. Find Product Recommendation Pairs

Concepts:
- Self Join
- Pair Generation
- DISTINCT Counting
- Aggregation
- Co-occurrence Analysis

Key Idea:
1. Pair products purchased by the same user.
2. Keep only one pair direction (product1 < product2).
3. Count unique users who purchased both products.
4. Keep pairs purchased by at least 3 users.
5. Sort by user count and product IDs.

Pattern Category:
- Self Join Pattern
- Frequently Bought Together
- Product Pair Analysis
- Co-occurrence Counting

Recognition Clues:
- Purchased together
- Users bought both products
- Product combinations
- Common pairs
- Recommendation pairs

Reusable Pattern:
Self Join on User
↓
Generate Unique Pairs
↓
Count Distinct Users
↓
Filter by Threshold
*/

SELECT 
p1.product_id AS product1_id, 
p2.product_id AS product2_id,
p1i.category AS product1_category,
p2i.category AS product2_category,
COUNT(*) AS customer_count
FROM ProductPurchases p1
INNER JOIN
ProductPurchases p2
ON p1.user_id = p2.user_id AND p1.product_id <> p2.product_id
INNER JOIN ProductInfo p1i
ON p1.product_id = p1i.product_id
INNER JOIN ProductInfo p2i
ON p2.product_id = p2i.product_id
WHERE p1.product_id < p2.product_id
GROUP BY p1.product_id, p2.product_id, p1i.category, p2i.category
HAVING COUNT(*) > 2
ORDER BY COUNT(*) DESC, p1.product_id, p2.product_id;