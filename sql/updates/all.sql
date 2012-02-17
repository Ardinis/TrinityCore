UPDATE `version` SET `db_version`='TDB 335.11.46' LIMIT 1;
-- Criteria conditions for Once Bitten, Twice Shy achievement
DELETE FROM `achievement_criteria_data` WHERE `type`=12 AND `criteria_id` IN (13013, 13012, 13011, 12780);
INSERT INTO `achievement_criteria_data` (`criteria_id`,`type`,`value1`,`value2`,`scriptname`) VALUES
(13013, 12, 1, 0, ""), -- heroic
(13012, 12, 1, 0, ""), -- heroic
(13011, 12, 0, 0, ""), -- normal
(12780, 12, 0, 0, ""); -- normalUPDATE `quest_template` SET `OfferRewardText` = 'Good, $C. You have done well in serving the Dark Lady. Your continued perseverance and ambition will be of great use to the Lady''s subjects. Return to me again in the future. Perhaps I will have other tasks for you that will aid the Dark Lady in her attempts at overtaking the Lich King and completely freeing the Scourge.', `RequestItemsText` = 'There are a hundred other tasks awaiting my attention, $C. Do you have the books?' WHERE `Id` = 14356;
DELETE FROM `areatrigger_tavern` WHERE `id` IN (98, 4109, 4300, 4378, 4380, 4498, 4608, 5314, 5315, 5316, 5317);
INSERT INTO `areatrigger_tavern` (`id`, `name`) VALUES 
(98, 'Nesingwary''s Expedition'),
(4109, 'Tranquillen - Upper level Inn'),
(4300, 'Cenarion Refugee - Outside Inn'),
(4378, 'Stonebreaker Hold Inn'),
(4380, 'Falcon Watch Inn'),
(4498, 'Old Hillsbrad Foothills Inn'),
(4608, 'Sanctum Of The Stars - Upper level Inn'),
(5314, 'Wyrmrest Temple'),
(5315, 'Wyrmrest Temple'),
(5316, 'Wyrmrest Temple'),
(5317, 'Wyrmrest Temple');
DELETE FROM `item_template` WHERE `entry`=49867;
INSERT INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `FlagsExtra`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `StatsCount`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `ScalingStatDistribution`, `ScalingStatValue`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `Duration`, `ItemLimitCategory`, `HolidayId`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `WDBVerified`) VALUES
(49867, 12, 0, -1, 'Crown Chemical Co. Supplies', 11448, 1, 0, 8192, 1, 0, 0, 0, -1, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1000, 0, 0, 0, 0, NULL, 0, -1, 0, -1, 0, 0, NULL, 0, -1, 0, -1, 0, 0, NULL, 0, -1, 0, -1, 0, 0, NULL, 0, -1, 0, -1, 0, 0, NULL, 0, -1, 0, -1, 4, 'You can hear the clink of glass... dont drop it!', 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 423, 0, 0, 0, 0, 14545);
-- Love is in the Air 
-- Quests Missing Text ... By Albis

UPDATE `quest_template` SET `RequestItemsText` ='The cologne isn''t going to give itself out, you know.$B$BGet spraying!' , `OfferRewardText` ='Nice work, $N! People will be buying Crown colognes by the crate-load now that they''ve had a chance to try them.$B$BHere''s a little something for helping us out.' WHERE `Id` = 24635;
UPDATE `quest_template` SET `RequestItemsText` ='That perfume''s not going to spray itself, you know.$B$BGet going!' , `OfferRewardText` ='Great work, $N! People will come running to buy Crown perfumes now that they''ve had a chance to sample their wonders.$B$BHere''s a little something for helping us out.' WHERE `Id` = 24629;
UPDATE `quest_template` SET `RequestItemsText` ='You know, those chocolates aren''t going to fling themselves at people.$B$BYou need to get to work!' , `OfferRewardText` ='Lovely work, $N! People will be tripping over one another to get Crown chocolates now that they''ve had a chance to taste those sweet, romantic treats.$B$BHere''s a little something for helping us out.' WHERE `Id` = 24636;
UPDATE `quest_template` SET `OfferRewardText` ='Hey. You got some time on your hands? I could use someone like you.' WHERE `Id` IN (24804,24805);
UPDATE `quest_template` SET `RequestItemsText` ='You analyze that reek yet, kid?' , `OfferRewardText` ='Hey, thanks, kid. Give it over, let''s take a look.$B$B<He takes the device from you and fiddles with it.>$B$BOh, that ain''t good.' WHERE `Id` IN (24655,24536);
UPDATE `quest_template` SET `RequestItemsText` ='Did they toss ya a crate to deliver?' , `OfferRewardText` ='You got it, huh? Good job, kid. Top notch. Let''s see what we what we got here.$B$B<He cracks open the crate and rummages around inside.' WHERE `Id` IN (24656,24541);
UPDATE `quest_template` SET `OfferRewardText` ='You... You''re not Snivel. Did he send you? He''s so late, I had started to give up hope...$B$B<Tears start welling up in the woman''s eyes once she realizes that you aren''t there to deliver a message from Snivel.>$B$BThat''s not like my Snivel, but what choice is there?' WHERE `Id` = 24848;
UPDATE `quest_template` SET `OfferRewardText` ='You''re not Snivel. He was supposed to be here an hour ago! What have you done with him?$B$B<Roka seems to calm down when you tell her that you''re looking for Snivel, too. Then the tears start to well up in her eyes.>$B$BThis isn''t like my Snivel. Do you think something''s happened to him?' WHERE `Id` = 24850;
UPDATE `quest_template` SET `RequestItemsText` ='Who are you?' , `OfferRewardText` ='All he talked about was leaving town with all his money? Then he really has abandoned me, hasn''t he?$B$BOh, $N. I was such a fool to fall for him, but how could I help myself? He was so irresistible!' WHERE `Id` = 24849;
UPDATE `quest_template` SET `RequestItemsText` ='Who are you?' , `OfferRewardText` ='All he talked about was leaving town with all his money? Then he really has abandoned me, hasn''t he?$B$BI can''t believe I fell for such a horrible goblin! But he was so irresistible when we first met.' WHERE `Id` = 24851;
UPDATE `quest_template` SET `RequestItemsText` ='Did you find the guy, or did he crawl under a rock?' , `OfferRewardText` ='You got his ledger? Really? That''s great, $N. There''s probably loads of good information in here.' WHERE `Id` IN (24657,24576);
UPDATE `quest_template` SET `OfferRewardText` ='Fantastic. Help is exactly what I need.' WHERE `Id` IN (24792,24793);
UPDATE `quest_template` SET `RequestItemsText` ='I don''t remember ordering a cleaing service... why yes, I am Apothecary Hummel.$B$B...wait, what is the meaning of this? You think these meaningless papers can stop me? Hah!' , `OfferRewardText` ='What we do here is none of your business...' WHERE `Id` = 11488;
UPDATE `quest_template` SET `RequestItemsText` ='Did you take care of those no-good scheming villains?' , `OfferRewardText` ='What''ve you got there?$B$BOh hey, this is big. Real big. Most of the crazy details in one little package. Thanks - you really helped us reel this all in. Good working with ya.' WHERE `Id` IN (24745,14483);
UPDATE `quest_template` SET `RequestItemsText` ='Did you teach ''em a lesson?' , `OfferRewardText` ='Good job, kid. You deserve a little somethin''. And hey, come back tomorrow if you get the time; I might have a job for ya.' WHERE `Id` IN (24658,24665,24666,24664,24663,24659,24660,24662,24647,24638,24651,24652,24650,24649,24645,24648);
-- Horde
UPDATE `quest_template` SET `PrevQuestId`=24805 WHERE `Id`=24536; -- Uncommon Scents completed before starting Something Stinks
UPDATE `quest_template` SET `PrevQuestId`=24536 WHERE `Id`=24541; -- Something Stinks completed before starting Pilfering Perfume
UPDATE `quest_template` SET `PrevQuestId`=24541 WHERE `Id`=24850; -- Pilfering Perfume completed before starting Snivel's Sweetheart
UPDATE `quest_template` SET `PrevQuestId`=24850 WHERE `Id`=24851; -- Snivel's Sweetheart completed before starting Hot On The Trail
UPDATE `quest_template` SET `PrevQuestId`=24851 WHERE `Id`=24576; -- Hot On The Trail completed before starting A Friendly Chat...

UPDATE `quest_template` SET `PrevQuestId`=24576 WHERE `Id` IN (24638,24645,24647,24648,24649,24650,24651,24652); -- A Friendly Chat... completed before starting Crushing the Crown

-- Alliance
UPDATE `quest_template` SET `PrevQuestId`=24804 WHERE `Id`=24655; -- Uncommon Scents completed before starting Something Stinks
UPDATE `quest_template` SET `PrevQuestId`=24655 WHERE `Id`=24656; -- Something Stinks completed before starting Pilfering Perfume
UPDATE `quest_template` SET `PrevQuestId`=24656 WHERE `Id`=24848; -- Pilfering Perfume completed before starting Snivel's Sweetheart
UPDATE `quest_template` SET `PrevQuestId`=24848 WHERE `Id`=24849; -- Snivel's Sweetheart completed before starting Hot On The Trail
UPDATE `quest_template` SET `PrevQuestId`=24849 WHERE `Id`=24657; -- Hot On The Trail completed before starting A Friendly Chat...

