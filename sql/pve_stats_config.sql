


DROP TABLE IF EXISTS `pvestats_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pvestats_config` (
  `entry` INT(10) UNSIGNED NOT NULL,
  `extra_point` INT(10) UNSIGNED NOT NULL,
  `map_id` INT(10) UNSIGNED NOT NULL,
  `difficulty` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO pvestats_config VALUES
-- caveau archavon
-- archavon
(31125, 1, 4603, 0),
-- emalon
(33993, 1, 4603, 0),
-- Koralon
(35013, 1, 4603, 0),
-- Toravon
(38433, 1, 4603, 0),

-- Naxxramas
-- Anub'Rekhan
(15956, 1, 3456, 0),
-- Grande veuve Faerlina
(15953, 1, 3456, 0),
-- Maexxna
(15952, 1, 3456, 0),
-- noth-le-porte-peste
(15954, 1, 3456, 0),
-- Heigan l'Impur
(15936, 1, 3456, 0),
-- horreb
(16011, 1, 3456, 0),
-- instructeur-razuvious
(16061, 1, 3456, 0),
-- gothik-le-moissonneur
(16060, 1, 3456, 0),
-- le-recousu
(16028, 1, 3456, 0),
-- grobbulus
(15931, 1, 3456, 0),
-- gluth
(15932, 1, 3456, 0),
-- thaddius
(15928, 1, 3456, 0),
-- saphiron
(15989, 1, 3456, 0),
-- kelthuzad
(15990, 1, 3456, 0),


-- le-sanctum-obsidien
-- Sartharion <Le gardien d'Onyx>
(28860, 1, 4493, 0),

-- L’Œil de l’éternité
-- malygos
(28859, 1, 4500, 0),

-- ulduar
-- leviathan-des-flammes
(33113, 2, 4273, 0),
-- ignis-le-maitre-de-la-fournaise
(33118, 2, 4273, 0),
-- tranchecaille
(33186, 2, 4273, 0),
-- deconstructeur-xt-002
(33293, 2, 4273, 0),
-- mande-foudre-brundir
(32857, 2, 4273, 0),
-- kologarn
(32930, 2, 4273, 0),
-- auriaya
(33515, 2, 4273, 0),
-- freya
(32906, 2, 4273, 0),
-- hodir
(32845, 2, 4273, 0),
-- mimiron
(33350, 2, 4273, 0),
-- thorim
(32865, 2, 4273, 0),
-- general-vezax
(33271, 2, 4273, 0),
-- yogg-saron
(33288, 2, 4273, 0),
-- algalon-lobservateur
(32871, 2, 4273, 0),

-- repaire-d-onyxia
-- onyxia
(10184, 1, 2159, 0),

-- l-epreuve-du-croise
-- glace-hurlante
(34797, 2, 4722, 0),
-- seigneur-jaraxxus
(34780, 2, 4722, 0),
-- fjola-plaie-lumineuse
(34497, 2, 4722, 0),
-- eydis-plaie-sombre
(34496, 2, 4722, 0),
-- anubarak
(34564, 3, 4722, 0),

-- citadelle-de-la-couronne-de-glace
-- seigneur-gargamoelle
(36612, 3, 4812, 0),
-- dame-murmemort
(36855, 3, 4812, 0),
-- porte-mort-saurcroc
(37813, 3, 4812, 0),
-- pulentraille
(36626, 3, 4812, 0),
-- trognepus
(36627, 3, 4812, 0),
-- professeur-putricide
(36678, 3, 4812, 0),
-- prince-valanar
(37970, 3, 4812, 0),
-- reine-de-sang-lanathel
(37955, 3, 4812, 0),
-- valithria-marchereve
-- (36789, 0, 0, 0),
-- sindragosa
(36853, 3, 4812, 0),
-- le-roi-liche
(36597, 4, 4812, 0),

-- le-sanctum-rubis
-- halion
(39863, 4, 4987, 0);


DROP TABLE IF EXISTS `pvestats_guild`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pvestats_guild` (
  `id` BIGINT(20) UNSIGNED NOT NULL,
  `guild_id` INT(10) UNSIGNED NOT NULL,
  `boss_entry` INT(10) UNSIGNED  NOT NULL,
  `kill_timer`  BIGINT(20) UNSIGNED NOT NULL,
  `death_count` INT(10) UNSIGNED  NOT NULL,
  `difficulty` INT(10) UNSIGNED  NOT NULL,
   `date` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
