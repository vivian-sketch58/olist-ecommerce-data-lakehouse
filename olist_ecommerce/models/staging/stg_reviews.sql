{{ config(materialized='table', schema='stg') }}

SELECT
    review_id,
    order_id,

    CAST(review_score AS INT64) AS review_score,

    TRIM(review_comment_title) AS comment_title,
    TRIM(review_comment_message) AS comment_message,

    CAST(review_creation_date AS TIMESTAMP) AS review_creation_ts,
    CAST(review_answer_timestamp AS TIMESTAMP) AS review_answer_ts

FROM {{ source('olist_raw', 'raw_reviews') }}