UPDATE `quest_template` SET `PrevQuestId`=24657 WHERE `Id` IN (24658,24659,24660,24662,24663,24664,24665,24666); -- A Friendly Chat... completed before starting Crushing the Crown
DELETE FROM `creature_involvedrelation` WHERE `quest`=24745;
INSERT INTO `creature_involvedrelation` (`id`, `quest`) VALUES
(38066, 24745); -- A - Something is in the Air (and it Ain't Love) - Inspector Snip Snagglebolt
SET @GUID := 40489;
SET @NPC :=3254;

DELETE FROM `creature` WHERE `guid` BETWEEN @GUID AND @GUID+7;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(@GUID  ,@NPC,1,1,1,0,0, 10.3997021, -2316.43555, 92.1945343, 2.91896486,120,0,0,1,0,0,0,0,0),
(@GUID+1,@NPC,1,1,1,0,0,346.736572 , -2606.38916, 91.7916641, 1.58010352,120,0,0,1,0,0,0,0,0),
(@GUID+2,@NPC,1,1,1,0,0, 83.07206  , -2545.2085 , 98.107666 , 1.86412442,120,0,0,1,0,0,0,0,0),
(@GUID+3,@NPC,1,1,1,0,0,-93.53362  , -2287.0835 , 92.35358  , 0.8518014 ,120,0,0,1,0,0,0,0,0),
(@GUID+4,@NPC,1,1,1,0,0,-618.9995,-2738.234,91.91664,4.303216,120,0,0,1,0,0,0,0,0),
(@GUID+5,@NPC,1,1,1,0,0,-491.2982,-2473.443,93.66666,2.670027,120,0,0,1,0,0,0,0,0),
(@GUID+6,@NPC,1,1,1,0,0,-614.9523,-2721.66 ,93.85735,1.412064,120,0,0,1,0,0,0,0,0),
(@GUID+7,@NPC,1,1,1,0,0,-617.4864,-2710.463,96.7657 ,1.582084,120,0,0,1,0,0,0,0,0);

SET @NPC1=@GUID*10;
SET @NPC2=(@GUID+1)*10;
SET @NPC3=(@GUID+2)*10;
SET @NPC4=(@GUID+3)*10;
SET @NPC5=(@GUID+6)*10;
SET @NPC6=(@GUID+7)*10;

DELETE FROM `waypoint_data` WHERE `id` IN (@NPC1,@NPC2,@NPC3,@NPC4,@NPC5,@NPC6);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
-- 1st
(@NPC1,1,6.336712,-2322.309,92.16663,0,0,0,0,100,0),
-- 2nd
(@NPC2,1,346.4289,-2573.332,91.79166,0,0,0,0,100,0),
-- 3rd
(@NPC3,1,81.53384,-2540.826,97.38716,0,0,0,0,100,0),
(@NPC3,2,80.28384,-2537.076,96.63716,0,0,0,0,100,0),
(@NPC3,3,79.03384,-2533.326,95.38716,0,0,0,0,100,0),
(@NPC3,4,78.28384,-2530.326,94.63716,0,0,0,0,100,0),
(@NPC3,5,77.03384,-2526.576,93.63716,0,0,0,0,100,0),
(@NPC3,6,76.49564,-2523.443,93.66665,0,0,0,0,100,0),
-- 4th
(@NPC4,1,-88.46167,-2281.137,92.69763,0,0,0,0,100,0),
(@NPC4,2,-92.46167,-2285.637,91.94763,0,0,0,0,100,0),
-- 5th
(@NPC5,1,-614.9318,-2720.435,94.01199,0,0,0,0,100,0),
-- 6th
(@NPC6,1,-617.2921,-2722.99,93.41664,0,0,0,0,100,0),
(@NPC6,2,-617.3077,-2721.99,93.41664,0,0,0,0,100,0),
(@NPC6,3,-617.3398,-2719.99,94.16664,0,0,0,0,100,0),
(@NPC6,4,-617.3867,-2716.99,95.04164,0,0,0,0,100,0),
(@NPC6,5,-617.4336,-2713.99,95.91664,0,0,0,0,100,0),
(@NPC6,6,-617.4805,-2710.99,96.66664,0,0,0,0,100,0),
(@NPC6,7,-617.503,-2708.995,97.04164,0,0,0,0,100,0),
(@NPC6,8,-617.503,-2708.995,97.04164,0,0,0,0,100,0);

DELETE FROM `creature_addon` WHERE `guid` IN (@GUID,@GUID+1,@GUID+2,@GUID+3,@GUID+6,@GUID+7);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(@GUID  ,@NPC1,0,0,0,0,''),
(@GUID+1,@NPC2,0,0,0,0,''),
(@GUID+2,@NPC3,0,0,0,0,''),
(@GUID+3,@NPC4,0,0,0,0,''),
(@GUID+6,@NPC5,0,0,0,0,''),
(@GUID+7,@NPC6,0,0,0,0,'');
SET @NPC := 26841;
SET @GUID := 40497; -- need 9

SET @SPAWN0 := (@GUID  )*10;
SET @SPAWN1 := (@GUID+1)*10;
SET @SPAWN2 := (@GUID+2)*10;
SET @SPAWN3 := (@GUID+3)*10;
SET @SPAWN4 := (@GUID+4)*10;
SET @SPAWN5 := (@GUID+5)*10;
SET @SPAWN6 := (@GUID+6)*10;
SET @SPAWN7 := (@GUID+7)*10;
SET @SPAWN8 := (@GUID+8)*10;

DELETE FROM `creature` WHERE `guid` BETWEEN @GUID AND @GUID+8;
INSERT INTO creature (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(@GUID  ,@NPC,571,1,1,0,0,4690.292,859.291,154.1271,2.914072,120,0,0,1,0,0,0,0,0),
(@GUID+1,@NPC,571,1,1,0,0,4362.418,750.5102,123.7846,6.194367,120,0,0,1,0,0,0,0,0),
(@GUID+2,@NPC,571,1,1,0,0,4191.03,645.8215,109.6868,0.4027403,120,0,0,1,0,0,0,0,0),
(@GUID+3,@NPC,571,1,1,0,0,4098.345,657.0866,99.36436,5.185792,120,0,0,1,0,0,0,0,0),
(@GUID+4,@NPC,571,1,1,0,0,4065.753,709.2308,108.47,1.153499,120,0,0,1,0,0,0,0,0),
(@GUID+5,@NPC,571,1,1,0,0,4012.895,495.4877,82.1595,0.8684024,120,0,0,1,0,0,0,0,0),
(@GUID+6,@NPC,571,1,1,0,0,3941.605,552.9745,144.0994,0.06546114,120,0,0,1,0,0,0,0,0),
(@GUID+7,@NPC,571,1,1,0,0,3995.586,447.6094,88.55691,1.320955,120,0,0,1,0,0,0,0,0),
(@GUID+8,@NPC,571,1,1,0,0,3869.004,707.384,134.3378,4.695541,120,0,0,1,0,0,0,0,0);

DELETE FROM `creature_addon` WHERE `guid` BETWEEN @GUID AND @GUID+8;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(@GUID  ,@SPAWN0,0,0,0,0,''),
(@GUID+1,@SPAWN1,0,0,0,0,''),
(@GUID+2,@SPAWN2,0,0,0,0,''),
(@GUID+3,@SPAWN3,0,0,0,0,''),
(@GUID+4,@SPAWN4,0,0,0,0,''),
(@GUID+5,@SPAWN5,0,0,0,0,''),
(@GUID+6,@SPAWN6,0,0,0,0,''),
(@GUID+7,@SPAWN7,0,0,0,0,''),
(@GUID+8,@SPAWN8,0,0,0,0,'');

DELETE FROM `waypoint_data` WHERE `id` IN (@SPAWN0,@SPAWN1,@SPAWN2,@SPAWN3,@SPAWN4,@SPAWN5,@SPAWN6,@SPAWN7,@SPAWN8);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
-- 1st
(@SPAWN0,0,4716.777,833.6211,169.0006,0,0,0,0,100,0),
(@SPAWN0,1,4643.756,855.9798,132.5562,0,0,0,0,100,0),
(@SPAWN0,2,4550.864,812.4362,133.6673,0,0,0,0,100,0),
(@SPAWN0,3,4532.678,762.772,130.1951,0,0,0,0,100,0),
(@SPAWN0,4,4566.182,662.6984,132.7506,0,0,0,0,100,0),
(@SPAWN0,5,4592.511,595.6938,130.1674,0,0,0,0,100,0),
(@SPAWN0,6,4732.632,631.5569,164.584,0,0,0,0,100,0),
(@SPAWN0,7,4716.777,833.6211,169.0006,0,0,0,0,100,0),
(@SPAWN0,8,4643.756,855.9798,132.5562,0,0,0,0,100,0),
(@SPAWN0,9,4550.864,812.4362,133.6673,0,0,0,0,100,0),
-- 2nd
(@SPAWN1,0,4431.805,596.8371,157.1775,0,0,0,0,100,0),
(@SPAWN1,1,4128.16,507.4055,198.8118,0,0,0,0,100,0),
(@SPAWN1,2,4102.405,567.1112,198.8118,0,0,0,0,100,0),
(@SPAWN1,3,4112.486,636.6321,86.95068,0,0,0,0,100,0),
(@SPAWN1,4,4141.771,704.1605,67.97847,0,0,0,0,100,0),
(@SPAWN1,5,4191.388,726.6014,98.11736,0,0,0,0,100,0),
(@SPAWN1,6,4247.502,724.9836,182.4229,0,0,0,0,100,0),
(@SPAWN1,7,4295.807,746.8245,210.1174,0,0,0,0,100,0),
(@SPAWN1,8,4387.15,744.5955,93.08962,0,0,0,0,100,0),
(@SPAWN1,9,4428.509,680.8868,91.33962,0,0,0,0,100,0),
(@SPAWN1,10,4431.805,596.8371,157.1775,0,0,0,0,100,0),
(@SPAWN1,11,4128.16,507.4055,198.8118,0,0,0,0,100,0),
(@SPAWN1,12,4102.405,567.1112,198.8118,0,0,0,0,100,0),
-- 3rd
(@SPAWN2,0,4170.111,627.0887,100.283,0,0,0,0,100,0),
(@SPAWN2,1,4265.816,644.1154,136.2274,0,0,0,0,100,0),
(@SPAWN2,2,4272.799,551.5093,50.92185,0,0,0,0,100,0),
(@SPAWN2,3,4378.531,451.3199,54.28299,0,0,0,0,100,0),
(@SPAWN2,4,4277.019,345.219,121.2274,0,0,0,0,100,0),
(@SPAWN2,5,4185.893,458.5754,118.5608,0,0,0,0,100,0),
(@SPAWN2,6,4170.111,627.0887,100.283,0,0,0,0,100,0),
(@SPAWN2,7,4265.816,644.1154,136.2274,0,0,0,0,100,0),
(@SPAWN2,8,4272.799,551.5093,50.92185,0,0,0,0,100,0),
-- 4th
(@SPAWN3,0,4464.15,712.9612,99.36437,0,0,0,0,100,0),
(@SPAWN3,1,4466.412,769.1019,99.36437,0,0,0,0,100,0),
(@SPAWN3,2,4427.949,785.3342,99.36437,0,0,0,0,100,0),
(@SPAWN3,3,4382.415,794.0613,99.36437,0,0,0,0,100,0),
(@SPAWN3,4,4312.128,808.5213,99.36437,0,0,0,0,100,0),
(@SPAWN3,5,4206.404,817.2534,99.36437,0,0,0,0,100,0),
(@SPAWN3,6,4089.363,771.5425,99.36437,0,0,0,0,100,0),
(@SPAWN3,7,4114.452,637.4808,99.36437,0,0,0,0,100,0),
(@SPAWN3,8,4265.095,661.3358,99.36437,0,0,0,0,100,0),
(@SPAWN3,9,4366.876,678.4272,99.36437,0,0,0,0,100,0),
(@SPAWN3,10,4433.122,674.1555,99.36437,0,0,0,0,100,0),
(@SPAWN3,11,4464.15,712.9612,99.36437,0,0,0,0,100,0),
(@SPAWN3,12,4466.412,769.1019,99.36437,0,0,0,0,100,0),
(@SPAWN3,13,4427.949,785.3342,99.36437,0,0,0,0,100,0),
-- 5th
(@SPAWN4,0,4331.604,778.9,114.7446,0,0,0,0,100,0),
(@SPAWN4,1,4270.823,698.3784,130.4668,0,0,0,0,100,0),
(@SPAWN4,2,4232.598,681.8058,126.7724,0,0,0,0,100,0),
(@SPAWN4,3,4156.661,638.471,129.439,0,0,0,0,100,0),
(@SPAWN4,4,4062.89,681.9251,102.9113,0,0,0,0,100,0),
(@SPAWN4,5,4096.761,758.9566,123.5501,0,0,0,0,100,0),
(@SPAWN4,6,4134.598,799.989,109.8835,0,0,0,0,100,0),
(@SPAWN4,7,4189.475,840.5444,114.6335,0,0,0,0,100,0),
(@SPAWN4,8,4274.875,812.3191,101.3001,0,0,0,0,100,0),
(@SPAWN4,9,4331.604,778.9,114.7446,0,0,0,0,100,0),
(@SPAWN4,10,4270.823,698.3784,130.4668,0,0,0,0,100,0),
(@SPAWN4,11,4232.598,681.8058,126.7724,0,0,0,0,100,0),
-- 6th
(@SPAWN5,0,3769.598,454.0081,82.1595,0,0,0,0,100,0),
(@SPAWN5,1,3879.825,441.5815,82.1595,0,0,0,0,100,0),
(@SPAWN5,2,3926.388,447.295,82.1595,0,0,0,0,100,0),
(@SPAWN5,3,4017.082,501.3171,82.1595,0,0,0,0,100,0),
(@SPAWN5,4,4015.132,597.8423,82.1595,0,0,0,0,100,0),
(@SPAWN5,5,3923.788,576.8113,82.1595,0,0,0,0,100,0),
(@SPAWN5,6,3865.991,561.2335,82.1595,0,0,0,0,100,0),
(@SPAWN5,7,3795.942,538.189,82.1595,0,0,0,0,100,0),
(@SPAWN5,8,3769.598,454.0081,82.1595,0,0,0,0,100,0),
(@SPAWN5,9,3879.825,441.5815,82.1595,0,0,0,0,100,0),
(@SPAWN5,10,3926.388,447.295,82.1595,0,0,0,0,100,0),
-- 7th
(@SPAWN6,0,3886.876,810.7806,134.3378,0,0,0,0,100,0),
(@SPAWN6,1,3868.72,688.4549,134.3378,0,0,0,0,100,0),
(@SPAWN6,2,3883.254,607.1956,134.3378,0,0,0,0,100,0),
(@SPAWN6,3,3904.998,559.2425,134.3378,0,0,0,0,100,0),
(@SPAWN6,4,3969.396,561.8792,148.5877,0,0,0,0,100,0),
(@SPAWN6,5,4010.678,638.0726,130.6155,0,0,0,0,100,0),
(@SPAWN6,6,3976.813,756.3585,134.3378,0,0,0,0,100,0),
(@SPAWN6,7,3886.876,810.7806,134.3378,0,0,0,0,100,0),
(@SPAWN6,8,3868.72,688.4549,134.3378,0,0,0,0,100,0),
(@SPAWN6,9,3883.254,607.1956,134.3378,0,0,0,0,100,0),
-- 8th
(@SPAWN7,0,4187.318,438.9777,88.55692,0,0,0,0,100,0),
(@SPAWN7,1,4151.397,351.4095,88.55692,0,0,0,0,100,0),
(@SPAWN7,2,4106.679,347.3126,88.55692,0,0,0,0,100,0),
(@SPAWN7,3,4056.414,373.3088,88.55692,0,0,0,0,100,0),
(@SPAWN7,4,3994.193,440.1974,88.55692,0,0,0,0,100,0),
(@SPAWN7,5,4076.892,564.8895,88.55692,0,0,0,0,100,0),
(@SPAWN7,6,4178.652,558.3406,88.55692,0,0,0,0,100,0),
(@SPAWN7,7,4187.318,438.9777,88.55692,0,0,0,0,100,0),
(@SPAWN7,8,4151.397,351.4095,88.55692,0,0,0,0,100,0),
(@SPAWN7,9,4106.679,347.3126,88.55692,0,0,0,0,100,0),
-- 9th
(@SPAWN8,0,3886.876,810.7806,134.3378,0,0,0,0,100,0),
(@SPAWN8,1,3868.72,688.4549,134.3378,0,0,0,0,100,0),
(@SPAWN8,2,3883.254,607.1956,134.3378,0,0,0,0,100,0),
(@SPAWN8,3,3904.998,559.2425,134.3378,0,0,0,0,100,0),
(@SPAWN8,4,3969.396,561.8792,148.5877,0,0,0,0,100,0),
(@SPAWN8,5,4010.678,638.0726,130.6155,0,0,0,0,100,0),
(@SPAWN8,6,3976.813,756.3585,134.3378,0,0,0,0,100,0),
(@SPAWN8,7,3886.876,810.7806,134.3378,0,0,0,0,100,0),
(@SPAWN8,8,3868.72,688.4549,134.3378,0,0,0,0,100,0),
(@SPAWN8,9,3883.254,607.1956,134.3378,0,0,0,0,100,0);
-- Love is in the Air
SET @OGUID := 24399;
SET @CGUID := 40506;
SET @OLDGUID := 40489; -- wrong guids
SET @EVENT := 8;

-- Quest chain
DELETE FROM `creature_questrelation` WHERE `quest` IN (24804,24657,24656,24848,24849);
INSERT INTO `creature_questrelation` (`id`, `quest`) VALUES
(38293, 24804), -- A - Uncommon Scents - Junior Inspector
(38325, 24657), -- A - Friendly Chat... - Marion Sutton
(38066, 24656), -- A - Pilfering Perfume - Inspector Snip Snagglebolt
(38066, 24848), -- A - Fireworks At The Gilded Rose - Inspector Snip Snagglebolt
(38325, 24849); -- A - Hot On The Trail - Marion Sutton

DELETE FROM `creature_involvedrelation` WHERE `quest` IN (24804,24657,24656,24848,24849);
INSERT INTO `creature_involvedrelation` (`id`, `quest`) VALUES
(38066, 24804), -- A - Uncommon Scents - Inspector Snip Snagglebolt
(38066, 24657), -- A - Friendly Chat... - Inspector Snip Snagglebolt
(38066, 24656), -- A - Pilfering Perfume - Inspector Snip Snagglebolt
(38325, 24848), -- A - Fireworks At The Gilded Rose - Marion Sutton
(38325, 24849); -- A - Hot On The Trail - Marion Sutton

-- Loot: Crown Chemical Co. Supplies
DELETE FROM `gameobject_loot_template` WHERE `entry`=27766;
INSERT INTO `gameobject_loot_template` VALUES 
(27766, 49867, -100, 1, 0, 1, 1); --  Crown Chemical Co. Supplies

-- GO spawns
DELETE FROM `gameobject` WHERE `id` IN (181086,201752,201778) AND `guid` BETWEEN @OGUID+0 AND @OGUID+42;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
-- Valentine Arch
(@OGUID+0, 181086, 1, 1, 1, 9869.12, 2493.13, 1315.88, 6.16653, 0, 0, 0.0582931, -0.9983, 300, 0, 1),
(@OGUID+1, 181086, 530, 1, 1, -4004.66, -11844.5, 0.19541, 4.93701, 0, 0, 0.623403, -0.7819, 300, 0, 1),
(@OGUID+2, 181086, 0, 1, 1, -4918.78, -983.208, 501.455, 2.30465, 0, 0, 0.913711, 0.406364, 300, 0, 1),
(@OGUID+3, 181086, 0, 1, 1, -8869.51, 636.686, 95.7873, 0.794388, 0, 0, 0.386832, 0.92215, 300, 0, 1),
(@OGUID+4, 181086, 1, 1, 1, 1653.44, -4437.37, 18.1863, 1.72627, 0, 0, 0.759883, 0.65006, 300, 0, 1),
(@OGUID+5, 181086, 1, 1, 1, -1224.34, 68.3642, 129.71, 3.17285, 0, 0, 0.999878, -0.015627, 300, 0, 1),
(@OGUID+6, 181086, 530, 1, 1, 9612.28, -7184.77, 14.285, 1.82938, 0, 0, 0.792374, 0.610036, 300, 0, 1),
(@OGUID+7, 181086, 0, 1, 1, 1629.62, 240.116, 63.8516, 0.155664, 0, 0, 0.0777534, 0.996973, 300, 0, 1),
-- Large Crate
(@OGUID+8, 201752, 0, 1, 1, -9029.77, 353.325, 92.923, 0.8808, 0, 0, 0.426301, 0.904581, 300, 0, 1),
(@OGUID+9, 201752, 0, 1, 1, -9029.87, 351.542, 92.9248, 0.489671, 0, 0, 0.242397, 0.970177, 300, 0, 1),
(@OGUID+10, 201752, 0, 1, 1, -9028.41, 352.69, 92.9163, 0.721364, 0, 0, 0.352912, 0.935656, 300, 0, 1),
(@OGUID+11, 201752, 0, 1, 1, -9027.7, 351.062, 92.9193, 0.689162, 0, 0, 0.337803, 0.941217, 300, 0, 1),
(@OGUID+12, 201752, 0, 1, 1, -9029.08, 349.917, 92.932, 0.657746, 0, 0, 0.322977, 0.946407, 300, 0, 1),
(@OGUID+13, 201752, 0, 1, 1, -9028.77, 352.62, 94.1596, 6.02202, 0, 0, 0.130214, -0.991486, 300, 0, 1),
(@OGUID+14, 201752, 0, 1, 1, -9028.84, 350.443, 94.1755, 0.771628, 0, 0, 0.376314, 0.926492, 300, 0, 1),
(@OGUID+15, 201752, 0, 1, 1, -9026.5, 348.864, 93.0359, 2.17356, 0, 0, 0.885134, 0.465337, 300, 0, 1),
(@OGUID+16, 201752, 0, 1, 1, -9028.21, 348.744, 93.024, 0.889436, 0, 0, 0.430203, 0.902732, 300, 0, 1),
(@OGUID+17, 201752, 1, 1, 1, 1381.97, -4431.17, 30.6588, 5.49617, 0, 0, 0.383432, -0.923569, 300, 0, 1),
(@OGUID+18, 201752, 1, 1, 1, 1380.98, -4432.28, 30.6586, 5.55507, 0, 0, 0.356069, -0.93446, 300, 0, 1),
(@OGUID+19, 201752, 1, 1, 1, 1379.73, -4433.4, 30.6569, 5.69644, 0, 0, 0.28918, -0.957275, 300, 0, 1),
(@OGUID+20, 201752, 1, 1, 1, 1377.96, -4432.16, 30.6489, 5.58649, 0, 0, 0.341345, -0.939938, 300, 0, 1),
(@OGUID+21, 201752, 1, 1, 1, 1379.23, -4431.41, 30.6768, 5.559, 0, 0, 0.354231, -0.935158, 300, 0, 1),
(@OGUID+22, 201752, 1, 1, 1, 1379.85, -4432.91, 31.8999, 5.66896, 0, 0, 0.302309, -0.95321, 300, 0, 1),
(@OGUID+23, 201752, 1, 1, 1, 1380.81, -4431.58, 31.902, 5.64147, 0, 0, 0.315381, -0.948965, 300, 0, 1),
(@OGUID+24, 201752, 1, 1, 1, 1377.67, -4434.36, 30.6055, 5.36265, 0, 0, 0.444186, -0.895935, 300, 0, 1),
-- Crown Chemical Co. Supplies
(@OGUID+25, 201778, 0, 1, 1, -9031.18, 354.399, 92.9752, 6.12019, 0, 0, 0.0814081, -0.996681, 300, 0, 1),
(@OGUID+26, 201778, 0, 1, 1, -9028.76, 352.525, 95.4034, 0.503804, 0, 0, 0.249246, 0.96844, 300, 0, 1),
(@OGUID+27, 201778, 0, 1, 1, -9030.19, 351.409, 94.1683, 0.134668, 0, 0, 0.067283, 0.997734, 300, 0, 1),
(@OGUID+28, 201778, 0, 1, 1, -9031.52, 349.739, 92.9068, 0.338872, 0, 0, 0.168626, 0.98568, 300, 0, 1),
(@OGUID+29, 201778, 0, 1, 1, -9030.55, 347.899, 92.9635, 0.751206, 0, 0, 0.366833, 0.930287, 300, 0, 1),
(@OGUID+30, 201778, 0, 1, 1, -9027.59, 348.911, 94.2683, 1.784, 0, 0, 0.77833, 0.627855, 300, 0, 1),
(@OGUID+31, 201778, 0, 1, 1, -9028.87, 349.971, 95.4191, 1.82327, 0, 0, 0.790507, 0.612452, 300, 0, 1),
(@OGUID+32, 201778, 0, 1, 1, -9031.75, 354.82, 92.9939, 6.0605, 0, 0, 0.111113, -0.993808, 300, 0, 1),
(@OGUID+33, 201778, 0, 1, 1, -9032.22, 352.779, 92.9627, 6.0605, 0, 0, 0.111113, -0.993808, 300, 0, 1),
(@OGUID+34, 201778, 1, 1, 1, 1375.84, -4432.46, 30.5735, 5.69645, 0, 0, 0.289178, -0.957275, 300, 0, 1),
(@OGUID+35, 201778, 1, 1, 1, 1377.99, -4431.81, 31.8923, 5.5001, 0, 0, 0.381614, -0.924322, 300, 0, 1),
(@OGUID+36, 201778, 1, 1, 1, 1379.21, -4430.58, 31.9198, 4.81681, 0, 0, 0.669241, -0.743045, 300, 0, 1),
(@OGUID+37, 201778, 1, 1, 1, 1379.35, -4432.78, 33.143, 5.61791, 0, 0, 0.326536, -0.945185, 300, 0, 1),
(@OGUID+38, 201778, 1, 1, 1, 1380.87, -4431.5, 33.1452, 4.66994, 0, 0, 0.721955, -0.69194, 300, 0, 1),
(@OGUID+39, 201778, 1, 1, 1, 1380.96, -4429.36, 30.6772, 4.6503, 0, 0, 0.728713, -0.68482, 300, 0, 1),
(@OGUID+40, 201778, 1, 1, 1, 1383.08, -4429.42, 30.651, 4.53642, 0, 0, 0.766505, -0.642238, 300, 0, 1),
(@OGUID+41, 201778, 1, 1, 1, 1378.64, -4428.42, 30.6846, 5.23543, 0, 0, 0.500243, -0.865885, 300, 0, 1),
(@OGUID+42, 201778, 1, 1, 1, 1377.05, -4429.39, 30.6467, 5.31397, 0, 0, 0.465863, -0.884857, 300, 0, 1); 

DELETE FROM `game_event_gameobject` WHERE `eventEntry`=@EVENT AND `guid` BETWEEN @OGUID AND @OGUID+42;
INSERT INTO `game_event_gameobject` (`guid`, `eventEntry`) VALUES
(@OGUID, @EVENT),(@OGUID+1, @EVENT),(@OGUID+2, @EVENT),
(@OGUID+3, @EVENT),(@OGUID+4, @EVENT),(@OGUID+5, @EVENT),
(@OGUID+6, @EVENT),(@OGUID+7, @EVENT),(@OGUID+8, @EVENT),
(@OGUID+9, @EVENT),(@OGUID+10, @EVENT),(@OGUID+11, @EVENT),
(@OGUID+12, @EVENT),(@OGUID+13, @EVENT),(@OGUID+14, @EVENT),
(@OGUID+15, @EVENT),(@OGUID+16, @EVENT),(@OGUID+17, @EVENT),
(@OGUID+18, @EVENT),(@OGUID+19, @EVENT),(@OGUID+20, @EVENT),
(@OGUID+21, @EVENT),(@OGUID+22, @EVENT),(@OGUID+23, @EVENT),
(@OGUID+24, @EVENT),(@OGUID+25, @EVENT),(@OGUID+26, @EVENT),
(@OGUID+27, @EVENT),(@OGUID+28, @EVENT),(@OGUID+29, @EVENT),
(@OGUID+30, @EVENT),(@OGUID+31, @EVENT),(@OGUID+32, @EVENT),
(@OGUID+33, @EVENT),(@OGUID+34, @EVENT),(@OGUID+35, @EVENT),
(@OGUID+36, @EVENT),(@OGUID+37, @EVENT),(@OGUID+38, @EVENT),
(@OGUID+39, @EVENT),(@OGUID+40, @EVENT),(@OGUID+41, @EVENT),
(@OGUID+42, @EVENT);

-- [Q]: Pilfering Perfume
-- Note: this is EndText (misleading field name), NOT ObjectiveText1
UPDATE `quest_template` SET `EndText` = 'Steal perfume package from Crown Chemical Co. outside Stormind' WHERE `Id` = 24656; -- Alliance
UPDATE `quest_template` SET `EndText` = 'Steal perfume package from Crown Chemical Co. outside Orgrimmar' WHERE `Id` = 24541; -- Horde

-- Creature templates and spawns
UPDATE `creature_template` SET `minlevel`=70, `maxlevel`=75 WHERE `entry`=37671; -- Crown Supply Guard
UPDATE `creature_template` SET `npcflag`=`npcflag`|1, `gossip_menu_id`=10991 WHERE `entry`=38293; -- Junior Inspector (gossip menu not confirmed)

DELETE FROM `creature` WHERE `id` IN (38293,38065,37671) AND `guid` BETWEEN @CGUID+0 AND @CGUID+3;
DELETE FROM `creature` WHERE `id` IN (38293,38065,37671) AND `guid` BETWEEN @OLDGUID+0 AND @OLDGUID+3;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(@CGUID+0, 38293, 530, 1, 1, 0, 0, -4022.81, -11842.7, 0.0062171, 5.89912, 300, 0, 0, 955, 0, 0, 0, 0, 0), -- Junior Inspector
(@CGUID+1, 38065, 1, 1, 1, 0, 0, 1380.22, -4426.79, 30.6681, 2.03572, 300, 0, 0, 12600, 0, 0, 0, 0, 0), -- Crown Supply Sentry <Crown Chemical Co.>
(@CGUID+2, 37671, 0, 1, 1, 30912, 0, -9033.01, 356.408, 93.1543, 2.09345, 300, 0, 0, 42, 0, 0, 0, 0, 0), -- Crown Supply Guard
(@CGUID+3, 37671, 0, 1, 1, 30912, 0, -9028.63, 344.994, 93.2389, 3.37679, 300, 0, 0, 42, 0, 0, 0, 0, 0); -- Crown Supply Guard

DELETE FROM `game_event_creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+3 AND `eventEntry`=@EVENT;
DELETE FROM `game_event_creature` WHERE `guid` BETWEEN @OLDGUID+0 AND @OLDGUID+3 AND `eventEntry`=@EVENT;
INSERT INTO `game_event_creature` (`guid`, `eventEntry`) VALUES
(@CGUID+0, @EVENT),
(@CGUID+1, @EVENT),
(@CGUID+2, @EVENT),
(@CGUID+3, @EVENT);
SET @Pinata := 34632;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@Pinata AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@Pinata, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 65788, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ogre Pinata - On death cast Pile of Candy'),
(@Pinata, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ogre Pinata - On reset set react state passive');

-- same faction of the GO that is spawned by spell 65788 (not sniffed)
UPDATE `creature_template` SET `faction_A`=7,`faction_H`=7,`exp`=0,`AIName`='SmartAI' WHERE `entry`=@Pinata;
-- Corrected proc of Misery
DELETE FROM `spell_proc_event` WHERE `entry` IN (33191, 33192, 33193);
INSERT INTO `spell_proc_event` VALUES 
(33191, 0x00, 0x06, 0x00008000, 0x00000400, 0x00000040, 0x00000000, 0x00000000, 0, 0, 0),
(33192, 0x00, 0x06, 0x00008000, 0x00000400, 0x00000040, 0x00000000, 0x00000000, 0, 0, 0),
(33193, 0x00, 0x06, 0x00008000, 0x00000400, 0x00000040, 0x00000000, 0x00000000, 0, 0, 0);
DELETE FROM `achievement_criteria_data` WHERE `criteria_id`=9798 AND `type`=6;

DELETE FROM `spell_script_names` WHERE `spell_id`=63399;
INSERT INTO `spell_script_names`(`spell_id`,`ScriptName`) VALUES
(63399, 'spell_gen_tournament_pennant');
-- Update reference for hallowed end
SET @Ref := 10020;
DELETE FROM `reference_loot_template` WHERE `entry` IN (@Ref,10021);
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- Masks
(@Ref,20391,2,1,0,1,1), -- Flimsy Male Gnome Mask
(@Ref,20392,2,1,0,1,1), -- Flimsy Female Gnome Mask
(@Ref,20561,2,1,0,1,1), -- Flimsy Male Dwarf Mask
(@Ref,20562,2,1,0,1,1), -- Flimsy Female Dwarf Mask
(@Ref,20563,2,1,0,1,1), -- Flimsy Female Night Elf Mask
(@Ref,20564,2,1,0,1,1), -- Flimsy Male Night Elf Mask
(@Ref,20565,2,1,0,1,1), -- Flimsy Female Human Mask
(@Ref,20566,2,1,0,1,1), -- Flimsy Male Human Mask
(@Ref,20567,2,1,0,1,1), -- Flimsy Female Troll Mask
(@Ref,20568,2,1,0,1,1), -- Flimsy Male Troll Mask
(@Ref,20569,2,1,0,1,1), -- Flimsy Female Orc Mask
(@Ref,20570,2,1,0,1,1), -- Flimsy Male Orc Mask
(@Ref,20571,2,1,0,1,1), -- Flimsy Female Tauren Mask
(@Ref,20572,2,1,0,1,1), -- Flimsy Male Tauren Mask
(@Ref,20573,2,1,0,1,1), -- Flimsy Male Undead Mask
(@Ref,20574,2,1,0,1,1), -- Flimsy Female Undead Mask
(@Ref,34000,2,1,0,1,1), -- Flimsy Female Blood Elf Mask
(@Ref,34001,2,1,0,1,1), -- Flimsy Female Draenei Mask
(@Ref,34002,2,1,0,1,1), -- Flimsy Male Blood Elf Mask
(@Ref,34003,2,1,0,1,1), -- Flimsy Male Draenei Mask
-- Wands
(@Ref,20397,2,1,0,1,1), -- Hallowed Wand - Pirate
(@Ref,20398,2,1,0,1,1), -- Hallowed Wand - Ninja
(@Ref,20399,2,1,0,1,1), -- Hallowed Wand - Leper Gnome
(@Ref,20409,2,1,0,1,1), -- Hallowed Wand - Ghost
(@Ref,20410,2,1,0,1,1), -- Hallowed Wand - Bat
(@Ref,20411,2,1,0,1,1), -- Hallowed Wand - Skeleton
(@Ref,20413,2,1,0,1,1), -- Hallowed Wand - Random
(@Ref,20414,2,1,0,1,1), -- Hallowed Wand - Wisp
-- Pets
(@Ref,33154,5,1,0,1,1), -- Sinister Squashling
(@Ref,33292,5,1,0,1,1), -- Hallowed Helm
-- Candies
(@Ref,20388,15,1,0,4,6), -- Lollipop
(@Ref,20389,15,1,0,4,6), -- Candy Corn
(@Ref,20390,15,1,0,4,6), -- Candy Bar
(@Ref,37604,30,1,0,10,10), -- Tooth Pick
(@Ref,37582,30,1,0,1,2), -- Pyroblast Cinnamon Ball
(@Ref,37583,30,1,0,1,2), -- G.N.E.R.D.S.
(@Ref,37584,30,1,0,1,2), -- Soothing Spearmint Candy
(@Ref,37585,30,1,0,1,2), -- Chewy Fel Taffy
(@Ref,37606,15,1,0,1,1); -- Penny Pouch

-- Assign loot to the special bags
DELETE FROM `item_loot_template` WHERE `entry` IN (54516,37586);
INSERT INTO `item_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
-- Loot Filled Pumpkin: 
(54516,33226,100,1,0,2,3), -- Tricky Treat
(54516,1,100,1,0,-@Ref,1), -- Referenced Specials
(54516,33808,2,1,0,1,1), -- The Horseman's Helm
(54516,38175,2,1,0,1,1), -- The Horseman's Blade
(54516,37012,0.1,1,0,1,1), -- The Horseman's Reins
-- Handfull of Treats:
(37586,33226,100,1,0,2,3), -- Tricky Treat
(37586,1,100,1,0,-@Ref,1); -- Referenced Specials
-- XXXXXXXXXXXXXXXXXXXXX
-- X   Mage Trainers   X
-- XXXXXXXXXXXXXXXXXXXXX

-- Gossip Condition for Mage Trainers
SET @GOSSIP := 63; -- http://www.wowhead.com/npc=2128 "Tirisfal Glades" http://www.wowhead.com/npc=23103 "Undercity"
SET @TEXTYES := 562;
SET @TEXTNO := 563;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP WHERE `entry`=23103;

SET @GOSSIP := 64; -- http://www.wowhead.com/npc=5880 "Durotar"
SET @TEXTYES := 564;
SET @TEXTNO := 565;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 4484; -- http://www.wowhead.com/npc=5498 "Stormwind City"
SET @TEXTYES := 538;
SET @TEXTNO := 539;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 4485; -- http://www.wowhead.com/npc=5497 "Stormwind City"
SET @TEXTYES := 538;
SET @TEXTNO := 539;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 4486; -- http://www.wowhead.com/npc=331 "Stormwind City"
SET @TEXTYES := 538;
SET @TEXTNO := 539;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 4517; -- http://www.wowhead.com/npc=7311 "Orgrimmar"
SET @TEXTYES := 564;
SET @TEXTNO := 565;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 4518; -- http://old.wowhead.com/npc=5883 "Orgrimmar"
SET @TEXTYES := 564;
SET @TEXTNO := 565;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 4519; -- http://old.wowhead.com/npc=5885 "Orgrimmar"
SET @TEXTYES := 564;
SET @TEXTNO := 565;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 4520; -- http://old.wowhead.com/npc=5882 "Orgrimmar"
SET @TEXTYES := 564;
SET @TEXTNO := 565;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 4537; -- http://www.wowhead.com/npc=4568 "Undercity"
SET @TEXTYES := 562;
SET @TEXTNO := 563;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 4538; -- http://www.wowhead.com/npc=4567 "Undercity"
SET @TEXTYES := 562;
SET @TEXTNO := 563;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 4539; -- http://www.wowhead.com/npc=4566 "Undercity"
SET @TEXTYES := 562;
SET @TEXTNO := 563;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 4552; -- http://www.wowhead.com/npc=5144 5145,5146,7312 "Ironforge"
SET @TEXTYES := 560;
SET @TEXTNO := 561;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 4651; -- http://old.wowhead.com/npc=5884 "Durotar"
SET @TEXTYES := 564;
SET @TEXTNO := 565;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 4654; -- http://www.wowhead.com/npc=2124 "Tirisfal Glades"
SET @TEXTYES := 562;
SET @TEXTNO := 563;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 4660; -- http://www.wowhead.com/npc=198 "Elwynn Forest"
SET @TEXTYES := 538;
SET @TEXTNO := 539;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 4661; -- http://www.wowhead.com/npc=328 "Elwynn Forest"
SET @TEXTYES := 538;
SET @TEXTNO := 539;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 4685; -- http://www.wowhead.com/npc=1228 "Dun Morogh"
SET @TEXTYES := 558;
SET @TEXTNO := 559;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 4686; -- http://old.wowhead.com/npc=944 "Dun Morogh"
SET @TEXTYES := 560;
SET @TEXTNO := 561;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 6648; -- 15279,16269,16651,16652,16653 "Blood elf Mage trainers"
SET @TEXTYES := 9190;
SET @TEXTNO := 9191;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 7264; -- 16500,16749,17481,17513,17514 "Draenei Mage Trainers"
SET @TEXTYES := 8589;
SET @TEXTNO := 8590;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 9990; -- http://www.wowhead.com/npc=28956 28958 "Dalaran Mage Trainers"
SET @TEXTYES := 13845;
SET @TEXTNO := 13846;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

SET @GOSSIP := 9580; -- http://www.wowhead.com/npc=27704 "Dustwallow Marsh"
SET @TEXTYES := 12929;
SET @TEXTNO := 12930;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP WHERE `entry`=27704;

-- Gossip Condition for Mage Trainers
SET @GOSSIP := 7366; -- http://www.wowhead.com/npc=17105 "Darnassus"
SET @TEXTYES := 8799;
SET @TEXTNO := 8800;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP WHERE `entry`=17105;

-- Gossip Condition for Mage Trainers
SET @GOSSIP := 4535; -- http://www.wowhead.com/npc=3049 "Thunder Bluff"
SET @TEXTYES := 562;
SET @TEXTNO := 663;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP WHERE `entry`=3049;

-- XXXXXXXXXXXXXXXXXXXXXX
-- X  Warlock Trainers  X
-- XXXXXXXXXXXXXXXXXXXXXX

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 1503;
SET @TEXTYES := 2175;
SET @TEXTNO := 5722;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in warlock training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 1522;
SET @TEXTYES := 2193;
SET @TEXTNO := 5722;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in warlock training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 2381;
SET @TEXTYES := 2193;
SET @TEXTNO := 5723;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in warlock training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 2383;
SET @TEXTYES := 5714;
SET @TEXTNO := 5715;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in warlock training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 2384;
SET @TEXTYES := 2193;
SET @TEXTNO := 5722;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in warlock training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 4503;
SET @TEXTYES := 5693;
SET @TEXTNO := 5722;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in warlock training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 4504;
SET @TEXTYES := 5693;
SET @TEXTNO := 5722;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in warlock training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 4505;
SET @TEXTYES := 5693;
SET @TEXTNO := 5722;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in warlock training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 4566;
SET @TEXTYES := 2193;
SET @TEXTNO := 5722;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in warlock training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 4567;
SET @TEXTYES := 2193;
SET @TEXTNO := 5723;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in warlock training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 4603;
SET @TEXTYES := 2193;
SET @TEXTNO := 5723;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in warlock training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 4604;
SET @TEXTYES := 2193;
SET @TEXTNO := 5723;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in warlock training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 4609;
SET @TEXTYES := 5719;
SET @TEXTNO := 5720;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I submit myself for further training my master.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 4610;
SET @TEXTYES := 5719;
SET @TEXTNO := 5720;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I submit myself for further training, my master.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP WHERE `entry`=4565;

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 4641;
SET @TEXTYES := 5714;
SET @TEXTNO := 5715;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in warlock training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 4643;
SET @TEXTYES := 5714;
SET @TEXTNO := 5715;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in warlock training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 4655;
SET @TEXTYES := 5719;
SET @TEXTNO := 5720;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I submit myself for further training my master.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 4656;
SET @TEXTYES := 5719;
SET @TEXTNO := 5720;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I submit myself for further training my master.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 4667;
SET @TEXTYES := 2193;
SET @TEXTNO := 5722;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in warlock training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 4681;
SET @TEXTYES := 2193;
SET @TEXTNO := 5723;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in warlock training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 4682;
SET @TEXTYES := 2193;
SET @TEXTNO := 5722;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in warlock training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 6628;
SET @TEXTYES := 7882;
SET @TEXTNO := 7903;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in warlock training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 7437;
SET @TEXTYES := 9006;
SET @TEXTNO := 7903;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in warlock training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 7566;
SET @TEXTYES := 9184;
SET @TEXTNO := 9185;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"It is a greater knowledge of the ways of the warlock that I crave.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warlock Trainers
SET @GOSSIP := 4642;
SET @TEXTYES := 5714;
SET @TEXTNO := 5715;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,256,0,0,0,'','Show gossip text if player is a Warlock'),
(14,@GOSSIP,@TEXTNO,0,15,1279,0,0,0,'','Show gossip text if player is not a Warlock');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"It is a greater knowledge of the ways of the warlock that I crave.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP WHERE `entry`=988;

-- XXXXXXXXXXXXXXXXXXXXXX
-- X  Paladin Trainers  X
-- XXXXXXXXXXXXXXXXXXXXXX

-- Gossip Condition for Paladin Trainers
SET @GOSSIP := 2304;
SET @TEXTYES := 2999;
SET @TEXTNO := 3975;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,2,0,0,0,'','Show gossip text if player is a Paladin'),
(14,@GOSSIP,@TEXTNO,0,15,1533,0,0,0,'','Show gossip text if player is not a Paladin');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I would like to train further in the ways of the Light.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP WHERE `entry`=5149;

