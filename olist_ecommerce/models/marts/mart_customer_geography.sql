{{ config(materialized='table', schema='marts') }}

SELECT
    c.state,
    c.city,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(p.payment_value) AS revenue

FROM {{ ref('fact_orders') }} o

JOIN {{ ref('dim_customers') }} c
ON o.customer_id = c.customer_id

JOIN {{ ref('fact_payments') }} p
ON o.order_id = p.order_id

GROUP BY state, city