delete from creature where map = 616;
insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values
('31253','616','3','1','27401','0','754.255','1301.72','266.253','1.23918','3600','5','0','3052','0','1','0','0','0'),
('30334','616','3','1','11686','0','754.294','1301.19','266.254','4.24115','3600','0','0','12600','0','0','0','0','0'),
('30090','616','3','1','0','0','754.733','1301.51','283.379','5.58505','3600','0','0','12600','0','0','0','0','0'),
('30090','616','3','1','0','0','754.521','1301.23','279.524','0.680678','3600','0','0','12600','0','0','0','0','0'),
('30090','616','3','1','0','0','754.356','1301.48','285.733','5.96903','3600','0','0','12600','0','0','0','0','0'),
('30090','616','3','1','0','0','754.192','1301.18','281.851','5.75959','3600','0','0','12600','0','0','0','0','0'),
('30090','616','3','1','0','0','754.688','1301.8','287.295','1.25664','3600','0','0','12600','0','0','0','0','0'),
('30118','616','3','1','14501','0','652.417','1200.52','295.972','0.785398','3600','0','0','17010','0','0','0','0','0'),
('30118','616','3','1','14501','0','847.67','1408.05','295.972','3.97935','3600','0','0','17010','0','0','0','0','0'),
('30118','616','3','1','14501','0','647.675','1403.8','295.972','5.53269','3600','0','0','17010','0','0','0','0','0'),
('30118','616','3','1','14501','0','843.182','1215.42','295.972','2.35619','3600','0','0','17010','0','0','0','0','0'),
('28859','616','3','1','26752','0','808.535','1213.55','295.972','3.22503','604800','0','0','6972500','212900','0','0','0','0'),
('32448','616','3','1','27401','0','754.544','1301.71','220.083','3.9968','3600','5','0','3052','0','1','0','0','0'),
('22517','616','3','1','16925','0','754.395','1301.27','266.254','1.0821','3600','0','0','4120','0','0','0','0','0');

