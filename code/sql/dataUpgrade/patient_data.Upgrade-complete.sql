-- DROP PROCEDURE IF EXISTS  `openemr`.`PatientData_To_Improved_Layout2`;

-- DROP PROCEDURE IF EXISTS  `openemr`.`PatientData_To_Improved_Layout`;
DROP PROCEDURE IF EXISTS  `openemr`.`PatientData_To_Improved_Layout`;

delimiter #
  

CREATE PROCEDURE `openemr`.PatientData_To_Improved_Layout()
begin
  -- Need to create variables for each value.
  
  -- Change Table

  DECLARE current_person_id bigint(20);
  DECLARE current_contact_id bigint(20);
  DECLARE current_patient_id bigint(20);
  DECLARE current_telephone_id bigint(20);
  DECLARE current_address_id bigint(20);
  DECLARE current_email_web_id bigint(20);
  DECLARE local_contact_id bigint(20);
  DECLARE local_person_id bigint(20);
  DECLARE local_telephone_id bigint(20);

  DECLARE old_foreign_key_checks tinyint(1);
  
  
  DECLARE lcl_id bigint(20); 
  DECLARE lcl_pid bigint(20); 
  DECLARE no_more_rows tinyint(1);
  DECLARE num_rows int(11);
  declare lcl_DOB date;
  declare lcl_title varchar(255) ;
  declare lcl_language varchar(255) ;
  declare lcl_financial varchar(255) ;
  declare lcl_fname varchar(255) ;
  declare lcl_lname varchar(255) ;
  declare lcl_mname varchar(255) ;
  declare lcl_street varchar(255) ;
  declare lcl_postal_code varchar(255) ;
  declare lcl_city varchar(255) ;
  declare lcl_state varchar(255) ;
  declare lcl_country_code varchar(255) ;
  declare lcl_drivers_license varchar(255) ;
  declare lcl_ss varchar(255) ;
  declare lcl_occupation longtext;
  declare lcl_phone_home varchar(255) ;
  declare lcl_phone_biz varchar(255) ;
  declare lcl_phone_contact varchar(255) ;
  declare lcl_phone_cell varchar(255) ;
  declare lcl_pharmacy_id int(11) ;
  declare lcl_status varchar(255) ;
  declare lcl_contact_relationship varchar(255) ;
  declare lcl_date datetime ;
  declare lcl_sex varchar(255) ;
  declare lcl_referrer varchar(255) ;
  declare lcl_referrerID varchar(255) ;
  declare lcl_providerID int(11) ;
  declare lcl_email varchar(255) ;
  declare lcl_ethnoracial varchar(255) ;
  declare lcl_race varchar(255) ;
  declare lcl_ethnicity varchar(255) ;
  declare lcl_interpretter varchar(255) ;
  declare lcl_migrantseasonal varchar(255) ;
  declare lcl_family_size varchar(255) ;
  declare lcl_monthly_income varchar(255) ;
  declare lcl_homeless varchar(255) ;
  declare lcl_financial_review datetime ;
  declare lcl_pubpid varchar(255) ;
  declare lcl_genericname1 varchar(255) ;
  declare lcl_genericval1 varchar(255) ;
  declare lcl_genericname2 varchar(255) ;
  declare lcl_genericval2 varchar(255) ;
  declare lcl_hipaa_mail varchar(3) ;
  declare lcl_hipaa_voice varchar(3) ;
  declare lcl_hipaa_notice varchar(3) ;
  declare lcl_hipaa_message varchar(20) ;
  declare lcl_hipaa_allowsms varchar(3) ;
  declare lcl_hipaa_allowemail varchar(3) ;
  declare lcl_squad varchar(32) ;
  declare lcl_fitness int(11) ;
  declare lcl_referral_source varchar(30) ;
  declare lcl_usertext1 varchar(255) ;
  declare lcl_usertext2 varchar(255) ;
  declare lcl_usertext3 varchar(255) ;
  declare lcl_usertext4 varchar(255) ;
  declare lcl_usertext5 varchar(255) ;
  declare lcl_usertext6 varchar(255) ;
  declare lcl_usertext7 varchar(255) ;
  declare lcl_usertext8 varchar(255) ;
  declare lcl_userlist1 varchar(255) ;
  declare lcl_userlist2 varchar(255) ;
  declare lcl_userlist3 varchar(255) ;
  declare lcl_userlist4 varchar(255) ;
  declare lcl_userlist5 varchar(255) ;
  declare lcl_userlist6 varchar(255) ;
  declare lcl_userlist7 varchar(255) ;
  declare lcl_pricelevel varchar(255) ;
  declare lcl_regdate date  ;
  declare lcl_contrastart date  ;
  declare lcl_completed_ad varchar(3) ;
  declare lcl_ad_reviewed date ;
  declare lcl_vfc varchar(255) ;
  declare lcl_mothersname varchar(255) ;
  declare lcl_guardiansname varchar(255) ;
  declare lcl_allow_imm_reg_use varchar(255) ;
  declare lcl_allow_imm_info_share varchar(255) ;
  declare lcl_allow_health_info_ex varchar(255) ;
  declare lcl_allow_patient_portal varchar(31) ;
  declare lcl_deceased_date datetime ;
  declare lcl_deceased_reason varchar(255) ;
  declare lcl_soap_import_status tinyint(4)  ;





  -- Declare the cursor
  DECLARE cur_patient_data CURSOR FOR
    
    SELECT
        `patient_data`.`id`,
        `patient_data`.`title`,
        `patient_data`.`language`,
        `patient_data`.`financial`,
        `patient_data`.`fname`,
        `patient_data`.`lname`,
        `patient_data`.`mname`,
        `patient_data`.`DOB`,
        `patient_data`.`street`,
        `patient_data`.`postal_code`,
        `patient_data`.`city`,
        `patient_data`.`state`,
        `patient_data`.`country_code`,
        `patient_data`.`drivers_license`,
        `patient_data`.`ss`,
        `patient_data`.`occupation`,
        `patient_data`.`phone_home`,
        `patient_data`.`phone_biz`,
        `patient_data`.`phone_contact`,
        `patient_data`.`phone_cell`,
        `patient_data`.`pharmacy_id`,
        `patient_data`.`status`,
        `patient_data`.`contact_relationship`,
        `patient_data`.`date`,
        `patient_data`.`sex`,
        `patient_data`.`referrer`,
        `patient_data`.`referrerID`,
        `patient_data`.`providerID`,
        `patient_data`.`email`,
        `patient_data`.`ethnoracial`,
        `patient_data`.`race`,
        `patient_data`.`ethnicity`,
        `patient_data`.`interpretter`,
        `patient_data`.`migrantseasonal`,
        `patient_data`.`family_size`,
        `patient_data`.`monthly_income`,
        `patient_data`.`homeless`,
        `patient_data`.`financial_review`,
        `patient_data`.`pubpid`,
        `patient_data`.`pid`,
        `patient_data`.`genericname1`,
        `patient_data`.`genericval1`,
        `patient_data`.`genericname2`,
        `patient_data`.`genericval2`,
        `patient_data`.`hipaa_mail`,
        `patient_data`.`hipaa_voice`,
        `patient_data`.`hipaa_notice`,
        `patient_data`.`hipaa_message`,
        `patient_data`.`hipaa_allowsms`,
        `patient_data`.`hipaa_allowemail`,
        `patient_data`.`squad`,
        `patient_data`.`fitness`,
        `patient_data`.`referral_source`,
        `patient_data`.`usertext1`,
        `patient_data`.`usertext2`,
        `patient_data`.`usertext3`,
        `patient_data`.`usertext4`,
        `patient_data`.`usertext5`,
        `patient_data`.`usertext6`,
        `patient_data`.`usertext7`,
        `patient_data`.`usertext8`,
        `patient_data`.`userlist1`,
        `patient_data`.`userlist2`,
        `patient_data`.`userlist3`,
        `patient_data`.`userlist4`,
        `patient_data`.`userlist5`,
        `patient_data`.`userlist6`,
        `patient_data`.`userlist7`,
        `patient_data`.`pricelevel`,
        `patient_data`.`regdate`,
        `patient_data`.`contrastart`,
        `patient_data`.`completed_ad`,
        `patient_data`.`ad_reviewed`,
        `patient_data`.`vfc`,
        `patient_data`.`mothersname`,
        `patient_data`.`guardiansname`,
        `patient_data`.`allow_imm_reg_use`,
        `patient_data`.`allow_imm_info_share`,
        `patient_data`.`allow_health_info_ex`,
        `patient_data`.`allow_patient_portal`,
        `patient_data`.`deceased_date`,
        `patient_data`.`deceased_reason`,
        `patient_data`.`soap_import_status`
            FROM patient_data
          WHERE dataupgradeDone = 0
        order by patient_data.id desc;

   -- Declare 'handlers' for exceptions
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET no_more_rows = TRUE;





  -- 'open' the cursor and capture the number of rows returned
  -- (the 'select' gets invoked when the cursor is 'opened')
  set no_more_rows = false;
  
  -- Get current foreign_key_checks and turn it off.
  SET @old_foreign_key_checks = @@session.foreign_key_checks;
  SET global foreign_key_checks= 0;  


    IF NOT EXISTS( SELECT 1
                FROM INFORMATION_SCHEMA.COLUMNS
               WHERE table_name = 'patient_data'
                 AND table_schema = 'openemr'
                 AND column_name = 'dataupgradeDone')  THEN

      ALTER TABLE `openemr`.`patient_data` ADD dataupgradeDone tinyint default 0;

    END IF;

    IF NOT EXISTS( SELECT 1
                FROM INFORMATION_SCHEMA.COLUMNS
               WHERE table_name = 'patient_data'
                 AND table_schema = 'openemr'
                 AND column_name = 'dataupgradeStart')  THEN

      ALTER TABLE `openemr`.`patient_data` ADD dataupgradeStart tinyint default 0;

    END IF;


  OPEN cur_patient_data;
  select FOUND_ROWS() into num_rows;
  
  FETCH  cur_patient_data
        INTO   
      lcl_id,
      lcl_title,
      lcl_language,
      lcl_financial,
      lcl_fname,
      lcl_lname,
      lcl_mname,
      lcl_DOB,
      lcl_street,
      lcl_postal_code,
      lcl_city,
      lcl_state,
      lcl_country_code,
      lcl_drivers_license,
      lcl_ss,
      lcl_occupation,
      lcl_phone_home,
      lcl_phone_biz,
      lcl_phone_contact,
      lcl_phone_cell,
      lcl_pharmacy_id,
      ,
      lcl_contact_relationship,
      lcl_date,
      lcl_sex,
      lcl_referrer,
      lcl_referrerID,
      lcl_providerID,
      lcl_email,
      lcl_ethnoracial,
      lcl_race,
      lcl_ethnicity,
      lcl_interpretter,
      lcl_migrantseasonal,
      lcl_family_size,
      lcl_monthly_income,
      lcl_homeless,
      lcl_financial_review,
      lcl_pubpid,
      lcl_pid,
      lcl_genericname1,
      lcl_genericval1,
      lcl_genericname2,
      lcl_genericval2,
      lcl_hipaa_mail,
      lcl_hipaa_voice,
      lcl_hipaa_notice,
      lcl_hipaa_message,
      lcl_hipaa_allowsms,
      lcl_hipaa_allowemail,
      lcl_squad,
      lcl_fitness,
      lcl_referral_source,
      lcl_usertext1,
      lcl_usertext2,
      lcl_usertext3,
      lcl_usertext4,
      lcl_usertext5,
      lcl_usertext6,
      lcl_usertext7,
      lcl_usertext8,
      lcl_userlist1,
      lcl_userlist2,
      lcl_userlist3,
      lcl_userlist4,
      lcl_userlist5,
      lcl_userlist6,
      lcl_userlist7,
      lcl_pricelevel,
      lcl_regdate,
      lcl_contrastart,
      lcl_completed_ad,
      lcl_ad_reviewed,
      lcl_vfc,
      lcl_mothersname,
      lcl_guardiansname,
      lcl_allow_imm_reg_use,
      lcl_allow_imm_info_share,
      lcl_allow_health_info_ex,
      lcl_allow_patient_portal,
      lcl_deceased_date,
      lcl_deceased_reason,
      lcl_soap_import_status;
      
  while NOT no_more_rows do
