SELECT name 
FROM (
    SELECT m.id, m.name
    FROM 
    Employee e
    INNER JOIN 
    Employee m
    ON e.managerId = m.id
    GROUP BY m.id, m.name
    HAVING COUNT(*) > 4
)
managers;