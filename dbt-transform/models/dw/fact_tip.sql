{{ config(
    database='data_dwh',
    schema='dw',
    materialized='incremental',
    unique_key='tip_sk'
) }}

SELECT
  ROW_NUMBER() OVER (ORDER BY business_id, user_id, text) AS tip_sk,
  business_id,
  user_id,
  dw.date_sk,
  text AS tip_text,
  compliment_count,
  CURRENT_TIMESTAMP AS _created_at,
  CURRENT_TIMESTAMP AS _updated_at
FROM {{ source('ods', 'yelp_tip') }} t
LEFT JOIN {{ ref('dim_date_weather') }} dw
  ON t.date = dw.full_date