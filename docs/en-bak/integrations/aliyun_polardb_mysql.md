---
title: 'Aliyun PolarDB MySQL'
tags: 
  - Alibaba Cloud
summary: 'Aliyun PolarDB MySQL Metrics Display, including CPU usage, memory hit rate, network traffic, connection count, QPS (Queries Per Second), TPS (Transactions Per Second), and read-only node latency.'
__int_icon: icon/aliyun_polardb_mysql
dashboard:
  - desc: 'Aliyun PolarDB MySQL Monitoring View'
    path: 'dashboard/en/aliyun_polardb_mysql/'

monitor:
  - desc: 'Aliyun PolarDB MySQL Monitor'
    path: 'monitor/en/aliyun_polardb_mysql/'    
---

<!-- markdownlint-disable MD025 -->
# Aliyun PolarDB MySQL
<!-- markdownlint-enable -->

Aliyun PolarDB MySQL Metrics Display, including CPU usage, memory hit rate, network traffic, connection count, QPS (Queries Per Second), TPS (Transactions Per Second), and read-only node latency.

## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> Recommend deploying GSE (Game Server Engine) edition translation.

### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of PolarDB MySQL cloud resources, we install the corresponding collection script：「Guance Integration（Aliyun -PolarDB MySQL Collect）」(ID：`guance_aliyun_polardb_mysql`)

Click "Install" and enter the corresponding parameters: Aliyun AK, Aliyun account name.。

tap "Deploy startup Script"，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click "Run"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.



We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure - Resource Catalog」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Ali Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Aliyun Monitor Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_ecs_dashboard/ecs){:target="_blank"}

| Metric Id                      | Metric Name            | Dimensions                  | Statistics              | Unit        |
| ---- | ------ | ------ | ---- | ---- |
| `cluster_active_sessions`        | Active connection number             | userId,clusterId,nodeId     | Average                 | count       |
| `cluster_blktag_utilization`     | **blktag Usage**           | userId,clusterId            | Average                 | %           |
| `cluster_connection_utilization` | Connection number utilization           | userId,clusterId,nodeId     | Average,Maximum,Minimum | %           |
| `cluster_cpu_utilization`        | CPU Usage              | userId,clusterId,nodeId     | Average                 | %           |
| `cluster_data_io`                | Store engine IO throughput per second   | userId,clusterId,nodeId     | Average                 | KB          |
| `cluster_data_iops`              | Store engine IO per second     | userId,clusterId,nodeId     | Average                 | countSecond |
| `cluster_direntry_utilization`   | **direntry usage**       | userId,clusterId            | Average                 | %           |
| `cluster_disk_utilization`       | Disk usage             | userId,clusterId            | Average                 | %           |
| `cluster_imci_datasize`          | **IMCI** nodes store the amount of index storage | userId,clusterId,nodeId     | Average                 | MB          |
| `cluster_imci_exememusage`       | The **IMCI** executor uses the amount of memory   | userId,clusterId,nodeId     | Average                 | Byte        |
| `cluster_imci_stmtsexepersec`    | **IMCI** queries SQL per second    | userId,clusterId,nodeId     | Average                 | count/s     |
| `cluster_imci_stmtsinqueue`      | **IMCI** schedules the amount of SQL in the queue  | userId,clusterId,nodeId     | Average                 | count       |
| `cluster_imci_tmpfileusedsize`   | **IMCI** executor temporary table size   | userId,clusterId,nodeId     | Average                 | Byte        |
| `cluster_inode_utilization`      | inode usage            | userId,clusterId            | Average                 | %           |
| `cluster_input_traffic`          | Network input traffic per second       | userId,clusterId,nodeId     | Average,Maximum,Minimum | KByte/s     |
| `cluster_iops`                   | IO times per second             | userId,clusterId,nodeId     | Average                 | countSecond |
| `cluster_iops_usage`             | IOPS Usage             | userId,clusterId,nodeId     | Average,Maximum,Minimum | %           |
| `cluster_mem_hit_ratio`          | Memory hit rate             | userId,clusterId,nodeId     | Average                 | %           |
| `cluster_memory_utilization`     | Memory usage             | userId,clusterId,nodeId     | Average                 | %           |
| `cluster_mps`                    | Data operations per second         | userId,clusterId,instanceId | Average,Maximum,Minimum | countSecond |
| `cluster_output_traffic`         | Network output traffic per second       | userId,clusterId,nodeId     | Average,Maximum,Minimum | KByte/s     |
| `cluster_proxy_cpu_utilization`  | ProxyCPU usage         | userId,clusterId            | Average,Maximum,Minimum | %           |
| `cluster_qps`                    | Queries per second           | userId,clusterId,nodeId     | Average                 | count       |
| `cluster_redo_write_rate`        | redo log write rate       | userId,clusterId,nodeId     | Average                 | Byte/s      |
| `cluster_replica_lag`            | Read-only node replication latency       | userId,clusterId,instanceId | Average,Minimum,Maximum | seconds     |
| `cluster_slow_queries_ps`        | Slow queries per second         | userId,clusterId,nodeId     | Average                 | countS      |
| `cluster_total_session`          | Current total number of connections           | userId,clusterId,nodeId     | Average,Maximum,Minimum | count       |
| `cluster_tps`                    | Transactions per second             | userId,clusterId,nodeId     | Average                 | countS      |

