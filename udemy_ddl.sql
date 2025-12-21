-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema UdemyProject
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema UdemyProject
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `UdemyProject` DEFAULT CHARACTER SET utf8mb3 ;
USE `UdemyProject` ;

-- -----------------------------------------------------
-- Table `UdemyProject`.`Categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UdemyProject`.`Categories` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(100) NOT NULL,
  `slug` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE INDEX `category_name_UNIQUE` (`category_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `UdemyProject`.`Instructors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UdemyProject`.`Instructors` (
  `instructor_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `expert_domain` VARCHAR(100) NULL DEFAULT NULL COMMENT 'e.g. Web Development, Data Science',
  `biography` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`instructor_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `UdemyProject`.`Courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UdemyProject`.`Courses` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  `subtitle` VARCHAR(255) NULL DEFAULT NULL,
  `price` DECIMAL(10,2) NOT NULL DEFAULT '19.99',
  `language` VARCHAR(50) NULL DEFAULT 'English',
  `level` ENUM('Beginner', 'Intermediate', 'Expert') NOT NULL DEFAULT 'Beginner',
  `instructor_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_Courses_Instructors_idx` (`instructor_id` ASC) VISIBLE,
  INDEX `fk_Courses_Categories1_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_Courses_Categories1`
    FOREIGN KEY (`category_id`)
    REFERENCES `UdemyProject`.`Categories` (`category_id`),
  CONSTRAINT `fk_Courses_Instructors`
    FOREIGN KEY (`instructor_id`)
    REFERENCES `UdemyProject`.`Instructors` (`instructor_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `UdemyProject`.`Students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UdemyProject`.`Students` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `join_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`student_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `UdemyProject`.`Enrollments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UdemyProject`.`Enrollments` (
  `enrollment_id` INT NOT NULL AUTO_INCREMENT,
  `enrollment_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `amount_paid` DECIMAL(10,2) NOT NULL COMMENT 'Records price at time of purchase',
  `progress_percent` INT NULL DEFAULT '0',
  `student_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  PRIMARY KEY (`enrollment_id`),
  INDEX `fk_Enrollments_Students1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_Enrollments_Courses1_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `fk_Enrollments_Courses1`
    FOREIGN KEY (`course_id`)
    REFERENCES `UdemyProject`.`Courses` (`course_id`),
  CONSTRAINT `fk_Enrollments_Students1`
    FOREIGN KEY (`student_id`)
    REFERENCES `UdemyProject`.`Students` (`student_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `UdemyProject`.`Reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UdemyProject`.`Reviews` (
  `review_id` INT NOT NULL AUTO_INCREMENT,
  `rating` INT NOT NULL COMMENT '1 to 5 stars',
  `comment` TEXT NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `student_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  PRIMARY KEY (`review_id`),
  INDEX `fk_Reviews_Students1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_Reviews_Courses1_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `fk_Reviews_Courses1`
    FOREIGN KEY (`course_id`)
    REFERENCES `UdemyProject`.`Courses` (`course_id`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_Reviews_Students1`
    FOREIGN KEY (`student_id`)
    REFERENCES `UdemyProject`.`Students` (`student_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
