{
CREATE TABLE nyc311_db.resolution_time_modeling AS
SELECT
    agency,
    borough,
    problem,
    incident_zip,
    day_of_week(date_parse(created_date, '%Y-%m-%d %H:%i:%s'))  AS day_of_week,
    hour(date_parse(created_date, '%Y-%m-%d %H:%i:%s'))          AS hour_of_day,
    -- Count of same complaint type filed on same day (proxy for surge volume)
    COUNT(*) OVER (
        PARTITION BY agency, problem,
                     DATE(date_parse(created_date, '%Y-%m-%d %H:%i:%s'))
    ) AS same_day_complaint_volume,
    -- Continuous target: days to close
    date_diff('day',
        date_parse(created_date, '%Y-%m-%d %H:%i:%s'),
        date_parse(closed_date,  '%Y-%m-%d %H:%i:%s')) AS days_to_close
FROM nyc311_db.complaints
WHERE closed_date <> ''
  AND borough IN ('BROOKLYN','QUEENS','BRONX','MANHATTAN','STATEN ISLAND')
  AND date_diff('day',
        date_parse(created_date, '%Y-%m-%d %H:%i:%s'),
        date_parse(closed_date,  '%Y-%m-%d %H:%i:%s')) BETWEEN 0 AND 365;
}
