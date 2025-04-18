select
    SalesID::int as sales_id,
    SalesPersonID::int as sales_person_id,
    CustomerID::int as customer_id,
    s.ProductID::int as product_id,
    Quantity::int as quantity,
    Discount::float as discount,
    SalesDate::date as sales_date,
    TransactionNumber::varchar as transaction_number,
    s.quantity * p.price as total_price
from {{ source('main', 'raw_sales') }} s
left join {{ ref('raw_products') }} p
        on s.ProductId = p.ProductId
where s.SalesDate is not null