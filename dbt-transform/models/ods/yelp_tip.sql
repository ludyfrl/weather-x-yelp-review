{{ config(
    database='data_dwh',
    schema='ods',
    materialized='table',
) }}

WITH raw_data AS (
    SELECT * FROM {{ source('staging', 'raw_yelp_tip') }}
),

cleaned AS (
    SELECT
        business_id,
        user_id,
        text,
        date,
        compliment_count::INTEGER as compliment_count,
        _ingested_at
    FROM raw_data
)

SELECT
    business_id,
    user_id,
    text,
    date,
    compliment_count,
    _ingested_at,
    CURRENT_TIMESTAMP AS _created_at,
    CURRENT_TIMESTAMP AS _updated_at
FROM cleaned