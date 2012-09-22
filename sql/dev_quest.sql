/*Table structure for table `dev_quests` */

DROP TABLE IF EXISTS `dev_quests`;

CREATE TABLE `dev_quests` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  `comments` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

