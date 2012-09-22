/*
SQLyog Community v10.11 
MySQL - 5.1.63-0+squeeze1 : Database - paragon-site
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `profession_spell` */

DROP TABLE IF EXISTS `profession_spell`;

CREATE TABLE `profession_spell` (
  `skill` int(11) unsigned NOT NULL,
  `spell` int(11) unsigned NOT NULL DEFAULT '0',
  `name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`skill`,`spell`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `profession_spell` */

insert  into `profession_spell`(`skill`,`spell`,`name`) values (165,2155,'Travail du cuir'),(171,2275,'Alchimie'),(164,2020,'Forge'),(333,7414,'Enchantement'),(202,4039,'Ingénierie'),(182,2372,'Herboristerie'),(773,45375,'Calligraphie'),(755,25245,'Joaillerie'),(186,2581,'Minage'),(393,8615,'Dépeçage'),(197,3911,'Couture');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
