
DELETE FROM trinity_string WHERE entry >= 11206 AND entry <= 11214; 
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES('11206','It\'s the first time someone report this quest, thanks for you\'re help !',NULL,'Vous �tes le premier � reporter cette qu�te, merci de votre aide !',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES('11207','Cette qu�te a d�j� �t� report�e par un ou plusieurs joueurs, mais aucun mj n\'a encore v�rifier l\'�tat de celle-ci. Vous pouvez effectuer une requ�te, pour acc�l�rer la mise en v�rification.',NULL,'Cette qu�te a d�j� �t� report�e par un ou plusieurs joueurs, mais aucun mj n\'a encore v�rifier l\'�tat de celle-ci. Vous pouvez effectuer une requ�te, pour acc�l�rer la mise en v�rification.',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES('11208','Vous ne poss�dez pas cette qu�te !',NULL,'Vous ne poss�dez pas cette qu�te !',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES('11209','La qu�te vient de vous �tre valid�e. Merci et bon jeux !',NULL,'La qu�te vient de vous �tre valid�e. Merci et bon jeux !',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES('11210','Cette qu�te est, soit fonctionnelle, soit non validable par le syst�me de report, merci de contacter un mj via le syst�me de requ�tes. Bon jeux � vous.',NULL,'Cette qu�te est, soit fonctionnelle, soit non validable par le syst�me de report, merci de contacter un mj via le syst�me de requ�tes. Bon jeux � vous.',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES('11211','Cette qu�te est d�sormais archiv�e comme ayant un bug et n�cessitant une auto-validation.',NULL,'Cette qu�te est d�sormais archiv�e comme ayant un bug et n�cessitant une auto-validation.',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES('11212','Cette qu�te est d�j� archiv�e en auto-validation.',NULL,'Cette qu�te est d�j� archiv�e en auto-validation.',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES('11213','Cette qu�te est d�sormais archiv�e comme fonctionnelle ou ne correspondant pas aux crit�res d\'auto-validation.',NULL,'Cette qu�te est d�sormais archiv�e comme fonctionnelle ou ne correspondant pas aux crit�res d\'auto-validation.',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES('11214','La qu�te poss�de d�j� l\'archivage fonctionnel.',NULL,'La qu�te poss�de d�j� l\'archivage fonctionnel',NULL,NULL,NULL,NULL,NULL,NULL);

REPLACE INTO `command` (`name`, `security`, `help`) VALUES('report','0','Syntax: .report quest #questLink/#questId');
REPLACE INTO `command` (`name`, `security`, `help`) VALUES('report complete','3','Syntax: .report complete #questLink/#questId (met la qu�te en auto-compl�tion via la commande .report)');
REPLACE INTO `command` (`name`, `security`, `help`) VALUES('report quest','0','Syntax: .report quest #questLink/#questId');
REPLACE INTO `command` (`name`, `security`, `help`) VALUES('report remove','3','Syntax: .report remove #questLink/#questId (met la qu�te en auto-compl�tion via la commande .report)');


DROP TABLE IF EXISTS `report_quest`;

CREATE TABLE `report_quest` (
  `id` INT(32) UNSIGNED NOT NULL AUTO_INCREMENT,
  `status` INT(32) UNSIGNED NOT NULL,
  `count` INT(32) UNSIGNED NOT NULL,
  `comment` TEXT,
  PRIMARY KEY (`id`)
) ENGINE=MYISAM DEFAULT CHARSET=latin1;

