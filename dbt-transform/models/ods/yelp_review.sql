{{ config(
    database='data_dwh',
    schema='ods',
    materialized='table',
    unique_key='review_id'
) }}

WITH raw_data AS (
    SELECT * FROM {{ source('staging', 'raw_yelp_review') }}
),

cleaned AS (
    SELECT
        review_id,
        user_id,
        business_id,
        stars::DECIMAL(2, 1) as stars,
        useful::INTEGER as useful,
        funny::INTEGER as funny,
        cool::INTEGER as cool,
        text,
        date,
        _ingested_at
    FROM raw_data
),

deduped AS (
    SELECT
        review_id,
        user_id,
        business_id,
        stars,
        useful,
        funny,
        cool,
        text,
        date,
        _ingested_at
    FROM (
        SELECT
            *,
            ROW_NUMBER() OVER (PARTITION BY review_id ORDER BY _ingested_at DESC) AS rn
        FROM cleaned
    ) sq
    WHERE sq.rn = 1
)

SELECT
    review_id,
    user_id,
    business_id,
    stars,
    useful,
    funny,
    cool,
    text,
    date,
    _ingested_at,
    CURRENT_TIMESTAMP AS _created_at,
    CURRENT_TIMESTAMP AS _updated_at
FROM deduped