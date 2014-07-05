DELETE FROM `spell_script_names` WHERE `spell_id` IN (45907,45671);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(45907, 'spell_gen_torch_target_picker'),
(45671, 'spell_gen_juggle_torch_catch');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (45907,45671);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`) VALUES
(13,45907,18,1,25515),
(13,45671,18,1,0),
(13,45671,18,1,25515);

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=46747;
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(46747,45907,0, 'Fling Torch - Torch Target Picker');

UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry`=25515;

UPDATE `quest_template` SET `PrevQuestId`=11657 WHERE `Id`=11924;

DELETE FROM `creature` WHERE `id`=25515;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
('','25515','1','1','1','0','0','1921.68','-4326.24','21.7631','4.69113','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','-8820.57','863.37','98.9602','1.09525','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','-8819.07','881.422','98.6388','4.52744','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','-8812.03','885.719','98.5385','4.4489','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','-8814.08','873.969','98.8659','1.10232','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','-8814.7','864.967','99.0339','1.1141','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','-8821.88','870.852','98.7882','4.06092','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','-8807.15','878.687','98.8254','3.52921','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','-8823.06','855.943','99.045','1.4479','30','0','0','42','0','0','0','0','0'),
('','25515','1','1','1','0','0','1932.16','-4325.71','20.1871','4.38482','30','0','0','42','0','0','0','0','0'),
('','25515','1','1','1','0','0','1946.67','-4327.83','22.6344','3.60335','30','0','0','42','0','0','0','0','0'),
('','25515','1','1','1','0','0','1943','-4339.9','21.5222','3.88609','30','0','0','42','0','0','0','0','0'),
('','25515','1','1','1','0','0','1934.19','-4334.65','20.0495','3.48554','30','0','0','42','0','0','0','0','0'),
('','25515','1','1','1','0','0','1930.03','-4346.83','19.7546','3.8429','30','0','0','42','0','0','0','0','0'),
('','25515','1','1','1','0','0','1940.22','-4353.12','20.1355','4.05967','30','0','0','42','0','0','0','0','0'),
('','25515','1','1','1','0','0','1932.25','-4361.06','20.9716','2.11973','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','1833.6','223.202','60.3987','2.25109','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','1831.21','233.347','60.134','1.62277','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','1832.31','244.952','59.9711','1.24735','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','1832.3','256.49','59.6549','2.65793','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','1822.36','261.071','59.9183','4.76437','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','1823.9','252.272','60.0337','4.96229','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','1814.4','247.51','60.5868','5.74847','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','1821.79','238.343','60.6741','4.77144','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','-4698.32','-1214.39','501.66','1.4847','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','-4701.21','-1204.98','501.66','2.14051','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','-4711.01','-1195.42','501.675','2.40362','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','-4724.79','-1194.03','501.696','5.31745','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','-4714.44','-1204.85','501.66','5.40384','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','-4727.47','-1205.35','501.696','4.54775','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','-4718.13','-1216.85','501.66','5.08575','30','0','0','42','0','0','0','0','0'),
('','25515','0','1','1','0','0','-4692.04','-1200.08','501.66','3.52281','30','0','0','42','0','0','0','0','0');

delete from game_event_creature where guid in(select guid from creature where id = 25515);
INSERT INTO game_event_creature SELECT 1 ,guid FROM creature WHERE id = 25515;

DELETE FROM `gameobject` WHERE id = 300068;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
('','300068','0','1','1','1823.19','221.194','60.9658','4.08421','0','0','0.890974','-0.454055','300','0','1'),
('','300068','0','1','1','-4702.18','-1221.19','502.491','5.2232','0','0','0.505528','-0.86281','300','0','1');

DELETE FROM `game_event_gameobject` where guid in(select guid from gameobject where id = 300068);
INSERT INTO game_event_gameobject SELECT 1 ,guid FROM gameobject WHERE id = 300068;

-- Serverside Spells
DELETE FROM `spell_dbc` WHERE `Id` IN (29710,58934);
INSERT INTO `spell_dbc` (`Id`, `Dispel`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesEx2`, `AttributesEx3`, `AttributesEx4`, `AttributesEx5`, `Stances`, `StancesNot`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcFlags`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `StackAmount`, `EquippedItemClass`, `EquippedItemSubClassMask`, `EquippedItemInventoryTypeMask`, `Effect1`, `Effect2`, `Effect3`, `EffectDieSides1`, `EffectDieSides2`, `EffectDieSides3`, `EffectRealPointsPerLevel1`, `EffectRealPointsPerLevel2`, `EffectRealPointsPerLevel3`, `EffectBasePoints1`, `EffectBasePoints2`, `EffectBasePoints3`, `EffectMechanic1`, `EffectMechanic2`, `EffectMechanic3`, `EffectImplicitTargetA1`, `EffectImplicitTargetA2`, `EffectImplicitTargetA3`, `EffectImplicitTargetB1`, `EffectImplicitTargetB2`, `EffectImplicitTargetB3`, `EffectRadiusIndex1`, `EffectRadiusIndex2`, `EffectRadiusIndex3`, `EffectApplyAuraName1`, `EffectApplyAuraName2`, `EffectApplyAuraName3`, `EffectAmplitude1`, `EffectAmplitude2`, `EffectAmplitude3`, `EffectMultipleValue1`, `EffectMultipleValue2`, `EffectMultipleValue3`, `EffectMiscValue1`, `EffectMiscValue2`, `EffectMiscValue3`, `EffectMiscValueB1`, `EffectMiscValueB2`, `EffectMiscValueB3`, `EffectTriggerSpell1`, `EffectTriggerSpell2`, `EffectTriggerSpell3`, `EffectSpellClassMaskA1`, `EffectSpellClassMaskA2`, `EffectSpellClassMaskA3`, `EffectSpellClassMaskB1`, `EffectSpellClassMaskB2`, `EffectSpellClassMaskB3`, `EffectSpellClassMaskC1`, `EffectSpellClassMaskC2`, `EffectSpellClassMaskC3`, `MaxTargetLevel`, `SpellFamilyName`, `SpellFamilyFlags1`, `SpellFamilyFlags2`, `SpellFamilyFlags3`, `MaxAffectedTargets`, `DmgClass`, `PreventionType`, `DmgMultiplier1`, `DmgMultiplier2`, `DmgMultiplier3`, `AreaGroupId`, `SchoolMask`, `Comment`) VALUES
('29710','0','0','256','0','0','0','0','0','0','0','0','1','0','0','101','0','0','0','0','0','1','0','-1','0','0','140','0','0','0','0','0','0','0','0','0','0','0','0','0','0','25','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','29531','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','1','Ribbon Pole - Force Cast Ribbon Pole Channel'),
('58934','0','0','536870912','0','0','0','0','0','0','0','0','1','0','0','101','0','0','0','0','0','1','0','-1','0','0','3','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','28','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','Burning Hot Pole Dance credit marker');

-- Link Dancer Check Aura and Visual to Ribbon Pole Channel
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (29531,45390);
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(29531,45390,0, 'Ribbon Pole - Dancer Check Aura'),
(45390,45406,2, 'Ribbon Pole - Periodic Visual');

-- Spell Script
DELETE FROM `spell_script_names` WHERE `spell_id`=45390;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(45390, 'spell_gen_ribbon_pole_dancer_check');