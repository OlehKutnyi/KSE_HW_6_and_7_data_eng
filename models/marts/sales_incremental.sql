{{ config(
    materialized='incremental',
    unique_key='sales_id'
) }}

with source_data as (
    select
        sales_id,
        sales_date::date as date,
        product_id,
        customer_id,
        quantity,
        discount,
        total_price
    from {{ ref('stg_sales') }}
    where sales_date is not null
    {% if is_incremental() %}
        and sales_date > (select max(date) from {{ this }})
    {% endif %}
)

select * from source_data
