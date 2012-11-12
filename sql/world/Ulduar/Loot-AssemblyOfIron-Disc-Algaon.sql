-- Source : Trouvé sur internet, Adapté pour avoir les veritables loot en fonction des GroupMode du script. (et triomphe a la place des anciens truc) 

-- 10-Man Boss loot for Ulduar: The Antechamber of Ulduar (including Hard Modes)
-- Source: WoW Armory, WoWHead
-- Assembly of Iron
-- *NOTE: lootmode of 2 is for finishing with Molgeim or Steelbreaker, lootmode of 4 is Steelbreaker being last killed/looted
SET @Brundir := 32857;
SET @Molgeim := 32927;
SET @Steelbreaker := 32867;
SET @AssemblyReference := 1+(SELECT `entry` FROM `reference_loot_template` WHERE `entry` BETWEEN 34000 AND 34999 ORDER BY `entry` DESC LIMIT 1);
UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry`=@Brundir;
UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry`=@Molgeim;
UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry`=@Steelbreaker;
DELETE FROM `creature_loot_template` WHERE `entry`=@Brundir;
DELETE FROM `creature_loot_template` WHERE `entry`=@Molgeim;
DELETE FROM `creature_loot_template` WHERE `entry`=@Steelbreaker;
DELETE FROM `reference_loot_template` WHERE `entry`=@AssemblyReference;
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- Brundir
(@Brundir,1,100,1,0,-@AssemblyReference,2), -- 2 items from reference loot
(@Brundir,47241,100,1,0,1,1), -- Embleme Triomphe
-- Molgeim
(@Molgeim,1,100,1,0,-@AssemblyReference,2), -- 2 items from reference loot
(@Molgeim,47241,100,1,0,1,1), -- Triomphe

-- (@Molgeim,45506,100,4,0,1,1), -- Archivum Data Disc (hard mode)
(33693,45857,100,4,0,1,1), -- Disc 25HM.

-- Steelbreaker
(@Steelbreaker,1,100,1,0,-@AssemblyReference,1), -- 1 items from reference loot
(@Steelbreaker,2,100,4,0,-@AssemblyReference,1), -- 1 item from hard mode loot
(@Steelbreaker,47241,100,1,0,2,2), -- 2 Triomphe
(@Steelbreaker,45506,100,4,0,1,1); -- Archivum Data Disc (hard mode)
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@AssemblyReference,45378,0,1,1,1,1), -- Boots of the Petrified Forest
(@AssemblyReference,45333,0,1,1,1,1), -- Belt of the Iron Servant
(@AssemblyReference,45329,0,1,1,1,1), -- Circlet of True Sight
(@AssemblyReference,45418,0,1,1,1,1), -- Lady Maye's Sapphire Ring
(@AssemblyReference,45322,0,1,1,1,1), -- Cloak of the Iron Council
(@AssemblyReference,45332,0,1,1,1,1), -- Stormtip
(@AssemblyReference,45331,0,1,1,1,1), -- Rune-Etched Nightblade
(@AssemblyReference,45324,0,1,1,1,1), -- Leggings of Swift Reflexes
(@AssemblyReference,45423,0,1,1,1,1), -- Runetouch Wristwraps
(@AssemblyReference,45330,0,1,1,1,1), -- Greaves of Iron Intensity
-- hard mode
(@AssemblyReference,45455,0,4,2,1,1), -- Belt of the Crystal Tree
(@AssemblyReference,45447,0,4,2,1,1), -- Watchful Eye of Fate
(@AssemblyReference,45456,0,4,2,1,1), -- Loop of the Agile
(@AssemblyReference,45449,0,4,2,1,1), -- The Masticator
(@AssemblyReference,45448,0,4,2,1,1); -- Perilous Bite
