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
  `name` VARCHAR(45) NOT NULL,
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
  `rents` SMALLINT NOT NULL DEFAULT 0,
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

CREATE UNIQUE INDEX `login_UNIQUE` ON `car_rent_db`.`user` (`login` ASC);


-- -----------------------------------------------------
-- Table `car_rent_db`.`car_price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `car_rent_db`.`car_price` ;

CREATE TABLE IF NOT EXISTS `car_rent_db`.`car_price` (
  `id_car_price` INT NOT NULL AUTO_INCREMENT,
  `price_deposit` SMALLINT NOT NULL,
  `price_no_deposit` SMALLINT NOT NULL,
  `km_limit` SMALLINT NOT NULL,
  `deposit` SMALLINT NOT NULL,
  `additional_km` TINYINT NOT NULL,
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
  `eng_power` INT NOT NULL,
  `eng_torque` INT NOT NULL,
  `eng_info` VARCHAR(45) NULL,
  `eng_displacement` FLOAT NOT NULL,
  `drive` VARCHAR(10) NOT NULL,
  `time_100` FLOAT NULL,
  `top_speed` SMALLINT NULL,
  `fuel_type` VARCHAR(10) NOT NULL,
  `transmission_type` VARCHAR(15) NOT NULL,
  `doors` TINYINT NULL,
  `seats` TINYINT NULL,
  `weight` INT NULL,
  `fuel_capacity` TINYINT NULL,
  `fuel_consumption` FLOAT NULL,
  `rentable` TINYINT NOT NULL DEFAULT 0,
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
  `status` VARCHAR(45) NOT NULL,
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
  `rent_start` DATETIME NOT NULL,
  `rent_end` DATETIME NOT NULL,
  `id_rent_status` INT NOT NULL,
  `total_price` INT NOT NULL,
  `payment_type` VARCHAR(15) NOT NULL,
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
INSERT INTO `car_rent_db`.`user_role` (`id_user_role`, `name`) VALUES (1, 'customer');
INSERT INTO `car_rent_db`.`user_role` (`id_user_role`, `name`) VALUES (2, 'employee');
INSERT INTO `car_rent_db`.`user_role` (`id_user_role`, `name`) VALUES (3, 'admin');

COMMIT;


-- -----------------------------------------------------
-- Data for table `car_rent_db`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `car_rent_db`;
INSERT INTO `car_rent_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `rents`, `verified`, `birth_date`, `create_time`) VALUES (1, 'admin', '$2y$10$ISBE2oOvQMaElBqCtYxy8O0GK7QJNMw8ijEKKX6VJNaYugGbc493C', 'admin@gmail.com', 3, 'Kamil', 'Wesołowski', '48123456789', 0, 1, '1999-09-04', '2021-05-17 13:12:10');
INSERT INTO `car_rent_db`.`user` (`id_user`, `login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `rents`, `verified`, `birth_date`, `create_time`) VALUES (2, 'user', '$2y$10$4tJiE9qJ2YQpSQ3lFY82CeJxF6No1h4prsagK51bmivYF4Pl0r1Aa', 'user@gmail.com', 1, 'UserName', 'UserSurname', '48987654321', 0, 0, '2000-01-01', '2021-05-24 22:37:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `car_rent_db`.`car_price`
-- -----------------------------------------------------
START TRANSACTION;
USE `car_rent_db`;
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `km_limit`, `deposit`, `additional_km`) VALUES (1, 1, 1, 1, 1, 1);
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `km_limit`, `deposit`, `additional_km`) VALUES (2, 1, 1, 1, 1, 1);
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `km_limit`, `deposit`, `additional_km`) VALUES (3, 1, 1, 1, 1, 1);
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `km_limit`, `deposit`, `additional_km`) VALUES (4, 1, 1, 1, 1, 1);
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `km_limit`, `deposit`, `additional_km`) VALUES (5, 1, 1, 1, 1, 1);
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `km_limit`, `deposit`, `additional_km`) VALUES (6, 1, 1, 1, 1, 1);
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `km_limit`, `deposit`, `additional_km`) VALUES (7, 1, 1, 1, 1, 1);
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `km_limit`, `deposit`, `additional_km`) VALUES (8, 1, 1, 1, 1, 1);
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `km_limit`, `deposit`, `additional_km`) VALUES (9, 1, 1, 1, 1, 1);
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `km_limit`, `deposit`, `additional_km`) VALUES (10, 1, 1, 1, 1, 1);
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `km_limit`, `deposit`, `additional_km`) VALUES (11, 1, 1, 1, 1, 1);
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `km_limit`, `deposit`, `additional_km`) VALUES (12, 1, 1, 1, 1, 1);
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `km_limit`, `deposit`, `additional_km`) VALUES (13, 1, 1, 1, 1, 1);
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `km_limit`, `deposit`, `additional_km`) VALUES (14, 1, 1, 1, 1, 1);
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `km_limit`, `deposit`, `additional_km`) VALUES (15, 1, 1, 1, 1, 1);
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `km_limit`, `deposit`, `additional_km`) VALUES (16, 1, 1, 1, 1, 1);
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `km_limit`, `deposit`, `additional_km`) VALUES (17, 1, 1, 1, 1, 1);
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `km_limit`, `deposit`, `additional_km`) VALUES (18, 1, 1, 1, 1, 1);
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `km_limit`, `deposit`, `additional_km`) VALUES (19, 1, 1, 1, 1, 1);
INSERT INTO `car_rent_db`.`car_price` (`id_car_price`, `price_deposit`, `price_no_deposit`, `km_limit`, `deposit`, `additional_km`) VALUES (20, 1, 1, 1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `car_rent_db`.`car`
-- -----------------------------------------------------
START TRANSACTION;
USE `car_rent_db`;
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `eng_power`, `eng_torque`, `eng_info`, `eng_displacement`, `drive`, `time_100`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`, `rentable`) VALUES (1, 1, 'S0RENT01', 32000, 'Seat', 'Leon Cupra R', 310, 380, 'TSI Turbo', 2.0, 'FWD', 5.8, 250, 'Petrol', 'Manual', 5, 5, 1378, 50, 6.07, 1);
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `eng_power`, `eng_torque`, `eng_info`, `eng_displacement`, `drive`, `time_100`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`, `rentable`) VALUES (2, 2, 'S0RENT02', 65000, 'Ford', 'Focus RS', 350, 470, 'EcoBoost Turbo', 2.3, 'AWD', 4.7, 265, 'Petrol', 'Manual', 5, 5, 1524, 51, 6.4, 1);
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `eng_power`, `eng_torque`, `eng_info`, `eng_displacement`, `drive`, `time_100`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`, `rentable`) VALUES (3, 3, 'S0RENT03', 53520, 'Ford', 'Mustang 5.0 V8 GT', 416, 530, 'V8', 5.0, 'RWD', 4.8, 250, 'Petrol', 'Manual', 2, 4, 1645, 61, 11.3, 1);
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `eng_power`, `eng_torque`, `eng_info`, `eng_displacement`, `drive`, `time_100`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`, `rentable`) VALUES (4, 4, 'S0RENT04', 23000, 'Renault', 'Megane R.S. Trophy', 300, 400, 'Turbo', 1.8, 'FWD', 5.7, 260, 'Petrol', 'Manual', 5, 5, 1419, 50, 6.8, 1);
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `eng_power`, `eng_torque`, `eng_info`, `eng_displacement`, `drive`, `time_100`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`, `rentable`) VALUES (5, 5, 'S0RENT05', 45200, 'Subaru', 'Impreza WRX STI', 280, 392, 'Turbo', 2.5, 'AWD', 5.4, 254, 'Petrol', 'Manual', 4, 5, 1495, 60, 9, 1);
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `eng_power`, `eng_torque`, `eng_info`, `eng_displacement`, `drive`, `time_100`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`, `rentable`) VALUES (6, 6, 'S0RENT06', 36780, 'Toyota', 'Supra GR', 340, 500, 'Twin-Scroll Turbo', 3.0, 'RWD', 4.3, 250, 'Petrol', 'Automatic', 2, 2, 1530, 52, 7.2, 1);
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `eng_power`, `eng_torque`, `eng_info`, `eng_displacement`, `drive`, `time_100`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`, `rentable`) VALUES (7, 7, 'S0RENT07', 7800, 'Toyota', 'GR Yaris', 261, 360, 'R3 Turbo', 1.6, 'AWD', 5.5, 230, 'Petrol', 'Manual', 2, 4, 1280, 50, 8.2, 1);
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `eng_power`, `eng_torque`, `eng_info`, `eng_displacement`, `drive`, `time_100`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`, `rentable`) VALUES (8, 8, 'S0RENT08', 25000, 'BMW', 'M2 Competition', 410, 550, 'Twin-Turbo', 3.0, 'RWD', 4.2, 250, 'Petrol', 'Automatic', 2, 4, 1575, 52, 7.6, 1);
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `eng_power`, `eng_torque`, `eng_info`, `eng_displacement`, `drive`, `time_100`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`, `rentable`) VALUES (9, 9, 'S0RENT09', 9600, 'Audi', 'RS6', 600, 800, 'V8 TFSI Twin-Turbo', 4.0, 'AWD', 3.6, 280, 'Petrol', 'Automatic', 5, 4, 2075, 73, 11.6, 1);
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `eng_power`, `eng_torque`, `eng_info`, `eng_displacement`, `drive`, `time_100`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`, `rentable`) VALUES (10, 10, 'S0RENT10', 13450, 'Porsche', 'Taycan', 761, 1050, NULL, DEFAULT, 'AWD', 2.8, 260, 'Electric', 'Automatic', 4, 4, 2370, NULL, NULL, 1);
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `eng_power`, `eng_torque`, `eng_info`, `eng_displacement`, `drive`, `time_100`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`, `rentable`) VALUES (11, 11, 'S0RENT11', 37650, 'Toyota', 'GT86', 200, 205, NULL, 2.0, 'RWD', 7.6, 225, 'Petrol', 'Manual', 2, 4, 1270, 50, 7.2, 1);
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `eng_power`, `eng_torque`, `eng_info`, `eng_displacement`, `drive`, `time_100`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`, `rentable`) VALUES (12, 12, 'S0RENT12', 45500, 'Mercedes', 'AMG A45 S', 421, 500, 'Twin-Turbo', 2.0, 'AWD', 3.9, 270, 'Petrol', 'Automatic', 5, 5, 1550, 51, 8.3, 1);
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `eng_power`, `eng_torque`, `eng_info`, `eng_displacement`, `drive`, `time_100`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`, `rentable`) VALUES (13, 13, 'S0RENT13', 27865, 'Porsche', '718 Cayman GTS', 400, 420, 'Turbo', 4.0, 'RWD', 4.5, 292, 'Petrol', 'Automatic', 2, 2, 1405, 64, 10.8, 1);
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `eng_power`, `eng_torque`, `eng_info`, `eng_displacement`, `drive`, `time_100`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`, `rentable`) VALUES (14, 14, 'S0RENT14', 16500, 'Mercedes', 'AMG A35', 306, 400, 'Turbo', 2.0, 'AWD', 4.7, 250, 'Petrol', 'Automatic', 5, 5, 1555, 51, 6.1, 1);
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `eng_power`, `eng_torque`, `eng_info`, `eng_displacement`, `drive`, `time_100`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`, `rentable`) VALUES (15, 15, 'S0RENT15', 19252, 'Nissan', 'GT-R', 570, 637, 'V6 Twin-Turbo', 3.8, 'AWD', 2.7, 315, 'Petrol', 'Automatic', 2, 4, 1752, 74, 9.8, 1);
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `eng_power`, `eng_torque`, `eng_info`, `eng_displacement`, `drive`, `time_100`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`, `rentable`) VALUES (16, 16, 'S0RENT16', 12900, 'Chevrolet', 'Camaro SS', 455, 614, 'V8', 6.2, 'RWD', 4.6, 290, 'Petrol', 'Automatic', 2, 4, 1697, 72, 11.7, 1);
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `eng_power`, `eng_torque`, `eng_info`, `eng_displacement`, `drive`, `time_100`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`, `rentable`) VALUES (17, 17, 'S0RENT17', 12525, 'Volkswagen', 'Golf R', 310, 380, 'TSI Turbo', 2.0, 'AWD', 5.1, 250, 'Petrol', 'Automatic', 5, 5, 1408, 50, 6.5, 0);
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `eng_power`, `eng_torque`, `eng_info`, `eng_displacement`, `drive`, `time_100`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`, `rentable`) VALUES (18, 18, 'S0RENT18', 16250, 'Volkswagen', 'Golf GTI', 245, 370, 'TSI Turbo', 2.0, 'FWD', 6.2, 250, 'Petrol', 'Automatic', 5, 5, 1340, 50, 8.7, 0);
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `eng_power`, `eng_torque`, `eng_info`, `eng_displacement`, `drive`, `time_100`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`, `rentable`) VALUES (19, 19, 'S0RENT19', 13000, 'Porsche', '911 Turbo S', 650, 800, 'Flat-6 Twin-Turbo', 3.8, 'AWD', 2.7, 330, 'Petrol', 'Automatic', 2, 4, 1715, 67, 11.1, 1);
INSERT INTO `car_rent_db`.`car` (`id_car`, `id_car_price`, `license_plate`, `mileage`, `brand`, `model`, `eng_power`, `eng_torque`, `eng_info`, `eng_displacement`, `drive`, `time_100`, `top_speed`, `fuel_type`, `transmission_type`, `doors`, `seats`, `weight`, `fuel_capacity`, `fuel_consumption`, `rentable`) VALUES (20, 20, 'S0RENT20', 7900, 'Alfa Romeo', 'Giulia Quadrifoglio', 510, 600, 'V6 Twin-Turbo', 2.9, 'RWD', 3.9, 307, 'Petrol', 'Automatic', 4, 4, 1580, 58, 8.5, 1);

COMMIT;

