with sales as (
    select
        sales_date::date as date,
        total_price
    from {{ ref('stg_sales') }}
    where sales_date is not null
),

daily as (
    select
        date,
        count(*) as sales_count,
        sum(total_price) as total_revenue,
        avg(total_price) as avg_check
    from sales
    group by 1
)

select * from daily
