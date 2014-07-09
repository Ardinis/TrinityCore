/*
Quête : Les failles dimensionnelles (10278)
Bug : Les Générateur de Vide (20143) ne despawn jamais et ne faut pas pop de marcheur du Vide instable (34943)
*/
REPLACE INTO `creature_template` (`entry`,`difficulty_entry_1`,`difficulty_entry_2`,`difficulty_entry_3`,`KillCredit1`,`KillCredit2`,`modelid1`,`modelid2`,`modelid3`,`modelid4`,`name`,`subname`,`IconName`,`gossip_menu_id`,`minlevel`,`maxlevel`,`exp`,`faction_A`,`faction_H`,`npcflag`,`speed_walk`,`speed_run`,`speed_swim`,`speed_fly`,`scale`,`rank`,`mindmg`,`maxdmg`,`dmgschool`,`attackpower`,`dmg_multiplier`,`baseattacktime`,`rangeattacktime`,`unit_class`,`unit_flags`,`dynamicflags`,`family`,`trainer_type`,`trainer_spell`,`trainer_class`,`trainer_race`,`minrangedmg`,`maxrangedmg`,`rangedattackpower`,`type`,`type_flags`,`lootid`,`pickpocketloot`,`skinloot`,`resistance1`,`resistance2`,`resistance3`,`resistance4`,`resistance5`,`resistance6`,`spell1`,`spell2`,`spell3`,`spell4`,`spell5`,`spell6`,`spell7`,`spell8`,`PetSpellDataId`,`VehicleId`,`mingold`,`maxgold`,`AIName`,`MovementType`,`InhabitType`,`HoverHeight`,`Health_mod`,`Mana_mod`,`Armor_mod`,`RacialLeader`,`questItem1`,`questItem2`,`questItem3`,`questItem4`,`questItem5`,`questItem6`,`movementId`,`RegenHealth`,`equipment_id`,`mechanic_immune_mask`,`flags_extra`,`ScriptName`,`WDBVerified`) VALUES (20143,0,0,0,0,0,18684,0,0,0,'Void Spawner - Quest - Warp Rifts',NULL,NULL,0,1,1,0,35,35,0,1.125,1.14286,1.125,1.14286,1,0,2,2,0,24,1,1400,1900,1,0,8,0,0,0,0,0,1,1,100,10,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'SmartAI',1,3,1,1,1,1,0,0,0,0,0,0,0,0,1,0,0,2,'',12340);

