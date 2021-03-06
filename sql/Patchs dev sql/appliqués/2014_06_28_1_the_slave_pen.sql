DELETE FROM `gameobject` WHERE `id` IN (185292, 182094);
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(185292, 547, 3, 1, -297.0662, -459.9854, 3.035661, 0.1047193, 0, 0, 0, 1, 7200, 255, 1), -- Skar'this's Prison
(182094, 547, 3, 1, -192.2968, -799.3084, 43.80826, 5.98648, 0, 0, 0, 1, 7200, 255, 1); -- Cage

SET @CGUID = (SELECT MAX(guid) FROM creature);

DELETE FROM `creature_addon` WHERE `guid` IN (@CGUID+2, @CGUID+3, 52359, 52361);
INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(@CGUID+2, 0, 0x3000001, 0x1, 0, ''), -- Wastewalker Captive
(@CGUID+3, 0, 0x3000001, 0x1, 0, ''), -- Wastewalker Captive
(@CGUID+64, 0, 0x0, 0x1, 69, '5301'), -- Coilfang Collaborator - Revenge Trigger
(@CGUID+65, 0, 0x0, 0x1, 69, '5301'); -- Coilfang Collaborator - Revenge Trigger

DELETE FROM `creature` WHERE map = 547;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
(@CGUID+1, 13321, 547, 3, 1, 0.7285497, -66.80369, -1.59056, 4.962676, 7200, 5, 1), -- Small Frog
(@CGUID+2, 18206, 547, 3, 1, 7.689064, -10.21175, 0.9106051, 3.159046, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+3, 18206, 547, 3, 1, 9.391239, -11.7804, 0.6854159, 4.625123, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+4, 13321, 547, 3, 1, -14.80215, -9.449524, -1.451238, 2.552285, 7200, 5, 1), -- Small Frog
(@CGUID+5, 18206, 547, 3, 1, -26.60198, 8.733533, 1.752648, 5.288348, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+6, 18206, 547, 3, 1, -41.43275, 9.405079, 1.371649, 5.410521, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+7, 18206, 547, 3, 1, -88.38076, -148.3378, 24.94725, 1.117011, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+8, 18206, 547, 3, 1, -91.83733, -148.0196, 24.94726, 2.303835, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+9, 18206, 547, 3, 1, -70.57574, -138.288, 1.37165, 2.181662, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+10, 18206, 547, 3, 1, -70.36482, -139.9095, 1.371652, 3.979351, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+11, 13321, 547, 3, 1, -98.55703, -155.8409, -2.537082, 2.743803, 7200, 5, 1), -- Small Frog
(@CGUID+12, 18206, 547, 3, 1, -155.7575, -196.1139, -3.747556, 1.570796, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+13, 18206, 547, 3, 1, -154.6465, -197.7915, -3.747561, 0.1396263, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+14, 13321, 547, 3, 1, -72.17783, -260.2528, -1.327836, 5.296387, 7200, 5, 1), -- Small Frog
(@CGUID+15, 18206, 547, 3, 1, -141.5576, -269.821, 1.229008, 2.129302, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+16, 18206, 547, 3, 1, -139.6963, -270.7644, 1.229008, 0.5235988, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+17, 17963, 547, 3, 1, -95.53171, -293.335, -1.42634, 5.462881, 7200, 0, 0), -- Wastewalker Slave
(@CGUID+18, 18206, 547, 3, 1, -131.4032, -284.4102, 1.229006, 0.3665192, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+19, 18206, 547, 3, 1, -132.8301, -283.2076, 1.229015, 0.9075712, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+20, 18206, 547, 3, 1, -95.01682, -267.8548, 1.467276, 5.899213, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+21, 18206, 547, 3, 1, -39.31921, -248.708, 0.6584353, 3.159046, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+22, 18206, 547, 3, 1, -36.5463, -247.2646, 0.3471813, 5.72468, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+23, 18206, 547, 3, 1, -96.20238, -266.5772, 1.467276, 1.64061, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+24, 18206, 547, 3, 1, -89.40193, -297.0217, 1.22901, 0.9773844, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+25, 18206, 547, 3, 1, -91.98604, -297.5824, 1.22901, 2.286381, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+26, 2110, 547, 3, 1, 41.23739, -384.438, 3.035556, 2.865832, 7200, 5, 1), -- Black Rat
(@CGUID+27, 2110, 547, 3, 1, -54.96066, -377.6979, 81.26734, 0.9852618, 7200, 5, 1), -- Black Rat
(@CGUID+28, 2110, 547, 3, 1, -224.6407, -358.3843, 3.03559, 1.281962, 7200, 5, 1), -- Black Rat
(@CGUID+29, 2110, 547, 3, 1, -264.8192, -423.4044, 3.033602, 5.388705, 7200, 5, 1), -- Black Rat
(@CGUID+30, 18206, 547, 3, 1, -33.7396, -539.5004, 30.43043, 2.356194, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+31, 18206, 547, 3, 1, -29.99723, -536.3927, 1.163641, 4.101524, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+32, 18206, 547, 3, 1, -15.92518, -546.9789, 1.163645, 3.228859, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+33, 18206, 547, 3, 1, -152.0757, -585.8268, 8.971064, 0.3665192, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+34, 18206, 547, 3, 1, -152.9591, -588.3441, 8.971066, 5.131268, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+35, 18206, 547, 3, 1, -163.2083, -573.244, 13.99786, 0.296706, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+36, 18206, 547, 3, 1, -164.0016, -575.6511, 13.99786, 5.096361, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+37, 18206, 547, 3, 1, -37.74952, -590.5631, 1.16364, 1.53589, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+38, 18206, 547, 3, 1, -39.8357, -592.4739, 1.163639, 3.071779, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+39, 18206, 547, 3, 1, -14.05406, -560.0514, 28.04964, 2.827433, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+40, 18206, 547, 3, 1, -22.29612, -582.496, 1.163641, 2.460914, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+41, 18206, 547, 3, 1, -68.60107, -590.7484, 37.56314, 3.630285, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+42, 18206, 547, 3, 1, -67.34998, -588.6846, 37.56313, 1.448623, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+43, 18206, 547, 3, 1, -14.16554, -566.9521, 1.16364, 4.380776, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+44, 18206, 547, 3, 1, -16.15083, -565.0188, 1.16364, 3.141593, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+45, 18206, 547, 3, 1, -176.8808, -700.3074, 40.88328, 4.660029, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+46, 13321, 547, 3, 1, -175.3171, -720.527, 37.89232, 2.827228, 7200, 5, 1), -- Small Frog
(@CGUID+47, 18206, 547, 3, 1, -188.2369, -694.4863, 40.88328, 5.166174, 7200, 0, 0), -- Wastewalker Captive
(@CGUID+48, 3300, 547, 3, 1, -106.7319, -61.30008, -3.362401, 0.1478606, 7200, 5, 1), -- Adder
(@CGUID+49, 3300, 547, 3, 1, -72.26672, -318.7746, -1.512328, 1.468673, 7200, 5, 1), -- Adder
(@CGUID+50, 3300, 547, 3, 1, -59.9993, -542.4127, -1.593513, 1.952262, 7200, 5, 1), -- Adder
(@CGUID+51, 3300, 547, 3, 1, -92.25909, -682.5776, 32.75705, 1.602903, 7200, 5, 1), -- Adder
(@CGUID+52, 17817, 547, 3, 1, 7.252286, -251.2889, 0.3395844, 3.368485, 7200, 5, 1), -- Greater Bogstrok
(@CGUID+53, 17817, 547, 3, 1, 15.67841, -233.7075, -0.5607645, 0.3084831, 7200, 5, 1), -- Greater Bogstrok
(@CGUID+54, 17816, 547, 3, 1, 20.42247, -245.9672, 2.037554, 0.2054878, 7200, 5, 1), -- Bogstrok
(@CGUID+55, 17816, 547, 3, 1, 27.51504, -244.3523, 2.890243, 4.876865, 7200, 5, 1), -- Bogstrok
(@CGUID+56, 17817, 547, 3, 1, 35.86108, -254.7482, 5.748631, 5.541633, 7200, 5, 1), -- Greater Bogstrok
(@CGUID+57, 17816, 547, 3, 1, 40.02773, -232.9289, -0.2917374, 5.831529, 7200, 5, 1), -- Bogstrok
(@CGUID+58, 17817, 547, 3, 1, -203.7054, -734.4595, 35.6812, 4.970519, 7200, 0, 0), -- Greater Bogstrok
(@CGUID+59, 17817, 547, 3, 1, -207.3565, -724.6968, 36.44803, 5.07027, 7200, 0, 0), -- Greater Bogstrok
(@CGUID+60, 17816, 547, 3, 1, -206.1612, -714.8032, 37.3086, 4.836682, 7200, 0, 0), -- Bogstrok
(@CGUID+61, 17958, 547, 3, 1, -67.22121, -380.6276, 79.47726, 6.27036, 7200, 0, 0), -- Coilfang Defender
(@CGUID+62, 17958, 547, 3, 1, -74.04443, -378.5399, 78.72163, 6.27036, 7200, 0, 0), -- Coilfang Defender
(@CGUID+63, 13321, 547, 3, 1, 108.5413, -93.65434, -1.498286, 5.641585, 7200, 5, 1), -- Small Frog
(@CGUID+64, 17962, 547, 3, 1, 33.9016, -379.3725, 3.118852, 1.605703, 7200, 0, 0), -- Coilfang Collaborator
(@CGUID+65, 17962, 547, 3, 1, 39.15127, -395.5019, 3.118883, 4.799655, 7200, 0, 0); -- Coilfang Collaborator

INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
(22421, 547, 2, 1, -296.4931, -459.0429, 6.146773, 0.7679449, 7200, 0, 0), -- Skar'this the Heretic
(17938, 547, 3, 1, -119.4284, -595.8055, 8.456528, 5.323254, 7200, 0, 0), -- Coilfang Observer
(17938, 547, 3, 1, -127.1415, -144.4277, -1.803136, 0.8552113, 7200, 0, 0), -- Coilfang Observer
(17963, 547, 3, 1, -54.63998, -280.2335, -1.283369, 3.996804, 7200, 0, 0), -- Wastewalker Slave
(17964, 547, 3, 1, -54.29192, -248.0854, -3.691535, 1.972222, 7200, 0, 0), -- Wastewalker Worker
(17963, 547, 3, 1, -89.17553, -91.53407, -2.22339, 6.073746, 7200, 0, 0), -- Wastewalker Slave
(17963, 547, 3, 1, -120.7097, -65.83062, -2.223061, 3.159046, 7200, 0, 0), -- Wastewalker Slave
(17964, 547, 3, 1, -57.08875, -27.93377, -1.772427, 3.176499, 7200, 0, 0), -- Wastewalker Worker
(17963, 547, 3, 1, -78.01715, -191.155, -3.423848, 5.934119, 7200, 0, 0), -- Wastewalker Slave
(17964, 547, 3, 1, -113.1554, -8.017564, -8.669127, 1.762783, 7200, 0, 0), -- Wastewalker Worker
(17963, 547, 3, 1, -69.62327, -245.9392, -3.536769, 0.7679449, 7200, 0, 0), -- Wastewalker Slave
(17963, 547, 3, 1, -45.51907, -293.7432, -1.349522, 3.403392, 7200, 0, 0), -- Wastewalker Slave
(17964, 547, 3, 1, -47.75424, -285.9099, -1.310401, 3.752458, 7200, 0, 0), -- Wastewalker Worker
(17964, 547, 3, 1, -108.3841, -755.4068, 37.9846, 5.078908, 7200, 0, 0), -- Wastewalker Worker
(17964, 547, 3, 1, -114.9684, -747.1564, 37.98458, 0.8901179, 7200, 0, 0), -- Wastewalker Worker
(17964, 547, 3, 1, -73.0294, -718.7322, 38.98584, 5.480334, 7200, 0, 0), -- Wastewalker Worker
(17964, 547, 3, 1, -94.14198, -721.347, 38.1964, 2.827433, 7200, 0, 0), -- Wastewalker Worker
(17964, 547, 3, 1, -101.7542, -14.13979, -7.868871, 4.677482, 7200, 0, 0), -- Wastewalker Worker
(17964, 547, 3, 1, -77.18946, -284.4292, -1.241735, 5.654867, 7200, 0, 0), -- Wastewalker Worker
(17963, 547, 3, 1, -83.51007, -290.5829, -1.381121, 5.393067, 7200, 0, 0), -- Wastewalker Slave
(17964, 547, 3, 1, -38.74315, 3.089242, -1.204552, 1.850049, 7200, 0, 0), -- Wastewalker Worker
(17964, 547, 3, 1, -47.47281, 3.605731, -1.507226, 1.692969, 7200, 0, 0), -- Wastewalker Worker
(17964, 547, 3, 1, -96.44904, -62.15407, -1.792045, 0.1396263, 7200, 0, 0), -- Wastewalker Worker
(17964, 547, 3, 1, -61.51235, -20.17615, -2.663957, 4.18879, 7200, 0, 0), -- Wastewalker Worker
(17964, 547, 3, 1, -73.61772, -182.1575, -5.111982, 5.148721, 7200, 0, 0), -- Wastewalker Worker
(17963, 547, 3, 1, -60.16751, -176.9379, -4.0791, 4.660029, 7200, 0, 0), -- Wastewalker Slave
(17963, 547, 3, 1, -112.2143, -105.2496, -4.700827, 2.75762, 7200, 0, 0), -- Wastewalker Slave
(17963, 547, 3, 1, -71.8825, -19.18774, -4.44727, 4.153883, 7200, 0, 0), -- Wastewalker Slave
(17964, 547, 3, 1, -61.51586, -248.3638, -3.940233, 0.9948376, 7200, 0, 0), -- Wastewalker Worker
(17964, 547, 3, 1, -27.17291, 1.65894, -0.7652907, 1.815142, 7200, 0, 0), -- Wastewalker Worker
(17957, 547, 3, 1, -162.7924, -463.4172, 3.205104, 1.919862, 7200, 0, 0), -- Coilfang Champion
(17957, 547, 3, 1, -158.5233, -447.8588, 3.040779, 3.665191, 7200, 0, 0), -- Coilfang Champion
(17890, 547, 3, 1, -294.5036, -380.8706, 30.58193, 1.32645, 7200, 0, 0), -- Weeder Greenthumb
(17893, 547, 3, 1, -192.1564, -799.5793, 43.89159, 1.239184, 7200, 0, 0), -- Naturalist Bite
(17960, 547, 3, 1, -79.08044, -584.6921, 1.512077, 1.082104, 7200, 0, 0), -- Coilfang Soothsayer
(18206, 547, 3, 1, -190.9466, -693.8201, 40.88328, 3.787364, 7200, 0, 0), -- Wastewalker Captive
(18206, 547, 3, 1, -43.76052, 9.132533, 1.371655, 4.433136, 7200, 0, 0), -- Wastewalker Captive
(18206, 547, 3, 1, -28.65155, 8.898226, 1.752653, 3.630285, 7200, 0, 0), -- Wastewalker Captive
(18206, 547, 3, 1, -22.36813, -585.0342, 1.16364, 3.804818, 7200, 0, 0), -- Wastewalker Captive
(18206, 547, 3, 1, -178.7577, -698.3421, 40.88328, 3.281219, 7200, 0, 0), -- Wastewalker Captive
(18206, 547, 3, 1, -29.96552, -534.0687, 1.163646, 2.565634, 7200, 0, 0), -- Wastewalker Captive
(18206, 547, 3, 1, -14.36809, -548.7775, 1.163643, 4.485496, 7200, 0, 0), -- Wastewalker Captive
(18206, 547, 3, 1, -18.79482, -577.8669, 18.76408, 2.722714, 7200, 0, 0), -- Wastewalker Captive
(18206, 547, 3, 1, -33.75176, -585.9126, 23.79086, 2.96706, 7200, 0, 0), -- Wastewalker Captive
(17957, 547, 3, 1, -118.9584, -152.85, -1.957283, 0.4886922, 7200, 0, 0), -- Coilfang Champion
(21126, 547, 3, 1, -88.22562, -497.4428, -1.507759, 2.722714, 7200, 0, 0), -- Coilfang Scale-Healer
(17938, 547, 3, 1, -84.87788, -503.3429, -1.509169, 3.281219, 7200, 0, 0), -- Coilfang Observer
(17940, 547, 3, 1, 122.6974, -297.8582, 3.119044, 3.700098, 7200, 0, 0), -- Coilfang Technician
(17957, 547, 3, 1, -83.79871, -585.3203, 1.376997, 1.37881, 7200, 0, 0), -- Coilfang Champion
(17957, 547, 3, 1, -77.88522, -592.5287, 2.310318, 5.951573, 7200, 0, 0), -- Coilfang Champion
(21126, 547, 3, 1, -175.4446, -771.7658, 42.21755, 4.796402, 7200, 3, 1), -- Coilfang Scale-Healer
(17938, 547, 3, 1, -187.0115, -762.9409, 41.79701, 5.734584, 7200, 3, 1), -- Coilfang Observer
(17958, 547, 3, 1, -6.498472, -296.8441, 3.15944, 2.932153, 7200, 0, 0), -- Coilfang Defender
(17958, 547, 3, 1, -11.27964, -312.923, 2.95958, 2.86234, 7200, 0, 0), -- Coilfang Defender
(21126, 547, 3, 1, -121.849, -147.4496, -1.981267, 1.082104, 7200, 0, 0), -- Coilfang Scale-Healer
(17961, 547, 3, 1, -76.53473, -588.3738, 1.945644, 0.4363323, 7200, 0, 0), -- Coilfang Enchantress
(21127, 547, 3, 1, -82.17294, -494.0059, -1.509497, 2.391101, 7200, 0, 0), -- Coilfang Tempest
(21127, 547, 3, 1, -116.9161, -585.9364, 5.483181, 0.3839724, 7200, 0, 0), -- Coilfang Tempest
(21127, 547, 3, 1, -114.4843, -592.073, 6.581903, 6.161012, 7200, 0, 0), -- Coilfang Tempest
(21127, 547, 3, 1, -197.8177, -765.5336, 42.99123, 4.607836, 7200, 3, 1), -- Coilfang Tempest
(21127, 547, 3, 1, -168.9964, -778.1722, 42.36605, 0.5759587, 7200, 3, 1), -- Coilfang Tempest
(17942, 547, 3, 1, -281.0958, -667.1385, 9.402116, 5.846853, 7200, 0, 0); -- Quagmirran



