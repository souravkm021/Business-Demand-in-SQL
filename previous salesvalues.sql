with cte_main as 
(
with cte_join as 
(
with cte_salesvales as
(
select t1.orderNumber, orderDate, customerNumber, quantityOrdered * priceEach as sales_value
from orders t1
inner join orderdetails t2
on t1.orderNumber = t2.orderNumber)

select orderNumber, orderDate, customerNumber, sum(sales_value) as sales_values
from cte_salesvales
group by orderNumber, orderDate, customerNumber)


select orderNumber, orderDate, t1.customerNumber, sales_values, customerName, 
row_number() over (partition by customerName order by orderdate) as purchase_number,
lag(sales_values) over (partition by customerName order by orderdate) as prev_sales_values
from cte_join t1
inner join customers t2
on t1.customerNumber = t2.customerNumber)

select *, sales_values - prev_sales_values as pruchase_value_change
from cte_main
where prev_sales_values is not null