{{ config(materialized='table', schema='stg') }}

SELECT 
    seller_id,
    LPAD(seller_zip_code_prefix, 5, '0') AS zip_code_prefix,
    TRIM(UPPER(seller_city)) AS city,
    UPPER(seller_state) AS state
FROM {{ source('olist_raw', 'raw_sellers') }}