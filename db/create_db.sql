-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema support
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `support` ;

-- -----------------------------------------------------
-- Schema support
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `support` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `support` ;

-- -----------------------------------------------------
-- Table `support`.`clients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `support`.`clients` ;

CREATE TABLE IF NOT EXISTS `support`.`clients` (
  `client_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(32) NOT NULL,
  `lastname` VARCHAR(32) NOT NULL,
  `email` VARCHAR(255) NULL,
  PRIMARY KEY (`client_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `support`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `support`.`users` ;

CREATE TABLE IF NOT EXISTS `support`.`users` (
  `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(32) NOT NULL,
  `passwd` VARCHAR(128) NOT NULL,
  `firstname` VARCHAR(32) NULL,
  `lastname` VARCHAR(32) NULL,
  `email` VARCHAR(255) NULL,
  `admin` TINYINT(1) UNSIGNED NOT NULL,
  `created_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`, `username`));


-- -----------------------------------------------------
-- Table `support`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `support`.`categories` ;

CREATE TABLE IF NOT EXISTS `support`.`categories` (
  `category_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `support`.`priority`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `support`.`priority` ;

CREATE TABLE IF NOT EXISTS `support`.`priority` (
  `priority_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `priority_name` VARCHAR(16) NOT NULL,
  `reponse_sla` SMALLINT UNSIGNED NOT NULL,
  `resolve_sla` SMALLINT UNSIGNED NOT NULL,
  `description` TEXT NOT NULL,
  PRIMARY KEY (`priority_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `support`.`tickets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `support`.`tickets` ;

CREATE TABLE IF NOT EXISTS `support`.`tickets` (
  `ticket_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ticket_num` VARCHAR(45) NULL,
  `title` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `ticket_client_id` INT UNSIGNED NOT NULL,
  `ticket_user_id` INT UNSIGNED NOT NULL,
  `ticket_category_id` INT UNSIGNED NOT NULL,
  `ticket_priority_id` INT UNSIGNED NOT NULL,
  `created_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ticket_id`, `ticket_client_id`, `ticket_user_id`, `ticket_category_id`, `ticket_priority_id`),
  CONSTRAINT `ticket_client_id`
    FOREIGN KEY (`ticket_client_id`)
    REFERENCES `support`.`clients` (`client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ticket_user_id`
    FOREIGN KEY (`ticket_user_id`)
    REFERENCES `support`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ticket_category_id`
    FOREIGN KEY (`ticket_category_id`)
    REFERENCES `support`.`categories` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ticket_priority_id`
    FOREIGN KEY (`ticket_priority_id`)
    REFERENCES `support`.`priority` (`priority_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `client_id_idx` ON `support`.`tickets` (`ticket_client_id` ASC);

CREATE INDEX `user_id_idx` ON `support`.`tickets` (`ticket_user_id` ASC);

CREATE INDEX `category_id_idx` ON `support`.`tickets` (`ticket_category_id` ASC);

CREATE INDEX `priority_id_idx` ON `support`.`tickets` (`ticket_priority_id` ASC);


-- -----------------------------------------------------
-- Table `support`.`updates`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `support`.`updates` ;

CREATE TABLE IF NOT EXISTS `support`.`updates` (
  `update_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `update_ticket_id` INT UNSIGNED NOT NULL,
  `update_user_id` INT UNSIGNED NOT NULL,
  `type` ENUM('Open','Work in Progress','Info Update','Closed') NOT NULL,
  `description` TEXT NULL,
  `created_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`update_id`),
  CONSTRAINT `update_ticket_id`
    FOREIGN KEY (`update_ticket_id`)
    REFERENCES `support`.`tickets` (`ticket_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `update_user_id`
    FOREIGN KEY (`update_user_id`)
    REFERENCES `support`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `ticket_id_idx` ON `support`.`updates` (`update_ticket_id` ASC);

CREATE INDEX `user_id_idx` ON `support`.`updates` (`update_user_id` ASC);


-- -----------------------------------------------------
-- Table `support`.`status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `support`.`status` ;

CREATE TABLE IF NOT EXISTS `support`.`status` (
  `status_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `status_name` ENUM('Open','Work in progress','Closed') NOT NULL,
  PRIMARY KEY (`status_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `support`.`tickets_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `support`.`tickets_status` ;

CREATE TABLE IF NOT EXISTS `support`.`tickets_status` (
  `tickets_status_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ts_ticket_id` INT UNSIGNED NOT NULL,
  `ts_status_id` INT UNSIGNED NOT NULL,
  `active` TINYINT(1) UNSIGNED NOT NULL,
  `created_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tickets_status_id`, `ts_ticket_id`, `ts_status_id`),
  CONSTRAINT `ts_ticket_id`
    FOREIGN KEY (`ts_ticket_id`)
    REFERENCES `support`.`tickets` (`ticket_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ts_status_id`
    FOREIGN KEY (`ts_status_id`)
    REFERENCES `support`.`status` (`status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `ticket_id_idx` ON `support`.`tickets_status` (`ts_ticket_id` ASC);

CREATE INDEX `status_id_idx` ON `support`.`tickets_status` (`ts_status_id` ASC);

USE `support`;

DELIMITER $$

USE `support`$$
DROP TRIGGER IF EXISTS `support`.`tickets_AFTER_INSERT` $$
USE `support`$$
CREATE TRIGGER `support`.`tickets_AFTER_INSERT` 
AFTER INSERT ON tickets FOR EACH ROW
BEGIN
	INSERT INTO tickets_status (ts_ticket_id,ts_status_id,active) values (new.ticket_id,'1','1');
    INSERT INTO updates (update_ticket_id,update_user_id,type,description) values (new.ticket_id,new.ticket_user_id,'Open','The ticket has been opened');
END;
    
$$


DELIMITER ;
SET SQL_MODE = '';
GRANT USAGE ON *.* TO db_user;
 DROP USER db_user;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'db_user' IDENTIFIED BY 'db_user';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `support`.* TO 'db_user';
SET SQL_MODE = '';
GRANT USAGE ON *.* TO db_owner;
 DROP USER db_owner;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'db_owner' IDENTIFIED BY 'db_owner';

GRANT ALL ON `support`.* TO 'db_owner';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `support`.`clients`
-- -----------------------------------------------------
START TRANSACTION;
USE `support`;
INSERT INTO `support`.`clients` (`client_id`, `firstname`, `lastname`, `email`) VALUES (DEFAULT, 'Simon', 'Holst', 'Simon.Holst@ab-inveb.com');
INSERT INTO `support`.`clients` (`client_id`, `firstname`, `lastname`, `email`) VALUES (DEFAULT, 'Rick', 'Lorenz', 'Rick.Lorenz@ab-inveb.com');
INSERT INTO `support`.`clients` (`client_id`, `firstname`, `lastname`, `email`) VALUES (DEFAULT, 'Maxim', 'Tretiakov', 'Maxim.Tretiakov@ab-inveb.com');
INSERT INTO `support`.`clients` (`client_id`, `firstname`, `lastname`, `email`) VALUES (DEFAULT, 'Michael', 'Lindhorst', 'Michael.Lindhorst@ab-inveb.com');
INSERT INTO `support`.`clients` (`client_id`, `firstname`, `lastname`, `email`) VALUES (DEFAULT, 'Stefan', 'Lindhorst', 'Stefan.Lindhorst@ab-inveb.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `support`.`users`
-- -----------------------------------------------------
START TRANSACTION;
USE `support`;
INSERT INTO `support`.`users` (`user_id`, `username`, `passwd`, `firstname`, `lastname`, `email`, `admin`, `created_time`) VALUES (1, 'dperez', 'dperez', 'Diego', 'P. Bacigalupe', 'd_perezbacigalupe@infosys.com', 1, DEFAULT);
INSERT INTO `support`.`users` (`user_id`, `username`, `passwd`, `firstname`, `lastname`, `email`, `admin`, `created_time`) VALUES (2, 'user', 'user', 'User', NULL, 'user@infosys.com', 0, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `support`.`categories`
-- -----------------------------------------------------
START TRANSACTION;
USE `support`;
INSERT INTO `support`.`categories` (`category_id`, `category_name`) VALUES (DEFAULT, 'Hardware');
INSERT INTO `support`.`categories` (`category_id`, `category_name`) VALUES (DEFAULT, 'Configuration');
INSERT INTO `support`.`categories` (`category_id`, `category_name`) VALUES (DEFAULT, 'SAP');
INSERT INTO `support`.`categories` (`category_id`, `category_name`) VALUES (DEFAULT, 'User');
INSERT INTO `support`.`categories` (`category_id`, `category_name`) VALUES (DEFAULT, 'Bug');

COMMIT;


-- -----------------------------------------------------
-- Data for table `support`.`priority`
-- -----------------------------------------------------
START TRANSACTION;
USE `support`;
INSERT INTO `support`.`priority` (`priority_id`, `priority_name`, `reponse_sla`, `resolve_sla`, `description`) VALUES (1, 'Urgent', 30, 90, 'Major Incident with high business impact. Blocked or incorrect use of critical Application for all Users, downgrade of performance does not allow continuing of usage. No feasible business Workaround available.');
INSERT INTO `support`.`priority` (`priority_id`, `priority_name`, `reponse_sla`, `resolve_sla`, `description`) VALUES (2, 'High', 60, 360, 'Blocking or Serious Incident. Incidents that do not guarantee normal execution of part of the critical Application but do not impede the usage of a downgraded part of the Application. No feasible business Workaround available.');
INSERT INTO `support`.`priority` (`priority_id`, `priority_name`, `reponse_sla`, `resolve_sla`, `description`) VALUES (3, 'Medium', 480, 480, 'Non-serious Incident without any impact on the operational functions of the Application. System functionality not working to specification but with a minimal business impact (impaired functionality, no significant loss of service, some operational inconvenience, but system Workaround feasible).');
INSERT INTO `support`.`priority` (`priority_id`, `priority_name`, `reponse_sla`, `resolve_sla`, `description`) VALUES (4, 'Low', 480, 1920, 'Minor Incident or inquiry. Few Users impacted with no business impact or minor functionality.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `support`.`status`
-- -----------------------------------------------------
START TRANSACTION;
USE `support`;
INSERT INTO `support`.`status` (`status_id`, `status_name`) VALUES (DEFAULT, 'Open');
INSERT INTO `support`.`status` (`status_id`, `status_name`) VALUES (DEFAULT, 'Work in Progress');
INSERT INTO `support`.`status` (`status_id`, `status_name`) VALUES (DEFAULT, 'Closed');

COMMIT;

