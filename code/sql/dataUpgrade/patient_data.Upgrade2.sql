-- Requires clean up

drop procedure if exists PatientData_To_Improved_Layout;

delimiter #

CREATE PROCEDURE PatientData_To_Improved_Layout()
begin
  -- Need to create variables for each value.
  
  -- Change Table
  -- ALTER TABLE `paitent_data` ADD dataupgradeDone binary default 0;
  -- ALTER TABLE `paitent_data` ADD dataupgradeStart binary default 0;
  
  DECLARE lcl_ss as varchar(255); 
  DECLARE lcl_DOB as date; 
  DECLARE lcl_sex as varchar(255); 
  DECLARE lcl_mothersname as varchar(255); 
  DECLARE lcl_id as bigint(20); 
  DECLARE lcl_pid as bigint(20); 
  
  
  -- Declare the cursor
  DECLARE cur_patient_data CURSOR FOR
    SELECT
        `id`,`pid`,`sex`, `ss`, `mothersname`, `DOB`
    FROM patient_data
  --  WHERE dataupgradeDone = 0
	order by patient_data.id desc
	  
  
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
  OPEN cur_patient_data;
  select FOUND_ROWS() into num_rows;

  
  -- start transaction; -- Have to work on the fact that these are not supported. 
  while NOT no_more_rows do
--  `id`,`pid`,`sex`, `ss`, `mothersname`, `DOB`
  FETCH  cur_patient_data
    INTO   lcl_id, 	lcl_pid, lcl_sex , lcl_ss ,   lcl_mothersname, lcl_dob
  insert into `patient_data_test` (  `id`,`pid`,`sex`, `ss`, `mothersname`, `DOB`) VALUES lcl_id, 	lcl_pid, lcl_sex , lcl_ss ,   lcl_mothersname, lcl_dob
	
	
  end while;
  -- commit;

  CLOSE cur_patient_data;
end#

delimiter ;


