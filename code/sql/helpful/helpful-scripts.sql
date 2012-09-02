-- DROP PROCEDURE IF EXISTS  `openemr`.`PatientData_To_Improved_Layout`;


Update `openemr`.`patient_data` 
set dataupgradeDone = 0, dataupgradeStart = 0
where `openemr`.`patient_data`.`pid` = 4;

 call `openemr`.PatientData_To_Improved_Layout

-- select * from patient_data
-- delete from x12_partners where id < 10000;
-- 
-- delete from patient_data where id < 10000;
-- 
-- delete from insurance_companies where id < 10000;
-- delete from insurance_data where id < 10000;
-- 
-- 
-- 
-- select count(*) from x12_partners;
-- select count(*) from patient_data;
-- select count(*) from insurance_companies;
-- select count(*) from insurance_data;

-- call  `openemr`.PatientData_To_Improved_Layout;
-- DESCRIBE user;
-- CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`),
-- CONSTRAINT `person_secondary_contact_person` FOREIGN KEY (`source_person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
-- SELECT
-- ke.CONSTRAINT_NAME,
-- ke.referenced_table_name parent,
-- 
-- ke.column_name `child-column`,
-- 
-- ke.referenced_column_name `parent-column`,
-- '---',ke.table_name child
-- 
-- FROM
-- information_schema.KEY_COLUMN_USAGE ke
-- WHERE
-- ke.referenced_table_name  IS NOT NULL
-- AND KE.`CONSTRAINT_SCHEMA` = 'demographics-test'
-- AND 
-- ke.table_name 
-- -- ke.referenced_table_name 
-- = 'person_secondary_contact'
-- 
-- ORDER BY
-- ke.referenced_table_name;
-- 
-- 
-- select * from information_schema.KEY_COLUMN_USAGE  
-- where `CONSTRAINT_SCHEMA` = 'demographics-test'
-- limit 0,100;





-- SELECT DISTINCT TABLE_NAME 
--     FROM INFORMATION_SCHEMA.COLUMNS
--     WHERE COLUMN_NAME like '%em_name%'
--         -- AND TABLE_SCHEMA='YourDatabase';
-- ;

-- SELECT DISTINCT TABLE_NAME, COLUMN_NAME, COLUMN_TYPE
-- FROM INFORMATION_SCHEMA.COLUMNS
-- WHERE table_name = 'patient_data'
-- and COLUMN_NAME in ('DOB', 'drivers_license', 'ss', 'sex', 'ethnoracial', 'race', 'ethnicity', 'migrantseasonal', 'family_size', 'monthly_income', 'homeless', 'mothersname', 'deceased_date', 'deceased_reason') 
-- AND TABLE_SCHEMA='openemr'
-- UNION 
-- SELECT DISTINCT TABLE_NAME, COLUMN_NAME, COLUMN_TYPE
-- FROM INFORMATION_SCHEMA.COLUMNS
-- WHERE table_name = 'person'
-- and COLUMN_NAME in ('birthdate', 'drivers_license', 'social_security_number', 'gender', 'ethnoracial', 'race', 'ethnicity', 'migrantseasonal', 'family_size', 'monthly_income', 'homeless', 'mother_maiden_name', 'death_date', 'cause_of_death') 
-- AND TABLE_SCHEMA='demographics-test';

-- select substring('Male',1,1);



-- select * from patient_data_test;

-- SHOW CREATE Tperson_ibfk_1ABLE contact;

