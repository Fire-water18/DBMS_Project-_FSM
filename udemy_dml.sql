-- ==============================================================
-- SCRIPT 2: DML (Data Manipulation Language)

-- ==============================================================

USE UdemyClone;

-- 1. Insert Categories
INSERT INTO Categories (name, slug) VALUES 
('Development', 'development'),
('Business', 'business'),
('IT & Software', 'it-and-software'),
('Design', 'design');

-- 2. Insert Users (Instructors & Students)
INSERT INTO Users (full_name, email, password_hash, headline, is_instructor) VALUES 
('Jose Portilla', 'jose@python.com', 'hash1', 'Head of Data Science', 1),     -- ID 1
('Colt Steele', 'colt@webdev.com', 'hash2', 'Developer Bootcamp Instructor', 1), -- ID 2
('Angela Yu', 'angela@ios.com', 'hash3', 'iOS Lead Developer', 1),              -- ID 3
('John Student', 'john@gmail.com', 'hash4', 'Aspiring Dev', 0),                 -- ID 4
('Sarah Learner', 'sarah@yahoo.com', 'hash5', 'MBA Student', 0),                -- ID 5
('Mike Dropper', 'mike@test.com', 'hash6', 'Just looking', 0);                  -- ID 6

-- 3. Insert Courses
INSERT INTO Courses (title, instructor_id, category_id, price, level, description) VALUES 
('The Complete Python Bootcamp', 1, 1, 94.99, 'All Levels', 'Learn Python like a Pro!'), -- Course 1
('The Web Developer Bootcamp 2025', 2, 1, 19.99, 'Beginner', 'The only course you need.'), -- Course 2
('MBA in a Box: Business Strategy', 1, 2, 49.99, 'Intermediate', 'Business tactics.'), -- Course 3
('iOS 17 Development', 3, 1, 129.99, 'Expert', 'Swift and SwiftUI masterclass.'); -- Course 4

-- 4. Insert Course Sections (Syllabus)
INSERT INTO Course_Sections (course_id, title, sequence_order) VALUES
(1, 'Introduction to Python', 1),
(1, 'Python Object Data Structures', 2),
(1, 'Python Statements', 3),
(2, 'HTML Basics', 1),
(2, 'CSS Styling', 2);

-- 5. Insert Coupons (The Discounts)
INSERT INTO Coupons (code, course_id, discount_percent, expires_at) VALUES 
('BLACKFRIDAY90', 1, 90, '2025-12-31 23:59:59'), -- 90% off Python
('NEWYEAR2025', 2, 50, '2025-01-31 23:59:59'),   -- 50% off Web Dev
('FREEACCESS', 3, 100, '2024-12-31 23:59:59');   -- 100% off Business

-- 6. Insert Enrollments (Purchases)
INSERT INTO Enrollments (user_id, course_id, coupon_used_id, amount_paid, progress_percent) VALUES 
-- John uses a 90% coupon on a $94.99 course (Pays ~$9.50)
(4, 1, 1, 9.50, 45), 
-- Sarah buys full price (No coupon)
(5, 2, NULL, 19.99, 10),
-- Sarah uses a 100% off coupon (Pays $0)
(5, 3, 3, 0.00, 100),
-- Mike buys but refunds later
(6, 1, NULL, 94.99, 0);

-- Update Mike's refund status
UPDATE Enrollments SET is_refunded = 1 WHERE user_id = 6;

-- 7. Insert Reviews
INSERT INTO Reviews (course_id, user_id, rating, comment) VALUES 
(1, 4, 5.0, 'Best Python course on the internet!'),
(2, 5, 4.5, 'Colt is funny, but the CSS part was hard.'),
(3, 5, 5.0, 'Can not believe this was free with the coupon.');