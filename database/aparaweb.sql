-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 02, 2023 at 10:46 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aparaweb`
--

-- --------------------------------------------------------

--
-- Table structure for table `account_emailaddress`
--

CREATE TABLE `account_emailaddress` (
  `id` int(11) NOT NULL,
  `email` varchar(254) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `account_emailconfirmation`
--

CREATE TABLE `account_emailconfirmation` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `sent` datetime(6) DEFAULT NULL,
  `key` varchar(64) NOT NULL,
  `email_address_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(4, 'Customer'),
(2, 'Manager');

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `auth_group_permissions`
--

INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES
(29, 2, 1),
(30, 2, 2),
(31, 2, 3),
(32, 2, 4),
(33, 2, 5),
(34, 2, 6),
(35, 2, 7),
(36, 2, 8),
(37, 2, 9),
(38, 2, 10),
(39, 2, 11),
(40, 2, 12),
(41, 2, 13),
(42, 2, 14),
(43, 2, 15),
(44, 2, 16),
(129, 2, 17),
(130, 2, 18),
(131, 2, 19),
(132, 2, 20),
(133, 2, 21),
(134, 2, 22),
(135, 2, 23),
(136, 2, 24),
(45, 2, 25),
(46, 2, 26),
(47, 2, 27),
(48, 2, 28),
(49, 2, 29),
(50, 2, 30),
(51, 2, 31),
(52, 2, 32),
(137, 2, 33),
(138, 2, 34),
(139, 2, 35),
(140, 2, 36),
(53, 2, 37),
(54, 2, 38),
(55, 2, 39),
(56, 2, 40),
(57, 2, 41),
(58, 2, 42),
(59, 2, 43),
(60, 2, 44),
(61, 2, 45),
(62, 2, 46),
(63, 2, 47),
(64, 2, 48),
(65, 2, 49),
(66, 2, 50),
(67, 2, 51),
(68, 2, 52),
(141, 2, 53),
(142, 2, 54),
(143, 2, 55),
(144, 2, 56),
(145, 2, 57),
(146, 2, 58),
(147, 2, 59),
(148, 2, 60),
(149, 2, 61),
(150, 2, 62),
(151, 2, 63),
(152, 2, 64),
(153, 2, 65),
(154, 2, 66),
(155, 2, 67),
(156, 2, 68),
(126, 2, 69),
(127, 2, 70),
(128, 2, 71),
(125, 2, 72),
(161, 2, 73),
(162, 2, 74),
(163, 2, 75),
(164, 2, 76),
(172, 4, 28),
(165, 4, 32),
(170, 4, 44),
(171, 4, 52),
(166, 4, 69),
(167, 4, 70),
(168, 4, 71),
(169, 4, 72);

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add account', 7, 'add_account'),
(26, 'Can change account', 7, 'change_account'),
(27, 'Can delete account', 7, 'delete_account'),
(28, 'Can view account', 7, 'view_account'),
(29, 'Can add location', 8, 'add_location'),
(30, 'Can change location', 8, 'change_location'),
(31, 'Can delete location', 8, 'delete_location'),
(32, 'Can view location', 8, 'view_location'),
(33, 'Can add role', 9, 'add_role'),
(34, 'Can change role', 9, 'change_role'),
(35, 'Can delete role', 9, 'delete_role'),
(36, 'Can view role', 9, 'view_role'),
(37, 'Can add account_role', 10, 'add_account_role'),
(38, 'Can change account_role', 10, 'change_account_role'),
(39, 'Can delete account_role', 10, 'delete_account_role'),
(40, 'Can view account_role', 10, 'view_account_role'),
(41, 'Can add category', 11, 'add_category'),
(42, 'Can change category', 11, 'change_category'),
(43, 'Can delete category', 11, 'delete_category'),
(44, 'Can view category', 11, 'view_category'),
(45, 'Can add comment', 12, 'add_comment'),
(46, 'Can change comment', 12, 'change_comment'),
(47, 'Can delete comment', 12, 'delete_comment'),
(48, 'Can view comment', 12, 'view_comment'),
(49, 'Can add images', 13, 'add_images'),
(50, 'Can change images', 13, 'change_images'),
(51, 'Can delete images', 13, 'delete_images'),
(52, 'Can view images', 13, 'view_images'),
(53, 'Can add Blacklisted IP', 14, 'add_blacklistip'),
(54, 'Can change Blacklisted IP', 14, 'change_blacklistip'),
(55, 'Can delete Blacklisted IP', 14, 'delete_blacklistip'),
(56, 'Can view Blacklisted IP', 14, 'view_blacklistip'),
(57, 'Can add Blacklisted User Agent', 15, 'add_blacklistuseragent'),
(58, 'Can change Blacklisted User Agent', 15, 'change_blacklistuseragent'),
(59, 'Can delete Blacklisted User Agent', 15, 'delete_blacklistuseragent'),
(60, 'Can view Blacklisted User Agent', 15, 'view_blacklistuseragent'),
(61, 'Can add hit', 16, 'add_hit'),
(62, 'Can change hit', 16, 'change_hit'),
(63, 'Can delete hit', 16, 'delete_hit'),
(64, 'Can view hit', 16, 'view_hit'),
(65, 'Can add hit count', 17, 'add_hitcount'),
(66, 'Can change hit count', 17, 'change_hitcount'),
(67, 'Can delete hit count', 17, 'delete_hitcount'),
(68, 'Can view hit count', 17, 'view_hitcount'),
(69, 'Can add rating', 18, 'add_rating'),
(70, 'Can change rating', 18, 'change_rating'),
(71, 'Can delete rating', 18, 'delete_rating'),
(72, 'Can view rating', 18, 'view_rating'),
(73, 'Can add history', 19, 'add_history'),
(74, 'Can change history', 19, 'change_history'),
(75, 'Can delete history', 19, 'delete_history'),
(76, 'Can view history', 19, 'view_history'),
(77, 'Can add email address', 20, 'add_emailaddress'),
(78, 'Can change email address', 20, 'change_emailaddress'),
(79, 'Can delete email address', 20, 'delete_emailaddress'),
(80, 'Can view email address', 20, 'view_emailaddress'),
(81, 'Can add email confirmation', 21, 'add_emailconfirmation'),
(82, 'Can change email confirmation', 21, 'change_emailconfirmation'),
(83, 'Can delete email confirmation', 21, 'delete_emailconfirmation'),
(84, 'Can view email confirmation', 21, 'view_emailconfirmation'),
(85, 'Can add social account', 22, 'add_socialaccount'),
(86, 'Can change social account', 22, 'change_socialaccount'),
(87, 'Can delete social account', 22, 'delete_socialaccount'),
(88, 'Can view social account', 22, 'view_socialaccount'),
(89, 'Can add social application', 23, 'add_socialapp'),
(90, 'Can change social application', 23, 'change_socialapp'),
(91, 'Can delete social application', 23, 'delete_socialapp'),
(92, 'Can view social application', 23, 'view_socialapp'),
(93, 'Can add social application token', 24, 'add_socialtoken'),
(94, 'Can change social application token', 24, 'change_socialtoken'),
(95, 'Can delete social application token', 24, 'delete_socialtoken'),
(96, 'Can view social application token', 24, 'view_socialtoken'),
(97, 'Can add visitor', 25, 'add_visitor'),
(98, 'Can change visitor', 25, 'change_visitor'),
(99, 'Can delete visitor', 25, 'delete_visitor'),
(100, 'Can view visitor', 25, 'view_visitor'),
(101, 'Can add visitor interest', 26, 'add_visitorinterest'),
(102, 'Can change visitor interest', 26, 'change_visitorinterest'),
(103, 'Can delete visitor interest', 26, 'delete_visitorinterest'),
(104, 'Can view visitor interest', 26, 'view_visitorinterest');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$390000$w5og3zfL5ovHlXdsqMZwjY$5Z+di1kdk1zavweZwjEblOQc1sLgkC8oF7MsksAPiDU=', '2023-01-02 06:33:02.455569', 1, 'phamthiphuongnga', '', '', 'phamnga.bibi89@gmail.com', 1, 1, '2022-11-13 06:15:29.000000'),
(61, 'pbkdf2_sha256$390000$xoEE6TeyYEytYqNKSJEIh1$LK6gzPLq3GvEcQmHUUtIBghgJA3Me/LXd/hUmfWyEuQ=', '2022-12-25 07:24:18.000000', 0, 'Cus1', '', '', '', 0, 1, '2022-12-24 12:45:44.000000'),
(62, 'pbkdf2_sha256$390000$VBGn5LQLLCKOOvaIk8YY4U$Xl2+BV55ojBrS8dPVS+akBkXmsVZiEFNi+RGCXDFyTY=', '2022-12-31 13:54:25.501865', 0, 'Cuss2', '', '', 'vincompnt@gmail.com', 0, 1, '2022-12-24 16:30:40.000000'),
(63, 'pbkdf2_sha256$390000$V4xZoYiatSCdHV17Gt8nV8$ZaXkAVdKJ9RvkoOYLuOBGzkvACDmhgfLbTFVh0nXjKU=', '2022-12-24 16:58:35.000000', 0, 'Cuss3', '', '', 'cuss3@gmail.com', 0, 1, '2022-12-24 16:31:10.000000'),
(64, 'pbkdf2_sha256$390000$nJTjVbenpanMXKrRl1xa9O$FZLoUnAYD4Szo2tfnEaPoh5nbHRNVvOTBVFASTz85Jc=', '2022-12-25 07:14:11.000000', 0, 'cuss4', '', '', 'cuss3@gmail.com', 0, 1, '2022-12-24 16:31:20.000000'),
(65, 'pbkdf2_sha256$390000$Uy8l0fTfPxJl1593DvmzvK$LBe7g/kvC7iUt8CRpKbCyZM3P9lqtjdZH4f9Dcv5vec=', '2022-12-25 07:15:17.000000', 0, 'Cuss5', '', '', 'cuss5@gmail.com', 0, 1, '2022-12-24 16:31:34.000000'),
(66, 'pbkdf2_sha256$390000$Gm14oZW9WhvVJwx4XHQFIB$xS5GdavFUpduVQmqcN0soS9xY2FyiVZGH4dboSjYlm4=', '2022-12-25 07:24:51.000000', 0, 'Cuss6', '', '', 'cuss6@gmail.com', 0, 1, '2022-12-24 16:31:45.000000'),
(68, 'pbkdf2_sha256$390000$obANh6059D1EG7qYedYXty$5WMJ4xgzw498j2JhnupUEqJVAV1Of4f4sWBIO91pXYs=', '2023-01-02 08:43:44.565922', 0, 'ngochan', '', '', 'ngochan@gmail.com', 0, 1, '2022-12-30 16:20:12.000000'),
(69, 'pbkdf2_sha256$390000$VQqOiwyBWclzYgz7H33d6m$ydpJeMhZM4ZgQ+Ew1nTFd0jOIoZ8ySaz7xnjg1ptMG0=', '2022-12-31 14:36:21.542804', 0, 'nganga', '', '', 'ngaptp.bhsoft@gmail.com', 1, 1, '2022-12-30 16:23:02.000000'),
(87, 'pbkdf2_sha256$390000$GK8n8H81je1009w7UCXtYd$oSYVvv5GgKp+K3NFrZFYUVCz0ya46whNkMPE059yeak=', NULL, 0, 'ngochai', '', '', 'ngochai@gmail.com', 1, 1, '2023-01-02 04:32:39.755268');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `auth_user_groups`
--

INSERT INTO `auth_user_groups` (`id`, `user_id`, `group_id`) VALUES
(54, 61, 4),
(55, 62, 4),
(56, 63, 4),
(57, 64, 4),
(58, 65, 4),
(59, 66, 4),
(60, 68, 4),
(44, 69, 2),
(69, 87, 2);

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `blog_category`
--

