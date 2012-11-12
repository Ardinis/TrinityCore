DELETE FROM `spell_script_names` WHERE `spell_id` IN (61698);
INSERT INTO `spell_script_names`(`spell_id`,`ScriptName`) VALUES
(61698,'spell_gen_ds_flush_knockback');

DELETE FROM `spell_dbc` WHERE `id`=61698;
INSERT INTO `spell_dbc` (`Id`, `Dispel`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesEx2`, `AttributesEx3`, `AttributesEx4`, `AttributesEx5`, `AttributesEx6`, `AttributesEx7`, `Stances`, `StancesNot`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcFlags`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `StackAmount`, `EquippedItemClass`, `EquippedItemSubClassMask`, `EquippedItemInventoryTypeMask`, `Effect1`, `Effect2`, `Effect3`, `EffectDieSides1`, `EffectDieSides2`, `EffectDieSides3`, `EffectRealPointsPerLevel1`, `EffectRealPointsPerLevel2`, `EffectRealPointsPerLevel3`, `EffectBasePoints1`, `EffectBasePoints2`, `EffectBasePoints3`, `EffectMechanic1`, `EffectMechanic2`, `EffectMechanic3`, `EffectImplicitTargetA1`, `EffectImplicitTargetA2`, `EffectImplicitTargetA3`, `EffectImplicitTargetB1`, `EffectImplicitTargetB2`, `EffectImplicitTargetB3`, `EffectRadiusIndex1`, `EffectRadiusIndex2`, `EffectRadiusIndex3`, `EffectApplyAuraName1`, `EffectApplyAuraName2`, `EffectApplyAuraName3`, `EffectAmplitude1`, `EffectAmplitude2`, `EffectAmplitude3`, `EffectMultipleValue1`, `EffectMultipleValue2`, `EffectMultipleValue3`, `EffectMiscValue1`, `EffectMiscValue2`, `EffectMiscValue3`, `EffectMiscValueB1`, `EffectMiscValueB2`, `EffectMiscValueB3`, `EffectTriggerSpell1`, `EffectTriggerSpell2`, `EffectTriggerSpell3`, `EffectSpellClassMaskA1`, `EffectSpellClassMaskA2`, `EffectSpellClassMaskA3`, `EffectSpellClassMaskB1`, `EffectSpellClassMaskB2`, `EffectSpellClassMaskB3`, `EffectSpellClassMaskC1`, `EffectSpellClassMaskC2`, `EffectSpellClassMaskC3`, `MaxTargetLevel`, `SpellFamilyName`, `SpellFamilyFlags1`, `SpellFamilyFlags2`, `SpellFamilyFlags3`, `MaxAffectedTargets`, `DmgClass`, `PreventionType`, `DmgMultiplier1`, `DmgMultiplier2`, `DmgMultiplier3`, `AreaGroupId`, `SchoolMask`, `Comment`) VALUES
(61698,0,0,536871296,269058048,67108868,268894272,2048,0,1024,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,-1,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,25,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Flush - Knockback effect');

UPDATE `battleground_template` SET `HordeStartO`=3.14159 WHERE `id`=10;

UPDATE `creature_template` SET `flags_extra`=128 WHERE `entry`=28567;
DELETE FROM `spell_script_names` WHERE `spell_id` = 36444;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(36444, 'spell_gen_wg_water');
DELETE FROM `spell_script_names` WHERE `spell_id` in (7384,7887,11584,11585);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(7384,	'spell_warr_overpower'),
(7887,	'spell_warr_overpower'),
(11584,	'spell_warr_overpower'),
(11585,	'spell_warr_overpower');
DELETE FROM `spell_script_names` WHERE `spell_id` IN (20625,29142,35139,42393,49882,55269,56578,38441,66316,67100,67101,67102);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(20625,'spell_gen_default_count_pct_from_max_hp'), -- Ritual of Doom Sacrifice
(29142,'spell_gen_default_count_pct_from_max_hp'), -- Eyesore Blaster
(35139,'spell_gen_default_count_pct_from_max_hp'), -- Throw Boom's Doom
(42393,'spell_gen_default_count_pct_from_max_hp'), -- Brewfest - Attack Keg
(49882,'spell_gen_default_count_pct_from_max_hp'), -- Leviroth Self-Impale
(55269,'spell_gen_default_count_pct_from_max_hp'), -- Deathly Stare
(56578,'spell_gen_default_count_pct_from_max_hp'), -- Rapid-Fire Harpoon
(38441,'spell_gen_50pct_count_pct_from_max_hp'), -- Cataclysmic Bolt
(66316,'spell_gen_50pct_count_pct_from_max_hp'), -- Spinning Pain Spike 10m
(67100,'spell_gen_50pct_count_pct_from_max_hp'), -- Spinning Pain Spike 25m
(67101,'spell_gen_50pct_count_pct_from_max_hp'), -- Spinning Pain Spike 10m heroic
(67102,'spell_gen_50pct_count_pct_from_max_hp'); -- Spinning Pain Spike 25m heroic
DELETE FROM `spell_scripts` WHERE `id` IN (15998,25952,29435,45980,51592,51910,52267,54420);
DELETE FROM `spell_script_names` WHERE `spell_id` IN (15998,25952,29435,45980,51592,51910,52267,54420);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(15998, 'spell_gen_despawn_self'),
(25952, 'spell_gen_despawn_self'),
(29435, 'spell_gen_despawn_self'),
(45980, 'spell_gen_despawn_self'),
(51592, 'spell_gen_despawn_self'),
(51910, 'spell_gen_despawn_self'),
(52267, 'spell_gen_despawn_self'),
(54420, 'spell_gen_despawn_self');
DELETE FROM `spell_script_names` WHERE `spell_id` IN (50341,50344);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(50341, 'spell_gen_touch_the_nightmare'),
(50344, 'spell_gen_dream_funnel');
DELETE FROM `spell_script_names` WHERE `spell_id` IN (-633,781,-746,1515,6495,-8050,-16972,31789,-34914,-44457,-48181,-30108,34438,34439,35183,43522,65812,68154,68155,68156,52610,61336,-33763,40133,40132,43421,52551,53608,57762,59990,66093,67957,67958,67959,7057,28832,28833,28834,28835,27831,55638,31447,32960,33654,33671,50810,61546,50811,61547,52942,59837,63322,47977,48025,54729,71342,72286,74856,75614,75973);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(-633,  'spell_pal_lay_on_hands'),
(781,   'spell_hun_disengage'),
(-746,  'spell_gen_bandage'),
(1515,  'spell_hun_tame_beast'),
(6495,  'spell_sha_sentry_totem'),
(-8050, 'spell_sha_flame_shock'),
(-16972,'spell_dru_predatory_strikes'),
(31789, 'spell_pal_righteous_defense'),
(-34914,'spell_pri_vampiric_touch'),
(-44457,'spell_mage_living_bomb'),
(-48181,'spell_warl_haunt'),
(-30108,'spell_warl_unstable_affliction'),
(34438, 'spell_warl_unstable_affliction'), -- using class spell script for generic spell because it uses class spell effect
(34439, 'spell_warl_unstable_affliction'),
(35183, 'spell_warl_unstable_affliction'),
(43522, 'spell_hexlord_unstable_affliction'),
(65812, 'spell_faction_champion_warl_unstable_affliction'),
(68154, 'spell_faction_champion_warl_unstable_affliction'),
(68155, 'spell_faction_champion_warl_unstable_affliction'),
(68156, 'spell_faction_champion_warl_unstable_affliction'),
(52610, 'spell_dru_savage_roar'),
(61336, 'spell_dru_survival_instincts'),
(-33763,'spell_dru_lifebloom'),
(40133, 'spell_gen_summon_fire_elemental'),
(40132, 'spell_gen_summon_earth_elemental'),
(43421, 'spell_hexlord_lifebloom'),
(52551, 'spell_tur_ragepaw_lifebloom'),
(53608, 'spell_cenarion_scout_lifebloom'),
(57762, 'spell_twisted_visage_lifebloom'),
(59990, 'spell_twisted_visage_lifebloom'),
(66093, 'spell_faction_champion_dru_lifebloom'),
(67957, 'spell_faction_champion_dru_lifebloom'),
(67958, 'spell_faction_champion_dru_lifebloom'),
(67959, 'spell_faction_champion_dru_lifebloom'),
(7057,  'spell_shadowfang_keep_haunting_spirits'),
(28832, 'spell_four_horsemen_mark'),
(28833, 'spell_four_horsemen_mark'),
(28834, 'spell_four_horsemen_mark'),
(28835, 'spell_four_horsemen_mark'),
(27831, 'spell_gothik_shadow_bolt_volley'),
(55638, 'spell_gothik_shadow_bolt_volley'),
(31447, 'spell_mark_of_kazrogal'),
(32960, 'spell_mark_of_kazzak'),
(33654, 'spell_gruul_shatter'),
(33671, 'spell_gruul_shatter_effect'),
(50810, 'spell_krystallus_shatter'),
(61546, 'spell_krystallus_shatter'),
(50811, 'spell_krystallus_shatter_effect'),
(61547, 'spell_krystallus_shatter_effect'),
(52942, 'spell_loken_pulsing_shockwave'),
(59837, 'spell_loken_pulsing_shockwave'),
(63322, 'spell_general_vezax_saronite_vapors'),
(47977, 'spell_magic_broom'),
(48025, 'spell_headless_horseman_mount'),
(54729, 'spell_winged_steed_of_the_ebon_blade'),
(71342, 'spell_big_love_rocket'),
(72286, 'spell_invincible'),
(74856, 'spell_blazing_hippogryph'),
(75614, 'spell_celestial_steed'),
(75973, 'spell_x53_touring_rocket');
DELETE FROM `spell_script_names` WHERE `spell_id` = 23880;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(23880, 'spell_warr_bloodthirst_heal');
UPDATE `creature_template` SET `InhabitType`=4,`flags_extra`=128,`unit_flags`=0x2000000,`ScriptName`='npc_arthas_teleport_visual' WHERE `entry`=30298; -- Invisible Stalker (Float, Uninteractible, LargeAOI)

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_icc_soul_missile';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(72585,'spell_icc_soul_missile');

DELETE FROM `creature_template_addon` WHERE `entry`=30298;
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`auras`) VALUES
(30298,0,0x0,0x1,''); -- Invisible Stalker (Float, Uninteractible, LargeAOI)

