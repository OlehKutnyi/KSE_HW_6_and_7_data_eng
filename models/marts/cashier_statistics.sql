select
    s.sales_person_id,
    city.city_name,
    s.sales_date::date as date,
    sum(s.quantity) as total_quantity,
    sum(s.total_price) as total_revenue
from {{ ref('stg_sales') }} s
left join {{ ref('stg_employees') }} e on s.sales_person_id = e.employee_id
left join {{ ref('stg_cities') }} city on e.city_id = city.city_id
where s.sales_date is not null
group by 1, 2, 3
