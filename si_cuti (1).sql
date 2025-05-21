-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 18, 2025 at 08:00 AM
-- Server version: 8.0.30
-- PHP Version: 8.3.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `si_cuti`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id_admin` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `id_user` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cuti`
--

CREATE TABLE `cuti` (
  `id_cuti` int NOT NULL,
  `npm` int DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `tgl_pengajuan` date NOT NULL,
  `semester` int NOT NULL,
  `dokumen_pendukung` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `alasan` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kajur`
--

CREATE TABLE `kajur` (
  `id_kajur` int NOT NULL,
  `nama_kajur` varchar(50) NOT NULL,
  `nidn` varchar(20) NOT NULL,
  `nama_jurusan` varchar(30) NOT NULL,
  `id_user` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kajur`
--

INSERT INTO `kajur` (`id_kajur`, `nama_kajur`, `nidn`, `nama_jurusan`, `id_user`) VALUES
(1, 'Rivat', '198765432', 'JKB', 2);

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `npm` int NOT NULL,
  `id_user` int DEFAULT NULL,
  `id_kajur` int DEFAULT NULL,
  `nama_mahasiswa` varchar(50) NOT NULL,
  `tempat_tanggal_lahir` varchar(100) NOT NULL,
  `jenis_kelamin` enum('Laki-laki','Perempuan') NOT NULL,
  `alamat` varchar(200) NOT NULL,
  `agama` varchar(20) NOT NULL,
  `angkatan` varchar(10) NOT NULL,
  `program_studi` varchar(50) NOT NULL,
  `no_hp` varchar(13) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `mahasiswa`
--

INSERT INTO `mahasiswa` (`npm`, `id_user`, `id_kajur`, `nama_mahasiswa`, `tempat_tanggal_lahir`, `jenis_kelamin`, `alamat`, `agama`, `angkatan`, `program_studi`, `no_hp`, `email`) VALUES
(230102052, 3, 1, 'nana', 'Cilacap, 2005-02-02', 'Perempuan', 'Cilacap', 'Islam', '2022', 'Teknik Informatika', '0812345678912', 'nama@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int NOT NULL,
  `password` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `level` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `password`, `username`, `level`) VALUES
(1, 'admin123', 'admin', 'admin'),
(2, 'kajur123', 'windy', 'kajur'),
(3, 'mhs1', 'nana', 'mahasiswa');

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_beranda_kajur`
-- (See below for the actual view)
--
CREATE TABLE `view_beranda_kajur` (
`username` varchar(50)
,`npm` int
,`nama_mahasiswa` varchar(50)
,`program_studi` varchar(50)
,`nama_jurusan` varchar(30)
,`email` varchar(50)
,`nama_kajur` varchar(50)
,`semester` int
,`tgl_pengajuan` date
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_beranda_mahasiswa`
-- (See below for the actual view)
--
CREATE TABLE `view_beranda_mahasiswa` (
`npm` int
,`nama_mahasiswa` varchar(50)
,`tempat_tanggal_lahir` varchar(100)
,`jenis_kelamin` enum('Laki-laki','Perempuan')
,`agama` varchar(20)
,`angkatan` varchar(10)
,`program_studi` varchar(50)
,`nama_jurusan` varchar(30)
,`alamat` varchar(200)
,`email` varchar(50)
,`no_hp` varchar(13)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_riwayat_admin`
-- (See below for the actual view)
--
CREATE TABLE `view_riwayat_admin` (
`username` varchar(50)
,`npm` int
,`nama_mahasiswa` varchar(50)
,`program_studi` varchar(50)
,`nama_jurusan` varchar(30)
,`nama_kajur` varchar(50)
,`semester` int
,`tgl_pengajuan` date
,`no_hp` varchar(13)
,`email` varchar(50)
);

-- --------------------------------------------------------

--
-- Structure for view `view_beranda_kajur`
--
DROP TABLE IF EXISTS `view_beranda_kajur`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_beranda_kajur`  AS SELECT `u`.`username` AS `username`, `m`.`npm` AS `npm`, `m`.`nama_mahasiswa` AS `nama_mahasiswa`, `m`.`program_studi` AS `program_studi`, `k`.`nama_jurusan` AS `nama_jurusan`, `m`.`email` AS `email`, `k`.`nama_kajur` AS `nama_kajur`, `c`.`semester` AS `semester`, `c`.`tgl_pengajuan` AS `tgl_pengajuan` FROM (((`mahasiswa` `m` join `user` `u` on((`m`.`id_user` = `u`.`id_user`))) join `kajur` `k` on((`m`.`id_kajur` = `k`.`id_kajur`))) left join `cuti` `c` on((`m`.`npm` = `c`.`npm`)))  ;

-- --------------------------------------------------------

--
-- Structure for view `view_beranda_mahasiswa`
--
DROP TABLE IF EXISTS `view_beranda_mahasiswa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_beranda_mahasiswa`  AS SELECT `m`.`npm` AS `npm`, `m`.`nama_mahasiswa` AS `nama_mahasiswa`, `m`.`tempat_tanggal_lahir` AS `tempat_tanggal_lahir`, `m`.`jenis_kelamin` AS `jenis_kelamin`, `m`.`agama` AS `agama`, `m`.`angkatan` AS `angkatan`, `m`.`program_studi` AS `program_studi`, `k`.`nama_jurusan` AS `nama_jurusan`, `m`.`alamat` AS `alamat`, `m`.`email` AS `email`, `m`.`no_hp` AS `no_hp` FROM (`mahasiswa` `m` join `kajur` `k` on((`m`.`id_kajur` = `k`.`id_kajur`)))  ;

-- --------------------------------------------------------

--
-- Structure for view `view_riwayat_admin`
--
DROP TABLE IF EXISTS `view_riwayat_admin`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_riwayat_admin`  AS SELECT `u`.`username` AS `username`, `m`.`npm` AS `npm`, `m`.`nama_mahasiswa` AS `nama_mahasiswa`, `m`.`program_studi` AS `program_studi`, `k`.`nama_jurusan` AS `nama_jurusan`, `k`.`nama_kajur` AS `nama_kajur`, `c`.`semester` AS `semester`, `c`.`tgl_pengajuan` AS `tgl_pengajuan`, `m`.`no_hp` AS `no_hp`, `m`.`email` AS `email` FROM (((`mahasiswa` `m` join `user` `u` on((`m`.`id_user` = `u`.`id_user`))) join `kajur` `k` on((`m`.`id_kajur` = `k`.`id_kajur`))) left join `cuti` `c` on((`m`.`npm` = `c`.`npm`)))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `cuti`
--
ALTER TABLE `cuti`
  ADD PRIMARY KEY (`id_cuti`),
  ADD UNIQUE KEY `unique_cuti` (`npm`);

--
-- Indexes for table `kajur`
--
ALTER TABLE `kajur`
  ADD PRIMARY KEY (`id_kajur`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`npm`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_kajur` (`id_kajur`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id_admin` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cuti`
--
ALTER TABLE `cuti`
  MODIFY `id_cuti` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kajur`
--
ALTER TABLE `kajur`
  MODIFY `id_kajur` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cuti`
--
ALTER TABLE `cuti`
  ADD CONSTRAINT `cuti_ibfk_1` FOREIGN KEY (`npm`) REFERENCES `mahasiswa` (`npm`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kajur`
--
ALTER TABLE `kajur`
  ADD CONSTRAINT `kajur_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD CONSTRAINT `mahasiswa_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mahasiswa_ibfk_2` FOREIGN KEY (`id_kajur`) REFERENCES `kajur` (`id_kajur`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
