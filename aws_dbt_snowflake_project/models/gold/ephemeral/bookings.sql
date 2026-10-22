--Method 1:
{{
  config(
    materialized = 'ephemeral',
    )
}}
WITH bookings AS(
    SELECT
        BOOKING_ID,
        BOOKING_DATE,
        BOOKING_STATUS,
        CREATED_AT
    FROM
        {{ref('obt')}}
)
SELECT * FROM bookings



--Method 2
{# {{
  config(
    materialized = 'ephemeral',
    )
}}

WITH bookings AS(
    SELECT * FROM{{ref('obt')}}
)

SELECT 
    BOOKING_ID,
    BOOKING_DATE,
    BOOKING_STATUS,
    CREATED_AT
FROM bookings #}
