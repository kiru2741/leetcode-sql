WITH RankedDelivery AS (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY customer_id
               ORDER BY order_date
           ) AS rn
    FROM Delivery
)

SELECT ROUND(
           AVG(
               order_date = customer_pref_delivery_date
           ) * 100,
           2
       ) AS immediate_percentage
FROM RankedDelivery
WHERE rn = 1;