-- Gossip Condition for Paladin Trainers
SET @GOSSIP := 4556;
SET @TEXTYES := 3974;
SET @TEXTNO := 3975;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,2,0,0,0,'','Show gossip text if player is a Paladin'),
(14,@GOSSIP,@TEXTNO,0,15,1533,0,0,0,'','Show gossip text if player is not a Paladin');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I would like to train further in the ways of the Light.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP WHERE `entry`=5148;

-- Gossip Condition for Paladin Trainers
SET @GOSSIP := 4557;
SET @TEXTYES := 3974;
SET @TEXTNO := 3975;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,2,0,0,0,'','Show gossip text if player is a Paladin'),
(14,@GOSSIP,@TEXTNO,0,15,1533,0,0,0,'','Show gossip text if player is not a Paladin');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I would like to train further in the ways of the Light.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP WHERE `entry`=5147;

-- Gossip Condition for Paladin Trainers
SET @GOSSIP := 4469;
SET @TEXTYES := 3976;
SET @TEXTNO := 3977;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,2,0,0,0,'','Show gossip text if player is a Paladin'),
(14,@GOSSIP,@TEXTNO,0,15,1533,0,0,0,'','Show gossip text if player is not a Paladin');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I would like to train further in the ways of the Light.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Paladin Trainers
SET @GOSSIP := 4470;
SET @TEXTYES := 3976;
SET @TEXTNO := 3977;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,2,0,0,0,'','Show gossip text if player is a Paladin'),
(14,@GOSSIP,@TEXTNO,0,15,1533,0,0,0,'','Show gossip text if player is not a Paladin');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I would like to train further in the ways of the Light.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Paladin Trainers
SET @GOSSIP := 4471;
SET @TEXTYES := 3976;
SET @TEXTNO := 3977;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,2,0,0,0,'','Show gossip text if player is a Paladin'),
(14,@GOSSIP,@TEXTNO,0,15,1533,0,0,0,'','Show gossip text if player is not a Paladin');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I would like to train further in the ways of the Light.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Paladin Trainers
SET @GOSSIP := 4662;
SET @TEXTYES := 3976;
SET @TEXTNO := 3977;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,2,0,0,0,'','Show gossip text if player is a Paladin'),
(14,@GOSSIP,@TEXTNO,0,15,1533,0,0,0,'','Show gossip text if player is not a Paladin');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I would like to train further in the ways of the Light.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP WHERE `entry`=8140;

