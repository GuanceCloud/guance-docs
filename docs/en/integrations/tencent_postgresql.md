---
title: 'Tencent Cloud PostgreSQL'
tags: 
  - Tencent Cloud
summary: 'Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/tencent_postgresql'
dashboard:

  - desc: 'Tencent Cloud PostgreSQL built-in views'
    path: 'dashboard/en/tencent_postgresql'

monitor:
  - desc: 'Tencent Cloud PostgreSQL monitor'
    path: 'monitor/en/tencent_postgresql'


---
<!-- markdownlint-disable MD025 -->
# Tencent Cloud PostgreSQL
<!-- markdownlint-enable -->

Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install PostgreSQL collection script

> Note: Please prepare a qualified Tencent Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize PostgreSQL monitoring data, we install the corresponding collection script: "Guance Integration (Tencent Cloud-PostgreSQL Collection)" (ID: `guance_tencentcloud_postgresql`)

After clicking 【Install】, enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Start Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding start script.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】, it can be executed immediately without waiting for the regular time. After a while, you can view the execution task records and corresponding logs.

> If you want to collect the corresponding logs, you also need to enable the corresponding log collection script. If you want to collect bills, you need to enable the cloud bill collection script.

We default to collecting some configurations, for more details see [Configuration Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configuration, and check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Tencent Cloud Cloud Monitoring Metric Details](https://cloud.tencent.com/document/product/248/45105){:target="_blank"}

### Monitoring Metrics

| Metric English Name      | Metric Chinese Name             | Meaning                        | Unit  | Dimensions              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| `Cpu` | CPU Utilization     | Actual CPU utilization  | %    | resourceId |
| `DataFileSize` | Data File Size  | Data file occupied space size   | GB | resourceId |
| `LogFileSize` | Log File Size  | WAL log file occupied space size  | MB | resourceId |
| `TempFileSize` | Temporary File Size  | Size of temporary files  | times | resourceId |
| `StorageRate` | Storage Space Usage  | Total storage space usage rate, including temporary files, data files, log files, and other types of database files  | % | resourceId |
| `Qps` | Queries Per Second   | Average number of SQL statements executed per second  | times/sec | resourceId |
| `Connections` | Connections   | Total current connections to the database when initiating data collection  | units | resourceId |
| `NewConnIn5s` | New Connections Within 5 Seconds  | All connections established within the last 5 seconds when initiating data collection  | times | resourceId |
| `ActiveConns` | Active Connections | Instantaneous active connections to the database (non-idle connections) when initiating data collection    | units | resourceId |
| `IdleConns` | Idle Connections | Instantaneous idle connections (idle connections) to the database when initiating data collection  | units | resourceId |
| `Waiting` | Waiting Sessions   | Number of sessions waiting for the database when initiating data collection (status is waiting) | times/sec | resourceId |
| `LongWaiting` | Sessions Waiting More Than 5 Seconds | Number of sessions waiting for the database more than 5 seconds within one collection cycle (status is waiting, and waiting status has lasted for 5 seconds)  | units | resourceId |
| `IdleInXact` | Idle Transactions  | Number of transactions in the database that are in an idle state when initiating data collection | units | resourceId |
| `LongXact` | Transactions Taking Longer Than 1 Second  | Number of transactions taking longer than 1 second within one collection cycle  | units | resourceId |
| `Tps` | Transactions Per Second | Average number of successful transactions executed per second (including rollbacks and commits)  | times/sec | resourceId |
| `XactCommit` | Transaction Commits  | Average number of transactions committed per second  | times/sec | resourceId |
| `XactRollback` | Transaction Rollbacks  | Average number of transactions rolled back per second  | times/sec | resourceId |
| `ReadWriteCalls` | Requests  | Total number of requests within one statistical cycle  | times | resourceId |
| `ReadCalls` | Read Requests  | Total number of read requests within one statistical cycle  | times | resourceId |
| `WriteCalls` | Write Requests  | Total number of write requests within one statistical cycle  | times | resourceId |
| `OtherCalls` | Other Requests  | Total number of other requests within one statistical cycle (begin, create, non-DML, DDL, DQL operations)  | times | resourceId |
| `HitPercent` | Buffer Cache Hit Ratio  | Hit ratio of all SQL statements executed within one request cycle  | % | resourceId |
| `SqlRuntimeAvg` | Average Execution Latency  | Average execution latency of all SQL statements within one statistical cycle  | ms | resourceId |
| `SqlRuntimeMax` | Longest TOP10 Execution Latency  | Average execution latency of the longest TOP10 SQL within one statistical cycle  | ms | resourceId |
| `SqlRuntimeMin` | Shortest TOP10 Execution Latency  | Average execution latency of the shortest TOP10 SQL within one statistical cycle  | ms | resourceId |
| `SlowQueryCnt` | Slow Query Count  | Number of slow queries appearing within one collection cycle  | units | resourceId |
| `LongQuery` | SQL Count Executing Longer Than 1 Second  | Number of SQL queries taking longer than 1 second when initiating data collection  | units | resourceId |
| `2pc` | 2PC Transactions  | Number of current 2PC transactions when initiating data collection  | units | resourceId |
| `Long2pc` | 2PC Transactions Taking Longer Than 5 Seconds Not Committed  | Number of 2PC transactions taking longer than 5 seconds not committed when initiating data collection  | units | resourceId |
| `Deadlocks` | Deadlock Counts  | All deadlock counts within one collection cycle  | units | resourceId |
| `Memory` | Memory Usage  | Used memory amount  | MB | resourceId |
| `MemoryRate` | Memory Usage Rate  | Percentage of used memory out of total memory  | % | resourceId |

## Objects {#object}

Collected Tencent Cloud **postgresql** object data structure, can be seen from "Infrastructure-Custom" objects data

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
    "RelatedInstance"  : "{Instance JSON Data}",
    "ReplicaSets"      : "{Instance JSON Data}",
    "StandbyInstances" : "[]",
    "message"          : "{Instance JSON Data}",
  }
}
```

## Logs {#logging}

### Slow Query Statistics

#### Prerequisites

> Note 1: The code execution of this script depends on PostgreSQL instance object collection. If PostgreSQL custom object collection is not configured, the slow log script cannot collect slow log data.


#### Install Log Collection Script

On top of the previous setup, you need to install another corresponding **PostgreSQL slow query statistics log collection script**

In "Manage / Script Market", click and install the corresponding script package:

- "Guance Integration (Tencent Cloud-PostgreSQL Slow Query Log Collection)" (ID: `guance_tencentcloud_postgresql_slowlog`)

After data synchronization is normal, you can view the data in the "Logs" section of Guance.

Example of reported data:

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
      "message"     : "{Slow Query JSON Data}"
  }
}


```

> *Note: Fields in `tags`, `fields` may change with subsequent updates.*
> Note 1: `tags` values are supplemented by custom objects.
> Note 2: `fields.message` is a JSON serialized string.

### Appendix

#### TencentCloud-PostgreSQL "Regions"

Refer to the official Tencent documentation:

- [TencentCloud-MongoDB Region ID](https://cloud.tencent.com/document/api/409/16764)


#### TencentCloud-PostgreSQL "Slow Log Information Documentation"
Refer to the official Tencent documentation:

- [TencentCloud-PostgreSQL Slow Log Detailed Information Documentation](https://cloud.tencent.com/document/api/409/60541)