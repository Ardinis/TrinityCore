-- Fix para que las sangres de caraputrea y panzachacro sean loteadas 
-- por el lootmaster by Strolx

-- Sangre ácida de Carapútrea
UPDATE creature_loot_template SET ChanceOrQuestChance=100 WHERE item=50231;
UPDATE creature_loot_template SET ChanceOrQuestChance=100 WHERE item=50231;

-- Sangre ácida de Panzachancro
UPDATE creature_loot_template SET ChanceOrQuestChance=100 WHERE item=50226;
UPDATE creature_loot_template SET ChanceOrQuestChance=100 WHERE item=50226;