-- DROP PROCEDURE IF EXISTS  `openemr`.`PatientData_To_Improved_Layout2`;

-- DROP PROCEDURE IF EXISTS  `openemr`.`PatientData_To_Improved_Layout`;
DROP PROCEDURE IF EXISTS  `openemr`.`Insurance_To_Improved_Layout`;

delimiter #
  

CREATE PROCEDURE `openemr`.Insurance_To_Improved_Layout()
begin
  -- Note: does not move current insurrance_numbers which are numbers about the practice itself.
  
  -- Need to create variables for each value.
  

  DECLARE current_insurance_id bigint(20);
  DECLARE current_insurance_business_id bigint(20);
  DECLARE current_patient_id bigint(20);
  DECLARE current_person_id bigint(20);
  DECLARE current_employer_business_id bigint(20);
  DECLARE current_business_id bigint(20);
  DECLARE current_contact_id bigint(20);
  DECLARE current_address_id bigint(20);
  DECLARE local_contact_id bigint(20);
  DECLARE local_person_id bigint(20);
  DECLARE local_address_id bigint(20);
  DECLARE current_telephone_id bigint(20);
  
  DECLARE current_patient_insurance_id bigint(20);
  
  DECLARE local_priority int(11);  
  DECLARE old_foreign_key_checks tinyint(1);
  
  DECLARE no_more_rows tinyint(1);
  DECLARE num_rows int(11);
  
  DECLARE lcl_id bigint(20) ;
  DECLARE lcl_type VARCHAR(20);
  DECLARE lcl_provider varchar(255) ;
  DECLARE lcl_plan_name varchar(255) ;
  DECLARE lcl_policy_number varchar(255) ;
  DECLARE lcl_group_number varchar(255) ;
  DECLARE lcl_subscriber_lname varchar(255) ;
  DECLARE lcl_subscriber_mname varchar(255) ;
  DECLARE lcl_subscriber_fname varchar(255) ;
  DECLARE lcl_subscriber_relationship varchar(255) ;
  DECLARE lcl_subscriber_ss varchar(255) ;
  DECLARE lcl_subscriber_DOB date ;
  DECLARE lcl_subscriber_street varchar(255) ;
  DECLARE lcl_subscriber_postal_code varchar(255) ;
  DECLARE lcl_subscriber_city varchar(255) ;
  DECLARE lcl_subscriber_state varchar(255) ;
  DECLARE lcl_subscriber_country varchar(255) ;
  DECLARE lcl_subscriber_phone varchar(255) ;
  DECLARE lcl_subscriber_employer varchar(255) ;
  DECLARE lcl_subscriber_employer_street varchar(255) ;
  DECLARE lcl_subscriber_employer_postal_code varchar(255) ;
  DECLARE lcl_subscriber_employer_state varchar(255) ;
  DECLARE lcl_subscriber_employer_country varchar(255) ;
  DECLARE lcl_subscriber_employer_city varchar(255) ;
  DECLARE lcl_copay varchar(255) ;
  DECLARE lcl_date date ;
  DECLARE lcl_pid bigint(20) ;
  DECLARE lcl_subscriber_sex varchar(25) ;
  DECLARE lcl_accept_assignment varchar(5) ;
  DECLARE lcl_policy_type varchar(25) ;

  -- Declare the cursor
  DECLARE cur_insurance_data_data CURSOR FOR
  SELECT
    `insurance_data`.`id`,
    `insurance_data`.`type`,
    `insurance_data`.`provider`,
    `insurance_data`.`plan_name`,
    `insurance_data`.`policy_number`,
    `insurance_data`.`group_number`,
    `insurance_data`.`subscriber_lname`,
    `insurance_data`.`subscriber_mname`,
    `insurance_data`.`subscriber_fname`,
    `insurance_data`.`subscriber_relationship`,
    `insurance_data`.`subscriber_ss`,
    `insurance_data`.`subscriber_DOB`,
    `insurance_data`.`subscriber_street`,
    `insurance_data`.`subscriber_postal_code`,
    `insurance_data`.`subscriber_city`,
    `insurance_data`.`subscriber_state`,
    `insurance_data`.`subscriber_country`,
    `insurance_data`.`subscriber_phone`,
    `insurance_data`.`subscriber_employer`,
    `insurance_data`.`subscriber_employer_street`,
    `insurance_data`.`subscriber_employer_postal_code`,
    `insurance_data`.`subscriber_employer_state`,
    `insurance_data`.`subscriber_employer_country`,
    `insurance_data`.`subscriber_employer_city`,
    `insurance_data`.`copay`,
    `insurance_data`.`date`,
    `insurance_data`.`pid`,
    `insurance_data`.`subscriber_sex`,
    `insurance_data`.`accept_assignment`,
    `insurance_data`.`policy_type`
  FROM `openemr`.`insurance_data`
  WHERE `insurance_data`.`dataupgradeDone` = 0;
	  
  -- Declare 'handlers' for exceptions
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET no_more_rows = TRUE;


  -- The following add columns to the table in order to make the function re-entrant.
    IF NOT EXISTS( SELECT 1
                FROM INFORMATION_SCHEMA.COLUMNS
               WHERE table_name = 'insurance_data'
                 AND table_schema = 'openemr'
                 AND column_name = 'dataupgradeDone')  THEN

      ALTER TABLE `openemr`.`insurance_data` ADD dataupgradeDone tinyint default 0;
    END IF;

    IF NOT EXISTS( SELECT 1
              FROM INFORMATION_SCHEMA.COLUMNS
             WHERE table_name = 'insurance_data'
               AND table_schema = 'openemr'
               AND column_name = 'dataupgradeStart')  THEN

      ALTER TABLE `openemr`.`insurance_data` ADD dataupgradeStart tinyint default 0;

    END IF;


  -- 'open' the cursor and capture the number of rows returned
  -- (the 'select' gets invoked when the cursor is 'opened')
  set no_more_rows = false;
  
  -- Get current foreign_key_checks and turn it off.
  -- This will be turned back on during the closing of this stored procedure.
  
  SET @old_foreign_key_checks = @@session.foreign_key_checks;
  SET global foreign_key_checks= 0;  
  
  
  OPEN cur_insurance_data_data;
  select FOUND_ROWS() into num_rows;
  
  -- Get the data into the cursor.
  FETCH  cur_insurance_data_data
        INTO   
      lcl_id,
      lcl_type,
      lcl_provider,
      lcl_plan_name,
      lcl_policy_number,
      lcl_group_number,
      lcl_subscriber_lname,
      lcl_subscriber_mname,
      lcl_subscriber_fname,
      lcl_subscriber_relationship,
      lcl_subscriber_ss,
      lcl_subscriber_DOB,
      lcl_subscriber_street,
      lcl_subscriber_postal_code,
      lcl_subscriber_city,
      lcl_subscriber_state,
      lcl_subscriber_country,
      lcl_subscriber_phone,
      lcl_subscriber_employer,
      lcl_subscriber_employer_street,
      lcl_subscriber_employer_postal_code,
      lcl_subscriber_employer_state,
      lcl_subscriber_employer_country,
      lcl_subscriber_employer_city,
      lcl_copay,
      lcl_date,
      lcl_pid,  
      lcl_subscriber_sex,
      lcl_accept_assignment,
      lcl_policy_type;

  while NOT no_more_rows do

      -- Set the current record that we are changing to 
      update `openemr`.`insurance_data` 
        set dataupgradeStart  = 1 
        where id = lcl_id;

      

      SELECT `patient_id`,`person_id` into current_patient_id, current_person_id 
         from `demographics-test`.`patient` 
         where `imported_patient_id`= lcl_pid 
          AND imported_patient_id IS NOT NULL
          AND person_id IS NOT NULL
       limit 1 ; -- Shouldn't need to limit this to one, but for testing purposes.

      -- DEBUG: The following value is returned for debugging purposes.
      select current_patient_id, current_person_id;
      
      
      -- convert the priorites given in the table to numeric values.
      -- convert primary => 1, etc.  and -1 for everything else.
      CASE lcl_type
          WHEN 'primary' THEN SET local_priority = 1 ;
          WHEN 'secondary' THEN SET local_priority = 2;
        WHEN 'tertiary' THEN SET local_priority = 3;
          ELSE
            BEGIN
          SET local_priority = -1; 
            END;
        END CASE;
      
      
      INSERT INTO `demographics-test`.`patient_insurance`
      (
      `patient_id`,
      `priority`,
      `plan_name`,
      `policy_no`,
      `group_no`,
      `policy_type`,
      `copay`,
      `accept_assignment`)
      VALUES
      ( current_patient_id, local_priority, lcl_plan_name, lcl_policy_number, 
        lcl_group_number, lcl_policy_type, lcl_copay, lcl_accept_assignment
      );  

      SELECT LAST_INSERT_ID() into current_patient_insurance_id;

      -- DEBUG: The following value is returned for debugging purposes.
      SELECT current_patient_insurance_id;
      

      -- Create employer business
      insert into `demographics-test`.`business`
        (`type`)
      VALUES ('EMPLOYER');
      
      SELECT LAST_INSERT_ID() into current_business_id;
      
      -- DEBUG: The following value is returned for debugging purposes.
      SELECT current_business_id;
      
      
    INSERT INTO `demographics-test`.`business_name`
    (
      `business_id`,
      `business_name`,
      `type`,
      `priority`)
    VALUES
    (
      current_business_id,
      lcl_subscriber_employer,
      'LEGAL',
      1
    );

    -- Handle Contact and address information
      
      -- Create a contact
      insert into `demographics-test`.`contact` 
           (`source_table`, `source_table_id`)
       VALUES ('business',current_business_id);
       
      SELECT LAST_INSERT_ID() into current_contact_id;
       
      -- DEBUG: The following value is returned for debugging purposes.
      SELECT current_contact_id;

      -- Address
      -- If address exists then we need to update the other values, like phone
      insert into `demographics-test`.`contact_to_contact_address`
        (`contact_id`) 
        values (current_contact_id);
      
      SELECT LAST_INSERT_ID() into current_address_id;
      
      insert into `demographics-test`.`contact_address`
        ( `contact_address`.`contact_address_id`,
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
         values (current_address_id, 
              1, 
              'main', -- type
              '', -- title
              lcl_subscriber_employer_street,
              null, -- street_line_2
              lcl_subscriber_employer_city,
              lcl_subscriber_employer_state,
              lcl_subscriber_employer_postal_code,
              lcl_subscriber_employer_country,
              DATE(NOW()), DATE(NOW()));


      -- If relationship is self then we just need to connect the company to the person.
      if lcl_subscriber_relationship = 'self' THEN 
         
         insert into `demographics-test`.`person_employment`
          (`person_employment`.`person_id`,
        `person_employment`.`business_id`)
          VALUES (current_person_id, 
          current_business_id)
          ON DUPLICATE KEY UPDATE `person_employment`.`business_id`= current_business_id;
       
      -- else we need to create a new person.
      ELSEIF EXISTS (
        
      -- Need to insert a new person and make them contact, probably check to see if they are not already there.
      -- Checks only first and last name, does not check middle initial.
      select * 
         from `demographics-test`.`person_secondary_contact` 
            inner join `demographics-test`.`person` on `person_secondary_contact`.`secondary_contact_person_id` = `person`.`person_id`
          inner join `demographics-test`.`person_name` on `person`.`person_id` = `name`.`person_id`
          
         
         where `source_person_id` = current_person_id 
         -- Logic to match which person.
         and `person_name`.`person_last_name` = lcl_subscriber_lname AND `person_name`.`person_first_name` = lcl_subscriber_fname)
         
         THEN 
         
         -- Will assume that if someone already has a contact of the same name we can use them.
         
           insert into `demographics-test`.`person_employment`
          (`person_employment`.`person_id`,
            `person_employment`.`business_id`)
          VALUES (current_person_id, 
            current_business_id)
          ON DUPLICATE KEY UPDATE `person_employment`.`business_id`= current_business_id;
       ELSE
       -- The subscriber does not appear to exist, so we need to create them.
       BEGIN
          insert into `demographics-test`.`contact` 
             (`source_table`, `source_table_id`)
           VALUES ('person',-1);
      
           SELECT LAST_INSERT_ID() into local_contact_id;
      
          insert into `demographics-test`.`person` 
             (  `contact_id`,`birthdate`, `social_security_number`,  `gender`) 
          VALUES (@local_contact_id, lcl_subscriber_DOB, lcl_subscriber_ss, substring(`lcl_subscriber_sex`,1,1)) ;
      
          SELECT LAST_INSERT_ID() into local_person_id;
          
          -- Update contact with the new person
           update `demographics-test`.`contact`  SET 
             `source_table_id` = @local_person_id
           where `contact_id` = @local_contact_id;
        
          -- Add relationship
           insert into `demographics-test`.`person_secondary_contact`
            (`person_secondary_contact`.`source_person_id`,
            `person_secondary_contact`.`secondary_contact_person_id`,
            `person_secondary_contact`.`priority`,
            `person_secondary_contact`.`relationship`)
          VALUES
          (current_person_id, local_person_id,  1, 'contact');

          -- Add person_employment	  
           insert into `demographics-test`.`person_employment`
          (`person_employment`.`person_id`,
            `person_employment`.`business_id`)
          VALUES (local_person_id, 
          current_business_id);

          -- Add Name
           insert into `demographics-test`.`person_name`
            (`person_name`.`person_id`,
          `person_name`.`person_last_name`,
          `person_name`.`person_first_name`,
          `person_name`.`person_middle_name`,
          `person_name`.`priority`,
          `person_name`.`type`)
          VALUES (local_person_id, 
          lcl_subscriber_lname, lcl_subscriber_fname, lcl_subscriber_mname, 
          1,
          'default'
          );

          -- Add Address
             insert into `demographics-test`.`contact_to_contact_address`
            (`contact_id`) 
            values (local_contact_id);
            
            SELECT LAST_INSERT_ID() into local_address_id;
            
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
          values (local_address_id, 1, 'main',
                  '', -- title
                  lcl_subscriber_street, -- street_line_1
                  null, -- street_line_2
                  lcl_subscriber_city,
                  lcl_subscriber_state,
                  lcl_subscriber_postal_code, 
                  lcl_subscriber_country,
                  DATE(NOW()), DATE(NOW())
                );
          -- Add Phone	  
          insert into `demographics-test`.`contact_to_contact_telephone`
            (`contact_id`) 
          values (local_contact_id);
          
          
          SELECT LAST_INSERT_ID() into current_telephone_id;
          
          -- check if not null or empty
          insert into `demographics-test`.`contact_telephone`
          (`contact_telephone`.`contact_telephone_id`,
            `contact_telephone`.`contact_address_id`,
            `contact_telephone`.`priority`,
            `contact_telephone`.`type`,
            `contact_telephone`.`telephone_number`,
            `contact_telephone`.`created_date`,
            `contact_telephone`.`activated_date`)
        VALUES (local_telephone_id,local_address_id, 1, 'home',lcl_subscriber_phone, DATE(NOW()), DATE(NOW()));


       END;
      END IF; -- If for the type of relationship the subscriber is.
      
      
      -- Set data to complete
      update `openemr`.`insurance_data` 
      set dataupgradeDone  = 1 
      where id = lcl_id;
      
      FETCH  cur_insurance_data_data
            INTO   
              lcl_id,
              lcl_type,
              lcl_provider,
              lcl_plan_name,
              lcl_policy_number,
              lcl_group_number,
              lcl_subscriber_lname,
              lcl_subscriber_mname,
              lcl_subscriber_fname,
              lcl_subscriber_relationship,
              lcl_subscriber_ss,
              lcl_subscriber_DOB,
              lcl_subscriber_street,
              lcl_subscriber_postal_code,
              lcl_subscriber_city,
              lcl_subscriber_state,
              lcl_subscriber_country,
              lcl_subscriber_phone,
              lcl_subscriber_employer,
              lcl_subscriber_employer_street,
              lcl_subscriber_employer_postal_code,
              lcl_subscriber_employer_state,
              lcl_subscriber_employer_country,
              lcl_subscriber_employer_city,
              lcl_copay,
              lcl_date,
              lcl_pid,
              lcl_subscriber_sex,
              lcl_accept_assignment,
              lcl_policy_type;
      
  end while;
  
  
  -- Do necessary cleanup and shut down items.
  
  close cur_insurance_data_data;
  
  -- Cleanup Scripts:
  SET @@session.foreign_key_checks= @old_foreign_key_checks;
  
END#

