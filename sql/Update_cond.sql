-- Knights of the Ebon Blade
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=23 AND `SourceEntry` IN (44149,50367);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ScriptName`,`Comment`) VALUES
(23,32538,44149,0,0,5,0,1098,192,0,0,'','Arcanum of Torment - when Knights of the Ebon Blade revered/exalted'),
(23,32538,50367,0,0,5,0,1098,63,0,0,'','Arcanum of Torment - when Knights of the Ebon Blade not revered/exalted');

DELETE FROM `npc_vendor` WHERE `entry`=32538 AND `item`=50367;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES
(32538,0,50367,0,0,0); -- Arcanum of Torment

-- Kirin Tor
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=23 AND `SourceEntry` IN (44159,50368);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ScriptName`,`Comment`) VALUES
(23,32287,44159,0,0,5,0,1090,192,0,0,'','Arcanum of Burning Mysteries - when Kirin Tor revered/exalted'),
(23,32287,50368,0,0,5,0,1090,63,0,0,'','Arcanum of Burning Mysteries - when Kirin Tor not revered/exalted');

DELETE FROM `npc_vendor` WHERE `entry`=32287 AND `item`=50368;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES
(32287,0,50368,0,0,0); -- Arcanum of Burning Mysteries

-- The Wyrmrest Accord
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=23 AND `SourceEntry` IN (44152,50370);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ScriptName`,`Comment`) VALUES
(23,32533,44152,0,0,5,0,1091,192,0,0,'','Arcanum of Blissful Mending - when The Wyrmrest Accord revered/exalted'),
(23,32533,50370,0,0,5,0,1091,63,0,0,'','Arcanum of Blissful Mending - when The Wyrmrest Accord not revered/exalted');

DELETE FROM `npc_vendor` WHERE `entry`=32533 AND `item`=50370;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES
(32533,0,50370,0,0,0); -- Arcanum of Blissful Mending

-- Horde Expedition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=23 AND `SourceEntry` IN (44702,50373);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ScriptName`,`Comment`) VALUES
(23,32774,44702,0,0,5,0,1052,128,0,0,'','Arcanum of the Savage Gladiator - when Horde Expedition exalted'),
(23,32774,50373,0,0,5,0,1052,127,0,0,'','Arcanum of the Savage Gladiator - when Horde Expedition not exalted'),
(23,32565,44702,0,0,5,0,1052,128,0,0,'','Arcanum of the Savage Gladiator - when Horde Expeditione exalted'),
(23,32565,50373,0,0,5,0,1052,127,0,0,'','Arcanum of the Savage Gladiator - when Horde Expedition not exalted');

DELETE FROM `npc_vendor` WHERE `entry` IN (32565,32774) AND `item`=50373;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES
(32565,0,50373,0,0,0), -- Arcanum of the Savage Gladiator
(32774,0,50373,0,0,0); -- Arcanum of the Savage Gladiator

