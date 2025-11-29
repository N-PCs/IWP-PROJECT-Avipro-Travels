-- Create database
CREATE DATABASE IF NOT EXISTS avipro_travels;
USE avipro_travels;

-- Admin users table
CREATE TABLE admin_users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    full_name VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Packages table
CREATE TABLE packages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    duration VARCHAR(100),
    destination VARCHAR(255),
    image_url VARCHAR(500),
    itinerary TEXT,
    inclusions TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bookings table
CREATE TABLE bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    package_id INT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    travel_date DATE,
    persons INT,
    message TEXT,
    status ENUM('pending', 'confirmed', 'cancelled') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (package_id) REFERENCES packages(id) ON DELETE SET NULL
);

-- Contact enquiries table
CREATE TABLE enquiries (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    subject VARCHAR(255),
    message TEXT,
    status ENUM('new', 'read', 'replied') DEFAULT 'new',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Site content table
CREATE TABLE site_content (
    id INT PRIMARY KEY AUTO_INCREMENT,
    page VARCHAR(100),
    section VARCHAR(100),
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert default admin user
INSERT INTO admin_users (username, password_hash, email, full_name) 
VALUES ('admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin@aviprotravels.com', 'Administrator');

-- Insert sample packages
INSERT INTO packages (title, description, price, duration, destination, image_url, itinerary, inclusions) VALUES
('Swiss Alps Adventure', 'Experience the breathtaking beauty of the Swiss Alps with this all-inclusive package.', 1299.00, '7 Days / 6 Nights', 'Switzerland', 'swiss-alps.jpg', 'Day 1: Arrival in Zurich...', '6 nights accommodation, Daily breakfast, All transfers, Guided tours'),
('Bali Paradise Retreat', 'Relax and rejuvenate in the tropical paradise of Bali with our luxury retreat package.', 1599.00, '10 Days / 9 Nights', 'Indonesia', 'bali-retreat.jpg', 'Day 1: Arrival in Denpasar...', '9 nights luxury villa, All meals, Spa treatments, Private transfers'),
('Japanese Cultural Tour', 'Immerse yourself in the rich culture and traditions of Japan with our guided tour.', 2199.00, '12 Days / 11 Nights', 'Japan', 'japan-tour.jpg', 'Day 1: Arrival in Tokyo...', '11 nights accommodation, Cultural experiences, All meals, Bullet train tickets');

-- Insert sample bookings
INSERT INTO bookings (package_id, name, email, phone, travel_date, persons, message, status) VALUES
(1, 'John Smith', 'john@email.com', '+1-555-123-4567', '2025-12-15', 2, 'Looking forward to this trip!', 'confirmed'),
(2, 'Sarah Johnson', 'sarah@email.com', '+1-555-234-5678', '2026-01-20', 4, 'Family vacation', 'pending'),
(3, 'Mike Davis', 'mike@email.com', '+1-555-345-6789', '2026-03-05', 1, 'Solo travel experience', 'confirmed');

-- Insert sample enquiries
INSERT INTO enquiries (name, email, subject, message) VALUES
('Robert Wilson', 'robert@email.com', 'Group Booking', 'I would like to inquire about group booking rates for 15 people.'),
('Emily Chen', 'emily@email.com', 'Custom Package', 'Do you offer custom travel packages for specific destinations?');