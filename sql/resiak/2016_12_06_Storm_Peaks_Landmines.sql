-- Correction du bump des landmines près de K3
INSERT INTO spell_linked_spell(spell_trigger, spell_effect, type, comment)
VALUES (54355, 54402, 0, 'Detonation');

-- Retrait de l'appel d'un script pour valider le HF Démineur (script non existant)
UPDATE achievement_criteria_data SET type=0 WHERE criteria_id = 5258;
