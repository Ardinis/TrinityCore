/* Correct fix */

DELETE FROM `spell_script_names` WHERE spell_id = 30012 OR spell_id = 37144 OR spell_id = 37146 OR spell_id = 37148 OR spell_id = 37151 OR spell_id = 37152 OR spell_id = 37153 OR spell_id = 30284;
	
INSERT INTO spell_script_names VALUES (30284, 'spell_dummy_change_facing');
INSERT INTO `spell_script_names` VALUES (30012, 'spell_dummy_movement');
INSERT INTO `spell_script_names` VALUES (37144, 'spell_dummy_movement');
INSERT INTO `spell_script_names` VALUES (37146, 'spell_dummy_movement');
INSERT INTO `spell_script_names` VALUES (37148, 'spell_dummy_movement');
INSERT INTO `spell_script_names` VALUES (37151, 'spell_dummy_movement');
INSERT INTO `spell_script_names` VALUES (37152, 'spell_dummy_movement');
INSERT INTO `spell_script_names` VALUES (37153, 'spell_dummy_movement');

DELETE FROM spell_script_names WHERE spell_id IN (37427, 37428, 37459, 37461, 37471, 37472, 37406, 37413, 37453, 37454, 37498, 37502, 37474, 37476, 39384);

INSERT INTO `spell_script_names` VALUES (37427, 'spell_hellfire_geyser');
INSERT INTO `spell_script_names` VALUES (37428, 'spell_hellfire_geyser');
INSERT INTO `spell_script_names` VALUES (37459, 'spell_spear_lance');
INSERT INTO `spell_script_names` VALUES (37461, 'spell_spear_lance');
INSERT INTO `spell_script_names` VALUES (37471, 'spell_bloodlust_heroism');
INSERT INTO `spell_script_names` VALUES (37472, 'spell_bloodlust_heroism');
INSERT INTO `spell_script_names` VALUES (37406, 'spell_vicious_strike');
INSERT INTO `spell_script_names` VALUES (37413, 'spell_vicious_strike');
INSERT INTO `spell_script_names` VALUES (37453, 'spell_vicious_strike');
INSERT INTO `spell_script_names` VALUES (37454, 'spell_vicious_strike');
INSERT INTO `spell_script_names` VALUES (37498, 'spell_howl_stomp');
INSERT INTO `spell_script_names` VALUES (37502, 'spell_howl_stomp');
INSERT INTO `spell_script_names` VALUES (37474, 'spell_cleave_sweep');
INSERT INTO `spell_script_names` VALUES (37476, 'spell_cleave_sweep');
INSERT INTO `spell_script_names` VALUES (39384, 'spell_fury_of_medivh');

