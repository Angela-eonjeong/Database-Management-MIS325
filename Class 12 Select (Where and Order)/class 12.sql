
-- #1
Select VENDOR_ID, VENDOR_NAME, VENDOR_ADDRESS1, VENDOR_ADDRESS2, VENDOR_CITY, VENDOR_STATE, VENDOR_ZIP_CODE
from vendors
order by VENDOR_STATE asc; 

--#2
Select VENDOR_ID, VENDOR_NAME, VENDOR_ADDRESS1, VENDOR_ADDRESS2, VENDOR_CITY, VENDOR_STATE, VENDOR_ZIP_CODE
from vendors
order by VENDOR_STATE desc; 

--#3 
Select VENDOR_ID,VENDOR_NAME, VENDOR_ADDRESS1, VENDOR_ADDRESS2, VENDOR_CITY, VENDOR_STATE, VENDOR_ZIP_CODE
from vendors
order by VENDOR_STATE, VENDOR_CITY, VENDOR_NAME asc; 

--#4
Select VENDOR_ID, VENDOR_NAME as name, VENDOR_ADDRESS1, VENDOR_ADDRESS2, VENDOR_CITY, VENDOR_STATE, VENDOR_ZIP_CODE
from vendors
order by name asc; 

--#5
Select VENDOR_ID, VENDOR_NAME as name, VENDOR_ADDRESS1, VENDOR_ADDRESS2, VENDOR_CITY, VENDOR_STATE, VENDOR_ZIP_CODE
from vendors
order by name asc; 

--###26 
SELECT *
FROM invoices
WHERE ROWNUM <=5
ORDER BY invoice_id DESC;

SELECT *
FROM invoices
ORDER BY invoice_id DESC
FETCH first 5 ROWS ONLY;

SELECT *
FROM invoices
ORDER BY invoice_id DESC
OFFSET 2 ROWS FETCH Next 5 ROWS ONLY;

--##7
Select VENDOR_ID, VENDOR_NAME, VENDOR_ADDRESS1, VENDOR_ADDRESS2, VENDOR_CITY, VENDOR_STATE, VENDOR_ZIP_CODE
from vendors
where VENDOR_STATE = 'NY' or VENDOR_STATE = 'NJ'; 

--##8
Select VENDOR_ID, VENDOR_NAME, VENDOR_ADDRESS1, VENDOR_ADDRESS2, VENDOR_CITY, VENDOR_STATE, VENDOR_ZIP_CODE
from vendors
where VENDOR_STATE in ('NY','NJ');

--#9 
Select VENDOR_ID, VENDOR_NAME, VENDOR_ADDRESS1, VENDOR_ADDRESS2, VENDOR_CITY, VENDOR_STATE, VENDOR_ZIP_CODE
from vendors
where VENDOR_STATE not in ('NY','NJ');

--##10 
select invoice_id, invoice_total
from invoices 
order by invoice_total desc 
fetch first 7 rows only ;

SELECT invoice_id, invoice_total
FROM (SELECT * FROM invoices ORDER BY invoice_total DESC)
WHERE ROWNUM<=7;

--##11 
select INVOICE_ID, INVOICE_ID - PAYMENT_TOTAL - CREDIT_TOTAL as "Balance Due"
from invoices
where INVOICE_ID - PAYMENT_TOTAL - CREDIT_TOTAL  = 0 ; 

--###12
Select *
from Customers_OM
where CUSTOMER_FIRST_NAME || ' ' || CUSTOMER_LAST_NAME in 'Korah Blanca'; 

--#12-2 (not work)
SELECT customer_id, customer_first_name || ' ' || customer_last_name AS cust_name
FROM Customers_OM
WHERE cust_name IN ('Korah Blanca');

--###13 
select *
from Customers_om
where CUSTOMER_LAST_NAME like 'Dam%';

select *
from Customers_om
where substr(CUSTOMER_LAST_NAME,1,3) = 'Dam';

--#14 
select *
from invoices 
where invoice_date between sysdate and sysdate+120;

--####15 
select *
from invoices 
where invoice_due_date between sysdate and sysdate+120
and payment_total = 0; 

--##16 
select *
from vendors
where VENDOR_CITY = 'Sacramento' and VENDOR_STATE = 'CA';  


--#17 
    select *
    from vendors
    where VENDOR_CITY = 'Sacramento' or VENDOR_STATE = 'CA';  

--#18 
	select * 
	from vendors
	where not (vendor_state = 'CA' or vendor_city = 'Sacramento')
    order by vendor_state asc;
    
    
--#19
select *
from vendors
where Vendor_phone is null;

--#20
select *
from vendors
where Vendor_name like '%Gas%';

--#21 
select *
from vendors 
where Vendor_name like '%gas%';

--#22 
select *
from vendors 
where vendor_name like 'B%';

--#23
    select * 
	from vendors
	where vendor_phone IS NOT NULL;
    
--#24 
SELECT vendor_id
from vendors 
where vendor_id in (select vendor_id from invoices where invoice_total > 1000) ;

--#25 
SELECT vendor_id, vendor_state
from vendors 
where vendor_id in (select vendor_id from invoices where invoice_total > 1000) 
and vendor_state = 'CA' ;

