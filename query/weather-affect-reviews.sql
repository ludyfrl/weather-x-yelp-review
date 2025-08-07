SELECT
    CASE
        WHEN dim.precipitation >= 0.5 THEN 'Rainy'
        WHEN dim.precipitation > 0 AND dim.precipitation < 0.5 THEN 'Light Rain'
        WHEN dim.precipitation = 0 THEN 'Dry'
        ELSE 'Unknown'
    END AS weather_type,
    AVG(fr.stars) AS avg_stars
FROM dw.fact_review fr
JOIN dw.dim_date_weather dim ON fr.date_sk = dim.date_sk
GROUP BY 1
ORDER BY 2 DESC;