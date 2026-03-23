-- ============================================================
-- 01_setup.sql
-- Database, schema, and source table setup
--
-- Article: https://medium.com/@snowflakechronicles
-- Author:  Satish Kumar | https://www.linkedin.com/in/satishkumar-snowflake/
-- ============================================================

CREATE OR REPLACE DATABASE iot_monitoring;
CREATE OR REPLACE SCHEMA iot_monitoring.sensor_data;

CREATE OR REPLACE TABLE iot_monitoring.sensor_data.raw_readings (
    reading_id    NUMBER AUTOINCREMENT,
    sensor_id     VARCHAR(20),
    facility      VARCHAR(50),
    reading_ts    TIMESTAMP_NTZ,
    temperature_c FLOAT,
    humidity_pct  FLOAT,
    battery_level FLOAT,
    ingested_at   TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);
