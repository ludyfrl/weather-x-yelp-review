{{ config(
    database='data_dwh',
    schema='dw',
    materialized='incremental',
    unique_key='user_id'
) }}

SELECT
    user_id,
    name,
    review_count,
    yelping_since,
    useful,
    funny,
    cool,
    elite,
    friends,
    fans,
    average_stars,
    compliment_hot,
    compliment_more,
    compliment_profile,
    compliment_cute,
    compliment_list,
    compliment_note,
    compliment_plain,
    compliment_cool,
    compliment_funny,
    compliment_writer,
    compliment_photos,
    CURRENT_TIMESTAMP AS _created_at,
    CURRENT_TIMESTAMP AS _updated_at
FROM {{ source('ods', 'yelp_user') }}