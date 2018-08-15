-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema exchg
-- -----------------------------------------------------
-- Mini stock exchg database schema

-- -----------------------------------------------------
-- Schema exchg
--
-- Mini stock exchg database schema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `exchg` DEFAULT CHARACTER SET utf8 ;
USE `exchg` ;

-- -----------------------------------------------------
-- Table `exchg`.`cpy_lst`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exchg`.`cpy_lst` (
  `r_k` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cpy_id` VARCHAR(10) NOT NULL,
  `cpy_bgt` DECIMAL(5,2) NOT NULL,
  `bid_prc` DECIMAL(5,2) NOT NULL,
  `lst_upd` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`r_k`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exchg`.`cat_lst`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exchg`.`cat_lst` (
  `r_k` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cat_nme` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`r_k`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exchg`.`cty_lst`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exchg`.`cty_lst` (
  `r_k` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cty_nme` VARCHAR(50) NOT NULL,
  `cty_cde` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`r_k`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exchg`.`cpy_cty_lst`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exchg`.`cpy_cty_lst` (
  `cpy_lst_r_k` INT UNSIGNED NOT NULL,
  `cty_lst_r_k` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`cpy_lst_r_k`, `cty_lst_r_k`),
  INDEX `fk_cty_lst_has_cpy_lst_cpy_lst1_idx` (`cpy_lst_r_k` ASC),
  INDEX `fk_cty_lst_has_cpy_lst_cty_lst_idx` (`cty_lst_r_k` ASC),
  CONSTRAINT `fk_cty_lst_has_cpy_lst_cty_lst`
    FOREIGN KEY (`cty_lst_r_k`)
    REFERENCES `exchg`.`cty_lst` (`r_k`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cty_lst_has_cpy_lst_cpy_lst1`
    FOREIGN KEY (`cpy_lst_r_k`)
    REFERENCES `exchg`.`cpy_lst` (`r_k`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exchg`.`cpy_cat_lst`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exchg`.`cpy_cat_lst` (
  `cpy_lst_r_k` INT UNSIGNED NOT NULL,
  `cat_lst_r_k` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`cpy_lst_r_k`, `cat_lst_r_k`),
  INDEX `fk_cpy_lst_has_cat_lst_cat_lst1_idx` (`cat_lst_r_k` ASC),
  INDEX `fk_cpy_lst_has_cat_lst_cpy_lst1_idx` (`cpy_lst_r_k` ASC),
  CONSTRAINT `fk_cpy_lst_has_cat_lst_cpy_lst1`
    FOREIGN KEY (`cpy_lst_r_k`)
    REFERENCES `exchg`.`cpy_lst` (`r_k`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cpy_lst_has_cat_lst_cat_lst1`
    FOREIGN KEY (`cat_lst_r_k`)
    REFERENCES `exchg`.`cat_lst` (`r_k`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- View `exchg`.`cpy_cty_cat_vw`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `exchg`.`cpy_cty_cat_vw`;
DROP TABLE IF EXISTS `exchg`.`cpy_cty_cat_vw`;

CREATE OR REPLACE VIEW `exchg`.`cpy_cty_cat_vw`
AS
SELECT
  cp.r_k cmp_id,
  cp.cpy_id cmp_cde,
  cp.cpy_bgt cmp_bgt,
  cp.bid_prc cmp_bd_prc,
  ca.cat_nme ctg_nme,
  ct.cty_nme cty_nm,
  ct.cty_cde cty_code
FROM cpy_lst cp, cat_lst ca, cpy_cat_lst cca, cty_lst ct, cpy_cty_lst cct
WHERE cp.r_k = cca.cpy_lst_r_k and ca.r_k = cca.cat_lst_r_k and cp.r_k = cct.cpy_lst_r_k and ct.r_k = cct.cty_lst_r_k;



-- -----------------------------------------------------
-- Insert data for cty_lst
-- -----------------------------------------------------
INSERT INTO `exchg`.`cty_lst` (`cty_nme`, `cty_cde`) VALUES ('UNITED STATES OF AMERICA', 'US');
INSERT INTO `exchg`.`cty_lst` (`cty_nme`, `cty_cde`) VALUES ('FRANCE', 'FR');
INSERT INTO `exchg`.`cty_lst` (`cty_nme`, `cty_cde`) VALUES ('INDIA', 'IN');
INSERT INTO `exchg`.`cty_lst` (`cty_nme`, `cty_cde`) VALUES ('RUSSIA', 'RU');

-- -----------------------------------------------------
-- Insert data for cat_lst
-- -----------------------------------------------------
INSERT INTO `exchg`.`cat_lst` (`cat_nme`) VALUES ('Automobile');
INSERT INTO `exchg`.`cat_lst` (`cat_nme`) VALUES ('Finance');
INSERT INTO `exchg`.`cat_lst` (`cat_nme`) VALUES ('IT');

-- -----------------------------------------------------
-- Insert data for cpy_lst
-- -----------------------------------------------------
INSERT INTO `exchg`.`cpy_lst` (`cpy_id`, `cpy_bgt`, `bid_prc`, `lst_upd`) VALUES ('C1', 1.00, 0.10, NOW());
INSERT INTO `exchg`.`cpy_lst` (`cpy_id`, `cpy_bgt`, `bid_prc`, `lst_upd`) VALUES ('C2', 2.00, 0.30, NOW());
INSERT INTO `exchg`.`cpy_lst` (`cpy_id`, `cpy_bgt`, `bid_prc`, `lst_upd`) VALUES ('C3', 3.00, 0.05, NOW());

-- -----------------------------------------------------
-- Insert data for cpy_cat_lst
-- -----------------------------------------------------
INSERT INTO `exchg`.`cpy_cat_lst` (`cpy_lst_r_k`, `cat_lst_r_k`) VALUES (1, 1);
INSERT INTO `exchg`.`cpy_cat_lst` (`cpy_lst_r_k`, `cat_lst_r_k`) VALUES (1, 2);
INSERT INTO `exchg`.`cpy_cat_lst` (`cpy_lst_r_k`, `cat_lst_r_k`) VALUES (2, 2);
INSERT INTO `exchg`.`cpy_cat_lst` (`cpy_lst_r_k`, `cat_lst_r_k`) VALUES (2, 3);
INSERT INTO `exchg`.`cpy_cat_lst` (`cpy_lst_r_k`, `cat_lst_r_k`) VALUES (3, 3);
INSERT INTO `exchg`.`cpy_cat_lst` (`cpy_lst_r_k`, `cat_lst_r_k`) VALUES (3, 1);

-- -----------------------------------------------------
-- Insert data for cpy_cty_lst
-- -----------------------------------------------------
INSERT INTO `exchg`.`cpy_cty_lst` (`cpy_lst_r_k`, `cty_lst_r_k`) VALUES (1, 1);
INSERT INTO `exchg`.`cpy_cty_lst` (`cpy_lst_r_k`, `cty_lst_r_k`) VALUES (1, 2);
INSERT INTO `exchg`.`cpy_cty_lst` (`cpy_lst_r_k`, `cty_lst_r_k`) VALUES (2, 3);
INSERT INTO `exchg`.`cpy_cty_lst` (`cpy_lst_r_k`, `cty_lst_r_k`) VALUES (2, 1);
INSERT INTO `exchg`.`cpy_cty_lst` (`cpy_lst_r_k`, `cty_lst_r_k`) VALUES (3, 1);
INSERT INTO `exchg`.`cpy_cty_lst` (`cpy_lst_r_k`, `cty_lst_r_k`) VALUES (3, 4);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
