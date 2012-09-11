
DROP TABLE IF EXISTS `char_report_quests`;

CREATE TABLE `char_report_quests` (
  `guid` INT(64) UNSIGNED NOT NULL,
  `quest` INT(32) UNSIGNED NOT NULL
) ENGINE=MYISAM DEFAULT CHARSET=latin1;