DELETE FROM `smart_scripts` WHERE (`entryorguid`=20143 AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(20143, 0, 0, 0, 1, 0, 100, 0, 2000, 5000, 20000, 25000, 11, 34943, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Void Spawner - Summon Unstable Voidwalker"),
(20143, 0, 1, 0, 1, 0, 100, 0, 120000, 120000, 2000, 2000, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Void Spawner - Despawn");

/*
Quête : La puissance des éléments
Bug : impossible de récuperer "Énergie collectée" car pas de script sur le tôtem/enragé de vapeur
*/

DELETE FROM `smart_scripts` WHERE `entryorguid`=24601 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(24601,0,0,0,11,0,100,0,0,0,0,0,11,36151,0,0,0,0,0,1,0,0,0,0,0,0,0,'Steam Rager - On spawn - Cast Cosmetic: Steam Aura on self'),
(24601,0,1,0,0,0,100,0,4000,8000,11000,14000,11,50375,1,0,0,0,0,2,0,0,0,0,0,0,0,'Steam Rager - Combat - Cast Steam Blast on victom'),
(24601,0,2,0,6,0,100,0,0,0,0,0,33,25987,0,0,0,0,0,7,0,0,0,0,0,0,0,'Steam Rager - On Death - Kill Credit');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry` =24601;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(22,3,24601,0,0,1,1,46374,0,0,0,0,'','Windsoul Totem Gives Credit only if aura present at death');

DELETE FROM `smart_scripts` WHERE (`entryorguid`=25987 AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(25987,0,0,0,1,0,100,0,3000,3000,3000,3000,11,46374,0,0,0,0,0,19,24601,10,0,0,0,0,0,"Windsoul Totem cast spell 46374 on Steam Rager");

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=46374;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,46374,0,0,31,0,3,24601,0,0,0,'','Windsoul Totem Aura targets only Steam Rager'),
(13,1,46374,0,0,36,0,0,0,0,0,0,'','Windsoul Totem Aura targets only if units is alive');

/*
Quete : L'ami de mon ennemi (12412)
bug : Le PNJ Vladek (27547) est inexistant
*/
DELETE FROM `creature` WHERE id = 27547;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES ('',27547,571,1,1,0,786,3142.11,-3014.32,134.174,0.910789,600,0,0,10282,0,0,0,0,0);


/*
Quête : Le serment des Terrestres (13005)
bug : Mauvaise condition pour réaliser la quête
*/
REPLACE INTO `quest_template` (`Id`,`Method`,`Level`,`MinLevel`,`MaxLevel`,`ZoneOrSort`,`Type`,`SuggestedPlayers`,`LimitTime`,`RequiredClasses`,`RequiredRaces`,`RequiredSkillId`,`RequiredSkillPoints`,`RequiredFactionId1`,`RequiredFactionId2`,`RequiredFactionValue1`,`RequiredFactionValue2`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`PrevQuestId`,`NextQuestId`,`ExclusiveGroup`,`NextQuestIdChain`,`RewardXPId`,`RewardOrRequiredMoney`,`RewardMoneyMaxLevel`,`RewardSpell`,`RewardSpellCast`,`RewardHonor`,`RewardHonorMultiplier`,`RewardMailTemplateId`,`RewardMailDelay`,`SourceItemId`,`SourceItemCount`,`SourceSpellId`,`Flags`,`SpecialFlags`,`RewardTitleId`,`RequiredPlayerKills`,`RewardTalents`,`RewardArenaPoints`,`RewardItemId1`,`RewardItemId2`,`RewardItemId3`,`RewardItemId4`,`RewardItemCount1`,`RewardItemCount2`,`RewardItemCount3`,`RewardItemCount4`,`RewardChoiceItemId1`,`RewardChoiceItemId2`,`RewardChoiceItemId3`,`RewardChoiceItemId4`,`RewardChoiceItemId5`,`RewardChoiceItemId6`,`RewardChoiceItemCount1`,`RewardChoiceItemCount2`,`RewardChoiceItemCount3`,`RewardChoiceItemCount4`,`RewardChoiceItemCount5`,`RewardChoiceItemCount6`,`RewardFactionId1`,`RewardFactionId2`,`RewardFactionId3`,`RewardFactionId4`,`RewardFactionId5`,`RewardFactionValueId1`,`RewardFactionValueId2`,`RewardFactionValueId3`,`RewardFactionValueId4`,`RewardFactionValueId5`,`RewardFactionValueIdOverride1`,`RewardFactionValueIdOverride2`,`RewardFactionValueIdOverride3`,`RewardFactionValueIdOverride4`,`RewardFactionValueIdOverride5`,`PointMapId`,`PointX`,`PointY`,`PointOption`,`Title`,`Objectives`,`Details`,`EndText`,`OfferRewardText`,`RequestItemsText`,`CompletedText`,`RequiredNpcOrGo1`,`RequiredNpcOrGo2`,`RequiredNpcOrGo3`,`RequiredNpcOrGo4`,`RequiredNpcOrGoCount1`,`RequiredNpcOrGoCount2`,`RequiredNpcOrGoCount3`,`RequiredNpcOrGoCount4`,`RequiredSourceItemId1`,`RequiredSourceItemId2`,`RequiredSourceItemId3`,`RequiredSourceItemId4`,`RequiredSourceItemCount1`,`RequiredSourceItemCount2`,`RequiredSourceItemCount3`,`RequiredSourceItemCount4`,`RequiredItemId1`,`RequiredItemId2`,`RequiredItemId3`,`RequiredItemId4`,`RequiredItemId5`,`RequiredItemId6`,`RequiredItemCount1`,`RequiredItemCount2`,`RequiredItemCount3`,`RequiredItemCount4`,`RequiredItemCount5`,`RequiredItemCount6`,`RequiredSpellCast1`,`RequiredSpellCast2`,`RequiredSpellCast3`,`RequiredSpellCast4`,`Unknown0`,`ObjectiveText1`,`ObjectiveText2`,`ObjectiveText3`,`ObjectiveText4`,`DetailsEmote1`,`DetailsEmote2`,`DetailsEmote3`,`DetailsEmote4`,`DetailsEmoteDelay1`,`DetailsEmoteDelay2`,`DetailsEmoteDelay3`,`DetailsEmoteDelay4`,`EmoteOnIncomplete`,`EmoteOnComplete`,`OfferRewardEmote1`,`OfferRewardEmote2`,`OfferRewardEmote3`,`OfferRewardEmote4`,`OfferRewardEmoteDelay1`,`OfferRewardEmoteDelay2`,`OfferRewardEmoteDelay3`,`OfferRewardEmoteDelay4`,`StartScript`,`CompleteScript`,`WDBVerified`) VALUES (13005,2,80,77,0,67,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,148000,165300,0,0,0,0,0,0,42840,1,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,42847,42871,42893,42882,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'The Earthen Oath','Thorim, at the Terrace of the Makers, wants you to use the Horn of the Peaks and call on the Earthen to defeat 20 Iron Dwarves and 7 Iron Sentinels.','For years I neglected my duties, giving into defeat and self-pity.$B$BNot the brave earthen, however.  Their oath to protect these grounds with their lives has gone unbroken.$B$BEven now, they fight the corruption of iron with selflessness, waiting for the moment in which the tides turn.$B$BThat moment has arrived.  We must rally what remains of the earthen defenders and lead them into a glorious victory.  Sound the Horn of the Peaks to call them to your side and take back the Terrace of the Makers.','','It\'s a good start. But my brother\'s forces will not take long to regroup. We must make our victory a decisive one.','Hail, $N! What news do you bring?','Return to Thorim at Terrace of the Makers in The Storm Peaks.',30296,29978,0,0,7,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Iron Sentinel slain','Iron Dwarf Assailant slain','','',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12340);

/*
Quête : Un espoir dans le cauchemar d'émeraude (13074)
Bug : Le Gossip menu ne permet pas de passer dans le Rêve d'émeraude
*/
DELETE FROM `smart_scripts` WHERE (`entryorguid`=11832 AND `source_type`=0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(11832, 0, 0, 0, 19, 0, 100, 1, 8736, 0, 0, 0, 1, 0, 15000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - Quest Accepted - Say 0"),
(11832, 0, 1, 0, 52, 0, 100, 0, 0, 11832, 0, 0, 53, 0, 11832, 0, 8736, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - Say 0 - Start WayPoint"),
(11832, 0, 1, 2, 62, 0, 100, 0, 10215, 1, 0, 0, 11, 57670, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - On gossip option select - cast spell Fitful Dream"),
(11832, 0, 2, 0, 52, 0, 100, 0, 0, 11832, 0, 0, 83, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - Quest Accepted - Remove npcflag"),
(11832, 0, 3, 0, 40, 0, 100, 0, 13, 11832, 0, 0, 54, 95000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - WayPoint 13 - Pause"),
(11832, 0, 4, 0, 40, 0, 100, 0, 13, 11832, 0, 0, 1, 1, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - WayPoint 13 - Say 1"),
(11832, 0, 5, 0, 52, 0, 100, 0, 1, 11832, 0, 0, 1, 2, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - Say 1 - Say 2"),
(11832, 0, 6, 0, 52, 0, 100, 0, 2, 11832, 0, 0, 11, 25813, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - Say 3 - Cast Conjure Dream Rift"),
(11832, 0, 7, 0, 52, 0, 100, 0, 2, 11832, 0, 0, 12, 15491, 3, 3600000, 0, 0, 0, 8, 0, 0, 0, 7900.36, -2654.09, 497.029, 0.63583, "Keeper Remulos - Say 3 - Summon Eranikus"),
(11832, 0, 8, 0, 52, 0, 100, 0, 2, 11832, 0, 0, 1, 3, 23000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - Say 2 - Say 3"),
(11832, 0, 9, 0, 52, 0, 100, 0, 3, 11832, 0, 0, 1, 4, 31000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - Say 3 - Say 4"),
(11832, 0, 10, 0, 52, 0, 100, 0, 4, 11832, 0, 0, 1, 5, 22000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - Say 4 - Say 5"),
(11832, 0, 11, 0, 52, 0, 100, 0, 5, 11832, 0, 0, 1, 6, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - Say 5 - Say 6"),
(11832, 0, 12, 0, 40, 0, 100, 0, 20, 11832, 0, 0, 54, 60000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - WayPoint 20 - Pause"),
(11832, 0, 13, 0, 40, 0, 100, 0, 20, 11832, 0, 0, 1, 7, 20000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - WayPoint 20 - Say 7"),
(11832, 0, 14, 0, 52, 0, 100, 0, 7, 11832, 0, 0, 12, 15629, 3, 3600000, 0, 0, 0, 8, 0, 0, 0, 7829.07, -2562.35, 489.299, 5.234, "Keeper Remulos - Say 7 - Summon 1"),
(11832, 0, 15, 0, 52, 0, 100, 0, 7, 11832, 0, 0, 12, 15629, 3, 3600000, 0, 0, 0, 8, 0, 0, 0, 7828.89, -2580.69, 489.299, 0.753, "Keeper Remulos - Say 7 - Summon 2"),
(11832, 0, 16, 0, 52, 0, 100, 0, 7, 11832, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - Say 7 - Aggresive"),
(11832, 0, 17, 0, 52, 0, 100, 0, 7, 11832, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 15629, 0, 0, 0, 0, 0, 0, "Keeper Remulos - Say 7 - Attack"),
(11832, 0, 18, 0, 0, 0, 100, 0, 7000, 14000, 6000, 12000, 11, 20665, 0, 0, 0, 0, 0, 18, 20, 0, 0, 0, 0, 0, 0, "Keeper Remulos - Combat - Cast Regrowth"),
(11832, 0, 19, 0, 0, 0, 100, 0, 26000, 52000, 34000, 46000, 11, 20664, 0, 0, 0, 0, 0, 18, 20, 0, 0, 0, 0, 0, 0, "Keeper Remulos - Combat - Cast Regrowth"),
(11832, 0, 20, 0, 0, 0, 100, 0, 25000, 25000, 25000, 50000, 11, 23381, 0, 0, 0, 0, 0, 18, 20, 0, 0, 0, 0, 0, 0, "Keeper Remulos - Combat - Cast Healing Touch"),
(11832, 0, 21, 0, 0, 0, 100, 0, 10000, 40000, 40000, 40000, 11, 25817, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - Combat - Cast Tranquility"),
(11832, 0, 22, 0, 0, 0, 100, 0, 16000, 21000, 19000, 25000, 11, 21668, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - Combat - Cast Starfall"),
(11832, 0, 23, 0, 38, 0, 100, 0, 1, 1, 0, 0, 1, 8, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - Data Set - Say 8"),
(11832, 0, 24, 0, 52, 0, 100, 0, 8, 11832, 0, 0, 1, 9, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - Said 8 8 - Say 9"),
(11832, 0, 25, 0, 40, 0, 100, 1, 21, 11832, 0, 0, 49, 0, 0, 0, 0, 0, 0, 11, 15491, 30, 0, 0, 0, 0, 0, "Keeper Remulos - Attack - Summon"),
(11832, 0, 26, 0, 6, 0, 100, 0, 0, 0, 0, 0, 6, 8736, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0, "Keeper Remulos - Death - Fail"),
(11832, 0, 27, 0, 40, 0, 100, 1, 23, 11832, 0, 0, 54, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - WayPoint 23 - Pause"),
(11832, 0, 28, 0, 40, 0, 100, 1, 23, 11832, 0, 0, 66, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - WayPoint 23 - Face"),
(11832, 0, 29, 0, 52, 0, 100, 0, 9, 11832, 0, 0, 53, 1, 1183200, 0, 8736, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - Said 9 - Go Home"),
(11832, 0, 30, 0, 40, 0, 100, 0, 12, 1183200, 0, 0, 82, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - WayPoint 12 - npcflags"),
(11832, 0, 31, 0, 40, 0, 100, 0, 12, 1183200, 0, 0, 66, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - WayPoint 12 - Face"),
(11832, 0, 32, 0, 40, 0, 100, 0, 24, 11832, 0, 0, 80, 1183200, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - WayPoint 24 - Run Script Only When OOC"),
(11832, 0, 33, 0, 62, 0, 100, 0, 10215, 0, 0, 0, 11, 57413, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Keeper Remulos - On gossip option select - cast spell Fitful Dream");