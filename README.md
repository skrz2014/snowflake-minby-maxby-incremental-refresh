# Snowflake Just Fixed the MIN_BY/MAX_BY Performance Tax

> Incremental refresh support is now GA — and if you're building real-time pipelines with Dynamic Tables, this is the update you didn't know you were waiting for.

📖 **Read the full article on Medium:** [Snowflake Just Fixed the MIN_BY/MAX_BY Performance Tax](https://medium.com/@snowflakechronicles)  
🔗 **Connect on LinkedIn:** [Satish Kumar](https://www.linkedin.com/in/satishkumar-snowflake/)

---

## What This Repo Contains

This repository contains all the SQL code from the Medium article — a complete, end-to-end IoT sensor monitoring pipeline built on Snowflake Dynamic Tables using `MIN_BY` and `MAX_BY` with incremental refresh.

As of **March 19, 2026**, these functions are GA with incremental refresh support, meaning dynamic tables using them now process only changed rows — not the entire dataset on every cycle.

---

## Repo Structure

```
snowflake-minby-maxby-incremental-refresh/
│
├── README.md
│
└── sql/
    ├── 01_setup.sql                  -- Database, schema, and source table
    ├── 02_seed_data.sql              -- Sample IoT sensor readings
    ├── 03_dynamic_table_latest.sql   -- Latest reading per sensor (MAX_BY + timestamp)
    ├── 04_dynamic_table_extremes.sql -- Facility extremes: hottest sensor + lowest battery
    ├── 05_dynamic_table_temp_range.sql -- Temperature range per facility (MAX_BY + MIN_BY)
    ├── 06_incremental_refresh_test.sql -- Insert new rows to trigger incremental refresh
    ├── 07_verify_refresh_mode.sql    -- Confirm INCREMENTAL mode via refresh history
    └── 08_cleanup.sql                -- Drop database when done
```

---

## Prerequisites

- A Snowflake account (Standard edition or higher)
- A warehouse — scripts default to `SHARED_WH`, update as needed
- `SYSADMIN` or equivalent role with `CREATE DATABASE` privileges

---

## Quick Start

Run the scripts in order:

```bash
# 1. Set up the database, schema, and source table
01_setup.sql

# 2. Load sample sensor data
02_seed_data.sql

# 3. Create the three dynamic tables
03_dynamic_table_latest.sql
04_dynamic_table_extremes.sql
05_dynamic_table_temp_range.sql

# 4. Wait ~1 minute for initial refresh, then simulate new data
06_incremental_refresh_test.sql

# 5. Confirm incremental refresh is active
07_verify_refresh_mode.sql

# 6. Clean up when done
08_cleanup.sql
```

---

## The Three Dynamic Tables

### 1. `latest_sensor_readings`
Returns the most recent temperature, humidity, and battery level per sensor using `MAX_BY(value, timestamp)` — a clean, subquery-free alternative to `ROW_NUMBER()`.

### 2. `facility_extremes`
Per facility: identifies the hottest sensor and its timestamp, and the lowest-battery sensor and its timestamp — all in a single aggregation pass using both `MAX_BY` and `MIN_BY`.

### 3. `top_hot_sensors_by_facility`
Per facility: shows the hottest and coolest sensors using `MAX_BY` and `MIN_BY` keyed on temperature. Uses single-value form only — the array (top-N) form is not yet supported in dynamic tables.

---

## Key Patterns

| Pattern | Function | Use Case |
|---|---|---|
| Latest value per group | `MAX_BY(value, timestamp)` | Real-time sensor dashboards |
| Top record per group | `MAX_BY(id, metric)` | Hottest / highest / most recent |
| Bottom record per group | `MIN_BY(id, metric)` | Lowest battery / coolest / earliest |
| Confirm incremental mode | `DYNAMIC_TABLE_REFRESH_HISTORY()` | Debug refresh fallback to FULL |

> **Note:** The array form `MAX_BY(col, col, N)` is supported in regular queries but **not** in dynamic tables. Use the single-value form in dynamic table definitions.

---

## Why Incremental Refresh Matters

| Mode | What It Processes | Cost Profile |
|---|---|---|
| Full Refresh | Every source row, every cycle | Scales linearly with table size |
| Incremental Refresh | Only new/changed rows since last refresh | Near-constant for steady-state workloads |

Before March 2026, any dynamic table using `MIN_BY` or `MAX_BY` silently fell back to full refresh. This repo demonstrates the new behaviour — and how to verify it's working.

---

## Author

**Satish Kumar**  
📖 [Medium — Snowflake Chronicles](https://medium.com/@snowflakechronicles)  
🔗 [LinkedIn](https://www.linkedin.com/in/satishkumar-snowflake/)

If the article or this repo helped you, consider giving the Medium post a clap (up to 50!) and following for more Snowflake deep-dives.

---

## License

MIT — free to use, adapt, and share. Attribution appreciated.
