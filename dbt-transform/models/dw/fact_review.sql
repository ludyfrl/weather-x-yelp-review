{{ config(
    database='data_dwh',
    schema='dw',
    materialized='table',
    unique_key='review_id'
) }}

WITH review_casted AS (
    SELECT
        *,
        SPLIT_PART(date, ' ', 1) AS review_date
    FROM {{ source('ods', 'yelp_review') }}
),

cleaned AS (
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
    FROM review_casted r
    LEFT JOIN {{ ref('dim_date_weather') }} dw
      ON r.review_date = dw.full_date
)

SELECT * FROM cleaned