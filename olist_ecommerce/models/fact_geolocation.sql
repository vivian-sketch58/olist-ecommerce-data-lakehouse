SELECT
    zip_code_prefix AS location_key,
    AVG(latitude) AS latitude,
    AVG(longitude) AS longitude,
    ANY_VALUE(city) AS city,
    ANY_VALUE(state) AS state
FROM {{ ref('stg_geolocation') }}
GROUP BY zip_code_prefix
