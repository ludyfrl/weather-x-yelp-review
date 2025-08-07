SELECT
    -- CASE
    --     WHEN dim.precipitation >= 0.5 THEN 'Rainy'
    --     WHEN dim.precipitation > 0 AND dim.precipitation < 0.5 THEN 'Light Rain'
    --     WHEN dim.precipitation = 0 THEN 'Dry'
    --     ELSE 'Unknown'
    -- END AS weather_type,

    CASE
        WHEN (dim.normal_max_temperature+dim.normal_min_temperature)/2 < 50 THEN 'Cold'
        WHEN (dim.normal_max_temperature+dim.normal_min_temperature)/2 BETWEEN 50 AND 75 THEN 'Mild'
        WHEN (dim.normal_max_temperature+dim.normal_min_temperature)/2 > 75 THEN 'Hot'
        ELSE 'Unknown'
    END AS temp_bucket,
    AVG(fr.stars) AS avg_stars
FROM dw.fact_review fr
JOIN dw.dim_date_weather dim ON fr.date_sk = dim.date_sk
GROUP BY temp_bucket
ORDER BY 2 DESC;