-- ============================================================
-- 03_dynamic_table_latest.sql
-- Dynamic Table: Latest reading per sensor
--
-- Uses MAX_BY(value, timestamp) as a clean alternative to
-- ROW_NUMBER() OVER (PARTITION BY ... ORDER BY reading_ts DESC)
--
-- Article: https://medium.com/@snowflakechronicles
-- Author:  Satish Kumar | https://www.linkedin.com/in/satishkumar-snowflake/
-- ============================================================

CREATE OR REPLACE DYNAMIC TABLE iot_monitoring.sensor_data.latest_sensor_readings
    WAREHOUSE = SHARED_WH
    TARGET_LAG = '1 minute'
AS
SELECT
    sensor_id,
    facility,
    MAX(reading_ts)                   AS last_seen_at,
    MAX_BY(temperature_c, reading_ts) AS latest_temperature_c,
    MAX_BY(humidity_pct,  reading_ts) AS latest_humidity_pct,
    MAX_BY(battery_level, reading_ts) AS latest_battery_level
FROM iot_monitoring.sensor_data.raw_readings
GROUP BY sensor_id, facility;

-- Query after refresh (~1 minute)
SELECT * FROM iot_monitoring.sensor_data.latest_sensor_readings
ORDER BY facility, sensor_id;