## Object {#object}

The collected Aliyun PolarDB object data structure can be viewed in 「Infrastructure - Resource Catalog」 under the object data.

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
    "DBNodes"             : "{Node List JSON Data}",
    "DBVersion"           : "8.0",
    "Database"            : "[Database Details JSON Data]",
    "ExpireTime"          : "",
    "LockMode"            : "Unlock",
    "PayType"             : "Postpaid",
    "Tags"                : "{"Tag": []}",
    "VpcId"               : "vpc-bp16f7**********3p3",
    "message"             : "{Instance JSON data}"
  }
}

```

## Log {#logging}

### Slow query statistics

#### The prerequisite for slow query statistics

> Tip: The code running this script depends on PolarDB instance object collection. If PolarDB custom object collection is not configured, the slow log script cannot collect slow log data

#### Install scripts

On top of the previous requirements, an installation script for **PolarDB Slow Query Statistics Log Collection** is needed.

Click and install the corresponding script package in "Management / Script Market."

- 「Guance Integration（Aliyun - PolarDB Slow query statistical log Collect）」(ID：`guance_aliyun_polardb_slowlog`)

Once the data is successfully synchronized, you can view it in the "Logs" section of Observing Cloud.

Examples of reported data are as follows：

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
    "message"             : "{Log JSON data}"
  }
}

```

Some parameters are explained as follows:

| Field              | Type | Description              |
| :--------------------- | :--- | :--------------------------- |
| `MaxExecutionTime`     | Long | Execution time (Max) in seconds |
| `TotalExecutionTimes`  | Long | Execution time (total) in seconds   |
| `TotalLockTimes`       | Long | Lock duration (total) in seconds   |
| `MaxLockTime`          | Long | Lock duration (Max), in seconds |
| `ReturnMaxRowCount`    | Long | Number of SQL rows returned (Max)      |
| `ReturnTotalRowCounts` | Long | Number of SQL rows returned (total)        |
| `ParseMaxRowCount`     | Long | Number of SQL rows parsed (Max)      |
| `ParseTotalRowCounts`  | Long | Number of SQL rows parsed (total)        |
| `TotalExecutionCounts` | Long | Number of Executions (Total)             |

> *Note: The fields in 'tags' and' fields' are subject to change*
>
> Hint: 'fields.message' is a JSON serialized string

### Slow query details

#### Prerequisite for slow query of details

> Tip：This script's code execution relies on PolarDB instance object collection. If PolarDB custom object collection is not configured, the slow log script will not be able to collect slow log data.

#### Slow query details installation script

On top of the previous requirements, an installation script for **PolarDB Slow Query Detailed Log Collection** is needed.

Click and install the corresponding script package in "Management / Script Market."

- 「Guance Integration（Aliyun -PolarDB Slow query detail log Collect）」(ID：`guance_aliyun_polardb_slowlog_record`)

After data synchronization is successfully completed, you can view the data in the "Logs" section of the Guance platform.

Configuration [Cloud database PolarDB slow Query Details](https://func.guance.com/doc/script-market-guance-aliyun-polardb-slowlog-record/){:target="_blank"}

The reported data example is as follows：

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
    "message"           : "{Log JSON data}"
  }
}

```

The partial parameter explanations are as follows：

| Field                | Type   | Description                                                  |
| :------------------- | :----- | :----------------------------------------------------------- |
| `QueryTimes`         | Long   | SQL execution time, in seconds                               |
| `QueryTimesMS`       | Long   | Query time. milliseconds                                     |
| `ReturnRowCounts`    | Long   | Returns the number of rows                                   |
| `ParseRowCounts`     | Long   | Number of parsed lines                                       |
| `ExecutionStartTime` | String | The time at which SQL execution begins. The format is YYYY-MM-DDThh:mmZ (UTC time) |
| `LockTimes`          | Long   | SQL lock duration in seconds                                 |

> *Note: The fields in 'tags' and' fields' are subject to change*
>
> Note: 'fields.message' is a JSON serialized string

