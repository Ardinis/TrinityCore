SET @ENTRY = 80001;
SET @GUID  = @ENTRY * 10;


DELETE FROM `creature_template` WHERE `entry` = @ENTRY;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction_A`, `faction_H`, `scale`, `unit_class`, `flags_extra`, `ScriptName`) VALUES
(@ENTRY, 7103, "Queuey", "Solo Queue", 80, 80, 35, 35, 2, 1, 2, "npc_solo_queue");


DELETE FROM `creature` WHERE `guid` BETWEEN @GUID AND @GUID+1;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@GUID+0, @ENTRY, 0, 1, 1, -9115.23,   375.719, 93.4513, 2.24187), -- Stormwind
(@GUID+1, @ENTRY, 1, 1, 1,  1343.20, -4398.104, 28.5712, 1.51420), -- Orgrimmar
(@GUID+2, @ENTRY, 571, 1, 1, 5915.431, 620.374, 646.378, 1.070589), -- Horde Bank
(@GUID+3, @ENTRY, 571, 1, 1, 5683.843, 678.724, 647.421, 5.468815), -- Ally Bank
(@GUID+4, @ENTRY, 571, 1, 1, 5795.306, 593.846, 609.157, 2.597414), -- Dala underground
(@GUID+5, @ENTRY, 0, 1, 1, -8823.3, 631.779, 94.866, 3.765572), -- Stormwind Auction House
(@GUID+6, @ENTRY, 1, 1, 1, 1630.179, -4417.128, 16.441, 5.625772); -- Orgrimmar other NPC's
