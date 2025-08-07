{{ config(
    database='data_dwh',
    schema='dw',
    materialized='incremental',
    unique_key='review_id'
) }}

WITH cleaned AS (
    SELECT
        r.review_id,
        r.user_id,
        r.business_id,
        dw.date_sk,
        r.stars,
        r.useful AS useful_votes,
        r.funny AS funny_votes,
        r.cool AS cool_votes,
        r.text AS review_text,
        CURRENT_TIMESTAMP AS _created_at,
        CURRENT_TIMESTAMP AS _updated_at
    FROM {{ source('ods', 'yelp_review') }} r
    LEFT JOIN {{ ref('dim_date_weather') }} dw
      ON r.date = dw.full_date
)

SELECT * FROM cleaned