insert into `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) values
('17959','547','3','1','0','0','-97.774','-109.2','20.2306','1.49643','86400','0','0','0','0','2','0','0','0'),
('17959','547','3','1','0','0','-71.858','-16.172','-4.7298','5.70353','86400','0','0','0','0','2','0','0','0'),
('17959','547','3','1','0','0','-41.1192','-1.00841','-1.38881','1.69853','86400','0','0','0','0','2','0','0','0'),
('17959','547','3','1','0','0','-78.8031','-198.368','-3.30045','1.27724','86400','0','0','0','0','2','0','0','0'),
('17959','547','3','1','0','0','-54.3411','-251.294','-3.37616','3.27301','86400','0','0','0','0','2','0','0','0'),
('17959','547','3','1','0','0','-77.7076','-282.609','-1.24249','4.19428','86400','0','0','0','0','2','0','0','0'),
('17941','547','3','1','0','0','127.752','-379.932','30.4546','3.17405','86400','0','0','0','0','2','0','0','0'),
('21128','547','3','1','0','0','-72.7437','-553.587','-0.803235','1.35787','86400','1','0','0','0','1','0','0','0'),
('21128','547','3','1','0','0','-131.436','-138.875','-1.92874','5.59713','86400','1','0','0','0','1','0','0','0'),
('21128','547','3','1','0','0','-123.412','-596.11','9.09754','6.15645','86400','1','0','0','0','1','0','0','0'),
('21128','547','3','1','0','0','-87.7426','-507.42','-1.59256','1.01829','86400','1.6','0','0','0','1','0','0','0'),
('17991','547','3','1','0','0','23.9','-447.261','3.03544','3.3803','86400','0','0','0','0','2','0','0','0'),
('25697','547','1','1','0','0','-92.45','-110.66','-2.866','4.5618','86400','0','0','0','0','0','0','0','0'),
('25754','547','1','1','0','0','-127.463','-130.762','-2.06541','4.90899','86400','0','0','0','0','0','0','0','0'),
('25754','547','1','1','0','0','-141.138','-136.834','-1.59055','5.24279','86400','0','0','0','0','0','0','0','0'),
('25754','547','1','1','0','0','-136.327','-132.425','-1.80894','5.06608','86400','0','0','0','0','0','0','0','0'),
('25961','547','1','1','0','0','-138.054','-139.024','-1.67183','5.04643','86400','0','0','0','0','0','0','0','0'),
('25961','547', '1','1','0','0','-131.929','-135.194','-1.94897','4.99538','86400','0','0','0','0','0','0','0','0'),
('25952','547', '3','1','0','0','-69.839','-162.474','-2.30365','2.51327','86400','0','0','0','0','0','0','0','0'),
('25952','547', '3','1','0','0','-97.4688','-231.198','-2.10893','1.46608','86400','0','0','0','0','0','0','0','0'),
('25745','547', '3','1','0','0','-96.6415','-230.886','4.78096','1.41372','86400','0','0','0','0','0','0','0','0'),
('25746','547', '3','1','0','0','-96.8723','-212.842','-1.14914','4.15388','86400','0','0','0','0','0','0','0','0'),
('54667','547', '3','1','0','0','135.15','-113.508','-1.50723','3.92699','86400','0','0','0','0','0','0','0','0'),
('54668','547', '3','1','0','0','130.109','-104.872','-1.50723','2.67035','86400','0','0','0','0','0','0','0','0'),
('26120','547', '3','1','0','0','-98.1029','-230.786','-10.8085','1.44862','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-100.563','-196.444','-1.31891','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-101.459','-169.614','-2.32086','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-99.3975','-174.808','-2.48351','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-97.9865','-202.805','-1.11239','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-97.3549','-192.603','-1.59374','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-97.8473','-185.715','-1.86221','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-89.4828','-197.786','-1.62742','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-82.9852','-189.272','7.6672','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-98.6159','-164.908','-2.4994','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-93.8235','-196.603','-1.34138','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-102.528','-178.276','-2.08858','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-108.463','-189.883','-1.54006','1.79769','86400','0','0','0','0','0','0','0','0'),
('26230','547', '3','1','0','0','-98.8607','-233.753','8.37293','2.75762','86400','0','0','0','0','0','0','0','0'),
('40446','547', '3','1','0','0','-76.9917','-157.081','-2.10639','5.63741','86400','0','0','0','0','0','0','0','0'),
('26121','547', '3','1','0','0','-69.812','-162.495','-2.30451','1.71042','86400','0','0','0','0','0','0','0','0'),
('26190','547', '3','1','0','0','-95.3357','-207.483','16.2874','4.90438','86400','0','0','0','0','0','0','0','0'),
('25740','547', '3','1','0','0','-99.1021','-233.753','-1.22297','1.52907','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-105.467','-172.523','-2.02007','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-97.9889','-184.025','-1.96084','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-109.135','-174.916','-1.77931','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-99.8656','-199.061','-1.25568','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-82.6681','-202.088','-2.65235','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-105.199','-191.39','-1.54038','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-97.3219','-207.037','-1.1294','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-105.301','-181.586','-1.82538','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-107.894','-178.196','-1.78434','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-101.072','-200.237','-1.221','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-94.5296','-188.501','-1.84028','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-108.278','-180.761','-1.74661','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-101.512','-203.16','-1.15893','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-109.82','-193.46','-1.36308','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-103.898','-184.876','-1.78344','1.79769','86400','0','0','0','0','0','0','0','0'),
('25985','547', '3','1','0','0','-96.0734','-196.617','-1.3306','1.79769','86400','0','0','0','0','0','0','0','0'),
('16606','547', '3','1','0','0','-89.8605','-113.449','-2.33038','2.61799','86400','0','0','0','0','0','0','0','0'),
('16606','547', '3','1','0','0','-114.746','-117.227','-2.4447','1.16937','86400','0','0','0','0','0','0','0','0'),
('25971','547', '3','1','0','0','-143.172','-147.68','-3.16113','4.85202','86400','0','0','0','0','0','0','0','0'),
('25972','547', '3','1','0','0','-134.304','-145.78','-1.70332','4.67748','86400','0','0','0','0','0','0','0','0'),
('25973','547', '3','1','0','0','-125.036','-144.207','-1.9166','4.99164','86400','0','0','0','0','0','0','0','0'),
('25710','547', '3','1','0','0','132.721','-116.256','-1.59053','3.85833','86400','0','0','0','0','0','0','0','0'),
('24320','547', '3','1','0','0','127.745','-109.161','-1.54947','2.75656','86400','0','0','0','0','0','0','0','0'),
('24320','547', '3','1','0','0','-92.4903','-123.935','-1.67876','4.74753','86400','0','0','0','0','0','0','0','0'),
('24320','547', '3','1','0','0','-97.9888','-122.327','-1.92884','4.18204','86400','0','0','0','0','0','0','0','0'),
('24320','547', '3','1','0','0','128.56','-104.269','-1.59038','2.67802','86400','0','0','0','0','0','0','0','0');

UPDATE `creature_template` SET `AIName` = '', `ScriptName`= 'boss_mennu_the_betrayer' WHERE entry=17991;
UPDATE `creature_template` SET `AIName` = '', `ScriptName`= 'boss_rokmar_the_crackler' WHERE entry=17991;

UPDATE `creature_template` SET `AIName` = '', `ScriptName`= 'boss_mennu_the_betrayer' WHERE entry=17941;
UPDATE `creature_template` SET `AIName` = '', `ScriptName`= 'boss_quagmirran' WHERE entry=17942;

-- Add missing spelldifficulty_dbc values
DELETE FROM `spelldifficulty_dbc` WHERE `id` IN (31956,34780);
INSERT INTO `spelldifficulty_dbc` (`id`,`spellid0`,`spellid1`) VALUES
(31956,31956,39005), -- Rokmar the Crackler
(34780,34780,39340); -- Quagmirran
