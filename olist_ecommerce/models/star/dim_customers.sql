
SELECT 
    customer_id,
    customer_unique_id,
    zip_code_prefix,
    city,
    state
FROM {{ ref('stg_customers') }}
