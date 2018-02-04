-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mini_qlims
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mini_qlims` ;

-- -----------------------------------------------------
-- Schema mini_qlims
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mini_qlims` DEFAULT CHARACTER SET utf8 ;
USE `mini_qlims` ;

-- -----------------------------------------------------
-- Table `mini_qlims`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_qlims`.`country` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_qlims`.`region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_qlims`.`region` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_region_country1_idx` (`country_id` ASC),
  CONSTRAINT `fk_region_country1`
    FOREIGN KEY (`country_id`)
    REFERENCES `mini_qlims`.`country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_qlims`.`contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_qlims`.`contact` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `region_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_contact_region1_idx` (`region_id` ASC),
  CONSTRAINT `fk_contact_region1`
    FOREIGN KEY (`region_id`)
    REFERENCES `mini_qlims`.`region` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_qlims`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_qlims`.`user` (
  `id` INT NOT NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `role` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_qlims`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_qlims`.`client` (
  `id` INT NOT NULL,
  `contact_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_client_contact1_idx` (`contact_id` ASC),
  INDEX `fk_client_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_client_contact1`
    FOREIGN KEY (`contact_id`)
    REFERENCES `mini_qlims`.`contact` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mini_qlims`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_qlims`.`request`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_qlims`.`request` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(45) NULL,
  `status` VARCHAR(45) NULL,
  `submitter_id` INT NOT NULL,
  `other_id` INT NOT NULL,
  `client_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_request_contact1_idx` (`submitter_id` ASC),
  INDEX `fk_request_contact2_idx` (`other_id` ASC),
  INDEX `fk_request_client1_idx` (`client_id` ASC),
  CONSTRAINT `fk_request_contact1`
    FOREIGN KEY (`submitter_id`)
    REFERENCES `mini_qlims`.`contact` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_request_contact2`
    FOREIGN KEY (`other_id`)
    REFERENCES `mini_qlims`.`contact` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_request_client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `mini_qlims`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_qlims`.`test_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_qlims`.`test_type` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_qlims`.`sample_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_qlims`.`sample_type` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_qlims`.`unit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_qlims`.`unit` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_qlims`.`sample`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_qlims`.`sample` (
  `id` INT NOT NULL,
  `request_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `test_type_id` INT NOT NULL,
  `sample_type_id` INT NOT NULL,
  `qty` VARCHAR(45) NULL,
  `unit_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sample_request_idx` (`request_id` ASC),
  INDEX `fk_sample_test_type1_idx` (`test_type_id` ASC),
  INDEX `fk_sample_sample_type1_idx` (`sample_type_id` ASC),
  INDEX `fk_sample_unit1_idx` (`unit_id` ASC),
  CONSTRAINT `fk_sample_request`
    FOREIGN KEY (`request_id`)
    REFERENCES `mini_qlims`.`request` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sample_test_type1`
    FOREIGN KEY (`test_type_id`)
    REFERENCES `mini_qlims`.`test_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sample_sample_type1`
    FOREIGN KEY (`sample_type_id`)
    REFERENCES `mini_qlims`.`sample_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sample_unit1`
    FOREIGN KEY (`unit_id`)
    REFERENCES `mini_qlims`.`unit` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_qlims`.`test_type_has_sample_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_qlims`.`test_type_has_sample_type` (
  `test_type_id` INT NOT NULL,
  `sample_type_id` INT NOT NULL,
  PRIMARY KEY (`test_type_id`, `sample_type_id`),
  INDEX `fk_test_type_has_sample_type_sample_type1_idx` (`sample_type_id` ASC),
  INDEX `fk_test_type_has_sample_type_test_type1_idx` (`test_type_id` ASC),
  CONSTRAINT `fk_test_type_has_sample_type_test_type1`
    FOREIGN KEY (`test_type_id`)
    REFERENCES `mini_qlims`.`test_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_test_type_has_sample_type_sample_type1`
    FOREIGN KEY (`sample_type_id`)
    REFERENCES `mini_qlims`.`sample_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_qlims`.`counter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_qlims`.`counter` (
  `id` INT NOT NULL,
  `type` VARCHAR(45) NULL,
  `counter` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mini_qlims`.`barcode_printer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mini_qlims`.`barcode_printer` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
