-- ============================================================
-- 04_dynamic_table_extremes.sql
-- Dynamic Table: Facility extremes — hottest sensor + lowest battery
--
-- Uses both MAX_BY and MIN_BY in a single aggregation pass.
-- No self-joins, no subqueries.
--
-- Article: https://medium.com/@snowflakechronicles
-- Author:  Satish Kumar | https://www.linkedin.com/in/satishkumar-snowflake/
-- ============================================================

CREATE OR REPLACE DYNAMIC TABLE iot_monitoring.sensor_data.facility_extremes
    WAREHOUSE = SHARED_WH
    TARGET_LAG = '1 minute'
AS
SELECT
    facility,
    MAX(temperature_c)             AS peak_temperature_c,
    MAX_BY(sensor_id,  temperature_c) AS hottest_sensor,
    MAX_BY(reading_ts, temperature_c) AS hottest_reading_time,
    MIN(battery_level)             AS lowest_battery_pct,
    MIN_BY(sensor_id,  battery_level) AS lowest_battery_sensor,
    MIN_BY(reading_ts, battery_level) AS lowest_battery_time
FROM iot_monitoring.sensor_data.raw_readings
GROUP BY facility;

-- Query after refresh (~1 minute)
SELECT * FROM iot_monitoring.sensor_data.facility_extremes
ORDER BY peak_temperature_c DESC;
