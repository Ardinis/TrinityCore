/* le chevalier noir n'est plus réservé aux vaillants */

DELETE FROM `conditions` WHERE (SourceGroup = 10383) AND (SourceTypeOrReferenceId = 15);
INSERT INTO `conditions` VALUES (15, 10383, 0, 0, 0, 9, 0, 13664, 0, 0, 0, 0, '', ''),
(15, 10383, 0, 0, 2, 1, 0, 63501, 0, 0, 0, 0, '', ''),
(15, 10383, 0, 0, 1, 1, 0, 63606, 0, 0, 0, 0, '', ''),
(15, 10383, 0, 0, 2, 9, 0, 13664, 0, 0, 0, 0, '', ''),
(15, 10383, 0, 0, 0, 1, 0, 63500, 0, 0, 0, 0, '', ''),
(15, 10383, 0, 0, 1, 9, 0, 13664, 0, 0, 0, 0, '', '');
