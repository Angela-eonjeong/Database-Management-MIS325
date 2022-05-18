--#1 
select *
from invoices
where invoice_total > (select avg(invoice_total) from invoices) ; 

--#2 
select  invoice_id
        , invoice_date
        , invoice_total
from invoices
where vendor_id in 
        (
            select vendor_id 
            from vendors 
            where vendor_state in ('TX','TN','NV')
        );
        
        
select  invoice_id
        , invoice_date
        , invoice_total
from vendors v join invoices i
on v.vendor_id = i.vendor_id
where v.vendor_state in ('TX','TN','NV');



--#3 
select  invoice_id
        , invoice_date
        , invoice_total
from invoices
where vendor_id in 
        (
            select vendor_id 
            from vendors 
            where vendor_state not in ('TX','TN','NV')
        );

--#4 
select *
from invoices 
where invoice_total > All 
    ( 
        select invoice_total 
        from invoices
        where vendor_id in (
        select vendor_id
        from vendors
        where vendor_name = 'IBM')
    );  

--#5 
select *
from invoices 
where invoice_total > Some 
    ( 
        select invoice_total 
        from invoices
        where vendor_id in (
        select vendor_id
        from vendors
        where vendor_name = 'IBM')
    );  


--#6 From 
select avg(count)
from (
            select count(invoice_id) as count
            from invoices 
            where vendor_id not in 123
            group by vendor_id
            having count(invoice_id) > 1
        );


--#7 
select vendor_name, summary_1.vendor_state, summary_1.invoice_total 
from 
(SELECT  v.vendor_id, 
        v.vendor_name,
        v.vendor_state,
        SUM(i.invoice_total) AS INVOICE_TOTAL
FROM invoices i JOIN vendors v ON i.vendor_id = v.vendor_id
GROUP BY v.vendor_id, v.vendor_name, v.vendor_state
order by vendor_state ) summary_1 
join 
(select vendor_state, max(sum_of_invoices) as invoice_total
from	(SELECT v.vendor_id, 
       	  v.vendor_state,
        SUM(i.invoice_total) AS sum_of_invoices 
 FROM invoices i JOIN vendors v ON i.vendor_id = v.vendor_id
 GROUP BY v.vendor_id, v.vendor_state
 ORDER BY v.vendor_state)
GROUP BY vendor_state ) summary_2
on summary_1.vendor_state = summary_2.vendor_state 
and summary_1.invoice_total =  summary_2.invoice_total;


--#8
SELECT D.DEPARTMENT_NAME, COUNT(EMPLOYEE_ID)
FROM DEPARTMENTS D JOIN EMPLOYEES E
     ON D.DEPARTMENT_NUMBER = E.DEPARTMENT_NUMBER
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM PROJECTS)
GROUP BY D.DEPARTMENT_NAME;


--#9

SELECT  CUSTOMER_FIRST_NAME || ' ' || 
        CUSTOMER_LAST_NAME AS CUSTOMER_NAME
        , CUSTOMER_CITY
        , CUSTOMER_STATE 
FROM CUSTOMERS_EX
WHERE CUSTOMER_CITY IN (    
                        SELECT CUSTOMER_CITY 
                        FROM (
                                SELECT CUSTOMER_CITY, COUNT(*)
                                FROM CUSTOMERS_EX
                                GROUP BY CUSTOMER_CITY
                                Having count(*) = 1
                              )
                        );


--#10 
SELECT CUSTOMER_FIRST_NAME || ' ' || CUSTOMER_LAST_NAME as customer_name
        , CUSTOMER_STATE
        , NUM_ORDERS
        , AVG_PROC_TIME
FROM CUSTOMERS_EX C JOIN (
                            SELECT  O.CUSTOMER_ID, COUNT(*) AS NUM_ORDERS
                                    , ROUND(AVG(SHIPPED_DATE-ORDER_DATE),1) AS AVG_PROC_TIME 
                            FROM ORDERS O JOIN CUSTOMERS_OM C
                            ON O.CUSTOMER_ID = C.CUSTOMER_ID
                            GROUP BY O.CUSTOMER_ID
                          ) CUSTOMERS_SHIPPING
                          
ON C.CUSTOMER_ID = CUSTOMERS_SHIPPING.CUSTOMER_ID
WHERE AVG_PROC_TIME > (SELECT AVG(SHIPPED_DATE-ORDER_DATE) FROM ORDERS)
ORDER BY C.CUSTOMER_ID
;


--#10 

-- Better situation
-- Where better for comparing search conditions with other tables 
-- From better for joining other tables 



