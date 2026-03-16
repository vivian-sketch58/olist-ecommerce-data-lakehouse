SELECT
    r.review_id,
    o.order_id,

    r.review_score,

    r.comment_title AS comment_title,
    r.comment_message AS comment_message,

    -- date keys for dim_date
    CAST(FORMAT_TIMESTAMP('%Y%m%d', r.review_creation_ts) AS INT64) AS review_date_key,
    CAST(FORMAT_TIMESTAMP('%Y%m%d', r.review_answer_ts) AS INT64) AS answer_date_key,

    -- timestamps kept for tracking review timelines
    r.review_creation_ts,
    r.review_answer_ts

FROM {{ ref('stg_reviews') }} r

LEFT JOIN {{ ref('fact_orders') }} o
ON r.order_id = o.order_id