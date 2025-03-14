-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 14, 2025 at 03:41 AM
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
-- Table structure for table `gabungan_keluarga`
--

CREATE TABLE `gabungan_keluarga` (
  `id` int(16) NOT NULL,
  `NIK` varchar(16) NOT NULL,
  `Nomor_KK` varchar(16) DEFAULT NULL,
  `nama_lengkap` varchar(100) DEFAULT NULL,
  `Gelar_Depan` varchar(20) DEFAULT NULL,
  `Gelar_Belakang` varchar(20) DEFAULT NULL,
  `Passport_Number` varchar(20) DEFAULT NULL,
  `Tgl_Berakhir_Paspor` date DEFAULT NULL,
  `Nama_Sponsor` varchar(100) DEFAULT NULL,
  `Tipe_Sponsor` varchar(50) DEFAULT NULL,
  `Alamat_Sponsor` varchar(255) DEFAULT NULL,
  `Jenis_Kelamin` varchar(10) DEFAULT NULL,
  `Tempat_Lahir` varchar(50) DEFAULT NULL,
  `Tanggal_Lahir` date DEFAULT NULL,
  `Kewarganegaraan` varchar(50) DEFAULT NULL,
  `No_SK_Penetapan_WNI` varchar(50) DEFAULT NULL,
  `Akta_Lahir` tinyint(1) DEFAULT NULL,
  `Nomor_Akta_Kelahiran` varchar(50) DEFAULT NULL,
  `Golongan_Darah` varchar(3) DEFAULT NULL,
  `Agama` varchar(50) DEFAULT NULL,
  `Nama_Organisasi_Kepercayaan` varchar(100) DEFAULT NULL,
  `Status_Perkawinan` varchar(20) DEFAULT NULL,
  `Akta_Perkawinan` tinyint(1) DEFAULT NULL,
  `Nomor_Akta_Perkawinan` varchar(50) DEFAULT NULL,
  `Tanggal_Perkawinan` date DEFAULT NULL,
  `Akta_Cerai` tinyint(1) DEFAULT NULL,
  `Nomor_Akta_Cerai` varchar(50) DEFAULT NULL,
  `Tanggal_Perceraian` date DEFAULT NULL,
  `Status_Hubungan_Dalam_Keluarga` varchar(50) DEFAULT NULL,
  `Kelainan_Fisik_dan_Mental` varchar(100) DEFAULT NULL,
  `Penyandang_Cacat` tinyint(1) DEFAULT NULL,
  `Pendidikan_Terakhir` varchar(50) DEFAULT NULL,
  `Jenis_Pekerjaan` varchar(50) DEFAULT NULL,
  `Nomor_ITAS_ITAP` varchar(50) DEFAULT NULL,
  `Tanggal_Terbit_ITAS_ITAP` date DEFAULT NULL,
  `Tanggal_Akhir_ITAS_ITAP` date DEFAULT NULL,
  `Tempat_Datang_Pertama` varchar(100) DEFAULT NULL,
  `Tanggal_Kedatangan_Pertama` date DEFAULT NULL,
  `NIK_Ibu` int(11) DEFAULT NULL,
  `Nama_Ibu` varchar(100) DEFAULT NULL,
  `NIK_Ayah` int(11) DEFAULT NULL,
  `Nama_Ayah` varchar(100) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `kode_pos` char(5) DEFAULT NULL,
  `rt` char(3) DEFAULT NULL,
  `rw` char(3) DEFAULT NULL,
  `jumlah_anggota_keluarga` int(11) DEFAULT NULL,
  `telepon` varchar(15) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `kode_provinsi` char(2) DEFAULT NULL,
  `nama_provinsi` varchar(255) DEFAULT NULL,
  `kode_kabupaten` char(2) DEFAULT NULL,
  `nama_kabupaten` varchar(255) DEFAULT NULL,
  `kode_kecamatan` char(2) DEFAULT NULL,
  `nama_kecamatan` varchar(255) DEFAULT NULL,
  `kode_desa` char(2) DEFAULT NULL,
  `nama_desa` varchar(255) DEFAULT NULL,
  `nama_dusun` varchar(255) DEFAULT NULL,
  `alamat_luar_negeri` text DEFAULT NULL,
  `kota_luar_negeri` varchar(255) DEFAULT NULL,
  `provinsi_negara_bagian_luar_negeri` varchar(255) DEFAULT NULL,
  `negara_luar_negeri` varchar(255) DEFAULT NULL,
  `kode_pos_luar_negeri` char(10) DEFAULT NULL,
  `jumlah_anggota_keluarga_luar_negeri` varchar(3) DEFAULT NULL,
  `telepon_luar_negeri` varchar(15) DEFAULT NULL,
  `email_luar_negeri` varchar(255) DEFAULT NULL,
  `kode_negara` char(2) DEFAULT NULL,
  `nama_negara` varchar(255) DEFAULT NULL,
  `kode_perwakilan_ri` char(2) DEFAULT NULL,
  `nama_perwakilan_ri` varchar(255) DEFAULT NULL,
  `Status_Hidup_Meninggal` enum('HIDUP','MENINGGAL') DEFAULT 'HIDUP',
  `Tgl_Kematian` date DEFAULT NULL,
  `no_hp` varchar(20) NOT NULL,
  `tempat_tanggal_lahir_bapak` varchar(255) NOT NULL,
  `pekerjaan_bapak` varchar(255) NOT NULL,
  `agama_bapak` varchar(255) NOT NULL,
  `alamat_bapak` varchar(255) NOT NULL,
  `tempat_tanggal_lahir_ibu` varchar(255) NOT NULL,
  `pekerjaan_ibu` varchar(255) NOT NULL,
  `agama_ibu` varchar(255) NOT NULL,
  `alamat_ibu` varchar(255) NOT NULL,
  `nik_bapak` varchar(255) NOT NULL,
  `nama_bapak` varchar(255) NOT NULL,
  `nama_kepala_keluarga` varchar(255) NOT NULL,
  `created_by` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gabungan_keluarga`
--

INSERT INTO `gabungan_keluarga` (`id`, `NIK`, `Nomor_KK`, `nama_lengkap`, `Gelar_Depan`, `Gelar_Belakang`, `Passport_Number`, `Tgl_Berakhir_Paspor`, `Nama_Sponsor`, `Tipe_Sponsor`, `Alamat_Sponsor`, `Jenis_Kelamin`, `Tempat_Lahir`, `Tanggal_Lahir`, `Kewarganegaraan`, `No_SK_Penetapan_WNI`, `Akta_Lahir`, `Nomor_Akta_Kelahiran`, `Golongan_Darah`, `Agama`, `Nama_Organisasi_Kepercayaan`, `Status_Perkawinan`, `Akta_Perkawinan`, `Nomor_Akta_Perkawinan`, `Tanggal_Perkawinan`, `Akta_Cerai`, `Nomor_Akta_Cerai`, `Tanggal_Perceraian`, `Status_Hubungan_Dalam_Keluarga`, `Kelainan_Fisik_dan_Mental`, `Penyandang_Cacat`, `Pendidikan_Terakhir`, `Jenis_Pekerjaan`, `Nomor_ITAS_ITAP`, `Tanggal_Terbit_ITAS_ITAP`, `Tanggal_Akhir_ITAS_ITAP`, `Tempat_Datang_Pertama`, `Tanggal_Kedatangan_Pertama`, `NIK_Ibu`, `Nama_Ibu`, `NIK_Ayah`, `Nama_Ayah`, `alamat`, `kode_pos`, `rt`, `rw`, `jumlah_anggota_keluarga`, `telepon`, `email`, `kode_provinsi`, `nama_provinsi`, `kode_kabupaten`, `nama_kabupaten`, `kode_kecamatan`, `nama_kecamatan`, `kode_desa`, `nama_desa`, `nama_dusun`, `alamat_luar_negeri`, `kota_luar_negeri`, `provinsi_negara_bagian_luar_negeri`, `negara_luar_negeri`, `kode_pos_luar_negeri`, `jumlah_anggota_keluarga_luar_negeri`, `telepon_luar_negeri`, `email_luar_negeri`, `kode_negara`, `nama_negara`, `kode_perwakilan_ri`, `nama_perwakilan_ri`, `Status_Hidup_Meninggal`, `Tgl_Kematian`, `no_hp`, `tempat_tanggal_lahir_bapak`, `pekerjaan_bapak`, `agama_bapak`, `alamat_bapak`, `tempat_tanggal_lahir_ibu`, `pekerjaan_ibu`, `agama_ibu`, `alamat_ibu`, `nik_bapak`, `nama_bapak`, `nama_kepala_keluarga`, `created_by`) VALUES
(7, '1234567890123457', '6543210987654321', 'Maulana Malik', 'Dr.', 'M.Sc', 'A12345678', '2030-12-31', 'PT. Maju Jaya', 'Perusahaan', 'Jl. Merdeka No. 123, Jakarta', 'Laki-Laki', 'Jakarta', '1990-05-15', 'Indonesia', 'SK12345678', 1, 'AKT123456', 'O', 'Islam', 'NU', 'Menikah', 1, 'AKP123456', '2015-08-20', 0, NULL, NULL, 'Kepala Keluarga', NULL, 0, 'S1', 'Pegawai Negeri', 'ITAS123456', '2025-06-10', '2030-06-10', 'Bandung', '2010-07-15', 2147483647, 'Siti Aminah', 2147483647, 'Samsul Bahri', 'Jl. Anggrek No. 45, Surabaya', '60123', '007', '002', 4, '081234567890', 'budi.santoso@email.com', '01', 'Jawa Timur', '02', 'Surabaya', '03', 'Tegalsari', '04', 'Tegalsari', 'Dusun Indah', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ID', 'Indonesia', '05', 'KJRI Kuala Lumpur', 'HIDUP', NULL, '081298765432', 'Semarang, 1965-02-10', 'Wiraswasta', 'Islam', 'Jl. Mawar No. 12, Semarang', 'Surabaya, 1970-06-05', 'Ibu Rumah Tangga', 'Islam', 'Jl. Mawar No. 12, Semarang', '4567890123456789', 'Samsul Bahri', 'Maulana Malik', 'maulanamalik'),
(8, '1234567890123456', '6543210987654321', 'Yusuf Atha', 'Dr.', 'M.Sc', 'A12345678', '2030-12-31', 'PT. Maju Jaya', 'Perusahaan', 'Jl. Merdeka No. 123, Jakarta', 'Laki-Laki', 'Jakarta', '1990-05-15', 'Indonesia', 'SK12345678', 1, 'AKT123456', 'O', 'Islam', 'NU', 'Menikah', 1, 'AKP123456', '2015-08-20', 0, NULL, NULL, 'Kepala Keluarga', NULL, 0, 'S3', 'Pegawai Negeri', 'ITAS123456', '2025-06-10', '2030-06-10', 'Bandung', '2010-07-15', 2147483647, 'Siti Aminah', 2147483647, 'Samsul Bahri', 'Jl. Anggrek No. 45, Surabaya', '60123', '007', '002', 4, '081234567890', 'budi.santoso@email.com', '01', 'Jawa Timur', '02', 'Surabaya', '03', 'Tegalsari', '04', 'Tegalsari', 'Dusun Indah', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ID', 'Indonesia', '05', 'KJRI Kuala Lumpur', 'HIDUP', NULL, '081298765432', 'Semarang, 1965-02-10', 'Wiraswasta', 'Islam', 'Jl. Mawar No. 12, Semarang', 'Surabaya, 1970-06-05', 'Ibu Rumah Tangga', 'Islam', 'Jl. Mawar No. 12, Semarang', '1234567890123457', 'Maulana Malik', 'Maulana Malik', 'maulanamalik'),
(9, '9876543210987654', '1234567890123456', 'Rizky Fadillah', 'Prof.', 'Ph.D', 'B98765432', '2032-07-20', 'CV. Sukses Abadi', 'Individu', 'Jl. Diponegoro No. 99, Bandung', 'Laki-Laki', 'Bandung', '1985-11-25', 'Indonesia', 'SK87654321', 1, 'AKT654321', 'A', 'Kristen', 'Gereja Bethel', 'Duda', 1, 'AKP987654', '2012-09-18', 1, 'AC123456', '2019-03-21', 'Ayah', NULL, 0, 'S3', 'Dosen', 'ITAP987654', '2027-01-05', '2032-01-05', 'Jakarta', '2008-05-10', 2147483647, 'Maria Elisabeth', 2147483647, 'Johannes Haryanto', 'Jl. Kenanga No. 88, Yogyakarta', '55221', '005', '001', 3, '082134567890', 'rizky.fadillah@email.com', '03', 'DI Yogyakarta', '04', 'Sleman', '05', 'Depok', '06', 'Condongcatur', 'Dusun Sejahtera', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ID', 'Indonesia', '07', 'KBRI Tokyo', 'HIDUP', NULL, '082198765432', 'Semarang, 1960-12-15', 'Pengusaha', 'Kristen', 'Jl. Cemara No. 7, Semarang', 'Surabaya, 1965-09-30', 'Guru', 'Kristen', 'Jl. Cemara No. 7, Semarang', '7890123456789012', 'Johannes Haryanto', 'Rizky Fadillah', 'yuswanyuswan'),
(10, '9876543210987655', '1234567890123456', 'Sebastian', 'Prof.', 'Ph.D', 'B98765432', '2032-07-20', 'CV. Sukses Abadi', 'Individu', 'Jl. Diponegoro No. 99, Bandung', 'Laki-Laki', 'Bandung', '1985-11-25', 'Indonesia', 'SK87654321', 1, 'AKT654321', 'A', 'Kristen', 'Gereja Bethel', 'Duda', 1, 'AKP987654', '2012-09-18', 1, 'AC123456', '2019-03-21', 'Ayah', NULL, 0, 'S2', 'Dosen', 'ITAP987654', '2027-01-05', '2032-01-05', 'Jakarta', '2008-05-10', 2147483647, 'Maria Elisabeth', 2147483647, 'Johannes Haryanto', 'Jl. Kenanga No. 88, Yogyakarta', '55221', '005', '001', 3, '082134567890', 'rizky.fadillah@email.com', '03', 'DI Yogyakarta', '04', 'Sleman', '05', 'Depok', '06', 'Condongcatur', 'Dusun Sejahtera', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ID', 'Indonesia', '07', 'KBRI Tokyo', 'HIDUP', NULL, '082198765432', 'Semarang, 1960-12-15', 'Pengusaha', 'Kristen', 'Jl. Cemara No. 7, Semarang', 'Surabaya, 1965-09-30', 'Guru', 'Kristen', 'Jl. Cemara No. 7, Semarang', '7890123456789012', 'Rizky Fadillah', 'Rizky Fadillah', 'yuswanyuswan');

-- --------------------------------------------------------

--
-- Table structure for table `pengguna`
--

CREATE TABLE `pengguna` (
  `id` int(11) NOT NULL,
  `username` varchar(80) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `role` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pengguna`
--

INSERT INTO `pengguna` (`id`, `username`, `password`, `nama_lengkap`, `role`) VALUES
(17, 'maulanamalik', 'scrypt:32768:8:1$3TcKli7awbAr3JYT$9eb1f9dee219dfff22b96c3daaad09ed31108629d740c927b603d2fc4b03bc6c8d4485e957ae4e23c0105292ad8d4848a75f9345c940b02b05ed09a7c48314c5', 'Maulana Malik', 'user'),
(18, 'yuswanyuswan', 'scrypt:32768:8:1$seW2kUP1b4MJCDqI$ae470e210950e211ca6115e78d2410715b9ae4c7bcb14a8102960cd660fc8c796fd52497876bffe55ff8c9c656c43cd1b966df6f9ba42cc4a7f5af5017e25714', 'Rizky Fadillah', 'user'),
(19, 'rakhamaulana', 'scrypt:32768:8:1$kk59q0kR6zM0JBiE$97e2998ce1feaeb307afede0c3675c5f71be09929b4e6605e75963603245ac2ee62f83ff9f4509b0dea8db354a054a97144448b172d75e95bc3ce4f3cf6ae792', 'Rakha Maulana', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `gabungan_keluarga`
--
ALTER TABLE `gabungan_keluarga`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_nik` (`NIK`);

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
-- AUTO_INCREMENT for table `gabungan_keluarga`
--
ALTER TABLE `gabungan_keluarga`
  MODIFY `id` int(16) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `pengguna`
--
ALTER TABLE `pengguna`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
