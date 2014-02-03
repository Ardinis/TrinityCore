-- kalecgos
-- kalec human
UPDATE creature_template SET faction_A=290, faction_H=290 WHERE entry=24891;

REPLACE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES('44869','46648','1','Spectral Blast visual');

DELETE FROM `spell_script_names` WHERE spell_id=45032;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(45032, 'curse_of_boundless_agony');

-- brutallus
-- replace madrigosa
UPDATE creature SET id = 25160 WHERE id = 24895;

-- Kil'jaeden
-- Armageddon Target
UPDATE creature_template SET faction_A=14, faction_H=14 WHERE entry=25735;
-- Kil'jaeden
UPDATE creature_template SET rangedattackpower=70, mechanic_immune_mask=651116543  WHERE entry=25315;
-- entry 25319 - Kalecgos
-- entry 25588 - Hand of the Deceiver
DELETE FROM creature WHERE id IN (25319, 25588);
INSERT INTO creature (id, map, spawnMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType) VALUES
(25319, 580, 1, 0, 0, 1701.7, 635.515, 72.2884, 4.65461, 25, 0, 0, 1, 0, 0);
-- Power of the Blue Flight
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel` = 70, `unit_flags` = 33554432, spell1 = 45848, spell2 = 45862, spell3 = 45860, spell4 = 45856, ScriptName='mob_powerOfBlueFlight' WHERE entry = 25653;
-- anveena
UPDATE creature_template SET InhabitType = 4 WHERE entry=26046;
-- go_orb_of_the_blue_flight
DELETE FROM gameobject WHERE id IN (188114,188115,188116,187869); -- 188415;
INSERT INTO gameobject (id, map, spawnMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES
(188114, 580, 1, 1653.12, 635.41, 28.0932, 0.0977725, 0, 0, 0.0488668, 0.998805, 25, 0, 1),
(188115, 580, 1, 1704.14, 583.591, 28.1696, 1.59003, 0, 0, 0.713874, 0.700274, 25, 0, 1),
(188116, 580, 1, 1745.68, 621.823, 28.0505, 2.93777, 0, 0, 0.994812, 0.101733, 25, 0, 1),
(187869, 580, 1, 1694.48, 674.29, 28.0502, 4.86985, 0, 0, 0.649302, -0.760531, 25, 0, 1);
UPDATE `gameobject_template` SET ScriptName = 'go_orb_of_the_blue_flight' /*`type` = 1*/ WHERE `entry` IN (188114,188115,188116,187869);

DELETE FROM `spell_script_names` WHERE spell_id IN (45909,46589,45839,45785/*,45833*/,45856,45860);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(45909, 'spell_kiljaeden_armageddon'), -- Armageddon
(46589, 'spell_kiljaeden_shadow_spike'),
(45839, 'spell_kiljaeden_vengeance_of_blue_flight'),
(45856, 'spell_kiljaeden_haste_revit'),
(45860, 'spell_kiljaeden_haste_revit'),
(45785, 'spell_kiljaeden_sinister_reflection');
-- anveena says
UPDATE script_texts SET `type` = 0 WHERE entry IN (-1580083,-1580085,-1580087,-1580089);

REPLACE INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`,`ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `Comment`) VALUES
('13','1','45680','0','0','31','4','0','0','Schattenblitz'),
('13','3','45885','0','0','31','4','0','0','Schattenstachel'),
('13','1','45657','0','0','31','4','0','0','Dunkelheit der tausend Seelen');

DELETE FROM `spell_script_names` WHERE spell_id IN (45770,45779,45442,45664,45642,45885,45737,45657,45915,45680,46190,47076,47071,47074,45897,38921,47077,47079,16496,48098,47072,58844);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(45770, 'spell_kj_80_damage3effAll'), -- SPELL_SHADOW_BOLT_VOLLEY
(45779, 'spell_kj_80_damage3effAll'), -- Teufelsfeuerspalt
(45442, 'spell_kj_80_damage5eff0'), -- Seelenschinden
(45664, 'spell_kj_80_damage5effAll'), -- Blitzschlag der Legion
(45642, 'spell_kj_80_damage3eff0'), -- Feuerblüte
(45885, 'spell_kj_80_damage4eff0'), -- Schattenstachel
(45737, 'spell_kj_80_damage3eff0'), -- Feuerpfeil
(45657, 'spell_kj_80_damage3eff0'), -- Dunkelheit der tausend Seelen
(45915, 'spell_kj_80_damage3eff0'), -- Armageddon
(45680, 'spell_kj_80_damage3eff0'), -- Schattenblitz
(46190, 'spell_kj_80_damage3eff0'), -- Fluch der Pein
(47076, 'spell_kj_80_damage3eff0'), -- Schattenblitz
(47071, 'spell_kj_80_damage3eff0'), -- Erdschock
(47074, 'spell_kj_80_damage3eff0'), -- Feuerball
(45897, 'spell_kj_80_damage3effAll'), -- Blutsturz
(38921, 'spell_kj_80_damage3eff0'), -- Heiliger Schock
(47077, 'spell_kj_80_damage3eff0'), -- Heilige Pein
(47079, 'spell_kj_80_damage3eff0'), -- Erneuerung
(16496, 'spell_kj_80_damage3eff0'), -- Schießen
(48098, 'spell_kj_80_damage3eff0'), -- Mehrfachschuss
(47072, 'spell_kj_80_damage3effAll'), -- Mondfeuer
(58844, 'spell_kj_80_damage3eff0'); -- Blutseuche
