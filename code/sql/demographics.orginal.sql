databaseName	 table	 field	 type	 collation	 null	 key	 default	 extra	 comment
CREATE TABLE `business` (
  `business_id` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `subtype` varchar(255) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` date DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
);

CREATE TABLE `business_name` (
  `business_name_id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `business_name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
);

CREATE TABLE `business_to_source_table` (
  `business_id` int(11) NOT NULL,
  `foreign_key_id` int(11) NOT NULL,
  `source_table` varchar(45) DEFAULT NULL,
);

CREATE TABLE `contact` (
  `contact_id` int(11) NOT NULL,
  `source_table` varchar(255) DEFAULT NULL,
  `source_table_id` int(11) NOT NULL,
);

CREATE TABLE `contact_address` (
  `contact_address_id` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `address_title` varchar(45) DEFAULT NULL,
  `street_line_1` varchar(255) DEFAULT NULL,
  `street_line_2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `postal_code_suffix` varchar(255) DEFAULT NULL,
  `country_code` varchar(2) DEFAULT NULL,
  `area_name` varchar(255) DEFAULT NULL,
  `area_type` varchar(255) DEFAULT NULL,
  `is_billing` binary(1) DEFAULT NULL,
  `is_mailing` binary(1) DEFAULT NULL,
  `directions` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `activated_date` datetime DEFAULT NULL,
  `inactivated_date` datetime DEFAULT NULL,
  `inactivated_reason` varchar(255) DEFAULT NULL,
);

CREATE TABLE `contact_email_web` (
  `contact_email_web_id` int(11) NOT NULL,
  `priority` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `activated_date` datetime DEFAULT NULL,
  `inactivated_date` datetime DEFAULT NULL,
  `inactivated_reason` varchar(255) DEFAULT NULL,
);

CREATE TABLE `contact_telephone` (
  `contact_telephone_id` int(11) NOT NULL,
  `contact_address_id` int(11) NOT NULL,
  `priority` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `telephone_number` varchar(255) DEFAULT NULL,
  `is_sms_enabled` binary(1) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `activated_date` datetime DEFAULT NULL,
  `inactivated_date` datetime DEFAULT NULL,
  `inactivated_reason` varchar(255) DEFAULT NULL,
);

CREATE TABLE `contact_to_contact_address` (
  `contact_id` int(11) NOT NULL,
  `contact_address_id` int(11) NOT NULL,
);

CREATE TABLE `contact_to_contact_email_web` (
  `contact_id` int(11) NOT NULL,
  `contact_email_web_id` int(11) NOT NULL,
);

CREATE TABLE `contact_to_contact_telephone` (
  `contact_id` int(11) NOT NULL,
  `contact_telephone_id` int(11) NOT NULL,
);

CREATE TABLE `data_history_log` (
  `data_history_log_id` int(11) NOT NULL,
  `source_table` varchar(255) DEFAULT NULL,
  `source_table_id` int(11) NOT NULL,
  `field` varchar(255) DEFAULT NULL,
  `previous_value` varchar(255) DEFAULT NULL,
  `new_value` varchar(255) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `user` int(11) NOT NULL,
);

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
);

CREATE TABLE `home_health_agency` (
  `home_health_agency_id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
);

CREATE TABLE `insurance_company` (
  `insurance_company_id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `cms_id` int(11) NOT NULL,
  `freeb_type` varchar(45) DEFAULT NULL,
  `x12_receiver_id` varchar(45) DEFAULT NULL,
  `x12_default_partner_id` varchar(45) DEFAULT NULL,
  `alt_cms_id` varchar(45) DEFAULT NULL,
);

CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL,
  `person_id` int(11) DEFAULT NULL,
  `referral_source_person_id` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `voided` varchar(45) DEFAULT NULL,
  `voided_by` varchar(45) DEFAULT NULL,
  `date_voided` varchar(45) DEFAULT NULL,
  `voide_reason` varchar(45) DEFAULT NULL,
);

CREATE TABLE `patient_copy_results_to` (
  `patient_copy_results_to_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `foreign_key_id` int(11) NOT NULL,
  `source_table` varchar(255) DEFAULT NULL,
  `method_of_contact` varchar(255) DEFAULT NULL,
  `relationship` varchar(255) DEFAULT NULL,
);

CREATE TABLE `patient_copy_results_to_type` (
  `patient_copy_results_to_type_id` int(11) NOT NULL,
  `patient_copy_results_to_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
);

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
);

CREATE TABLE `patient_insurance` (
  `patient_insurance_id` int(11) NOT NULL auto_increment,
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
);

CREATE TABLE `patient_medical_providers` (
  `patient_medical_providers_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL,
);

CREATE TABLE `patient_pharmacy` (
  `patient_id` int(11) NOT NULL,
  `pharmacy_id` int(11) NOT NULL,
  `priority` varchar(45) DEFAULT NULL,
);

CREATE TABLE `person` (
  `person_id` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `social_security_number` varchar(255) DEFAULT NULL,
  `mother_maiden_name` varchar(255) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `employment_status` varchar(255) DEFAULT NULL,
  `education_level` varchar(255) DEFAULT NULL,
  `notes` varchar(45) DEFAULT NULL,
  `dead` int(11) DEFAULT NULL,
  `death_date` date DEFAULT NULL,
  `cause_of_death` varchar(255) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
);

CREATE TABLE `person_employment` (
  `person_employment_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
);

CREATE TABLE `person_first_name` (
  `person_first_name_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `person_first_name` varchar(255) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
);

CREATE TABLE `person_language` (
  `person_language_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `language` varchar(255) DEFAULT NULL,
  `fluency` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
);

CREATE TABLE `person_last_name` (
  `person_last_name_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `person_last_name` varchar(255) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
);

CREATE TABLE `person_secondary_contact` (
  `person_secondary_contact_id` int(11) NOT NULL,
  `source_person_id` int(11) NOT NULL,
  `secondary_contact_person_id` int(11) NOT NULL,
  `priority` int(11) DEFAULT NULL,
  `relationship` varchar(255) DEFAULT NULL,
  `is_guarantor` varchar(45) DEFAULT NULL,
  `is_guardian` binary(1) DEFAULT NULL,
  `is_poa` binary(1) DEFAULT NULL,
  `is_insurance_subscriber` varchar(45) DEFAULT NULL,
  `date_created` varchar(45) DEFAULT NULL,
  `voided` varchar(45) DEFAULT NULL,
  `voided_by` varchar(45) DEFAULT NULL,
  `void_reason` varchar(45) DEFAULT NULL,
);

CREATE TABLE `person_to_person_secondary_contact` (
  `person_to_person_secondary_contact_id` int(11) NOT NULL auto_increment,
  `person_id` int(11) NOT NULL,
  `person_secondary_contact_id` int(11) NOT NULL,
);

CREATE TABLE `person_to_source_table` (
  `person_id` int(11) NOT NULL,
  `foreign_key_id` int(11) NOT NULL,
  `source_table` varchar(255) DEFAULT NULL,
);

CREATE TABLE `pharmacy` (
  `pharmacy_id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `is_compounding` tinyint(1) NOT NULL,
);

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL auto_increment,
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
);

