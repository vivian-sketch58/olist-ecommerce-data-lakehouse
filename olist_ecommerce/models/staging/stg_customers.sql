{{ config(materialized='table', schema='stg') }}

SELECT 
    customer_id,
    customer_unique_id,
    LPAD(customer_zip_code_prefix, 5, '0') AS zip_code_prefix,
    TRIM(UPPER(customer_city)) AS city,
    UPPER(customer_state) AS state
FROM {{ source('olist_raw', 'raw_customers') }}