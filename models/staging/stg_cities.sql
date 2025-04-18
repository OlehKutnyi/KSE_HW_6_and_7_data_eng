select
    CityID::int as city_id,
    CityName::varchar as city_name,
    Zipcode::int as zipcode,
    CountryID::int as country_id
from {{ ref('raw_cities') }}