--  `id`,`pid`,`sex`, `ss`, `mothersname`, `DOB`
      
  
  
  update `openemr`.`patient_data` 
  set dataupgradeStart  = 1 
  where id = lcl_id;

  insert into `demographics-test`.`contact` 
      (`source_table`, `source_table_id`)
  VALUES ('person',-1);
  
  SELECT LAST_INSERT_ID() into @current_contact_id ;
  
  insert into `demographics-test`.`person` 
      (  `contact_id`,`birthdate`, `drivers_license`, `social_security_number`, `gender`, `ethnoracial`, `race`, `ethnicity`, `migrantseasonal`, `family_size`, `monthly_income`, `homeless`, `mother_maiden_name`, `death_date`, `cause_of_death`) 
      VALUES (@current_contact_id, lcl_DOB, lcl_drivers_license, lcl_ss, substring(lcl_sex,1,1), lcl_ethnoracial, lcl_race, lcl_ethnicity, lcl_migrantseasonal, lcl_family_size, lcl_monthly_income, lcl_homeless, lcl_mothersname, date(lcl_deceased_date), lcl_deceased_reason);
  
  SELECT LAST_INSERT_ID() into @current_person_id;
  
  -- Debug
  select 'About to start patient', @current_person_id, @current_contact_id;
  
  insert into `demographics-test`.`patient`
          (`imported_patient_id`,
          `person_id`,
          -- `referral_source_person_id`, not sure.
          `interpretter`,
          `financial_review`,
          `pubpid`,
          `genericname1`,
          `genericval1`,
          `genericname2`,
          `genericval2`,
          `hipaa_mail`,
          `hipaa_voice`,
          `hipaa_notice`,
          `hipaa_message`,
          `hipaa_allowsms`,
          `hipaa_allowemail`,
          `squad`,
          `fitness`,
          `usertext1`,
          `usertext2`,
          `usertext3`,
          `usertext4`,
          `usertext5`,
          `usertext6`,
          `usertext7`,
          `usertext8`,
          `userlist1`,
          `userlist2`,
          `userlist3`,
          `userlist4`,
          `userlist5`,
          `userlist6`,
          `userlist7`,
          `pricelevel`,
          `regdate`,
          `contrastart`,
          `completed_ad`,
          `ad_reviewed`,
          `vfc`,
          `allow_imm_reg_use`,
          `allow_imm_info_share`,
          `allow_health_info_ex`,
          `allow_patient_portal`)
        VALUES
        ( lcl_pid,
        @current_person_id,
        lcl_interpretter,
        lcl_financial_review,
        lcl_pubpid,
        lcl_genericname1,
        lcl_genericval1,
        lcl_genericname2,
        lcl_genericval2,
        lcl_hipaa_mail,
        lcl_hipaa_voice,
        lcl_hipaa_notice,
        lcl_hipaa_message,
        lcl_hipaa_allowsms,
        lcl_hipaa_allowemail,
        lcl_squad,
        lcl_fitness,
        lcl_usertext1,
        lcl_usertext2,
        lcl_usertext3,
        lcl_usertext4,
        lcl_usertext5,
        lcl_usertext6,
        lcl_usertext7,
        lcl_usertext8,
        lcl_userlist1,
        lcl_userlist2,
        lcl_userlist3,
        lcl_userlist4,
        lcl_userlist5,
        lcl_userlist6,
        lcl_userlist7,
        lcl_pricelevel,
        lcl_regdate,
        lcl_contrastart,
        lcl_completed_ad,
        lcl_ad_reviewed,
        lcl_vfc,
        lcl_allow_imm_reg_use,
        lcl_allow_imm_info_share,
        lcl_allow_health_info_ex,
        lcl_allow_patient_portal
        );

      -- DEBUG: The following value is returned for debugging purposes.
      select 'About to start address';
  
  
  
      -- Update contact with the new person
      update `demographics-test`.`contact`  SET 
        `source_table_id` = @current_person_id
        where `contact_id` = @current_contact_id;

      -- Address
      -- If address exists then we need to update the other values, like phone
       insert into `demographics-test`.`contact_to_contact_address`
        (`contact_id`) 
        values (@current_contact_id);
      
      SELECT LAST_INSERT_ID() into @current_address_id;
  
  
      -- DEBUG 
      select 'Started Address', @current_address_id as `address ID`, @current_contact_id as `contact_id`;
  
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
      `contact_address`.`country_code`,
      `contact_address`.`created_date`,
      `contact_address`.`activated_date`)
    values (@current_address_id, 1, 'main',
        '', -- type
        lcl_street, -- street_line_1
        null, -- street_line_2
        lcl_city,
        lcl_state,
        lcl_postal_code, 
        lcl_country_code,
        DATE(NOW()), DATE(NOW()));


  -- Insert home phone
  insert into `demographics-test`.`contact_to_contact_telephone`
    (`contact_id`) 
    values (@current_contact_id);
    
    
  SELECT LAST_INSERT_ID() into @current_telephone_id;
  
  
  
  -- check if not null or empty
  insert into `demographics-test`.`contact_telephone`
    (`contact_telephone`.`contact_telephone_id`,
      `contact_telephone`.`contact_address_id`,
      `contact_telephone`.`priority`,
      `contact_telephone`.`type`,
      `contact_telephone`.`telephone_number`,
      `contact_telephone`.`created_date`,
      `contact_telephone`.`activated_date`)
  VALUES (@current_telephone_id,@current_address_id, 1, 'home',lcl_phone_home, DATE(NOW()), DATE(NOW()));

  -- insert business (lcl_phone_biz)
    insert into `demographics-test`.`contact_to_contact_telephone`
      (`contact_id`) 
    values (@current_contact_id);
    
    
  SELECT LAST_INSERT_ID() into @current_telephone_id;
  select @current_telephone_id;
  
  
  -- check if not null or empty
  insert into `demographics-test`.`contact_telephone`
    (`contact_telephone`.`contact_telephone_id`,
    `contact_telephone`.`contact_address_id`,
    `contact_telephone`.`priority`,
    `contact_telephone`.`type`,
    `contact_telephone`.`telephone_number`,
    `contact_telephone`.`created_date`,
    `contact_telephone`.`activated_date`)
  VALUES (@current_telephone_id,@current_address_id, 1, 'business',lcl_phone_biz, DATE(NOW()), DATE(NOW()));

  -- insert cell (lcl_phone_cell)
    insert into `demographics-test`.`contact_to_contact_telephone`
    (`contact_id`) 
    values (@current_contact_id);
    
    
  SELECT LAST_INSERT_ID() into @current_telephone_id;
  
  
  
  -- check if not null or empty
  insert into `demographics-test`.`contact_telephone`
    (`contact_telephone`.`contact_telephone_id`,
    `contact_telephone`.`contact_address_id`,
    `contact_telephone`.`priority`,
    `contact_telephone`.`type`,
    `contact_telephone`.`telephone_number`,
    `contact_telephone`.`created_date`,
    `contact_telephone`.`activated_date`)
  VALUES (@current_telephone_id,@current_address_id, 1, 'mobile',lcl_phone_cell, DATE(NOW()), DATE(NOW()));

