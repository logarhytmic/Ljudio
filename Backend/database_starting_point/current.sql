-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.5.8-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for nodemusic
CREATE DATABASE IF NOT EXISTS `nodemusic` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci */;
USE `nodemusic`;

-- Dumping structure for table nodemusic.examples
CREATE TABLE IF NOT EXISTS `examples` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `slogan` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `updated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `color` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `color` (`color`),
  CONSTRAINT `examples_ibfk_1` FOREIGN KEY (`color`) REFERENCES `example_colors` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table nodemusic.examples: ~3 rows (approximately)
/*!40000 ALTER TABLE `examples` DISABLE KEYS */;
INSERT INTO `examples` (`id`, `name`, `slogan`, `created`, `updated`, `color`) VALUES
	(1, 'Future', 'So bright gotta wear shades', '2021-02-07 02:54:26', '2021-02-07 02:54:40', 1),
	(2, 'No name', 'No slogan', '2021-02-07 02:55:02', NULL, 2),
	(3, 'Vanity', 'I need no color', '2021-02-07 03:31:52', NULL, NULL);
/*!40000 ALTER TABLE `examples` ENABLE KEYS */;

-- Dumping structure for table nodemusic.example_colors
CREATE TABLE IF NOT EXISTS `example_colors` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table nodemusic.example_colors: ~2 rows (approximately)
/*!40000 ALTER TABLE `example_colors` DISABLE KEYS */;
INSERT INTO `example_colors` (`id`, `value`) VALUES
	(1, 'red'),
	(2, 'blue');
/*!40000 ALTER TABLE `example_colors` ENABLE KEYS */;

-- Dumping structure for table nodemusic.playlist
CREATE TABLE IF NOT EXISTS `playlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  `userid` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_playlist_users` (`userid`),
  CONSTRAINT `FK_playlist_users` FOREIGN KEY (`userid`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

-- Dumping data for table nodemusic.playlist: ~0 rows (approximately)
/*!40000 ALTER TABLE `playlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlist` ENABLE KEYS */;

-- Dumping structure for table nodemusic.playlist_song
CREATE TABLE IF NOT EXISTS `playlist_song` (
  `playlist_id` int(11) NOT NULL,
  `song_id` int(11) NOT NULL,
  PRIMARY KEY (`playlist_id`,`song_id`),
  KEY `FK_playlist_song_song` (`song_id`),
  CONSTRAINT `FK_playlist_song_playlist` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`id`),
  CONSTRAINT `FK_playlist_song_song` FOREIGN KEY (`song_id`) REFERENCES `song` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

-- Dumping data for table nodemusic.playlist_song: ~0 rows (approximately)
/*!40000 ALTER TABLE `playlist_song` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlist_song` ENABLE KEYS */;

-- Dumping structure for table nodemusic.song
CREATE TABLE IF NOT EXISTS `song` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  `originator` varchar(255) COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

-- Dumping data for table nodemusic.song: ~0 rows (approximately)
/*!40000 ALTER TABLE `song` DISABLE KEYS */;
/*!40000 ALTER TABLE `song` ENABLE KEYS */;

-- Dumping structure for table nodemusic.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) DEFAULT '',
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table nodemusic.users: ~2 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `email`, `password`, `first_name`, `last_name`) VALUES
	(1, 'bob@node.se', '$2b$10$7s4yfYXT.9ElDSEzW0xw6uv1gE99u45HlK9ESjjbshfAnRhbhqqce', 'Bob', 'Node'),
	(2, 'ben@node.se', '$2b$10$9HqnbybYby9JQI1o0srtMe4p4ip4PtEhVoUlNNpbKcgTZvufWpOEG', 'Ben', 'Node');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table nodemusic.ytm_cache
CREATE TABLE IF NOT EXISTS `ytm_cache` (
  `request_url` varchar(256) NOT NULL DEFAULT '',
  `response_body` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`response_body`)),
  PRIMARY KEY (`request_url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table nodemusic.ytm_cache: ~0 rows (approximately)
/*!40000 ALTER TABLE `ytm_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `ytm_cache` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
