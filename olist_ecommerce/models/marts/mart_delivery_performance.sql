{{ config(materialized='table', schema='marts') }}

WITH unique_order_items AS (
    SELECT DISTINCT 
        order_id, 
        seller_id 
    FROM {{ ref('fact_order_items') }}
)

SELECT
    o.order_id,
    c.city AS customer_city,
    c.state AS customer_state,
    s.city AS seller_city,
    s.state AS seller_state,
    purchase_d.full_date AS order_date,
    delivery_d.full_date AS delivery_date,

    DATE_DIFF(
        delivery_d.full_date,
        purchase_d.full_date,
        DAY
    ) AS delivery_days

FROM {{ ref('fact_orders') }} o
JOIN {{ ref('dim_customers') }} c
    ON o.customer_id = c.customer_id
JOIN unique_order_items oi
    ON o.order_id = oi.order_id
JOIN {{ ref('dim_sellers') }} s
    ON oi.seller_id = s.seller_id
JOIN {{ ref('dim_date') }} purchase_d
    ON o.purchase_date_key = purchase_d.date_key
JOIN {{ ref('dim_date') }} delivery_d
    ON o.delivered_date_key = delivery_d.date_key

WHERE o.purchase_date_key IS NOT NULL
  AND o.delivered_date_key IS NOT NULL
    AND delivery_d.full_date >= purchase_d.full_date
