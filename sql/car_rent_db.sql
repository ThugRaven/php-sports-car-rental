-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema car_rent_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `car_rent_db` ;

-- -----------------------------------------------------
-- Schema car_rent_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `car_rent_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_polish_ci ;
USE `car_rent_db` ;

-- -----------------------------------------------------
-- Table `car_rent_db`.`user_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `car_rent_db`.`user_role` ;

CREATE TABLE IF NOT EXISTS `car_rent_db`.`user_role` (
  `id_user_role` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id_user_role`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_rent_db`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `car_rent_db`.`user` ;

CREATE TABLE IF NOT EXISTS `car_rent_db`.`user` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(45) NOT NULL,
  `password` CHAR(60) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `id_user_role` INT NOT NULL DEFAULT 1,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(15) NOT NULL,
  `verified` TINYINT(1) NOT NULL DEFAULT 0,
  `birth_date` DATE NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user`),
  CONSTRAINT `fk_user_role`
    FOREIGN KEY (`id_user_role`)
    REFERENCES `car_rent_db`.`user_role` (`id_user_role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_user_role_idx` ON `car_rent_db`.`user` (`id_user_role` ASC);


-- -----------------------------------------------------
-- Table `car_rent_db`.`car_price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `car_rent_db`.`car_price` ;

CREATE TABLE IF NOT EXISTS `car_rent_db`.`car_price` (
  `id_car_price` INT NOT NULL AUTO_INCREMENT,
  `price_deposit` TINYINT(5) NOT NULL,
  `price_no_deposit` TINYINT(5) NOT NULL,
  `multiplier` FLOAT NOT NULL,
  `km_limit` TINYINT(5) NOT NULL,
  `deposit` TINYINT(5) NOT NULL,
  `additional_km` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id_car_price`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_rent_db`.`car`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `car_rent_db`.`car` ;

CREATE TABLE IF NOT EXISTS `car_rent_db`.`car` (
  `id_car` INT NOT NULL AUTO_INCREMENT,
  `id_car_price` INT NOT NULL,
  `license_plate` VARCHAR(15) NOT NULL,
  `mileage` INT NOT NULL,
  `brand` VARCHAR(45) NOT NULL,
  `model` VARCHAR(45) NOT NULL,
  `production_year` YEAR(4) NOT NULL,
  `eng_power` INT NOT NULL,
  `eng_torque` INT NOT NULL,
  `eng_type` VARCHAR(45) NOT NULL,
  `eng_displacement` FLOAT NOT NULL,
  `drive` VARCHAR(10) NOT NULL,
  `100_time` FLOAT NULL,
  `top_speed` SMALLINT(3) NULL,
  `fuel_type` VARCHAR(5) NOT NULL,
  `transmission_type` VARCHAR(15) NOT NULL,
  `doors` TINYINT(1) NULL,
  `seats` TINYINT(1) NULL,
  `weight` INT NULL,
  `fuel_capacity` TINYINT(3) NULL,
  `fuel_consumption` FLOAT NULL,
  PRIMARY KEY (`id_car`),
  CONSTRAINT `fk_car_rent_price`
    FOREIGN KEY (`id_car_price`)
    REFERENCES `car_rent_db`.`car_price` (`id_car_price`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `license_plate_UNIQUE` ON `car_rent_db`.`car` (`license_plate` ASC);

CREATE INDEX `fk_car_rent_price_idx` ON `car_rent_db`.`car` (`id_car_price` ASC);


-- -----------------------------------------------------
-- Table `car_rent_db`.`rent_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `car_rent_db`.`rent_status` ;

CREATE TABLE IF NOT EXISTS `car_rent_db`.`rent_status` (
  `id_rent_status` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`id_rent_status`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `car_rent_db`.`rent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `car_rent_db`.`rent` ;

CREATE TABLE IF NOT EXISTS `car_rent_db`.`rent` (
  `id_rent` INT NOT NULL AUTO_INCREMENT,
  `id_car` INT NOT NULL,
  `id_user` INT NOT NULL,
  `rent_start` DATETIME NULL,
  `rent_end` DATETIME NULL,
  `id_rent_status` INT NOT NULL,
  `total_price` INT NULL,
  PRIMARY KEY (`id_rent`),
  CONSTRAINT `fk_rent_car`
    FOREIGN KEY (`id_car`)
    REFERENCES `car_rent_db`.`car` (`id_car`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rent_user`
    FOREIGN KEY (`id_user`)
    REFERENCES `car_rent_db`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rent_status`
    FOREIGN KEY (`id_rent_status`)
    REFERENCES `car_rent_db`.`rent_status` (`id_rent_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_rent_car_idx` ON `car_rent_db`.`rent` (`id_car` ASC);

CREATE INDEX `fk_rent_user_idx` ON `car_rent_db`.`rent` (`id_user` ASC);

CREATE INDEX `fk_rent_status_idx` ON `car_rent_db`.`rent` (`id_rent_status` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `car_rent_db`.`user_role`
-- -----------------------------------------------------
START TRANSACTION;
USE `car_rent_db`;
INSERT INTO `car_rent_db`.`user_role` (`id_user_role`, `name`) VALUES (1, 'user');
INSERT INTO `car_rent_db`.`user_role` (`id_user_role`, `name`) VALUES (2, 'admin');

COMMIT;


-- -----------------------------------------------------
-- Data for table `car_rent_db`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `car_rent_db`;
INSERT INTO `car_rent_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `verified`, `birth_date`, `create_time`) VALUES (1, 'admin', '$2y$10$ISBE2oOvQMaElBqCtYxy8O0GK7QJNMw8ijEKKX6VJNaYugGbc493C', 'admin@gmail.com', 2, 'Kamil', 'Wesołowski', '48123456789', 1, '1999-09-04', '2021-05-17 13:12:10');

COMMIT;


-- -----------------------------------------------------
-- Data for table `car_rent_db`.`car_price`
-- -----------------------------------------------------
START TRANSACTION;
USE `car_rent_db`;
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `multiplier`, `km_limit`, `deposit`, `additional_km`) VALUES (1, 1, 1, 1, 1, 1, 1);
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `multiplier`, `km_limit`, `deposit`, `additional_km`) VALUES (2, 1, 1, 1, 1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `car_rent_db`.`car`
-- -----------------------------------------------------
START TRANSACTION;
USE `car_rent_db`;
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `production_year`, `eng_power`, `eng_torque`, `eng_type`, `eng_displacement`, `drive`, `100_time`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`) VALUES (1, 1, 'S0RENT01', 32000, 'Seat', 'Leon Cupra R', 2018, 310, 380, 'TSI', 2.0, 'FWD', 5.8, 250, 'Petrol', 'Manual', 5, 5, 1930, 50, 6.07);
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `production_year`, `eng_power`, `eng_torque`, `eng_type`, `eng_displacement`, `drive`, `100_time`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`) VALUES (2, 2, 'S0RENT02', 65000, 'Ford', 'Focus RS', 2017, 350, 470, 'EcoBoost', 2.3, 'AWD', 4.7, 265, 'Petrol', 'Manual', 5, 5, 2025, 51, 6.4);

COMMIT;

