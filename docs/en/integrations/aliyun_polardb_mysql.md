---
title: 'Alibaba Cloud PolarDB MySQL'
tags: 
  - Alibaba Cloud
summary: 'Display of Alibaba Cloud PolarDB MySQL metrics, including CPU usage, memory hit rate, network traffic, connections, QPS, TPS, read-only node delay, etc.'
__int_icon: 'icon/aliyun_polardb'
dashboard:
  - desc: 'Built-in views for Alibaba Cloud PolarDB MySQL'
    path: 'dashboard/en/aliyun_polardb_mysql/'

monitor:
  - desc: 'Monitor for Alibaba Cloud PolarDB MySQL'
    path: 'monitor/en/aliyun_polardb_mysql/'    
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud PolarDB MySQL
<!-- markdownlint-enable -->

Display of Alibaba Cloud PolarDB MySQL metrics, including CPU usage, memory hit rate, network traffic, connections, QPS, TPS, read-only node delay, etc.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> We recommend deploying the GSE version.

<!-- markdownlint-disable MD024 -->
### Install Script
<!-- markdownlint-enable -->

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize monitoring data from Alibaba Cloud PolarDB MySQL, we install the corresponding collection script: 「Guance Integration (Alibaba Cloud-PolarDB MySQL Collection)」(ID: `guance_aliyun_polardb_mysql`)

After clicking 【Install】, enter the required parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect logs, enable the corresponding log collection script. If you need to collect billing data, enable the cloud billing collection script.

By default, we collect some configurations; see the metrics section for details.

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Verification

1. Confirm in 「Manage / Automatic Trigger Configuration」whether the corresponding tasks have been configured for automatic triggers. You can also check the task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure - Resource Catalog」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if the corresponding monitoring data is available.

## Metrics {#metric}
After configuring Alibaba Cloud Cloud Monitor, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitor Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                      | Metric Name            | Dimensions                  | Statistics              | Unit        |
| ---- | ------ | ------ | ---- | ---- |
| `cluster_active_sessions`      | Active Connections     | userId,clusterId,nodeId     | Average                 | count       |
| `cluster_blktag_utilization`   | **blktag** Utilization | userId,clusterId            | Average                 | %           |
| `cluster_connection_utilization` | Connection Utilization | userId,clusterId,nodeId     | Average,Maximum,Minimum | %           |
| `cluster_cpu_utilization`      | CPU Utilization        | userId,clusterId,nodeId     | Average                 | %           |
| `cluster_data_io`              | Storage Engine IO Throughput per Second | userId,clusterId,nodeId | Average                 | KB          |
| `cluster_data_iops`            | Storage Engine IO Operations per Second | userId,clusterId,nodeId | Average                 | countSecond |
| `cluster_direntry_utilization` | **direntry** Utilization | userId,clusterId            | Average                 | %           |
| `cluster_disk_utilization`     | Disk Utilization       | userId,clusterId            | Average                 | %           |
| `cluster_imci_datasize`        | **IMCI** Node Column Store Index Size | userId,clusterId,nodeId | Average                 | MB          |
| `cluster_imci_exememusage`     | **IMCI** Executor Memory Usage | userId,clusterId,nodeId | Average                 | Byte        |
| `cluster_imci_stmtsexepersec`  | **IMCI** SQL Queries per Second | userId,clusterId,nodeId | Average                 | count/s     |
| `cluster_imci_stmtsinqueue`    | **IMCI** SQL Statements in Queue | userId,clusterId,nodeId | Average                 | count       |
| `cluster_imci_tmpfileusedsize` | **IMCI** Temporary Table Size | userId,clusterId,nodeId | Average                 | Byte        |
| `cluster_inode_utilization`    | inode Utilization      | userId,clusterId            | Average                 | %           |
| `cluster_input_traffic`        | Network Input Traffic per Second | userId,clusterId,nodeId | Average,Maximum,Minimum | KByte/s     |
| `cluster_iops`                 | IO Operations per Second | userId,clusterId,nodeId | Average                 | countSecond |
| `cluster_iops_usage`           | IOPS Utilization       | userId,clusterId,nodeId     | Average,Maximum,Minimum | %           |
| `cluster_mem_hit_ratio`        | Memory Hit Rate        | userId,clusterId,nodeId     | Average                 | %           |
| `cluster_memory_utilization`   | Memory Utilization     | userId,clusterId,nodeId     | Average                 | %           |
| `cluster_mps`                  | Data Operations per Second | userId,clusterId,instanceId | Average,Maximum,Minimum | countSecond |
| `cluster_output_traffic`       | Network Output Traffic per Second | userId,clusterId,nodeId | Average,Maximum,Minimum | KByte/s     |
| `cluster_proxy_cpu_utilization` | Proxy CPU Utilization | userId,clusterId            | Average,Maximum,Minimum | %           |
| `cluster_qps`                  | Queries per Second     | userId,clusterId,nodeId     | Average                 | count       |
| `cluster_redo_write_rate`      | Redo Log Write Rate    | userId,clusterId,nodeId     | Average                 | Byte/s      |
| `cluster_replica_lag`          | Read-Only Node Replication Delay | userId,clusterId,instanceId | Average,Minimum,Maximum | seconds     |
| `cluster_slow_queries_ps`      | Slow Queries per Second | userId,clusterId,nodeId     | Average                 | countS      |
| `cluster_total_session`        | Total Current Connections | userId,clusterId,nodeId | Average,Maximum,Minimum | count       |
| `cluster_tps`                  | Transactions per Second | userId,clusterId,nodeId | Average                 | countS      |

