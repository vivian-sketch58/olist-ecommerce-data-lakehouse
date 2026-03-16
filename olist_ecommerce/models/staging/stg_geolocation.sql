{{ config(materialized='table', schema='stg') }}

SELECT
    LPAD(geolocation_zip_code_prefix, 5, '0') AS zip_code_prefix,
    CAST(geolocation_lat AS FLOAT64) AS latitude,
    CAST(geolocation_lng AS FLOAT64) AS longitude,
    TRIM(UPPER(geolocation_city)) AS city,
    UPPER(geolocation_state) AS state
FROM {{ source('olist_raw', 'raw_geolocation') }}
