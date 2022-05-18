-- #1 
select * 
from invoices ;


--#2 
select  sum(invoice_total),         
        avg(invoice_total),
        min(invoice_total), 
        max(invoice_total),
        count(vendor_id)
from invoices ;


--#3 
select  sum(invoice_total),         
        round(avg(invoice_total),2),
        min(invoice_total), 
        max(invoice_total),
        count(distinct vendor_id)
from invoices ;


--#4 
SELECT	COUNT(*) AS number_of_invoices,
  		SUM(invoice_total) AS sum_of_invoice_totals,
		SUM( invoice_total - payment_total - credit_total ) as amount_due
FROM 	invoices;


--#5 
SELECT	COUNT(*) AS number_of_invoices,
  		SUM(invoice_total) AS sum_of_invoice_totals,
		SUM( invoice_total - payment_total - credit_total ) as amount_due
FROM 	invoices
Where   invoice_date > '15-FEB-21';


--#6 
Select vendor_state, count(vendor_id)
from vendors
group by vendor_state;




--#7
Select vendor_state, count(vendor_id)
from vendors
where vendor_state = 'CA'
group by vendor_state;

--#8
Select vendor_state, count(vendor_id)
from vendors
group by vendor_state
Having count(vendor_id) > 2 ;


select vendor_state, vendor_city
from vendors
where vendor_state = 'MI';

--#9 
Select vendor_state, vendor_city, count(vendor_id)
from vendors
group by vendor_city, vendor_state
order by vendor_city DESC;

Select vendor_state, vendor_city, count(vendor_id)
from vendors
group by vendor_state, vendor_city
order by  vendor_city  DESC;



--#10 
Select vendor_state, vendor_city, count(vendor_id)
from vendors
group by vendor_state, vendor_city
order by count(vendor_id) DESC;

 
--#11 
Select vendor_state, count(vendor_id)
from vendors
group by rollup (vendor_state)
order by count(vendor_id) ASC;

--#12 

Select vendor_state, vendor_city, count(vendor_id)
from vendors
group by rollup (vendor_state, vendor_city)
order by vendor_state ASC;

Select vendor_state, vendor_city, count(vendor_id)
from vendors
group by rollup (vendor_city, vendor_state)
order by vendor_city ASC;

--#13 
Select vendor_state, vendor_city, count(vendor_id)
from vendors
group by cube (vendor_state, vendor_city)
order by vendor_state ASC; 

--#14 
SELECT vendor_name, COUNT(*) AS invoice_qty,
    ROUND(AVG(invoice_total),2) AS invoice_avg
FROM vendors JOIN invoices
    ON vendors.vendor_id = invoices.vendor_id
GROUP BY vendor_name
HAVING AVG(invoice_total) > 500 --aggregate filter
ORDER BY invoice_qty DESC;

SELECT vendor_name, COUNT(*) AS invoice_qty,
    ROUND(AVG(invoice_total),2) AS invoice_avg
FROM vendors JOIN invoices
    ON vendors.vendor_id = invoices.vendor_id
WHERE invoice_total > 500   --row level filter
GROUP BY vendor_name
ORDER BY invoice_qty DESC;


--#15 
Select vendor_state, avg(invoice_total)
FROM vendors JOIN invoices
    ON vendors.vendor_id = invoices.vendor_id
where invoice_date > '15-APR-14'
group by vendor_state 
having avg(invoice_total) > 2000 ;


-- #16 
select min(Last_name)
from vendor_contacts;

select max(Last_name)
from vendor_contacts;

--#17 
select avg(vendor_id)
from vendors;

select avg(vendor_phone)
from vendors;

select avg(vendor_zip_code)
from vendors;

update vendors
set vendor_zip_code = '3333s'
where vendor_id = 1;

---# plus w/ group by
SELECT	DISTINCT vendor_state, 
        vendor_city, 
        COUNT(*) AS invoice_qty, 
        ROUND(sum(invoice_total),2) AS invoice_avg
FROM invoices JOIN vendors ON invoices.vendor_id = vendors.vendor_id
group by vendor_state, vendor_city
ORDER BY vendor_state, vendor_city;

---# plus w/o group by
SELECT  DISTINCT vendor_state, 
        vendor_city, 
        COUNT(*) OVER (PARTITION BY vendor_state, vendor_city) AS invoice_qty, 
        SUM(invoice_total) OVER (PARTITION BY vendor_state, vendor_city) AS invoice_sum
FROM invoices JOIN vendors ON invoices.vendor_id = vendors.vendor_id
ORDER BY vendor_state, vendor_city;


--# 
SELECT  DISTINCT vendor_state, 
        vendor_city, 
        COUNT(*) OVER (PARTITION BY vendor_state) AS invoice_qty, 
        SUM(invoice_total) OVER (PARTITION BY vendor_state, vendor_city) AS invoice_sum
FROM invoices JOIN vendors ON invoices.vendor_id = vendors.vendor_id
ORDER BY vendor_state, vendor_city;


