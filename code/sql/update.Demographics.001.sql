-- Add changes to update patient and other tables to match needed data
ALTER TABLE contact_email_web add `value` varchar(255);
ALTER TABLE person add ethnoracial varchar(255);
ALTER TABLE person add race varchar(255);
ALTER TABLE person add ethnicity  varchar(255);
ALTER TABLE patient add interpretter  varchar(255);
ALTER TABLE person add migrantseasonal  varchar(255);
ALTER TABLE person add family_size  varchar(255);
ALTER TABLE person add monthly_income  varchar(255);
ALTER TABLE person add homeless  varchar(255);
ALTER TABLE patient add financial_review datetime;
ALTER TABLE patient add pubpid  varchar(255);
ALTER TABLE patient add genericname1  varchar(255) ;
ALTER TABLE patient add genericval1  varchar(255);
ALTER TABLE patient add genericname2  varchar(255);
ALTER TABLE patient add genericval2  varchar(255);
ALTER TABLE patient add hipaa_mail varchar(3);
ALTER TABLE patient add hipaa_voice varchar(3);
ALTER TABLE patient add hipaa_notice varchar(3);
ALTER TABLE patient add hipaa_message  varchar(20);
ALTER TABLE patient add hipaa_allowsms varchar(3);
ALTER TABLE patient add hipaa_allowemail varchar(3);
ALTER TABLE patient add squad varchar(32);
ALTER TABLE patient add fitness int(11);
ALTER TABLE patient add usertext1  varchar(255);
ALTER TABLE patient add usertext2  varchar(255);
ALTER TABLE patient add usertext3 varchar(255);
ALTER TABLE patient add usertext4 varchar(255);
ALTER TABLE patient add usertext5 varchar(255);
ALTER TABLE patient add usertext6 varchar(255);
ALTER TABLE patient add usertext7 varchar(255);
ALTER TABLE patient add usertext8 varchar(255);
ALTER TABLE patient add userlist1 varchar(255);
ALTER TABLE patient add userlist2 varchar(255);
ALTER TABLE patient add userlist3 varchar(255);
ALTER TABLE patient add userlist4 varchar(255);
ALTER TABLE patient add userlist5 varchar(255);
ALTER TABLE patient add userlist6 varchar(255);
ALTER TABLE patient add userlist7 varchar(255);
ALTER TABLE patient add pricelevel varchar(255);
ALTER TABLE patient add regdate date;
ALTER TABLE patient add contrastart date;
ALTER TABLE patient add completed_ad varchar(3);
ALTER TABLE patient add ad_reviewed date;
ALTER TABLE patient add vfc varchar(255);
ALTER TABLE patient add allow_imm_reg_use varchar(255);
ALTER TABLE patient add allow_imm_info_share varchar(255);
ALTER TABLE patient add allow_health_info_ex varchar(255);
ALTER TABLE patient add allow_patient_portal varchar(31);
alter table person add drivers_license varchar(255); 