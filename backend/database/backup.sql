/*
SQLyog Ultimate v12.5.1 (64 bit)
MySQL - 10.1.38-MariaDB : Database - cashtrace
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`cashtrace` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `cashtrace`;

/*Table structure for table `categories` */

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('income','expense') COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '#3B82F6',
  `is_default` tinyint(1) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `categories` */

insert  into `categories`(`id`,`user_id`,`name`,`type`,`icon`,`color`,`is_default`,`created_at`) values 
(1,NULL,'Gaji','income','????','#10B981',1,'2026-01-28 15:57:37'),
(2,NULL,'Bonus','income','????','#8B5CF6',1,'2026-01-28 15:57:37'),
(3,NULL,'Investasi','income','????','#3B82F6',1,'2026-01-28 15:57:37'),
(4,NULL,'Freelance','income','????','#F59E0B',1,'2026-01-28 15:57:37'),
(5,NULL,'Lainnya','income','????','#6B7280',1,'2026-01-28 15:57:37'),
(6,NULL,'Makanan','expense','????','#EF4444',1,'2026-01-28 15:57:37'),
(7,NULL,'Transport','expense','????','#3B82F6',1,'2026-01-28 15:57:37'),
(8,NULL,'Belanja','expense','????','#10B981',1,'2026-01-28 15:57:37'),
(9,NULL,'Hiburan','expense','????','#8B5CF6',1,'2026-01-28 15:57:37'),
(10,NULL,'Tagihan','expense','????','#F59E0B',1,'2026-01-28 15:57:37'),
(11,NULL,'Kesehatan','expense','????','#EC4899',1,'2026-01-28 15:57:37'),
(12,NULL,'Pendidikan','expense','????','#6366F1',1,'2026-01-28 15:57:37'),
(13,NULL,'Lainnya','expense','????','#6B7280',1,'2026-01-28 15:57:37');

/*Table structure for table `refresh_tokens` */

DROP TABLE IF EXISTS `refresh_tokens`;

CREATE TABLE `refresh_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `token` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `refresh_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `refresh_tokens` */

insert  into `refresh_tokens`(`id`,`user_id`,`token`,`expires_at`,`created_at`) values 
(10,1,'c9732d86-524a-446b-9f25-51c35a91e347','2026-02-04 18:26:48','2026-01-28 18:26:48'),
(11,1,'e1360895-6ac8-4283-aa3a-32062253b00b','2026-02-04 18:45:09','2026-01-28 18:45:09'),
(12,2,'ff096532-abcd-48d5-af97-8431757edfee','2026-02-04 19:19:47','2026-01-28 19:19:47'),
(13,2,'0123c493-bdbd-411b-8f8d-800b0be5fdf2','2026-02-04 19:19:57','2026-01-28 19:19:57'),
(14,1,'afbd91b1-4b6f-4fef-a3fd-96461935333e','2026-02-04 19:21:06','2026-01-28 19:21:06'),
(15,2,'e88f942a-fce3-451a-bcbe-4d8de71b291c','2026-02-04 19:29:27','2026-01-28 19:29:27'),
(16,1,'2eaa6e0a-a759-41d8-aa78-c6e485df48fc','2026-02-04 19:29:37','2026-01-28 19:29:37'),
(17,1,'950b1d95-c2df-424e-82d3-7205ec27ac45','2026-02-04 19:29:50','2026-01-28 19:29:50');

/*Table structure for table `transactions` */

DROP TABLE IF EXISTS `transactions`;

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `type` enum('income','expense') COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `transaction_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `transactions` */

insert  into `transactions`(`id`,`user_id`,`category_id`,`amount`,`type`,`description`,`transaction_date`,`created_at`,`updated_at`) values 
(1,1,1,3000000.00,'income','gaji januari','2026-01-01','2026-01-28 15:58:59','2026-01-28 15:58:59'),
(2,1,6,500000.00,'expense','maem','2026-01-02','2026-01-28 15:59:38','2026-01-28 15:59:38'),
(3,1,6,200000.00,'expense','maem','2026-01-06','2026-01-28 16:00:16','2026-01-28 16:00:16'),
(4,1,11,120000.00,'expense','obat','2026-01-13','2026-01-28 16:00:43','2026-01-28 16:00:43'),
(5,1,8,845000.00,'expense','shopping','2026-01-20','2026-01-28 16:01:19','2026-01-28 16:01:19'),
(6,1,9,170000.00,'expense','depo ngetrade','2026-01-28','2026-01-28 16:01:45','2026-01-28 16:01:45'),
(7,1,1,500000.00,'income','bonus','2025-12-01','2026-01-28 16:04:42','2026-01-28 16:04:42'),
(8,1,2,100000.00,'income',NULL,'2026-01-15','2026-01-28 17:29:00','2026-01-28 17:29:00'),
(9,1,1,100000.00,'income',NULL,'2025-12-01','2026-01-28 17:37:33','2026-01-28 17:37:33');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar_url` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`email`,`password`,`name`,`avatar_url`,`created_at`) values 
(1,'ajek@gmail.com','$2a$10$/ur8pKRbPhbaDLhtRW7Oyee3MXbNrMAigbEMGqU68EH8I7SC0kjwS','ajek',NULL,'2026-01-28 15:58:21'),
(2,'per@gmail.com','$2a$10$0FMaQa7Yjw/EpMn9m2Ni1uOvKgfjc/sNqyPHym12ibBwu0coKWi4m','per',NULL,'2026-01-28 19:19:47');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
