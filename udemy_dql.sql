-- ==============================================================
-- SCRIPT 3: DQL (Data Query Language)
-- OBJECTIVE: Business Analytics & Decision Support Queries
-- ==============================================================

USE UdemyClone;

-- ---------------------------------------------------------
-- BUSINESS QUERY 1: The "Instructor Payout" Report
-- Logic: Calculates total revenue per instructor.
-- Why? Determines how much Udemy owes the teachers.
-- ---------------------------------------------------------
SELECT 
    u.full_name AS Instructor_Name,
    COUNT(e.enrollment_id) AS Total_Sales,
    CONCAT('$', SUM(e.amount_paid)) AS Total_Revenue_Generated
FROM Users u
JOIN Courses c ON u.user_id = c.instructor_id
JOIN Enrollments e ON c.course_id = e.course_id
WHERE e.is_refunded = 0 -- Exclude refunds from payout
GROUP BY u.user_id
ORDER BY Total_Revenue_Generated DESC;


-- ---------------------------------------------------------
-- BUSINESS QUERY 2: The "Discount Impact" Analysis
-- Logic: Compares users who paid full price vs. used coupons.
-- Why? Helps decide if we should issue more coupons.
-- ---------------------------------------------------------
SELECT 
    c.title AS Course_Title,
    SUM(CASE WHEN e.coupon_used_id IS NOT NULL THEN 1 ELSE 0 END) AS Coupon_Users,
    SUM(CASE WHEN e.coupon_used_id IS NULL THEN 1 ELSE 0 END) AS Full_Price_Users,
    AVG(e.amount_paid) AS Average_Sale_Price
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id;


-- ---------------------------------------------------------
-- BUSINESS QUERY 3: The "Ghost Student" Finder
-- Logic: Finds students enrolled > 30 days ago with < 10% progress.
-- Why? These users are at risk of churning; we should email them.
-- ---------------------------------------------------------
SELECT 
    u.full_name AS Student_Name,
    u.email,
    c.title AS Course_Stalled,
    e.progress_percent,
    DATEDIFF(CURRENT_DATE, e.enrollment_date) AS Days_Since_Enrollment
FROM Users u
JOIN Enrollments e ON u.user_id = e.user_id
JOIN Courses c ON e.course_id = c.course_id
WHERE e.progress_percent < 10
  AND e.is_refunded = 0;