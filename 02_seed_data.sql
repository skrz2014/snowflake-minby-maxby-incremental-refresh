-- ============================================================
-- 02_seed_data.sql
-- Load sample IoT sensor readings (18 rows across 6 sensors)
--
-- Article: https://medium.com/@snowflakechronicles
-- Author:  Satish Kumar | https://www.linkedin.com/in/satishkumar-snowflake/
-- ============================================================

INSERT INTO iot_monitoring.sensor_data.raw_readings
    (sensor_id, facility, reading_ts, temperature_c, humidity_pct, battery_level)
VALUES
    ('SENS-001', 'Warehouse-East',  '2026-03-15 08:00:00', 22.5, 45.0, 98.2),
    ('SENS-001', 'Warehouse-East',  '2026-03-15 08:15:00', 22.8, 44.5, 98.1),
    ('SENS-001', 'Warehouse-East',  '2026-03-15 08:30:00', 23.1, 44.0, 98.0),
    ('SENS-002', 'Warehouse-East',  '2026-03-15 08:00:00', 21.0, 50.2, 72.5),
    ('SENS-002', 'Warehouse-East',  '2026-03-15 08:15:00', 21.3, 49.8, 72.3),
    ('SENS-002', 'Warehouse-East',  '2026-03-15 08:30:00', 21.7, 49.5, 72.1),
    ('SENS-003', 'Warehouse-West',  '2026-03-15 08:00:00', 19.5, 55.0, 45.0),
    ('SENS-003', 'Warehouse-West',  '2026-03-15 08:15:00', 19.8, 54.5, 44.8),
    ('SENS-003', 'Warehouse-West',  '2026-03-15 08:30:00', 20.1, 54.0, 44.5),
    ('SENS-004', 'Warehouse-West',  '2026-03-15 08:00:00', 25.5, 40.0, 88.0),
    ('SENS-004', 'Warehouse-West',  '2026-03-15 08:15:00', 26.2, 39.0, 87.8),
    ('SENS-004', 'Warehouse-West',  '2026-03-15 08:30:00', 27.0, 38.5, 87.5),
    ('SENS-005', 'Warehouse-North', '2026-03-15 08:00:00', 18.0, 60.0, 15.3),
    ('SENS-005', 'Warehouse-North', '2026-03-15 08:15:00', 18.2, 59.5, 15.0),
    ('SENS-005', 'Warehouse-North', '2026-03-15 08:30:00', 18.5, 59.0, 14.8),
    ('SENS-006', 'Warehouse-North', '2026-03-15 08:00:00', 30.5, 35.0, 92.0),
    ('SENS-006', 'Warehouse-North', '2026-03-15 08:15:00', 31.0, 34.0, 91.8),
    ('SENS-006', 'Warehouse-North', '2026-03-15 08:30:00', 31.8, 33.5, 91.5);

-- Verify
SELECT * FROM iot_monitoring.sensor_data.raw_readings
ORDER BY sensor_id, reading_ts;
