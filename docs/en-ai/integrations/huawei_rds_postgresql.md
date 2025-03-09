---
title: 'Huawei Cloud RDS PostgreSQL'
tags: 
  - Huawei Cloud
summary: 'The displayed Metrics for Huawei Cloud RDS PostgreSQL include query performance, transaction throughput, concurrent connections, and data reliability. These Metrics reflect the performance and reliability of RDS PostgreSQL when handling large-scale relational data storage and transaction processing.'
__int_icon: 'icon/huawei_rds_postgresql'
dashboard:

  - desc: 'Built-in Views for Huawei Cloud RDS PostgreSQL'
    path: 'dashboard/en/huawei_rds_postgresql'

monitor:
  - desc: 'Monitor for Huawei Cloud RDS PostgreSQL'
    path: 'monitor/en/huawei_rds_postgresql'

---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud RDS PostgreSQL
<!-- markdownlint-enable -->

The displayed Metrics for Huawei Cloud RDS PostgreSQL include query performance, transaction throughput, concurrent connections, and data reliability. These Metrics reflect the performance and reliability of RDS PostgreSQL when handling large-scale relational data storage and transaction processing.


## Configuration {#config}

### Install Func

We recommend enabling the Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize monitoring data from Huawei Cloud RDS PostgreSQL, install the corresponding collection script: visit the web service of func and enter the 【Script Market】, select 「Guance Integration (Huawei Cloud-RDS-PostgreSQL Collection)」(ID: `guance_huaweicloud_rds_postgresql`).

Click 【Install】and input the required parameters: Huawei Cloud AK, SK, Huawei Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and configure the corresponding startup script.

After the script is installed, find the script 「Guance Integration (Huawei Cloud-RDS-PostgreSQL Collection)」under 「Development」in Func, expand and modify this script, locate `collector_configs` and `monitor_configs`, and edit the content of `region_projects`. Change the region and Project ID to the actual values, then click Save and Publish.

Additionally, view the corresponding automatic trigger configuration under 「Management / Automatic Trigger Configuration」. Click 【Execute】to immediately execute it once without waiting for the scheduled time. After a short wait, you can check the execution task records and corresponding logs.

