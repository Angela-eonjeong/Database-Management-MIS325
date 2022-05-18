drop table members;
drop table committees;
drop table member_committee;
 
create table members
(
 uteid          varchar(20)         not null     primary key,
 first_name     varchar(30),
 last_name      varchar(40),
 email          varchar(40),
 phone          varchar(12),
 grade          number(1),
 birthday       date 
 );


create table committees 
(
 committee_id         number(5)         primary key,
 committee_name       varchar(30),
 semester             varchar(4)
); 


create table member_committee
(
 uteid                varchar(20) ,        
 committee_id         number(5),
 Constraint member_committee primary key (uteid, committee_id),
 Constraint member_committee_fk_members foreign key (uteid) references members (uteid),
 Constraint member_committee_fk_committees foreign key (committee_id) references committees (committee_id), 
 Constraint member_committee_uq unique (committee_id) 

);


--change columns constraint (check) 

Alter table members
Add Constraint grade_check Check (grade >= 0) ; 


Alter table members
Add Constraint grade_check2 Check (grade in (1,2,3,4) ); 


--change column name 

Alter table members
Rename Column phone to phone_num ; 

--change column constraint (unique) 

Alter table members
Add Constraint email_constraint unique (email); 

--change column max length
Alter table members
modify UTEID varchar(10) ; 

--change column data type
Alter table members
modify phone_num char(12) ; 

--change column default constraint  
Alter table committees
add STATUS varchar(10) default 'active' ; 

Alter table committees
modify STATUS varchar(1) default 'A' ; 

Alter table committees
add constraint STATUS_chcek Check (Status in ('A','I')) ; 

-- add not null constraint 
Alter table committees
modify Status Constraint STATUS_nn not null; 

--change table name 
Rename members to new_member;
Rename new_member to members;

-- Truncate table
Truncate table new_member; 

-- drop table
drop table new_member;

-- drop constraint
Alter table members
drop constraint grade_check; 

-- drop column
Alter table new_member
drop column phone_num;

-- enable constraint (only new values)
Alter Table new_member
enable novalidate constraint grade_check;

-- disable
Alter Table new_member
Disable constraint grade_check;


select * from members;