delete from gameobject where map = 616;
insert into `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) values
('193070','616','3','1','754.346','1300.87','256.249','3.14159','0','0','0','1','180','0','1'),
('193908','616','3','1','724.684','1332.92','267.234','-0.802851','0','0','0','1','180','0','1'),
('193967','616','2','1','764.56','1284.63','269','1.82','0','0','0','0','-604800','100','1'),
('193905','616','1','1','764.56','1284.63','269','1.82','0','0','0','0','-604800','100','1'),
('193958','616','1','1','754.255','1301.72','266.17','-1.6057','0','0','0','0','604800','0','1'),
('193960','616','2','1','754.255','1301.72','266.17','-1.6057','0','0','0','0','604800','0','1');

DELETE FROM `instance_template` WHERE `map`=616;
INSERT INTO `instance_template` (map,parent,script) VALUES (616,571,'instance_eye_of_eternity');

UPDATE `creature_template` SET `ScriptName`='boss_malygos' WHERE `entry`=28859;
UPDATE `creature_template` SET `ScriptName`='npc_power_spark' WHERE `entry`=30084;
UPDATE `creature_template` SET `ScriptName`='npc_portal_eoe' WHERE `entry`=30118;
UPDATE `creature_template` SET `ScriptName`='npc_hover_disk' WHERE `entry` IN (30234,30248);
UPDATE `creature_template` SET `ScriptName`='npc_arcane_overload' WHERE `entry`=30282;
UPDATE `creature_template` SET `ScriptName`='npc_wyrmrest_skytalon' WHERE `entry`=30161;
UPDATE `creature_template` SET `ScriptName`='npc_alexstrasza_eoe' WHERE `entry`=32295;

DELETE FROM `spell_script_names` WHERE `spell_id`=56105;
INSERT INTO `spell_script_names` VALUES (56105,'spell_malygos_vortex_dummy');
DELETE FROM `spell_script_names` WHERE `spell_id`=55873;
INSERT INTO `spell_script_names` VALUES (55873,'spell_malygos_vortex_visual');


-- Add spell script names
DELETE FROM `spell_script_names` WHERE `spell_id` IN (56046,56047,61693,61694,57459,56438,61210,56397,58842,59084,59099,56070,56072,60936,60939,61028,61023, 56548);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(56046, 'spell_malygos_portal_beam'),
(56047, 'spell_malygos_random_portal'),
(61693, 'spell_malygos_arcane_storm'), -- Phase I /10/
(61694, 'spell_malygos_arcane_storm'), -- Phase I /25/
(57459, 'spell_malygos_arcane_storm'), -- Phase III
(56438, 'spell_arcane_overload'),
(61210, 'spell_nexus_lord_align_disk_aggro'),
(56397, 'spell_scion_of_eternity_arcane_barrage'),
(58842, 'spell_malygos_destroy_platform_channel'),
(59084, 'spell_alexstrasza_bunny_destroy_platform_boom_visual'),
(59099, 'spell_alexstrasza_bunny_destroy_platform_event'),
(56070, 'spell_wyrmrest_skytalon_summon_red_dragon_buddy'),
(56072, 'spell_wyrmrest_skytalon_ride_red_dragon_buddy_trigger'),
(60936, 'spell_malygos_surge_of_power_25'),
(60939, 'spell_malygos_surge_of_power_warning_selector_25'),
(61028, 'spell_alexstrasza_gift_beam'),
(61023, 'spell_alexstrasza_gift_beam_visual'),
(56548, 'spell_malygos_surge_of_power_P2');

-- Add spell difficulties
DELETE FROM `spelldifficulty_dbc` WHERE `id` IN (61693,56272,57058);
INSERT INTO `spelldifficulty_dbc` (`id`,`spellid0`,`spellid1`,`spellid2`,`spellid3`) VALUES
(61693,61693,61694,0,0), -- Arcane Storm - Phase I
(56272,56272,60072,0,0), -- Arcane Breath
(57058,57058,60073,0,0); -- Arcane Shock (Nexus Lord)

-- Insert missing creature template addon
DELETE FROM `creature_template_addon` WHERE `entry` IN (28859,30234,30248,32295,30592,31748,31749);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(28859,0,0,0x1000000|0x2000000,0x1,0, ''), -- Malygos
(30234,0,0,0x1000000|0x2000000,0x1,0, '43775'), -- Hover Disk (Nexus Lord), add aura "Flight"
(30248,0,0,0x1000000|0x2000000,0x1,0, '43775'), -- Hover Disk (Scion of Eternity), add aura "Flight"
(31748,0,0,0x1000000|0x2000000,0x1,0, '43775'), -- Hover Disk Difficulty (Nexus Lord), add aura "Flight"
(31749,0,0,0x1000000|0x2000000,0x1,0, '43775'), -- Hover Disk Difficulty (Scion of Eternity), add aura "Flight"
(32295,0,0,0x1000000|0x2000000,0x1,0, ''), -- Alexstrasza
(30592,0,0,0x1000000|0x2000000,0x1,0, '57428'); -- Static Field bunny

-- Add, restructure and update missing texts and sounds
DELETE FROM `creature_text` WHERE `entry` IN (28859,32295);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(28859,0,0, 'Lesser beings, intruding here! A shame that your excess courage does not compensate for your stupidity!',14,0,100,0,10000,14512,'Malygos - Intro'),
(28859,0,1, 'None but the blue dragonflight are welcome here. Perhaps this is the work of Alexstrasza? Well, then, she has sent you to your deaths!',14,0,100,0,11000,14513,'Malygos - Intro'),
(28859,0,2, 'What could you hope to accomplish? To storm brazenly into my domain... to employ magic... against ME?',14,0,100,0,13000,14514,'Malygos - Intro'),
(28859,0,3, 'I am without limits here. The rules of your cherished reality do not apply. In this realm, I am in control!',14,0,100,0,10000,14515,'Malygos - Intro'),
(28859,0,4, 'I give you one chance. Pledge fealty to me, and perhaps I will not slaughter you for your insolence.',14,0,100,0,7000,14516,'Malygos - Intro'),
(28859,1,0, 'My patience has reached its limit, I will be rid of you!',14,0,100,0,4000,14517,'Malygos - Start phase 1'),
(28859,2,0, 'You will not succeed while I draw breath!',14,0,100,0,3000,14518,'Malygos - Begin to cast Deep Breath'),
(28859,3,0, 'Your stupidity has finally caught up to you!',14,0,100,0,3250,14519,'Malygos - Killed Player (Phase 1)'),
(28859,3,1, 'More artifacts to confiscate...',14,0,100,0,2800,14520,'Malygos - Killed Player (Phase 1)'),
(28859,3,2, 'How very naive.',14,0,100,0,4800,14521,'Malygos - Killed Player (Phase 1)'),
(28859,4,0, 'I had hoped to end your lives quickly, but you have proven more... resilient than I anticipated. Nonetheless, your efforts are in vain. It is you reckless, careless mortals who are to blame for this war. I do what I must, and if it means your extinction.... then SO BE IT!!',14,0,100,0,22900,14522,'Malygos - End Phase One'),
(28859,5,0, 'Few have experienced the pain I will now inflict upon you!',14,0,100,0,5500,14523,'Malygos - Start phase 2'), -- Unused by Blizzard for some reason
(28859,6,0, 'I will teach you IGNORANT children just how little you know of magic...',14,0,100,0,7000,14524,'Malygos - Anti-Magic Shell'),
(28859,7,0, 'Watch helplessly as your hopes are swept away...',14,0,100,0,4000,14525,'Malygos - Magic Blast'),
(28859,8,0, 'Your energy will be put to good use!',14,0,100,0,2000,14526,'Malygos - Killed Player (Phase 2)'),
(28859,8,1, 'I am the spell-weaver! My power is infinite!',14,0,100,0,5200,14527,'Malygos - Killed Player (Phase 2)'),
(28859,8,2, 'Your spirit will linger here forever!',14,0,100,0,3800,14528,'Malygos - Killed Player (Phase 2)'),
(28859,9,0, 'ENOUGH! If you intend to reclaim Azeroth''s magic, then you shall have it...',14,0,100,0,7000,14529,'Malygos - End Phase 2'),
(28859,10,0, 'Now your benefactors make their appearance... But they are too late. The powers contained here are sufficient to destroy the world ten times over! What do you think they will do to you?',14,0,100,0,13000,14530,'Intro Phase 3'),
(28859,11,0, 'SUBMIT!',14,0,100,0,1000,14531,'Malygos - Start phase 3'), -- Unused by Blizzard for some reason
(28859,12,0, 'Malygos takes a deep breath.',41,0,100,0,10000,0,'Malygos - Surge of Power warning (Phase 2)'),
(28859,13,0, 'The powers at work here exceed anything you could possibly imagine!',14,0,100,0,5000,14532,'Malygos - Surge of Power'),
(28859,14,0, 'I AM UNSTOPPABLE!',14,0,100,0,2000,14533,'Malygos - Buffed by a spark'),
(28859,15,0, 'Alexstrasza! Another of your brood falls!',14,0,100,0,3600,14534,'Malygos - Killed Player (Phase 3)'),
(28859,15,1, 'Little more then gnats!',14,0,100,0,2650,14535,'Malygos - Killed Player (Phase 3)'),
(28859,15,2, 'Your red allies will share your fate...',14,0,100,0,3000,14536,'Malygos - Killed Player (Phase 3)'),
(28859,16,0, 'Still standing? Not for long...',14,0,100,0,3600,14537,'Malygos - Spell Casting 1(Phase 3)'),
(28859,16,1, 'Your cause is lost!',14,0,100,0,2000,14538,'Malygos - Spell Casting 2 (Phase 3)'),
(28859,16,2, 'Your fragile mind will be shattered!',14,0,100,0,4000,14539,'Malygos - Spell Casting 3 (Phase 3)'),
(28859,17,0, 'Unthinkable! The mortals will destroy... everything! My sister, what have you...',14,0,100,0,8500,14540,'Malygos - Death'),
(28859,18,0, '%s fixes his eyes on you!',42,0,100,0,3000,0,'Malygos - Surge of Power warning (Phase 3)'),
(28859,19,0, '%s goes into a berserker rage!',41,0,100,0,10000,0,'Malygos - Hit berserk timer (Any phase)'),
(32295,0,0, 'I did what I had to, brother. You gave me no alternative.',14,0,100,0,4000,14406,'Alexstrasza - Yell text 1'),
(32295,1,0, 'And so ends the Nexus War.',14,0,100,0,4000,14407,'Alexstrasza - Yell text 2'),
(32295,2,0, 'This resolution pains me deeply, but the destruction, the monumental loss of life had to end. Regardless of Malygos''s recent transgressions, I will mourn his loss. He was once a guardian, a protector. This day, one of the world''s mightiest has fallen.',14,0,100,0,24000,14408,'Alexstrasza - Yell text 3'),
(32295,3,0, 'The red dragonflight will take on the burden of mending the devastation wrought on Azeroth. Return home to your people and rest. Tomorrow will bring you new challenges, and you must be ready to face them. Life... goes on.',14,0,100,0,22000,14409,'Alexstrasza - Yell text 4');
-- Update wrong sound and add duration for Power Sparks warning
UPDATE `creature_text` SET `duration`=10000,`sound`=0 WHERE `entry`=30084 AND `groupid`=0 AND`id`=0;

-- Add conditions00
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (56047,58846,61028,56429,56505,59099,61714,61715,57432,57429,61210,56548,56431,56438, 55853, 56263, 56152);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ScriptName`,`Comment`) VALUES
(13,0,56047,0,0,18,0,1,30118,0,0,'', 'Random Portal can implicitly hit only Portal (Malygos)'),
(13,1,56047,0,0,29,0,28859,30,1,0,'', 'Random Portal can implicitly hit only target that is not in 30 yards near Malygos'),
(13,1,58846,0,0,32,0,0x0010,0,0,0,'', 'Summon Red Dragon Buddy force cast can implicitly hit only players'),
(13,0,61028,0,0,18,0,1,32448,0,0,'', 'Alexstrasza''s Gift Beam can hit only Alexstrasza''s Gift'),
(13,0,56429,0,0,18,0,1,31253,0,0,'', 'Summon Arcane Bomb can hit only Alexstrasza the Life-Binder (bunny)'),
(13,0,56505,0,0,18,0,1,30334,0,0,'', 'Surge of Power (phase II) can hit only Surge of Power'),
(13,1,56548,0,0,31,0,3,30234,0,1,'', 'Surge of Power triggered damage spell (phase II) can''t hit melee Hover Disk'),
(13,3,56431,0,0,31,0,3,30234,0,1,'', 'Arcane Overload damage and knockback spell can''t hit melee Hover Disk'),
(13,1,56438,0,0,1,0,1,56438,0,1,'', 'Arcane Overload damage reduce aura can''t apply to target that already is affected by such'),
(13,6,59099,0,0,32,0,0x0010,0,0,0,'', 'Destroy Platform Event effect 1 and 2 can hit only players'),
(13,7,61714,0,0,31,0,3,30245,0,0,'', 'Berserk (spell 2) can hit Nexus Lord'),
(13,7,61714,0,1,31,0,3,30249,0,0,'', 'Berserk (spell 2) can hit Scion of Eternity'),
(13,7,61715,0,0,31,0,3,30592,0,0,'', 'Berserk (spell 3) can hit Static Field bunny'),
(13,0,57432,0,0,18,0,1,30161,0,0,'', 'Arcane Pulse can hit only drakes'),
(13,0,57429,0,0,18,0,1,30161,0,0,'', 'Static Field can hit only drakes');
-- (13,0,61210,0,0,18,0,1,30234,0,0,'', 'Align Disk Aggro can only hit the vehicle of the passenger caster');
INSERT INTO `conditions` (SourceTypeOrReferenceId,ConditionTypeOrReference,SourceGroup,SourceEntry,ConditionValue1,ConditionValue2) VALUES
(13,18,0,55853,1,30090),
(13,18,0,56263,1,30090),
(13,18,0,56152,1,28859);