## Objects {#object}

The collected Alibaba Cloud PolarDB MySQL object data structure can be viewed in 「Infrastructure - Resource Catalog」

```json
{
  "measurement": "aliyun_polardb",
  "tags": {
    "name"                : "pc-xxxx",
    "RegionId"            : "cn-hangzhou",
    "DBNodeNumber"        : "2",
    "DBType"              : "MySQL",
    "DBClusterId"         : "pc-xxxx",
    "ZoneId"              : "cn-hangzhou-i",
    "Engine"              : "POLARDB",
    "Category"            : "Normal",
    "DBClusterDescription": "pc-xxxx"
  },
  "fields": {
    "CreateTime"          : "2022-06-17T06:07:19Z",
    "DBClusterNetworkType": "VPC",
    "DBNodeClass"         : "polar.mysql.g1.tiny.c",
    "DBNodes"             : "{JSON data of node list}",
    "DBVersion"           : "8.0",
    "Database"            : "[JSON data of database details]",
    "ExpireTime"          : "",
    "LockMode"            : "Unlock",
    "PayType"             : "Postpaid",
    "Tags"                : "{"Tag": []}",
    "VpcId"               : "vpc-bp16f7**********3p3",
    "message"             : "{JSON data of instance}"
  }
}

```

## Logs {#logging}

### Slow Query Statistics

<!-- markdownlint-disable MD024 -->
#### Prerequisites
<!-- markdownlint-enable -->

> Note: This script depends on the collection of PolarDB instance objects. If PolarDB custom object collection is not configured, the slow log script cannot collect slow log data.

<!-- markdownlint-disable MD024 -->
#### Install Script
<!-- markdownlint-enable -->

In addition to the previous setup, you need to install another script for collecting **PolarDB slow query statistics logs**.

In 「Manage / Script Market」, click and install the corresponding script package:

- 「Guance Integration (Alibaba Cloud - PolarDB Slow Query Statistics Log Collection)」(ID: `guance_aliyun_polardb_slowlog`)

After data synchronization, you can view the data in the 「Logs」section of Guance.

Example of reported data:

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
    "message"             : "{JSON log data}"
  }
}

```

Field descriptions:

| Field                   | Type | Description                       |
| :--------------------- | :--- | :--------------------------------- |
| `MaxExecutionTime`     | Long | Maximum execution duration, in seconds |
| `TotalExecutionTimes`  | Long | Total execution duration, in seconds |
| `TotalLockTimes`       | Long | Total lock duration, in seconds     |
| `MaxLockTime`          | Long | Maximum lock duration, in seconds   |
| `ReturnMaxRowCount`    | Long | Maximum returned row count         |
| `ReturnTotalRowCounts` | Long | Total returned row count           |
| `ParseMaxRowCount`     | Long | Maximum parsed row count           |
| `ParseTotalRowCounts`  | Long | Total parsed row count             |
| `TotalExecutionCounts` | Long | Total execution count              |

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Note: `fields.message` is a JSON serialized string.

### Slow Query Details

<!-- markdownlint-disable MD024 -->
#### Prerequisites
<!-- markdownlint-enable -->

> Note: This script depends on the collection of PolarDB instance objects. If PolarDB custom object collection is not configured, the slow log script cannot collect slow log data.

<!-- markdownlint-disable MD024 -->
#### Install Script
<!-- markdownlint-enable -->

In addition to the previous setup, you need to install another script for collecting **PolarDB slow query detail logs**.

In 「Manage / Script Market」, click and install the corresponding script package:

- 「Guance Integration (Alibaba Cloud - PolarDB Slow Query Detail Log Collection)」(ID: `guance_aliyun_polardb_slowlog_record`)

After data synchronization, you can view the data in the 「Logs」section of Guance.

Configure [Cloud Database PolarDB Slow Query Details](https://func.guance.com/doc/script-market-guance-aliyun-polardb-slowlog-record/){:target="_blank"}

Example of reported data:

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
    "message"           : "{JSON log data}"
  }
}

```

Field descriptions:

| Field                 | Type   | Description                                                  |
| :------------------- | :----- | :----------------------------------------------------------- |
| `QueryTimes`         | Long   | SQL execution duration, in seconds                           |
| `QueryTimeMS`        | Long   | Query time, in milliseconds                                  |
| `ReturnRowCounts`    | Long   | Returned row count                                           |
| `ParseRowCounts`     | Long   | Parsed row count                                             |
| `ExecutionStartTime` | String | SQL start execution time. Format: YYYY-MM-DDThh:mmZ (UTC time) |
| `LockTimes`          | Long   | SQL lock duration, in seconds                                 |

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Note: `fields.message` is a JSON serialized string.