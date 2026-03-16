

SELECT

    oi.order_id,
    oi.order_item_id,

    oi.product_id,
    oi.seller_id,

    -- Date key for joining with dim_date
    CAST(FORMAT_TIMESTAMP('%Y%m%d', oi.shipping_limit_ts) AS INT64) AS shipping_limit_date_key,

    oi.shipping_limit_ts,

    oi.price,
    oi.freight_value,


FROM {{ ref('stg_order_items') }} oi

LEFT JOIN {{ ref('fact_orders') }} o
ON oi.order_id = o.order_id

LEFT JOIN {{ ref('dim_products') }} p
ON oi.product_id = p.product_id

LEFT JOIN {{ ref('dim_sellers') }} s
ON oi.seller_id = s.seller_id