-- Add missing equipment
DELETE FROM `creature_equip_template` WHERE `entry` IN (30245,31750,30249,31751);
INSERT INTO `creature_equip_template` (`entry`,`itemEntry1`,`itemEntry2`,`itemEntry3`) VALUES
(30245,30714,0,0), -- Nexus Lord
(31750,30714,0,0), -- Nexus Lord (Difficulty)
(30249,29107,0,0), -- Scion of Eternity
(31751,29107,0,0); -- Scion of Eternity (Difficulty)

-- Update accessories of hover disks to die with the vehicle and have lower despawn time. They should fall from hover disks,
-- and despawn after 5 sec, but for some reason they keep staying standing while dead. This needs to be fixed coreside.
UPDATE `vehicle_template_accessory` SET `minion`=1,`summontype`=6,`summontimer`=1000 WHERE `entry`=30234 AND `seat_id`=0;
UPDATE `vehicle_template_accessory` SET `minion`=1,`summontype`=6,`summontimer`=1000 WHERE `entry`=30248 AND `seat_id`=0;

-- Add flag GO not selectable for both and extra condition for Heart of Magic
UPDATE `gameobject_template` SET `flags`=16 WHERE `entry`=193967; -- Alexstrasza Gift
UPDATE `gameobject_template` SET `flags`=20 WHERE `entry`=194159; -- Heart of Magic

