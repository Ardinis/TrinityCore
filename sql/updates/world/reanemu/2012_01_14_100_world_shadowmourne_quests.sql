-- Quest de la cadena de Shadowmourne sólo disponible para paladin, dk y guerrero

UPDATE `quest_template` SET `RequiredClasses`=35 WHERE `Id` IN (24545,24743,24547,24749,24756,24757,24548,24549,24748);