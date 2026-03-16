SELECT
 
    p.product_id,
    p.category_name,
    c.category_name_english,
    
    p.name_length,
    p.description_length,
    p.photos_qty,
    
    p.weight_g,
    p.length_cm,
    p.height_cm,
    p.width_cm

FROM {{ ref('stg_products') }} p

LEFT JOIN {{ ref('stg_product_category') }} c
ON p.category_name = c.category_name