-- Add some gameobject data update
UPDATE `gameobject` SET `animprogress`=255,`spawntimesecs`=300 WHERE `guid` IN (151791,193960); -- that spawn time has no influence, but having different values doesn't look correct

-- Delete static GO spawns of Alexstrasza's Gift Boxes, they are dynamic (10/25)
DELETE FROM `gameobject` WHERE `guid` IN (151792,151793);

-- Add map difficulty checks for achievement "Denyin the Scion"
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (7573,7574) AND `type`=12;
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`) VALUES
(7573,12,0), -- 10 mode
(7574,12,1); -- 25 mode

-- Delete Nexus Lords SAI script, because of incapacity to handle the combat spell mechanic of Arcane Shock correctly
-- Delete Scions of Eternity SAI script, because of incapacity to handle non reactive AI when being attacked in a way it won't bug other encounter mechanics.
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (30245,30249) AND `source_type`=0;

-- Add SAI support for Alexstrasza since is only short timed event after boss mechanic ends
SET @NPC_ALEXSTRASZA  := 32295;
SET @ACTIONLIST       := @NPC_ALEXSTRASZA * 100;
SET @SPELL_GIFT_BEAM  := 61028;

-- Add areatrigger script for the improvised platform that is killing/rooting falling players
DELETE FROM `areatrigger_scripts` WHERE `entry`=5342;
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES
(5342, 'at_eye_of_eternity_improvised_floor');

-- /////////////// Various misc in creature, creature template and creature addon ///////////////
-- Update some guids spawn positions
UPDATE `creature` SET `position_x`=754.362,`position_y`=1301.61,`position_z`=266.171,`orientation`=4.24115 WHERE `guid`=132302; -- Alexstrasza the Life-Binder (Bunny)
UPDATE `creature` SET `position_x`=747.61,`position_y`=1393.43,`position_z`=295.9722,`orientation`=3.03832 WHERE `guid`=132313; -- Malygos

-- Update some creature guids to be have static MovementType and spawn dist to 0 accordingly
UPDATE `creature` SET `spawndist`=0,`MovementType`=0 WHERE `guid` IN
(132313, -- Malygos
132314, -- Alexstrasza''s Gift Bunny
132302); -- Alexstrasza the Life-Binder (Bunny)

-- Update template to InhabitType "Air" for various creatures
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry` IN (28859,31734,30245,31750,30249,31751,32295,32448);

