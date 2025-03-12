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
-- Table structure for table `form_ktp`
--

CREATE TABLE `form_ktp` (
  `id` char(36) NOT NULL,
  `NIK` varchar(20) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `opsi` varchar(50) NOT NULL,
  `dokumen_path` varchar(255) DEFAULT NULL,
  `tanggal_dikeluarkan` datetime DEFAULT NULL,
  `pembuat` varchar(100) DEFAULT NULL,
  `nomor_surat` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `form_ktp`
--

INSERT INTO `form_ktp` (`id`, `NIK`, `nama_lengkap`, `opsi`, `dokumen_path`, `tanggal_dikeluarkan`, `pembuat`, `nomor_surat`) VALUES
('28e5f670-65a6-47a6-b73a-7e0796222bcd', '1234567890123456', 'John Doeaaa', 'baru', '/path/to/document.pdf', '2025-03-12 21:37:50', 'siddiq', NULL),
('3107f76b-c6d6-44b9-8589-74bc3a477227', '1234567890111123456', 'John Doeaaa', 'pergantian', '/path/to/document.pdf', '2025-03-12 22:18:29', 'siddiq', NULL),
('3f373c14-a61c-440a-9042-c136e1f22195', '12asss34567890111123', 'John Doeaaa', 'pergantian', '/path/to/document.pdf', '2025-03-12 22:18:40', 'siddiq', NULL),
('4bd6aed6-8e7a-4af3-bdd6-17ce8bd9ba4e', '1234567890123456', 'John Doeaaa', 'baru', '/path/to/document.pdf', '2025-03-12 22:15:08', 'siddiq', NULL),
('4fa751d9-edcc-4993-81d6-560c6f1c1258', '123456789011123456', 'John Doeaaa', 'pergantian', '/path/to/document.pdf', '2025-03-12 22:16:23', 'siddiq', NULL),
('5839db11-294c-4078-ae2a-c1de0f4c4bd7', '9876543210987654', 'dosssss', 'baru', '/path/to/new/document.pdf', '2025-03-12 21:47:28', 'siddiq', NULL),
('60d7feeb-a61a-4c11-b337-952fcf440abf', '1234567890123456', 'John Doeaaa', 'baru', '/path/to/document.pdf', '2025-03-12 21:40:38', 'siddiq', NULL),
('6728b2e7-f03b-40b5-8943-a725480e4db2', '1234567890123456', 'John Doeaaa', 'baru', '/path/to/document.pdf', '2025-03-12 21:40:39', 'siddiq', NULL),
('808dd09c-75f6-45e6-90ba-5b31c5fe79ee', '1234567890123456', 'John Doeaaa', 'baru', '/path/to/document.pdf', '2025-03-12 21:36:47', 'siddiq', NULL),
('8e7d91c4-6eac-4d1a-b119-af8f6f7ff70b', '1234567890123456', 'John Doeaaa', 'baru', '/path/to/document.pdf', '2025-03-12 22:15:50', 'siddiq', NULL),
('aeaa296e-b1ea-4c91-868d-d69cfbca9c3f', '1234567890123456', 'John Doeaaa', 'baru', '/path/to/document.pdf', '2025-03-12 21:36:49', 'siddiq', NULL),
('bb9e9403-acd2-4fe4-a164-55f35d79e31c', '12345678901aaa23456', 'John Doeaaa', 'pergantian', '/path/to/document.pdf', '2025-03-12 22:16:19', 'siddiq', NULL),
('bcab99ff-0faa-4590-bec2-dc397374e186', '1234567890123456', 'John Doeaaa', 'baru', '/path/to/document.pdf', '2025-03-12 21:36:48', 'siddiq', NULL),
('bdfca6af-8f72-43cd-8812-d619df15cfd9', '1234567890123456', 'John Doeaaa', 'baru', '/path/to/document.pdf', '2025-03-12 21:37:51', 'siddiq', NULL),
('ee5d15f8-e26d-42b6-80c1-f1ec5c77a8f9', '1234567890123456', 'John Doeaaa', 'baru', '/path/to/document.pdf', '2025-03-12 22:12:08', 'siddiq', NULL),
('f554c2a2-c4a9-458e-84d8-dc760ea22e21', '1234567890123456', 'John Doeaaa', 'baru', '/path/to/document.pdf', '2025-03-12 21:36:46', 'siddiq', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `form_ktp`
--
ALTER TABLE `form_ktp`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
