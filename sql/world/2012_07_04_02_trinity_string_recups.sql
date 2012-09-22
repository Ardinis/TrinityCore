/*
SQLyog Community v10.11 
MySQL - 5.1.63-0+squeeze1-log : Database - wod-world
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `trinity_string` */

DROP TABLE IF EXISTS `trinity_string`;

CREATE TABLE `trinity_string` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `content_default` text NOT NULL,
  `content_loc1` text,
  `content_loc2` text,
  `content_loc3` text,
  `content_loc4` text,
  `content_loc5` text,
  `content_loc6` text,
  `content_loc7` text,
  `content_loc8` text,
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `trinity_string` */

insert  into `trinity_string`(`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`) values (11205,'Votre récupération n\'a pas encore été acceptée.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11200,'Votre récupération a déjà été effectuée.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11201,'Votre récupération a été refusée.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11203,'Félicitations, votre récupération est maintenant terminée !',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11204,'Aucune récupération n\'existe pour votre personnage.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(783,'La bataille pour le joug s\'est arretée ! Pas assez de d\'attaquants.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Битва за Озеро Ледяных Оков Остановлена. Не хватает нападающих. Крепость остается защитникам.'),(11206,'It\'s the first time someone report this quest, thanks for you\'re help !',NULL,'Vous êtes le premier à reporter cette quête, merci de votre aide !',NULL,NULL,NULL,NULL,NULL,NULL),(11207,'Cette quête a déjà été reportée par un ou plusieurs joueurs, mais aucun mj n\'a encore vérifié l\'état de celle-ci. Vous pouvez effectuer une requête, pour accélérer la vérification.',NULL,'Cette quête a déjà été reportée par un ou plusieurs joueurs, mais aucun mj n\'a encore vérifié l\'état de celle-ci. Vous pouvez effectuer une requête, pour accélérer la vérification.',NULL,NULL,NULL,NULL,NULL,NULL),(11208,'Vous ne possédez pas cette quête !',NULL,'Vous ne possédez pas cette quête !',NULL,NULL,NULL,NULL,NULL,NULL),(11209,'La quête vient de vous être validée. Bon jeu !',NULL,'La quête vient de vous être validée. Bon jeu !',NULL,NULL,NULL,NULL,NULL,NULL),(11210,'Cette quête est, soit fonctionnelle, soit non validable par le système de report. Merci de contacter un mj via requête. Bon jeu à vous.',NULL,'Cette quête est, soit fonctionnelle, soit non validable par le système de report. Merci de contacter un mj via requête. Bon jeu à vous.',NULL,NULL,NULL,NULL,NULL,NULL),(11211,'Cette quête est désormais archivée comme ayant un bug et nécessitant une auto-validation.',NULL,'Cette quête est désormais archivée comme ayant un bug et nécessitant une auto-validation.',NULL,NULL,NULL,NULL,NULL,NULL),(11212,'Cette quête est déjà archivée en auto-validation.',NULL,'Cette quête est déjà archivée en auto-validation.',NULL,NULL,NULL,NULL,NULL,NULL),(11213,'Cette quête est désormais archivée comme fonctionnelle ou ne correspondant pas aux critères d\'auto-validation.',NULL,'Cette quête est désormais archivée comme fonctionnelle ou ne correspondant pas aux critères d\'auto-validation.',NULL,NULL,NULL,NULL,NULL,NULL),(11214,'La quête possède déjà l\'archivage fonctionnel.',NULL,'La quête possède déjà l\'archivage fonctionnel',NULL,NULL,NULL,NULL,NULL,NULL),(11215,'Cette quête n\'a jamais été reportée.',NULL,'Cette quête n\'a jamais été reportée.',NULL,NULL,NULL,NULL,NULL,NULL),(11216,'Cette quête a déjà été reportée mais non vérifiée par le staff.',NULL,'Cette quête a déjà été reportée mais non vérifiée par le staff.',NULL,NULL,NULL,NULL,NULL,NULL),(11217,'Cette quête est signalée comme bugée, utilisez la commande .report #quest.',NULL,'Cette quête est signalée comme bugée, utilisez la commande .report #quest.',NULL,NULL,NULL,NULL,NULL,NULL),(11218,'Cette quête est signalée comme étant fonctionnelle, ou non validable par ce système.',NULL,'Cette quête est signalée comme étant fonctionnelle, ou non validable par ce système.',NULL,NULL,NULL,NULL,NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
