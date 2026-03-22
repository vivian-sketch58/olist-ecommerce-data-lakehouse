{{ config(materialized='table', schema='marts') }}

SELECT
    o.purchase_date_key AS order_date_key,  -- Added integer key for Tableau joins
    d.full_date AS order_date,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(p.payment_value) AS total_revenue,
    AVG(p.payment_value) AS avg_order_value

FROM {{ ref('fact_orders') }} o

JOIN {{ ref('fact_payments') }} p
ON o.order_id = p.order_id

JOIN {{ ref('dim_date') }} d
ON o.purchase_date_key = d.date_key

GROUP BY order_date_key, order_date  -- Updated group by to include the new column
ORDER BY order_date