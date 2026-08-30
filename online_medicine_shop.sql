-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 25, 2026 at 07:18 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `online_medicine_shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `medicine_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `added_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category_type` enum('liquid','solid') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `category_type`, `created_at`) VALUES
(1, 'Aspirin Genre', 'solid', '2026-05-11 06:12:54'),
(2, 'Paracetamol Genre', 'solid', '2026-05-11 06:12:54'),
(3, 'Cough Syrup Genre', 'liquid', '2026-05-11 06:12:54'),
(4, 'Antibiotic Genre', 'solid', '2026-05-11 06:12:54'),
(5, 'Vitamin Syrup Genre', 'liquid', '2026-05-11 06:12:54'),
(6, 'Pain Relief Genre', 'solid', '2026-05-11 06:12:54'),
(7, 'Antacid Genre', 'liquid', '2026-05-11 06:12:54'),
(8, 'Diabetes Care', 'liquid', '2026-05-11 06:12:54');

-- --------------------------------------------------------

--
-- Table structure for table `medicines`
--

CREATE TABLE `medicines` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `category_id` int(11) NOT NULL,
  `vendor_name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `availability` int(11) NOT NULL DEFAULT 0,
  `description` text DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `medicines`
--

INSERT INTO `medicines` (`id`, `name`, `category_id`, `vendor_name`, `price`, `availability`, `description`, `image_path`, `created_at`) VALUES
(1, 'Aspirin 100mg', 1, 'Square Pharmaceuticals', 5.50, 100, 'Pain reliever and fever reducer', 'aspirin.jpg', '2026-05-11 06:12:54'),
(2, 'Aspirin 500mg', 1, 'Beximco Pharma', 8.00, 80, 'Extra strength pain relief', 'aspirin500.jpg', '2026-05-11 06:12:54'),
(3, 'Paracetamol 500mg', 2, 'Beximco Pharma', 3.00, 200, 'Effective for headache and fever', 'paracetamol.jpg', '2026-05-11 06:12:54'),
(4, 'Paracetamol 650mg', 2, 'Renata Limited', 4.50, 150, 'Extra strength paracetamol', 'paracetamol650.jpg', '2026-05-11 06:12:54'),
(5, 'Cough Syrup 100ml', 3, 'Renata Limited', 85.00, 50, 'Relief from dry cough', 'cough_syrup.jpg', '2026-05-11 06:12:54'),
(7, 'Amoxicillin 250mg', 4, 'Incepta Pharma', 120.00, 75, 'Antibiotic for bacterial infections', 'amoxicillin.jpg', '2026-05-11 06:12:54'),
(8, 'Azithromycin 500mg', 4, 'ACI Limited', 180.00, 60, 'Broad spectrum antibiotic', 'azithromycin.jpg', '2026-05-11 06:12:54'),
(9, 'Multivitamin Syrup', 5, 'ACI Limited', 150.00, 60, 'Daily vitamin supplement', 'multivitamin.jpg', '2026-05-11 06:12:54'),
(10, 'Vitamin D3 Syrup', 5, 'Healthcare Pharma', 200.00, 45, 'Essential vitamin D supplement', 'vitd3.jpg', '2026-05-11 06:12:54'),
(11, 'Ibuprofen 400mg', 6, 'Square Pharmaceuticals', 7.50, 120, 'Anti-inflammatory pain relief', 'ibuprofen.jpg', '2026-05-11 06:12:54'),
(12, 'Diclofenac 50mg', 6, 'Beximco Pharma', 6.00, 90, 'Strong pain and inflammation relief', 'diclofenac.jpg', '2026-05-11 06:12:54'),
(13, 'Antacid Suspension', 7, 'Renata Limited', 95.00, 55, 'Quick relief from acidity', 'antacid.jpg', '2026-05-11 06:12:54'),
(14, 'Omeprazole 20mg', 7, 'Incepta Pharma', 4.50, 100, 'Long-lasting acid relief', 'medicine_1779112452_6131.png', '2026-05-11 06:12:54');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `shipping_address` text NOT NULL,
  `status` enum('pending','accepted','rejected') DEFAULT 'pending',
  `payment_method` varchar(50) DEFAULT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `total_amount`, `shipping_address`, `status`, `payment_method`, `order_date`) VALUES
(11, 2, 188.00, 'Uttara, Dhaka', 'accepted', 'Nagad', '2026-05-18 12:43:29'),
(12, 2, 191.00, 'Dhanmondi, Dhaka', 'pending', 'Cash Delivery', '2026-05-18 12:43:36'),
(13, 2, 185.00, 'Mirpur, Dhaka', 'pending', 'bKash', '2026-05-18 12:44:00'),
(14, 2, 132.00, 'Uttara, Dhaka', 'accepted', 'Nagad', '2026-05-18 12:44:45'),
(15, 2, 132.00, 'Uttara, Dhaka', 'accepted', 'Nagad', '2026-05-18 12:45:02'),
(16, 2, 91.00, 'Mirpur, Dhaka', 'accepted', 'bKash', '2026-05-18 12:45:10'),
(17, 2, 199.50, 'hjbjnm', 'accepted', 'bKash', '2026-05-18 15:38:18');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `medicine_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `medicine_id`, `quantity`, `unit_price`) VALUES
(31, 11, 7, 1, 120.00),
(32, 11, 12, 2, 6.00),
(33, 11, 13, 1, 95.00),
(34, 12, 3, 2, 3.00),
(35, 12, 5, 1, 85.00),
(36, 12, 11, 1, 7.50),
(39, 14, 7, 1, 120.00),
(40, 14, 12, 2, 6.00),
(41, 15, 7, 1, 120.00),
(42, 15, 12, 2, 6.00),
(43, 16, 3, 2, 3.00),
(44, 16, 5, 1, 85.00),
(45, 17, 2, 1, 8.00),
(46, 17, 12, 1, 6.00),
(47, 17, 8, 1, 180.00),
(48, 17, 1, 1, 5.50);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `order_id`, `amount`, `payment_method`, `transaction_id`, `payment_date`) VALUES
(9, 11, 188.00, 'Nagad', 'NAGAD-TEST-002', '2026-05-18 12:43:29'),
(10, 12, 191.00, 'Cash Delivery', 'COD-TEST-001', '2026-05-18 12:43:36'),
(11, 14, 132.00, 'Nagad', 'NAGAD-TEST-002', '2026-05-18 12:44:45'),
(12, 15, 132.00, 'Nagad', 'NAGAD-TEST-002', '2026-05-18 12:45:02'),
(13, 16, 91.00, 'bKash', 'BKASH-TEST-001', '2026-05-18 12:45:10'),
(14, 17, 199.50, 'bKash', 'TXN1779118698639', '2026-05-18 15:38:18');

