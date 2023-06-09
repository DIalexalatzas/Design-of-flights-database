-- MySQL Script generated by MySQL Workbench
-- Wed Mar 30 00:14:05 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`airport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`airport` (
  `airport id` VARCHAR(90) NOT NULL,
  `international id` VARCHAR(5) NOT NULL,
  `name` VARCHAR(90) NOT NULL,
  `city` VARCHAR(90) NOT NULL,
  `country` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`airport id`, `international id`),
  UNIQUE INDEX `international id_UNIQUE` (`international id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`airplane models`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`airplane models` (
  `manifacturer` VARCHAR(90) NOT NULL,
  `no_seats` INT NOT NULL,
  `weight` INT NOT NULL,
  PRIMARY KEY (`manifacturer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`airplanes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`airplanes` (
  `airplane id` VARCHAR(90) NOT NULL,
  `airport_airport id` VARCHAR(90) NOT NULL,
  `airplane models_manifacturer` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`airplane id`),
  INDEX `fk_airplanes_airport_idx` (`airport_airport id` ASC) VISIBLE,
  INDEX `fk_airplanes_airplane models1_idx` (`airplane models_manifacturer` ASC) VISIBLE,
  CONSTRAINT `fk_airplanes_airport`
    FOREIGN KEY (`airport_airport id`)
    REFERENCES `mydb`.`airport` (`airport id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_airplanes_airplane models1`
    FOREIGN KEY (`airplane models_manifacturer`)
    REFERENCES `mydb`.`airplane models` (`manifacturer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`airline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`airline` (
  `international id` VARCHAR(90) NOT NULL,
  `name` VARCHAR(90) NOT NULL,
  `country` VARCHAR(90) NOT NULL,
  `status` CHAR(1) BINARY NOT NULL,
  `airport_airport id` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`international id`),
  INDEX `fk_airline_airport1_idx` (`airport_airport id` ASC) VISIBLE,
  CONSTRAINT `fk_airline_airport1`
    FOREIGN KEY (`airport_airport id`)
    REFERENCES `mydb`.`airport` (`airport id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`flight`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`flight` (
  `flight id` VARCHAR(90) NOT NULL,
  `departure date` DATETIME NOT NULL,
  `arrival date` DATETIME NOT NULL,
  `arrival airport` VARCHAR(90) NOT NULL,
  `departure airport` VARCHAR(90) NOT NULL,
  `airline_international id` VARCHAR(90) NOT NULL,
  `airplanes_airplane id` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`flight id`),
  INDEX `fk_flight_airline1_idx` (`airline_international id` ASC) VISIBLE,
  INDEX `fk_flight_airplanes1_idx` (`airplanes_airplane id` ASC) VISIBLE,
  INDEX `fk_flight_airport1_idx` (`arrival airport` ASC) VISIBLE,
  INDEX `fk_flight_airport2_idx` (`departure airport` ASC) VISIBLE,
  CONSTRAINT `fk_flight_airline1`
    FOREIGN KEY (`airline_international id`)
    REFERENCES `mydb`.`airline` (`international id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_flight_airplanes1`
    FOREIGN KEY (`airplanes_airplane id`)
    REFERENCES `mydb`.`airplanes` (`airplane id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_flight_airport1`
    FOREIGN KEY (`arrival airport`)
    REFERENCES `mydb`.`airport` (`international id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_flight_airport2`
    FOREIGN KEY (`departure airport`)
    REFERENCES `mydb`.`airport` (`international id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`human`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`human` (
  `federal_id` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(90) NOT NULL,
  `last_name` VARCHAR(90) NOT NULL,
  `address` VARCHAR(90) NOT NULL,
  `telephone` VARCHAR(13) NOT NULL,
  `email` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`federal_id`),
  INDEX `Employ` (`first_name` ASC, `last_name` ASC, `address` ASC, `telephone` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customer` (
  `id` VARCHAR(90) NOT NULL,
  `human_federal_id` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customer_human1_idx` (`human_federal_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_human1`
    FOREIGN KEY (`human_federal_id`)
    REFERENCES `mydb`.`human` (`federal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`manifest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`manifest` (
  ` id` VARCHAR(90) NOT NULL,
  `flight_flight id` VARCHAR(90) NOT NULL,
  PRIMARY KEY (` id`),
  INDEX `fk_manifest_flight1_idx` (`flight_flight id` ASC) VISIBLE,
  CONSTRAINT `fk_manifest_flight1`
    FOREIGN KEY (`flight_flight id`)
    REFERENCES `mydb`.`flight` (`flight id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`seat_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`seat_type` (
  `seat_number` VARCHAR(45) NOT NULL,
  `first_class` BINARY(1) NOT NULL DEFAULT 0,
  `business_class` BINARY(1) NOT NULL DEFAULT 0,
  `premium_economy` BINARY(1) NOT NULL DEFAULT 0,
  `economy_class` BINARY(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`seat_number`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reservation` (
  `reservations_id` VARCHAR(90) NOT NULL,
  `customer_id` VARCHAR(90) NOT NULL,
  `seat_type` VARCHAR(90) NOT NULL,
  `date` VARCHAR(90) NOT NULL,
  `comments` VARCHAR(90) NULL,
  `manifest_ id` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`reservations_id`, `seat_type`),
  INDEX `fk_reservation_customer1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_reservation_manifest1_idx` (`manifest_ id` ASC) VISIBLE,
  INDEX `fk_seat_type_type1_idx` (`seat_type` ASC) VISIBLE,
  CONSTRAINT `fk_reservation_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservation_manifest1`
    FOREIGN KEY (`manifest_ id`)
    REFERENCES `mydb`.`manifest` (` id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_seat_type_type1`
    FOREIGN KEY (`seat_type`)
    REFERENCES `mydb`.`seat_type` (`seat_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`food menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`food menu` (
  `food menu id` VARCHAR(90) NOT NULL,
  `flight_flight id` VARCHAR(90) NOT NULL,
  `seat_type` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`food menu id`, `seat_type`),
  INDEX `fk_food menu_flight1_idx` (`flight_flight id` ASC, `seat_type` ASC) VISIBLE,
  INDEX `fk_food menu_seat_type1_idx` (`seat_type` ASC) VISIBLE,
  CONSTRAINT `fk_food menu_flight1`
    FOREIGN KEY (`flight_flight id` , `seat_type`)
    REFERENCES `mydb`.`flight` (`flight id` , `flight id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_food menu_seat_type1`
    FOREIGN KEY (`seat_type`)
    REFERENCES `mydb`.`reservation` (`seat_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`research`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`research` (
  `title` VARCHAR(90) NOT NULL,
  `flight_type` VARCHAR(90) NOT NULL,
  `flight_date` VARCHAR(90) NOT NULL,
  `flight_description` VARCHAR(90) NOT NULL,
  `human_federal_id` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`title`),
  CONSTRAINT `fk_research_human1`
    FOREIGN KEY (`human_federal_id`)
    REFERENCES `mydb`.`human` (`federal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`research_has_reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`research_has_reservation` (
  `research_title` VARCHAR(90) NOT NULL,
  `reservation_reservations_id` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`research_title`, `reservation_reservations_id`),
  INDEX `fk_research_has_reservation_reservation1_idx` (`reservation_reservations_id` ASC) VISIBLE,
  INDEX `fk_research_has_reservation_research1_idx` (`research_title` ASC) VISIBLE,
  CONSTRAINT `fk_research_has_reservation_research1`
    FOREIGN KEY (`research_title`)
    REFERENCES `mydb`.`research` (`title`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_research_has_reservation_reservation1`
    FOREIGN KEY (`reservation_reservations_id`)
    REFERENCES `mydb`.`reservation` (`reservations_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vaccination certificate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vaccination certificate` (
  `qr` VARCHAR(90) NOT NULL,
  `date` DATE NOT NULL,
  `number_of_doses` INT NOT NULL,
  PRIMARY KEY (`qr`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`passenger`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`passenger` (
  `passport_id` VARCHAR(90) NOT NULL,
  `human_federal_id` VARCHAR(90) NOT NULL,
  `vaccination certificate_qr` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`passport_id`),
  INDEX `fk_passenger_human1_idx` (`human_federal_id` ASC) VISIBLE,
  INDEX `fk_passenger_vaccination certificate1_idx` (`vaccination certificate_qr` ASC) VISIBLE,
  CONSTRAINT `fk_passenger_human1`
    FOREIGN KEY (`human_federal_id`)
    REFERENCES `mydb`.`human` (`federal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_passenger_vaccination certificate1`
    FOREIGN KEY (`vaccination certificate_qr`)
    REFERENCES `mydb`.`vaccination certificate` (`qr`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ticket` (
  `qr_code` VARCHAR(90) NOT NULL,
  `ticket_id` VARCHAR(90) NOT NULL,
  `creationDate` VARCHAR(90) NOT NULL,
  `passenger_passport_id` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`qr_code`),
  INDEX `fk_ticket_passenger1_idx` (`passenger_passport_id` ASC) VISIBLE,
  CONSTRAINT `fk_ticket_passenger1`
    FOREIGN KEY (`passenger_passport_id`)
    REFERENCES `mydb`.`passenger` (`passport_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`employee` (
  `idcard` VARCHAR(90) NOT NULL,
  `human_first_name` VARCHAR(90) NOT NULL,
  `human_last_name` VARCHAR(90) NOT NULL,
  `human_address` VARCHAR(90) NOT NULL,
  `airport_airport id` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`idcard`),
  INDEX `fk_employee_human1_idx` (`human_first_name` ASC, `human_last_name` ASC, `human_address` ASC) INVISIBLE,
  INDEX `fk_employee_airport1_idx` (`airport_airport id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_human1`
    FOREIGN KEY (`human_first_name` , `human_last_name` , `human_address`)
    REFERENCES `mydb`.`human` (`first_name` , `last_name` , `address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_airport1`
    FOREIGN KEY (`airport_airport id`)
    REFERENCES `mydb`.`airport` (`airport id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`technician`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`technician` (
  `employee_idcard` VARCHAR(90) NOT NULL,
  `telephone` VARCHAR(90) NOT NULL,
  `wage` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`employee_idcard`),
  INDEX `fk_technician_employee1_idx` (`employee_idcard` ASC) VISIBLE,
  CONSTRAINT `fk_technician_employee1`
    FOREIGN KEY (`employee_idcard`)
    REFERENCES `mydb`.`employee` (`idcard`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`controler`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`controler` (
  `employee_idcard` VARCHAR(90) NOT NULL,
  `medical_check_date` DATE NOT NULL,
  PRIMARY KEY (`employee_idcard`),
  CONSTRAINT `fk_inspector_employee1`
    FOREIGN KEY (`employee_idcard`)
    REFERENCES `mydb`.`employee` (`idcard`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`expertise`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`expertise` (
  `technician_employee_idcard` VARCHAR(90) NOT NULL,
  `airplane models_manifacturer` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`technician_employee_idcard`, `airplane models_manifacturer`),
  INDEX `fk_technician_has_airplane models_airplane models1_idx` (`airplane models_manifacturer` ASC) VISIBLE,
  INDEX `fk_technician_has_airplane models_technician1_idx` (`technician_employee_idcard` ASC) VISIBLE,
  CONSTRAINT `fk_technician_has_airplane models_technician1`
    FOREIGN KEY (`technician_employee_idcard`)
    REFERENCES `mydb`.`technician` (`employee_idcard`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_technician_has_airplane models_airplane models1`
    FOREIGN KEY (`airplane models_manifacturer`)
    REFERENCES `mydb`.`airplane models` (`manifacturer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`assosciation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`assosciation` (
  `name` VARCHAR(90) NOT NULL,
  `foundation_year` YEAR NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`association members`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`association members` (
  `assosciation_name` VARCHAR(90) NOT NULL,
  `employee_idcard` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`assosciation_name`, `employee_idcard`),
  INDEX `fk_assosciation_has_employee_assosciation1_idx` (`assosciation_name` ASC) VISIBLE,
  INDEX `fk_association members_employee1_idx` (`employee_idcard` ASC) VISIBLE,
  CONSTRAINT `fk_assosciation_has_employee_assosciation1`
    FOREIGN KEY (`assosciation_name`)
    REFERENCES `mydb`.`assosciation` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_association members_employee1`
    FOREIGN KEY (`employee_idcard`)
    REFERENCES `mydb`.`employee` (`idcard`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`inspection type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`inspection type` (
  `ypa_code` INT NOT NULL,
  `name` VARCHAR(90) NOT NULL,
  `max_score` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`ypa_code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`report` (
  `id` VARCHAR(90) NOT NULL,
  `airplanes_airplane id` VARCHAR(90) NOT NULL,
  `inspection type_ypa_code` INT NOT NULL,
  `technician_employee_idcard` INT NOT NULL,
  `date` DATE NOT NULL,
  `hours` TIME NOT NULL,
  `score` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_report_airplanes1_idx` (`airplanes_airplane id` ASC) VISIBLE,
  INDEX `fk_report_technician1_idx` (`technician_employee_idcard` ASC) VISIBLE,
  INDEX `fk_report_inspection type1_idx` (`inspection type_ypa_code` ASC) VISIBLE,
  CONSTRAINT `fk_report_airplanes1`
    FOREIGN KEY (`airplanes_airplane id`)
    REFERENCES `mydb`.`airplanes` (`airplane id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_technician1`
    FOREIGN KEY (`technician_employee_idcard`)
    REFERENCES `mydb`.`technician` (`employee_idcard`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_inspection type1`
    FOREIGN KEY (`inspection type_ypa_code`)
    REFERENCES `mydb`.`inspection type` (`ypa_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
