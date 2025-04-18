with sales as (
    select
        product_id,
        sales_date::date as date,
        total_price
    from {{ ref('stg_sales') }}
),

aggregated as (
    select
        date,
        product_id,
        sum(total_price) as daily_revenue
    from sales
    group by 1, 2
),

ranked as (
    select
        *,
        rank() over (partition by date order by daily_revenue desc) as revenue_rank
    from aggregated
)

select * from ranked
where revenue_rank <= 10
ORDER BY revenue_rank DESC
