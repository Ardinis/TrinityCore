/*
SQLyog Community v10.11 
MySQL - 5.1.61-0+squeeze1-log : Database - allopass
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`allopass` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `allopass`;

/*Table structure for table `command` */

DROP TABLE IF EXISTS `command`;

CREATE TABLE `command` (
  `guid` int(11) NOT NULL AUTO_INCREMENT,
  `acctid` int(11) DEFAULT NULL,
  `charid` char(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `itemid` char(255) DEFAULT NULL,
  `statut` binary(1) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mj` int(11) DEFAULT NULL,
  UNIQUE KEY `guid` (`guid`)
) ENGINE=MyISAM AUTO_INCREMENT=2701 DEFAULT CHARSET=latin1;

/*Table structure for table `diamond` */

DROP TABLE IF EXISTS `diamond`;

CREATE TABLE `diamond` (
  `acctid` int(11) unsigned NOT NULL DEFAULT '0',
  `diamond` int(11) DEFAULT '0',
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `month_limit` int(3) unsigned NOT NULL DEFAULT '200',
  `is_allowed` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`acctid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `level` */

DROP TABLE IF EXISTS `level`;

CREATE TABLE `level` (
  `level` int(2) unsigned NOT NULL AUTO_INCREMENT,
  `price` int(3) unsigned NOT NULL DEFAULT '0',
  `nblevel` int(2) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`level`),
  UNIQUE KEY `id` (`level`)
) ENGINE=MyISAM AUTO_INCREMENT=81 DEFAULT CHARSET=latin1;

/*Table structure for table `log_votes` */

DROP TABLE IF EXISTS `log_votes`;

CREATE TABLE `log_votes` (
  `guid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account` int(11) unsigned NOT NULL,
  `nbvotes` int(5) unsigned NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `reward` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `logallo` */

DROP TABLE IF EXISTS `logallo`;

CREATE TABLE `logallo` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `acctid` int(8) NOT NULL,
  `code` varchar(8) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=36071 DEFAULT CHARSET=latin1;

/*Table structure for table `logpaypal` */

DROP TABLE IF EXISTS `logpaypal`;

CREATE TABLE `logpaypal` (
  `guid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acctid` int(11) NOT NULL DEFAULT '0',
  `txnid` varchar(17) NOT NULL DEFAULT '',
  `quantity` int(11) NOT NULL DEFAULT '0',
  `price` float(8,2) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM AUTO_INCREMENT=3649 DEFAULT CHARSET=latin1;

/*Table structure for table `lvl_bought` */

DROP TABLE IF EXISTS `lvl_bought`;

CREATE TABLE `lvl_bought` (
  `guid` int(255) unsigned NOT NULL AUTO_INCREMENT,
  `acctid` int(255) unsigned NOT NULL,
  `charid` int(255) unsigned NOT NULL,
  `clvl` int(2) unsigned NOT NULL,
  `elvl` int(2) unsigned NOT NULL,
  `nlvl` int(2) unsigned NOT NULL,
  `price` int(3) unsigned NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `guid` (`guid`)
) ENGINE=MyISAM AUTO_INCREMENT=30584 DEFAULT CHARSET=latin1;

/*Table structure for table `orders_log` */

DROP TABLE IF EXISTS `orders_log`;

CREATE TABLE `orders_log` (
  `guid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `acctid` int(11) unsigned NOT NULL,
  `charid` int(11) unsigned NOT NULL,
  `price` int(5) unsigned NOT NULL,
  `itemid` int(11) unsigned NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL,
  `mj` int(11) unsigned NOT NULL,
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM AUTO_INCREMENT=27260 DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
