-- DROP PROCEDURE IF EXISTS  `openemr`.`PatientData_To_Improved_Layout2`;

-- DROP PROCEDURE IF EXISTS  `openemr`.`PatientData_To_Improved_Layout`;
DROP PROCEDURE IF EXISTS  `openemr`.`PatientData_To_Improved_Layout`;

delimiter #
  

CREATE PROCEDURE `openemr`.Insurance_Company_To_Improved_Layout()
begin
  -- Note: does not move current insurrance_numbers which are numbers about the practice itself.
  
  -- Need to create variables for each value.
  

  DECLARE current_insurance_id bigint(20);
  DECLARE current_insurance_business_id bigint(20);
  DECLARE current_employer_business_id bigint(20);
  DECLARE current_insurance_company_id bigint(20);
   DECLARE current_patient_insurance_id bigint(20);
   DECLARE current_business_id bigint(20);
  
  DECLARE local_priority int(11);  
  DECLARE old_foreign_key_checks tinyint(1);
  
  DECLARE no_more_rows tinyint(1);
  DECLARE num_rows int(11);
  
DECLARE lcl_id int(11) ;
DECLARE lcl_name varchar(255)  ;
DECLARE lcl_attn varchar(255)  ;
DECLARE lcl_cms_id varchar(15)  ;
DECLARE lcl_freeb_type tinyint(2)  ;
DECLARE lcl_x12_receiver_id varchar(25)  ;
DECLARE lcl_x12_default_partner_id int(11)  ;
DECLARE lcl_alt_cms_id varchar(15)    ;
  
  
  -- Declare the cursor
  DECLARE cur_insurance_companies_data CURSOR FOR
  SELECT
`insurance_companies`.`id`,
`insurance_companies`.`name`,
`insurance_companies`.`attn`,
`insurance_companies`.`cms_id`,
`insurance_companies`.`freeb_type`,
`insurance_companies`.`x12_receiver_id`,
`insurance_companies`.`x12_default_partner_id`,
`insurance_companies`.`alt_cms_id`
FROM `openemr`.`insurance_companies`

where `dataupgradeDone` = 0;

	  
  
	  -- declare v_max int unsigned default 1000;
      -- declare v_counter int unsigned default 0;

   -- Declare 'handlers' for exceptions
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET no_more_rows = TRUE;


  -- Change Table
IF NOT EXISTS( SELECT 1
            FROM INFORMATION_SCHEMA.COLUMNS
           WHERE table_name = 'insurance_companies'
             AND table_schema = 'openemr'
             AND column_name = 'dataupgradeDone')  THEN

  ALTER TABLE `openemr`.`insurance_companies` ADD dataupgradeDone tinyint default 0;

END IF;

IF NOT EXISTS( SELECT 1
            FROM INFORMATION_SCHEMA.COLUMNS
           WHERE table_name = 'insurance_companies'
             AND table_schema = 'openemr'
             AND column_name = 'dataupgradeStart')  THEN

  ALTER TABLE `openemr`.`insurance_companies` ADD dataupgradeStart tinyint default 0;

END IF;



  /*
    Now the programming logic
  */

  -- 'open' the cursor and capture the number of rows returned
  -- (the 'select' gets invoked when the cursor is 'opened')
  set no_more_rows = false;
  
  -- Get current foreign_key_checks and turn it off.
  SET @old_foreign_key_checks = @@session.foreign_key_checks;
  SET global foreign_key_checks= 0;  






  OPEN cur_insurance_companies_data;
  select FOUND_ROWS() into num_rows;
  
  FETCH  cur_insurance_companies_data
        INTO   
lcl_id,
lcl_name,
lcl_attn,
lcl_cms_id,
lcl_freeb_type,
lcl_x12_receiver_id,
lcl_x12_default_partner_id,
lcl_alt_cms_id;

  while NOT no_more_rows do