-- --------------------------------------------------------

--
-- Table structure for table `remember_tokens`
--

CREATE TABLE `remember_tokens` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','customer') NOT NULL DEFAULT 'customer',
  `profile_picture` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `role`, `profile_picture`, `address`, `phone`, `created_at`) VALUES
(1, 'Anirban', 'admin@medicine.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin', NULL, 'Dhaka, Bangladesh', '01711111111', '2026-05-11 06:12:54'),
(2, 'John Doe', 'customer@test.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'customer', NULL, 'Chittagong, Bangladesh', '01811111111', '2026-05-11 00:12:54'),
(3, 'Admin User', 'ad@medicine.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin', NULL, 'Dhaka, Bangladesh', '01711111111', '2026-05-11 00:12:54'),
(5, 'abc', 'abc@gmail.com', '$2y$10$sMuzS7oH3jWGzrOItEWXT.FD9LTI9bc5L3qGc7006mvzetrelRGby', 'customer', NULL, '76rutfghvbn8iyiuhkj', '12345678900', '2026-05-19 10:55:05');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_cart_item` (`user_id`,`medicine_id`),
  ADD KEY `medicine_id` (`medicine_id`),
  ADD KEY `idx_user` (`user_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_type` (`category_type`);

--
-- Indexes for table `medicines`
--
ALTER TABLE `medicines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_category` (`category_id`),
  ADD KEY `idx_vendor` (`vendor_name`),
  ADD KEY `idx_name` (`name`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `medicine_id` (`medicine_id`),
  ADD KEY `idx_order` (`order_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order` (`order_id`);

--
-- Indexes for table `remember_tokens`
--
ALTER TABLE `remember_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_token` (`token`),
  ADD KEY `idx_user` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_role` (`role`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `medicines`
--
ALTER TABLE `medicines`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `remember_tokens`
--
ALTER TABLE `remember_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`medicine_id`) REFERENCES `medicines` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `medicines`
--
ALTER TABLE `medicines`
  ADD CONSTRAINT `medicines_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`medicine_id`) REFERENCES `medicines` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `remember_tokens`
--
ALTER TABLE `remember_tokens`
  ADD CONSTRAINT `remember_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
