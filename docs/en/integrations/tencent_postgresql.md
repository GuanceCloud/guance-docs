---
title: 'Tencent Cloud PostgreSQL'
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'
__int_icon: 'icon/tencent_postgresql'
dashboard:

  - desc: 'Tencent PostgreSQL Dashboard'
    path: 'dashboard/zh/tencent_postgresql'

monitor:
  - desc: 'Tencent PostgreSQL Monitor'
---
<!-- markdownlint-disable MD025 -->
# Tencent Cloud PostgreSQL
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）


To synchronize the monitoring data of PostgreSQL cloud resources, we install the corresponding collection script：「Guance Integration（Tencent Cloud - **PostgreSQLCollect**）」(ID：`guance_tencentcloud_postgresql`)

Click 【Install】 and enter the corresponding parameters: Aliyun AK, Aliyun account name.

Click [Deploy Startup Scripts], the system will automatically create the `Startup` script set and automatically configure the corresponding startup scripts.

You can see the corresponding auto-trigger configuration in "Management / Auto-trigger Configuration" after you turn it on. Click "Execute" to execute the task immediately without waiting for the regular time. Wait for a while, you can check the record and log of the executed task.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}

<!-- markdownlint-disable MD001 -->
### Verify
<!-- markdownlint-enable -->

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist.
2. On the Guance cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists.
3. On the Guance cloud platform, press 「Metrics」 to check whether monitoring data exists.