By default, we collect some configurations; for more details, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-rds-postgresql/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, in 「Infrastructure / Custom」check if asset information exists.
3. On the Guance platform, in 「Metrics」check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Huawei Cloud Cloud Monitoring, the default Mearsurement sets are as follows. You can collect more Metrics through configuration [Huawei Cloud Cloud Monitoring Metrics Details](https://support.huaweicloud.com/usermanual-rds/rds_pg_06_0001.html){:target="_blank"}

### Instance Monitoring Metrics

RDS for PostgreSQL instance performance monitoring Metrics are shown in the table below. For more Metrics, refer to [Table 1](https://support.huaweicloud.com/usermanual-rds/rds_pg_06_0001.html){:target="_blank"}

| Metric ID                                       | Metric Name                                | Metric Description                                                     | Value Range           | Monitoring Period (Original Metric) |
| -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `swap_total_size`| Total Swap Size| This Metric measures the total swap size.| ≥ 0 MB| 1 minute|
| `swap_usage`| Swap Usage Rate| This Metric measures the swap usage rate.| 0-100%| 1 minute|
| `rds005_bytes_out`| Network Output Throughput| This Metric measures the average traffic output per second from all network adapters of the measurement object, in bytes/second.| ≥ 0 bytes/s| 1 minute|
| `rds004_bytes_in`| Network Input Throughput| This Metric measures the average traffic input per second from all network adapters of the measurement object, in bytes/second.| ≥ 0 bytes/s| 1 minute|
| `rds003_iops`| IOPS| This Metric measures the number of I/O requests processed by the current instance per unit time (average).| ≥ 0 counts/s| 1 minute|
| `read_count_per_second`| Read IOPS| This Metric measures the number of read I/O requests processed by the current instance per unit time (average).| ≥ 0 counts/s| 1 minute|
| `write_count_per_second`| Write IOPS| This Metric measures the number of write I/O requests processed by the current instance per unit time (average).| ≥ 0 counts/s| 1 minute|
| `rds042_database_connections`| Database Connections| The number of backend connections currently connected to the database.| ≥ 0 counts| 1 minute|
| `rds083_conn_usage`| Connection Usage Rate| This Metric measures the percentage of used PgSQL connections out of the total connections.| 0-100%| 1 minute|
| `active_connections`| Active Connections| This Metric measures the current active database connections.| ≥ 0| 1 minute|
| `rds082_tps`| TPS| This Metric measures the number of transactions executed per second, including committed and rolled back ones.| ≥ 0 times/second| 1 minute|
| `rds046_replication_lag`| Replication Lag| The replication lag delay.| ≥ 0 ms| 1 minute|
| `synchronous_replication_blocking_time`| Synchronous Replication Blocking Time| This Metric measures the duration of synchronous replication blocking between the master and standby.| ≥ 0 s| 1 minute|
| `inactive_logical_replication_slot`| Inactive Logical Replication Slots| This Metric measures the number of inactive logical replication slots in the current database.| ≥ 0| 1 minute|
| `rds041_replication_slot_usage`| Replication Slot Usage| Disk space occupied by replication slot files.| ≥ 0 MB| 1 minute|
| `rds043_maximum_used_transaction_ids`| Maximum Used Transaction IDs| The maximum number of used transaction IDs.| ≥ 0 counts| 1 minute|
| `idle_transaction_connections`| Idle Transaction Connections| This Metric measures the current idle database connections.| ≥ 0| 1 minute|
| `oldest_transaction_duration`| Longest Transaction Duration| This Metric measures the longest transaction duration in the current database.| ≥ 0 ms| 1 minute|
| `oldest_transaction_duration_2pc`| Longest Pending Transaction Duration| This Metric measures the longest pending transaction duration in the current database.| ≥ 0 ms| 1 minute|
| `rds040_transaction_logs_usage`| Transaction Log Usage| Disk space occupied by transaction logs.| ≥ 0 MB| 1 minute|
| `lock_waiting_sessions`| Sessions Waiting for Locks| This Metric measures the number of sessions currently in a blocked state.| ≥ 0| 1 minute|
| `slow_sql_log_min_duration_statement`| SQL Statements Executed Longer Than log_min_duration_statement| This Metric measures the number of slow SQL statements whose execution time exceeds the parameter `log_min_duration_statement`, which can be adjusted according to business needs.| ≥ 0| 1 minute|
| `slow_sql_one_second`| SQL Statements Executed Longer Than 1 Second| This Metric measures the number of slow SQL statements whose execution time exceeds 1 second.| ≥ 0| 1 minute|
| `slow_sql_three_second`| SQL Statements Executed Longer Than 3 Seconds| This Metric measures the number of slow SQL statements whose execution time exceeds 3 seconds.| ≥ 0| 1 minute|
| `slow_sql_five_second`| SQL Statements Executed Longer Than 5 Seconds| This Metric measures the number of slow SQL statements whose execution time exceeds 5 seconds.| ≥ 0| 1 minute|

## Objects {#object}

The collected Huawei Cloud RDS PostgreSQL object data structure can be viewed under 「Infrastructure - Custom」

```json
{
  "measurement": "huaweicloud_rds_postgresql",
  "tags": {
    "name"                   : "1d0c91561f4644daxxxxx68304b0520din01",
    "id"                     : "1d0c91561f4644dxxxxxxd68304b0520din01",
    "instance_name"          : "rds-df54-xxxx",
    "status"                 : "ACTIVE",
    "port"                   : "5432",
    "type"                   : "Single",
    "RegionId"               : "cn-north-4",
    "security_group_id"      : "d13ebb59-d4fe-xxxx-xxxx-c22bcea6f987",
    "switch_strategy"        : "xxx",
    "project_id"             : "c631f046252dxxxxxxxf253c62d48585",
    "time_zone"              : "UTC+08:00",
    "enable_ssl"             : "False",
    "charge_info.charge_mode": "postPaid",
    "engine"                 : "PostgreSQL",
    "engine_version"         : "14"
  },
  "fields": {
    "created_time"    : "2022-06-21T06:17:27+0000",
    "updated_time"    : "2022-06-21T06:20:03+0000",
    "alias"           : "xxx",
    "private_ips"     : "[\"192.xxx.x.144\"]",
    "public_ips"      : "[]",
    "datastore"       : "{database information}",
    "cpu"             : "2",
    "mem"             : "4",
    "volume"          : "{volume information}",
    "nodes"           : "[{master-slave instance information}]",
    "related_instance": "[]",
    "backup_strategy" : "{backup strategy}",
    "message"         : "{instance JSON data}"
  }
}
```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Note 1: The value of `tags.name` is the instance ID, serving as a unique identifier.
>
> Note 2: The following fields are serialized JSON strings:
>
> - `fields.message`
> - `fields.private_ips`
> - `fields.public_ips`
> - `fields.volume`
> - `fields.nodes`
> - `fields.related_instance`
> - `fields.backup_strategy`
>
> Note 3: The `type` field can take the values "Single", "Ha", "Replica", or "Enterprise", corresponding to single-instance, master-slave instance, read-only instance, and distributed instance (enterprise edition), respectively.