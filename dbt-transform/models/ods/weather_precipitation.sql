{{ config(
    database='data_dwh',
    schema='ods',
    materialized='table',
    unique_key='date'
) }}

WITH cleaned AS (
    SELECT
        TO_CHAR(TO_DATE(date, 'YYYYMMDD'), 'YYYY-MM-DD') AS date,
        CASE
            WHEN precipitation ~ '^\d+(\.\d+)?$' THEN precipitation::DECIMAL(10,3)
            ELSE NULL
        END AS precipitation,

        CASE
            WHEN precipitation_normal ~ '^\d+(\.\d+)?$' THEN precipitation_normal::DECIMAL(10,3)
            ELSE NULL
        END AS precipitation_normal,

        _ingested_at
    FROM {{ source('staging', 'raw_weather_precipitation') }}
),

deduped AS (
    SELECT
        date,
        precipitation,
        precipitation_normal,
        _ingested_at
    FROM (
        SELECT
            *,
            ROW_NUMBER() OVER (PARTITION BY date ORDER BY _ingested_at DESC) AS rn
        FROM cleaned
    ) sq
    WHERE sq.rn = 1
)

SELECT
    date,
    precipitation,
    precipitation_normal,
    _ingested_at,
    CURRENT_TIMESTAMP AS _created_at,
    CURRENT_TIMESTAMP AS _updated_at
FROM deduped