-- Modifier par Gabii - Dev Paragon.  
-- Patch trouvé sur internet.

-- ---------------------------------------------------
-- Redon all drops from Ulduar by Misimouse & Burnham
-- ---------------------------------------------------
-- Boses done
-- Flame Leviathan
-- Razorscale
-- Ignis the Furnace Master
-- XT-002 Deconstructor
-- Kologarn
-- Steelbreaker
-- Auriaya
-- General Vezax
-- Yogg-Saron

-- ---------------
-- Flame Leviathan
-- ---------------

-- http://www.wowhead.com/npc=33113#drops:mode=normal10:01-15
-- Normal (10P)
-- Fix rates and drops adding new groups and patters correction about some 25P drops including on 10P
DELETE FROM `creature_loot_template` WHERE (`entry`=33113);
INSERT INTO `creature_loot_template` VALUES 
(33113, 34057, 1.3, 1, 0, 1, 2),
(33113, 47241, 100, 1, 0, 1, 3),
(33113, 45135, 12.5, 1, 1, 1, 1),
(33113, 45282, 12.5, 1, 1, 1, 1),
(33113, 45283, 12.5, 1, 1, 1, 1),
(33113, 45284, 12.5, 1, 1, 1, 1),
(33113, 45288, 12.5, 1, 1, 1, 1),
(33113, 45289, 12.5, 1, 1, 1, 1),
(33113, 45295, 12.5, 1, 1, 1, 1),
(33113, 45297, 12.5, 1, 1, 1, 1),
(33113, 45285, 12.5, 1, 2, 1, 1),
(33113, 45286, 12.5, 1, 2, 1, 1),
(33113, 45287, 12.5, 1, 2, 1, 1),
(33113, 45291, 12.5, 1, 2, 1, 1),
(33113, 45292, 12.5, 1, 2, 1, 1),
(33113, 45293, 12.5, 1, 2, 1, 1),
(33113, 45296, 12.5, 1, 2, 1, 1),
(33113, 45300, 12.5, 1, 2, 1, 1),
(33113, 45088, 2.1, 1, 3, 1, 1),
(33113, 45089, 2.1, 1, 3, 1, 1),
(33113, 45090, 2.1, 1, 3, 1, 1),
(33113, 45091, 2.1, 1, 3, 1, 1),
(33113, 45092, 2.1, 1, 3, 1, 1),
(33113, 45093, 2.1, 1, 3, 1, 1),
(33113, 45094, 2.1, 1, 3, 1, 1),
(33113, 45095, 2.1, 1, 3, 1, 1),
(33113, 45096, 2.1, 1, 3, 1, 1),
(33113, 45097, 2.1, 1, 3, 1, 1),
(33113, 45098, 2.1, 1, 3, 1, 1),
(33113, 45099, 2.1, 1, 3, 1, 1),
(33113, 45100, 2.1, 1, 3, 1, 1),
(33113, 45101, 2.1, 1, 3, 1, 1),
(33113, 45102, 2.1, 1, 3, 1, 1),
(33113, 45103, 2.1, 1, 3, 1, 1),
(33113, 45104, 2.1, 1, 3, 1, 1),
(33113, 45105, 2.1, 1, 3, 1, 1),
(33113, 35623, 16.3, 1, 4, 2, 6),
(33113, 35624, 16.3, 1, 4, 4, 10),
(33113, 35627, 16.3, 1, 4, 2, 10),
(33113, 36860, 16.3, 1, 4, 2, 6),
(33113, 37663, 16.3, 1, 4, 1, 1),
(33113, 45087, 16.3, 1, 4, 1, 3),
(33113, 36913, 16.3, 1, 5, 16, 20),
(33113, 36916, 16.3, 1, 5, 16, 20),
(33113, 39681, 16.3, 1, 5, 8, 10),
(33113, 39682, 16.3, 1, 5, 5, 5),
(33113, 39683, 16.3, 1, 5, 2, 3),
(33113, 39690, 16.3, 1, 5, 16, 20);

-- Flame Leviathan
-- http://www.wowhead.com/npc=33113#drops:mode=normal25:01-15
-- Normal (25P) 
-- Fix drops rates and including missing dops with groups and rates
DELETE FROM `creature_loot_template` WHERE (`entry`=34003);
INSERT INTO `creature_loot_template` VALUES 
(34003, 45038, 7.8, 1, 0, 1, 3),
(34003, 45089, 1.3, 1, 0, -45089, 1),
(34003, 47241, 100, 1, 0, 1, 3),
(34003, 45113, 16.666, 1, 1, 1, 1),
(34003, 45114, 16.666, 1, 1, 1, 1),
(34003, 45116, 16.666, 1, 1, 1, 1),
(34003, 45118, 16.666, 1, 1, 1, 1),
(34003, 45119, 16.666, 1, 1, 1, 1),
(34003, 45132, 16.666, 1, 1, 1, 1),
(34003, 45108, 16.666, 1, 2, 1, 1),
(34003, 45109, 16.666, 1, 2, 1, 1),
(34003, 45112, 16.666, 1, 2, 1, 1),
(34003, 45115, 16.666, 1, 2, 1, 1),
(34003, 45117, 16.666, 1, 2, 1, 1),
(34003, 45135, 16.666, 1, 2, 1, 1),
(34003, 45086, 14.285, 1, 3, 1, 1),
(34003, 45106, 14.285, 1, 3, 1, 1),
(34003, 45107, 14.285, 1, 3, 1, 1),
(34003, 45110, 14.285, 1, 3, 1, 1),
(34003, 45111, 14.285, 1, 3, 1, 1),
(34003, 45133, 14.285, 1, 3, 1, 1),
(34003, 45136, 14.285, 1, 3, 1, 1),
(34003, 46027, 5.5, 1, 4, 1, 1),
(34003, 46348, 5.5, 1, 4, 1, 1),
(34003, 35623, 10, 1, 5, 1, 6),
(34003, 35624, 10, 1, 5, 4, 10),
(34003, 35627, 10, 1, 5, 2, 10),
(34003, 37663, 10, 1, 5, 1, 1),
(34003, 45087, 51, 1, 5, 1, 3),
(34003, 36916, 6.7, 1, 6, 16, 20),
(34003, 39682, 22.8, 1, 6, 5, 5),
(34003, 39683, 14.5, 1, 6, 2, 3);

-- ------------------------------------------------------------------------------------
-- ----------
-- Razorscale
-- ----------

-- http://www.wowhead.com/npc=33186#drops:mode=normal10:01-15
-- Normal (10P)
-- Fix rates
DELETE FROM `creature_loot_template` WHERE (`entry`=33186);
INSERT INTO `creature_loot_template` VALUES 
(33186, 47241, 100, 1, 0, 1, 1),
(33186, 45303, 20, 1, 1, 1, 1),
(33186, 45306, 20, 1, 1, 1, 1),
(33186, 45305, 20, 1, 1, 1, 1),
(33186, 45308, 20, 1, 1, 1, 1),
(33186, 45298, 20, 1, 1, 1, 1),
(33186, 45301, 20, 1, 2, 1, 1),
(33186, 45299, 20, 1, 2, 1, 1),
(33186, 45307, 20, 1, 2, 1, 1),
(33186, 45304, 20, 1, 2, 1, 1),
(33186, 45302, 20, 1, 2, 1, 1);

-- Razorscale
-- http://www.wowhead.com/npc=33186#drops:mode=normal25:01-15
-- Normal (25P)
-- Fix drops and rates also removing patters from loot list cos its not correct
DELETE FROM `creature_loot_template` WHERE (`entry`=33724);
INSERT INTO `creature_loot_template` VALUES 
(33724, 45038, 10, 1, 0, 1, 3),
(33724, 47241, 100, 1, 0, 1, 1),
(33724, 45138, 20, 1, 1, 1, 1),
(33724, 45143, 20, 1, 1, 1, 1),
(33724, 45146, 20, 1, 1, 1, 1),
(33724, 45149, 20, 1, 1, 1, 1),
(33724, 45150, 20, 1, 1, 1, 1),
(33724, 45140, 20, 1, 2, 1, 1),
(33724, 45144, 20, 1, 2, 1, 1),
(33724, 45148, 20, 1, 2, 1, 1),
(33724, 45151, 20, 1, 2, 1, 1),
(33724, 45510, 20, 1, 2, 1, 1),
(33724, 45137, 20, 1, 3, 1, 1),
(33724, 45139, 20, 1, 3, 1, 1),
(33724, 45141, 20, 1, 3, 1, 1),
(33724, 45142, 20, 1, 3, 1, 1),
(33724, 45147, 20, 1, 3, 1, 1),
(33724, 45087, 33, 1, 4, 1, 1);

-- --------------------------------------------------------------------------------------------
-- ------------------------
-- Ignis the Furnace Master
-- ------------------------

-- http://www.wowhead.com/npc=33118#drops:mode=normal10:01-15
-- Normal (10P)
-- Fix drops and rates also removing some drops from 25P including on 10P 
DELETE FROM `creature_loot_template` WHERE (`entry`=33118);
INSERT INTO `creature_loot_template` VALUES 
(33118, 47241, 100, 1, 0, 1, 1),
(33118, 45310, 20, 1, 1, 1, 1),
(33118, 45311, 20, 1, 1, 1, 1),
(33118, 45312, 20, 1, 1, 1, 1),
(33118, 45317, 20, 1, 1, 1, 1),
(33118, 45321, 20, 1, 1, 1, 1),
(33118, 45309, 20, 1, 2, 1, 1),
(33118, 45313, 20, 1, 2, 1, 1),
(33118, 45314, 20, 1, 2, 1, 1),
(33118, 45316, 20, 1, 2, 1, 1),
(33118, 45318, 20, 1, 2, 1, 1);

-- Ignis the Furnace Master
-- http://www.wowhead.com/npc=33118#drops:mode=normal25:01-15 
-- Normal (25P)
-- Redone drops and rates redone ref for this drops also including some miss drops
DELETE FROM `creature_loot_template` WHERE (`entry`=33190);
INSERT INTO `creature_loot_template` VALUES 
(33190, 45038, 10, 1, 0, 1, 1),
(33190, 45087, 33, 1, 0, 1, 1),
(33190, 45089, 1.3, 1, 0, -45089, 1),
(33190, 47241, 100, 1, 0, 1, 1),
(33190, 45157, 20, 1, 1, 1, 1),
(33190, 45166, 20, 1, 1, 1, 1),
(33190, 45168, 20, 1, 1, 1, 1),
(33190, 45169, 20, 1, 1, 1, 1),
(33190, 45185, 20, 1, 1, 1, 1),
(33190, 45158, 20, 1, 2, 1, 1),
(33190, 45161, 20, 1, 2, 1, 1),
(33190, 45164, 20, 1, 2, 1, 1),
(33190, 45186, 20, 1, 2, 1, 1),
(33190, 45187, 20, 1, 2, 1, 1),
(33190, 45162, 20, 1, 3, 1, 1),
(33190, 45165, 20, 1, 3, 1, 1),
(33190, 45167, 20, 1, 3, 1, 1),
(33190, 45170, 20, 1, 3, 1, 1),
(33190, 45171, 20, 1, 3, 1, 1),
(33190, 46027, 2, 1, 4, 1, 1),
(33190, 46348, 2, 1, 4, 1, 1);