-- Contact Phone needs to be added: 

    insert into `demographics-test`.`contact_to_contact_email_web`
      (`contact_id`) 
    values (@current_contact_id);
    
    
  SELECT LAST_INSERT_ID() into @current_email_web_id;
  
  insert into `demographics-test`.`contact_email_web`
    (`contact_email_web`.`contact_email_web_id`,
      `contact_email_web`.`priority`,
      `contact_email_web`.`type`,
      `contact_email_web`.`value`,
      `contact_email_web`.`created_date`,
      `contact_email_web`.`activated_date`)
  VALUES (@current_email_web_id, 1, 'email',lcl_email, DATE(NOW()), DATE(NOW()));

  -- DEBUG: The following value is returned for debugging purposes.
  SELECT 'FINISH email';

-- Insert Employment

  insert into `demographics-test`.`person_employment`
    (`person_employment`.`person_id`,
    `person_employment`.`business_id`,
    `person_employment`.`occupation`)

    VALUES (@current_person_id, 
      NULL, -- business_id
      lcl_occupation);



    -- DEBUG: The following value is returned for debugging purposes.
    SELECT 'FINISH EMployement';
    SELECT @current_person_id as 'Current Person ID';

  -- Name
  insert into `demographics-test`.`person_name`
    (`person_name`.`person_id`,
      `person_name`.`person_last_name`,
      `person_name`.`person_first_name`,
      `person_name`.`person_middle_name`,
      `person_name`.`priority`,
      `person_name`.`type`
    )
    VALUES (@current_person_id, 
      lcl_lname, lcl_fname, lcl_mname, 
      1,
      'default'
    );

    
    -- DEBUG: The following value is returned for debugging purposes.
    SELECT 'FINISH Name';

    -- Employment  - Doesn't look like employer is directly used.
  
    -- Patient_pharmacy
  
  
  
    -- Insert secondary_contact Person
    -- Generate person_id
  
    insert into `demographics-test`.`contact` 
        (`source_table`, `source_table_id`)
    VALUES ('person',-1);
    
    SELECT LAST_INSERT_ID() into @local_contact_id;
    -- DEBUG: The following value is returned for debugging purposes. 
    SELECT @local_contact_id as 'local contact for secondary contact';
  
    insert into `demographics-test`.`person`
    (gender)
    VALUES
    (NULL
    );



    SELECT LAST_INSERT_ID() into @local_person_id;

    -- DEBUG: The following value is returned for debugging purposes.  
    SELECT @local_person_id as 'local person for secondary contact';
      
  
     -- It appears that patient_data.contact_relationship is the contact name
  insert into `demographics-test`.`person_name`
    (`person_name`.`person_id`,
      `person_name`.`person_last_name`,
      `person_name`.`priority`,
      `person_name`.`type`
    )
    VALUES (@local_person_id, 
    lcl_contact_relationship, 
    1,
    'contact'
    );

    insert into `demographics-test`.`person_secondary_contact`
    (`person_secondary_contact`.`source_person_id`,
    `person_secondary_contact`.`secondary_contact_person_id`,
    `person_secondary_contact`.`priority`,
    `person_secondary_contact`.`relationship`)
    VALUES
    (@current_person_id, @local_person_id,  1, 'contact');

    -- check if not null or empty
      insert into `demographics-test`.`contact_to_contact_telephone`
      (`contact_to_contact_telephone`.`contact_id`)
      VALUES
      (@local_contact_id);
      
      SELECT LAST_INSERT_ID() into @local_telephone_id;
  
      insert into `demographics-test`.`contact_telephone`
        (`contact_telephone`.`contact_telephone_id`,
        `contact_telephone`.`contact_address_id`,
        `contact_telephone`.`priority`,
        `contact_telephone`.`type`,
        `contact_telephone`.`telephone_number`,
        `contact_telephone`.`created_date`,
        `contact_telephone`.`activated_date`)
        VALUES (@local_telephone_id,NULL, 1, 'primary',lcl_phone_contact, DATE(NOW()), DATE(NOW()));


      -- Update new secondary contact information
      update `demographics-test`.`contact`  SET 
        `source_table_id` = @local_person_id
        where `contact_id` = @local_contact_id;

      

      -- guardian
      -- Only insert a guadian if they exist.
      IF(lcl_guardiansname IS NOT NULL AND lcl_guardiansname <> '') THEN
      BEGIN
      
        insert into `demographics-test`.`person`
        (gender
        )
        VALUES
        (NULL
        );
    
    
    
        SELECT LAST_INSERT_ID() into @local_person_id;
        
        
        insert into `demographics-test`.`person_name`
          (`person_name`.`person_id`,
            `person_name`.`person_last_name`,
            `person_name`.`priority`,
            `person_name`.`type`
          )
          VALUES (@local_person_id, 
          lcl_guardiansname, 
          1,
          'guardian'
          );
        
          insert into `demographics-test`.`person_secondary_contact`
          (`person_secondary_contact`.`source_person_id`,
          `person_secondary_contact`.`secondary_contact_person_id`,
          `person_secondary_contact`.`priority`,
          `person_secondary_contact`.`relationship`,
          `person_secondary_contact`.`is_guardian`)
          VALUES
          (@local_person_id, @current_person_id, 1, 'guardian', is_guardian);
        END;
      END IF;
  
  
  -- Set data to complete
  update `openemr`.`patient_data` 
  set dataupgradeDone  = 1 
  where id = lcl_id;

  
