DROP TABLE IF EXISTS `account_notes`; 
CREATE TABLE `account_notes` (
  `id` int(11) NOT NULL default '0' COMMENT 'Account id',
  `notedate` bigint(40) NOT NULL default '0',
  `notedby` varchar(50) NOT NULL,
  `text` varchar(255) NOT NULL,  
  PRIMARY KEY  (`id`,`notedate`) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Note List';
