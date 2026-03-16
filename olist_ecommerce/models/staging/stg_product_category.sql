{{ config(materialized='table', schema='stg') }}

SELECT
    TRIM(LOWER(product_category_name)) AS category_name,
    TRIM(LOWER(product_category_name_english)) AS category_name_english
FROM {{ source('olist_raw', 'raw_product_category') }}
