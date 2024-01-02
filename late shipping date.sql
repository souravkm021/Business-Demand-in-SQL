with cte_main as 
(select *, 
date_add(shippedDate, interval 3 day) as latest_arrival 
from orders)

select *,
case when latest_arrival > requiredDate then 1
else 0
end as late_flag
from cte_main
where 
(case when latest_arrival > requiredDate then 1 else 0 end) = 1