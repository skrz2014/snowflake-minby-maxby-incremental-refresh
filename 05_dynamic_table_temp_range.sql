-- ============================================================
-- 05_dynamic_table_temp_range.sql
-- Dynamic Table: Temperature range per facility
--
-- Identifies the hottest and coolest sensors per facility
-- using single-value MAX_BY and MIN_BY.
--
-- NOTE: The array form MAX_BY(col, col, N) / MIN_BY(col, col, N)
-- is NOT currently supported in dynamic tables. Use the
-- single-value form shown here instead.
--
-- Article: https://medium.com/@snowflakechronicles
-- Author:  Satish Kumar | https://www.linkedin.com/in/satishkumar-snowflake/
-- ============================================================

CREATE OR REPLACE DYNAMIC TABLE iot_monitoring.sensor_data.top_hot_sensors_by_facility
    WAREHOUSE = SHARED_WH
    TARGET_LAG = '1 minute'
AS
SELECT
    facility,
    MAX_BY(sensor_id, temperature_c) AS hottest_sensor,
    MAX(temperature_c)               AS max_temperature_c,
    MIN_BY(sensor_id, temperature_c) AS coolest_sensor,
    MIN(temperature_c)               AS min_temperature_c
FROM iot_monitoring.sensor_data.raw_readings
GROUP BY facility;

-- Query after refresh (~1 minute)
SELECT * FROM iot_monitoring.sensor_data.top_hot_sensors_by_facility
ORDER BY facility;