-- ---------------------------------------------------------------------------
-- --------------------
-- XT-002 Deconstructor
-- --------------------

-- http://www.wowhead.com/npc=33293#drops:mode=normal10:01-15
-- Normal (10P)
-- Fix drops rates also remove lots of drops for 25P including on 10P adding some miss drops and trasth drops 
DELETE FROM `creature_loot_template` WHERE (`entry`=33293);
INSERT INTO `creature_loot_template` VALUES 
(33293, 47241, 100, 1, 0, 1, 1),
(33293, 45675, 20, 1, 1, 1, 1),
(33293, 45685, 20, 1, 1, 1, 1),
(33293, 45686, 20, 1, 1, 1, 1),
(33293, 45687, 20, 1, 1, 1, 1),
(33293, 45694, 20, 1, 1, 1, 1),
(33293, 45676, 20, 1, 2, 1, 1),
(33293, 45677, 20, 1, 2, 1, 1),
(33293, 45679, 20, 1, 2, 1, 1),
(33293, 45680, 20, 1, 2, 1, 1),
(33293, 45682, 20, 1, 2, 1, 1),
(33293, 45445, 16.666, 1, 3, 1, 1),
(33293, 45867, 16.666, 1, 3, 1, 1),
(33293, 45868, 16.666, 1, 3, 1, 1),
(33293, 45869, 16.666, 1, 3, 1, 1),
(33293, 45870, 16.666, 1, 3, 1, 1),
(33293, 45871, 16.666, 1, 3, 1, 1),
(33293, 36860, 1.3, 1, 4, 2, 5),
(33293, 35627, 1.3, 1, 4, 2, 9),
(33293, 39681, 1.3, 1, 4, 8, 10),
(33293, 39682, 1.3, 1, 4, 5, 5);

-- XT-002 Deconstructor
-- http://www.wowhead.com/npc=33293#drops:mode=normal25:01-15
-- Normal (25P)
-- Fix rates and drops including lots of missing items remove some drops from 10P including on 25P 
DELETE FROM `creature_loot_template` WHERE (`entry`=33885);
INSERT INTO `creature_loot_template` VALUES 
(33885, 45087, 10, 1, 0, 1, 1),
(33885, 45089, 1.3, 1, 0, -45089, 1),
(33885, 47241, 100, 1, 0, 1, 1),
(33885, 45247, 14.285, 1, 1, 1, 1),
(33885, 45252, 14.285, 1, 1, 1, 1),
(33885, 45254, 14.285, 1, 1, 1, 1),
(33885, 45255, 14.285, 1, 1, 1, 1),
(33885, 45260, 14.285, 1, 1, 1, 1),
(33885, 45442, 14.285, 1, 1, 1, 1),
(33885, 45446, 14.285, 1, 1, 1, 1),
(33885, 45248, 14.285, 1, 2, 1, 1),
(33885, 45251, 14.285, 1, 2, 1, 1),
(33885, 45253, 14.285, 1, 2, 1, 1),
(33885, 45258, 14.285, 1, 2, 1, 1),
(33885, 45259, 14.285, 1, 2, 1, 1),
(33885, 45443, 14.285, 1, 2, 1, 1),
(33885, 45445, 14.285, 1, 2, 1, 1),
(33885, 45246, 16.666, 1, 3, 1, 1),
(33885, 45249, 16.666, 1, 3, 1, 1),
(33885, 45250, 16.666, 1, 3, 1, 1),
(33885, 45256, 16.666, 1, 3, 1, 1),
(33885, 45257, 16.666, 1, 3, 1, 1),
(33885, 45444, 16.666, 1, 3, 1, 1),
(33885, 46027, 1.3, 1, 4, 1, 1),
(33885, 46348, 1.3, 1, 4, 1, 1);

-- ---------------------------------------------------------------------------
-- ------------
-- Steelbreaker
-- ------------
-- http://www.wowhead.com/npc=32867#drops:mode=normal10
-- Normal (10P)
-- Fix drops and rates adding some miss drops
DELETE FROM `creature_loot_template` WHERE (`entry`=32867);
INSERT INTO `creature_loot_template` VALUES 
(32867, 45506, 100, 1, 0, 1, 1),
(32867, 47241, 100, 1, 0, 1, 1),
(32867, 45330, 20, 1, 1, 1, 1),
(32867, 45418, 20, 1, 1, 1, 1),
(32867, 45324, 20, 1, 1, 1, 1),
(32867, 45423, 20, 1, 1, 1, 1),
(32867, 45332, 20, 1, 1, 1, 1),
(32867, 45333, 20, 1, 2, 1, 1),
(32867, 45378, 20, 1, 2, 1, 1),
(32867, 45329, 20, 1, 2, 1, 1),
(32867, 45322, 20, 1, 2, 1, 1),
(32867, 45331, 20, 1, 2, 1, 1),
(32867, 45455, 20, 1, 3, 1, 1),
(32867, 45456, 20, 1, 3, 1, 1),
(32867, 45448, 20, 1, 3, 1, 1),
(32867, 45449, 20, 1, 3, 1, 1),
(32867, 45447, 20, 1, 3, 1, 1);

-- Steelbreaker
-- http://www.wowhead.com/npc=32867#drops:mode=normal25:01-15
-- Normal (25P) 
-- Fix drops and rates including formulas on drop
DELETE FROM `creature_loot_template` WHERE (`entry`=33693);
INSERT INTO `creature_loot_template` VALUES 
(33693, 45089, 1.3, 1, 0, -45089, 1),
(33693, 45857, 100, 1, 0, 1, 1),
(33693, 47241, 100, 1, 0, 1, 1),
(33693, 45038, 10, 1, 0, 1, 1),
(33693, 45087, 33, 1, 0, 1, 3),
(33693, 45193, 20, 1, 1, 1, 1),
(33693, 45227, 20, 1, 1, 1, 1),
(33693, 45240, 20, 1, 1, 1, 1),
(33693, 45232, 20, 1, 1, 1, 1),
(33693, 45225, 20, 1, 1, 1, 1),
(33693, 45226, 20, 1, 2, 1, 1),
(33693, 45238, 20, 1, 2, 1, 1),
(33693, 45237, 20, 1, 2, 1, 1),
(33693, 45235, 20, 1, 2, 1, 1),
(33693, 45239, 20, 1, 2, 1, 1),
(33693, 45224, 20, 1, 3, 1, 1),
(33693, 45228, 20, 1, 3, 1, 1),
(33693, 45234, 20, 1, 3, 1, 1),
(33693, 45233, 20, 1, 3, 1, 1),
(33693, 45236, 20, 1, 3, 1, 1),
(33693, 45241, 16.666, 1, 4, 1, 1),
(33693, 45242, 16.666, 1, 4, 1, 1),
(33693, 45607, 16.666, 1, 4, 1, 1),
(33693, 45244, 16.666, 1, 4, 1, 1),
(33693, 45243, 16.666, 1, 4, 1, 1),
(33693, 45245, 16.666, 1, 4, 1, 1),
(33693, 46027, 1.3, 1, 5, 1, 1),
(33693, 46348, 1.3, 1, 5, 1, 1);

-- ---------------------------------------------------------------------------------
-- --------
-- Auriaya
-- --------
-- http://www.wowhead.com/npc=33515#drops:mode=normal10:01-15
-- Normal (10P)
-- Fix drops and rates deleting some drops form 25P including on 10P
DELETE FROM `creature_loot_template` WHERE (`entry`=33515);
INSERT INTO `creature_loot_template` VALUES 
(33515, 47241, 100, 1, 0, 1, 1),
(33515, 45708, 20, 1, 1, 1, 1),
(33515, 45712, 20, 1, 1, 1, 1),
(33515, 45713, 20, 1, 1, 1, 1),
(33515, 45864, 20, 1, 1, 1, 1),
(33515, 45865, 20, 1, 1, 1, 1),
(33515, 45707, 20, 1, 2, 1, 1),
(33515, 45709, 20, 1, 2, 1, 1),
(33515, 45711, 20, 1, 2, 1, 1),
(33515, 45832, 20, 1, 2, 1, 1),
(33515, 45866, 20, 1, 2, 1, 1);

-- Auriaya
-- http://www.wowhead.com/npc=33515#drops:mode=normal25:01-15
-- Normal (25P)
-- Fix drops and rates miss some items includind on SQL
DELETE FROM `creature_loot_template` WHERE (`entry`=34175);
INSERT INTO `creature_loot_template` VALUES 
(34175, 47241, 100, 1, 0, 1, 1),
(34175, 45038, 10, 1, 0, 1, 1),
(34175, 45089, 1.3, 1, 0, -45089, 1),
(34175, 45087, 33, 1, 0, 1, 1),
(34175, 45440, 20, 1, 1, 1, 1),
(34175, 45434, 20, 1, 1, 1, 1),
(34175, 45436, 20, 1, 1, 1, 1),
(34175, 45320, 20, 1, 1, 1, 1),
(34175, 45439, 20, 1, 1, 1, 1),
(34175, 45319, 20, 1, 2, 1, 1),
(34175, 45325, 20, 1, 2, 1, 1),
(34175, 45326, 20, 1, 2, 1, 1),
(34175, 45438, 20, 1, 2, 1, 1),
(34175, 45441, 20, 1, 2, 1, 1),
(34175, 45435, 20, 1, 3, 1, 1),
(34175, 45437, 20, 1, 3, 1, 1),
(34175, 45327, 20, 1, 3, 1, 1),
(34175, 45315, 20, 1, 3, 1, 1),
(34175, 45334, 20, 1, 3, 1, 1);

-- ---------------------------------------------------------------------------------
-- --------
-- General Vezax
-- --------
-- http://www.wowhead.com/npc=33271#drops:mode=normal10:01-16
-- Normal (10P)
-- Fix drops and rates deleting some drops form 25P including on 10P
DELETE FROM `creature_loot_template` WHERE (`entry`=33271);
INSERT INTO `creature_loot_template` VALUES 
(33271, 47241, 100, 1, 0, 1, 1),
(33271, 46035, 12.5, 1, 1, 1, 1),
(33271, 46009, 12.5, 1, 1, 1, 1),
(33271, 46008, 12.5, 1, 1, 1, 1),
(33271, 46010, 12.5, 1, 1, 1, 1),
(33271, 46032, 12.5, 1, 1, 1, 1),
(33271, 45997, 12.5, 1, 1, 1, 1),
(33271, 45996, 12.5, 1, 1, 1, 1),
(33271, 46034, 12.5, 1, 1, 1, 1),
(33271, 46015, 14.285, 1, 2, 1, 1),
(33271, 46014, 14.285, 1, 2, 1, 1),
(33271, 46011, 14.285, 1, 2, 1, 1),
(33271, 46033, 14.285, 1, 2, 1, 1),
(33271, 46013, 14.285, 1, 2, 1, 1),
(33271, 46012, 14.285, 1, 2, 1, 1),
(33271, 46036, 14.285, 1, 2, 1, 1);

