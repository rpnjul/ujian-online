-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 10, 2021 at 05:34 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 7.4.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ujian-online`
--

-- --------------------------------------------------------

--
-- Table structure for table `ujian_dosen`
--

CREATE TABLE `ujian_dosen` (
  `id_dosen` int(11) NOT NULL,
  `nip` char(12) NOT NULL,
  `nama_dosen` varchar(50) NOT NULL,
  `email` varchar(254) NOT NULL,
  `matkul_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ujian_dosen`
--

INSERT INTO `ujian_dosen` (`id_dosen`, `nip`, `nama_dosen`, `email`, `matkul_id`) VALUES
(1, '11111111', 'Mister Satria Aprilian', 'satria@satria.ga', 1),
(3, '10011011', 'Setianingsih', 'setianingsih@satria.ga', 1);

--
-- Triggers `ujian_dosen`
--
DELIMITER $$
CREATE TRIGGER `edit_user_dosen` BEFORE UPDATE ON `ujian_dosen` FOR EACH ROW UPDATE `ujian_users` SET `email` = NEW.email, `username` = NEW.nip WHERE `ujian_users`.`username` = OLD.nip
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `hapus_user_dosen` BEFORE DELETE ON `ujian_dosen` FOR EACH ROW DELETE FROM `ujian_users` WHERE `ujian_users`.`username` = OLD.nip
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ujian_groups`
--

CREATE TABLE `ujian_groups` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ujian_groups`
--

INSERT INTO `ujian_groups` (`id`, `name`, `description`) VALUES
(1, 'admin', 'Administrator'),
(2, 'dosen', 'Pembuat Soal dan ujian'),
(3, 'mahasiswa', 'Peserta Ujian');

-- --------------------------------------------------------

--
-- Table structure for table `ujian_h_ujian`
--

CREATE TABLE `ujian_h_ujian` (
  `id` int(11) NOT NULL,
  `ujian_id` int(11) NOT NULL,
  `mahasiswa_id` int(11) NOT NULL,
  `list_soal` longtext NOT NULL,
  `list_jawaban` longtext NOT NULL,
  `jml_benar` int(11) NOT NULL,
  `nilai` decimal(10,2) NOT NULL,
  `nilai_bobot` decimal(10,2) NOT NULL,
  `tgl_mulai` datetime NOT NULL,
  `tgl_selesai` datetime NOT NULL,
  `status` enum('Y','N') NOT NULL,
  `security_key` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ujian_h_ujian`
--

INSERT INTO `ujian_h_ujian` (`id`, `ujian_id`, `mahasiswa_id`, `list_soal`, `list_jawaban`, `jml_benar`, `nilai`, `nilai_bobot`, `tgl_mulai`, `tgl_selesai`, `status`, `security_key`) VALUES
(1, 1, 1, '1,2', '1:A:N,2:A:N', 2, '100.00', '100.00', '2020-08-28 22:57:55', '2020-08-28 23:57:55', 'N', NULL),
(2, 1, 2, '1,2', '1:B:N,2:A:N', 2, '100.00', '100.00', '2020-08-29 02:48:45', '2020-08-29 03:48:45', 'N', NULL),
(15, 1, 3, '1,2', '1:B:N,2:C:N', 1, '50.00', '100.00', '2020-08-30 22:15:43', '2020-08-30 23:15:43', 'N', '3b74284f643734135f672e78f7e6cffe'),
(16, 2, 3, '3,2,1', '3:A:N,2:A:N,1:B:N', 3, '100.00', '100.00', '2020-08-31 22:37:06', '2020-08-31 23:37:06', 'N', 'e1b9cb2de79dbcf2382170a7f0ee9988'),
(17, 3, 3, '2,3,1', '2:B:N,3:E:N,1:E:N', 0, '0.00', '100.00', '2021-03-09 18:12:21', '2021-03-09 19:12:21', 'N', '68dd9a58df17dc7088cfb5e62b57a4b2');

-- --------------------------------------------------------

