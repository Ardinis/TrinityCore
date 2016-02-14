


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
(31125, 0, 0, 0),
-- emalon
(33993, 0, 0, 0),
-- Koralon
(35013, 0, 0, 0),
-- Toravon
(38433, 0, 0, 0),

-- Naxxramas
-- Anub'Rekhan
(15956, 0, 0, 0),
-- Grande veuve Faerlina
(15953, 0, 0, 0),
-- Maexxna
(15952, 0, 0, 0),
-- noth-le-porte-peste
(15954, 0, 0, 0),
-- Heigan l'Impur
(15936, 0, 0, 0),
-- horreb
(16011, 0, 0, 0),
-- instructeur-razuvious
(16061, 0, 0, 0),
-- gothik-le-moissonneur
(16060, 0, 0, 0),
-- le-recousu
(16028, 0, 0, 0),
-- grobbulus
(15931, 0, 0, 0),
-- gluth
(15932, 0, 0, 0),
-- thaddius
(15928, 0, 0, 0),
-- saphiron
(15989, 0, 0, 0),
-- kelthuzad
(15990, 0, 0, 0),


-- le-sanctum-obsidien
-- Sartharion <Le gardien d'Onyx>
(28860, 0, 0, 0),

-- L’Œil de l’éternité
-- malygos
(28859, 0, 0, 0),

-- ulduar
-- leviathan-des-flammes
(33113, 0, 0, 0),
-- ignis-le-maitre-de-la-fournaise
(33118, 0, 0, 0),
-- tranchecaille
(33186, 0, 0, 0),
-- deconstructeur-xt-002
(33293, 0, 0, 0),
-- mande-foudre-brundir
(32857, 0, 0, 0),
-- kologarn
(32930, 0, 0, 0),
-- auriaya
(33515, 0, 0, 0),
-- freya
(32906, 0, 0, 0),
-- hodir
(32845, 0, 0, 0),
-- mimiron
(33350, 0, 0, 0),
-- thorim
(32865, 0, 0, 0),
-- general-vezax
(33271, 0, 0, 0),
-- yogg-saron
(33288, 0, 0, 0),
-- algalon-lobservateur
(32871, 0, 0, 0),

-- repaire-d-onyxia
-- onyxia
(10184, 0, 0, 0),

-- l-epreuve-du-croise
-- glace-hurlante
(34797, 0, 0, 0),
-- seigneur-jaraxxus
(34780, 0, 0, 0),
-- fjola-plaie-lumineuse
(34497, 0, 0, 0),
-- eydis-plaie-sombre
(34496, 0, 0, 0),
-- anubarak
(34564, 0, 0, 0),

-- citadelle-de-la-couronne-de-glace
-- seigneur-gargamoelle
(36612, 0, 0, 0),
-- dame-murmemort
(36855, 0, 0, 0),
-- porte-mort-saurcroc
(37813, 0, 0, 0),
-- pulentraille
(36626, 0, 0, 0),
-- trognepus
(36627, 0, 0, 0),
-- professeur-putricide
(36678, 0, 0, 0),
-- prince-valanar
(37970, 0, 0, 0),
-- reine-de-sang-lanathel
(37955, 0, 0, 0),
-- valithria-marchereve
-- (36789, 0, 0, 0),
-- sindragosa
(36853, 0, 0, 0),
-- le-roi-liche
(36597, 1, 0, 0),

-- le-sanctum-rubis
-- halion
(39863, 0, 0, 0);


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