-- Clear scripts names for Alexstrasza the Life-Binder (Bunny)
UPDATE `creature_template` SET `AIName`='',`ScriptName`='' WHERE `entry`=31253;

--  Update Portal (Malygos) initial flags before the encounter starts
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|0x00000100|0x02000000,`flags_extra`=128 WHERE `entry`=30118; -- Immunity to Players + Not selectable

-- Update flags extra to trigger & civilian for Static Field and add script name
UPDATE `creature_template` SET `AIName`='',`ScriptName`='npc_static_field',`flags_extra`=130 WHERE `entry`=30592;

-- Update flags extra to extra trigger & extra civilian for Alexstrasza Bunny
UPDATE `creature_template` SET `flags_extra`=130, `ScriptName`='' WHERE `entry`=31253;

-- Remove uneeded creature_addon data
DELETE FROM `creature_addon` WHERE `guid` IN
(30592, -- The spawn for Static Field is dynamique, so not fixed guid.
132313); -- Malygos is boss so is unique and needs only the template addon.

-- Update templates for both types of hover disks
UPDATE `creature_template` SET `faction_A`=14,`faction_H`=14,`VehicleId`=223,`InhabitType`=4 WHERE `entry` IN (30248,31749); -- Hover disk for Scions
UPDATE `creature_template` SET `ScriptName`='npc_caster_hover_disk' WHERE `entry`=30248;
UPDATE `creature_template` SET `faction_A`=14,`faction_H`=14,`InhabitType`=4 WHERE `entry` IN (30234,31748); -- Hover disk for Nexus Lords
UPDATE `creature_template` SET `ScriptName`='npc_melee_hover_disk' WHERE `entry`=30234;
UPDATE `creature_template` SET `AIName`='',`ScriptName`='npc_nexus_lord' WHERE `entry`=30245; -- Nexus Lord
UPDATE `creature_template` SET `AIName`='',`ScriptName`='npc_scion_of_eternity' WHERE `entry`=30249; -- Scion of Eternity