/*   insert into patient
	(`person_id`, )
	values (current_person_id,  */
  
  FETCH  cur_patient_data
        INTO   lcl_id,
      lcl_title,
      lcl_language,
      lcl_financial,
      lcl_fname,
      lcl_lname,
      lcl_mname,
      lcl_DOB,
      lcl_street,
      lcl_postal_code,
      lcl_city,
      lcl_state,
      lcl_country_code,
      lcl_drivers_license,
      lcl_ss,
      lcl_occupation,
      lcl_phone_home,
      lcl_phone_biz,
      lcl_phone_contact,
      lcl_phone_cell,
      lcl_pharmacy_id,
      ,
      lcl_contact_relationship,
      lcl_date,
      lcl_sex,
      lcl_referrer,
      lcl_referrerID,
      lcl_providerID,
      lcl_email,
      lcl_ethnoracial,
      lcl_race,
      lcl_ethnicity,
      lcl_interpretter,
      lcl_migrantseasonal,
      lcl_family_size,
      lcl_monthly_income,
      lcl_homeless,
      lcl_financial_review,
      lcl_pubpid,
      lcl_pid,
      lcl_genericname1,
      lcl_genericval1,
      lcl_genericname2,
      lcl_genericval2,
      lcl_hipaa_mail,
      lcl_hipaa_voice,
      lcl_hipaa_notice,
      lcl_hipaa_message,
      lcl_hipaa_allowsms,
      lcl_hipaa_allowemail,
      lcl_squad,
      lcl_fitness,
      lcl_referral_source,
      lcl_usertext1,
      lcl_usertext2,
      lcl_usertext3,
      lcl_usertext4,
      lcl_usertext5,
      lcl_usertext6,
      lcl_usertext7,
      lcl_usertext8,
      lcl_userlist1,
      lcl_userlist2,
      lcl_userlist3,
      lcl_userlist4,
      lcl_userlist5,
      lcl_userlist6,
      lcl_userlist7,
      lcl_pricelevel,
      lcl_regdate,
      lcl_contrastart,
      lcl_completed_ad,
      lcl_ad_reviewed,
      lcl_vfc,
      lcl_mothersname,
      lcl_guardiansname,
      lcl_allow_imm_reg_use,
      lcl_allow_imm_info_share,
      lcl_allow_health_info_ex,
      lcl_allow_patient_portal,
      lcl_deceased_date,
      lcl_deceased_reason,
      lcl_soap_import_status;
          
         
                      
  end while;

  close cur_patient_data;

  
  
  -- Cleanup Scripts:
  SET @@session.foreign_key_checks= @old_foreign_key_checks;
  
END#