-- General Vezax
-- http://www.wowhead.com/npc=33271#drops:mode=normal25:01-16
-- Normal (25P)
-- Fix drops and rates miss some items includind on SQL
DELETE FROM `creature_loot_template` WHERE (`entry`=33449);
INSERT INTO `creature_loot_template` VALUES 
(33449, 47241, 100, 1, 0, 1, 1), -- Emblem of Triumph
(33449, 45038, 10, 1, 0, 1, 1), -- Fragment of Val'anyr
(33449, 45087, 33, 1, 0, 1, 1), -- Runed Orb
(33449, 45505, 16.666, 1, 1, 1, 1),
(33449, 45513, 16.666, 1, 1, 1, 1),
(33449, 45501, 16.666, 1, 1, 1, 1),
(33449, 45504, 16.666, 1, 1, 1, 1),
(33449, 45518, 16.666, 1, 1, 1, 1),
(33449, 45512, 16.666, 1, 1, 1, 1),
(33449, 45520, 16.666, 1, 2, 1, 1),
(33449, 45502, 16.666, 1, 2, 1, 1),
(33449, 45509, 16.666, 1, 2, 1, 1),
(33449, 45145, 16.666, 1, 2, 1, 1),
(33449, 45498, 16.666, 1, 2, 1, 1),
(33449, 45514, 16.666, 1, 2, 1, 1),
(33449, 45503, 14.285, 1, 3, 1, 1),
(33449, 45517, 14.285, 1, 3, 1, 1),
(33449, 45515, 14.285, 1, 3, 1, 1),
(33449, 45511, 14.285, 1, 3, 1, 1),
(33449, 45507, 14.285, 1, 3, 1, 1),
(33449, 45519, 14.285, 1, 3, 1, 1),
(33449, 45516, 14.285, 1, 3, 1, 1),
(33449, 45089, 1.3, 1, 0, -45089, 1);

-- ---------------------------------------------------------------------------------
-- ----------
-- Yogg-Saron
-- ----------

-- http://www.wowhead.com/npc=33288#drops:mode=normal10
-- Normal (10P)
-- Miss lots of drops (like 17 itms no on list)
DELETE FROM `creature_loot_template` WHERE (`entry`=33288);
INSERT INTO `creature_loot_template` VALUES 
(33288, 45087, 25, 1, 0, 1, 3), -- Runed Orb
(33288, 47241, 100, 1, 0, 1, 2), -- Emblem of Triumph
(33288, 46018, 12.5, 1, 1, 1, 1),
(33288, 46028, 12.5, 1, 1, 1, 1),
(33288, 46021, 12.5, 1, 1, 1, 1),
(33288, 46031, 12.5, 1, 1, 1, 1),
(33288, 46016, 12.5, 1, 1, 1, 1),
(33288, 46025, 12.5, 1, 1, 1, 1),
(33288, 46030, 12.5, 1, 1, 1, 1),
(33288, 46024, 12.5, 1, 1, 1, 1),
(33288, 46019, 12.5, 1, 2, 1, 1),
(33288, 46022, 12.5, 1, 2, 1, 1),
(33288, 46097, 12.5, 1, 2, 1, 1),
(33288, 46096, 12.5, 1, 2, 1, 1),
(33288, 46068, 12.5, 1, 2, 1, 1),
(33288, 46067, 12.5, 1, 2, 1, 1),
(33288, 46312, 12.5, 1, 2, 1, 1),
(33288, 46095, 12.5, 1, 2, 1, 1),
(33288, 45104, 53.2, 1, 0, -45481, 1), -- Armor TIER
(33288, 45102, 1.4, 1, 0, -45089, 1); -- Recipies

-- Yogg-Saron
-- http://www.wowhead.com/npc=33288#drops:mode=normal25
-- Normal (25P)
-- Miss lots of drops (like 17 itms no on list)
DELETE FROM `creature_loot_template` WHERE (`entry`=33955);
INSERT INTO `creature_loot_template` VALUES 
(33955, 45087, 25, 1, 0, 1, 3), -- Runed Orb
(33955, 47241, 100, 1, 0, 2, 2), -- Emblem of Triumph
(33955, 45897, 1.8, 1, 0, 1, 1), -- Reforged Hammer of Ancient Kings
(33955, 45532, 12.5, 1, 1, 1, 1),
(33955, 45529, 12.5, 1, 1, 1, 1),
(33955, 45522, 12.5, 1, 1, 1, 1),
(33955, 45523, 12.5, 1, 1, 1, 1),
(33955, 45531, 12.5, 1, 1, 1, 1),
(33955, 45521, 12.5, 1, 1, 1, 1),
(33955, 45525, 12.5, 1, 1, 1, 1),
(33955, 45530, 12.5, 1, 1, 1, 1),
(33955, 45524, 12.5, 1, 2, 1, 1),
(33955, 45527, 12.5, 1, 2, 1, 1),
(33955, 45693, 12.5, 1, 2, 1, 1),
(33955, 45534, 12.5, 1, 2, 1, 1),
(33955, 45537, 12.5, 1, 2, 1, 1),
(33955, 45533, 12.5, 1, 2, 1, 1),
(33955, 45536, 12.5, 1, 2, 1, 1),
(33955, 45535, 12.5, 1, 2, 1, 1),
(33955, 45104, 53.2, 1, 0, -33955, 1), -- Armor TIER
(33955, 45102, 1.4, 1, 0, -45089, 1); -- Recipies

-- ----------------------------------------------------------------------------------
-- References for the need drops
-- All bosses from Ulduar got the same reference items only a few hace to references
-- ----------------------------------------------------------------------------------

-- Redone ref 
DELETE FROM `reference_loot_template` WHERE `entry`='45089';
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('45089','45100','0','1','1','1','1'),
('45089','45094','0','1','1','1','1'),
('45089','45096','0','1','1','1','1'),
('45089','45095','0','1','1','1','1'),
('45089','45101','0','1','1','1','1'),
('45089','45104','0','1','1','1','1'),
('45089','45098','0','1','1','1','1'),
('45089','45099','0','1','1','1','1'),
('45089','45097','0','1','1','1','1'),
('45089','45102','0','1','1','1','1'),
('45089','45105','0','1','1','1','1'),
('45089','45103','0','1','1','1','1'),
('45089','45089','0','1','1','1','1'),
('45089','45088','0','1','1','1','1'),
('45089','45092','0','1','1','1','1'),
('45089','45090','0','1','1','1','1'),
('45089','45093','0','1','1','1','1'),
('45089','45091','0','1','1','1','1');

-- Redone ref for TIER
DELETE FROM `reference_loot_template` WHERE `entry`='45481';
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('45481','45644','0','1','1','1','1'),
('45481','45645','0','1','1','1','1'),
('45481','45646','0','1','1','1','1');

-- Redone ref for TIER
DELETE FROM `reference_loot_template` WHERE `entry`='33955';
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('33955','45658','0','1','1','1','1'),
('33955','45657','0','1','1','1','1'),
('33955','45656','0','1','1','1','1');

-- ---------------------------------------------------------------------------
-- Drops on gameobject
-- Only one chest is working and I do the drops, rest of caches is not working
-- ----------------------------------------------------------------------------
-- --------
-- Kologarn
-- --------

-- http://www.wowhead.com/npc=32930#drops:mode=normal10:01-15
-- Normal (10P)
-- Fix rates and drops removing some drops from 25P including on 10P also including some miss drop
DELETE FROM `gameobject_loot_template` WHERE (`entry`=195046);
INSERT INTO `gameobject_loot_template` VALUES 
(195046, 34057, 1.3, 1, 0, 1, 2),
(195046, 47241, 100, 1, 0, 1, 1),
(195046, 45695, 20, 1, 1, 1, 1),
(195046, 45696, 20, 1, 1, 1, 1),
(195046, 45700, 20, 1, 1, 1, 1),
(195046, 45701, 20, 1, 1, 1, 1),
(195046, 45704, 20, 1, 1, 1, 1),
(195046, 45697, 20, 1, 2, 1, 1),
(195046, 45698, 20, 1, 2, 1, 1),
(195046, 45699, 20, 1, 2, 1, 1),
(195046, 45702, 20, 1, 2, 1, 1),
(195046, 45703, 20, 1, 2, 1, 1);

-- Kologarn
-- http://www.wowhead.com/npc=32930#drops:mode=normal25:01-15
-- Normal (25P)
-- Fix drops and rates also including some miss drops
DELETE FROM `gameobject_loot_template` WHERE (`entry`=195047);
INSERT INTO `gameobject_loot_template` VALUES 
(195047, 47241, 100, 1, 0, 1, 1),
(195047, 45038, 10, 1, 0, 1, 1),
(195047, 45089, 1.3, 1, 0, -45089, 1),
(195047, 45087, 27, 1, 0, 1, 1),
(195047, 45275, 20, 1, 1, 1, 1),
(195047, 45268, 20, 1, 1, 1, 1),
(195047, 45273, 20, 1, 1, 1, 1),
(195047, 45272, 20, 1, 1, 1, 1),
(195047, 45263, 20, 1, 1, 1, 1),
(195047, 45270, 20, 1, 2, 1, 1),
(195047, 45271, 20, 1, 2, 1, 1),
(195047, 45262, 20, 1, 2, 1, 1),
(195047, 45267, 20, 1, 2, 1, 1),
(195047, 45269, 20, 1, 2, 1, 1),
(195047, 45264, 20, 1, 3, 1, 1),
(195047, 45261, 20, 1, 3, 1, 1),
(195047, 45274, 20, 1, 3, 1, 1),
(195047, 45266, 20, 1, 3, 1, 1),
(195047, 45265, 20, 1, 3, 1, 1);


-- BIG THANKS TO TDB TEAM
-- 10-Man Generic loot for Ulduar (including trash mobs)
-- Source: WoWHead, YTDB (trash loot ideas)

-- Global Profession Drops

SET @ProfReference :=1+(SELECT `entry` FROM `reference_loot_template` WHERE `entry` BETWEEN 34000 AND 34999 ORDER BY `entry` DESC LIMIT 1);
DELETE FROM `reference_loot_template` WHERE `entry`=@ProfReference;

INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@ProfReference,45105,0,1,1,1,1), -- Pattern: Savior's Slippers
(@ProfReference,45104,0,1,1,1,1), -- Pattern: Cord of the White Dawn
(@ProfReference,45103,0,1,1,1,1), -- Pattern: Spellslinger's Slippers
(@ProfReference,45102,0,1,1,1,1), -- Pattern: Sash of Ancient Power
(@ProfReference,45100,0,1,1,1,1), -- Pattern: Belt of Arctic Life
(@ProfReference,45099,0,1,1,1,1), -- Pattern: Footpads of Silence
(@ProfReference,45098,0,1,1,1,1), -- Pattern: Death-warmed Belt
(@ProfReference,45101,0,1,1,1,1), -- Pattern: Boots of Wintry Endurance
(@ProfReference,45095,0,1,1,1,1), -- Pattern: Boots of Living Scale
(@ProfReference,45096,0,1,1,1,1), -- Pattern: Blue Belt of Chaos
(@ProfReference,45094,0,1,1,1,1), -- Pattern: Belt of Dragons
(@ProfReference,45097,0,1,1,1,1), -- Pattern: Lightning Grounded Boots
(@ProfReference,45091,0,1,1,1,1), -- Plans: Treads of Destiny
(@ProfReference,45088,0,1,1,1,1), -- Plans: Belt of the Titans
(@ProfReference,45092,0,1,1,1,1), -- Plans: Indestructible Plate Girdle
(@ProfReference,45093,0,1,1,1,1), -- Plans: Spiked Deathdealers
(@ProfReference,45090,0,1,1,1,1), -- Plans: Plate Girdle of Righteousness
(@ProfReference,45089,0,1,1,1,1); -- Plans: Battlelord's Plate Boots


-- Trash Loot

-- Generic

SET @TrashGenericGrey :=1+(SELECT `entry` FROM `reference_loot_template` WHERE `entry` BETWEEN 34000 AND 34999 ORDER BY `entry` DESC LIMIT 1);
SET @TrashGenericWhite :=@TrashGenericGrey+1;
SET @TrashGenericScroll :=@TrashGenericWhite+1;
SET @TrashGenericGreen :=@TrashGenericScroll+1;
SET @TrashGenericBlue :=@TrashGenericGreen+1;
SET @TrashGenericPurple :=@TrashGenericBlue+1;
SET @TrashGenericFinal :=@TrashGenericPurple+1;

DELETE FROM `reference_loot_template` WHERE `entry`=@TrashGenericGrey;
DELETE FROM `reference_loot_template` WHERE `entry`=@TrashGenericWhite;
DELETE FROM `reference_loot_template` WHERE `entry`=@TrashGenericScroll;
DELETE FROM `reference_loot_template` WHERE `entry`=@TrashGenericGreen;
DELETE FROM `reference_loot_template` WHERE `entry`=@TrashGenericBlue;
DELETE FROM `reference_loot_template` WHERE `entry`=@TrashGenericPurple;
DELETE FROM `reference_loot_template` WHERE `entry`=@TrashGenericFinal;

INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- grey items
(@TrashGenericGrey,43852,0,1,1,1,1), -- Thick Fur Clothing Scraps
(@TrashGenericGrey,39220,0,1,1,1,8), -- Geodesic Fragments
(@TrashGenericGrey,33424,0,1,1,1,1), -- Cracked Iron Staff
(@TrashGenericGrey,33403,0,1,1,1,1), -- Frigid Mail Shoulderpads
(@TrashGenericGrey,33370,0,1,1,1,1), -- Frost-Rimed Cloth Shoulderpads
(@TrashGenericGrey,33379,0,1,1,1,1), -- Frozen Armor
(@TrashGenericGrey,33365,0,1,1,1,1), -- Frost-Rimed Cloth Belt
(@TrashGenericGrey,33422,0,1,1,1,1), -- Shattered Bow
-- white items
(@TrashGenericWhite,33470,0,1,1,2,7), -- Frostweave Cloth
(@TrashGenericWhite,37701,0,1,1,1,2), -- Crystallized Earth
(@TrashGenericWhite,34054,0,1,1,1,1), -- Infinite Dust
(@TrashGenericWhite,33445,0,1,1,1,1), -- Honeymint Tea
(@TrashGenericWhite,33454,0,1,1,1,1), -- Salted Venison
-- scroll items
(@TrashGenericScroll,43463,0,1,1,1,1), -- Scroll of Agility VII
(@TrashGenericScroll,37091,0,1,1,1,1), -- Scroll of Intellect VII
(@TrashGenericScroll,37093,0,1,1,1,1), -- Scroll of Stamina VII
(@TrashGenericScroll,43465,0,1,1,1,1), -- Scroll of Strength VII
(@TrashGenericScroll,37097,0,1,1,1,1), -- Scroll of Spirit VII
(@TrashGenericScroll,43464,0,1,1,1,1), -- Scroll of Agility VIII
(@TrashGenericScroll,37092,0,1,1,1,1), -- Scroll of Intellect VIII
(@TrashGenericScroll,37094,0,1,1,1,1), -- Scroll of Stamina VIII
(@TrashGenericScroll,43466,0,1,1,1,1), -- Scroll of Strength VIII
(@TrashGenericScroll,37098,0,1,1,1,1), -- Scroll of Spirit VIII
-- green items
(@TrashGenericGreen,36043,0,1,1,1,1), -- Crystalsong Sash
(@TrashGenericGreen,36394,0,1,1,1,1), -- Revenant Bracers
(@TrashGenericGreen,36052,0,1,1,1,1), -- Vizier Slippers
(@TrashGenericGreen,36274,0,1,1,1,1), -- Ulduar Bracers
(@TrashGenericGreen,36296,0,1,1,1,1), -- Ulduar Breastplate
(@TrashGenericGreen,36270,0,1,1,1,1), -- Ulduar Gauntlets
(@TrashGenericGreen,36267,0,1,1,1,1), -- Ulduar Girdle
(@TrashGenericGreen,36268,0,1,1,1,1), -- Ulduar Greaves
(@TrashGenericGreen,36271,0,1,1,1,1), -- Ulduar Helm
(@TrashGenericGreen,36272,0,1,1,1,1), -- Ulduar Legguards
(@TrashGenericGreen,36273,0,1,1,1,1), -- Ulduar Shoulderguards
(@TrashGenericGreen,36051,0,1,1,1,1), -- Vizier Sash
(@TrashGenericGreen,36059,0,1,1,1,1), -- Coldwraith Sash
(@TrashGenericGreen,43297,0,1,1,1,1), -- Damaged Necklace
(@TrashGenericGreen,36035,0,1,1,1,1), -- Condor Belt
-- blue items
(@TrashGenericBlue,37761,0,1,1,1,1), -- Shimmerthread Girdle
(@TrashGenericBlue,37760,0,1,1,1,1), -- Cracklefire Wristguards
(@TrashGenericBlue,37781,0,1,1,1,1), -- Grips of the Warming Heart
(@TrashGenericBlue,37794,0,1,1,1,1), -- Torta's Oversized Choker
(@TrashGenericBlue,37771,0,1,1,1,1), -- Wristguards of Verdant Recovery
(@TrashGenericBlue,41777,0,1,1,1,1), -- Design: Etched Monarch Topaz
(@TrashGenericBlue,41788,0,1,1,1,1), -- Design: Beaming Earthsiege Diamond
(@TrashGenericBlue,41780,0,1,1,1,1), -- Design: Champion's Monarch Topaz
(@TrashGenericBlue,41786,0,1,1,1,1), -- Design: Destructive Skyflare Diamond
(@TrashGenericBlue,41789,0,1,1,1,1), -- Design: Inscribed Monarch Topaz
(@TrashGenericBlue,41781,0,1,1,1,1), -- Design: Misty Forest Emerald
(@TrashGenericBlue,41783,0,1,1,1,1), -- Design: Purified Twilight Opal
(@TrashGenericBlue,41778,0,1,1,1,1), -- Design: Resolute Monarch Topaz
(@TrashGenericBlue,41782,0,1,1,1,1), -- Design: Shining Forest Emerald
(@TrashGenericBlue,41784,0,1,1,1,1), -- Design: Sovereign Twilight Opal
(@TrashGenericBlue,41779,0,1,1,1,1), -- Design: Stalwart Monarch Topaz
(@TrashGenericBlue,41785,0,1,1,1,1), -- Design: Tenuous Twilight Opal
(@TrashGenericBlue,41787,0,1,1,1,1), -- Design: Thundering Skyflare Diamond
-- purple items
(@TrashGenericPurple,46340,0,1,1,1,1), -- Adamant Handguards
(@TrashGenericPurple,46351,0,1,1,1,1), -- Bloodcrush Cudgel
(@TrashGenericPurple,46346,0,1,1,1,1), -- Boots of Unsettled Prey
(@TrashGenericPurple,46347,0,1,1,1,1), -- Cloak of the Dormant Blaze
(@TrashGenericPurple,46342,0,1,1,1,1), -- Golemheart Longbow
(@TrashGenericPurple,46344,0,1,1,1,1), -- Iceshear Mantle
(@TrashGenericPurple,46350,0,1,1,1,1), -- Pillar of Fortitude
(@TrashGenericPurple,46345,0,1,1,1,1), -- Bracers of Righteous Reformation
(@TrashGenericPurple,46341,0,1,1,1,1), -- Drape of the Spellweaver
(@TrashGenericPurple,46343,0,1,1,1,1), -- Fervor of the Protectorate
(@TrashGenericPurple,45538,0,1,1,1,1), -- Titanstone Pendant
(@TrashGenericPurple,37254,0,1,1,1,1), -- Super Simian Sphere
-- final output
(@TrashGenericFinal,1,40,1,0,-@TrashGenericGrey,1), -- 1 grey loot (40%)
(@TrashGenericFinal,2,40,1,0,-@TrashGenericGrey,1), -- 1 grey loot (40%)
(@TrashGenericFinal,3,20,1,0,-@TrashGenericWhite,1), -- 1 white loot (20%)
(@TrashGenericFinal,4,7,1,0,-@TrashGenericScroll,1), -- 1 scroll loot (7%)
(@TrashGenericFinal,5,10,1,0,-@TrashGenericGreen,1), -- 1 green loot (10%)
(@TrashGenericFinal,6,3,1,0,-@TrashGenericBlue,1), -- 1 blue loot (3%)
(@TrashGenericFinal,7,1,1,0,-@TrashGenericPurple,1); -- 1 purple loot (1%)

-- Mechanical

SET @TrashMechGrey :=1+(SELECT `entry` FROM `reference_loot_template` WHERE `entry` BETWEEN 34000 AND 34999 ORDER BY `entry` DESC LIMIT 1);
SET @TrashMechWhite :=@TrashMechGrey+1;
SET @TrashMechFinal :=@TrashMechWhite+1;

DELETE FROM `reference_loot_template` WHERE `entry`=@TrashMechGrey;
DELETE FROM `reference_loot_template` WHERE `entry`=@TrashMechWhite;
DELETE FROM `reference_loot_template` WHERE `entry`=@TrashMechFinal;

INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- grey items
(@TrashMechGrey,41338,0,1,1,1,3), -- Sprung Whirlygig
(@TrashMechGrey,41337,0,1,1,1,3), -- Whizzed-Out Gizmo
-- white items
(@TrashMechWhite,39690,0,1,1,1,3), -- Volatile Blasting Trigger
(@TrashMechWhite,39681,0,1,1,2,4), -- Handful of Cobalt Bolts
(@TrashMechWhite,39683,0,1,1,1,1), -- Froststeel Tube
-- final output
(@TrashMechFinal,1,40,1,0,-@TrashMechGrey,1), -- 1 grey loot (40%)
(@TrashMechFinal,2,20,1,0,-@TrashMechGrey,1), -- 1 grey loot (20%)
(@TrashMechFinal,3,20,1,0,-@TrashMechWhite,1); -- 1 white loot (20%)


-- Apply Trash Loot

-- Mechanical

SET @MechLoot :=34234; -- needs official entry designated
UPDATE `creature_template` SET `lootid`=@MechLoot WHERE `entry` IN (34183,34193,34085,34267,33699,33722,34191,34273,34271,34269);
DELETE FROM `creature_loot_template` WHERE `entry` IN (34183,34193,34085,34267,33699,33722,34191,34273,34271,34269,@MechLoot);

INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@MechLoot,1,100,1,0,-@TrashGenericFinal,1), -- 1 selection from generic trash loot
(@MechLoot,2,100,1,0,-@TrashMechFinal,1); -- 1 selection from mechanical trash loot

-- Humanoid / Giant / Elemental 

SET @HGELoot :=33237; -- needs official entry designated
UPDATE `creature_template` SET `lootid`=@HGELoot WHERE `entry` IN (33755,33754,34198,34199,33355,33527,33818,33819,33822,33820,33824,33823,34133,34069,34197,33354,33431,33430,34190,33526,34086,33525,34196,34134,34135);
DELETE FROM `creature_loot_template` WHERE `entry` IN (33755,33754,34198,34199,33355,33527,33818,33819,33822,33820,33824,33823,34133,34069,34197,33354,33431,33430,34190,33526,34086,33525,34196,34134,34135,@HGELoot);

INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@HGELoot,1,100,1,0,-@TrashGenericFinal,1); -- 1 selection from generic trash loot

-- Dragonkin / Beast

SET @DBLoot :=34164; -- needs official entry designated
UPDATE `creature_template` SET `lootid`=@DBLoot WHERE `entry` IN (33528,34137);
DELETE FROM `creature_loot_template` WHERE `entry` IN (33528,34137,@DBLoot);

INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@DBLoot,1,100,1,0,-@TrashGenericFinal,1), -- 1 selection from generic trash loot
(@DBLoot,33568,15,1,0,1,1); -- Borean Leather (15%)


-- Alchemist Cache (drop rates estimated)

SET @AlchCache :=46110;
DELETE FROM `item_loot_template` WHERE `entry`=@AlchCache;

INSERT INTO `item_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@AlchCache,40411,90,1,1,17,19), -- Enchanted Vial
(@AlchCache,40212,85,1,2,5,10), -- Potion of Wild Magic
(@AlchCache,40211,80,1,3,5,10), -- Potion of Speed
(@AlchCache,40195,77,1,4,18,19), -- Pygmy Oil
(@AlchCache,35625,69,1,5,2,4), -- Eternal Life
(@AlchCache,36908,68,1,6,2,3), -- Frost Lotus
(@AlchCache,36906,30,1,7,17,19), -- Icethorn
(@AlchCache,36905,30,1,8,17,19), -- Lichbloom
(@AlchCache,40404,33,1,9,3,4), -- Mixture of Pure Mojo
(@AlchCache,40087,45,1,10,5,5), -- Powerful Rejuvenation Potion
(@AlchCache,40081,25,1,11,5,5), -- Potion of Nightmares
(@AlchCache,33448,23,1,12,5,5), -- Runic Mana Potion
(@AlchCache,40084,44,1,13,5,5), -- Mixture of Endless Rage
(@AlchCache,40082,20,1,14,5,5), -- Mixture of the Frost Wyrm
(@AlchCache,46378,17,1,15,6,8), -- Flask of Pure Mojo
(@AlchCache,33447,17,1,16,5,5), -- Runic Healing Potion
(@AlchCache,46377,14,1,17,10,14), -- Flask of Endless Rage
(@AlchCache,46376,14,1,18,10,14), -- Flask of the Frost Wyrm
(@AlchCache,40083,16,1,19,3,4), -- Mixture of Stoneblood
(@AlchCache,44329,10,1,20,2,3), -- Elixir of Expertise
(@AlchCache,44328,10,1,21,2,3), -- Elixir of Mighty Defense
(@AlchCache,40109,10,1,22,2,3), -- Elixir of Mighty Mageblood
(@AlchCache,40073,10,1,23,2,3), -- Elixir of Mighty Strength
(@AlchCache,46379,12,1,24,6,8), -- Flask of Stoneblood
(@AlchCache,44330,9,1,25,2,3), -- Elixir of Armor Piercing
(@AlchCache,44331,9,1,26,2,3), -- Elixir of Lightning Speed
(@AlchCache,44332,9,1,27,2,3), -- Elixir of Mighty Thoughts
(@AlchCache,39666,9,1,28,2,3), -- Elixir of Mighty Agility
(@AlchCache,40078,9,1,29,2,3), -- Elixir of Mighty Fortitude
(@AlchCache,40097,9,1,30,2,3), -- Elixir of Protection
(@AlchCache,40072,9,1,31,2,3), -- Elixir of Spirit
(@AlchCache,39970,12,1,32,17,19), -- Fire Leaf
(@AlchCache,36907,9,1,33,17,19), -- Talandra's Rose
(@AlchCache,44325,9,1,34,2,3), -- Elixir of Accuracy
(@AlchCache,44327,9,1,35,2,3), -- Elixir of Deadly Strikes
(@AlchCache,40076,14,1,36,2,3), -- Guru's Elixir
(@AlchCache,40070,8,1,37,2,3), -- Spellpower Elixir
(@AlchCache,40068,9,1,38,2,3), -- Wrath Elixir
(@AlchCache,36903,8,1,39,17,19); -- Adder's Tongue


-- 10-Man Boss loot for Ulduar: The Siege of Ulduar (including Hard Modes)
-- Source: WoW Armory, WoWHead

-- Flame Leviathan
-- *NOTE: lootmode of 2 is 3 or less used
--        lootmode of 4 is for 2 towers (exactly) used, 
--        lootmode of 8 is for 1 tower or less used, 
--        lootmode of 16 is for zero towers

SET @Flame := 33113;
SET @Reference := 1+(SELECT `entry` FROM `reference_loot_template` WHERE `entry` BETWEEN 34000 AND 34999 ORDER BY `entry` DESC LIMIT 1);
SET @H2Reference := @Reference+1;
SET @H1Reference := @H2Reference+1;

UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry`=@Flame;
DELETE FROM `creature_loot_template` WHERE `entry`=@Flame;
DELETE FROM `reference_loot_template` WHERE `entry`=@Reference;
DELETE FROM `reference_loot_template` WHERE `entry`=@H2Reference;
DELETE FROM `reference_loot_template` WHERE `entry`=@H1Reference;

INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Flame,1,100,1,0,-@Reference,2), -- 2 selections from gear loot
(@Flame,2,100,2,0,-@Reference,1), -- 1 selection from hard mode (<=3 towers used)
(@Flame,3,100,4,0,-@H2Reference,1), -- 1 selection from hard mode (exactly 2 towers used)
(@Flame,4,100,8,0,-@H1Reference,1), -- 1 selection from hard mode (<=1 tower used)
(@Flame,5,100,16,0,-@Reference,1), -- 1 selection from hard mode (no towers used)
(@Flame,47241,100,1,0,1,1); -- Emblem of Triomphe

INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- gear loot
(@Reference,45283,0,1,1,1,1), -- Flamewatch Armguards
(@Reference,45288,0,1,1,1,1), -- Firestrider Chestguard
(@Reference,45286,0,1,1,1,1), -- Pyrite Infuser
(@Reference,45291,0,1,1,1,1), -- Combustion Bracers
(@Reference,45282,0,1,1,1,1), -- Ironsoul
(@Reference,45289,0,1,1,1,1), -- Lifespark Visage
(@Reference,45284,0,1,1,1,1), -- Kinetic Ripper
(@Reference,45285,0,1,1,1,1), -- Might of the Leviathan
(@Reference,45287,0,1,1,1,1), -- Firesoul
(@Reference,45292,0,1,1,1,1), -- Energy Siphon
-- 3 towers or less used
(@Reference,47241,100,2,2,1,1), -- Emblem of Triomphe
-- 2 towers (exactly) used
(@H2Reference,1,50,4,0,-@ProfReference,1), -- 1 item from profession drop (50%)
(@H2Reference,45087,50,4,1,1,1), -- Runed Orb (50%)
-- 1 tower or less used
(@H1Reference,1,100,8,0,-@ProfReference,1), -- 1 item from profession drop
(@H1Reference,47241,100,8,1,1,1), -- Emblem of Triomphe
(@H1Reference,45087,100,8,2,1,1), -- Runed Orb 
-- no towers used
(@Reference,45296,0,16,3,1,1), -- Twirling Blades
(@Reference,45300,0,16,3,1,1), -- Mantle of Fiery Vengeance
(@Reference,45293,0,16,3,1,1), -- Handguards of Potent Cures
(@Reference,45297,0,16,3,1,1); -- Shimmering Seal


-- Ignis the Furnace Master

SET @Ignis := 33118;
SET @Reference := 1+(SELECT `entry` FROM `reference_loot_template` WHERE `entry` BETWEEN 34000 AND 34999 ORDER BY `entry` DESC LIMIT 1);

UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry`=@Ignis;
DELETE FROM `creature_loot_template` WHERE `entry`=@Ignis;
DELETE FROM `reference_loot_template` WHERE `entry`=@Reference;

INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Ignis,1,100,1,0,-@Reference,2), -- 2 selections from gear loot
(@Ignis,47241,100,1,0,1,1); -- Emblem of Triomphe

INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Reference,45321,0,1,1,1,1), -- Pauldrons of Tempered Will
(@Reference,45316,0,1,1,1,1), -- Armbraces of the Vibrant Flame
(@Reference,45310,0,1,1,1,1), -- Gauntlets of the Iron Furnace
(@Reference,45318,0,1,1,1,1), -- Drape of Fuming Anger
(@Reference,45312,0,1,1,1,1), -- Gloves of Smoldering Touch
(@Reference,45314,0,1,1,1,1), -- Igniter Rod
(@Reference,45309,0,1,1,1,1), -- Rifle of the Platinum Guard
(@Reference,45317,0,1,1,1,1), -- Shawl of the Caretaker
(@Reference,45313,0,1,1,1,1), -- Furnace Stone
(@Reference,45311,0,1,1,1,1); -- Relentless Edge


-- Razorscale

SET @Razorscale := 33186;
SET @Reference := 1+(SELECT `entry` FROM `reference_loot_template` WHERE `entry` BETWEEN 34000 AND 34999 ORDER BY `entry` DESC LIMIT 1);

UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry`=@Razorscale;
DELETE FROM `creature_loot_template` WHERE `entry`=@Razorscale;
DELETE FROM `reference_loot_template` WHERE `entry`=@Reference;

INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Razorscale,1,100,1,0,-@Reference,2), -- 2 selections from gear loot
(@Razorscale,47241,100,1,0,1,1); -- Emblem of Triomphe

INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Reference,45301,0,1,1,1,1), -- Bracers of the Smothering Inferno
(@Reference,45303,0,1,1,1,1), -- Band of Draconic Guile
(@Reference,45298,0,1,1,1,1), -- Razorscale Talon
(@Reference,45308,0,1,1,1,1), -- Eye of the Broodmother
(@Reference,45306,0,1,1,1,1), -- Binding of the Dragon Matriarch
(@Reference,45299,0,1,1,1,1), -- Dragonsteel Faceplate
(@Reference,45302,0,1,1,1,1), -- Treads of the Invader
(@Reference,45304,0,1,1,1,1), -- Stormtempered Girdle
(@Reference,45307,0,1,1,1,1), -- Ironscale Leggings
(@Reference,45305,0,1,1,1,1); -- Breastplate of the Afterlife


-- XT-002 Deconstructor

SET @Decon := 33293;
SET @Reference := 1+(SELECT `entry` FROM `reference_loot_template` WHERE `entry` BETWEEN 34000 AND 34999 ORDER BY `entry` DESC LIMIT 1);

UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry`=@Decon;
DELETE FROM `creature_loot_template` WHERE `entry`=@Decon;
DELETE FROM `reference_loot_template` WHERE `entry`=@Reference;

INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Decon,1,100,1,0,-@Reference,2), -- 2 selections from gear loot
(@Decon,2,100,2,0,-@Reference,1), -- 1 selection from hard mode loot
(@Decon,47241,100,1,0,1,1); -- Emblem of Triomphe

INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Reference,45685,0,1,1,1,1), -- Plasma Foil
(@Reference,45687,0,1,1,1,1), -- Helm of Veiled Energies
(@Reference,45676,0,1,1,1,1), -- Chestplate of Vicious Potency
(@Reference,45680,0,1,1,1,1), -- Armbands of the Construct
(@Reference,45686,0,1,1,1,1), -- Vest of the Glowing Crescent
(@Reference,45675,0,1,1,1,1), -- Power Enhancing Loop
(@Reference,45677,0,1,1,1,1), -- Treacherous Shoulderpads
(@Reference,45682,0,1,1,1,1), -- Pulsing Spellshield
(@Reference,45679,0,1,1,1,1), -- Gloves of Taut Grip
(@Reference,45694,0,1,1,1,1), -- Conductive Cord
-- hard mode
(@Reference,45868,0,2,2,1,1), -- Aesir's Edge
(@Reference,45867,0,2,2,1,1), -- Breastplate of the Stoneshaper
(@Reference,45869,0,2,2,1,1), -- Fluxing Energy Coils
(@Reference,45870,0,2,2,1,1), -- Magnetized Projectile Emitter
(@Reference,45871,0,2,2,1,1); -- Seal of Ulduar


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
(@Brundir,47241,100,1,0,1,1), -- Emblem of Triomphe
-- Molgeim
(@Molgeim,1,100,1,0,-@AssemblyReference,2), -- 2 items from reference loot
(@Molgeim,47241,100,1,0,2,2), -- 2 Emblem of Triomphe
(@Molgeim,45506,100,2,0,1,1), -- Archivum Data Disc (hard mode)
-- Steelbreaker
(@Steelbreaker,1,100,1,0,-@AssemblyReference,2), -- 2 items from reference loot
(@Steelbreaker,2,100,4,0,-@AssemblyReference,1), -- 1 item from hard mode loot
(@Steelbreaker,47241,100,1,0,2,2), -- 2 Emblem of Triomphe
(@Steelbreaker,45506,100,2,0,1,1); -- Archivum Data Disc (hard mode)

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


-- Cache of Living Stone (chest spawned after killing Kologarn)

SET @CacheLStone := (SELECT `data1` FROM `gameobject_template` WHERE `entry`=195046);
SET @OldRef := (SELECT ABS(`mincountOrRef`) FROM `gameobject_loot_template` WHERE `entry`=27061 AND `mincountOrRef` < 0);
SET @Reference := 1+(SELECT `entry` FROM `reference_loot_template` WHERE `entry` BETWEEN 34000 AND 34999 ORDER BY `entry` DESC LIMIT 1);

DELETE FROM `gameobject_loot_template` WHERE `entry`=@CacheLStone;
DELETE FROM `reference_loot_template` WHERE `entry`=@OldRef;
DELETE FROM `reference_loot_template` WHERE `entry`=@Reference;

INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@CacheLStone,1,100,1,0,-@Reference,2), -- 2 items from reference loot
(@CacheLStone,47241,100,1,0,1,1); -- Emblem of Triomphe

INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Reference,45699,0,1,1,1,1), -- Pendant of the Piercing Glare
(@Reference,45695,0,1,1,1,1), -- Spire of Withering Dreams
(@Reference,45703,0,1,1,1,1), -- Spark of Hope
(@Reference,45701,0,1,1,1,1), -- Greaves of the Earthbinder
(@Reference,45700,0,1,1,1,1), -- Stoneguard
(@Reference,45698,0,1,1,1,1), -- Sabatons of the Iron Watcher
(@Reference,45696,0,1,1,1,1), -- Mark of the Unyielding
(@Reference,45702,0,1,1,1,1), -- Emerald Signet Ring
(@Reference,45697,0,1,1,1,1), -- Shoulderguards of the Solemn Watch
(@Reference,45704,0,1,1,1,1); -- Shawl of the Shattered Giant

-- Auriaya

SET @Auriaya := 33515;
SET @Reference := 1+(SELECT `entry` FROM `reference_loot_template` WHERE `entry` BETWEEN 34000 AND 34999 ORDER BY `entry` DESC LIMIT 1);

UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry`=@Auriaya;
DELETE FROM `creature_loot_template` WHERE `entry`=@Auriaya;
DELETE FROM `reference_loot_template` WHERE `entry`=@Reference;

INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Auriaya,1,100,1,0,-@Reference,2), -- 2 items from reference loot
(@Auriaya,47241,100,1,0,1,1); -- Emblem of Triomphe

INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Reference,45708,0,1,1,1,1), -- Archaedas' Lost Legplates
(@Reference,45866,0,1,1,1,1), -- Elemental Focus Stone
(@Reference,45712,0,1,1,1,1), -- Chestplate of Titanic Fury
(@Reference,45713,0,1,1,1,1), -- Nurturing Touch
(@Reference,45711,0,1,1,1,1), -- Ironaya's Discarded Mantle
(@Reference,45709,0,1,1,1,1), -- Nimble Climber's Belt
(@Reference,45864,0,1,1,1,1), -- Cover of the Keepers
(@Reference,45865,0,1,1,1,1), -- Raiments of the Corrupted
(@Reference,45707,0,1,1,1,1), -- Shieldwall of the Breaker
(@Reference,45832,0,1,1,1,1); -- Mantle of the Preserver


-- 10-Man Boss loot for Ulduar: The Keepers of Ulduar (including Hard Modes)
-- Source: WoW Armory, WoWHead

-- WDB data update

-- update WDB data for Freya's Gift
SET @GiftID :=194324;
UPDATE `gameobject_template` SET `data1`=27078 WHERE `entry`=@GiftID;

-- 2nd update WDB data for Freya's Gift
UPDATE `gameobject_template` SET `data1`=27079 WHERE `entry`=194325;

-- update WDB data for Cache of Innovation
SET @CacheInnovationID :=194789;
UPDATE `gameobject_template` SET `data1`=27085 WHERE `entry`=@CacheInnovationID;


-- Freya's Gift (chest spawned after defeating Freya)
-- *NOTE: hard mode generic (lootmode=2) is for any number of elders (lootmodes 4, 8, 16 are for 1, 2, and 3 elders respectively)

SET @Gift := (SELECT `data1` FROM `gameobject_template` WHERE `entry`=@GiftID);
SET @Reference := 1+(SELECT `entry` FROM `reference_loot_template` WHERE `entry` BETWEEN 34000 AND 34999 ORDER BY `entry` DESC LIMIT 1);
SET @H1Reference := @Reference+1;
SET @H2Reference := @H1Reference+1;
SET @H3Reference := @H2Reference+1;

DELETE FROM `gameobject_loot_template` WHERE `entry`=@Gift;
DELETE FROM `reference_loot_template` WHERE `entry`=@Reference;
DELETE FROM `reference_loot_template` WHERE `entry`=@H1Reference;
DELETE FROM `reference_loot_template` WHERE `entry`=@H2Reference;
DELETE FROM `reference_loot_template` WHERE `entry`=@H3Reference;

INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Gift,1,100,1,0,-@Reference,1), -- 1 item from reference loot
(@Gift,2,100,1,0,-@ProfReference,1), -- 1 item from profession reference loot
(@Gift,3,100,2,0,-@Reference,1), -- hard mode (generic)
(@Gift,4,100,4,0,-@H1Reference,1), -- hard mode (one elder left)
(@Gift,5,100,8,0,-@H2Reference,1), -- hard mode (two elders left)
(@Gift,6,100,16,0,-@H3Reference,1), -- hard mode (three elders left)
(@Gift,47241,100,1,0,1,1), -- Emblem of Triomphe
(@Gift,45087,100,1,0,1,1), -- Runed Orb
(@Gift,46110,100,1,0,1,1), -- Alchemist's Cache
-- 1 item from token loot
(@Gift,45645,0,1,1,1,1), -- Gloves of the Wayward Protector
(@Gift,45646,0,1,1,1,1), -- Gloves of the Wayward Vanquisher
(@Gift,45644,0,1,1,1,1), -- Gloves of the Wayward Conqueror
-- hard mode (generic)
(@Gift,45788,-100,2,0,1,1); -- Freya's Sigil

INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Reference,45294,0,1,1,1,1), -- Petrified Ivy Sprig
(@Reference,45936,0,1,1,1,1), -- Legplates of Flourishing Resolve
(@Reference,45935,0,1,1,1,1), -- Ironbark Faceguard
(@Reference,45941,0,1,1,1,1), -- Chestguard of the Lasher
(@Reference,45934,0,1,1,1,1), -- Unraveling Reach
(@Reference,45940,0,1,1,1,1), -- Tunic of the Limber Stalker
-- hard mode (generic)
(@Reference,45946,0,2,2,1,1), -- Fire Orchid Signet
(@Reference,45943,0,2,2,1,1), -- Gloves of Whispering Winds
(@Reference,45945,0,2,2,1,1), -- Seed of Budding Carnage
(@Reference,45947,0,2,2,1,1), -- Serilas, Blood Blade of Invar One-Arm
-- hard mode (one elder left)
(@H1Reference,47241,100,4,2,1,1), -- Emblem of Triomphe
-- hard mode (two elders left)
(@H2Reference,47241,100,8,3,1,1), -- Emblem of Triomphe
-- hard mode (three elders left)
(@H3Reference,47241,100,16,4,1,1); -- Emblem of Triomphe


-- Cache of Winter (chest spawned after defeating Hodir)

SET @CacheWinter := (SELECT `data1` FROM `gameobject_template` WHERE `entry`=194307);
DELETE FROM `gameobject_loot_template` WHERE `entry`=@CacheWinter;

INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@CacheWinter,47241,100,1,0,1,1), -- Emblem of Triomphe
-- 1 item from token loot
(@CacheWinter,45651,0,1,1,1,1), -- Leggings of the Wayward Protector
(@CacheWinter,45652,0,1,1,1,1), -- Leggings of the Wayward Vanquisher
(@CacheWinter,45650,0,1,1,1,1), -- Leggings of the Wayward Conqueror
-- 1 item from gear loot
(@CacheWinter,45872,0,1,2,1,1), -- Avalanche
(@CacheWinter,45464,0,1,2,1,1), -- Cowl of Icy Breaths
(@CacheWinter,45874,0,1,2,1,1), -- Signet of Winter
(@CacheWinter,45458,0,1,2,1,1), -- Stormedge
(@CacheWinter,45873,0,1,2,1,1); -- Winter's Frigid Embrace


-- Rare Cache of Winter (chest spawned after defeating Hodir on hard mode)

SET @RCacheWinter := (SELECT `data1` FROM `gameobject_template` WHERE `entry`=194200);
DELETE FROM `gameobject_loot_template` WHERE `entry`=@RCacheWinter;

INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@RCacheWinter,47241,100,2,0,1,1), -- Emblem of Triomphe
(@RCacheWinter,45786,-100,2,0,1,1), -- Hodir's Sigil
-- 1 item from gear loot
(@RCacheWinter,45886,0,2,1,1,1), -- Icecore Staff
(@RCacheWinter,45888,0,2,1,1,1), -- Bitter Cold Armguards
(@RCacheWinter,45876,0,2,1,1,1), -- Shiver
(@RCacheWinter,45877,0,2,1,1,1), -- The Boreal Guard
(@RCacheWinter,45887,0,2,1,1,1); -- Ice Layered Barrier


-- Cache of Innovation (chest spawned after defeating Mimiron)

SET @CacheInnovation := (SELECT `data1` FROM `gameobject_template` WHERE `entry`=@CacheInnovationID);
SET @Reference := 1+(SELECT `entry` FROM `reference_loot_template` WHERE `entry` BETWEEN 34000 AND 34999 ORDER BY `entry` DESC LIMIT 1);

DELETE FROM `gameobject_loot_template` WHERE `entry`=@CacheInnovation;
DELETE FROM `reference_loot_template` WHERE `entry`=@Reference;

INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@CacheInnovation,1,100,1,0,-@Reference,1), -- 1 item from reference loot
(@CacheInnovation,2,100,2,0,-@Reference,1), -- 1 item from hard mode loot
(@CacheInnovation,47241,100,1,0,1,1), -- Emblem of Triomphe
-- 1 item from token loot
(@CacheInnovation,45648,0,1,1,1,1), -- Helm of the Wayward Protector
(@CacheInnovation,45649,0,1,1,1,1), -- Helm of the Wayward Vanquisher
(@CacheInnovation,45647,0,1,1,1,1), -- Helm of the Wayward Conqueror
-- hard mode
(@CacheInnovation,45787,-100,2,0,1,1); -- Mimiron's Sigil

INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Reference,45973,0,1,1,1,1), -- Stylish Power Cape
(@Reference,45974,0,1,1,1,1), -- Shoulderguards of Assimilation
(@Reference,45975,0,1,1,1,1), -- Cable of the Metrognome
(@Reference,45976,0,1,1,1,1), -- Static Charge Handwraps
(@Reference,45972,0,1,1,1,1), -- Pulse Baton
-- hard mode
(@Reference,45988,0,2,2,1,1), -- Greaves of the Iron Army
(@Reference,45993,0,2,2,1,1), -- Mimiron's Flight Goggles
(@Reference,45982,0,2,2,1,1), -- Fused Alloy Legplates
(@Reference,45989,0,2,2,1,1), -- Tempered Mercury Greaves
(@Reference,45990,0,2,2,1,1); -- Fusion Blade


-- Assault Bot (when fighting Mimiron)

SET @AssaultBot  := 34057;
UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry`=@AssaultBot;
DELETE FROM `creature_loot_template` WHERE `entry` = @AssaultBot;

INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@AssaultBot,46029,100,1,0,1,1); -- Magnetic Core


-- Cache of Storms (chest spawned after defeating Thorim)

SET @CacheStorms := (SELECT `data1` FROM `gameobject_template` WHERE `entry`=194312);
SET @Reference := 1+(SELECT `entry` FROM `reference_loot_template` WHERE `entry` BETWEEN 34000 AND 34999 ORDER BY `entry` DESC LIMIT 1);

DELETE FROM `gameobject_loot_template` WHERE `entry`=@CacheStorms;
DELETE FROM `reference_loot_template` WHERE `entry`=@Reference;

INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@CacheStorms,1,100,1,0,-@Reference,1), -- 1 item from reference loot
(@CacheStorms,2,100,2,0,-@Reference,1), -- 1 item from hard mode loot
(@CacheStorms,47241,100,1,0,1,1), -- Emblem of Triomphe
-- 1 item from token loot
(@CacheStorms,45660,0,1,1,1,1), -- Spaulders of the Wayward Protector
(@CacheStorms,45661,0,1,1,1,1), -- Spaulders of the Wayward Vanquisher
(@CacheStorms,45659,0,1,1,1,1), -- Spaulders of the Wayward Conqueror
-- hard mode
(@CacheStorms,45784,-100,2,0,1,1); -- Thorim's Sigil

INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Reference,45895,0,1,1,1,1), -- Belt of the Blood Pit
(@Reference,45894,0,1,1,1,1), -- Leggings of Unstable Discharge
(@Reference,45927,0,1,1,1,1), -- Handwraps of Resonance
(@Reference,45893,0,1,1,1,1), -- Guise of the Midgard Serpent
(@Reference,45892,0,1,1,1,1), -- Legacy of Thunder
-- hard mode
(@Reference,45930,0,2,2,1,1), -- Combatant's Bootblade
(@Reference,45931,0,2,2,1,1), -- Mjolnir Runestone
(@Reference,45933,0,2,2,1,1), -- Pendant of the Shallow Grave
(@Reference,45929,0,2,2,1,1), -- Sif's Remembrance
(@Reference,45928,0,2,2,1,1); -- Gauntlets of the Thunder God


-- 10-Man Boss loot for Ulduar: The Descent into Madness (including Hard Modes)
-- Source: WoW Armory, WoWHead

-- General Vezax

SET @Vezax := 33271;
SET @Reference := 1+(SELECT `entry` FROM `reference_loot_template` WHERE `entry` BETWEEN 34000 AND 34999 ORDER BY `entry` DESC LIMIT 1);

UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry`=@Vezax;
DELETE FROM `creature_loot_template` WHERE `entry`=@Vezax;
DELETE FROM `reference_loot_template` WHERE `entry`=@Reference;

INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Vezax,1,100,1,0,-@Reference,2), -- 2 items from reference loot
(@Vezax,2,100,2,0,-@Reference,1), -- 1 item from hard mode loot
(@Vezax,47241,100,1,0,1,1); -- Emblem of Triomphe

INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Reference,46011,0,1,1,1,1), -- Shadowbite
(@Reference,46015,0,1,1,1,1), -- Pendant of Endless Despair
(@Reference,46013,0,1,1,1,1), -- Underworld Mantle
(@Reference,46012,0,1,1,1,1), -- Vestments of the Piercing Light
(@Reference,46008,0,1,1,1,1), -- Choker of the Abyss
(@Reference,46010,0,1,1,1,1), -- Darkstone Ring
(@Reference,46009,0,1,1,1,1), -- Bindings of the Depths
(@Reference,46014,0,1,1,1,1), -- Saronite Animus Cloak
(@Reference,45997,0,1,1,1,1), -- Gauntlets of the Wretched
(@Reference,45996,0,1,1,1,1), -- Hoperender
-- hard mode
(@Reference,46035,0,2,2,1,1), -- Aesuga, Hand of the Ardent Champion
(@Reference,46032,0,2,2,1,1), -- Drape of the Faceless General
(@Reference,46034,0,2,2,1,1), -- Leggings of Profound Darkness
(@Reference,46033,0,2,2,1,1), -- Tortured Earth
(@Reference,46036,0,2,2,1,1); -- Void Sabre

-- Yogg-Saron

SET @YoggSaron :=33288;
SET @Reference :=1+(SELECT `entry` FROM `reference_loot_template` WHERE `entry` BETWEEN 34000 AND 34999 ORDER BY `entry` DESC LIMIT 1);
SET @HReference :=@Reference+1;

UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry`=@YoggSaron;
DELETE FROM `creature_loot_template` WHERE `entry`=@YoggSaron;
DELETE FROM `reference_loot_template` WHERE `entry`=@Reference;
DELETE FROM `reference_loot_template` WHERE `entry`=@HReference;

INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@YoggSaron,1,100,1,0,-@Reference,2), -- 2 items from reference loot
(@YoggSaron,2,100,2,0,-@HReference,1), -- 1 item hard mode loot (generic bonus)
(@YoggSaron,3,100,4,0,-@Reference,1), -- 1 item hard mode loot (1-3 keepers)
(@YoggSaron,4,100,8,0,-@Reference,1), -- 1 item hard mode loot (zero keepers)
(@YoggSaron,47241,100,1,0,1,2), -- Emblem of Triomphe
(@YoggSaron,45635,0,1,1,1,1), -- Chestguard of the Wayward Conqueror
(@YoggSaron,45636,0,1,1,1,1), -- Chestguard of the Wayward Protector
(@YoggSaron,45637,0,1,1,1,1); -- Chestguard of the Wayward Vanquisher

INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Reference,46018,0,1,1,1,1), -- Deliverance
(@Reference,46022,0,1,1,1,1), -- Pendant of a Thousand Maws
(@Reference,46019,0,1,1,1,1), -- Leggings of the Insatiable
(@Reference,46016,0,1,1,1,1), -- Abaddon
(@Reference,46031,0,1,1,1,1), -- Touch of Madness
(@Reference,46024,0,1,1,1,1), -- Kingsbane
(@Reference,46030,0,1,1,1,1), -- Treads of the Dragon Council
(@Reference,46025,0,1,1,1,1), -- Devotion
(@Reference,46021,0,1,1,1,1), -- Royal Seal of King Llane
(@Reference,46028,0,1,1,1,1), -- Faceguard of the Eyeless Horror
-- hard mode bonus (generic)
(@HReference,47241,0,2,2,1,1), -- Emblem of Triomphe
-- hard mode (use 1-3 keepers)
(@Reference,46068,0,4,2,1,1), -- Amice of Inconceivable Horror
(@Reference,46097,0,4,2,1,1), -- Caress of Insanity
(@Reference,46067,0,4,2,1,1), -- Hammer of Crushing Whispers
(@Reference,46096,0,4,2,1,1), -- Signet of Soft Lament
(@Reference,46095,0,4,2,1,1), -- Soul-Devouring Cinch
-- hard mode (use zero keepers)
(@Reference,46312,0,8,3,1,1); -- Vanquished Clutches of Yogg-Saron


-- 10-Man (Normal) Boss loot for Ulduar: Celestial Planetarium
-- Source: WoW Armory

-- Gift of the Observer (chest spawned after defeating Algalon the Observer)

SET @Gift :=(SELECT `data1` FROM `gameobject_template` WHERE `entry`=194821);
SET @Reference :=1+(SELECT `entry` FROM `reference_loot_template` WHERE `entry` BETWEEN 34000 AND 34999 ORDER BY `entry` DESC LIMIT 1);

DELETE FROM `gameobject_loot_template` WHERE `entry`=@Gift;
DELETE FROM `reference_loot_template` WHERE `entry`=@Reference;

INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Gift,1,100,1,0,-@Reference,3), -- 3 items from reference loot
(@Gift,46052,100,1,0,1,1), -- Reply-Code Alpha
(@Gift,47241,100,1,0,1,1); -- Emblem of Triomphe

INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(@Reference,46044,0,1,1,1,1), -- Observer's Mantle
(@Reference,46037,0,1,1,1,1), -- Shoulderplates of the Celestial Watch
(@Reference,46050,0,1,1,1,1), -- Starlight Treads
(@Reference,46038,0,1,1,1,1), -- Dark Matter
(@Reference,46048,0,1,1,1,1), -- Band of Lights
(@Reference,46051,0,1,1,1,1), -- Meteorite Crystal
(@Reference,46041,0,1,1,1,1), -- Starfall Girdle
(@Reference,46047,0,1,1,1,1), -- Pendant of the Somber Witness
(@Reference,46039,0,1,1,1,1), -- Breastplate of the Timeless
(@Reference,46043,0,1,1,1,1), -- Gloves of the Endless Dark
(@Reference,46040,0,1,1,1,1), -- Strength of the Heavens
(@Reference,46046,0,1,1,1,1), -- Nebula Band
(@Reference,46049,0,1,1,1,1), -- Zodiac Leggings
(@Reference,46042,0,1,1,1,1), -- Drape of the Messenger
(@Reference,46045,0,1,1,1,1); -- Pulsar Gloves


-- Ajout BLood : 
-- Drop des fragment de Valanyr sur les boss (creature).

DELETE FROM `creature_loot_template` WHERE item = 45038;

INSERT INTO `creature_loot_template` VALUES 
(33955, 45038, 100, 1, 0, 1, 1),
(34003, 45038, 7.5, 1, 0, 1, 1),
(33190, 45038, 7.5, 1, 0, 1, 1),
(33724, 45038, 7.5, 1, 0, 1, 1),
(33694, 45038, 8, 1, 0, 1, 1),
(33692, 45038, 8, 1, 0, 1, 1),
(33693, 45038, 19, 1, 0, 1, 1),
(33449, 45038, 10, 1, 0, 1, 1),
(34175, 45038, 10, 1, 0, 1, 1),
(33885, 45038, 7.5, 1, 0, 1, 1);


-- Ajout Gabii :
DELETE FROM `gameobject_loot_template` WHERE `entry` IN (27078, 27079, 27080, 27081);
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('27078','1','100','1','0','-34125','1'),
('27078','2','100','1','0','-34105','1'),
('27078','47241','100','1','0','1','1'),
('27078','45087','100','1','0','1','1'),
('27078','45644','0','1','1','1','1'),
('27078','45645','0','1','1','1','1'),
('27078','45646','0','1','1','1','1'),
('27078','46110','100','1','0','1','1'),
('27079','1','100','1','0','-34125','2'),
('27079','2','100','1','0','-34105','1'),
('27079','47','100','1','0','1','1'),
('27079','45087','100','1','0','1','1'),
('27079','45644','0','1','1','1','1'),
('27079','45645','0','1','1','1','1'),
('27079','45646','0','1','1','1','1'),
('27079','46110','100','1','0','1','1'),
('27080','1','100','1','0','-34125','2'),
('27080','2','100','1','0','-34105','1'),
('27080','47241','100','1','0','2','2'),
('27080','45087','100','1','0','1','1'),
('27080','45644','0','1','1','1','1'),
('27080','45645','0','1','1','1','1'),
('27080','45646','0','1','1','1','1'),
('27080','46110','100','1','0','1','1'),
('27081','1','100','1','0','-34125','1'),
('27081','2','100','1','0','-34105','1'),
('27081','45943','0','1','2','1','1'),
('27081','45945','0','1','2','1','1'),
('27081','45946','0','1','2','1','1'),
('27081','45294','0','1','2','1','1'),
('27081','45947','0','1','2','1','1'),
('27081','47241','100','1','0','1','1'),
('27081','45087','100','1','0','1','1'),
('27081','45644','0','1','1','1','1'),
('27081','45645','0','1','1','1','1'),
('27081','45646','0','1','1','1','1'),
('27081','45788','-100','1','0','1','1'),
('27081','46110','100','1','0','1','1');

DELETE FROM `reference_loot_template` WHERE `entry`=34125;
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('34125','45934','0','1','1','1','1'),
('34125','45935','0','1','1','1','1'),
('34125','45936','0','1','1','1','1'),
('34125','45940','0','1','1','1','1'),
('34125','45941','0','1','1','1','1');

DELETE FROM `gameobject_template` WHERE entry IN (194326, 194328, 194329, 194330, 194331);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`, `WDBVerified`) VALUES
('194326','3','8628','Freya\'s Gift','','','','0','0','2','0','0','0','0','0','0','1634','27080','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','12340'),
('194328','3','8628','Freya\'s Gift','','','','0','0','2','0','0','0','0','0','0','1634','27087','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','12340'),
('194329','3','8628','Freya\'s Gift','','','','0','0','2','0','0','0','0','0','0','1634','27088','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','12340'),
('194330','3','8628','Freya\'s Gift','','','','0','0','2','0','0','0','0','0','0','1634','27089','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','12340'),
('194331','3','8628','Freya\'s Gift','','','','0','0','2','0','0','0','0','0','0','1634','27090','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','12340');

DELETE FROM `reference_loot_template` WHERE entry = 34176;
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('34176','45479','0','1','1','1','1'),
('34176','45483','0','1','1','1','1'),
('34176','45482','0','1','1','1','1'),
('34176','45481','0','1','1','1','1'),
('34176','45480','0','1','1','1','1');

DELETE FROM `gameobject_loot_template` WHERE entry = 27087;
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('27087','1','100','1','0','-34176','2'),
('27087','2','10','1','0','-34154','1'),
('27087','47241','100','1','0','1','1'),
('27087','45038','18','1','0','1','1'),
('27087','45087','75','1','0','1','1'),
('27087','45653','0','1','1','1','1'),
('27087','45654','0','1','1','1','1'),
('27087','45655','0','1','1','1','1'),
('27087','46110','70','1','0','1','1');

DELETE FROM `gameobject_loot_template` WHERE entry = 27088;
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('27088','1','100','1','0','-34176','3'),
('27088','2','10','1','0','-34154','1'),
('27088','47241','100','1','0','1','1'),
('27088','45038','18','1','0','1','1'),
('27088','45087','75','1','0','1','1'),
('27088','45653','0','1','1','1','1'),
('27088','45654','0','1','1','1','1'),
('27088','45655','0','1','1','1','1'),
('27088','46110','70','1','0','1','1');

DELETE FROM `gameobject_loot_template` WHERE entry = 27089;
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('27089','1','100','1','0','-34176','3'),
('27089','2','10','1','0','-34154','1'),
('27089','47241','100','1','0','2','2'),
('27089','45038','18','1','0','1','1'),
('27089','45087','75','1','0','1','1'),
('27089','45653','0','1','1','1','1'),
('27089','45654','0','1','1','1','1'),
('27089','45655','0','1','1','1','1'),
('27089','46110','70','1','0','1','1'),
('27089','45814','-100','1','0','1','1');

DELETE FROM `gameobject_loot_template` WHERE entry = 27090;
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
('27090','1','100','1','0','-34176','3'),
('27090','2','10','1','0','-34154','1'),
('27090','47241','100','1','0','2','2'),
('27090','45038','18','1','0','1','1'),
('27090','45087','75','1','0','1','1'),
('27090','45485','0','1','1','1','1'),
('27090','45613','0','1','1','1','1'),
('27090','45487','0','1','1','1','1'),
('27090','45484','0','1','1','1','1'),
('27090','45486','0','1','1','1','1'),
('27090','45653','0','1','2','1','1'),
('27090','45654','0','1','2','1','1'),
('27090','45655','0','1','2','1','1'),
('27090','45488','0','1','1','1','1'),
('27090','46110','70','1','0','1','1'),
('27090','45814','-100','1','0','1','1');

-- Hodir Loot , 10 & 25 , Avec HF 
DELETE FROM gameobject WHERE id IN(194200, 194201,194307,194308) ;
INSERT INTO gameobject
   (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`)
VALUES
(194307, 603, 1, 1, 1966.43, -203.906, 432.687, -0.90757, 0, 0, 0, 1, -604800, 255, 1),
(194308, 603, 2, 1, 1966.43, -203.906, 432.687, -0.90757, 0, 0, 0, 1, -604800, 255, 1),
(194200, 603, 1, 1, 2004.65, -209.028, 432.687, 1.91458, 0, 0, 0.817635, 0.575738, 604800, 100, 1),
(194201, 603, 2, 1, 2004.65, -209.028, 432.687, 1.91458, 0, 0, 0.817635, 0.575738, 604800, 100, 1);

UPDATE `gameobject_template` SET `flags` = 16 WHERE `entry` = 194201;
UPDATE gameobject_loot_template SET lootmode = 1 WHERE entry = 26950 AND lootmode = 2;



