-- Fix quest 14108 : Sus au raken ! --


UPDATE creature_template SET AIName='SmartAI' WHERE entry IN (34925, 35092);

DELETE FROM spell_linked_spell WHERE spell_trigger=66588;
INSERT INTO spell_linked_spell VALUES (66588, 44188, 0, 'Flaming Spear');


DELETE FROM `smart_scripts` WHERE entryorguid=34925 AND source_type=0;
DELETE FROM `smart_scripts` WHERE entryorguid=35092 AND source_type=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(34925, 0, 1, 0, 8, 0, 100, 0, 44188, 0, 0, 0, 33, 35009, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Spellhit Flaming spear : give killcredit'),
(35092, 0, 1, 2, 8, 0, 100, 0, 44188, 0, 0, 0, 33, 35092, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Spellhit Flaming spear : give killcredit'),
(35092, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mande-fonds : die');







