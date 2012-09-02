
-- Select Statement for 
select business_name.business_name, contact_address.street_line_1, contact_address.street_line_2,
contact_address.city, contact_address.state, contact_address.postal_code 
from business
   inner join contact 
      on business.contact_id = contact.contact_id
   inner join contact_to_contact_address 
      on contact.contact_id = contact_to_contact_address.contact_id
   inner join contact_address 
      on contact_to_contact_address.contact_address_id = contact_address.contact_address_id
   inner join business_name 
      on business_name.business_id = business.business_id 
where 
-- Business Name
business_name.priority = 1 AND contact_address.priority = 1



