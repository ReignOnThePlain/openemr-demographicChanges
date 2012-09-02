SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';


DROP DATABASE demographics3;

CREATE DATABASE demographics3;
use demographics3;

-- CREATE SCHEMA IF NOT EXISTS `openemrdevdemographic` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
CREATE SCHEMA IF NOT EXISTS `openemrdevdemographic` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `openemrdevdemographic` ;

-- -----------------------------------------------------
-- Table `demographics3`.`contact`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`contact` (
  `contact_id` INT(11) NOT NULL ,
  `source_table` VARCHAR(255) NULL DEFAULT NULL COMMENT '[Values: person, business]' ,
  `source_table_id` INT(11) NOT NULL ,
  PRIMARY KEY (`contact_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci;


-- -----------------------------------------------------
-- Table `demographics3`.`person_secondary_contact`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`person_secondary_contact` (
  `person_secondary_contact_id` INT(11) NOT NULL ,
  `source_person_id` INT(11) NOT NULL ,
  `secondary_contact_person_id` INT(11) NOT NULL ,
  `priority` INT(11) NULL DEFAULT NULL ,
  `relationship` VARCHAR(255) NULL DEFAULT NULL COMMENT '[Values: Son, Daughter, Mother, Relative, Friend, Caregiver, Home Health Aide, Acquaintance, Other]' ,
  `is_guarantor` VARCHAR(45) NULL ,
  `is_guardian` BINARY NULL DEFAULT NULL COMMENT '[Values: Guardian, Power of Attorney, None]' ,
  `is_poa` BINARY NULL ,
  `is_insurance_subscriber` VARCHAR(45) NULL ,
  `date_created` VARCHAR(45) NULL ,
  `voided` VARCHAR(45) NULL ,
  `voided_by` VARCHAR(45) NULL ,
  `void_reason` VARCHAR(45) NULL ,
  PRIMARY KEY (`person_secondary_contact_id`, `secondary_contact_person_id`) ,
  INDEX `person_secondary_source_person` (`source_person_id` ASC) ,
  INDEX `person_secondary_contact_person` (`secondary_contact_person_id` ASC) ,
  CONSTRAINT `person_secondary_contact_person`
    FOREIGN KEY (`source_person_id` )
    REFERENCES `demographics3`.`person` (`person_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `demographics3`.`person`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`person` (
  `person_id` INT(11) NOT NULL ,
  `contact_id` INT(11) NOT NULL  ,
  `gender` VARCHAR(1) NULL DEFAULT NULL COMMENT 'Called Sex in OpenEMR and 255 characters' ,
  `social_security_number` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Called SS in OpenEMR' ,
  `mother_maiden_name` VARCHAR(255) NULL DEFAULT NULL ,
  `birthdate` DATE NULL DEFAULT NULL ,
  `employment_status` VARCHAR(255) NULL DEFAULT NULL ,
  `education_level` VARCHAR(255) NULL DEFAULT NULL ,
  `notes` VARCHAR(45) NULL ,
  `dead` INT(11) NULL DEFAULT NULL COMMENT 'May want something else' ,
  `death_date` DATE NULL DEFAULT NULL ,
  `cause_of_death` VARCHAR(255) NULL DEFAULT NULL ,
  `date_created` DATE NULL DEFAULT NULL ,
  `voided` INT(11) NULL DEFAULT NULL ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  INDEX `CONTACT_ID` (`contact_id` ASC) ,
  INDEX `person_person_secondary_contact` (`person_id` ASC) ,
  CONSTRAINT `person_ibfk_1`
    FOREIGN KEY (`contact_id` )
    REFERENCES `demographics3`.`contact` (`contact_id` ),
  CONSTRAINT `person_person_secondary_contact`
    FOREIGN KEY (`person_id` )
    REFERENCES `demographics3`.`person_secondary_contact` (`secondary_contact_person_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci;




-- -----------------------------------------------------
-- Table `demographics3`.`person_to_person_secondary_contact`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`person_to_person_secondary_contact` (
  `person_to_person_secondary_contact_id` INT NOT NULL AUTO_INCREMENT ,
  `person_id` INT NOT NULL ,
  `person_secondary_contact_id` INT NOT NULL ,
  PRIMARY KEY (`person_to_person_secondary_contact_id`) ,
  UNIQUE INDEX `person_to_person_secondary_contact_id_UNIQUE` (`person_to_person_secondary_contact_id` ASC) ,
  INDEX `fk_person_to_person_secondary_contact_person` (`person_id` ASC) ,
  CONSTRAINT `fk_person_to_person_secondary_contact_person`
    FOREIGN KEY (`person_id` )
    REFERENCES `demographics3`.`person` (`person_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demographics3`.`user`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT ,
  `person_id` INT NOT NULL ,
  `username` VARCHAR(45) NULL ,
  `password` VARCHAR(45) NULL ,
  `authorized` VARCHAR(45) NULL ,
  `dea_number` VARCHAR(45) NULL ,
  `npi` VARCHAR(45) NULL ,
  `upin` VARCHAR(45) NULL ,
  `taxonomy` VARCHAR(45) NULL ,
  `license_sate` VARCHAR(45) NULL ,
  `license_number` VARCHAR(45) NULL ,
  `notes` VARCHAR(45) NULL ,
  `active` VARCHAR(45) NULL ,
  `facility_id_default` VARCHAR(45) NULL ,
  `see_auth` VARCHAR(45) NULL ,
  `cal_ui` VARCHAR(45) NULL ,
  `ssi_relayhealth` VARCHAR(45) NULL ,
  `calendar` VARCHAR(45) NULL ,
  `pwd_expiration_date` VARCHAR(45) NULL ,
  `pwd_history1` VARCHAR(45) NULL ,
  `pwd_history2` VARCHAR(45) NULL ,
  `default_warehouse` VARCHAR(45) NULL ,
  `irnpool` VARCHAR(45) NULL ,
  `newcrop_user_rule` VARCHAR(45) NULL ,
  `user_user_id` INT NOT NULL ,
  PRIMARY KEY (`user_id`) ,
  INDEX `user_person` (`person_id` ASC) ,
  CONSTRAINT `user_person`
    FOREIGN KEY (`person_id` )
    REFERENCES `demographics3`.`person` (`person_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demographics3`.`patient`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`patient` (
  `patient_id` INT(11) NOT NULL DEFAULT '0' ,
  `person_id` INT(11) NULL DEFAULT NULL ,
  `referral_source_person_id` INT(11) NULL DEFAULT NULL ,
  `date_created` DATETIME NULL ,
  `voided` VARCHAR(45) NULL ,
  `voided_by` VARCHAR(45) NULL ,
  `date_voided` VARCHAR(45) NULL ,
  `voide_reason` VARCHAR(45) NULL ,
  PRIMARY KEY (`patient_id`) ,
  INDEX `person_id` (`person_id` ASC) ,
  INDEX `patient_id` (`patient_id` ASC) ,
  CONSTRAINT `patient_ibfk_1`
    FOREIGN KEY (`person_id` )
    REFERENCES `demographics3`.`person` (`person_id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `demographics3`.`insurance_company`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`insurance_company` (
  `insurance_company_id` INT NOT NULL ,
  `business_id` INT NOT NULL ,
  `cms_id` INT NOT NULL ,
  `freeb_type` VARCHAR(45) NULL ,
  `x12_receiver_id` VARCHAR(45) NULL ,
  `x12_default_partner_id` VARCHAR(45) NULL ,
  `alt_cms_id` VARCHAR(45) NULL ,
  PRIMARY KEY (`business_id`, `insurance_company_id`, `cms_id`),
  INDEX `insurance_company_id` (`insurance_company_id` ASC)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demographics3`.`patient_insurance`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`patient_insurance` (
  `patient_insurance_id` INT NOT NULL AUTO_INCREMENT ,
  `patient_id` INT NOT NULL ,
  `insurance_company_id` INT NOT NULL ,
  `priority` INT NULL ,
  `plan_name` VARCHAR(45) NULL ,
  `policy_no` VARCHAR(45) NULL ,
  `group_no` VARCHAR(45) NULL ,
  `policy_type` VARCHAR(45) NULL ,
  `copay` VARCHAR(45) NULL ,
  `accept_assignment` VARCHAR(45) NULL ,
  `subscriber_person_secondary_contact_id` VARCHAR(45) NULL ,
  `subscriber_person_employment_id` INT NULL ,
  `policy_start_date` VARCHAR(45) NULL ,
  `policy_end_date` VARCHAR(45) NULL ,
  `date_created` VARCHAR(45) NULL ,
  `voided` VARCHAR(45) NULL ,
  `voided_by` VARCHAR(45) NULL ,
  `date_voided` VARCHAR(45) NULL ,
  `void_reason` VARCHAR(45) NULL ,
  PRIMARY KEY (`patient_insurance_id`) ,
  INDEX `patient_id` (`patient_id` ASC) ,
  INDEX `insurance_company_id` (`insurance_company_id` ASC) ,
  CONSTRAINT `patient_patient_insurance`
    FOREIGN KEY (`patient_id` )
    REFERENCES `demographics3`.`patient` (`patient_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `insurance_company_patient_insurance`
    FOREIGN KEY (`insurance_company_id` )
    REFERENCES `demographics3`.`insurance_company` (`insurance_company_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demographics3`.`pharmacy`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`pharmacy` (
  `pharmacy_id` INT NOT NULL ,
  `business_id` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`pharmacy_id`, `business_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demographics3`.`patient_pharmacy`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`patient_pharmacy` (
  `patient_id` INT NOT NULL ,
  `pharmacy_id` INT NOT NULL ,
  `priority` VARCHAR(45) NULL ,
  INDEX `patient_patient_to_pharmacy` (`patient_id` ASC) ,
  INDEX `pharmacy_patient_to_pharmacy` (`pharmacy_id` ASC) ,
  CONSTRAINT `patient_patient_to_pharmacy`
    FOREIGN KEY (`patient_id` )
    REFERENCES `demographics3`.`patient` (`patient_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pharmacy_patient_to_pharmacy`
    FOREIGN KEY (`pharmacy_id` )
    REFERENCES `demographics3`.`pharmacy` (`pharmacy_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demographics3`.`home_health_agency`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`home_health_agency` (
  `home_health_agency_id` INT NOT NULL ,
  `business_id` INT NOT NULL ,
  PRIMARY KEY (`home_health_agency_id`, `business_id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demographics3`.`patient_home_health_agency`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`patient_home_health_agency` (
  `patient_id` INT NOT NULL ,
  `home_health_agency_id` INT NOT NULL ,
  `start_date` DATE NULL ,
  `end_date` DATE NULL ,
  `is_active` VARCHAR(45) NULL ,
  `date_created` VARCHAR(45) NULL ,
  `voided` VARCHAR(45) NULL ,
  `date_voided` VARCHAR(45) NULL ,
  `void_reason` VARCHAR(45) NULL ,
  INDEX `patient_patient_home_health` (`patient_id` ASC) ,
  INDEX `patient_home_health_agency_home_health` (`home_health_agency_id` ASC) ,
  CONSTRAINT `patient_patient_home_health`
    FOREIGN KEY (`patient_id` )
    REFERENCES `demographics3`.`patient` (`patient_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `patient_home_health_agency_home_health`
    FOREIGN KEY (`home_health_agency_id` )
    REFERENCES `demographics3`.`home_health_agency` (`home_health_agency_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demographics3`.`contact_address`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`contact_address` (
  `contact_address_id` INT NOT NULL ,
  `priority` INT NOT NULL  COMMENT 'integer, 1-5, 0=not set, -1=inactive' ,
  `type` VARCHAR(255) NULL DEFAULT NULL COMMENT '[Values: Physical, Mailing, Shipping]' ,
  `address_title` VARCHAR(45) NULL ,
  `street_line_1` VARCHAR(255) NULL DEFAULT NULL ,
  `street_line_2` VARCHAR(255) NULL DEFAULT NULL ,
  `city` VARCHAR(255) NULL DEFAULT NULL ,
  `state` VARCHAR(255) NULL DEFAULT NULL ,
  `postal_code` VARCHAR(255) NULL DEFAULT NULL ,
  `postal_code_suffix` VARCHAR(255) NULL DEFAULT NULL ,
  `country_code` VARCHAR(2) NULL DEFAULT NULL ,
  `area_name` VARCHAR(255) NULL DEFAULT NULL COMMENT 'neighborhood name, or apartment complex name, or facility name' ,
  `area_type` VARCHAR(255) NULL DEFAULT NULL COMMENT '[Values: Assisted Living Facility, Nursing Home, Neighborhood, Apartment Complex, Independent Living Facility]' ,
  `is_billing` BINARY NULL ,
  `is_mailing` BINARY NULL ,
  `directions` TEXT NULL DEFAULT NULL COMMENT 'Limited to 65K Characters' ,
  `notes` TEXT NULL DEFAULT NULL COMMENT 'Limited to 65K Characters' ,
  `created_date` DATETIME NULL DEFAULT NULL ,
  `activated_date` DATETIME NULL DEFAULT NULL ,
  `inactivated_date` DATETIME NULL DEFAULT NULL ,
  `inactivated_reason` VARCHAR(255) NULL DEFAULT NULL COMMENT '[Values: Moved, Mail Returned, etc]' ,
  PRIMARY KEY (`contact_address_id`, `priority`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `demographics3`.`business`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`business` (
  `business_id` INT(11) NOT NULL ,
  `contact_id` INT(11) NOT NULL ,
  `type` VARCHAR(255) NULL DEFAULT NULL COMMENT '[Values: Laboratory, Imaging, Facility, Specialist, Vendor, DME, Immunization Service, Pharmacy, Other]' ,
  `subtype` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Certain subtypes can only go with certain types.\n	[Specialists: GI, Pulmonary, ...]\n	[Vendors: Office, Medications, Medical Supplies\n	[DME: Oxygen, General. . .]\n	[Facilities: Assisted Living Facility, Hospital, Nursing Home]' ,
  `date_created` DATE NULL DEFAULT NULL ,
  `voided` INT(11) NULL DEFAULT NULL ,
  `voided_by` INT(11) NULL DEFAULT NULL ,
  `date_voided` DATE NULL DEFAULT NULL ,
  `void_reason` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`business_id`) ,
  INDEX `contact_id` (`contact_id` ASC) ,
  CONSTRAINT `business_ibfk_1`
    FOREIGN KEY (`contact_id` )
    REFERENCES `demographics3`.`contact` (`contact_id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `demographics3`.`facility`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`facility` (
  `facility_id` INT NOT NULL ,
  `business_id` INT NOT NULL ,
  `contact_address_id` INT NOT NULL ,
  `federal_ein` VARCHAR(45) NULL ,
  `service_location` VARCHAR(45) NULL ,
  `billing_location` VARCHAR(45) NULL ,
  `accepts_assignment` VARCHAR(45) NULL ,
  `pos_code` VARCHAR(45) NULL ,
  `x12_sender_id` VARCHAR(45) NULL ,
  `attn` VARCHAR(45) NULL ,
  `domain_identifier` VARCHAR(45) NULL ,
  `facility_npi` VARCHAR(45) NULL ,
  `tax_id_type` VARCHAR(45) NULL ,
  `color` VARCHAR(45) NULL ,
  `primary_business_entity` VARCHAR(45) NULL ,
  PRIMARY KEY (`facility_id`) ,
  INDEX `facility_contact_address` (`contact_address_id` ASC) ,
  INDEX `facility_business` (`business_id` ASC) ,
  CONSTRAINT `facility_contact_address`
    FOREIGN KEY (`contact_address_id` )
    REFERENCES `demographics3`.`contact_address` (`contact_address_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `facility_business`
    FOREIGN KEY (`business_id` )
    REFERENCES `demographics3`.`business` (`business_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `demographics3`.`business_to_source_table`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`business_to_source_table` (
  `business_id` INT NOT NULL ,
  `foreign_key_id` INT NOT NULL ,
  `source_table` VARCHAR(45) NULL ,
  PRIMARY KEY (`foreign_key_id`) ,
  INDEX `business_to_business_source` (`business_id` ASC) ,
  CONSTRAINT `business_to_business_source0`
    FOREIGN KEY (`business_id` )
    REFERENCES `demographics3`.`business` (`business_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `openemrdevdemographic` ;

-- -----------------------------------------------------
-- Table `demographics3`.`business_name`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`business_name` (
  `business_name_id` INT(11) NOT NULL ,
  `business_id` INT(11) NOT NULL ,
  `business_name` VARCHAR(255) NULL DEFAULT NULL ,
  `type` VARCHAR(255) NULL DEFAULT NULL COMMENT '[Values: Corporate Name, Business Name, Abbreviated Name]' ,
  `priority` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`business_name_id`) ,
  INDEX `business_id` (`business_id` ASC) ,
  CONSTRAINT `business_name_ibfk_1`
    FOREIGN KEY (`business_id` )
    REFERENCES `demographics3`.`business` (`business_id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `demographics3`.`contact_email_web`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`contact_email_web` (
  `contact_email_web_id` INT(11) NOT NULL ,
  `priority` INT(11) NULL DEFAULT NULL COMMENT 'integer, 1-5, 0=not set, -1=inactive' ,
  `type` VARCHAR(255) NULL DEFAULT NULL COMMENT '[Values: email_business, email_personal, website_business, website_personal, other]' ,
  `created_date` DATETIME NULL DEFAULT NULL ,
  `activated_date` DATETIME NULL DEFAULT NULL ,
  `inactivated_date` DATETIME NULL DEFAULT NULL ,
  `inactivated_reason` VARCHAR(255) NULL DEFAULT NULL COMMENT '[Values: Moved, Mail Returned, etc]' ,
  PRIMARY KEY (`contact_email_web_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `demographics3`.`contact_telephone`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`contact_telephone` (
  `contact_telephone_id` INT NOT NULL ,
  `contact_address_id` INT NOT NULL ,
  `priority` INT NULL DEFAULT NULL ,
  `type` VARCHAR(255) NULL DEFAULT NULL COMMENT '[Values: Home, FAX, Cell, Work]' ,
  `telephone_number` VARCHAR(255) NULL DEFAULT NULL ,
  `is_sms_enabled` BINARY NULL DEFAULT NULL ,
  `notes` TEXT NULL DEFAULT NULL COMMENT 'Limited to 65K Characters' ,
  `created_date` DATETIME NULL DEFAULT NULL ,
  `activated_date` DATETIME NULL DEFAULT NULL ,
  `inactivated_date` DATETIME NULL DEFAULT NULL ,
  `inactivated_reason` VARCHAR(255) NULL DEFAULT NULL COMMENT '[Values: Changed Number, Disconnected, etc]' ,
  PRIMARY KEY (`contact_telephone_id`) ,
  INDEX `contact_telephone_contact_address` (`contact_address_id` ASC) ,
  CONSTRAINT `contact_telephone_contact_address`
    FOREIGN KEY (`contact_address_id` )
    REFERENCES `demographics3`.`contact_address` (`contact_address_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `demographics3`.`data_history_log`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`data_history_log` (
  `data_history_log_id` INT(11) NOT NULL ,
  `source_table` VARCHAR(255) NULL DEFAULT NULL ,
  `source_table_id` INT(11) NOT NULL ,
  `field` VARCHAR(255) NULL DEFAULT NULL ,
  `previous_value` VARCHAR(255) NULL DEFAULT NULL COMMENT '-- is this redundant? Do we need this?' ,
  `new_value` VARCHAR(255) NULL DEFAULT NULL ,
  `date_changed` DATETIME NULL DEFAULT NULL ,
  `user` INT(11) NOT NULL ,
  PRIMARY KEY (`data_history_log_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `demographics3`.`patient_copy_results_to`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`patient_copy_results_to` (
  `patient_copy_results_to_id` INT(11) NOT NULL ,
  `patient_id` INT(11) NOT NULL ,
  `foreign_key_id` INT(11) NOT NULL ,
  `source_table` VARCHAR(255) NULL DEFAULT NULL ,
  `method_of_contact` VARCHAR(255) NULL DEFAULT NULL ,
  `relationship` VARCHAR(255) NULL DEFAULT NULL COMMENT '[Values: Son, Daughter, Mother, Relative, Friend, Caregiver, Home Health Aide, Acquaintance, Other]' ,
  PRIMARY KEY (`patient_copy_results_to_id`) ,
  INDEX `patient_id` (`patient_id` ASC) ,
  CONSTRAINT `patient_copy_results_to_ibfk_1`
    FOREIGN KEY (`patient_id` )
    REFERENCES `demographics3`.`patient` (`patient_id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `demographics3`.`patient_copy_results_to_type`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`patient_copy_results_to_type` (
  `patient_copy_results_to_type_id` INT(11) NOT NULL ,
  `patient_copy_results_to_id` INT(11) NOT NULL ,
  `type_id` INT(11) NOT NULL ,
  PRIMARY KEY (`patient_copy_results_to_type_id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `demographics3`.`patient_medical_providers`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`patient_medical_providers` (
  `patient_medical_providers_id` INT(11) NOT NULL ,
  `patient_id` INT(11) NOT NULL ,
  `business_id` INT(11) NOT NULL ,
  `start_date` DATETIME NULL DEFAULT NULL ,
  `end_date` DATETIME NULL DEFAULT NULL ,
  `notes` TEXT NULL DEFAULT NULL ,
  PRIMARY KEY (`patient_medical_providers_id`) ,
  INDEX `patient_id` (`patient_id` ASC) ,
  INDEX `business_id` (`business_id` ASC) ,
  CONSTRAINT `patient_medical_providers_ibfk_1`
    FOREIGN KEY (`patient_id` )
    REFERENCES `demographics3`.`patient` (`patient_id` ),
  CONSTRAINT `patient_medical_providers_ibfk_2`
    FOREIGN KEY (`business_id` )
    REFERENCES `demographics3`.`business` (`business_id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `demographics3`.`person_employment`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`person_employment` (
  `person_employment_id` INT(11) NOT NULL ,
  `person_id` INT(11) NOT NULL ,
  `business_id` INT(11) NOT NULL ,
  `occupation` VARCHAR(255) NULL DEFAULT NULL ,
  `title` VARCHAR(255) NULL DEFAULT NULL ,
  `start_date` DATE NULL DEFAULT NULL ,
  `end_date` DATE NULL DEFAULT NULL ,
  PRIMARY KEY (`person_employment_id`) ,
  INDEX `person_id` (`person_id` ASC) ,
  INDEX `business_id` (`business_id` ASC) ,
  CONSTRAINT `person_employment_ibfk_1`
    FOREIGN KEY (`person_id` )
    REFERENCES `demographics3`.`person` (`person_id` ),
  CONSTRAINT `person_employment_ibfk_2`
    FOREIGN KEY (`business_id` )
    REFERENCES `demographics3`.`business` (`business_id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `demographics3`.`person_first_name`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`person_first_name` (
  `person_first_name_id` INT(11) NOT NULL ,
  `person_id` INT(11) NOT NULL ,
  `person_first_name` VARCHAR(255) NULL DEFAULT NULL ,
  `priority` INT(11) NULL DEFAULT NULL ,
  `type` VARCHAR(255) NULL DEFAULT NULL COMMENT '[Values: Legal, Nickname]' ,
  PRIMARY KEY (`person_first_name_id`) ,
  INDEX `person_id` (`person_id` ASC) ,
  CONSTRAINT `person_first_name_ibfk_1`
    FOREIGN KEY (`person_id` )
    REFERENCES `demographics3`.`person` (`person_id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `demographics3`.`person_language`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`person_language` (
  `person_language_id` INT(11) NOT NULL ,
  `person_id` INT(11) NOT NULL ,
  `language` VARCHAR(255) NULL DEFAULT NULL ,
  `fluency` INT(11) NULL DEFAULT NULL ,
  `priority` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`person_language_id`) ,
  INDEX `person_id` (`person_id` ASC) ,
  CONSTRAINT `person_language_ibfk_1`
    FOREIGN KEY (`person_id` )
    REFERENCES `demographics3`.`person` (`person_id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `demographics3`.`person_last_name`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`person_last_name` (
  `person_last_name_id` INT(11) NOT NULL ,
  `person_id` INT(11) NOT NULL ,
  `person_last_name` VARCHAR(255) NULL DEFAULT NULL ,
  `priority` INT(11) NULL DEFAULT NULL ,
  `type` VARCHAR(255) NULL DEFAULT NULL COMMENT '[Values: Maiden Name, Married Name, Other]' ,
  PRIMARY KEY (`person_last_name_id`) ,
  INDEX `person_id` (`person_id` ASC) ,
  CONSTRAINT `person_last_name_ibfk_1`
    FOREIGN KEY (`person_id` )
    REFERENCES `demographics3`.`person` (`person_id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `demographics3`.`person_to_source_table`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`person_to_source_table` (
  `person_id` INT(11) NOT NULL ,
  `foreign_key_id` INT(11) NOT NULL  ,
  `source_table` VARCHAR(255) NULL DEFAULT NULL COMMENT '[Values: patient_data, patient_secondary_contact, users, address_book]' ,
  INDEX `person_id` (`person_id` ASC) ,
  PRIMARY KEY (`foreign_key_id`) ,
  CONSTRAINT `person_to_source_ibfk_1`
    FOREIGN KEY (`person_id` )
    REFERENCES `demographics3`.`person` (`person_id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `demographics3`.`contact_to_contact_telephone`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`contact_to_contact_telephone` (
  `contact_id` INT(11) NOT NULL ,
  `contact_telephone_id` INT(11) NOT NULL ,
  INDEX `contact_id` (`contact_id` ASC) ,
  INDEX `contact_telephone_id` (`contact_telephone_id` ASC) ,
  CONSTRAINT `contact_to_contact_telephone_ibfk_1`
    FOREIGN KEY (`contact_id` )
    REFERENCES `demographics3`.`contact` (`contact_id` ),
  CONSTRAINT `contact_to_contact_telephone_ibfk_2`
    FOREIGN KEY (`contact_telephone_id` )
    REFERENCES `demographics3`.`contact_telephone` (`contact_telephone_id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci;


-- -----------------------------------------------------
-- Table `demographics3`.`contact_to_contact_address`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`contact_to_contact_address` (
  `contact_id` INT(11) NOT NULL ,
  `contact_address_id` INT(11) NOT NULL ,
  INDEX `contact_id` (`contact_id` ASC) ,
  INDEX `contact_address_id` (`contact_address_id` ASC) ,
  CONSTRAINT `contact_to_contact_address_ibfk_1`
    FOREIGN KEY (`contact_id` )
    REFERENCES `demographics3`.`contact` (`contact_id` ),
  CONSTRAINT `contact_to_contact_address_ibfk_2`
    FOREIGN KEY (`contact_address_id` )
    REFERENCES `demographics3`.`contact_address` (`contact_address_id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci;


-- -----------------------------------------------------
-- Table `demographics3`.`contact_to_contact_email_web`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `demographics3`.`contact_to_contact_email_web` (
  `contact_id` INT(11) NOT NULL ,
  `contact_email_web_id` INT(11) NOT NULL ,
  INDEX `contact_id` (`contact_id` ASC) ,
  INDEX `contact_email_web_id` (`contact_email_web_id` ASC) ,
  CONSTRAINT `contact_to_contact_email_web_ibfk_1`
    FOREIGN KEY (`contact_id` )
    REFERENCES `demographics3`.`contact` (`contact_id` ),
  CONSTRAINT `contact_to_contact_email_web_ibfk_2`
    FOREIGN KEY (`contact_email_web_id` )
    REFERENCES `demographics3`.`contact_email_web` (`contact_email_web_id` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
