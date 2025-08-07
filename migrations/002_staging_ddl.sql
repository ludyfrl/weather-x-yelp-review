CREATE TABLE IF NOT EXISTS staging.raw_yelp_business (
    business_id VARCHAR,
    name VARCHAR,
    address VARCHAR,
    city VARCHAR,
    state VARCHAR,
    postal_code VARCHAR,
    latitude VARCHAR,
    longitude VARCHAR,
    stars VARCHAR,
    review_count VARCHAR,
    is_open VARCHAR,
    categories VARCHAR,
    attributes VARCHAR,
    hours VARCHAR,
    _ingested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS staging.raw_yelp_user (
    user_id VARCHAR,
    name VARCHAR,
    review_count VARCHAR,
    yelping_since VARCHAR,
    useful VARCHAR,
    funny VARCHAR,
    cool VARCHAR,
    elite VARCHAR,
    friends VARCHAR,
    fans VARCHAR,
    average_stars VARCHAR,
    compliment_hot VARCHAR,
    compliment_more VARCHAR,
    compliment_profile VARCHAR,
    compliment_cute VARCHAR,
    compliment_list VARCHAR,
    compliment_note VARCHAR,
    compliment_plain VARCHAR,
    compliment_cool VARCHAR,
    compliment_funny VARCHAR,
    compliment_writer VARCHAR,
    compliment_photos VARCHAR,
    _ingested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS staging.raw_yelp_checkin (
    business_id VARCHAR,
    date VARCHAR,
    _ingested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS staging.raw_yelp_tip (
    business_id VARCHAR,
    user_id VARCHAR,
    text VARCHAR,
    date VARCHAR,
    compliment_count VARCHAR,
    _ingested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS staging.raw_yelp_review (
    review_id VARCHAR,
    user_id VARCHAR,
    business_id VARCHAR,
    stars VARCHAR,
    useful VARCHAR,
    funny VARCHAR,
    cool VARCHAR,
    text VARCHAR,
    date VARCHAR,
    _ingested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS staging.raw_weather_precipitation (
    date VARCHAR,
    precipitation VARCHAR,
    precipitation_normal VARCHAR,
    _ingested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS staging.raw_weather_temperature (
    date VARCHAR,
    min VARCHAR,
    max VARCHAR,
    normal_min VARCHAR,
    normal_max VARCHAR,
    _ingested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);