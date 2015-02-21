-- Fix quest 13809 : La menace vient d''en haut --


DELETE FROM creature_addon WHERE guid=111094;
DELETE FROM waypoint_data WHERE id=2008510;

DELETE FROM creature_template WHERE entry=500501;
INSERT INTO creature_template (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES 
(500501, 0, 0, 0, 33695, 0, 27887, 25343, 25342, 17957, 'Sectateur bombardier', '', '', 0, 80, 80, 2, 21, 21, 0, 1, 1.14286, 1, 1, 417, 582, 0, 608, 7.5, 2000, 0, 2, 32832, 8, 0, 0, 0, 0, 0, 341, 506, 80, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 57, 0, 0, '', 12340);

DELETE FROM `creature_template_addon` WHERE entry=33687;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES 
(33687, 0, 0, 50331648, 0, 0, 0);

DELETE FROM spell_dbc WHERE id=1001251;
INSERT INTO spell_dbc (Id,     Dispel, Mechanic, Attributes, AttributesEx, AttributesEx2, AttributesEx3, AttributesEx4, AttributesEx5, AttributesEx6, AttributesEx7, Stances, StancesNot, Targets, CastingTimeIndex, AuraInterruptFlags, ProcFlags, ProcChance, ProcCharges, MaxLevel, BaseLevel, SpellLevel, DurationIndex, RangeIndex, StackAmount, EquippedItemClass, EquippedItemSubClassMask, EquippedItemInventoryTypeMask, Effect1, Effect2, Effect3, EffectDieSides1, EffectDieSides2, EffectDieSides3, EffectRealPointsPerLevel1, EffectRealPointsPerLevel2, EffectRealPointsPerLevel3, EffectBasePoints1, EffectBasePoints2, EffectBasePoints3, EffectMechanic1, EffectMechanic2, EffectMechanic3, EffectImplicitTargetA1, EffectImplicitTargetA2, EffectImplicitTargetA3, EffectImplicitTargetB1, EffectImplicitTargetB2, EffectImplicitTargetB3, EffectRadiusIndex1, EffectRadiusIndex2, EffectRadiusIndex3, EffectApplyAuraName1, EffectApplyAuraName2, EffectApplyAuraName3, EffectAmplitude1, EffectAmplitude2, EffectAmplitude3, EffectMultipleValue1, EffectMultipleValue2, EffectMultipleValue3, EffectMiscValue1, EffectMiscValue2, EffectMiscValue3, EffectMiscValueB1, EffectMiscValueB2, EffectMiscValueB3, EffectTriggerSpell1, EffectTriggerSpell2, EffectTriggerSpell3, EffectSpellClassMaskA1, EffectSpellClassMaskA2, EffectSpellClassMaskA3, EffectSpellClassMaskB1, EffectSpellClassMaskB2, EffectSpellClassMaskB3, EffectSpellClassMaskC1, EffectSpellClassMaskC2, EffectSpellClassMaskC3, MaxTargetLevel, SpellFamilyName, SpellFamilyFlags1, SpellFamilyFlags2, SpellFamilyFlags3, MaxAffectedTargets, DmgClass, PreventionType, DmgMultiplier1, DmgMultiplier2, DmgMultiplier3, AreaGroupId, SchoolMask, Comment) VALUES 
                      (1001251,0,      0,        384,        0,           0,              0,             0,             0,             0,             0,             0,       0,          0,       1,                0,                  0,         100,        0,           0,        0,         0,          30,            1,          0,           -1,                0,                        0,                             6,       0,       0,       0,               0,               0,               0,                         0,                         0,                         100,               0,                 0,                 0,               0,               0,               1,                      0,                      0,                      0,                      0,                      0,                      0,                  0,                  0,                  22,                   0,                    0,                    0,                0,                0,                0,                    0,                    0,                    1,                0,                0,                0,                 0,                 0,                 0,                   0,                   0,                   0,                      0,                      0,                      0,                      0,                      0,                      0,                      0,                      0,                      0,              0,               0,                 0,                 0,                 0,                  0,        0,              0,              0,              0,              0,           1,           'Spell aide script +100 armure');

DELETE FROM spell_area WHERE spell=1001251;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_start_active`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`) VALUES 
(1001251, 0, 0, 0, 0, -46598, 0, 2, 0);