-- Alliance Vanguard
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=23 AND `SourceEntry` IN (44701,50372);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ScriptName`,`Comment`) VALUES
(23,32564,44701,0,0,5,0,1037,128,0,0,'','Arcanum of the Savage Gladiator - when Alliance Vanguard rexalted'),
(23,32564,50372,0,0,5,0,1037,127,0,0,'','Arcanum of the Savage Gladiator - when Alliance Vanguard not exalted'),
(23,32773,44701,0,0,5,0,1037,128,0,0,'','Arcanum of the Savage Gladiator - when Alliance Vanguard exalted'),
(23,32773,50372,0,0,5,0,1037,127,0,0,'','Arcanum of the Savage Gladiator - when Alliance Vanguard not exalted');

DELETE FROM `npc_vendor` WHERE `entry` IN (32773,32564) AND `item`=50372;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES
(32564,0,50372,0,0,0), -- Arcanum of the Savage Gladiator
(32773,0,50372,0,0,0); -- Arcanum of the Savage Gladiator

-- Red Rider Air Rifle
DELETE FROM `npc_vendor` WHERE `entry` IN (29478,29716) AND `item`=46725;
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES
(29478,0,46725,0,0,0), -- Jepetto Joybuzz <Toymaker>
(29716,0,46725,0,0,0); -- Clockwork Assistant <Jepetto's Companion>

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=23 AND `SourceEntry`=46725;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ScriptName`,`Comment`) VALUES
(23,29478,46725,0,0,12,0,2,0,0,0,'','Rotes Erbsengewehr / Jepetto Joybuzz <Toymaker> - only for Winter Veil'),
(23,29716,46725,0,0,12,0,2,0,0,0,'','Rotes Erbsengewehr / Clockwork Assistant <Jepetto''s Companion> - only for Winter Veil');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=23 AND `SourceGroup`=12944 AND `SourceEntry` IN (20761,17051,17022,17018,17023,19444);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=23 AND `SourceGroup`=12944 AND `SourceEntry` IN (19219,17017,17025,19330,19448,17059,17060,17049,19206);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=23 AND `SourceGroup`=12944 AND `SourceEntry` IN (19220,19332,19333,19331,19449,19209,19208,19207,17053,17052);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=23 AND `SourceGroup`=12944 AND `SourceEntry` IN (19211,19210,19212,20040);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ScriptName`, `Comment`) VALUES
-- Conditon rep Friendly
(23,12944,20761,0,0,5,0,59,16,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Friendly with Thorium Brotherhood'),
(23,12944,17051,0,0,5,0,59,16,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Friendly with Thorium Brotherhood'),
(23,12944,17022,0,0,5,0,59,16,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Friendly with Thorium Brotherhood'),
(23,12944,17018,0,0,5,0,59,16,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Friendly with Thorium Brotherhood'),
(23,12944,17023,0,0,5,0,59,16,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Friendly with Thorium Brotherhood'),
(23,12944,19444,0,0,5,0,59,16,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Friendly with Thorium Brotherhood'),
-- Conditon rep Honored
(23,12944,19219,0,0,5,0,59,32,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Honored with Thorium Brotherhood'),
(23,12944,17017,0,0,5,0,59,32,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Honored with Thorium Brotherhood'),
(23,12944,17025,0,0,5,0,59,32,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Honored with Thorium Brotherhood'),
(23,12944,19330,0,0,5,0,59,32,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Honored with Thorium Brotherhood'),
(23,12944,19448,0,0,5,0,59,32,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Honored with Thorium Brotherhood'),
(23,12944,17059,0,0,5,0,59,32,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Honored with Thorium Brotherhood'),
(23,12944,17060,0,0,5,0,59,32,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Honored with Thorium Brotherhood'),
(23,12944,17049,0,0,5,0,59,32,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Honored with Thorium Brotherhood'),
(23,12944,19206,0,0,5,0,59,32,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Honored with Thorium Brotherhood'),
-- Conditon rep Revered
(23,12944,19220,0,0,5,0,59,64,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Revered with Thorium Brotherhood'),
(23,12944,19332,0,0,5,0,59,64,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Revered with Thorium Brotherhood'),
(23,12944,19333,0,0,5,0,59,64,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Revered with Thorium Brotherhood'),
(23,12944,19331,0,0,5,0,59,64,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Revered with Thorium Brotherhood'),
(23,12944,19449,0,0,5,0,59,64,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Revered with Thorium Brotherhood'),
(23,12944,19209,0,0,5,0,59,64,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Revered with Thorium Brotherhood'),
(23,12944,19208,0,0,5,0,59,64,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Revered with Thorium Brotherhood'),
(23,12944,19207,0,0,5,0,59,64,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Revered with Thorium Brotherhood'),
(23,12944,17053,0,0,5,0,59,64,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Revered with Thorium Brotherhood'),
(23,12944,17052,0,0,5,0,59,64,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Revered with Thorium Brotherhood'),
-- Conditon rep Exalted
(23,12944,19211,0,0,5,0,59,128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Exalted with Thorium Brotherhood'),
(23,12944,19210,0,0,5,0,59,128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Exalted with Thorium Brotherhood'),
(23,12944,19212,0,0,5,0,59,128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Exalted with Thorium Brotherhood'),
(23,12944,20040,0,0,5,0,59,128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Exalted with Thorium Brotherhood');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=23 AND `SourceGroup`=12944 AND `SourceEntry` IN (20761,17051,17022,17018,17023,19444);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=23 AND `SourceGroup`=12944 AND `SourceEntry` IN (19219,17017,17025,19330,19448,17059,17060,17049,19206);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=23 AND `SourceGroup`=12944 AND `SourceEntry` IN (19220,19332,19333,19331,19449,19209,19208,19207,17053,17052);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=23 AND `SourceGroup`=12944 AND `SourceEntry` IN (19211,19210,19212,20040);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ScriptName`, `Comment`) VALUES
-- Conditon rep Friendly
(23,12944,20761,0,0,5,0,59,16|32|64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Friendly with Thorium Brotherhood'),
(23,12944,17051,0,0,5,0,59,16|32|64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Friendly with Thorium Brotherhood'),
(23,12944,17022,0,0,5,0,59,16|32|64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Friendly with Thorium Brotherhood'),
(23,12944,17018,0,0,5,0,59,16|32|64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Friendly with Thorium Brotherhood'),
(23,12944,17023,0,0,5,0,59,16|32|64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Friendly with Thorium Brotherhood'),
(23,12944,19444,0,0,5,0,59,16|32|64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Friendly with Thorium Brotherhood'),
-- Conditon rep Honored
(23,12944,19219,0,0,5,0,59,32|64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Honored with Thorium Brotherhood'),
(23,12944,17017,0,0,5,0,59,32|64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Honored with Thorium Brotherhood'),
(23,12944,17025,0,0,5,0,59,32|64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Honored with Thorium Brotherhood'),
(23,12944,19330,0,0,5,0,59,32|64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Honored with Thorium Brotherhood'),
(23,12944,19448,0,0,5,0,59,32|64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Honored with Thorium Brotherhood'),
(23,12944,17059,0,0,5,0,59,32|64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Honored with Thorium Brotherhood'),
(23,12944,17060,0,0,5,0,59,32|64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Honored with Thorium Brotherhood'),
(23,12944,17049,0,0,5,0,59,32|64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Honored with Thorium Brotherhood'),
(23,12944,19206,0,0,5,0,59,32|64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Honored with Thorium Brotherhood'),
-- Conditon rep Revered
(23,12944,19220,0,0,5,0,59,64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Revered with Thorium Brotherhood'),
(23,12944,19332,0,0,5,0,59,64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Revered with Thorium Brotherhood'),
(23,12944,19333,0,0,5,0,59,64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Revered with Thorium Brotherhood'),
(23,12944,19331,0,0,5,0,59,64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Revered with Thorium Brotherhood'),
(23,12944,19449,0,0,5,0,59,64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Revered with Thorium Brotherhood'),
(23,12944,19209,0,0,5,0,59,64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Revered with Thorium Brotherhood'),
(23,12944,19208,0,0,5,0,59,64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Revered with Thorium Brotherhood'),
(23,12944,19207,0,0,5,0,59,64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Revered with Thorium Brotherhood'),
(23,12944,17053,0,0,5,0,59,64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Revered with Thorium Brotherhood'),
(23,12944,17052,0,0,5,0,59,64|128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Revered with Thorium Brotherhood'),
-- Conditon rep Exalted
(23,12944,19211,0,0,5,0,59,128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Exalted with Thorium Brotherhood'),
(23,12944,19210,0,0,5,0,59,128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Exalted with Thorium Brotherhood'),
(23,12944,19212,0,0,5,0,59,128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Exalted with Thorium Brotherhood'),
(23,12944,20040,0,0,5,0,59,128,0,0, '', 'Lokhtos Darkbargainer - Only sell item if Exalted with Thorium Brotherhood');
