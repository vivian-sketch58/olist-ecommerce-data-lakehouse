{{ config(materialized='table', schema='stg') }}

SELECT
    order_id,

    CAST(order_item_id AS INT64) AS order_item_id,

    product_id,
    seller_id,

    CAST(shipping_limit_date AS TIMESTAMP) AS shipping_limit_ts,

    CAST(price AS FLOAT64) AS price,
    CAST(freight_value AS FLOAT64) AS freight_value

FROM {{ source('olist_raw', 'raw_order_items') }}