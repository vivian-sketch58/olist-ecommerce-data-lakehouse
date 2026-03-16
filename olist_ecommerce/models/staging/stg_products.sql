{{ config(materialized='table', schema='stg') }}


SELECT
    product_id,
    TRIM(LOWER(product_category_name)) AS category_name,
    
    SAFE_CAST(product_name_lenght AS INT64) AS name_length,
    SAFE_CAST(product_description_lenght AS INT64) AS description_length,
    SAFE_CAST(product_photos_qty AS INT64) AS photos_qty,
    
    SAFE_CAST(product_weight_g AS FLOAT64) AS weight_g,
    SAFE_CAST(product_length_cm AS FLOAT64) AS length_cm,
    SAFE_CAST(product_height_cm AS FLOAT64) AS height_cm,
    SAFE_CAST(product_width_cm AS FLOAT64) AS width_cm

FROM {{ source('olist_raw', 'raw_products') }}