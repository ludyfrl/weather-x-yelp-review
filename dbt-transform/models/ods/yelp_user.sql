{{ config(
    database='data_dwh',
    schema='ods',
    materialized='table',
    unique_key='user_id'
) }}

WITH raw_data AS (
    SELECT * FROM {{ source('staging', 'raw_yelp_user') }}
),

cleaned AS (
    SELECT
        user_id,
        name,
        review_count::INTEGER as review_count,
        yelping_since,
        useful::INTEGER as useful,
        funny::INTEGER as funny,
        cool::INTEGER as cool,
        elite,
        friends,
        fans::INTEGER as fans,
        average_stars::DECIMAL(2, 1) as average_stars,
        compliment_hot::INTEGER as compliment_hot,
        compliment_more::INTEGER as compliment_more,
        compliment_profile::INTEGER as compliment_profile,
        compliment_cute::INTEGER as compliment_cute,
        compliment_list::INTEGER as compliment_list,
        compliment_note::INTEGER as compliment_note,
        compliment_plain::INTEGER as compliment_plain,
        compliment_cool::INTEGER as compliment_cool,
        compliment_funny::INTEGER as compliment_funny,
        compliment_writer::INTEGER as compliment_writer,
        compliment_photos::INTEGER as compliment_photos,
        _ingested_at
    FROM raw_data
),

deduped AS (
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
        _ingested_at
    FROM (
        SELECT
            *,
            ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY _ingested_at DESC) AS rn
        FROM cleaned
    ) sq
    WHERE sq.rn = 1
)

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
    _ingested_at,
    CURRENT_TIMESTAMP AS _created_at,
    CURRENT_TIMESTAMP AS _updated_at
FROM deduped