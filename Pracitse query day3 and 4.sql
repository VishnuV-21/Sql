SELECT * FROM store.products;
-- Simple select math expression with select 
SELECT prd.name, prd.unit_price , unit_price*1.1 as new_price
FROM products prd;

-- Query to get the current year
select year(curdate()) as CurrentYear ;

-- Using REGEX
SELECT c.first_name,c.last_name 
FROM store.customers c
/*where c.last_name  Regexp '^MY|SE';  -- start with MY or has SE
WHERE c.first_name Regexp 'ELKA|AMBUR';
Where c.last_name REGEXP '^Do|ON$';
where c.last_name REGEXP '.*B[R]|.*B[U]';  -- contains B followed by R or U */;

-- Join Query
select o.order_id,p.product_id,p.name
from order_items o
join products p 
on o.product_id=p.product_id;

-- wokring with multiple databases
select * from order_items oi 
join sql_inventory.products p -- we only have to prefix the db that is not part of the current database
on oi.product_id=p.product_id;

-- Note: Joins are by default Inner Join , and left and right are outer joins
-- Self join to display the mangers id in the employee table
select  e.employee_id,e.first_name ,m.first_name as Manager_Name 
from sql_hr.employees e
join sql_hr.employees m
on m.employee_id=e.reports_to; -- be carefull on self joins here <=

-- joining three tables using joins
Select p.payment_id , c.name, pm.name, p.amount from invoicing.payments p
join invoicing.clients c on p.client_id=c.client_id
join invoicing.payment_methods pm on p.payment_method=pm.payment_method_id; 

-- Composite joins ( 2 primary key)
select * from store.order_items oi
join store.order_statuses os 
where oi.order_id=os.order_status_id 
and 
oi.product_id-os.product_id;

-- Outer Joins 
select p.product_id,p.name,oi.order_id from store.products p 
left join store.order_items oi  
on p.product_id=oi.product_id;

select o.order_id,c.first_name,s.name,os.name from orders o
left join customers c 
on o.customer_id=c.customer_id
left join shippers s 
on o.shipper_id=s.shipper_id
left join order_statuses os
on o.status =os.order_status_id;

-- self outer join 
select  e.employee_id,e.first_name ,m.first_name as Manager_Name 
from sql_hr.employees e
left join sql_hr.employees m
on m.employee_id=e.reports_to; 

-- joins with using clause
select p.product_id,p.name,oi.order_id from store.products p 
left join store.order_items oi  
using(product_id);

-- cross join 
-- implicit
select * from shippers s 
cross join products p ;

-- explicit
select * from shippers s,products p ;

-- Union
select customer_id,first_name name ,points, 'Bronze' Type
 from customers 
 where points between 300 and 1000
 union 
 select customer_id,first_name name ,points, 'Silver' Type
 from customers 
 where points between 1001 and 3000
 union
 select customer_id,first_name name ,points, 'Gold' Type
 from customers 
 where points >3000
 order by name;
 
 
 -- create and select as subquery
 create table invoicing.invoice_achive AS 
 select i.invoice_id,i.number,c.name,i.invoice_total,payment_total from invoicing.invoices i 
  join invoicing.clients c
 using (client_id) 
 where payment_date is not null;
 drop table invoicing.invoice_achive;
 
 select * from invoicing.invoice_achive;