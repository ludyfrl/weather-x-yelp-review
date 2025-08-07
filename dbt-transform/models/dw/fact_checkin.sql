{{ config(
    database='data_dwh',
    schema='dw',
    materialized='incremental',
    unique_key='checkin_sk'
) }}

WITH expanded AS (
    SELECT
        business_id,
        unnest(string_to_array(date, ',')) AS ts
    FROM {{ source('ods', 'yelp_checkin') }}
),

dates AS (
    SELECT
        business_id,
        SPLIT_PART(LTRIM(ts), ' ', 1) AS full_date
    FROM expanded
),

aggregated AS (
    SELECT
        d.business_id,
        dw.date_sk,
        COUNT(*) AS checkin_count,
        CURRENT_TIMESTAMP AS _created_at,
        CURRENT_TIMESTAMP AS _updated_at
    FROM dates d
    LEFT JOIN {{ ref('dim_date_weather') }} dw
        ON d.full_date = dw.full_date
    GROUP BY d.business_id, dw.date_sk
)

SELECT
    ROW_NUMBER() OVER (ORDER BY date_sk, business_id) AS checkin_sk,
    business_id,
    date_sk,
    checkin_count,
    _created_at,
    _updated_at
FROM aggregated