SELECT
    {{ dbt_utils.generate_surrogate_key(['payment_type']) }} AS payment_type_key,
    payment_type
FROM {{ ref('stg_payments') }}
GROUP BY payment_type