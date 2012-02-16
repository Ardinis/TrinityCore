-- ICC weapons procs
-- (71845) Item - Icecrown 25 Normal Caster Weapon Proc
DELETE FROM `spell_proc_event` WHERE `entry` IN (71845);
INSERT INTO `spell_proc_event` VALUES (71845, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00010000, 0x00000000, 0, 2, 40);
-- (71846) Item - Icecrown 25 Normal Caster Weapon Proc
DELETE FROM `spell_proc_event` WHERE `entry` IN (71845);
INSERT INTO `spell_proc_event` VALUES (71845, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00010000, 0x00000000, 0, 2, 45);
-- (71865) Item - Icecrown 25 Normal Healer Weapon Proc
DELETE FROM `spell_proc_event` WHERE `entry` IN (71865);
INSERT INTO `spell_proc_event` VALUES (71865, 0x01, 0x0A, 0x00000000, 0x00000000, 0x00000000, 0x00044000, 0x00000018, 0, 1, 0);
-- (71868) Item - Icecrown 25 Heroic Healer Weapon Proc
DELETE FROM `spell_proc_event` WHERE `entry` IN (71868);
INSERT INTO `spell_proc_event` VALUES (71868, 0x01, 0x0A, 0x00000000, 0x00000000, 0x00000000, 0x00044000, 0x00000018, 0, 1, 0);
-- (71871) Item - Icecrown 25 Normal Tank Weapon Proc
DELETE FROM `spell_proc_event` WHERE `entry` IN (71871);
INSERT INTO `spell_proc_event` VALUES (71871, 0x01, 0x0A, 0x00000000, 0x00000000, 0x00000000, 0x00000014, 0x00000018, 0, 37, 30);
-- (71873) Item - Icecrown 25 Heroic Tank Weapon Proc
DELETE FROM `spell_proc_event` WHERE `entry` IN (71873);
INSERT INTO `spell_proc_event` VALUES (71873, 0x01, 0x00, 0x00000000, 0x00000000, 0x00000000, 0x00000014, 0x00000018, 0, 37, 35);-- Bloodworm AI
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 28017;
DELETE FROM `creature_ai_scripts` WHERE `creature_id` = 28017;
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES
(2801701, 28017, 4, 0, 100, 0, 0, 0, 0, 0, 11, 50453, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodworm - Health Leech');SET @GUID := 153100;
DELETE FROM `gameobject` WHERE `id` IN(201959, 202338, 202339, 202340);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID+0, 201959, 631, 1, 1, 4203.65, 2484.56, 364.873, 6.28004, 0, 0, 0.00157252, -1, -120, 0, 1),
(@GUID+1, 202339, 631, 2, 1, 4203.65, 2484.56, 364.873, 6.28004, 0, 0, 0.00157252, -1, -120, 0, 1),
(@GUID+2, 202338, 631, 4, 1, 4203.65, 2484.56, 364.873, 6.28004, 0, 0, 0.00157252, -1, -120, 0, 1),
(@GUID+3, 202340, 631, 8, 1, 4203.65, 2484.56, 364.873, 6.28004, 0, 0, 0.00157252, -1, -120, 0, 1);
-- 03_[Dungeon]Obsidian_Sanctum.sql
-- Twilight Welp
UPDATE `creature_template` SET `minlevel`=81  , `maxlevel`=81, `Health_mod`=12 WHERE `entry` IN (30890,31214);
UPDATE `creature_template` SET `Health_mod`=29 WHERE `entry` IN (31540,31548);
-- Twilight Egg
UPDATE `creature_template` SET `minlevel`=80  , `maxlevel`=80, `Health_mod`=5 WHERE `entry` IN (30882,31204);
UPDATE `creature_template` SET `Health_mod`=15 WHERE `entry` IN (31539,31547);
UPDATE `creature_template` SET `ScriptName` = 'mob_twilight_eggs' WHERE `entry` = 31204;
-- Delete Portals
DELETE FROM `gameobject` WHERE `id`=193988;
-- Delete Trigger
DELETE FROM `creature` WHERE `id` = 31138;
-- Add Script to Portal
UPDATE `gameobject_template` SET `ScriptName` = 'go_twilight_portal' WHERE `entry` = 193988;
-- Add Script to Trash
UPDATE `creature_template` SET `ScriptName` = 'mob_obsidian_sanctum_trash' WHERE `entry` IN (30681,30680,30682,30453);
-- Fix some Immunitys
UPDATE `creature_template` SET `mechanic_immune_mask`=650854235 WHERE `entry` IN (30451,31520,28860,31311);
-- More Terrible Terrible Damage
UPDATE `creature_template` SET `dmg_multiplier` = 13 WHERE `entry` IN (30681,30680,30682,30453,31214,30890,31219,31218);
UPDATE `creature_template` SET `dmg_multiplier` = 26 WHERE `entry` IN (31001,30999,30998,31000,31548,31540,31543,31541);
UPDATE `creature_template` SET `dmg_multiplier` = 40 WHERE `entry` IN (30452,30451,30449,28860);
UPDATE `creature_template` SET `dmg_multiplier` = 80 WHERE `entry` IN (31535,31520,31534,31311);
UPDATE `creature_template` SET `dmgschool`=1 WHERE `entry` IN (30643,31317);UPDATE `spell_bonus_data` SET `direct_bonus` = 0.473 WHERE `entry` = 974;DELETE FROM `spell_script_names` WHERE `spell_id` = 58597;
INSERT INTO `spell_script_names` VALUES
(58597, 'spell_pal_sacred_shield');-- A�adido CD interno a Nature Grasp
DELETE FROM `spell_proc_event` WHERE `entry` = 16689;

INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`)

VALUES (16689, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2);-- Fix Spell Explosive Trap (Hunter) da�o peri�dico nulo
UPDATE `spell_bonus_data` SET `ap_dot_bonus` = '0.1' WHERE `entry` = 13812;DELETE FROM `spell_dbc` WHERE `id` = 20912;
INSERT INTO `spell_dbc` (`Id`,`CastingTimeIndex`,`DurationIndex`,`RangeIndex`,`Effect1`,`EffectBasePoints1`,`EffectImplicitTargetA1`,`EffectApplyAuraName1`,`EffectMiscValue1`,`SpellFamilyName`,`Comment`) VALUES
(20912,1,21,1,6,-3,1,87,127,10,'Blessing of Sanctuary Helper (SERVERSIDE)');

-- Blessing of Sanctuary vs Vigilance
UPDATE `spell_group` SET `spell_id` = 68066 WHERE `id` = 1091 and `spell_id` = 47930;
UPDATE `spell_group` SET `spell_id` = 20912 WHERE `id` = 1092 and `spell_id` = 20911;
-- Eilo (https://github.com/eilo)
-- Recopilacion y adecuacion de querys originales de HyD y varios autores de scripts antiguas y raras
-- Algunas querys anadidas y ordenacion/comentarios del sql por Eilo

-- INSTANCE: Halls of Reflection
-- Creature Templates
SET @NPC_JAINA_OUTRO        := 36955;
SET @NPC_SYLVANA_OUTRO      := 37554;
SET @NPC_LICH_KING_BOSS     := 37226;

-- Unit flags de HoR (por Eilo)
UPDATE `creature_template` SET `unit_flags`=0 WHERE `entry` IN (38112,38599,38113,38603,36954,38173,38525,38172,38524,38176,38544,38175,38563,38177,38564,36723,37720,37226,36940,37550,36941,37551,37069,37549,38567,38568);

-- Complementos Intro
UPDATE `creature_template` SET `scale`='0.8', `equipment_id`='1221' WHERE `entry` IN (37221, @NPC_JAINA_OUTRO);
UPDATE `creature_template` SET `equipment_id`='1290' WHERE `entry` IN (37223, @NPC_SYLVANA_OUTRO);
UPDATE `creature_template` SET `equipment_id`='0' WHERE `entry`=36954;
UPDATE `creature_template` SET `scale`='0.8' WHERE `entry` IN (37225, 37223, @NPC_LICH_KING_BOSS, @NPC_SYLVANA_OUTRO);

-- Complementos Mini boss
UPDATE `creature_template` SET `speed_walk`='1.8', `speed_run`='2.0' WHERE `entry` IN (36954, @NPC_LICH_KING_BOSS);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_frostworn_general' WHERE `entry`=36723;
UPDATE `creature_template` SET `flags_extra` = 1 WHERE `entry` = 36723;
UPDATE `creature_template` SET `flags_extra` = 257 WHERE `entry` = 36723;

-- Complementos Segunda Parte
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_jaina_and_sylvana_hor_part2' WHERE `entry` IN (@NPC_JAINA_OUTRO, @NPC_SYLVANA_OUTRO);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='boss_lich_king_hor' WHERE `entry`=@NPC_LICH_KING_BOSS;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_raging_gnoul' WHERE `entry`=36940;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_risen_witch_doctor' WHERE `entry`=36941;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_abon' WHERE `entry`=37069;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_queldelar' WHERE `entry`=37158;

-- Complementos adicionales
UPDATE `creature_template` SET `unit_flags` = 32784, `AIName` = '', `ScriptName` = 'npc_spiritual_reflection', `difficulty_entry_1` = 37721 WHERE `entry` = 37107;
UPDATE `creature_template` SET `minlevel` = 80, `maxlevel` = 80, `unit_flags` = 32784, `mindmg` = '422', `maxdmg` = '586', `attackpower` = '642', `dmg_multiplier` = '13' WHERE `entry` = 37721;

-- Quitando a Uther visible
DELETE FROM `creature` WHERE `id` IN (37225) AND `map` = 668;

-- Quitando a Arthas visible
DELETE FROM `creature` WHERE `id` IN (37226) AND `map` = 668;

-- Spawn Quel'delar
DELETE FROM `creature` WHERE `id` IN (37158) AND `map` = 668;
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`)
VALUES 
('37158', '668', '3', '2', '0', '0', '5304.5', '2001.35', '709.341', '4.15073', '7200', '0', '0', '214200', '0', '0', '0', '0', '0');

-- Spawn de Falric y Marwyn
DELETE FROM `creature` WHERE `id` IN (38112,38599,38113,38603);
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`)
VALUES 
('38112','668','3','1','0','0','5271.65','2042.5','709.32','5.51217','604800','0','0','377468','0','0','0','0','0'),
('38599','668','3','1','0','0','5271.65','2042.5','709.32','5.51217','604800','0','0','377468','0','0','0','0','0'),
('38113','668','3','1','0','0','5344.75','1972.87','709.319','2.33445','604800','0','0','539240','0','0','0','0','0'),
('38603','668','3','1','0','0','5344.75','1972.87','709.319','2.33445','604800','0','0','539240','0','0','0','0','0');

-- Spawn de Frostsworn General
DELETE FROM `creature` WHERE `id` IN (36723);
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`)
VALUES
('36723','668','3','1','0','2432','5413.9','2116.65','707.695','3.94765','604800','0','0','315000','0','0','0','0','0');

-- Facciones gameobjects
UPDATE `gameobject_template` SET `faction`='1375' WHERE `entry` IN (197341, 202302, 201385, 201596);

-- Textos
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1594540 AND -1594430;
INSERT INTO `script_texts` (`entry`,`content_default`,`content_loc8`,`sound`,`TYPE`,`LANGUAGE`,`emote`,`COMMENT`) VALUES
(-1594473, 'Insensata, buscas lo que asesine tiempo atras. Ahora no es mas que un fantasma, un eco lejano en mi mente.', '', 17229,1,0,0, '67234'),
(-1594474, 'No cometere el mismo error, Sylvanas. Esta vez no habra escapatoria. Fallaste al servirme como no muerta. Ahora lo que te queda es el olvido.', '', 17228,1,0,0, '67234'),
-- SCENE - Hall Of Reflection (Extro) - PreEscape
(-1594477, 'Han llegado tus aliados, Jaina, como prometiste. Todos sereis poderosos agentes de la Plaga.', '', 17212,1,0,0, '67234'),
(-1594478, 'No cometere el mismo error, Sylvanas. Esta vez no habra escapatoria. Me servireis en la muerte!', '', 17213,1,0,0, '67234'),
(-1594479, 'Es demasiado poderoso, debemos abandonar este lugar ahora mismo! Mi magia podra inmovilizarlo brevemente! Vamos rapido, heroes!', '', 16644,0,0,1, '67234'),
(-1594480, 'Es demasiado poderoso! Heroes, rapido, venid! Debemos abandonar este lugar ahora mismo! Hare lo que pueda para inmovilizarlo mientras huimos.', '', 17058,0,0,1, '67234'),
-- SCENE - Hall Of Reflection (Extro) - Escape
(-1594481, 'El frio abrazo de la muerte os aguarda!', '', 17221,1,0,0, '67234'),
(-1594482, 'Alzaos esbirros! Que no pasen!', '', 17216,1,0,0, '67234'),
(-1594483, 'Esbirros cojedlos. Traedme sus cadaveres!', '', 17222,1,0,0, '67234'),
(-1594484, 'Sin esperanza...', '!', 17214,1,0,0, '67234'),
(-1594485, 'Todo perdido!', '', 17215,1,0,0, '67234'),
(-1594486, 'No hay escapatoria!', '', 17217,1,0,0, '67234'),
(-1594487, 'Destruire esta barrera. Debeis mantener atras a los no muertos!', '', 16607,1,0,0, '67234'),
(-1594488, 'Ninguna pared detendre a la Reina Alma en Pena! Mantened a los no muertos a raya, heroes! Destruire esta barrera!', '', 17029,1,0,0, '67234'),
(-1594489, 'Otro muro de hielo! Evitad que los no muertos interrumpan mis conjuros para que pueda derribar este muro!', '', 16608,1,0,0, '67234'),
(-1594490, 'Otra barrera? Sed fuertes, campeones! Derrumbare el muro!', '', 17030,1,0,0, '67234'),
(-1594491, 'Sucumbid al frio de la tumba.', '', 17218,1,0,0, '67234'),
(-1594492, 'Otro final sin salida.', '', 17219,1,0,0, '67234'),
(-1594493, 'Cuanto vais a aguantar?', '', 17220,1,0,0, '67234'),
(-1594494, 'Esta jugando con nosotros. Le enseñare lo que le pasa al hielo cuando se junta con el fuego!', '', 16609,0,0,0, '67234'),
(-1594495, 'Tus muros no pueden detenernos, monstruo. Los destruire todos!', '', 16610,1,0,0, '67234'),
(-1594496, 'Me canso de estos juegos, Arthas! Tus muros no me detendran!', '', 17031,1,0,0, '67234'),
(-1594497, 'No impediras que escapemos, demonio. Acabad con los no muertos mientras derribo esta barrera!', '', 17032,1,0,0, '67234'),
(-1594498, 'Hay una salida ahi delante, vamos!', '', 16645,1,0,0, '67234'),
(-1594499, 'Casi estamos, no os rindais!', '', 16646,1,0,0, '67234'),
(-1594500, 'Hay una salida ahi delante, vamos!', '', 17059,1,0,0, '67234'),
(-1594501, 'Casi estamos, no os rindais!', '', 17060,1,0,0, '67234'),
(-1594502, 'No... No hay salida. No tenemos mas opcion que luchar. Armaos de valor heroes, pues esta sera nuestra ultima batalla!', '', 16647,1,0,0, '67234'),
(-1594503, 'Maldicion, no hay salida! Asi es como acaba. Preparaos heroes, hoy tendra lugar nuestra ultima batalla!', '', 17061,1,0,0, '67234'),
(-1594504, 'No corrais. Sois mios....', '', 17223,1,0,0, '67234'),
(-1594524,'Perdonadme heroes. Debi escuchar a Uther. Tenia que verlo por mi misma, poder mirarle a los ojos una ultima vez. Lo siento.', '','16648','0','0','0','67234'),
(-1594525,'Ahora sabemos que debemos hacer, les dare estas noticias al Rey Varian y al alto señor Vadin.','','16649','0','0','0','67234'),
(-1594522,'Fuego, fuego!','','16732','1','0','0','67234'),
(-1594523,'A bordo! Ya! La ladera de la montaña se derrumbara en cualquier momento!','','16733','1','0','0','67234'),
(-1594521,'Estamos a salvo por ahora. Su fuerza se ha multiplicado desde nuestra ultima batalla. Necesitamos un ejercito poderoso para destruir al Rey Exanime, mejor incluso que el que la Horda puede convocar.','','17062','0','0','0','67234'),
(-1594526,'Fuego, fuego!','','16721','1','0','0','67234'),
(-1594527,'Rapido! A bordo! No debemos entretenernos. La ladera de la montaña se derrumbara en cualquier momento!','','16722','1','0','0','67234'),
(-1594505, 'Soldados de Lordaeron, alzaos ante la llamada de vuestro maestro!', '', 16714,1,0,0, '67234'),
(-1594506, 'El maestro observo su reino, y lo encontro... incompleto. Su juicio fue rapido y despiado. Muerte a todos!', '', 16738,1,0,0, '67234'),
-- FrostWorn General
(-1594519, 'No sois dignos de enfrentaros al Rey Exanime!', '', 16921,1,0,0, '67234'),
(-1594520, 'Maestro, he fracasado...', '', 16922,1,0,0, '67234');

-- Waipoints
DELETE FROM script_waypoint WHERE entry IN (@NPC_JAINA_OUTRO,@NPC_LICH_KING_BOSS,@NPC_SYLVANA_OUTRO);
INSERT INTO script_waypoint VALUES
-- Jaina

   (@NPC_JAINA_OUTRO, 0, 5587.682,2228.586,733.011, 0, 'WP1'),
   (@NPC_JAINA_OUTRO, 1, 5600.715,2209.058,731.618, 0, 'WP2'),
   (@NPC_JAINA_OUTRO, 2, 5606.417,2193.029,731.129, 0, 'WP3'),
   (@NPC_JAINA_OUTRO, 3, 5598.562,2167.806,730.918, 0, 'WP4 - Summon IceWall 01'),
   (@NPC_JAINA_OUTRO, 4, 5556.436,2099.827,731.827, 0, 'WP5 - Spell Channel'),
   (@NPC_JAINA_OUTRO, 5, 5543.498,2071.234,731.702, 0, 'WP6'),
   (@NPC_JAINA_OUTRO, 6, 5528.969,2036.121,731.407, 0, 'WP7'),
   (@NPC_JAINA_OUTRO, 7, 5512.045,1996.702,735.122, 0, 'WP8'),
   (@NPC_JAINA_OUTRO, 8, 5504.490,1988.789,735.886, 0, 'WP9 - Spell Channel'),
   (@NPC_JAINA_OUTRO, 9, 5489.645,1966.389,737.653, 0, 'WP10'),
   (@NPC_JAINA_OUTRO, 10, 5475.517,1943.176,741.146, 0, 'WP11'),
   (@NPC_JAINA_OUTRO, 11, 5466.930,1926.049,743.536, 0, 'WP12'),
   (@NPC_JAINA_OUTRO, 12, 5445.157,1894.955,748.757, 0, 'WP13 - Spell Channel'),
   (@NPC_JAINA_OUTRO, 13, 5425.907,1869.708,753.237, 0, 'WP14'),
   (@NPC_JAINA_OUTRO, 14, 5405.118,1833.937,757.486, 0, 'WP15'),
   (@NPC_JAINA_OUTRO, 15, 5370.324,1799.375,761.007, 0, 'WP16'),
   (@NPC_JAINA_OUTRO, 16, 5335.422,1766.951,767.635, 0, 'WP17 - Spell Channel'),
   (@NPC_JAINA_OUTRO, 17, 5311.438,1739.390,774.165, 0, 'WP18'),
   (@NPC_JAINA_OUTRO, 18, 5283.589,1703.755,784.176, 0, 'WP19'),
   (@NPC_JAINA_OUTRO, 19, 5260.400,1677.775,784.301, 3000, 'WP20'),
   (@NPC_JAINA_OUTRO, 20, 5262.439,1680.410,784.294, 0, 'WP21'),
   (@NPC_JAINA_OUTRO, 21, 5260.400,1677.775,784.301, 0, 'WP22'),

-- Sylvana

   (@NPC_SYLVANA_OUTRO, 0, 5587.682,2228.586,733.011, 0, 'WP1'),
   (@NPC_SYLVANA_OUTRO, 1, 5600.715,2209.058,731.618, 0, 'WP2'),
   (@NPC_SYLVANA_OUTRO, 2, 5606.417,2193.029,731.129, 0, 'WP3'),
   (@NPC_SYLVANA_OUTRO, 3, 5598.562,2167.806,730.918, 0, 'WP4 - Summon IceWall 01'),
   (@NPC_SYLVANA_OUTRO, 4, 5556.436,2099.827,731.827, 0, 'WP5 - Spell Channel'),
   (@NPC_SYLVANA_OUTRO, 5, 5543.498,2071.234,731.702, 0, 'WP6'),
   (@NPC_SYLVANA_OUTRO, 6, 5528.969,2036.121,731.407, 0, 'WP7'),
   (@NPC_SYLVANA_OUTRO, 7, 5512.045,1996.702,735.122, 0, 'WP8'),
   (@NPC_SYLVANA_OUTRO, 8, 5504.490,1988.789,735.886, 0, 'WP9 - Spell Channel'),
   (@NPC_SYLVANA_OUTRO, 9, 5489.645,1966.389,737.653, 0, 'WP10'),
   (@NPC_SYLVANA_OUTRO, 10, 5475.517,1943.176,741.146, 0, 'WP11'),
   (@NPC_SYLVANA_OUTRO, 11, 5466.930,1926.049,743.536, 0, 'WP12'),
   (@NPC_SYLVANA_OUTRO, 12, 5445.157,1894.955,748.757, 0, 'WP13 - Spell Channel'),
   (@NPC_SYLVANA_OUTRO, 13, 5425.907,1869.708,753.237, 0, 'WP14'),
   (@NPC_SYLVANA_OUTRO, 14, 5405.118,1833.937,757.486, 0, 'WP15'),
   (@NPC_SYLVANA_OUTRO, 15, 5370.324,1799.375,761.007, 0, 'WP16'),
   (@NPC_SYLVANA_OUTRO, 16, 5335.422,1766.951,767.635, 0, 'WP17 - Spell Channel'),
   (@NPC_SYLVANA_OUTRO, 17, 5311.438,1739.390,774.165, 0, 'WP18'),
   (@NPC_SYLVANA_OUTRO, 18, 5283.589,1703.755,784.176, 0, 'WP19'),
   (@NPC_SYLVANA_OUTRO, 19, 5260.400,1677.775,784.301, 3000, 'WP20'),
   (@NPC_SYLVANA_OUTRO, 20, 5262.439,1680.410,784.294, 0, 'WP21'),
   (@NPC_SYLVANA_OUTRO, 21, 5260.400,1677.775,784.301, 0, 'WP22'),

-- Lich King

   (@NPC_LICH_KING_BOSS, 1, 5577.19, 2236, 733.012, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 2, 5580.57, 2232.22, 733.012, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 3, 5586.67, 2225.54, 733.012, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 4, 5590.45, 2221.41, 733.012, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 5, 5595.75, 2215.62, 732.101, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 6, 5601.21, 2206.49, 731.54, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 7, 5605.01, 2197.9, 731.667, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 8, 5606.55, 2191.39, 730.977, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 9, 5604.68, 2186.11, 730.998, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 10, 5602.26, 2179.9, 730.967, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 11, 5600.06, 2174.38, 730.924, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 12, 5597.29, 2166.81, 730.924, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 13, 5596.25, 2160.36, 730.931, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 14, 5591.79, 2152.87, 731.008, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 15, 5585.47, 2146.63, 731.109, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 16, 5579.1, 2140.34, 731.18, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 17, 5572.56, 2134.21, 731.092, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 18, 5564.08, 2126.53, 730.816, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 19, 5559.04, 2117.64, 730.812, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 20, 5555.77, 2111.88, 730.995, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 21, 5550.82, 2103.14, 731.123, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 22, 5546.02, 2094.68, 731.16, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 23, 5541.53, 2084.42, 730.999, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 24, 5537.5, 2075.18, 730.901, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 25, 5533.76, 2063.84, 730.87, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 26, 5530.97, 2052.98, 730.981, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 27, 5526.75, 2041.73, 731.193, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 28, 5522.88, 2031.65, 731.7, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 29, 5521.01, 2023.02, 732.396, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 30, 5516.55, 2015.36, 733.12, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 31, 5513.06, 2007.33, 733.99, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 32, 5510.43, 1997.9, 735.016, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 33, 5504.53, 1990.39, 735.748, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 34, 5499.34, 1983.78, 736.29, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 35, 5493.11, 1975.86, 736.852, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 36, 5487.58, 1968.81, 737.394, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 37, 5483.12, 1961.78, 738.06, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 38, 5478.33, 1954.2, 739.343, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 39, 5475.2, 1945.84, 740.697, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 40, 5472.15, 1938.02, 741.884, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 41, 5469.26, 1931.34, 742.813, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 42, 5464.23, 1922.25, 744.055, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 43, 5458.43, 1912.96, 745.229, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 44, 5452.26, 1902.95, 747.091, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 45, 5442.44, 1892.51, 749.208, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 46, 5435.67, 1879.7, 751.776, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 47, 5429.03, 1870.73, 753.151, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 48, 5423.72, 1862.16, 754.263, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 49, 5417.21, 1851.7, 755.507, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 50, 5408.94, 1838.38, 757.002, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 51, 5398.8, 1829.61, 757.742, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 52, 5388.47, 1817.95, 759.285, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 53, 5378.23, 1808.5, 760.316, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 54, 5368.5, 1801.35, 760.845, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 55, 5360.86, 1793.16, 762.271, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 56, 5353.62, 1785.4, 763.868, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 57, 5344.78, 1776.09, 765.759, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 58, 5336.38, 1768.67, 767.324, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 59, 5327.56, 1760.12, 769.332, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 60, 5319.62, 1750.7, 771.487, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 61, 5313.12, 1742.99, 773.424, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 62, 5305.41, 1735.79, 775.473, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 63, 5298.93, 1728.16, 777.573, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 64, 5292.54, 1720.37, 779.862, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 65, 5287.11, 1713.96, 781.667, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 66, 5280.14, 1705.21, 784.65, 0, 'HoR WP LichKing'),
   (@NPC_LICH_KING_BOSS, 67, 5277.98, 1701.28, 785.224, 0, 'HoR WP LichKing');

-- AreaTrigger for waves restarter
DELETE FROM `areatrigger_scripts` WHERE `entry` = 5697;
INSERT INTO `areatrigger_scripts` VALUES
(5697, 'at_hor_waves_restarter');

-- GameObject Templates
DELETE FROM gameobject_template WHERE entry IN (201709, 202211, 190236, 196391, 196392, 197341, 197342, 197343, 201385, 201596, 201710, 201747, 201756, 201885, 201976, 202079, 202212, 202236, 202302, 202336, 202337, 202396, 500001, 500002, 500003);
INSERT INTO `gameobject_template` (`entry`, `TYPE`, `displayId`, `NAME`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `AIName`, `ScriptName`, `WDBVerified`) VALUES
('201596','0','9223','Cave In','','','','1375','4','2','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','12340'),
('197342','0','9124','Doodad_IceCrown_Door_02','','','','1375','36','1','0','0','0','0','0','0','1','0','3','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','12340'),
('197343','0','9124','Doodad_IceCrown_Door_03','','','','1375','36','1','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','12340'),
('201976','0','9124','Doodad_IceCrown_Door_04','','','','114','32','1','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','12340'),
('196391','31','8196','Doodad_InstanceNewPortal_Purple01','','','','0','0','2.72','0','0','0','0','0','0','632','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','12340'),
('201747','31','8196','Doodad_InstanceNewPortal_Purple01','','','','0','0','2.72','0','0','0','0','0','0','668','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','12340'),
('196392','31','8197','Doodad_InstanceNewPortal_Purple_Skull01','','','','0','0','2.72','0','0','0','0','0','0','632','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','12340'),
('201756','31','8197','Doodad_InstanceNewPortal_Purple_Skull01','','','','0','0','2.72','0','0','0','0','0','0','668','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','12340'),
('202302','0','9301','Frostmourne','','','','1375','32','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','12340'),
('202236','0','9294','Frostmourne Altar','','','','114','32','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','12340'),
('190236','0','7876','Gate','','','','114','32','0.88','0','0','0','0','0','0','0','0','3000','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','12340'),
('201385','0','9214','Ice Wall','','','','1375','1','2.5','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','12340'),
('500001','0','9214','Ice Wall','','','','1375','1','2.5','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','1'),
('201885','0','9214','Ice Wall','','','','0','1','2','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','12340'),
('202396','0','9214','Ice Wall','','','','114','33','2','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','12340'),
('197341','0','9124','Impenetrable Door','','','','1375','32','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','12340'),
('500003','14','8253','Orgrim\'s Hammer','','','','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','1'),
('202079','22','8111','Portal to Dalaran','','','','0','0','1','0','0','0','0','0','0','53141','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','12340'),
('201710','3','9280','The Captain\'s Chest','','','','1732','0','1','0','0','0','0','0','0','57','27985','0','1','0','0','0','0','0','0','0','1','0','0','0','1','0','0','0','0','0','0','0','0','','','12340'),
('202337','3','9281','The Captain\'s Chest','','','','1735','0','1','0','0','0','0','0','0','57','27993','0','1','0','0','0','0','0','0','0','1','0','0','0','1','0','0','0','0','0','0','0','0','','','12340'),
('202336','3','9280','The Captain\'s Chest','','','','1732','0','1','0','0','0','0','0','0','57','27993','0','1','0','0','0','0','0','0','0','1','0','0','0','1','0','0','0','0','0','0','0','0','','','12340'),
('202212','3','9281','The Captain\'s Chest','','','','1735','0','1','0','0','0','0','0','0','57','27985','0','1','0','0','0','0','0','0','0','1','0','0','0','1','0','0','0','0','0','0','0','0','','','11723'),
('500002','14','9150','The Skybreaker','','','','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','1'),
('201709','5','9288','Gunship Stairs','','','','0','1','2','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','12340'),
('202211','5','9289','Gunship Stairs','','','','0','1','2','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','12340');

-- Gameobject Spawns
DELETE FROM gameobject WHERE map = 668 AND id IN (190236, 196391, 196392, 197341, 197342, 197343, 201385, 201596, 201710, 201747, 201756, 201885, 201976, 202079, 202212, 202236, 202302, 202336, 202337, 202396, 500001, 500002, 500003);
SET @GUID_GO := 153000;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID_GO,201747,668,3,1,5231.04,1923.79,707.044,0.810935,0,0,-0.370856,0.928691,6000,100,1),
(@GUID_GO+1,201756,668,3,1,5231.04,1923.79,707.044,0.810935,0,0,-0.370856,0.928691,6000,100,1),
(@GUID_GO+2,190236,668,3,1,4926.09,1554.96,163.292,-2.26562,0,0,0.999999,-0.001655,6000,100,1),
(@GUID_GO+3,202302,668,3,1,5309.51,2006.64,709.341,5.50041,0,0,0.381473,-0.92438,604800,100,1),
(@GUID_GO+4,202236,668,3,1,5309.51,2006.64,709.341,5.53575,0,0,0.365077,-0.930977,604800,100,1),
(@GUID_GO+5,201596,668,3,1,5275.28,1694.23,786.147,0.981225,0,0,0.471166,0.882044,25,0,0),
(@GUID_GO+6,500001,668,3,1,5323.61,1755.85,770.305,0.784186,0,0,0.382124,0.924111,604800,100,0),
(@GUID_GO+7,196391,668,3,1,5232.31,1925.57,707.695,0.815481,0,0,0.396536,0.918019,300,0,1),
(@GUID_GO+8,196392,668,3,1,5232.31,1925.57,707.695,0.815481,0,0,0.396536,0.918019,300,0,1),
(@GUID_GO+9,202396,668,3,1,5434.27,1881.12,751.303,0.923328,0,0,0.445439,0.895312,604800,100,0),
(@GUID_GO+10,201885,668,3,1,5494.3,1978.27,736.689,1.0885,0,0,0.517777,0.855516,604800,100,0),
(@GUID_GO+11,197341,668,3,1,5359.24,2058.35,707.695,3.96022,0,0,0.917394,-0.397981,300,100,1),
(@GUID_GO+12,201976,668,3,1,5264.6,1959.55,707.695,0.736951,0,0,0.360194,0.932877,300,100,0),
(@GUID_GO+13,197342,668,3,1,5520.72,2228.89,733.011,0.778581,0,0,0.379532,0.925179,300,100,1),
(@GUID_GO+14,197343,668,3,1,5582.96,2230.59,733.011,5.49098,0,0,0.385827,-0.922571,300,100,1),
(@GUID_GO+15,201385,668,3,1,5540.39,2086.48,731.066,1.00057,0,0,0.479677,0.877445,604800,100,0),
(@GUID_GO+16,202337,668,2,1,5252.33,1585.36,796.062,2.80195,0,0,0.985615,0.169007,604800,100,1),
(@GUID_GO+17,202336,668,2,1,5264.22,1584.94,794.359,2.70142,0,0,0.975878,0.218315,604800,100,1),
(@GUID_GO+18,202079,668,3,1,5248.58,1574.22,795.209,0,0,0,0,1,604800,100,1),
(@GUID_GO+19,500002,668,3,1,5247.09,1586.39,773.922,5.86166,0,0,0.209207,-0.977871,300,0,1),
(@GUID_GO+20,500003,668,3,1,5245.17,1582.11,761.72,5.86166,0,0,0.209207,-0.977871,300,0,1),
(@GUID_GO+21,202212,668,1,1,5253.03,1585.13,796.089,2.75698,0,0,0.981566,0.191121,300,0,1),
(@GUID_GO+22,201710,668,1,1,5262.5,1582.41,794.342,2.75698,0,0,0.981566,0.191121,300,0,1);

-- Loot del Chest del final
DELETE FROM `gameobject_loot_template` WHERE (`entry`=27993);
INSERT INTO `gameobject_loot_template` VALUES 
(27993, 43102, 100, 1, 0, 1, 1),
(27993, 47241, 100, 1, 0, 1, 1),
(27993, 50302, 0, 1, 1, 1, 1),
(27993, 50303, 0, 1, 1, 1, 1),
(27993, 50304, 0, 1, 2, 1, 1),
(27993, 50305, 0, 1, 2, 1, 1),
(27993, 50306, 0, 1, 1, 1, 1),
(27993, 50308, 0, 1, 2, 1, 1),
(27993, 50309, 0, 1, 1, 1, 1),
(27993, 50310, 0, 1, 2, 1, 1),
(27993, 50311, 0, 1, 2, 1, 1),
(27993, 50312, 0, 1, 2, 1, 1),
(27993, 50313, 0, 1, 1, 1, 1),
(27993, 50314, 0, 1, 1, 1, 1);

DELETE FROM `gameobject_loot_template` WHERE (`entry`=27985);
INSERT INTO `gameobject_loot_template` VALUES 
(27985, 47241, 100, 1, 0, 1, 1),
(27985, 49839, 0, 1, 1, 1, 1),
(27985, 49840, 0, 1, 1, 1, 1),
(27985, 49841, 0, 1, 2, 1, 1),
(27985, 49842, 0, 1, 2, 1, 1),
(27985, 49843, 0, 1, 2, 1, 1),
(27985, 49844, 0, 1, 1, 1, 1),
(27985, 49845, 0, 1, 1, 1, 1),
(27985, 49846, 0, 1, 1, 1, 1),
(27985, 49847, 0, 1, 2, 1, 1),
(27985, 49848, 0, 1, 2, 1, 1),
(27985, 49849, 0, 1, 1, 1, 1),
(27985, 49851, 0, 1, 2, 1, 1);

-- Inmunidades.
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|4194304|8388608|33554432|536870912 WHERE `entry` IN (SELECT `id`  FROM `creature` WHERE map=668);
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|4194304|8388608|33554432|536870912 WHERE `entry` IN 
(
38112,
38113,
36723,
37107,
36954,
37745,
37158,
37226,
37225,
37221,
36955,
37223,
37554,
37182,
37833,
38177,
38173,
38176,
38175,
38172,
37906,
37014,
36940,
36941,
37069);
DELETE FROM spell_script_names WHERE ScriptName='spell_warl_demonic_circle_summon';
INSERT INTO spell_script_names VALUES (48018, 'spell_warl_demonic_circle_summon');

DELETE FROM disables WHERE sourceType=3 AND entry IN (10,11);SET NAMES 'utf8';

DELETE FROM `trinity_string` WHERE entry IN (756,757,758,759,760,761,762,763,764,765,766,767,768,769,770,771,772,780,781,782,783);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('756', 'Battle begins!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '�?и�?ва на�?аНас�?'),
('757', '%s has successfully defended the fortress!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '%s успошнО Са�?и�?иН(а) к�?опОс�?�?!'),
('758', '%s has taken over the fortress!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '%s Са�?ва�?иН(а) к�?опОс�?�?'),
('759', 'The %s siege workshop has been damaged by the %s!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('760', 'The %s siege workshop has been destroyed by the %s!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('761', 'The %s tower has been damaged!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '%s йашн�? пОв�?оМдона'),
('762', 'The %s tower has been destroyed!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '%s йашн�? уни�?�?ОМона!'),
('763', 'Wintergrasp fortress is under attack!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('764', 'Wintergrasp is now under the control of the %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('765', 'Wintergrasp timer set to %s.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('766', 'Wintergrasp battle started.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('767', 'Wintergrasp battle finished.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('768', 'Wintergrasp info: %s controlled. Timer: %s. Wartime: %s. Number of Players: (Horde: %u, Alliance: %u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('769', 'Wintergrasp outdoorPvP is disabled.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('770', 'Wintergrasp outdoorPvP is enabled.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('771', 'You have reached Rank 1: Corporal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '�?�? дОс�?игНи � анга 1: �?ап�?аН'),
('772', 'You have reached Rank 2: First Lieutenant', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '�?�? дОс�?игНи � анга 2: �?оК�?онан�?'),
('780', 'Before the Battle of  Wintergrasp left 30 minutes!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '�?О йи�?в�? на  �?Со�?о �?од�?н�?�? �?кОв Ос�?аНОс�? 30 Пину�?!'),
('781', 'Before the Battle of  Wintergrasp left 10 minutes! Portal from Dalaran will work at begin of the battle.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '�?О йи�?в�? на  �?Со�?о �?од�?н�?�? �?кОв Ос�?аНОс�? 10 Пину�?! �?О�?�?аН с �?аНа�?ана на�?но�? �?айО�?у вО в�?оП�? йО�?.'),
('782', 'The battle for Wintergrasp  has stopped! Not enough defenders. Wintergrasp Fortress remains  Attackers.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '�?и�?ва Са �?Со�?О �?од�?н�?�? �?кОв �?с�?анОвНона. �?о �?ва�?ао�? Са�?и�?никОв. �?�?опОс�?�? по�?о�?Оди�? а�?аку�?�?оК  с�?О�?Оно.'),
('783', 'The battle for Wintergrasp  has stopped! Not enough attackers. Wintergrasp Fortress remains  Defenders.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '�?и�?ва Са �?Со�?О �?од�?н�?�? �?кОв �?с�?анОвНона. �?о �?ва�?ао�? напада�?�?и�?. �?�?опОс�?�? Ос�?ао�?с�? Са�?и�?никаП.');

DELETE FROM `command` WHERE name IN ('wg','wg enable','wg start','wg status','wg stop','wg switch','wg timer');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('wg', '3', 'Syntax: .wg $subcommand.'),
('wg enable', '3', 'Syntax: .wg enable [on/off] Enable/Disable Wintergrasp outdoorPvP.'),
('wg start', '3', 'Syntax: .wg start\r\nForce Wintergrasp battle start.'),
('wg status', '3', 'Syntax: .wg status\r\nWintergrasp info, defender, timer, wartime.'),
('wg stop', '3', 'Syntax: .wg stop\r\nForce Wintergrasp battle stop (No rewards).'),
('wg switch', '3', 'Syntax: .wg switch\r\nSwitchs Wintergrasp defender team.'),
('wg timer', '3', 'Syntax: .wg timer $minutes\r\nChange the current timer. Min value = 1, Max value 60 (Wartime), 1440 (Not Wartime)');

/* WG scriptname */
DELETE FROM `outdoorpvp_template` WHERE TypeId=7;
INSERT INTO `outdoorpvp_template` (`TypeId`, `ScriptName`, `comment`) VALUES 
('7', 'outdoorpvp_wg', 'Wintergrasp');

/* Teleport WG SPELLs*/
DELETE FROM `spell_target_position` WHERE id IN ('59096', '58632', '58633');
INSERT INTO `spell_target_position` (`id`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
('59096', '571', '5325.06', '2843.36', '409.285', '3.20278'),
('58632', '571', '5097.79', '2180.29', '365.61', '2.41'),
('58633', '571', '5026.80', '3676.69', '362.58', '3.94');

/* Defender's Portal Activate Proper Spell */
DELETE FROM `spell_linked_spell` WHERE spell_trigger=54640;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES 
('54640','54643','0','Defenders Portal Activate Proper Spell');

/* Protect players from catching by Druid Cyclone at graveyard which removes immunity after disappear */
DELETE FROM `spell_linked_spell` WHERE spell_trigger=58729;
INSERT INTO `spell_linked_spell` VALUES (58729, -33786, 2, 'Spiritual Immunity: Protect From Cyclone (now Immune always)');

/*Spirit healer add spiritguide flag FIX for ressurection*/
UPDATE creature_template SET npcflag=npcflag|32768 WHERE entry IN (31841,31842);

/* Creature template */
UPDATE creature_template SET faction_A = '1802', faction_H = '1802' WHERE entry IN (30499,28312,28319);
UPDATE creature_template SET faction_A = '1801', faction_H = '1801' WHERE entry IN (30400,32629,32627);

/* Demolisher Engineer script */
UPDATE `creature_template` SET `ScriptName` = 'npc_demolisher_engineerer' WHERE `entry` IN (30400,30499);

/* Wintergrasp Battle-Mage */
DELETE FROM `creature` WHERE `id` IN (32170, 32169);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(NULL, 32170, 571, 1, 65535, 27801, 0, 5917.69, 584.167, 660.49, 5.17983, 300, 0, 0, 504000, 440700, 0, 0, 0, 0),
(NULL, 32170, 571, 1, 65535, 0, 2796, 5939.59, 556.516, 640.001, 2.70112, 300, 0, 0, 504000, 440700, 0, 0, 0, 0),
(NULL, 32169, 571, 1, 65535, 0, 0, 5698.38, 777.562, 647.852, 5.56938, 900, 0, 0, 504000, 440700, 0, 0, 0, 0);

UPDATE `creature_template` SET `ScriptName`='npc_wg_ally_battle_mage' WHERE `entry`=32169;
UPDATE `creature_template` SET `ScriptName`='npc_wg_horde_battle_mage' WHERE `entry`=32170;

/* Portal Dalaran->WG */
DELETE FROM `gameobject` WHERE `id`=193772;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(NULL, 193772, 571, 1, 64, 5924.11, 573.387, 661.087, 4.43208, 0, 0, 0.798953, -0.601393, 300, 0, 1),
(NULL, 193772, 571, 1, 65535, 5686.57, 772.921, 647.754, 5.62225, 0, 0, 0.324484, -0.945891, 600, 0, 1),
(NULL, 193772, 571, 1, 65535, 5930.82, 548.961, 640.632, 1.88506, 0, 0, 0.809047, 0.587744, 300, 0, 1);

/* Vehicle Teleporter */
UPDATE `gameobject_template` SET `type` = 6, `faction` = 0, `data2` = 10, `data3` = 54643, `ScriptName` = 'go_wg_veh_teleporter' WHERE `entry` = 192951;

/* Workshop */
UPDATE `gameobject_template` SET `faction` = 35 WHERE `entry` IN (192028,192029,192030,192031,192032,192033);

/* Towers */
UPDATE `gameobject_template` SET `faction` = 0, `flags` = 6553632 WHERE `entry` IN (190356,190357,190358);

/* Titan Relic remove */
DELETE FROM `gameobject` WHERE `id`=192829;

/* Temp removed gameobject stopping you getting to the relic
* 194323 - [Wintergrasp Keep Collision Wall X:5396.209961 Y:2840.010010 Z:432.268005 MapId:571
* 194162 - [Doodad_WG_Keep_Door01_collision01 X:5397.109863 Y:2841.540039 Z:425.901001 MapId:571]*/
DELETE FROM gameobject WHERE id IN ('194323', '194162');

/* spell target for build vehicles */
DELETE FROM `conditions` WHERE ConditionValue2=27852;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 0, 49899, 0, 18, 1, 27852, 0, 0, '', NULL),
(13, 0, 56575, 0, 18, 1, 27852, 0, 0, '', NULL),
(13, 0, 56661, 0, 18, 1, 27852, 0, 0, '', NULL),
(13, 0, 56663, 0, 18, 1, 27852, 0, 0, '', NULL),
(13, 0, 56665, 0, 18, 1, 27852, 0, 0, '', NULL),
(13, 0, 56667, 0, 18, 1, 27852, 0, 0, '', NULL),
(13, 0, 56669, 0, 18, 1, 27852, 0, 0, '', NULL),
(13, 0, 61408, 0, 18, 1, 27852, 0, 0, '', NULL);

/*WG Spell area Data For wg antifly */
DELETE FROM `spell_area` WHERE spell IN (58730, 57940, 58045);
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_start_active`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`) VALUES
(58730, 4197, 0, 0, 0, 0, 0, 2, 1),
(58730, 4584, 0, 0, 0, 0, 0, 2, 1),
(58730, 4581, 0, 0, 0, 0, 0, 2, 1),
(58730, 4585, 0, 0, 0, 0, 0, 2, 1),
(58730, 4612, 0, 0, 0, 0, 0, 2, 1),
(58730, 4582, 0, 0, 0, 0, 0, 2, 1),
(58730, 4611, 0, 0, 0, 0, 0, 2, 1),
(58730, 4578, 0, 0, 0, 0, 0, 2, 1),
(58730, 4576, 0, 0, 0, 0, 0, 2, 1),
(58730, 4538, 0, 0, 0, 0, 0, 2, 1),
(57940, 65, 0, 0, 0, 0, 0, 2, 1),
(57940, 66, 0, 0, 0, 0, 0, 2, 1),
(57940, 67, 0, 0, 0, 0, 0, 2, 1),
(57940, 206, 0, 0, 0, 0, 0, 2, 1),
(57940, 210, 0, 0, 0, 0, 0, 2, 1),
(57940, 394, 0, 0, 0, 0, 0, 2, 1),
(57940, 395, 0, 0, 0, 0, 0, 2, 1),
(57940, 1196, 0, 0, 0, 0, 0, 2, 1),
(57940, 2817, 0, 0, 0, 0, 0, 2, 1),
(57940, 3456, 0, 0, 0, 0, 0, 2, 1),
(57940, 3477, 0, 0, 0, 0, 0, 2, 1),
(57940, 3537, 0, 0, 0, 0, 0, 2, 1),
(57940, 3711, 0, 0, 0, 0, 0, 2, 1),
(57940, 4100, 0, 0, 0, 0, 0, 2, 1),
(57940, 4196, 0, 0, 0, 0, 0, 2, 1),
(57940, 4228, 0, 0, 0, 0, 0, 2, 1),
(57940, 4264, 0, 0, 0, 0, 0, 2, 1),
(57940, 4265, 0, 0, 0, 0, 0, 2, 1),
(57940, 4272, 0, 0, 0, 0, 0, 2, 1),
(57940, 4273, 0, 0, 0, 0, 0, 2, 1),
(57940, 4395, 0, 0, 0, 0, 0, 2, 1),
(57940, 4415, 0, 0, 0, 0, 0, 2, 1),
(57940, 4416, 0, 0, 0, 0, 0, 2, 1),
(57940, 4493, 0, 0, 0, 0, 0, 2, 1),
(57940, 4494, 0, 0, 0, 0, 0, 2, 1),
(57940, 4603, 0, 0, 0, 0, 0, 2, 1),
(58045, 4197, 0, 0, 0, 0, 0, 2, 1);

DELETE FROM gameobject WHERE 
      id IN (192317,192335,192313,192316,192332,192331,192330,192329,192487,192310,192314,192308,192309,192324,192326,192312,192325,192304,187433,193984,193983,192377,192321,192318,192322,192320,192269,192273,192274,192277,192278,192280,192283,192284,192285,192289,192290,192336,192338,192339,192349,192350,192351,192352,192353,192354,192355,192356,192357,192358,192359,192360,192361,192362,192363,192364,192366,192367,192368,192369,192370,192371,192372,192373,192374,192375,192378,192379,192406,192407,192414,192416,192417,192418,192429,192433,192434,192435,192458,192459,192460,192461,192488,192501,192254,192255,192688,192686,180398,193764,193762,192319,192287,192323,192305,192286,192334,192307,192306,192328,192252,192253,192292,192299,192327,192267,192449,192450) 
         AND map=571;
INSERT INTO `gameobject` VALUES (NULL, 192317, 571, 1, 385, 5363.39, 2781.28, 435.634, 1.58825, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192335, 571, 1, 385, 5363.72, 2763.25, 445.023, -1.54462, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192313, 571, 1, 1, 5392.65, 3037.11, 433.713, -1.52716, 0, 0, -0.691512, 0.722365, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192316, 571, 1, 385, 5322.01, 2781.13, 435.673, 1.57952, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192332, 571, 1, 1, 5289.46, 2704.68, 435.875, -0.017451, 0, 0, -0.00872539, 0.999962, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192331, 571, 1, 1, 5350.95, 2640.36, 435.408, 1.5708, 0, 0, 0.707108, 0.707106, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192330, 571, 1, 1, 5392.27, 2639.74, 435.331, 1.50971, 0, 0, 0.685183, 0.728371, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192329, 571, 1, 1, 5350.88, 2622.72, 444.686, -1.5708, 0, 0, -0.707108, 0.707106, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192487, 571, 1, 1, 5278.38, 2613.83, 432.721, -1.58825, 0, 0, -0.713251, 0.700909, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192487, 571, 1, 1, 5260.82, 2631.8, 433.324, 3.05433, 0, 0, 0.999048, 0.0436174, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192310, 571, 1, 1, 5271.8, 2704.87, 445.183, -3.13286, 0, 0, -0.99999, 0.00436634, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192314, 571, 1, 1, 5236.27, 2739.46, 444.992, -1.59698, 0, 0, -0.716303, 0.697789, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192487, 571, 1, 1, 5163.78, 2729.68, 432.009, -1.58825, 0, 0, -0.713251, 0.700909, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192308, 571, 1, 1, 5237.07, 2757.03, 435.796, 1.51844, 0, 0, 0.688356, 0.725373, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192309, 571, 1, 1, 5235.34, 2924.34, 435.04, -1.5708, 0, 0, -0.707108, 0.707106, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192487, 571, 1, 1, 5262.54, 3047.95, 430.979, 3.10665, 0, 0, 0.999847, 0.0174704, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192487, 571, 1, 1, 5163.13, 2952.59, 433.503, 1.53589, 0, 0, 0.694658, 0.71934, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192324, 571, 1, 1, 5235.19, 2942, 443.948, 1.58825, 0, 0, 0.713251, 0.700909, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192326, 571, 1, 1, 5272.73, 2976.55, 443.81, 3.12412, 0, 0, 0.999962, 0.00873622, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192312, 571, 1, 1, 5352.37, 3037.09, 435.252, -1.5708, 0, 0, -0.707108, 0.707106, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192325, 571, 1, 1, 5290.35, 2976.56, 435.221, 0.017452, 0, 0, 0.00872589, 0.999962, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192304, 571, 1, 385, 5397.76, 2873.08, 455.321, 3.10665, 0, 0, 0.999847, 0.0174704, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 187433, 571, 1, 1, 2832.84, 6184.45, 84.6827, -2.58308, 0, 0, 0, 0, 300, 100, 1);
INSERT INTO `gameobject` VALUES (NULL, 187433, 571, 1, 1, 2835.96, 6180.37, 84.6827, 1.50098, 0, 0, 0, 0, 180, 100, 1);
INSERT INTO `gameobject` VALUES (NULL, 187433, 571, 1, 1, 2830.12, 6188.96, 84.6827, -0.855211, 0, 0, 0, 0, 300, 100, 1);
INSERT INTO `gameobject` VALUES (NULL, 187433, 571, 1, 1, 2831.88, 6188.72, 84.6827, -1.65806, 0, 0, 0, 0, 300, 100, 1);
INSERT INTO `gameobject` VALUES (NULL, 193984, 571, 1, 1, 7647.47, 2055.55, 599.399, -0.279252, 0, 0, 0, 0, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 193984, 571, 1, 1, 7647.42, 2065.23, 599.308, 0.279252, 0, 0, 0, 0, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 193984, 571, 1, 1, 7609.86, 2055.53, 599.494, -2.86234, 0, 0, 0, 0, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 193984, 571, 1, 1, 7610.18, 2065.31, 599.426, 2.87979, 0, 0, 0, 0, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 193983, 571, 1, 1, 7906.95, 2053.04, 599.626, -0.296705, 0, 0, 0, 0, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 193983, 571, 1, 1, 7907.01, 2063.02, 599.587, 0.261798, 0, 0, 0, 0, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 193983, 571, 1, 1, 7870.43, 2053.35, 599.669, -2.87979, 0, 0, 0, 0, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 193983, 571, 1, 1, 7870.36, 2063.25, 599.628, 2.86234, 0, 0, 0, 0, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192377, 571, 1, 1, 5414.19, 3069.8, 415.187, 1.64061, 0, 0, 0, 0, 5, 100, 1);
INSERT INTO `gameobject` VALUES (NULL, 192321, 571, 1, 385, 5288.85, 2861.82, 435.591, 0.026179, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192318, 571, 1, 385, 5322.25, 2898.95, 435.643, -1.57952, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192322, 571, 1, 385, 5322.89, 2917.14, 445.154, 1.56207, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192320, 571, 1, 385, 5289.05, 2820.23, 435.674, 0, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192269, 571, 1, 1, 4526.46, 2810.18, 391.2, -2.99322, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192273, 571, 1, 1, 4417.94, 2324.81, 371.577, 3.08051, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192274, 571, 1, 1, 4424.15, 3286.54, 371.546, 3.12412, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192277, 571, 1, 1, 4572.93, 3475.52, 363.009, 1.42244, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192278, 571, 1, 1, 4433.9, 3534.14, 360.275, -1.85005, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192280, 571, 1, 1, 4857.97, 3335.44, 368.881, -2.94959, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192283, 571, 1, 1, 5006.34, 3280.4, 371.163, 2.22529, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192284, 571, 1, 65, 5372.48, 2862.5, 409.049, 3.14159, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192285, 571, 1, 65, 5371.49, 2820.8, 409.177, 3.14159, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192289, 571, 1, 1, 4778.19, 2438.06, 345.644, -2.94088, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192290, 571, 1, 1, 5024.57, 2532.75, 344.023, -1.93732, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192336, 571, 1, 1, 5154.49, 2862.15, 445.012, 3.14159, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192338, 571, 1, 65, 5397.76, 2873.08, 455.461, 3.10665, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192339, 571, 1, 65, 5397.39, 2809.33, 455.344, 3.10665, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192349, 571, 1, 1, 5155.31, 2820.74, 444.979, -3.13286, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192350, 571, 1, 1, 5270.69, 2861.78, 445.058, -3.11539, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192351, 571, 1, 1, 5271.28, 2820.16, 445.201, -3.13286, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192352, 571, 1, 1, 5173.02, 2820.93, 435.72, 0.017452, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192353, 571, 1, 1, 5172.11, 2862.57, 435.721, 0.017452, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192354, 571, 1, 1, 5288.41, 2861.79, 435.721, 0.017452, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192355, 571, 1, 1, 5288.92, 2820.22, 435.721, 0.017452, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192356, 571, 1, 1, 5237.07, 2757.03, 435.796, 1.51844, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192357, 571, 1, 1, 5235.34, 2924.34, 435.04, -1.5708, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192358, 571, 1, 65, 5322.23, 2899.43, 435.808, -1.58825, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192359, 571, 1, 65, 5364.35, 2899.4, 435.839, -1.5708, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192360, 571, 1, 65, 5352.37, 3037.09, 435.252, -1.5708, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192361, 571, 1, 65, 5392.65, 3037.11, 433.713, -1.52716, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192362, 571, 1, 65, 5322.12, 2763.61, 444.974, -1.55334, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192363, 571, 1, 65, 5363.61, 2763.39, 445.024, -1.54462, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192364, 571, 1, 1, 5350.88, 2622.72, 444.686, -1.5708, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192366, 571, 1, 1, 5236.27, 2739.46, 444.992, -1.59698, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192367, 571, 1, 1, 5271.8, 2704.87, 445.183, -3.13286, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192368, 571, 1, 65, 5289.46, 2704.68, 435.875, -0.017451, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192369, 571, 1, 1, 5350.95, 2640.36, 435.408, 1.5708, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192370, 571, 1, 1, 5392.27, 2639.74, 435.331, 1.50971, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192371, 571, 1, 65, 5364.29, 2916.94, 445.331, 1.57952, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192372, 571, 1, 65, 5322.86, 2916.95, 445.154, 1.56207, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192373, 571, 1, 1, 5290.35, 2976.56, 435.221, 0.017452, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192374, 571, 1, 1, 5272.94, 2976.55, 444.492, 3.12412, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192375, 571, 1, 1, 5235.19, 2941.9, 444.278, 1.58825, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192378, 571, 1, 65, 5322.02, 2781.13, 435.811, 1.5708, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192379, 571, 1, 65, 5363.42, 2781.03, 435.763, 1.5708, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192406, 571, 1, 1, 4438.3, 3361.08, 371.568, -0.017451, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192407, 571, 1, 1, 4448.17, 3235.63, 370.412, -1.56207, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192414, 571, 1, 1, 4387.62, 2719.57, 389.935, -1.54462, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192416, 571, 1, 1, 4408.57, 2422.61, 377.179, 1.58825, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192417, 571, 1, 1, 4416.59, 2414.08, 377.196, 0, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192418, 571, 1, 1, 4417.25, 2301.14, 377.214, 0.026179, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192429, 571, 1, 1, 4464.12, 2855.45, 406.111, 0.829032, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192433, 571, 1, 1, 4401.63, 3377.46, 363.365, 1.55334, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192434, 571, 1, 1, 5041.61, 3294.4, 382.15, -1.63188, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192435, 571, 1, 1, 4855.63, 3297.62, 376.739, -3.13286, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192458, 571, 1, 1, 4811.4, 2441.9, 358.207, -2.0333, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192459, 571, 1, 1, 4805.67, 2407.48, 358.191, 1.78023, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192460, 571, 1, 1, 5004.35, 2486.36, 358.449, 2.17294, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192461, 571, 1, 1, 4983.28, 2503.09, 358.177, -0.427603, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192488, 571, 1, 1, 5160.34, 2798.61, 430.769, 3.14159, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192488, 571, 1, 1, 5158.81, 2883.13, 431.618, 3.14159, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192488, 571, 1, 1, 5278.38, 2613.83, 433.409, -1.58825, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192488, 571, 1, 1, 5260.82, 2631.8, 433.324, 3.05433, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192488, 571, 1, 1, 5163.13, 2952.59, 433.503, 1.53589, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192488, 571, 1, 1, 5145.11, 2935, 433.386, 3.14159, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192488, 571, 1, 1, 5262.54, 3047.95, 432.055, 3.10665, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192488, 571, 1, 1, 5146.04, 2747.21, 433.584, 3.07177, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192488, 571, 1, 1, 5163.78, 2729.68, 433.394, -1.58825, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192501, 571, 1, 1, 4398.82, 2804.7, 429.792, -1.58825, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192501, 571, 1, 1, 4416, 2822.67, 429.851, -0.017452, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192501, 571, 1, 1, 4559.11, 3606.22, 419.999, -1.48353, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192501, 571, 1, 1, 4539.42, 3622.49, 420.034, -3.07177, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192501, 571, 1, 1, 4555.26, 3641.65, 419.974, 1.67551, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192501, 571, 1, 1, 4574.87, 3625.91, 420.079, 0.087266, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192501, 571, 1, 1, 4466.79, 1960.42, 459.144, 1.15192, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192501, 571, 1, 1, 4475.35, 1937.03, 459.07, -0.436332, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192501, 571, 1, 1, 4451.76, 1928.1, 459.076, -2.00713, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192501, 571, 1, 1, 4442.99, 1951.9, 459.093, 2.74016, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192254, 571, 1, 1, 5154.46, 2828.94, 409.189, 3.14159, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192255, 571, 1, 1, 5154.52, 2853.31, 409.183, 3.14159, 0, 0, 0, 1, 180, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192688, 571, 1, 1, 5916.1, 566.209, 639.625, -2.72271, 0, 0, 0, 1, 180, 100, 1);
INSERT INTO `gameobject` VALUES (NULL, 192686, 571, 1, 1, 5664.81, 791.002, 653.698, -0.663223, 0, 0, 0, 1, 180, 100, 1);
INSERT INTO `gameobject` VALUES (NULL, 180398, 571, 1, 1, 5665.02, 790.2, 653.698, -0.610864, 0, 0, 0, 1, 180, 100, 1);
INSERT INTO `gameobject` VALUES (NULL, 192487, 571, 1, 256, 4855.63, 3297.62, 376.281, -3.13286, 0, 0, -0.99999, 0.00436634, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192290, 571, 1, 256, 4526.46, 2810.18, 391.2, -2.99322, 0, 0, -0.997249, 0.0741182, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192487, 571, 1, 256, 4517.75, 2717.23, 387.812, -1.53589, 0, 0, -0.694658, 0.71934, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192488, 571, 1, 256, 4475.35, 1937.03, 459.07, -0.436332, 0, 0, -0.216439, 0.976296, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192488, 571, 1, 256, 4451.76, 1928.1, 459.076, -2.00713, 0, 0, -0.843392, 0.537299, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192488, 571, 1, 256, 4442.99, 1951.9, 459.093, 2.74016, 0, 0, 0.979924, 0.199371, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192488, 571, 1, 256, 4466.8, 1960.44, 459.841, 1.15192, 0, 0, 0.54464, 0.83867, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192487, 571, 1, 256, 5041.61, 3294.4, 382.15, -1.63188, 0, 0, -0.72837, 0.685184, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192278, 571, 1, 256, 5006.34, 3280.4, 371.163, 2.22529, 0, 0, 0.896872, 0.442291, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192278, 571, 1, 256, 4857.97, 3335.44, 368.881, -2.94959, 0, 0, -0.995395, 0.0958539, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192290, 571, 1, 256, 4433.9, 3534.14, 360.275, -1.85005, 0, 0, -0.798636, 0.601815, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192290, 571, 1, 256, 4572.93, 3475.52, 363.009, 1.42244, 0, 0, 0.652758, 0.757566, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192488, 571, 1, 256, 4555.26, 3641.65, 419.974, 1.67551, 0, 0, 0.743143, 0.669133, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192488, 571, 1, 256, 4574.87, 3625.91, 420.079, 0.087266, 0, 0, 0.0436192, 0.999048, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192488, 571, 1, 256, 4559.11, 3606.22, 419.999, -1.48353, 0, 0, -0.67559, 0.737277, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192488, 571, 1, 256, 4539.42, 3622.49, 420.034, -3.07177, 0, 0, -0.999391, 0.0349043, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192290, 571, 1, 256, 4401.63, 3377.46, 363.365, 1.55334, 0, 0, 0.700908, 0.713252, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192488, 571, 1, 256, 4448.17, 3235.63, 370.412, -1.56207, 0, 0, -0.704015, 0.710185, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192488, 571, 1, 256, 4438.3, 3361.08, 371.299, -0.017451, 0, 0, -0.00872539, 0.999962, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192290, 571, 1, 256, 4424.15, 3286.54, 371.546, 3.12412, 0, 0, 0.999962, 0.00873622, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192461, 571, 1, 1, 4416.03, 2822.68, 430.475, -0.017452, 0, 0, -0.00872589, 0.999962, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192461, 571, 1, 1, 4464.12, 2855.45, 406.111, 0.829032, 0, 0, 0.402747, 0.915311, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192461, 571, 1, 1, 4398.82, 2804.7, 429.792, -1.58825, 0, 0, -0.713251, 0.700909, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192461, 571, 1, 1, 4408.57, 2422.61, 377.179, 1.58825, 0, 0, 0.713251, 0.700909, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192461, 571, 1, 1, 4416.59, 2414.08, 377.13, 0, 0, 0, 0, 1, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192461, 571, 1, 1, 4417.25, 2301.14, 377.214, 0.026179, 0, 0, 0.0130891, 0.999914, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192418, 571, 1, 1, 4805.67, 2407.48, 358.191, 1.78023, 0, 0, 0.777144, 0.629323, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192418, 571, 1, 1, 4811.4, 2441.9, 358.207, -2.0333, 0, 0, -0.85035, 0.526218, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192273, 571, 1, 1, 4778.19, 2438.06, 345.644, -2.94088, 0, 0, -0.994969, 0.100188, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192273, 571, 1, 1, 5024.57, 2532.75, 344.023, -1.93732, 0, 0, -0.824127, 0.566404, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192418, 571, 1, 1, 5004.35, 2486.36, 358.449, 2.17294, 0, 0, 0.884989, 0.465612, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192418, 571, 1, 1, 4983.28, 2503.09, 358.177, -0.427603, 0, 0, -0.212176, 0.977231, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 192290, 571, 1, 1, 4417.94, 2324.81, 371.577, 3.08051, 0, 0, 0.999534, 0.0305366, 300, 0, 1);
INSERT INTO `gameobject` VALUES (NULL, 193764, 571, 1, 1, 7625.87, 2060.05, 604.27, 0.07854, 0, 0, 0.99999, 0.004363, 180, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 193762, 571, 1, 1, 7625.66, 2060.04, 604.195, -3.05428, 0, 0, 0.99999, 0.004363, 180, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192319, 571, 1, 385, 5364.3, 2899.22, 435.691, -1.55334, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192287, 571, 1, 385, 5372.42, 2862.48, 409.366, 3.14159, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192323, 571, 1, 385, 5364.28, 2917.26, 445.332, 1.58825, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192305, 571, 1, 385, 5397.31, 2809.26, 455.102, 3.13286, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192286, 571, 1, 385, 5371.45, 2820.79, 409.427, 3.12412, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192334, 571, 1, 385, 5322.17, 2763.2, 444.974, -1.56207, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192307, 571, 1, 385, 5271.16, 2820.11, 445.109, -3.13286, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192306, 571, 1, 385, 5270.56, 2861.68, 444.917, -3.12412, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192487, 571, 1, 385, 5160.28, 2798.6, 430.604, -3.12412, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192487, 571, 1, 385, 5146.04, 2747.3, 433.527, 3.12412, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192328, 571, 1, 385, 5173.13, 2820.96, 435.658, 0.026179, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192252, 571, 1, 385, 5154.37, 2853.23, 409.183, 3.14159, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192253, 571, 1, 385, 5154.42, 2828.93, 409.189, 3.14159, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192292, 571, 1, 385, 5154.35, 2862.08, 445.01, 3.14159, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192299, 571, 1, 385, 5155.22, 2820.63, 444.979, -3.11539, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192327, 571, 1, 385, 5172.34, 2862.57, 435.658, 0, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192487, 571, 1, 385, 5158.71, 2882.9, 431.274, 3.14159, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192487, 571, 1, 385, 5145.11, 2934.95, 433.255, -3.10665, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192267, 571, 1, 385, 4452.76, 2639.14, 358.444, 1.67552, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192449, 571, 1, 385, 4517.75, 2717.23, 387.812, -1.53589, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (NULL, 192450, 571, 1, 385, 4387.59, 2719.9, 390.201, -1.51843, 0, 0, 0, 1, 300, 255, 1);

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5164, 2723.62, 439.844, 4.73907, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5255.01, 2631.98, 439.755, 3.15257, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5278.21, 2607.23, 439.755, 4.71944, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5390.95, 2615.5, 421.126, 4.6409, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5350.87, 2616.03, 421.243, 4.72729, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5265.02, 2704.63, 421.7, 3.12507, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5236.2, 2732.68, 421.649, 4.72336, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5363.78, 2756.77, 421.629, 4.78226, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5322.16, 2756.69, 421.646, 4.69978, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5264.68, 2819.78, 421.656, 3.15645, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5264.04, 2861.34, 421.587, 3.21142, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5363.82, 2923.87, 421.709, 1.60527, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5323.05, 2923.7, 421.645, 1.5817, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5234.86, 2948.8, 420.88, 1.61311, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5266.75, 2976.5, 421.067, 3.20354, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5391.19, 3060.8, 419.616, 1.69557, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5280.9, 3071.32, 438.499, 1.62879, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5255.88, 3047.63, 438.499, 3.13677, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5139.69, 2747.4, 439.844, 3.17221, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5148.8, 2820.24, 421.621, 3.16043, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5147.98, 2861.93, 421.63, 3.18792, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5138.59, 2935.16, 439.845, 3.11723, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (0, 28366, 571, 1, 1, 0, 0, 5163.06, 2959.52, 439.846, 1.47258, 600, 0, 0, 50000, 0, 0, 0, 0, 0);
UPDATE `creature_template` SET `unit_flags`=16384 WHERE `entry`=28366;
DELETE FROM `disables` WHERE `sourceType` = 0 AND `entry` IN (23397, 23398);
INSERT INTO `disables` VALUES
    (0, 23397, 3, '', '', 'CURRENTLY A SOURCE OF BUG ABUSE - Allows Warriors to stack Berserker Stance passive auras indefinitely and for use in all stances'),
    (0, 23398, 3, '', '', 'CURRENTLY A SOURCE OF BUG ABUSE - Allows Druids to stack Cat Form passive auras indefinitely and for use in all stances');
-- Fix Paladin Righteous Defense spell
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pal_righteous_defense';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(31789,'spell_pal_righteous_defense');-- ICC

-- BOSS FESTERGUT
-- Fix spell http://www.wowhead.com/spell=71160
DELETE FROM `spell_script_names` WHERE `spell_id` IN (71160,71161);
INSERT INTO `spell_script_names` VALUES 
(71160,'spell_stinky_plague_stench'),
(71161,'spell_stinky_plague_stench');
-- Eilo (https://github.com/eilo)
-- Query base para busquedas de las id en todas las dificultades de los npcs o bosses:
-- SELECT  `entry` ,  `difficulty_entry_1` ,  `difficulty_entry_2` ,  `difficulty_entry_3` FROM  `creature_template` WHERE  `entry`IN ( 37697,37562)

-- Immunidades menos bleed y enrage
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN 
(35144,35511,35512,35513,  -- Acidmaw
 34799,35514,35515,35516,  -- Dreadscale
 34797,35447,35558,35449,  -- Icehowl
 34813,35265,35266,35267,  -- Infernal Volcano
 34825,35278,35279,35280,  -- Nether Portal
 34497,35350,35351,35352,  -- Fjola Lightbane
 34496,35347,35348,35349,  -- Eydis Darkbane
 34564,34566,35615,35616); -- Anubarak

-- Inmunidades menos bleed disarm y enrage
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN 
(34796,35438,35439,35440); -- Gormok

-- Immunidades menos bleed interrupt y enrage
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|1048576|4194304|8388608|67108864|536870912 WHERE `entry` IN 
(34780,35216,35268,35269); -- Jaraxxus
DELETE FROM spell_script_names WHERE spell_id IN (-54049,54049,54050,54051,54052,54053);
INSERT INTO spell_script_names (spell_id, ScriptName) VALUES (-54049, 'spell_warl_shadow_bite');-- Eilo (https://github.com/eilo)
-- Query base para busquedas de las id en todas las dificultades de los npcs o bosses:
-- SELECT  `entry` ,  `difficulty_entry_1` ,  `difficulty_entry_2` ,  `difficulty_entry_3` FROM  `creature_template` WHERE  `entry`IN ( 37697,37562)

-- Inmunidades adicionales a los bosses de icc por DB
-- marrowgar
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (36612,37957,37958,37959);
-- lady
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|1048576|4194304|8388608|67108864|536870912 WHERE `entry` IN (36855,38106,38926,38297);
-- saurfang
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (37813,38402,38582,38583);
-- valkyrs de la espiral
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (37098,38418);
-- stinky
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (37025,38064);
-- precious
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (37217,38103);
-- festergut
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (36626,37504,37505,37506);
-- rotface
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (36627,38390,38549,38550);
-- putricidio
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (36678,38431,38585,38586);
-- valanar
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (37970,38401,38784,38785);
-- keleseth
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (37972,38399,38769,38770);
-- taldaram
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (37973,38400,38771,38772);
-- lanathel
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (37955,38434,38435,38436);
-- sindragosa
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (36853,38265,38266,38267);
-- rimefang
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (37533,38220);
-- spinestalker
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (37534,38219);
-- lichking
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (36597,39166,39167,39168);-- Eilo (https://github.com/eilo)
-- ICC trash mob
-- Corrigiendo ara�as para que se las pueda pegar
-- Nerubar Broodkeeper http://old.wowhead.com/npc=36725

-- Las dos primeras del medio
UPDATE `creature` SET `position_z` = 35.24 WHERE `guid`=201170;
UPDATE `creature` SET `position_z` = 35.24 WHERE `guid`=201106;

-- Las dos siguientes, osea arriba de las gradas
UPDATE `creature` SET `position_z` = 44.57 WHERE `guid`=200949;
UPDATE `creature` SET `position_z` = 44.57 WHERE `guid`=200956;

-- Las dos siguientes, llegando a marrowgar
UPDATE `creature` SET `position_z` = 42.1 WHERE `guid`=200912;
UPDATE `creature` SET `position_z` = 42.1 WHERE `guid`=200934;

-- Icc adds putricidio
-- Ajuste de velocidades para babosas de putricidio, amenorada la velocidad
-- Originalmente speed_walk=2
UPDATE `creature_template` SET `speed_walk`=0.68 WHERE `entry` IN (37697,38604,38758,38759);
-- Inmunidades de las babosas de putricidio
-- Babosas de putricidio Volatile Ooze(37697)
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|4194304|8388608|33554432|536870912 WHERE `entry` IN (37697,38604,38758,38759,37562,38602,38760,38761);

-- Icc triggers de Rotface
-- Eliminado algunos Puddle Stalker(37013) que hacen que salga en el aire los charcos
DELETE FROM `creature` WHERE `guid`=201602;
DELETE FROM `creature` WHERE `guid`=201332;
DELETE FROM `creature` WHERE `guid`=201651;
DELETE FROM `creature` WHERE `guid`=201494;
DELETE FROM `creature` WHERE `guid`=201600;
DELETE FROM `creature` WHERE `guid`=201648;
DELETE FROM `creature` WHERE `guid`=201441;
DELETE FROM `creature` WHERE `guid`=200922;

-- Icc adds Lich King
-- Valkyrs de lich king(36609)
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|8|16|32|64|128|256|512|4096|8192|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (36609,39120,39121,39122);
-- Eilo (https://github.com/eilo)
-- Trashmobs icc 
-- En desarrollo ReanEmu https://github.com/ComunidadRean/ReanEmu
-- Datos base por overy, kayserzero y wowhead.com
-- Final por Eilo http://twitter.com/eilo2518/

-- Trash inicial Martillo de Luz http://www.youtube.com/watch?v=zcSKxoA8eC8
-- Trash de Caminasue�os http://www.youtube.com/watch?v=dYXY7QsAI98
-- Trash de Consejo de Sangre http://www.youtube.com/watch?v=-y1jiiaUfC8

-- Scriptnames y ajustes:

/*-----Trash de Martillo de la Luz-----*/
-- Aqui se les sube el da�o tambien para que no puedan farmear en solo
UPDATE `creature_template` SET `ScriptName` = 'npc_ancient_skeletal_soldier_icc' WHERE `entry` =37012;
UPDATE `creature_template` SET `dmg_multiplier` = '10' WHERE `entry` =37012;
UPDATE `creature_template` SET `ScriptName` = 'npc_ancient_skeletal_soldier_icc' WHERE `entry` =38059;
UPDATE `creature_template` SET `dmg_multiplier` = '17.5' WHERE `entry` =38059;
UPDATE `creature_template` SET `ScriptName` = 'npc_deathbound_ward_icc' WHERE `entry` =37007;
UPDATE `creature_template` SET `mindmg` = '1100',`maxdmg` = '1300' WHERE `entry` =37007;
UPDATE `creature_template` SET `ScriptName` = 'npc_deathbound_ward_icc' WHERE `entry` =38031;
UPDATE `creature_template` SET `mindmg` = '1100',`maxdmg` = '1200' WHERE `entry` =38031;
UPDATE `creature_template` SET `ScriptName` = 'npc_servant_of_the_throne_icc' WHERE `entry` =36724;
UPDATE `creature_template` SET `dmg_multiplier` = '10.5' WHERE `entry` =36724;
UPDATE `creature_template` SET `ScriptName` = 'npc_servant_of_the_throne_icc' WHERE `entry` =38057;
UPDATE `creature_template` SET `dmg_multiplier` = '19' WHERE `entry` =38057;
-- UPDATE `creature_template` SET `ScriptName` = 'npc_the_damned_icc' WHERE `entry` =37011;
UPDATE `creature_template` SET `dmg_multiplier` = '10' WHERE `entry` =37011;
-- UPDATE `creature_template` SET `ScriptName` = 'npc_the_damned_icc' WHERE `entry` =38061;
UPDATE `creature_template` SET `dmg_multiplier` = '16' WHERE `entry` =38061;
UPDATE `creature_template` SET `ScriptName` = 'npc_nerubar_broodkeeper_icc' WHERE `entry` =36725;
UPDATE `creature_template` SET `dmg_multiplier` = '11.2' WHERE `entry` =36725;
UPDATE `creature_template` SET `ScriptName` = 'npc_nerubar_broodkeeper_icc' WHERE `entry` =38058;
UPDATE `creature_template` SET `dmg_multiplier` = '14.7' WHERE `entry` =38058;

/*--Trash de Oratorio de los Malditos--*/
UPDATE `creature_template` SET `ScriptName` = 'npc_deathspeaker_servant_10man_icc' WHERE `entry`=36805;
UPDATE `creature_template` SET `ScriptName` = 'npc_deathspeaker_servant_25man_icc' WHERE `entry`=38075;
UPDATE `creature_template` SET `ScriptName` = 'npc_deathspeaker_disciple_10man_icc' WHERE `entry`=36807;
UPDATE `creature_template` SET `ScriptName` = 'npc_deathspeaker_disciple_25man_icc' WHERE `entry`=38073;
UPDATE `creature_template` SET `ScriptName` = 'npc_deathspeaker_zealot_icc' WHERE `entry`=36808;
UPDATE `creature_template` SET `ScriptName` = 'npc_deathspeaker_zealot_icc' WHERE `entry`=38076;
UPDATE `creature_template` SET `ScriptName` = 'npc_deathspeaker_attendant_10man_icc' WHERE `entry`=36811;
UPDATE `creature_template` SET `ScriptName` = 'npc_deathspeaker_attendant_25man_icc' WHERE `entry`=38072;
UPDATE `creature_template` SET `ScriptName` = 'npc_deathspeaker_high_priest_icc' WHERE `entry`=36829;
UPDATE `creature_template` SET `ScriptName` = 'npc_deathspeaker_high_priest_icc' WHERE `entry`=38074;

/*---------Trash de La Espiral---------*/
UPDATE `creature_template` SET `ScriptName` = 'npc_valkyr_herald_10man_icc' WHERE `entry`=37098;
UPDATE `creature_template` SET `ScriptName` = 'npc_valkyr_herald_25man_icc' WHERE `entry`=38418;

/*----Trash de Talleres de la Peste----*/
UPDATE `creature_template` SET `ScriptName` = 'npc_blighted_abomination_icc' WHERE `entry`=37022;
UPDATE `creature_template` SET `ScriptName` = 'npc_blighted_abomination_icc' WHERE `entry`=38108;
UPDATE `creature_template` SET `ScriptName` = 'npc_vengeful_fleshreapert_icc' WHERE `entry`=37038;
UPDATE `creature_template` SET `ScriptName` = 'npc_vengeful_fleshreapert_icc' WHERE `entry`=38063;
UPDATE `creature_template` SET `ScriptName` = 'npc_plague_scientist_icc' WHERE `entry`=37023;
UPDATE `creature_template` SET `ScriptName` = 'npc_plague_scientist_icc' WHERE `entry`=38062;
UPDATE `creature_template` SET `ScriptName` = 'npc_pustulating_horror_10man_icc' WHERE `entry`=10404;
UPDATE `creature_template` SET `ScriptName` = 'npc_pustulating_horror_25man_icc' WHERE `entry`=38110;
UPDATE `creature_template` SET `ScriptName` = 'npc_decaying_colossus_10man_icc' WHERE `entry`=36880;
UPDATE `creature_template` SET `ScriptName` = 'npc_decaying_colossus_25man_icc' WHERE `entry`=37655;

/*--------Trash de Salas Carmesi--------*/
UPDATE `creature_template` SET `ScriptName` = 'npc_darkfallen_archmage_10man_icc' WHERE `entry`=37664;
UPDATE `creature_template` SET `ScriptName` = 'npc_darkfallen_archmage_25man_icc' WHERE `entry`=38099;
UPDATE `creature_template` SET `ScriptName` = 'npc_darkfallen_blood_knight_icc' WHERE `entry`=37595;
UPDATE `creature_template` SET `ScriptName` = 'npc_darkfallen_blood_knight_icc' WHERE `entry`=38100;
UPDATE `creature_template` SET `ScriptName` = 'npc_darkfallen_noble_10man_icc' WHERE `entry`=37663;
UPDATE `creature_template` SET `ScriptName` = 'npc_darkfallen_noble_25man_icc' WHERE `entry`=38480;
UPDATE `creature_template` SET `ScriptName` = 'npc_vampiric_fiend_icc' WHERE `entry`=37901;
UPDATE `creature_template` SET `ScriptName` = 'npc_darkfallen_advisor_10man_icc' WHERE `entry`=37571;
UPDATE `creature_template` SET `ScriptName` = 'npc_darkfallen_advisor_25man_icc' WHERE `entry`=38098;
UPDATE `creature_template` SET `ScriptName` = 'npc_darkfallen_commander_10man_icc' WHERE `entry`=37662;
UPDATE `creature_template` SET `ScriptName` = 'npc_darkfallen_commander_25man_icc' WHERE `entry`=38102;
UPDATE `creature_template` SET `ScriptName` = 'npc_darkfallen_lieutenant_10man_icc' WHERE `entry`=37665;
UPDATE `creature_template` SET `ScriptName` = 'npc_darkfallen_lieutenant_25man_icc' WHERE `entry`=38101;
UPDATE `creature_template` SET `ScriptName` = 'npc_darkfallen_tactician_icc' WHERE `entry`=37666;
UPDATE `creature_template` SET `ScriptName` = 'npc_darkfallen_tactician_icc' WHERE `entry`=38479;

/*---Trash de Camaras de Alaescarcha---*/
UPDATE `creature_template` SET `ScriptName` = 'npc_ymirjar_deathbringer_10man_icc' WHERE `entry`=38125;
UPDATE `creature_template` SET `ScriptName` = 'npc_ymirjar_deathbringer_25man_icc' WHERE `entry`=38130;
-- UPDATE `creature_template` SET `ScriptName` = 'npc_ymirjar_frostbinder_icc' WHERE `entry`=37127;
-- UPDATE `creature_template` SET `ScriptName` = 'npc_ymirjar_frostbinder_icc' WHERE `entry`=38126;
UPDATE `creature_template` SET `ScriptName` = 'npc_ymirjar_battlemaiden_icc' WHERE `entry`=37132;
UPDATE `creature_template` SET `ScriptName` = 'npc_ymirjar_battlemaiden_icc' WHERE `entry`=38132;
UPDATE `creature_template` SET `ScriptName` = 'npc_ymirjar_huntress_icc' WHERE `entry`=37134;
UPDATE `creature_template` SET `ScriptName` = 'npc_ymirjar_huntress_icc' WHERE `entry`=38134;
UPDATE `creature_template` SET `ScriptName` = 'npc_ymirjar_warlord_icc' WHERE `entry`=37133;
UPDATE `creature_template` SET `ScriptName` = 'npc_ymirjar_warlord_icc' WHERE `entry`=38133;

-- Eilo (https://github.com/eilo)
-- Inmunidades del trash de icc:
-- ancient skeletal soldier
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37012,38059);
-- deathbound ward
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37007,38031);
-- servant of the throne
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (36724,38057);
-- the damned
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37011,38061);
-- nerubar broodkeeper
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (36725,38058);
-- deathspeaker servant
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (36805,38075);
-- deathspeaker disciple
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (36807,38073);
-- deathspeaker zealot
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (36808,38076);
-- deathspeaker attendant
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (36811,38072);
-- deathspeaker high priest
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (36829,38074);
-- blighted abomination
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37022,38108);
-- vengeful fleshreapert
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37038,38063);
-- plague scientist
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37023,38062);
-- pustulating horror
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (10404,38110);
-- decaying colossus
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (36880,37655);
-- darkfallen archmage
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37664,38099);
-- darkfallen blood knight
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37595,38100);
-- darkfallen noble
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37663,38480);
-- vampiric fiend
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry`=37901;
-- darkfallen advisor
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37571,38098);
-- darkfallen commander
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37662,38102);
-- darkfallen lieutenant
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37665,38101);
-- darkfallen tactician
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37666,38479);
-- ymirjar deathbringer
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (38125,38130);
-- ymirjar frostbinder
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry` IN (37127,38126);
-- ymirjar battlemaiden
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry`=38132;
-- ymirjar huntress
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry`=38134;
-- ymirjar warlord
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|4|8|16|128|512|1024|65536|131072|524288|1048576|4194304|8388608|33554432|67108864|134217728 WHERE `entry`=38133;
-- Query para visualizar los valores:
-- SELECT `entry`,`name`,`mindmg`,`maxdmg`,`dmg_multiplier` FROM `creature_template` WHERE entry=36612;

-- Icc actualizacion de Da�o de bosses
-- Eilo (https://github.com/eilo)

-- Lord Marrowgar -- Este divide el da�o entre los tankes asi que estara bien
-- 10n min=45.8k max=51.3k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '30' WHERE `entry` =36612;
-- 10H min=50.3k max=56.4k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '33' WHERE `entry` =37957;
-- 25n min=56.5k max=63.3k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '37' WHERE `entry` =37958;
-- 25H min=61k max=68.4k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '40' WHERE `entry` =37959;


-- Lady Deathwhisper
-- 10n min=20.5k max=23.5k
UPDATE `creature_template` SET  `mindmg` =  '1110',`maxdmg` =  '1271',`dmg_multiplier` =  '18.5' WHERE `entry` =36855;
-- 10H min=22.7k max=26k
UPDATE `creature_template` SET  `mindmg` =  '1110',`maxdmg` =  '1271',`dmg_multiplier` =  '20.5' WHERE `entry` =38106;
-- 25n min=26k max=29,8k
UPDATE `creature_template` SET  `mindmg` =  '1110',`maxdmg` =  '1271',`dmg_multiplier` =  '23.5' WHERE `entry` =38296;
-- 25H min=26k max=32.4k
UPDATE `creature_template` SET  `mindmg` =  '1110',`maxdmg` =  '1271',`dmg_multiplier` =  '25.5' WHERE `entry` =38297;


-- Deathbringer
-- 10n min=35.1k max=39.3k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '23' WHERE `entry` =37813;
-- 10H min=38.1k max=42.7k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '25' WHERE `entry` =38402;
-- 25n min=44.2k max=49.5k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '29' WHERE `entry` =38582;
-- 25H min=47.3k max=53k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '31' WHERE `entry` =38583;


-- Festergut
-- 10n min=32k max=35.9k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '21' WHERE `entry` =36626;
-- 10H min=35.1k max=39.3k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '23' WHERE `entry` =37505;
-- 25n min=41.2k max=46.1k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '27' WHERE `entry` =38582;
-- 25H min=44.2k max=49.6k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '29' WHERE `entry` =37506;


-- Rotface
-- 10n min=35.1k max=39.3k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '23' WHERE `entry` =36627;
-- 10H min=38.1k max=42.7k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '25' WHERE `entry` =38390;
-- 25n min=44.2k max=49.5k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '29' WHERE `entry` =38549;
-- 25H min=47.3k max=53k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '31' WHERE `entry` =38550;


-- Profesor Putricidio
-- 10n min=39.7k max=44.4k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '26' WHERE `entry` =36678;
-- 10H min=42.7k max=47.8k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '28' WHERE `entry` =38431;
-- 25n min=47.3k max=53k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '31' WHERE `entry` =38585;
-- 25H min=50.3k max=56.4k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '33' WHERE `entry` =38586;


-- Valanar
-- 10n min=22.9k max=25.6k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '15' WHERE `entry` =37970;
-- 10H min=26.9k max=29k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '17' WHERE `entry` =38401;
-- 25n min=30.5k max=34.2k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '20' WHERE `entry` =38784;
-- 25H min=33.6k max=37.6k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '22' WHERE `entry` =38785;

-- Keleseth
-- 10n min=22.9k max=25.6k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '15' WHERE `entry` =37972;
-- 10H min=26.9k max=29k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '17' WHERE `entry` =38399;
-- 25n min=30.5k max=34.2k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '20' WHERE `entry` =38769;
-- 25H min=33.6k max=37.6k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '22' WHERE `entry` =38770;

-- Taldaram
-- 10n min=22.9k max=25.6k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '15' WHERE `entry` =37973;
-- 10H min=26.9k max=29k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '17' WHERE `entry` =38400;
-- 25n min=30.5k max=34.2k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '20' WHERE `entry` =38771;
-- 25H min=33.6k max=37.6k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '22' WHERE `entry` =38772;


-- Blood Queen Lanathel
-- 10n min=35.1k max=39.3k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '23' WHERE `entry` =37955;
-- 10H min=38.1k max=42.7k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '25' WHERE `entry` =38434;
-- 25n min=44.2k max=49.5k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '29' WHERE `entry` =38435;
-- 25H min=47.3k max=53k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '31' WHERE `entry` =38436;


-- Sindragosa
-- 10n min=29k max=32.4k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '19' WHERE `entry` =36853;
-- 10H min=32k max=35.9k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '21' WHERE `entry` =38265;
-- 25n min=36.6k max=41k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '24' WHERE `entry` =38266;
-- 25H min=39.7k max=44.4k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '26' WHERE `entry` =38267;


-- Lich King
-- 10n min=29k max=32.4k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '19' WHERE `entry` =36597;
-- 10H min=32k max=35.9k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '21' WHERE `entry` =39166;
-- 25n min=36.6k max=41k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '24' WHERE `entry` =39167;
-- 25H min=39.7k max=44.4k
UPDATE `creature_template` SET  `mindmg` =  '1527',`maxdmg` =  '1710',`dmg_multiplier` =  '26' WHERE `entry` =39168;/* World trinity_string */
SET NAMES 'utf8';
DELETE FROM trinity_string WHERE `entry` IN (950, 951, 952, 953, 954, 955, 956, 957, 958, 959, 960, 961, 962, 963, 964, 965, 966, 967, 968, 969, 970, 971, 972, 973, 974, 975, 976, 977, 978, 979, 980, 981, 982, 983);

INSERT INTO `trinity_string` VALUES 
('950', 'Has sido encarcelado por %s durante %u minuto(s)!', null, null, null, null, null, null, null, null),
('951', '%s escribio como razon: %s', null, null, null, null, null, null, null, null),
('952', '%s encarcelado por %u minuto(s).', null, null, null, null, null, null, null, null),
('953', 'Has sido liberado de la carcel por %s.', null, null, null, null, null, null, null, null),
('954', 'Has liberado a %s de la carcel.', null, null, null, null, null, null, null, null),
('955', 'Razon no ingresada o %u caracteres escritos!', null, null, null, null, null, null, null, null),
('956', 'Nombre no ingresado!', null, null, null, null, null, null, null, null),
('957', 'Tiempo no ingresado!', null, null, null, null, null, null, null, null),
('958', 'El tiempo en carcel debe estar entre 1 y %u minutos!', null, null, null, null, null, null, null, null),
('959', 'Pj %s no encarcelado!', null, null, null, null, null, null, null, null),
('960', 'Comando prohibido para pjs encarcelados!', null, null, null, null, null, null, null, null),
('961', 'Te queda %u minuto(s) restantes en la carcel.', null, null, null, null, null, null, null, null),
('962', 'Te queda %u segundo(s) restantes en la carcel.', null, null, null, null, null, null, null, null),
('963', 'Eres libre! Evita ser encarcelado otra vez! ;-)', null, null, null, null, null, null, null, null),
('964', '%s ha sido %u veces encarcelado y tiene %u minuto(s) restantes. Ultima vez encarcelado el %s. Razon: %s', null, null, null, null, null, null, null, null),
('965', '%s nunca ha sido encarcelado.', null, null, null, null, null, null, null, null),
('966', 'No puedes encarcelarte a ti mismo!', null, null, null, null, null, null, null, null),
('967', 'No puedes liberarte a ti mismo!', null, null, null, null, null, null, null, null),
('968', '|cffff0000[!!! ATENCION !!!\r\n Has estado %u veces en la carcel. Si llegas a estar encarcelado un total de %u veces, tu pj sera borrado automaticamente\r\n|cffff0000!!! ATENCION !!!]', null, null, null, null, null, null, null, null),
('969', 'El pj ', null, null, null, null, null, null, null, null),
('970', ' ha sido encarcelado por ', null, null, null, null, null, null, null, null),
('971', ' minuto(s) por ', null, null, null, null, null, null, null, null),
('972', '. Razon: ', null, null, null, null, null, null, null, null),
('973', 'Configuracion del sistema Jail actualizada.', null, null, null, null, null, null, null, null),
('974', '>> Trinity Jail configuracion cargada.', null, null, null, null, null, null, null, null),
('975', 'No se puede cargar la config! Tabla vacia o no existente! Usar characters_jail.sql!', null, null, null, null, null, null, null, null),
('976', 'Configurado sistema Jail con valores por defecto...', null, null, null, null, null, null, null, null),
('977', 'El pj \'%s\'  es encarcelado y teleportado a la carcel.', null, null, null, null, null, null, null, null),
('978', 'El pj \'%s\'  ha sido liberado de la carcel.', null, null, null, null, null, null, null, null),
('979', 'No existe un pj con ese nombre!', null, null, null, null, null, null, null, null),
('980', '|cffff0000[!!! ATENCION !!!\r\n Has estado %u veces en la carcel. Si llegas a estar un total de %u veces, tu cuenta sera baneada automaticamente!\r\n|cffff0000!!! ATENCION !!!]', null, null, null, null, null, null, null, null),
('981', 'Maximo de veces en carcel alcanzado!', null, null, null, null, null, null, null, null),
('982', 'Sistema Jail', null, null, null, null, null, null, null, null),
('983', 'Estado de Jail reseteado a 0', null, null, null, null, null, null, null, null);

/* World Command English */
DELETE FROM `command` WHERE name IN ('jail','jailinfo','unjail','jailreload');
INSERT INTO `command` (name, security, help) VALUES
('jail', 1, 'Sintaxis: .jail nombre_pj minutos razon\nEncarcelar al \'nombre_pj\' durante \'minutos\' con la razon \'razon\'.'),
('jailinfo', 0, 'Sntaxis: .jailinfo\nMuestra estado de Jail del pj seleccionado.'),
('unjail', 1, 'Sintaxis: .unjail nombre_pj\nLibera al \'nombre_pj\' fuera de la carcel.'),
('jailreload', 3, 'Sintaxis: .jailreload\nRecarca la config del Sistema Jail.');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 46924;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(46924, -13810, 2, 'Bladestorm immune at Frost Trap'),
(46924, -51514, 2, 'Bladestorm immune at Hex'),
(46924, -116, 2, 'Bladestorm immune at FrostBolt'),
(46924, -45524, 2, 'Bladestorm immune at Chains of Ice'),
(46924, -68766, 2, 'Bladestorm immune at Desecration'),
(46924, -58617, 2, 'Bladestorm immune at Glyph of Heart Strike'),
(46924, -605, 2, 'Bladestorm immune at Mind Control');-- Eilo (https://github.com/eilo)
-- Recopilacion y adecuacion de querys originales de Zwerg
-- Haciendo las Puas de Ormorok inatacables (mas bugueros)
SET @spike_h = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 27099);
UPDATE creature_template SET unit_flags = unit_flags|2 WHERE entry IN (27099,@spike_h);

-- Cambiando la posicion de los trashmob en Ormorok, estos estaban al lado de el :S
UPDATE creature SET position_x = '323.541779', position_y = '-240.492249', position_z = '-14.088820', orientation = '2.964224' WHERE guid = '126444';
UPDATE creature SET position_x = '323.179108', position_y = '-242.347137', position_z = '-14.088820', orientation = '2.948516' WHERE guid = '126606';
UPDATE creature SET position_x = '324.616272', position_y = '-234.996307', position_z = '-14.088820', orientation = '3.152720' WHERE guid = '126605';
UPDATE creature SET position_x = '317.004852', position_y = '-237.360901', position_z = '-14.088820', orientation = '3.231260' WHERE guid = '126445';

-- Varios en Telestra, inmunidad a interrumpir y asignando script a su imagen invocada
UPDATE creature_template SET mechanic_immune_mask = mechanic_immune_mask &~ 33554432 WHERE entry IN (26731,30510);
UPDATE creature_template SET AIName = '', ScriptName = 'boss_magus_telestra_arcane' WHERE entry = 26929;

-- Los Chaotic Rift no deberian matarse entre ellos
UPDATE `creature_template` SET `faction_A`=16,`faction_H`=16 WHERE `entry` IN (26918,30522);

-- Algunos mobs que no se les podira atacar, lo que antes se ajustaba con DeathState
UPDATE `creature_template` SET `unit_flags`=0x00008040 WHERE `entry` IN (26737,30519, 26734,30516);
UPDATE `creature` SET `unit_flags`=0,`dynamicflags`=`dynamicflags`&~32 WHERE `id` IN (26734,30516,26735,30517,26736,30518,26737,30519,26746,30520,26761,30521);
UPDATE `creature_template` SET `dynamicflags`=`dynamicflags`&~32 WHERE `entry` IN (26734,30516,26735,30517,26736,30518,26737,30519,26746,30520,26761,30521);

-- Quitando el aura de Fingir Muerte, esto pasa cuando te les acercas fingen
UPDATE `creature_addon` SET `auras`='' WHERE `guid` BETWEEN 126481 AND 126598;

-- Cambio de posiciones de los Skyrazor que estaban en las piedras o abajo
UPDATE `creature` SET 
`position_z`=-10,
`orientation`= 
    CASE `guid` 
        WHEN 126505 THEN 2.15 
        WHEN 126506 THEN 5.47
    END
WHERE `guid` IN (126505,126506);-- Eilo (https://github.com/eilo)
-- Recopilacion y adecuacion de querys originales de Zwerg mas unas mias
-- Drakkari Guardian (no deberia estar todos muertos)
UPDATE `creature_template` SET 
	`faction_A`=1814,
	`faction_H`=1814,
	`unit_flags`=`unit_flags`&~33554432&~2,
	`dynamicflags`=`dynamicflags`&~32,
	`type_flags`=`type_flags`&~128,
	`flags_extra`=`flags_extra`&~2 
WHERE `entry` IN (26620,31339); 

-- Drakkari Bat mas flags hasta que desmonte
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|0x2, `flags_extra`=`flags_extra`|0x2 WHERE `entry`=27490;

-- Risen Drakkari Bat Rider correccion de sus flags para atacarle
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~33554432&~2 WHERE `entry` IN (26638,31351); 
UPDATE `creature_template` SET `dynamicflags`=`dynamicflags`&~32 WHERE `entry` IN (26638,31351);
UPDATE `creature` SET `unit_flags`=0,`dynamicflags`=`dynamicflags`&~32 WHERE `id` IN (26638,31351);

-- Quien esta vivo y quien se queda muerto o aparentemente muerto sin que se le pueda atacar
UPDATE `creature` SET 
	`unit_flags`= IF(`guid` IN (127589,127590,127580,127591,127579,127578,127582),0,(`unit_flags`|33554432|512|2)),
	`dynamicflags`= IF(`guid` IN (127589,127590,127580,127591,127579,127578,127582),0,(`dynamicflags`|32))
WHERE `id`=26620;

-- Mismas facciones para que no se puedan pegar entre si
UPDATE `creature_template` SET `faction_A`=1814,`faction_H`=1814 WHERE `entry` IN 
(
26639,  -- Drakkari Shaman
31345,  -- Drakkari Shaman H
26830,  -- Risen Drakkari Death Knight
31352,  -- Risen Drakkari Death Knight H
27431,  -- Drakkari Commander
31338   -- Drakkari Commander H
);
-- bosses Isle of Conquest
UPDATE `creature_template` SET `unit_flags` = 0  WHERE `entry` in (34924,35403, 34922,35405);
UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35 WHERE `entry` in (34924,35403);
UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35 WHERE `entry` in (34922,35405);
UPDATE `creature_template` SET `ScriptName`='bosses_isle_of_conquest' WHERE `entry` IN (34924,34922);
-- Eilo (https://github.com/eilo)
-- Recopilacion y adecuacion de querys originales de Zwerg

-- INSTANCE: The Oculus
-- first remove unneeded stuff from recent commits
UPDATE `gameobject_template` SET `AIName`='' WHERE `entry` IN (188715,189985);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (188715,189985);
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_emerald_drake_touch_the_nightmare';
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (49346,49460,49464);
UPDATE `creature_template` SET `AIName`='',`ScriptName`='' WHERE `entry`=28239;
DELETE FROM `creature` WHERE `id`=28183;
DELETE FROM `creature_addon` WHERE `guid` BETWEEN 100227 AND 100234;
-- end remove

UPDATE `creature_template` SET `unit_flags`=0 WHERE `entry`=30879;
UPDATE `creature_template` SET `IconName`='',`ScriptName`='npc_oculus_mount' WHERE `entry` IN (27692,27755,27756);
UPDATE `creature_template` SET `InhabitType`=5,`ScriptName`='npc_planar_anomaly' WHERE `entry`=30879;
UPDATE `creature_template_addon` SET `auras`='50325' WHERE `entry` IN (27692,27755);
UPDATE `creature_template_addon` SET `auras`='50248 50325' WHERE `entry`=27756;
UPDATE `creature_template` SET `spell2`=50240,`spell3`=50253,`spell4`=0 WHERE `entry`=27756;

UPDATE `creature_template` SET `mingold`=7666,`maxgold`=12776 WHERE `entry` IN(27633,27635,27636,27641, 30901,30902,30904,30905,30915,30916);
UPDATE `creature_template` SET `mingold`=40000,`maxgold`=60000,`mechanic_immune_mask`=646676351 WHERE `entry` IN(27447,27654,27655,27656);
UPDATE `creature_template` SET `mingold`=120000,`maxgold`=180000,`mechanic_immune_mask`=646676351 WHERE `entry` IN(31558,31559,31560,31561);

DELETE FROM `spell_script_names` WHERE `spell_id` IN(49838,49840,50240,49592);
INSERT INTO `spell_script_names` VALUES
(49840,'spell_amber_drake_shock_lance'),
(49838,'spell_amber_drake_stop_time'),
(50240,'spell_ruby_drake_evasive_maneuvers'),
(49592,'spell_amber_drake_temporal_rift');

DELETE FROM `spell_proc_event` WHERE `entry`=50240;
INSERT INTO `spell_proc_event` (`entry`,`procEx`,`CustomChance`)VALUES
(50240,4,100);

DELETE FROM `creature_addon` WHERE `guid` IN (101924,101933,101922,101974,102064,101967);
DELETE FROM `creature_template_addon` WHERE `entry` IN (27641,30905,28153,30917);
INSERT INTO `creature_template_addon` (`entry`,`auras`) VALUES
(27641,'50088'),
(30905,'50088'),
(28153,'44604'),
(30917,'44604');

-- SAI
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry` IN (27636,27633,27635,27638,27640,28153,27639,28276,27642,27644,27645,27650,27651,27653,27647,27648);
DELETE FROM `creature_ai_scripts` WHERE `creature_id` IN (27636,27633,27635,27638,27641,27640,28153,27639,28276,27642,27644,27645,27650,27651,27653,27647,27648);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (27636,27633,27635,27638,27640,28153,27639,28276,27642,27644,27645,27650,27651,27653,27647,27648);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(27636,0,0,0,0,0,100,2,2000,4000,2000,4000,11,50705,0,0,0,0,0,2,0,0,0,0,0,0,0,'Azure Ley-Whelp - IC - cast Arcane Bolt'),
(27636,0,1,0,0,0,100,4,2000,4000,2000,4000,11,59210,0,0,0,0,0,2,0,0,0,0,0,0,0,'Azure Ley-Whelp - IC - cast Arcane Bolt H'),

(27633,0,0,0,0,0,100,0,3000,5000,6000,8000,11,50573,0,0,0,0,0,2,0,0,0,0,0,0,0,'Azure Inquisitor - IC - cast Arcane Cleave'),
(27633,0,1,0,0,0,100,0,9000,10000,15000,20000,11,50690,0,0,0,0,0,5,0,0,0,0,0,0,0,'Azure Inquisitor - IC - cast Immobilizing Field'),
(27633,0,2,0,9,0,100,2,5,30,3000,5000,11,51454,0,0,0,0,0,6,0,0,0,0,0,0,0,'Azure Inquisitor - IC - cast Throw'),
(27633,0,3,0,9,0,100,4,5,30,3000,5000,11,59209,0,0,0,0,0,6,0,0,0,0,0,0,0,'Azure Inquisitor - IC - cast Throw H'),

(27635,0,0,0,0,0,100,2,3000,5000,12000,14000,11,50702,0,0,0,0,0,1,0,0,0,0,0,0,0,'Azure Spellbinder - IC - cast Arcane Volley '),
(27635,0,1,0,0,0,100,4,3000,5000,12000,14000,11,59212,0,0,0,0,0,1,0,0,0,0,0,0,0,'Azure Spellbinder - IC - cast Arcane Volley H'),
(27635,0,2,0,0,0,100,2,7000,9000,15000,20000,11,50566,0,0,0,0,0,5,0,0,0,0,0,0,0,'Azure Spellbinder - IC - cast Mind Warp'),
(27635,0,3,0,0,0,100,4,7000,9000,15000,20000,11,38047,0,0,0,0,0,5,0,0,0,0,0,0,0,'Azure Spellbinder - IC - cast Mind Warp H'),
(27635,0,4,0,0,0,100,0,10000,13000,20000,25000,11,50572,0,0,0,0,0,5,0,0,0,0,0,0,0,'Azure Spellbinder - IC - cast Power Sap'),

(27638,0,0,0,0,0,100,2,0,5000,6000,8000,11,49549,0,0,0,0,0,2,0,0,0,0,0,0,0,'Azure Ring Guardian - IC - cast Ice Beam'),
(27638,0,1,0,0,0,100,4,0,5000,6000,8000,11,59211,0,0,0,0,0,2,0,0,0,0,0,0,0,'Azure Ring Guardian - IC - cast Ice Beam H'),

(27640,0,0,0,23,0,100,2,50717,0,0,0,11,50717,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ring-Lord Conjurer - On missing Aura: Charged Skin - cast Charged Skin'),
(27640,0,1,0,23,0,100,4,59276,0,0,0,11,59276,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ring-Lord Conjurer - On missing Aura: Charged Skin H - cast Charged Skin H'),
(27640,0,2,0,0,0,100,0,4000,6000,13000,15000,11,50719,0,0,0,0,0,1,0,0,0,0,0,0,0,'Ring-Lord Conjurer - IC - cast Conjure Snowflake'),
-- may implement beam to misc Centrifuge Construct

(28153,0,0,0,0,0,100,2,0,0,0,0,11,50721,0,0,0,0,0,5,0,0,0,0,0,0,0,'Snowflake - IC - cast Frostbolt'),
(28153,0,1,0,0,0,100,4,0,0,0,0,11,59280,0,0,0,0,0,5,0,0,0,0,0,0,0,'Snowflake - IC - cast Frostbolt H'),

(27639,0,0,0,0,0,100,2,5000,7000,20000,25000,11,50715,0,0,0,0,0,5,0,0,0,0,0,0,0,'Ring-Lord Sorceress - IC - cast Blizzard'),
(27639,0,1,0,0,0,100,4,5000,7000,20000,25000,11,59278,0,0,0,0,0,5,0,0,0,0,0,0,0,'Ring-Lord Sorceress - IC - cast Blizzard H'),
(27639,0,2,0,0,0,100,2,2000,4000,8000,10000,11,16102,0,0,0,0,0,5,0,0,0,0,0,0,0,'Ring-Lord Sorceress - IC - cast Flamestrike'),
(27639,0,3,0,0,0,100,4,2000,4000,8000,10000,11,61402,0,0,0,0,0,5,0,0,0,0,0,0,0,'Ring-Lord Sorceress - IC - cast Flamestrike H'),
-- may implement beam to misc Centrifuge Construct

(28276,0,0,0,0,0,100,2,2000,4000,2000,4000,11,50705,0,0,0,0,0,2,0,0,0,0,0,0,0,'Greater Ley-Whelp - IC - cast Arcane Bolt'),
(28276,0,1,0,0,0,100,4,2000,4000,2000,4000,11,59210,0,0,0,0,0,2,0,0,0,0,0,0,0,'Greater Ley-Whelp - IC - cast Arcane Bolt H'),

-- Mage-Lord Urom Adds
(27642,0,0,0,9,0,100,0,8,25,6000,8000,11,32323,0,0,0,0,0,6,0,0,0,0,0,0,0,'Phantasmal Mammoth - IC - cast Charge'),
(27642,0,1,0,0,0,100,0,4000,6000,10000,12000,11,51253,0,0,0,0,0,1,0,0,0,0,0,0,0,'Phantasmal Mammoth - IC - cast Trample'),

(27644,0,0,0,0,0,100,2,3000,6000,12000,14000,11,50728,0,0,0,0,0,1,0,0,0,0,0,0,0,'Phantasmal Wolf - IC - cast Furious Howl'),
(27644,0,1,0,0,0,100,4,3000,6000,12000,14000,11,59274,0,0,0,0,0,1,0,0,0,0,0,0,0,'Phantasmal Wolf - IC - cast Furious Howl H'),
(27644,0,2,0,0,0,100,2,5000,8000,14000,17000,11,50729,0,0,0,0,0,2,0,0,0,0,0,0,0,'Phantasmal Wolf - IC - cast Carnivorous Bite'),
(27644,0,3,0,0,0,100,4,5000,8000,14000,17000,11,59269,0,0,0,0,0,2,0,0,0,0,0,0,0,'Phantasmal Wolf - IC - cast Carnivorous Bite H'),

(27645,0,0,0,0,0,100,2,6000,8000,10000,12000,11,59220,0,0,0,0,0,5,0,0,0,0,0,0,0,'Phantasmal Cloudscraper - IC - cast Chain Lightning'),
(27645,0,1,0,0,0,100,4,6000,8000,10000,12000,11,15588,0,0,0,0,0,5,0,0,0,0,0,0,0,'Phantasmal Cloudscraper - IC - cast Chain Lightning H'),
(27645,0,2,0,0,0,100,2,2000,4000,12000,14000,11,15588,0,0,0,0,0,1,0,0,0,0,0,0,0,'Phantasmal Cloudscraper - IC - cast Thunderclap'),
(27645,0,3,0,0,0,100,4,2000,4000,12000,14000,11,59217,0,0,0,0,0,1,0,0,0,0,0,0,0,'Phantasmal Cloudscraper - IC - cast Thunderclap H'),

(27650,0,0,0,4,0,100,2,0,0,0,0,11,25020,0,0,0,0,0,1,0,0,0,0,0,0,0,'Phantasmal Air - On Aggro - cast Lightning Shield'),
(27650,0,1,0,4,0,100,4,0,0,0,0,11,20545,0,0,0,0,0,1,0,0,0,0,0,0,0,'Phantasmal Air - On Aggro - cast Lightning Shield H'),

(27651,0,0,0,0,0,100,2,3000,5000,5000,8000,11,50744,0,0,0,0,0,5,0,0,0,0,0,0,0,'Phantasmal Fire - IC - cast Blaze'),
(27651,0,1,0,0,0,100,4,3000,5000,5000,8000,11,59225,0,0,0,0,0,5,0,0,0,0,0,0,0,'Phantasmal Fire - IC - cast Blaze H'),

(27653,0,0,0,0,0,100,2,3000,5000,7000,9000,11,37924,0,0,0,0,0,1,0,0,0,0,0,0,0,'Phantasmal Water - IC - cast Water Bolt Volley'),
(27653,0,1,0,0,0,100,4,3000,5000,7000,9000,11,59266,0,0,0,0,0,1,0,0,0,0,0,0,0,'Phantasmal Water - IC - cast Water Bolt Volley H'),

(27647,0,0,0,0,0,100,0,2000,5000,7000,9000,11,50731,0,0,0,0,0,5,0,0,0,0,0,0,0,'Phantasmal Ogre - IC - cast Mace Smash'),
(27647,0,1,0,4,0,100,0,0,0,0,0,11,50730,0,0,0,0,0,1,0,0,0,0,0,0,0,'Phantasmal Ogre - On Aggro - cast Bloodlust'),

(27648,0,0,0,0,0,100,2,3000,5000,8000,10000,11,50732,0,0,0,0,0,5,0,0,0,0,0,0,0,'Phantasmal Naga - IC - cast Water Tomb'),
(27648,0,1,0,0,0,100,4,3000,5000,8000,10000,11,59261,0,0,0,0,0,5,0,0,0,0,0,0,0,'Phantasmal Naga - IC - cast Water Tomb H'),
(27648,0,2,0,0,0,100,0,4000,6000,6000,8000,11,49711,0,0,0,0,0,5,0,0,0,0,0,0,0,'Phantasmal Naga - IC - cast Hooked Net');

-- skinnloot
UPDATE `creature_template` SET `skinloot`=70210 WHERE `entry` IN (27636,27633,27635,27638,28276, 30902,30901,30904,30903,30991);
UPDATE `creature_template` SET `skinloot`=29730,`type_flags`=`type_flags`|32768 WHERE `entry` IN (27641, 30905);
UPDATE `creature_template` SET `skinloot`=70211 WHERE `entry` IN (27642,27644,27645, 30909,30914,30907);

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry` IN (50232,50328,50341,49840,49592);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (61407,62136,54069,56251,51024,50087);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
-- Searing Wrath
(17,50232,1,19,27638,0),
(17,50232,2,19,27656,0),
(17,50232,3,19,28276,0),
-- Leeching Poison
(17,50328,1,19,27638,0),
(17,50328,2,19,27656,0),
(17,50328,3,19,28276,0),
-- Touch the Nightmare
(17,50341,1,19,27638,0),
(17,50341,2,19,27656,0),
(17,50341,3,19,28276,0),
-- Shock Lance
(17,49840,1,19,27638,0),
(17,49840,2,19,27656,0),
(17,49840,3,19,28276,0),
-- Temporal Rift
(17,49592,1,19,27638,0),
(17,49592,2,19,27656,0),
(17,49592,3,19,28276,0),

(13,61407,0,18,1,28183),
(13,62136,0,18,1,28183),
(13,54069,0,18,1,28183),
(13,56251,0,18,1,28183),
(13,51024,0,18,1,28239),

(13,50087,0,18,1,27641);

DELETE FROM creature_loot_template WHERE entry IN(30901, 30902, 30904, 30905, 30906, 30907, 30908, 30909, 30910, 30911, 30912, 30913, 30914, 30915, 30916);
INSERT INTO creature_loot_template VALUES
(30902, 33631, 73, 1, 0, 1, 1),
(30902, 33632, 17, 1, 0, 1, 1),
(30902, 37366, 1, 1, 0, 1, 1),
(30902, 37365, 1, 1, 0, 1, 1),
(30902, 37364, 1, 1, 0, 1, 1),
(30902, 43297, 0.1, 1, 0, 1, 1),
(30902, 45912, 0.1, 1, 0, 1, 1),
(30901, 33470, 33, 1, 0, 1, 7),
(30901, 43852, 19, 1, 0, 1, 1),
(30901, 33454, 8, 1, 0, 1, 1),
(30901, 33445, 4, 1, 0, 1, 1),
(30901, 33447, 2, 1, 0, 1, 1),
(30901, 33448, 2, 1, 0, 1, 1),
(30901, 37364, 1.2, 1, 0, 1, 1),
(30901, 37366, 1, 1, 0, 1, 1),
(30901, 37365, 1, 1, 0, 1, 1),
(30901, 43297, 0.1, 1, 0, 1, 1),
(30901, 45912, 0.1, 1, 0, 1, 1),
(30904, 33470, 31, 1, 0, 1, 7),
(30904, 43852, 19, 1, 0, 1, 1),
(30904, 33454, 7, 1, 0, 1, 1),
(30904, 33445, 4, 1, 0, 1, 1),
(30904, 33447, 2, 1, 0, 1, 1),
(30904, 37366, 1, 1, 0, 1, 1),
(30904, 37365, 1, 1, 0, 1, 1),
(30904, 37364, 1, 1, 0, 1, 1),
(30904, 43297, 0.1, 1, 0, 1, 1),
(30904, 45912, 0.1, 1, 0, 1, 1),
(30916, 33470, 32, 1, 0, 1, 7),
(30916, 43852, 18, 1, 0, 1, 1),
(30916, 33454, 8, 1, 0, 1, 1),
(30916, 33445, 4, 1, 0, 1, 1),
(30916, 33447, 2, 1, 0, 1, 1),
(30916, 37366, 1, 1, 0, 1, 1),
(30916, 37365, 1, 1, 0, 1, 1),
(30916, 37364, 1, 1, 0, 1, 1),
(30916, 43297, 0.1, 1, 0, 1, 1),
(30916, 45912, 0.1, 1, 0, 1, 1),
(30915, 33470, 33, 1, 0, 1, 7),
(30915, 43852, 19, 1, 0, 1, 1),
(30915, 33454, 8, 1, 0, 1, 1),
(30915, 33445, 4, 1, 0, 1, 1),
(30915, 33447, 2, 1, 0, 1, 1),
(30915, 33478, 2, 1, 0, 1, 1),
(30915, 37366, 1, 1, 0, 1, 1),
(30915, 37365, 1, 1, 0, 1, 1),
(30915, 37364, 1, 1, 0, 1, 1),
(30915, 43297, 0.1, 1, 0, 1, 1),
(30915, 45912, 0.1, 1, 0, 1, 1),
(30905, 39209, 72, 1, 0, 1, 1),
(30905, 39210, 17, 1, 0, 1, 1),
(30905, 37366, 1, 1, 0, 1, 1),
(30905, 37365, 1, 1, 0, 1, 1),
(30905, 37364, 1, 1, 0, 1, 1),
(30905, 43297, 0.1, 1, 0, 1, 1),
(30905, 45912, 0.1, 1, 0, 1, 1),
(30906, 39512, 72, 1, 0, 1, 4),
(30906, 37700, 28, 1, 0, 1, 4),
(30906, 39513, 17, 1, 0, 1, 4),
(30906, 37366, 1, 1, 0, 1, 1),
(30906, 37365, 1, 1, 0, 1, 1),
(30906, 37364, 1, 1, 0, 1, 1),
(30908, 39512, 69, 1, 0, 1, 4),
(30908, 37702, 30, 1, 0, 1, 4),
(30908, 39513, 18, 1, 0, 1, 4),
(30908, 37366, 1.7, 1, 0, 1, 1),
(30908, 37365, 1, 1, 0, 1, 1),
(30908, 37364, 1, 1, 0, 1, 1),
(30913, 39512, 72, 1, 0, 1, 4),
(30913, 37705, 30, 1, 0, 1, 4),
(30913, 39513, 18, 1, 0, 1, 4),
(30913, 37366, 1, 1, 0, 1, 1),
(30913, 37365, 1, 1, 0, 1, 1),
(30913, 37364, 1, 1, 0, 1, 1),
(30912, 33470, 33, 1, 0, 1, 4),
(30912, 43852, 18, 1, 0, 1, 1),
(30912, 33454, 7, 1, 0, 1, 1),
(30912, 33445, 6, 1, 0, 1, 1),
(30912, 33447, 2, 1, 0, 1, 1),
(30912, 33764, 1.8, 1, 0, 1, 1),
(30912, 36047, 1.1, 1, 0, 1, 1),
(30912, 36148, 1.1, 1, 0, 1, 1),
(30912, 37097, 1, 1, 0, 1, 1),
(30912, 33448, 2, 1, 0, 1, 1),
(30912, 36371, 1.3, 1, 0, 1, 1),
(30912, 37366, 1, 1, 0, 1, 1),
(30912, 37365, 1, 1, 0, 1, 1),
(30912, 37364, 1, 1, 0, 1, 1),
(30910, 17057, 27, 1, 0, 1, 1),
(30910, 17058, 25, 1, 0, 1, 1),
(30910, 33470, 19, 1, 0, 1, 1),
(30910, 36781, 16, 1, 0, 1, 1),
(30910, 43852, 12, 1, 0, 1, 1),
(30910, 37365, 1.2, 1, 0, 1, 1),
(30910, 33447, 2, 1, 0, 1, 1),
(30910, 37366, 1, 1, 0, 1, 1),
(30910, 37364, 1, 1, 0, 1, 1),
(30911, 17057, 26, 1, 0, 1, 1),
(30911, 17058, 25, 1, 0, 1, 1),
(30911, 33470, 17, 1, 0, 1, 7),
(30911, 36781, 14, 1, 0, 1, 1),
(30911, 43853, 10, 1, 0, 1, 1),
(30911, 37366, 1, 1, 0, 1, 1),
(30911, 37365, 1, 1, 0, 1, 1),
(30911, 37364, 1, 1, 0, 1, 1),
(30914, 39211, 71, 1, 0, 1, 5),
(30914, 43011, 46, 1, 0, 1, 1),
(30914, 39212, 17, 1, 0, 1, 4),
(30914, 43013, 13, 1, 0, 1, 1),
(30914, 37366, 1, 1, 0, 1, 1),
(30914, 37365, 1, 1, 0, 1, 1),
(30914, 37364, 1, 1, 0, 1, 1),
(30907, 39567, 73, 1, 0, 1, 5),
(30907, 39568, 16, 1, 0, 1, 4),
(30907, 37366, 1, 1, 0, 1, 1),
(30907, 37365, 1, 1, 0, 1, 1),
(30907, 37364, 1, 1, 0, 1, 1),
(30909, 39562, 72, 1, 0, 1, 4),
(30909, 34736, 49, 1, 0, 1, 1),
(30909, 39563, 18, 1, 0, 1, 3),
(30909, 43013, 11, 1, 0, 1, 1),
(30909, 33422, 1, 1, 0, 1, 1),
(30909, 37366, 1, 1, 0, 1, 1),
(30909, 37365, 1, 1, 0, 1, 1),
(30909, 37364, 1, 1, 0, 1, 1);

DELETE FROM `script_texts` WHERE `entry` BETWEEN  -1578024 AND -1578005 OR (`npc_entry` IN (27654,27447,27655,27656));
DELETE FROM `creature_text` WHERE `entry` IN (27654,27447,27655,27656);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
-- Drakos
(27654,1,0,'The prisoners shall not go free. The word of Malygos is law!',14,0,0,5,0,13594,'Drakos the Interrogator - Aggro'),
(27654,2,0,'A fitting punishment!',14,0,0,5,0,13602,'Drakos the Interrogator - Kill 1'),
(27654,2,1,'Sentence: executed!',14,0,0,5,0,13603,'Drakos the Interrogator - Kill 2'),
(27654,2,2,'Another casualty of war!',14,0,0,5,0,13604,'Drakos the Interrogator - Kill 3'),
(27654,3,0,'It is too late to run!',14,0,0,5,0,13598,'Drakos the Interrogator - Pull 1'),
(27654,3,1,'Gather ''round...',14,0,0,5,0,13599,'Drakos the Interrogator - Pull 2'),
(27654,3,2,'None shall escape!',14,0,0,5,0,13600,'Drakos the Interrogator - Pull 3'),
(27654,3,3,'I condemn you to death!',14,0,0,5,0,13601,'Drakos the Interrogator - Pull 4'),
(27654,4,0,'Tremble, worms!',14,0,0,5,0,13595,'Drakos the Interrogator - Stomp 1'),
(27654,4,1,'I will crush you!',14,0,0,5,0,13596,'Drakos the Interrogator - Stomp 2'),
(27654,4,2,'Can you fly?',14,0,0,5,0,13597,'Drakos the Interrogator - Stomp 3'),
(27654,5,0,'The war... goes on.',14,0,0,5,0,13605,'Drakos the Interrogator - Death'),
-- Varos
(27447,1,0,'There will be no mercy!',14,0,0,5,0,13649,'Varos Cloudstrider - Aggro'),
(27447,2,0,'They are... too strong! Underestimated their... fortitude.',14,0,0,5,0,13655,'Varos Cloudstrider - Death'),
(27447,3,0,'Blast them! Destroy them!',14,0,0,5,0,13650,'Varos Cloudstrider - Air Strike 1'),
(27447,3,1,'Take no prisoners! Attack!',14,0,0,5,0,13651,'Varos Cloudstrider - Air Strike 2'),
(27447,3,2,'Strike now! Obliterate them!',14,0,0,5,0,13652,'Varos Cloudstrider - Air Strike 3'),
(27447,4,0,'You have been warned!',14,0,0,5,0,13653,'Varos Cloudstrider - Kill 1'),
(27447,4,1,'The Oculus is ours!',14,0,0,5,0,13654,'Varos Cloudstrider - Kill 2'),
(27447,5,0,'Intruders, your victory will be short-lived. I am Commander Varos Cloudstrider. My drakes control the skies and protect this conduit. I will see to it personnaly that the Oculus does not fall into your hands!',14,0,0,5,0,13648,'Varos Cloudstrider - Spawn'),
-- Urom
(27655,1,0,'Poor blind fools!',14,0,0,5,0,13638,'Mage-Lord Urom - Aggro'),
(27655,2,0,'What do we have here... those would defy the Spell-Weaver? Those without foresight or understanding. How could I make you see? Malygos is saving the world from itself! Bah! You are hardly worth my time!',14,0,0,5,0,13635,'Mage-Lord Urom - Summon 1'),
(27655,3,0,'Clearly my pets failed. Perhaps another demonstration is in order.',14,0,0,5,0,13636,'Mage-Lord Urom - Summon 2'),
(27655,4,0,'Still you fight. Still you cling to misguided principles. If you survive, you''ll find me in the center ring.',14,0,0,5,0,13637,'Mage-Lord Urom - Summon 3'),
(27655,5,0,'If only you understood!',14,0,0,5,0,13641,'Mage-Lord Urom - Kill 1'),
(27655,5,1,'Now do you see? Do you?!',14,0,0,5,0,13642,'Mage-Lord Urom - Kill 2'),
(27655,5,2,'Unfortunate, but necessary.',14,0,0,5,0,13643,'Mage-Lord Urom - Kill 3'),
(27655,6,0,'A taste... just a small taste... of the Spell-Weaver''s power!',14,0,0,5,0,13639,'Mage-Lord Urom - Explotion 1'),
(27655,6,1,'So much unstable energy... but worth the risk to destroy you!',14,0,0,5,0,13640,'Mage-Lord Urom - Explotion 2'),
(27655,7,0,'Everything I''ve done... has been for Azeroth...',14,0,0,5,0,13644,'Mage-Lord Urom - Death'),
-- Eregos
(27656,1,0,'You brash interlopers are out of your element! I will ground you!',14,0,0,5,0,13623,'Ley-Guardian Eregos - Aggro'),
(27656,2,0,'Simpletons! You cannot comprehend the forces you have set in motion. The ley line conduit will not be disrupted! Your defeat shall be absolute!',14,0,0,5,0,13622,'Ley-Guardian Eregos - Spawn'),
(27656,3,0,'Such insolence... such arrogance... must be PUNISHED!',14,0,0,5,0,13624,'Ley-Guardian Eregos - Frenzy'),
(27656,4,0,'It''s a long way down...',14,0,0,5,0,13628,'Ley-Guardian Eregos - Kill 1'),
(27656,4,1,'Back to the earth with you!',14,0,0,5,0,13629,'Ley-Guardian Eregos - Kill 2'),
(27656,4,2,'Enjoy the fall!',14,0,0,5,0,13630,'Ley-Guardian Eregos - Kill 3'),
(27656,5,0,'Savor this small victory, foolish little creatures. You and your dragon allies have won this battle. But we will win... the Nexus War.',14,0,0,5,0,13631,'Ley-Guardian Eregos - Death'),
(27656,6,0,'Anomalies form as Ley-Guardian Eregos shifts into the Astral Plane!',41,0,0,0,0,0,'Ley-Guardian Eregos - Astral');

DELETE FROM creature_onkill_reputation WHERE creature_id IN (30902, 30901, 30904, 30915, 30916, 30905, 30903, 31558, 31559, 31560, 31561);
INSERT INTO creature_onkill_reputation VALUES
(30902, 1037, 1052, 7, 0, 2, 7, 0, 2, 1),
(30901, 1037, 1052, 7, 0, 15, 7, 0, 15, 1),
(30904, 1037, 1052, 7, 0, 15, 7, 0, 15, 1),
(30915, 1037, 1052, 7, 0, 15, 7, 0, 15, 1),
(30916, 1037, 1052, 7, 0, 15, 7, 0, 15, 1),
(30905, 1037, 1052, 7, 0, 30, 7, 0, 30, 1),
(30903, 1037, 1052, 7, 0, 15, 7, 0, 15, 1),
(31558, 1037, 1052, 7, 0, 250, 7, 0, 250, 1),
(31559, 1037, 1052, 7, 0, 250, 7, 0, 250, 1),
(31560, 1037, 1052, 7, 0, 250, 7, 0, 250, 1),
(31561, 1037, 1052, 7, 0, 250, 7, 0, 250, 1);

-- 06/12/2011
-- Achievements
-- Voids
DELETE FROM `disables` WHERE `sourceType`=4 AND `entry` IN (7323,7324,7325);
DELETE FROM `achievement_criteria_data` WHERE `type`=11 AND `criteria_id` IN (7323,7324,7325);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(7323,11,0,0,'achievement_ruby_void'),
(7324,11,0,0,'achievement_emerald_void'),
(7325,11,0,0,'achievement_amber_void');

-- 10/12/2011
-- Achievements
-- Experienced Drake Rider
DELETE FROM `disables` WHERE `sourceType`=4 AND `entry` IN (7177,7178,7179);
DELETE FROM `achievement_criteria_data` WHERE `type` IN (5,11) AND `criteria_id` IN (7177,7178,7179);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(7177,11,0,0,'achievement_experienced_drake_rider_amber'),
(7178,11,0,0,'achievement_experienced_drake_rider_emerald'),
(7179,11,0,0,'achievement_experienced_drake_rider_ruby');

-- 10/12/2011
-- Cache of the Ley-Guardian
DELETE FROM `item_loot_template` WHERE `entry`=52676;
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
-- Gems
(52676,36921,0,1,1,1,3),
(52676,36933,0,1,1,1,3),
(52676,36930,0,1,1,1,3),
(52676,36918,0,1,1,1,3),
(52676,36927,0,1,1,1,3),
(52676,36924,0,1,1,1,3),
-- Mount
(52676,43953,5,1,0,1,1);-- Querys correcciones Foso de Saron
-- Eilo (https://github.com/eilo)

-- Querys para encontrar los valores actuales de los npcs, tanto plantilla como spawn
-- SELECT entry,difficulty_entry_1,`name`,unit_flags,dynamicflags,mechanic_immune_mask,ainame,scriptname FROM creature_template WHERE entry=36830;
-- SELECT * FROM creature WHERE id IN (36830,37638);

-- Warborn Laborer corregida flag que no hacia que ataquen normalmente y asegurando que el spawn tampoco
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~256 WHERE `entry` IN (36830,37638); 
UPDATE `creature_template` SET `dynamicflags`=`dynamicflags`&~32 WHERE `entry` IN (36830,37638);
UPDATE `creature` SET `unit_flags`=0,`dynamicflags`=`dynamicflags`&~32 WHERE `id` IN (36830,37638);

-- Ymirjar Deathbringer lo mismo que el anterior
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~256 WHERE `entry` IN (36892,37641); 
UPDATE `creature_template` SET `dynamicflags`=`dynamicflags`&~32 WHERE `entry` IN (36892,37641);
UPDATE `creature` SET `unit_flags`=0,`dynamicflags`=`dynamicflags`&~32 WHERE `id` IN (36892,37641);-- Eilo (https://github.com/eilo)
-- Recopilacion y adecuacion de querys originales de HyD y varios autores de scripts antiguas y raras
-- Algunas querys anadidas y ordenacion/comentarios del sql por Eilo, cabe recalcar que los cpp hubo que retocar tambien.

-- INSTANCE: TrialOfTheChampion
-- ----------------------
--    TEMPLATES HERO
-- ----------------------
-- Templates
DELETE FROM `creature_template` WHERE `entry` IN (12000, 12001, 12002, 12003, 12004, 12005, 12006, 12007, 12008, 12009, 12010, 12011, 12444, 12436);
UPDATE `creature_template` SET `difficulty_entry_1` = 36089 WHERE `entry` = 35572;
UPDATE `creature_template` SET `difficulty_entry_1` = 36085 WHERE `entry` = 35569;
UPDATE `creature_template` SET `difficulty_entry_1` = 36090 WHERE `entry` = 35571;
UPDATE `creature_template` SET `difficulty_entry_1` = 36091 WHERE `entry` = 35570;
UPDATE `creature_template` SET `difficulty_entry_1` = 36084 WHERE `entry` = 35617;
UPDATE `creature_template` SET `difficulty_entry_1` = 36088 WHERE `entry` = 34705;
UPDATE `creature_template` SET `difficulty_entry_1` = 36082 WHERE `entry` = 34702;
UPDATE `creature_template` SET `difficulty_entry_1` = 36083 WHERE `entry` = 34701;
UPDATE `creature_template` SET `difficulty_entry_1` = 36086 WHERE `entry` = 34657;
UPDATE `creature_template` SET `difficulty_entry_1` = 36087 WHERE `entry` = 34703;
UPDATE `creature_template` SET `difficulty_entry_1` = 35518 WHERE `entry` = 35119;
UPDATE `creature_template` SET `difficulty_entry_1` = 35517 WHERE `entry` = 34928;
UPDATE `creature_template` SET `difficulty_entry_1` = 35717 WHERE `entry` = 35590;
UPDATE `creature` SET `phasemask`=2 WHERE `id`=20562;

-- ----------------------
--        SPAWNS
-- ----------------------
-- Spawns
SET @SPAWN_GUID := 365000;
DELETE FROM `creature` WHERE `map` = 650;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@SPAWN_GUID+000,36558,650,1,1,0,0,726.826,661.201,412.472,4.66003,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+001,36558,650,1,1,0,0,716.665,573.495,412.475,0.977384,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+002,36558,650,1,1,0,0,705.497,583.944,412.476,0.698132,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+003,36558,650,1,1,0,0,770.486,571.552,412.475,2.05949,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+004,36558,650,1,1,0,0,717.443,660.646,412.467,4.92183,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+005,36558,650,1,1,0,0,700.531,591.927,412.475,0.523599,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+006,36558,650,1,1,0,0,790.177,589.059,412.475,2.56563,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+007,36558,650,1,1,0,0,702.165,647.267,412.475,5.68977,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+008,36558,650,1,1,0,0,773.097,660.733,412.467,4.45059,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+009,36558,650,1,1,0,0,793.052,642.851,412.474,3.63029,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+010,36558,650,1,1,0,0,778.741,576.049,412.476,2.23402,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+011,35004,650,0,1,0,0,746.675,619.318,411.091,4.79268,300,0,0,10635,0,0,0,0,0),
(@SPAWN_GUID+012,36558,650,1,1,0,0,788.016,650.788,412.475,3.80482,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+013,35644,650,1,1,0,0,704.943,651.33,412.475,5.60251,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+014,35644,650,1,1,0,0,774.898,573.736,412.475,2.14675,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+015,35644,650,1,1,0,0,699.943,643.37,412.474,5.77704,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+016,34871,650,0,1,0,0,795.968,651.859,435.421,3.6569,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+017,35644,650,1,1,0,0,793.009,592.667,412.475,2.6529,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+018,35644,650,1,1,0,0,702.967,587.649,412.475,0.610865,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+019,35644,650,1,1,0,0,768.255,661.606,412.47,4.55531,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+020,35644,650,1,1,0,0,720.569,571.285,412.475,1.06465,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+021,35644,650,1,1,0,0,787.439,584.969,412.476,2.47837,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+022,35644,650,1,1,0,0,722.363,660.745,412.468,4.83456,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+023,35644,650,1,1,0,0,790.49,646.533,412.474,3.71755,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+024,35644,650,1,1,0,0,777.564,660.3,412.467,4.34587,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+025,34990,650,0,1,0,0,807.814,618.058,435.395,3.0884,300,0,0,8367000,0,0,0,0,0),
(@SPAWN_GUID+026,35016,650,1,1,0,0,702.274,638.76,412.47,0,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+027,35016,650,1,1,0,0,697.285,618.253,412.476,0,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+028,35016,650,1,1,0,0,714.486,581.722,412.476,0,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+029,35016,650,1,1,0,0,703.884,596.601,412.474,0,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+030,35016,650,1,1,0,0,712.413,653.931,412.474,0,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+031,34977,650,1,1,0,0,733.809,545.215,442.075,1.41372,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+032,34977,650,1,1,0,0,730.998,552.719,438.812,1.3439,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+033,34977,650,1,1,0,0,734.411,560.158,435.501,1.37881,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+034,34977,650,1,1,0,0,726.38,557.151,436.978,1.25664,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+035,34979,650,1,1,0,0,709.576,570.106,435.504,0.942478,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+036,34979,650,1,1,0,0,712.873,563.172,436.967,1.02974,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+037,34979,650,1,1,0,0,714.34,553.708,440.223,1.11701,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+038,34979,650,1,1,0,0,700.273,559.224,442.08,0.925025,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+039,34966,650,1,1,0,0,718.917,564.078,435.504,1.11701,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+040,34966,650,1,1,0,0,721.971,548.191,442.072,1.23918,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+041,34966,650,1,1,0,0,718.405,555.92,438.803,1.15192,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+042,34966,650,1,1,0,0,725.661,560.835,435.503,1.23918,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+043,34858,650,1,1,0,0,697.241,583.858,435.504,0.628319,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+044,34858,650,1,1,0,0,689.635,582.823,438.819,0.558505,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+045,34858,650,1,1,0,0,696.26,577.507,436.966,0.698132,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+046,34858,650,1,1,0,0,682.856,586.2,440.243,0.471239,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+047,34858,650,1,1,0,0,688.012,573.852,442.074,0.663225,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+048,34860,650,1,1,0,0,699.005,654.894,435.504,5.53269,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+049,34860,650,1,1,0,0,693.635,654.892,436.963,5.60251,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+050,34860,650,1,1,0,0,690.486,661.661,440.209,5.55015,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+051,34860,650,1,1,0,0,684.069,656.681,442.074,5.68977,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+052,34860,650,1,1,0,0,686.866,650.837,438.779,5.75959,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+053,34861,650,1,1,0,0,677.17,640.74,442.069,6.00393,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+054,34861,650,1,1,0,0,689.436,639.259,435.503,5.95157,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+055,34861,650,1,1,0,0,679.981,648.878,440.198,5.86431,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+056,34861,650,1,1,0,0,686.392,643.351,436.973,5.88176,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+057,34861,650,1,1,0,0,692.406,644.87,435.504,5.8294,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+058,34970,650,1,1,0,0,767.512,546.841,441.991,1.66197,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+059,34970,650,1,1,0,0,761.217,549.142,440.246,1.58825,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+060,34970,650,1,1,0,0,764.08,553.434,438.828,1.8675,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+061,34857,650,1,1,0,0,675.281,589.988,442.081,0.383972,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+062,34857,650,1,1,0,0,675.115,597.719,442.073,0.279253,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+064,34857,650,1,1,0,0,692.854,590.632,435.504,0.471239,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+065,34857,650,1,1,0,0,684.964,591.017,438.848,0.418879,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+066,34975,650,1,1,0,0,779.997,550.694,442.077,2.05949,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+067,34975,650,1,1,0,0,773.502,555.516,438.825,1.95477,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+068,34859,650,1,1,0,0,687.965,629.611,435.498,6.19592,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+069,34859,650,1,1,0,0,688.731,604.689,435.501,0.20944,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+070,34859,650,1,1,0,0,677.986,634.102,440.245,5.78437,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+071,34859,650,1,1,0,0,680.599,603.986,438.794,0.191986,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+072,34859,650,1,1,0,0,685.113,600.431,436.97,0.279253,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+073,34859,650,1,1,0,0,685.118,634.405,436.976,6.0912,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+074,34868,650,1,1,0,0,806.488,574.615,442.076,2.49582,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+075,34868,650,1,1,0,0,799.194,575.25,438.801,2.37365,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+076,34974,650,1,1,0,0,790.608,559.269,442.073,2.40855,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+077,34869,650,1,1,0,0,813.502,644.877,440.254,3.49066,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+078,34869,650,1,1,0,0,818.512,640.599,442.078,3.38594,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+079,34869,650,1,1,0,0,813.3,650.717,442.073,3.49066,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+080,34856,650,1,1,0,0,813.635,587.592,442.069,2.70526,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+081,34856,650,1,1,0,0,808.157,594.937,436.87,2.8495,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+082,34856,650,1,1,0,0,806.527,586.584,438.727,2.83379,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+083,34870,650,1,1,0,0,818.163,607.13,440.209,2.94961,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+084,34870,650,1,1,0,0,818.134,626.964,440.218,3.28122,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+085,34871,650,1,1,0,0,810.608,659.83,442.086,3.68265,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+086,34871,650,1,1,0,0,800.194,660.729,438.769,3.82227,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+087,34871,650,1,1,0,0,802.709,650.685,436.877,3.64668,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+088,34905,650,1,1,0,0,696.359,653.587,435.504,5.53252,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+089,34903,650,1,1,0,0,697.116,583.052,435.504,0.628319,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+090,34902,650,1,1,0,0,689.196,597,435.503,0.349066,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+091,34883,650,1,1,0,0,687.83,617.649,435.493,1.58825,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+092,34901,650,1,1,0,0,687.16,618.132,435.489,0,86400,0,0,1,0,0,0,0,0),
(@SPAWN_GUID+093,34904,650,1,1,0,0,690.596,642,435.504,5.88176,86400,0,0,1,0,0,0,0,0),
-- (@SPAWN_GUID+094,31144,650,0,1,0,0,796.773,604.543,412.385,2.58299,300,0,0,2,0,0,0,0,0),
(@SPAWN_GUID+095,34996,650,0,1,0,546,746.725,556.492,435.396,1.59928,300,0,0,13945000,4258,0,0,0,0),
(@SPAWN_GUID+096,35491,650,0,1,0,0,799.806,639.236,475.88,2.18738,300,0,0,189000,0,2,0,0,0),
(@SPAWN_GUID+097,34992,650,0,1,0,0,809.178,624.409,435.395,3.0774,300,0,0,4505029,7981,0,0,0,0),
(@SPAWN_GUID+098,34994,650,0,1,0,0,685.637,622.2,435.395,0.074604,300,0,0,7925544,4258,0,0,0,0),
(@SPAWN_GUID+099,34995,650,0,1,0,0,686.255,615.367,435.399,0.074604,300,0,0,1394500,0,0,0,0,0),
(@SPAWN_GUID+100,34871,650,0,1,0,0,808.958,652.464,440.151,3.6027,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+101,34871,650,0,1,0,0,802.134,656.474,438.717,3.78334,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+102,34869,650,0,1,0,0,811.348,640.844,438.7,3.3121,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+103,34869,650,0,1,0,0,807.653,636.377,436.902,3.3121,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+104,34869,650,0,1,0,0,802.876,642.818,435.421,3.3121,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+105,34869,650,0,1,0,0,809.194,646.673,438.7,3.70244,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+106,34870,650,0,1,0,0,813.093,631.476,438.704,3.17465,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+107,34870,650,0,1,0,0,808.383,631.705,436.9,3.17465,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+108,34870,650,0,1,0,0,815.127,636.5,440.169,3.27833,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+109,34870,650,0,1,0,0,818.937,632.312,441.991,3.37257,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+110,34870,650,0,1,0,0,809.167,602.84,436.874,2.78274,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+111,34870,650,0,1,0,0,812.745,602.889,438.704,2.81651,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+112,34870,650,0,1,0,0,819.104,598.436,441.996,2.92254,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+113,34856,650,0,1,0,0,814.28,596.223,440.175,2.90212,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+114,34868,650,0,1,0,0,799.128,581.376,436.896,2.61309,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+115,34868,650,0,1,0,0,806.628,580.52,440.148,2.61309,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+116,34868,650,0,1,0,0,793.731,579.421,435.421,2.61309,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+117,34868,650,0,1,0,0,799.549,587.703,435.421,2.48743,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+118,34970,650,0,1,0,0,760.024,559.473,435.418,1.61249,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+119,34970,650,0,1,0,0,751.913,544.129,441.99,1.74051,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+120,34970,650,0,1,0,0,766.899,557.863,436.915,1.66197,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+121,34975,650,0,1,0,0,774.213,563.449,435.421,2.09472,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+122,34975,650,0,1,0,0,781.049,563.972,436.893,2.04367,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+123,34975,650,0,1,0,0,781.712,556.65,440.159,2.12535,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+124,34974,650,0,1,0,0,781.8,568.648,435.421,2.20939,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+125,34974,650,0,1,0,0,788.423,568.361,436.881,2.20389,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+126,34974,650,0,1,0,0,787.929,563.884,438.695,2.18504,300,0,0,42,0,0,0,0,0),
(@SPAWN_GUID+127,34857,650,1,1,0,0,689.623,598.045,435.503,0.331613,86400,0,0,1,0,0,0,0,0);
UPDATE `creature` SET `spawnMask` = 3, `spawntimesecs` = 86400 WHERE `map` = 650;

-- ----------------------
--       MONTURAS
-- ----------------------
-- Vehicleid para Warhorse, esto no trae TDB11.44
UPDATE `creature_template` SET `VehicleId`=486 WHERE `entry`=35644;
-- Spells de monturas
UPDATE `creature_template` SET `spell1` = 68505, `spell2` = 62575, `spell3` = 68282, `spell4` = 66482 WHERE `entry` IN (35644, 36558);
-- Faccion de monturas
UPDATE `creature_template` SET `faction_A` = 84, `faction_H` = 16 WHERE `entry` = 35644;
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 83 WHERE `entry` = 36558;
-- Cero addons, las spells de escudo se aplican de otra forma
DELETE FROM `creature_template_addon` WHERE `entry` IN (35644, 36558);

-- ----------------------
--     GAMEOBJECTS
-- ----------------------
-- Adios puerta anterior
DELETE FROM `gameobject` WHERE `guid` = 150081;

-- ----------------------
--     MONTURAS NPCS
-- ----------------------
-- Monturas del evento Grand Faction Champions
UPDATE `creature_template` SET `type_flags` = 2048, `ScriptName` = 'generic_vehicleAI_toc5' WHERE `entry` IN (35328, 35329, 35331, 35332, 35330, 35314, 35325, 35327, 35323, 35326);
UPDATE `creature_template` SET `type_flags` = 2048,`mechanic_immune_mask` = 617299835 WHERE `entry` IN (35572, 35569, 35571, 35570, 35617, 34705, 34702, 34701, 34657, 34703);
UPDATE `creature_template_addon` SET `auras` = LEFT(`auras`, 11) WHERE `entry` IN (35572, 35569, 35571, 35570, 35617, 34705, 34702, 34701, 34657, 34703);
-- Monturas Hero
CREATE TABLE `entry_temp` (`id` INT);
INSERT INTO `entry_temp` SELECT `difficulty_entry_1` FROM `creature_template` WHERE `entry` IN (35572, 35569, 35571, 35570, 35617, 34705, 34702, 34701, 34657, 34703);
UPDATE `creature_template` SET `type_flags` = 2048, `mechanic_immune_mask` = 617299835  WHERE `entry` IN (SELECT id FROM`entry_temp`);
UPDATE `creature_template_addon` SET `auras` = LEFT(`auras`, 11) WHERE `entry` IN (SELECT id FROM`entry_temp`);
DROP TABLE `entry_temp`;

-- ----------------------
--   EL CABALLERO NEGRO
-- ----------------------
-- Flags y configuracion de la montura
UPDATE `creature_template` SET `unit_flags` = 64 WHERE `entry` IN (35451, 35490);
DELETE FROM `vehicle_template_accessory` WHERE `entry` = 35491;
INSERT INTO `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) VALUES
(35491,35451,0,0,'Trial of the Champion - Black Knight on his gryphon',6,30000);

-- -----------------------
-- MONTURA CABALLERO NEGRO
-- -----------------------
-- Black Knight Gryphon, faccion, unitflags y vehicleid basicamente
UPDATE `creature_template` SET
`faction_A`=35,
`faction_H`=35,
`mindmg`=0,
`maxdmg`=0,
`attackpower`=0,
`dmg_multiplier`=0,
`baseattacktime`=0,
`unit_flags`=33554432,
`dynamicflags`=0,
`minrangedmg`=0,
`maxrangedmg`=0,
`rangedattackpower`=0,
`VehicleId`=486 WHERE `entry`=35491;
-- Asignacion de nombre de script
UPDATE `creature_template` SET `flags_extra` = 2, `ScriptName` = 'npc_black_knight_skeletal_gryphon' WHERE `entry` = 35491;-- S
-- Monta con spell
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 35491;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `quest_start`, `quest_start_active`, `quest_end`, `cast_flags`, `aura_required`, `aura_forbidden`, `user_type`) VALUES
(35491,46598,0,0,0,0,0,0,0);
-- Especificando que vuela y que tiene waypoints para efecto de vuelo
UPDATE `creature_template` SET `movementtype` = 2,`inhabittype` = 4 WHERE `entry` = 35491;
UPDATE `creature` SET `movementtype` = 2 WHERE `id` = 35491;
-- Waypoints (esto hay que retocar por si no queda bien)
DELETE FROM `script_waypoint` WHERE `entry` = 35491;
INSERT INTO `script_waypoint` (`entry`, `pointid`, `location_x`, `location_y`, `location_z`, `waittime`, `point_comment`) VALUES
(35491,1,781.513,657.99,466.821,0,''),
(35491,2,759.005,665.142,462.541,0,''),
(35491,3,732.937,657.164,452.678,0,''),
(35491,4,717.491,646.009,440.137,0,''),
(35491,5,707.57,628.978,431.129,0,''),
(35491,6,705.164,603.628,422.957,0,''),
(35491,7,716.351,588.49,420.802,0,''),
(35491,8,741.703,580.168,420.523,0,''),
(35491,9,761.634,586.383,422.206,0,''),
(35491,10,775.983,601.992,423.606,0,''),
(35491,11,769.051,624.686,420.035,0,''),
(35491,12,756.582,631.692,412.53,0,''),
(35491,13,744.841,634.505,411.575,2000,''),
(35491,14,759.005,665.142,462.541,0,''),
(35491,15,747.127,813.51,460.707,0,'');

-- ----------------------
--   SOLDADOS ARGENTA
-- ----------------------
-- Configuraciones
-- -- Argent Lightwielder
UPDATE `creature_template` SET `modelid3` = 0 WHERE `entry` = 35309;
UPDATE `creature_template` SET `minlevel` = 80, `maxlevel` = 80, `mindmg` = 420, `maxdmg` = 630, `attackpower` = 158, `mechanic_immune_mask` = 650854267 WHERE `entry` = 35310;
-- -- Argent Monk
UPDATE `creature_template` SET `modelid3` = 0 WHERE `entry` = 35305;
UPDATE `creature_template` SET `minlevel` = 80, `maxlevel` = 80, `mindmg` = 420, `maxdmg` = 650, `attackpower` = 158, `mechanic_immune_mask` = 650854267 WHERE `entry` = 35306;
-- -- Argent Priestess
UPDATE `creature_template` SET `modelid3` = 0 WHERE `entry` = 35307;
UPDATE `creature_template` SET `minlevel` = 80, `maxlevel` = 80, `mindmg` = 420, `maxdmg` = 630, `attackpower` = 158, `mechanic_immune_mask` = 650854267 WHERE `entry` = 35308;
-- Script Names de los Soldados Argenta
UPDATE creature_template SET ScriptName = 'npc_argent_monk' WHERE entry = 35305;
UPDATE creature_template SET ScriptName = 'npc_argent_lightwielder' WHERE entry = 35309;
UPDATE creature_template SET ScriptName = 'npc_argent_priest' WHERE entry = 35307;
-- Inmunidades de los Soldados Argenta
UPDATE `creature_template` SET `mechanic_immune_mask` = '650854267' WHERE `entry` IN (35305, 35309, 35307, 12488, 12439, 12448);
-- Ajustes para los Soldados Argenta HERO
UPDATE `creature_template` SET `Health_mod` = 29.4806 WHERE `entry`IN  (35306, 35308, 35310);
UPDATE `creature_template` SET `Health_mod` = 51.8533 WHERE `entry` = 35490;
UPDATE `creature_template` SET `Health_mod` = 16.4286 WHERE `entry` = 35451;
-- Addons para los Soldados Argenta y varias auras
DELETE FROM `creature_template_addon` WHERE `entry` IN (35305, 35306, 35307, 35308, 35309, 35310);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(35305, 0, 0, 0, 1, 27, '63501'),
(35306, 0, 0, 0, 1, 27, '63501'),
(35307, 0, 0, 0, 1, 375, '63501'),
(35308, 0, 0, 0, 1, 375, '63501'),
(35309, 0, 0, 0, 1, 375, '63501'),
(35310, 0, 0, 0, 1, 375, '63501');
DELETE FROM `creature_template_addon` WHERE (`entry` IN (35614, 35311));
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(35614, 0, 0, 0, 0, 0, 67782), -- Desecration Stalker (Periodic Desecration)
(35311, 0, 0, 0, 0, 0, 67196); -- Fountain of Light (Periodic Light rain)
UPDATE `creature_template` SET `flags_extra` = 130 WHERE `entry` = 35614; -- Set Desecration Stalker as invisible passive trigger
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 35311; -- Set Light Fountain as passive
DELETE FROM `smart_scripts` WHERE (`entryorguid`=35311 AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(35311, 0, 0, 0, 25, 0, 100, 7, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Fountain of Light - Set passive');

-- ----------------------
--       MEMORIAS
-- ----------------------
-- Hero
UPDATE `creature_template` SET `mindmg` = 330, `maxdmg` = 495, `attackpower` = 124, `baseattacktime` = 2000, `mechanic_immune_mask` = 617297499 WHERE `name` LIKE 'Memory of%(1)';
-- Normal
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16, `rank`=1, `minlevel`=82, `maxlevel`=82, `exp`=2 WHERE `name` LIKE 'Memory of %';

-- ----------------------
--    RESURRECCIONES
-- ----------------------
-- Aqui estan Arelas y Jaeren en el caballero negro
UPDATE `creature_template` SET `mindmg` = 420, `maxdmg` = 630, `attackpower` = 158 WHERE `entry` = 35717;
UPDATE `creature_template` SET `difficulty_entry_1` = 35546 WHERE `entry` = 35545;
UPDATE `creature_template` SET `difficulty_entry_1` = 35568 WHERE `entry` = 35564;
UPDATE `creature_template` SET `minlevel` = 80, `maxlevel` = 80, `mindmg` = 420, `maxdmg` = 630, `attackpower` = 158 WHERE `entry` IN (35568, 35546);
UPDATE `creature_template` SET `minlevel` = 80, `maxlevel` = 80, `baseattacktime` = 2000, `faction_A` = 14, `faction_H` = 14 WHERE `entry` IN (35564, 35568, 35545, 35546, 35717, 35590);

-- ----------------------
--     EQUIPAMIENTOS
-- ----------------------
-- Memorias equip templates
UPDATE `creature_template` SET `equipment_id` = 22 WHERE `entry` IN  (34942, 35531);
UPDATE `creature_template` SET `equipment_id` = 1431 WHERE `entry` IN (35028, 35541);
UPDATE `creature_template` SET `equipment_id` = 1178 WHERE `entry` IN (35030, 35530);
UPDATE `creature_template` SET `equipment_id` = 1330 WHERE `entry` IN (35031, 35536);
UPDATE `creature_template` SET `equipment_id` = 1808 WHERE `entry` IN (35036, 35543);
UPDATE `creature_template` SET `equipment_id` = 1496 WHERE `entry` IN (35037, 35535);
UPDATE `creature_template` SET `equipment_id` = 2216 WHERE `entry` IN (35042, 35533);
UPDATE `creature_template` SET `equipment_id` = 714 WHERE `entry` IN (35045, 35534);
UPDATE `creature_template` SET `equipment_id` = 271 WHERE `entry` IN (35049, 35529);
-- Eadric
UPDATE `creature_template` SET `equipment_id` = 833 WHERE `entry` IN (35119, 35518);
-- Champions equip templates
UPDATE `creature_template` SET `equipment_id` = 1892 WHERE `entry` IN (35572, 36089);
UPDATE `creature_template` SET `equipment_id` = 1895 WHERE `entry` IN (35569, 36085);
UPDATE `creature_template` SET `equipment_id` = 1899 WHERE `entry` IN (35571, 36090);
UPDATE `creature_template` SET `equipment_id` = 1893 WHERE `entry` IN (35570, 36091);
UPDATE `creature_template` SET `equipment_id` = 1894 WHERE `entry` IN (35617, 36084);

UPDATE `creature_template` SET `equipment_id` = 1966 WHERE `entry` IN (34705, 36088);
UPDATE `creature_template` SET `equipment_id` = 1993 WHERE `entry` IN (36082, 34702);
UPDATE `creature_template` SET `equipment_id` = 1970 WHERE `entry` IN (36083, 34701);
UPDATE `creature_template` SET `equipment_id` = 1969 WHERE `entry` IN (36086, 34657);
UPDATE `creature_template` SET `equipment_id` = 1967 WHERE `entry` IN (34703, 36087);

-- ----------------------
--     INMUNIDADES
-- ----------------------
-- Los eadric, la chica y el caballero negro
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299835 WHERE `entry` IN (34928,35517,35119,35518,35451,35490);

-- ----------------------
--       SPELLS
-- ----------------------
 DELETE FROM `spell_script_names` WHERE spell_id IN (66515, 66867, 67534, 67830, 66482);
 INSERT INTO `spell_script_names` VALUES
 (66867, 'spell_eadric_hammer_of_righteous'), -- Hammer can be picked by target if isn't under HoJ effect
 (66515, 'spell_paletress_shield'),           -- Reflect 25% of abosorbed damage
 (67534, 'spell_toc5_hex_mending'),           -- Hex of mending spell effect
 (67830, 'spell_toc5_ride_mount'),            -- Allow ride only if a Lance is equiped
 (66482, 'spell_toc5_defend');                -- Add visual shields depending on stack size
-- Trigger en eadric
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 66905;
INSERT INTO `spell_linked_spell` VALUES
(66905, -66904, 0, 'Eadric Hammer of Righteous');  -- Remove the Hammer of Righteous spell after using it
-- Condiciones en eventos en medio de la pelea
-- DELETE FROM `conditions` WHERE SourceTypeOrReferenceId = 13 AND SourceEntry IN (66905, 67705, 67715, 66798);
-- INSERT INTO `conditions` VALUES
-- (13, 0, 66905, 0, 0, 18, 1, 35119, 0, 0, 0, '', 'Eadric Hammer of Rigtheous'), -- Target Eadric with Hammer of Righteous
-- (13, 0, 66798, 0, 18, 1, 35005, 0, 0, 0, '', 'The Black Kinght - Deaths Respite'),
-- (13, 0, 66798, 0, 18, 1, 35004, 0, 0, 0, '', 'The Black Kinght - Deaths Respite'),
-- (13, 0, 67705, 0, 18, 2, 35005, 0, 0, 0, '', 'The Black Kinght - Raise Arelas Brightstar'),
-- (13, 0, 67715, 0, 18, 2, 35004, 0, 0, 0, '', 'The Black Kinght - Raise Arelas Brightstar');

-- ----------------------
--       TEXTOS
-- ----------------------
-- Aqui hubo que arreglar las tildes y demas
SET @TIRION       := 34996;
SET @THRALL       := 34994;
SET @GARROSH      := 34995;
SET @VARIAN       := 34990;
SET @JAINA        := 34992;

SET @EADRIC       := 35119;
SET @PALETRESS    := 34928;
SET @BLACK_KNIGHT := 35451;

SET @SCRIPT_TEXTS_ID := -1999900;

-- TEXTOS DEL PUBLICO Y VARIOS
DELETE FROM `script_texts` WHERE `entry` <= @SCRIPT_TEXTS_ID AND `entry` >= @SCRIPT_TEXTS_ID-24;
INSERT INTO `script_texts` (`npc_entry`,`entry`,`content_default`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(0,@SCRIPT_TEXTS_ID-00, 'El publico anima a %s.',15882,2,0,1, 'ToC5 Cheers'),
(0,@SCRIPT_TEXTS_ID-01, 'Los humanos de Ventormenta animan a %s.',13838,2,0,1, 'ToC5 Cheers'),
(0,@SCRIPT_TEXTS_ID-02, 'Los orcos de Orgrimmar animan a %s.',13839,2,0,1, 'ToC5 Cheers'),
(0,@SCRIPT_TEXTS_ID-03, 'Los enanos de Forjaz animan a %s.',13838,2,0,1, 'ToC5 Cheers'),
(0,@SCRIPT_TEXTS_ID-05, 'Los no-muertos de Entranas animan a %s.',13839,2,0,1, 'ToC5 Cheers'),
(0,@SCRIPT_TEXTS_ID-04, 'Los elfos la noche de Darnassus animan a %s.',13838,2,0,1, 'ToC5 Cheers'),
(0,@SCRIPT_TEXTS_ID-06, 'Los tauren de Cima del Trueno animan a %s.',13839,2,0,1, 'ToC5 Cheers'),
(0,@SCRIPT_TEXTS_ID-07, 'Los gnomos de Gnomeregan animan a %s.',13838,2,0,1, 'ToC5 Cheers'),
(0,@SCRIPT_TEXTS_ID-08, 'Los trol de Sen\'jin animan a %s.',13839,2,0,1, 'ToC5 Cheers'),
(0,@SCRIPT_TEXTS_ID-10, 'Los elfos de la sangre de Lunargenta animan a %s.',13839,2,0,1, 'ToC5 Cheers'),
(0,@SCRIPT_TEXTS_ID-11, 'Los draenei de Exodar animan a %s.',13838,2,0,1, 'ToC5 Cheers'),
(0,@SCRIPT_TEXTS_ID-12, '%s comienza a lanzar Pesadilla Lucida!',0,3,0,0, 'Paletress - Memory warning.'),
(0,@SCRIPT_TEXTS_ID-13, '%s comienza a lanzar Martillo del Honrado sobre $N.',0,3,0,0, 'Eadric - Combat - Warning - Hammer'),
(0,@SCRIPT_TEXTS_ID-20, '$N se ha alzado hasta el rango de $Gcampeon:campeona; en nuestro torneo. Nos orgullecemos de $Gpresentarlo:presentarla; hoy.',0,1,0,1, 'ToC5 Player presentation'),
(0,@SCRIPT_TEXTS_ID-21, '$GUn:Una; $Gpoderoso:poderosa; $Gcampeon:campeona;, $Gun:una; $Gcapacitado:capacitada; $c, $gun:una; honorable $r. Presentamos a $N.',13838,1,0,1, 'ToC5 Player presentation'),
(0,@SCRIPT_TEXTS_ID-22, 'Los campeones del torneo hablan muy bien de $Geste:esta; $c. Hoy presentamos a $N.',13838,1,0,1, 'ToC5 Player presentation'),
(0,@SCRIPT_TEXTS_ID-23, '$GUno:Una; de $glos:las; mas $gfieros:fieras; $cs en el campo de batalla, presentamos a $N.',13838,1,0,1, 'ToC5 Player presentation'),
(0,@SCRIPT_TEXTS_ID-24, 'Si aun no conoceis su nombre, estamos seguros de que lo hareis despues de este combate. Presentamos a $N.',13838,1,0,1, 'ToC5 Player presentation');

-- INTROS
DELETE FROM creature_text WHERE entry IN (35004, 35005, @TIRION, @THRALL, @GARROSH , @VARIAN , @JAINA, @EADRIC, @PALETRESS, @BLACK_KNIGHT);
INSERT INTO creature_text (entry, groupid, id, TEXT, TYPE, LANGUAGE, probability, emote, duration, sound, COMMENT) VALUES
-- -- Presentacion
(35004,0,0,'Los Atracasol estan orgullosos de presentar a sus representantes en estas pruebas de combate.',14,0,100,1,0,0,'Announcer - Player Horde Champions - Intro'),
(35005,0,0,'El Pacto de Plata esta encantado de presentar a sus luchadores para este evento, Alto Senor.',14,0,100,1,0,0,'Announcer - Player Alliance Champions - Intro'),
(@TIRION,0,0,'Bienvenidos campeones. Hoy, ante los ojos de vuestros lideres y companeros os probareis como combatientes dignos.',14,0,100,1,0,0,'Tirion - Intro'),
-- -- Horda
(@THRALL,0,0,'Luchad con fuerza, Horda! Lok\'tar Ogar!',14,0,100,1,0,0,'Thrall - Intro'),
(@GARROSH,0,0,'Por fin! Un combate digno de ser contemplado.',12,0,100,1,0,0,'Garrosh - Intro'),
(@VARIAN,0,0,'No he venido hasta aqui para ver animales despezandose entre ellos sin ningun criterio, Tirion.',12,0,100,1,0,0,'Varian - Intro'),
(@JAINA,0,0,'Son combatientes dignos, ya lo veras.',12,0,100,1,0,0,'Jaina - Intro'),
-- -- Ali
(@VARIAN,1,0,'No le veo la gracia a estos juegos, Tirion. Aun asi... Confio en que lo haran de una forma admirable.',12,0,100,1,0,0,'Thrall - Intro'),
(@JAINA,1,0,'Por supuesto que lo haran.',12,0,100,1,0,0,'Garrosh - Intro'),
(@GARROSH,1,0,'Admirable? Ja! Voy a disfrutar viendo a tus pequenos campeones fracasar, humano.',14,0,100,1,0,0,'Varian - Intro'),
(@THRALL,1,0,'Garrosh, es suficiente.',12,0,100,1,0,0,'Jaina - Intro'),
(@TIRION,1,0,'Primero os enfrentareis a tres de los Grandes Campeones del Torneo. Estos feroces contendientes han derrotado a todos los demas hasta alcanzar la maxima habilidad en la justa.',14,0,100,1,0,0,'Tirion - Intro'),

-- CAMPEONES
-- -- Horda
(35004,1,0,'Aqui llega el pequeno pero mortal Ambrose Chisparrayo, Gran Campeon de Gnomeregan.',14,0,100,1,0,0,'Announcer - Alliance Champions - Intro Mage'),
(35004,2,0,'Colosos, el enorme Gran Campeon de El Exodar, esta saliendo por la puerta.',14,0,100,1,0,0,'Announcer - Alliance Champions - Intro Shaman'),
(35004,3,0,'Esta entrando en la arena la Gran Campeona de Darnassus, la habil centinela Jaelyne Unicanto.',14,0,100,1,0,0,'Announcer - Alliance Champions - Intro Hunter'),
(35004,4,0,'Fuerte y orgulloso, aclamad al mariscal Jacob Alerius, el Gran Campeon de Ventormenta!',14,0,100,1,0,0,'Announcer - Alliance Champions - Intro Warrior'),
(35004,5,0,'Hoy el poder de los enanos esta representado por la Gran Campeona de Forjaz, Lana Martillotenaz.',14,0,100,1,0,0,'Announcer - Alliance Champions - Intro Rouge'),
-- -- Ali
(35005,1,0,'Saliendo por la puerta Eressea Cantoalba, habil maga y Gran Campeona de Lunargenta!',14,0,100,1,0,0,'Announcer - Horde Champions - Intro Mage'),
(35005,2,0,'En lo alto de su kodo, aqui esta el venerable Runok Ferocrin, Gran Campeon de Cima del Trueno!',14,0,100,1,0,0,'Announcer - Horde Champions - Intro Shaman'),
(35005,3,0,'Entrando en la arena el enjuto pero peligroso Zul\'tore, Campeon de los Sen\'jin!',14,0,100,1,0,0,'Announcer - Horde Champions - Intro Hunter'),
(35005,4,0,'Presentamos al Gran Campeon de Orgrimmar, Mokra el Trituracraneos!',14,0,100,1,0,0,'Announcer - Horde Champions - Intro Warrior'),
(35005,5,0,'Representando la tenacidad de los Renegados, aqui esta el Gran Campeon de Entranas, Mortacechador Visceri!',14,0,100,1,0,0,'Announcer - Horde Champions - Intro Rouge'),

-- ARGENTAS
(@TIRION,2,0,'Buen combate! Vuestro proximo reto viene de los mismisimos cargos de la Cruzada. Sereis puestos a prueba contra sus considerables habilidades.',14,0,100,1,0,0,'Tirion - Intro'),
-- -- Eadric
(35004,11,0,'Entrando en la arena, tenemos a un paladin que no es un extrano para los campos de batalla, ni los Campos del Torneo. El gran campeon de la Cruzada Argenta, Eadric el Puro!',14,0,100,1,0,0,'Announcer - Eadric - Intro'),
(35005,11,0,'Entrando en la arena, tenemos a un paladin que no es un extrano para los campos de batalla, ni los Campos del Torneo. El gran campeon de la Cruzada Argenta, Eadric el Puro!',14,0,100,1,0,0,'Announcer - Eadric - Intro'),
(@EADRIC,10,0,'Aceptais el reto? No hay vuelta atras!',12,0,100,1,0,16134,'Eadric - Intro'),
-- -- Paletress
(35004,12,0,'La siguiente combatiente no tiene rival alguno en su pasion al apoyar a la Luz. Les entrego a la confesora Argenta Cabelloclaro!',14,0,100,1,0,0,'Announcer - Paletress - Intro'),
(35005,12,0,'La siguiente combatiente no tiene rival alguno en su pasion al apoyar a la Luz. Les entrego a la confesora Argenta Cabelloclaro!',14,0,100,1,0,0,'Announcer - Paletress - Intro'),
(@PALETRESS,10,0,'Gracias buen heraldo. Tus palabras son muy amables.',12,0,100,1,0,16245,'Paletress - Intro'),
(@PALETRESS,11,0,'Que la luz me de fuerzas para ser un reto digno.',12,0,100,1,0,16246,'Paletress - Intro'),
-- -- Tirion
(@TIRION,3,0,'Podeis comenzar!',14,0,100,1,0,0,'Tirion - Intro'),

-- CABALLERO NEGRO
(@TIRION,4,0,'Bien hecho. Habeis probado vuestra valia hoy...',14,0,100,1,0,0,'Tirion - Intro'),
(35004,13,0,'Que es eso que hay cerca de las vigas?',12,0,100,1,0,0,'Announcer - Black Knight - Intro'),
(35005,13,0,'Que es eso que hay cerca de las vigas?',12,0,100,1,0,0,'Announcer - Black Knight - Intro'),
(@BLACK_KNIGHT,10,0,'Has estropeado mi gran entrada, rata.',12,0,100,1,0,16256,'Black Knight - Intro'),
(@TIRION,5,0,'Que significa esto?',14,0,100,1,0,0,'Tirion - Intro'),
(@BLACK_KNIGHT,11,0,'Realmente pensabas que derrotarias a un agente del Rey Exanime en los campos de tu patetico torneo?',12,0,100,1,0,16257,'Black Knight - Intro'),
(@BLACK_KNIGHT,12,0,'He venido a terminar mi cometido.',12,0,100,1,0,16258,'Black Knight - Intro'),
(@GARROSH,10,0,'Hacedlo picadillo!',14,0,100,1,0,0,'Garrosh - Black Knight - Intro'),
(@VARIAN,10,0,'No os quedeis ahi mirando; matadlo!',14,0,100,1,0,0,'Varian - Black Knight - Intro'),

-- TEXTOS EN COMBATES
-- -- Eadric
(@EADRIC,1,0,'Preparaos!',14,0,100,0,0,16135,'Eadric - Combat - Aggro'),
(@EADRIC,2,0,'Martillo del honrado!',14,0,100,0,0,16136,'Eadric - Combat - Hammer'),
(@EADRIC,3,0,'Tu! Tienes que practicar mas!',14,0,100,0,0,16137,'Eadric - Combat - Slay 1'),
(@EADRIC,3,1,'No! No! Y otra vez no! No es suficiente!',14,0,100,0,0,16138,'Eadric - Combat - Slay 2'),
(@EADRIC,4,0,'Me rindo! Lo admito. Un trabajo excelente. Puedo escaparme ya?',14,0,100,0,0,16139,'Eadric - Combat - Death'),
(@EADRIC,5,0,'%s comienza a irradiar luz. Cubrios los ojos!',41,0,100,0,0,0,'Eadric - Combat - Warning - Radiance'),
-- -- Paletress
(@PALETRESS,1,0,'Bien entonces. Comencemos.',14,0,100,0,0,16247,'Paletress - Combat - Aggro'),
(@PALETRESS,2,0,'Aprovecha este tiempo para pensar en tus hazanas.',14,0,100,0,0,16248,'Paletress - Combat - Summon Memory'),
(@PALETRESS,3,0,'Descansa.',14,0,100,0,0,16250,'Paletress - Combat - Slay 1'),
(@PALETRESS,3,1,'Ve en paz.',14,0,100,0,0,16251,'Paletress - Combat - Slay 2'),
(@PALETRESS,4,0,'Un trabajo excelente!',14,0,100,0,0,16252,'Paletress - Combat - Death'),
(@PALETRESS,5,0,'Incluso el recuerdo mas oscuro se desvanece al afrontarlo.',14,0,100,0,0,16249,'Paletress - Combat - Memory dies'),
-- -- Black Knight
(@BLACK_KNIGHT,1,0,'Esta farsa acaba aqui!',14,0,100,0,0,16259,'Black Knight - Combat - Aggro'),
(@BLACK_KNIGHT,2,0,'Patetico.',14,0,100,0,0,16260,'Black Knight - Combat - Slay 1'),
(@BLACK_KNIGHT,2,1,'Que desperdicio!',14,0,100,0,0,16261,'Black Knight - Combat - Slay 2'),
(@BLACK_KNIGHT,3,0,'Me estorbaba esa carne putrefacta!',14,0,100,0,0,16262,'Black Knight - Combat - Skeleton Res'),
(@BLACK_KNIGHT,4,0,'No necesito huesos para vencerte.',14,0,100,0,0,16263,'Black Knight - Combat - Ghost Res'),
(@BLACK_KNIGHT,5,0,'No! No debo fallar... otra vez...',14,0,100,0,0,16264,'Black Knight - Combat - Death');

-- ----------------------
--        LOGROS
-- ----------------------
-- Achievements
DELETE FROM achievement_criteria_data WHERE criteria_id IN (11863, 11420, 12439, 11858);
DELETE FROM achievement_criteria_data WHERE criteria_id BETWEEN 12298 AND 12306;
DELETE FROM achievement_criteria_data WHERE criteria_id BETWEEN 12310 AND 12324;
DELETE FROM achievement_criteria_data WHERE criteria_id BETWEEN 11904 AND 11927;
INSERT INTO `achievement_criteria_data` VALUES
-- Champion achievements (Normal)
(11420, 18, 0, 0, ''),
(12298, 18, 0, 0, ''),
(12299, 18, 0, 0, ''),
(12300, 18, 0, 0, ''),
(12301, 18, 0, 0, ''),
(12302, 18, 0, 0, ''),
(12303, 18, 0, 0, ''),
(12304, 18, 0, 0, ''),
(12305, 18, 0, 0, ''),
(12306, 18, 0, 0, ''),
-- Champion achievements (Hero)
(12310, 18, 0, 0, ''),
(12311, 18, 0, 0, ''),
(12312, 18, 0, 0, ''),
(12313, 18, 0, 0, ''),
(12314, 18, 0, 0, ''),
(12318, 18, 0, 0, ''),
(12319, 18, 0, 0, ''),
(12320, 18, 0, 0, ''),
(12321, 18, 0, 0, ''),
(12322, 18, 0, 0, ''),
-- Memories achievment
(11863, 18, 0, 0, ''),
(11904, 18, 0, 0, ''),
(11905, 18, 0, 0, ''),
(11906, 18, 0, 0, ''),
(11907, 18, 0, 0, ''),
(11908, 18, 0, 0, ''),
(11909, 18, 0, 0, ''),
(11910, 18, 0, 0, ''),
(11911, 18, 0, 0, ''),
(11912, 18, 0, 0, ''),
(11913, 18, 0, 0, ''),
(11914, 18, 0, 0, ''),
(11915, 18, 0, 0, ''),
(11916, 18, 0, 0, ''),
(11917, 18, 0, 0, ''),
(11918, 18, 0, 0, ''),
(11919, 18, 0, 0, ''),
(11920, 18, 0, 0, ''),
(11921, 18, 0, 0, ''),
(11922, 18, 0, 0, ''),
(11923, 18, 0, 0, ''),
(11924, 18, 0, 0, ''),
(11925, 18, 0, 0, ''),
(11926, 18, 0, 0, ''),
(11927, 18, 0, 0, ''),
-- Champion achievements (Hero)
(12310, 12, 1, 0, ''),
(12311, 12, 1, 0, ''),
(12312, 12, 1, 0, ''),
(12313, 12, 1, 0, ''),
(12314, 12, 1, 0, ''),
(12315, 12, 1, 0, ''),
(12316, 12, 1, 0, ''),
(12317, 12, 1, 0, ''),
(12318, 12, 1, 0, ''),
(12319, 12, 1, 0, ''),
(12320, 12, 1, 0, ''),
(12321, 12, 1, 0, ''),
(12322, 12, 1, 0, ''),
(12323, 12, 1, 0, ''),
(12324, 12, 1, 0, ''),
(12439, 12, 1, 0, ''),
-- Faceroller achievement
(11858, 12, 1, 0, ''),
-- Memories achievement
(11863, 12, 1, 0, ''),
(11904, 12, 1, 0, ''),
(11905, 12, 1, 0, ''),
(11906, 12, 1, 0, ''),
(11907, 12, 1, 0, ''),
(11908, 12, 1, 0, ''),
(11909, 12, 1, 0, ''),
(11910, 12, 1, 0, ''),
(11911, 12, 1, 0, ''),
(11912, 12, 1, 0, ''),
(11913, 12, 1, 0, ''),
(11914, 12, 1, 0, ''),
(11915, 12, 1, 0, ''),
(11916, 12, 1, 0, ''),
(11917, 12, 1, 0, ''),
(11918, 12, 1, 0, ''),
(11919, 12, 1, 0, ''),
(11920, 12, 1, 0, ''),
(11921, 12, 1, 0, ''),
(11922, 12, 1, 0, ''),
(11923, 12, 1, 0, ''),
(11924, 12, 1, 0, ''),
(11925, 12, 1, 0, ''),
(11926, 12, 1, 0, ''),
(11927, 12, 1, 0, '');

-- ----------------------
--       AJUSTES
-- ----------------------
-- Basicamente dano y armor
-- Tial of the Champion (Normal)
UPDATE `creature_template`
    SET `dmg_multiplier` = CASE `entry`
        -- Faction Grand Champions
        WHEN 35572 THEN 11.2 -- Grand Champion Warrior
        WHEN 34705 THEN 11.2
        WHEN 35569 THEN 10.2 -- Grand Champion Mage
        WHEN 34702 THEN 10.2
        WHEN 34701 THEN 10.2 -- Grand Champion Shaman
        WHEN 35571 THEN 10.2
        WHEN 35570 THEN 10.2 -- Grand Champion Hunter
        WHEN 34657 THEN 10.2
        WHEN 35617 THEN 10.2 -- Grand Champion Rouge
        WHEN 34703 THEN 10.2
        -- Argent Challenge
        WHEN 35305 THEN 8    -- Argent Monk
        WHEN 35307 THEN 5.5  -- Argent Priestess
        WHEN 35309 THEN 8.4  -- Argent Lightwielder
        WHEN 35119 THEN 14.5 -- Eadric the Pure
        WHEN 34928 THEN 14.5 -- Argent Confessor Paletress
        -- Black Knight Encounter
        WHEN 35564 THEN 1.4  -- Risen Arelas Brightstar
        WHEN 35545 THEN 1.4  -- Risen Jaeren Sunsworn
        WHEN 35590 THEN 1.5  -- Risen Champion
        WHEN 35451 THEN 11.8 -- Black Knight
    END,
    `Armor_mod` = CASE `entry`
        -- Faction Grand Champions
        WHEN 35572 THEN 1    -- Grand Champion Warrior
        WHEN 34705 THEN 1
        WHEN 35569 THEN 1    -- Grand Champion Mage
        WHEN 34702 THEN 1
        WHEN 34701 THEN 1    -- Grand Champion Shaman
        WHEN 35571 THEN 1
        WHEN 35570 THEN 1    -- Grand Champion Hunter
        WHEN 34657 THEN 1
        WHEN 35617 THEN 1    -- Grand Champion Rouge
        WHEN 34703 THEN 1
        -- Argent Challenge
        WHEN 35305 THEN 1    -- Argent Monk
        WHEN 35307 THEN 1    -- Argent Priestess
        WHEN 35309 THEN 1    -- Argent Lightwielder
        WHEN 35119 THEN 1    -- Eadric the Pure
        WHEN 34928 THEN 1    -- Argent Confessor Paletress
        -- Black Knight Encounter
        WHEN 35564 THEN 1    -- Risen Arelas Brightstar
        WHEN 35545 THEN 1    -- Risen Jaeren Sunsworn
        WHEN 35590 THEN 1    -- Risen Champion
        WHEN 35451 THEN 1    -- Black Knight
    END
WHERE `entry` IN (35572, 34705, 35569, 34702, 34701, 35571, 35570, 34657, 35617, 34703, 35305, 35307, 35309, 35119, 34928, 35564, 35545, 35590, 35451);

-- Tial of the Champion (Heroic)
UPDATE `creature_template`
    SET `dmg_multiplier` = CASE `entry`
    -- Heroic difficult
        -- Faction Grand Champions
        WHEN 36088 THEN 13   -- Grand Champion Warrior
        WHEN 36089 THEN 13
        WHEN 36085 THEN 13   -- Grand Champion Mage
        WHEN 36082 THEN 13
        WHEN 36083 THEN 13   -- Grand Champon Shaman
        WHEN 36090 THEN 13
        WHEN 36091 THEN 13   -- Grand Champion Hunter
        WHEN 36086 THEN 13
        WHEN 36084 THEN 13   -- Grand Champion Rouge
        WHEN 36087 THEN 13
        -- Argent Challenge
        WHEN 35306 THEN 16   -- Argent Monk
        WHEN 35308 THEN 11   -- Argent Priestess
        WHEN 35310 THEN 16.8 -- Argent Lightwielder
        WHEN 35518 THEN 13   -- Eadric the Pure
        WHEN 35517 THEN 13   -- Argent Confessor Paletress
        -- Black Knight Encounter
        WHEN 35568 THEN 3    -- Risen Arelas Brightstar
        WHEN 35546 THEN 3    -- Risen Jaeren Sunsworn
        WHEN 35717 THEN 3    -- Risen Champion
        WHEN 35490 THEN 17.6 -- Black Knight (Heroic)
    END,
    `Armor_mod` = CASE `entry`
        -- Faction Grand Champions
        WHEN 36088 THEN 1    -- Grand Champion Warrior
        WHEN 36089 THEN 1
        WHEN 36085 THEN 1    -- Grand Champion Mage
        WHEN 36082 THEN 1
        WHEN 36083 THEN 1    -- Grand Champon Shaman
        WHEN 36090 THEN 1
        WHEN 36091 THEN 1    -- Grand Champion Hunter
        WHEN 36086 THEN 1
        WHEN 36084 THEN 1    -- Grand Champion Rouge
        WHEN 36087 THEN 1
        -- Argent Challenge
        WHEN 35306 THEN 1    -- Argent Monk
        WHEN 35308 THEN 1    -- Argent Priestess
        WHEN 35310 THEN 1    -- Argent Lightwielder
        WHEN 35518 THEN 1    -- Eadric the Pure
        WHEN 35517 THEN 1    -- Argent Confessor Paletress
        -- Black Knight Encounter
        WHEN 35568 THEN 1    -- Risen Arelas Brightstar
        WHEN 35546 THEN 1    -- Risen Jaeren Sunsworn
        WHEN 35717 THEN 1    -- Risen Champion
        WHEN 35490 THEN 1    -- Black Knight (Heroic)
    END
WHERE `entry` IN (36088, 36089, 36085, 36082, 36083, 36090, 36091, 36086, 36084, 36087, 35306, 35308, 35310, 35518, 35517, 35568, 35546, 35717, 35490);-- Eilo (https://github.com/eilo)
-- Svala correccion de sus flags para atacarle
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~254&~2 WHERE `entry` IN (29281,30809);
UPDATE `creature` SET `unit_flags`=0,`dynamicflags`=`dynamicflags`&~32 WHERE `id` IN (29281,30809);
-- ------------- Script name Instance fix Eilo ----------------
-- ------------------------------------------------------------
UPDATE `instance_template` SET `Script`='instance_ruby_sanctum' WHERE `map`=724;
-- -------------- Script name Npcs fix ws ---------------------
-- ------------------------------------------------------------
UPDATE `creature_template` SET `ScriptName`='npc_convocadora_carboescala' WHERE `entry`=40417;
UPDATE `creature_template` SET `ScriptName`='npc_acometedor_carboescala' WHERE `entry`=40419;
UPDATE `creature_template` SET `ScriptName`='npc_elite_carboescala'  WHERE `entry`=40421;
UPDATE `creature_template` SET `ScriptName`='npc_comandante_carboescala'  WHERE `entry`=40423;
UPDATE `creature_template` SET `ScriptName`='boss_halion_real'  WHERE `entry`=39751;
UPDATE `creature_template` SET `ScriptName`='mob_baltharus_clone'  WHERE `entry`=39899;
UPDATE `creature_template` SET `ScriptName`='mob_xerestrasza'  WHERE `entry`=40429;
UPDATE `creature_template` SET `ScriptName`='boss_halion_twilight'  WHERE `entry`=40142;
UPDATE `creature_template` SET `ScriptName`='mob_halion_meteor'  WHERE `entry`=40029;
UPDATE `creature_template` SET `ScriptName`='mob_halion_flame'  WHERE `entry`=40041;
UPDATE `creature_template` SET `ScriptName`='mob_halion_orb'  WHERE `entry`=40083;
UPDATE `creature_template` SET `ScriptName`='mob_halion_control'  WHERE `entry`=40146;
UPDATE `creature_template` SET `ScriptName`='mob_orb_rotation_focus'  WHERE `entry`=40091;
UPDATE `creature_template` SET `ScriptName`='mob_orb_carrier'  WHERE `entry`=40081;
UPDATE `creature_template` SET `ScriptName`='mob_soul_consumption'  WHERE `entry`=40135;
UPDATE `creature_template` SET `ScriptName`='mob_fiery_combustion'  WHERE `entry`=40001;
UPDATE `creature_template` SET `ScriptName`='boss_ragefire'  WHERE `entry`=39747;
UPDATE `creature_template` SET `ScriptName`='boss_zarithrian'  WHERE `entry`=39746;
UPDATE `creature_template` SET `ScriptName`='mob_flamecaller_ruby'  WHERE `entry`=39814;
UPDATE `creature_template` SET `ScriptName`='boss_baltharus' WHERE `entry`=39751;
-- ---------------- Respawn Npcs fix Eilo ---------------------
-- ------------------------------------------------------------
-- Bosses
UPDATE `creature` SET `spawntimesecs`=604800 WHERE `id` IN (39751,39746,39747);
-- Trash mobs
UPDATE `creature` SET `spawntimesecs`=1209600 WHERE `map`=724 AND `id` NOT IN (39751,39746,39747);
-- --------- Dragones fin evento (custom) fix ws --------------
-- ------------------------------------------------------------
replace INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES
(3470008, 0, 0, 0, 0, 0, 2718, 0, 0, 0, 'Ruby Dragon', 'WS-CORE', 'WS-CORE', 0, 80, 80, 0, 2010, 2010, 0, 3, 3, 1.4, 0, 420, 630, 0, 158, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 2, 4096, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 378.538, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 'npc_D_ws2', 0);
-- --------- Script name objetos fix ws -----------------------
-- ------------------------------------------------------------
UPDATE `gameobject_template` SET `data10` = 74807, `faction` = '0', `ScriptName` = 'go_halion_portal_twilight' WHERE `gameobject_template`.`entry` IN (202794,202795);
UPDATE `gameobject_template` SET `faction` = '0', `ScriptName` = 'go_halion_portal_real' WHERE `gameobject_template`.`entry` IN (202796);
-- --------- Spell script de rubi fix ws ----------------------
-- ------------------------------------------------------------
-- spell_halion_fiery_combustion 74562
DELETE FROM `spell_script_names` WHERE `spell_id`=74562 AND `ScriptName`='spell_halion_fiery_combustion';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (74562,'spell_halion_fiery_combustion');
-- spell_halion_soul_consumption 74792
DELETE FROM `spell_script_names` WHERE `spell_id`=74792 AND `ScriptName`='spell_halion_soul_consumption';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (74792,'spell_halion_soul_consumption');
-- spell_twilight_cutter 74768
-- DELETE FROM `spell_script_names` WHERE `spell_id`=74562 AND `ScriptName`='spell_twilight_cutter';
replace INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (74768,'spell_twilight_cutter');
-- ---------- Ws core Traduccion de Rubi event ---------------
-- -------- Textos a�adidos por Eilo y retoques --------------
-- -----------------------------------------------------------
replace into `script_texts`(`npc_entry`,`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) values
(40429,-1666000,'Help! I am trapped within this tree! I require aid!',NULL,NULL,NULL,NULL,NULL,'Ayuda estoy atrapada dentro del arbol! ayudadme!',NULL,NULL,17490,6,0,0,'SAY_XERESTRASZA_YELL_1'),
(40429,-1666001,'Thank you! I could have not held out for much longer. A terrible thing has happened here.',NULL,NULL,NULL,NULL,NULL,'Gracias no podia aguantar mucho mas! Aqui ha sucedido algo terrible!',NULL,NULL,17491,0,0,0,'SAY_XERESTRASZA_YELL_2'),
(40429,-1666002,'We believed that the Sanctum was well fortified, but we were not prepareted for the nature of this assault.',NULL,NULL,NULL,NULL,NULL,'creiamos que el sagrario estaba bien protegido, pero no estabamos preparado para un ataque como este',NULL,NULL,17492,0,0,0,'SAY_XERESTRASZA_SAY_1'),
(40429,-1666003,'The Black Dragonkin materialized from thin air, and set upon us before we could react.',NULL,NULL,NULL,NULL,NULL,'Los dragoneantes negros aparecieron de la nada y atacaron antes de que pudieramos reaccionar.',NULL,NULL,17493,0,0,0,'SAY_XERESTRASZA_SAY_2'),
(40429,-1666004,'We did not stand a chance. As my brethren perished around me, I managed to retreat here and bar the entrance.',NULL,NULL,NULL,NULL,NULL,'La defensa fue inutil! Mientras mis hermanos morian consegui retirarme aqui y bloquear la entrada',NULL,NULL,17494,0,0,0,'SAY_XERESTRASZA_SAY_3'),
(40429,-1666005,'They slaughtered us with cold efficiency, but the true focus of their interest seemed to be the eggs kept here in the sanctum.',NULL,NULL,NULL,NULL,NULL,'Fue una masacre calculada y eficaz pero su verdadero objetivo eran los huevos que guardamos en el sagrario.',NULL,NULL,17495,0,0,0,'SAY_XERESTRASZA_SAY_4'),
(40429,-1666006,'The commander of the forces on the ground here is a cruel brute named Zarithrian. But I fear there are greater powers at work.',NULL,NULL,NULL,NULL,NULL,'El comandante de las fuerzas terrestre es un bruto cruel llamado Zarithrian, pero me temo que hay implicados poderes mayores',NULL,NULL,17496,0,0,0,'SAY_XERESTRASZA_SAY_5'),
(40429,-1666007,'In their initial assault I caught a glimpse of their true leader, a fearsome full-grown Twilight Dragon.',NULL,NULL,NULL,NULL,NULL,'En el ataque inicial, pude ver a su verdadero lider, un temible dragon crepuscular adulto.',NULL,NULL,17497,0,0,0,'SAY_XERESTRASZA_SAY_6'),
(40429,-1666008,'I know not the extent of their plans heroes, but I know this: they cannot be allowed to succeed!',NULL,NULL,NULL,NULL,NULL,'No conozco todos sus planes heroes pero se, que no debemos permitir que tengan exito.',NULL,NULL,17498,0,0,0,'SAY_XERESTRASZA_SAY_7'),
(39863,-1666100,'Meddlesome insects, you\'re too late! The Ruby Sanctum is lost.',NULL,NULL,NULL,NULL,NULL,'Insectos entrometidos... llegais tarde... el sagrario rubi esta perdido.',NULL,NULL,17499,6,0,0,'SAY_HALION_SPAWN'),
(39863,-1666101,'Your world teeters on the brink of annihilation. You will all bear witness to the coming of a new age of destruction!',NULL,NULL,NULL,NULL,NULL,'Vuestro mundo esta al borde de la aniquilacion. todos sereis testigo de la llegada de una nueva era de destruccion!',NULL,NULL,17500,6,0,0,'SAY_HALION_AGGRO'),
(39863,-1666102,'Another hero falls.',NULL,NULL,NULL,NULL,NULL,'Cae... otro... heroe!',NULL,NULL,17501,6,0,0,'SAY_HALION_SLAY_1'),
(39863,-1666103,'Ha Ha Ha!',NULL,NULL,NULL,NULL,NULL,'jajajajaja...',NULL,NULL,17502,6,0,0,'SAY_HALION_SLAY_2'),
(39863,-1666104,'Relish this victory mortals, for it will be your last. This world will burn with the Master\'s return!',NULL,NULL,NULL,NULL,NULL,'Disfrutad la victoria mortales por que sera la ultima. este mundo ardera cuando vuelva el maestro.',NULL,NULL,17503,6,0,0,'SAY_HALION_DEATH'),
(39863,-1666105,'Not good enough!',NULL,NULL,NULL,NULL,NULL,'No es suficiente.',NULL,NULL,17504,6,0,0,'SAY_HALION_BERSERK'),
(39863,-1666106,'The heavens burn!',NULL,NULL,NULL,NULL,NULL,'Los cielos arden.',NULL,NULL,17505,6,0,0,'SAY_HALION_SPECIAL_1'),
(39863,-1666107,'Beware the shadow!',NULL,NULL,NULL,NULL,NULL,'Temed la sombra.',NULL,NULL,17506,6,0,0,'SAY_HALION_SPECIAL_2'),
(39863,-1666108,'You will find only suffering within the realm of Twilight. Enter if you dare.',NULL,NULL,NULL,NULL,NULL,'En el reino del crepusculo solo encontrareis sufrimiento. Entrad si os atreveis.',NULL,NULL,17507,6,0,0,'SAY_HALION_PHASE_2'),
(39863,-1666109,'I am the light AND the darkness! Cower mortals before the Herald of Deathwing!',NULL,NULL,NULL,NULL,NULL,'Yo soy la luz y la oscuridad. Temed mortales la llegada de Alamuerte.',NULL,NULL,17508,6,0,0,'SAY_HALION_PHASE_3'),
(39863,-1666110,'The orbiting spheres pulse with dark energy!',NULL,NULL,NULL,NULL,NULL,'Los orbes rotan pulsando energia oscura!',NULL,NULL,0,3,0,0,''),
(39863,-1666111,'Your efforts have forced Halion further into the Physical realm!',NULL,NULL,NULL,NULL,NULL,'Tus esfuerzos han enviado a Halion al reino fisico!',NULL,NULL,0,3,0,0,''),
(39863,-1666112,'Your efforts have forced Halion further into the Twilight realm!',NULL,NULL,NULL,NULL,NULL,'Tus esfuerzos han enviado a Halion al reino crepuscular!',NULL,NULL,0,3,0,0,''),
(39863,-1666113,'Without pressure in both realms, Halion begins to regenerate.',NULL,NULL,NULL,NULL,NULL,'Sin presion en ambos reinos, Halion restaurara vitalidad.',NULL,NULL,0,3,0,0,''),
(39746,-1666200,'Alexstrasza has chosen capable allies. A pity that I must end you!',NULL,NULL,NULL,NULL,NULL,'Alexstrasza sabe elegir bien a sus aliados. Lastima tener que mataros.',NULL,NULL,17512,6,0,0,'SAY_ZARITHRIAN_AGGRO'),
(39746,-1666201,'You thought you stood a chance?',NULL,NULL,NULL,NULL,NULL,'�Pensabas sobrevivir?',NULL,NULL,17513,6,0,0,'SAY_ZARITHRIAN_SLAY_1'),
(39746,-1666202,'It\'s for the best.',NULL,NULL,NULL,NULL,NULL,'Es por tu bien...',NULL,NULL,17514,6,0,0,'SAY_ZARITHRIAN_SLAY_2'),
(39746,-1666203,'Halion! I\'m...aah!',NULL,NULL,NULL,NULL,NULL,'Halion... yo... ohhhggg...',NULL,NULL,17515,6,0,0,'SAY_ZARITHRIAN_DEATH'),
(39746,-1666204,'Turn them to ash, minions!',NULL,NULL,NULL,NULL,NULL,'�Reducidlos a cenizas, esbirros!!',NULL,NULL,17516,6,0,0,'SAY_ZARITHRIAN_SPECIAL_1'),
(39751,-1666300,'Ah, the entertainment has arrived...',NULL,NULL,NULL,NULL,NULL,'ahh... �Ha llegado la diversion',NULL,NULL,17520,6,0,0,'SAY_BALTHARUS_AGGRO'),
(39751,-1666301,'Baltharus leaves no survivors!',NULL,NULL,NULL,NULL,NULL,'�Baltharus no deja supervivientes!',NULL,NULL,17521,6,0,0,'SAY_BALTHARUS_SLAY_1'),
(39751,-1666302,'This world has enough heroes!',NULL,NULL,NULL,NULL,NULL,'�Ya es suficiente heroes!',NULL,NULL,17522,6,0,0,'SAY_BALTHARUS_SLAY_2'),
(39751,-1666303,'I...didn\'t see that coming...',NULL,NULL,NULL,NULL,NULL,'AArG� �no lo vi venir!!',NULL,NULL,17523,1,0,0,'SAY_BALTHARUS_DEATH'),
(39751,-1666304,'Twice the pain and half the fun!',NULL,NULL,NULL,NULL,NULL,'El doble de dolor y la mitad de diversion',NULL,NULL,17524,6,0,0,'SAY_BALTHARUS_SPECIAL_1'),
(39751,-1666305,'Your power wanes, ancient one! Soon, you will join your friends!',NULL,NULL,NULL,NULL,NULL,'Tu poder decae, ancestro. Pronto te uniras a tus amigos.',NULL,NULL,17525,6,0,0,'SAY_BALTHARUS_YELL'),
(39747,-1666400,'You will suffer for this intrusion...',NULL,NULL,NULL,NULL,NULL,'Sufrireis por esta intrusion!',NULL,NULL,17528,6,0,0,'SAY_SAVIANA_AGGRO'),
(39747,-1666401,'As it should be!',NULL,NULL,NULL,NULL,NULL,'�Como debe ser!',NULL,NULL,17529,6,0,0,'SAY_SAVIANA_SLAY_1'),
(39747,-1666402,'Halion will be pleased...',NULL,NULL,NULL,NULL,NULL,'Halion estara satisfecho',NULL,NULL,17530,6,0,0,'SAY_SAVIANA_SLAY_2'),
(39747,-1666403,'OOHHAH...',NULL,NULL,NULL,NULL,NULL,'OOHHAH...',NULL,NULL,17531,6,0,0,'SAY_SAVIANA_DEATH'),
(39747,-1666404,'Burn in the master\'s flame!',NULL,NULL,NULL,NULL,NULL,'Arded en la llama del maestro!',NULL,NULL,17532,6,0,0,'SAY_SAVIANA_SPECIAL_1'),
(39747,-1666405,'|3-3(%s) fall into a trance!\r\n',NULL,NULL,NULL,NULL,NULL,'|3-3(%s) cae en un trance!\r\n',NULL,NULL,0,3,0,0,'');
-- ---------- Spawn del Anillo de fuego fix Eilo --------------
-- ------------------------------------------------------------
-- SET @OGUID = 152192; -- Need 1 (Set by TDB team)
-- INSERT INTO `gameobject` (`guid`,`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
-- (@OGUID,203624,724,15,1,3154.99,535.637,72.887,3.14159,0,0,0,0,120,0,0); -- GO_TWILIGHT_FLAME_RING
-- ---------------- Spawn hero y otros fix ws -----------------
-- ------------------------------------------------------------
REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40081, 40470, 40471, 40472, 0, 0, 169, 11686, 0, 0, 'Orb Carrier', '', '', 0, 80, 80, 2, 14, 14, 0, 1.2, 0.428571, 1, 0, 420, 630, 0, 157, 1, 2000, 2000, 1, 1, 0, 0, 0, 0, 0, 0, 336, 504, 126, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 718, 0, 0, '', 0, 7, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 76, 0, 0, 0, 128, 'mob_orb_carrier', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40083, 0, 0, 0, 0, 0, 32754, 0, 0, 0, 'Shadow Orb', '', '', 0, 80, 80, 2, 14, 14, 0, 2.4, 0.857143, 1, 0, 420, 630, 0, 157, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 10, 1048576, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 106, 1, 0, 0, 0, 'mob_halion_orb', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40091, 43280, 43281, 43282, 0, 0, 169, 11686, 0, 0, 'Orb Rotation Focus', '', '', 0, 80, 80, 2, 14, 14, 0, 2.2, 0.785714, 1, 0, 420, 630, 0, 157, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 10, 1048576, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 98, 1, 0, 0, 128, 'mob_orb_rotation_focus', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40100, 0, 0, 0, 0, 0, 32754, 0, 0, 0, 'Shadow Orb', '', '', 0, 80, 80, 2, 14, 14, 0, 2.4, 0.857143, 1, 0, 420, 630, 0, 157, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 4, 1048576, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 106, 1, 0, 0, 0, 'mob_halion_orb', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40142, 40143, 40144, 40145, 0, 0, 31952, 0, 0, 0, 'Halion', 'The Twilight Destroyer', '', 0, 83, 83, 2, 14, 14, 0, 1.6, 1.42857, 1, 3, 468, 702, 0, 175, 74.6, 2000, 2000, 1, 768, 0, 0, 0, 0, 0, 0, 374, 562, 140, 2, 1132, 0, 0, 0, 0, 0, 0, 0, 0, 0, 26662, 74524, 74562, 74531, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 800, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 803160063, 1, 'boss_halion_twilight', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40146, 0, 0, 0, 0, 0, 169, 11686, 0, 0, 'Halion Controller', '', '', 0, 80, 80, 2, 14, 14, 0, 2.8, 1, 1, 0, 420, 630, 0, 157, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 10, 1048576, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 118, 1, 0, 0, 128, 'mob_halion_control', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (39863, 39864, 39944, 39945, 0, 0, 31952, 0, 0, 0, 'Halion', 'The Twilight Destroyer', '', 0, 83, 83, 2, 14, 14, 0, 1, 1.42857, 1, 3, 468, 702, 0, 175, 74.2, 2000, 2000, 1, 768, 0, 0, 0, 0, 0, 0, 374, 562, 140, 2, 108, 39863, 0, 0, 0, 0, 0, 0, 0, 0, 26662, 74524, 74562, 74531, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 800, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 803160063, 1, 'boss_halion_real', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (39751, 39920, 0, 0, 0, 0, 31761, 0, 0, 0, 'Baltharus the Warborn', '', '', 0, 83, 83, 2, 103, 103, 0, 2.8, 1.71429, 1, 3, 351, 526, 0, 132, 80, 1500, 1500, 1, 0, 0, 0, 0, 0, 0, 0, 281, 421, 106, 2, 76, 39947, 0, 0, 0, 0, 0, 0, 0, 0, 75125, 40504, 74502, 74509, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 250, 1, 1, 0, 0, 0, 0, 0, 0, 0, 171, 1, 1568, 803160063, 1, 'boss_baltharus', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (39899, 39922, 0, 0, 0, 0, 31761, 0, 0, 0, 'Baltharus the Warborn', '', '', 0, 83, 83, 2, 103, 103, 0, 2.8, 1.71429, 1, 3, 351, 526, 0, 132, 80, 1500, 1500, 1, 0, 0, 0, 0, 0, 0, 0, 281, 421, 106, 2, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 75125, 40504, 74502, 74509, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 250, 1, 1, 0, 0, 0, 0, 0, 0, 0, 171, 1, 1568, 803160063, 1, 'mob_baltharus_clone', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (39746, 39805, 0, 0, 0, 0, 32179, 0, 0, 0, 'General Zarithrian', '', '', 0, 83, 83, 2, 16, 16, 0, 0.888888, 1.42857, 1, 3, 351, 526, 0, 132, 74.8, 1500, 1500, 1, 0, 0, 0, 0, 0, 0, 0, 281, 421, 106, 2, 76, 39946, 0, 0, 0, 0, 0, 0, 0, 0, 74367, 74384, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 297, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 1764, 803160063, 1, 'boss_zarithrian', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (39747, 39823, 0, 0, 0, 0, 31577, 0, 0, 0, 'Saviana Ragefire', '', '', 0, 83, 83, 2, 103, 103, 0, 2, 2.14286, 1, 3, 351, 526, 0, 132, 74.8, 1500, 1500, 1, 0, 0, 0, 0, 0, 0, 0, 281, 421, 106, 2, 76, 39948, 0, 0, 0, 0, 0, 0, 0, 0, 74452, 78722, 74404, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 300, 1, 1, 0, 0, 0, 0, 0, 0, 0, 191, 1, 0, 803160063, 1, 'boss_ragefire', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40429, 0, 0, 0, 0, 0, 31962, 0, 0, 0, 'Sanctum Guardian Xerestrasza', '', '', 0, 80, 80, 2, 2010, 2010, 2, 1, 1.14286, 1, 0, 230, 345, 0, 86, 1.4, 1500, 1500, 8, 0, 0, 0, 0, 0, 0, 0, 184, 276, 69, 2, 4096, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 189, 832, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 'mob_xerestrasza', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (26712, 0, 0, 0, 0, 0, 169, 17188, 0, 0, 'Crystal Channel Target', '', '', 0, 70, 70, 2, 14, 14, 0, 1, 1.14286, 1, 0, 260, 390, 0, 97, 1, 2000, 2000, 1, 33555200, 8, 0, 0, 0, 0, 0, 208, 312, 78, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 2, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (39794, 0, 0, 0, 0, 0, 169, 16925, 0, 0, 'Zarithrian Spawn Stalker', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 0.992063, 1, 0, 420, 630, 0, 157, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 130, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40470, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Orb Carrier (1)', NULL, NULL, 0, 1, 1, 0, 0, 0, 0, 1, 1.14286, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, '', 1);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40143, 0, 0, 0, 0, 0, 31952, 0, 0, 0, 'Halion (1)', 'The Twilight Destroyer', '', 0, 83, 83, 2, 14, 14, 0, 1.6, 1.42857, 1, 3, 468, 702, 0, 175, 112.6, 2000, 2000, 1, 768, 0, 0, 0, 0, 0, 0, 374, 562, 140, 2, 1132, 0, 0, 0, 0, 0, 0, 0, 0, 0, 26662, 74524, 74562, 74531, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 2900, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 803160063, 1, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (43280, 0, 0, 0, 0, 0, 169, 11686, 0, 0, 'Orb Rotation Focus (1)', '', '', 0, 80, 80, 2, 14, 14, 0, 2.2, 0.785714, 1, 0, 420, 630, 0, 157, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 10, 1048576, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 98, 1, 0, 0, 128, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (39864, 0, 0, 0, 0, 0, 31952, 0, 0, 0, 'Halion (1)', 'The Twilight Destroyer', '', 0, 83, 83, 2, 14, 14, 0, 1, 1.42857, 1, 3, 468, 702, 0, 175, 112.2, 2000, 2000, 1, 768, 0, 0, 0, 0, 0, 0, 374, 562, 140, 2, 108, 39864, 0, 0, 0, 0, 0, 0, 0, 0, 26662, 74524, 74562, 74531, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 2900, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 803160063, 1, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (39920, 0, 0, 0, 0, 0, 31761, 0, 0, 0, 'Baltharus the Warborn (1)', '', '', 0, 83, 83, 2, 103, 103, 0, 2.8, 1.71429, 1, 3, 351, 526, 0, 132, 112.8, 1500, 1500, 1, 0, 0, 0, 0, 0, 0, 0, 281, 421, 106, 2, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 75125, 40504, 74502, 74509, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 800, 1, 1, 0, 0, 0, 0, 0, 0, 0, 171, 1, 1568, 803160063, 1, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (39922, 0, 0, 0, 0, 0, 31761, 0, 0, 0, 'Baltharus the Warborn (1)', '', '', 0, 83, 83, 2, 103, 103, 0, 2.8, 1.71429, 1, 3, 351, 526, 0, 132, 112.8, 1500, 1500, 1, 0, 0, 0, 0, 0, 0, 0, 281, 421, 106, 2, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 75125, 40504, 74502, 74509, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 800, 1, 1, 0, 0, 0, 0, 0, 0, 0, 171, 1, 1568, 803160063, 1, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (39805, 0, 0, 0, 0, 0, 32179, 0, 0, 0, 'General Zarithrian (1)', '', '', 0, 83, 83, 2, 16, 16, 0, 0.888888, 1.42857, 1, 3, 351, 526, 0, 132, 112.8, 1500, 1500, 1, 0, 0, 0, 0, 0, 0, 0, 281, 421, 106, 2, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 74367, 74384, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1011, 1, 1, 0, 0, 0, 0, 0, 0, 0, 144, 1, 1764, 803160063, 1, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (39823, 0, 0, 0, 0, 0, 31577, 0, 0, 0, 'Saviana Ragefire (1)', '', '', 0, 83, 83, 2, 103, 103, 0, 2, 2.14286, 1, 3, 351, 526, 0, 132, 112.8, 1500, 1500, 1, 0, 0, 0, 0, 0, 0, 0, 281, 421, 106, 2, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 74452, 78722, 74404, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1000, 1, 1, 0, 0, 0, 0, 0, 0, 0, 191, 1, 0, 803160063, 1, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40471, 0, 0, 0, 0, 0, 169, 11686, 0, 0, 'Orb Carrier (2)', '', '', 0, 80, 80, 2, 14, 14, 0, 1.2, 0.428571, 1, 0, 420, 630, 0, 157, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 718, 0, 0, '', 0, 7, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 76, 0, 0, 0, 128, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40472, 0, 0, 0, 0, 0, 169, 11686, 0, 0, 'Orb Carrier (3)', '', '', 0, 80, 80, 2, 14, 14, 0, 1.2, 0.428571, 1, 0, 420, 630, 0, 157, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 718, 0, 0, '', 0, 7, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 76, 0, 0, 0, 128, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (43281, 0, 0, 0, 0, 0, 169, 11686, 0, 0, 'Orb Rotation Focus (2)', '', '', 0, 80, 80, 2, 14, 14, 0, 2.2, 0.785714, 1, 0, 420, 630, 0, 157, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 10, 1048576, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 118, 1, 0, 0, 128, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (43282, 0, 0, 0, 0, 0, 169, 11686, 0, 0, 'Orb Rotation Focus (3)', '', '', 0, 80, 80, 2, 14, 14, 0, 2.2, 0.785714, 1, 0, 420, 630, 0, 157, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 10, 1048576, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 118, 1, 0, 0, 128, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40144, 0, 0, 0, 0, 0, 31952, 0, 0, 0, 'Halion (2)', 'The Twilight Destroyer', '', 0, 83, 83, 2, 14, 14, 0, 1.6, 1.42857, 1, 3, 468, 702, 0, 175, 150, 2000, 2000, 1, 768, 0, 0, 0, 0, 0, 0, 374, 562, 140, 2, 1132, 0, 0, 0, 0, 0, 0, 0, 0, 0, 26662, 74524, 74562, 74531, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1100, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 803160063, 1, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40145, 0, 0, 0, 0, 0, 31952, 0, 0, 0, 'Halion (3)', 'The Twilight Destroyer', '', 0, 83, 83, 2, 14, 14, 0, 1.6, 1.42857, 1, 3, 468, 702, 0, 175, 168.6, 2000, 2000, 1, 768, 0, 0, 0, 0, 0, 0, 374, 562, 140, 2, 1132, 0, 0, 0, 0, 0, 0, 0, 0, 0, 26662, 74524, 74562, 74531, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 4200, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 803160063, 1, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (39944, 0, 0, 0, 0, 0, 31952, 0, 0, 0, 'Halion (2)', 'The Twilight Destroyer', '', 0, 83, 83, 2, 14, 14, 0, 1, 1.42857, 1, 3, 468, 702, 0, 175, 112.2, 2000, 2000, 1, 768, 0, 0, 0, 0, 0, 0, 374, 562, 140, 2, 108, 39944, 0, 0, 0, 0, 0, 0, 0, 0, 26662, 74524, 74562, 74531, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1100, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 803160063, 1, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (39945, 0, 0, 0, 0, 0, 31952, 0, 0, 0, 'Halion (3)', 'The Twilight Destroyer', '', 0, 83, 83, 2, 14, 14, 0, 1, 1.42857, 1, 3, 468, 702, 0, 175, 168.2, 2000, 2000, 1, 768, 0, 0, 0, 0, 0, 0, 374, 562, 140, 2, 108, 39945, 0, 0, 0, 0, 0, 0, 0, 0, 26662, 74524, 74562, 74531, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 4200, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 803160063, 1, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40001, 40670, 40671, 40672, 0, 0, 169, 16946, 0, 0, 'Combustion', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 1.14286, 1, 0, 391, 585, 0, 146, 1.1, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 313, 468, 117, 10, 16778240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 128, 'mob_fiery_combustion', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40670, 0, 0, 0, 0, 0, 169, 11686, 0, 0, 'Combustion (1)', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 1.14286, 1, 0, 391, 585, 0, 146, 1.1, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 313, 468, 117, 10, 16778240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 128, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40671, 0, 0, 0, 0, 0, 169, 16946, 0, 0, 'Combustion (2)', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 1.14286, 1, 0, 391, 585, 0, 146, 1.1, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 313, 468, 117, 10, 16778240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 128, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40672, 0, 0, 0, 0, 0, 169, 16946, 0, 0, 'Combustion (3)', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 1.14286, 1, 0, 391, 585, 0, 146, 1.1, 2000, 2000, 2, 0, 0, 0, 0, 0, 0, 0, 313, 468, 117, 10, 16778240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 128, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40135, 40673, 40674, 40675, 0, 0, 169, 16946, 0, 0, 'Consumption', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 1.14286, 1, 0, 420, 630, 0, 157, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 10, 16778240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 128, 'mob_soul_consumption', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40673, 0, 0, 0, 0, 0, 169, 16946, 0, 0, 'Consumption (1)', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 1.14286, 1, 0, 420, 630, 0, 157, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 10, 16778240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 128, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40674, 0, 0, 0, 0, 0, 169, 16946, 0, 0, 'Consumption (2)', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 1.14286, 1, 0, 420, 630, 0, 157, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 10, 16778240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 128, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40675, 0, 0, 0, 0, 0, 169, 16946, 0, 0, 'Consumption (3)', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 1.14286, 1, 0, 420, 630, 0, 157, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 10, 16778240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1.35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 128, '', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40029, 0, 0, 0, 0, 0, 169, 15880, 0, 0, 'Meteor Strike', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 1.14286, 1, 0, 420, 630, 0, 157, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 128, 'mob_halion_meteor', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40041, 0, 0, 0, 0, 0, 169, 11686, 0, 0, 'Meteor Strike', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 1.14286, 1, 0, 420, 630, 0, 157, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 128, 'mob_halion_flame', 12340);

REPLACE INTO creature_template
   (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`)
VALUES
   (40042, 0, 0, 0, 0, 0, 169, 11686, 0, 0, 'Meteor Strike', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 1.14286, 1, 0, 420, 630, 0, 157, 1, 2000, 2000, 1, 0, 0, 0, 0, 0, 0, 0, 336, 504, 126, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 7, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 128, '', 12340);

REPLACE INTO gameobject_template
   (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `AIName`, `ScriptName`, `WDBVerified`)
VALUES
   (202794, 10, 1327, 'Twilight Portal', '', '', '', 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 74807, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'go_halion_portal_twilight', 12340);

REPLACE INTO gameobject_template
   (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `AIName`, `ScriptName`, `WDBVerified`)
VALUES
   (202795, 10, 1327, 'Twilight Portal', '', '', '', 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 74807, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'go_halion_portal_twilight', 12340);

REPLACE INTO gameobject_template
   (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `AIName`, `ScriptName`, `WDBVerified`)
VALUES
   (202796, 10, 1327, 'Twilight Portal', '', '', '', 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 74812, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'go_halion_portal_real', 12340);

REPLACE INTO gameobject_template
   (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `AIName`, `ScriptName`, `WDBVerified`)
VALUES
   (203005, 0, 9484, 'Fire Field', '', '', '', 0, 48, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 12340);

REPLACE INTO gameobject_template
   (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `AIName`, `ScriptName`, `WDBVerified`)
VALUES
   (203006, 0, 9485, 'Flame Walls', '', '', '', 0, 48, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 12340);

REPLACE INTO gameobject_template
   (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `AIName`, `ScriptName`, `WDBVerified`)
VALUES
   (203007, 0, 9482, 'Ruby Sanctum Halion Flame Ring', '', '', '', 0, 48, 1.6, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 12340);
-- Spawn Lok'lira (29975), asignacion de guid mediante auto_increment

INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES

(29975, 571, 1, 1, 0, 0, 6917.26, -1541.88, 833.81, 1.11376, 600, 0, 0, 12175, 0, 0, 0, 0, 0);
-- Fix para que las sangres de caraputrea y panzachacro sean loteadas 
-- por el lootmaster by Strolx

-- Sangre �cida de Carap�trea
UPDATE creature_loot_template SET ChanceOrQuestChance=100 WHERE item=50231;
UPDATE creature_loot_template SET ChanceOrQuestChance=100 WHERE item=50231;

-- Sangre �cida de Panzachancro
UPDATE creature_loot_template SET ChanceOrQuestChance=100 WHERE item=50226;
UPDATE creature_loot_template SET ChanceOrQuestChance=100 WHERE item=50226;-- Cambio en facciones del NPC "Abisario invocado"
UPDATE `creature_template` SET `faction_A`=189, `faction_H`=189 WHERE `entry`=5676;-- Quest de la cadena de Shadowmourne s�lo disponible para paladin, dk y guerrero

UPDATE `quest_template` SET `RequiredClasses`=35 WHERE `Id` IN (24545,24743,24547,24749,24756,24757,24548,24549,24748);-- Permite liberar a la dragona Kanyraku Fix By Strolx

UPDATE quest_template SET RequiredNpcOrGo1 = -185156 WHERE id = 10866 LIMIT 1;-- SAI For "Exhausted Vrykul", quests "Discipline" & "Maintaining discipline"
SET @ENTRY := 30146; -- Exhausted Vrykul
SET @SPELL := 56033; -- Disciplining Rod

DELETE FROM `creature_template_addon` WHERE `entry`=@ENTRY; -- Para que aparezca sentado por SAI, no por esta tabla
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (3014600,3014601); -- SAI viejo que no sirve y no funcionaba

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,0,0,0,25,0,100,1,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exhausted Vrykul - Every minute OOC - Switch to Phase 1'),
(@ENTRY,0,1,0,1,1,100,0,0,0,0,0,90,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exhausted Vrykul - On phase 1 - Seat'),
(@ENTRY,0,2,3,8,1,100,0,@SPELL,0,0,0,30,2,3,0,0,0,0,1,0,0,0,0,0,0,0,'Exhausted Vrykul - On Spell hit & phase 1 - Switch to Phase 2 or 3'),
(@ENTRY,0,3,0,61,1,100,0,0,0,0,0,33,29886,0,0,0,0,0,7,0,0,0,0,0,0,0,'Exhausted Vrykul - Link Spell hit - Kill credit'),
(@ENTRY,0,4,5,1,2,100,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exhausted Vrykul - If phase 2 - Say random text 0'),
(@ENTRY,0,5,6,61,2,100,0,0,0,0,0,91,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exhausted Vrykul - If phase 2 - Stand up'),
(@ENTRY,0,6,0,61,2,100,0,0,0,0,0,49,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Exhausted Vrykul - On phase 2 - Start Attack'),
(@ENTRY,0,7,0,1,2,100,0,5000,5000,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exhausted Vrykul - On phase 2 & 5 sec OOC - Switch to phase 1'),
(@ENTRY,0,8,9,1,4,100,1,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exhausted Vrykul - On phase 3 - Say random text 1'),
(@ENTRY,0,9,10,61,4,100,0,0,0,0,0,91,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exhausted Vrykul - If phase 3 - Stand up'),
(@ENTRY,0,10,11,61,4,100,0,0,0,0,0,46,6,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exhausted Vrykul - If phase 3 - walk 6 yards'),
(@ENTRY,0,11,0,61,4,100,0,0,0,0,0,22,4,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exhausted Vrykul - On phase 3 - Switch phase 4'),
(@ENTRY,0,12,0,1,8,100,0,0,0,0,0,17,233,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exhausted Vrykul - On phase 4 - Emote Work mining'),
(@ENTRY,0,13,0,1,8,100,1,60000,60000,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Exhausted Vrykul - On phase 4 & 1 minute OOC - despawn'),
(@ENTRY,0,14,0,2,0,100,1,0,30,0,0,11,57395,0,0,0,0,0,2,0,0,0,0,0,0,0,'Exhausted Vrykul - At 30% Hp - Cast Desperate Blow');
-- Se cambia el campo SpecialFlaq para que no se complete mediante un Script sino en el campo Agrega en el campo de RequiredNpcOrGo1 el npc que debia ser matado, antes valor en 0 By Strolx

UPDATE quest_template SET SpecialFlags=0,RequiredNpcOrGo1=18398,RequiredNpcOrGoCount1=1 WHERE Id=9962 LIMIT 1;
UPDATE quest_template SET SpecialFlags=0,RequiredNpcOrGo1=18399,RequiredNpcOrGoCount1=1 WHERE Id=9967 LIMIT 1;
UPDATE quest_template SET SpecialFlags=0,RequiredNpcOrGo1=18400,RequiredNpcOrGoCount1=1 WHERE Id=9970 LIMIT 1;
UPDATE quest_template SET SpecialFlags=0,RequiredNpcOrGo1=18401,RequiredNpcOrGoCount1=1 WHERE Id=9972 LIMIT 1;
UPDATE quest_template SET SpecialFlags=0,RequiredNpcOrGo1=18402,RequiredNpcOrGoCount1=1 WHERE Id=9973 LIMIT 1;
UPDATE quest_template SET SpecialFlags=0,RequiredNpcOrGo1=18069,RequiredNpcOrGoCount1=1 WHERE Id=9977 LIMIT 1;

/*          [Q] A Suitable Disguise

SUMMARY:
Basically we are running a random script (4 in total) every 12 seconds after gossip select. Every script has a different subject. For example when we run script @ENTRY*100+1 it will require you to throw a bucket of water into the tub. If you don't do this on time, the event will fail and you'll have to start it over again.
The gossip flags are turned off on gossip select (@ENTRY*100+0) because we don't want the same event to be ran more than once at a time.
As you might have noticed we are using phases a LOT. This helps us to basically add conditions to some lines so they won't occur all the time, yet we can easily time them OOC.
We are also using Data Set event and action types a lot. As you can see when a bunny is hit by the spell which belongs to it, it will set data to Shandy which makes Shandy say something like 'Well done'.
The way the gameobjects are handled is maybe pretty much a work-around but it will need a LOT of core work to make this work like it works on Blizzlike. It should be different objects if you're either horde or alliance. Right now I've just spawned them on-top of each other, because in the end you can only use the object which belongs to your faction.


PROBLEMS:
Shandy Glossgleam should start a waypoint after completing script. (wtb sniffs)
Aquanos' evocation spell seems to have a bugged effect.

RESOURCES:
http://www.youtube.com/watch?v=Fe4mRWO20Hw
http://www.youtube.com/watch?v=tqBbFr_BhC4
http://www.youtube.com/watch?v=OFBRam2MgUw
http://www.wowwiki.com/Quest:A_Suitable_Disguise_(Alliance)

PHASES:
Phase 0: when event did not start yet
Phase 1: when event is happening
Phase 2: when event failed
Phase 4: resetting everything*/

/* Script realizado por Discover y arreglado por Strolch

-- Shandy Glossgleam SAI
SET @ENTRY := 36856;
SET @QUEST_A := 20438;
SET @QUEST_H := 24556;
SET @GUID := 10000000; -- Go ahead Nayd
SET @GOSSIP := @ENTRY; -- Here as well
UPDATE `creature_template` SET `AIName`='SmartAI',`gossip_menu_id`=@GOSSIP WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@ENTRY,@ENTRY*100+0,@ENTRY*100+1,@ENTRY*100+2,@ENTRY*100+3,@ENTRY*100+4,@ENTRY*100+5,@ENTRY*100+6,@ENTRY*100+7);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,62,0,100,0,@GOSSIP,0,0,0,80,@ENTRY*100+0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - On Gossip Select - Run script"),
(@ENTRY,0,1,0,1,1,100,0,8000,8000,12000,12000,88,@ENTRY*100+1,@ENTRY*100+4,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Timed - Run Random Script"),

(@ENTRY,0,2,0,38,1,100,0,1,1,0,0,80,@ENTRY*100+5,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - On Data Set 1 1 - Run Task Successful Script"),
(@ENTRY,0,3,0,1,1,100,1,120000,120000,0,0,80,@ENTRY*100+7,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Timed - Run Complete Script"),
(@ENTRY,0,4,0,1,2,100,1,0,0,0,0,80,@ENTRY*100+6,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Timed - Run Failure Script"),
(@ENTRY,0,5,0,1,4,100,1,0,0,0,0,81,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Timed - Set Back Gossip & Quest Flags"), -- This can only occur in phase 4 so no need to time it (P4 is set in completion script)
(@ENTRY,0,6,0,1,4,100,1,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Timed - Reset Scripts"),

-- Start script
(@ENTRY*100+0,9,0,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 0 - Close Gossip"),
(@ENTRY*100+0,9,1,0,0,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 0 - Turn of Gossip & Questgiver flags"),
(@ENTRY*100+0,9,2,0,0,0,100,0,1000,1000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 0 - Say Line 0"),
(@ENTRY*100+0,9,3,0,0,0,100,0,5000,5000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 0 - Say Line 1"),
(@ENTRY*100+0,9,4,0,0,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 0 - Set Phase 1"),
-- Wants Water
(@ENTRY*100+1,9,0,0,0,0,100,0,0,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 1 - Say Line 4"),
(@ENTRY*100+1,9,1,0,0,0,100,0,0,0,0,0,12,36947,1,10000,0,0,0,8,0,0,0,5796.970215,693.942993,658.351990,0,"Shandy Glossgleam - Script 1 - Summon Wants Water"),
(@ENTRY*100+1,9,2,0,0,0,100,0,10000,10000,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 1 - Set Phase 2"),
-- Wants Pants
(@ENTRY*100+2,9,0,0,0,0,100,0,0,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 2 - Say Line 5"),
(@ENTRY*100+2,9,1,0,0,0,100,0,0,0,0,0,12,36945,1,10000,0,0,0,8,0,0,0,5796.970215,693.942993,658.351990,0,"Shandy Glossgleam - Script 2 - Summon Wants Pants"),
(@ENTRY*100+2,9,2,0,0,0,100,0,10000,10000,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 2 - Set Phase 2"),
-- Wants Unmentionables
(@ENTRY*100+3,9,0,0,0,0,100,0,0,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 3 - Say Line 3"),
(@ENTRY*100+3,9,1,0,0,0,100,0,0,0,0,0,12,36946,1,10000,0,0,0,8,0,0,0,5796.970215,693.942993,658.351990,0,"Shandy Glossgleam - Script 3 - Summon Wants Unmentionables"),
(@ENTRY*100+3,9,2,0,0,0,100,0,10000,10000,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 3 - Set Phase 2"),
-- Wants Shirts
(@ENTRY*100+4,9,0,0,0,0,100,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 4 - Say Line 2"),
(@ENTRY*100+4,9,1,0,0,0,100,0,0,0,0,0,12,36944,1,10000,0,0,0,8,0,0,0,5796.970215,693.942993,658.351990,0,"Shandy Glossgleam - Script 4 - Summon Wants Shirts"),
(@ENTRY*100+4,9,2,0,0,0,100,0,10000,10000,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 4 - Set Phase 2"),

-- Task successful
(@ENTRY*100+5,9,0,0,0,0,100,0,0,0,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 6 - Say Line 6 (random)"),
-- End failure
(@ENTRY*100+6,9,0,0,0,0,100,0,0,0,0,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 7 - Say Line 7"),
(@ENTRY*100+6,9,1,0,0,0,100,0,0,0,0,0,22,4,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 7 - Set Phase 4"),
(@ENTRY*100+6,9,2,0,0,0,100,0,0,0,0,0,41,8000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 8 - Force Despawn"),
-- Completion script
(@ENTRY*100+7,9,0,0,0,0,100,0,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 8 - Stop Current Scripts"),
(@ENTRY*100+7,9,1,0,0,0,100,0,2000,2000,0,0,1,8,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 8 - Say Line 8"),
(@ENTRY*100+7,9,2,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,19,36851,0,0,0,0,0,0,"Shandy Glossgleam - Script 8 - Face Aquanos"),
(@ENTRY*100+7,9,3,0,0,0,100,0,8000,8000,0,0,1,9,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 8 - Say Line 9"),
(@ENTRY*100+7,9,4,0,0,0,100,0,0,0,0,0,50,201384,30000,0,0,0,0,8,0,0,0,5797.147461,696.602417,657.949463,6.090852,"Shandy Glossgleam - Script 8 - Summon Clean Laundry"),
(@ENTRY*100+7,9,5,0,0,0,100,0,0,0,0,0,22,4,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 8 - Set Phase 4"),
(@ENTRY*100+7,9,6,0,0,0,100,0,0,0,0,0,41,8000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shandy Glossgleam - Script 8 - Force Despawn");

-- Texts
-- They all emote ONESHOT_TALK apart from request texts (as seen in videos)
DELETE FROM `creature_text` WHERE `entry`=@ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
-- Start
(@ENTRY,0,0,"You're in luck. I've got just what you need in the load I'm about to wash.",12,0,100,0,0,0,"Shandy Glossgleam"),
(@ENTRY,1,0,"See the piles of laundry and the bucket of water? I'll run out what I need next, and you put it in the tub. Ready?",12,0,100,0,0,0,"Shandy Glossgleam"),
-- Requests
(@ENTRY,2,0,"Quick, add some shirts to the laundry!",12,0,100,0,0,0,"Shandy Glossgleam"), -- Emote ONESHOT_POINT
(@ENTRY,3,0,"Add the unmentionables... uh, I mean, the 'delicates'!",12,0,100,25,0,0,"Shandy Glossgleam"), -- Emote ONESHOT_POINT
(@ENTRY,4,0,"The tub needs more water!",12,0,100,25,0,0,"Shandy Glossgleam"), -- Emote ONESHOT_POINT
(@ENTRY,5,0,"Toss some pants in to the tub!",12,0,100,25,0,0,"Shandy Glossgleam"), -- Emote ONESHOT_POINT
-- Correct
(@ENTRY,6,0,"I should keep you around.",12,0,100,0,0,0,"Shandy Glossgleam"),
(@ENTRY,6,1,"Well done!",12,0,100,0,0,0,"Shandy Glossgleam"),
(@ENTRY,6,2,"That's how it's done!",12,0,100,0,0,0,"Shandy Glossgleam"),
(@ENTRY,6,3,"Clean and tidy!",12,0,100,0,0,0,"Shandy Glossgleam"),
(@ENTRY,6,4,"Nice. I don't want to know what that stain was.",12,0,100,0,0,0,"Shandy Glossgleam"),
(@ENTRY,6,5,"Aquanos can hardly keep up!",12,0,40,0,0,0,"Shandy Glossgleam"),
-- Incorrect
(@ENTRY,7,0,"Oh, no! That wasn't right. Now I'll have to go get more detergent so we can start over!",12,0,100,0,0,0,"Shandy Glossgleam"),
-- End
(@ENTRY,8,0,"Aquanos, stop sending the clothes so high! You didn't have to see the look on Aethas Sunreaver's face when he found his pants in the fountain!",12,0,100,0,0,0,"Shandy Glossgleam"),
(@ENTRY,9,0,"See how easy that was with everyone working together? Just take what you need from the clean laundry here, but don't forget to return it when you're finished.",12,0,100,0,0,0,"Shandy Glossgleam");

-- Give Clean Laundry quest item loot
DELETE FROM `gameobject_loot_template` WHERE `entry`=27725;
INSERT INTO `gameobject_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(27725,49648,-100,1,0,1,1);

-- Summon quest gameobjects
DELETE FROM `gameobject` WHERE `id` IN (201295,201931,201301,201296,201300,201932,201936,201933,201299,201855,201298) AND `guid` BETWEEN @GUID+0 AND @GUID+10;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(@GUID+0,201295,571,1,1,5805.76,694.548,657.949,4.79886,0,0,0.675882,-0.73701,300,0,1),
(@GUID+1,201931,571,1,1,5805.76,694.548,658.447,0.139097,0,0,0.0694922,0.997582,300,0,1),
(@GUID+2,201301,571,1,1,5805.76,694.548,658.447,0.139097,0,0,0.0694922,0.997582,300,0,1),
(@GUID+3,201296,571,1,1,5805.29,691.864,657.949,4.76666,0,0,0.687659,-0.726034,300,0,1),
(@GUID+4,201300,571,1,1,5805.29,691.864,658.365,4.77845,0,0,0.683371,-0.730071,300,0,1),
(@GUID+5,201932,571,1,1,5805.29,691.864,658.365,4.77845,0,0,0.683371,-0.730071,300,0,1),
(@GUID+6,201936,571,1,1,5805.28,697.603,657.949,3.61841,0,0,0.971715,-0.236158,300,0,1),
(@GUID+7,201933,571,1,1,5805.28,697.603,658.281,3.61841,0,0,0.971715,-0.236158,300,0,1),
(@GUID+8,201299,571,1,1,5805.28,697.603,658.281,3.61841,0,0,0.971715,-0.236158,300,0,1),
(@GUID+9,201855,571,1,1,5806.72,690.329,659.15,5.65024,0,0,0.311216,-0.950339,300,0,1),
(@GUID+10,201298,571,1,1,5806.72,690.329,659.15,5.65024,0,0,0.311216,-0.950339,300,0,1);

-- Insert option menu
DELETE FROM `gossip_menu_option` WHERE `menu_id`=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`) VALUES
(@GOSSIP,0,0,"Arcanist Tybalin said you might be able to lend me a certain tabard.",1,1);

-- Basic text for Shandy Glossgleam
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=15066;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,15066);

-- Add conditions for gossip - as you see we are using ElseGroup (logical 'OR')
DELETE FROM `conditions` WHERE `SourceGroup` IN (@GOSSIP) AND `ConditionValue1` IN (@QUEST_A,@QUEST_H);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,@GOSSIP,0,0,9,@QUEST_A,0,0,0,'',"Only show first gossip if player is on quest A Suitable Disguise (A)"),
(15,@GOSSIP,0,1,9,@QUEST_H,0,0,0,'',"Only show first gossip if player is on quest A Suitable Disguise (H)");

-- Aquanos SAI
SET @ENTRY := 36851;
SET @SPELL_EVOCATION := 69659;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,38,0,100,0,2,2,0,0,11,@SPELL_EVOCATION,1,0,0,0,0,1,0,0,0,0,0,0,0,"Aquanos - On Data Set 2 2 - Cast Evocation (Visual Only)");

-- Wants Water SAI
SET @ENTRY := 36947;
SET @SPELL_WATER := 69614;
UPDATE `creature_template` SET `AIName`='SmartAI',`minlevel`=70,`maxlevel`=70,`exp`=2,`unit_class`=2,`unit_flags`=`unit_flags`|33554432,`flags_extra`=`flags_extra`|128 WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,8,0,100,1,@SPELL_WATER,0,0,0,45,1,1,0,0,0,0,19,36856,0,0,0,0,0,0,"Wants Water - On Spellhit - Set Data Shandy Glossgleam"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,45,2,2,0,0,0,0,19,36851,0,0,0,0,0,0,"Wants Water - On Spellhit - Set Data Aquanos");

-- Wants Pants SAI
SET @ENTRY := 36945;
SET @SPELL_PANTS := 69600;
UPDATE `creature_template` SET `AIName`='SmartAI',`minlevel`=70,`maxlevel`=70,`exp`=2,`unit_class`=2,`unit_flags`=`unit_flags`|33554432,`flags_extra`=`flags_extra`|128 WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,8,0,100,1,@SPELL_PANTS,0,0,0,45,1,1,0,0,0,0,19,36856,0,0,0,0,0,0,"Wants Pants - On Spellhit - Set Data Shandy Glossgleam"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,45,2,2,0,0,0,0,19,36851,0,0,0,0,0,0,"Wants Pants - On Spellhit - Set Data Aquanos");

-- Wants Unmentionables SAI
SET @ENTRY := 36946;
SET @SPELL_UNMENTIONABLES := 69601;
UPDATE `creature_template` SET `AIName`='SmartAI',`minlevel`=70,`maxlevel`=70,`exp`=2,`unit_class`=2,`unit_flags`=`unit_flags`|33554432,`flags_extra`=`flags_extra`|128 WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,8,0,100,1,@SPELL_UNMENTIONABLES,0,0,0,45,1,1,0,0,0,0,19,36856,0,0,0,0,0,0,"Wants Unmentionables - On Spellhit - Set Data Shandy Glossgleam"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,45,2,2,0,0,0,0,19,36851,0,0,0,0,0,0,"Wants Unmentionables - On Spellhit - Set Data Aquanos");

-- Wants Shirts SAI
SET @ENTRY := 36944;
SET @SPELL_SHIRT := 69593;
UPDATE `creature_template` SET `AIName`='SmartAI',`minlevel`=70,`maxlevel`=70,`exp`=2,`unit_class`=2,`unit_flags`=`unit_flags`|33554432,`flags_extra`=`flags_extra`|128 WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`, `event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`, `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,8,0,100,1,@SPELL_SHIRT,0,0,0,45,1,1,0,0,0,0,19,36856,0,0,0,0,0,0,"Wants Shirts - On Spellhit - Set Data Shandy Glossgleam"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,45,2,2,0,0,0,0,19,36851,0,0,0,0,0,0,"Wants Shirts - On Spellhit - Set Data Aquanos");

-- The conditions are made this way because the PLAYER should throw the 'item'. (water, shirt, pant, etc.) Basically when you click the object it casts a trigger spell on you. This trigger spell can only target players and will make the player cast 'Toss XX', which has direct conditions to one of the Wants XX imps.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (69593,69600,69601,69614,69548,69542,69544,69543);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
(13,69593,18,1,36944), -- Toss Shirts requires target Wants Shirts
(13,69593,18,1,36945), -- Toss Shirts requires target Wants Pants
(13,69593,18,1,36947), -- Toss Shirts requires target Wants Water
(13,69593,18,1,36946), -- Toss Shirts requires target Wants Unmentionables

(13,69600,18,1,36944), -- Toss Pants requires target Wants Shirts
(13,69600,18,1,36945), -- Toss Pants requires target Wants Pants
(13,69600,18,1,36947), -- Toss Pants requires target Wants Water
(13,69600,18,1,36946), -- Toss Pants requires target Wants Unmentionables

(13,69601,18,1,36944), -- Toss Unmentionables requires target Wants Shirts
(13,69601,18,1,36945), -- Toss Unmentionables requires target Wants Pants
(13,69601,18,1,36947), -- Toss Unmentionables requires target Wants Water
(13,69601,18,1,36946), -- Toss Unmentionables requires target Wants Unmentionables

(13,69614,18,1,36944), -- Toss Water requires target Wants Shirts
(13,69614,18,1,36945), -- Toss Water requires target Wants Pants
(13,69614,18,1,36947), -- Toss Water requires target Wants Water
(13,69614,18,1,36946), -- Toss Water requires target Wants Unmentionables

-- These are erroring:
(13,69548,18,1,0), -- Trigger Throw Water requires target player
(13,69542,18,1,0), -- Trigger Throw Pants requires target player
(13,69544,18,1,0), -- Trigger Throw Unmentionables requires target player
(13,69543,18,1,0); -- Trigger Throw Shirt requires target playerDELETE FROM `creature_template` WHERE `entry`=37158;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES (37158, 0, 0, 0, 0, 0, 14992, 0, 0, 0, 'Quel\'Delar', '', '', 0, 80, 80, 2, 14, 14, 0, 1, 1.14286, 0.1, 1, 422, 586, 0, 642, 7.5, 0, 0, 1, 0, 8, 0, 0, 0, 0, 0, 345, 509, 103, 10, 0, 37158, 0, 0, 0, 0, 0, 0, 0, 0, 67541, 29426, 16856, 67716, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 17, 5, 1, 0, 50254, 0, 0, 0, 0, 0, 0, 1, 0, 583745531, 0, 'npc_queldelar', 12340);

DELETE FROM `creature_loot_template` WHERE `entry`=37158;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (37158, 50254, -100, 1, 0, 1, 1);

DELETE FROM `creature` WHERE `id`=37158;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (37158, 668, 1, 1, 0, 0, 5304.82, 2000.48, 709.341, 0.800565, 300, 0, 0, 214200, 0, 0, 0, 0, 0);
DROP TABLE IF EXISTS `warden_checks`;

CREATE TABLE `warden_checks` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `type` int(3) DEFAULT NULL,
  `data` tinytext,
  `str` tinytext,
  `address` int(8) DEFAULT NULL,
  `length` int(2) DEFAULT NULL,
  `result` tinytext,
  `comment` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


insert into `warden_checks` (`id`, `type`, `data`, `str`, `address`, `length`, `result`, `comment`) values
(1,178,'07F223143C69271AA2A851FECF6DC883A9D3A7DBA6FE26CC','',710730,23,'',NULL),
(2,191,'C7D18F99DBC446A4B36E78B9130B6FA2E365B3D2D4199DF5','',28940,17,'',NULL),
(3,191,'AA1A8559776F873F26954F15E49E6041EDC2C3766AD87A59','',21826,11,'',NULL),
(4,178,'5F342A4D0EA9DB35F93FAE6E32670D810F017309817AA7C0','',676970,23,'',NULL),
(5,178,'C57BD89DD447131EA2083784AB4DA8BD58CF3E182F1D8AF6','',690106,23,'',NULL),
(6,191,'69AA85EFE8A1A990DA5ECFED4FAFD5B14F1D52EF2548FD15','',12905,36,'',NULL),
(7,191,'083ECAD073DE2D61E3564B4BF767C9D1F8F15AA0495F5A76','',41096,24,'',NULL),
(8,178,'C774D64EF60AD5A141FC56F3D02AE78AC147770FAE25D8FE','',3037164,22,'',NULL),
(9,191,'502C59CAFEA11E9584C13BFE75F85EB79936AEEE31B44165','',12194860,37,'',NULL),
(10,178,'4FBE8978A662428C616AABD71DA5562E4AC21F54BEB8ADBF','',3037164,22,'',NULL),
(11,178,'83D3F7FD7DCA144AD8219A6A4E20F0CFC6E7EA208C4144FF','',3033068,22,'',NULL),
(12,243,'','',4623652,7,'578B7D08578BF1','Pointer to realmlist address'),
(13,178,'00523153EE2298A8D80D7B26B7067CA7B26AC06FF374FE7B','',673210,23,'',NULL),
(14,191,'91BC368FA14A3FE3E13D0B1056F485F846925E613D8E8903','',12194860,37,'',NULL),
(15,243,'','',10010636,12,'8166443FFF1FFFD9565CD95E',NULL),
(16,178,'8FEFDBC58301AB0E0D0F6EBC5FBDA5ED9A7126873A9AB337','',682394,23,'',NULL),
(17,191,'B40FF92D4F092599EA9014C88B474DE4352C3F1635109882','',448492,48,'',NULL),
(18,191,'42B596FF923054531E4918DC39E08F8564FED16D559B494A','',29852,20,'',NULL),
(19,178,'24291D6733A7CEFA3D54C3BCCAE95D56D8365BAB42AEE1CE','',3037164,22,'',NULL),
(20,178,'6C4E321E2D5A153F2BB664EB6EEDF8D67FDE7ECC8076D087','',3990720,23,'',NULL),
(21,178,'FB649706C8F1AFF5990B5F3118DFE54FF6F9609C6991C161','',3045776,31,'',NULL),
(22,191,'D1B451C906B81261B048FD4025217245950C11660815367F','',28920,23,'',NULL),
(23,191,'40079A1083A6B57E3B713992BD395FB6650B631E4C4B8D4E','',29852,20,'',NULL),
(24,178,'3F8FEFE08CB358D6613656AFDB498AB8C599BA18B5574FB6','',682378,23,'',NULL),
(25,191,'EECA71B5536EE1992FD7825A5CCC4B7F9F3B413C0DA498B6','',29884,20,'',NULL),
(26,191,'B8786BFF2421ED1F1FB30F3F0BAF671FC1DAD5B3B33124C8','',28956,17,'',NULL),
(27,191,'BF0C842D635D9D8B3F6FF84EF6DF7C963C485EBAF02D17B0','',28920,23,'',NULL),
(28,191,'9672ED2A27C4972E04DF4471C95492C721024E241995170C','',36924,24,'',NULL),
(29,191,'63532B056020A261251BD24AB026BBC5D4468AF863136044','',17906,11,'',NULL),
(30,178,'7D38C80FEAB10B857A4A7BEF15D27A58FB43FD875E29C73C','',3990720,23,'',NULL),
(31,178,'B158752316672A90BF29846E7AD64BA4FD1699C638BFD3B6','',2299116,33,'',NULL),
(32,178,'4549AE7CA28700562D996CBC78FA7341DC05F644C01474E4','',3000288,31,'',NULL),
(33,178,'EE77806A4F5723FD9C6FC6F43308C8AB448E0A139CB43700','',690106,23,'',NULL),
(34,191,'046D6EA3E99E275F51CAA591BD8C478B6F964A3072018F43','',21660,15,'',NULL),
(35,178,'B1682CE919907AD7D8990F3D8272CFF24A996162565D52B4','',676970,23,'',NULL),
(36,178,'22E057649A8BF1D9672841EF47A4DA175AAC082FFEF059DA','',710730,23,'',NULL),
(37,178,'7BA62D5F5CFEB545D1AE646962F4EB9A91B93EF8FFD5D1B0','',710554,23,'',NULL),
(38,178,'702802D919D9E5C3FD42CA9188936C73E47F87CFA419025A','',3033068,22,'',NULL),
(39,178,'FDA6D997BFB8A991B57755633D1AB3C7E567A74C1EC09937','',3070052,22,'',NULL),
(40,191,'84F6BDD28490937867774E7BF8D5B78F68BF9EB43DE90F10','',477912,60,'',NULL),
(41,191,'5A5B4BA32BD937FF253016AE836DD44B794F8D05982860A6','',447736,48,'',NULL),
(42,178,'A243986665C7FCA1E60A9F209DE9431C3098D082DF1C4528','',682378,23,'',NULL),
(43,178,'7CC89374CE3A9C07DCD685006690B828931D60085EE5FEE8','',710554,23,'',NULL),
(44,191,'01F10590E6DFED79523D26C043D5424174BEF1011F3F4974','',477928,60,'',NULL),
(45,178,'C9728BDC4B77BAA7B3515AFD3628EDB0986DFA20B46917B4','',672746,23,'',NULL),
(46,191,'179B80E5E054521E44BA8F5978D5FC489CC9E514B350A3FF','',28956,17,'',NULL),
(47,243,'','',5417948,5,'7734FF2485','FrameXML Signature Check'),
(48,191,'7769A67D6E2460450873133B0CFF99B67A58CE6C404A17F8','',17282,15,'',NULL),
(49,178,'CF3896074EEBC0F93B539FD44E4D825227D4C1556B8F2279','',3990720,23,'',NULL),
(50,178,'88F2833B5267A71A0CA72509C40819B99283A6E556FD9038','',198,10,'',NULL),
(51,243,'','',8491566,5,'8B4D10890D','Lua DoString'),
(52,178,'F7229DF2D879A9E8D5BCEDCDC7046D75BAEE1C9D4DA41E55','',3638348,23,'',NULL),
(53,191,'AE78585CD862134059B13669FC416B8124752EC6471DDCE6','',28940,17,'',NULL),
(54,191,'B408E9F9B475E4B6A81F9B7F2E060824F618FFDABBFFE805','',13634,11,'',NULL),
(55,178,'A9DA016B83961F95097E08F2DEBE69517C7573FFF06D8C4B','',668874,23,'',NULL),
(56,191,'0E74160C242EF826D09BCE4ED535E9A9D251B1CD20E31891','',24812,14,'',NULL),
(57,178,'A58E4D44D952C1F9DB7B5E423167EE4C28AD02668C5B86AF','',710730,23,'',NULL),
(58,191,'35A9FC42ACBF3A147B0C8CF67BA04EC979C6534B20249B45','',28956,12,'',NULL),
(59,243,'','',5345746,7,'746583F9177760','Lua Protection Patch'),
(60,191,'1430DC4A627EA5FA2CFF9C010CE16022F259F81DB6047879','',13634,11,'',NULL),
(61,191,'85A005398AF851382267C01BB6FB04AEF2093213C20EC200','',360508,13,'',NULL),
(62,191,'96916CD89649027A9A8BBFBD28AE190CD5D590E24BBAD451','',13033,36,'',NULL),
(63,191,'056D57A5C1A46883400E1F69405750B23DE18C3032C3D91C','',27270,13,'',NULL),
(64,191,'87C641E1EDBD96D9F170C7BE0FA13F45611DCDF41AC02526','',41127,24,'',NULL),
(65,191,'1F378DF1E7BD99164DDC7401A98CA5E9551BD50B4A35D5AA','',34176,25,'',NULL),
(66,178,'B5ED443D6CA2F6095BAC8DAFDC8F3413F7B473916357C17E','',209352,75,'',NULL),
(67,191,'A2BC3FF01787A38CB88B3EF45C1CD97DA113157FC395D38C','',30012,16,'',NULL),
(68,191,'190862E5018F1428E5B12BFDAD08283ECD057B34AD722846','',41228,24,'',NULL),
(69,191,'6E0E55BE8690F64442E275559E6C9F8A3FDCAA00937D1C13','',49347,24,'',NULL),
(70,191,'B6FC4C07BB2CBE7C5C854CD99DAFEC0D1AE4101FC51460F9','',477912,60,'',NULL),
(71,178,'3B5955C3B498489869990F08A4CAE566A7D689C23990518B','',156,8,'',NULL),
(72,243,'','',7246064,6,'8950108B450C','Movement State related'),
(73,178,'F24317DAA28AA477996EEBB9538A89569ABF9B185A3EA4E4','',718842,23,'',NULL),
(74,178,'DA25A4134671325719833878E2556455EC4321A2207B6728','',198,10,'',NULL),
(75,191,'DC9490A7BEB43C64585E013B5260BE843D126EB3BCEBAC11','',50040,26,'',NULL),
(76,178,'4BB92BBD5CA8C192C9D0E1EDB6C21FF3F4A61ED1B151365F','',673210,23,'',NULL),
(77,178,'13E8DD1C9F5501A270A59CC4B61311F6D5D18DC3F2AA351A','',3037164,22,'',NULL),
(78,191,'346CFA39FF98198BDE1C23673FBF51A50CFF5ADED784F077','',17522,15,'',NULL),
(79,113,'0590FC57AB448975FA46C314A8AB75AF96DF0FD0A3D9FB23','Afd32uu',0,0,'',NULL),
(80,178,'E37D413DC96A92D3CEAB8A482B8F5397587A0E654C9A0166','',672954,23,'',NULL),
(81,178,'E7D5551799C2C7F0072BC3149A22F37D09EA1EB83F64C655','',3045912,31,'',NULL),
(82,191,'7CC5260578671130CA5B3392BA5CFD0F3DE0BE1085E556B6','',9977,32,'',NULL),
(83,191,'F44A40945F24385D089E040A733553EEFF92EFAAB0636323','',134968,32,'',NULL),
(84,178,'D3122CF30EE55310CF4A710E61B190D2B108227B746B41AD','',679578,23,'',NULL),
(85,191,'7E3CC1BC53477D84F05F623BBC94B9DE8D01A2607CA935DB','',41188,24,'',NULL),
(86,191,'DC06565CC1512B5A91A848E08BC4FBC6DA705F6503667852','',41127,24,'',NULL),
(87,191,'03DC47CDFBB14C5CF0D0010FA5424556F951585588A2180A','',29916,16,'',NULL),
(88,191,'29EC91C4D87891FECDED381CE65A86A259F00DD788833E4D','',174688,37,'',NULL),
(89,191,'31F024003681765368F6EFB667E83CE1D12799723AA99BF9','',685304,44,'',NULL),
(90,191,'6A82AC1D0BFEF5DA7385510CBC57189FACD42E45E0D2A65E','',30012,16,'',NULL),
(91,191,'3901FBD52655E12ADA4EEDED3B365B1DDFAAA925A140097F','',448492,48,'',NULL),
(92,191,'6E9991A25EC347BEA5813EDE0A842D746779C97606565B5A','',17906,11,'',NULL),
(93,191,'0AC9F2B104AC5AA9131FB14E669B98D30D056936625B0245','',27270,13,'',NULL),
(94,178,'A338B3DA78A6683CBEE08A63C5EEFBE1AF33BF54983D583D','',684876,29,'',NULL),
(95,178,'38759C29F2ACF42DA9D16EF35837A470DC7C42C3284B2A3C','',3049492,22,'',NULL),
(96,191,'F35817564FC39F4DB7994021352FEEB86E2FEE86C11B8DBB','',360508,13,'',NULL),
(97,191,'09FAC087283873DAEE0AD074ABF7DDB1B395F5CF6BC2141E','',28956,17,'',NULL),
(98,178,'87FE57916743AF3C97CC3B583B29E89B6E503D31D1747B64','',676970,23,'',NULL),
(99,178,'97D854645011BAD1F6625679511D78D1B7367A51EB0FCC6E','',668874,23,'',NULL),
(100,178,'12369F6F1B875FB5CC5E67445ADEAE2B295D196596679317','',0,9,'',NULL),
(101,191,'5034278808E93A3DFC9BEFFD8E180FEFA24DFC5056ED3BE1','',433168,48,'',NULL),
(102,178,'55EF16220A7EF3F74A9D895821610DFBD2A757FB05C792D5','',209352,75,'',NULL),
(103,191,'67445533AA0BB737D2F74C9258148C6C667794F0E3D07498','',45324,24,'',NULL),
(104,178,'AA8649100B17A9C5BE227F47F867FADE51AD242BAAD39821','',3045632,31,'',NULL),
(105,191,'85545FE9242B2474574EEBABBF452FBD11497073CB1E46A5','',41080,24,'',NULL),
(106,191,'9DACD6981681F53650B681EAE68065D26F4803682058709D','',448456,48,'',NULL),
(107,191,'96B74F1436A05E658E3282164BC3CBDF4DBBB2CF6A5B866F','',9977,32,'',NULL),
(108,191,'033BD6861DF7878DC9470EC2F699772BB2F3D5000490866F','',90202,13,'',NULL),
(109,113,'B797D0AF3164EE83167D5C054A511A5B209A70C6655C408B','IPSect',0,0,'',NULL),
(110,178,'D91A2764435C5091D3F9471AB8B5F397E609330294694488','',710730,23,'',NULL),
(111,191,'94EED02DCDB71789E50917DA401A03F4B91BDBEA050D8BCA','',3766400,37,'',NULL),
(112,178,'2DF33CBB544E2D5238FB591F2547AC507B4D8A652D789F2B','',2303444,33,'',NULL),
(113,243,'','',7860712,5,'742DF6407C',NULL),
(114,178,'81A74F35F0F887144D59F93647C18C70C5FEEF542A7F3782','',709322,22,'',NULL),
(115,178,'2E1F8A68FDDF084A950B786A1EE7E0CE43E62449A56F92A3','',3045632,31,'',NULL),
(116,191,'B1F8988B6664A90E79503FA5D843C3CB97BFDC23EB8C7690','',433168,48,'',NULL),
(117,178,'0277E26DE31814DFD675A59E526669E39080E033BAE88859','',0,9,'',NULL),
(118,243,'','',10714892,8,'BB8D243FD4D0313E','Wall Climb'),
(119,178,'09BBFC19FCADC69D6B5BF655A5BB6350B4A8120C3EB557D2','',3990720,23,'',NULL),
(120,178,'BF4ABDEB726B0060E74701C03180C3CB02170ADCB7DCB61C','',3049872,31,'',NULL),
(121,243,'','',9990741,9,'8B878000000089463C','No Fall Damage Patch'),
(122,178,'D259A46A6D1855C436BFC96FB9376BDCDF5E9FFAE8B4147C','',3045616,31,'',NULL),
(123,178,'F425A62A44097742D72A05669B6BE93AD9CEFE9E40D71E48','',3045976,31,'',NULL),
(124,191,'B134291F515D136B6576FFBC0133C7859755974611170D07','',20512,16,'',NULL),
(125,191,'125BE691985D8DB37068DC14D74EA2DA1260E4A63D3F74BF','',45324,24,'',NULL),
(126,178,'E06E3C5B356B34BA92F6765108556AD53ABB74B986D5810E','',3070052,22,'',NULL),
(127,178,'8CC87DFF61F2EC82DE033865C9879010D94E1614369FE286','',710554,23,'',NULL),
(128,191,'E1F5233450FEFFB6F0E8F2B17683047A485828FEDD3E5B80','',448456,48,'',NULL),
(129,191,'31BA6EA4DF2362676AB71F4CB60B0D40FA51A3AABD25D5CB','',36924,24,'',NULL),
(130,191,'C14630E1D519EB85C254C536FE81DC490977E869BD5CD884','',12985,36,'',NULL),
(131,191,'B337F892EEDD52A5B978C116A19D927134273626EFC4DAA3','',17890,11,'',NULL),
(132,191,'D97560108AA21A487EC9278759F7615BFA304A933776A201','',18680,35,'',NULL),
(133,178,'DA59505BA61459508532CBEAD246DCD2C8E7BF5C6D3CE676','',3037164,22,'',NULL),
(134,191,'5803CA69E5B7F1DF08D95219894D75F52EDB1AD429E562D9','',174688,37,'',NULL),
(135,178,'8A1099E19139D91573286DBB3DED2CC093A99FD178F7FEC8','',3033068,22,'',NULL),
(136,178,'0331B438B085F55C06F7F697160845BE953D9CE789AA62A4','',3000288,31,'',NULL),
(137,191,'E844078A5671FF7DB0621E7F1C7EDDF9C92F5A9FA0477FCB','',41023,24,'',NULL),
(138,178,'AAD7F47B231861913F353341FD26E5AA89AFB586FB6A5366','',672746,23,'',NULL),
(139,178,'136DFB3FE66D2830DF46EE155FCAEADC9624FFE1410088DA','',3041472,31,'',NULL),
(140,191,'C6015A0D5C9109768BA4233639A51F163CC7ED58749E5026','',25724,20,'',NULL),
(141,178,'9C668CE4D328EEA9B6AB7AD5FF54169289B35B230275A43C','',3049872,31,'',NULL),
(142,178,'FC3C95E71F968C46BD5DB5C9EF9B0A5BDCC5619B805046F5','',2299060,33,'',NULL),
(143,178,'FBE3808C0E36BFBC1D1F5A0E508CA89E81E550CD2FDEEC48','',149,5,'',NULL),
(144,178,'35A8252DBC65514E858256C497141153812EE61C724BF5A9','',710730,23,'',NULL),
(145,178,'CC79AA9AE29A52A998181D183D38974221B8BAC0AB534E7D','',0,9,'',NULL),
(146,178,'B89F25A249D295580E649F5ABE0C65EC24401F4889A4FB16','',668874,23,'',NULL),
(147,178,'742A0A9997B9E857C355AA75797466506BAE73D44D26399D','',3037164,22,'',NULL),
(148,178,'E7975701601B2FDF8262098521B7BB4FF5CCC484F8E919E7','',3045776,31,'',NULL),
(149,178,'43E81BE830F169F4EDD23B84ABFA9D15EF12C978FE134346','',60648,56,'',NULL),
(150,178,'66CA9E464A2122E301A72FAEF13A4853D8CB1A45C177E854','',178504,96,'',NULL),
(151,113,'0A3C294B0799FD2C9EC17C1CCBCD174A51B6A2ECC62FEF17','IPSect',0,0,'',NULL),
(152,178,'6E9CE81BFCAF0C250705FCC599981D2D9E4D474A7E857B37','',2299108,33,'',NULL),
(153,178,'8734D6E081D5C993DCE8161CFDFC6197F39A487E4083A3E1','',149,5,'',NULL),
(154,178,'A33355AF7B5FF3CECB3A6059F6621F30AEE695D69421EA2B','',3049492,22,'',NULL),
(155,191,'BF8CEA63013511BDE0B551DAAC492DFBB9608645140B88F7','',29916,16,'',NULL),
(156,178,'8D5D5E99EAB2ED21A104913B05D6BD7A8E63ADA56B66CDED','',3022016,31,'',NULL),
(157,191,'778256BFEF82EA60C4E0F25083655FB2BB75B83FD60A9C06','',18680,35,'',NULL),
(158,178,'43FB8007D7DD7B01FFBEEA3EF9D0242778565544281EC761','',0,9,'',NULL),
(159,191,'94DCF5D21FE2106F5303216C14AD55EEDC1B19FDC91D5F76','',28704,16,'',NULL),
(160,191,'7EBBF90F7D8462D1453479DF9AC5943AF483FE2828C74FDD','',477928,60,'',NULL),
(161,191,'A171148491E099B12CCD1708B784D8C3B09737772C7780C0','',401992,14,'',NULL),
(162,191,'5350ACB75F9FA498FE0D2A371649C9FD9716BDDE2C32F5FB','',13634,11,'',NULL),
(163,191,'85E53280630956C58D4CA7FD8DC5FE73C9A2A03314DFF294','',45223,24,'',NULL),
(164,191,'391BC8A81D4EB6D526BAF0DC3468CAA36C9207B82E194B7A','',130380,14,'',NULL),
(165,191,'0F88FA5CD9B9950F850C18FE76C948FF43CDDE3E75638FF1','',17938,11,'',NULL),
(166,178,'EB63FC60164AFF92726DA658882BF1CE47CF0BF6C80B1B97','',690106,23,'',NULL),
(167,178,'E30B2494142B416BBE95DA3DAE4A82CBDF3A020715F10E8B','',4011280,23,'',NULL),
(168,191,'6CA1C19D0E9191CBC9CA3D5BC3CF1D19764D8F17C6B54AE4','',59620,13,'',NULL),
(169,178,'4730B7A7EC70544A688211A5C754C357A090116092D3EC4D','',682378,23,'',NULL),
(170,243,'','',10000022,6,'894644894E54',NULL),
(171,191,'713A7B79619AEF3C47E44102F86EDCE0D6AFBC5ABE87F861','',13538,11,'',NULL),
(172,191,'575F1C6AF7C71085C7D9CB2291844D9F2DA3B71391C0B941','',36907,24,'',NULL),
(173,178,'296F233E4FAC4CF419D5FBF2701AC4D5AA0866CB4D0DAEC6','',3045976,31,'',NULL),
(174,178,'933C1A228C99E35DF309838B25B7D5EA3A8E961E81D81D32','',673194,23,'',NULL),
(175,191,'9EC125252C3738478CA942DCB59030097194B284A9162B32','',59620,13,'',NULL),
(176,178,'6665F3FB8DC6BE71C152C3674B5783D6E57FE8BF796D190C','',3634252,23,'',NULL),
(177,191,'E120DD63042FEFF9E7FCEC0CA44D2544F03C5D4CDBA1C008','',12985,36,'',NULL),
(178,113,'09BDABA6CB17BE561B4104124A3D0266C858D194A8765198','drvsys_mon',0,0,'',NULL),
(179,178,'3AAE69E7088E4060EA32EF95E9B6D9532460F5B84EE4EC80','',684876,29,'',NULL),
(180,191,'990D4E1C2D63C8E447F034642686D57B727064E3EDE13B00','',448500,48,'',NULL),
(181,191,'E88F31BDC5513216CF3701CAF8BE954CCC7EAE0E7AC7D942','',594348,26,'',NULL),
(182,178,'81229C1E56FA72E01B52E8CBB8BB5F55ED48A11B72E7729B','',710554,23,'',NULL),
(183,191,'B4D0CDE7D53493A1549328F711013F07DBD3A9BE88DB2EF9','',685304,44,'',NULL),
(184,178,'D6CA6F94FF248F722F97037C1AE7C8DE0191D5F4D1E3A5B8','',156,8,'',NULL),
(185,178,'9C9DF1E868BB33D43676F21096C4F75759C0807096EEB886','',60648,56,'',NULL),
(186,178,'1C79B3B5A74A4F09A1FAE19BB15CDCF26B5F917861071F1C','',198,10,'',NULL),
(187,178,'AC1AD3E831A4C758858350A8A197A24FE82583F4B0E39A85','',3049888,31,'',NULL),
(188,178,'56E4980485E3129E94F370E7066E80B07141C4A669B9FC0F','',672746,23,'',NULL),
(189,178,'C21574305E0377A3D2B72D1E1546B9D62DCFA8B1A4405F16','',3638348,23,'',NULL),
(190,178,'AA74121AF835978BC1C1BB402A8B7388CB7C075C1227C253','',3049888,31,'',NULL),
(191,178,'D6457A86DFADF9825D6093090AED2A807FE7DA6ECF5922AF','',3065956,22,'',NULL),
(192,191,'1BAB7E6B5ACBEED8F54B667EDF13A385B9E146C0C50D9FB7','',448456,48,'',NULL),
(193,243,'','',7517484,7,'7518683B010000','Follow Unit Check'),
(194,178,'01000FEAC61ED76FE04ED1169C40289D96C71A1564E38FCB','',690106,23,'',NULL),
(195,191,'F095338ED87C658C916CC604A427F4ED95309C4A07B7898C','',34176,25,'',NULL),
(196,191,'800E120187DF74A231722FB887B3944AD16A703FB8CB9D39','',28920,23,'',NULL),
(197,191,'2CFCE981C322A54724E1418B6A6D1896B95D584630EEEA43','',38300,21,'',NULL),
(198,243,'','',5081862,8,'6840AAB600C60200',NULL),
(199,178,'481751066D6C97AD5EE90173E8ED107BB1C9FD873B0CE55A','',3037164,22,'',NULL),
(200,178,'7FC57D49535798CDA7E4DC5DCEA2E085AAB9A68BF7F9469D','',149,5,'',NULL),
(201,191,'33357C112DE0195F013FAAC4D57AB1BE77417934CE03A2B9','',3766400,37,'',NULL),
(202,191,'BF8AC678DC3CD354BADBFE46C9173D34CC84D13302190EBB','',21826,11,'',NULL),
(203,178,'4E2F9721D52A7552AE2728B9695F1523DD62DC0569237C3F','',2299108,33,'',NULL),
(204,191,'9F015E7D8A11F30AA1954D9FEA7142D0247E3C09FF2BFF72','',12194860,37,'',NULL),
(205,178,'1EB5AD39B94DB5CDC3294DF49FA589DFBE2C674D07E4B211','',710730,23,'',NULL),
(206,178,'E9D67F07E035A64B89C9E91614DC1930FEF61DC3A5C1BBA6','',690106,23,'',NULL),
(207,191,'36411C2FF2C3AC51B7F6A6B8DF61DBD4E5895C27438847BE','',59620,13,'',NULL),
(208,178,'A77F30CBB8057E0DB37782367C8462FA98D4DB21DE936ECD','',3049492,22,'',NULL),
(209,243,'','',7452688,10,'8B81CC07000025000000','WoWEmuHacker Injection'),
(210,178,'A8C806E1FB7CA3625E6BB6F5E4D9E2BF0EBDBE70BA7226F7','',3049872,31,'',NULL),
(211,191,'B3DD04807DEA2679045F4F197BDDAED5C7CCEEFE19622B43','',360508,13,'',NULL),
(212,178,'B075C8B4D8C5D83FE703677319491DC816EA5103901B44A8','',682394,23,'',NULL),
(213,191,'53DB506C0341B50BEA3897E2E3C0DD74C2CA2D8F5F34A2E4','',59620,13,'',NULL),
(214,191,'E112F38956124FE0F48BF569F5E81B40E293DC6E16B544D6','',17282,15,'',NULL),
(215,191,'0363EF2B1AAE09E6C2B1FA555E706F4EE094BE678DA27598','',3766400,37,'',NULL),
(216,191,'EA256F01B6340C99E27611B39C5ED28CF2FA202436F0972F','',49564,24,'',NULL),
(217,178,'A86C95C4E58495A10F5F1C9B5B62D3365132E8DC62863E8B','',198,12,'',NULL),
(218,191,'56DD8D99991F83AFA2E169315B395BD388B248340E9C64D3','',30044,16,'',NULL),
(219,191,'684B23E010C3D6B88CC12BD9F0B6B0CE00D692C71BFB84A8','',28940,17,'',NULL),
(220,178,'83AEEFCDF4C2E80B18DDF93D99120A89F916C19206D257AB','',668874,23,'',NULL),
(221,178,'D68651921F5CD387C7E860FB7C3B143409735748E3B2FB7F','',682394,23,'',NULL),
(222,113,'A4D501A9DB9D84BD8695A8BF61FC853BF434D2D4B352C7A0','HideEx',0,0,'',NULL),
(223,191,'5E77F12C032D4FEF559F9B837B85BDB9D95ADB10C9F56649','',448504,48,'',NULL),
(224,178,'F08406AEDFA8F19B6FB7C9ADDE0BFEE82CB0D2E275593150','',2303444,33,'',NULL),
(225,178,'AC0EC72522ADA5B2BFFAFAC92D6D0A0225E1D5C727CDFFA7','',672602,23,'',NULL),
(226,178,'4D1A7D1C88AB04438510E3255184E51EAE2036BB09DB553A','',700714,23,'',NULL),
(227,178,'68BBC36F75DC763B573DACAB1D6D8F70E667638AA894BEE9','',717898,23,'',NULL),
(228,178,'2AC3C23FBDE2C1EC46C9ECFF71BD7F603F17C9DFC1328D1C','',3638348,23,'',NULL),
(229,191,'C365E9FE00580EBB14EE863A5CE3C8139B1A59A610520AE7','',3766400,37,'',NULL),
(230,178,'DB2A0451B9753100085C9D149B61CE47A195D77C8B709143','',178504,96,'',NULL),
(231,178,'0871F69205FA62C74C2DDE200A3911FC3E41A4FB8BAB9817','',682378,23,'',NULL),
(232,191,'0017307F2FF889462B0FA06018D99EB1F847F189B6CC9B99','',21826,11,'',NULL),
(233,178,'0FEFCD6B0BF8C2816A9259AB5FD7B89231AEB8D92DE53D26','',3045356,22,'',NULL),
(234,178,'87EAD79656133B3183C2E452886D8F00C5EC6C9D741673A2','',3037164,22,'',NULL),
(235,178,'C2B6C5E19FA98D121B2CDE51789BD2883A324015E7D131E0','',710554,23,'',NULL),
(236,178,'B6F3A7D557A3E3BC4833C3D9B6B0B0609255591CC8AB3B65','',3022016,31,'',NULL),
(237,243,'','',5283280,12,'558BECB8084E0000E8731DF0','AddChatMessage'),
(238,191,'AEA87B23CD9463E9693B6C053C1D9030F8E229DA308DBF29','',90202,13,'',NULL),
(239,178,'8C16C7E8EEAD49AE67E4E91E229FFBCE2F6590A48348914E','',3049888,31,'',NULL),
(240,178,'7B2DCA97CD348E45490C288EADE9303CE270CF57F28EB1E4','',690106,23,'',NULL),
(241,191,'BC10B10BE398F2397FA6962C4E59C8CF11FDD7158EC222A5','',29916,16,'',NULL),
(242,178,'8E53EC1B8ABE90C9A5C087671DE0A3007BEA4488EE5415D0','',3037164,22,'',NULL),
(243,191,'65B5CE07A794164101F7E379D21A7A544EF1EC2A3A39A2D8','',27270,13,'',NULL),
(244,191,'C6C8597824F249180A53196699421ADF7857A5C4E4F80D6F','',13033,36,'',NULL),
(245,178,'FE677759E719178BC5CB49DA252D9B635F76030FC4C9876C','',673194,23,'',NULL),
(246,243,'','',5265823,5,'72118B5518','Language Patch'),
(247,178,'BA2D161EF412084B0229A08E64D5A445C4E9F9F2645535E5','',706314,23,'',NULL),
(248,191,'0174B647A535F206711D3EEEF08D3F421BCABD7016A2F103','',17282,15,'',NULL),
(249,178,'5F5F754FD6E7BAC9650B715387646CF992813730A2BA37DA','',2303444,33,'',NULL),
(250,178,'D2CC7F98209E9A9BBA483BD1E9A916E40EB971EE2129AFF8','',3990720,23,'',NULL),
(251,178,'E8C741CC79005898FFD0026821F61A2E4E67C695C6E1CE1C','',198,10,'',NULL),
(252,191,'23B364A9012EF40A39EC4D04A91F9B60FC7EF7D85E3F240A','',18680,35,'',NULL),
(253,191,'C9363F808D37F13FC09EBB7F700AD09EEB27DA046E41FD52','',36907,24,'',NULL),
(254,191,'2D92FC5B8603E18F50D9CAA0922F5C7BB89E42A4656ED2D5','',3766400,37,'',NULL),
(255,178,'EDEDBC5B1A3D92D2A91192118898FDBF840C967C82968D70','',3045912,31,'',NULL),
(256,113,'BFEF06E80472106B57B15D711F94A25243F6ABA7FE354C95','ndis_x86',0,0,'',NULL),
(257,178,'FB20B0EB9ACF571FE37C6B69CBE86F7906F96B996D7E5EFA','',2303444,33,'',NULL),
(258,191,'917AC1C48C1FF354FD594A3705C70A2C356FE981275E7FB5','',22792,25,'',NULL),
(259,178,'48CD29D8B39DC07B0FD071FD8C643E07A8FC2C9AFC2A3083','',3045356,22,'',NULL),
(260,243,'','',11154396,8,'D893FEC0488C11C1','Jump Momentum'),
(261,191,'FB13A8360C8E23B83ED7309625A7EFBAEE7DCF737068C5A6','',174688,37,'',NULL),
(262,191,'3C8D85F85ED5DD0354561F84EACA575123DE05EE941C28D2','',56063,25,'',NULL),
(263,191,'FBC20EEA52B5882209BC016EC14818376CA7BAF28780BCED','',22792,25,'',NULL),
(264,191,'210D85A84F7BE48F3EB427E0CBCCD9C146320ABAAB5E28D8','',41096,24,'',NULL),
(265,178,'953107F9F718795B6DF9E5E5BEE0EA949800CAD0EB71F891','',3037164,22,'',NULL),
(266,113,'FBBA36D0FC5434D12EE1509E148FF908D51F18719CCBEABC','IPSect',0,0,'',NULL),
(267,178,'82CB32BA2A05B228F2F8D0313C185EB6FDC50A94340F40C8','',209352,75,'',NULL),
(268,191,'079172B91B1768A2650A87BAB06AF700BB4C9A0B5E5B983B','',17522,15,'',NULL),
(269,191,'881751DF112F817E799953E00E94543DA4610968437DB7C6','',12194860,37,'',NULL),
(270,191,'9A47B274EAAC888FA2007B4EC0623580365458E3621CC416','',28956,17,'',NULL),
(271,191,'77344CE014111FAAA66DEF35B670B2E76AE878B054F85285','',61874,42,'',NULL),
(272,191,'0A74CBD8DFF245DA5E8691C1174F037D7ABE823E265226AB','',685656,44,'',NULL),
(273,178,'0E13ADDD413B679E2984060D929440064FAC308FC2B90742','',3049872,31,'',NULL),
(274,178,'D0D8CE5001596C6F4A766FE94726FE7E337F42469CB96CA1','',3065956,22,'',NULL),
(275,191,'313C58F8401B47F716B220B88411CAD0E85966D95B301591','',13033,36,'',NULL),
(276,178,'ACBDC68A4D748C48ED1180DD3DA52632EA6FC275BFC35D5B','',0,9,'',NULL),
(277,191,'BACA83A742B9E09CD07787BC6B50389707EA94C41886BAD0','',448504,48,'',NULL),
(278,178,'549B42D266E7F17B7F30B72E301A9CB3C5E3865DE9B7E90B','',60648,56,'',NULL),
(279,178,'86DB854557D75BEEE7DA820FCA15669B08C760E8B165B06F','',3037164,22,'',NULL),
(280,178,'02D5FBD9E30D43ACED0EFD00CF16DAA69EDD262C292136AB','',178504,96,'',NULL),
(281,191,'B9D920131EFC38767012340CF0FFBFE154DBA28E6EF3B859','',61874,42,'',NULL),
(282,191,'96E6CAE70AF690F5D552E0948C29CA9AA527DEBF9731B16B','',20512,16,'',NULL),
(283,191,'375B22B4990997348A8AEDD53319897BE196398B4F1DBAC3','',30012,16,'',NULL),
(284,178,'932F4622AE9F1B3990900F1F88375FA1DD7C238F7C6133C6','',684876,29,'',NULL),
(285,178,'43583C7BCCD9DF14C64CC84710BEE44DD30E199F579890AE','',3049872,31,'',NULL),
(286,191,'97CF98F0BCABA04BC2BAD40FBD4EBFB3C1FD8A7139D5C9B9','',433168,48,'',NULL),
(287,178,'97A0E0F8F8ACE7F1E6492DAFADE8F45B366446E79C1B0419','',3049452,22,'',NULL),
(288,243,'','',5284488,9,'7507C7451400000000','Language Patch'),
(289,191,'C3546D16052E0DC1838E7A6E18936B88CC8A40C2AEC0BE3B','',21826,11,'',NULL),
(290,178,'4179D6BD8C2F11AD5D5C103A7877504074009AB53AE4D8A6','',3045356,22,'',NULL),
(291,191,'2C360CEAB996C8D6E5DE3FFAC30E412DED48E7814D1CE110','',20512,16,'',NULL),
(292,191,'6F1486BE58078BD453F1B249947BB99CB8E17E9A355CE024','',41228,24,'',NULL),
(293,178,'924F4631DC3167BCFAB02F92DDB49A871DA0C55122EF9EB8','',0,9,'',NULL),
(294,178,'411029C5B28D942ED3C7BC1F4299162D874838A661410894','',700714,23,'',NULL),
(295,191,'B9093BAED730E86AF004119B3B7258938C56902915C2E8BA','',501956,48,'',NULL),
(296,178,'63BD2D7FF6C5442795361031E5768C396A37AE38AF98DB11','',668874,23,'',NULL),
(297,191,'754A2FE56037B971E128FFAA669032C511BDA3A62524CE03','',28956,12,'',NULL),
(298,178,'9AEFDCDB62EBC2DABD6CEBF8C411C1145274FCA7CED890CB','',3037164,22,'',NULL),
(299,178,'3AC57BAC3B782AE5ADBB899CCC060D4E8F66E5217F7DF654','',676970,23,'',NULL),
(300,191,'2F0D9702A58D6D5A8599529A0A816AA101AFE581D98416B2','',56063,25,'',NULL),
(301,178,'77804219E627B4D38C9F95194301A895180B598AEFA9963F','',3022016,31,'',NULL),
(302,178,'0D1B99EDC8E458705A88E72F7FDEEE9233DB21290A0098E6','',149,5,'',NULL),
(303,191,'BB795B4069F985BF44C7418DE264C3B0E9BA6D61A116FF81','',90202,13,'',NULL),
(304,191,'5A6EEBA1E6B9EE71BD4A5F63014E9928302C36FC806DC796','',3766400,37,'',NULL),
(305,191,'BA5777AF7FFF3895935669878D662B585912A759A2DFCE68','',24812,14,'',NULL),
(306,178,'5E690DB1AD8910886334158C6D4452FA2CE896634BCDDF40','',580768,52,'',NULL),
(307,191,'42A8F651F55F697E783ADA1959A2833276F970F1EE0410C7','',41280,16,'',NULL),
(308,243,'','',5296496,12,'558BEC81ECE80D00006A0AE8','SendChatMessage'),
(309,191,'445A6894B8C1838462D7D0D29FBE6BF815B5E6C344971349','',31924,23,'',NULL),
(310,178,'C010786A38F396503B7411FBADA0C1A68795F54A7AAE228E','',679578,23,'',NULL),
(311,113,'E3185EE4428291F9D2E4080C2EB1B19ADB005AD26EF0A993','IPSect',0,0,'',NULL),
(312,243,'','',7739760,11,'01BE80000000E805B6FFFF','Jump related?'),
(313,191,'1995FA3235ADA4B25232DC6403E7463A8D1864528BF9FDD4','',12905,36,'',NULL),
(314,243,'','',5124558,5,'8BF08D4608','GetCharacterInfo'),
(315,191,'30A26827798B7F1646003A9E846E8A9A8FF10A9DF926825A','',49564,24,'',NULL),
(316,178,'A567BBE4CA9D8E976083024E8D68903CF15CEA88C47C9961','',2299060,33,'',NULL),
(317,191,'BEA7165D7DD8E24E31B1C3D791A47A28731E1BACD1189A17','',24812,14,'',NULL),
(318,191,'0971A7CEB84D392670C7B8CBB61776762C25259D8E772CA5','',13538,11,'',NULL),
(319,178,'13200A59A28561A413FADAADFFFE4521A209CB691EA199A5','',690106,23,'',NULL),
(320,243,'','',5090917,8,'E886EE1D0083C40C',NULL),
(321,191,'56CABE081991356465BDE1DA3B8DED099DF9B6E746D1B531','',25724,20,'',NULL),
(322,191,'F98469C704F8B8ABC1A251EF8FC1E4CB5CEF1E007BAB5EA5','',57602,42,'',NULL),
(323,178,'6A64BF5AC652747B47E0B8E6593B7EEAC1EF38E0A84F4F5D','',3049452,22,'',NULL),
(324,191,'978BCD17BC9C81B05A2F0A50EC2CC206EC5F6AB1FE40D38D','',28956,12,'',NULL),
(325,178,'A28EDC898CEB14FB52591754DEF981C7168DD2421D0742FA','',3037164,22,'',NULL),
(326,191,'35E88DF07F0D48A0B7ABD53F4865DB762E6935529DC826DF','',360508,13,'',NULL),
(327,178,'BF1FB7E4C3CDD5D5A93AA1B24FC822AA5537DBB59F696818','',3037164,22,'',NULL),
(328,178,'343F1AFF6DA7A967D2DB958C608A6E2A19F83E862F8E3954','',149,5,'',NULL),
(329,243,'','',10694516,8,'2F549A416F12033B','Wall Climb'),
(330,178,'0B008034F97BD411A9F900D87578258AA1B79873850BC12B','',3049888,31,'',NULL),
(331,178,'C5A35B72E6BC604BAC9AA218908B3747D6850769CEA79C0F','',2299092,33,'',NULL),
(332,191,'FDDB2AA7F8884C8E3A7ED646B3E9E4AF5A8C0704130C39A7','',29852,20,'',NULL),
(333,178,'F57343CEA7133DE6469B1CFD1A749845D553B8D806B2BAA4','',3037164,22,'',NULL),
(334,178,'565A63583AC736E3CAFB95EE5AF9A64D3A7D3C3A8B234121','',3045912,31,'',NULL),
(335,191,'E26CF0E2ED92F608A80733CE703D7EA2C3DB83FE46182519','',3766400,37,'',NULL),
(336,191,'2F44EE3A34EFF98303B3724005EF3A8AC89CB25F9CA1B8BC','',12985,36,'',NULL),
(337,191,'C32F7CDB33BEF7B3093262F89263884DBB44E57D74D646B7','',12985,36,'',NULL),
(338,113,'2357AD2012CEBA72283F93460AC5FF55E4E5719A5AB9F5B9','drvsys_mon',0,0,'',NULL),
(339,178,'1C1595A1A64016D8725619CBC2FC7ABD41835320958A97FD','',676970,23,'',NULL),
(340,191,'DB5765A8B8D5F636D619E44669E9D3EF968BD8011C5D6999','',36907,24,'',NULL),
(341,191,'70B78734AC394D83D45427E0B7C88351E9BB108ED59C7E71','',37136,40,'',NULL),
(342,191,'85F2A5072D2D7557155CBF5157CAA460B19470DEE8AF96BB','',22792,25,'',NULL),
(343,243,'','',4609669,5,'8986100F00','Login Password Pointer'),
(344,191,'6C33FD80565B2860A76C87BB772E794E2FF444D813079A2F','',685656,44,'',NULL),
(345,178,'F09BEAD15FDEBD09240316D9E2E736028B54972B13F14E5E','',673194,23,'',NULL),
(346,191,'302E114D921D40EE54585BD9D63B9BDDFF7A2BD4D678DA97','',30044,16,'',NULL),
(347,178,'24807D7810C58A4B9A070A21B8AE50A0385DD4B4C6BD8B6F','',3049872,31,'',NULL),
(348,178,'B6BDECA858773B6F995AC6496923F5D0CBFDB1F76DB29C58','',198,12,'',NULL),
(349,243,'','',5296823,7,'75166824020000','Language patch (speak all)'),
(350,191,'C125EB3FD1B222ACE1B518959D96C5AC83EEAF109E9C6D20','',12194860,37,'',NULL),
(351,178,'8AFF28C3E6367B10340FB963B093AB52E61B267C541D5659','',2299108,33,'',NULL),
(352,191,'734D3EDDA69D9DD307032245FA0806456E2F02E90C2291E2','',36907,24,'',NULL),
(353,191,'9CB5A848D90B7FA4F58801ABD8A68EF8FDF8C602063C2CD6','',13033,36,'',NULL),
(354,178,'C8BCF785F8B7118D0270016E620E2C3DF6802E034471E5E4','',3033068,22,'',NULL),
(355,178,'8FB282098C8BB4EC10C8398E44C630677C6E2785227E31D3','',0,9,'',NULL),
(356,191,'2381BB2B613C58C364E962738335EBC2F3EFF81009DE49E4','',37180,24,'',NULL),
(357,191,'AA2A24A7C90D149C7817640B0D2D46C8A4B4D52146837605','',501956,48,'',NULL),
(358,191,'6815D749CCA8C1738A5F3236A737F0B70AE037E82D46033A','',448500,48,'',NULL),
(359,178,'F9F131F27BCC37FEF638FB8EDDAC29400652020C290D4F75','',676970,23,'',NULL),
(360,191,'319CBACC4CD2E1F54F8C8FC41EF44A3A9C492A652B00C622','',18700,32,'',NULL),
(361,178,'A4A7DB31BF51180F1ACFEA6C0E59AC84B43D022CB4BB817D','',2299116,33,'',NULL),
(362,191,'0DF639ED45B0C578DD616DD191014727A3C22C346E9FF73C','',50040,26,'',NULL),
(363,191,'72944B7FED63C1D2FC9D2CF6A07B5788731BE2B02215CEE4','',447736,48,'',NULL),
(364,191,'9148E18CF9213B25197C247F08CCA4C0DC60FEA73E3A247C','',13250,15,'',NULL),
(365,191,'ADA39A6A805BDF59271BBCE21734E8F28182164563CA15AA','',29916,16,'',NULL),
(366,191,'D5C852D85FA4393D027615506B7DEE07A1074AA4633019D8','',41023,24,'',NULL),
(367,191,'D06EE8DDC2115E5895E96D26A2A2F11FC566297D1D21BD26','',56063,25,'',NULL),
(368,191,'3AFE3B981D50B26FCAAC9DBE5A4BCB24F5BC3E9348AAA04B','',25724,20,'',NULL),
(369,191,'058E826BD75C26BACE712DF9D67B0A751896515802E9DDAE','',501956,48,'',NULL),
(370,178,'6E4C9CA0F7140E32D9284AF2E0EEB76419696771D4DDE887','',3634252,23,'',NULL),
(371,178,'29E43B1309ACB344AC777636BE838F0BFE6A04570B7FB09C','',700714,23,'',NULL),
(372,191,'5B7AC53977D57C5756A2F61582DD386EC93F5FE180FAB5DC','',27270,13,'',NULL),
(373,191,'22BF8D63A306178F368016E4657CCFCA5B2B21EBC90B8DB2','',50040,26,'',NULL),
(374,178,'1E8729EE000CD5BD8BABC49C368E0FF5AC08BC2B30921BC4','',709322,22,'',NULL),
(375,178,'8A1304B9AB2579F392F92D8A592308728EF76B26AE258A41','',4011280,23,'',NULL),
(376,178,'8A90AA547378BD5930D24FC415AEC08EF52E29B22073335F','',710730,23,'',NULL),
(377,113,'4BBF42A918109CC23F231B8E657076A213601AD681C032D1','HideEx',0,0,'',NULL),
(378,191,'06D9E92AE3953D13A0AC5FA31EC24B16C6A2260E2D32BF8E','',41096,24,'',NULL),
(379,178,'D4D3A9950FA07FAEDAD0658F9128007ADE282C043210A201','',683146,23,'',NULL),
(380,191,'94530FBCCC455105E8BB67E5B19BE0A4534A6F39A1201B52','',13291422,37,'',NULL),
(381,243,'','',4198410,6,'CCCCCCCCCCCC',NULL),
(382,178,'2313AF1E20F446936533F9440B220BEA966D9EB3A0502DCF','',178504,96,'',NULL),
(383,191,'F982BFDF01EB3BC6FFB70E897BFE21376232B2EEEFB25E58','',20512,16,'',NULL),
(384,178,'26308A71C6F483CC7795A01A2F2CF7E7EE97787C12CACC52','',2299108,33,'',NULL),
(385,113,'368334F9A3A549DFD3ABC9793E4EB83E837AA43F010354D1','ndis_x86',0,0,'',NULL),
(386,113,'5DA702DF95570780875ADB4C64259E887CE0A867D9B67711','Afd32uu',0,0,'',NULL),
(387,191,'B51E8DA25AAE556552404F5172642D0808A89E2AFE870B23','',694376,44,'',NULL),
(388,191,'4748EAC0350B1B56D8549157AAAAF4FF35438078A7E37AB5','',34176,25,'',NULL),
(389,191,'FBE20B03C75572D992273F192CE72CE78A65E6764BF8E6F6','',36907,24,'',NULL),
(390,191,'D8C1B9DEF3CA9CA59C5B827F055729B636FD55BA6242F9F0','',694376,44,'',NULL),
(391,191,'448475EBCA685E5A4ECC5F810740C9181825B49613CDDDA8','',477928,60,'',NULL),
(392,191,'2AF2DEE0CA5F307895E5773A083AEB862EA3D5210E037F06','',41080,24,'',NULL),
(393,178,'1708C050FF0C98DE59FE8F070273D80F9C1A612D336AB9FC','',3049452,22,'',NULL),
(394,178,'ED6BB184C9DD307229A023C1905E6EE73981D3E088D69FE6','',676970,23,'',NULL),
(395,191,'EB63A86D51668323A18AE2F8CE2BDD1ADAE57375B5F76C6B','',45223,24,'',NULL),
(396,178,'5837373EE8D4CCB5687045C04A4297450ACDE774FE973917','',673194,23,'',NULL),
(397,191,'65CCA5E079D38DCF32053D8DEE6C5ECF88E6AD8E1CF5379B','',31924,23,'',NULL),
(398,178,'FB895125A69DE5DB112B4731F6216668EB09C4F57943D85A','',706314,23,'',NULL),
(399,191,'A388E8CE523DB7C3C501AC5DB2C8AAE58FD1831E75665C48','',401992,14,'',NULL),
(400,178,'77C74B5E4CBCA9150FB64261E497AC4E7642A316C89B291A','',3045356,22,'',NULL),
(401,178,'8A2C4F7F3367A4648744D8964BB9A6833182ECABFE015B00','',3022016,31,'',NULL),
(402,243,'','',4609675,5,'5E5DC20800','Loggin Result'),
(403,191,'E8A24A78E6A716734CC666B48263B424804A42155C0BDB51','',18700,32,'',NULL),
(404,191,'3C881D2F0634D9223A36DF5266A7CF36B503DCF424441FA5','',28928,17,'',NULL),
(405,191,'7B3D92577810CAB5DA0134FDDA91CE6F36003C5373526774','',41023,24,'',NULL),
(406,178,'7F794E0811DA99DABA76CD9925B3E78045425E32880F05D3','',672746,23,'',NULL),
(407,178,'08235E08E4F83DDEA588D9FE32BD084FB26BDA6DEBB1E416','',668874,23,'',NULL),
(408,191,'5EF7C22867612F48FE5B41E219A1CA389AE8D32D8F0FC46B','',21660,15,'',NULL),
(409,178,'C7C78789911D6B30FA6E67198EF03B73CEE37576AEBFF5EA','',3045356,22,'',NULL),
(410,178,'62BF4E6440FE3F28138094B46FB469CDEB35008DEB652B8B','',3045776,31,'',NULL),
(411,191,'E24027620A1723C203E8084AD6269A852CD50D6F79D50530','',36544,55,'',NULL),
(412,113,'49CA50FCF2699AE5F4A867156A5D8053C4239B36DACE170C','HideEx',0,0,'',NULL),
(413,191,'073F4A76F248FE7C38F799437D475B9A2E9E81FA08B0C6BB','',17666,11,'',NULL),
(414,178,'6ECA7966F2845B9B61C6D9356E4FE4C913FE917808C8AFFE','',684876,29,'',NULL),
(415,178,'30BA488B3964465B142E75F6D1E1BA42DC9F489C3AC70BDA','',2299092,33,'',NULL),
(416,178,'55492051D368975D444428D6218A7D731555ABF7C3391E7D','',3049888,31,'',NULL),
(417,191,'94E0CEC4F7BDE7844C4D4ACF62E5C96ECF1D11FC2169CF8E','',433168,48,'',NULL),
(418,191,'5003A599A1162170A30F1906C0AD5B16DC7041E72D28A4B4','',28956,17,'',NULL),
(419,178,'686F700B2223502053CAFDF9977D8774E905E76B8C960E7C','',3049492,22,'',NULL),
(420,191,'F5A776E794B34ABBF93CA93E9230B7224CA088AB741DCB57','',13291422,37,'',NULL),
(421,191,'4A67D56DDA6B0E7D9117CFDB17EC6572E68B9300609FFE3C','',28956,17,'',NULL),
(422,178,'1B695DF78AA0708221E0EC2F5A69AB7078ED8143B2EAD174','',668874,23,'',NULL),
(423,191,'7C8CD40E29AE999923CD8EAFC233E619C73885A0258A6E3D','',21826,11,'',NULL),
(424,191,'73407824E9064DF5F1161A204A272A9CD69026EB4DF1004A','',29916,16,'',NULL),
(425,191,'B21609972E46C9BC8C6A77A18161A77D0C1D4001DC892DF1','',41080,24,'',NULL),
(426,191,'BB66A6AC45D02568067987834ECD8BF0A2BD0DAD06D12753','',17762,11,'',NULL),
(427,191,'2550EB7C358B7FB86FAF0EACDDC3111118769F448D93BF7A','',49347,24,'',NULL),
(428,178,'B6E4EF9350CA859576DB74D02C115D5A19C79AA58B0F6681','',684876,29,'',NULL),
(429,191,'451D2C8FF751743B52109FF5D95ED633DDBD8BCDB80EB7A9','',17906,11,'',NULL),
(430,191,'4A0161A4E5D50F11F58E1B23B281ABDA106625E3DC5A179C','',685304,44,'',NULL),
(431,178,'E4F21910D4B5D3E7B5461ED384889F6D0969645AE83F7601','',3037164,22,'',NULL),
(432,113,'B9756E3E1093B54511AC5A7B85711E53CEBEA373EF4866EE','Afde32uu',0,0,'',NULL),
(433,178,'A5AD6C8506004101E42165CD95051A7B5F13FBADD027461B','',710730,23,'',NULL),
(434,178,'B8AE30A02C59219D144EE95228C6CC9F99916F6FE423C940','',700714,23,'',NULL),
(435,178,'DAFD84BA8F977F5CFEEC9310C0EEF8F949F8EB6B827EBE71','',3990720,23,'',NULL),
(436,191,'B42986974893A82D73CC497B3252E9B844A11A99ACF46BEA','',41188,24,'',NULL),
(437,243,'','',11287980,8,'04000000903C9F00','Parental Controls related'),
(438,191,'0DC0953AE42E913121092DF17BC2BEE8BE133D1C53C8BFFD','',17762,11,'',NULL),
(439,178,'72C81E9BA425C54DE57BF4B7745D9C8D6B44D56E8FE933BA','',3049888,31,'',NULL),
(440,191,'100426CD22E80090502AA7A087B094B49ACFF4E7A09773ED','',30044,16,'',NULL),
(441,178,'46C797D1E60CC458E6C9D874650B996D10FC52641C2E7AA7','',676970,23,'',NULL),
(442,178,'DEA2C8A5775AA8CA86B8241BD418979D10DF4587E8E95C87','',250,11,'',NULL),
(443,113,'8807783067F9FF2697A61DEE925760682EB894C6F0A798AE','Afd32uu',0,0,'',NULL),
(444,178,'F63823A1F60619FDE6B4D6F3915EFB03EC03DEBEC82AFB9E','',673210,23,'',NULL),
(445,191,'E4DFD66163F2A65ECDD2EE9CA8062D707CC51882336F6483','',130380,14,'',NULL),
(446,178,'88182C96807A6025E628C90CE436C9EC54EC5FEC858A12B2','',690106,23,'',NULL),
(447,178,'EC322863C90B861E66A0008554BB8702EA92E1406F6F1711','',3070052,22,'',NULL),
(448,178,'9C851C7C05E54E5514E7BE038ABC5C669A3F5747EC573333','',3022016,31,'',NULL),
(449,178,'46D70E5C13F6D16BDD01A7481D9AFA51B73202070CA5D712','',673210,23,'',NULL),
(450,178,'CBEBB5F6F4EFB1324D17AB6CB48C573B639A37EAFD6299B4','',683146,23,'',NULL),
(451,191,'684575AAC0D8BC30D5325D56D3D522380E85ABFF380FA80F','',17938,11,'',NULL),
(452,178,'952BC8983C2CAEB6239BB2774F176A7F87A9F2DC10261205','',3045356,22,'',NULL),
(453,191,'4EAE0459E341062DB99658136D494BD79511B883F00BCE6A','',57602,42,'',NULL),
(454,178,'67E6E0A4006561DC5A67026886D1FF37AD14C5AA1AEA3CAD','',149,5,'',NULL),
(455,191,'222FE6B0A70CE2CEE633597E018706B3F78C338D96F6D9DC','',38300,21,'',NULL),
(456,113,'79747D68A5D6CD203671EF43029F17591E42BBCDB60B8B93','IPSect',0,0,'',NULL),
(457,178,'77ECC7613D44E56210F7CCDD6046226B41C8F087E901C94D','',682394,23,'',NULL),
(458,191,'77A59932BC8D497D992A213256ABD52C4D5F4FFB8A06002E','',49564,24,'',NULL),
(459,113,'2D14DD3BC859535580D8D9DC3BE7D59865A4E3FD112598A5','drvsys_mon',0,0,'',NULL),
(460,178,'9B487CD5032D00424A24FF3185AC4C17246729ECCE431951','',3049872,31,'',NULL),
(461,191,'978D8D1F3E1EF11CEBC4B65B13F1C5CE6E9E220E71B255B9','',13033,36,'',NULL),
(462,191,'1F5AD2397EB3CA814C5D156C6777C040F5D73085F3751C35','',433168,48,'',NULL),
(463,178,'912807952F9397C8F2B718C9164424D720E4EFC681DA3099','',3045356,22,'',NULL),
(464,191,'095F1A232F56B3DDA3338B5DE2CA310E5CF0EC0B6F72E87F','',17890,11,'',NULL),
(465,178,'2A5E27A3EE36254F61795E168A98C055772F88CEA5CCD6F1','',3033068,22,'',NULL),
(466,178,'4319BA4F2139568E87BAAC5F7C95121DD98D710B1C901E2B','',718842,23,'',NULL),
(467,191,'74E55BA8CDEFB5BD54BF1C0B0D326721D756440BA33C3ECE','',27270,13,'',NULL),
(468,191,'ED9FED6EE63B6C5E35C9E4615AC444603F6BF1FBC669D8B5','',13033,36,'',NULL),
(469,191,'DF967A96C67C8D6CB1955D1CA06556F37EEFC88D26F1D684','',90202,13,'',NULL),
(470,191,'2BDB1F4509561B2F846AAE7A5354008215C1EF4BDD0EA1D1','',49347,24,'',NULL),
(471,178,'0F3B3F0934C1B1E32DC9F83F67308BF9CFCCEB0EFE10B2FA','',672602,23,'',NULL),
(472,178,'E89980FFE6987D22DF5379283F53DA8DC3B5CD4862BA22C4','',335122,23,'',NULL),
(473,191,'156B3F2929664A16C3DA2D47CE3050B3A1BC32F9C30E4776','',27270,13,'',NULL),
(474,191,'65B03F581DEAA68B6A07C679C6B620A2623FD83EB4C4978B','',28940,17,'',NULL),
(475,178,'044C63CB9F480E28E02D68426C1F3D69BD146B39A7F081B5','',0,9,'',NULL),
(476,178,'B3BC7201BF77B362B943C8C13F9E70A751906F304F9AE133','',673210,23,'',NULL),
(477,191,'4783BF04A6BD423D63CD955407780BE0E15A70BC2643F853','',28928,17,'',NULL),
(478,178,'A71B471FFB4C58A2C99FC6818DD0269C4AE4C5686D5FDA87','',690106,23,'',NULL),
(479,191,'3EA0347F1F7D9BC9CAE387816DFBE4F492F53533400315B4','',17762,11,'',NULL),
(480,178,'AA5ADEE929B0B2FB655080B35D19607695F611672E6AD364','',3045616,31,'',NULL),
(481,191,'2DAAB5C524CA576967A7B0B713C1C34DA8EBF3990A86730C','',28704,16,'',NULL),
(482,191,'D0042CAE82A7121F7783A1382F542074B34ABFDF50A1B13A','',22792,25,'',NULL),
(483,191,'4D30286AD524AB2EB05C1A361A81036F787B1C0ACA36DD74','',30012,16,'',NULL),
(484,191,'03F9E0F9328E7C7025C0D5C59585700F19E29E8C8F9BF5B4','',49564,24,'',NULL),
(485,191,'430C4F44FD7CDF1A51F7A8FA5852ECCDA6CFA92C2A6ACB3A','',28920,23,'',NULL),
(486,178,'A2886E2080C54F25867AEDACDADD8F5175545F44512A3B58','',672746,23,'',NULL),
(487,178,'8438939BFCD0C550664ADE2DD75DD15FA23DC435EB5FC011','',3638348,23,'',NULL),
(488,191,'66480AAA84C5C00B64EEABE96DD21EB3773228B144E25D0E','',20512,16,'',NULL),
(489,191,'76C1B0FAC29E4E41FC6DAC31A0592CB0087BCE0D052904FE','',61874,42,'',NULL),
(490,191,'DA219765DA22ABBDBE5486CF7DB01C283FBF9986732C9A91','',37180,24,'',NULL),
(491,178,'F58BFE40291DD85F45C47E0E255594382DE0180AAE1F1FC9','',149,5,'',NULL),
(492,178,'8D8A305C43A3DD47DE550F256BD5F4B1753EDCC079AF279E','',3070052,22,'',NULL),
(493,191,'69CA60928A9A85D79ED39596C018DF899BD14C6219EFE088','',41080,24,'',NULL),
(494,191,'8D9AA947B904C003D06ACDF4EA0C84104612B274696999C4','',17890,11,'',NULL),
(495,178,'289CBF469FC750449980BFC2CA6AD7E42A69E14595D140A3','',209352,75,'',NULL),
(496,178,'49961CDE71B612E5432EAB389E7AD193476E05BB2778B751','',700714,23,'',NULL),
(497,178,'43818F9575A04BF426F4BE167052859015CC63622F7D4F3A','',672746,23,'',NULL),
(498,191,'7828B55FDE24719EC377E29FAE55BA6324020D00CD42A99D','',360508,13,'',NULL),
(499,178,'5432916108AFDFA313B6D88C886D87B5722E43EEBCAFC627','',0,8,'',NULL),
(500,191,'106F24060B7A4FC87A7971A4B0EFC1021F7181A09598C336','',17906,11,'',NULL),
(501,191,'13AA99805639421566A2652F0A7104939EA52EF0F77CFB03','',24812,14,'',NULL),
(502,178,'D0938B578EC70162A30A25571CD5DC7E765780F6191EAE1B','',710730,23,'',NULL),
(503,178,'70FA2C3749960F1B0D881FDB186DB9992D6EFD30C6674104','',580768,52,'',NULL),
(504,191,'BCA2CC6F5740DEF5D01D314146879036A5B6965C01424B0C','',45223,24,'',NULL),
(505,178,'47DD279576A64BCB3A4AF23D55895600C73BB5C214B70AEF','',3049452,22,'',NULL),
(506,178,'09C9B53C215456866BF764553A7B7E4F1F20F33A8D2CB613','',3638348,23,'',NULL),
(507,178,'3EC2D3876D82F424718D3B8E0B87562244C3F5A11A29F0E8','',682394,23,'',NULL),
(508,191,'7B4E9BBDC89694CCAE5BA6996D4240EB2E0C9C7F03CC5D40','',59620,13,'',NULL),
(509,178,'E2333772B05ABC620076EB66CFBB4AFE2313CCB6D719399F','',3065956,22,'',NULL),
(510,178,'2EB4C04C0946264F5BC8EFBAA832CA97381A8A6523BAB093','',178504,96,'',NULL),
(511,178,'0E3DE8374276C08D5DD241ABA2AC0AC1D2319F5CD22AAB52','',2303444,33,'',NULL),
(512,178,'FDB8DF478DADD2E36619D63D04D106EDB86EBF8FB9EC8CB4','',3000288,31,'',NULL),
(513,191,'BA76761FA5F569497047C3484FBC6FDDD8AFA71B96FE93C8','',24812,14,'',NULL),
(514,191,'2496E15413F7008A01FA53AC109C01E45B80BF2C3BC2F205','',56063,25,'',NULL),
(515,191,'CACB6383E8613E41489D93D7FE7235BE61214F9AE0825F44','',13291422,37,'',NULL),
(516,178,'931C403D2562AEE58EEB2586D73D51323A3A739860290AA6','',690106,23,'',NULL),
(517,191,'1A95AFB270B9C0D170E7280816891492C21E87D92E9EA6E5','',433168,48,'',NULL),
(518,191,'7483929857AE7A16C2D9EB0857EB1D5E9477479C2EEF0B5C','',37180,24,'',NULL),
(519,113,'379E1F6905F203E1026DB54A58AF588EF5726D9F50FCF369','Afde32uu',0,0,'',NULL),
(520,113,'08394625CCD77F36897EF283FAA0C019EE9F36775182584F','Afd32uu',0,0,'',NULL),
(521,191,'D9ADFC0283E75A86A3E1672BF50F5D1AD8E8466AE7086437','',27270,13,'',NULL),
(522,178,'D37F6219417C0E5196D3A4473D57ED767E6D9B49BB2B9555','',0,9,'',NULL),
(523,191,'93AAFBD4B8B50D6AE72F3BA7002D76791942D0EC0E61253A','',41127,24,'',NULL),
(524,191,'F9B132A5E1FFF379EC7175C12A58683C85272CC96E03E161','',41023,24,'',NULL),
(525,178,'1867D3CEC9379D1E6B8A1B9B667BDB1B6084B02ED9A60864','',3037164,22,'',NULL),
(526,178,'86548378A25632100F7E6E872ECF4D591B7542D977B623AE','',3049452,22,'',NULL),
(527,191,'9E00F6F9AF1D63FA2628E60B7BF2B1D63EFDD42D69929A73','',41080,24,'',NULL),
(528,178,'7DDD4CF1352822A1F9D19775498EE865FABB26C69F8FDEFE','',209352,75,'',NULL),
(529,191,'3D793384AD147BDDE98743EBE1E943263EFD6CAD542E2757','',17522,15,'',NULL),
(530,191,'9014AFDE93FDAC6C20971BEE76898FBB300A744CCBC24DA1','',28956,12,'',NULL),
(531,178,'D1212D7155D2C3114DA596070139C0B3610597CA0CE1CB17','',149,5,'',NULL),
(532,178,'BE18517661568A9D7F3CC9548592867F3A987A705866F60F','',3049888,31,'',NULL),
(533,191,'5D833D8DF05A7AF50DF945F5AF6880D325AC52B3ABC815AF','',41188,24,'',NULL),
(534,178,'1AA3B0D9AD368562F181E4E5D498652B3859210C126824D8','',672602,23,'',NULL),
(535,191,'331E027A700CAFDBEAC9E80B68B8304D0895D52947447448','',501956,48,'',NULL),
(536,191,'8E704337CE9F823A8A93947130ED1EE14A99F2EDB5458B94','',12194860,37,'',NULL),
(537,178,'BB1C818F79DB2F1FF71B7CB181021EB4F425311D09DAAE81','',0,9,'',NULL),
(538,178,'F1AD484D3F189A08EBF420C235D16ECAF1B485092FB063D6','',3045776,31,'',NULL),
(539,191,'1CF7028BE4D68B7AC6BB8061BECBFF402860541D04C90C0C','',17906,11,'',NULL),
(540,191,'2550D8249054E57086D4F4CF80396C686A71673C070711DA','',17890,11,'',NULL),
(541,191,'E864BD00AEB4F3D18CFFA7AADEAC7926A9A1E3EA7588F17A','',29884,20,'',NULL),
(542,191,'9E70338B4C8C845F8514925463DB624FC4423F9C467F5E62','',685304,44,'',NULL),
(543,178,'FC5EF49EDEE7A5268395298071BBA270822547A7416AEFB1','',3634252,23,'',NULL),
(544,191,'8282F57B7C3CD9B449B6363D5C9E792C2044EA2C3F381F9F','',17282,15,'',NULL),
(545,191,'B793EEE20E44B2942C6522F79343C58738A1A8489A381FB0','',24812,14,'',NULL),
(546,191,'6178EE9E575927A3505835AC88DA31BE15F0622DA55B31EB','',28956,12,'',NULL),
(547,178,'7BFD2D88793D6AB1A2351A3E8873B1E20CF44BF6563A0930','',3049888,31,'',NULL),
(548,191,'4102F13984A4E146C134D3F607AE7CA1B3263A22B52308C6','',447736,48,'',NULL),
(549,178,'EA1C4CA2A64548757BC2ED1C5BB6D2B5094AAD5B5C331F7D','',683146,23,'',NULL),
(550,178,'BEB42A9DB2B656B2DFF3DD7D1B8D87033F1D99A019CD4BB5','',3045632,31,'',NULL),
(551,191,'4E209437251EBB0CF31CF8A7CCF2C873A4D759B9563D573E','',34176,25,'',NULL),
(552,191,'85EB9C8A36B32287F096CF73F7FAE8B57405321342E9B779','',17666,11,'',NULL),
(553,191,'2EDE42629DD4A72669FFC9BBFBE15F357BF241853DBF7B2E','',27270,13,'',NULL),
(554,191,'FF47A1D9514F4DD81BDA23FC9018F03D894F9096E26EF809','',18680,35,'',NULL),
(555,191,'65185BBCA1D9995EA4B796E908B9F78923FDAE2D0C2500BC','',594348,26,'',NULL),
(556,191,'BD55E51B55A8FAB82CBF45012D761B1BEEE9BC0DAD8A83CD','',28920,17,'',NULL),
(557,178,'AACC3E694ACD478B1F99714734B5A43BD7D7A2A3565ED9B2','',3049492,22,'',NULL),
(558,191,'F3C07663325C5358F58A547725FBDF8DEF591021CD94513D','',685304,44,'',NULL),
(559,191,'503B5AB938616DE7672103919957B421FA8B6C98F72375F6','',20512,16,'',NULL),
(560,191,'3B6EFA3FF9443BEF4CBD2E7CAE08DA1753C79E5EDFA8510F','',37136,40,'',NULL),
(561,191,'3E5D1B5BBAD191442388FBD5236F5406CB2CA68EDF986328','',17666,11,'',NULL),
(562,178,'D8AB51DCC7840369846821B2A6B229CBA2E42C0CA566792D','',0,9,'',NULL),
(563,178,'F8004FA24C4925FAA3ED4993B0D457C5E4C5371915BB93D0','',3037164,22,'',NULL),
(564,178,'EAF4A696D564F6BC800BF0F6D732E4E92B50133DE02EE8C4','',0,9,'',NULL),
(565,191,'30BDC2BC3E4A2055426FA0EC67DBDEB7705C58047EFFA4D6','',61874,42,'',NULL),
(566,191,'3C8BCED97B2F9E5A52587E725004E136DED2B53AB2DB9D4F','',20512,16,'',NULL),
(567,178,'0B586F15A8CFD6B7A96632FF2B48D0F71E9D06BFAC174002','',3049888,31,'',NULL),
(568,191,'B2B3043BF9CDF3DB535D52ABC45BE586E6B8097B58D82C45','',17890,11,'',NULL),
(569,191,'9ED22064CDACF86DAC8C365C325EE428A87B628D137E038E','',28920,17,'',NULL),
(570,178,'2254B046D6D8D1A47E5F9275474B5EEE7A96CD99E8D952E9','',682378,23,'',NULL),
(571,113,'0A268B6DB28320A1956B54C36C61C625B02A48A4768A0823','Afd32uu',0,0,'',NULL),
(572,191,'41B3450DB8D10C506A561C7B95354A7792286D837C08B437','',12194860,37,'',NULL),
(573,191,'5CEDF5982800D9C6D16F9D357AEA17BBBAABADC8F3A12EC6','',45223,24,'',NULL),
(574,178,'3399D1DE6156FDE8614333B6C4AB0F5B2354381AAB7AF818','',3049872,31,'',NULL),
(575,178,'31DA5322A7B1F1715CA35F0976C201122A76D46A719F0C28','',335122,23,'',NULL),
(576,178,'36172791F3ACC5EFD406A7AD6F5D218279B94D458BDD60C3','',700714,23,'',NULL),
(577,178,'C64DDA3E5D94BD0DEFEDDB867DD304177B554C5771CF4DEF','',682378,23,'',NULL),
(578,178,'701D57AFE1315795AFE1340C35E923FE69C36EFC670C0BA5','',0,9,'',NULL),
(579,191,'D55BBE3C196C2FE07829CC54717C0A2A27C13A38ED4CF582','',30012,16,'',NULL),
(580,178,'DAD3C22D23FAB30C9AA6796E19EAB23CB7DCCD639854C14F','',3045976,31,'',NULL),
(581,178,'B3EC9710B55079104420F126BA7257F8FD7DC39D46880E5B','',2299060,33,'',NULL),
(582,191,'7762CCDD012D51167BF42F775CC307238C35EA5DA55B999E','',41096,24,'',NULL),
(583,191,'CEB7B2C893B8410CA8716C77DB679AB860F7F0E86BCF2D8E','',12194860,37,'',NULL),
(584,113,'C584FF543FABE32DBA3206AB324CAFAD92497C4926BBF8B2','HideEx',0,0,'',NULL),
(585,178,'122B96C9AD3D43FA5EE82ADFA464904F304EB7FD4CB5622D','',2299108,33,'',NULL),
(586,178,'3EFBC5B273BFF42D9F704C74DC2381B8A0D50D61C2F1512E','',717898,23,'',NULL),
(587,178,'8C5824E4A6D16714A2BFB5FC9D0CBF4706B8A2170DA87D7B','',0,9,'',NULL),
(588,191,'402282B90E06579656CF454305C0B5A925C95FBF6A7CF265','',477928,60,'',NULL),
(589,191,'71B36C6D650EF0D049328643E5B12E73DF95B58B2F30D0DC','',17938,11,'',NULL),
(590,178,'7C49C303394E1493D897E802528CA8E558B6A7BFE8320F08','',3037164,22,'',NULL),
(591,178,'2C190F9E920AF2EF67DA4D06905C2A6A0A2BC63D0192BAC5','',3045632,31,'',NULL),
(592,191,'E59168C40E1A0C9F8896EA9E2D684988D81A522FFCDC51D5','',3766400,37,'',NULL),
(593,191,'3C825803D3ABF20A11495E54718A2D83A0B35FD7D741B5E1','',12905,36,'',NULL),
(594,191,'DCF32E3E1C5DF813DFB137A2D9B21D95B0AF66CC2AD0F245','',41023,24,'',NULL),
(595,178,'7B66BDB4A0A713A7B315888708B88F90CCF7313832CCE35E','',3045356,22,'',NULL),
(596,178,'FFAF20DD14D7018A4156F000D1455DF36966513EB76F93E7','',2299116,33,'',NULL),
(597,178,'0C59AA1F05D2D9D3C0C5ECF6A38D9FF57187A7A461DEE908','',717898,23,'',NULL),
(598,191,'913AA6D16EBE73143FA4B4EF89C786668C6E7DD0B936DD18','',90202,13,'',NULL),
(599,191,'A9F5CA81A547D8F8051928A287DD280F7FE835B2858CEED5','',20512,16,'',NULL),
(600,178,'16B4D8897AEED4732A47239CDC99603D2F505D0AD602847F','',673210,23,'',NULL),
(601,191,'23F29E10D55E8701A1A699A1C05CED4553676E9FBA5B51F5','',13634,11,'',NULL),
(602,178,'9A65A024256C0D7D677C9F24A9C16A48BEA9B03CCA016098','',3000288,31,'',NULL),
(603,191,'AA0004288ED58DE4324FA521F849807DB1EF33634C7FE8C3','',61874,42,'',NULL),
(604,191,'E400A401BD0376A0475F1216731F5EE0DDF42C9A4FA805D2','',59620,13,'',NULL),
(605,178,'FD434987A57E848192562B61CA0D67BDCEA2392514CDD0AF','',3000288,31,'',NULL),
(606,191,'88C140A6580061C775D9141887FABD3F20E574DC4C0C4BBB','',9977,32,'',NULL),
(607,178,'3623B441A5D414AFD6650C8B8623ECF3C3A9129E1F5A81C1','',672954,23,'',NULL),
(608,178,'393A06D430D287FEC1C02F9945C34BA2A7954241C6357909','',335122,23,'',NULL),
(609,191,'0955A3267A3E576B9BD823BB210E8200F37CCB0421BF208C','',685656,44,'',NULL),
(610,191,'1A00ED18B456ADC1A1F39A5DEF572250FB0CCAC8BECA9DD8','',477928,60,'',NULL),
(611,178,'370B9B6E3AA987595F986C5716BF9FFCF0369438D5DC5D11','',156,8,'',NULL),
(612,191,'E8E85DFE24D8D20852A37D702CDF029C3B1FA30B99CAA4BE','',447736,48,'',NULL),
(613,178,'FA24C5FEEAF4538DD4913F10C99F3F64380B7354EB318386','',3041472,31,'',NULL),
(614,191,'C6AD92AC13B340575AB5D0769A1A7EED47BC42A5968E67D6','',37136,40,'',NULL),
(615,191,'990EFFE367D44A29E82F62C57B6041A66F66C1D100B05639','',28956,12,'',NULL),
(616,191,'631E42C3B6ED8A22F5AFA903176A7EB011754F5ABF2081EF','',3766400,37,'',NULL),
(617,191,'D8AB4091C51177D7BBA7384EE12E0384A7EDB73E38D15920','',13291422,37,'',NULL),
(618,178,'54AAA1926869D259C427870A620AE0C24AFC9B472F424633','',3049888,31,'',NULL),
(619,191,'CC0E40919988E53DA0B447F0984A30D51CC42E9DB54A8F1F','',49564,24,'',NULL),
(620,191,'396E7EC540DC2C74CD6709753CC627517E3A2DB8A1EF3633','',29916,16,'',NULL),
(621,191,'84A5A077180DFB9841E8DF4A4EC49EADE886D905768EE032','',57602,42,'',NULL),
(622,178,'072300C283F8DF72B3ED5F3CD8B7DF47574AECF7B21FBB59','',668874,23,'',NULL),
(623,191,'D4FC9A6022B7CFA81904503E43B813631D4735D80BC61868','',9977,32,'',NULL),
(624,178,'47B5A19B87234257CB6C1485AB2C0CB25513260F60094BEE','',3037164,22,'',NULL),
(625,191,'B8B6F4BA5FD45F0ABDCB060F72987987B6EF62B80C9E378F','',12194860,37,'',NULL),
(626,178,'261F2915266F20B7289A1560176F24198930C61540BEFA01','',3638348,23,'',NULL),
(627,191,'019A378006B0677C0B2F42C6CA882EC571D504E7D8F5B05B','',17282,15,'',NULL),
(628,178,'4E82DD9F04571D6DAB2FFCFCD638699D1D4C84917F720F32','',717898,23,'',NULL),
(629,178,'EAA75F6AE049552C55AFFDABB7268682428B1A9BF028C4D4','',673194,23,'',NULL),
(630,178,'F1431C669453FE0BD95430ECD8328EA0D3CD37BA658F094E','',198,12,'',NULL),
(631,178,'8AD8C581E8BAF7A2140211C4298A93E229493F272F4EFF4A','',3045912,31,'',NULL),
(632,191,'C154E3B6CE0B979BA98FEDAA1829DCCF2A7172642DEF9EFC','',37180,24,'',NULL),
(633,191,'295A29C81B1B9CC9B6758440BED913ED4D8B5E05A90D7CE7','',41023,24,'',NULL),
(634,178,'3ED9105E3D1F31AD1D4376C54B07D18348C56E7453D161B2','',690106,23,'',NULL),
(635,178,'74C75B8F0147ADA8610F6C9BB80C4BDA543C1D95943ADCEB','',0,8,'',NULL),
(636,191,'7BE7A7D3F4AD8B30A0A144D5D4AC5E569BB9A0D18AB590FC','',37180,24,'',NULL),
(637,191,'0B5C54A4850924038D95A3F1C44F300921CEA1E13644842E','',57602,42,'',NULL),
(638,191,'876743AA30D61C83444427F4F18203B2FF443C337E5DD190','',22792,25,'',NULL),
(639,191,'C83A14C21D1E66345574E3E0E3613E924F702883A30A1809','',31924,23,'',NULL),
(640,191,'2545F02B4FC2F5425960A2E5C0299936C99FF2EC68A5ECDB','',501956,48,'',NULL),
(641,191,'85EF9C6353712A8D0E2E27B1702B510A95B1305473F86345','',41023,24,'',NULL),
(642,191,'35282392AA86692A153FC159D6E13C74F9DF01661E4867D6','',13538,11,'',NULL),
(643,191,'0D6CC3008615CD5BFB96A90620805B78D5BFBC6100B1AF0D','',13538,15,'',NULL),
(644,191,'D573179188521C485CFD24A9EE9CDA77C540A31EE68E3E78','',41228,24,'',NULL),
(645,191,'8FA80694C3766FC1B041103EB35EBA3B7C77081A5DA8FFD8','',28940,17,'',NULL),
(646,113,'CD6B8F9D23612C807F7653D29F1F1C54BC8F917C5C5BD8F1','Afd32uu',0,0,'',NULL),
(647,178,'FCB5CF830DB536208D4C58E5838D1C8798F0738247EF0867','',672602,23,'',NULL),
(648,178,'4451680A3F41926C1545701887F93A0A49CC29C3E114AADB','',4011280,23,'',NULL),
(649,191,'6BE2C4F29ADF49AE5BF0485A27A854087E775FA28047168C','',27270,13,'',NULL),
(650,191,'016FF5D8685E37969B1B7C310756DCD93D4AB34256837031','',38300,21,'',NULL),
(651,191,'6726DA4A8F112CC25DD78500CA9BF792DB688F7D8D1FBC4B','',57602,42,'',NULL),
(652,191,'9F8B3A3C70027496420A619969CF1EB7AF447D245DA766A0','',29884,20,'',NULL),
(653,178,'E74FFC8ADF5FE8A0FE0F10BCABCFCEDB3B2B9C2307340D7C','',3041472,31,'',NULL),
(654,178,'B31302D6A47971059B2643B57D2D50EBEBEAA89BE483F1F4','',3037164,22,'',NULL),
(655,191,'2F761DEA3CD3394A0091D745FD2976B52F3B16BB0A48BC80','',29884,20,'',NULL),
(656,178,'8E44EC966A93870696359D3E2474D12C071A381B9403B1B9','',673210,23,'',NULL),
(657,191,'2424AFA7FEC48FF09E5E3BDAF93FAA74743A7551B6FB1495','',56063,25,'',NULL),
(658,178,'ACCF5804D419F30643F87A650C4DC6E0E10266922692AECE','',682378,23,'',NULL),
(659,191,'6EC19D6D1244E3FE787AE448EC905C509DBA3C01FBE34F24','',41280,16,'',NULL),
(660,178,'5B2D2EE40383C33D381998995210918AC6B1AD67C5880F6D','',710554,23,'',NULL),
(661,178,'83FFE0F8F224D5E56C38D731EFE8AD5AD1285B1AD4FA019B','',683146,23,'',NULL),
(662,191,'9D67A809FD8FDA1E1504F0C038E21E1D5FC4C6D11F426228','',28940,17,'',NULL),
(663,191,'2965EC092EC0A4B3D4A3C781F0A0A542824C77B7300BF50C','',45324,24,'',NULL),
(664,191,'FE31901F5558E6555DA6BC5B1BC3415E82CB97DECBB486BB','',41096,24,'',NULL),
(665,191,'B35406A77D6501A50F41981C7C137AD5272EB612F4A74109','',29884,20,'',NULL),
(666,178,'7275397E511B45264BCFA30E3A3F8101894AA3923D91BE6E','',3037164,22,'',NULL),
(667,178,'CA7D8D0E1F20385DCF6FC209799750CE9D0160B0C67196E7','',700714,23,'',NULL),
(668,191,'F5CCDA244D826B3180E7C49193B3B0B5DBF651EC67DCB47A','',594348,26,'',NULL),
(669,191,'7977F1E72B30179072EE1784396AB0406D06162051CA1EDB','',37136,40,'',NULL),
(670,178,'603F8A015D8436CCBCD68B26FF6006E7A81BA9A8D9524B1F','',3045356,22,'',NULL),
(671,178,'9631E9EBC78E0333010E522045852C7BEA44655080D418F3','',3049888,31,'',NULL),
(672,191,'43BE7C00605D9FECAEFAE38D8FFEAED78B8382563A245F10','',9977,32,'',NULL),
(673,191,'E493F1BAED1DBE7A0D429BF1A5D665636D29069060310BF0','',13291422,37,'',NULL),
(674,191,'6C53203FA95EBE4DBB0A7F3E85994058DECA069A5244C29E','',130380,14,'',NULL),
(675,178,'5A07E5A0525DBD5005CBDE16F7393EC8B795ADB2327C2F96','',3045356,22,'',NULL),
(676,178,'D7665366F333BD580C5F8E2FF8971294F69E99EC7E3623F3','',717898,23,'',NULL),
(677,191,'FB87EB8F178C69D9F7576AC7FF75D0479467057A2B6C956D','',9977,32,'',NULL),
(678,178,'292911AC98E7ED34DF021B562D5DEBE8DAA15570B552978B','',3000288,31,'',NULL),
(679,178,'6618F45C49D47C4105070C085FD5C384254A62E4AB614DB9','',3634252,23,'',NULL),
(680,191,'316E531545999AFC533814888434999501FEA8ABFBAF8655','',134968,32,'',NULL),
(681,191,'9945ED64886F68664A4BDF50731F4B4DC680273AB2E0DBCB','',20512,16,'',NULL),
(682,191,'1D4D6EC7B6B26553FC914D28BF9B62FD81D0B865DE606D97','',29884,20,'',NULL),
(683,178,'63B2D2ACF6E912CDC68282B080A2D610BE6AFE8EBB95FD31','',3070052,22,'',NULL),
(684,191,'B0955BAC042D5441496103E7C45E38609A9AE3799D534BD9','',18680,35,'',NULL),
(685,178,'6488E44D4E965581650F73F6E68DD8F863795162D99104F8','',682378,23,'',NULL),
(686,191,'CC0D3F7D8FCF928A55F92F6414F4AEF7AD75DED5819BF870','',13538,15,'',NULL),
(687,191,'CD3835965AF27EC338F828666CD06089B847B04A2DD56AE0','',17938,11,'',NULL),
(688,178,'D04E9CF6A03D4767AFF1E4EE0EFBC333AEBA5B0552F15957','',0,9,'',NULL),
(689,178,'120904F033D78A13DB0971F095C809852B7EB876D1A8AA01','',3045632,31,'',NULL),
(690,191,'7DDD19DCF77E27DF0A31BC21C7F716FF85076AF065F102DC','',36924,24,'',NULL),
(691,178,'5486E2CDD98AC3F25C223FD515CE7EF3FB09AC12ED338C86','',198,10,'',NULL),
(692,178,'F8D6423F01E5369D16F6F70180083B936F0DDE3737B23308','',2299092,33,'',NULL),
(693,191,'EC10CC349A8E654240B27B03EE1232B9CCED28F7104CCB71','',49347,24,'',NULL),
(694,178,'29E064ACC509206873A1D548F4816DB60D29D6EE9FF63A56','',682378,23,'',NULL),
(695,178,'E1A8A2A81920A7BA9F419A6D19CAC3DD9E292EF39F963234','',676970,23,'',NULL),
(696,191,'32393EB09F7C829F58612E5E47018F7203C43218C3506C79','',20512,16,'',NULL),
(697,178,'AFC4D19CACEDE8E9A2FDE3CC3D29CF8556AF4980872DFE1A','',3033068,22,'',NULL),
(698,178,'09A2B97FD351B1D339030233AC51C741E0ECDC21AA7A152B','',3049452,22,'',NULL),
(699,191,'2B2AF2171B8A9FC0D44EFE0ECDCB9DE1A55ACC8D83661E16','',41023,24,'',NULL),
(700,178,'D111B236DC42EB338870E72FF6EE3141714D0437864B02AE','',3045356,22,'',NULL),
(701,178,'E6DC6898929D1DA9F5768A9BFCBE848F8C1F31E8B6910FB8','',335122,23,'',NULL),
(702,113,'85A32F8B5F8430A086D27E62EB17D878E49CE815F6AC91CA','IPSect',0,0,'',NULL),
(703,191,'B6CB7B905A6BDD64BC032BE71927C1FE31153D14D6CF87E1','',447736,48,'',NULL),
(704,178,'40EE7F4EEE1D707ECB770CDBBB54730CB863CC8E268D4208','',3634252,23,'',NULL),
(705,178,'D74E308262D8C52ACE81B66F1D90C160AC86B2E0508176C1','',0,8,'',NULL),
(706,178,'E15287D29EE155299619F8E93E66B55B564FD921FA41CF50','',3049452,22,'',NULL),
(707,191,'58DFAEE44A52F0D5A58B0C94F0E5E63C1C7F76206D7FA7CA','',22792,25,'',NULL),
(708,191,'83705EAE8AAD9709494E52EB05AC0481C998C15730E61099','',30012,16,'',NULL),
(709,178,'0271F4D624304A48CB7CDFA016E3A735DCA3170FAD557468','',3070052,22,'',NULL),
(710,178,'217DFFE3C12F984992E1E0AE7B5864061572BA301B21D869','',178504,96,'',NULL),
(711,178,'C5C7AC33D1E4CF33E661033006BFEDE08523B643CCF51261','',3045356,22,'',NULL),
(712,243,'','',4618113,10,'FF1554F79D003B470C89','WS2_32.Send'),
(713,191,'D45144FC835266270E67CFB1F2900FD227B63204698A3EA7','',50040,26,'',NULL),
(714,191,'B5BB832AEEC591196864E08A392592C5789D76D3DDDD4DBF','',27270,13,'',NULL),
(715,191,'93582814E00150E2DD750ACAD7BD1719C4EBCD4C06F482AB','',28940,17,'',NULL),
(716,191,'FD6B6AC7FA5F2E7828CB1B429A9442383BD93E762A5D7D00','',31924,23,'',NULL),
(717,191,'51DF4EDECBBE42CC7C5D6723318F98E43E14A45F41CBD124','',41080,24,'',NULL),
(718,191,'F2B2260FDD23E5F268FAAE4D1A48E74C452F2AC5D114765D','',57602,42,'',NULL),
(719,191,'69FBDB69EC2E113EF691E47EDD46E40F03D1EBE226A1F7CE','',29884,20,'',NULL),
(720,178,'E3E431D8F8FB38F0F2586D0F50D809BCCEB13651C5EF2619','',682394,23,'',NULL),
(721,178,'2294015927F07D884FE2923FA17B3A8BCABC0A378930CF84','',679578,23,'',NULL),
(722,191,'0A022AB25C52F94404A01F96687B2D6E6BE774237254BD05','',20512,16,'',NULL),
(723,191,'65EEE243504EDC3319C3528B1A1E8061A3E75F4C25B61F95','',41228,24,'',NULL),
(724,178,'877C654036A29FC108FE8D69D416361732D7A0270E51189D','',3022016,31,'',NULL),
(725,178,'1A223564DF9E7BADD3CF858FB8250FE59F892232AC3B412D','',4011280,23,'',NULL),
(726,191,'4FEDF58FB4DE45289C97ACCF16EB2DEA6FBC85C74A52D3C9','',37180,24,'',NULL),
(727,191,'D4BE47EA1D68B92E2AD8307D139877705BE2B6A98B6A916E','',13033,36,'',NULL),
(728,191,'9658AC7EF426A52C327BBC1ED71C6FA6DC5940E35DCC18C7','',18680,35,'',NULL),
(729,113,'1B17998CD8E0CDA4D84B0A0F9DB05E536DACE0348A883D24','ndis_x86',0,0,'',NULL),
(730,178,'BB9B86ED12359A465B02387A1D727F11F78D35C8B7FCC2FC','',2299092,33,'',NULL),
(731,191,'842BC1A8C53902D26018B1C5E05ADCD70D973A968E298331','',50040,26,'',NULL),
(732,178,'3E894F9682573CC0AD54C7E9873C9026AC050929392D0B93','',3049452,22,'',NULL),
(733,191,'4A31E3D24FD6D576D84EF1BFB813D0F066870DEB38C32E47','',21826,11,'',NULL),
(734,191,'EEA122B4C066EC0B196F67511E633EBACB37C4EA6AE4BFF7','',41096,24,'',NULL),
(735,191,'66211671BEF80FB973B1C9595A70B462AD79EC83530DFE89','',12905,36,'',NULL),
(736,178,'3760BBD6FE99A0BBEE0AB61A8BD52A6ABCAC48FF3CB265B8','',3070052,22,'',NULL),
(737,191,'70F425426612D0D8495386C2375F7A4183548C0D4E7DFA46','',594348,26,'',NULL),
(738,178,'BB310E9DDE9259027123500E65F9FA1E8D9D0F5FE8381CD2','',3638348,23,'',NULL),
(739,191,'6FFB5E4982D306680E0C59087DA961CD4F6B068E323C3BB4','',401992,14,'',NULL),
(740,191,'6DDCA79B7460A1F3671532A28FDCEB331DE6CA550E3178D0','',3766400,37,'',NULL),
(741,191,'A8F7B2FB37CF3BEF43D6CE5C0BF85E85077E681490BA1C4C','',37136,40,'',NULL),
(742,191,'052F425E7528B3A7155C45EEE530F915DBB154E5C8876E25','',50040,26,'',NULL),
(743,178,'D6DE200B631AF71BFBC76202D82649942FD6ED9BC4A9EF75','',198,12,'',NULL),
(744,178,'61077261C66B2CF9B199F115A3A656EA6A00068F151E3656','',706314,23,'',NULL),
(745,191,'513FC0F0673A9DF86FA1FA05371040C14634CE08311ED619','',401992,14,'',NULL),
(746,191,'5E0970A6EB246A79DDF427CB76D0D921F971E13921DD5D2C','',134968,32,'',NULL),
(747,178,'53CAC3EF654610AC7E043C6AAD62709EF0B5400DBDE755EB','',149,5,'',NULL),
(748,178,'566637D06BAEA9190B7CE510C697F72CD20FE3D958A95A25','',3049888,31,'',NULL),
(749,113,'3C9B0CC7FE020EEBD43E6B1D88EDDF0EC46AC35974765068','drvsys_mon',0,0,'',NULL),
(750,191,'BDFEE5DCDD37FC5B2A1B3E42FBE5F7997CFED35E86062EB6','',28920,23,'',NULL),
(751,191,'7794AE60131E4D07860DB48047206784B885B30457EAB83E','',12194860,37,'',NULL),
(752,178,'653A308BB00D914AE1ECD773BA4B0BA7724874BC62647D10','',3037164,22,'',NULL),
(753,178,'06B696C35F905E75B451A02E121BDA0330CD44E0D9B872BF','',60648,56,'',NULL),
(754,191,'35E8CD9E8CBD879B1E53278926C634AA8B72B8D9A20009F9','',17522,15,'',NULL),
(755,191,'9B13F2E744904ADAAA062F9113A576D11C2C450D1CD6A4AB','',13033,36,'',NULL),
(756,191,'60851B4A6F7338632A84795FBBB20320E49AD2CC2034BA80','',28940,17,'',NULL),
(757,191,'3BC0BE02AE0B6975974D3B13B811EC6BDACBF9EE122BE633','',90202,13,'',NULL),
(758,191,'E47F7DD8D5B5C29B70AFFD4F25AA286167D411937F9BD247','',36907,24,'',NULL),
(759,178,'35D1CDEE86A410DF087DE6D5F5AC6289C4888B9753293E73','',3037164,22,'',NULL),
(760,191,'2ED2EEB29EE0D48477779E5CA875F1F5F15CCE74CA85BDAA','',28956,17,'',NULL),
(761,191,'78C3A74F7624B26478D4C98BAF1194D9A8E1B33D6AF89DD6','',174688,37,'',NULL),
(762,178,'3D02551F548DFB58832626FE90A7AAA12824D93A54A0DC14','',709322,22,'',NULL),
(763,191,'09D04CF8ABC51D06D874784442987E5F2631041550607255','',36544,55,'',NULL),
(764,191,'F3CD473F8C85977895CA5BA9DC22185BCCBBF6B977205193','',448492,48,'',NULL),
(765,191,'30E2F23DB1038D16D2DEEAB1D0F1790D961E468368DC5108','',30012,16,'',NULL),
(766,191,'540D465F760320A63981289D30CD40CCC770EE126523C71D','',477912,60,'',NULL),
(767,191,'C461E1BE054FE29A1FD58B33D33890BC4A1279DE4F572B47','',37180,24,'',NULL),
(768,191,'1AC3D903CFCA11321E76A257BDA0608E5060030BE745CCF3','',130380,14,'',NULL),
(769,178,'96281A2887E61232007D7015E4A35DA118794841A8EC84BC','',3037164,22,'',NULL),
(770,178,'8A1AC926B46A9E3D60D3BD87A59FF77D7B80A1510BC327A7','',710730,23,'',NULL),
(771,191,'3620B6BDF3993B87FD35E906FE8376A04FF34684E2023D8E','',41280,16,'',NULL),
(772,191,'025C373F05EC6E809EF5A86A903570FDA14D219286BCED5E','',448492,48,'',NULL),
(773,178,'5C0E4EE98C4E34CBE44F6BD595C13DD675555164A8D491DA','',710554,23,'',NULL),
(774,191,'BECE667BF9443EF6515E8E154F74FC2C5817455C8636DB72','',501956,48,'',NULL),
(775,191,'94F1DA3E0D955761826D6BC932E26F44D321B4838C7567D8','',13538,15,'',NULL),
(776,191,'EA3A3AD71FD14B038C98F256E80C1EFA1F45562A3DF92E7D','',22792,25,'',NULL),
(777,191,'AD5A8CBF55EC436DA968EE0B9744C93F65D9E0D6E3C1B136','',174688,37,'',NULL),
(778,191,'9B6B3B311BA9007C06CF0D146BB979B11CF295C58768DD4F','',31924,23,'',NULL),
(779,191,'A373FDB6A789CC46072A4CC51A429C817C40862DC6C0190F','',30012,16,'',NULL),
(780,243,'','',5345728,2,'558B','Lua Protection Remover'),
(781,243,'','',7726137,2,'7414','Walk on Water Patch'),
(782,243,'','',8016620,2,'7417','Collision M2 Special'),
(783,243,'','',8016079,6,'0F8462010000','Collision M2 Regular'),
(784,243,'','',8054762,2,'7506','Collision WMD'),
(785,243,'','',9995315,2,'7544','Multi-Jump Patch'),
(786,217,'','WPESPY.DLL',0,0,'','WPE PRO - injected dll'),
(787,217,'','RPE.DLL',0,0,'','rEdoX Packet Editor - injected dll');
