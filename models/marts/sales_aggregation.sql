with sales as (
    select
        product_id,
        quantity,
        discount,
        total_price,
        cast(sales_date as date) as date
    from {{ ref('stg_sales') }}
),

products as (
    select
        product_id,
        product_name,
        price,
        category_id
    from {{ ref('stg_products') }}
),

aggregated as (
    select
        s.sales_date,
        s.product_id,
        p.product_name,
        p.category_id,
        count(*) as sales_count,
        sum(s.quantity) as total_quantity,
        sum(s.total_price) as total_revenue,
        avg(s.total_price) as avg_check,
        avg(p.price) as avg_unit_price
    from stg_sales s
    join products p on s.product_id = p.product_id
    group by s.sales_date, s.product_id, p.product_name, p.category_id
)

select * from aggregated
