-- [Ulduar]{Flame Leviathan} -- By Elron103.
-- Scripts update/register for NPCs, areatriggers and spells.

-- Part 1: Creatures. I've renamed them, since they are no bosses, as named before.
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~33554432 WHERE `entry`=33067;
UPDATE `creature_template` SET `ScriptName`='npc_flame_leviathan_seat' WHERE `entry`=33114;
UPDATE `creature_template` SET `ScriptName`='npc_flame_leviathan_defense_turret' WHERE `entry`=33142;
UPDATE `creature_template` SET `ScriptName`='npc_flame_leviathan_defense_cannon' WHERE `entry`=33139;
UPDATE `creature_template` SET `ScriptName`='npc_flame_leviathan_overload_device' WHERE `entry`=33143;
UPDATE `creature_template` SET `ScriptName`='npc_flame_leviathan_safety_container' WHERE `entry`=33218;
UPDATE `creature_template` SET `ScriptName`='npc_liquid_pyrite' WHERE `entry`=33189;
UPDATE `creature_template` SET `ScriptName`='npc_freya_ward_of_life' WHERE `entry`=34275;
-- Part 1.1: Mimirons Inferno Bunny - it should walk around.
DELETE FROM `waypoints` WHERE `entry`=33370;
REPLACE INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(33370, 1, 266.689, -33.391, 409.99, 'Mimirons Inferno - Waypoint of dummy'),
(33370, 2, 379.158, -33.318, 409.81, 'Mimirons Inferno - Waypoint of dummy 2'),
(33370, 3, 266.611, -133.387, 409.81, 'Mimirons Inferno - Waypoint of dummy 3'),
(33370, 4, 158.411, -33.311, 409.81, 'Mimirons Inferno - Waypoint of dummy 4'),
(33370, 5, 266.699, 66.632, 409.81, 'Mimirons Inferno - Waypoint of dummy 5');

-- Part 2: Areatrigger. These are the triggers at the repair stations (194261,194262).
DELETE FROM `areatrigger_scripts` WHERE `entry` IN (5369, 5423);
REPLACE INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (5369, 'at_RX_214_repair_o_matic_station');
REPLACE INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (5423, 'at_RX_214_repair_o_matic_station');

-- Part 3: Updates for achievement criterias... to avoid DISTINCT-selection during load :s
UPDATE `achievement_criteria_data` SET `ScriptName`='achievement_unbroken_25' WHERE `criteria_id`=10045 AND `type`=11;
UPDATE `achievement_criteria_data` SET `ScriptName`='achievement_shutout_25' WHERE `criteria_id`=10055 AND `type`=11;
UPDATE `achievement_criteria_data` SET `ScriptName`='achievement_three_car_garage_chopper_25' WHERE `criteria_id`=10049 AND `type`=11;
UPDATE `achievement_criteria_data` SET `ScriptName`='achievement_three_car_garage_siege_25' WHERE `criteria_id`=10050 AND `type`=11;
UPDATE `achievement_criteria_data` SET `ScriptName`='achievement_three_car_garage_demolisher_25' WHERE `criteria_id`=10051 AND `type`=11;
UPDATE `achievement_criteria_data` SET `ScriptName`='achievement_orbital_bombardment_25' WHERE `criteria_id`=10059 AND `type`=11;
UPDATE `achievement_criteria_data` SET `ScriptName`='achievement_orbital_devastation_25' WHERE `criteria_id`=10060 AND `type`=11;
UPDATE `achievement_criteria_data` SET `ScriptName`='achievement_nuked_from_orbit_25' WHERE `criteria_id`=10061 AND `type`=11;
UPDATE `achievement_criteria_data` SET `ScriptName`='achievement_orbit_uary_25' WHERE `criteria_id`=10219 AND `type`=11;