/* npc_chess */
DELETE FROM creature_template WHERE entry in (17469,17211,21748,21664,21750,21683,21747,21682,21726,21160,21752,21684);
INSERT INTO `creature_template` VALUES (17211, 0, 0, 0, 0, 0, 16276, 0, 0, 0, 'Human Footman', NULL, NULL, 0, 70, 70, 1, 1690, 1690, 1, 2, 1.42857, 2, 1.42857, 1, 1, 252, 357, 0, 304, 7.5, 2000, 0, 1, 33587264, 8, 0, 0, 0, 0, 0, 215, 320, 44, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30284, 37146, 37406, 37414, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 7.15717, 1, 1, 0, 0, 0, 0, 0, 0, 0, 151, 1, 107, 0, 2, 'chess_npc', 12340);
INSERT INTO `creature_template` VALUES (17469, 0, 0, 0, 0, 0, 16264, 0, 0, 0, 'Orc Grunt', NULL, NULL, 0, 70, 70, 1, 1689, 1689, 1, 2, 1.42857, 2, 1.42857, 1, 1, 252, 357, 0, 304, 7.5, 2000, 0, 1, 33587264, 8, 0, 0, 0, 0, 0, 215, 320, 44, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30284, 37146, 37413, 37416, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 7.15717, 1, 1, 0, 0, 0, 0, 0, 0, 0, 151, 1, 295, 0, 2, 'chess_npc', 12340);
INSERT INTO `creature_template` VALUES (21160, 0, 0, 0, 0, 0, 5564, 0, 0, 0, 'Conjured Water Elemental', NULL, NULL, 0, 70, 70, 1, 1690, 1690, 1, 2, 1.42857, 2, 1.42857, 1, 1, 252, 357, 0, 304, 7.5, 2000, 0, 1, 33587264, 8, 0, 0, 0, 0, 0, 215, 320, 44, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30284, 37151, 37427, 37432, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 11.4515, 1, 1, 0, 0, 0, 0, 0, 0, 0, 151, 1, 0, 0, 2, 'chess_npc', 12340);
INSERT INTO `creature_template` VALUES (21664, 0, 0, 0, 0, 0, 19783, 0, 0, 0, 'Human Charger', NULL, NULL, 0, 70, 70, 1, 1690, 1690, 1, 2, 1.42857, 2, 1.42857, 1, 1, 252, 357, 0, 304, 7.5, 2000, 0, 1, 33587264, 8, 0, 0, 0, 0, 0, 215, 320, 44, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30284, 37144, 37453, 37498, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 9.30432, 1, 1, 0, 0, 0, 0, 0, 0, 0, 151, 1, 0, 0, 2, 'chess_npc', 12340);
INSERT INTO `creature_template` VALUES (21682, 0, 0, 0, 0, 0, 16278, 0, 0, 0, 'Human Cleric', NULL, NULL, 0, 70, 70, 1, 1690, 1690, 1, 2, 1.42857, 2, 1.42857, 1, 1, 252, 357, 0, 304, 7.5, 2000, 0, 1, 33587264, 8, 0, 0, 0, 0, 0, 215, 320, 44, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30284, 37152, 37455, 37459, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 8.58861, 1, 1, 0, 0, 0, 0, 0, 0, 0, 151, 1, 71, 0, 2, 'chess_npc', 12340);
INSERT INTO `creature_template` VALUES (21683, 0, 0, 0, 0, 0, 16280, 0, 0, 0, 'Human Conjurer', NULL, NULL, 0, 70, 70, 1, 1690, 1690, 1, 2, 1.42857, 2, 1.42857, 1, 1, 252, 357, 0, 304, 7.5, 2000, 0, 1, 33587264, 8, 0, 0, 0, 0, 0, 215, 320, 44, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30284, 37148, 37462, 39842, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 11.4515, 1, 1, 0, 0, 0, 0, 0, 0, 0, 151, 1, 97, 0, 2, 'chess_npc', 12340);
INSERT INTO `creature_template` VALUES (21684, 0, 0, 0, 0, 0, 16293, 0, 0, 0, 'King Llane', NULL, NULL, 0, 70, 70, 1, 1690, 1690, 1, 2, 1.42857, 2, 1.42857, 1, 1, 252, 357, 0, 304, 7.5, 2000, 0, 1, 33587264, 8, 0, 0, 0, 0, 0, 215, 320, 44, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30284, 37146, 37471, 37474, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 21.4715, 1, 1, 0, 0, 0, 0, 0, 0, 0, 151, 1, 305, 0, 2, 'chess_npc', 12340);
INSERT INTO `creature_template` VALUES (21726, 0, 0, 0, 0, 0, 16269, 0, 0, 0, 'Summoned Daemon', NULL, NULL, 0, 70, 70, 1, 1689, 1689, 1, 2, 1.42857, 2, 1.42857, 1, 1, 252, 357, 0, 304, 7.5, 2000, 0, 1, 33587264, 8, 0, 0, 0, 0, 0, 215, 320, 44, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30284, 37151, 37434, 37428, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 11.4515, 1, 1, 0, 0, 0, 0, 0, 0, 0, 151, 1, 295, 0, 2, 'chess_npc', 12340);
INSERT INTO `creature_template` VALUES (21747, 0, 0, 0, 0, 0, 16267, 0, 0, 0, 'Orc Necrolyte', NULL, NULL, 0, 70, 70, 1, 1689, 1689, 1, 2, 1.42857, 2, 1.42857, 1, 1, 252, 357, 0, 304, 7.5, 2000, 0, 1, 33587264, 8, 0, 0, 0, 0, 0, 215, 320, 44, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30284, 37152, 37456, 37461, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 8.58861, 1, 1, 0, 0, 0, 0, 0, 0, 0, 151, 1, 310, 0, 2, 'chess_npc', 12340);
INSERT INTO `creature_template` VALUES (21748, 0, 0, 0, 0, 0, 2352, 0, 0, 0, 'Orc Wolf', NULL, NULL, 0, 70, 70, 1, 1689, 1689, 1, 2, 1.42857, 2, 1.42857, 1, 1, 252, 357, 0, 304, 7.5, 2000, 0, 1, 33587264, 8, 0, 0, 0, 0, 0, 215, 320, 44, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30284, 37144, 37454, 37502, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 9.30432, 1, 1, 0, 0, 0, 0, 0, 0, 0, 151, 1, 295, 0, 2, 'chess_npc', 12340);
INSERT INTO `creature_template` VALUES (21750, 0, 0, 0, 0, 0, 16263, 0, 0, 0, 'Orc Warlock', NULL, NULL, 0, 70, 70, 1, 1689, 1689, 1, 2, 1.42857, 2, 1.42857, 1, 1, 252, 357, 0, 304, 7.5, 2000, 0, 1, 33587264, 8, 0, 0, 0, 0, 0, 215, 320, 44, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30284, 37148, 37463, 37469, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 11.4515, 1, 1, 0, 0, 0, 0, 0, 0, 0, 151, 1, 321, 0, 2, 'chess_npc', 12340);
INSERT INTO `creature_template` VALUES (21752, 0, 0, 0, 0, 0, 16270, 0, 0, 0, 'Warchief Blackhand', NULL, NULL, 0, 70, 70, 1, 1689, 1689, 1, 2, 1.42857, 2, 1.42857, 1, 1, 252, 357, 0, 304, 7.5, 2000, 0, 1, 33587264, 8, 0, 0, 0, 0, 0, 215, 320, 44, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30284, 37152, 37472, 37476, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 21.4715, 1, 1, 0, 0, 0, 0, 0, 0, 0, 151, 1, 2180, 0, 2, 'chess_npc', 12340);

