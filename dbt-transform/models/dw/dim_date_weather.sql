{{ config(
    database='data_dwh',
    schema='dw',
    materialized='incremental',
    unique_key='full_date'
) }}

WITH weather AS (
    SELECT
        COALESCE(t.date, p.date) AS full_date,
        t.min AS min_temperature,
        t.max AS max_temperature,
        t.normal_min AS normal_min_temperature,
        t.normal_max AS normal_max_temperature,
        p.precipitation,
        p.precipitation_normal
    FROM {{ source('ods', 'weather_temperature') }} t
    FULL OUTER JOIN {{ source('ods', 'weather_precipitation') }} p
        ON t.date = p.date
),

dim_date AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY full_date) AS date_sk,
        full_date,
        EXTRACT(YEAR FROM full_date::DATE) AS year,
        EXTRACT(MONTH FROM full_date::DATE) AS month,
        EXTRACT(DAY FROM full_date::DATE) AS day,
        TO_CHAR(full_date::DATE, 'Day') AS day_name,
        TO_CHAR(full_date::DATE, 'Month') AS month_name,
        min_temperature,
        max_temperature,
        normal_min_temperature,
        normal_max_temperature,
        precipitation,
        precipitation_normal,
        CURRENT_TIMESTAMP AS _created_at,
        CURRENT_TIMESTAMP AS _updated_at
    FROM weather
    WHERE full_date IS NOT NULL
)

SELECT * FROM dim_date