-- Gossip Condition for Paladin Trainers
SET @GOSSIP := 4463;
SET @TEXTYES := 3976;
SET @TEXTNO := 3977;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,2,0,0,0,'','Show gossip text if player is a Paladin'),
(14,@GOSSIP,@TEXTNO,0,15,1533,0,0,0,'','Show gossip text if player is not a Paladin');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I would like to train further in the ways of the Light.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Paladin Trainers
SET @GOSSIP := 4464;
SET @TEXTYES := 3976;
SET @TEXTNO := 3977;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,2,0,0,0,'','Show gossip text if player is a Paladin'),
(14,@GOSSIP,@TEXTNO,0,15,1533,0,0,0,'','Show gossip text if player is not a Paladin');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I would like to train further in the ways of the Light.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Paladin Trainers
SET @GOSSIP := 4477;
SET @TEXTYES := 3974;
SET @TEXTNO := 3975;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,2,0,0,0,'','Show gossip text if player is a Paladin'),
(14,@GOSSIP,@TEXTNO,0,15,1533,0,0,0,'','Show gossip text if player is not a Paladin');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I would like to train further in the ways of the Light.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Paladin Trainers
SET @GOSSIP := 4478;
SET @TEXTYES := 3974;
SET @TEXTNO := 3975;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,2,0,0,0,'','Show gossip text if player is a Paladin'),
(14,@GOSSIP,@TEXTNO,0,15,1533,0,0,0,'','Show gossip text if player is not a Paladin');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I would like to train further in the ways of the Light.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Paladin Trainers
SET @GOSSIP := 7260;
SET @TEXTYES := 8582;
SET @TEXTNO := 8584;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,2,0,0,0,'','Show gossip text if player is a Paladin'),
(14,@GOSSIP,@TEXTNO,0,15,1533,0,0,0,'','Show gossip text if player is not a Paladin');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I would like to train further in the ways of the Light.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Paladin Trainers
SET @GOSSIP := 8111;
SET @TEXTYES := 10040;
SET @TEXTNO := 10041;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,2,0,0,0,'','Show gossip text if player is a Paladin'),
(14,@GOSSIP,@TEXTNO,0,15,1533,0,0,0,'','Show gossip text if player is not a Paladin');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I would like to train further in the ways of the Light.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- XXXXXXXXXXXXXXXXXXXXXX
-- X  Warrior Trainers  X
-- XXXXXXXXXXXXXXXXXXXXXX

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 523;
SET @TEXTYES := 1040;
SET @TEXTNO := 4985;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP WHERE `entry`=985;

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 655;
SET @TEXTYES := 1218;
SET @TEXTNO := 4973;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP WHERE `entry`=3408;

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 656;
SET @TEXTYES := 1219;
SET @TEXTNO := 4984;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4091;
SET @TEXTYES := 4992;
SET @TEXTNO := 4993;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"Yes. I have.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4475;
SET @TEXTYES := 1216;
SET @TEXTNO := 5721;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4481;
SET @TEXTYES := 1216;
SET @TEXTNO := 5721;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4482;
SET @TEXTYES := 1216;
SET @TEXTNO := 5721;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4509;
SET @TEXTYES := 1040;
SET @TEXTNO := 4985;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4511;
SET @TEXTYES := 1040;
SET @TEXTNO := 4985;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4525;
SET @TEXTYES := 1218;
SET @TEXTNO := 4973;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4526;
SET @TEXTYES := 1218;
SET @TEXTNO := 4973;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4527;
SET @TEXTYES := 1218;
SET @TEXTNO := 4973;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4546;
SET @TEXTYES := 1219;
SET @TEXTNO := 4984;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4547;
SET @TEXTYES := 1219;
SET @TEXTNO := 4984;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4548;
SET @TEXTYES := 1219;
SET @TEXTNO := 4984;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4568;
SET @TEXTYES := 4989;
SET @TEXTNO := 4988;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4569;
SET @TEXTYES := 1215;
SET @TEXTNO := 5724;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4570;
SET @TEXTYES := 1215;
SET @TEXTNO := 5724;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4578;
SET @TEXTYES := 1217;
SET @TEXTNO := 5725;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP WHERE `entry`=4089;

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4579;
SET @TEXTYES := 1217;
SET @TEXTNO := 5725;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4581;
SET @TEXTYES := 1217;
SET @TEXTNO := 5725;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4645;
SET @TEXTYES := 1218;
SET @TEXTNO := 4973;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4649;
SET @TEXTYES := 1216;
SET @TEXTNO := 5721;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4650;
SET @TEXTYES := 1216;
SET @TEXTNO := 5721;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4653;
SET @TEXTYES := 1219;
SET @TEXTNO := 4984;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP WHERE `entry`=2119;

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4683;
SET @TEXTYES := 1215;
SET @TEXTNO := 5724;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4684;
SET @TEXTYES := 1215;
SET @TEXTNO := 5724;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4696;
SET @TEXTYES := 1217;
SET @TEXTNO := 5725;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 4697;
SET @TEXTYES := 1217;
SET @TEXTNO := 5725;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Warrior Trainers
SET @GOSSIP := 7263;
SET @TEXTYES := 8587;
SET @TEXTNO := 8588;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1,0,0,0,'','Show gossip text if player is a Warrior'),
(14,@GOSSIP,@TEXTNO,0,15,1534,0,0,0,'','Show gossip text if player is not a Warrior');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require warrior training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- XXXXXXXXXXXXXXXXXXXXXX
-- X   Druid Trainers   X
-- XXXXXXXXXXXXXXXXXXXXXX

-- Gossip Condition for Druid Trainers
SET @GOSSIP := 1403;
SET @TEXTYES := 4786;
SET @TEXTNO := 2037;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1024,0,0,0,'','Show gossip text if player is a Druid'),
(14,@GOSSIP,@TEXTNO,0,15,511,0,0,0,'','Show gossip text if player is not a Druid');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek training as a druid.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Druid Trainers
SET @GOSSIP := 3921;
SET @TEXTYES := 4774;
SET @TEXTNO := 4775;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1024,0,0,0,'','Show gossip text if player is a Druid'),
(14,@GOSSIP,@TEXTNO,0,15,511,0,0,0,'','Show gossip text if player is not a Druid');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek training as a druid.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Druid Trainers
SET @GOSSIP := 3924;
SET @TEXTYES := 4782;
SET @TEXTNO := 4781;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1024,0,0,0,'','Show gossip text if player is a Druid'),
(14,@GOSSIP,@TEXTNO,0,15,511,0,0,0,'','Show gossip text if player is not a Druid');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek training as a druid.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Druid Trainers
SET @GOSSIP := 3925;
SET @TEXTYES := 4784;
SET @TEXTNO := 4783;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1024,0,0,0,'','Show gossip text if player is a Druid'),
(14,@GOSSIP,@TEXTNO,0,15,511,0,0,0,'','Show gossip text if player is not a Druid');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek training as a druid.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP WHERE `entry`=9465;

-- Gossip Condition for Druid Trainers
SET @GOSSIP := 3926;
SET @TEXTYES := 4786;
SET @TEXTNO := 4785;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1024,0,0,0,'','Show gossip text if player is a Druid'),
(14,@GOSSIP,@TEXTNO,0,15,511,0,0,0,'','Show gossip text if player is not a Druid');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek training as a druid.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Druid Trainers
SET @GOSSIP := 4507;
SET @TEXTYES := 4784;
SET @TEXTNO := 4783;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1024,0,0,0,'','Show gossip text if player is a Druid'),
(14,@GOSSIP,@TEXTNO,0,15,511,0,0,0,'','Show gossip text if player is not a Druid');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek training as a druid.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP WHERE `entry`=5506;

-- Gossip Condition for Druid Trainers
SET @GOSSIP := 4508;
SET @TEXTYES := 4784;
SET @TEXTNO := 4783;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1024,0,0,0,'','Show gossip text if player is a Druid'),
(14,@GOSSIP,@TEXTNO,0,15,511,0,0,0,'','Show gossip text if player is not a Druid');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek training as a druid.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Druid Trainers
SET @GOSSIP := 4571;
SET @TEXTYES := 4782;
SET @TEXTNO := 4781;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1024,0,0,0,'','Show gossip text if player is a Druid'),
(14,@GOSSIP,@TEXTNO,0,15,511,0,0,0,'','Show gossip text if player is not a Druid');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek training as a druid.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Druid Trainers
SET @GOSSIP := 4605;
SET @TEXTYES := 5716;
SET @TEXTNO := 5717;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1024,0,0,0,'','Show gossip text if player is a Druid'),
(14,@GOSSIP,@TEXTNO,0,15,511,0,0,0,'','Show gossip text if player is not a Druid');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek training as a druid.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Druid Trainers
SET @GOSSIP := 4606;
SET @TEXTYES := 5716;
SET @TEXTNO := 5717;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1024,0,0,0,'','Show gossip text if player is a Druid'),
(14,@GOSSIP,@TEXTNO,0,15,511,0,0,0,'','Show gossip text if player is not a Druid');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek training as a druid.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Druid Trainers
SET @GOSSIP := 4607;
SET @TEXTYES := 5716;
SET @TEXTNO := 5717;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1024,0,0,0,'','Show gossip text if player is a Druid'),
(14,@GOSSIP,@TEXTNO,0,15,511,0,0,0,'','Show gossip text if player is not a Druid');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek training as a druid.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Druid Trainers
SET @GOSSIP := 4687;
SET @TEXTYES := 4784;
SET @TEXTNO := 4783;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1024,0,0,0,'','Show gossip text if player is a Druid'),
(14,@GOSSIP,@TEXTNO,0,15,511,0,0,0,'','Show gossip text if player is not a Druid');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek training as a druid.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Druid Trainers
SET @GOSSIP := 4688;
SET @TEXTYES := 4784;
SET @TEXTNO := 4783;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1024,0,0,0,'','Show gossip text if player is a Druid'),
(14,@GOSSIP,@TEXTNO,0,15,511,0,0,0,'','Show gossip text if player is not a Druid');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek training as a druid.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP WHERE `entry`=3597;

-- Gossip Condition for Druid Trainers
SET @GOSSIP := 7567;
SET @TEXTYES := 9195;
SET @TEXTNO := 9194;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1024,0,0,0,'','Show gossip text if player is a Druid'),
(14,@GOSSIP,@TEXTNO,0,15,511,0,0,0,'','Show gossip text if player is not a Druid');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek training as a druid.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Druid Trainers
SET @GOSSIP := 4646;
SET @TEXTYES := 5716;
SET @TEXTNO := 5717;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1024,0,0,0,'','Show gossip text if player is a Druid'),
(14,@GOSSIP,@TEXTNO,0,15,511,0,0,0,'','Show gossip text if player is not a Druid');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek training as a druid.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP WHERE `entry`=8142;

