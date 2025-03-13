-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 13, 2025 at 05:34 AM
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
-- Database: `dbdesa2`
--

-- --------------------------------------------------------

--
-- Table structure for table `daftar_surat_kematian`
--

CREATE TABLE `daftar_surat_kematian` (
  `Id` int(11) NOT NULL,
  `Tanggal_Terbit` date DEFAULT NULL,
  `Nomor_Surat` varchar(50) DEFAULT NULL,
  `Penyimpanan` varchar(255) DEFAULT NULL,
  `NIK_Terlapor` varchar(20) DEFAULT NULL,
  `Nama_Terlapor` varchar(255) DEFAULT NULL,
  `Nama_Petugas` varchar(100) DEFAULT NULL,
  `Nama_Kades` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `daftar_surat_kematian`
--

INSERT INTO `daftar_surat_kematian` (`Id`, `Tanggal_Terbit`, `Nomor_Surat`, `Penyimpanan`, `NIK_Terlapor`, `Nama_Terlapor`, `Nama_Petugas`, `Nama_Kades`) VALUES
(10, '2024-07-24', '400/001/Pem', 'D:\\Kuliah\\Poltek SSN\\_TINGKAT 3_\\SEMESTER 6\\Pemrograman Desktop\\Surat_Kematian_1234567890123456.pdf', '1234567890123456', 'Budi Santoso', 'Mas Edi', ''),
(11, '2024-11-20', 'dsad', 'C:\\Users\\siddiq odiq\\Downloads\\tele\\Surat_Kematian_1234567890123456.pdf', '1234567890123456', 'SYAFIRA NOVIANI', 'ads', ''),
(12, '2024-11-20', 'dqqw', 'C:\\Users\\siddiq odiq\\Downloads\\tele\\Surat_Kematian_1234567890123456.pdf', '1234567890123456', 'SYAFIRA NOVIANI', 'weqw', ''),
(13, '2024-12-09', '400/002/Pem', 'C:\\Users\\rival\\Downloads\\Surat_Kematian_1312312312312312.pdf', '1312312312312312', 'Reynold Alexander', 'Aep', ''),
(14, '2024-12-09', 'pem/003', 'C:\\Users\\rival\\Downloads\\Surat_Kematian_1234567890123456.pdf', '1234567890123456', 'Syafira Noviani', 'fina', ''),
(15, '2025-03-12', 'Desa/SKK/411', 'Laptop Rival', '1234567890987654', 'John Doe', 'Deden', 'Khabib'),
(16, '2025-03-12', 'Desa/SKK/412', 'Laptop Rival', '1234567890123460', 'Peter Doe', 'Jajang', 'Didi Kempot'),
(17, '2025-03-13', 'Desa/SKK/413', 'Laptop Rival', '1234567890123458', 'John Doe Jr.', 'Ngadimin', 'Dadang Serdadu');

-- --------------------------------------------------------

--
-- Table structure for table `detail_kematian`
--

CREATE TABLE `detail_kematian` (
  `Id` int(20) NOT NULL,
  `NIK` varchar(16) NOT NULL,
  `Tgl_Kematian` date NOT NULL,
  `Jam_Kematian` time NOT NULL,
  `Lokasi_Kematian` varchar(255) NOT NULL,
  `Penyebab_Kematian` varchar(255) NOT NULL,
  `Nama_Pelapor` varchar(255) NOT NULL,
  `Hubungan_dengan_Terlapor` varchar(255) NOT NULL,
  `Jenis` enum('Surat','Non-Surat') NOT NULL DEFAULT 'Surat'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_kematian`
--

INSERT INTO `detail_kematian` (`Id`, `NIK`, `Tgl_Kematian`, `Jam_Kematian`, `Lokasi_Kematian`, `Penyebab_Kematian`, `Nama_Pelapor`, `Hubungan_dengan_Terlapor`, `Jenis`) VALUES
(1, '123124213124213', '2025-03-12', '00:00:00', '', 'eweqe', '', '', 'Surat'),
(2, '1234567890123456', '2024-03-01', '00:00:00', '', 'Sakit', '', '', 'Surat'),
(3, '1234567890123456', '2025-03-04', '00:00:00', '', 'Patah hati', '', '', 'Non-Surat'),
(4, '1234567890123456', '2024-03-05', '14:30:00', '', 'Sakit', '', '', 'Surat'),
(5, '1234567890123459', '2024-07-07', '14:30:00', 'Bidar Alam', 'Sakit', '', 'Pacar', 'Surat'),
(6, '1234567890', '2024-07-07', '14:30:00', 'Bidar Alam', 'Sakit', '', 'Pacar', 'Surat'),
(7, '12345678904444', '2024-08-08', '15:30:00', 'Bidar Alam', 'Sakit', 'Test User', 'Pacar', 'Surat'),
(8, '1234567890987654', '2024-09-09', '10:00:00', 'Empang', 'Tenggelam', 'Test User', 'Musuh Bebuyutan', 'Non-Surat'),
(9, '1234567890123460', '2024-10-10', '00:00:00', 'Kandang Ayam', 'Dipatok Ayam', 'Rival Achmad', 'Supplier telur', 'Surat'),
(10, '1234567890123458', '2024-12-12', '06:00:00', 'Sampataloka', 'Tersedak melon', 'Kai Cenat', 'Teman angkatan', 'Surat');

-- --------------------------------------------------------

--
-- Table structure for table `gabungan_keluarga`
--

CREATE TABLE `gabungan_keluarga` (
  `NIK` char(16) NOT NULL,
  `Nomor_KK` varchar(16) DEFAULT NULL,
  `Nama_Lengkap` varchar(100) DEFAULT NULL,
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
  `NIK_Ibu` char(16) DEFAULT NULL,
  `Nama_Ibu` varchar(100) DEFAULT NULL,
  `NIK_Ayah` char(16) DEFAULT NULL,
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
  `nama_kepala_keluarga` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gabungan_keluarga`
--

INSERT INTO `gabungan_keluarga` (`NIK`, `Nomor_KK`, `Nama_Lengkap`, `Gelar_Depan`, `Gelar_Belakang`, `Passport_Number`, `Tgl_Berakhir_Paspor`, `Nama_Sponsor`, `Tipe_Sponsor`, `Alamat_Sponsor`, `Jenis_Kelamin`, `Tempat_Lahir`, `Tanggal_Lahir`, `Kewarganegaraan`, `No_SK_Penetapan_WNI`, `Akta_Lahir`, `Nomor_Akta_Kelahiran`, `Golongan_Darah`, `Agama`, `Nama_Organisasi_Kepercayaan`, `Status_Perkawinan`, `Akta_Perkawinan`, `Nomor_Akta_Perkawinan`, `Tanggal_Perkawinan`, `Akta_Cerai`, `Nomor_Akta_Cerai`, `Tanggal_Perceraian`, `Status_Hubungan_Dalam_Keluarga`, `Kelainan_Fisik_dan_Mental`, `Penyandang_Cacat`, `Pendidikan_Terakhir`, `Jenis_Pekerjaan`, `Nomor_ITAS_ITAP`, `Tanggal_Terbit_ITAS_ITAP`, `Tanggal_Akhir_ITAS_ITAP`, `Tempat_Datang_Pertama`, `Tanggal_Kedatangan_Pertama`, `NIK_Ibu`, `Nama_Ibu`, `NIK_Ayah`, `Nama_Ayah`, `alamat`, `kode_pos`, `rt`, `rw`, `jumlah_anggota_keluarga`, `telepon`, `email`, `kode_provinsi`, `nama_provinsi`, `kode_kabupaten`, `nama_kabupaten`, `kode_kecamatan`, `nama_kecamatan`, `kode_desa`, `nama_desa`, `nama_dusun`, `alamat_luar_negeri`, `kota_luar_negeri`, `provinsi_negara_bagian_luar_negeri`, `negara_luar_negeri`, `kode_pos_luar_negeri`, `jumlah_anggota_keluarga_luar_negeri`, `telepon_luar_negeri`, `email_luar_negeri`, `kode_negara`, `nama_negara`, `kode_perwakilan_ri`, `nama_perwakilan_ri`, `Status_Hidup_Meninggal`, `Tgl_Kematian`, `no_hp`, `tempat_tanggal_lahir_bapak`, `pekerjaan_bapak`, `agama_bapak`, `alamat_bapak`, `tempat_tanggal_lahir_ibu`, `pekerjaan_ibu`, `agama_ibu`, `alamat_ibu`, `nik_bapak`, `nama_bapak`, `nama_kepala_keluarga`) VALUES
('', '2312312542534121', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'HIDUP', NULL, '', '', '', '', '', '', '', '', '', '', '', ''),
('1103160408030001', '1103160408030003', 'Siddiq', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Laki-laki', 'aceh', '2024-11-20', 'Aceh', NULL, NULL, NULL, NULL, 'islam', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Gam', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Idi', '12345', '111', '112', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MENINGGAL', '2025-03-10', '213', '', '', '', '', '', '', '', '', '', '', ''),
('1231243242353532', '1234123412341235', 'fazal', 'tess', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'HIDUP', '2025-03-10', '', '', '', '', '', '', '', '', '', '', '', ''),
('1232132144', '1234123412341235', 'Agus', 'asdad', 'sada', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', ''),
('1234123412341235', '1234123412341235', 'Rakha Maulana', 'glr_dpn', 'glr_blkg', 'pasport_number', '2024-07-24', 'nama_sponsor', 'tipe_sponsor', 'alamat_sponsor', 'Laki-laki', 'tempat_lahir', '2024-07-24', 'kewarganegaraan', 'no sk penetapan wni', 1, 'nomor akta kelahiran', 'gol', 'Islam', 'nama organisasi', 'status kawin', 1, 'nomor akta', '2024-07-24', 1, 'nomor akta ', '2024-07-24', 'status hubungan', 'kelainan fisik', 1, 'pendidikan terakhirr', 'jneis pekerjaan', 'nomor itas', '2024-07-24', '2024-07-24', 'tempat datang', '2024-07-24', '1234567812345678', 'nama ibu', '1234567887654321', 'nama ayah', 'Jalan Riau 8', '16120', '001', '001', 5, '085156559292', 'dreamwarior0@gmail.com', '32', 'Jawa Barat', '01', 'Kabupaten Bogor', '11', 'Kecamatan Ciseeng', '11', 'Kelurahan CIBEUTEUNG MUARA', 'Ciseeng', 'alamat ln', 'kota ln', 'provinsi ln', 'negara ln', '1234', '1', '56559292', 'dreamwarior0@gmail.com', '11', 'negara ln', '12', 'nama perwakilan', 'HIDUP', NULL, '', '', '', '', '', '', '', '', '', '', '', ''),
('1234214', '1234123412341235', 'fazal', 'tess', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', ''),
('1234567890123456', '1234567890123456', 'Syafira Noviani', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Perempuan', 'Bogor', '2007-07-12', 'Indonesia', NULL, NULL, NULL, NULL, 'Islam', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Belum/Tidak Bekerja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Kp. Cib. Muara  RT.001/003  Ds Cibeuteung Muara Ke.', '16120', '001', '003', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MENINGGAL', '2024-12-09', '082282900655', '', '', '', '', '', '', '', '', '', '', ''),
('1234567890123458', '1234567890123458', 'John Doe Jr.', NULL, NULL, 'C12345678', '2023-10-31', 'John Doe', 'Orang Tua', 'Jl. Merdeka No. 123', 'Laki-laki', 'Bandung', '2000-11-25', 'Indonesia', 'SK1234567892', 1, 'AK1234567892', 'O', 'Islam', NULL, 'Belum Menikah', 0, NULL, NULL, 0, NULL, NULL, 'Anak', 'Tidak Ada', 0, 'SMA', 'Pelajar', 'ITAS1234567892', '2020-01-01', '2025-01-01', 'Bandung', '2020-01-01', '1234567890123457', 'Jane Doe', '1234567890123456', 'John Doe', 'Jl. Merdeka No. 123', '12345', '001', '001', 4, '081234567892', 'john.doe.jr@example.com', 'JK', 'Jakarta', '01', 'Jakarta Pusat', '01', 'Gambir', '01', 'Gambir', 'Gambir', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ID', 'Indonesia', 'RI', 'Indonesia', 'MENINGGAL', '2024-12-12', '081234567892', 'Bandung, 1975-05-15', 'Pegawai Negeri', 'Islam', 'Jl. Merdeka No. 123', 'Bandung, 1978-10-28', 'Ibu Rumah Tangga', 'Islam', 'Jl. Merdeka No. 123', '1234567890123456', 'John Doe', ''),
('1234567890123459', '1234567890123459', 'Mary Doe', NULL, NULL, 'D12345678', '2022-09-30', 'Jane Doe', 'Orang Tua', 'Jl. Merdeka No. 123', 'Perempuan', 'Medan', '2002-03-30', 'Indonesia', 'SK1234567893', 1, 'AK1234567893', 'AB', 'Islam', NULL, 'Belum Menikah', 0, NULL, NULL, 0, NULL, NULL, 'Anak', 'Tidak Ada', 0, 'SMA', 'Pelajar', 'ITAS1234567893', '2020-01-01', '2025-01-01', 'Medan', '2020-01-01', '1234567890123457', 'Jane Doe', '1234567890123456', 'John Doe', 'Jl. Merdeka No. 123', '12345', '001', '001', 4, '081234567893', 'mary.doe@example.com', 'JK', 'Jakarta', '01', 'Jakarta Pusat', '01', 'Gambir', '01', 'Gambir', 'Gambir', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ID', 'Indonesia', 'RI', 'Indonesia', 'HIDUP', NULL, '081234567893', 'Medan, 1976-06-16', 'Pegawai Negeri', 'Islam', 'Jl. Merdeka No. 123', 'Medan, 1979-11-29', 'Ibu Rumah Tangga', 'Islam', 'Jl. Merdeka No. 123', '1234567890123456', 'John Doe', ''),
('1234567890123460', '1234567890123460', 'Peter Doe', NULL, NULL, 'E12345678', '2021-08-31', 'John Doe', 'Orang Tua', 'Jl. Merdeka No. 123', 'Laki-laki', 'Yogyakarta', '2004-07-05', 'Indonesia', 'SK1234567894', 1, 'AK1234567894', 'B', 'Islam', NULL, 'Belum Menikah', 0, NULL, NULL, 0, NULL, NULL, 'Anak', 'Tidak Ada', 0, 'SMP', 'Pelajar', 'ITAS1234567894', '2020-01-01', '2025-01-01', 'Yogyakarta', '2020-01-01', '1234567890123457', 'Jane Doe', '1234567890123456', 'John Doe', 'Jl. Merdeka No. 123', '12345', '001', '001', 4, '081234567894', 'peter.doe@example.com', 'JK', 'Jakarta', '01', 'Jakarta Pusat', '01', 'Gambir', '01', 'Gambir', 'Gambir', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ID', 'Indonesia', 'RI', 'Indonesia', 'MENINGGAL', '2024-11-11', '081234567894', 'Yogyakarta, 1977-07-17', 'Pegawai Negeri', 'Islam', 'Jl. Merdeka No. 123', 'Yogyakarta, 1980-12-30', 'Ibu Rumah Tangga', 'Islam', 'Jl. Merdeka No. 123', '1234567890123456', 'John Doe', ''),
('1234567890987654', '1234567890123456', 'John Doe', 'Dr.', 'M.Sc.', 'A12345678', '2025-12-31', 'Jane Doe', 'Orang Tua', 'Jl. Merdeka No. 123', 'Laki-laki', 'Jakarta', '1980-05-15', 'Indonesia', 'SK1234567890', 1, 'AK1234567890', 'A', 'Islam', NULL, 'Menikah', 1, 'AKP1234567890', '2005-06-20', 0, NULL, NULL, 'Anak', 'Tidak Ada', 0, 'S1', 'Pegawai Negeri', 'ITAS1234567890', '2020-01-01', '2025-01-01', 'Jakarta', '2020-01-01', '1234567890123457', 'Jane Doe', '1234567890123458', 'John Doe Sr.', 'Jl. Merdeka No. 123', '12345', '001', '001', 4, '081234567890', 'john.doe@example.com', 'JK', 'Jakarta', '01', 'Jakarta Pusat', '01', 'Gambir', '01', 'Gambir', 'Gambir', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ID', 'Indonesia', 'RI', 'Indonesia', 'MENINGGAL', '2024-09-09', '081234567890', 'Jakarta, 1955-03-10', 'Pegawai Negeri', 'Islam', 'Jl. Merdeka No. 123', 'Jakarta, 1958-07-22', 'Ibu Rumah Tangga', 'Islam', 'Jl. Merdeka No. 123', '1234567890123458', 'John Doe Sr.', ''),
('1324567890123456', '1234123412341236', 'nama_lengkap', 'gelar_depan', 'gelar_belakang', 'passpor number', '2024-07-01', 'nama_sponsor', 'tipe_sponsor', 'alamat_sponsor', 'Laki-laki', 'tempat_lahir', '2024-07-03', 'WNI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'HIDUP', NULL, '', '', '', '', '', '', '', '', '', '', '', ''),
('3123123123123123', '1231212312312312', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'blok jambu', '16120', '001', '001', 2, '082127071354', 'rivalchmad@gmail.com', '32', 'Jawa Barat', '01', 'Kabupaten Bogor', '11', 'Kecamatan Ciseeng', '23', 'Kelurahan CIBEUTEUNG MUARA', 'Blok Jambu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'HIDUP', NULL, '', '', '', '', '', '', '', '', '', '', '', 'dadang'),
('3124325325131231', '2312312542534121', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'afe faef qfq', '16120', '001', '001', 4, '1231241241251', 'afarqrq', '32', 'Jawa Barat', '01', 'Kabupaten Bogor', '11', 'Kecamatan Ciseeng', '21', 'Kelurahan CIBEUTEUNG MUARA', 'asfefesfs', '', '', '', '', '', '', '', '', '', '', '', '', 'HIDUP', NULL, '', '', '', '', '', '', '', '', '', '', '', 'asepdgrs'),
('324324', '1234123412341235', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', '', '', '', '', '', '', '', '', '', ''),
('5555555555555555', '4444444444444444', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'jalan aja', '16120', '001', '001', 1, '14809128', 'rei@cdam', '32', 'Jawa Barat', '01', 'Kabupaten Bogor', '11', 'Kecamatan Ciseeng', '12', 'Kelurahan CIBEUTEUNG MUARA', 'ALFSUHLSIUA', 'ADSHF', 'HAKSHDF', 'UAFSHUH', 'AFHASIUHF', '34134', '19', '1428491848090', 'ASFDJ@ADG', '12', 'BIE', '12', 'AFUAS', 'HIDUP', NULL, '', '', '', '', '', '', '', '', '', '', '', 'asfhf');

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
(7, 'testuser', 'scrypt:32768:8:1$tdZzr0gVpIun5Tvc$5ac93e7643c697fc7615959d34545c683c0b7608b2be98ff5541d1337f7f140b242316454b65711c8ca3beb10c2c22f9971c525577f1b23039f093eb1f5b2455', 'Test User', 'Warga', 'user'),
(8, 'DoBronx', 'scrypt:32768:8:1$AMjmHEAt8ne4Ojqn$cead799d465a81a9ca2e1f4b2f82e10d0ab8a9b9a52f41033248a91dff33040ca8d2ec59c37ba30f7397caccc039dd8c0144460da74e0cffa60cea9914bd12a1', 'Rival Achmad', 'Warga', 'user'),
(9, 'Kai', 'scrypt:32768:8:1$B6JqXKavAobGsuLO$7ca844ca05a058a009087c4ca2152fd142e08afd868b3200a92ac3846e033c81f3c00c076669aa5e1bdb758b91c7d0e26e1f47307c26fdff279700f1be53ec40', 'Kai Cenat', 'Warga', 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `daftar_surat_kematian`
--
ALTER TABLE `daftar_surat_kematian`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `detail_kematian`
--
ALTER TABLE `detail_kematian`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `gabungan_keluarga`
--
ALTER TABLE `gabungan_keluarga`
  ADD PRIMARY KEY (`NIK`);

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
-- AUTO_INCREMENT for table `daftar_surat_kematian`
--
ALTER TABLE `daftar_surat_kematian`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `detail_kematian`
--
ALTER TABLE `detail_kematian`
  MODIFY `Id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `pengguna`
--
ALTER TABLE `pengguna`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