--  `id`,`pid`,`sex`, `ss`, `mothersname`, `DOB`
      
  update `openemr`.`insurance_companies` 
  set dataupgradeStart  = 1 
  where id = lcl_id;

  -- Create Business
  insert into `demographics-test`.`business`
  (`type`)
  VALUES ('INSURANCE');
  
  SELECT LAST_INSERT_ID() into current_business_id;
  
    INSERT INTO `demographics-test`.`business_name`
	(
	`business_id`,
	`business_name`,
	`type`,
	`priority`)
	VALUES
	(
	current_business_id,
	lcl_name,
	'LEGAL',
	1
	);
  
  -- Create a contact
  insert into `demographics-test`.`contact` 
       (`source_table`, `source_table_id`)
   VALUES ('business',current_business_id);
  
  SELECT LAST_INSERT_ID() into current_contact_id;
  
  -- Create Insurance Company
  INSERT INTO `demographics-test`.`insurance_company`
(
`business_id`,
`cms_id`,
`freeb_type`,
`x12_receiver_id`,
`x12_default_partner_id`,
`alt_cms_id`,
`old_insurance_company_id`
)
VALUES
( current_business_id, -- Business_id
   lcl_cms_id, lcl_freeb_type, lcl_x12_receiver_id,lcl_x12_default_partner_id,lcl_alt_cms_id,lcl_id
);  
  SELECT LAST_INSERT_ID() into current_insurance_company_id;
  
  INSERT INTO `demographics-test`.`business_to_source_table`
(`business_id`,
`foreign_key_id`,
`source_table`)
VALUES (
  current_business_id, current_insurance_company_id, 'insurance_company');
  
  -- Update contact with the new person
  update `demographics-test`.`contact`  SET 
    `source_table_id` = @current_person_id, `source_table` = 'insurance_company'
    where `contact_id` = @current_contact_id;

  -- Address
  -- If address exists then we need to update the other values, like phone
   insert into `demographics-test`.`contact_to_contact_address`
    (`contact_id`) 
    values (@current_contact_id);
  
  
  
  SELECT LAST_INSERT_ID() into current_address_id;
  
  
  
  insert into `demographics-test`.`contact_address`
    (`contact_address`.`contact_address_id`,
`contact_address`.`priority`,
`contact_address`.`type`,
`contact_address`.`address_title`,
`contact_address`.`street_line_1`,
`contact_address`.`street_line_2`,
`contact_address`.`city`,
`contact_address`.`state`,
`contact_address`.`postal_code`,
`contact_address`.`postal_code_suffix`,
`contact_address`.`country_code`,
`contact_address`.`created_date`,
`contact_address`.`activated_date`)
select @current_address_id, 1, 
'main', -- type
'', -- title
line1,
line2, -- street_line_2
city,
state,
zip, 
plus_four,
country
from `openemr`.`addresses`

DATE(NOW()), DATE(NOW())
where `addresses`.`foreign_id` = lcl_id);


  -- Insert home phone
  insert into `demographics-test`.`contact_to_contact_telephone`
    (`contact_id`) 
    values (@current_contact_id);
    
    
  SELECT LAST_INSERT_ID() into current_telephone_id;
  
  
  
  -- check if not null or empty
  insert into `demographics-test`.`contact_telephone`
    (`contact_telephone`.`contact_telephone_id`,
    `contact_telephone`.`contact_address_id`,
`contact_telephone`.`priority`,
`contact_telephone`.`type`,
`contact_telephone`.`country_code`,
`contact_telephone`.`telephone_number`,
`contact_telephone`.`created_date`,
`contact_telephone`.`activated_date`)

select 
VALUES (@current_telephone_id,@current_address_id, 1, 
case int(11) `type`
  When 1 THEN 'home'
  when 2 then 'work'
  when 3 then 'cell'
  when 4 then 'emergency'
  when 5 then 'fax', `country_code`, 
  `area_code` +" "+`prefix`+" "+`number`,
  , DATE(NOW()), DATE(NOW()));

  
  
  -- Set data to complete
  update `openemr`.`insurance_companies` 
  set dataupgradeDone  = 1 
  where id = lcl_id;

  
/*   insert into patient
	(`person_id`, )
	values (current_person_id,  */
  
  FETCH  cur_insurance_data_data
        INTO   
lcl_id,
lcl_name,
lcl_attn,
lcl_cms_id,
lcl_freeb_type,
lcl_x12_receiver_id,
lcl_x12_default_partner_id,
lcl_alt_cms_id;
		
  end while;
  close cur_insurance_data_data;
  -- SELECT current_person_id ;
  
  
  -- Cleanup Scripts:
  SET @@session.foreign_key_checks= @old_foreign_key_checks;
  
END