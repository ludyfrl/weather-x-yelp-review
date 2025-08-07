{{ config(
    database='data_dwh',
    schema='ods',
    materialized='table',
    unique_key='business_id'
) }}

WITH raw_data AS (
    SELECT * FROM {{ source('staging', 'raw_yelp_business') }}
),

cleaned AS (
    SELECT
        business_id,
        name,
        address,
        city,
        state,
        postal_code,
        latitude::NUMERIC as latitude,
        longitude::NUMERIC as longitude,
        stars::NUMERIC as stars,
        review_count::INTEGER as review_count,
        is_open::INTEGER as is_open,
        categories,
        attributes::JSONB as attributes,
        hours::JSONB as hours,
        _ingested_at
    FROM raw_data
),

deduped AS (
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
        _ingested_at
    FROM (
        SELECT
            *,
            ROW_NUMBER() OVER (PARTITION BY business_id ORDER BY _ingested_at DESC) AS rn
        FROM cleaned
    ) sq
    WHERE sq.rn = 1
)

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
    _ingested_at,
    CURRENT_TIMESTAMP AS _created_at,
    CURRENT_TIMESTAMP AS _updated_at
FROM deduped