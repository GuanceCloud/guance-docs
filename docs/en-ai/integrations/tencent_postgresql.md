---
title: 'Tencent Cloud PostgreSQL'
tags: 
  - Tencent Cloud
summary: 'Use the "Guance Cloud Sync" series of script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance'
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

Use the "Guance Cloud Sync" series of script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with the script installation

If you deploy Func on your own, refer to [Deploy Func on Your Own](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install PostgreSQL Collection Script

> Note: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize PostgreSQL monitoring data, install the corresponding collection script: "Guance Integration (Tencent Cloud-PostgreSQL Collection)" (ID: `guance_tencentcloud_postgresql`)

After clicking 【Install】, enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】to immediately execute once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, you also need to enable the corresponding log collection script. If you need to collect billing information, you need to enable the cloud billing collection script.

By default, we collect some configurations; for more details, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any abnormalities.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Tencent Cloud-Cloud Monitoring, the default metric sets are as follows. You can collect more metrics through configuration [Tencent Cloud Cloud Monitoring Metrics Details](https://cloud.tencent.com/document/product/248/45105){:target="_blank"}

### Monitoring Metrics

| Metric English Name | Metric Chinese Name             | Meaning                        | Unit  | Dimension              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| `Cpu` | CPU Utilization     | Actual CPU utilization  | %    | resourceId |
| `DataFileSize` | Data File Size  | Size of data files occupied space   | GB | resourceId |
| `LogFileSize` | Log File Size  | Size of WAL log files occupied space  | MB | resourceId |
| `TempFileSize` | Temporary File Size  | Size of temporary files  | Times | resourceId |
| `StorageRate` | Storage Space Usage  | Total storage space usage rate, including temporary files, data files, log files, and other types of database files  | % | resourceId |
| `Qps` | Queries Per Second   | Average number of SQL statements executed per second  | Times/Second | resourceId |
| `Connections` | Connections   | Total current connections to the database when initiating collection  | Count | resourceId |
| `NewConnIn5s` | New Connections in 5 Seconds  | Number of connections established within the last 5 seconds when initiating collection  | Times | resourceId |
| `ActiveConns` | Active Connections | Instantaneous active connections (non-idle connections) to the database when initiating collection    | Count | resourceId |
| `IdleConns` | Idle Connections | Instantaneous idle connections (idle connections) to the database when initiating collection  | Count | resourceId |
| `Waiting` | Waiting Sessions   | Number of sessions currently waiting in the database (status is waiting) | Times/Second | resourceId |
| `LongWaiting` | Sessions Waiting Over 5 Seconds | Number of sessions in the database that have been waiting for over 5 seconds (status is waiting and maintained for 5 seconds)  | Count | resourceId |
| `IdleInXact` | Idle Transactions  | Number of transactions in the database that are in an idle state when initiating collection | Count | resourceId |
| `LongXact` | Transactions Over 1 Second  | Number of transactions in a collection cycle that took longer than 1 second  | Count | resourceId |
| `Tps` | Transactions Per Second | Average number of successfully executed transactions per second (including rollbacks and commits)  | Times/Second | resourceId |
| `XactCommit` | Transaction Commits  | Average number of committed transactions per second  | Times/Second | resourceId |
| `XactRollback` | Transaction Rollbacks  | Average number of rolled back transactions per second  | Times/Second | resourceId |
| `ReadWriteCalls` | Request Count  | Total request count in a statistical period  | Times | resourceId |
| `ReadCalls` | Read Request Count  | Total read request count in a statistical period  | Times | resourceId |
| `WriteCalls` | Write Request Count  | Total write request count in a statistical period  | Times | resourceId |
| `OtherCalls` | Other Request Count  | Total other request count (begin, create, non-DML, DDL, DQL operations) in a statistical period  | Times | resourceId |
| `HitPercent` | Buffer Cache Hit Rate  | Hit rate of all SQL statements executed in a request period  | % | resourceId |
| `SqlRuntimeAvg` | Average Execution Latency  | Average execution latency of all SQL statements in a statistical period  | ms | resourceId |
| `SqlRuntimeMax` | Longest TOP10 Execution Latency  | Average execution latency of the longest TOP10 SQL in a statistical period  | ms | resourceId |
| `SqlRuntimeMin` | Shortest TOP10 Execution Latency  | Average execution latency of the shortest TOP10 SQL in a statistical period  | ms | resourceId |
| `SlowQueryCnt` | Slow Query Count  | Number of slow queries in a collection cycle  | Count | resourceId |
| `LongQuery` | SQLs Over 1 Second  | Number of SQLs taking longer than 1 second when initiating collection  | Count | resourceId |
| `2pc` | 2PC Transaction Count  | Current 2PC transaction count when initiating collection  | Count | resourceId |
| `Long2pc` | 2PC Transactions Over 5 Seconds  | Current 2PC transaction count exceeding 5 seconds when initiating collection  | Count | resourceId |
| `Deadlocks` | Deadlock Count  | Total deadlock count in a collection cycle  | Count | resourceId |
| `Memory` | Memory Usage  | Used memory amount  | MB | resourceId |
| `MemoryRate` | Memory Usage Rate  | Percentage of used memory out of total capacity  | % | resourceId |

## Objects {#object}

The collected Tencent Cloud **postgresql** object data structure can be seen in "Infrastructure-Custom"

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

> Note 1: The operation of this script depends on the collection of PostgreSQL instance objects. If PostgreSQL custom object collection is not configured, the slow log script cannot collect slow log data.


#### Install Log Collection Script

On top of the previous setup, you need to install a corresponding script for **PostgreSQL slow query log collection**

In "Management / Script Market", click and install the corresponding script package:

- "Guance Integration (Tencent Cloud-PostgreSQL Slow Query Log Collection)" (ID: `guance_tencentcloud_postgresql_slowlog`)

After data synchronization is normal, you can view the data in the "Logs" section of Guance.

Sample data reported:

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

#### TencentCloud-PostgreSQL「Regions」

Refer to the official Tencent documentation:

- [TencentCloud-MongoDB Region IDs](https://cloud.tencent.com/document/api/409/16764)


#### TencentCloud-PostgreSQL「Slow Log Information Documentation」
Refer to the official Tencent documentation:

- [TencentCloud-PostgreSQL Slow Log Detailed Information Documentation](https://cloud.tencent.com/document/api/409/60541)

</input_content>
<target_language>英语</target_language>
</input>

- 如果输入是 Markdown 内容，示例：
<example>
输入示例：
- input_content: "# 介绍\n这是一个关于产品的简短介绍。\n- 特点1\n- 特点2"
- target_language: 英语

期望输出：
- translated_content: "# Introduction\nThis is a brief introduction to the product.\n- Feature 1\n- Feature 2"
</example>

- 如果输入是 YAML 内容，示例：
<example>
输入示例：
nav:
 - 观测云: /guance
 - 应用性能监测: /apm

期望输出（输出结果，不要添加额外的 ```YAML ``` 这个 Markdown 格式代码块标记。）：
nav:
 - Guance: /guance
 - APM: /apm
</example>
```