-- Gossip Condition for Druid Trainers
SET @GOSSIP := 7567;
SET @TEXTYES := 9195;
SET @TEXTNO := 9194;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,1024,0,0,0,'','Show gossip text if player is a Druid'),
(14,@GOSSIP,@TEXTNO,0,15,511,0,0,0,'','Show gossip text if player is not a Druid');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek training as a druid.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Set quest "Feedin' Da Goolz" available to all races
UPDATE `quest_template` SET `RequiredRaces`=1791 WHERE `id`=12652;
-- Adds missing spirit healer in Desolace
SET @GUID := 40269;
DELETE FROM `creature` WHERE `guid`=@GUID AND `id`=6491;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(@GUID, 6491, 1, 1, 1, 0, 0, -452.182, 2513.69, 92.8852, 6.1809, 300, 0, 0, 4120, 0, 0, 0, 0, 0);
-- set correct type from sniff
UPDATE `gameobject_template` SET `type`=33 WHERE `entry`=166872; 
UPDATE `creature_template` SET `gossip_menu_id`=4677 WHERE `entry`=1232;
UPDATE `creature_template` SET `gossip_menu_id`=4678 WHERE `entry`=629;

-- Insert npc_text from sniff
DELETE FROM `npc_text` WHERE `ID` IN (9195);
INSERT INTO `npc_text` (`ID`,`prob0`,`text0_0`,`text0_1`,`lang0`,`em0_0`,`em0_1`,`em0_2`,`em0_3`,`em0_4`,`em0_5`,`prob1`,`text1_0`,`text1_1`,`lang1`,`em1_0`,`em1_1`,`em1_2`,`em1_3`,`em1_4`,`em1_5`,`prob2`,`text2_0`,`text2_1`,`lang2`,`em2_0`,`em2_1`,`em2_2`,`em2_3`,`em2_4`,`em2_5`,`prob3`,`text3_0`,`text3_1`,`lang3`,`em3_0`,`em3_1`,`em3_2`,`em3_3`,`em3_4`,`em3_5`,`prob4`,`text4_0`,`text4_1`,`lang4`,`em4_0`,`em4_1`,`em4_2`,`em4_3`,`em4_4`,`em4_5`,`prob5`,`text5_0`,`text5_1`,`lang5`,`em5_0`,`em5_1`,`em5_2`,`em5_3`,`em5_4`,`em5_5`,`prob6`,`text6_0`,`text6_1`,`lang6`,`em6_0`,`em6_1`,`em6_2`,`em6_3`,`em6_4`,`em6_5`,`prob7`,`text7_0`,`text7_1`,`lang7`,`em7_0`,`em7_1`,`em7_2`,`em7_3`,`em7_4`,`em7_5`,`WDBVerified`) VALUES
(9195,1,'Greetings, my $g brother : sister;. How can I guide you today?','Greetings, my $g brother : sister;. How can I guide you today?',7,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,1);
-- Spawn Petrov
SET @GUID :=40268;
DELETE FROM `creature` WHERE `id`=26932;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`)  VALUES
(@GUID,26932,571,1,1,0,0,4698.392,-4004.781,212.3551,0.5061455,300,0,0,1,0,0,0,0,0);

-- Template updates for creature 26932 (Petrov)
UPDATE `creature_template` SET `baseattacktime`=1500,`unit_flags`=`unit_flags`|512 WHERE `entry`=26932; -- Petrov
-- Addon data for creature 26932 (Petrov)
DELETE FROM `creature_template_addon` WHERE `entry`=26932;
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(26932,0,0,257,333, NULL); -- Petrov
-- Set correct faction from sniff
UPDATE `creature_template` SET `faction_A`= 16,`faction_H`=16 WHERE `entry`=26231;
-- Argent Tournament Trainers part
SET @SPELL_ON_ARGENT_MOUNT         := 63034;

SET @NPC_JAERAN_LOCKWOOD           := 33973;
SET @QUEST_MASTERY_OF_MELEE_A      := 13828;
SET @QUEST_MASTERY_OF_MELEE_H      := 13829;

SET @GOSSIP_MENU_JERAN_MOUNTED     := 10398;
SET @GOSSIP_MENU_JERAN_EXPLANATION := 10397; -- From Aokromes Sniffs

SET @GOSSIP_TEXT_JERAN_MOUNTED     := 14431;
SET @GOSSIP_TEXT_JERAN_EXPLANATION := 14434;
SET @SPELL_CREDIT_JERAN            := 64113;

SET @NPC_RUGAN_STEELBELLY          := 33972;
SET @QUEST_MASTERY_OF_CHARGE_A     := 13837;
SET @QUEST_MASTERY_OF_CHARGE_H     := 13839;

SET @GOSSIP_MENU_RUGAN_MOUNTED     := 10400;
SET @GOSSIP_MENU_RUGAN_EXPLANATION := 10399; -- From Aokromes Sniffs

SET @GOSSIP_TEXT_RUGAN_MOUNTED     := 14436;
SET @GOSSIP_TEXT_RUGAN_EXPLANATION := 14437;
SET @SPELL_CREDIT_RUGAN            := 64114;

SET @NPC_VALIS_WINDCHASER          := 33974;
SET @QUEST_MASTERY_OF_SH_BREAKER_A := 13835;
SET @QUEST_MASTERY_OF_SH_BREAKER_H := 13838;

SET @GOSSIP_MENU_VALIS_MOUNTED     := 10402;
SET @GOSSIP_MENU_VALIS_EXPLANATION := 10401; -- From Aokromes Sniffs

SET @GOSSIP_TEXT_VALIS_MOUNTED     := 14438;
SET @GOSSIP_TEXT_VALIS_EXPLANATION := 14439;
SET @SPELL_CREDIT_VALIS            := 64115;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (@NPC_JAERAN_LOCKWOOD,@NPC_RUGAN_STEELBELLY,@NPC_VALIS_WINDCHASER);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@NPC_JAERAN_LOCKWOOD,@NPC_RUGAN_STEELBELLY,@NPC_VALIS_WINDCHASER) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@NPC_JAERAN_LOCKWOOD,0,0,0,64,0,100,0,0,0,0,0,98,@GOSSIP_MENU_JERAN_MOUNTED,@GOSSIP_TEXT_JERAN_MOUNTED,0,0,0,0,7,0,0,0,0,0,0,0,'Jeran Lockwood - Send different gossip when mounted (Requires conditions)'),
(@NPC_JAERAN_LOCKWOOD,0,1,3,62,0,100,0,@GOSSIP_MENU_JERAN_MOUNTED,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Jeran Lockwood - Send text when option clicked'),
(@NPC_JAERAN_LOCKWOOD,0,2,3,62,0,100,0,@GOSSIP_MENU_JERAN_EXPLANATION,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Jeran Lockwood - Send text when option clicked'),
(@NPC_JAERAN_LOCKWOOD,0,3,4,61,0,100,0,0,0,0,0,11,@SPELL_CREDIT_JERAN,0,0,0,0,0,7,0,0,0,0,0,0,0,'Jeran Lockwood - Give Credit'),
(@NPC_JAERAN_LOCKWOOD,0,4,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Jeran Lockwood - Close Gossip'),

(@NPC_RUGAN_STEELBELLY,0,0,0,64,0,100,0,0,0,0,0,98,@GOSSIP_MENU_RUGAN_MOUNTED,@GOSSIP_TEXT_RUGAN_MOUNTED,0,0,0,0,7,0,0,0,0,0,0,0,'Rugan Steelbelly - Send different gossip when mounted (Requires conditions)'),
(@NPC_RUGAN_STEELBELLY,0,1,3,62,0,100,0,@GOSSIP_MENU_RUGAN_MOUNTED,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Rugan Steelbelly - Send text when option clicked'),
(@NPC_RUGAN_STEELBELLY,0,2,3,62,0,100,0,@GOSSIP_MENU_RUGAN_EXPLANATION,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Rugan Steelbelly - Send text when option clicked'),
(@NPC_RUGAN_STEELBELLY,0,3,4,61,0,100,0,0,0,0,0,11,@SPELL_CREDIT_RUGAN,0,0,0,0,0,7,0,0,0,0,0,0,0,'Rugan Steelbelly - Give Credit'),
(@NPC_RUGAN_STEELBELLY,0,4,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Rugan Steelbelly - Close Gossip'),

(@NPC_VALIS_WINDCHASER,0,0,0,64,0,100,0,0,0,0,0,98,@GOSSIP_MENU_VALIS_MOUNTED,@GOSSIP_TEXT_VALIS_MOUNTED,0,0,0,0,7,0,0,0,0,0,0,0,'Valis Windchaser - Send different gossip when mounted (Requires conditions)'),
(@NPC_VALIS_WINDCHASER,0,1,3,62,0,100,0,@GOSSIP_MENU_VALIS_MOUNTED,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Valis Windchaser - Send text when option clicked'),
(@NPC_VALIS_WINDCHASER,0,2,3,62,0,100,0,@GOSSIP_TEXT_VALIS_EXPLANATION,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Valis Windchaser - Send text when option clicked'),
(@NPC_VALIS_WINDCHASER,0,3,4,61,0,100,0,0,0,0,0,11,@SPELL_CREDIT_VALIS,0,0,0,0,0,7,0,0,0,0,0,0,0,'Valis Windchaser - Give Credit'),
(@NPC_VALIS_WINDCHASER,0,4,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Valis Windchaser - Close Gossip');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry` IN (@NPC_JAERAN_LOCKWOOD,@NPC_RUGAN_STEELBELLY,@NPC_VALIS_WINDCHASER);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup` IN (@GOSSIP_MENU_JERAN_MOUNTED,@GOSSIP_MENU_RUGAN_MOUNTED,@GOSSIP_MENU_VALIS_MOUNTED);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(22,1,@NPC_JAERAN_LOCKWOOD,0,0,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'','SAI - Jeran Lockwood show different menu if player mounted'),
(15,@GOSSIP_MENU_JERAN_MOUNTED,0,0,0,9,@QUEST_MASTERY_OF_MELEE_A,0,0,0,'',"Jeran Lockwood - Show gossip if player has quest"),
(15,@GOSSIP_MENU_JERAN_MOUNTED,0,0,0,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Jeran Lockwood - Show gossip if player has aura"),
(15,@GOSSIP_MENU_JERAN_MOUNTED,0,0,1,9,@QUEST_MASTERY_OF_MELEE_H,0,0,0,'',"Jeran Lockwood - Show gossip if player has quest"),
(15,@GOSSIP_MENU_JERAN_MOUNTED,0,0,1,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Jeran Lockwood - Show gossip if player has aura"),
(15,@GOSSIP_MENU_JERAN_MOUNTED,1,0,0,9,@QUEST_MASTERY_OF_MELEE_A,0,0,0,'',"Jeran Lockwood - Show gossip if player has quest"),
(15,@GOSSIP_MENU_JERAN_MOUNTED,1,0,0,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Jeran Lockwood - Show gossip if player has aura"),
(15,@GOSSIP_MENU_JERAN_MOUNTED,1,0,1,9,@QUEST_MASTERY_OF_MELEE_H,0,0,0,'',"Jeran Lockwood - Show gossip if player has quest"),
(15,@GOSSIP_MENU_JERAN_MOUNTED,1,0,1,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Jeran Lockwood - Show gossip if player has aura"),

(22,1,@NPC_RUGAN_STEELBELLY,0,0,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'','SAI - Rugan Steelbelly show different menu if player mounted'),
(15,@GOSSIP_MENU_RUGAN_MOUNTED,0,0,0,9,@QUEST_MASTERY_OF_CHARGE_A,0,0,0,'',"Rugan Steelbelly - Show gossip if player has quest"),
(15,@GOSSIP_MENU_RUGAN_MOUNTED,0,0,0,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Rugan Steelbelly - Show gossip if player has aura"),
(15,@GOSSIP_MENU_RUGAN_MOUNTED,0,0,1,9,@QUEST_MASTERY_OF_CHARGE_H,0,0,0,'',"Rugan Steelbelly - Show gossip if player has quest"),
(15,@GOSSIP_MENU_RUGAN_MOUNTED,0,0,1,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Rugan Steelbelly - Show gossip if player has aura"),
(15,@GOSSIP_MENU_RUGAN_MOUNTED,1,0,0,9,@QUEST_MASTERY_OF_CHARGE_A,0,0,0,'',"Rugan Steelbelly - Show gossip if player has quest"),
(15,@GOSSIP_MENU_RUGAN_MOUNTED,1,0,0,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Rugan Steelbelly - Show gossip if player has aura"),
(15,@GOSSIP_MENU_RUGAN_MOUNTED,1,0,1,9,@QUEST_MASTERY_OF_CHARGE_H,0,0,0,'',"Rugan Steelbelly - Show gossip if player has quest"),
(15,@GOSSIP_MENU_RUGAN_MOUNTED,1,0,1,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Rugan Steelbelly - Show gossip if player has aura"),

(22,1,@NPC_VALIS_WINDCHASER,0,0,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'','SAI - Valis Windchaser show different menu if player mounted'),
(15,@GOSSIP_MENU_VALIS_MOUNTED,0,0,0,9,@QUEST_MASTERY_OF_SH_BREAKER_A,0,0,0,'',"Valis Windchaser - Show gossip if player has quest"),
(15,@GOSSIP_MENU_VALIS_MOUNTED,0,0,0,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Valis Windchaser - Show gossip if player has aura"),
(15,@GOSSIP_MENU_VALIS_MOUNTED,0,0,1,9,@QUEST_MASTERY_OF_SH_BREAKER_H,0,0,0,'',"Valis Windchaser - Show gossip if player has quest"),
(15,@GOSSIP_MENU_VALIS_MOUNTED,0,0,1,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Valis Windchaser - Show gossip if player has aura"),
(15,@GOSSIP_MENU_VALIS_MOUNTED,1,0,0,9,@QUEST_MASTERY_OF_SH_BREAKER_A,0,0,0,'',"Valis Windchaser - Show gossip if player has quest"),
(15,@GOSSIP_MENU_VALIS_MOUNTED,1,0,0,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Valis Windchaser - Show gossip if player has aura"),
(15,@GOSSIP_MENU_VALIS_MOUNTED,1,0,1,9,@QUEST_MASTERY_OF_SH_BREAKER_H,0,0,0,'',"Valis Windchaser - Show gossip if player has quest"),
(15,@GOSSIP_MENU_VALIS_MOUNTED,1,0,1,1,@SPELL_ON_ARGENT_MOUNT,0,0,0,'',"Valis Windchaser - Show gossip if player has aura");

DELETE FROM `gossip_menu` WHERE `entry` IN (@GOSSIP_MENU_JERAN_EXPLANATION,@GOSSIP_MENU_RUGAN_EXPLANATION,@GOSSIP_MENU_VALIS_EXPLANATION);
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(@GOSSIP_MENU_JERAN_EXPLANATION,@GOSSIP_TEXT_JERAN_EXPLANATION),
(@GOSSIP_MENU_RUGAN_EXPLANATION,@GOSSIP_TEXT_RUGAN_EXPLANATION),
(@GOSSIP_MENU_VALIS_EXPLANATION,@GOSSIP_TEXT_VALIS_EXPLANATION);

DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (@GOSSIP_MENU_JERAN_MOUNTED,@GOSSIP_MENU_JERAN_EXPLANATION,@GOSSIP_MENU_RUGAN_MOUNTED,@GOSSIP_MENU_RUGAN_EXPLANATION,@GOSSIP_MENU_VALIS_MOUNTED,@GOSSIP_MENU_VALIS_EXPLANATION);
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(@GOSSIP_MENU_JERAN_MOUNTED,0,0,'Show me how to train with a Melee Target.',1,1,0,0,0,0,''),
(@GOSSIP_MENU_JERAN_MOUNTED,1,0,'Tell me more about Defend and Thrust!',1,1,@GOSSIP_MENU_JERAN_EXPLANATION,0,0,0,''),
(@GOSSIP_MENU_JERAN_EXPLANATION,0,0,'Show me how to train with a Melee Target.',1,1,0,0,0,0,''),

(@GOSSIP_MENU_RUGAN_MOUNTED,0,0,'Show me how to train with a Charge Target.',1,1,0,0,0,0,''),
(@GOSSIP_MENU_RUGAN_MOUNTED,1,0,'Tell me more about the Charge!',1,1,@GOSSIP_MENU_RUGAN_EXPLANATION,0,0,0,''),
(@GOSSIP_MENU_RUGAN_EXPLANATION,0,0,'Show me how to train with a Charge Target.',1,1,0,0,0,0,''),

(@GOSSIP_MENU_VALIS_MOUNTED,0,0,'Show me how to train with a Ranged Target.',1,1,0,0,0,0,''),
(@GOSSIP_MENU_VALIS_MOUNTED,1,0,'Tell me more about the Shield-Breaker!',1,1,@GOSSIP_MENU_VALIS_EXPLANATION,0,0,0,''),
(@GOSSIP_MENU_VALIS_EXPLANATION,0,0,'Show me how to train with a Ranged Target.',1,1,0,0,0,0,'');

DELETE FROM `creature_text` WHERE `entry` IN (@NPC_JAERAN_LOCKWOOD,@NPC_RUGAN_STEELBELLY,@NPC_VALIS_WINDCHASER);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@NPC_JAERAN_LOCKWOOD,0,0,'Put up defend$B|TInterface\\Icons\\ability_warrior_shieldmastery.blp:32|t$BThen use Thrust on a Melee Target$B|TInterface\\Icons\\inv_sword_65.blp:32|t',42,0,0,0,0,0,'Argent Tournament - Melee Tutorial'),
(@NPC_RUGAN_STEELBELLY,0,0,'Use Shield-Breaker on a Charge Target$B|TInterface\\Icons\\ability_warrior_shieldbreak.blp:32|t$BFollow up with Charge while the target is vulnerable$B|TInterface\\Icons\\ability_mount_charger.blp:32|t',42,0,0,0,0,0,'Argent Tournament - Charge Tutorial'),
(@NPC_VALIS_WINDCHASER,0,0,'Use Shield-Breaker on a Ranged Target$B|TInterface\\Icons\\ability_warrior_shieldbreak.blp:32|t$BThen use Shield-Breaker while the target is defenseless$B|TInterface\\Icons\\ability_warrior_shieldbreak.blp:32|t',42,0,0,0,0,0,'Argent Tournament - Ranged Tutorial');

-- Training Dummies Part
UPDATE `creature_template` SET `ScriptName` = 'npc_tournament_training_dummy' WHERE `entry` IN (33272,33229,33243);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=62709;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,62709,0,0,18,1,33845,0,0, '','Counterattack! (Argent Tournament) - Target near aspirant mounts'),
(13,0,62709,0,0,18,1,33323,0,0, '','Counterattack! (Argent Tournament) - Target near aspirant mounts');

DELETE FROM `spell_script_names` WHERE `spell_id`=62709;
INSERT INTO `spell_script_names` VALUES (62709, 'spell_gen_tournament_counterattack');
UPDATE `game_event` SET `start_time`= '2012-02-05 00:01:00', `holiday`=423 WHERE `eventEntry`=8; -- Love is in the Air
-- add spawn for Saragosa 
SET @GUID := 40270; 
DELETE FROM `creature` WHERE `id`=26231;
INSERT INTO creature (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES 
(@GUID,26231,571,1,1,0,0,3981.03687,7148.006,666.1618,1.037019,120,0,0,1,0,0,0,0,0);
-- Pathing for Saragosa Entry: 26231

SET @PATH = @GUID*10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@GUID,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3972.692,7139.177,666.609,0,0,0,0,100,0),
(@PATH,2,3973.208,7140.034,666.609,0,0,0,0,100,0),
(@PATH,3,3981.671,7149.173,666.2463,0,0,0,0,100,0),
(@PATH,4,3989.375,7172.479,669.3846,0,0,0,0,100,0),
(@PATH,5,3998.89,7199.31,674.7188,0,0,0,0,100,0),
(@PATH,6,4012.167,7242.467,666.8287,0,0,0,0,100,0),
(@PATH,7,4020.924,7276.525,652.9682,0,0,0,0,100,0),
(@PATH,8,4026.488,7297.103,640.2736,0,0,0,0,100,0),
(@PATH,9,4026.488,7297.103,640.2736,0,0,0,0,100,0);
UPDATE `game_event` SET `length`=20160 WHERE `eventEntry`=8; -- Love is in the Air
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=56278;

DELETE FROM `db_script_string` WHERE `entry`=2000000077;
INSERT INTO `db_script_string` (`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`)VALUES
(2000000077,'%s gestures to the pitcher of water sitting on the edge of the well.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

SET @GOSSIP := 4535;
SET @OLD := 663;
SET @NEW := 563;
UPDATE `conditions` SET `SourceEntry`=@NEW WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=@GOSSIP AND `SourceEntry`=@OLD;
-- UPDATE `gossip_menu` SET `text_id`=@NEW WHERE `entry`=@GOSSIP AND `text_id`=@OLD;
UPDATE `quest_template` SET `OfferRewardText`= 'Alright, $n. You want to earn your keep with the Horde? Well there''s plenty to do here, so listen close and do what you''re told.$b$b$gI see that look in your eyes, do not think I will tolerate any insolence. Thrall himself has declared the Hordes females to be on equal footing with you men. Disrespect me in the slightest, and you will know true pain.:I''m happy to have met you. Thrall will be glad to know that more females like you and I are taking the initiative to push forward in the Barrens.;' WHERE `Id`=842;
-- change incorrect Paladin Trainers gossips
-- 4477 -> 4677
-- 4478 -> 4678
-- Gossip Condition for Paladin Trainers
SET @GOSSIP := 4677;
SET @TEXTYES := 3974;
SET @TEXTNO := 3975;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,2,0,0,0,'','Show gossip text if player is a Paladin'),
(14,@GOSSIP,@TEXTNO,0,15,1533,0,0,0,'','Show gossip text if player is not a Paladin');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I would like to train further in the ways of the Light.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Paladin Trainers
SET @GOSSIP := 4678;
SET @TEXTYES := 3974;
SET @TEXTNO := 3975;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,2,0,0,0,'','Show gossip text if player is a Paladin'),
(14,@GOSSIP,@TEXTNO,0,15,1533,0,0,0,'','Show gossip text if player is not a Paladin');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I would like to train further in the ways of the Light.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Delete conditions and menu_id for old typo gossips
DELETE FROM `conditions` WHERE `SourceGroup`=4477 AND `SourceEntry`=3974;
DELETE FROM `conditions` WHERE `SourceGroup`=4477 AND `SourceEntry`=3975;
DELETE FROM `conditions` WHERE `SourceGroup`=4478 AND `SourceEntry`=3974;
DELETE FROM `conditions` WHERE `SourceGroup`=4478 AND `SourceEntry`=3975;
DELETE FROM `gossip_menu_option` WHERE menu_id=4477;
DELETE FROM `gossip_menu_option` WHERE menu_id=4478;

-- Gossip Condition for Mage Trainers
SET @GOSSIP := 4535; -- http://www.wowhead.com/npc=3049 "Thunder Bluff"
SET @TEXTYES := 562;
SET @TEXTNO := 563;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,128,0,0,0,'','Show gossip text if player is a mage'),
(14,@GOSSIP,@TEXTNO,0,15,1407,0,0,0,'','Show gossip text if player is not a mage');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I am interested in mage training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');
UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP WHERE `entry`=3049;

-- XXXXXXXXXXXXXXXXXXXXX
-- X  Priest Trainers  X
-- XXXXXXXXXXXXXXXXXXXXX

UPDATE `creature_template` SET `gossip_menu_id`=3643 WHERE `entry`=11397; -- 3643
UPDATE `creature_template` SET `gossip_menu_id`=4533 WHERE `entry`=3044; -- 4533
UPDATE `creature_template` SET `gossip_menu_id`=4531 WHERE `entry`=3045; -- 4531
UPDATE `creature_template` SET `gossip_menu_id`=4532 WHERE `entry`=3046; -- 4532
UPDATE `creature_template` SET `gossip_menu_id`=4544 WHERE `entry`=4606; -- 4544
UPDATE `creature_template` SET `gossip_menu_id`=7265 WHERE `entry`=16756; -- 7265
UPDATE `creature_template` SET `gossip_menu_id`=7265 WHERE `entry` IN (17510,17511); -- 7265
UPDATE `creature_template` SET `gossip_menu_id`=4558 WHERE `entry`=5142; -- 4558
UPDATE `creature_template` SET `gossip_menu_id`=4559 WHERE `entry`=5141; -- 4559
UPDATE `creature_template` SET `gossip_menu_id`=4572 WHERE `entry`=4092; -- 4572
UPDATE `creature_template` SET `gossip_menu_id`=4574 WHERE `entry`=4090; -- 4574
UPDATE `creature_template` SET `gossip_menu_id`=4692 WHERE `entry`=3595; -- 4692
UPDATE `creature_template` SET `gossip_menu_id`=7349 WHERE `entry`=16502; -- 7349
UPDATE `creature_template` SET `gossip_menu_id`=4801 WHERE `entry`=11401; -- 4801
UPDATE `creature_template` SET `gossip_menu_id`=3642 WHERE `entry`=11406; -- 3642

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 3642;
SET @TEXTYES := 4436;
SET @TEXTNO := 4437;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 3643;
SET @TEXTYES := 4438;
SET @TEXTNO := 4437;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I would like to train.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 3644;
SET @TEXTYES := 4441;
SET @TEXTNO := 4440;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 3645;
SET @TEXTYES := 4442;
SET @TEXTNO := 4439;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4466;
SET @TEXTYES := 4433;
SET @TEXTNO := 4434;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4467;
SET @TEXTYES := 4433;
SET @TEXTNO := 4434;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4468;
SET @TEXTYES := 4433;
SET @TEXTNO := 4434;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4521;
SET @TEXTYES := 4441;
SET @TEXTNO := 4440;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4522;
SET @TEXTYES := 4441;
SET @TEXTNO := 4440;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4523;
SET @TEXTYES := 4441;
SET @TEXTNO := 4440;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4531;
SET @TEXTYES := 4442;
SET @TEXTNO := 4437;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4532;
SET @TEXTYES := 4442;
SET @TEXTNO := 4437;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4533;
SET @TEXTYES := 4442;
SET @TEXTNO := 4437;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4543;
SET @TEXTYES := 4442;
SET @TEXTNO := 4437;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4544;
SET @TEXTYES := 4442;
SET @TEXTNO := 4437;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4545;
SET @TEXTYES := 4442;
SET @TEXTNO := 4437;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4558;
SET @TEXTYES := 4436;
SET @TEXTNO := 4437;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4559;
SET @TEXTYES := 4436;
SET @TEXTNO := 4437;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4572;
SET @TEXTYES := 4438;
SET @TEXTNO := 4437;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4573;
SET @TEXTYES := 4438;
SET @TEXTNO := 4437;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4574;
SET @TEXTYES := 4438;
SET @TEXTNO := 4437;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4665;
SET @TEXTYES := 4433;
SET @TEXTNO := 4434;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4666;
SET @TEXTYES := 4433;
SET @TEXTNO := 4434;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4679;
SET @TEXTYES := 4436;
SET @TEXTNO := 4437;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4680;
SET @TEXTYES := 4436;
SET @TEXTNO := 4435;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4691;
SET @TEXTYES := 4438;
SET @TEXTNO := 4437;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4692;
SET @TEXTYES := 4438;
SET @TEXTNO := 4437;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 4801;
SET @TEXTYES := 4438;
SET @TEXTNO := 4437;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 6649;
SET @TEXTYES := 9007;
SET @TEXTNO := 9186;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I require priest training.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 7265;
SET @TEXTYES := 8591;
SET @TEXTNO := 8592;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 7349;
SET @TEXTYES := 8591;
SET @TEXTNO := 8768;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');

-- Gossip Condition for Priest Trainers
SET @GOSSIP := 7438;
SET @TEXTYES := 9007;
SET @TEXTNO := 9186;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=@GOSSIP;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,@GOSSIP,@TEXTYES,0,15,16,0,0,0,'','Show gossip text if player is a Priest'),
(14,@GOSSIP,@TEXTNO,0,15,1519,0,0,0,'','Show gossip text if player is not a Priest');
-- Add Any Missing Gossip Menu item
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTYES;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTYES);
DELETE FROM `gossip_menu` WHERE `entry`=@GOSSIP AND `text_id`=@TEXTNO;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES (@GOSSIP,@TEXTNO);
-- Add Any Missing Gossip Option
DELETE FROM `gossip_menu_option` WHERE menu_id=@GOSSIP;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`)VALUES
(@GOSSIP,0,3,"I seek more training in the priestly ways.",5,16,0,0,0,0,''),
(@GOSSIP,1,0,"I wish to unlearn my talents.",16,16,4461,0,0,0,''),
(@GOSSIP,2,0,"I wish to know about Dual Talent Specialization.",1,1,10371,0,0,0,'');DELETE FROM `creature` WHERE `id` IN (28538,29056,28563);
DELETE FROM `creature` WHERE `id`=28320 AND `guid` BETWEEN 40451 AND 40462 OR `guid` IN (40466,40467);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
-- Cultist Saboteur
(40271,28538,571,1,1,0,0,6197.03,4772.67,221.593,4.62512,120,0,0,1,0,0,0,0,0),
(40272,28538,571,1,1,0,0,6207.94,4791.03,224.951,0.504098,120,0,0,1,0,0,0,0,0),
(40273,28538,571,1,1,0,0,6209.31,4766.71,224.144,3.22886,120,0,0,1,0,0,0,0,0),
(40274,28538,571,1,1,0,0,6177.88,4737.93,224.747,2.24767,120,0,0,1,0,0,0,0,0),
(40275,28538,571,1,1,0,0,6185.42,4760.61,224.796,1.62316,120,0,0,1,0,0,0,0,0),
(40276,28538,571,1,1,0,0,6195.94,4761.25,220.873,1.53589,120,0,0,1,0,0,0,0,0),
(40277,28538,571,1,1,0,0,6231.93,4739.39,224.738,5.95606,120,0,0,1,0,0,0,0,0),
(40278,28538,571,1,1,0,0,6208.1,4762.39,222.758,2.87979,120,0,0,1,0,0,0,0,0),
-- Servant of Freya
(40451,28320,571,1,1,0,0,6177.58,4762.69,225.418,1.78024,120,0,0,1,0,0,0,0,0),
(40452,28320,571,1,1,0,0,6236,4785.33,224.865,1.90241,120,0,0,1,0,0,0,0,0),
(40453,28320,571,1,1,0,0,6218.78,4772.22,224.84,5.41052,120,0,0,1,0,0,0,0,0),
(40454,28320,571,1,1,0,0,6191.46,4728.85,224.807,5.86431,120,0,0,1,0,0,0,0,0),
(40455,28320,571,1,1,0,0,6206.62,4787.49,224.797,4.64258,120,0,0,1,0,0,0,0,0),
(40456,28320,571,1,1,0,0,6185.58,4761.77,224.796,4.39823,120,0,0,1,0,0,0,0,0),
(40457,28320,571,1,1,0,0,6226.41,4738,224.796,5.61996,120,0,0,1,0,0,0,0,0),
(40458,28320,571,1,1,0,0,6206.94,4750.79,224.796,3.78736,120,0,0,1,0,0,0,0,0),
(40459,28320,571,1,1,0,0,6238.17,4731.89,224.783,3.92699,120,0,0,1,0,0,0,0,0),
(40460,28320,571,1,1,0,0,6177.83,4730.03,224.693,0.244346,120,0,0,1,0,0,0,0,0),
(40461,28320,571,1,1,0,0,6168.2,4749.64,224.577,5.0091,120,0,0,1,0,0,0,0,0),
(40462,28320,571,1,1,0,0,6242.58,4769.51,224.443,2.98451,120,0,0,1,0,0,0,0,0),
(40466,28320,571,1,1,0,0,6217.79,4796.46,224.431,1.39626,120,0,0,1,0,0,0,0,0),
(40467,28320,571,1,1,0,0,6254.19,4757.5,217.856,0.837758,120,0,0,1,0,0,0,0,0),
-- Glimmering Pillar Credit
(40468,29056,571,1,1,0,0,6201.76,4764.45,225.84,3.19395,120,0,0,1,0,0,0,0,0),
-- Freya's Presence
(40469,28563,571,1,1,0,0,6203.26,4765.47,248.057,1.95477,120,0,0,1,0,0,0,0,0);

