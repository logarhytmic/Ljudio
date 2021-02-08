# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.17)
# Database: nodemusic
# Generation Time: 2021-02-07 03:03:55 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table example_colors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `example_colors`;

CREATE TABLE `example_colors` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `example_colors` WRITE;
/*!40000 ALTER TABLE `example_colors` DISABLE KEYS */;

INSERT INTO `example_colors` (`id`, `value`)
VALUES
	(1,'red'),
	(2,'blue');

/*!40000 ALTER TABLE `example_colors` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table examples
# ------------------------------------------------------------

DROP TABLE IF EXISTS `examples`;

CREATE TABLE `examples` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `slogan` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `color` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `color` (`color`),
  CONSTRAINT `examples_ibfk_1` FOREIGN KEY (`color`) REFERENCES `example_colors` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `examples` WRITE;
/*!40000 ALTER TABLE `examples` DISABLE KEYS */;

INSERT INTO `examples` (`id`, `name`, `slogan`, `created`, `updated`, `color`)
VALUES
	(1,'Future','So bright gotta wear shades','2021-02-07 02:54:26','2021-02-07 02:54:40',1),
	(2,'No name','No slogan','2021-02-07 02:55:02',NULL,2),
	(3,'Vanity','I need no color','2021-02-07 03:31:52',NULL,NULL);

/*!40000 ALTER TABLE `examples` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table examples_with_colors
# ------------------------------------------------------------

DROP VIEW IF EXISTS `examples_with_colors`;

CREATE TABLE `examples_with_colors` (
   `id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
   `name` VARCHAR(255) NOT NULL DEFAULT '',
   `slogan` VARCHAR(255) NULL DEFAULT NULL,
   `created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
   `updated` DATETIME NULL DEFAULT NULL,
   `color` INT(11) UNSIGNED NULL DEFAULT NULL,
   `value` VARCHAR(255) NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) DEFAULT '',
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `email`, `password`, `first_name`, `last_name`)
VALUES
	(1,'bob@node.se','$2b$10$7s4yfYXT.9ElDSEzW0xw6uv1gE99u45HlK9ESjjbshfAnRhbhqqce','Bob','Node'),
	(2,'ben@node.se','$2b$10$9HqnbybYby9JQI1o0srtMe4p4ip4PtEhVoUlNNpbKcgTZvufWpOEG','Ben','Node');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ytm_cache
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ytm_cache`;

CREATE TABLE `ytm_cache` (
  `request_url` varchar(256) NOT NULL DEFAULT '',
  `response_body` json DEFAULT NULL,
  PRIMARY KEY (`request_url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


# Replace placeholder table for examples_with_colors with correct view syntax
# ------------------------------------------------------------

DROP TABLE `examples_with_colors`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `examples_with_colors`
AS SELECT
   `examples`.`id` AS `id`,
   `examples`.`name` AS `name`,
   `examples`.`slogan` AS `slogan`,
   `examples`.`created` AS `created`,
   `examples`.`updated` AS `updated`,
   `examples`.`color` AS `color`,
   `example_colors`.`value` AS `value`
FROM (`examples` left join `example_colors` on((`examples`.`color` = `example_colors`.`id`)));

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
