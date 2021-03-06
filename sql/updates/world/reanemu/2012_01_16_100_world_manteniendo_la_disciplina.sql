-- SAI For "Exhausted Vrykul", quests "Discipline" & "Maintaining discipline"
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
