{{ config(materialized='table', schema='marts') }}

SELECT
    -- Fix: Use COALESCE to handle missing category names
    COALESCE(p.category_name_english, 'Unknown/Missing') AS category_name_english,
    COUNT(oi.order_item_id) AS items_sold,
    SUM(oi.price) AS revenue,
    -- Fix: Use ROUND to keep the review score clean for reporting
    ROUND(AVG(r.review_score), 2) AS avg_review_score

FROM {{ ref('fact_order_items') }} oi

-- Fix: Changed to LEFT JOIN so you don't lose sales data for products 
-- that might be missing from the products dimension
LEFT JOIN {{ ref('dim_products') }} p
    ON oi.product_id = p.product_id

LEFT JOIN {{ ref('fact_reviews') }} r
    ON oi.order_id = r.order_id

GROUP BY 1 -- Refers to the first column (category_name_english)