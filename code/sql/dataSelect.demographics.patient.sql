select id, -- 
title, -- missing
person_lanuage.xxx as language, -- done
financial, --  missing
person_first_name.xxx as fname, -- done
person_last_name.xxx as lname, -- done
mname, -- question
person.birthdate as DOB, -- 
contact_address.xxx as street, -- 
contact_address.xxx as postal_code, -- 
contact_address.xxx as city, -- 
contact_address.xxx as state, -- 
contact_address.xxx as country_code, -- 
person.drivers_license as drivers_license, -- missing
person.social_security_number as ss, -- 
person_employment.occupation as occupation, -- 
contact_telephone_home.telephone_number as phone_home, -- 
contact_telephone_biz.telephone_number as phone_biz, -- 
person_secondary_contact_telephone.telephone_number as phone_contact, -- what is this field
contact_telephone_cell.telephone_number as phone_cell, -- 
patient_pharmacy.pharmacy_id as pharmacy_id, -- 
status, -- martial status
person_secondary_contact.relationship as contact_relationship, -- 
date, -- ???
person.gender as sex, -- 
referrer, --  ???
referrerID, -- ???
patient_insurance.insurance_company_id as  providerID, -- ???
contact_email_web.value as email, 
person.ethnoracial as ethnoracial, -- may move
person.race as race, -- may move
person.ethnicity as ethnicity, -- 
patient.interpretter as interpretter, -- may move
person.migrantseasonal as migrantseasonal, -- may move
person.family_size as family_size, -- may move
person.monthly_income as monthly_income, -- may move
person.homeless as homeless, -- may move
patient.financial_review as financial_review, -- may move
pubpid, -- public id
patient.patient_id as pid, -- 
patient.genericname1 as genericname1, -- may move
patient.genericval1 as genericval1, -- may move
patient.genericname2 as genericname2, -- may move
patient.genericval2 as genericval2, -- may move
patient.hipaa_mail as hipaa_mail, -- may move
patient.hipaa_voice as hipaa_voice, -- may move
patient.hipaa_notice as hipaa_notice, -- may move
patient.hipaa_message as hipaa_message, -- may move
patient.hipaa_allowsms as hipaa_allowsms, -- may move
patient.hipaa_allowemail as hipaa_allowemail, -- may move
patient.squad as squad, -- may move
patient.fitness as fitness, -- may move

referral_source, -- ???

patient.usertext1 as usertext1, -- may move
patient.usertext2 as usertext2, -- may move
patient.usertext3 as usertext3, -- may move
patient.usertext4 as usertext4, -- may move
patient.usertext5 as usertext5, -- may move
patient.usertext6 as usertext6, -- may move
patient.usertext7 as usertext7, -- may move
patient.usertext8 as usertext8, -- may move
patient.userlist1 as userlist1, -- may move
patient.userlist2 as userlist2, -- may move
patient.userlist3 as userlist3, -- may move
patient.userlist4 as userlist4, -- may move
patient.userlist5 as userlist5, -- may move
patient.userlist6 as userlist6, -- may move
patient.userlist7 as userlist7, -- may move
patient.pricelevel as pricelevel, -- may move
patient.regdate as regdate, -- may move
patient.contrastart as contrastart, -- may move
patient.completed_ad as completed_ad, -- may move
patient.ad_reviewed as ad_reviewed, -- may move

patient.vfc as vfc, -- 
person.mother_maiden_name as mothersname, -- 
guardiansname, -- 
patient.allow_imm_reg_use as allow_imm_reg_use, -- may move
patient.allow_imm_info_share as allow_imm_info_share, -- may move
patient.allow_health_info_ex as allow_health_info_ex, -- may move
patient.allow_patient_portal as allow_patient_portal, -- may move
deceased_date, -- 
deceased_reason, -- 
soap_import_status -- 
from person 
inner join patient on person.person_id = patient.person_id 
inner join person_lanuage on person_language.person_id = person.person_id -- does this need to be left join
inner join person_first_name on person_first_name.person_id = person_person_id
inner join person_last_name on person_last_name.person_id = person_person_id
-- Contact Details for Person
   inner join contact on contact.source_table_id = person.person_id and contact.source_table = 'person'
   inner join contact_to_contact_address on contact.contact_id = contact_to_contact_address.contact_id
   inner join contact_address on contact_address.contact_address_id = contact_to_contact_address.contact_address_id
   left join contact_to_contact_email_web on contact_to_contact_email_web.contact_id = contact.contact_id
   inner join contact_email_web on contact_email_web.contact_email_web_id = contact_to_contact_email_web.contact_email_web_id
   -- Phone Numbers
      inner join contact_to_contact_telephone on contact_to_contact_telephone.contact_id = contact.contact_id
      inner join contact_telephone as contact_telephone_home on contact_to_contact_telephone.contact_telephone_id = contact_telephone.contact_telephone_id
      inner join contact_telephone as contact_telephone_biz on contact_to_contact_telephone.contact_telephone_id = contact_telephone.contact_telephone_id
      inner join contact_telephone as contact_telephone_cell on contact_to_contact_telephone.contact_telephone_id = contact_telephone.contact_telephone_id
-- Employment
   inner join person_employment on person.person_id = person_employment.person_id
-- Secondary Contact 
   inner join person_secondary_contact on person.person_id = person_secondary_contact.source_person_id
   inner join person as person_secondary_contact_person on person_secondary_contact_person.person_id = person_secondary_contact.secondary_contact_person_id
   inner join contact as person_secondary_contact_contact on person_secondary_contact_contact.source_table_id = person_secondary_contact_person.person_id and contact.source_table = 'person'
   inner join contact_to_contact_telephone  as person_secondary_contact_contact_to_contact_telephone on person_secondary_contact_contact_to_contact_telephone.contact_id = contact.contact_id
   inner join contact_telephone as person_secondary_contact_telephone on contact_to_contact_telephone.contact_telephone_id = contact_telephone.contact_telephone_id
-- Pharmacy 
   left join patient_pharmacy on patient.patient_id = patient_pharmacy.patient_id
-- Insurance 
   inner join patient_insurance on patient.patient_id = patient_insurance.patient_id
-- guardian, optional 
   left join person_secondary_contact as person_secondary_contact_guardian on person_secondary_contact_guardian.source_person_id = person.contact_id and person_secondary_contact_guardian.is_guardian = 1
   inner join person as person_secondary_contact_guardian_person on person_secondary_contact_guardian_person.person_id = person_secondary_contact.secondary_contact_person_id
   inner join person_first_name as person_secondary_contact_guardian_person_first_name on person_secondary_contact_guardian_person_first_name.person_id = person_secondary_contact_guardian_person.person_id
   inner join person_last_name as person_secondary_contact_guardian_person_last_name on person_secondary_contact_guardian_person_last_name.person_id = person_secondary_contact_guardian_person.person_id
where 
person_lanuage.priority = 1 and 
person_first_name.priority = 1 and 
person_last_name.priority = 1 and 
contact_address.priority = 1 and
contact_telephone_home.priority = 1 and contact_telephone_home.type = 'home' and
contact_telephone_biz.priority = 1 and contact_telephone_biz.type = 'business' and  -- what to do about these priorities
contact_telephone_cell.priority = 1 and contact_telephone_cell.type = 'cell' and
person_secondary_contact.priority = 1 and 
person_secondary_contact_telephone.priority = 1 and
contact_email_web.priority =1 and contact_email_web.type = 'email' and 
person_secondary_contact_guardian_person_first_name.priority = 1 and 
person_secondary_contact_guardian_person_last_name.priority = 1 