-- by Valcorb
DELETE FROM `gameobject` WHERE `id`=300223;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(227,300223,571,1,1,6204.758301,4766.002930,221.531799,0,0,0,0,0,300,0,1);

UPDATE `creature_template` SET `unit_flags`=0,`MovementType`=1 WHERE `entry`=28320; -- Servant of Freya
UPDATE `creature_template` SET `MovementType`=1 WHERE `entry`=28538; -- Cultist Saboteur
UPDATE `creature_template` SET `exp`=0,`InhabitType`=7,`flags_extra`=`flags_extra`|128 WHERE `entry`=28563; -- Freya's Presence

DELETE FROM `creature_template_addon` WHERE `entry` IN (28538,29036,28320,28563);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(28538,0,0,1,69, NULL), -- Cultist Saboteur (EMOTE_STATE_USE_STANDING)
(29036,0,0,1,0, '52948 61750 61751'), -- Servant of Freya (All Wild Growth, visual effects)
(28320,0,0,1,429, NULL), -- Servant of Freya
(28563,0,0,1,0, NULL); -- Freya's Presence

DELETE FROM `creature_text` WHERE `entry`=28563;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(28563,0,0, 'The structure above begins to hum with energy.',42,0,0,0,0,0, 'Freya''s Presence - On Call of the Lifewarden cast');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (51318,51395);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,51318,0,0,18,1,28320,0,0, '', 'Freya Dummy - Target Servant of Freya'),
(13,0,51395,0,0,18,1,28538,0,0, '', 'Lifeforce - Target Cultist Saboteur');

DELETE FROM `spell_script_names` WHERE `spell_id`=51957;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(51957,'spell_q12620_the_lifewarden_wrath');
UPDATE `gameobject_template` SET `flags` = `flags` | 32, `AIName` = 'SmartGameObjectAI' WHERE `entry` = 187267;

