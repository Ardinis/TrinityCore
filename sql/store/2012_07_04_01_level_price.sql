/*
SQLyog Community v10.11 
MySQL - 5.1.63-0+squeeze1-log : Database - allopass
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `level` */

DROP TABLE IF EXISTS `level`;

CREATE TABLE `level` (
  `level` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `price` int(3) unsigned NOT NULL DEFAULT '0',
  `nblevel` int(2) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`level`),
  UNIQUE KEY `id` (`level`)
) ENGINE=MyISAM AUTO_INCREMENT=81 DEFAULT CHARSET=latin1;

/*Data for the table `level` */

insert  into `level`(`level`,`price`,`nblevel`) values (1,5,7),(2,5,7),(3,5,7),(4,5,7),(5,5,7),(6,5,7),(7,5,7),(8,5,7),(9,5,7),(10,5,7),(11,5,7),(12,5,7),(13,5,7),(14,5,7),(15,5,7),(16,5,7),(17,5,7),(18,5,7),(19,5,7),(20,7,5),(21,7,5),(22,7,5),(23,7,5),(24,7,5),(25,7,5),(26,7,5),(27,7,5),(28,7,5),(29,7,5),(30,7,5),(31,7,5),(32,7,5),(33,7,5),(34,7,5),(35,7,5),(36,7,5),(37,7,5),(38,7,5),(39,7,5),(40,7,3),(41,7,3),(42,7,3),(43,7,3),(44,7,3),(45,7,3),(46,7,3),(47,7,3),(48,7,3),(49,7,3),(50,7,2),(51,7,2),(52,7,2),(53,7,2),(54,7,2),(55,7,2),(56,7,2),(57,7,2),(58,7,2),(59,7,2),(60,10,1),(61,10,1),(62,10,1),(63,10,1),(64,10,1),(65,10,1),(66,10,1),(67,10,1),(68,10,1),(69,10,1),(70,15,1),(71,15,1),(72,15,1),(73,15,1),(74,15,1),(75,15,1),(76,15,1),(77,15,1),(78,15,1),(79,20,1),(80,20,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
