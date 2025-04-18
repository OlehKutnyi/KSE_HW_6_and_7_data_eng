select
    s.sales_id,
    s.sales_person_id,
    s.customer_id,
    s.product_id,
    s.quantity,
    s.discount,
    s.sales_date,
    s.transaction_number,
    s.total_price
from {{ ref('stg_sales') }} s
