## Overview

When data is written into a specific workspace, Guance will monitor and tally the volume of data written in real-time. It records and stores this statistical information in the database according to a preset time cycle.

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

### Field Description

| Field        | Type   | Description                                                                 | Example                     |
| -------------- | ------- | ------------------------------------------------------------------------------- | ----------------------------- |
| time          | int64  | Metric item timestamp, in milliseconds, e.g., 1720584000000 is equivalent to 2024-07-10 12:00:00, indicating the metric item time range from 2024-07-10 12:00:00 to 2024-07-10 13:00:00 (inclusive on the left, exclusive on the right) | 1720584000000               |
| date          | int64  | Same as `time`                                                                |                             |
| __docid       | string | Unique identifier for a database record                                       | fb4d3b817fdc08a266bfefe85049d279 |
| workspaceUUID | string | Workspace ID                                                                  | wksp_3c5cc6626cb64550b401347931fcf467 |
| project       | string | Metering project, see detailed explanation below                              | logging                      |
| sub_project   | string | Sub-metering project, see detailed explanation below                          | default                      |
| count         | int64  | Total metering                                                               | 2345                         |
| hour_count    | int64  | Hourly metering data                                                         | 1234                         |
| create_time   | int64  | Actual time of writing to the database, in milliseconds                       | 1720591166343                |

### Metering Project (`project`) Explanation

Note⚠️: For total statistics, use `count`; for incremental statistics, use `hour_count`.

| Metric Item            | project           | sub_project                                      | Statistics Period | Method     | Description                                                                 |
| ------------------------ | ------------------- | -------------------------------------------------- | ------------------- | ------------ | ----------------------------------------------------------------------------- |
| Datakit quantity        | datakit            |                                                   | Every hour         | Total      | Usage amount of Datakit in a specific workspace                             |
| Site-wide Datakit quantity | cluster_datakit    |                                                   | Every hour         | Total      | Usage amount of Datakit across the entire site, unrelated to specific workspaces |
| HTTP API quantity       | api_test           |                                                   | Every hour         | Incremental |                                                                             |
| PV quantity             | rum_pv             |                                                   | Every hour         | Incremental |                                                                             |
| RUM write traffic charge item | rum_bytes        |                                                   | Every hour         | Incremental |                                                                             |
| Trace quantity          | tracing            |                                                   | Every hour         | Incremental |                                                                             |
| Tracing write traffic charge item | tracing_bytes   |                                                   | Every hour         | Incremental |                                                                             |
| Event quantity          | keyevent           |                                                   | Every hour         | Total      |                                                                             |
| Backup data to customer S3 object storage | backup_log_s3_bytes | Optional values: logging/tracing/rum, representing backup information for corresponding data types | Every hour         | Incremental |                                                                             |
| Backup data to customer message engine | backup_log_kafka_bytes | Optional values: logging/tracing/rum, representing backup information for corresponding data types | Every hour         | Incremental |                                                                             |
| Backup data to customer OSS object storage | backup_log_oss_bytes | Optional values: logging/tracing/rum, representing backup information for corresponding data types | Every hour         | Incremental |                                                                             |
| Backup data to customer OBS object storage | backup_log_obs_bytes | Optional values: logging/tracing/rum, representing backup information for corresponding data types | Every hour         | Incremental |                                                                             |
| Backup data to Guance object storage | backup_log_guance_bytes | Optional values: logging/tracing/rum, representing backup information for corresponding data types | Every hour         | Total      |                                                                             |
| Security check          | security           |                                                   | Every hour         | Incremental |                                                                             |
| Scheduled report        | report             |                                                   | Every 5 minutes    | Incremental |                                                                             |
| Object quantity         | object             |                                                   | Every hour         | Total      |                                                                             |
| Pipeline byte processing volume | pipeline_processed_bytes |                                                   | Every hour         | Incremental |                                                                             |
| Sensitive data scan traffic charge item | privacy_scan_bytes |                                                   | Every hour         | Incremental |                                                                             |
| Log write traffic charge item | logging_bytes     | Optional value: index name for multi-index logs   | Every hour         | Incremental |                                                                             |
| Log quantity            | logging            | Optional value: index name for multi-index logs   | Every hour         | Incremental |                                                                             |
| Time series             | ts                 |                                                   | Every hour         | Total      |                                                                             |
| Pipeline traffic statistics | pipeline_processed_bytes |                                                   | Every hour         | Incremental |                                                                             |

## Query Metering Data

```
# Using DQL statements, you can view the log write volume within a day for a specific workspace

metering::`*`:(sum(hour_count)) {project="logging", workspaceUUID="wksp_xxx"}
```