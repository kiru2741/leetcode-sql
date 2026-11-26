/*
LeetCode 3586. Find COVID Recovery Patients

Concepts:
- CTE
- Aggregation
- MIN()
- Self Join
- Date Comparison
- Sequential Event Analysis

Key Idea:
1. Identify each patient's first positive COVID test date.
2. Find the earliest negative test date that occurred after the first positive test.
3. Calculate recovery time as the difference between the negative and positive test dates.
4. Keep only patients who have both a positive and subsequent negative test.
5. Return recovery information ordered by recovery time.

Pattern Category:
- First Event After Another Event
- Sequential Event Analysis
- Date-Based Tracking
- Aggregation Pattern
*/

WITH tests AS (
    SELECT *,
    MIN(
        CASE
        WHEN result = 'Positive' THEN test_date
        END
    ) OVER(PARTITION BY patient_id) AS first_positive
    FROM covid_tests
)

SELECT t1.patient_id, p.patient_name, p.age,
DATEDIFF(MIN(t2.test_date), t1.first_positive) AS recovery_time
FROM tests t1
INNER JOIN 
tests t2
ON t1.patient_id = t2.patient_id AND
t1.first_positive < t2.test_date AND
t2.result = 'Negative'
INNER JOIN 
patients p
ON t1.patient_id = p.patient_id
GROUP BY t1.patient_id, p.patient_name, p.age
ORDER BY recovery_time ASC, p.patient_name ASC;