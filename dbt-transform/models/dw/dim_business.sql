{{ config(
    database='data_dwh',
    schema='dw',
    materialized='incremental',
    unique_key='business_id'
) }}

SELECT
    business_id,
    name,
    address,
    city,
    state,
    postal_code,
    latitude,
    longitude,
    stars,
    review_count,
    is_open,
    categories,
    attributes,
    hours,
    CURRENT_TIMESTAMP AS _created_at,
    CURRENT_TIMESTAMP AS _updated_at
FROM {{ source('ods', 'yelp_business') }}