SELECT
    o.order_id,
    c.customer_id,

    -- Date Keys for dim_date safely
    CAST(FORMAT_TIMESTAMP('%Y%m%d', o.order_purchase_ts) AS INT64) AS purchase_date_key,
    CAST(FORMAT_TIMESTAMP('%Y%m%d', o.order_approved_ts) AS INT64) AS approved_date_key,
    CAST(FORMAT_TIMESTAMP('%Y%m%d', o.order_delivered_carrier_ts) AS INT64) AS carrier_date_key,
    CAST(FORMAT_TIMESTAMP('%Y%m%d', o.order_delivered_customer_ts) AS INT64) AS delivered_date_key,
    CAST(FORMAT_TIMESTAMP('%Y%m%d', o.order_estimated_delivery_ts) AS INT64) AS estimated_delivery_date_key,

    o.order_status,
    o.order_purchase_ts,
    o.order_approved_ts,
    o.order_delivered_carrier_ts,
    o.order_delivered_customer_ts,
    o.order_estimated_delivery_ts

FROM {{ ref('stg_orders') }} o
LEFT JOIN {{ ref('dim_customers') }} c
    ON o.customer_id = c.customer_id