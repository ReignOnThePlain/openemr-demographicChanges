-- DROP PROCEDURE IF EXISTS  `openemr`.`PatientData_To_Improved_Layout2`;

-- DROP PROCEDURE IF EXISTS  `openemr`.`PatientData_To_Improved_Layout`;

delimiter #
  

CREATE PROCEDURE `openemr`.PatientData_To_Improved_Layout2()
begin
  -- Need to create variables for each value.
  
  -- Change Table
  -- ALTER TABLE `paitent_data` ADD dataupgradeDone binary default 0;
  -- ALTER TABLE `paitent_data` ADD dataupgradeStart binary default 0;
  
  DECLARE lcl_ss  varchar(255); 
  DECLARE lcl_DOB date; 
  DECLARE lcl_sex varchar(255); 
  DECLARE lcl_mothersname varchar(255); 
  DECLARE lcl_id bigint(20); 
  DECLARE lcl_pid bigint(20); 
  DECLARE no_more_rows tinyint(1);
  DECLARE num_rows int(11);
  
  -- Declare the cursor
  DECLARE cur_patient_data CURSOR FOR
    SELECT
        `id`,`pid`,`sex`, `ss`, `mothersname`, `DOB`
    FROM patient_data
  --  WHERE dataupgradeDone = 0
	order by patient_data.id desc;
	  
  
	  -- declare v_max int unsigned default 1000;
      -- declare v_counter int unsigned default 0;

   -- Declare 'handlers' for exceptions
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET no_more_rows = TRUE;

  
  /*
    Now the programming logic
  */

  -- 'open' the cursor and capture the number of rows returned
  -- (the 'select' gets invoked when the cursor is 'opened')
  set no_more_rows = false;
  
  OPEN cur_patient_data;
  select FOUND_ROWS() into num_rows;
  
  FETCH  cur_patient_data
        INTO   lcl_id, 	lcl_pid, lcl_sex , lcl_ss ,   lcl_mothersname, lcl_dob;
      
  while NOT no_more_rows do
--  `id`,`pid`,`sex`, `ss`, `mothersname`, `DOB`
      
  insert into `patient_data_test` 
      (  `id`,`pid`,`sex`, `ss`, `mothersname`, `DOB`) 
      VALUES (lcl_id, 	lcl_pid, lcl_sex , lcl_ss ,   lcl_mothersname, lcl_dob);
      
  FETCH  cur_patient_data
        INTO   lcl_id, 	lcl_pid, lcl_sex , lcl_ss ,   lcl_mothersname, lcl_dob;
          
         
                      
  end while;
  close cur_patient_data;
  
  
END#