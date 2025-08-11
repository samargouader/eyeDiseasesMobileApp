-- OculoCheck Database Setup Script
-- This script creates the database and tables for the OculoCheck mobile app
-- Run this script in phpMyAdmin or MySQL command line

-- Create the database
CREATE DATABASE IF NOT EXISTS oculocheck CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Use the database
USE oculocheck;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_users_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tests table
CREATE TABLE IF NOT EXISTS tests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    imagePath TEXT NOT NULL,
    result VARCHAR(50) NOT NULL,
    confidence DECIMAL(5,4) NOT NULL,
    userId INT NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_tests_user_id (userId),
    INDEX idx_tests_created_at (createdAt),
    INDEX idx_tests_result (result)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert sample data (optional)
-- Uncomment the following lines if you want to add sample data

/*
-- Sample user
INSERT INTO users (name, lastName, age) VALUES 
('John', 'Doe', 35),
('Jane', 'Smith', 28),
('Dr. Michael', 'Johnson', 42);

-- Sample tests
INSERT INTO tests (imagePath, result, confidence, userId) VALUES 
('/path/to/image1.jpg', 'Normal', 0.95, 1),
('/path/to/image2.jpg', 'Cataract', 0.87, 1),
('/path/to/image3.jpg', 'Glaucoma', 0.92, 2),
('/path/to/image4.jpg', 'Diabetic Retinopathy', 0.78, 3);
*/

-- Show table structure
DESCRIBE users;
DESCRIBE tests;

-- Show sample data (if inserted)
-- SELECT * FROM users;
-- SELECT * FROM tests;
