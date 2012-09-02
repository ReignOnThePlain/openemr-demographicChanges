CREATE DATABASE  IF NOT EXISTS `demographics-test` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `demographics-test`;
-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: localhost    Database: demographics-test
-- ------------------------------------------------------
-- Server version	5.5.24

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `person_secondary_contact`
--

DROP TABLE IF EXISTS `person_secondary_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_secondary_contact` (
  `person_secondary_contact_id` int(11) NOT NULL AUTO_INCREMENT,
  `source_person_id` int(11) NOT NULL,
  `secondary_contact_person_id` int(11) NOT NULL,
  `priority` int(11) DEFAULT NULL,
  `relationship` varchar(255) DEFAULT NULL COMMENT '[Values: Son, Daughter, Mother, Relative, Friend, Caregiver, Home Health Aide, Acquaintance, Other]',
  `is_guarantor` varchar(45) DEFAULT NULL,
  `is_guardian` binary(1) DEFAULT NULL COMMENT '[Values: Guardian, Power of Attorney, None]',
  `is_poa` binary(1) DEFAULT NULL,
  `is_insurance_subscriber` varchar(45) DEFAULT NULL,
  `date_created` varchar(45) DEFAULT NULL,
  `voided` varchar(45) DEFAULT NULL,
  `voided_by` varchar(45) DEFAULT NULL,
  `void_reason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`person_secondary_contact_id`,`secondary_contact_person_id`),
  KEY `person_secondary_source_person` (`source_person_id`),
  KEY `person_secondary_contact_person` (`secondary_contact_person_id`),
  CONSTRAINT `person_secondary_contact_person` FOREIGN KEY (`source_person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=213 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_pharmacy`
--

DROP TABLE IF EXISTS `patient_pharmacy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_pharmacy` (
  `patient_id` int(11) NOT NULL,
  `pharmacy_id` int(11) NOT NULL,
  `priority` varchar(45) DEFAULT NULL,
  KEY `patient_patient_to_pharmacy` (`patient_id`),
  KEY `pharmacy_patient_to_pharmacy` (`pharmacy_id`),
  CONSTRAINT `patient_patient_to_pharmacy` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact_to_contact_address`
--

DROP TABLE IF EXISTS `contact_to_contact_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_to_contact_address` (
  `contact_id` int(11) NOT NULL,
  `contact_address_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`contact_address_id`),
  KEY `contact_id` (`contact_id`),
  KEY `contact_address_id` (`contact_address_id`),
  CONSTRAINT `contact_to_contact_address_ibfk_1` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=239 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facility`
--

DROP TABLE IF EXISTS `facility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facility` (
  `facility_id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `contact_address_id` int(11) NOT NULL,
  `federal_ein` varchar(45) DEFAULT NULL,
  `service_location` varchar(45) DEFAULT NULL,
  `billing_location` varchar(45) DEFAULT NULL,
  `accepts_assignment` varchar(45) DEFAULT NULL,
  `pos_code` varchar(45) DEFAULT NULL,
  `x12_sender_id` varchar(45) DEFAULT NULL,
  `attn` varchar(45) DEFAULT NULL,
  `domain_identifier` varchar(45) DEFAULT NULL,
  `facility_npi` varchar(45) DEFAULT NULL,
  `tax_id_type` varchar(45) DEFAULT NULL,
  `color` varchar(45) DEFAULT NULL,
  `primary_business_entity` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`facility_id`),
  KEY `facility_contact_address` (`contact_address_id`),
  KEY `facility_business` (`business_id`),
  CONSTRAINT `facility_business` FOREIGN KEY (`business_id`) REFERENCES `business` (`business_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `facility_contact_address` FOREIGN KEY (`contact_address_id`) REFERENCES `contact_address` (`contact_address_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact_to_contact_telephone`
--

DROP TABLE IF EXISTS `contact_to_contact_telephone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_to_contact_telephone` (
  `contact_id` int(11) NOT NULL,
  `contact_telephone_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`contact_telephone_id`),
  KEY `contact_id` (`contact_id`),
  KEY `contact_telephone_id` (`contact_telephone_id`),
  CONSTRAINT `contact_to_contact_telephone_ibfk_1` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=788 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `home_health_agency`
--

DROP TABLE IF EXISTS `home_health_agency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `home_health_agency` (
  `home_health_agency_id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  PRIMARY KEY (`home_health_agency_id`,`business_id`),
  KEY `homeHealth_ibfk_1` (`business_id`),
  CONSTRAINT `homeHealth_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `business` (`business_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact_address`
--

DROP TABLE IF EXISTS `contact_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_address` (
  `contact_address_id` int(11) NOT NULL,
  `priority` int(11) NOT NULL COMMENT 'integer, 1-5, 0=not set, -1=inactive',
  `type` varchar(255) DEFAULT NULL COMMENT '[Values: Physical, Mailing, Shipping]',
  `address_title` varchar(45) DEFAULT NULL,
  `street_line_1` varchar(255) DEFAULT NULL,
  `street_line_2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `postal_code_suffix` varchar(255) DEFAULT NULL,
  `country_code` varchar(2) DEFAULT NULL,
  `area_name` varchar(255) DEFAULT NULL COMMENT 'neighborhood name, or apartment complex name, or facility name',
  `area_type` varchar(255) DEFAULT NULL COMMENT '[Values: Assisted Living Facility, Nursing Home, Neighborhood, Apartment Complex, Independent Living Facility]',
  `is_billing` binary(1) DEFAULT NULL,
  `is_mailing` binary(1) DEFAULT NULL,
  `directions` text COMMENT 'Limited to 65K Characters',
  `notes` text COMMENT 'Limited to 65K Characters',
  `created_date` datetime DEFAULT NULL,
  `activated_date` datetime DEFAULT NULL,
  `inactivated_date` datetime DEFAULT NULL,
  `inactivated_reason` varchar(255) DEFAULT NULL COMMENT '[Values: Moved, Mail Returned, etc]',
  PRIMARY KEY (`contact_address_id`,`priority`),
  KEY `contact_to_contact_address` (`contact_address_id`),
  CONSTRAINT `contact_to_contact_address` FOREIGN KEY (`contact_address_id`) REFERENCES `contact_to_contact_address` (`contact_address_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `business_to_source_table`
--

DROP TABLE IF EXISTS `business_to_source_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_to_source_table` (
  `business_id` int(11) NOT NULL,
  `foreign_key_id` int(11) NOT NULL,
  `source_table` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`foreign_key_id`),
  KEY `business_to_business_source` (`business_id`),
  CONSTRAINT `business_to_business_source0` FOREIGN KEY (`business_id`) REFERENCES `business` (`business_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_history_log`
--

DROP TABLE IF EXISTS `data_history_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_history_log` (
  `data_history_log_id` int(11) NOT NULL,
  `source_table` varchar(255) DEFAULT NULL,
  `source_table_id` int(11) NOT NULL,
  `field` varchar(255) DEFAULT NULL,
  `previous_value` varchar(255) DEFAULT NULL COMMENT '-- is this redundant? Do we need this?',
  `new_value` varchar(255) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `user` int(11) NOT NULL,
  PRIMARY KEY (`data_history_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `referral_source_person_id` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `voided` varchar(45) DEFAULT NULL,
  `voided_by` varchar(45) DEFAULT NULL,
  `date_voided` varchar(45) DEFAULT NULL,
  `voide_reason` varchar(45) DEFAULT NULL,
  `interpretter` varchar(255) DEFAULT NULL,
  `financial_review` datetime DEFAULT NULL,
  `pubpid` varchar(255) DEFAULT NULL,
  `genericname1` varchar(255) DEFAULT NULL,
  `genericval1` varchar(255) DEFAULT NULL,
  `genericname2` varchar(255) DEFAULT NULL,
  `genericval2` varchar(255) DEFAULT NULL,
  `hipaa_mail` varchar(3) DEFAULT NULL,
  `hipaa_voice` varchar(3) DEFAULT NULL,
  `hipaa_notice` varchar(3) DEFAULT NULL,
  `hipaa_message` varchar(20) DEFAULT NULL,
  `hipaa_allowsms` varchar(3) DEFAULT NULL,
  `hipaa_allowemail` varchar(3) DEFAULT NULL,
  `squad` varchar(32) DEFAULT NULL,
  `fitness` int(11) DEFAULT NULL,
  `usertext1` varchar(255) DEFAULT NULL,
  `usertext2` varchar(255) DEFAULT NULL,
  `usertext3` varchar(255) DEFAULT NULL,
  `usertext4` varchar(255) DEFAULT NULL,
  `usertext5` varchar(255) DEFAULT NULL,
  `usertext6` varchar(255) DEFAULT NULL,
  `usertext7` varchar(255) DEFAULT NULL,
  `usertext8` varchar(255) DEFAULT NULL,
  `userlist1` varchar(255) DEFAULT NULL,
  `userlist2` varchar(255) DEFAULT NULL,
  `userlist3` varchar(255) DEFAULT NULL,
  `userlist4` varchar(255) DEFAULT NULL,
  `userlist5` varchar(255) DEFAULT NULL,
  `userlist6` varchar(255) DEFAULT NULL,
  `userlist7` varchar(255) DEFAULT NULL,
  `pricelevel` varchar(255) DEFAULT NULL,
  `regdate` date DEFAULT NULL,
  `contrastart` date DEFAULT NULL,
  `completed_ad` varchar(3) DEFAULT NULL,
  `ad_reviewed` date DEFAULT NULL,
  `vfc` varchar(255) DEFAULT NULL,
  `allow_imm_reg_use` varchar(255) DEFAULT NULL,
  `allow_imm_info_share` varchar(255) DEFAULT NULL,
  `allow_health_info_ex` varchar(255) DEFAULT NULL,
  `allow_patient_portal` varchar(31) DEFAULT NULL,
  `imported_patient_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`patient_id`),
  KEY `person_id` (`person_id`),
  KEY `patient_id` (`patient_id`),
  KEY `patient_ibfk_2` (`referral_source_person_id`),
  CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`),
  CONSTRAINT `patient_ibfk_2` FOREIGN KEY (`referral_source_person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact_telephone`
--

DROP TABLE IF EXISTS `contact_telephone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_telephone` (
  `contact_telephone_id` int(11) NOT NULL,
  `contact_address_id` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT '[Values: Home, FAX, Cell, Work]',
  `telephone_number` varchar(255) DEFAULT NULL,
  `is_sms_enabled` binary(1) DEFAULT NULL,
  `notes` text COMMENT 'Limited to 65K Characters',
  `created_date` datetime DEFAULT NULL,
  `activated_date` datetime DEFAULT NULL,
  `inactivated_date` datetime DEFAULT NULL,
  `inactivated_reason` varchar(255) DEFAULT NULL COMMENT '[Values: Changed Number, Disconnected, etc]',
  `country_code` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`contact_telephone_id`),
  KEY `contact_telephone_contact_address` (`contact_address_id`),
  KEY `contact_to_contact_telephone` (`contact_telephone_id`),
  CONSTRAINT `contact_telephone_contact_address` FOREIGN KEY (`contact_address_id`) REFERENCES `contact_address` (`contact_address_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `contact_to_contact_telephone` FOREIGN KEY (`contact_telephone_id`) REFERENCES `contact_to_contact_telephone` (`contact_telephone_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pharmacy`
--

DROP TABLE IF EXISTS `pharmacy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pharmacy` (
  `pharmacy_id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `is_compounding` tinyint(1) NOT NULL DEFAULT '0',
  `transmit_method` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`pharmacy_id`,`business_id`),
  KEY `id_pharmacy_id` (`pharmacy_id`),
  KEY `id_business_id` (`business_id`),
  CONSTRAINT `pharmacy_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `business` (`business_id`),
  CONSTRAINT `pharmacy_ibfk_2` FOREIGN KEY (`pharmacy_id`) REFERENCES `patient_pharmacy` (`pharmacy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person_employment`
--

DROP TABLE IF EXISTS `person_employment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_employment` (
  `person_employment_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `business_id` int(11) DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`person_employment_id`),
  KEY `person_id` (`person_id`),
  KEY `business_id` (`business_id`),
  CONSTRAINT `person_employment_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`),
  CONSTRAINT `person_employment_ibfk_2` FOREIGN KEY (`business_id`) REFERENCES `business` (`business_id`)
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_insurance`
--

DROP TABLE IF EXISTS `patient_insurance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_insurance` (
  `patient_insurance_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `insurance_company_id` int(11) NOT NULL,
  `priority` int(11) DEFAULT NULL,
  `plan_name` varchar(45) DEFAULT NULL,
  `policy_no` varchar(45) DEFAULT NULL,
  `group_no` varchar(45) DEFAULT NULL,
  `policy_type` varchar(45) DEFAULT NULL,
  `copay` varchar(45) DEFAULT NULL,
  `accept_assignment` varchar(45) DEFAULT NULL,
  `subscriber_person_secondary_contact_id` varchar(45) DEFAULT NULL,
  `subscriber_person_employment_id` int(11) DEFAULT NULL,
  `policy_start_date` varchar(45) DEFAULT NULL,
  `policy_end_date` varchar(45) DEFAULT NULL,
  `date_created` varchar(45) DEFAULT NULL,
  `voided` varchar(45) DEFAULT NULL,
  `voided_by` varchar(45) DEFAULT NULL,
  `date_voided` varchar(45) DEFAULT NULL,
  `void_reason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`patient_insurance_id`),
  KEY `patient_id` (`patient_id`),
  KEY `insurance_company_id` (`insurance_company_id`),
  CONSTRAINT `insurance_company_patient_insurance` FOREIGN KEY (`insurance_company_id`) REFERENCES `insurance_company` (`insurance_company_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_patient_insurance` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact_email_web`
--

DROP TABLE IF EXISTS `contact_email_web`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_email_web` (
  `contact_email_web_id` int(11) NOT NULL,
  `priority` int(11) DEFAULT NULL COMMENT 'integer, 1-5, 0=not set, -1=inactive',
  `type` varchar(255) DEFAULT NULL COMMENT '[Values: email_business, email_personal, website_business, website_personal, other]',
  `created_date` datetime DEFAULT NULL,
  `activated_date` datetime DEFAULT NULL,
  `inactivated_date` datetime DEFAULT NULL,
  `inactivated_reason` varchar(255) DEFAULT NULL COMMENT '[Values: Moved, Mail Returned, etc]',
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`contact_email_web_id`),
  KEY `contact_contact_email_web` (`contact_email_web_id`),
  CONSTRAINT `contact_contact_email_web` FOREIGN KEY (`contact_email_web_id`) REFERENCES `contact_to_contact_email_web` (`contact_email_web_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact_to_contact_email_web`
--

DROP TABLE IF EXISTS `contact_to_contact_email_web`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_to_contact_email_web` (
  `contact_id` int(11) NOT NULL,
  `contact_email_web_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`contact_email_web_id`),
  KEY `contact_id` (`contact_id`),
  KEY `contact_email_web_id` (`contact_email_web_id`),
  CONSTRAINT `contact_to_contact_email_web_ibfk_1` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=224 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person_name`
--

DROP TABLE IF EXISTS `person_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_name` (
  `person_name_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `person_last_name` varchar(255) DEFAULT NULL,
  `person_first_name` varchar(255) DEFAULT NULL,
  `person_middle_name` varchar(255) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT '[Values: Maiden Name, Married Name, Other]',
  PRIMARY KEY (`person_name_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `person_name_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=325 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_copy_results_to_type`
--

DROP TABLE IF EXISTS `patient_copy_results_to_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_copy_results_to_type` (
  `patient_copy_results_to_type_id` int(11) NOT NULL,
  `patient_copy_results_to_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`patient_copy_results_to_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `business`
--

DROP TABLE IF EXISTS `business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business` (
  `business_id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_id` int(11) NOT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT '[Values: Laboratory, Imaging, Facility, Specialist, Vendor, DME, Immunization Service, Pharmacy, Other]',
  `subtype` varchar(255) DEFAULT NULL COMMENT 'Certain subtypes can only go with certain types.\n	[Specialists: GI, Pulmonary, ...]\n	[Vendors: Office, Medications, Medical Supplies\n	[DME: Oxygen, General. . .]\n	[Facilities: Assisted Living Facility, Hospital, Nursing Home]',
  `date_created` date DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` date DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`business_id`),
  KEY `contact_id` (`contact_id`),
  CONSTRAINT `business_ibfk_1` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person_language`
--

DROP TABLE IF EXISTS `person_language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_language` (
  `person_language_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `language` varchar(255) DEFAULT NULL,
  `fluency` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  PRIMARY KEY (`person_language_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `person_language_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_medical_providers`
--

DROP TABLE IF EXISTS `patient_medical_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_medical_providers` (
  `patient_medical_providers_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`patient_medical_providers_id`),
  KEY `patient_id` (`patient_id`),
  KEY `business_id` (`business_id`),
  CONSTRAINT `patient_medical_providers_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `patient_medical_providers_ibfk_2` FOREIGN KEY (`business_id`) REFERENCES `business` (`business_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `insurance_company`
--

DROP TABLE IF EXISTS `insurance_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insurance_company` (
  `insurance_company_id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `cms_id` int(11) NOT NULL,
  `freeb_type` varchar(45) DEFAULT NULL,
  `x12_receiver_id` varchar(45) DEFAULT NULL,
  `x12_default_partner_id` varchar(45) DEFAULT NULL,
  `alt_cms_id` varchar(45) DEFAULT NULL,
  `old_insurance_company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`insurance_company_id`,`cms_id`),
  KEY `insurance_company_id` (`insurance_company_id`),
  KEY `Insurance Company to Business` (`business_id`),
  CONSTRAINT `Insurance Company to Business` FOREIGN KEY (`business_id`) REFERENCES `business` (`business_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `authorized` varchar(45) DEFAULT NULL,
  `dea_number` varchar(45) DEFAULT NULL,
  `npi` varchar(45) DEFAULT NULL,
  `upin` varchar(45) DEFAULT NULL,
  `taxonomy` varchar(45) DEFAULT NULL,
  `license_sate` varchar(45) DEFAULT NULL,
  `license_number` varchar(45) DEFAULT NULL,
  `notes` varchar(45) DEFAULT NULL,
  `active` varchar(45) DEFAULT NULL,
  `facility_id_default` varchar(45) DEFAULT NULL,
  `see_auth` varchar(45) DEFAULT NULL,
  `cal_ui` varchar(45) DEFAULT NULL,
  `ssi_relayhealth` varchar(45) DEFAULT NULL,
  `calendar` varchar(45) DEFAULT NULL,
  `pwd_expiration_date` varchar(45) DEFAULT NULL,
  `pwd_history1` varchar(45) DEFAULT NULL,
  `pwd_history2` varchar(45) DEFAULT NULL,
  `default_warehouse` varchar(45) DEFAULT NULL,
  `irnpool` varchar(45) DEFAULT NULL,
  `newcrop_user_rule` varchar(45) DEFAULT NULL,
  `user_user_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `user_person` (`person_id`),
  CONSTRAINT `user_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_home_health_agency`
--

DROP TABLE IF EXISTS `patient_home_health_agency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_home_health_agency` (
  `patient_id` int(11) NOT NULL,
  `home_health_agency_id` int(11) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `is_active` varchar(45) DEFAULT NULL,
  `date_created` varchar(45) DEFAULT NULL,
  `voided` varchar(45) DEFAULT NULL,
  `date_voided` varchar(45) DEFAULT NULL,
  `void_reason` varchar(45) DEFAULT NULL,
  KEY `patient_patient_home_health` (`patient_id`),
  KEY `patient_home_health_agency_home_health` (`home_health_agency_id`),
  CONSTRAINT `patient_home_health_agency_home_health` FOREIGN KEY (`home_health_agency_id`) REFERENCES `home_health_agency` (`home_health_agency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_patient_home_health` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `business_name`
--

DROP TABLE IF EXISTS `business_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_name` (
  `business_name_id` int(11) NOT NULL AUTO_INCREMENT,
  `business_id` int(11) NOT NULL,
  `business_name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT '[Values: Corporate Name, Business Name, Abbreviated Name]',
  `priority` int(11) DEFAULT NULL,
  PRIMARY KEY (`business_name_id`),
  KEY `business_id` (`business_id`),
  CONSTRAINT `business_name_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `business` (`business_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person_last_name`
--

DROP TABLE IF EXISTS `person_last_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_last_name` (
  `person_last_name_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `person_last_name` varchar(255) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT '[Values: Maiden Name, Married Name, Other]',
  PRIMARY KEY (`person_last_name_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `person_last_name_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person_to_source_table`
--

DROP TABLE IF EXISTS `person_to_source_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_to_source_table` (
  `person_id` int(11) NOT NULL,
  `foreign_key_id` int(11) NOT NULL,
  `source_table` varchar(255) DEFAULT NULL COMMENT '[Values: patient_data, patient_secondary_contact, users, address_book]',
  PRIMARY KEY (`foreign_key_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `person_to_source_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_copy_results_to`
--

DROP TABLE IF EXISTS `patient_copy_results_to`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_copy_results_to` (
  `patient_copy_results_to_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `foreign_key_id` int(11) NOT NULL,
  `source_table` varchar(255) DEFAULT NULL,
  `method_of_contact` varchar(255) DEFAULT NULL,
  `relationship` varchar(255) DEFAULT NULL COMMENT '[Values: Son, Daughter, Mother, Relative, Friend, Caregiver, Home Health Aide, Acquaintance, Other]',
  PRIMARY KEY (`patient_copy_results_to_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `patient_copy_results_to_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person_to_person_secondary_contact`
--

DROP TABLE IF EXISTS `person_to_person_secondary_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_to_person_secondary_contact` (
  `person_to_person_secondary_contact_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `person_secondary_contact_id` int(11) NOT NULL,
  PRIMARY KEY (`person_to_person_secondary_contact_id`),
  UNIQUE KEY `person_to_person_secondary_contact_id_UNIQUE` (`person_to_person_secondary_contact_id`),
  KEY `fk_person_to_person_secondary_contact_person` (`person_id`),
  CONSTRAINT `fk_person_to_person_secondary_contact_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `person_id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_id` int(11) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL COMMENT 'Called Sex in OpenEMR and 255 characters',
  `social_security_number` varchar(255) DEFAULT NULL COMMENT 'Called SS in OpenEMR',
  `mother_maiden_name` varchar(255) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `employment_status` varchar(255) DEFAULT NULL,
  `education_level` varchar(255) DEFAULT NULL,
  `notes` varchar(45) DEFAULT NULL,
  `dead` int(11) DEFAULT NULL COMMENT 'May want something else',
  `death_date` date DEFAULT NULL,
  `cause_of_death` varchar(255) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `ethnoracial` varchar(255) DEFAULT NULL,
  `race` varchar(255) DEFAULT NULL,
  `ethnicity` varchar(255) DEFAULT NULL,
  `migrantseasonal` varchar(255) DEFAULT NULL,
  `family_size` varchar(255) DEFAULT NULL,
  `monthly_income` varchar(255) DEFAULT NULL,
  `homeless` varchar(255) DEFAULT NULL,
  `drivers_license` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`person_id`),
  KEY `CONTACT_ID` (`contact_id`),
  KEY `person_person_secondary_contact` (`person_id`),
  CONSTRAINT `person_ibfk_1` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=767 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact` (
  `contact_id` int(11) NOT NULL AUTO_INCREMENT,
  `source_table` varchar(255) DEFAULT NULL COMMENT '[Values: person, business]',
  `source_table_id` int(11) NOT NULL,
  PRIMARY KEY (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=678 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person_first_name`
--

DROP TABLE IF EXISTS `person_first_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_first_name` (
  `person_first_name_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `person_first_name` varchar(255) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT '[Values: Legal, Nickname]',
  PRIMARY KEY (`person_first_name_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `person_first_name_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-08-28 15:17:36
