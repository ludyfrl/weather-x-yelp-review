CREATE TABLE IF NOT EXISTS dw.dim_business (
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
    _created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    _updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dw.dim_user (
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
    _created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    _updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dw.fact_checkin (
    checkin_sk SERIAL PRIMARY KEY, 
    business_id VARCHAR,
    date_sk INTEGER,
    checkin_count INTEGER,
    _created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    _updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dw.fact_tip (
    tip_sk SERIAL PRIMARY KEY,
    business_id VARCHAR,
    user_id VARCHAR,
    date_sk INTEGER,
    tip_text VARCHAR,
    compliment_count INTEGER,
    _created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    _updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dw.fact_review (
    review_id VARCHAR PRIMARY KEY,
    user_id VARCHAR,
    business_id VARCHAR,
    date_sk INTEGER,
    stars INTEGER,
    useful_votes INTEGER,
    funny_votes INTEGER,
    cool_votes INTEGER,
    review_text VARCHAR,
    _created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    _updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dw.dim_date_weather (
    date_sk SERIAL PRIMARY KEY,
    full_date VARCHAR,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    day_name VARCHAR,
    month_name VARCHAR,
    min_temperature DECIMAL(3, 2),
    max_temperature DECIMAL(3, 2),
    normal_min_temperature DECIMAL(3, 2),
    normal_max_temperature DECIMAL(3, 2),
    precipitation DECIMAL(3, 2),
    precipitation_normal DECIMAL(3, 2),
    _created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    _updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);