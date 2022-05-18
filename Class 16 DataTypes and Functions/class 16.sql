--#1 date 변경  
select sysdate as unformatted,
        Upper(To_CHAR(sysdate, 'mon-yyyy')) as formatted1,
        INITCAP(To_CHAR(sysdate, 'month dd, yyyy')) as formatted2,
        To_CHAR(sysdate, 'mm/dd/yy hh:mi:ss')  as formatted3,
        UPPER(To_CHAR(sysdate, 'dy, mm-dd-yyyy' )) as formatted4
from dual;

--#2 $로 숫자 형태 변형
select  invoice_total as unformatted
        ,To_CHAR(invoice_total,'$999.99') as formatted1
        ,To_CHAR(invoice_total,'$99,999.99') as formatted2
        ,To_CHAR(invoice_total,'$99,999') as formatted3
from invoices;

--#3 formating string 
select  UPPER(vendor_name),
        LOWER(vendor_state) as state,
        Trim(to_char(invoice_date,'Month')) || ' ' ||to_char(invoice_date,'DD, YYYY')as invoice_date,
        LPAD(invoice_total , 15, '.') as invoice_total
from    vendors v inner join invoices i
         on v.vendor_id = i.vendor_id
order by v.vendor_name;


--#4 

select  vendor_phone as unformatted_phone,
        Replace(Replace(vendor_phone, '(',''), ') ', '-') as phone_replace,
        SUBSTR(vendor_phone,2,3) || '-' || 
        SUBSTR(vendor_phone,7,3) || '-' ||
        SUBSTR(vendor_phone,11,4)
        as phone_substr,
        Length(vendor_phone) as phone_length
from vendors ;


--#5 Parse substr, instr
select  product_name
        , SUBSTR(product_name, 1, INSTR(product_name, ' ') -1) Brand 
        , SUBSTR(product_name, INSTR(product_name, ' ') +1) as Instrument_Name
from products;

--#6 Numeric function 
SELECT  floor(12.4999) as Round_Whole,
        Round(12.4999,2) as Round_Decimal,
        Trunc(12.4999,2) as Format_TRUNC
FROM DUAL;


--#7 date function
Select  SYSDATE - TO_DATE('01-JAN-22') as Days_since_New_Year,
        Round(SYSDATE - TO_DATE('01-JAN-22')) as Days_Rounded,
        Round(Months_between(sysdate, '01-JAN-22'),2) as Mths_between,
        sysdate + 30, 
        ADD_Months(sysdate,1) 
from    DUAL; 


--#8 date/time searches 
select * 
from date_sample ;

--#9 case 
select  product_name,
        list_price,
        Case category_id 
            When 1 Then 'Guitars'
            When 2 Then  'Bass'
            When 3 Then 'Drums'
            When 4 Then 'Keyboard'
        End As category_name
from products
order by category_name, list_price asc; 

--#10 case search
Select product_name,
        list_price, 
        Case 
            When list_price >= 1000 Then 'Professional'
            When List_price >= 500 Then  'Intermediate'
            Else 'Beginner' 
        End As product_grade
from products;

--#11 nulls

Select Vendor_id
        , Vendor_name
        , NVL(vendor_phone, 'update contact') as contact_check
from vendors; 

--#12 nulls

Select Vendor_id
        , Vendor_name
        , NVL2(vendor_phone, 'okay', 'update contact') as contact_check
from vendors
order by contact_check; 

--#13 Rank, dense rank 
select product_name
        , list_price
        , rank() over (order by list_price desc) as rank 
from products;

--#14 row number 
select * 
from 
        (SELECT ROW_NUMBER() OVER(ORDER BY vendor_name) 
               AS row_number, vendor_name
        FROM vendors);
    

--#15 CAST 


--#16 
