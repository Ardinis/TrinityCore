DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `id` int(11) NOT NULL,
  `realm` int(11) NOT NULL,
  `val` int(11) NOT NULL,
  PRIMARY KEY  (`id`,`realm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
