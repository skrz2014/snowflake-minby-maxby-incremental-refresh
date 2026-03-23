-- ============================================================
-- 06_incremental_refresh_test.sql
-- Simulate new sensor data to trigger incremental refresh
--
-- Insert 4 new rows. Dynamic tables will process ONLY these rows
-- on the next refresh cycle — not all 18 from the initial load.
--
-- Article: https://medium.com/@snowflakechronicles
-- Author:  Satish Kumar | https://www.linkedin.com/in/satishkumar-snowflake/
-- ============================================================

INSERT INTO iot_monitoring.sensor_data.raw_readings
    (sensor_id, facility, reading_ts, temperature_c, humidity_pct, battery_level)
VALUES
    ('SENS-001', 'Warehouse-East',  '2026-03-15 08:45:00', 24.0, 43.0, 97.9),
    ('SENS-003', 'Warehouse-West',  '2026-03-15 08:45:00', 20.5, 53.0, 44.0),
    ('SENS-005', 'Warehouse-North', '2026-03-15 08:45:00', 18.8, 58.5, 14.5),
    ('SENS-006', 'Warehouse-North', '2026-03-15 08:45:00', 32.5, 33.0, 91.2);

-- Wait ~1 minute, then verify the dynamic tables updated
-- Expected: SENS-006 peak rises to 32.5°C, SENS-005 battery drops to 14.5%

SELECT * FROM iot_monitoring.sensor_data.latest_sensor_readings
ORDER BY facility, sensor_id;

SELECT * FROM iot_monitoring.sensor_data.facility_extremes
ORDER BY peak_temperature_c DESC;
