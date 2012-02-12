-- Se cambia el campo SpecialFlaq para que no se complete mediante un Script sino en el campo Agrega en el campo de RequiredNpcOrGo1 el npc que debia ser matado, antes valor en 0 By Strolx

UPDATE quest_template SET SpecialFlags=0,RequiredNpcOrGo1=18398,RequiredNpcOrGoCount1=1 WHERE Id=9962 LIMIT 1;
UPDATE quest_template SET SpecialFlags=0,RequiredNpcOrGo1=18399,RequiredNpcOrGoCount1=1 WHERE Id=9967 LIMIT 1;
UPDATE quest_template SET SpecialFlags=0,RequiredNpcOrGo1=18400,RequiredNpcOrGoCount1=1 WHERE Id=9970 LIMIT 1;
UPDATE quest_template SET SpecialFlags=0,RequiredNpcOrGo1=18401,RequiredNpcOrGoCount1=1 WHERE Id=9972 LIMIT 1;
UPDATE quest_template SET SpecialFlags=0,RequiredNpcOrGo1=18402,RequiredNpcOrGoCount1=1 WHERE Id=9973 LIMIT 1;
UPDATE quest_template SET SpecialFlags=0,RequiredNpcOrGo1=18069,RequiredNpcOrGoCount1=1 WHERE Id=9977 LIMIT 1;

