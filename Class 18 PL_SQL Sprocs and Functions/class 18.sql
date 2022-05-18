--#1 created procedure 
CREATE OR REPLACE PROCEDURE insert_vendor_contact 
(
  vendor_id_param  number,
  last_name_param  VARCHAR2,
  first_name_param VARCHAR2
)
AS
BEGIN
    INSERT INTO vendor_contacts
    VALUES (vendor_id_param ,last_name_param, first_name_param);
    COMMIT;
END;
/

--#2 call to insert 
--Call 1 
CALL insert_vendor_contact(1,'Thorton','Bob');
 
--Call 2
BEGIN
  insert_vendor_contact(2,'Williams','Selma');
END;
/

select * from vendor_contacts;

--#3 call to insert to created procedure 
CALL insert_vendor_contact(1,'Bob', 'Thorton');
 

--#4 create function 
CREATE OR REPLACE FUNCTION invoice_count
(
    vendor_id_param  NUMBER
)
RETURN NUMBER
AS 
    invoice_count_var NUMBER;
BEGIN 
    SELECT count(vendor_id)
    INTO invoice_count_var 
    From invoices
    where vendor_id = vendor_id_param;

    RETURN invoice_count_var;

END;
/

--#5 call created function 

SELECT vendor_id, vendor_name, invoice_count(vendor_id)
FROM vendors
WHERE invoice_count(vendor_id) > 0;


--#6 
CREATE OR REPLACE PROCEDURE insert_vendor_contact 
(
  vendor_id_param  number,
  last_name_param  VARCHAR2,
  first_name_param VARCHAR2 default '?'
)
AS
BEGIN
    INSERT INTO vendor_contacts
    VALUES (vendor_id_param ,last_name_param, first_name_param);
    COMMIT;
END;
/



CALL insert_vendor_contact(1,'Thorton','Bob');
 

CALL insert_vendor_contact(1,'Thorton');
 