DELETE FROM `spell_script_names` WHERE `spell_id` = 45102;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(45102, 'spell_love_is_in_the_air_romantic_picnic');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (45119, 45103, 45114);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 0, 45119, 0, 0, 18, 0, 187267, 0, 0, '', 'Holiday - Valentine - Romantic Picnic Near Basket Check - Target Romantic Basket'),
(13, 0, 45103, 0, 0, 18, 1, 0, 0, 0, '', 'Holiday - Valentine - Romantic Picnic Meal Periodic - Target Players'),
(13, 0, 45114, 0, 0, 18, 1, 0, 0, 0, '', 'Holiday - Valentine - Romantic Picnic Meal Particle - Target Players');

DELETE FROM `smart_scripts` WHERE `entryorguid`=187267 AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(187267, 1, 0, 0, 60, 0, 100, 0, 3*60*1000, 3*60*1000, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Picnic Basket - Despawn after 3 minutes');

DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (1291,5787,4071);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(5787, 6, 4395, 0, ''), -- Lonely? - Dalaran
(4071, 6, 4395, 0, ''); -- Lonely? - Dalaran
UPDATE `achievement_criteria_data` SET `value1`=423 WHERE `value1`=335 AND `type`=16;
-- Missing Love is in the Air NPCs
SET @GUID := 40481; -- need 8

DELETE FROM `creature` WHERE `guid` BETWEEN @GUID AND @GUID+7 AND `id` IN (37887,38039,38040,38066,38325,38293);
REPLACE INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(@GUID+0,37887,0,1,1,0,0,-8864.01,635.646,96.0818,1.97249,300,0,0,42,0,0,2,0,8), -- Kwee Q. Peddlefeet <Crown Chemical Co.>
(@GUID+1,38039,1,1,1,0,0,9871.16,2488.28,1315.88,0.547356,300,0,0,42,0,0,2,0,8), -- Kwee Q. Peddlefeet <Crown Chemical Co.>
(@GUID+2,38040,530,1,1,0,0,-4010.12,-11846.9,0.1352,5.42082,300,0,0,42,0,0,2,0,8), -- Kwee Q. Peddlefeet <Crown Chemical Co.>
(@GUID+3,38040,0,1,1,0,0,-4915.43,-979.532,501.448,2.31443,300,0,0,42,0,0,2,0,8), -- Kwee Q. Peddlefeet <Crown Chemical Co.>
(@GUID+4,38066,0,1,1,0,0,-8867.86,652.647,97.0113,4.84704,300,0,0,42,0,0,2,0,8), -- Inspector Snip Snagglebolt
(@GUID+5,38325,0,1,1,0,0,-8881.19,669.006,105.834,0.696214,300,0,0,42,0,0,2,0,8), -- Marion Sutton
(@GUID+6,38293,0,1,1,0,0,-4932.9,-995.348,501.441,0.7201,300,0,0,42,0,0,2,0,8), -- Junior Inspector
(@GUID+7,38293,1,1,1,0,0,9885.37,2494.31,1315.92,3.01351,300,0,0,42,0,0,2,0,8); -- Junior Inspector

DELETE FROM `game_event_creature` WHERE `eventEntry`=8 AND `guid` BETWEEN @GUID AND @GUID+7;
INSERT INTO `game_event_creature` (`guid`,`eventEntry`) VALUES
(@GUID+0,8),
(@GUID+1,8),
(@GUID+2,8),
(@GUID+3,8),
(@GUID+4,8),
(@GUID+5,8),
(@GUID+6,8),
(@GUID+7,8);

-- Fixing an old SAI, by Aokromes, not related with above code
 UPDATE `smart_scripts` SET `event_param1`=56033 WHERE `entryorguid`=30146 and `event_param1` = 42837;
-- Template updates
UPDATE `creature_template` SET `npcflag`=`npcflag`|3,`unit_flags`=`unit_flags`|32768,`speed_run`=1 WHERE `name`='Kwee Q. Peddlefeet' AND `IconName`!=NULL; -- Kwee Q. Peddlefeet
UPDATE `creature_template` SET `npcflag`=`npcflag`|3,`unit_flags`=`unit_flags`|512 WHERE `entry`=38066; -- Inspector Snip Snagglebolt
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=38325; -- Marion Sutton
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=38293; -- Junior Inspector (NS)

-- Model data
UPDATE `creature_model_info` SET `bounding_radius`=0.29,`combat_reach`=2.5,`gender`=0 WHERE `modelid`=15990; -- Kwee Q. Peddlefeet
UPDATE `creature_model_info` SET `bounding_radius`=0.306,`combat_reach`=1.5,`gender`=0 WHERE `modelid`=30728; -- Inspector Snip Snagglebolt
UPDATE `creature_model_info` SET `bounding_radius`=0.208,`combat_reach`=1.5,`gender`=0 WHERE `modelid`=31040; -- Marion Sutton

-- Addon data
DELETE FROM `creature_template_addon` WHERE `entry` IN (37887,38039,38040,38066,38325);
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(37887,0,0,1,0, NULL), -- Kwee Q. Peddlefeet
(38039,0,0,1,0, NULL), -- Kwee Q. Peddlefeet
(38040,0,0,1,0, NULL), -- Kwee Q. Peddlefeet
(38066,0,0,257,0, NULL), -- Inspector Snip Snagglebolt
(38325,0,1,1,0, NULL); -- Marion Sutton

-- Gossip, unfinished
DELETE FROM `gossip_menu_option` WHERE `menu_id`=10948 AND `id`=0;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `box_coded`, `box_money`, `box_text`) VALUES
(10948, 0, 0, 'I''d like a Lovely Charm Collector''s Kit.', 0, 0, '');
UPDATE `achievement_criteria_data` SET `value1`=423 WHERE `value1` IN (335,355) AND `type`=16;

-- Trigger extra flag for [DND] Holiday - Love - Bank/AH/Barber Bunny
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry` IN (38340,38341,38342);
SET @GUID = 5259;
DELETE FROM `gameobject` WHERE `id` IN (192536,192538);
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
-- phasemask 4
(@GUID+00,192536,571,1,4,7033.894,-1391.528,983.4609,0.05235888,0,0,0.02617645,0.9996573,120,255,1), -- Small Proto-Drake Egg
(@GUID+01,192536,571,1,4,6985.812,-1278.627,1101.344,1.308995,0,0,0.6087608,0.7933538,120,255,1), -- Small Proto-Drake Egg
(@GUID+02,192536,571,1,4,7006.557,-1260.263,1099.344,1.588249,0,0,0.7132502,0.7009096,120,255,1), -- Small Proto-Drake Egg
(@GUID+03,192536,571,1,4,7029.698,-1372.383,983.2609,-2.705255,0,0,-0.9762955,0.2164421,120,255,1), -- Small Proto-Drake Egg
(@GUID+04,192536,571,1,4,7011.055,-1270.609,1099.002,3.124123,0,0,0.9999619,0.008734641,120,255,1), -- Small Proto-Drake Egg
(@GUID+05,192536,571,1,4,7013.271,-1395.635,985.5262,-1.326448,0,0,-0.6156607,0.7880114,120,255,1), -- Small Proto-Drake Egg
-- phasemask 128 and 1
(@GUID+06,192536,571,1,129,7013.271,-1395.635,985.5262,-1.326448,0,0,-0.6156607,0.7880114,120,255,1), -- Small Proto-Drake Egg
(@GUID+07,192536,571,1,129,6985.812,-1278.627,1101.344,1.308995,0,0,0.6087608,0.7933538,120,255,1), -- Small Proto-Drake Egg
(@GUID+08,192536,571,1,129,7006.557,-1260.263,1099.344,1.588249,0,0,0.7132502,0.7009096,120,255,1), -- Small Proto-Drake Egg
(@GUID+09,192536,571,1,129,7029.698,-1372.383,983.2609,-2.705255,0,0,-0.9762955,0.2164421,120,255,1), -- Small Proto-Drake Egg
(@GUID+10,192536,571,1,129,7011.055,-1270.609,1099.002,3.124123,0,0,0.9999619,0.008734641,120,255,1), -- Small Proto-Drake Egg
(@GUID+11,192536,571,1,129,7033.894,-1391.528,983.4609,0.05235888,0,0,0.02617645,0.9996573,120,255,1), -- Small Proto-Drake Egg
-- phasemask 4
(@GUID+12,192538,571,1,4,7081.91,-906.408,1065.914,0.95993,0,0,0.4617481,0.8870111,120,255,1), -- Small Proto-Drake Egg
(@GUID+13,192538,571,1,4,7080.195,-912.1233,1066.743,-0.5410506,0,0,-0.2672377,0.9636307,120,255,1), -- Small Proto-Drake Egg
(@GUID+14,192538,571,1,4,7085.535,-912.6684,1066.484,1.815142,0,0,0.7880106,0.6156617,120,255,1), -- Small Proto-Drake Egg
(@GUID+15,192538,571,1,4,7090.95,-908.6667,1065.036,-0.9948372,0,0,-0.4771585,0.8788173,120,255,1), -- Small Proto-Drake Egg
(@GUID+16,192538,571,1,4,7082.188,-916.6476,1068.389,2.234018,0,0,0.8987932,0.4383728,120,255,1); -- Small Proto-Drake Egg
DELETE FROM `achievement_criteria_data` WHERE `criteria_id` IN (6343, 6344, 6345, 6346, 6347);
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(6343,6,4197,0,''), -- Wintergrasp
(6343,1,16111,0,''), -- target Love Fool
(6344,6,2177,0,''), -- Battle Ring
(6344,1,16111,0,''), -- target Love Fool
(6345,6,3421,0,''), -- Blacksmith
(6345,1,16111,0,''), -- target Love Fool
(6346,6,4100,0,''), -- The Culling of Stratholme
(6346,1,16111,0,''), -- target Love Fool
(6347,6,3456,0,''), -- Naxxramas
(6347,1,16111,0,''); -- target Love Fool
SET @pool_id := 348;

DELETE FROM `pool_template` WHERE `entry` = @pool_id;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@pool_id, 1, 'Public Relations Agent <Crown Chemical Co.> - Daily Quests');

DELETE FROM `pool_quest` WHERE `entry` IN (24635, 24636, 24629) AND `pool_entry` = @pool_id;
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES
(24629, @pool_id, 'A Perfect Puff of Perfume'),
(24635, @pool_id, 'A Cloudlet of Classy Cologne'),
(24636, @pool_id, 'Bonbon Blitz');
-- Pool quests from High Crusader Adelard
-- Source: http://www.wowwiki.com/High_Crusader_Adelard
SET @pool_id := 349;

-- create new pool, allowing only 1 out of 4 dailys per day
DELETE FROM `pool_template` WHERE `entry` = @pool_id;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@pool_id, 1, 'High Crusader Adelard - Daily Quests');

-- fill pools with the daily quests
DELETE FROM `pool_quest` WHERE `entry` IN (14101, 14102, 14104, 14105) AND `pool_entry` = @pool_id;
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES
(14101, @pool_id, 'Drottinn Hrothgar'),
(14102, @pool_id, 'Mistcaller Yngvar'),
(14104, @pool_id, 'Ornolf The Scarred'),
(14105, @pool_id, 'Deathspeaker Kharos');
UPDATE `quest_template` SET `RequestItemsText` = 'Jen''shan see a mighty $C before her and da spirits approve.$b$bDa path of da $C is one of our oldest walks of life. Da Horde turned to us when they be just strugglin'' to survive on Azeroth, and they ask us to teach them, to show them the secrets of many tings. They were strong already: strong in shaman ways; strong in warrior ways. But the $C path not be their path... then.' WHERE id = 3082;
-- Creature Gossip_menu_option Update from sniff
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (9130,9495,9879,9893,9988,10115) AND `id`=0;
DELETE FROM `gossip_menu_option` WHERE `menu_id`=9879 AND `id`=1;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`box_coded`,`box_money`,`box_text`) VALUES
(9130,0,1, 'I want to browse your goods.',3,128,0,0,0,0, ''),
(9495,0,1, 'Let me browse your goods.',3,128,0,0,0,0, ''),
(9879,0,3, 'Train me',5,16,0,0,0,0, ''),
(9879,1,1, 'Let me browse your goods.',3,128,0,0,0,0, ''),
(9893,0,3, 'Train me',5,16,0,0,0,0, ''),
(9988,0,3, 'Train me',5,16,0,0,0,0, ''),
(10115,0,3, 'Train me',5,16,0,0,0,0, '');

-- Gossip Menu insert from sniff
DELETE FROM `gossip_menu` WHERE `entry`=9130 AND `text_id`=12343;
DELETE FROM `gossip_menu` WHERE `entry`=9130 AND `text_id`=12344;
DELETE FROM `gossip_menu` WHERE `entry`=9133 AND `text_id`=12349;
DELETE FROM `gossip_menu` WHERE `entry`=9133 AND `text_id`=12350;
DELETE FROM `gossip_menu` WHERE `entry`=9134 AND `text_id`=12354;
DELETE FROM `gossip_menu` WHERE `entry`=9134 AND `text_id`=12352;
DELETE FROM `gossip_menu` WHERE `entry`=9137 AND `text_id`=12360;
DELETE FROM `gossip_menu` WHERE `entry`=9137 AND `text_id`=12361;
DELETE FROM `gossip_menu` WHERE `entry`=9138 AND `text_id`=12362;
DELETE FROM `gossip_menu` WHERE `entry`=9138 AND `text_id`=12363;
DELETE FROM `gossip_menu` WHERE `entry`=9153 AND `text_id`=12384;
DELETE FROM `gossip_menu` WHERE `entry`=9154 AND `text_id`=12387;
DELETE FROM `gossip_menu` WHERE `entry`=9158 AND `text_id`=12394;
DELETE FROM `gossip_menu` WHERE `entry`=9159 AND `text_id`=12395;
DELETE FROM `gossip_menu` WHERE `entry`=9160 AND `text_id`=12403;
DELETE FROM `gossip_menu` WHERE `entry`=9170 AND `text_id`=12433;
DELETE FROM `gossip_menu` WHERE `entry`=9172 AND `text_id`=12440;
DELETE FROM `gossip_menu` WHERE `entry`=9173 AND `text_id`=12441;
DELETE FROM `gossip_menu` WHERE `entry`=9210 AND `text_id`=12521;
DELETE FROM `gossip_menu` WHERE `entry`=9214 AND `text_id`=12525;
DELETE FROM `gossip_menu` WHERE `entry`=9216 AND `text_id`=12527;
DELETE FROM `gossip_menu` WHERE `entry`=9219 AND `text_id`=12530;
DELETE FROM `gossip_menu` WHERE `entry`=9223 AND `text_id`=13481;
DELETE FROM `gossip_menu` WHERE `entry`=9224 AND `text_id`=12538;
DELETE FROM `gossip_menu` WHERE `entry`=9247 AND `text_id`=12555;
DELETE FROM `gossip_menu` WHERE `entry`=9280 AND `text_id`=12585;
DELETE FROM `gossip_menu` WHERE `entry`=9417 AND `text_id`=12663;
DELETE FROM `gossip_menu` WHERE `entry`=9495 AND `text_id`=12781;
DELETE FROM `gossip_menu` WHERE `entry`=9685 AND `text_id`=13134;
DELETE FROM `gossip_menu` WHERE `entry`=9685 AND `text_id`=13135;
DELETE FROM `gossip_menu` WHERE `entry`=9893 AND `text_id`=13735;
DELETE FROM `gossip_menu` WHERE `entry`=9988 AND `text_id`=13842;
DELETE FROM `gossip_menu` WHERE `entry`=10115 AND `text_id`=14041;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(9130,12343),(9130,12344),
(9133,12349),(9133,12350),
(9134,12354),(9134,12352),
(9137,12360),(9137,12361),
(9138,12362),(9138,12363),
(9153,12384),(9154,12387),
(9158,12394),(9159,12395),
(9160,12403),(9170,12433),
(9172,12440),(9173,12441),
(9210,12521),(9214,12525),
(9216,12527),(9219,12530),
(9223,13481),(9224,12538),
(9247,12555),(9280,12585),
(9417,12663),(9495,12781),
(9685,13134),(9685,13135),
(9893,13735),(9988,13842),
(10115,14041);

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup` IN (9130,9133,9134,9137,9138,9685);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,9130,12344,0,8,11571,0,0,0,'','Ahlurglgr - Show different gossip if player has rewarded quest 11571'),
(14,9133,12350,0,8,11571,0,0,0,'','Brglmurgl - Show different gossip if player has rewarded quest 11571'),
(14,9134,12354,0,14,11571,0,0,0,'','Mrmrglmr - Show different gossip if player has not rewarded quest 11571'),
(14,9137,12361,0,8,11571,0,0,0,'','Lurgglbr - Show different gossip if player has rewarded quest 11571'),
(14,9138,12363,0,8,11571,0,0,0,'','Winterfin Gatherer - Show different gossip if player has rewarded quest 11571'),
(14,9685,13135,0,8,11571,0,0,0,'','Glrglrglr - Show different gossip if player has rewarded quest 11571');

