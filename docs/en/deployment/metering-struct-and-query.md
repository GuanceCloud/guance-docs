## Overview

When data is written into a specific workspace, <<< custom_key.brand_name >>> will monitor and tally the volume of data written in real-time. It records and stores this statistical information in the database according to a preset time cycle.

By combining DQL query statements, users can easily build a usage analysis dashboard. This dashboard provides an intuitive analysis of data usage, helping users gain insights into data traffic trends, optimize resource allocation, and monitor data usage.

## Data Structure

```json
{
    "time": 1720584000000,
    "__docid": "fb4d3b817fdc08a266bfefe85049d279",
    "count": "0",
    "create_time": "1720591166343",
    "date": "1720584000000",
    "hour_count": "0",
    "project": "logging",
    "sub_project": "default",
    "workspaceUUID": "wksp_3c5cc6626cb64550b401347931fcf467"
}
```

### Field Descriptions

| Field        | Type   | Description                                                                                                                                                                                                                   | Example                    |
| ------------ | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------- |
| time         | int64  | The timestamp of the metric item in milliseconds (ms). For example: 1720584000000 is equivalent to 2024-07-10 12:00:00, indicating the metric item's time range is from 2024-07-10 12:00:00 to 2024-07-10 13:00:00 (left-closed, right-open) | 1720584000000              |
| date         | int64  | Same as `time`                                                                                                                                                                                                                 |                            |
| __docid      | string | Unique identifier for a database record                                                                                                                                                                                       | fb4d3b817fdc08a266bfefe85049d279 |
| workspaceUUID| string | Workspace ID                                                                                                                                                                                                                  | wksp_3c5cc6626cb64550b401347931fcf467 |
| project      | string | Metering project, see detailed description below                                                                                                                                                                               | logging                    |
| sub_project  | string | Sub-project for metering, see detailed description below                                                                                                                                                                       | default                    |
| count        | int64  | Total metering                                                                                                                                                                                                                | 2345                       |
| hour_count   | int64  | Hourly metering data                                                                                                                                                                                                          | 1234                       |
| create_time  | int64  | Actual time when the data was written to the database, in milliseconds (ms)                                                                                                                                                   | 1720591166343              |

### Metering Project (`project`) Explanation

Note⚠️: For total statistics, use `count`, and for incremental statistics, use `hour_count`.

| Metric Item           | project          | sub_project               | Statistical Period       | Method     | Description                                                                 |
| --------------------- | ---------------- | ------------------------- | ------------------------- | ---------- | --------------------------------------------------------------------------- |
| Datakit Count         | datakit          |                           | Every hour               | Total      | Usage of Datakit in a specific workspace                                    |
| Site-wide Datakit Count | cluster_datakit  |                           | Every hour               | Total      | Total Datakit usage across the entire site, unrelated to specific workspaces|
| HTTP API Count        | api_test         |                           | Every hour               | Incremental|                                                                             |
| PV Count              | rum_pv           |                           | Every hour               | Incremental|                                                                             |
| RUM Write Traffic Charge Item | rum_bytes       |                           | Every hour               | Incremental|                                                                             |
| Trace Count           | tracing          |                           | Every hour               | Incremental|                                                                             |
| Tracing Write Traffic Charge Item | tracing_bytes  |                           | Every hour               | Incremental|                                                                             |
| Event Count           | keyevent         |                           | Every hour               | Total      |                                                                             |
| Backup Data to Customer S3 Object Storage | backup_log_s3_bytes | Optional values: logging/tracing/rum | Every hour               | Incremental| Represents backup information for corresponding data types                  |
| Backup Data to Customer Message Engine | backup_log_kafka_bytes | Optional values: logging/tracing/rum | Every hour               | Incremental| Represents backup information for corresponding data types                  |
| Backup Data to Customer OSS Object Storage | backup_log_oss_bytes | Optional values: logging/tracing/rum | Every hour               | Incremental| Represents backup information for corresponding data types                  |
| Backup Data to Customer OBS Object Storage | backup_log_obs_bytes | Optional values: logging/tracing/rum | Every hour               | Incremental| Represents backup information for corresponding data types                  |
| Backup Data to Guance Object Storage | backup_log_guance_bytes | Optional values: logging/tracing/rum | Every hour               | Total      | Represents backup information for corresponding data types                  |
| Security Check        | security         |                           | Every hour               | Incremental|                                                                             |
| Scheduled Reports     | report           |                           | Every 5 minutes          | Incremental|                                                                             |
| Object Count          | object           |                           | Every hour               | Total      |                                                                             |
| Pipeline Byte Processing Volume | pipeline_processed_bytes |                          | Every hour               | Incremental|                                                                             |
| Sensitive Data Scan Traffic Charge Item | privacy_scan_bytes |                          | Every hour               | Incremental|                                                                             |
| Log Write Traffic Charge Item | logging_bytes   | Optional values: index names of multi-index logs | Every hour               | Incremental|                                                                             |
| Log Count             | logging          | Optional values: index names of multi-index logs | Every hour               | Incremental|                                                                             |
| Time Series           | ts               |                           | Every hour               | Total      |                                                                             |
| Pipeline Traffic Statistics | pipeline_processed_bytes |                          | Every hour               | Incremental|                                                                             |

## Querying Metering Data

```
# Using DQL statements, you can view the log write volume within a specific workspace for one day

metering::`*`:(sum(hour_count)) {project="logging", workspaceUUID="wksp_xxx"}
```