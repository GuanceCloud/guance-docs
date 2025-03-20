---
title: 'Huawei Cloud RDS PostgreSQL'
tags: 
  - Huawei Cloud
summary: 'Collect Metrics data from Huawei Cloud RDS PostgreSQL'
__int_icon: 'icon/huawei_rds_postgresql'
dashboard:

  - desc: 'Built-in views for Huawei Cloud RDS PostgreSQL'
    path: 'dashboard/en/huawei_rds_postgresql'

monitor:
  - desc: 'Monitor for Huawei Cloud RDS PostgreSQL'
    path: 'monitor/en/huawei_rds_postgresql'

---

Collect Metrics data from Huawei Cloud RDS PostgreSQL

## Configuration {#config}

### Install Func

It is recommended to enable Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func by yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data of Huawei Cloud RDS PostgreSQL, we install the corresponding collection script: access the web service of func and enter the 【Script Market】, select 「Guance Integration (Huawei Cloud-RDS-PostgreSQL Collection)」(ID: `guance_huaweicloud_rds_postgresql`)

After clicking 【Install】, input the corresponding parameters: Huawei Cloud AK, SK, Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script automatically.

After the script is installed, find the script 「Guance Integration (Huawei Cloud-RDS-PostgreSQL Collection)」in the "Development" section of Func, unfold and modify this script. Locate `collector_configs` and `monitor_configs`, and edit the content of `region_projects`. Change the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.

### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding task has the corresponding automatic trigger configuration. You can also check the task records and logs to see if there are any anomalies.
2. On the Guance platform, in 「Infrastructure - Resource Catalog」, check if there is asset information.
3. On the Guance platform, in 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}

The Metrics data of Huawei Cloud RDS PostgreSQL can be collected through configuration. For more Metrics, refer to [Huawei Cloud RDS PostgreSQL Metrics Details](https://support.huaweicloud.com/usermanual-rds/rds_pg_06_0001.html){:target="_blank"}

### Instance Monitoring Metrics

RDS for PostgreSQL instance performance monitoring metrics are shown in the following table. For more metrics, refer to [Table 1](https://support.huaweicloud.com/usermanual-rds/rds_pg_06_0001.html){:target="_blank"}

| Metric ID                                       | Metric Name                                | Metric Meaning                                                     | Value Range           | Monitoring Period (Original Metric) |
| -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `swap_total_size`| Total swap area size| This metric counts the total swap space.| ≥ 0 MB| 1 minute|
| `swap_usage`| Swap area usage rate| This metric counts the usage rate of the swap area.| 0-100%| 1 minute|
| `rds005_bytes_out`| Network output throughput| This metric counts the average traffic per second output from all network adapters of the measurement object, in bytes/second.| ≥ 0 bytes/s| 1 minute|
| `rds004_bytes_in`| Network input throughput| This metric counts the average traffic per second input to all network adapters of the measurement object, in bytes/second.| ≥ 0 bytes/s| 1 minute|
| `rds003_iops`| IOPS| This metric counts the number of I/O requests processed by the current instance within a unit of time (average).| ≥ 0 counts/s| 1 minute|
| `read_count_per_second`| Read IOPS| This metric counts the number of read I/O requests processed by the current instance within a unit of time (average).| ≥ 0 counts/s| 1 minute|
| `write_count_per_second`| Write IOPS| This metric counts the number of write I/O requests processed by the current instance within a unit of time (average).| ≥ 0 counts/s| 1 minute|
| `rds042_database_connections`| Database connections| The number of backends currently connected to the database.| ≥ 0 counts| 1 minute|
| `rds083_conn_usage`| Connection usage rate| This metric counts the percentage of used PgSQL connections out of the total connection count.| 0-100%| 1 minute|
| `active_connections`| Active connections| This metric counts the current active connections of the database.| ≥ 0| 1 minute|
| `rds082_tps`| TPS| This metric counts the number of transactions executed per second, including committed and rolled back ones.| ≥ 0 times/second| 1 minute|
| `rds046_replication_lag`| Replication lag| Replica lag delay.| ≥ 0 ms| 1 minute|
| `synchronous_replication_blocking_time`| Synchronous replication blocking time| This metric gets the duration of synchronous replication block between the master and standby.| ≥ 0 s| 1 minute|
| `inactive_logical_replication_slot`| Number of inactive logical replication slots| This metric counts the number of inactive logical replication slots present in the current database.| ≥ 0| 1 minute|
| `rds041_replication_slot_usage`| Replication slot usage| Disk capacity occupied by the replication slot file.| ≥ 0 MB| 1 minute|
| `rds043_maximum_used_transaction_ids`| Maximum used transaction IDs| Maximum used transaction ID.| ≥ 0 counts| 1 minute|
| `idle_transaction_connections`| Idle transaction connections| This metric counts the current idle connections of the database.| ≥ 0| 1 minute|
| `oldest_transaction_duration`| Longest transaction lifetime| This metric counts the longest transaction lifetime present in the current database.| ≥ 0 ms| 1 minute|
| `oldest_transaction_duration_2pc`| Longest pending transaction lifetime| This metric counts the longest pending transaction lifetime present in the current database.| ≥ 0 ms| 1 minute|
| `rds040_transaction_logs_usage`| Transaction log usage| Disk capacity occupied by the transaction log.| ≥ 0 MB| 1 minute|
| `lock_waiting_sessions`| Sessions waiting for locks| This metric counts the number of sessions currently in a blocked state.| ≥ 0| 1 minute|
| `slow_sql_log_min_duration_statement`| Number of SQLs executed longer than log_min_duration_statement| This metric counts the number of slow SQLs with execution time greater than the parameter log_min_duration_statement, which can be changed according to business needs.| ≥ 0| 1 minute|
| `slow_sql_one_second`| Number of SQLs executed longer than 1s| This metric counts the number of slow SQLs with execution time over 1 second.| ≥ 0| 1 minute|
| `slow_sql_three_second`| Number of SQLs executed longer than 3s| This metric counts the number of slow SQLs with execution time over 3 seconds.| ≥ 0| 1 minute|
| `slow_sql_five_second`| Number of SQLs executed longer than 5s| This metric counts the number of slow SQLs with execution time over 5 seconds.| ≥ 0| 1 minute|

## Objects {#object}

The object data structure of Huawei Cloud RDS PostgreSQL collected can be seen in 「Infrastructure - Resource Catalog」

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
    "nodes"           : "[{Primary Standby Instance Information}]",
    "related_instance": "[]",
    "backup_strategy" : "{Backup Strategy}",
    "message"         : "{Instance JSON Data}"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used as unique identification.
>
> Tip 2: The following fields are strings serialized in JSON:
>
> - `fields.message`
> - `fields.private_ips`
> - `fields.public_ips`
> - `fields.volume`
> - `fields.nodes`
> - `fields.related_instance`
> - `fields.backup_strategy`
>
> Tip 3: The value of `type` can be "Single", "Ha", "Replica", or "Enterprise", corresponding to single-instance, primary-standby instance, read-only instance, and distributed instance (enterprise edition), respectively.