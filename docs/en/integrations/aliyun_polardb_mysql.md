---
title: 'Alibaba Cloud PolarDB MySQL'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud PolarDB MySQL Metrics display, including CPU usage, memory hit rate, network traffic, connection count, QPS, TPS, read-only node delay, etc.'
__int_icon: 'icon/aliyun_polardb'
dashboard:
  - desc: 'Alibaba Cloud PolarDB MySQL Built-in Views'
    path: 'dashboard/en/aliyun_polardb_mysql/'

monitor:
  - desc: 'Alibaba Cloud PolarDB MySQL Monitors'
    path: 'monitor/en/aliyun_polardb_mysql/'    
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud PolarDB MySQL
<!-- markdownlint-enable -->

Alibaba Cloud PolarDB MySQL Metrics display, including CPU usage, memory hit rate, network traffic, connection count, QPS, TPS, read-only node delay, etc.

## Configuration {#config}

### Install Func

It is recommended to activate <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func by yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

> GSE version deployment is recommended.

### Install Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize Alibaba Cloud PolarDB MySQL monitoring data, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Alibaba Cloud-PolarDB Collection)" (ID: `guance_aliyun_polardb`)

After clicking 【Install】, input the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

Once activated, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】to immediately execute it once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

> If you want to collect the corresponding logs, you need to enable the corresponding log collection script. If you want to collect bills, you need to enable the cloud bill collection script.


We default to collecting some configurations, details see the metrics section

