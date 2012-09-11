
DELETE FROM trinity_string WHERE entry >= 11206 AND entry <= 11214; 
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES('11206','It\'s the first time someone report this quest, thanks for you\'re help !',NULL,'Vous êtes le premier à reporter cette quête, merci de votre aide !',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES('11207','Cette quête a déjà été reportée par un ou plusieurs joueurs, mais aucun mj n\'a encore vérifier l\'état de celle-ci. Vous pouvez effectuer une requête, pour accélérer la mise en vérification.',NULL,'Cette quête a déjà été reportée par un ou plusieurs joueurs, mais aucun mj n\'a encore vérifier l\'état de celle-ci. Vous pouvez effectuer une requête, pour accélérer la mise en vérification.',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES('11208','Vous ne possédez pas cette quête !',NULL,'Vous ne possédez pas cette quête !',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES('11209','La quête vient de vous être validée. Merci et bon jeux !',NULL,'La quête vient de vous être validée. Merci et bon jeux !',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES('11210','Cette quête est, soit fonctionnelle, soit non validable par le système de report, merci de contacter un mj via le système de requêtes. Bon jeux à vous.',NULL,'Cette quête est, soit fonctionnelle, soit non validable par le système de report, merci de contacter un mj via le système de requêtes. Bon jeux à vous.',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES('11211','Cette quête est désormais archivée comme ayant un bug et nécessitant une auto-validation.',NULL,'Cette quête est désormais archivée comme ayant un bug et nécessitant une auto-validation.',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES('11212','Cette quête est déjà archivée en auto-validation.',NULL,'Cette quête est déjà archivée en auto-validation.',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES('11213','Cette quête est désormais archivée comme fonctionnelle ou ne correspondant pas aux critères d\'auto-validation.',NULL,'Cette quête est désormais archivée comme fonctionnelle ou ne correspondant pas aux critères d\'auto-validation.',NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES('11214','La quête possède déjà l\'archivage fonctionnel.',NULL,'La quête possède déjà l\'archivage fonctionnel',NULL,NULL,NULL,NULL,NULL,NULL);

insert into `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) values('11215','Cette qu�te n\'a jamais �t� report.',NULL,'Cette quete n\'a jamais �t� report.',NULL,NULL,NULL,NULL,NULL,NULL);
insert into `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) values('11216','Cette qu�te a d�j� �t� report mais non verifi�e par le staff.',NULL,'Cette qu�te a d�j� �t� report mais non verifi�e par le staff.',NULL,NULL,NULL,NULL,NULL,NULL);
insert into `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) values('11217','Cette qu�te est signal�e comme bug�e, utilisez la commande .report #quest.',NULL,'Cette qu�te est signal�e comme bug�e, utilisez la commande .report #quest.',NULL,NULL,NULL,NULL,NULL,NULL);
insert into `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) values('11218','Cette qu�te est signal�e comme �tant fonctionnelle, ou non validable par ce syst�me.',NULL,'Cette qu�te est signal�e comme �tant fonctionnelle, ou non validable par ce syst�me.',NULL,NULL,NULL,NULL,NULL,NULL);

REPLACE INTO `command` (`name`, `security`, `help`) VALUES('report','0','Syntax: .report quest #questLink/#questId');
REPLACE INTO `command` (`name`, `security`, `help`) VALUES('report complete','3','Syntax: .report complete #questLink/#questId (met la quête en auto-complétion via la commande .report)');
REPLACE INTO `command` (`name`, `security`, `help`) VALUES('report quest','0','Syntax: .report quest #questLink/#questId');
REPLACE INTO `command` (`name`, `security`, `help`) VALUES('report remove','3','Syntax: .report remove #questLink/#questId (met la quête en auto-complétion via la commande .report)');



replace into `command` (`name`, `security`, `help`) values('report info','0','Syntax: .report remove #questLink/#questId (met la qu�te en auto-compl�tion via la commande .report)');



DROP TABLE IF EXISTS `report_quest`;

CREATE TABLE `report_quest` (
  `id` INT(32) UNSIGNED NOT NULL AUTO_INCREMENT,
  `status` INT(32) UNSIGNED NOT NULL,
  `count` INT(32) UNSIGNED NOT NULL,
  `comment` TEXT,
  PRIMARY KEY (`id`)
) ENGINE=MYISAM DEFAULT CHARSET=latin1;

