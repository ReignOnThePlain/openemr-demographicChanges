select * from employer_data where pid='@pid';

New
select business_name.business_name, contact_address.street_line_1 + " "+
contact_address.street_line_2 as street
contact_address.city,
contact_address.state,
contact_address.postal_code
contact_address.postal_code_suffix,
contact_address.contry_code
-- ??? Date
* from patient inner join person on patient.person_id = person.person_id
inner join person_employment on person_employment.person_id = person.person_id
inner join business on person_employment.business_id = business.business_id
inner join business_name on business.business_id = business_name.business_id
inner join contact on business.business_id = contact.source_table_id and contact.source_table = 'business'
inner join contact_to_contact_address on contact_to_contact_address.contact_id = contact.contact_id
inner join contact_address on contact_to_contact_address.contact_address_id = contact_address.contact_address_id
where business_name.priority = 1 and contact_address.priority = 1
and patient.patient_id = '@pid'
