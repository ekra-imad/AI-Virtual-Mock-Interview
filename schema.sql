-- Database Schema for AI Based Virtual Mock Interview Platform using NLP
-- DBMS: MySQL
-- Normalized to 3NF

-- Drop tables if they exist to allow clean re-initialization (useful for testing)
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `answer_evaluations`;
DROP TABLE IF EXISTS `interview_sessions`;
DROP TABLE IF EXISTS `questions`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `roles`;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. Roles Table
-- Purpose: Stores the predefined interview roles (e.g., Java Developer, Frontend Developer, Data Scientist)
CREATE TABLE `roles` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL UNIQUE,
    `description` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. Users Table
-- Purpose: Stores user credentials and basic account information
CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    `email` VARCHAR(100) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Questions Table
-- Purpose: Predefined list of interview questions with ideal answers for comparative scoring
CREATE TABLE `questions` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `role_id` INT NOT NULL,
    `topic` VARCHAR(100) NOT NULL,
    `difficulty` VARCHAR(20) NOT NULL, -- 'Easy', 'Medium', 'Hard'
    `question_text` TEXT NOT NULL,
    `ideal_answer` TEXT NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`role_id`) REFERENCES `roles`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Interview Sessions Table
-- Purpose: Tracks each attempt of an interview by a user for a specific job role
CREATE TABLE `interview_sessions` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `role_id` INT NOT NULL,
    `status` VARCHAR(20) NOT NULL DEFAULT 'IN_PROGRESS', -- 'IN_PROGRESS', 'COMPLETED'
    `total_score` DECIMAL(5,2) DEFAULT NULL,            -- Cumulative average of evaluated questions
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`role_id`) REFERENCES `roles`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Answer Evaluations Table
-- Purpose: Stores evaluation results for individual questions within an interview session
CREATE TABLE `answer_evaluations` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `session_id` INT NOT NULL,
    `question_id` INT NOT NULL,
    `user_answer` TEXT NOT NULL,
    `similarity_score` DECIMAL(5,2) NOT NULL,            -- Similarity score from 0.00 to 100.00
    `remark` VARCHAR(20) NOT NULL,                       -- 'Poor' (0-39), 'Average' (40-69), 'Good' (70-100)
    `evaluated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`session_id`) REFERENCES `interview_sessions`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`question_id`) REFERENCES `questions`(`id`) ON DELETE CASCADE,
    UNIQUE KEY `unique_session_question` (`session_id`, `question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Sample Insert Statements for Predefined Interview Roles
INSERT INTO `roles` (`id`, `name`, `description`) VALUES
(1, 'Java Developer', 'Evaluates core Java concepts, OOPs, Multithreading, Exception Handling, Collections, and Spring Boot basics.'),
(2, 'Frontend Developer', 'Evaluates core web technologies including HTML5, CSS3 layout techniques, modern Vanilla JavaScript (ES6+), and browser APIs.'),
(3, 'Data Scientist', 'Evaluates fundamental machine learning algorithms, statistics, probability, core Python libraries for numerical processing, and NLP concepts.');
