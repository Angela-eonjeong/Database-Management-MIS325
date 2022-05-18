----#1  Rollback vs Commit 
create table vendor_only_ca
as select vendor_name, vendor_address1, vendor_address2, vendor_city, vendor_phone from vendors
where vendor_state = 'CA'
order by vendor_city;

select * from vendor_only_ca;

update vendor_only_ca 
set vendor_name = 'who cares?!';

select * from vendor_only_ca ; 

rollback; 

select * from vendor_only_ca ; 

update vendor_only_ca 
set vendor_name = 'who cares?!';
commit;

select * from vendor_only_ca ; 

rollback; 

select * from vendor_only_ca ; 

drop table vendor_only_ca; 



--------#2 Insert, update. delete 

select * from ubc_members; 

INSERT INTO ubc_members
VALUES ('ek9882','Angela', 'Kim', 'ek9882@gmail.com', '000-000-0000', null, '03-may-98') ;

select * from ubc_members; 
select * from ubc_committees; 
select * from ubc_member_committees; 


INSERT INTO ubc_member_committees
VALUES ('ek9882',1);

update ubc_members
set first_name = 'Iggy', last_name = 'clint' 
where UTEID = 'ieo328';  

update ubc_members
set phone = Null
where YEAR_OC > 1; 


Update ubc_members
set YEAR_OC = YEAR_OC+1; 


Delete 
from ubc_members 
where UTEID = 'ek9882' ; 

Delete 
from ubc_member_commitees
where YEAR_OC = 4; 


commit; 

Delete uteid
from ubc_member_commitees
where in YEAR_OC = 4; 

 Select  mc.uteid, mc.committee_id, m.year_oc
 from    ubc_member_committees mc
 inner join ubc_members m on m.uteid = mc.uteid
 inner join ubc_committees c on mc.committee_id = c.committee_id;



 
