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
            WHEN min ~ '^\d+(\.\d+)?$' THEN min::DECIMAL(10,3)
            ELSE NULL
        END AS min,

        CASE
            WHEN max ~ '^\d+(\.\d+)?$' THEN max::DECIMAL(10,3)
            ELSE NULL
        END AS max,

        CASE
            WHEN normal_min ~ '^\d+(\.\d+)?$' THEN normal_min::DECIMAL(10,3)
            ELSE NULL
        END AS normal_min,

        CASE
            WHEN normal_max ~ '^\d+(\.\d+)?$' THEN normal_max::DECIMAL(10,3)
            ELSE NULL
        END AS normal_max,
        _ingested_at
    FROM {{ source('staging', 'raw_weather_temperature') }}
),

deduped AS (
    SELECT
        date,
        min,
        max,
        normal_min,
        normal_max,
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
    min,
    max,
    normal_min,
    normal_max,
    _ingested_at,
    CURRENT_TIMESTAMP AS _created_at,
    CURRENT_TIMESTAMP AS _updated_at
FROM deduped