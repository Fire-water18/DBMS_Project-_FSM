-- ==============================================================
-- SCRIPT 3: DQL (Business Queries)
-- OBJECTIVE: Show the professor we can analyze the "Linkages"
-- ==============================================================

USE `UdemyProject`;

-- Query 1: The "Instructor Payout" (Revenue Analysis)
-- Shows how much money each Instructor's courses have generated.
SELECT 
    i.first_name,
    i.last_name,
    COUNT(e.enrollment_id) AS total_students_enrolled,
    SUM(e.amount_paid) AS total_revenue_generated
FROM Instructors i
JOIN Courses c ON i.instructor_id = c.instructor_id
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY i.instructor_id;

-- Query 2: The "Student Transcript" (Linkage Analysis)
-- Shows exactly which courses a specific student (Aranya) is taking.
SELECT 
    s.first_name AS Student,
    c.title AS Course_Taken,
    e.amount_paid AS Price_Paid,
    e.progress_percent AS Completion
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE s.first_name = 'Aranya';