CREATE TABLE `blog_category` (
  `id` bigint(20) NOT NULL,
  `name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `blog_category`
--

INSERT INTO `blog_category` (`id`, `name`) VALUES
(1, 'Nhà hàng'),
(2, 'Khu vui chơi'),
(3, 'Quán cafe'),
(4, 'Danh lam thắng cảnh'),
(5, 'Trung tâm thương mại'),
(19, 'Khác');

-- --------------------------------------------------------

--
-- Table structure for table `blog_comment`
--

CREATE TABLE `blog_comment` (
  `id` bigint(20) NOT NULL,
  `date` datetime(6) DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  `detaillocation_id` bigint(20) DEFAULT NULL,
  `body` longtext DEFAULT NULL,
  `updated_at` datetime(6) NOT NULL,
  `status` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `blog_comment`
--

INSERT INTO `blog_comment` (`id`, `date`, `author_id`, `detaillocation_id`, `body`, `updated_at`, `status`) VALUES
(44, '2022-11-20 11:20:19.752874', 1, 1, '5353253', '2022-11-21 16:09:52.959400', 1),
(45, '2022-11-20 13:39:47.168139', 1, 1, '5434535', '2022-11-21 16:09:52.959400', 1),
(46, '2022-11-20 15:15:28.480851', 1, 1, '32342', '2022-11-21 16:09:52.959400', 1),
(47, '2022-11-20 15:16:28.592172', 1, 1, 'testttt', '2022-11-21 16:09:52.959400', 1),
(48, '2022-11-20 15:24:30.629932', 1, 1, 'tesst sao', '2022-11-21 16:17:23.897298', 1),
(51, '2022-11-21 16:21:05.623318', 1, 1, 'Đán già nè', '2022-11-21 16:21:05.623318', 1),
(55, '2022-12-01 03:46:38.251673', 1, 28, 'Sạch đẹp, Nhân viên nhiệt tình.....', '2022-12-03 16:07:07.772844', 1),
(56, '2022-12-01 03:47:24.751693', 1, 28, 'Bình thường, đồ ăn không hợp khẩu vị, chất lượng', '2022-12-01 03:47:24.751693', 1),
(57, '2022-12-01 03:58:52.925429', 1, 28, 'Bình thường lắm đừng đến thất vọng\r\n', '2022-12-03 15:50:17.502598', 1),
(58, '2022-12-04 05:40:12.644000', 1, 28, 'Ngon lắm', '2022-12-04 05:40:12.644000', 1),
(63, '2022-12-07 15:33:41.722448', 1, 28, 'xấu lắm', '2022-12-07 15:33:41.722448', 1),
(67, '2022-12-10 12:25:33.746523', 1, 1, '4343242', '2022-12-10 12:25:33.746523', 1),
(68, '2022-12-10 12:37:35.005036', 1, 30, 'Đẹp lắm luôn\r\n', '2022-12-10 12:37:35.005036', 1),
(73, '2022-12-13 10:54:01.608933', 1, 33, 'Đẹp lắm ạ', '2022-12-13 10:54:01.608933', 1),
(84, '2022-12-24 12:52:39.679421', 61, 47, 'Quán siêu xinh. Mình là con trai nên đến để ngắm gái là chính. view đẹp thực sự. Mỗi tuần quán lại có 1 sự kiện hay cho khách hàng miễn phí.', '2022-12-24 12:52:39.679421', 1),
(85, '2022-12-24 16:41:20.804264', 62, 55, 'Đồ ăn ngon, nhân viên thân thiện, không gian quán sạch đẹp', '2022-12-24 16:41:20.804264', 1),
(86, '2022-12-24 16:42:56.878686', 63, 34, 'Không đẹp lắm, lúc mình đến hoa đã tàn nhiều rồi không có chỗ chụp nhiều', '2022-12-24 16:42:56.878686', 1),
(87, '2022-12-24 17:03:16.920694', 65, 55, 'Đồ ăn ngon, sẽ ghé quán nhiều lần', '2022-12-24 17:03:16.920694', 1),
(88, '2022-12-25 07:14:00.381067', 65, 50, 'Đồ ăn ngon, trang trí đẹp lắm, nhân viên thân thiện', '2022-12-25 07:14:00.381067', 1),
(89, '2022-12-25 07:14:55.851218', 64, 50, 'Đẹp lắm nên đến, giá cả phải chăng...', '2022-12-25 07:14:55.851218', 1),
(90, '2022-12-25 07:26:25.227604', 66, 53, 'Rất là đẹp, nhiều khu vui chơi giải trí, mua sắm giá cả phải chăng là một điểm đến thích hợp cho các cặp đôi và giải trí...', '2022-12-25 07:26:25.227604', 1),
(93, '2023-01-02 06:31:49.550042', 68, 52, 'Rất là đẹp', '2023-01-02 06:31:49.550042', 1),
(94, '2023-01-02 08:44:23.118999', 68, 58, 'Đẹp lắm', '2023-01-02 08:44:23.118999', 1);

-- --------------------------------------------------------

--
-- Table structure for table `blog_images`
--

CREATE TABLE `blog_images` (
  `id` bigint(20) NOT NULL,
  `image` varchar(100) NOT NULL,
  `location_id_id` bigint(20) DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `blog_images`
--

INSERT INTO `blog_images` (`id`, `image`, `location_id_id`, `date`) VALUES
(1, 'images/client-22x.png', 1, '2022-11-27 14:15:23.478066'),
(2, 'images/client-3.png', 1, '2022-11-27 14:15:23.478066'),
(3, 'images/client-22x.png', 1, '2022-11-27 14:15:23.478066'),
(4, 'images/client-3_sq12r0K.png', 1, '2022-11-27 14:15:23.478066'),
(5, 'images/client-22x_BcORE8C.png', 1, '2022-11-27 14:15:23.478066'),
(6, 'images/client-3_4vBnvQB.png', 1, '2022-11-27 14:15:23.478066'),
(7, 'images/agency3-screen.jpg', 1, '2022-11-27 14:15:23.478066'),
(9, 'images/bg-38.jpg', 1, '2022-11-27 14:15:23.478066'),
(10, 'images/bg-nature-4.jpg', 1, '2022-11-27 14:15:23.478066'),
(36, 'images/screen-22_NOPJ4Ll.jpg', 30, '2022-12-18 09:20:41.852801'),
(37, 'images/screen-23.jpg', 30, '2022-12-18 09:20:41.869762'),
(38, 'images/screen-24.jpg', 30, '2022-12-18 09:20:41.880132'),
(39, 'images/screen-36.jpg', 30, '2022-12-18 09:20:41.904120'),
(40, 'images/screen-37.jpg', 30, '2022-12-18 09:20:41.920226'),
(41, 'images/screen-38.jpg', 30, '2022-12-18 09:20:41.930198'),
(42, 'images/screen-39.jpg', 30, '2022-12-18 09:20:41.941171'),
(46, 'images/timeline1.png', 47, '2022-12-24 12:44:17.722565'),
(47, 'images/timeline2.png', 47, '2022-12-24 12:44:33.021392'),
(48, 'images/timeline3.png', 47, '2022-12-24 12:44:33.036666'),
(49, 'images/timeline4.png', 47, '2022-12-24 12:44:33.047707'),
(50, 'images/timeline5.png', 47, '2022-12-24 12:44:33.064141'),
(51, 'images/timeline6.png', 47, '2022-12-24 12:44:33.075597'),
(52, 'images/timeline7.png', 47, '2022-12-24 12:44:33.094939'),
(53, 'images/timeline8.png', 47, '2022-12-24 12:44:33.112784'),
(54, 'images/lofit3.png', 48, '2022-12-24 13:06:40.354458'),
(55, 'images/lofit4.png', 48, '2022-12-24 13:06:40.371201'),
(56, 'images/lofita_r8J7shg.png', 48, '2022-12-24 13:06:40.383302'),
(57, 'images/lofita1.png', 48, '2022-12-24 13:06:40.396283'),
(58, 'images/lofita2.png', 48, '2022-12-24 13:06:54.021297'),
(59, 'images/lofita3.png', 48, '2022-12-24 13:06:54.037483'),
(60, 'images/lofita5.png', 48, '2022-12-24 13:06:54.050196'),
(61, 'images/lofita6.png', 48, '2022-12-24 13:06:54.064737'),
(62, 'images/lofita7.png', 48, '2022-12-24 13:07:06.401376'),
(63, 'images/lofita8.png', 48, '2022-12-24 13:07:06.418297'),
(64, 'images/lofit3_Ikr8SYR.png', 49, '2022-12-24 14:19:51.292528'),
(65, 'images/trillrooftop1.png', 49, '2022-12-24 14:20:25.622167'),
(66, 'images/trillrooftop2.png', 49, '2022-12-24 14:20:25.630153'),
(67, 'images/trillrooftop3.png', 49, '2022-12-24 14:20:25.638125'),
(68, 'images/trillrooftop4.png', 49, '2022-12-24 14:20:25.648109'),
(69, 'images/trillrooftop5_XMmrLil.png', 49, '2022-12-24 14:20:42.984460'),
(70, 'images/maison1.png', 50, '2022-12-24 14:55:04.421433'),
(71, 'images/maison2.png', 50, '2022-12-24 14:55:21.146355'),
(72, 'images/maison3.png', 50, '2022-12-24 14:55:21.155463'),
(73, 'images/maison4.png', 50, '2022-12-24 14:56:03.232850'),
(74, 'images/timeline4_yMRQTWE.png', 50, '2022-12-24 14:56:28.959630'),
(75, 'images/241475345_147896430874477_1044065903268835992_n.jpg', 50, '2022-12-24 14:58:04.508099'),
(76, 'images/240592706_147896417541145_4086698508871206688_n.jpg', 50, '2022-12-24 14:58:04.513084'),
(77, 'images/241474684_147896447541142_7185731354225379146_n.jpg', 50, '2022-12-24 14:58:04.516068'),
(78, 'images/ttmvincom8.png', 51, '2022-12-24 15:09:01.660813'),
(79, 'images/ttmvincom.png', 51, '2022-12-24 15:09:25.937189'),
(80, 'images/ttmvincom1_4CjdSZy.png', 51, '2022-12-24 15:09:25.950174'),
(81, 'images/ttmvincom2.png', 51, '2022-12-24 15:09:25.966798'),
(82, 'images/ttmvincom3.png', 51, '2022-12-24 15:09:25.976769'),
(83, 'images/ttmvincom4.png', 51, '2022-12-24 15:09:25.997859'),
(84, 'images/ttmvincom5.png', 51, '2022-12-24 15:09:26.008345'),
(85, 'images/ttmvincom6.png', 51, '2022-12-24 15:09:26.019327'),
(86, 'images/ttmvincom7.png', 51, '2022-12-24 15:09:26.036850'),
(87, 'images/almazcenter1.png', 52, '2022-12-24 15:30:45.993232'),
(88, 'images/almazcenter2.png', 52, '2022-12-24 15:30:46.008191'),
(89, 'images/almazcenter3.png', 52, '2022-12-24 15:30:46.024151'),
(90, 'images/almazcenter4.png', 52, '2022-12-24 15:30:46.039109'),
(91, 'images/almazcenter5.png', 52, '2022-12-24 15:30:46.061050'),
(92, 'images/almazcenter6.png', 52, '2022-12-24 15:30:46.087493'),
(93, 'images/almazcenter7.png', 52, '2022-12-24 15:30:46.107439'),
(95, 'images/317976276_8960484890629054_1894802142888851974_n.jpg', 53, '2022-12-24 15:38:39.193339'),
(96, 'images/319835576_1146892666190888_3501633734910250746_n_d9lkTkG.jpg', 53, '2022-12-24 15:38:39.213284'),
(97, 'images/319746155_1667992470265450_2405156757612057025_n.jpg', 53, '2022-12-24 15:38:39.231235'),
(98, 'images/320630129_1378148059592557_148679263473720661_n.jpg', 53, '2022-12-24 15:38:39.254184'),
(99, 'images/320014050_1165613390984706_8718378490858999179_n.jpg', 53, '2022-12-24 15:38:39.272126'),
(100, 'images/319522957_672934811226788_3759595583521235168_n.jpg', 53, '2022-12-24 15:38:39.287086'),
(101, 'images/241475345_147896430874477_1044065903268835992_n_wmmaeoM.jpg', 53, '2022-12-24 15:38:39.310024'),
(102, 'images/240592706_147896417541145_4086698508871206688_n_O60t6B0.jpg', 53, '2022-12-24 15:38:39.334957'),
(103, 'images/241474684_147896447541142_7185731354225379146_n_zseQMf0.jpg', 53, '2022-12-24 15:38:39.359892'),
(104, 'images/paoquan1.png', 54, '2022-12-24 15:45:04.788805'),
(105, 'images/paoquan2.png', 54, '2022-12-24 15:45:04.803771'),
(106, 'images/paoquan3.png', 54, '2022-12-24 15:45:04.817110'),
(107, 'images/paoquan4.png', 54, '2022-12-24 15:45:04.828079'),
(108, 'images/paoquan5_3V04xs6.png', 54, '2022-12-24 15:45:04.842044'),
(109, 'images/paoquan6.png', 54, '2022-12-24 15:45:04.853569'),
(110, 'images/longwang.png', 55, '2022-12-24 15:52:43.108282'),
(111, 'images/longwang1.png', 55, '2022-12-24 15:53:03.736715'),
(112, 'images/longwang2.png', 55, '2022-12-24 15:53:03.752371'),
(113, 'images/longwang3.png', 55, '2022-12-24 15:53:03.765705'),
(114, 'images/longwang4_9xlhP6w.png', 55, '2022-12-24 15:53:03.777868'),
(115, 'images/longwang5.png', 55, '2022-12-24 15:53:03.798566'),
(116, 'images/longwang6.png', 55, '2022-12-24 15:53:03.817483'),
(117, 'images/lofit4_jY3EOHJ.png', 34, '2022-12-30 10:37:15.886037'),
(118, 'images/lofita_tU2d5iY.png', 34, '2022-12-30 10:37:15.898283'),
(119, 'images/lofita1_yq453U3.png', 34, '2022-12-30 10:37:15.909966'),
(120, 'images/lofita2_dInIx6L.png', 34, '2022-12-30 10:37:15.923129'),
(121, 'images/lofita3_VyFYwgm.png', 34, '2022-12-30 10:37:15.935956'),
(122, 'images/lofita5_f198Ijd.png', 34, '2022-12-30 10:37:15.953395'),
(123, 'images/almazcenter1_hnauf1F.png', 1, '2022-12-30 10:37:33.464164'),
(124, 'images/almazcenter2_z4JaAXb.png', 1, '2022-12-30 10:37:33.483113'),
(125, 'images/almazcenter3_W2sPvp4.png', 1, '2022-12-30 10:37:33.495404'),
(126, 'images/almazcenter4_DrdkXku.png', 1, '2022-12-30 10:37:33.507157'),
(127, 'images/almazcenter5_ReoTzaP.png', 1, '2022-12-30 10:37:33.516908'),
(128, 'images/almazcenter6_IXqOgRI.png', 1, '2022-12-30 10:37:33.530871'),
(129, 'images/longwang3_W1boYK6.png', 28, '2022-12-30 10:37:50.839362'),
(130, 'images/longwang4_oUUAV5P.png', 28, '2022-12-30 10:37:50.854361'),
(131, 'images/longwang5_eFGVcgf.png', 28, '2022-12-30 10:37:50.869508'),
(132, 'images/longwang6_lPtMpHE.png', 28, '2022-12-30 10:37:50.882473'),
(133, 'images/longwangloho_9WGFiEY.png', 28, '2022-12-30 10:37:50.892535'),
(134, 'images/maaaaa_u85fP8m.png', 28, '2022-12-30 10:37:50.907909'),
(135, 'images/timeline8_rZSlGbg.png', 29, '2022-12-30 10:38:10.498360'),
(136, 'images/trillrooftop1_Qsuvmfa.png', 29, '2022-12-30 10:38:10.511563'),
(137, 'images/trillrooftop2_pGnXy5j.png', 29, '2022-12-30 10:38:10.533662'),
(138, 'images/trillrooftop3_zckQPLT.png', 29, '2022-12-30 10:38:10.546521'),
(139, 'images/trillrooftop4_p8x6j2z.png', 29, '2022-12-30 10:38:10.560484'),
(140, 'images/trillrooftop5_qTebEvB.png', 29, '2022-12-30 10:38:10.594035'),
(141, 'images/trillrooftoplogo_WklawgJ.png', 29, '2022-12-30 10:38:10.606430'),
(142, 'images/ttmvincom_5L8Jgrl.png', 29, '2022-12-30 10:38:10.618892'),
(143, 'images/timeline2_0HeFEDY.png', 30, '2022-12-30 10:38:30.270772'),
(144, 'images/timeline3_NSSvKqQ.png', 30, '2022-12-30 10:38:30.284082'),
(145, 'images/timeline4_mKaoo7c.png', 30, '2022-12-30 10:38:30.303082'),
(146, 'images/timeline5_CUNf4Kx.png', 30, '2022-12-30 10:38:30.320768'),
(147, 'images/timeline6_khlYetT.png', 30, '2022-12-30 10:38:30.341714'),
(148, 'images/timeline7_2Cns59D.png', 30, '2022-12-30 10:38:30.357670'),
(149, 'images/ttmvincom1_2R41tyn.png', 31, '2022-12-30 10:38:49.099476'),
(150, 'images/ttmvincom2_KmdqfFr.png', 31, '2022-12-30 10:38:49.113915'),
(151, 'images/ttmvincom3_coJN3tf.png', 31, '2022-12-30 10:38:49.129576'),
(152, 'images/ttmvincom4_VNWPkpU.png', 31, '2022-12-30 10:38:49.149901'),
(153, 'images/ttmvincom5_J1iNYK3.png', 31, '2022-12-30 10:38:49.168358'),
(154, 'images/ttmvincom6_v8hC77F.png', 31, '2022-12-30 10:38:49.195061'),
(155, 'images/ttmvincom7_9eb7iHy.png', 31, '2022-12-30 10:38:49.211019'),
(156, 'images/ttmvincom8_44QFvlh.png', 31, '2022-12-30 10:38:49.225979'),
(157, 'images/ttmvincom1_EVA3Wie.png', 33, '2022-12-30 10:39:17.420341'),
(158, 'images/ttmvincom2_NF4OV6g.png', 33, '2022-12-30 10:39:17.432502'),
(159, 'images/ttmvincom3_gAh43XR.png', 33, '2022-12-30 10:39:17.448543'),
(160, 'images/ttmvincom4_wmkMhXL.png', 33, '2022-12-30 10:39:17.461509'),
(161, 'images/ttmvincom5_ueMno6W.png', 33, '2022-12-30 10:39:17.477466'),
(162, 'images/ttmvincom6_oCKJ2YW.png', 33, '2022-12-30 10:39:17.488435');

-- --------------------------------------------------------

--
-- Table structure for table `blog_location`
--

CREATE TABLE `blog_location` (
  `id` bigint(20) NOT NULL,
  `name` varchar(200) NOT NULL,
  `logo` varchar(100) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `image` varchar(100) NOT NULL,
  `wardcommune` varchar(100) NOT NULL,
  `district` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `address` varchar(200) NOT NULL,
  `costmin` varchar(10) NOT NULL,
  `costmax` varchar(10) NOT NULL,
  `describe` longtext DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `timeend` time(6) DEFAULT NULL,
  `timestart` time(6) DEFAULT NULL,
  `views` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `blog_location`
--

INSERT INTO `blog_location` (`id`, `name`, `logo`, `phone`, `image`, `wardcommune`, `district`, `city`, `address`, `costmin`, `costmax`, `describe`, `date`, `category_id`, `timeend`, `timestart`, `views`) VALUES
(1, 'Cafe Linnda', 'images/client-3.png', '0334456656', 'images/screen-7.jpg', 'Phường Trung Tự', 'Quận Đống Đa', 'Thành phố Hà Nội', '298 Tây Sơn', '50000', '120000', 'Sạch sẽ thoáng mát, trang trí rất đẹp', '2022-11-13 06:21:55.484586', 3, '06:49:56.911451', '06:49:56.951348', 209),
(28, 'Hadilao', 'images/client-22x_s0qozHr.png', '0334456656', 'images/screen-22.jpg', 'Xã Xuân Thủy', 'Huyện Kim Bôi', 'Tỉnh Hoà Bình', '125 Tây Sơn', '50000', '120000', 'Haidilao (海底捞, [note 1] Hải Để Lao) là hệ thống chuỗi nhà hàng lẩu được thành lập vào năm 1994 tại thành phố Giản Dương, tỉnh Tứ Xuyên,Lẩu Haidilao được định vị thương hiệu với mức giá từ trung bình đến cao cấp, với mức chi phí bình quân đầu người từ 150 đến 200 nhân dân tệ. Công ty còn được biết đến với dịch vụ chăm sóc khách hàng chu đáo như cung cấp tạp dề, chun buộc tóc, kẹp tóc và các mặt hàng khác trong cửa hàng, cung cấp dịch vụ chăm sóc trẻ em.', '2022-11-30 16:00:39.904615', 1, '06:49:56.911451', '06:49:56.951348', 36),
(29, 'Cafe Tình yêu', 'images/client-8.png', '0334456656', 'images/screen-12_VMhAQD1.jpg', 'Xã Sơn Lôi', 'Huyện Bình Xuyên', 'Tỉnh Vĩnh Phúc', '125 Ứng Yên', '120000', '250000', 'Sạch sẽ', '2022-12-04 08:15:55.430195', 3, '06:49:56.911451', '06:49:56.951348', 70),
(30, 'Phố đi bộ Hà Nội', 'images/client-4.png', '0334456656', 'images/screen-17_yJQlA2E.jpg', 'Phường Hàng Mã', 'Quận Hoàn Kiếm', 'Thành phố Hà Nội', 'Hoàn kiếm', '50000', '100000', 'Đông đúc, nơi cho các gia đình, bạn bè, các cặp đôi hẹn hò vui chơi', '2022-12-04 14:10:44.749845', 2, '06:49:56.911451', '06:49:56.951348', 163),
(31, 'Phố sách Hà Nội', 'images/logo2.png', '', 'images/screen-10.jpg', 'Xã Bum Tở', 'Huyện Mường Tè', 'Tỉnh Lai Châu', 'Phố 19 tháng 12', '50000', '150000', 'Phong trào \"sống ảo\" đã cập bến Phố sách Hà Nội. Thánh địa của dân mọt sách giờ đây được trang trí rất đẹp và bắt mắt nhé. Những bìa sách được đặt sát bên nhau trên các kệ gỗ tạo nên nét rất riêng cho Phố sách Hà Nội. Thật không có lý do gì để bỏ qua một địa điểm chụp hình đẹp ở Hà Nội như thế này và gẳn thẻ OOTD vào bức hình trên Instagram đúng không nào?', '2022-12-07 16:31:32.264916', 2, '22:00:00.000000', '08:00:00.000000', 249),
(32, 'Phố bích họa Phùng Hưng', 'images/bichhoa.png', '', 'images/bichhoa_avZmdQu.png', 'Phường Đồng Xuân', 'Quận Hoàn Kiếm', 'Thành phố Hà Nội', 'Phố Phùng Hưng', '25000', '50000', 'Màu sắc trẻ trung và nét vẽ phóng khoáng đã khiến diện mạo phố Phùng Hưng trở nên đầy sức sống, thu hút rất nhiều bạn trẻ đam mê hội họa, đặc biệt là tín đồ sống ảo. Tại đây, bạn sẽ nhìn thấy 17 tác phẩm tranh trên tổng số 127 vòm cầu, truyền tải thông điệp về một thủ đô Hà Nội nghìn năm văn hiến nhưng luôn tươi mới.', '2022-12-10 07:53:35.920932', 4, '22:00:00.000000', '08:00:00.000000', 54),
(33, 'Aeon Mall Long Biên', 'images/client-12x.png', '', 'images/aeonlongbien.png', 'Phường Long Biên', 'Quận Long Biên', 'Thành phố Hà Nội', 'Số 27, đường Cổ Linh', '25000', '100000', 'Aeon Mall luôn có sẵn vài khu để các bạn trẻ có thể sống ảo không biên giới. Từ cửa ra vào cho đến bãi đỗ xe đều tạo ra những bức ảnh “kool ngầu” khiến bạn không thể bỏ qua. Các fashionista và cửa hàng thời trang cũng tranh thủ mượn không gian của Aeon Mall Long Biên để chụp hình ngoại cảnh quảng bá sản phẩm chất lừ đấy.', '2022-12-10 08:03:58.902892', 5, '22:30:00.000000', '08:30:00.000000', 128),
(34, 'Thảo nguyên hoa Long Biên', 'images/client-3_4xRr4Ad.png', '', 'images/thoanguyenhoa.png', 'Xã Bản Liền', 'Huyện Bắc Hà', 'Tỉnh Lào Cai', 'Thạch Cầu', '25000', '100000', 'Đây không chỉ là điểm sống ảo được giới trẻ yêu thích mà còn nổi tiếng là địa điểm chụp ảnh cưới siêu đẹp ở Hà Nội. Thảo nguyên hoa Long Biên sở hữu các cánh đồng hoa rực rỡ, thơm mát với nhiều chủng loại phong phú như thạch thảo, súng tím, hồng tố nữ,…. Bên cạnh đó, nơi đây còn vô số cảnh đẹp khác như thung lũng mận trắng mộng mơ, trang trại cừu non xinh xắn,… Và chỉ cần bỏ ra 70.000 đồng vé vào cổng là bạn đã có thể thỏa sức chụp chọe để mang về những bức ảnh triệu like rồi.\r\nThảo nguyên hoa Long Biên là một địa điểm chụp ảnh đẹp ở Hà Nội lãng mạn dành cho các cặp đôi lẫn các bạn trẻ đam mê sống ảo\r\nThảo nguyên hoa Long Biên là một địa điểm chụp ảnh đẹp ở Hà Nội lãng mạn dành cho các cặp đôi lẫn các bạn trẻ đam mê sống ảo', '2022-12-10 08:08:47.875765', 4, '18:00:00.000000', '08:00:00.000000', 482),
(47, 'Timeline Cafe ', 'images/logotimeline_wCgHYXL.png', '0908261992', 'images/timeline4_NlPpGik.png', 'Phường Dịch Vọng Hậu', 'Quận Cầu Giấy', 'Thành phố Hà Nội', '79 Ngõ 260', '25000', '100000', 'Timeline Cafe được giới trẻ biết đến như một “Đà Lạt thu nhỏ” giữa thủ đô Hà Nội. Quán có rất nhiều góc đẹp để bạn sống ảo, nhận viên phục vụ nhiệt tình và niềm nở. Đặc biệt hơn, quán Timeline không sử dụng ống hút nhựa để góp phần bảo vệ môi trường xanh hiện nay.\r\nĐịa chỉ: Số 79 ngõ 260, đường Cầu Giấy, phường Quan Hoa, Quận Cầu Giấy, Hà Nội\r\nGiá đồ uống, món ăn: 25k – 48k\r\nDiện tích: 280m2\r\nTổng mức đầu tư 850tr\r\nPage: https://www.facebook.com/timelinecoffee79\r\n\r\n', '2022-12-24 12:39:31.449384', 3, '22:30:00.000000', '08:00:00.000000', 1),
(48, 'Lofita Cafe', 'images/lofitalogo.png', '', 'images/lofita.png', 'Xã Thái Sơn', 'Huyện Hàm Yên', 'Tỉnh Tuyên Quang', 'số 12 -14 Ấu Triệu', '50000', '200000', 'Lofita Tea & Coffee – Chuỗi quán cafe ngon, view đẹp đang gây sốt tại Hà Nội \r\n\r\nLofita được biết đến là một ngôi sao sáng trong \"làng Cafe\" Hà Nội với view đẹp, không gian decor lạ mắt để sống ảo, đặc biệt là đồ uống theo xu hướng hiện đại \"healthy and trendiez\". Trong 4 năm xây dưng và phát triển đã có 6 địa điểm tại những vị trí hot nhất Hà Nội trong đó có cả cở sở Lofita 261 Nguyễn Cao, TP. Bắc Minh.\r\nBên cạnh đó, ở đây còn được bố trí khá nhiều cây xanh tạo cảm giác mát mẻ, thoáng đãng. Đây sẽ là địa điểm lý tưởng cho những ai muốn hẹn hò và chụp hình cùng người thương nhé.', '2022-12-24 13:06:21.748680', 3, '22:00:00.000000', '07:30:00.000000', 0),
(49, 'Trill Rooftop', 'images/trillrooftoplogo.png', '', 'images/trillrooftop5.png', 'Phường Long Biên', 'Quận Long Biên', 'Thành phố Hà Nội', 'Tầng 26, Hei Tower', '25000', '100000', 'Nếu bạn là người thích trải nghiệm cảm giác vừa nhâm nhi cafe vừa ngắm Hà Nội từ trên cao thì Trill Rooftop Cafe là sự lựa chọn vô cùng hoàn hảo. Không gian ngoài trời được decor khá “chill” cùng với những chiếc gối ôm nhiều màu sắc vô cùng đẹp mắt. Những lọ hoa tươi handmade với tone màu trắng xanh hài hòa, dễ chịu. Ngoài ra, đồ uống và thức ăn của quán cũng khá đầy đủ và có mức giá không quá đắt. \r\nTrill Rooftop Cafe nổi tiếng với view rộng rãi, thoáng mát có cả không gian trong nhà lẫn ngoài trời. Đặc biệt quán còn có bể bơi. Ở đây buổi sáng thì hơi nắng tuy nhiên khi tối đến thì lại khá là lung linh. Phần sân thượng có thể giúp bạn ngắm 1 góc Hà Nội. Ở đây chắc chắn là địa chỉ bạn muốn tìm kiếm để “chill” cùng hội bạn rồi. Cứ một góc là sẽ có ngay một tấm hình đẹp đấy.', '2022-12-24 14:19:34.565366', 3, '22:30:00.000000', '08:30:00.000000', 0),
(50, 'Maison De Blanc - Bakery & Dessert Cafe ', 'images/maisonlogo.png', '', 'images/maaaaa.png', 'Phường Quảng An', 'Quận Tây Hồ', 'Thành phố Hà Nội', 'Nhà hàng – Việt Nam tại 5 Tây Hồ', '50000', '200000', 'Maison De Blanc – Bakery & Dessert Cafe\r\nMaison là quán cafe đẹp Hà Nội có cách bài trí mang đậm nét cổ kính Châu Âu. Đi vào 1 bước đã ngỡ như lạc sang nước Pháp thơ mộng. Ở đây, bạn có thể chọn giữa ngồi ở ngoài và ngồi ở trong nhà. Với những bạn muốn check-in sống ảo, tụ tập bạn bè thì ngồi ngoài là hợp nhất. Vì không gian rất thoáng, ánh sáng max luôn, bàn chụp flatlay ảo thôi rồi, background còn là căn biệt thự trắng lung linh xinh đẹp nữa.\r\nĐịa điểm: Nhà hàng – Việt Nam tại 5 Tây Hồ, P. Quảng An, Quận Tây Hồ, Hà Nội\r\nThời gian 9:00 – 22:00', '2022-12-24 14:54:46.602709', 3, '22:00:00.000000', '09:00:00.000000', 2),
(51, 'Vincom Mega Mall Royal City', 'images/ttmvincomlogo.png', '0246664999', 'images/ttmvincom1.png', 'Phường Thượng Đình', 'Quận Thanh Xuân', 'Thành phố Hà Nội', '72A Đ', '25000', '300000', 'Vincom Times City là một trong những trung tâm thương mại Hà Nội lớn nhất với tổng quy hoạch diện tích lên tới 200.000 m2, phân chia thành các khu mua sắm, ẩm thực, rạp chiếu phim, giải trí,… Không chỉ tọa lạc ở vị trí đắc địa, thuận tiện kết nối, Vincom Times City còn “chiêu đãi” du khách màn biểu diễn nhạc nước miễn phí với dàn âm thanh, ánh sáng hoành tráng vào 19h hằng ngày.\r\nĐặc biệt, nếu bạn đang tìm kiếm các khu vui chơi trong nhà ở Hà Nội thì Vincom Times City là điểm hẹn vô cùng lý tưởng. Tại đây, bạn có thể khám phá thủy cung đầu tiên giữa lòng Thủ đô với tổng diện tích lên tới 4.000 m2 – nơi sinh sống của hơn 30.000 sinh vật thuộc các phân khu như: khu hang động bò sát, khu nước mặn, khu nước ngọt…', '2022-12-24 15:08:46.406505', 5, '22:00:00.000000', '09:30:00.000000', 0),
(52, 'Almaz Center', 'images/Almazlogo.png', '0949898222', 'images/almazcenter.png', 'Phường Phú La', 'Quận Hà Đông', 'Thành phố Hà Nội', 'Đường Hoa Lan', '50000', '200000', 'Almaz Convention Center Hà Nội\r\nĐược thiết kế theo phong cách kiến trúc Baroque cổ điển, Almaz Convention Center Hà Nội toả sáng như một toà lâu đài Châu Âu tráng lệ thời Phục Hưng. Cùng với hệ thống trang thiết bị hiện đại, đẳng cấp quốc tế, Almaz tự hào là sự lựa chọn hàng đầu cho những sự kiện đẳng cấp và là nơi khởi đầu cho những hành trình hạnh phúc lứa đôi.\r\n\r\nVới các thiết kế đa dạng và linh hoạt, Almaz Convention Center Hà Nội đem đến 07 lựa chọn không gian khác nhau với diện tích từ 70m2 - 1.100 m2, sức chứa lên đến hơn 1.600 người, phù hợp với các sự kiện triển lãm lớn, các hội nghị mang tầm cỡ quốc gia - quốc tế.\r\n\r\nTổng diện tích: 2,5ha\r\n\r\nTổng số tầng: 02\r\n\r\nTầng 1 gồm 5 phòng nhỏ: Pink Diamond, Blue Diamond, Yellow Diamond, White Diamond, Black Diamond\r\n\r\nVới hệ thống trang thiết bị hàng đầu cả nước, thế mạnh ẩm thực chuyên sâu cùng hệ thống phòng tiệc linh hoạt, Almaz Convention Center Hà Nội đáp ứng đủ nhu cầu từ lớn đến nhỏ của tất cả các khách hàng mong muốn tổ chức sự kiện, hội nghị.', '2022-12-24 15:30:30.173556', 5, '23:00:00.000000', '07:00:00.000000', 2),
(53, 'The Garden Shopping Center', 'images/gardenlogo.png', '0243787550', 'images/319835576_1146892666190888_3501633734910250746_n.jpg', 'Phường Khương Mai', 'Quận Thanh Xuân', 'Thành phố Hà Nội', 'KĐT The Manor Hà Nội', '25000', '150000', 'Đắm chìm trong không gian Giáng sinh rực rỡ đầy màu sắc, âm nhạc ngân vang và những cây thông lấp lánh tại TTTM The Garden. Đừng quên những món quà mà chúng tôi đã chuẩn bị dành tặng riêng bạn, cùng những ưu đãi bất tận đón mùa lễ hội:\r\nTặng ngay hộp quà ông già Noel và người tuyết xinh xắn chứa đầy bánh kẹo Giáng Sinh ngọt ngào cho chi tiêu từ 1.8 triệu VNĐ\r\nƯu đãi bất tận từ Chương trình End of Season Sale của các thương hiệu yêu thích\r\nTô điểm quà tặng của bạn với dịch vụ gói quà miễn phí tại Trung tâm Dịch vụ Khách hàng (tầng 2)\r\nCheck-in bên cây thông khổng lồ rực rỡ, cùng với hiệu ứng tuyết rơi đặc biệt mà The Garden đã chuẩn bị để bạn có khoảnh khắc Giáng Sinh lung linh! Dùng ngay filter tại:\r\nhttps://www.facebook.com/fbcameraeffects/tryit/1136502363669534/', '2022-12-24 15:38:26.596208', 5, '22:30:00.000000', '08:00:00.000000', 2),
(54, 'Pao Quán', 'images/paoquanlogo.png', '098478933', 'images/paoquan5.png', 'Xã Kim Nỗ', 'Huyện Đông Anh', 'Thành phố Hà Nội', '33 Đinh Tiên Hoàng', '25000', '200000', 'Đến với Pao Quán (Rum Quán cũ), bạn sẽ có cơ hội được thưởng thức đủ các loại đặc sản của vùng Tây Bắc như: cải mèo Bắc Hà, rau tầm bóp, rau bò khai, mầm đá Sa Pa, lợn Bắc Hà 7 món, cá nướng,... Mỗi món ăn của quán ăn dân tộc tại Hà Nội này là một hương vị ẩm thực Tây Bắc đặc trưng khiến thực khách không chỉ cảm thấy ngon mà còn rất lạ miệng.\r\n\r\nKhoảng giá: 180.000 - 250.000 vnđ/người', '2022-12-24 15:44:37.942776', 1, '22:00:00.000000', '09:30:00.000000', 0),
(55, 'Hotpot Longwang', 'images/longwangloho.png', '1900636458', 'images/longwang4.png', 'Phường Quảng An', 'Quận Tây Hồ', 'Thành phố Hà Nội', '84 Ngọc Khánh', '100000', '250000', 'Cùng khám phá Nhà hàng lẩu hấp Hồng Kông Long Wang – Top nhà hàng Hà Nội ngon, nổi tiếng được thực khách vô cùng yêu thích. Long Wang sử dụng công nghệ hấp nhiệt số một Hồng Kông. Không dầu mỡ, không chiên rán, giữ trọn vẹn các vitamin và dưỡng chất. Mang đến cho khách hàng một bữa tiệc thơm ngon, đầy dinh dưỡng, lại rất tốt cho sức khỏe. \r\nNhà hàng sử dụng những nguyên liệu tươi sạch, được kiểm định kỹ càng theo quy trình khép kín. Nhằm mang đến cho khách hàng những món ăn  thơm ngon, chất lượng. Menu món ăn vô cùng đa dạng với hơn 50 món ăn đa dạng khác nhau từ các loại hải sản, thịt bò hảo hạng, cá, dimsum, rau củ….', '2022-12-24 15:52:21.202256', 1, '23:00:00.000000', '09:00:00.000000', 3),
(58, 'Thảo Cầm Viên', 'images/gardenlogo_qxPbKVW.png', '', 'images/thaocamvien.png', 'Phường Thảo Điền', 'Quận 2', 'Thành phố Hồ Chí Minh', ' 2 Nguyễn Bỉnh Khiêm', '25000', '50000', 'Với các cặp đôi muốn trải nghiệm cảm giác hòa mình cùng với thiên nhiên nhưng ngại đi chơi xa thì Thảo Cầm Viên TPHCM sẽ là một địa điểm lý tưởng dành cho cả hai. Với không gian rộng rãi với nhiều hoạt động thú vị, hai bạn sẽ có được không gian thoải mái để tham quan và vui chơi mà không lo ngại ngùng.\r\nNgoài ra, đây cũng là địa điểm lý tưởng cho những buổi picnic tụ hợp bạn bè. Thảo Cầm Viên là tọa độ “đổi gió” phù hợp với những cặp đôi muốn tìm địa điểm hẹn hò mới lạ.', '2023-01-02 04:58:17.131876', 4, '22:00:00.000000', '07:00:00.000000', 2);

-- --------------------------------------------------------

--
-- Table structure for table `blog_rating`
--

CREATE TABLE `blog_rating` (
  `id` bigint(20) NOT NULL,
  `rating` double DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  `detaillocation_id` bigint(20) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `blog_rating`
--

INSERT INTO `blog_rating` (`id`, `rating`, `author_id`, `detaillocation_id`, `status`, `date`) VALUES
(86, 2, 61, 47, 1, '2022-12-24 12:46:39.393651'),
(87, 2, 61, 55, 1, '2022-12-24 16:40:54.721950'),
(89, 4, 62, 28, 1, '2022-12-24 16:44:51.525391'),
(90, 3, 61, 34, 1, '2022-12-24 16:45:14.649242'),
(91, 5, 61, 50, 1, '2022-12-24 16:46:11.403234'),
(92, 5, 62, 50, 1, '2022-12-24 16:49:37.356553'),
(93, 2, 62, 55, 1, '2022-12-24 16:50:32.139589'),
(94, 0, 62, 47, 1, '2022-12-24 16:50:57.514173'),
(95, 4, 63, 47, 1, '2022-12-24 16:51:38.085754'),
(96, 3, 63, 55, 1, '2022-12-24 16:52:15.747279'),
(97, 1, 63, 28, 1, '2022-12-24 16:52:30.131851'),
(98, 2, 63, 50, 1, '2022-12-24 16:52:56.146775'),
(99, 4, 64, 55, 1, '2022-12-24 16:53:36.069155'),
(100, 0, 64, 34, 1, '2022-12-24 16:53:48.100165'),
(101, 0, 64, 50, 1, '2022-12-24 16:53:54.602186'),
(102, 4, 65, 55, 1, '2022-12-24 16:54:20.211176'),
(103, 1, 65, 50, 1, '2022-12-24 16:54:49.043260'),
(104, 1, 66, 28, 1, '2022-12-24 16:55:13.074293'),
(105, 5, 1, 47, 1, '2022-12-24 16:55:32.036198'),
(106, 4, 1, 55, 1, '2022-12-24 16:56:05.801095'),
(107, 2, 1, 28, 1, '2022-12-24 16:56:24.914548'),
(108, 2, 66, 34, 1, '2022-12-24 17:00:48.292276'),
(109, 5, 66, 53, 1, '2022-12-25 07:25:18.257833'),
(111, 4, 68, 52, 1, '2023-01-02 06:31:37.603815'),
(112, 4.5, 68, 58, 1, '2023-01-02 08:44:05.515100');

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2022-11-13 06:16:21.930891', '1', 'Nhà hàng', 1, '[{\"added\": {}}]', 11, 1),
(2, '2022-11-13 06:16:35.352214', '2', 'Khu vui chơi', 1, '[{\"added\": {}}]', 11, 1),
(3, '2022-11-13 06:16:49.728484', '3', 'Quán cafe', 1, '[{\"added\": {}}]', 11, 1),
(4, '2022-11-13 06:17:07.374479', '4', 'Danh lam thắng cảnh', 1, '[{\"added\": {}}]', 11, 1),
(5, '2022-11-13 06:17:17.841812', '5', 'Trung tâm thương mại', 1, '[{\"added\": {}}]', 11, 1),
(6, '2022-11-13 06:21:55.489581', '1', 'Cafe Linnda', 1, '[{\"added\": {}}]', 8, 1),
(7, '2022-11-13 10:28:41.057686', '2', 'nganga', 1, '[{\"added\": {}}]', 4, 1),
(8, '2022-11-13 10:28:50.818118', '2', 'nganga', 2, '[]', 4, 1),
(9, '2022-11-19 16:16:32.325726', '1', 'Comment object (1)', 3, '', 12, 1),
(10, '2022-11-19 16:17:18.951246', '28', 'Comment object (28)', 3, '', 12, 1),
(11, '2022-11-19 16:17:18.956380', '27', 'Comment object (27)', 3, '', 12, 1),
(12, '2022-11-19 16:17:18.958638', '26', 'Comment object (26)', 3, '', 12, 1),
(13, '2022-11-19 16:17:18.963963', '25', 'Comment object (25)', 3, '', 12, 1),
(14, '2022-11-19 16:17:18.965965', '24', 'Comment object (24)', 3, '', 12, 1),
(15, '2022-11-19 16:17:18.974305', '23', 'Comment object (23)', 3, '', 12, 1),
(16, '2022-11-19 16:17:18.981961', '22', 'Comment object (22)', 3, '', 12, 1),
(17, '2022-11-19 16:17:18.989486', '21', 'Comment object (21)', 3, '', 12, 1),
(18, '2022-11-19 16:17:18.997175', '20', 'Comment object (20)', 3, '', 12, 1),
(19, '2022-11-19 16:17:19.000482', '19', 'Comment object (19)', 3, '', 12, 1),
(20, '2022-11-19 16:17:19.003221', '18', 'Comment object (18)', 3, '', 12, 1),
(21, '2022-11-19 16:17:19.005900', '17', 'Comment object (17)', 3, '', 12, 1),
(22, '2022-11-19 16:17:19.008011', '16', 'Comment object (16)', 3, '', 12, 1),
(23, '2022-11-19 16:17:19.010184', '15', 'Comment object (15)', 3, '', 12, 1),
(24, '2022-11-19 16:17:19.014179', '14', 'Comment object (14)', 3, '', 12, 1),
(25, '2022-11-19 16:17:19.016570', '13', 'Comment object (13)', 3, '', 12, 1),
(26, '2022-11-19 16:17:19.021177', '12', 'Comment object (12)', 3, '', 12, 1),
(27, '2022-11-19 16:17:19.029606', '11', 'Comment object (11)', 3, '', 12, 1),
(28, '2022-11-19 16:17:19.037808', '10', 'Comment object (10)', 3, '', 12, 1),
(29, '2022-11-19 16:17:19.045752', '9', 'Comment object (9)', 3, '', 12, 1),
(30, '2022-11-19 16:17:19.053900', '8', 'Comment object (8)', 3, '', 12, 1),
(31, '2022-11-19 16:17:19.056807', '7', 'Comment object (7)', 3, '', 12, 1),
(32, '2022-11-19 16:17:19.059690', '6', 'Comment object (6)', 3, '', 12, 1),
(33, '2022-11-19 16:17:19.062689', '5', 'Comment object (5)', 3, '', 12, 1),
(34, '2022-11-19 16:17:19.065520', '4', 'Comment object (4)', 3, '', 12, 1),
(35, '2022-11-19 16:17:19.068093', '3', 'Comment object (3)', 3, '', 12, 1),
(36, '2022-11-19 16:17:19.071122', '2', 'Comment object (2)', 3, '', 12, 1),
(37, '2022-11-19 17:05:50.489985', '32', 'Comment object (32)', 2, '[{\"changed\": {\"fields\": [\"Rating\"]}}]', 12, 1),
(38, '2022-11-19 17:05:55.569955', '32', 'Comment object (32)', 2, '[{\"changed\": {\"fields\": [\"Rating\"]}}]', 12, 1),
(39, '2022-11-20 10:24:04.332050', '43', 'Comment object (43)', 3, '', 12, 1),
(40, '2022-11-20 10:24:04.337667', '42', 'Comment object (42)', 3, '', 12, 1),
(41, '2022-11-20 10:24:04.340048', '41', 'Comment object (41)', 3, '', 12, 1),
(42, '2022-11-20 10:24:04.344297', '40', 'Comment object (40)', 3, '', 12, 1),
(43, '2022-11-20 10:24:04.346698', '39', 'Comment object (39)', 3, '', 12, 1),
(44, '2022-11-20 10:24:04.349051', '38', 'Comment object (38)', 3, '', 12, 1),
(45, '2022-11-20 10:24:04.351710', '37', 'Comment object (37)', 3, '', 12, 1),
(46, '2022-11-20 10:24:04.363270', '36', 'Comment object (36)', 3, '', 12, 1),
(47, '2022-11-20 10:24:04.371790', '35', 'Comment object (35)', 3, '', 12, 1),
(48, '2022-11-20 10:24:04.378643', '34', 'Comment object (34)', 3, '', 12, 1),
(49, '2022-11-20 10:24:04.386313', '33', 'Comment object (33)', 3, '', 12, 1),
(50, '2022-11-20 10:24:04.389298', '32', 'Comment object (32)', 3, '', 12, 1),
(51, '2022-11-20 10:24:04.392306', '31', 'Comment object (31)', 3, '', 12, 1),
(52, '2022-11-20 10:24:04.395407', '30', 'Comment object (30)', 3, '', 12, 1),
(53, '2022-11-20 10:24:04.397962', '29', 'Comment object (29)', 3, '', 12, 1),
(54, '2022-11-20 11:20:19.755865', '44', 'Comment object (44)', 1, '[{\"added\": {}}]', 12, 1),
(55, '2022-11-24 07:59:52.424175', '1', 'Cafe Linnda', 2, '[{\"changed\": {\"fields\": [\"Logo\", \"Image\"]}}]', 8, 1),
(56, '2022-11-24 08:12:54.687466', '1', 'Cafe Linnda', 2, '[{\"changed\": {\"fields\": [\"Logo\"]}}]', 8, 1),
(57, '2022-11-24 08:14:04.568667', '1', 'Cafe Linnda', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 8, 1),
(58, '2022-11-26 06:22:34.251182', '5', 'Vincom Phạm Ngọc Thạch', 1, '[{\"added\": {}}]', 8, 1),
(59, '2022-11-26 07:01:24.171698', '15', '453454', 3, '', 8, 1),
(60, '2022-11-26 07:01:24.186200', '14', 'tre', 3, '', 8, 1),
(61, '2022-11-26 07:01:24.188573', '13', '43543', 3, '', 8, 1),
(62, '2022-11-26 07:01:24.191232', '12', '435345', 3, '', 8, 1),
(63, '2022-11-26 07:01:24.193231', '11', 'Phạm Nga', 3, '', 8, 1),
(64, '2022-11-26 07:01:24.195225', '10', 'Vincom Phạm Ngọc Thạch', 3, '', 8, 1),
(65, '2022-11-26 07:01:24.203858', '9', '43543', 3, '', 8, 1),
(66, '2022-11-26 07:01:24.211249', '8', '43543', 3, '', 8, 1),
(67, '2022-11-26 07:01:24.225744', '7', '43543', 3, '', 8, 1),
(68, '2022-11-26 07:01:24.227742', '6', '43543', 3, '', 8, 1),
(69, '2022-11-26 07:01:24.231551', '5', 'Vincom Phạm Ngọc Thạch', 3, '', 8, 1),
(70, '2022-11-26 07:01:24.234029', '4', 'Vincom Phạm Ngọc Thạch', 3, '', 8, 1),
(71, '2022-11-26 07:01:24.241108', '3', '35235', 3, '', 8, 1),
(72, '2022-11-26 07:01:24.243771', '2', '324', 3, '', 8, 1),
(73, '2022-11-26 18:01:28.719933', '25', 'testttt ảnh', 3, '', 8, 1),
(74, '2022-11-26 18:01:28.724841', '24', 'testttt ảnh', 3, '', 8, 1),
(75, '2022-11-26 18:01:28.727663', '23', 'testttt ảnh', 3, '', 8, 1),
(76, '2022-11-26 18:01:28.730655', '22', '324324', 3, '', 8, 1),
(77, '2022-11-26 18:01:28.733815', '21', '324324', 3, '', 8, 1),
(78, '2022-11-26 18:01:28.736125', '20', '324324', 3, '', 8, 1),
(79, '2022-11-26 18:01:28.738683', '19', '53453', 3, '', 8, 1),
(80, '2022-11-26 18:01:28.746132', '18', 'tesyt', 3, '', 8, 1),
(81, '2022-11-26 18:01:28.754189', '17', 'Phạm Nga', 3, '', 8, 1),
(82, '2022-11-26 18:01:28.762602', '16', 'Phạm Nga', 3, '', 8, 1),
(83, '2022-11-27 03:51:30.468903', '1', 'Cafe Linnda', 2, '[{\"changed\": {\"fields\": [\"Image\"]}}]', 8, 1),
(84, '2022-11-27 03:55:55.364663', '1', 'Cafe Linnda', 2, '[{\"changed\": {\"fields\": [\"Logo\"]}}]', 8, 1),
(85, '2022-11-29 16:01:48.499919', '26', 'Shogun', 3, '', 8, 1),
(86, '2022-12-05 16:47:18.329649', '3', 'Admin', 3, '', 4, 1),
(87, '2022-12-05 16:47:38.157624', '4', 'admin222', 3, '', 4, 1),
(88, '2022-12-06 15:53:28.660087', '5', 'nga@1234', 1, '[{\"added\": {}}]', 4, 1),
(89, '2022-12-06 15:55:44.269799', '5', 'nga@1234', 2, '[{\"changed\": {\"fields\": [\"User permissions\"]}}]', 4, 1),
(90, '2022-12-06 15:57:28.956759', '5', 'nga@1234', 2, '[{\"changed\": {\"fields\": [\"User permissions\"]}}]', 4, 1),
(91, '2022-12-06 16:01:53.822388', '5', 'nga@1234', 2, '[{\"changed\": {\"fields\": [\"Staff status\"]}}]', 4, 1),
(92, '2022-12-06 16:05:33.396887', '1', 'Khách hàng', 1, '[{\"added\": {}}]', 3, 1),
(93, '2022-12-06 16:06:17.012364', '2', 'Quản lý', 1, '[{\"added\": {}}]', 3, 1),
(94, '2022-12-06 16:06:46.754453', '1', 'Khách hàng', 2, '[]', 3, 1),
(95, '2022-12-06 16:07:49.983011', '5', 'nga@1234', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(96, '2022-12-06 16:08:09.916666', '2', 'nganga', 2, '[]', 4, 1),
(97, '2022-12-06 16:08:23.578844', '2', 'nganga', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(98, '2022-12-06 16:08:35.617659', '6', 'Ngatesst', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(99, '2022-12-06 16:48:43.409493', '5', 'nga@1234', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(100, '2022-12-06 17:05:57.220720', '3', 'RootAdmin', 1, '[{\"added\": {}}]', 3, 1),
(101, '2022-12-06 17:06:12.263045', '1', 'phamthiphuongnga', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(102, '2022-12-07 15:34:17.731932', '7', 'Test1', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(103, '2022-12-10 08:51:07.429291', '17', '2498765', 3, '', 4, 1),
(104, '2022-12-10 08:51:07.432309', '21', '312453542', 3, '', 4, 1),
(105, '2022-12-10 08:51:07.434278', '14', '3432432', 3, '', 4, 1),
(106, '2022-12-10 08:51:07.436272', '13', '343423', 3, '', 4, 1),
(107, '2022-12-10 08:51:07.438267', '22', '4432', 3, '', 4, 1),
(108, '2022-12-10 08:51:07.440262', '24', '78674645', 3, '', 4, 1),
(109, '2022-12-10 08:51:07.442258', '16', '8987756', 3, '', 4, 1),
(110, '2022-12-10 08:51:07.443256', '23', '996876', 3, '', 4, 1),
(111, '2022-12-10 08:51:07.445249', '12', 'ngatttt1111', 3, '', 4, 1),
(112, '2022-12-10 08:51:07.453227', '15', 'ngoc', 3, '', 4, 1),
(113, '2022-12-10 08:51:07.460244', '20', 'tesssss', 3, '', 4, 1),
(114, '2022-12-10 08:51:07.467609', '7', 'Test1', 3, '', 4, 1),
(115, '2022-12-10 08:51:07.475708', '10', 'Testpq', 3, '', 4, 1),
(116, '2022-12-10 08:51:07.479172', '9', 'Testtttt9798', 3, '', 4, 1),
(117, '2022-12-10 08:51:07.481425', '11', 'tétttttttttttttttttttttttttttt', 3, '', 4, 1),
(118, '2022-12-10 08:51:07.484131', '18', 'trew4453', 3, '', 4, 1),
(119, '2022-12-10 08:51:07.485991', '19', 'trew445355435', 3, '', 4, 1),
(120, '2022-12-10 14:13:09.941299', '1', 'Hadilao', 1, '[{\"added\": {}}]', 18, 1),
(121, '2022-12-10 14:17:03.722255', '2', 'Cafe Tình yêu', 1, '[{\"added\": {}}]', 18, 1),
(122, '2022-12-10 14:38:30.682796', '4', 'Phố đi bộ Hà Nội', 3, '', 18, 1),
(123, '2022-12-10 14:38:30.685788', '3', 'Phố đi bộ Hà Nội', 3, '', 18, 1),
(124, '2022-12-10 15:04:58.729798', '9', 'Aeon Mall Long Biên', 3, '', 18, 1),
(125, '2022-12-10 15:04:58.736819', '8', 'Aeon Mall Long Biên', 3, '', 18, 1),
(126, '2022-12-10 15:04:58.739781', '7', 'Aeon Mall Long Biên', 3, '', 18, 1),
(127, '2022-12-10 15:10:53.566026', '1', 'Khách hàng', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 3, 1),
(129, '2022-12-10 15:51:02.915822', '12', 'Phố bích họa Phùng Hưng', 1, '[{\"added\": {}}]', 18, 1),
(130, '2022-12-10 15:51:13.290411', '12', 'Thảo nguyên hoa Long Biên', 2, '[{\"changed\": {\"fields\": [\"Detaillocation\"]}}]', 18, 1),
(131, '2022-12-10 16:52:27.605867', '32', '4543', 3, '', 4, 1),
(132, '2022-12-10 16:52:27.610851', '28', '4543534', 3, '', 4, 1),
(133, '2022-12-10 16:52:27.612848', '29', '46554654', 3, '', 4, 1),
(134, '2022-12-10 16:52:27.614842', '27', '4fffdfxfdrwer', 3, '', 4, 1),
(135, '2022-12-10 16:52:27.616836', '31', '5654', 3, '', 4, 1),
(136, '2022-12-10 16:52:27.619829', '30', '6665', 3, '', 4, 1),
(137, '2022-12-10 16:52:27.621823', '6', 'Ngatesst', 3, '', 4, 1),
(138, '2022-12-10 16:52:27.623818', '26', 'Ngatestdk', 3, '', 4, 1),
(139, '2022-12-10 16:52:27.625813', '25', 'Testgoiy', 3, '', 4, 1),
(140, '2022-12-10 17:45:25.372014', '40', 'tttttttttttt', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(141, '2022-12-10 18:41:38.680315', '16', 'Thảo nguyên hoa Long Biên', 3, '', 18, 1),
(155, '2022-12-11 13:00:11.858742', '18', 'Thảo nguyên hoa Long Biên', 3, '', 18, 1),
(156, '2022-12-11 13:00:11.863727', '17', 'Cafe Linnda', 3, '', 18, 1),
(157, '2022-12-11 13:00:11.865875', '15', 'Cafe Linnda', 3, '', 18, 1),
(158, '2022-12-11 13:00:11.868769', '13', 'Phố bích họa Phùng Hưng', 3, '', 18, 1),
(159, '2022-12-11 13:00:11.871780', '12', 'Thảo nguyên hoa Long Biên', 3, '', 18, 1),
(160, '2022-12-11 13:00:11.873756', '11', 'Thảo nguyên hoa Long Biên', 3, '', 18, 1),
(161, '2022-12-11 13:00:11.875750', '10', 'Thảo nguyên hoa Long Biên', 3, '', 18, 1),
(162, '2022-12-11 13:37:11.997751', '23', 'Aeon Mall Long Biên', 3, '', 18, 1),
(163, '2022-12-11 13:37:12.001740', '22', 'Hadilao', 3, '', 18, 1),
(164, '2022-12-11 13:37:12.003745', '21', 'Thảo nguyên hoa Long Biên', 3, '', 18, 1),
(165, '2022-12-11 13:37:12.004731', '20', 'Aeon Mall Long Biên', 3, '', 18, 1),
(166, '2022-12-11 13:37:12.006726', '19', 'Thảo nguyên hoa Long Biên', 3, '', 18, 1),
(167, '2022-12-11 13:37:12.008721', '6', 'Aeon Mall Long Biên', 3, '', 18, 1),
(168, '2022-12-11 13:37:12.010717', '5', 'Phố đi bộ Hà Nội', 3, '', 18, 1),
(169, '2022-12-11 13:37:12.012710', '2', 'Cafe Tình yêu', 3, '', 18, 1),
(170, '2022-12-11 13:37:12.014705', '1', 'Hadilao', 3, '', 18, 1),
(171, '2022-12-12 08:34:43.446466', '3', 'RootAdmin', 3, '', 3, 1),
(172, '2022-12-12 08:34:54.686594', '2', 'Người quản lý', 2, '[{\"changed\": {\"fields\": [\"Name\"]}}]', 3, 1),
(173, '2022-12-12 08:37:41.773596', '43', 'phamngaagaaa', 1, '[{\"added\": {}}]', 4, 1),
(174, '2022-12-12 08:38:37.486300', '43', 'phamngaagaaa', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(175, '2022-12-12 10:08:00.582106', '36', '12345', 3, '', 4, 1),
(176, '2022-12-12 10:08:00.585522', '34', '214324', 3, '', 4, 1),
(177, '2022-12-12 10:08:00.588319', '35', '2321', 3, '', 4, 1),
(178, '2022-12-12 10:08:00.591029', '38', '4234234', 3, '', 4, 1),
(179, '2022-12-12 10:08:00.594016', '39', '54656', 3, '', 4, 1),
(180, '2022-12-12 10:08:00.596767', '37', '785856', 3, '', 4, 1),
(181, '2022-12-12 10:08:00.599619', '41', '789ttyyyyy', 3, '', 4, 1),
(182, '2022-12-12 10:08:00.601948', '5', 'nga@1234', 3, '', 4, 1),
(183, '2022-12-12 10:08:12.570034', '33', '1234', 3, '', 4, 1),
(184, '2022-12-12 15:09:42.668909', '42', 'Ngatesst', 3, '', 4, 1),
(185, '2022-12-12 15:09:42.677009', '8', 'ngaxinhgai', 3, '', 4, 1),
(186, '2022-12-12 15:09:42.677009', '43', 'phamngaagaaa', 3, '', 4, 1),
(187, '2022-12-12 15:09:42.684886', '40', 'tttttttttttt', 3, '', 4, 1),
(188, '2022-12-12 15:10:54.443976', '44', 'ngochan', 1, '[{\"added\": {}}]', 4, 1),
(189, '2022-12-13 03:31:16.357485', '44', 'ngochan', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(190, '2022-12-13 07:32:44.499093', '31', 'Phố sách Hà Nội', 2, '[{\"changed\": {\"fields\": [\"Author\", \"Rating\"]}}]', 18, 1),
(191, '2022-12-13 14:42:17.636680', '35', 'Thảo nguyên hoa Long Biên', 2, '[{\"changed\": {\"fields\": [\"Rating\"]}}]', 18, 1),
(192, '2022-12-13 14:54:02.782214', '45', 'Phố sách Hà Nội', 3, '', 18, 1),
(193, '2022-12-13 14:54:02.790178', '44', 'Phố sách Hà Nội', 3, '', 18, 1),
(194, '2022-12-13 14:54:02.790178', '43', 'Phố sách Hà Nội', 3, '', 18, 1),
(195, '2022-12-13 14:54:02.790178', '42', 'Phố sách Hà Nội', 3, '', 18, 1),
(196, '2022-12-13 14:54:02.798178', '41', 'Thảo nguyên hoa Long Biên', 3, '', 18, 1),
(197, '2022-12-13 14:54:02.798178', '40', 'Thảo nguyên hoa Long Biên', 3, '', 18, 1),
(198, '2022-12-13 14:54:02.798178', '39', 'Thảo nguyên hoa Long Biên', 3, '', 18, 1),
(199, '2022-12-13 14:54:02.798178', '38', 'Thảo nguyên hoa Long Biên', 3, '', 18, 1),
(200, '2022-12-13 14:54:02.798178', '37', 'Thảo nguyên hoa Long Biên', 3, '', 18, 1),
(201, '2022-12-13 14:54:02.806177', '36', 'Phố sách Hà Nội', 3, '', 18, 1),
(202, '2022-12-13 14:54:02.814212', '35', 'Thảo nguyên hoa Long Biên', 3, '', 18, 1),
(203, '2022-12-13 14:54:02.822238', '34', 'Phố sách Hà Nội', 3, '', 18, 1),
(204, '2022-12-13 14:54:02.830329', '33', 'Cafe Linnda', 3, '', 18, 1),
(205, '2022-12-13 14:54:02.830329', '32', 'Hadilao', 3, '', 18, 1),
(206, '2022-12-13 14:54:02.838191', '31', 'Phố sách Hà Nội', 3, '', 18, 1),
(207, '2022-12-13 14:54:02.838191', '30', 'Phố bích họa Phùng Hưng', 3, '', 18, 1),
(208, '2022-12-13 14:54:02.838191', '29', 'Phố đi bộ Hà Nội', 3, '', 18, 1),
(209, '2022-12-13 14:54:02.846179', '28', 'Cafe Tình yêu', 3, '', 18, 1),
(210, '2022-12-13 14:54:02.846179', '27', 'Thảo nguyên hoa Long Biên', 3, '', 18, 1),
(211, '2022-12-14 05:51:57.897987', '46', 'Thảo nguyên hoa Long Biên', 3, '', 18, 1),
(212, '2022-12-14 14:55:13.445087', '45', 'ngatesst', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(213, '2022-12-14 14:55:23.741778', '46', 'Test1', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(214, '2022-12-14 15:03:30.190890', '1', 'Custom', 2, '[{\"changed\": {\"fields\": [\"Name\"]}}]', 3, 1),
(215, '2022-12-14 15:03:45.925766', '2', 'Manager', 2, '[{\"changed\": {\"fields\": [\"Name\"]}}]', 3, 1),
(216, '2022-12-14 15:03:59.454433', '1', 'Customer', 2, '[{\"changed\": {\"fields\": [\"Name\"]}}]', 3, 1),
(217, '2022-12-14 15:14:14.537224', '47', 'Cuss1', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(218, '2022-12-15 02:07:46.726467', '2', 'Manager', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 3, 1),
(219, '2022-12-15 02:07:55.070360', '1', 'phamthiphuongnga', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(220, '2022-12-15 02:08:38.062256', '2', 'Manager', 2, '[]', 3, 1),
(221, '2022-12-15 08:56:12.083851', '10', 'Thảo nguyên hoa Long Biên', 3, '', 19, 1),
(222, '2022-12-15 08:56:12.087841', '9', 'Thảo nguyên hoa Long Biên', 3, '', 19, 1),
(223, '2022-12-15 08:56:12.089834', '8', 'Thảo nguyên hoa Long Biên', 3, '', 19, 1),
(224, '2022-12-15 08:56:12.092827', '7', 'Thảo nguyên hoa Long Biên', 3, '', 19, 1),
(225, '2022-12-15 08:56:12.094824', '6', 'Thảo nguyên hoa Long Biên', 3, '', 19, 1),
(226, '2022-12-15 08:56:12.095819', '5', 'Thảo nguyên hoa Long Biên', 3, '', 19, 1),
(227, '2022-12-15 08:56:12.097814', '4', 'Thảo nguyên hoa Long Biên', 3, '', 19, 1),
(228, '2022-12-15 08:56:12.099809', '3', 'Thảo nguyên hoa Long Biên', 3, '', 19, 1),
(229, '2022-12-15 08:56:12.100807', '2', 'Thảo nguyên hoa Long Biên', 3, '', 19, 1),
(230, '2022-12-15 08:56:12.108791', '1', 'Thảo nguyên hoa Long Biên', 3, '', 19, 1),
(231, '2022-12-15 09:27:51.103023', '23', 'Aeon Mall Long Biên', 3, '', 19, 1),
(232, '2022-12-15 09:27:51.107011', '22', 'Aeon Mall Long Biên', 3, '', 19, 1),
(233, '2022-12-15 09:27:51.109007', '21', 'Aeon Mall Long Biên', 3, '', 19, 1),
(234, '2022-12-15 09:27:51.111001', '20', 'Aeon Mall Long Biên', 3, '', 19, 1),
(235, '2022-12-15 09:27:51.112996', '19', 'Aeon Mall Long Biên', 3, '', 19, 1),
(236, '2022-12-15 09:27:51.114991', '18', 'Aeon Mall Long Biên', 3, '', 19, 1),
(237, '2022-12-15 09:27:51.116985', '17', 'Aeon Mall Long Biên', 3, '', 19, 1),
(238, '2022-12-15 09:27:51.118980', '16', 'Aeon Mall Long Biên', 3, '', 19, 1),
(239, '2022-12-15 09:27:51.126963', '15', 'Aeon Mall Long Biên', 3, '', 19, 1),
(240, '2022-12-15 09:27:51.134936', '14', 'Aeon Mall Long Biên', 3, '', 19, 1),
(241, '2022-12-15 09:27:51.141917', '13', 'Aeon Mall Long Biên', 3, '', 19, 1),
(242, '2022-12-15 09:27:51.150895', '12', 'Aeon Mall Long Biên', 3, '', 19, 1),
(243, '2022-12-15 09:27:51.152888', '11', 'Thảo nguyên hoa Long Biên', 3, '', 19, 1),
(244, '2022-12-15 11:17:51.041453', '107', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(245, '2022-12-15 11:17:51.047438', '106', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(246, '2022-12-15 11:17:51.048434', '105', 'Thảo nguyên hoa Long Biên', 3, '', 19, 1),
(247, '2022-12-15 11:17:51.050429', '104', 'Thảo nguyên hoa Long Biên', 3, '', 19, 1),
(248, '2022-12-15 11:17:51.051426', '103', 'Phố đi bộ Hà Nội', 3, '', 19, 1),
(249, '2022-12-15 11:17:51.053422', '102', 'Phố đi bộ Hà Nội', 3, '', 19, 1),
(250, '2022-12-15 11:17:51.055415', '101', 'Phố đi bộ Hà Nội', 3, '', 19, 1),
(251, '2022-12-15 11:17:51.057410', '100', 'Cafe Linnda', 3, '', 19, 1),
(252, '2022-12-15 11:17:51.059406', '99', 'Cafe Linnda', 3, '', 19, 1),
(253, '2022-12-15 11:17:51.065388', '98', 'Cafe Linnda', 3, '', 19, 1),
(254, '2022-12-15 11:17:51.072370', '97', 'Cafe Linnda', 3, '', 19, 1),
(255, '2022-12-15 11:17:51.080349', '96', 'Cafe Linnda', 3, '', 19, 1),
(256, '2022-12-15 11:17:51.087329', '95', 'Cafe Linnda', 3, '', 19, 1),
(257, '2022-12-15 11:17:51.089325', '94', 'Cafe Linnda', 3, '', 19, 1),
(258, '2022-12-15 11:17:51.091319', '93', 'Thảo nguyên hoa Long Biên', 3, '', 19, 1),
(259, '2022-12-15 11:17:51.093314', '92', 'Aeon Mall Long Biên', 3, '', 19, 1),
(260, '2022-12-15 11:17:51.094315', '91', 'Aeon Mall Long Biên', 3, '', 19, 1),
(261, '2022-12-15 11:17:51.096306', '90', 'Aeon Mall Long Biên', 3, '', 19, 1),
(262, '2022-12-15 11:17:51.097304', '89', 'Aeon Mall Long Biên', 3, '', 19, 1),
(263, '2022-12-15 11:17:51.099298', '88', 'Aeon Mall Long Biên', 3, '', 19, 1),
(264, '2022-12-15 11:17:51.101294', '87', 'Aeon Mall Long Biên', 3, '', 19, 1),
(265, '2022-12-15 11:17:51.108273', '86', 'Aeon Mall Long Biên', 3, '', 19, 1),
(266, '2022-12-15 11:17:51.115254', '85', 'Aeon Mall Long Biên', 3, '', 19, 1),
(267, '2022-12-15 11:17:51.122237', '84', 'Aeon Mall Long Biên', 3, '', 19, 1),
(268, '2022-12-15 11:17:51.129217', '83', 'Aeon Mall Long Biên', 3, '', 19, 1),
(269, '2022-12-15 11:17:51.131214', '82', 'Aeon Mall Long Biên', 3, '', 19, 1),
(270, '2022-12-15 11:17:51.132211', '81', 'Aeon Mall Long Biên', 3, '', 19, 1),
(271, '2022-12-15 11:17:51.134204', '80', 'Aeon Mall Long Biên', 3, '', 19, 1),
(272, '2022-12-15 11:17:51.137197', '79', 'Aeon Mall Long Biên', 3, '', 19, 1),
(273, '2022-12-15 11:17:51.139192', '78', 'Aeon Mall Long Biên', 3, '', 19, 1),
(274, '2022-12-15 11:17:51.141187', '77', 'Aeon Mall Long Biên', 3, '', 19, 1),
(275, '2022-12-15 11:17:51.147205', '76', 'Aeon Mall Long Biên', 3, '', 19, 1),
(276, '2022-12-15 11:17:51.154189', '75', 'Aeon Mall Long Biên', 3, '', 19, 1),
(277, '2022-12-15 11:17:51.162132', '74', 'Aeon Mall Long Biên', 3, '', 19, 1),
(278, '2022-12-15 11:17:51.169113', '73', 'Aeon Mall Long Biên', 3, '', 19, 1),
(279, '2022-12-15 11:17:51.171108', '72', 'Aeon Mall Long Biên', 3, '', 19, 1),
(280, '2022-12-15 11:17:51.173103', '71', 'Aeon Mall Long Biên', 3, '', 19, 1),
(281, '2022-12-15 11:17:51.174098', '70', 'Aeon Mall Long Biên', 3, '', 19, 1),
(282, '2022-12-15 11:17:51.176092', '69', 'Aeon Mall Long Biên', 3, '', 19, 1),
(283, '2022-12-15 11:17:51.178088', '68', 'Aeon Mall Long Biên', 3, '', 19, 1),
(284, '2022-12-15 11:17:51.180082', '67', 'Aeon Mall Long Biên', 3, '', 19, 1),
(285, '2022-12-15 11:17:51.181079', '66', 'Aeon Mall Long Biên', 3, '', 19, 1),
(286, '2022-12-15 11:17:51.182080', '65', 'Aeon Mall Long Biên', 3, '', 19, 1),
(287, '2022-12-15 11:17:51.189059', '64', 'Aeon Mall Long Biên', 3, '', 19, 1),
(288, '2022-12-15 11:17:51.196038', '63', 'Aeon Mall Long Biên', 3, '', 19, 1),
(289, '2022-12-15 11:17:51.204018', '62', 'Aeon Mall Long Biên', 3, '', 19, 1),
(290, '2022-12-15 11:17:51.210998', '61', 'Aeon Mall Long Biên', 3, '', 19, 1),
(291, '2022-12-15 11:17:51.211997', '60', 'Aeon Mall Long Biên', 3, '', 19, 1),
(292, '2022-12-15 11:17:51.213991', '59', 'Aeon Mall Long Biên', 3, '', 19, 1),
(293, '2022-12-15 11:17:51.215986', '58', 'Aeon Mall Long Biên', 3, '', 19, 1),
(294, '2022-12-15 11:17:51.216984', '57', 'Aeon Mall Long Biên', 3, '', 19, 1),
(295, '2022-12-15 11:17:51.218979', '56', 'Aeon Mall Long Biên', 3, '', 19, 1),
(296, '2022-12-15 11:17:51.219975', '55', 'Aeon Mall Long Biên', 3, '', 19, 1),
(297, '2022-12-15 11:17:51.221971', '54', 'Aeon Mall Long Biên', 3, '', 19, 1),
(298, '2022-12-15 11:17:51.223966', '53', 'Aeon Mall Long Biên', 3, '', 19, 1),
(299, '2022-12-15 11:17:51.230950', '52', 'Aeon Mall Long Biên', 3, '', 19, 1),
(300, '2022-12-15 11:17:51.236930', '51', 'Aeon Mall Long Biên', 3, '', 19, 1),
(301, '2022-12-15 11:17:51.244908', '50', 'Aeon Mall Long Biên', 3, '', 19, 1),
(302, '2022-12-15 11:17:51.250891', '49', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(303, '2022-12-15 11:17:51.252897', '48', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(304, '2022-12-15 11:17:51.256876', '47', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(305, '2022-12-15 11:17:51.257874', '46', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(306, '2022-12-15 11:17:51.259868', '45', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(307, '2022-12-15 11:17:51.260875', '44', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(308, '2022-12-15 11:17:51.262860', '43', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(309, '2022-12-15 11:17:51.263859', '42', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(310, '2022-12-15 11:17:51.265853', '41', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(311, '2022-12-15 11:17:51.272833', '40', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(312, '2022-12-15 11:17:51.279814', '39', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(313, '2022-12-15 11:17:51.286796', '38', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(314, '2022-12-15 11:17:51.293778', '37', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(315, '2022-12-15 11:17:51.295773', '36', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(316, '2022-12-15 11:17:51.296770', '35', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(317, '2022-12-15 11:17:51.297767', '34', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(318, '2022-12-15 11:17:51.299762', '33', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(319, '2022-12-15 11:17:51.301758', '32', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(320, '2022-12-15 11:17:51.303751', '31', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(321, '2022-12-15 11:17:51.310732', '30', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(322, '2022-12-15 11:17:51.317713', '29', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(323, '2022-12-15 11:17:51.324695', '28', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(324, '2022-12-15 11:17:51.331676', '27', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(325, '2022-12-15 11:17:51.333670', '26', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(326, '2022-12-15 11:17:51.335666', '25', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(327, '2022-12-15 11:17:51.336663', '24', 'Phố bích họa Phùng Hưng', 3, '', 19, 1),
(328, '2022-12-16 18:22:06.926593', '116', 'Aeon Mall Long Biên viewed: 2022-12-16 18:08:06.236876+00:00', 2, '[{\"changed\": {\"fields\": [\"User\"]}}]', 19, 1),
(329, '2022-12-17 07:43:17.122343', '61', 'Phố đi bộ Hà Nội', 3, '', 18, 1),
(330, '2022-12-17 07:43:17.127147', '59', 'Aeon Mall Long Biên', 3, '', 18, 1),
(331, '2022-12-17 07:43:17.131179', '58', 'Aeon Mall Long Biên', 3, '', 18, 1),
(332, '2022-12-17 07:43:17.136373', '57', 'Aeon Mall Long Biên', 3, '', 18, 1),
(333, '2022-12-17 07:43:17.140953', '56', 'Aeon Mall Long Biên', 3, '', 18, 1),
(334, '2022-12-17 07:43:17.145059', '55', 'Aeon Mall Long Biên', 3, '', 18, 1),
(335, '2022-12-17 09:20:25.688236', '195', 'History object (195)', 3, '', 19, 1),
(336, '2022-12-17 09:20:25.699310', '194', 'History object (194)', 3, '', 19, 1),
(337, '2022-12-17 09:20:25.703302', '193', 'History object (193)', 3, '', 19, 1),
(338, '2022-12-17 09:20:25.707256', '192', 'History object (192)', 3, '', 19, 1),
(339, '2022-12-17 09:20:25.718233', '191', 'History object (191)', 3, '', 19, 1),
(340, '2022-12-17 09:20:25.723214', '190', 'History object (190)', 3, '', 19, 1),
(341, '2022-12-17 09:20:25.731192', '189', 'History object (189)', 3, '', 19, 1),
(342, '2022-12-17 09:20:25.736179', '188', 'History object (188)', 3, '', 19, 1),
(343, '2022-12-17 09:20:25.737178', '187', 'History object (187)', 3, '', 19, 1),
(344, '2022-12-17 10:40:14.680305', '64', 'Phố đi bộ Hà Nội', 3, '', 18, 1),
(345, '2022-12-17 10:40:31.695564', '65', 'Phố bích họa Phùng Hưng', 3, '', 18, 1),
(346, '2022-12-17 10:40:31.699554', '63', 'Cafe Tình yêu', 3, '', 18, 1),
(347, '2022-12-17 10:40:31.703547', '62', 'Phố sách Hà Nội', 3, '', 18, 1),
(348, '2022-12-17 10:40:31.707537', '60', 'Cafe Linnda', 3, '', 18, 1),
(349, '2022-12-17 10:40:31.710536', '54', 'Aeon Mall Long Biên', 3, '', 18, 1),
(350, '2022-12-17 10:40:31.712520', '53', 'Thảo nguyên hoa Long Biên', 3, '', 18, 1),
(351, '2022-12-17 16:03:05.941162', '67', 'Aeon Mall Long Biên', 3, '', 18, 1),
(352, '2022-12-17 16:03:05.944896', '66', 'Aeon Mall Long Biên', 3, '', 18, 1),
(353, '2022-12-17 16:03:05.952153', '52', 'Cafe Linnda', 3, '', 18, 1),
(354, '2022-12-17 16:03:05.960632', '51', 'Cafe Tình yêu', 3, '', 18, 1),
(355, '2022-12-17 16:03:05.967424', '50', 'Cafe Linnda', 3, '', 18, 1),
(356, '2022-12-17 16:03:05.975301', '49', 'Aeon Mall Long Biên', 3, '', 18, 1),
(357, '2022-12-17 16:03:05.977634', '48', 'Thảo nguyên hoa Long Biên', 3, '', 18, 1),
(358, '2022-12-17 16:03:05.979650', '47', 'Thảo nguyên hoa Long Biên', 3, '', 18, 1),
(359, '2022-12-18 08:19:50.467134', '17', '5656', 3, '', 11, 1),
(360, '2022-12-18 08:19:50.472177', '16', '5451345', 3, '', 11, 1),
(361, '2022-12-18 08:19:50.474791', '15', '653', 3, '', 11, 1),
(362, '2022-12-18 08:19:50.477432', '14', '421', 3, '', 11, 1),
(363, '2022-12-18 08:19:50.481335', '13', '421', 3, '', 11, 1),
(364, '2022-12-18 08:19:50.483535', '12', '6342', 3, '', 11, 1),
(365, '2022-12-18 08:19:50.486218', '11', '342242', 3, '', 11, 1),
(366, '2022-12-18 08:19:50.488892', '10', '786543', 3, '', 11, 1),
(367, '2022-12-18 08:19:50.491544', '9', '32423', 3, '', 11, 1),
(368, '2022-12-18 08:19:50.499267', '8', '34232', 3, '', 11, 1),
(369, '2022-12-18 08:19:50.507458', '7', 'adsafadf', 3, '', 11, 1),
(370, '2022-12-18 08:19:50.515450', '6', 'Abc', 3, '', 11, 1),
(371, '2022-12-18 08:53:56.262832', '1', 'phamthiphuongnga', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(372, '2022-12-18 09:04:34.031215', '1', 'phamthiphuongnga', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(373, '2022-12-18 09:06:41.822775', '1', 'Customer', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 3, 1),
(374, '2022-12-18 09:06:58.827050', '2', 'Manager', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 3, 1),
(375, '2022-12-18 09:18:49.424993', '35', 'Phố sách Hà Nội', 3, '', 13, 1),
(376, '2022-12-18 11:52:48.814051', '58', '213123', 3, '', 4, 1),
(377, '2022-12-18 11:52:48.817040', '59', '31231', 3, '', 4, 1),
(378, '2022-12-18 11:52:48.819036', '60', '7rrfđ', 3, '', 4, 1),
(379, '2022-12-19 18:59:09.835733', '43', '45425', 3, '', 8, 1),
(380, '2022-12-19 19:13:58.295713', '44', '4324223', 3, '', 8, 1),
(381, '2022-12-19 19:31:16.492268', '45', '432423', 3, '', 8, 1),
(382, '2022-12-19 19:42:58.185949', '46', '75gdfg', 3, '', 8, 1),
(383, '2022-12-20 18:33:02.794274', '75', 'Phố bích họa Phùng Hưng', 3, '', 18, 1),
(384, '2022-12-20 18:33:02.797898', '74', 'Hadilao', 3, '', 18, 1),
(385, '2022-12-20 18:33:02.799902', '73', 'Cafe Tình yêu', 3, '', 18, 1),
(386, '2022-12-20 18:33:02.801886', '72', 'Phố sách Hà Nội', 3, '', 18, 1),
(387, '2022-12-20 18:33:02.805876', '71', 'Thảo nguyên hoa Long Biên', 3, '', 18, 1),
(388, '2022-12-20 18:33:02.807871', '70', 'Phố sách Hà Nội', 3, '', 18, 1),
(389, '2022-12-20 18:33:02.809865', '69', 'Phố bích họa Phùng Hưng', 3, '', 18, 1),
(390, '2022-12-20 18:33:02.811860', '68', 'Phố sách Hà Nội', 3, '', 18, 1),
(391, '2022-12-22 18:29:24.104626', '78', 'Thảo nguyên hoa Long Biên', 2, '[{\"changed\": {\"fields\": [\"Rating\"]}}]', 18, 1),
(392, '2022-12-24 12:05:29.460995', '47', 'Cuss1', 3, '', 4, 1),
(393, '2022-12-24 12:05:29.467423', '55', 'Cuss11', 3, '', 4, 1),
(394, '2022-12-24 12:05:29.469417', '56', 'Cuss12', 3, '', 4, 1),
(395, '2022-12-24 12:05:29.470416', '57', 'Cuss13', 3, '', 4, 1),
(396, '2022-12-24 12:05:29.475181', '48', 'Cuss3', 3, '', 4, 1),
(397, '2022-12-24 12:05:29.478304', '49', 'Cuss4', 3, '', 4, 1),
(398, '2022-12-24 12:05:29.480303', '50', 'Cuss5', 3, '', 4, 1),
(399, '2022-12-24 12:05:29.483409', '51', 'Cuss6', 3, '', 4, 1),
(400, '2022-12-24 12:05:29.486499', '52', 'Cuss7', 3, '', 4, 1),
(401, '2022-12-24 12:05:29.494058', '53', 'Cuss8', 3, '', 4, 1),
(402, '2022-12-24 12:05:29.502175', '54', 'Cuss9', 3, '', 4, 1),
(403, '2022-12-24 12:05:29.509926', '2', 'nganga', 3, '', 4, 1),
(404, '2022-12-24 12:05:29.518364', '45', 'ngatesst', 3, '', 4, 1),
(405, '2022-12-24 12:05:29.520664', '44', 'ngochan', 3, '', 4, 1),
(406, '2022-12-24 12:05:29.523378', '46', 'Test1', 3, '', 4, 1),
(407, '2022-12-24 12:45:44.617005', '61', 'Cus1', 1, '[{\"added\": {}}]', 4, 1),
(408, '2022-12-24 12:45:58.285867', '61', 'Cus1', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(409, '2022-12-24 12:46:39.397735', '86', 'Timeline Cafe ', 1, '[{\"added\": {}}]', 18, 1),
(410, '2022-12-24 16:41:52.266645', '86', 'Timeline Cafe ', 2, '[{\"changed\": {\"fields\": [\"Rating\"]}}]', 18, 1),
(411, '2022-12-24 16:43:51.902565', '67', 'Cuss7', 3, '', 4, 1),
(412, '2022-12-24 16:44:51.527722', '89', 'Hadilao', 1, '[{\"added\": {}}]', 18, 1),
(413, '2022-12-24 16:46:11.405899', '91', 'Maison De Blanc - Bakery & Dessert Cafe ', 1, '[{\"added\": {}}]', 18, 1),
(414, '2022-12-24 16:46:31.902214', '88', 'Thảo nguyên hoa Long Biên', 3, '', 18, 1),
(415, '2022-12-24 16:48:01.189249', '91', 'Maison De Blanc - Bakery & Dessert Cafe ', 2, '[{\"changed\": {\"fields\": [\"Author\", \"Rating\"]}}]', 18, 1),
(416, '2022-12-24 16:48:09.240032', '90', 'Thảo nguyên hoa Long Biên', 2, '[{\"changed\": {\"fields\": [\"Author\", \"Rating\"]}}]', 18, 1),
(417, '2022-12-24 16:48:41.845658', '87', 'Hotpot Longwang', 2, '[{\"changed\": {\"fields\": [\"Author\", \"Rating\"]}}]', 18, 1),
(418, '2022-12-24 16:48:53.177212', '86', 'Timeline Cafe ', 2, '[{\"changed\": {\"fields\": [\"Rating\"]}}]', 18, 1),
(419, '2022-12-24 16:49:08.698491', '89', 'Hadilao', 2, '[{\"changed\": {\"fields\": [\"Author\", \"Rating\"]}}]', 18, 1),
(420, '2022-12-24 16:49:37.359542', '92', 'Maison De Blanc - Bakery & Dessert Cafe ', 1, '[{\"added\": {}}]', 18, 1),
(421, '2022-12-24 16:50:32.142877', '93', 'Hotpot Longwang', 1, '[{\"added\": {}}]', 18, 1),
(422, '2022-12-24 16:50:57.517314', '94', 'Timeline Cafe ', 1, '[{\"added\": {}}]', 18, 1),
(423, '2022-12-24 16:51:38.088711', '95', 'Timeline Cafe ', 1, '[{\"added\": {}}]', 18, 1),
(424, '2022-12-24 16:52:15.750264', '96', 'Hotpot Longwang', 1, '[{\"added\": {}}]', 18, 1),
(425, '2022-12-24 16:52:30.132848', '97', 'Hadilao', 1, '[{\"added\": {}}]', 18, 1),
(426, '2022-12-24 16:52:56.149706', '98', 'Maison De Blanc - Bakery & Dessert Cafe ', 1, '[{\"added\": {}}]', 18, 1),
(427, '2022-12-24 16:53:36.071791', '99', 'Hotpot Longwang', 1, '[{\"added\": {}}]', 18, 1),
(428, '2022-12-24 16:53:48.102729', '100', 'Thảo nguyên hoa Long Biên', 1, '[{\"added\": {}}]', 18, 1),
(429, '2022-12-24 16:53:54.603168', '101', 'Maison De Blanc - Bakery & Dessert Cafe ', 1, '[{\"added\": {}}]', 18, 1),
(430, '2022-12-24 16:54:20.215164', '102', 'Hotpot Longwang', 1, '[{\"added\": {}}]', 18, 1),
(431, '2022-12-24 16:54:49.046215', '103', 'Maison De Blanc - Bakery & Dessert Cafe ', 1, '[{\"added\": {}}]', 18, 1),
(432, '2022-12-24 16:55:13.077332', '104', 'Hadilao', 1, '[{\"added\": {}}]', 18, 1),
(433, '2022-12-24 16:55:32.039171', '105', 'Timeline Cafe ', 1, '[{\"added\": {}}]', 18, 1),
(434, '2022-12-24 16:56:05.804086', '106', 'Hotpot Longwang', 1, '[{\"added\": {}}]', 18, 1),
(435, '2022-12-24 16:56:24.915853', '107', 'Hadilao', 1, '[{\"added\": {}}]', 18, 1),
(436, '2022-12-24 17:00:48.295269', '108', 'Thảo nguyên hoa Long Biên', 1, '[{\"added\": {}}]', 18, 1),
(437, '2022-12-30 16:35:58.223523', '71', 'rrrrrr', 3, '', 4, 1),
(438, '2022-12-30 16:35:58.226512', '70', 'testt1', 3, '', 4, 1),
(439, '2022-12-30 16:46:53.175188', '1', 'Customer', 3, '', 3, 1),
(440, '2022-12-30 16:53:20.270621', '4', 'Customer', 1, '[{\"added\": {}}]', 3, 1),
(441, '2022-12-30 17:19:46.701684', '61', 'Cus1', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(442, '2022-12-30 17:19:56.568303', '62', 'Cuss2', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(443, '2022-12-30 17:20:11.142667', '63', 'Cuss3', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(444, '2022-12-30 17:20:20.354554', '64', 'cuss4', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(445, '2022-12-30 17:20:30.888637', '65', 'Cuss5', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(446, '2022-12-30 17:20:42.434346', '66', 'Cuss6', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(447, '2022-12-30 17:20:57.458593', '68', 'ngochan', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(448, '2022-12-31 09:15:11.748195', '73', '23w33', 3, '', 4, 1),
(449, '2022-12-31 09:15:11.758189', '72', '4444422', 3, '', 4, 1),
(450, '2022-12-31 10:52:46.676959', '77', 'Cuss2454543', 3, '', 4, 1),
(451, '2022-12-31 10:52:46.683132', '76', 'cussssss12', 3, '', 4, 1),
(452, '2022-12-31 11:22:05.038997', '69', 'nganga', 2, '[{\"changed\": {\"fields\": [\"Staff status\"]}}]', 4, 1),
(453, '2022-12-31 11:44:11.878857', '85', '2e2e', 3, '', 4, 1),
(454, '2022-12-31 11:44:11.882848', '86', '3r234r234', 3, '', 4, 1),
(455, '2022-12-31 11:44:11.885542', '84', '3r345r34r', 3, '', 4, 1),
(456, '2022-12-31 11:44:11.888460', '80', '65333', 3, '', 4, 1),
(457, '2022-12-31 11:44:11.890871', '78', 'Cuss2454543', 3, '', 4, 1),
(458, '2022-12-31 11:44:11.894263', '83', 'e3rr32', 3, '', 4, 1),
(459, '2022-12-31 11:44:11.896264', '82', 'nfarts', 3, '', 4, 1),
(460, '2022-12-31 11:44:11.900262', '74', 'ql111', 3, '', 4, 1),
(461, '2022-12-31 12:29:46.128934', '1', 'phamthiphuongnga', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(20, 'account', 'emailaddress'),
(21, 'account', 'emailconfirmation'),
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(7, 'blog', 'account'),
(10, 'blog', 'account_role'),
(11, 'blog', 'category'),
(12, 'blog', 'comment'),
(13, 'blog', 'images'),
(8, 'blog', 'location'),
(18, 'blog', 'rating'),
(9, 'blog', 'role'),
(5, 'contenttypes', 'contenttype'),
(19, 'history', 'history'),
(25, 'history', 'visitor'),
(26, 'history', 'visitorinterest'),
(14, 'hitcount', 'blacklistip'),
(15, 'hitcount', 'blacklistuseragent'),
(16, 'hitcount', 'hit'),
(17, 'hitcount', 'hitcount'),
(6, 'sessions', 'session'),
(22, 'socialaccount', 'socialaccount'),
(23, 'socialaccount', 'socialapp'),
(24, 'socialaccount', 'socialtoken');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2022-11-13 06:13:20.007498'),
(2, 'auth', '0001_initial', '2022-11-13 06:13:20.927830'),
(3, 'admin', '0001_initial', '2022-11-13 06:13:21.120519'),
(4, 'admin', '0002_logentry_remove_auto_add', '2022-11-13 06:13:21.136876'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2022-11-13 06:13:21.147848'),
(6, 'contenttypes', '0002_remove_content_type_name', '2022-11-13 06:13:21.305565'),
(7, 'auth', '0002_alter_permission_name_max_length', '2022-11-13 06:13:21.394425'),
(8, 'auth', '0003_alter_user_email_max_length', '2022-11-13 06:13:21.427342'),
(9, 'auth', '0004_alter_user_username_opts', '2022-11-13 06:13:21.450898'),
(10, 'auth', '0005_alter_user_last_login_null', '2022-11-13 06:13:21.527575'),
(11, 'auth', '0006_require_contenttypes_0002', '2022-11-13 06:13:21.532536'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2022-11-13 06:13:21.550490'),
(13, 'auth', '0008_alter_user_username_max_length', '2022-11-13 06:13:21.588406'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2022-11-13 06:13:21.631322'),
(15, 'auth', '0010_alter_group_name_max_length', '2022-11-13 06:13:21.663642'),
(16, 'auth', '0011_update_proxy_permissions', '2022-11-13 06:13:21.678818'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2022-11-13 06:13:21.715564'),
(18, 'blog', '0001_initial', '2022-11-13 06:13:22.060955'),
(19, 'blog', '0002_location_describe_alter_location_logo', '2022-11-13 06:13:22.184738'),
(20, 'blog', '0003_location_date', '2022-11-13 06:13:22.231615'),
(21, 'blog', '0004_category_location_category', '2022-11-13 06:13:22.496514'),
(22, 'blog', '0005_rename_ward_commune_location_wardcommune', '2022-11-13 06:13:22.535535'),
(23, 'blog', '0006_alter_location_image_alter_location_logo', '2022-11-13 06:13:22.550496'),
(24, 'blog', '0007_alter_location_image_alter_location_logo', '2022-11-13 06:13:22.567450'),
(25, 'blog', '0008_comment', '2022-11-13 06:13:22.794610'),
(26, 'blog', '0009_comment_body', '2022-11-13 06:13:22.824491'),
(27, 'blog', '0010_rename_location_comment_detaillocation', '2022-11-13 06:13:23.151545'),
(28, 'home', '0001_initial', '2022-11-13 06:13:23.309400'),
(29, 'home', '0002_delete_choice_delete_question', '2022-11-13 06:13:23.341316'),
(30, 'sessions', '0001_initial', '2022-11-13 06:13:23.451234'),
(31, 'blog', '0011_comment_rating', '2022-11-13 13:19:52.057540'),
(32, 'blog', '0012_alter_comment_rating', '2022-11-19 16:22:56.974533'),
(33, 'blog', '0013_alter_comment_rating', '2022-11-19 17:05:36.722849'),
(34, 'blog', '0014_alter_comment_rating', '2022-11-20 09:19:17.888791'),
(35, 'blog', '0015_alter_comment_rating', '2022-11-20 15:15:12.036182'),
(36, 'blog', '0016_alter_comment_rating', '2022-11-21 16:01:06.671647'),
(37, 'blog', '0017_comment_updated_at', '2022-11-21 16:09:52.987140'),
(38, 'blog', '0018_comment_status', '2022-11-21 16:53:01.744177'),
(39, 'blog', '0019_alter_location_image', '2022-11-22 02:33:50.731341'),
(40, 'blog', '0020_remove_location_vote', '2022-11-24 06:49:34.168299'),
(41, 'blog', '0021_alter_location_logo', '2022-11-24 07:48:39.988147'),
(42, 'blog', '0022_remove_location_email_remove_location_representative', '2022-11-24 09:25:25.432031'),
(43, 'blog', '0023_alter_location_image', '2022-11-24 14:45:52.244079'),
(44, 'blog', '0024_rename_distric_location_district', '2022-11-25 02:28:38.455535'),
(45, 'blog', '0025_images', '2022-11-26 17:56:30.853346'),
(46, 'blog', '0026_alter_images_location_id', '2022-11-27 06:30:57.364732'),
(47, 'blog', '0027_alter_location_describe', '2022-11-27 14:04:21.809965'),
(48, 'blog', '0028_images_date', '2022-11-27 14:15:23.510910'),
(49, 'blog', '0029_delete_account_role_delete_role', '2022-12-06 15:38:37.956117'),
(50, 'blog', '0030_alter_comment_rating', '2022-12-06 16:46:19.446495'),
(51, 'blog', '0031_alter_comment_rating', '2022-12-06 16:47:31.582141'),
(52, 'blog', '0032_delete_account', '2022-12-06 16:51:05.089076'),
(53, 'blog', '0033_location_timeend_location_timestart', '2022-12-07 06:49:56.976283'),
(54, 'blog', '0034_alter_location_timeend_alter_location_timestart', '2022-12-07 06:51:58.305783'),
(55, 'blog', '0035_alter_location_timeend_alter_location_timestart', '2022-12-07 06:53:15.900342'),
(56, 'blog', '0036_alter_location_costmax_alter_location_costmin', '2022-12-07 08:19:34.098973'),
(57, 'blog', '0037_location_views', '2022-12-08 17:47:19.117784'),
(58, 'hitcount', '0001_initial', '2022-12-08 17:47:19.664926'),
(59, 'hitcount', '0002_index_ip_and_session', '2022-12-08 17:47:19.750281'),
(60, 'hitcount', '0003_auto_20190608_1004', '2022-12-08 17:47:20.719676'),
(61, 'hitcount', '0004_auto_20200704_0933', '2022-12-08 17:47:20.881795'),
(62, 'hitcount', '0005_alter_blacklistip_id_alter_blacklistuseragent_id_and_more', '2022-12-08 17:47:21.637435'),
(63, 'blog', '0038_rating', '2022-12-10 13:59:55.336837'),
(64, 'blog', '0039_rating_status', '2022-12-10 14:16:56.369639'),
(65, 'blog', '0040_rating_date', '2022-12-10 16:14:47.168315'),
(66, 'blog', '0041_remove_comment_rating', '2022-12-10 16:26:28.697341'),
(67, 'history', '0001_initial', '2022-12-15 04:03:17.231735'),
(68, 'account', '0001_initial', '2022-12-15 08:44:20.798166'),
(69, 'account', '0002_email_max_length', '2022-12-15 08:44:20.859999'),
(70, 'socialaccount', '0001_initial', '2022-12-15 08:44:21.279668'),
(71, 'socialaccount', '0002_token_max_lengths', '2022-12-15 08:44:21.380010'),
(72, 'socialaccount', '0003_extra_data_default_dict', '2022-12-15 08:44:21.399811'),
(73, 'history', '0002_alter_history_options', '2022-12-15 13:14:12.362042'),
(74, 'history', '0003_visitor_visitorinterest', '2022-12-16 15:07:20.745309'),
(75, 'history', '0004_remove_visitorinterest_visitor_delete_visitor_and_more', '2022-12-16 18:17:52.083540');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('0aiiris5f0kyrn27zzq9ffo22nzzryd8', '.eJxVjMsOwiAUBf-FtSEXKFxw6b7fQHhK1UBS2pXx36VJF7o9M3PexLp9K3bvabVLJFfCyOV38y48Uz1AfLh6bzS0uq2Lp4dCT9rp3GJ63U7376C4XkYNxjOlQQqdGWDQWhiOUzQMPDo3UMxGQwIVFSohJWKGKXEYkuSQBPl8AaLuNf4:1p8QHa:97S6FJCK1fqM6M1Y6yWR7lYJJPsokioRwEtbQjN7mGg', '2023-01-05 18:27:06.636861'),
('1m0fly37i2g9d787g0mqei9vtf44nzhv', '.eJxVjDkOwjAUBe_iGlkkxkso6TmD9VccQI4UJxXi7hApBbRvZt7LZFiXktcmcx7ZnE1I5vA7ItBD6kb4DvU2WZrqMo9oN8XutNnrxPK87O7fQYFWvrUSs1KHITjwKSQV0ZiC4Mm73mMPrBGiG8Qf2XUgFJNT9ENEpODFmfcHQvQ5RQ:1pCBz7:msTEblMfJj7IpfYLMORKaYn6AxH3Hbgbx-ysEsD829U', '2023-01-16 03:59:37.959009'),
('1pi8u4vlmz7xr6nib1zulrcnxfsei9ry', '.eJxVjMsOwiAUBf-FtSEXKFxw6b7fQHhK1UBS2pXx36VJF7o9M3PexLp9K3bvabVLJFfCyOV38y48Uz1AfLh6bzS0uq2Lp4dCT9rp3GJ63U7376C4XkYNxjOlQQqdGWDQWhiOUzQMPDo3UMxGQwIVFSohJWKGKXEYkuSQBPl8AaLuNf4:1p6tu4:IQJjJ4vY-FFm2K9CHiMRgB-poVYViSlotvrDErH_xq8', '2023-01-01 13:40:32.677011'),
('4gvz7hvwu0i4ap6zrxuqn1l9e5ancv6y', '.eJxVjDkOwjAUBe_iGlkkxkso6TmD9VccQI4UJxXi7hApBbRvZt7LZFiXktcmcx7ZnE1I5vA7ItBD6kb4DvU2WZrqMo9oN8XutNnrxPK87O7fQYFWvrUSs1KHITjwKSQV0ZiC4Mm73mMPrBGiG8Qf2XUgFJNT9ENEpODFmfcHQvQ5RQ:1pCGQ4:fNV0Kcuk1KEbCdh9CgejbosDrG1NWchYfUQE8Zz9M_4', '2023-01-16 08:43:44.572280'),
('7xja3v0ixp24j26bsf0cu3bmjxqo7t0j', '.eJxVjDkOwjAUBe_iGllx_OOFkp4zWH-xcQDFUpYKcXeIlALaNzPvpRJua03bkuc0ijorGNTpdyTkR552Inecbk1zm9Z5JL0r-qCLvjbJz8vh_h1UXOq3RikIpnjP3hibh2AdYPSZoJPCoRcgdOQiQTHkbd91jgcKFFmC58Dq_QEdXzif:1p5SRX:KodhXr7TGklR8pvJ_vsVaSxxiNowZwRyw4WdbP0UthU', '2022-12-28 14:09:07.956802'),
('8b91ypa28eycgjjbduullgtebv5nxih1', '.eJxVjMsOwiAUBf-FtSEXKFxw6b7fQHhK1UBS2pXx36VJF7o9M3PexLp9K3bvabVLJFfCyOV38y48Uz1AfLh6bzS0uq2Lp4dCT9rp3GJ63U7376C4XkYNxjOlQQqdGWDQWhiOUzQMPDo3UMxGQwIVFSohJWKGKXEYkuSQBPl8AaLuNf4:1p6HHy:57TfYSTvo-9HvG6kmWJZExR8Hwz5-gNtGgPheqp_c7c', '2022-12-30 20:26:38.628417'),
('8gewil9azowbw6zwc8ewev984n588m11', '.eJxVjEEOwiAQRe_C2pCWYQZw6d4zNANMpWpoUtqV8e7apAvd_vfef6mBt7UMW5NlmLI6K-vU6XeMnB5Sd5LvXG-zTnNdlynqXdEHbfo6Z3leDvfvoHAr35osdTEAiUGAMQViS2MWDh1EtNJBCiHD6JCRnO-9oDE9kuHse0Lv1PsD8bY3BQ:1p7KPF:Vxtn4ufhBksij0fQaLLtCgpcPNeQGFl2G_gYKYwzV4w', '2023-01-02 17:58:29.435283'),
('eqi58olnq8k53is6wpiznxk9e7rpq7nh', '.eJxVjEEOwiAQRe_C2pB2Zijg0r1nIAwMUjVtUtqV8e7apAvd_vfef6kQt7WGrckSxqzOyqjT78YxPWTaQb7H6TbrNE_rMrLeFX3Qpq9zluflcP8Oamz1WxNjB-QZHVmTivWOuECRnAQYEvTFWZsJfE_eCCMMCbqM4nqDSAOq9wfWyDce:1p4Idf:fqF-3Qhuo54QyW9o5epwlmuYDeHeR87AF5MXyKk-M58', '2022-12-25 09:28:51.012601'),
('ffkrssas2cbwouikgusd6w9kfo6z1zre', '.eJxVjMsOwiAUBf-FtSEXKFxw6b7fQHhK1UBS2pXx36VJF7o9M3PexLp9K3bvabVLJFfCyOV38y48Uz1AfLh6bzS0uq2Lp4dCT9rp3GJ63U7376C4XkYNxjOlQQqdGWDQWhiOUzQMPDo3UMxGQwIVFSohJWKGKXEYkuSQBPl8AaLuNf4:1p6CJi:kkGDpxGk_34cLWwTO-M8Wi7peUCjZWb2Tg7ovKye1WI', '2022-12-30 15:08:06.676699'),
('fvroly2ew2w1odf5tiohf2p50yx56t5w', '.eJxVjMsOwiAUBf-FtSEXKFxw6b7fQHhK1UBS2pXx36VJF7o9M3PexLp9K3bvabVLJFfCyOV38y48Uz1AfLh6bzS0uq2Lp4dCT9rp3GJ63U7376C4XkYNxjOlQQqdGWDQWhiOUzQMPDo3UMxGQwIVFSohJWKGKXEYkuSQBPl8AaLuNf4:1p8vrX:GCDI5tzEzDls7DTWJi6AkAKvFWGHD4rw8g7-B4HrayQ', '2023-01-07 04:10:19.488426'),
('fzn2t2yawywkblrsxp8xnx2rc2owms43', '.eJxVjMsOwiAUBf-FtSEXKFxw6b7fQHhK1UBS2pXx36VJF7o9M3PexLp9K3bvabVLJFfCyOV38y48Uz1AfLh6bzS0uq2Lp4dCT9rp3GJ63U7376C4XkYNxjOlQQqdGWDQWhiOUzQMPDo3UMxGQwIVFSohJWKGKXEYkuSQBPl8AaLuNf4:1p5nkN:dgvUWZhLBdtpgwl6J0j0CAIJ8n-vEHxuPKi0bGCBhWk', '2022-12-29 12:53:59.241088'),
('g8nva84nb0k19cl6l7lx4wje2btm9jsk', '.eJxVjMsOwiAUBf-FtSEXKFxw6b7fQHhK1UBS2pXx36VJF7o9M3PexLp9K3bvabVLJFfCyOV38y48Uz1AfLh6bzS0uq2Lp4dCT9rp3GJ63U7376C4XkYNxjOlQQqdGWDQWhiOUzQMPDo3UMxGQwIVFSohJWKGKXEYkuSQBPl8AaLuNf4:1pABNU:SkQMXonQAVPfKx01ZXNK1PfqMMXdEx8p1lGfgFej6ao', '2023-01-10 14:56:28.473947'),
('ohwp1vpauppzwd9udr1tnlchmjuzk58h', '.eJxVjMsOwiAUBf-FtSEXKFxw6b7fQHhK1UBS2pXx36VJF7o9M3PexLp9K3bvabVLJFfCyOV38y48Uz1AfLh6bzS0uq2Lp4dCT9rp3GJ63U7376C4XkYNxjOlQQqdGWDQWhiOUzQMPDo3UMxGQwIVFSohJWKGKXEYkuSQBPl8AaLuNf4:1p8IDz:qs4E6vIp18Wtn0QDPefVp-wCEX71xKI0c77YucIZv0I', '2023-01-05 09:50:51.412304'),
('t1eqh5rez2wwgl6o39tayhxlwu6fu04q', '.eJxVjMsOwiAUBf-FtSEXKFxw6b7fQHhK1UBS2pXx36VJF7o9M3PexLp9K3bvabVLJFfCyOV38y48Uz1AfLh6bzS0uq2Lp4dCT9rp3GJ63U7376C4XkYNxjOlQQqdGWDQWhiOUzQMPDo3UMxGQwIVFSohJWKGKXEYkuSQBPl8AaLuNf4:1p8Z1j:ZtEoRb4Q0GjiEgh9kN-b5xLA-ksWzpLXNWCLNlNt7YU', '2023-01-06 03:47:19.164720'),
('tbc8g6jj6lvk8rt0m02j8emembynvop0', '.eJxVjMsOwiAUBf-FtSEXKFxw6b7fQHhK1UBS2pXx36VJF7o9M3PexLp9K3bvabVLJFfCyOV38y48Uz1AfLh6bzS0uq2Lp4dCT9rp3GJ63U7376C4XkYNxjOlQQqdGWDQWhiOUzQMPDo3UMxGQwIVFSohJWKGKXEYkuSQBPl8AaLuNf4:1p5k1t:8iTekPkq0UbDRYQZ4VqS3KQat6QyQFwTxZKPHHRKU9Q', '2022-12-29 08:55:49.218984'),
('txmw5n7us42uvk797fowndbh97eqee4g', '.eJxVjMsOwiAUBf-FtSEXKFxw6b7fQHhK1UBS2pXx36VJF7o9M3PexLp9K3bvabVLJFfCyOV38y48Uz1AfLh6bzS0uq2Lp4dCT9rp3GJ63U7376C4XkYNxjOlQQqdGWDQWhiOUzQMPDo3UMxGQwIVFSohJWKGKXEYkuSQBPl8AaLuNf4:1p9RCR:ujSCIkMc0GjLpnb4N62ENohVJLGKJEwqvQVj6MKWnFE', '2023-01-08 13:37:59.428512'),
('unamwv42n6bnx1i0u9ld1h0ugm0d1va3', '.eJxVjMsOwiAUBf-FtSEXKFxw6b7fQHhK1UBS2pXx36VJF7o9M3PexLp9K3bvabVLJFfCyOV38y48Uz1AfLh6bzS0uq2Lp4dCT9rp3GJ63U7376C4XkYNxjOlQQqdGWDQWhiOUzQMPDo3UMxGQwIVFSohJWKGKXEYkuSQBPl8AaLuNf4:1p6ZYL:-SRPoSraALqDauc41jknOZw5fM4TO1CE9t10uXc2mF8', '2022-12-31 15:56:45.045205'),
('xo0hn7aaoi5nz656rnifr5nd6vfq110o', '.eJxVjEEOwiAQRe_C2pB2Zijg0r1nIAwMUjVtUtqV8e7apAvd_vfef6kQt7WGrckSxqzOyqjT78YxPWTaQb7H6TbrNE_rMrLeFX3Qpq9zluflcP8Oamz1WxNjB-QZHVmTivWOuECRnAQYEvTFWZsJfE_eCCMMCbqM4nqDSAOq9wfWyDce:1p4MiC:1CGYtboY9irtEDf-QS3-7t7a_zu9SXc7V79I6xaN8GM', '2022-12-25 13:49:48.400229'),
('yfhdvdc2ihf18diqtfxg7d2c02scm4uy', '.eJxVjEEOwiAQRe_C2hAoMwIu3fcMBIZBqoYmpV0Z765NutDtf-_9lwhxW2vYOi9hyuIiQInT75giPbjtJN9ju82S5rYuU5K7Ig_a5Thnfl4P9--gxl6_tUJrGM4cgXQxYMEzevDIJg1pyBodaIycVFFonCPyFkxmBsrOYiHx_gDv3jfn:1p44pN:8_tMCWuk-Flv8GXQdavZjCjizWiJRiSOp_wWVzlEtJQ', '2022-12-24 18:44:01.843374');

-- --------------------------------------------------------

--
-- Table structure for table `history_history`
--

CREATE TABLE `history_history` (
  `id` bigint(20) NOT NULL,
  `object_id` bigint(20) UNSIGNED NOT NULL CHECK (`object_id` >= 0),
  `viewed_on` datetime(6) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `history_history`
--

INSERT INTO `history_history` (`id`, `object_id`, `viewed_on`, `content_type_id`, `user_id`) VALUES
(116, 33, '2022-12-16 18:08:06.236876', 8, 1),
(427, 47, '2022-12-24 12:46:53.295500', 8, 61),
(428, 47, '2022-12-24 12:50:59.264074', 8, 61),
(429, 47, '2022-12-24 12:51:40.177603', 8, 61),
(430, 47, '2022-12-24 12:52:39.635537', 8, 61),
(431, 47, '2022-12-24 12:52:39.702363', 8, 61),
(432, 47, '2022-12-24 12:54:44.528536', 8, 61),
(433, 47, '2022-12-24 12:55:59.855527', 8, 61),
(434, 47, '2022-12-24 12:57:16.227451', 8, 61),
(435, 47, '2022-12-24 12:58:07.178478', 8, 61),
(436, 48, '2022-12-24 13:07:24.204231', 8, 61),
(437, 48, '2022-12-24 13:08:16.536529', 8, 61),
(438, 48, '2022-12-24 14:07:00.854906', 8, 61),
(439, 49, '2022-12-24 14:20:50.565218', 8, 61),
(440, 31, '2022-12-24 14:24:35.861657', 8, 61),
(441, 34, '2022-12-24 14:26:20.368155', 8, 61),
(442, 48, '2022-12-24 14:33:06.266304', 8, 61),
(443, 48, '2022-12-24 14:58:13.225850', 8, 61),
(444, 50, '2022-12-24 14:58:17.290405', 8, 61),
(445, 52, '2022-12-24 15:31:12.108626', 8, 61),
(446, 1, '2022-12-24 15:53:47.439867', 8, 61),
(447, 54, '2022-12-24 16:28:55.860808', 8, 61),
(448, 55, '2022-12-24 16:40:44.176957', 8, 62),
(449, 55, '2022-12-24 16:40:54.684049', 8, 62),
(450, 55, '2022-12-24 16:40:54.747402', 8, 62),
(451, 55, '2022-12-24 16:41:20.770843', 8, 62),
(452, 55, '2022-12-24 16:41:20.855128', 8, 62),
(453, 34, '2022-12-24 16:42:16.833860', 8, 63),
(454, 34, '2022-12-24 16:42:21.871192', 8, 63),
(455, 34, '2022-12-24 16:42:21.916327', 8, 63),
(456, 34, '2022-12-24 16:42:56.806876', 8, 63),
(457, 34, '2022-12-24 16:42:56.904616', 8, 63),
(458, 30, '2022-12-24 16:44:31.842670', 8, 64),
(459, 34, '2022-12-24 16:45:09.024718', 8, 65),
(460, 34, '2022-12-24 16:45:14.618160', 8, 65),
(461, 34, '2022-12-24 16:45:14.663803', 8, 65),
(462, 55, '2022-12-24 17:02:11.420621', 8, 66),
(463, 55, '2022-12-24 17:02:53.548718', 8, 65),
(464, 55, '2022-12-24 17:03:16.879785', 8, 65),
(465, 55, '2022-12-24 17:03:16.965483', 8, 65),
(466, 55, '2022-12-24 17:05:13.664458', 8, 65),
(467, 55, '2022-12-24 17:05:15.868671', 8, 65),
(468, 55, '2022-12-25 07:10:53.070878', 8, 65),
(469, 52, '2022-12-25 07:11:00.102488', 8, 65),
(470, 54, '2022-12-25 07:11:05.846445', 8, 65),
(471, 50, '2022-12-25 07:11:10.760184', 8, 65),
(472, 50, '2022-12-25 07:14:00.290309', 8, 65),
(473, 50, '2022-12-25 07:14:00.403826', 8, 65),
(474, 50, '2022-12-25 07:14:18.849879', 8, 64),
(475, 50, '2022-12-25 07:14:55.793366', 8, 64),
(476, 50, '2022-12-25 07:14:55.906064', 8, 64),
(477, 50, '2022-12-25 07:15:26.025928', 8, 65),
(478, 50, '2022-12-25 07:24:25.575622', 8, 61),
(479, 55, '2022-12-25 07:24:58.383294', 8, 66),
(480, 53, '2022-12-25 07:25:10.988701', 8, 66),
(481, 53, '2022-12-25 07:25:18.210959', 8, 66),
(482, 53, '2022-12-25 07:25:18.291741', 8, 66),
(483, 53, '2022-12-25 07:26:25.171752', 8, 66),
(484, 53, '2022-12-25 07:26:25.267533', 8, 66),
(485, 50, '2022-12-25 14:49:57.984796', 8, 66),
(486, 54, '2022-12-27 14:55:06.497288', 8, 66),
(487, 56, '2022-12-27 16:03:21.577577', 8, 66),
(488, 54, '2022-12-27 16:03:25.966566', 8, 66),
(489, 54, '2022-12-27 16:04:49.310833', 8, 66),
(490, 34, '2022-12-30 10:35:29.535199', 8, 62),
(491, 34, '2022-12-30 10:39:27.662089', 8, 62),
(492, 34, '2022-12-30 10:52:38.900353', 8, 62),
(493, 56, '2022-12-30 10:53:11.004322', 8, 62),
(494, 55, '2022-12-30 10:53:19.858208', 8, 62),
(495, 56, '2022-12-30 10:53:27.428042', 8, 62),
(496, 28, '2022-12-30 10:56:08.281174', 8, 62),
(497, 28, '2022-12-30 10:57:35.149587', 8, 62),
(498, 54, '2022-12-31 14:04:13.221676', 8, 62),
(499, 47, '2022-12-31 14:08:10.305639', 8, 62),
(500, 47, '2022-12-31 14:08:20.010090', 8, 62),
(501, 47, '2022-12-31 14:09:19.147381', 8, 62),
(502, 47, '2022-12-31 14:11:04.588221', 8, 62),
(503, 56, '2023-01-02 04:04:58.595024', 8, 1),
(504, 56, '2023-01-02 04:15:01.819531', 8, 1),
(505, 56, '2023-01-02 04:15:04.182547', 8, 1),
(506, 56, '2023-01-02 04:16:33.963151', 8, 1),
(507, 56, '2023-01-02 04:25:50.792048', 8, 1),
(508, 56, '2023-01-02 04:25:54.229705', 8, 1),
(509, 56, '2023-01-02 04:25:54.259624', 8, 1),
(510, 56, '2023-01-02 04:27:33.714764', 8, 1),
(511, 56, '2023-01-02 04:27:41.912330', 8, 1),
(512, 56, '2023-01-02 04:27:41.984138', 8, 1),
(513, 56, '2023-01-02 04:30:08.607697', 8, 1),
(514, 56, '2023-01-02 04:30:08.662547', 8, 1),
(515, 56, '2023-01-02 04:34:00.363556', 8, 68),
(516, 56, '2023-01-02 04:34:02.852671', 8, 68),
(517, 52, '2023-01-02 06:31:34.326103', 8, 68),
(518, 52, '2023-01-02 06:31:37.588822', 8, 68),
(519, 52, '2023-01-02 06:31:37.622731', 8, 68),
(520, 52, '2023-01-02 06:31:49.539117', 8, 68),
(521, 52, '2023-01-02 06:31:49.568990', 8, 68),
(522, 58, '2023-01-02 06:38:17.901884', 8, 1),
(523, 58, '2023-01-02 08:43:17.577882', 8, 1),
(524, 58, '2023-01-02 08:44:02.307408', 8, 68),
(525, 58, '2023-01-02 08:44:05.502100', 8, 68),
(526, 58, '2023-01-02 08:44:05.537005', 8, 68),
(527, 58, '2023-01-02 08:44:23.099057', 8, 68),
(528, 58, '2023-01-02 08:44:23.167871', 8, 68);

-- --------------------------------------------------------

--
-- Table structure for table `hitcount_blacklist_ip`
--

CREATE TABLE `hitcount_blacklist_ip` (
  `id` bigint(20) NOT NULL,
  `ip` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hitcount_blacklist_user_agent`
--

CREATE TABLE `hitcount_blacklist_user_agent` (
  `id` bigint(20) NOT NULL,
  `user_agent` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hitcount_hit`
--

CREATE TABLE `hitcount_hit` (
  `id` bigint(20) NOT NULL,
  `created` datetime(6) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `session` varchar(40) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `hitcount_id` bigint(20) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hitcount_hit_count`
--

CREATE TABLE `hitcount_hit_count` (
  `id` bigint(20) NOT NULL,
  `hits` int(10) UNSIGNED NOT NULL CHECK (`hits` >= 0),
  `modified` datetime(6) NOT NULL,
  `object_pk` int(10) UNSIGNED NOT NULL,
  `content_type_id` int(11) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `socialaccount_socialaccount`
--

CREATE TABLE `socialaccount_socialaccount` (
  `id` int(11) NOT NULL,
  `provider` varchar(30) NOT NULL,
  `uid` varchar(191) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `extra_data` longtext NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `socialaccount_socialapp`
--

CREATE TABLE `socialaccount_socialapp` (
  `id` int(11) NOT NULL,
  `provider` varchar(30) NOT NULL,
  `name` varchar(40) NOT NULL,
  `client_id` varchar(191) NOT NULL,
  `secret` varchar(191) NOT NULL,
  `key` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `socialaccount_socialtoken`
--

CREATE TABLE `socialaccount_socialtoken` (
  `id` int(11) NOT NULL,
  `token` longtext NOT NULL,
  `token_secret` longtext NOT NULL,
  `expires_at` datetime(6) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `app_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account_emailaddress`
--
ALTER TABLE `account_emailaddress`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `account_emailaddress_user_id_2c513194_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `account_emailconfirmation`
--
ALTER TABLE `account_emailconfirmation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `key` (`key`),
  ADD KEY `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` (`email_address_id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `blog_category`
--
ALTER TABLE `blog_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_comment`
--
ALTER TABLE `blog_comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_comment_author_id_4f11e2e0_fk_auth_user_id` (`author_id`),
  ADD KEY `blog_comment_detaillocation_id_6af46106_fk_blog_location_id` (`detaillocation_id`);

--
-- Indexes for table `blog_images`
--
ALTER TABLE `blog_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_images_location_id_id_ea85adf1_fk_blog_location_id` (`location_id_id`);

--
-- Indexes for table `blog_location`
--
ALTER TABLE `blog_location`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_location_category_id_99998d73_fk_blog_category_id` (`category_id`);

--
-- Indexes for table `blog_rating`
--
ALTER TABLE `blog_rating`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_rating_author_id_1bc2b3d8_fk_auth_user_id` (`author_id`),
  ADD KEY `blog_rating_detaillocation_id_9595e2f1_fk_blog_location_id` (`detaillocation_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `history_history`
--
ALTER TABLE `history_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `history_history_content_type_id_3061c654_fk_django_co` (`content_type_id`),
  ADD KEY `history_history_user_id_4e4120ab_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `hitcount_blacklist_ip`
--
ALTER TABLE `hitcount_blacklist_ip`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ip` (`ip`);

--
-- Indexes for table `hitcount_blacklist_user_agent`
--
ALTER TABLE `hitcount_blacklist_user_agent`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_agent` (`user_agent`);

--
-- Indexes for table `hitcount_hit`
--
ALTER TABLE `hitcount_hit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hitcount_hit_user_id_f7067f66_fk_auth_user_id` (`user_id`),
  ADD KEY `hitcount_hit_created_79adf7bc` (`created`),
  ADD KEY `hitcount_hit_ip_a52a62aa` (`ip`),
  ADD KEY `hitcount_hit_session_5be83758` (`session`),
  ADD KEY `hitcount_hit_hitcount_id_b7971910_fk` (`hitcount_id`);

--
-- Indexes for table `hitcount_hit_count`
--
ALTER TABLE `hitcount_hit_count`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `hitcount_hit_count_content_type_id_object_pk_4dacb610_uniq` (`content_type_id`,`object_pk`);

--
-- Indexes for table `socialaccount_socialaccount`
--
ALTER TABLE `socialaccount_socialaccount`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `socialaccount_socialaccount_provider_uid_fc810c6e_uniq` (`provider`,`uid`),
  ADD KEY `socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `socialaccount_socialapp`
--
ALTER TABLE `socialaccount_socialapp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `socialaccount_socialtoken`
--
ALTER TABLE `socialaccount_socialtoken`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq` (`app_id`,`account_id`),
  ADD KEY `socialaccount_social_account_id_951f210e_fk_socialacc` (`account_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account_emailaddress`
--
ALTER TABLE `account_emailaddress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `account_emailconfirmation`
--
ALTER TABLE `account_emailconfirmation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=173;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `blog_category`
--
ALTER TABLE `blog_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `blog_comment`
--
ALTER TABLE `blog_comment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT for table `blog_images`
--
ALTER TABLE `blog_images`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=164;

--
-- AUTO_INCREMENT for table `blog_location`
--
ALTER TABLE `blog_location`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `blog_rating`
--
ALTER TABLE `blog_rating`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=462;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `history_history`
--
ALTER TABLE `history_history`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=529;

--
-- AUTO_INCREMENT for table `hitcount_blacklist_ip`
--
ALTER TABLE `hitcount_blacklist_ip`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hitcount_blacklist_user_agent`
--
ALTER TABLE `hitcount_blacklist_user_agent`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hitcount_hit`
--
ALTER TABLE `hitcount_hit`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hitcount_hit_count`
--
ALTER TABLE `hitcount_hit_count`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `socialaccount_socialaccount`
--
ALTER TABLE `socialaccount_socialaccount`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `socialaccount_socialapp`
--
ALTER TABLE `socialaccount_socialapp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `socialaccount_socialtoken`
--
ALTER TABLE `socialaccount_socialtoken`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account_emailaddress`
--
ALTER TABLE `account_emailaddress`
  ADD CONSTRAINT `account_emailaddress_user_id_2c513194_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `account_emailconfirmation`
--
ALTER TABLE `account_emailconfirmation`
  ADD CONSTRAINT `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` FOREIGN KEY (`email_address_id`) REFERENCES `account_emailaddress` (`id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `blog_comment`
--
ALTER TABLE `blog_comment`
  ADD CONSTRAINT `blog_comment_author_id_4f11e2e0_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `blog_comment_detaillocation_id_6af46106_fk_blog_location_id` FOREIGN KEY (`detaillocation_id`) REFERENCES `blog_location` (`id`);

--
-- Constraints for table `blog_images`
--
ALTER TABLE `blog_images`
  ADD CONSTRAINT `blog_images_location_id_id_ea85adf1_fk_blog_location_id` FOREIGN KEY (`location_id_id`) REFERENCES `blog_location` (`id`);

--
-- Constraints for table `blog_location`
--
ALTER TABLE `blog_location`
  ADD CONSTRAINT `blog_location_category_id_99998d73_fk_blog_category_id` FOREIGN KEY (`category_id`) REFERENCES `blog_category` (`id`);

--
-- Constraints for table `blog_rating`
--
ALTER TABLE `blog_rating`
  ADD CONSTRAINT `blog_rating_author_id_1bc2b3d8_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `blog_rating_detaillocation_id_9595e2f1_fk_blog_location_id` FOREIGN KEY (`detaillocation_id`) REFERENCES `blog_location` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `history_history`
--
ALTER TABLE `history_history`
  ADD CONSTRAINT `history_history_content_type_id_3061c654_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `history_history_user_id_4e4120ab_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `hitcount_hit`
--
ALTER TABLE `hitcount_hit`
  ADD CONSTRAINT `hitcount_hit_hitcount_id_b7971910_fk` FOREIGN KEY (`hitcount_id`) REFERENCES `hitcount_hit_count` (`id`),
  ADD CONSTRAINT `hitcount_hit_user_id_f7067f66_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `hitcount_hit_count`
--
ALTER TABLE `hitcount_hit_count`
  ADD CONSTRAINT `hitcount_hit_count_content_type_id_4a734fe1_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `socialaccount_socialaccount`
--
ALTER TABLE `socialaccount_socialaccount`
  ADD CONSTRAINT `socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `socialaccount_socialtoken`
--
ALTER TABLE `socialaccount_socialtoken`
  ADD CONSTRAINT `socialaccount_social_account_id_951f210e_fk_socialacc` FOREIGN KEY (`account_id`) REFERENCES `socialaccount_socialaccount` (`id`),
  ADD CONSTRAINT `socialaccount_social_app_id_636a42d7_fk_socialacc` FOREIGN KEY (`app_id`) REFERENCES `socialaccount_socialapp` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
