select
        cast("ProductID" as integer) as product_id,
        cast("ProductName" as text) as product_name,
        cast("Price" as numeric) as price,
        cast("CategoryID" as integer) as category_id,
        cast("Class" as text) as class,
        cast("ModifyDate" as timestamp) as modify_date,
        cast("Resistant" as boolean) as resistant,
        cast("IsAllergic" as boolean) as is_allergic,
        cast("VitalityDays" as integer) as vitality_days
from {{ ref('raw_products') }}
