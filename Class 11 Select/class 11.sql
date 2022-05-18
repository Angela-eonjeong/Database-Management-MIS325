--#1 
Select *
from vendors; 

--#2 
Select Vendor_ID, Vendor_Name, VENDOR_ADDRESS1, VENDOR_ADDRESS2, VENDOR_CITY, VENDOR_STATE, VENDOR_ZIP_CODE
from vendors;

--#3,4 
Select  Vendor_ID, 
        Vendor_Name, 
        VENDOR_ADDRESS1 || ' ' || 
        VENDOR_ADDRESS2 || ',' || 
        VENDOR_CITY || ',' || 
        VENDOR_STATE || ' ' ||  
        VENDOR_ZIP_CODE as Vender_address 
from vendors;

--#5,6,7 
Select  vendor_ID,
        invoice_total, payment_total, 
        invoice_total - payment_total as "Amount_Owed"
from invoices
where Rownum <= 5;


--#8
select *
from dual;

--#9
select 'hello,' as "Hello",
        'my name is' as "my name ",
        'Angela' as "Your name"
from dual;

select 18*36 
from dual ; 

--#10
Select Sysdate as "Today's date",
       MOD(3942/17, 1) AS remainder,
       To_char ( sysdate, 'MM/DD/YYYY'),
       To_char ( sysdate, 'DD/MM/YYYY')
from dual; 


--#11 
Select  invoice_id, 
        invoice_number, 
        invoice_total, 
        invoice_date, 
        invoice_date - sysdate as "Days till Due"
from invoices;


--#11 (2nd function) 
SELECT invoice_id, invoice_number, invoice_total, invoice_date, 
    ROUND(SYSDATE - invoice_date)  AS invoice_age_in_days
FROM invoices;

--#12 
Select round(avg(invoice_total),2) as invoice_amount
from invoices; 

select * from invoices;

--#13 
select  substr ( customer_first_name, 1, 1) ||
        substr ( customer_last_name, 1, 1) as Initials,
        substr ( customer_phone, 1, 3) || '-' ||
        substr ( customer_phone, 4, 3) || '-' ||
        substr ( customer_phone, 8, 4) as phone_num
from customers_OM; 



--#14
Select Count(*)
From (
        select distinct vendor_name
        FROM vendors);

--#15
Select Count(*)
From (
        Select DISTINCT vendor_id
        FROM invoices);