SET @CGUID:=88653;
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+47;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`MovementType`) VALUES
(@CGUID+00,30298,631,15,1,4357.052,2769.421,356.1364,3.141593,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+01,30298,631,15,1,4308.511,2788.476,312.6750,3.263766,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+02,30298,631,15,1,4292.898,2793.981,310.8101,1.640610,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+03,30298,631,15,1,4306.854,2752.771,299.1382,0.820304,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+04,30298,631,15,1,4317.904,2743.047,299.1328,0.820304,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+05,30298,631,15,1,4319.273,2799.125,299.1442,5.567600,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+06,30298,631,15,1,4312.229,2735.825,299.1255,0.820304,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+07,30298,631,15,1,4295.093,2743.372,299.1294,0.820304,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+08,30298,631,15,1,4342.194,2719.366,312.6750,4.799655,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+09,30298,631,15,1,4284.044,2753.073,299.1465,0.820304,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+10,30298,631,15,1,4331.980,2730.547,299.1442,0.820304,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+11,30298,631,15,1,4331.183,2813.701,299.1328,5.567600,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+12,30298,631,15,1,4292.952,2807.547,299.1372,5.567600,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+13,30298,631,15,1,4284.188,2735.236,299.1377,0.820304,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+14,30298,631,15,1,4323.733,2819.085,299.1255,5.567600,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+15,30298,631,15,1,4308.430,2717.113,299.1333,0.820304,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+16,30298,631,15,1,4304.886,2822.116,299.1333,5.567600,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+17,30298,631,15,1,4336.049,2703.986,310.8101,3.176499,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+18,30298,631,15,1,4430.367,2800.603,299.1377,3.909538,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+19,30298,631,15,1,4432.948,2749.438,307.1431,4.799655,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+20,30298,631,15,1,4340.452,2825.148,299.1382,5.567600,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+21,30298,631,15,1,4322.498,2704.592,299.1372,0.820304,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+22,30298,631,15,1,4380.124,2816.074,312.6750,6.265732,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+23,30298,631,15,1,4330.582,2836.512,299.1294,5.567600,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+24,30298,631,15,1,4418.384,2734.435,299.1372,2.443461,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+25,30298,631,15,1,4429.439,2782.781,299.1465,3.909538,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+26,30298,631,15,1,4380.205,2727.930,299.1328,2.443461,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+27,30298,631,15,1,4371.056,2716.414,299.1382,2.443461,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+28,30298,631,15,1,4399.571,2746.277,312.6750,4.799655,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+29,30298,631,15,1,4382.944,2808.139,299.1442,3.909538,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+30,30298,631,15,1,4389.698,2694.647,299.1377,2.443461,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+31,30298,631,15,1,4336.760,2689.307,307.1431,3.176499,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+32,30298,631,15,1,4391.995,2742.610,299.1442,2.443461,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+33,30298,631,15,1,4322.008,2847.075,299.1377,5.567600,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+34,30298,631,15,1,4396.241,2794.807,299.1328,3.909538,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+35,30298,631,15,1,4380.467,2834.892,310.8101,6.265732,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+36,30298,631,15,1,4337.707,2850.425,299.1465,5.567600,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+37,30298,631,15,1,4392.823,2719.806,299.1255,2.443461,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+38,30298,631,15,1,4406.686,2784.457,299.1382,3.909538,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+39,30298,631,15,1,4381.028,2705.133,299.1294,2.443461,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+40,30298,631,15,1,4371.884,2693.614,299.1465,2.443461,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+41,30298,631,15,1,4405.702,2806.464,299.1255,3.909538,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+42,30298,631,15,1,4418.314,2747.997,310.8101,4.799655,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+43,30298,631,15,1,4380.639,2849.595,307.1431,6.265732,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+44,30298,631,15,1,4393.958,2833.470,299.1372,3.909538,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+45,30298,631,15,1,4406.588,2719.758,299.1333,2.443461,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+46,30298,631,15,1,4407.252,2820.139,299.1333,3.909538,7200,0,0), -- Invisible Stalker (Float, Uninteractible, LargeAOI)
(@CGUID+47,30298,631,15,1,4418.995,2793.132,299.1294,3.909538,7200,0,0); -- Invisible Stalker (Float, Uninteractible, LargeAOI)
DELETE FROM `spell_script_names` WHERE (`spell_id`='-5570');
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(-5570, 'spell_dru_insect_swarm');
DELETE FROM `spell_script_names` WHERE `spell_id`IN (64142,62991);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(64142,'spell_gen_upper_deck_create_foam_sword'),
(62991,'spell_gen_bonked');
-- Gift of the Naaru
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_gen_gift_of_naaru';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(28880,'spell_gen_gift_of_naaru'), -- SPELLFAMILY_WARRIOR
(59542,'spell_gen_gift_of_naaru'), -- SPELLFAMILY_PALADIN
(59543,'spell_gen_gift_of_naaru'), -- SPELLFAMILY_HUNTER
(59544,'spell_gen_gift_of_naaru'), -- SPELLFAMILY_PRIEST
(59545,'spell_gen_gift_of_naaru'), -- SPELLFAMILY_DEATHKNIGHT
(59547,'spell_gen_gift_of_naaru'), -- SPELLFAMILY_SHAMAN
(59548,'spell_gen_gift_of_naaru'); -- SPELLFAMILY_MAGE
DELETE FROM `spell_target_position` WHERE `id` IN (60323,60324,60325,60326,60327,60328,60329,60330,60331,60332,60333,60334,60335);
INSERT INTO `spell_target_position` (`id`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
(60323,0,-5506.339,-704.348,392.686,0.595), -- Steelgrills Depot
(60324,0,-9470.760,3.909,49.794,4.802), -- Lions Pride Inn, Goldshire
(60325,1,-3721.306,-4411.906,25.247,0.831), -- Theramore isle, Dustwallow Marsh
(60326,0,286.314,-2184.086,122.612,2.271), -- Aerie Peak, The Hinterlands
(60327,1,6395.708,433.256,33.260,0.566), -- Auberdine, Darkshore
(60328,0,-14412.923,692.017,22.248,1.231), -- Boote Bay
(60329,1,-7135.717,-3787.769,8.799,5.992), -- Tanaris, Gadgetzan
(60330,0,-10336.138,-2934.057,116.723,4.523), -- Swamp of Sorrows, Z coord is intended
(60331,0,-10446.900,-3261.909,20.179,5.875), -- Stonard, Swamp of Sorrows
(60332,0,-103.988,-902.795,55.534,5.924), -- Tarren Mill, Hillsbrad Foothils
(60333,0,1804.836,196.322,70.399,1.572), -- Undercity
(60334,1,-1060.266,23.137,141.455,5.967), -- Thunder Bluff
(60335,1,-506.224,-2590.084,113.150,2.445); -- Barrens, The Crossroads
