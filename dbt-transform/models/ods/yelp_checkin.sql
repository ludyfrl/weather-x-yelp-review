{{ config(
    database='data_dwh',
    schema='ods',
    materialized='table',
    unique_key='business_id'
) }}

WITH raw_data AS (
    SELECT * FROM {{ source('staging', 'raw_yelp_checkin') }}
),

deduped AS (
    SELECT
        business_id,
        date,
        _ingested_at
    FROM (
        SELECT
            *,
            ROW_NUMBER() OVER (PARTITION BY business_id ORDER BY _ingested_at DESC) AS rn
        FROM raw_data
    ) sq
    WHERE sq.rn = 1
)

SELECT
    business_id,
    date,
    _ingested_at,
    CURRENT_TIMESTAMP AS _created_at,
    CURRENT_TIMESTAMP AS _updated_at
FROM deduped