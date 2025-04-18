select cast("EmployeeID" as integer) as employee_id,
       cast("FirstName" as text)     as first_name,
       cast("MiddleInitial" as text) as middle_initial,
       cast("LastName" as text)      as last_name,
       cast("BirthDate" as date)     as birth_date,
       cast("Gender" as text)        as gender,
       cast("CityID" as integer)     as city_id,
       cast("HireDate" as date)      as hire_date

from {{ ref('raw_employees') }}

