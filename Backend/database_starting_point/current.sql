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
  `ytid` varchar(50) COLLATE utf8mb4_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Dumping data for table nodemusic.users: ~3 rows (approximately)
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

-- Dumping data for table nodemusic.ytm_cache: ~4 rows (approximately)
/*!40000 ALTER TABLE `ytm_cache` DISABLE KEYS */;
INSERT INTO `ytm_cache` (`request_url`, `response_body`) VALUES
	('/api/yt/search/@artist%20adult.', '{"content":[{"type":"song","videoId":"pEZ9jRIIi1o","playlistId":"RDAMVMpEZ9jRIIi1o","name":"R.S.x","artist":{"name":"Adult.","browseId":"UChQOJyZRyfic1vHuP2y3D3w"},"album":{"name":"Why Bother?","browseId":"MPREb_vBqfPa8kfr6"},"duration":254000,"thumbnails":[{"url":"https://lh3.googleusercontent.com/yJEq_H-fpr09jHJHe1za5X71SFap83CkjHUauI4Mql6qTXggm7nMqB-AYHTwzjjJmTzjtU8K7u35cLBRfw=w60-h60-l90-rj","width":60,"height":60},{"url":"https://lh3.googleusercontent.com/yJEq_H-fpr09jHJHe1za5X71SFap83CkjHUauI4Mql6qTXggm7nMqB-AYHTwzjjJmTzjtU8K7u35cLBRfw=w120-h120-l90-rj","width":120,"height":120}],"params":"wAEB"},{"type":"song","videoId":"lkhDGaIReEE","playlistId":"RDAMVMlkhDGaIReEE","name":"Don\'t Talk (Redux)","artist":{"name":"Adult.","browseId":"UChQOJyZRyfic1vHuP2y3D3w"},"album":{"name":"D.U.M.E.","browseId":"MPREb_2WyeoaLNnDN"},"duration":180000,"thumbnails":[{"url":"https://lh3.googleusercontent.com/-R8pVMTlOpow1iXD19EoXpbMdeDCDhlym-gSxOgHGhA6RsziwZt97iA5yh_AFY0Zvf1mCeN7ER9RKcUB=w60-h60-l90-rj","width":60,"height":60},{"url":"https://lh3.googleusercontent.com/-R8pVMTlOpow1iXD19EoXpbMdeDCDhlym-gSxOgHGhA6RsziwZt97iA5yh_AFY0Zvf1mCeN7ER9RKcUB=w120-h120-l90-rj","width":120,"height":120}],"params":"wAEB"},{"type":"song","videoId":"ysIZIowQJns","playlistId":"RDAMVMysIZIowQJns","name":"Cultivation","artist":{"name":"Adult.","browseId":"UChQOJyZRyfic1vHuP2y3D3w"},"album":{"name":"Why Bother?","browseId":"MPREb_vBqfPa8kfr6"},"duration":133000,"thumbnails":[{"url":"https://lh3.googleusercontent.com/yJEq_H-fpr09jHJHe1za5X71SFap83CkjHUauI4Mql6qTXggm7nMqB-AYHTwzjjJmTzjtU8K7u35cLBRfw=w60-h60-l90-rj","width":60,"height":60},{"url":"https://lh3.googleusercontent.com/yJEq_H-fpr09jHJHe1za5X71SFap83CkjHUauI4Mql6qTXggm7nMqB-AYHTwzjjJmTzjtU8K7u35cLBRfw=w120-h120-l90-rj","width":120,"height":120}],"params":"wAEB"},{"type":"song","videoId":"Si4nNGdU_lU","playlistId":"RDAMVMSi4nNGdU_lU","name":"Still Waiting","artist":{"name":"Adult.","browseId":"UChQOJyZRyfic1vHuP2y3D3w"},"album":{"name":"Gimmie Trouble","browseId":"MPREb_wiZhNVtsPHi"},"duration":149000,"thumbnails":[{"url":"https://lh3.googleusercontent.com/uy_-O6elElpPoYrlTtIvTnDpTNZUPu-UZJTf11UYQQe0v0F3u4MjKtl8gjsdf89BVIz0bbUiURJ6Lf4=w60-h60-l90-rj","width":60,"height":60},{"url":"https://lh3.googleusercontent.com/uy_-O6elElpPoYrlTtIvTnDpTNZUPu-UZJTf11UYQQe0v0F3u4MjKtl8gjsdf89BVIz0bbUiURJ6Lf4=w120-h120-l90-rj","width":120,"height":120}],"params":"wAEB"},{"type":"video","videoId":"WxuCfX0EdZY","playlistId":"RDAMVMWxuCfX0EdZY","name":"Adult Art Club - Lungs","author":"Confession","views":"49K views","duration":315000,"thumbnails":{"url":"https://i.ytimg.com/vi/WxuCfX0EdZY/sddefault.jpg?sqp=-oaymwEWCJADEOEBIAQqCghqEJQEGHgg6AJIWg&rs=AMzJL3lvEdeuF_MOaN_4AodNfC_SKcf1NQ","width":400,"height":225},"params":"wAEB"},{"type":"video","videoId":"NhheiPTdZCw","playlistId":"RDAMVMNhheiPTdZCw","name":"The Music Scene","author":"Blockhead","views":"15M views","duration":322000,"thumbnails":{"url":"https://i.ytimg.com/vi/NhheiPTdZCw/sddefault.jpg?sqp=-oaymwEWCJADEOEBIAQqCghqEJQEGHgg6AJIWg&rs=AMzJL3kCpSBJ_wRiGrl_X3xYzAoFN5xpxA","width":400,"height":225},"params":"wAEB"},{"type":"video","videoId":"qv_Zmwlso68","playlistId":"RDAMVMqv_Zmwlso68","name":"Sondia (손디아) - Adult (어른) My Mister/나의 아저씨 OST Part 2 LYRICS","author":"setsu29","views":"2.4M views","duration":258000,"thumbnails":{"url":"https://i.ytimg.com/vi/qv_Zmwlso68/sddefault.jpg?sqp=-oaymwEWCJADEOEBIAQqCghqEJQEGHgg6AJIWg&rs=AMzJL3n4wqldDzCyf1m4cCwf_4Saz-LDww","width":400,"height":225},"params":"wAEB"},{"type":"single","browseId":"MPREb_1V3oInqp3Xw","playlistId":"OLAK5uy_kfO2EPRNQpGsDbQ8BlQbSlB2NjQChpRhk","name":"TOUCHIN\'","artist":"KANG DANIEL","year":"2019","thumbnails":[{"url":"https://lh3.googleusercontent.com/C6pVtG_LSbKWbMR6IKcsrSt4KskAyzCYGbQ3tNPAthGg9E01TKfrm7q93XAfE6mD81iRmb2wT8SElTRf=w60-h60-l90-rj","width":60,"height":60},{"url":"https://lh3.googleusercontent.com/C6pVtG_LSbKWbMR6IKcsrSt4KskAyzCYGbQ3tNPAthGg9E01TKfrm7q93XAfE6mD81iRmb2wT8SElTRf=w120-h120-l90-rj","width":120,"height":120},{"url":"https://lh3.googleusercontent.com/C6pVtG_LSbKWbMR6IKcsrSt4KskAyzCYGbQ3tNPAthGg9E01TKfrm7q93XAfE6mD81iRmb2wT8SElTRf=w226-h226-l90-rj","width":226,"height":226},{"url":"https://lh3.googleusercontent.com/C6pVtG_LSbKWbMR6IKcsrSt4KskAyzCYGbQ3tNPAthGg9E01TKfrm7q93XAfE6mD81iRmb2wT8SElTRf=w544-h544-l90-rj","width":544,"height":544}]},{"type":"album","browseId":"MPREb_mcbiinetLPH","playlistId":"OLAK5uy_nHndL7FId8NVtNhEMts0DRfFRZm1l6_g4","name":"Place","artist":"Croq","year":"2017","thumbnails":[{"url":"https://lh3.googleusercontent.com/2SbpHSPEmGy1wpn-MFsjhC7j_4_zDZb_G3CZXda6MFgBNEU294SUXYpQDyJFzvavZ2EUf2rG6CKdP6Xr=w60-h60-l90-rj","width":60,"height":60},{"url":"https://lh3.googleusercontent.com/2SbpHSPEmGy1wpn-MFsjhC7j_4_zDZb_G3CZXda6MFgBNEU294SUXYpQDyJFzvavZ2EUf2rG6CKdP6Xr=w120-h120-l90-rj","width":120,"height":120},{"url":"https://lh3.googleusercontent.com/2SbpHSPEmGy1wpn-MFsjhC7j_4_zDZb_G3CZXda6MFgBNEU294SUXYpQDyJFzvavZ2EUf2rG6CKdP6Xr=w226-h226-l90-rj","width":226,"height":226},{"url":"https://lh3.googleusercontent.com/2SbpHSPEmGy1wpn-MFsjhC7j_4_zDZb_G3CZXda6MFgBNEU294SUXYpQDyJFzvavZ2EUf2rG6CKdP6Xr=w544-h544-l90-rj","width":544,"height":544}]},{"type":"ep","browseId":"MPREb_sTibC5c63SF","playlistId":"OLAK5uy_mFdOXMil6K4KzTx65TvA9DWIxrdd8MaVM","name":"Call Me Crazy, But...","artist":"Sevyn Streeter","year":"2013","thumbnails":[{"url":"https://lh3.googleusercontent.com/uM9urtcTmjFzatrXW57VJgCDjT5G9vlQp2PKHPx_pyyovVRlMxGnd4HC-GAW8NPRTi2HJBLtoNTaJYMA=w60-h60-l90-rj","width":60,"height":60},{"url":"https://lh3.googleusercontent.com/uM9urtcTmjFzatrXW57VJgCDjT5G9vlQp2PKHPx_pyyovVRlMxGnd4HC-GAW8NPRTi2HJBLtoNTaJYMA=w120-h120-l90-rj","width":120,"height":120},{"url":"https://lh3.googleusercontent.com/uM9urtcTmjFzatrXW57VJgCDjT5G9vlQp2PKHPx_pyyovVRlMxGnd4HC-GAW8NPRTi2HJBLtoNTaJYMA=w226-h226-l90-rj","width":226,"height":226},{"url":"https://lh3.googleusercontent.com/uM9urtcTmjFzatrXW57VJgCDjT5G9vlQp2PKHPx_pyyovVRlMxGnd4HC-GAW8NPRTi2HJBLtoNTaJYMA=w544-h544-l90-rj","width":544,"height":544}]},{"type":"artist","browseId":"UCJvOvKwxPEL-4RtSvu_nWhQ","name":"Flying Lotus","thumbnails":[{"url":"https://lh3.googleusercontent.com/3HKT8dYPecOWvMYqElXn6dVvcpSFe7qkZdZpr3B2F7VDcPGQZmY-TQL6TgsnLgPXT0sdmNqNSMyUkpk=w60-h60-l90-rj","width":60,"height":60},{"url":"https://lh3.googleusercontent.com/3HKT8dYPecOWvMYqElXn6dVvcpSFe7qkZdZpr3B2F7VDcPGQZmY-TQL6TgsnLgPXT0sdmNqNSMyUkpk=w120-h120-l90-rj","width":120,"height":120}]},{"type":"playlist redlist world hits 40 songs","browseId":"VLPLMmqTuUsDkRLf1nFrFrmHbnrAdp4i6CWH","title":"New Indie Music 2021 ♫ Best Indie Songs 2021 Playlist","author":" • ","count":null,"thumbnails":[{"url":"https://yt3.ggpht.com/A_aXotvmgLcN2Xowi_upeBFKl9SSr67o_sLQRvrsZ8-XRExaPY8hz6BAYBbHdhHXMPZyDRbElg=s192","width":192,"height":192},{"url":"https://yt3.ggpht.com/A_aXotvmgLcN2Xowi_upeBFKl9SSr67o_sLQRvrsZ8-XRExaPY8hz6BAYBbHdhHXMPZyDRbElg=s576","width":576,"height":576},{"url":"https://yt3.ggpht.com/A_aXotvmgLcN2Xowi_upeBFKl9SSr67o_sLQRvrsZ8-XRExaPY8hz6BAYBbHdhHXMPZyDRbElg=s1200","width":1200,"height":1200}]},{"type":"playlist xiao bai 72 songs","browseId":"VLPL5l9iRZwq9UmPEsavxxQWGb11_RlHhPZW","title":"Artist - 林宥嘉","author":" • ","count":null,"thumbnails":[{"url":"https://i.ytimg.com/vi/hrdQ_6K6oXk/sddefault.jpg?sqp=-oaymwEWCJADEOEBIAQqCghqEJQEGHgg6AJIWg&rs=AMzJL3n4tu45kG8je4_jqwplObjyFf1rwQ","width":400,"height":225},{"url":"https://i.ytimg.com/vi/hrdQ_6K6oXk/hq720.jpg?sqp=-oaymwEXCKAGEMIDIAQqCwjVARCqCBh4INgESFo&rs=AMzJL3lSBnZ7iIEpePl7ubPMTeDgmN4kJA","width":800,"height":450},{"url":"https://i.ytimg.com/vi/hrdQ_6K6oXk/hq720.jpg?sqp=-oaymwEXCNUGEOADIAQqCwjVARCqCBh4INgESFo&rs=AMzJL3nYlFSQBpE7zktqZlIfgUH4io23Ww","width":853,"height":480}]},{"type":"playlist nightingales music 168 songs","browseId":"VLPLWlTX25IDqIwQdg8jzo47Cqw28Fpgilrq","title":"FUNERAL SONGS RIP TRIBUTES Playlist 2021","author":" • ","count":null,"thumbnails":[{"url":"https://yt3.ggpht.com/eY5X8sGTOOwqD6ogRYfZnxi6wNEVQ6vvqLk4SUBd627163I2OvizijOBlqPi1w9tp47jGexDpv8J=s192","width":192,"height":192},{"url":"https://yt3.ggpht.com/eY5X8sGTOOwqD6ogRYfZnxi6wNEVQ6vvqLk4SUBd627163I2OvizijOBlqPi1w9tp47jGexDpv8J=s576","width":576,"height":576},{"url":"https://yt3.ggpht.com/eY5X8sGTOOwqD6ogRYfZnxi6wNEVQ6vvqLk4SUBd627163I2OvizijOBlqPi1w9tp47jGexDpv8J=s1200","width":1200,"height":1200}]}]}'),
	('/api/yt/search/@artist%20belle', '{"content":[{"type":"video","videoId":"RUUHlsVNfNQ","playlistId":"RDAMVMRUUHlsVNfNQ","name":"NAVRATH/DANDIYA SHOW CRAZY CHAPS EVENTS +919826181112","author":"crazychapsindia1","views":"98 views","duration":52000,"thumbnails":{"url":"https://i.ytimg.com/vi/RUUHlsVNfNQ/sddefault.jpg?sqp=-oaymwEWCJADEOEBIAQqCghqEJQEGHgg6AJIWg&rs=AMzJL3mQ0EaU78H1STCfj1PekeM9dy6-1w","width":400,"height":225},"params":"wAEB"}]}'),
	('/api/yt/search/@song%20temptation', '{"content":[{"type":"playlist zumba trey gaming ztg 116 songs","browseId":"VLPLOvb6vN-PD2aM-1GNz5_i1Q8X7FwS3Hpp","title":"@song","author":" • ","count":null,"thumbnails":[{"url":"https://yt3.ggpht.com/ttyKhUmGSj61QAMikmXu5hKaoepNvOmiyYThevoWehfuCWgGo_teXLvu-bIHydvtfJgwLlY5Bw=s192","width":192,"height":192},{"url":"https://yt3.ggpht.com/ttyKhUmGSj61QAMikmXu5hKaoepNvOmiyYThevoWehfuCWgGo_teXLvu-bIHydvtfJgwLlY5Bw=s576","width":576,"height":576},{"url":"https://yt3.ggpht.com/ttyKhUmGSj61QAMikmXu5hKaoepNvOmiyYThevoWehfuCWgGo_teXLvu-bIHydvtfJgwLlY5Bw=s1200","width":1200,"height":1200}]},{"type":"playlist ximeyami 178 songs","browseId":"VLPL3CAA77354366477C","title":"Super Junior","author":" • ","count":null,"thumbnails":{"url":"https://i.ytimg.com/vi/YwyXCYQSA6s/hqdefault.jpg?sqp=-oaymwEWCMACELQBIAQqCghQEJADGFogjgJIWg&rs=AMzJL3l3B78sn9dj4bW0sZj2D1t7IdE5lw","width":320,"height":180}}]}'),
	('/api/yt/search/adult%20see', '{"content":[{"type":"video","videoId":"SvuFicZH3Jw","playlistId":"RDAMVMSvuFicZH3Jw","name":"Bhor Bhaye Panghat Pe","author":"Lata Mangeshkar","views":"22M views","duration":259000,"thumbnails":{"url":"https://i.ytimg.com/vi/SvuFicZH3Jw/hqdefault.jpg?sqp=-oaymwEWCMACELQBIAQqCghQEJADGFogjgJIWg&rs=AMzJL3nIJSh9HfMV8q4y-I_GlS60Tohnew","width":320,"height":180},"params":"wAEB"},{"type":"song","videoId":"yR79oLrI1g4","playlistId":"RDAMVMyR79oLrI1g4","name":"Adult Film (feat. Swizz Beatz)","artist":{"name":"Nas","browseId":"UCPoQYATXIYvN5WB0c4f6jfQ"},"album":{"name":"The Lost Tapes 2","browseId":"MPREb_X9wIoE8OvR7"},"duration":251000,"thumbnails":[{"url":"https://lh3.googleusercontent.com/wUPvXioPdN7Ztk8-NP0uuj75-x8Nz2utUc9d1058MLEEkdBgvv55RJiA0Dto0iB9dXWHvks0_fKduDVf=w60-h60-l90-rj","width":60,"height":60},{"url":"https://lh3.googleusercontent.com/wUPvXioPdN7Ztk8-NP0uuj75-x8Nz2utUc9d1058MLEEkdBgvv55RJiA0Dto0iB9dXWHvks0_fKduDVf=w120-h120-l90-rj","width":120,"height":120}],"params":"wAEB"},{"type":"song","videoId":"W9zuKCC046E","playlistId":"RDAMVMW9zuKCC046E","name":"Nobody Knows the Trouble I\'ve Seen","artist":{"name":"Louis Armstrong","browseId":"UCCDaSui4C9VFMpeRlKEOHDA"},"album":{"name":"Platinum Christian Music, Vol. 3","browseId":"MPREb_W9WGmaiH8qB"},"duration":190000,"thumbnails":[{"url":"https://lh3.googleusercontent.com/r_ELLJ13b9d_8xk5f8TnmTfNVxu_O_iB6ixHegA5moDR_YqGLEDw_-ZvushGgq1cPF4uGfCfZLTp2xVe=w60-h60-l90-rj","width":60,"height":60},{"url":"https://lh3.googleusercontent.com/r_ELLJ13b9d_8xk5f8TnmTfNVxu_O_iB6ixHegA5moDR_YqGLEDw_-ZvushGgq1cPF4uGfCfZLTp2xVe=w120-h120-l90-rj","width":120,"height":120}],"params":"wAEB"},{"type":"song","videoId":"c2bV9HScLx0","playlistId":"RDAMVMc2bV9HScLx0","name":"Nobody Knows the Trouble I\'ve Seen","artist":{"name":"Louis Armstrong","browseId":"UCCDaSui4C9VFMpeRlKEOHDA"},"album":{"name":"The Immortal Jazz Masters, Vol. 5","browseId":"MPREb_42kDaQ12Ely"},"duration":188000,"thumbnails":[{"url":"https://lh3.googleusercontent.com/-6Kv875g2BlmKQHLvUklKaA108f34M_sftX-2T_UDilBatY2G_jc1IdgsvePWFm0eFo_izejCqwfDLM3=w60-h60-l90-rj","width":60,"height":60},{"url":"https://lh3.googleusercontent.com/-6Kv875g2BlmKQHLvUklKaA108f34M_sftX-2T_UDilBatY2G_jc1IdgsvePWFm0eFo_izejCqwfDLM3=w120-h120-l90-rj","width":120,"height":120}],"params":"wAEB"},{"type":"video","videoId":"6m_CbDMIdlI","playlistId":"RDAMVM6m_CbDMIdlI","name":"Adult","author":"Ceremony","views":"1M views","duration":188000,"thumbnails":{"url":"https://i.ytimg.com/vi/6m_CbDMIdlI/sddefault.jpg?sqp=-oaymwEWCJADEOEBIAQqCghqEJQEGHgg6AJIWg&rs=AMzJL3nuix5NGQVnWPnTf3dz36ToiIay0Q","width":400,"height":225},"params":"wAEB"},{"type":"video","videoId":"1ZYbU82GVz4","playlistId":"RDAMVM1ZYbU82GVz4","name":"Relaxing Sleep Music • Deep Sleeping Music, Relaxing Music, Stress Relief, Meditation Music (Flying)","author":"Soothing Relaxation","views":"249M views","duration":10822000,"thumbnails":{"url":"https://i.ytimg.com/vi/1ZYbU82GVz4/sddefault.jpg?sqp=-oaymwEWCJADEOEBIAQqCghqEJQEGHgg6AJIWg&rs=AMzJL3mZHuU_Bkr64D2qqDRScrQzNF363Q","width":400,"height":225},"params":"wAEB"},{"type":"video","videoId":"NhheiPTdZCw","playlistId":"RDAMVMNhheiPTdZCw","name":"The Music Scene","author":"Blockhead","views":"15M views","duration":322000,"thumbnails":{"url":"https://i.ytimg.com/vi/NhheiPTdZCw/sddefault.jpg?sqp=-oaymwEWCJADEOEBIAQqCghqEJQEGHgg6AJIWg&rs=AMzJL3kCpSBJ_wRiGrl_X3xYzAoFN5xpxA","width":400,"height":225},"params":"wAEB"},{"type":"album","browseId":"MPREb_HfagDzjvzrC","playlistId":"OLAK5uy_krnu-lHGE87RHZCayMr60v8F3blPL20PA","name":"Home","artist":"Billy Strings","year":"2019","thumbnails":[{"url":"https://lh3.googleusercontent.com/_sJbRt8VsRzm5T9O7i9ceKfHe78bth_bBQWec12dUhqgdrOc28oQ8Fq8cRbfz2iTSoes8DY8nQoCRuFA=w60-h60-l90-rj","width":60,"height":60},{"url":"https://lh3.googleusercontent.com/_sJbRt8VsRzm5T9O7i9ceKfHe78bth_bBQWec12dUhqgdrOc28oQ8Fq8cRbfz2iTSoes8DY8nQoCRuFA=w120-h120-l90-rj","width":120,"height":120},{"url":"https://lh3.googleusercontent.com/_sJbRt8VsRzm5T9O7i9ceKfHe78bth_bBQWec12dUhqgdrOc28oQ8Fq8cRbfz2iTSoes8DY8nQoCRuFA=w226-h226-l90-rj","width":226,"height":226},{"url":"https://lh3.googleusercontent.com/_sJbRt8VsRzm5T9O7i9ceKfHe78bth_bBQWec12dUhqgdrOc28oQ8Fq8cRbfz2iTSoes8DY8nQoCRuFA=w544-h544-l90-rj","width":544,"height":544}]},{"type":"album","browseId":"MPREb_sTH2IfmO7kB","playlistId":"OLAK5uy_kAaHDDsSEe4RMPdLSG5FJ0NOwqRYivkjc","name":"Three","artist":"Patoranking","year":"2020","thumbnails":[{"url":"https://lh3.googleusercontent.com/oog--DvNI3L2Um3t6eWtFjV5NtsUl8y5YnfoNOe68kHBmX9H0G38UHhVV_mtvmv97r-TgAEx4TXWmJ_Kpw=w60-h60-l90-rj","width":60,"height":60},{"url":"https://lh3.googleusercontent.com/oog--DvNI3L2Um3t6eWtFjV5NtsUl8y5YnfoNOe68kHBmX9H0G38UHhVV_mtvmv97r-TgAEx4TXWmJ_Kpw=w120-h120-l90-rj","width":120,"height":120},{"url":"https://lh3.googleusercontent.com/oog--DvNI3L2Um3t6eWtFjV5NtsUl8y5YnfoNOe68kHBmX9H0G38UHhVV_mtvmv97r-TgAEx4TXWmJ_Kpw=w226-h226-l90-rj","width":226,"height":226},{"url":"https://lh3.googleusercontent.com/oog--DvNI3L2Um3t6eWtFjV5NtsUl8y5YnfoNOe68kHBmX9H0G38UHhVV_mtvmv97r-TgAEx4TXWmJ_Kpw=w544-h544-l90-rj","width":544,"height":544}]},{"type":"album","browseId":"MPREb_Vu8Rdaalq6G","playlistId":"OLAK5uy_nRMW4si38-CVkn0RqENkSd_29wPIGpBzA","name":"Come To The Well","artist":"Casting Crowns","year":"2011","thumbnails":[{"url":"https://lh3.googleusercontent.com/8-GVXXUa-ERJOEDxyUCkLoudM_oPYi2mvhU_5HtX2iihl977LbzMKniPW4USPHbdvBnZ_LmqNAuuUPQ9=w60-h60-l90-rj","width":60,"height":60},{"url":"https://lh3.googleusercontent.com/8-GVXXUa-ERJOEDxyUCkLoudM_oPYi2mvhU_5HtX2iihl977LbzMKniPW4USPHbdvBnZ_LmqNAuuUPQ9=w120-h120-l90-rj","width":120,"height":120},{"url":"https://lh3.googleusercontent.com/8-GVXXUa-ERJOEDxyUCkLoudM_oPYi2mvhU_5HtX2iihl977LbzMKniPW4USPHbdvBnZ_LmqNAuuUPQ9=w226-h226-l90-rj","width":226,"height":226},{"url":"https://lh3.googleusercontent.com/8-GVXXUa-ERJOEDxyUCkLoudM_oPYi2mvhU_5HtX2iihl977LbzMKniPW4USPHbdvBnZ_LmqNAuuUPQ9=w544-h544-l90-rj","width":544,"height":544}]},{"type":"artist","browseId":"UC8zbYR5i0gecEZ3iPgm-i9g","name":"Hall & Oates","thumbnails":[{"url":"https://lh3.googleusercontent.com/TlpOk1KiRHqbuEN7mku1Y8gt4qosRlZ1u0uGZl-OjG-_6-suUF4Y1ibBijRf_AwW65feTckb02wE5arF=w60-h60-p-l90-rj","width":60,"height":60},{"url":"https://lh3.googleusercontent.com/TlpOk1KiRHqbuEN7mku1Y8gt4qosRlZ1u0uGZl-OjG-_6-suUF4Y1ibBijRf_AwW65feTckb02wE5arF=w120-h120-p-l90-rj","width":120,"height":120}]},{"type":"playlist ukhio 396 songs","browseId":"VLPLEFA1204CC48584A2","title":"My favorite Adult Swim bumps !! and Nujabes ,...","author":" • ","count":null,"thumbnails":[{"url":"https://lh3.googleusercontent.com/D_bwZhJ5McWI50eYNhjgSrf-rJsOlLpEtw0foRg9Sew73SOvpSfrQ5SDO3dxGvh9AotbkUrJlRI1iIy62w=w60-h60-l90-rj","width":60,"height":60},{"url":"https://lh3.googleusercontent.com/D_bwZhJ5McWI50eYNhjgSrf-rJsOlLpEtw0foRg9Sew73SOvpSfrQ5SDO3dxGvh9AotbkUrJlRI1iIy62w=w120-h120-l90-rj","width":120,"height":120},{"url":"https://lh3.googleusercontent.com/D_bwZhJ5McWI50eYNhjgSrf-rJsOlLpEtw0foRg9Sew73SOvpSfrQ5SDO3dxGvh9AotbkUrJlRI1iIy62w=w226-h226-l90-rj","width":226,"height":226},{"url":"https://lh3.googleusercontent.com/D_bwZhJ5McWI50eYNhjgSrf-rJsOlLpEtw0foRg9Sew73SOvpSfrQ5SDO3dxGvh9AotbkUrJlRI1iIy62w=w544-h544-l90-rj","width":544,"height":544}]},{"type":"playlist best beginner guitar lessons 255 songs","browseId":"VLPLhDp-NXXZOh5FI7s8AejaPYQEW6rkOjC9","title":"Guitar Lessons For Adults","author":" • ","count":null,"thumbnails":{"url":"https://i.ytimg.com/vi/YJPo3erxq0A/hqdefault.jpg?sqp=-oaymwEWCMACELQBIAQqCghQEJADGFogjgJIWg&rs=AMzJL3mXRrgCN9STH9JCdBQ20RyujUMyPw","width":320,"height":180}},{"type":"playlist church of the presentation 94 songs","browseId":"VLPLuQLmDShVHRsqScWN2f63um4B1OL48KFH","title":"2017 Adult Choir - 11:30 Masses","author":" • ","count":null,"thumbnails":{"url":"https://i.ytimg.com/vi/rLQM2Omd5lI/hqdefault.jpg?sqp=-oaymwEWCMACELQBIAQqCghQEJADGFogjgJIWg&rs=AMzJL3mWCe8wk-l5U82u0ic6XivRtJ6EiQ","width":320,"height":180}}]}');
/*!40000 ALTER TABLE `ytm_cache` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
