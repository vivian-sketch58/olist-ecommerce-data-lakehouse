WITH date_series AS (
    SELECT day AS full_date
    FROM UNNEST(GENERATE_DATE_ARRAY('2016-01-01', '2020-12-31')) AS day
)
SELECT
    CAST(FORMAT_DATE('%Y%m%d', full_date) AS INT64) AS date_key,
    full_date,

    EXTRACT(YEAR FROM full_date) AS year,
    EXTRACT(QUARTER FROM full_date) AS quarter,

    EXTRACT(MONTH FROM full_date) AS month,
    FORMAT_DATE('%B', full_date) AS month_name,
    
    FORMAT_DATE('%Y-%b', full_date) AS year_month,

    EXTRACT(WEEK FROM full_date) AS week_of_year,
    EXTRACT(DAY FROM full_date) AS day_of_month,

-- This shifts Sunday (1) to 7, and Monday (2) to 1
    CASE 
        WHEN EXTRACT(DAYOFWEEK FROM full_date) = 1 THEN 7
        ELSE EXTRACT(DAYOFWEEK FROM full_date) - 1
    END AS day_of_week,

    FORMAT_DATE('%A', full_date) AS day_name,

    -- Adjusted weekend logic: Saturday is 6, Sunday is 7
    CASE 
        WHEN EXTRACT(DAYOFWEEK FROM full_date) IN (1, 7) THEN TRUE
        ELSE FALSE
    END AS is_weekend
FROM date_series
ORDER BY full_date