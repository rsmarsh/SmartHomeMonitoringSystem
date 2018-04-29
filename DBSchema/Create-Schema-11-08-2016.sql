-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema PiSmartHome
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema PiSmartHome
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PiSmartHome` DEFAULT CHARACTER SET utf8 ;
USE `PiSmartHome` ;

-- -----------------------------------------------------
-- Table `PiSmartHome`.`Climate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PiSmartHome`.`Climate` ;

CREATE TABLE IF NOT EXISTS `PiSmartHome`.`Climate` (
  `record_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `time` TIME NOT NULL,
  `temp_c` DECIMAL(3,1) NOT NULL,
  `temp_f` DECIMAL(3,1) NOT NULL,
  `humidity` INT(3) NOT NULL,
  UNIQUE INDEX `record_id_UNIQUE` (`record_id` ASC),
  PRIMARY KEY (`record_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PiSmartHome`.`Movements`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PiSmartHome`.`Movements` ;

CREATE TABLE IF NOT EXISTS `PiSmartHome`.`Movements` (
  `movement_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `time` TIME NOT NULL,
  `room` VARCHAR(45) NOT NULL,
  `area` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`movement_id`),
  UNIQUE INDEX `movement_id_UNIQUE` (`movement_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PiSmartHome`.`Gas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PiSmartHome`.`Gas` ;

CREATE TABLE IF NOT EXISTS `PiSmartHome`.`Gas` (
  `detection_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `time` TIME NOT NULL,
  PRIMARY KEY (`detection_id`),
  UNIQUE INDEX `detection_id_UNIQUE` (`detection_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PiSmartHome`.`Checkins`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PiSmartHome`.`Checkins` ;

CREATE TABLE IF NOT EXISTS `PiSmartHome`.`Checkins` (
  `checkin_id` INT NOT NULL AUTO_INCREMENT,
  `guest_id` INT(5) NOT NULL,
  `date` DATE NOT NULL,
  `time` TIME NOT NULL,
  PRIMARY KEY (`checkin_id`),
  UNIQUE INDEX `checkin_id_UNIQUE` (`checkin_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PiSmartHome`.`Guests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PiSmartHome`.`Guests` ;

CREATE TABLE IF NOT EXISTS `PiSmartHome`.`Guests` (
  `guest_id` INT(5) NOT NULL AUTO_INCREMENT,
  `nfc_tag_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(60) NOT NULL,
  `relationship_to_person` VARCHAR(160) NULL,
  `restricted_access` TINYINT(1) NOT NULL,
  `entry_allowed_from` TIME NULL,
  `entry_allowed_to` TIME NULL,
  PRIMARY KEY (`guest_id`),
  UNIQUE INDEX `guest_id_UNIQUE` (`guest_id` ASC))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `PiSmartHome`.`Climate`
-- -----------------------------------------------------
START TRANSACTION;
USE `PiSmartHome`;
INSERT INTO `PiSmartHome`.`Climate` (`record_id`, `date`, `time`, `temp_c`, `temp_f`, `humidity`) VALUES (DEFAULT, '2012-04-12', '12:25:00', 20.0, 67.4, 56);
INSERT INTO `PiSmartHome`.`Climate` (`record_id`, `date`, `time`, `temp_c`, `temp_f`, `humidity`) VALUES (DEFAULT, '2013-04-17', '13:22:00', 15.0, 60.4, 40);

COMMIT;


-- -----------------------------------------------------
-- Data for table `PiSmartHome`.`Movements`
-- -----------------------------------------------------
START TRANSACTION;
USE `PiSmartHome`;
INSERT INTO `PiSmartHome`.`Movements` (`movement_id`, `date`, `time`, `room`, `area`) VALUES (DEFAULT, '2015-12-24', '12:40', 'Kitchen', 'Oven');

COMMIT;


-- -----------------------------------------------------
-- Data for table `PiSmartHome`.`Gas`
-- -----------------------------------------------------
START TRANSACTION;
USE `PiSmartHome`;
INSERT INTO `PiSmartHome`.`Gas` (`detection_id`, `date`, `time`) VALUES (DEFAULT, '2013-03-13', '09:30');

COMMIT;


-- -----------------------------------------------------
-- Data for table `PiSmartHome`.`Checkins`
-- -----------------------------------------------------
START TRANSACTION;
USE `PiSmartHome`;
INSERT INTO `PiSmartHome`.`Checkins` (`checkin_id`, `guest_id`, `date`, `time`) VALUES (DEFAULT, 3, '2014-03-14', '05:50');

COMMIT;


-- -----------------------------------------------------
-- Data for table `PiSmartHome`.`Guests`
-- -----------------------------------------------------
START TRANSACTION;
USE `PiSmartHome`;
INSERT INTO `PiSmartHome`.`Guests` (`guest_id`, `nfc_tag_id`, `name`, `relationship_to_person`, `restricted_access`, `entry_allowed_from`, `entry_allowed_to`) VALUES (1, '0', 'Guest', 'N/A', 0, NULL, NULL);
INSERT INTO `PiSmartHome`.`Guests` (`guest_id`, `nfc_tag_id`, `name`, `relationship_to_person`, `restricted_access`, `entry_allowed_from`, `entry_allowed_to`) VALUES (2, '1231312', 'Richard Marshall', 'Home Owner', 0, NULL, NULL);
INSERT INTO `PiSmartHome`.`Guests` (`guest_id`, `nfc_tag_id`, `name`, `relationship_to_person`, `restricted_access`, `entry_allowed_from`, `entry_allowed_to`) VALUES (3, '411283', 'Dr. Bradley', 'Nurse', 1, '13:00:00', '16:00:00');

COMMIT;

