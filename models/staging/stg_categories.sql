select
    CategoryID::int as category_id,
    CategoryName::varchar as categoty_name
from {{ ref('raw_categories') }}
