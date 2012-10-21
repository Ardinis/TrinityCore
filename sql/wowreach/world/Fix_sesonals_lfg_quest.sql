UPDATE quest_template SET ZoneOrSort='-370', SpecialFlags='8' WHERE Id='25483'; -- World Event Dungeon - Coren Direbrew
UPDATE quest_template SET ZoneOrSort='-22', SpecialFlags='8' WHERE Id='25482';  -- World Event Dungeon - Headless Horseman
UPDATE quest_template SET ZoneOrSort='-369', SpecialFlags='8' WHERE Id='25484'; -- World Event Dungeon - Ahune
UPDATE quest_template SET ZoneOrSort='-376', SpecialFlags='8' WHERE Id='25485'; -- World Event Dungeon - Hummel

INSERT INTO `lfg_dungeon_encounters` VALUES 
('295', '287'),  -- Achievement: Direbrewfest
('4624', '288'), -- Achievement: Tough Love
('255', '285');  -- Achievement: Bring Me The Head of... Oh Wait

DROP TABLE IF EXISTS `lfg_holiday_dungeon`;
CREATE TABLE `lfg_holiday_dungeon` (
  `dungeonId` int(10) NOT NULL,
  `holiday` int(10) NOT NULL,
  PRIMARY KEY (`dungeonId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `lfg_holiday_dungeon` VALUES 
('285', '324'),
('286', '341'),
('287', '372'),
('288', '423');