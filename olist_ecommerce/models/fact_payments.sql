WITH payments_with_keys AS (
    SELECT 
        *,
        {{ dbt_utils.generate_surrogate_key(['payment_type']) }} AS payment_type_key
    FROM {{ ref('stg_payments') }}
)

SELECT
    o.order_id,
    p.payment_seq,
    p.payment_type_key,
    p.payment_installments,
    p.payment_value
FROM payments_with_keys p
LEFT JOIN {{ ref('fact_orders') }} o ON p.order_id = o.order_id
LEFT JOIN {{ ref('dim_payment_types') }} pt ON p.payment_type_key = pt.payment_type_key