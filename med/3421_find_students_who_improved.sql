With FLDates AS (
    SELECT
    student_id,
    subject,
    MIN(exam_date) AS first_date,
    MAX(exam_date) AS latest_date
    FROM Scores
    GROUP BY student_id, subject
)

SELECT fl.student_id, fl.subject, s.score AS first_score, s2.score AS latest_score FROM FLDates fl
INNER JOIN Scores s
ON fl.student_id = s.student_id AND fl.subject = s.subject AND fl.first_date = s.exam_date
INNER JOIN Scores s2
ON fl.student_id = s2.student_id AND fl.subject = s2.subject AND fl.latest_date = s2.exam_date
WHERE s.score < s2.score
ORDER BY fl.student_id, fl.subject;