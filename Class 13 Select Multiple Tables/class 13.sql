-- #1
select *
from vendors v full outer join invoices i
on v.vendor_id = i.vendor_id;
    

--#2 
select *
from customers_om cm full outer join orders o 
on cm.customer_id = o.customer_id;

--#3 
select cm.customer_id, cm.CUSTOMER_FIRST_NAME||' '|| cm.CUSTOMER_LAST_NAME as name, o.order_id, o.order_date 
from customers_om cm full outer join orders o 
on cm.customer_id = o.customer_id;

--#4 
select cm.customer_id, o.order_id, o.order_date, od.item_id, od.order_qty
from orders o 
    full outer join customers_om cm on cm.customer_id = o.customer_id
    full outer join order_details od on o.order_id = od.order_id; 

select cm.customer_id, o.order_id, o.order_date, od.item_id, od.order_qty
from customers_om cm
    full outer join orders o  on o.customer_id = cm.customer_id
    full outer join order_details od on o.order_id = od.order_id; 



--#5 
select *
from vendors v left join invoices i 
on v.vendor_id = i.vendor_id;

--#6 
select e.employee_id, FIRST_NAME, LAST_NAME, PROJECT_NUMBER
from employees e full outer join projects pj
on e.EMPLOYEE_ID = pj.EMPLOYEE_ID  ;


--#6(1)
select e.employee_id, FIRST_NAME, LAST_NAME, PROJECT_NUMBER
from employees e left join projects pj
on e.EMPLOYEE_ID = pj.EMPLOYEE_ID  
where pj.project_number is null; 

--#6(2) 
select e.employee_id, FIRST_NAME, LAST_NAME, PROJECT_NUMBER
from employees e right join projects pj
on e.EMPLOYEE_ID = pj.EMPLOYEE_ID 
where e.employee_id is null; 


--#7 
    select CUSTOMER_ID, CUSTOMER_CITY, CUSTOMER_STATE, 'West' as "region"
    from customers_om 
    where CUSTOMER_STATE = 'CA' or CUSTOMER_STATE = 'AZ'
union
    select CUSTOMER_ID, CUSTOMER_CITY, CUSTOMER_STATE, 'East' as "region"
    from customers_om 
    where CUSTOMER_STATE in ('DC','MD', 'NC', 'NY', 'NJ') 
union
    select CUSTOMER_ID, CUSTOMER_CITY, CUSTOMER_STATE, 'Midwest' as "region"
    from customers_om 
    where CUSTOMER_STATE in ('IA','OH', 'WI' ) 
order by 4 asc;

--#8 
select distinct vendor_id
from vendors;

--#9 
select distinct vendor_id
from invoices;

--#10
select distinct vendor_id
from vendors
minus
select distinct vendor_id
from invoices;

--#11 
select distinct vendor_id
from vendors
intersect
select distinct vendor_id
from invoices;

--#12 
select v.vendor_name, i.invoice_id, i.invoice_date, li.invoice_sequence, li.line_item_amt
from vendors v 
    join invoices i on v.vendor_id = i.vendor_id
    join invoice_line_items li on li.invoice_id = i.invoice_id; 
    
--#13 
select c.customer_id, c.customer_first_name, o.order_id
from  customers_om c 
    full join orders o on c.customer_id = o.customer_id; 

--#14 
    select Last_Name, First_Name
    from employees
intersect 
    select customer_Last_Name, customer_First_name
    from customers_om;

--#15
    select vendor_name, vendor_phone as phone 
    from vendors
    where vendor_phone is not null
union 
    select vendor_name, 'No phone' as phone 
    from vendors
    where vendor_phone is null;
    
--#16 
select v.vendor_id, i.invoice_id, v.vendor_address1, i.invoice_date, i.invoice_total, li.line_item_description, i.invoice_due_date 
from vendors v
    inner join invoices i 
    on v.vendor_id = i.vendor_id 
    inner join invoice_line_items li 
    on i.invoice_id = li.invoice_id ;