DELETE FROM waypoints WHERE entry=33687;
INSERT INTO waypoints (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES 
(33687, 1, 8038.62, 2686.50, 552.163, 'Frissegueule rescript WP'),
(33687, 2, 8054.09, 2682.12, 552.163, 'Frissegueule rescript WP'),
(33687, 3, 8070.22, 2668.86, 552.163, 'Frissegueule rescript WP'),
(33687, 4, 8083.00, 2652.03, 552.163, 'Frissegueule rescript WP'),
(33687, 5, 8088.15, 2638.35, 552.163, 'Frissegueule rescript WP'),
(33687, 6, 8087.99, 2612.74, 552.163, 'Frissegueule rescript WP'),
(33687, 7, 8083.25, 2574.91, 545.108, 'Frissegueule rescript WP'),
(33687, 8, 8078.04, 2539.73, 535.276, 'Frissegueule rescript WP'),
(33687, 9, 8072.47, 2520.45, 529.080, 'Frissegueule rescript WP'),
(33687, 10, 8056.10, 2499.43, 523.609, 'Frissegueule rescript WP'),
(33687, 11, 8022.82, 2484.35, 517.580, 'Frissegueule rescript WP'),
(33687, 12, 8001.60, 2505.49, 522.580, 'Frissegueule rescript WP'),
(33687, 13, 7969.29, 2523.78, 522.053, 'Frissegueule rescript WP'),
(33687, 14, 7953.56, 2557.25, 528.359, 'Frissegueule rescript WP'),
(33687, 15, 7961.60, 2620.53, 540.248, 'Frissegueule rescript WP'),
(33687, 16, 7987.26, 2654.73, 547.859, 'Frissegueule rescript WP'),
(33687, 17, 8014.98, 2677.58, 552.163, 'Frissegueule rescript WP');


DELETE FROM `smart_scripts` WHERE entryorguid=33687 AND source_type=0;
DELETE FROM `smart_scripts` WHERE entryorguid=33695 AND source_type=0;
DELETE FROM `smart_scripts` WHERE entryorguid=500501 AND source_type=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(33687, 0, 0, 0, 0, 0, 100, 0, 5800, 13900, 11700, 20800, 11, 65248, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Chillmaw - Cast Frost Breath'),
(33687, 0, 1, 0, 0, 0, 100, 0, 7800, 10800, 11800, 21100, 11, 65260, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chillmaw - Cast Wing Buffet'),
(33687, 0, 2, 0, 2, 0, 100, 1, 0, 75, 0, 0, 12, 500501, 1, 600000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chillmaw - Summon Cultist Bombardier at 75% HP'),
(33687, 0, 3, 0, 2, 0, 100, 1, 0, 50, 0, 0, 12, 500501, 1, 600000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chillmaw - Summon Cultist Bombardier at 50% HP'),
(33687, 0, 4, 0, 2, 0, 100, 1, 0, 25, 0, 0, 12, 500501, 1, 600000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chillmaw - Summon Cultist Bombardier at 25% HP'),
(33687, 0, 5, 6, 4, 0, 100, 0, 0, 0, 0, 0, 55, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chillmaw STOP WP on aggro'),
(33687, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Chillmaw ATTACK CLOSEST PLAYER on aggro'),
(33687, 0, 7, 0, 25, 0, 100, 0, 0, 0, 0, 0, 53, 1, 33687, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Chillmaw START WP on reset'),
(33695, 0, 0, 0, 0, 0, 100, 0, 5000, 6000, 7000, 8000, 11, 65128, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cultist Bombardier - Combat - Cast Throw Dynamite'),
(33695, 0, 1, 0, 0, 0, 100, 0, 18000, 20000, 6000, 7000, 11, 65130, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cultist Bombardier - Combat - Cast Time Bomb'),
(33695, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Cultist Bombardier - ATTACK CLOSEST PLAYER on aggro'),
(33695, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cultist Bombardier - On Evade - Set phase 1'),
(33695, 0, 4, 0, 1, 1, 100, 0, 5000, 5000, 5000, 5000, 75, 1001251, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cultist Bombardier - Out of Combat - AURA SPELL TEST'),
(33695, 0, 5, 0, 23, 1, 100, 0, 1001251, 1, 5000, 5000, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cultist Bombardier - Phase 1 IF HAS AURA SPELL TEST - Phase 2'),
(33695, 0, 6, 0, 23, 2, 100, 0, 46598, 1, 5000, 5000, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cultist Bombardier - Phase 2 IF HAS AURA RIDE VEHICLE - Phase 3'),
(33695, 0, 7, 0, 1, 2, 100, 0, 8000, 8000, 8000, 8000, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cultist Bombardier - Phase 2 IF HAS NO AURA RIDE VEHICLE (timer out) - Despawn'),
(33695, 0, 8, 0, 1, 4, 100, 0, 5000, 5000, 5000, 5000, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cultist Bombardier - Phase 3 timer - Set phase 1'),
(500501, 0, 0, 0, 0, 0, 100, 0, 5000, 6000, 7000, 8000, 11, 65128, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cultist Bombardier - Combat - Cast Throw Dynamite'),
(500501, 0, 1, 0, 0, 0, 100, 0, 18000, 20000, 6000, 7000, 11, 65130, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cultist Bombardier - Combat - Cast Time Bomb'),
(500501, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Cultist Bombardier - ATTACK CLOSEST PLAYER on aggro'),
(500501, 0, 3, 0, 1, 0, 100, 0, 3000, 3000, 5000, 5000, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cultist Bombardier - Out of combat 5 sec - DESPAWN');