[Configure Custom Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Verification

1. Confirm in "Manage/Automatic Trigger Configuration" whether the corresponding task has an automatic trigger configuration. You can also check the corresponding task records and logs for any anomalies.
2. In the <<< custom_key.brand_name >>> platform, check if there are asset information under "Infrastructure / Custom".
3. In the <<< custom_key.brand_name >>> platform, check if there are corresponding monitoring data under "Metrics".

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitor, the default measurement set is as follows. You can collect more metrics through configuration [Alibaba Cloud Cloud Monitor Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                      | Metric Name            | Dimensions                  | Statistics              | Unit        |
| ---- | ------ | ------ | ---- | ---- |
| `cluster_active_sessions`      | Active Connections     | userId,clusterId,nodeId     | Average                 | count       |
| `cluster_blktag_utilization`   | **blktag** Utilization | userId,clusterId            | Average                 | %           |
| `cluster_connection_utilization` | Connection Utilization | userId,clusterId,nodeId     | Average,Maximum,Minimum | %           |
| `cluster_cpu_utilization`      | CPU Utilization        | userId,clusterId,nodeId     | Average                 | %           |
| `cluster_data_io`              | Storage Engine IO Throughput per Second | userId,clusterId,nodeId     | Average                 | KB          |
| `cluster_data_iops`            | Storage Engine IO Operations per Second | userId,clusterId,nodeId     | Average                 | countSecond |
| `cluster_direntry_utilization` | **direntry** Utilization | userId,clusterId            | Average                 | %           |
| `cluster_disk_utilization`     | Disk Utilization       | userId,clusterId            | Average                 | %           |
| `cluster_imci_datasize`        | **IMCI** Node Column Store Index Size | userId,clusterId,nodeId     | Average                 | MB          |
| `cluster_imci_exememusage`     | **IMCI** Executor Memory Usage | userId,clusterId,nodeId     | Average                 | Byte        |
| `cluster_imci_stmtsexepersec`  | **IMCI** Queries Per Second | userId,clusterId,nodeId     | Average                 | count/s     |
| `cluster_imci_stmtsinqueue`    | **IMCI** SQLs in Scheduler Queue | userId,clusterId,nodeId     | Average                 | count       |
| `cluster_imci_tmpfileusedsize` | **IMCI** Executor Temporary Table Size | userId,clusterId,nodeId     | Average                 | Byte        |
| `cluster_inode_utilization`    | inode Utilization      | userId,clusterId            | Average                 | %           |
| `cluster_input_traffic`        | Network Input Traffic Per Second | userId,clusterId,nodeId     | Average,Maximum,Minimum | KByte/s     |
| `cluster_iops`                 | IO Operations Per Second | userId,clusterId,nodeId     | Average                 | countSecond |
| `cluster_iops_usage`           | IOPS Utilization       | userId,clusterId,nodeId     | Average,Maximum,Minimum | %           |
| `cluster_mem_hit_ratio`        | Memory Hit Ratio       | userId,clusterId,nodeId     | Average                 | %           |
| `cluster_memory_utilization`   | Memory Utilization     | userId,clusterId,nodeId     | Average                 | %           |
| `cluster_mps`                  | Data Operations Per Second | userId,clusterId,instanceId | Average,Maximum,Minimum | countSecond |
| `cluster_output_traffic`       | Network Output Traffic Per Second | userId,clusterId,nodeId     | Average,Maximum,Minimum | KByte/s     |
| `cluster_proxy_cpu_utilization` | Proxy CPU Utilization | userId,clusterId            | Average,Maximum,Minimum | %           |
| `cluster_qps`                  | Queries Per Second     | userId,clusterId,nodeId     | Average                 | count       |
| `cluster_redo_write_rate`      | Redo Log Write Rate    | userId,clusterId,nodeId     | Average                 | Byte/s      |
| `cluster_replica_lag`          | Replica Lag           | userId,clusterId,instanceId | Average,Minimum,Maximum | seconds     |
| `cluster_slow_queries_ps`      | Slow Queries Per Second | userId,clusterId,nodeId     | Average                 | countS      |
| `cluster_total_session`        | Current Total Connections | userId,clusterId,nodeId     | Average,Maximum,Minimum | count       |
| `cluster_tps`                  | Transactions Per Second | userId,clusterId,nodeId     | Average                 | countS      |

## Objects {#object}

Collected Alibaba Cloud PolarDB MySQL object data structure, which can be seen in "Infrastructure - Custom" objects data

```json
{
  "measurement": "aliyun_polardb",
  "tags": {
    "name"                : "pc-xxxx",
    "RegionId"            : "cn-hangzhou",
    "VpcId"               : "vpc-xxxx",
    "DBNodeNumber"        : "2",
    "PayType"             : "Postpaid",
    "DBType"              : "MySQL",
    "LockMode"            : "Unlock",
    "DBVersion"           : "8.0",
    "DBClusterId"         : "pc-xxxx",
    "DBClusterNetworkType": "VPC",
    "ZoneId"              : "cn-hangzhou-i",
    "Engine"              : "POLARDB",
    "Category"            : "Normal",
    "DBClusterDescription": "pc-xxxx",
    "DBNodeClass"         : "polar.mysql.x4.medium"
  },
  "fields": {
    "DBNodes"   : "{JSON Data of Node List}",
    "Database"  : "[JSON Data of Database Details]",
    "ExpireTime": "",
    "CreateTime": "2022-06-17T06:07:19Z",
    "message"   : "{Instance JSON Data}"
  }
}

```

## Logs {#logging}

### Slow Query Statistics

<!-- markdownlint-disable MD024 -->

#### Prerequisites

<!-- markdownlint-enable -->

> Note: The code execution of this script depends on the collection of PolarDB instance objects. If the custom object collection for PolarDB is not configured, the slow log script cannot collect slow log data.

<!-- markdownlint-disable MD024 -->

#### Install Script

<!-- markdownlint-enable -->

Based on the previous setup, you need to install another script corresponding to the **PolarDB Slow Query Statistics Log Collection**

In "Manage / Script Market", click and install the corresponding script package:

- "<<< custom_key.brand_name >>> Integration (Alibaba Cloud - PolarDB Slow Query Statistics Log Collection)" (ID: `guance_aliyun_polardb_slowlog`)

After the data is synchronized normally, you can view the data in the "Logs" section of <<< custom_key.brand_name >>>.

The reported data example is as follows:

```json
{
  "measurement": "aliyun_polardb_slowlog",
  "tags": {
    "DBName"  : "PolarDB_MySQL",
    "DBNodeId": "pi-***************"
  },
  "fields": {
    "CreateTime"          : "2023-05-22Z",
    "MaxExecutionTime"    : 60,
    "MaxLockTime"         : 1,
    "ParseMaxRowCount"    : 1,
    "ParseTotalRowCounts" : 2,
    "ReturnMaxRowCount"   : 3,
    "ReturnTotalRowCounts": 1,
    "SQLHASH"             : "U2FsdGVkxxxx",
    "SQLText"             : "select id,name from tb_table",
    "TotalExecutionCounts": 2,
    "TotalExecutionTimes" : 2,
    "TotalLockTimes"      : 1,
    "message"             : "{Log JSON Data}"
  }
}

```

Descriptions of some parameters are as follows:

| Field                   | Type | Description                         |
| :--------------------- | :--- | :---------------------------------- |
| `MaxExecutionTime`     | Long | Execution duration (maximum value), unit: seconds |
| `TotalExecutionTimes`  | Long | Execution duration (total value), unit: seconds   |
| `TotalLockTimes`       | Long | Lock duration (total value), unit: seconds       |
| `MaxLockTime`          | Long | Lock duration (maximum value), unit: seconds     |
| `ReturnMaxRowCount`    | Long | Returned SQL row count (maximum value)           |
| `ReturnTotalRowCounts` | Long | Returned SQL row count (total value)             |
| `ParseMaxRowCount`     | Long | Parsed SQL row count (maximum value)            |
| `ParseTotalRowCounts`  | Long | Parsed SQL row count (total value)              |
| `TotalExecutionCounts` | Long | Execution counts (total value)                  |

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Note: `fields.message` is a JSON serialized string

### Slow Query Details

<!-- markdownlint-disable MD024 -->

#### Prerequisites

<!-- markdownlint-enable -->

> Note: The code execution of this script depends on the collection of PolarDB instance objects. If the custom object collection for PolarDB is not configured, the slow log script cannot collect slow log data.

<!-- markdownlint-disable MD024 -->

#### Install Script

<!-- markdownlint-enable -->

Based on the previous setup, you need to install another script corresponding to the **PolarDB Slow Query Detail Log Collection**

In "Manage / Script Market", click and install the corresponding script package:

- "<<< custom_key.brand_name >>> Integration (Alibaba Cloud - PolarDB Slow Query Detail Log Collection)" (ID: `guance_aliyun_polardb_slowlog_record`)

After the data is synchronized normally, you can view the data in the "Logs" section of <<< custom_key.brand_name >>>.

Configuration [Cloud Database PolarDB Slow Query Details](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-polardb-slowlog-record/){:target="_blank"}

The reported data example is as follows:

```json
{
  "measurement": "aliyun_polardb_slowlog_record",
  "tags": {
    "DBName"     : "PolarDB_MySQL",
    "DBNodeId"   : "pi-***************",
    "HostAddress": "testdb[testdb] @ [100.**.**.242]"
  },
  "fields": {
    "SQLText"           : "select id,name from tb_table",
    "ExecutionStartTime": "2021-04-07T03:47Z",
    "QueryTimes"        : 20,
    "ReturnRowCounts"   : 0,
    "ParseRowCounts"    : 0,
    "LockTimes"         : 0,
    "QueryTimeMS"       : 100,
    "message"           : "{Log JSON Data}"
  }
}

```

Descriptions of some parameters are as follows:

| Field                 | Type   | Description                                                  |
| :------------------- | :----- | :---------------------------------------------------------- |
| `QueryTimes`         | Long   | SQL execution duration, unit: seconds                        |
| `QueryTimesMS`       | Long   | Query time. Unit: milliseconds                              |
| `ReturnRowCounts`    | Long   | Return row count                                            |
| `ParseRowCounts`     | Long   | Parse row count                                             |
| `ExecutionStartTime` | String | SQL start execution time. Format YYYY-MM-DDThh:mmZ (UTC time) |
| `LockTimes`          | Long   | SQL lock duration, unit: seconds                            |

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Note: `fields.message` is a JSON serialized string