-- Fix model display for Vortex Triggers (in creature handling).
-- Remove extra trigger flag because for some reason it was bugging model displaying as always visible,
-- since it has the invisible one for triggers first and other as second, this is the only nonhacky way (don't try to change it unless core side != c++ hack in instance script)
UPDATE `creature_template` SET `flags_extra`=flags_extra &~ 0x00000080 WHERE `entry`=30090;
UPDATE `creature` SET `modelid`=11686 WHERE `guid` BETWEEN 132304 AND 132308;

delete from event_scripts where id = 20711;

delete from disables where sourceType = 8 and entry = 616;
insert into disables values(8, 616, 0, '', '', 'disable malygos height relocation');


delete from waypoint_data where id = 2885900;
insert into waypoint_data values
(2885900, 1, 808.0, 1293.0, 297.0, 0, 0, 0, 0, 100, 0),
(2885900, 2, 758.44, 1247.34, 297.0, 0, 0, 0, 0, 100, 0),
(2885900, 3, 700.47, 1297.01, 297.0, 0, 0, 0, 0, 100, 0),
(2885900, 4, 749.18, 1355.24, 297.0, 0, 0, 0, 0, 100, 0),
(2885900, 5, 800.72, 1330.02, 297.0, 0, 0, 0, 0, 100, 0);

delete from gameobject where id = 193960;
insert into `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) values
('193960','616','2','1','754.255','1301.72','266.17','-1.6057','0','0','0','0','604800','0','1');


-- update creature_template set mechanic_immune_mask = 617299967 where entry in (30084, 32187);
update creature_template set mechanic_immune_mask = 0 where entry in (30084, 32187);


delete from gameobject_loot_template where entry in (26859, 26860, 26094, 26097);
insert into `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) values
('26094','1','100','1','0','-34174','2'),
('26094','43953','1','1','0','1','1'),
('26094','47241','100','1','0','2','2'),
('26097','1','100','1','0','-34175','4'),
('26097','40753','100','1','0','2','2'),
('26097','43952','1','1','0','1','1'),
('26097','47241','100','1','0','2','2'),
('26859','44650','100','1','0','1','1'),
('26860','44651','100','1','0','1','1');

delete from gameobject_template where entry in (194159, 193967, 194158, 193905, 193958, 193960);
insert into `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `faction`, `flags`, `size`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `AIName`, `ScriptName`, `WDBVerified`) values
('194159','3','8555','Heart of Magic','','','0','20','7','44651','0','0','0','0','0','1818','26860','0','0','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','','11159'),
('193967','3','8513','Alexstrasza\'s Gift','','','0','16','15','0','0','0','0','0','0','1818','26097','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','','11159'),
('194158','3','8555','Heart of Magic','','','0','0','7','44650','0','0','0','0','0','1818','26859','0','0','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','','12340'),
('193905','3','8513','Alexstrasza\'s Gift','','','0','0','15','0','0','0','0','0','0','1818','26094','0','1','0','0','0','0','0','0','0','1','0','1','0','1','0','0','0','0','0','0','0','0','','','12340'),
('193958','10','7800','The Focusing Iris','','','0','0','5','0','0','0','0','0','0','1817','0','20711','3000','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','12340'),
('193960','10','7800','The Focusing Iris','','','0','0','5','0','0','0','0','0','0','1816','0','20711','3000','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','','11159');

update creature_template set flags_extra = 128, modelid2 = 0 where entry = 30090;
