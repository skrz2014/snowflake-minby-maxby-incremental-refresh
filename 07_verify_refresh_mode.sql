-- ============================================================
-- 07_verify_refresh_mode.sql
-- Confirm dynamic tables are using INCREMENTAL refresh mode
--
-- After the first full refresh (initial load), subsequent cycles
-- should show refresh_mode = 'INCREMENTAL'.
--
-- If you see 'FULL', check refresh_mode_reason for the cause
-- (e.g. unsupported function, non-deterministic expression).
--
-- Article: https://medium.com/@snowflakechronicles
-- Author:  Satish Kumar | https://www.linkedin.com/in/satishkumar-snowflake/
-- ============================================================

SELECT
    name,
    refresh_mode,
    refresh_mode_reason,
    target_lag,
    warehouse
FROM TABLE(INFORMATION_SCHEMA.DYNAMIC_TABLE_REFRESH_HISTORY())
WHERE name IN (
    'LATEST_SENSOR_READINGS',
    'FACILITY_EXTREMES',
    'TOP_HOT_SENSORS_BY_FACILITY'
)
ORDER BY data_timestamp DESC
LIMIT 10;