-- Insert npc_text from sniff
DELETE FROM `npc_text` WHERE `ID`=13481;
INSERT INTO `npc_text` (`ID`,`text0_0`,`text0_1`,`lang0`,`prob0`,`em0_0`,`em0_1`,`em0_2`,`em0_3`,`em0_4`,`em0_5`,`text1_0`,`text1_1`,`lang1`,`prob1`,`em1_0`,`em1_1`,`em1_2`,`em1_3`,`em1_4`,`em1_5`,`text2_0`,`text2_1`,`lang2`,`prob2`,`em2_0`,`em2_1`,`em2_2`,`em2_3`,`em2_4`,`em2_5`,`text3_0`,`text3_1`,`lang3`,`prob3`,`em3_0`,`em3_1`,`em3_2`,`em3_3`,`em3_4`,`em3_5`,`text4_0`,`text4_1`,`lang4`,`prob4`,`em4_0`,`em4_1`,`em4_2`,`em4_3`,`em4_4`,`em4_5`,`text5_0`,`text5_1`,`lang5`,`prob5`,`em5_0`,`em5_1`,`em5_2`,`em5_3`,`em5_4`,`em5_5`,`text6_0`,`text6_1`,`lang6`,`prob6`,`em6_0`,`em6_1`,`em6_2`,`em6_3`,`em6_4`,`em6_5`,`text7_0`,`text7_1`,`lang7`,`prob7`,`em7_0`,`em7_1`,`em7_2`,`em7_3`,`em7_4`,`em7_5`,`WDBVerified`) VALUES
(13481,'','I''ll never forget what you did for Thassarian.  I will always be in your debt.',0,1,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,'','',0,0,0,0,0,0,0,0,12340);

-- Creature Gossip_menu_id Update from sniff
UPDATE `creature_template` SET `gossip_menu_id`=9130 WHERE `entry`=25206; -- Ahlurglgr
UPDATE `creature_template` SET `gossip_menu_id`=9133 WHERE `entry`=25199; -- Brglmurgl
UPDATE `creature_template` SET `gossip_menu_id`=9134 WHERE `entry`=25205; -- Mrmrglmr
UPDATE `creature_template` SET `gossip_menu_id`=9137 WHERE `entry`=25208; -- Lurgglbr
UPDATE `creature_template` SET `gossip_menu_id`=9138 WHERE `entry`=25198; -- Winterfin Gatherer
UPDATE `creature_template` SET `gossip_menu_id`=9153 WHERE `entry`=25336; -- Grunt Ragefist
UPDATE `creature_template` SET `gossip_menu_id`=9154 WHERE `entry`=25339; -- Spirit Talker Snarlfang
UPDATE `creature_template` SET `gossip_menu_id`=9158 WHERE `entry`=25374; -- Ortrosh
UPDATE `creature_template` SET `gossip_menu_id`=9159 WHERE `entry`=25376; -- Imperean
UPDATE `creature_template` SET `gossip_menu_id`=9160 WHERE `entry`=25335; -- Longrunner Proudhoof
UPDATE `creature_template` SET `gossip_menu_id`=9170 WHERE `entry`=25589; -- Bonker Togglevolt
UPDATE `creature_template` SET `gossip_menu_id`=9172 WHERE `entry`=25602; -- Greatmother Taiga
UPDATE `creature_template` SET `gossip_menu_id`=9173 WHERE `entry`=25604; -- Sage Highmesa
UPDATE `creature_template` SET `gossip_menu_id`=9210 WHERE `entry`=26085; -- Wendy Darren
UPDATE `creature_template` SET `gossip_menu_id`=9214 WHERE `entry`=26084; -- Jeremiah Hawning
UPDATE `creature_template` SET `gossip_menu_id`=9216 WHERE `entry`=25285; -- Harbinger Vurenn
UPDATE `creature_template` SET `gossip_menu_id`=9219 WHERE `entry`=25828; -- Guard Mitchells
UPDATE `creature_template` SET `gossip_menu_id`=9223 WHERE `entry`=25251; -- Leryssa
UPDATE `creature_template` SET `gossip_menu_id`=9224 WHERE `entry`=26083; -- Gerald Green
UPDATE `creature_template` SET `gossip_menu_id`=9247 WHERE `entry`=25395; -- Private Brau
UPDATE `creature_template` SET `gossip_menu_id`=9280 WHERE `entry`=26219; -- Iruk
UPDATE `creature_template` SET `gossip_menu_id`=9417 WHERE `entry`=26170; -- Thassarian
UPDATE `creature_template` SET `gossip_menu_id`=9495 WHERE `entry`=26110; -- Librarian Serrah
UPDATE `creature_template` SET `gossip_menu_id`=9685 WHERE `entry`=28375; -- Glrglrglr
UPDATE `creature_template` SET `gossip_menu_id`=9821 WHERE `entry`=27065; -- Breka Wolfsister
UPDATE `creature_template` SET `gossip_menu_id`=9879 WHERE `entry`=26977; -- Adelene Sunlance
UPDATE `creature_template` SET `gossip_menu_id`=9893 WHERE `entry`=26982; -- Geba'li
UPDATE `creature_template` SET `gossip_menu_id`=9988 WHERE `entry`=26972; -- Orn Tenderhoof
UPDATE `creature_template` SET `gossip_menu_id`=10115 WHERE `entry`=26969; -- Raenah
-- Toxic Tolerance questchain for a horde specific mount requires doing 
-- daily quests. However currently all of those are acceptable daily, though
-- only one (random) should be.
-- Source: http://www.wowhead.com/quest=13917/gorishi-grub#comments:id=829822
SET @pool1_id := 350; -- Orcs, Bloodelves
SET @pool2_id := 351; -- Undead, Tauren, Troll

-- create new pools, each allowing only 1 out of 4 dailys per day
DELETE FROM `pool_template` WHERE `entry` IN (@pool1_id, @pool2_id);
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@pool1_id, 1, 'Toxic Tolerance Daily-Quests'),
(@pool2_id, 1, 'Toxic Tolerance Daily-Quests');

-- fill pools with the daily quests, starting from Venomhide Hatchling (c34320)
DELETE FROM `pool_quest` WHERE `entry` IN (13889, 13915, 13903, 13904, 13905, 13917, 13916, 13914) AND `pool_entry` IN (@pool1_id, @pool2_id);
INSERT INTO `pool_quest` (`entry`, `pool_entry`, `description`) VALUES
(13889, @pool1_id, 'Hungry, Hungry Hatchling'),
(13903, @pool1_id, 'Gorishi Grub'),
(13904, @pool1_id, 'Poached, Scrambled, Or Raw?'),
(13905, @pool1_id, 'Searing Roc Feathers'),
(13915, @pool2_id, 'Hungry, Hungry Hatchling'),
(13917, @pool2_id, 'Gorishi Grub'),
(13916, @pool2_id, 'Poached, Scrambled, Or Raw?'),
(13914, @pool2_id, 'Searing Roc Feathers');
-- Remove Mistwhisper Refuge Zepik spawn
DELETE FROM `creature` WHERE `id` = 28216;

-- Add SAI to High-Shaman Rakjak to give horn when accepting A rough ride
DELETE FROM `smart_scripts` WHERE `entryorguid`=28082 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28082, 0, 0, 0, 19, 0, 100, 0, 12536, 0, 0, 0, 56, 38512, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'High-Shaman Rakjak - On acccept quest A rough ride - give Zepik''s Hunting Horn');
-- Lunar festival: Rocket Clusters placed near Omen's summon place (Moonglade)
SET @CLUSTER := 180874;
SET @LUNARFESTIVAL := 7;

DELETE FROM `gameobject` WHERE `id`=@CLUSTER AND `guid` IN (230,231);
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`) VALUES
(230,@CLUSTER,1,1,1,7531.662,-2851.228,458.9172),
(231,@CLUSTER,1,1,1,7561.145,-2872.45,461.0998);

DELETE FROM `game_event_gameobject` WHERE `guid` IN (230,231) AND `eventEntry`=@LUNARFESTIVAL;
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(@LUNARFESTIVAL,230),
(@LUNARFESTIVAL,231);
SET @ENTRY := 38035; -- Chemical Wagon
SET @SPELL1 := 71599; -- Cosmetic - Explosion (Chemical Wagon)
SET @SPELL2 := 71597; -- Cosmetic - Low Poly Fire (with Sound)

DELETE FROM `conditions` WHERE `SourceEntry`=@SPELL1 AND `SourceTypeOrReferenceId`=13 AND `ConditionTypeOrReference`=18;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`Comment`) VALUES
(13,@SPELL1,18,1,@ENTRY, 'Chemical Wagon - Cosmetic - Explosion (Chemical Wagon)');

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
UPDATE creature_template SET AIName='SmartAI' WHERE entry=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,0,0,1,8,0,100,0,@SPELL1,0,0,0,33,@ENTRY,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Chemical Wagon - Spell Hit - Credit"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,11,@SPELL2,2,0,0,0,0,0,0,0,0,0.0,0.0,0.0,0.0,"Chemical Wagon - Spell Hit - Cast Cosmetic - Low Poly Fire (with Sound)");
UPDATE `creature_template` SET `ScriptName`='npc_spring_rabbit' WHERE `entry`=32791;
UPDATE `achievement_criteria_data` SET `value1`=186 WHERE `criteria_id`=9199 AND `type`=6; -- Dolanaar, not Dalaran
-- Chillmaw
SET @ENTRY := 33687;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,0,0,0,0,0,100,0,10000,11000,20000,23000,11,65248,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Chillmaw - Combat - Cast Frost Breath"),
(@ENTRY,0,1,0,2,0,100,1,0,35,0,0,11,65260,0,0,0,0,0,2,0,0,0,0.0,0.0,0.0,0.0,"Chillmaw - @35% health - Cast Wing Buffet"),
(@ENTRY,0,2,0,2,0,100,1,0,25,0,0,11,60603,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Chillmaw - @25% health - Cast Eject Passenger 1"),
(@ENTRY,0,3,0,2,0,100,1,0,50,0,0,11,62539,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Chillmaw - @50% health - Cast Eject Passenger 2"),
(@ENTRY,0,4,0,2,0,100,1,0,75,0,0,11,52205,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Chillmaw - @75% health - Cast Eject Passenger 3");
-- Cultist Bombardier SAI
SET @ENTRY   := 33695; -- NPC entry
SET @SPELL1  := 65128; -- Throw Dynamite
SET @SPELL2  := 65130; -- Time Bomb
UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,6000,7000,8000,11,@SPELL1,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Cultist Bombardier - Combat - Cast Throw Dynamite'),
(@ENTRY,0,1,0,0,0,100,0,18000,20000,6000,7000,11,@SPELL2,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Cultist Bombardier - Combat - Cast Time Bomb'),
(@ENTRY,0,2,0,4,0,100,1,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Cultist Bombardier - On Aggro - Set Phase 1'),
(@ENTRY,0,3,0,1,1,100,1,0,0,0,0,41,5000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Cultist Bombardier - OOC - Despawn (Phase 1)');
-- ALTER TABLE `conditions` ADD COLUMN `NegativeCondition` tinyint(3) UNSIGNED NOT NULL default '0' AFTER `ConditionValue3`;
-- Picnic Basket
UPDATE `gameobject_template` SET `flags`=0, `AIName`='' WHERE `entry`=187267;
DELETE FROM `smart_scripts` WHERE `entryorguid`=187267 AND `source_type`=1;
-- CONDITION_NO_AURA -> CONDITION_AURA + NegativeCondition
DELETE FROM `conditions` WHERE `NegativeCondition`=1 AND `ConditionTypeOrReference`=1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) SELECT `SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`, 1 ,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`, 1 ,`ErrorTextId`,`ScriptName`,`Comment` FROM `conditions` WHERE `ConditionTypeOrReference`=11;
DELETE FROM `conditions` WHERE `ConditionTypeOrReference`=11;

-- CONDITION_NOITEM -> CONDITION_ITEM + NegativeCondition
DELETE FROM `conditions` WHERE `NegativeCondition`=1 AND `ConditionTypeOrReference`=2;                                                                                                                                                                                                                                                                          -- not a typo
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) SELECT `SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`, 2 ,`ConditionValue1`, 1 ,`ConditionValue2`, 1 ,`ErrorTextId`,`ScriptName`,`Comment` FROM `conditions` WHERE `ConditionTypeOrReference`=26;
DELETE FROM `conditions` WHERE `ConditionTypeOrReference`=26;
-- CONDITION_SPELL with ConditionValue2 = 1 -> CONDITION_SPELL + NegativeCondition
UPDATE `conditions` SET `NegativeCondition` = 1, `ConditionValue2` = 0 WHERE `ConditionTypeOrReference` = 25 AND `ConditionValue2` = 1;
-- ALTER TABLE `conditions` ADD COLUMN `ConditionTarget` tinyint(3) UNSIGNED NOT NULL default '0' AFTER `ConditionTypeOrReference`;
UPDATE `creature` SET `id`=38041 WHERE `guid`=40484;
-- Spawn Elder Ohanzee in Normal and Heroic modes of Gundrak and relocate near Drakkari Colossus (45.7,62) boss (v3.3.2 change). Coordinates are guessed based on https://www.youtube.com/watch?v=FRXgZthksN8 ( ~12min )
UPDATE `creature` SET `spawnMask`=3,`position_x`=1697.94,`position_y`=752.121,`position_z`=142.765,`orientation`=3.78933 WHERE `guid`=200841;
-- Spawn Elder Kilias in Normal and Heroic modes of Drak'Tharon Keep
UPDATE `creature` SET `spawnMask`=3 WHERE `guid`=200842;
-- Spawn Elder Nurgen in Normal and Heroic modes of Azjol-Nerub
UPDATE `creature` SET `spawnMask`=3 WHERE `guid`=200843;
-- Spawn Elder Yurauk in Normal and Heroic modes of Halls of Stone
UPDATE `creature` SET `spawnMask`=3 WHERE `guid`=200844;
-- Spawn Elder Jarten in Normal and Heroic modes of Utgarde Keep
UPDATE `creature` SET `spawnMask`=3 WHERE `guid`=200845;
-- Spawn Elder Chogan'gada in Normal and Heroic modes of Utgarde Pinnacle
UPDATE `creature` SET `spawnMask`=3 WHERE `guid`=200846;
-- Spawn Elder Igasho in Normal and Heroic modes of The Nexus
UPDATE `creature` SET `spawnMask`=3 WHERE `guid`=200847;
SET @pool_id := 352;

DELETE FROM `pool_template` WHERE `entry` IN (@pool_id, @pool_id+1);
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@pool_id,1, 'The Rokk <Master of Cooking> - Daily Quests'),
(@pool_id+1,1, 'Old Man Barlowned - Daily Quests');

DELETE FROM `pool_quest` WHERE `entry` IN (11377,11379,11380,11381) AND `pool_entry` = @pool_id;
DELETE FROM `pool_quest` WHERE `entry` IN (11665,11666,11667,11668,11669) AND `pool_entry` = @pool_id+1;
INSERT INTO `pool_quest` (`entry`,`pool_entry`,`description`) VALUES
(11377,@pool_id, 'Revenge is Tasty'),
(11379,@pool_id, 'Super Hot Stew'),
(11380,@pool_id, 'Manalicious'),
(11381,@pool_id, 'Soup for the Soul'),
(11665,@pool_id+1, 'Crocolisks in the City'),
(11666,@pool_id+1, 'Bait Bandits'),
(11667,@pool_id+1, 'The One That Got Away'),
(11668,@pool_id+1, 'Shrimpin Aint Easy'),
(11669,@pool_id+1, 'Felblood Fillet');
-- The Botanica and The Mecanar exit areatriggers
DELETE FROM `areatrigger_teleport` WHERE `id` IN (4612,4614);
INSERT INTO `areatrigger_teleport` (`id`,`name`,`target_map`,`target_position_x`,`target_position_y`,`target_position_z`,`target_orientation`) VALUES
(4612,'The Botanica',530,3407.110107,1488.479980,182.837753,2.501119),
(4614,'The Mechanar',530,2869.885742,1552.755249,252.158997,0.733993);

-- Spawn portals
DELETE FROM `gameobject` WHERE `id` IN (184221,184222) AND `guid` IN (233,236,237,242);
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(233,184222,553,1,1,158.952,391.653,-35.5291,0.0494656,0,0,0.0247303,0.999694,300,0,1),
(236,184222,554,1,1,71.1997,149.657,25.5811,3.17222,0,0,0.999883,-0.0153126,300,0,1),
(237,184221,553,1,1,158.952,391.653,-35.5291,0.0494656,0,0,0.0247303,0.999694,300,0,1),
(242,184221,554,1,1,71.1997,149.657,25.5811,3.17222,0,0,0.999883,-0.0153126,300,0,1);
