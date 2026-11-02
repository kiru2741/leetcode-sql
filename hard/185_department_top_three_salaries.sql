/*
LeetCode 185. Department Top Three Salaries

Concepts:
- Window Functions
- DENSE_RANK()
- Partitioning
- Top N Per Group
- Ranking within Groups

Key Idea:
1. Group employees by department using PARTITION BY.
2. Rank salaries within each department in descending order.
3. Use DENSE_RANK() to handle salary ties correctly.
4. Keep employees whose department salary rank is within the top 3.
5. Return all employees sharing the same salary rank.

Pattern Category:
- Top N Per Group
- Ranking Pattern
- Window Function Pattern
*/

WITH RankedEmployee AS (
    SELECT e.*,
    d.name AS Department,
    DENSE_RANK() OVER(PARTITION BY e.departmentId ORDER BY e.salary DESC) AS rank_salary
    FROM Employee e
    INNER JOIN
    Department d
    ON e.departmentId = d.id
)

SELECT Department, name AS Employee, Salary FROM RankedEmployee WHERE rank_salary <= 3;