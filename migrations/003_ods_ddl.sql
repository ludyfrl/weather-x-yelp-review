CREATE TABLE IF NOT EXISTS ods.yelp_business (
    business_id VARCHAR PRIMARY KEY,
    name VARCHAR,
    address VARCHAR,
    city VARCHAR,
    state VARCHAR,
    postal_code VARCHAR,
    latitude DECIMAL,
    longitude DECIMAL,
    stars DECIMAL(2, 1),
    review_count INTEGER,
    is_open INTEGER,
    categories VARCHAR,
    attributes JSONB,
    hours JSONB,
    _ingested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    _created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    _updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ods.yelp_user (
    user_id VARCHAR PRIMARY KEY,
    name VARCHAR,
    review_count INTEGER,
    yelping_since VARCHAR,
    useful INTEGER,
    funny INTEGER,
    cool INTEGER,
    elite VARCHAR,
    friends VARCHAR,
    fans INTEGER,
    average_stars DECIMAL(2, 1),
    compliment_hot INTEGER,
    compliment_more INTEGER,
    compliment_profile INTEGER,
    compliment_cute INTEGER,
    compliment_list INTEGER,
    compliment_note INTEGER,
    compliment_plain INTEGER,
    compliment_cool INTEGER,
    compliment_funny INTEGER,
    compliment_writer INTEGER,
    compliment_photos INTEGER,
    _ingested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    _created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    _updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ods.yelp_checkin (
    business_id VARCHAR,
    date VARCHAR,
    _ingested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    _created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    _updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ods.yelp_tip (
    business_id VARCHAR,
    user_id VARCHAR,
    text VARCHAR,
    date VARCHAR,
    compliment_count INTEGER,
    _ingested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    _created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    _updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (business_id, user_id)
);

CREATE TABLE IF NOT EXISTS ods.yelp_review (
    review_id VARCHAR PRIMARY KEY,
    user_id VARCHAR,
    business_id VARCHAR,
    stars INTEGER,
    useful INTEGER,
    funny INTEGER,
    cool INTEGER,
    text VARCHAR,
    date VARCHAR,
    _ingested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    _created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    _updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ods.weather_precipitation (
    date VARCHAR PRIMARY KEY,
    precipitation DECIMAL(3, 2),
    precipitation_normal DECIMAL(3, 2),
    _ingested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    _created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    _updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ods.weather_temperature (
    date VARCHAR PRIMARY KEY,
    min DECIMAL(3, 2),
    max DECIMAL(3, 2),
    normal_min DECIMAL(3, 2),
    normal_max DECIMAL(3, 2),
    _ingested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    _created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    _updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);