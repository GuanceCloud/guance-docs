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

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install PostgreSQL Collection Script

> Note: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize PostgreSQL monitoring data, we install the corresponding collection script: "Guance Integration (Tencent Cloud-PostgreSQL Collection)" (ID: `guance_tencentcloud_postgresql`)

Click [Install], then enter the required parameters: Tencent Cloud AK, Tencent Cloud account name.

Click [Deploy Startup Script], the system will automatically create a `Startup` script set and configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click [Execute] to immediately run once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, you also need to enable the corresponding log collection script. If you need to collect billing data, you need to enable the cloud billing collection script.

By default, we collect some configurations, for more details see the metrics section [Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, in "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, in "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Tencent Cloud Cloud Monitoring Metrics Details](https://cloud.tencent.com/document/product/248/45105){:target="_blank"}

### Monitoring Metrics

| Metric English Name | Metric Chinese Name | Meaning | Unit | Dimensions |
| ------------------- | ------------------- | ------- | ---- | ---------- |
| `Cpu` | CPU Utilization | Actual CPU utilization | % | resourceId |
| `DataFileSize` | Data File Size | Size of data files | GB | resourceId |
| `LogFileSize` | Log File Size | Size of WAL log files | MB | resourceId |
| `TempFileSize` | Temporary File Size | Size of temporary files | times | resourceId |
| `StorageRate` | Storage Space Usage Rate | Total storage space usage rate, including temporary files, data files, log files, and other types of database files | % | resourceId |
| `Qps` | Queries Per Second | Average number of SQL statements executed per second | times/sec | resourceId |
| `Connections` | Connections | Total number of current connections to the database when initiating collection | count | resourceId |
| `NewConnIn5s` | New Connections in 5 Seconds | Number of all connections established within the last 5 seconds when initiating collection | times | resourceId |
| `ActiveConns` | Active Connections | Instantaneous active connections (non-idle connections) when initiating collection | count | resourceId |
| `IdleConns` | Idle Connections | Instantaneous idle connections (idle connections) when initiating collection | count | resourceId |
| `Waiting` | Waiting Sessions | Number of sessions currently waiting (status is waiting) when initiating collection | times/sec | resourceId |
| `LongWaiting` | Sessions Waiting Over 5 Seconds | Number of sessions that have been waiting for more than 5 seconds (status is waiting and maintained for 5 seconds) within one collection cycle | count | resourceId |
| `IdleInXact` | Idle Transactions | Number of transactions currently in idle state when initiating collection | count | resourceId |
| `LongXact` | Transactions Executing Over 1 Second | Number of transactions that took longer than 1 second within one collection cycle | count | resourceId |
| `Tps` | Transactions Per Second | Average number of successful transactions executed per second (including rollbacks and commits) | times/sec | resourceId |
| `XactCommit` | Transaction Commits | Average number of transactions committed per second | times/sec | resourceId |
| `XactRollback` | Transaction Rollbacks | Average number of transactions rolled back per second | times/sec | resourceId |
| `ReadWriteCalls` | Requests | Total number of requests within a statistical period | times | resourceId |
| `ReadCalls` | Read Requests | Total number of read requests within a statistical period | times | resourceId |
| `WriteCalls` | Write Requests | Total number of write requests within a statistical period | times | resourceId |
| `OtherCalls` | Other Requests | Total number of other requests (begin, create, non-DML, DDL, DQL operations) within a statistical period | times | resourceId |
| `HitPercent` | Buffer Cache Hit Rate | Hit rate of all SQL statements executed within a request period | % | resourceId |
| `SqlRuntimeAvg` | Average Execution Latency | Average execution latency of all SQL statements within one statistical period | ms | resourceId |
| `SqlRuntimeMax` | Longest TOP10 Execution Latency | Average execution latency of the longest TOP10 SQL statements within one statistical period | ms | resourceId |
| `SqlRuntimeMin` | Shortest TOP10 Execution Latency | Average execution latency of the shortest TOP10 SQL statements within one statistical period | ms | resourceId |
| `SlowQueryCnt` | Slow Query Count | Number of slow queries within one collection cycle | count | resourceId |
| `LongQuery` | SQLs Executing Over 1 Second | Number of SQL statements that took longer than 1 second when initiating collection | count | resourceId |
| `2pc` | 2PC Transactions | Number of current 2PC transactions when initiating collection | count | resourceId |
| `Long2pc` | 2PC Transactions Over 5 Seconds Uncommitted | Number of 2PC transactions that have been executing for more than 5 seconds when initiating collection | count | resourceId |
| `Deadlocks` | Deadlock Count | Total number of deadlocks within one collection cycle | count | resourceId |
| `Memory` | Memory Usage | Amount of memory used | MB | resourceId |
| `MemoryRate` | Memory Usage Rate | Percentage of used memory out of total available memory | % | resourceId |

## Objects {#object}

The collected Tencent Cloud **postgresql** object data structure can be viewed in "Infrastructure - Custom"

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
    "RelatedInstance"  : "{instance JSON data}",
    "ReplicaSets"      : "{instance JSON data}",
    "StandbyInstances" : "[]",
    "message"          : "{instance JSON data}",
  }
}
```

## Logs {#logging}

### Slow Query Statistics

#### Prerequisites

> Note 1: This script's code execution depends on the collection of PostgreSQL instance objects. If PostgreSQL custom object collection is not configured, the slow log script cannot collect slow log data.


#### Install Log Collection Script

On top of the previous setup, you need to install a script corresponding to **PostgreSQL slow query statistics log collection**

In "Manage / Script Market", click and install the corresponding script package:

- "Guance Integration (Tencent Cloud-PostgreSQL Slow Query Log Collection)" (ID: `guance_tencentcloud_postgresql_slowlog`)

After data is synchronized normally, you can view the data in the "Logs" section of Guance.

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
      "message"     : "{slow query JSON data}"
  }
}


```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
> Note 1: `tags` values are supplemented by custom objects.
> Note 2: `fields.message` is a JSON serialized string.

### Appendix

#### TencentCloud-PostgreSQL "Regions"

Refer to the official Tencent documentation:

- [TencentCloud-MongoDB Region IDs](https://cloud.tencent.com/document/api/409/16764)


#### TencentCloud-PostgreSQL "Slow Log Information Documentation"
Refer to the official Tencent documentation:

- [TencentCloud-PostgreSQL Slow Log Detailed Information Documentation](https://cloud.tencent.com/document/api/409/60541)
