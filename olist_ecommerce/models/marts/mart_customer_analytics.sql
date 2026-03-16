{{ config(materialized='table', schema='marts') }}

SELECT
    o.customer_id,
    COUNT(o.order_id) AS total_orders,
    SUM(p.payment_value) AS total_spent,
    AVG(p.payment_value) AS avg_order_value

FROM {{ ref('fact_orders') }} o

JOIN {{ ref('fact_payments') }} p
ON o.order_id = p.order_id

JOIN {{ ref('dim_date') }} d
ON o.purchase_date_key = d.date_key

GROUP BY customer_id