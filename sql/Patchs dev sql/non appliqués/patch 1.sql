/* *********************************************************
Creature : 30401
Problème : PNJ non existant en jeu
Solution : Spawn de la créature

********************************************************** */
/* Velog Icebellow */
DELETE FROM creature WHERE id = 30401;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`?,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentway?point`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags?`) 
VALUES ('',30401,571,1,1,0,2396,6650.04,-310.876,989.381,1.76958,300,0,0,63000,0,0,0,0,0);


/* *********************************************************
GameObject : 149047, 149410
Problème : GameObject visible uniquement en GM-ON
Solution : Remplacement du spawntimesecs par une valeur positive 

********************************************************** */

/*Torch of Retribution*/
DELETE FROM `gameobject` WHERE `id`=149047;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z?`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,?`animprogress`,`state`) VALUES
('', 149047, 0, 1, 1, -6683.73, -1194.19, 242.02, 0.212059, 0, 0, 0.105831, 0.994384, 300, 0, 1);

/*Light of Retribution*/
DELETE FROM `gameobject` WHERE `id`=149410;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z?`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,?`animprogress`,`state`) VALUES
('', 149410, 0, 1, 1, -6683.73, -1194.19, 240.027, 0.447678, 0, 0, 0.221974, 0.975053, 300, 0, 1);