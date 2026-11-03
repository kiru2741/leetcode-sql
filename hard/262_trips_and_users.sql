/*
LeetCode 262
Trips and Users

Concepts:
- INNER JOIN
- Conditional Aggregation
- GROUP BY

Key Idea:
1. Join Trips with Users twice (client and driver).
2. Keep only trips where both client and driver are not banned.
3. Count cancelled trips using a condition.
4. Divide cancelled trips by total valid trips.
5. Aggregate by request date.

Pattern Category:
Aggregation -> Conditional Aggregation -> Ratio / Percentage
*/

SELECT request_at AS 'Day',
ROUND(SUM(status LIKE 'cancel%') * 1.0 / COUNT(*), 2) AS 'Cancellation Rate'
FROM Trips t
INNER JOIN
Users u
ON t.client_id = u.users_id
INNER JOIN
Users u2
ON t.driver_id = u2.users_id
WHERE request_at BETWEEN '2013-10-01' AND '2013-10-03' AND
u.banned = 'No' AND 
u2.banned = 'No'
GROUP BY request_at