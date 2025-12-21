

USE `UdemyProject`;

-- 1. Insert Categories
INSERT INTO Categories (category_name, slug) VALUES 
('Development', 'dev'),
('Business', 'bus'),
('Design', 'des');

-- 2. Insert Instructors
INSERT INTO Instructors (first_name, last_name, email, password_hash, expert_domain) VALUES 
('Jose', 'Portilla', 'jose@udemy.com', 'pass123', 'Data Science'),
('Angela', 'Yu', 'angela@udemy.com', 'pass456', 'Web Development'),
('Colt', 'Steele', 'colt@udemy.com', 'pass789', 'JavaScript');

-- 3. Insert Students
INSERT INTO Students (first_name, last_name, email, password_hash) VALUES 
('Aranya', 'Singh', 'aranya@gmail.com', 's_pass1'),
('Gursimran', 'Singh', 'gursimran@gmail.com', 's_pass2'),
('Shreya', 'Singh', 'shreya@gmail.com', 's_pass3'),
('John', 'Doe', 'john@test.com', 's_pass4');

-- 4. Insert Courses (Linked to Instructors and Categories)
INSERT INTO Courses (title, subtitle, price, level, instructor_id, category_id) VALUES 
('The Complete Python Bootcamp', 'Learn Python like a Pro', 94.99, 'Beginner', 1, 1),
('100 Days of Code: The Complete Python Pro', 'Master Python by building 100 projects', 84.99, 'Intermediate', 2, 1),
('The Web Developer Bootcamp 2024', 'The only course you need', 19.99, 'Beginner', 3, 1),
('MBA in a Box', 'Business Strategy', 49.99, 'Expert', 1, 2);

-- 5. Insert Enrollments (The "Linkage" Logic)
-- Aranya buys Python Bootcamp full price
INSERT INTO Enrollments (student_id, course_id, amount_paid, progress_percent) VALUES (1, 1, 94.99, 10);
-- Gursimran buys Web Dev on sale
INSERT INTO Enrollments (student_id, course_id, amount_paid, progress_percent) VALUES (2, 3, 9.99, 50);
-- Shreya buys MBA course
INSERT INTO Enrollments (student_id, course_id, amount_paid, progress_percent) VALUES (3, 4, 49.99, 100);
-- John Doe buys Python
INSERT INTO Enrollments (student_id, course_id, amount_paid, progress_percent) VALUES (4, 1, 94.99, 0);

-- 6. Insert Reviews
INSERT INTO Reviews (student_id, course_id, rating, comment) VALUES 
(3, 4, 5, 'Amazing business insights!'),
(2, 3, 4, 'Great course but very long.');