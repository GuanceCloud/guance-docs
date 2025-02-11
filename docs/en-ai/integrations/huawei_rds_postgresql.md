---
title: 'Huawei Cloud RDS PostgreSQL'
tags: 
  - Huawei Cloud
summary: 'The displayed metrics of Huawei Cloud RDS PostgreSQL include query performance, transaction throughput, concurrent connections, and data reliability. These metrics reflect the performance and reliability of RDS PostgreSQL in handling large-scale relational data storage and transaction processing.'
__int_icon: 'icon/huawei_rds_postgresql'
dashboard:

  - desc: 'Built-in views for Huawei Cloud RDS PostgreSQL'
    path: 'dashboard/en/huawei_rds_postgresql'

monitor:
  - desc: 'Monitor for Huawei Cloud RDS PostgreSQL'
    path: 'monitor/en/huawei_rds_postgresql'

---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud RDS PostgreSQL
<!-- markdownlint-enable -->

The displayed metrics of Huawei Cloud RDS PostgreSQL include query performance, transaction throughput, concurrent connections, and data reliability. These metrics reflect the performance and reliability of RDS PostgreSQL in handling large-scale relational data storage and transaction processing.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data from Huawei Cloud RDS PostgreSQL, install the corresponding collection script: Access the web service of Func and enter the 【Script Market】, then select 「Guance Integration (Huawei Cloud-RDS-PostgreSQL Collection)」(ID: `guance_huaweicloud_rds_postgresql`)

After clicking 【Install】, input the required parameters: Huawei Cloud AK, SK, and account name.

Click 【Deploy Startup Script】; the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Once the script is installed, find the script 「Guance Integration (Huawei Cloud-RDS-PostgreSQL Collection)」 under 「Development」 in Func, expand and modify this script. Find `collector_configs` and `monitor_configs`, and edit the contents of `region_projects`, changing the region and Project ID to the actual values, then click Save and Publish.

Additionally, view the corresponding automatic trigger configuration under 「Management / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

By default, we collect some configurations. For more details, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-rds-postgresql/){:target="_blank"}


### Verification

