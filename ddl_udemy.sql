

DROP DATABASE IF EXISTS UdemyClone;
CREATE DATABASE UdemyClone;
USE UdemyClone;

-- 1. Categories Table (To organize courses like 'Development', 'Business')

CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    slug VARCHAR(100) NOT NULL 
);

-- 2. Users Table (Base entity for Students and Instructors)

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    headline VARCHAR(200), -- e.g. "Software Engineer at Google"
    biography TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_instructor TINYINT(1) DEFAULT 0
);

-- 3. Courses Table (The core product)

CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    subtitle VARCHAR(255),
    description TEXT,
    instructor_id INT NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL DEFAULT 19.99, -- Base price before coupons
    language VARCHAR(50) DEFAULT 'English',
    level ENUM('All Levels', 'Beginner', 'Intermediate', 'Expert') NOT NULL,
    is_published TINYINT(1) DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (instructor_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- 4. Course_Sections Table (Udemy specific: Course > Sections > Lectures)

CREATE TABLE Course_Sections (
    section_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    sequence_order INT NOT NULL, -- To order the syllabus (Section 1, 2, 3)
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

-- 5. Coupons Table (The Udemy Business Model)

CREATE TABLE Coupons (
    coupon_id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    course_id INT NOT NULL,
    discount_percent TINYINT UNSIGNED CHECK (discount_percent <= 100),
    expires_at DATETIME NOT NULL,
    is_active TINYINT(1) DEFAULT 1,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- 6. Enrollments Table (The Transaction)

CREATE TABLE Enrollments (
    enrollment_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    course_id INT NOT NULL,
    coupon_used_id INT NULL, -- Nullable if bought full price
    amount_paid DECIMAL(10, 2) NOT NULL, -- Crucial for revenue calc
    enrollment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    progress_percent TINYINT UNSIGNED DEFAULT 0,
    is_refunded TINYINT(1) DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    FOREIGN KEY (coupon_used_id) REFERENCES Coupons(coupon_id)
);

-- 7. Reviews Table (Social Proof)
CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    user_id INT NOT NULL,
    rating DECIMAL(2,1) NOT NULL CHECK (rating >= 1.0 AND rating <= 5.0),
    comment TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);