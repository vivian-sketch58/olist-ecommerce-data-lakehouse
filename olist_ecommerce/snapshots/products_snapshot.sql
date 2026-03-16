{% snapshot products_snapshot %}

{{
  config(
    target_schema='snapshots',
    unique_key='product_id',
    strategy='check',
    check_cols=[
        'category_name',
        'category_name_english',
        'name_length',
        'description_length',
        'photos_qty',
        'weight_g',
        'length_cm',
        'height_cm',
        'width_cm'
    ]
  )
}}

SELECT
    product_id,
    category_name,
    category_name_english,
    name_length,
    description_length,
    photos_qty,
    weight_g,
    length_cm,
    height_cm,
    width_cm
FROM {{ ref('dim_products') }}

{% endsnapshot %}