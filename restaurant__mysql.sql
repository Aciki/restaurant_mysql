-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.11-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.1.0.6179
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for restoran
CREATE DATABASE IF NOT EXISTS `restoran` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `restoran`;

-- Dumping structure for table restoran.evidencija_rabotno_vreme
CREATE TABLE IF NOT EXISTS `evidencija_rabotno_vreme` (
  `vreme_od` time NOT NULL,
  `vreme_do` time NOT NULL,
  `dataa` date NOT NULL,
  `vraboteni_id` tinyint(2) unsigned NOT NULL,
  KEY `FK_evidencija_rabotno vreme_vraboteni` (`vraboteni_id`),
  KEY `FK_evidencija_rabotno_vreme_promet` (`dataa`),
  CONSTRAINT `FK_evidencija_rabotno vreme_vraboteni` FOREIGN KEY (`vraboteni_id`) REFERENCES `vraboteni` (`vraboteni_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table restoran.izlez_fiskalna
CREATE TABLE IF NOT EXISTS `izlez_fiskalna` (
  `proizvod_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dataa` date DEFAULT NULL,
  `kolicina` int(10) unsigned NOT NULL,
  `sifra` int(10) unsigned NOT NULL,
  KEY `FK1_magacin` (`proizvod_id`),
  KEY `FK2_promet` (`dataa`),
  KEY `FK2_magacin` (`sifra`),
  CONSTRAINT `FK2_magacin` FOREIGN KEY (`sifra`) REFERENCES `magacin` (`sifra`) ON UPDATE CASCADE,
  CONSTRAINT `FK2_promet` FOREIGN KEY (`dataa`) REFERENCES `promet` (`dataa`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table restoran.magacin
CREATE TABLE IF NOT EXISTS `magacin` (
  `proizvod_id` int(10) unsigned NOT NULL,
  `ime_proizvod` char(50) NOT NULL,
  `Nabavna_cena` int(11) NOT NULL,
  `kolicina` int(10) unsigned NOT NULL,
  `Prodazna_cena` int(10) unsigned NOT NULL,
  `dataa` date NOT NULL,
  `br_faktura` varchar(50) DEFAULT NULL,
  `cena_bez_ddv` int(11) DEFAULT NULL,
  `sifra` int(10) unsigned NOT NULL,
  PRIMARY KEY (`proizvod_id`),
  KEY `FK1_vlez` (`br_faktura`),
  KEY `proizvodi` (`sifra`),
  CONSTRAINT `FK1_vlez` FOREIGN KEY (`br_faktura`) REFERENCES `vlez` (`br_faktura`) ON UPDATE CASCADE,
  CONSTRAINT `proizvodi` FOREIGN KEY (`sifra`) REFERENCES `proizvodi` (`sifra`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table restoran.pocetna_sostojba
CREATE TABLE IF NOT EXISTS `pocetna_sostojba` (
  `proizvod_id` int(10) unsigned NOT NULL,
  `ime_proizvod` char(50) NOT NULL,
  `kolicina` int(10) unsigned NOT NULL,
  `dataa` date NOT NULL,
  `sifra` int(10) unsigned NOT NULL,
  PRIMARY KEY (`dataa`) USING BTREE,
  UNIQUE KEY `Index 2` (`proizvod_id`),
  CONSTRAINT `FK_pocetna_sostojba_magacin` FOREIGN KEY (`proizvod_id`) REFERENCES `magacin` (`proizvod_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table restoran.polls_choice
CREATE TABLE IF NOT EXISTS `polls_choice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `choice_text` varchar(200) NOT NULL,
  `votes` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `polls_choice_question_id_c5b4b260_fk_polls_question_id` (`question_id`),
  CONSTRAINT `polls_choice_question_id_c5b4b260_fk_polls_question_id` FOREIGN KEY (`question_id`) REFERENCES `polls_question` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table restoran.polls_question
CREATE TABLE IF NOT EXISTS `polls_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_text` varchar(200) NOT NULL,
  `pub_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table restoran.proizvodi
CREATE TABLE IF NOT EXISTS `proizvodi` (
  `ime_proizvod` varchar(50) NOT NULL,
  `sifra` int(10) unsigned NOT NULL,
  PRIMARY KEY (`sifra`),
  UNIQUE KEY `Index 2` (`ime_proizvod`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table restoran.promet
CREATE TABLE IF NOT EXISTS `promet` (
  `dataa` date NOT NULL,
  `Den` char(10) NOT NULL DEFAULT '',
  `Prva_smena` mediumint(8) unsigned NOT NULL,
  `Vtora_smena` mediumint(8) unsigned NOT NULL,
  `vraboteni_id` tinyint(2) unsigned NOT NULL,
  PRIMARY KEY (`dataa`),
  KEY `FK1_evidencija` (`vraboteni_id`),
  CONSTRAINT `FK1_evidencija` FOREIGN KEY (`vraboteni_id`) REFERENCES `evidencija_rabotno_vreme` (`vraboteni_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table restoran.vlez
CREATE TABLE IF NOT EXISTS `vlez` (
  `br_faktura` varchar(50) NOT NULL,
  `iznos_bez_ddv` float unsigned DEFAULT NULL,
  `Iznos` float NOT NULL,
  `data` date DEFAULT NULL,
  PRIMARY KEY (`br_faktura`),
  UNIQUE KEY `Index 2` (`br_faktura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table restoran.vraboteni
CREATE TABLE IF NOT EXISTS `vraboteni` (
  `vraboteni_id` tinyint(2) unsigned NOT NULL AUTO_INCREMENT,
  `pozicija` char(20) NOT NULL,
  `prezime` char(30) NOT NULL,
  `telefon` int(10) unsigned DEFAULT NULL,
  `ime` char(15) NOT NULL,
  `maticen` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`vraboteni_id`),
  UNIQUE KEY `Index 2` (`maticen`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for procedure restoran._delete
DELIMITER //
CREATE PROCEDURE `_delete`(
	IN `table_name` VARCHAR(30),
	IN `pk_value` INT
)
BEGIN

declare _pk_id varchar(50);
declare _pk_value int;
declare _table_name varchar(30);

set _pk_id   		= '';
set _pk_value  	= pk_value;
set _table_name 	= table_name;

CASE _table_name
	WHEN 'evidencija_rabotno_vreme' 	THEN  set _pk_id='vraboteni_id';
	WHEN 'magacin'							THEN  set _pk_id='proizvod_id';
	WHEN 'promet'							THEN  set _pk_id='dataa';
	WHEN 'vlez' 							THEN  set _pk_id='br_faktura';
	WHEN 'vraboteni' 						THEN  set _pk_id='vraboteni_id';
	WHEN 'proizvodi' 						THEN  set _pk_id='sifra';
	
	END case ;

set @sql= concat("delete from ",_table_name," where ", _pk_id ," = ", _pk_value);
PREPARE stmt FROM @sql;
EXECUTE stmt;
END//
DELIMITER ;

-- Dumping structure for procedure restoran._dospeva
DELIMITER //
CREATE PROCEDURE `_dospeva`()
BEGIN
 SELECT CURRENT_TIMESTAMP AS denes ,  `data` ,   DATE_ADD(`data`, INTERVAL 3 month) AS dospeva  from 
vlez  WHERE 'denes' < 'dospeva' GROUP BY `data` desc;
END//
DELIMITER ;

-- Dumping structure for procedure restoran._insert_all
DELIMITER //
CREATE PROCEDURE `_insert_all`(
	IN `_tableName` VARCHAR(50),
	IN `_values` TEXT
)
BEGIN

DECLARE koloni_ VARCHAR(50);
declare values_ TEXT;

SET values_=_values;
SET koloni_ = ' ';

case _tableName
when "evidencija_rabotno_vreme" then SET  koloni_ = " vreme_od ,vreme_do ,dataa, vraboteni_id ";
when "promet" then SET koloni_=" dataa, Den , Prva_smena , Vtora_smena , vraboteni_id ";
when "izlez_fiskalna" then SET koloni_= " proizvod_id ,  kolicina ,  dataa , sifra";
when "vraboteni" then SET koloni_= "  pozicija , prezime , telefon ,ime ,maticen ";
when "magacin" then SET koloni_ = "proizvod_id , ime_proizvod , Nabavna_cena ,  kolicina ,  Prodazna_cena , dataa , br_faktura , cena_bez_ddv , sifra ";
when "pocetna_sostoba " then SET koloni_ = "proizvod_id ,  ime_proizvod , kolicina , dataa , sifra " ;
when "vlez" then  SET koloni_ = "br_faktura , iznos_bez_ddv , Iznos " ;
when "proizvodi" then  SET koloni_ = "sifra,ime_proizvod " ;

END case ;


SET @SQL = CONCAT("INSERT INTO ", _tableName," ( ",koloni_,") VALUES (",values_,")");
PREPARE stmt FROM @SQL;
EXECUTE stmt;
END//
DELIMITER ;

-- Dumping structure for procedure restoran._Promet_po_datum
DELIMITER //
CREATE PROCEDURE `_Promet_po_datum`(
	IN `text_` TEXT
)
BEGIN 

DECLARE _text TEXT;
SET _text = text_;

SET @SQL = CONCAT("SELECT (SUM(promet.Prva_smena)+SUM(promet.Vtora_smena)) as promet_po_data ,promet.dataa , Den
FROM promet
WHERE promet.dataa BETWEEN" ,_text  );

PREPARE stmt FROM @SQL ;
EXECUTE stmt ;

END//
DELIMITER ;

-- Dumping structure for procedure restoran._prosecen_promet
DELIMITER //
CREATE PROCEDURE `_prosecen_promet`(
	IN `text_` TEXT
)
BEGIN 

DECLARE _text TEXT;
SET _text = text_;

SET @SQL = CONCAT("SELECT (SUM(promet.Prva_smena)+SUM(promet.Vtora_smena)) / COUNT(dataa) AS 'prosecen promet',promet.dataa , Den
FROM promet
WHERE promet.dataa BETWEEN" ,_text ," group by Den " );

PREPARE stmt FROM @SQL ;
EXECUTE stmt ;

END//
DELIMITER ;

-- Dumping structure for procedure restoran._update
DELIMITER //
CREATE PROCEDURE `_update`(
	IN `table_name_` VARCHAR(50),
	IN `columns_` TEXT,
	IN `pk_value` INT
)
BEGIN


DECLARE _columns TEXT;
DECLARE _pk_name VARCHAR(50) ;
DECLARE _table_name VARCHAR(50);
DECLARE pk_value_ INT ;

SET _columns = columns_;
SET pk_value_ = pk_value ;
SET _table_name = table_name_;

case _table_name
	when "evidencija_rabotno_vre" then SET _pk_name = "vraboteni_id";
	when "magacin" then SET _pk_name = "proizvod_id";
	when "promet" then SET _pk_name = "dataa";
	when "vlez" then SET _pk_name = "br_faktura";
	when "vraboteni" then SET _pk_name = "vraboteni_id" ;
	when "proizvodi" then SET _pk_name = "sifra" ;
END case ;

SET @SQL = CONCAT("update " , _table_name , " set ",_columns,"where ", _pk_name ," = " , pk_value_ );
PREPARE stmt FROM @SQL;
EXECUTE stmt;

END//
DELIMITER ;

-- Dumping structure for procedure restoran._Zaliha
DELIMITER //
CREATE PROCEDURE `_Zaliha`()
BEGIN
SELECT magacin.ime_proizvod , (SUM(magacin.kolicina) -
 (case when izlez_fiskalna.kolicina IS null then 0 else SUM(izlez_fiskalna.kolicina) END ))
 


 AS ostanato, 
 
 ((SUM(magacin.kolicina) -
 (case when izlez_fiskalna.kolicina IS null then 0 else SUM(izlez_fiskalna.kolicina) END )) * magacin.Nabavna_cena) AS vk_nabavna ,
 ((SUM(magacin.kolicina) -
 (case when izlez_fiskalna.kolicina IS null then 0 else SUM(izlez_fiskalna.kolicina) END )) * magacin.Prodazna_cena) AS vk_prodazna ,
 (
 ((SUM(magacin.kolicina) -
 (case when izlez_fiskalna.kolicina IS null then 0 else SUM(izlez_fiskalna.kolicina) END )) * magacin.Prodazna_cena) -
 ((SUM(magacin.kolicina) -
 (case when izlez_fiskalna.kolicina IS null then 0 else SUM(izlez_fiskalna.kolicina) END )) * magacin.Nabavna_cena) ) AS profit
 
 
 
 
  FROM magacin
left JOIN izlez_fiskalna
ON magacin.proizvod_id = izlez_fiskalna.proizvod_id
INNER JOIN proizvodi
ON proizvodi.sifra=magacin.sifra
GROUP BY magacin.sifra
ORDER by ostanato ASC;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