## Metric {#metric}
Configure Tencent Cloud COS monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Tencent Cloud Monitor Metrics Details](https://cloud.tencent.com/document/product/248/45105){:target="_blank"}

### Monitor Metric

| Metric name      | Metric        | Implication                        | Unit  | Dimensions              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| `Cpu`  | CPU Utilization     | Actual CPU utilization  | %    | resourceId |
| `DataFileSize`  | Data File Size  | Size of space occupied by data files   | GB | resourceId |
| `LogFileSize`  | Log File Size  | Size of log files  | MB | resourceId |
| `TempFileSize`  | Temporary File Size  | Size of temporary files  | times | resourceId |
| `StorageRate`  | Storage Utilization Rate  | Total storage space utilization, including temporary files, data files, log files, and other types of database files  | % | resourceId |
| `Qps`  | Queries per Second   | Average number of SQL statements executed per second  | times/s | resourceId |
| `Connections`  | Connections   | The current total number of connections to the database when initiating a collection against the database  | count | resourceId |
| `NewConnIn5s`  | New Connections in 5 Seconds  | Number of all connections established in the last 5 seconds when initiating a collection against a database  | times | resourceId |
| `ActiveConns` | Active Connections | Database transient active connection (non-idle connection) when initiating a collection against the database    | count | resourceId |
| `IdleConns` | Idle Connections | Instantaneous idle connections (idle connections) to the database queried when initiating a collection against the database  | count | resourceId |
| `Waiting`   | Waiting Sessions   | Number of sessions the database is waiting for when a capture is initiated against the database (status is waiting) | times/s | resourceId |
| `LongWaiting` | Long Waiting Sessions | Number of sessions where the database waited for more than 5 seconds during a collection cycle (status is waiting and the wait status was maintained for 5 seconds)  | count | resourceId |
| `IdleInXact`  | Idle Transactions  | The number of transactions in the database that are in idle state at the time the capture is initiated on the database | count | resourceId |
| `LongXact`   | Transactions with Execution Time Longer than 1 Second  | Number of transactions with an execution time of more than 1 second in a capture cycle  | count | resourceId |
| `Tps` | Transactions per Second | Average number of successful transactions executed per second (including rollbacks and commits)  | times/s | resourceId |
| `XactCommit` | Transactions Committed per Second  | Average number of transactions committed per second  | times/s | resourceId |
| `XactRollback`   | Transactions Rolled Back per Second  | Average number of transactions rolled back per second  | times/s | resourceId |
| `ReadWriteCalls` | Requests  | Total number of requests in a statistical cycle  | count | resourceId |
| `ReadCalls` | Read Requests  | Number of read requests in a statistical cycle  | count | resourceId |
| `WriteCalls` | Write Requests  | Number of write requests in a statistical cycle  | count | resourceId |
| `OtherCalls` | Other Requests  | Number of other requests (begin, create, non-DML, DDL, DQL operations) in a statistical cycle  | count | resourceId |
| `HitPercent` | Buffer Cache Hit Rate  | Hit rate of all SQL statements executed in a request cycle  | % | resourceId |
| `SqlRuntimeAvg` | Average Execution Latency  | Average execution latency of all SQL statements in a statistical cycle  | ms | resourceId |
| `SqlRuntimeMax` | Top 10 Longest Execution Latency  | Average execution latency of the top 10 longest SQLs in a statistical period  | ms | resourceId |
| `SqlRuntimeMin` | Top 10 Shortest Execution Latency  | Average execution latency of the top 10 shortest SQLs in a statistical cycle  | ms | resourceId |
| `SlowQueryCnt` | Number of Slow Queries  | Number of slow queries in a collection cycle  | count | resourceId |
| `LongQuery` | Number of SQL Queries with Execution Time Longer than 1 Second  | Number of SQL queries that take longer than 1s to execute when a collection is initiated against the database.  | count | resourceId |
| `2pc` | Number of 2PC Transactions  | Number of current 2PC transactions when initiating a collection against the database  | count | resourceId |
| `Long2pc` | Number of 2PC Transactions Not Committed for More than 5 Seconds  | Number of 2PC transactions with a current execution time of more than 5s when the database initiates a collection  | count | resourceId |
| `Deadlocks` | Number of Deadlocks  | Number of all deadlocks in an acquisition cycle  | count | resourceId |
| `Memory` | Memory Usage  | Memory Used  | MB | resourceId |
| `MemoryRate` | Memory Utilization Rate  | Memory Used Percentage of Total Occupancy  | % | resourceId |

## Object {#object}

Collected Tencent Cloud PostgreSQL object data structure, you can see the object data from "Infrastructure - Customize".

```json
{
  "measurement": "tencentcloud_postgresql",
  "tags": {
    "ClusterType" : "0",
    "InstanceId"  : "cmxxxx",
    "InstanceName": "test_01",
    "InstanceType": "1",
    "MongoVersion": "MONxxxx",
    "NetType"     : "1",
    "PayMode"     : "0",
    "ProjectId"   : "0",
    "RegionId"    : "ap-nanjing",
    "Status"      : "2",
    "VpcId"       : "vpc-nf6xxxxx",
    "Zone"        : "ap-nanjing-1",
    "name"        : "cmxxxx"
  },
  "fields": {
    "CloneInstances"   : "[]",
    "CreateTime"       : "2022-08-24 13:54:00",
    "DeadLine"         : "2072-08-24 13:54:00",
    "ReadonlyInstances": "[]",
    "RelatedInstance"  : "{Instance JSON data}",
    "ReplicaSets"      : "{Instance JSON data}",
    "StandbyInstances" : "[]",
    "message"          : "{Instance JSON data}",
  }
}
```

## Logging {#logging}

### Slow query statistics

#### Preconditions

> Tip 1: The code running of this script depends on the collection of PostgreSQL instance objects. If the custom collection of PostgreSQL object is not configured, the slow log script cannot collect slow log data.

<!-- markdownlint-disable MD024 -->
#### Installation script
<!-- markdownlint-enable -->

On the basis of the previous, you need to install another script for TencentCloud PostgreSQL slow query statistics log collection.

In "Manage/Script Marketplace", click and install the corresponding script package:


- 「Guance Integration (Tencent Cloud - PostgreSQL Slow Query Log Collection)  」(ID：`guance_tencentcloud_postgresql_slowlog`)


After data is synchronized, you can view the data in Logs of the Guance.

The following is an example of the reported data:

```json
{
  "measurement": "tencentcloud_postgre_slowlog",
  "tags": {
      "AppId": "137185",
      "ClientAddr": "",
      "DBCharset": "UTF8",
      "DBEngine": "postgresql",
      "DBEngineConfig": "",
      "DBInstanceClass": "cdb.pg.ts1.2g",
      "DBInstanceId": "postgres-3coh1xgm",
      "DBInstanceName": "Unnamed",
      "DBInstanceStatus": "running",
      "DBInstanceType": "primary",
      "DBInstanceVersion": "standard",
      "DBVersion": "10.17",
      "DatabaseName": "postgres",
      "PayType": "postpaid",
      "ProjectId": "0",
      "Region": "ap-shanghai",
      "RegionId": "ap-shanghai",
      "SubnetId": "subnet-bp2jqhcj",
      "Type": "TS85",
      "Uid": "4147",
      "UserName": "postgres",
      "VpcId": "vpc-kcpy",
      "Zone": "ap-shanghai-2",
      "name": "postgres-3coh1xgm"
  },
  "fields": {
      "NormalQuery": "select $1 from information_schema.tables where table_schema = $2 and table_name = $3",
      "AvgCostTime" : "101.013005",
      "CostTime"    : "101.013025",
      "FirstTime"   : "2021-07-27 03:12:01",
      "LastTime"    : "2021-07-27 03:12:01",
      "MaxCostTime" : "101.828125",
      "MinCostTime" : "101.828125",
      "message"     : "{Slow query JSON data}"
  }
}


```

> Note: The fields in tags and Fields may change with subsequent updates
>
> Tip 1: The tags value is supplemented by a custom object
>
> Tip 2: 'fields.message' is the JSON serialized string
>
> Tip 3: 'fields.Slowlog' records each record for all slow query details

### **Appendice**

#### TencentCloud-PostgreSQL「Region」

Please refer to the official Tencent documentation:

- [TencentCloud-MongoDB Region ID](https://cloud.tencent.com/document/api/409/16764)


#### TencentCloud-PostgreSQL「Slow Log Information Documentation」
Please refer to the official Tencent documentation:

- [TencentCloud-PostgreSQL Slow Log Details Documentation](https://cloud.tencent.com/document/api/409/60541)