/* 22925 est le pnj a script pour la pluie de feu*/

/* suppression des DND */
UPDATE creature_template SET flags_extra = 128 WHERE entry in (17305, 17208, 17317, 21921, 17459);

/*DELETE FROM conditions WHERE ConditionValue2 = 22519;
	INSERT INTO `conditions` VALUES (13, 1, 37144, 0, 0, 31, 0, 3, 22519, 0, 0, 0, '', NULL),
	(13, 1, 37146, 0, 0, 31, 0, 3, 22519, 0, 0, 0, '', NULL),
	(13, 1, 37148, 0, 0, 31, 0, 3, 22519, 0, 0, 0, '', NULL),
	(13, 1, 37151, 0, 0, 31, 0, 3, 22519, 0, 0, 0, '', NULL),
	(13, 1, 37152, 0, 0, 31, 0, 3, 22519, 0, 0, 0, '', NULL),
	(13, 1, 37153, 0, 0, 31, 0, 3, 22519, 0, 0, 0, '', NULL),
	(13, 1, 30284, 0, 0, 31, 0, 3, 22519, 0, 0, 0, '', NULL);*/

/* trigger + medivh */
DELETE FROM creature_template WHERE entry in (16816,22519,22520);
INSERT INTO `creature_template` VALUES (16816, 0, 0, 0, 0, 0, 18720, 0, 0, 0, 'Echo of Medivh', NULL, NULL, 0, 70, 70, 1, 35, 35, 1, 1, 0.99206, 1, 0.99206, 1, 3, 252, 357, 0, 304, 35, 2000, 0, 1, 768, 8, 0, 0, 0, 0, 0, 215, 320, 44, 6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 0.7, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2087, 617299803, 1, 'npc_echo_of_medivh', 12340);
INSERT INTO `creature_template` VALUES (22519, 0, 0, 0, 0, 0, 1126, 0, 0, 0, 'Chess Piece: Karazhan Invisible Stalker', NULL, NULL, 0, 1, 1, 0, 35, 35, 0, 1, 1.14286, 1, 1.14286, 1, 0, 2, 2, 0, 24, 1, 2000, 0, 1, 33554432, 2048, 0, 0, 0, 0, 0, 1, 1, 100, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 128, 'chess_move_trigger', 12340);
INSERT INTO `creature_template` VALUES (22520, 0, 0, 0, 0, 0, 1126, 11686, 0, 0, 'Chess Piece: Status Bar', NULL, NULL, 0, 1, 1, 0, 35, 35, 0, 1, 1.14286, 1, 1.14286, 0.5, 0, 2, 2, 0, 24, 1, 2000, 0, 1, 33554432, 8, 0, 0, 0, 0, 0, 1, 1, 100, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 2, 'npc_chess_status', 12340);

/* replacement de medivh */
DELETE FROM creature WHERE id = 16816; 
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`) VALUES ('', 16816, 532, 1, 0, 0, -11098.3, -1854.01, 221.07, 5.61086, 7200, 0, 0, 50000, 0, 0);
  
/* remove all non used triggers */

DELETE FROM creature WHERE id in (22519, 17305, 17208, 17317, 17316, 22523, 22524, 21921);

/* FIX rain of fire */

DELETE FROM creature_template WHERE entry = 22925;
INSERT INTO `creature_template` VALUES (22925, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Rain of Fire Bunny (Alliance)', '', NULL, 0, 1, 1, 0, 35, 35, 0, 1, 1.14286, 1, 1.14286, 1, 0, 2, 2, 0, 24, 1, 2000, 0, 1, 0, 8, 0, 0, 0, 0, 0, 1, 1, 0, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 0.7, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 2, 'npc_chess_rain_of_fire', 12340);
