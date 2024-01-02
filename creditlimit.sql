with cte_sales as 
(
select t1.orderNumber, t1.customerNumber, productCode, quantityOrdered, priceEach, creditLimit, priceEach * quantityOrdered as saluesValue
from orders t1
inner join orderdetails t2
on t1.orderNumber = t2.orderNumber
inner join customers t3
on t1.customerNumber = t3.customerNumber
)

select orderNumber, customerNumber, 
case when creditLimit < 75000 then 'a: less than $75k'
when creditLimit between 75000 and 100000 then 'b:$75k - $100k'
when creditLimit between 100000 and 150000 then 'b:$100k - $150k'
when creditLimit > 150000 and 150000 then 'd: more than $150k'
else 'others'
end as creditLimit_group,
sum(saluesValue) as sales_values
from cte_sales 
group by orderNumber, customerNumber, creditLimit_group