WITH trips_avg_eff AS (
    SELECT t.driver_id, d.driver_name,
    AVG(
        CASE
        WHEN MONTH(t.trip_date) BETWEEN 1 AND 6 THEN t.distance_km / t.fuel_consumed
        END
    ) AS first_half_avg,
    AVG(
        CASE
        WHEN MONTH(t.trip_date) BETWEEN 7 AND 12 THEN t.distance_km / t.fuel_consumed
        END
    ) AS second_half_avg
    FROM trips t
    INNER JOIN 
    drivers d
    ON t.driver_id = d.driver_id
    GROUP BY t.driver_id, d.driver_name
)

SELECT driver_id, driver_name, 
ROUND(first_half_avg, 2) AS first_half_avg,
ROUND(second_half_avg, 2) AS second_half_avg,
ROUND(second_half_avg - first_half_avg, 2) AS efficiency_improvement
FROM trips_avg_eff
WHERE first_half_avg < second_half_avg
ORDER BY efficiency_improvement DESC, driver_name ASC;