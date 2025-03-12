-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 12, 2025 at 04:56 PM
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
-- Database: `dbdesa`
--

-- --------------------------------------------------------

--
-- Table structure for table `pengguna`
--

CREATE TABLE `pengguna` (
  `id` int(11) NOT NULL,
  `username` varchar(80) NOT NULL,
  `password` varchar(256) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `jabatan` varchar(50) DEFAULT NULL,
  `role` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pengguna`
--

INSERT INTO `pengguna` (`id`, `username`, `password`, `nama_lengkap`, `jabatan`, `role`) VALUES
(5, 'warga3', 'scrypt:32768:8:1$NVvflGJnUnRROJ0N$51b8c2003bb87bfa10ea68a87dd223736979c15bb741eeab87619a5f28d4f1e99b3b425e8aa726665aa438df64c9c5db20d530809b3f2523134dc95e645f1fdf', 'Test User', 'Warga', 'user'),
(6, 'admin1', 'scrypt:32768:8:1$q5nDTYWoI6BhGSzs$06824dedda0ffc1cc9353d3430420e0df2433c80b60b2b0754c60ada08816227cff55eed48a006c658a90c3168115252e7ba857a0a1a38e69c0bb155ff6695bf', 'Admin1', 'admin', 'admin'),
(7, 'testuser', 'scrypt:32768:8:1$sIawXzOJozmCYQX8$5fc5c86843a54d14c08bea8258347cbba3fdd51db6faebd79b659d2422e7429621ceb46a7df6d986da29682873a144d759817d60cbe3cbcea0a1f65ea1ed851e', 'siddiq', 'Warga', 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pengguna`
--
ALTER TABLE `pengguna`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pengguna`
--
ALTER TABLE `pengguna`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