1. Confirm in 「Management / Automatic Trigger Configuration」 whether the corresponding tasks have been configured for automatic triggers, and check the task records and logs for any anomalies.
2. In the Guance platform, check 「Infrastructure / Custom」 to see if asset information exists.
3. In the Guance platform, check 「Metrics」 to see if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Huawei Cloud Cloud Monitoring, the default metric sets are as follows. You can collect more metrics through configuration. [Huawei Cloud Cloud Monitoring Metric Details](https://support.huaweicloud.com/usermanual-rds/rds_pg_06_0001.html){:target="_blank"}

### Instance Monitoring Metrics

RDS for PostgreSQL instance performance monitoring metrics are shown in the table below. For more metrics, refer to [Table 1](https://support.huaweicloud.com/usermanual-rds/rds_pg_06_0001.html){:target="_blank"}

| Metric ID                                       | Metric Name                                | Metric Description                                                     | Value Range           | Monitoring Period (Original Metric) |
| -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `swap_total_size`| Total Swap Size| This metric measures the total swap space. | ≥ 0 MB| 1 minute|
| `swap_usage`| Swap Usage Rate| This metric measures the usage rate of the swap space. | 0-100%| 1 minute|
| `rds005_bytes_out`| Network Output Throughput| This metric measures the average amount of traffic output from all network adapters per second, in bytes/second. | ≥ 0 bytes/s| 1 minute|
| `rds004_bytes_in`| Network Input Throughput| This metric measures the average amount of traffic input to all network adapters per second, in bytes/second. | ≥ 0 bytes/s| 1 minute|
| `rds003_iops`| IOPS| This metric measures the number of I/O requests processed by the current instance per unit time (average). | ≥ 0 counts/s| 1 minute|
| `read_count_per_second`| Read IOPS| This metric measures the number of read I/O requests processed by the current instance per unit time (average). | ≥ 0 counts/s| 1 minute|
| `write_count_per_second`| Write IOPS| This metric measures the number of write I/O requests processed by the current instance per unit time (average). | ≥ 0 counts/s| 1 minute|
| `rds042_database_connections`| Database Connections| The number of backend connections currently connected to the database. | ≥ 0 counts| 1 minute|
| `rds083_conn_usage`| Connection Usage Rate| This metric measures the percentage of used PgSQL connections out of the total connections. | 0-100%| 1 minute|
| `active_connections`| Active Connections| This metric measures the number of active database connections. | ≥ 0| 1 minute|
| `rds082_tps`| TPS| This metric measures the number of transactions executed per second, including committed and rolled back transactions. | ≥ 0 times/second| 1 minute|
| `rds046_replication_lag`| Replication Lag| The lag time of the replica. | ≥ 0 ms| 1 minute|
| `synchronous_replication_blocking_time`| Synchronous Replication Blocking Time| This metric measures the duration of replication blocking between the master and standby servers. | ≥ 0 s| 1 minute|
| `inactive_logical_replication_slot`| Inactive Logical Replication Slots| This metric measures the number of inactive logical replication slots in the current database. | ≥ 0| 1 minute|
| `rds041_replication_slot_usage`| Replication Slot Usage| The disk capacity occupied by replication slot files. | ≥ 0 MB| 1 minute|
| `rds043_maximum_used_transaction_ids`| Maximum Used Transaction IDs| The maximum used transaction ID. | ≥ 0 counts| 1 minute|
| `idle_transaction_connections`| Idle Transaction Connections| This metric measures the number of idle connections in the database. | ≥ 0| 1 minute|
| `oldest_transaction_duration`| Longest Transaction Duration| This metric measures the longest transaction duration in the current database. | ≥ 0 ms| 1 minute|
| `oldest_transaction_duration_2pc`| Longest Pending Transaction Duration| This metric measures the longest pending transaction duration in the current database. | ≥ 0 ms| 1 minute|
| `rds040_transaction_logs_usage`| Transaction Log Usage| The disk capacity occupied by transaction logs. | ≥ 0 MB| 1 minute|
| `lock_waiting_sessions`| Sessions Waiting for Locks| This metric measures the number of sessions currently in a blocked state. | ≥ 0| 1 minute|
| `slow_sql_log_min_duration_statement`| Number of Slow SQL Statements Executed Longer than log_min_duration_statement| This metric measures the number of slow SQL statements that take longer than the parameter `log_min_duration_statement`. The parameter value can be adjusted according to business needs. | ≥ 0| 1 minute|
| `slow_sql_one_second`| Number of SQL Statements Executed Longer than 1 Second| This metric measures the number of SQL statements that take longer than 1 second to execute. | ≥ 0| 1 minute|
| `slow_sql_three_second`| Number of SQL Statements Executed Longer than 3 Seconds| This metric measures the number of SQL statements that take longer than 3 seconds to execute. | ≥ 0| 1 minute|
| `slow_sql_five_second`| Number of SQL Statements Executed Longer than 5 Seconds| This metric measures the number of SQL statements that take longer than 5 seconds to execute. | ≥ 0| 1 minute|

## Objects {#object}

The collected object data structure of Huawei Cloud RDS PostgreSQL can be viewed in 「Infrastructure - Custom」

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
    "datastore"       : "{Database Information}",
    "cpu"             : "2",
    "mem"             : "4",
    "volume"          : "{Volume Information}",
    "nodes"           : "[{Master-Slave Instance Information}]",
    "related_instance": "[]",
    "backup_strategy" : "{Backup Strategy}",
    "message"         : "{Instance JSON Data}"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
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
> Note 3: The `type` field can take values "Single", "Ha", "Replica", or "Enterprise", corresponding to single-instance, master-slave instance, read-only instance, and distributed instance (enterprise edition), respectively.