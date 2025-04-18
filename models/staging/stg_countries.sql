select
    CountryID::int as country_id,
    CountryName::varchar as country_name,
    CountryCode::varchar as country_code
from {{ ref('raw_countries') }}