-- Part 4: Spells
DELETE FROM `spell_script_names` WHERE `spell_id` IN (64979, 65044, 62907, 63847, 64677);
REPLACE INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(64979, 'spell_anti_air_rocket'),
(65044, 'spell_leviathan_blaze_flames_effect'),
(62907, 'spell_freyas_ward_summon'),
(63847, 'spell_leviathan_flame_vents'),
(64677, 'spell_shield_generator');
-- Part 4.1: Renamed - the resulting effect is called "Pursued", not "Pursue". Period.
UPDATE `spell_script_names` SET `ScriptName`='spell_pursued' WHERE `spell_id`=62374;

-- Part 5: Game-objects: Replaced them if position is incorrect.
DELETE FROM `gameobject` WHERE `id` IN (194261, 194262);
REPLACE INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(194261, 603, 3, 1, 130.553, -128.063, 409.804, 2.87979, 0, 0, 0, 1, 180, 255, 1),
(194261, 603, 3, 1, 138.516, 56.1078, 409.804, 2.87979, 0, 0, 0, 1, 180, 255, 1),
(194262, 603, 3, 1, 131.895, -128.264, 409.804, 0, 0, 0, 0, 1, 180, 255, 1),
(194262, 603, 3, 1, 139.857, 55.9064, 409.804, 0, 0, 0, 0, 1, 180, 255, 1);



-- BY GABI !

UPDATE `creature_template` SET `speed_walk`='1' WHERE (`entry`='33113');  -- Vitesse du boss.
UPDATE `spell_script_names` SET `ScriptName`='spell_vehicle_throw_passenger' WHERE (`spell_id`='62324') AND (`ScriptName`='spell_throw_passenger')  ;
UPDATE `creature` SET `spawntimesecs` = 604800 WHERE `id` IN (33236, 33838);  -- Temps de respawn ok .
UPDATE `gameobject` SET `spawnMask` = 3 WHERE `id` = 194262 AND `map` = 603;
DELETE FROM `creature` WHERE `id` = '34145' OR `id` = '34144';
DELETE FROM gameobject WHERE id = '194905';
INSERT INTO `gameobject`
(`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`)
VALUES
(194905, 603, 3,1, 401.308, -13.8236, 409.524, 3.14159, 0, 0, 0, 1, 180, 255, 0),
(194905, 603, 3,1,148.011, 53, 410.73, 3.1415, 0, 0, 0.999666, 0.0258449, 300, 0, 1),
(194905, 603, 3,1,148.011, 13.09, 410.73, 3.1415, 0, 0, 0.999666, 0.0258449, 300, 0, 1),
(194905, 603, 3,1,148.011, -16.9589, 410.73, 3.1415, 0, 0, 0.999998, -0.00203387, 300, 0, 1),
(194905, 603, 3,1,148.011, -56.8689, 410.73, 3.1415, 0, 0, 0.999998, -0.00203387, 300, 0, 1),
(194905, 603, 3,1,148.011, -86.031, 410.73, 3.1415, 0, 0, 0.999978, 0.00660518, 300, 0, 1),
(194905, 603, 3,1,148.011, -125.941, 410.73, 3.1415, 0, 0, 0.999978, 0.00660518, 300, 0, 1);
UPDATE `gameobject` SET `spawnMask` = 3 WHERE `id` = 194905 AND `map` = 603;
UPDATE `creature_template` SET `modelid1`='28469',`modelid2`='28469',`modelid4`='28469' WHERE (`entry`='33143')  ;
UPDATE `creature_template` SET `modelid1`='11686' WHERE (`entry`='33370');
UPDATE `creature_template` SET `modelid1`='24914' WHERE (`entry`='33114');

UPDATE creature_template SET faction_A = 16 , faction_H = 16 where entry = 33142;
UPDATE creature_template SET vehicleId= 340 where entry = 33113; -- Avant 387
UPDATE creature_template SET vehicleId= 341 where entry = 33114;
UPDATE `creature_template` SET `speed_run`='2' , `speed_walk`='2' WHERE `entry` IN ('34014', '34166');