--
-- Table structure for table `ujian_jurusan`
--

CREATE TABLE `ujian_jurusan` (
  `id_jurusan` int(11) NOT NULL,
  `nama_jurusan` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ujian_jurusan`
--

INSERT INTO `ujian_jurusan` (`id_jurusan`, `nama_jurusan`) VALUES
(1, 'Sistem Informasi'),
(3, 'Ilmu kecintaan');

-- --------------------------------------------------------

--
-- Table structure for table `ujian_jurusan_matkul`
--

CREATE TABLE `ujian_jurusan_matkul` (
  `id` int(11) NOT NULL,
  `matkul_id` int(11) NOT NULL,
  `jurusan_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ujian_jurusan_matkul`
--

INSERT INTO `ujian_jurusan_matkul` (`id`, `matkul_id`, `jurusan_id`) VALUES
(4, 1, 3),
(5, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ujian_kelas`
--

CREATE TABLE `ujian_kelas` (
  `id_kelas` int(11) NOT NULL,
  `nama_kelas` varchar(30) NOT NULL,
  `jurusan_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ujian_kelas`
--

INSERT INTO `ujian_kelas` (`id_kelas`, `nama_kelas`, `jurusan_id`) VALUES
(1, '12.1A.01', 1),
(2, '12.1B.01', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ujian_kelas_dosen`
--

CREATE TABLE `ujian_kelas_dosen` (
  `id` int(11) NOT NULL,
  `kelas_id` int(11) NOT NULL,
  `dosen_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ujian_kelas_dosen`
--

INSERT INTO `ujian_kelas_dosen` (`id`, `kelas_id`, `dosen_id`) VALUES
(5, 1, 1),
(6, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ujian_login_attempts`
--

CREATE TABLE `ujian_login_attempts` (
  `id` int(11) UNSIGNED NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ujian_mahasiswa`
--

CREATE TABLE `ujian_mahasiswa` (
  `id_mahasiswa` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `nim` char(20) NOT NULL,
  `email` varchar(254) NOT NULL,
  `jenis_kelamin` enum('L','P') NOT NULL,
  `kelas_id` int(11) NOT NULL COMMENT 'kelas&jurusan'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ujian_mahasiswa`
--

INSERT INTO `ujian_mahasiswa` (`id_mahasiswa`, `nama`, `nim`, `email`, `jenis_kelamin`, `kelas_id`) VALUES
(1, 'Chintya Fauzia Rahmadhani', '12171756', 'chintya@satria.ga', 'P', 1),
(2, 'Rian', '12172064', '12172064@satria.ga', 'L', 1),
(3, 'testing', '12121212', '12121212@admin.com', 'L', 1),
(4, 'Aprilian', '12171217', 'aprilian@bsi.ac.id', 'L', 2),
(5, 'Chintya Fauzia', '12170705', 'chintya@gmail.com', 'P', 1),
(6, 'Kini tinggal aku sendiri', '12171717', 'akusendiri@gm.com', 'L', 2),
(7, 'Hae hae joss', '121714156', 'joss@haehae.com', 'P', 1),
(8, '[removed]alert&#40;1&#41; [removed]', '11111111', 'aaa@a.com', 'L', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ujian_matkul`
--

CREATE TABLE `ujian_matkul` (
  `id_matkul` int(11) NOT NULL,
  `nama_matkul` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ujian_matkul`
--

INSERT INTO `ujian_matkul` (`id_matkul`, `nama_matkul`) VALUES
(1, 'Web Programming'),
(3, 'Struktur Data');

-- --------------------------------------------------------

--
-- Table structure for table `ujian_m_ujian`
--

CREATE TABLE `ujian_m_ujian` (
  `id_ujian` int(11) NOT NULL,
  `dosen_id` int(11) NOT NULL,
  `matkul_id` int(11) NOT NULL,
  `nama_ujian` varchar(200) NOT NULL,
  `jumlah_soal` int(11) NOT NULL,
  `waktu` int(11) NOT NULL,
  `jenis` enum('acak','urut') NOT NULL,
  `tgl_mulai` datetime NOT NULL,
  `terlambat` datetime NOT NULL,
  `token` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ujian_m_ujian`
--

INSERT INTO `ujian_m_ujian` (`id_ujian`, `dosen_id`, `matkul_id`, `nama_ujian`, `jumlah_soal`, `waktu`, `jenis`, `tgl_mulai`, `terlambat`, `token`) VALUES
(1, 1, 1, 'UTS', 2, 60, 'acak', '2020-08-28 22:56:11', '2020-08-31 22:00:00', 'CZTPU'),
(2, 1, 1, 'UAS', 3, 60, 'acak', '2021-03-09 18:00:00', '2021-03-09 20:00:00', 'RWGHY'),
(3, 1, 1, 'www', 3, 60, 'acak', '2021-03-09 17:51:00', '2021-03-09 18:47:05', 'XOKJE');

-- --------------------------------------------------------

--
-- Table structure for table `ujian_tb_soal`
--

CREATE TABLE `ujian_tb_soal` (
  `id_soal` int(11) NOT NULL,
  `dosen_id` int(11) NOT NULL,
  `matkul_id` int(11) NOT NULL,
  `bobot` int(11) NOT NULL,
  `file` varchar(255) NOT NULL,
  `tipe_file` varchar(50) NOT NULL,
  `soal` longtext NOT NULL,
  `opsi_a` longtext NOT NULL,
  `opsi_b` longtext NOT NULL,
  `opsi_c` longtext NOT NULL,
  `opsi_d` longtext NOT NULL,
  `opsi_e` longtext NOT NULL,
  `file_a` varchar(255) NOT NULL,
  `file_b` varchar(255) NOT NULL,
  `file_c` varchar(255) NOT NULL,
  `file_d` varchar(255) NOT NULL,
  `file_e` varchar(255) NOT NULL,
  `jawaban` varchar(5) NOT NULL,
  `created_on` int(11) NOT NULL,
  `updated_on` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ujian_tb_soal`
--

INSERT INTO `ujian_tb_soal` (`id_soal`, `dosen_id`, `matkul_id`, `bobot`, `file`, `tipe_file`, `soal`, `opsi_a`, `opsi_b`, `opsi_c`, `opsi_d`, `opsi_e`, `file_a`, `file_b`, `file_c`, `file_d`, `file_e`, `jawaban`, `created_on`, `updated_on`) VALUES
(1, 1, 1, 1, '07bd1030125954817fe6b64527d6a06c.jpg', 'image/jpeg', '<p>Siapakah yang ada di foto ?</p>', '<p>Aprilian Satria</p>', '<p>Satria Aprilian</p>', '<p>Ryan</p>', '<p>Rian Aprilian</p>', '<p>Super Rian</p>', '', '', '', '', '', 'B', 1598629162, 1598643757),
(2, 1, 1, 1, '', '', '<p>Siapakah Pemilik Website <a href=\"//WWW.SATRIA.GA\">WWW.SATRIA.GA</a> ?</p>', '<p>SATRIA APRILIAN</p>', '<p>SATRIA HAMANGKUBUWONO</p>', '<p>SATRIA FU</p>', '<p>SATRIA GARUDA</p>', '<p>BIMA SATRIA</p>', '', '', '', '', '', 'A', 1598629235, 1598629235),
(3, 1, 1, 1, '', '', '<p>Apa fungsi Array pada PHP?</p>', '<p>array()</p>', '<p>array{  }</p>', '<p>array => &#39;array&#39;</p>', '<p>array->array</p>', '<p>$array[&#39;array&#39;]</p>', '', '', '', '', '', 'A', 1598812461, 1598817218);

-- --------------------------------------------------------

--
-- Table structure for table `ujian_users`
--

CREATE TABLE `ujian_users` (
  `id` int(11) UNSIGNED NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  `activation_selector` varchar(255) DEFAULT NULL,
  `activation_code` varchar(255) DEFAULT NULL,
  `forgotten_password_selector` varchar(255) DEFAULT NULL,
  `forgotten_password_code` varchar(255) DEFAULT NULL,
  `forgotten_password_time` int(11) UNSIGNED DEFAULT NULL,
  `remember_selector` varchar(255) DEFAULT NULL,
  `remember_code` varchar(255) DEFAULT NULL,
  `created_on` int(11) UNSIGNED NOT NULL,
  `last_login` int(11) UNSIGNED DEFAULT NULL,
  `active` tinyint(1) UNSIGNED DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ujian_users`
--

INSERT INTO `ujian_users` (`id`, `ip_address`, `username`, `password`, `email`, `activation_selector`, `activation_code`, `forgotten_password_selector`, `forgotten_password_code`, `forgotten_password_time`, `remember_selector`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`) VALUES
(1, '127.0.0.1', 'Administrator', '$2y$12$oTnMESIWVe06XP5xmJTB.O4QudEXqnHaXAlqdqPlMasADNJQdqO4W', 'admin@admin.com', NULL, '', NULL, NULL, NULL, NULL, NULL, 1268889823, 1615290269, 1, 'Admin', 'Istrator', 'ADMIN', '0'),
(9, '::1', '12171756', '$2y$10$.ia6vwQvGT4582rkJ4cqr.cO.xGBQ1i1aXPL2eGin3x5HIUokyMd.', 'chintya@satria.ga', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1598629035, 1598635975, 1, 'Chintya', 'Rahmadhani', NULL, NULL),
(10, '::1', '11111111', '$2y$10$UeAFUTikIncD9LfQS7ICcuI0u2XPLs5bXi4raI7HRGtjFQbUwIqZG', 'satria@satria.ga', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1598630120, 1615286620, 1, 'Mister', 'Aprilian', NULL, NULL),
(11, '::1', '12172064', '$2y$10$6zfYj.ZdkKz9veSmxwxXou9D8z/DHK8gWD7vaG4itM/6xFKc4cOga', '12172064@satria.ga', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1598643702, 1607323862, 1, 'Rian', 'Rian', NULL, NULL),
(12, '::1', '12121212', '$2y$10$0cdgm1ICp3DIFslN0a.XDOGqYXxiMIG4/eBVLbXBLdalfsHzzIfOa', '12121212@admin.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1598798547, 1615286468, 1, 'testing', 'testing', NULL, NULL),
(13, '::1', '12171217', '$2y$10$.wLvgXEk9JtbxWsor61VtOD2DBb456XnqdtFfEbXtjmGP7v8XhhtS', 'aprilian@bsi.ac.id', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1598812010, NULL, 1, 'Aprilian', 'Aprilian', NULL, NULL),
(14, '114.124.161.190', '12170705', '$2y$10$BeccwBdYgMpsh1FnpdwwFe/pGDlfjjBnCvCblujjSHCG009gbAAlW', 'chintya@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1598887744, 1598888558, 1, 'Chintya', 'Fauzia', NULL, NULL),
(15, '182.2.39.3', '121714156', '$2y$10$MvULgVWMU7xqnHp5FHT3DuBF6DJoHVTDlvj91lRXbb84HdXL0SCOK', 'joss@haehae.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1615104698, NULL, 1, 'Hae', 'joss', NULL, NULL),
(16, '125.166.0.184', '12171717', '$2y$10$TZTuwbWeQHrzjf5KFmsR.eOlnUnmkxjz5kN4ZmAr.sfQ7vrSHWnXe', 'akusendiri@gm.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1615286338, NULL, 1, 'Kini', 'sendiri', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ujian_users_groups`
--

CREATE TABLE `ujian_users_groups` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `group_id` mediumint(8) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ujian_users_groups`
--

INSERT INTO `ujian_users_groups` (`id`, `user_id`, `group_id`) VALUES
(3, 1, 1),
(11, 9, 3),
(12, 10, 2),
(13, 11, 3),
(14, 12, 3),
(15, 13, 3),
(16, 14, 3),
(17, 15, 3),
(18, 16, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ujian_dosen`
--
ALTER TABLE `ujian_dosen`
  ADD PRIMARY KEY (`id_dosen`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `nip` (`nip`),
  ADD KEY `matkul_id` (`matkul_id`);

--
-- Indexes for table `ujian_groups`
--
ALTER TABLE `ujian_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ujian_h_ujian`
--
ALTER TABLE `ujian_h_ujian`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ujian_id` (`ujian_id`),
  ADD KEY `mahasiswa_id` (`mahasiswa_id`);

--
-- Indexes for table `ujian_jurusan`
--
ALTER TABLE `ujian_jurusan`
  ADD PRIMARY KEY (`id_jurusan`);

--
-- Indexes for table `ujian_jurusan_matkul`
--
ALTER TABLE `ujian_jurusan_matkul`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jurusan_id` (`jurusan_id`),
  ADD KEY `matkul_id` (`matkul_id`);

--
-- Indexes for table `ujian_kelas`
--
ALTER TABLE `ujian_kelas`
  ADD PRIMARY KEY (`id_kelas`),
  ADD KEY `jurusan_id` (`jurusan_id`);

--
-- Indexes for table `ujian_kelas_dosen`
--
ALTER TABLE `ujian_kelas_dosen`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kelas_id` (`kelas_id`),
  ADD KEY `dosen_id` (`dosen_id`);

--
-- Indexes for table `ujian_login_attempts`
--
ALTER TABLE `ujian_login_attempts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ujian_mahasiswa`
--
ALTER TABLE `ujian_mahasiswa`
  ADD PRIMARY KEY (`id_mahasiswa`),
  ADD UNIQUE KEY `nim` (`nim`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `kelas_id` (`kelas_id`);

--
-- Indexes for table `ujian_matkul`
--
ALTER TABLE `ujian_matkul`
  ADD PRIMARY KEY (`id_matkul`);

--
-- Indexes for table `ujian_m_ujian`
--
ALTER TABLE `ujian_m_ujian`
  ADD PRIMARY KEY (`id_ujian`),
  ADD KEY `matkul_id` (`matkul_id`),
  ADD KEY `dosen_id` (`dosen_id`);

--
-- Indexes for table `ujian_tb_soal`
--
ALTER TABLE `ujian_tb_soal`
  ADD PRIMARY KEY (`id_soal`),
  ADD KEY `matkul_id` (`matkul_id`),
  ADD KEY `dosen_id` (`dosen_id`);

--
-- Indexes for table `ujian_users`
--
ALTER TABLE `ujian_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uc_activation_selector` (`activation_selector`),
  ADD UNIQUE KEY `uc_forgotten_password_selector` (`forgotten_password_selector`),
  ADD UNIQUE KEY `uc_remember_selector` (`remember_selector`),
  ADD UNIQUE KEY `uc_email` (`email`) USING BTREE;

--
-- Indexes for table `ujian_users_groups`
--
ALTER TABLE `ujian_users_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uc_users_groups` (`user_id`,`group_id`),
  ADD KEY `fk_users_groups_users1_idx` (`user_id`),
  ADD KEY `fk_users_groups_groups1_idx` (`group_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ujian_dosen`
--
ALTER TABLE `ujian_dosen`
  MODIFY `id_dosen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ujian_groups`
--
ALTER TABLE `ujian_groups`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ujian_h_ujian`
--
ALTER TABLE `ujian_h_ujian`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `ujian_jurusan`
--
ALTER TABLE `ujian_jurusan`
  MODIFY `id_jurusan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ujian_jurusan_matkul`
--
ALTER TABLE `ujian_jurusan_matkul`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ujian_kelas`
--
ALTER TABLE `ujian_kelas`
  MODIFY `id_kelas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ujian_kelas_dosen`
--
ALTER TABLE `ujian_kelas_dosen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `ujian_login_attempts`
--
ALTER TABLE `ujian_login_attempts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `ujian_mahasiswa`
--
ALTER TABLE `ujian_mahasiswa`
  MODIFY `id_mahasiswa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `ujian_matkul`
--
ALTER TABLE `ujian_matkul`
  MODIFY `id_matkul` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ujian_m_ujian`
--
ALTER TABLE `ujian_m_ujian`
  MODIFY `id_ujian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ujian_tb_soal`
--
ALTER TABLE `ujian_tb_soal`
  MODIFY `id_soal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ujian_users`
--
ALTER TABLE `ujian_users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `ujian_users_groups`
--
ALTER TABLE `ujian_users_groups`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ujian_dosen`
--
ALTER TABLE `ujian_dosen`
  ADD CONSTRAINT `ujian_dosen_ibfk_1` FOREIGN KEY (`matkul_id`) REFERENCES `ujian_matkul` (`id_matkul`);

--
-- Constraints for table `ujian_h_ujian`
--
ALTER TABLE `ujian_h_ujian`
  ADD CONSTRAINT `ujian_h_ujian_ibfk_1` FOREIGN KEY (`ujian_id`) REFERENCES `ujian_m_ujian` (`id_ujian`),
  ADD CONSTRAINT `ujian_h_ujian_ibfk_2` FOREIGN KEY (`mahasiswa_id`) REFERENCES `ujian_mahasiswa` (`id_mahasiswa`);

--
-- Constraints for table `ujian_jurusan_matkul`
--
ALTER TABLE `ujian_jurusan_matkul`
  ADD CONSTRAINT `ujian_jurusan_matkul_ibfk_1` FOREIGN KEY (`jurusan_id`) REFERENCES `ujian_jurusan` (`id_jurusan`),
  ADD CONSTRAINT `ujian_jurusan_matkul_ibfk_2` FOREIGN KEY (`matkul_id`) REFERENCES `ujian_matkul` (`id_matkul`);

--
-- Constraints for table `ujian_kelas_dosen`
--
ALTER TABLE `ujian_kelas_dosen`
  ADD CONSTRAINT `ujian_kelas_dosen_ibfk_1` FOREIGN KEY (`dosen_id`) REFERENCES `ujian_dosen` (`id_dosen`),
  ADD CONSTRAINT `ujian_kelas_dosen_ibfk_2` FOREIGN KEY (`kelas_id`) REFERENCES `ujian_kelas` (`id_kelas`);

--
-- Constraints for table `ujian_mahasiswa`
--
ALTER TABLE `ujian_mahasiswa`
  ADD CONSTRAINT `ujian_mahasiswa_ibfk_2` FOREIGN KEY (`kelas_id`) REFERENCES `ujian_kelas` (`id_kelas`);

--
-- Constraints for table `ujian_m_ujian`
--
ALTER TABLE `ujian_m_ujian`
  ADD CONSTRAINT `ujian_m_ujian_ibfk_1` FOREIGN KEY (`dosen_id`) REFERENCES `ujian_dosen` (`id_dosen`),
  ADD CONSTRAINT `ujian_m_ujian_ibfk_2` FOREIGN KEY (`matkul_id`) REFERENCES `ujian_matkul` (`id_matkul`);

--
-- Constraints for table `ujian_tb_soal`
--
ALTER TABLE `ujian_tb_soal`
  ADD CONSTRAINT `ujian_tb_soal_ibfk_1` FOREIGN KEY (`matkul_id`) REFERENCES `ujian_matkul` (`id_matkul`),
  ADD CONSTRAINT `ujian_tb_soal_ibfk_2` FOREIGN KEY (`dosen_id`) REFERENCES `ujian_dosen` (`id_dosen`);

--
-- Constraints for table `ujian_users_groups`
--
ALTER TABLE `ujian_users_groups`
  ADD CONSTRAINT `fk_users_groups_groups1` FOREIGN KEY (`group_id`) REFERENCES `ujian_groups` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_users_groups_users1` FOREIGN KEY (`user_id`) REFERENCES `ujian_users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
