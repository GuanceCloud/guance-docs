---
title: 'Tencent Cloud PostgreSQL'
summary: 'Use the「观测云云同步」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/tencent_postgresql'
dashboard:

  - desc: '腾讯云 PostgreSQL 内置视图'
    path: 'dashboard/zh/tencent_postgresql'

monitor:
  - desc: '腾讯云 PostgreSQL 监控器'
    path: 'monitor/zh/tencent_postgresql'

---
<!-- markdownlint-disable MD025 -->
# Tencent Cloud PostgreSQL
<!-- markdownlint-enable -->

Use the「观测云云同步」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of PostgreSQL cloud resources, we install the corresponding collection script：「观测云集成（腾讯云-PostgreSQL采集）」(ID：`guance_tencentcloud_postgresql`)

Click 【Install】 and enter the corresponding parameters: Aliyun AK, Aliyun account name.

Click [Deploy Startup Scripts], the system will automatically create the `Startup` script set and automatically configure the corresponding startup scripts.

You can see the corresponding auto-trigger configuration in "Management / Auto-trigger Configuration" after you turn it on. Click "Execute" to execute the task immediately without waiting for the regular time. Wait for a while, you can check the record and log of the executed task.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist.
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists.
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists.

## Metric {#metric}
Configure Tencent Cloud COS monitoring. The default indicator set is as follows. You can collect more indicators by configuring them [Tencent Cloud Monitor Metrics Details](https://cloud.tencent.com/document/product/248/45105){:target="_blank"}

### 监控指标

| Metric name      | 指标中文名             | Implication                        | Unit  | Dimensions              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| Cpu  | CPU 利用率     | Actual CPU utilization  | %    | resourceId |
| DataFileSize  | 数据文件大小  | Size of space occupied by data files   | GB | resourceId |
| LogFileSize  | 日志文件大小  | wal Log file size  | MB | resourceId |
| TempFileSize  | 临时文件大小  | Size of temporary files  | 次 | resourceId |
| StorageRate  | 存储空间使用率  | Total storage space utilization, including temporary files, data files, log files, and other types of database files  | % | resourceId |
| Qps  | 每秒查询数   | Average number of SQL statements executed per second  | 次/秒 | resourceId |
| Connections  | 连接数   | The current total number of connections to the database when initiating a collection against the database  | 个 | resourceId |
| NewConnIn5s  | 5秒内新建连接数  | When initiating a collection against a database, query about the number of all connections established in the last 5 seconds  | 次 | resourceId |
| ActiveConns | 活跃连接数 | Database transient active connection (non-idle connection) when initiating a collection against the database    | 个 | resourceId |
| IdleConns | 空闲连接数 | Instantaneous idle connections (idle connections) to the database queried when initiating a collection against the database  | 个 | resourceId |
| Waiting   | 等待会话数   | Number of sessions the database is waiting for when a capture is initiated against the database (status is waiting) | 次/秒 | resourceId |
| LongWaiting | 等待超过5秒的会话数 | Number of sessions where the database waited for more than 5 seconds during a collection cycle (status is waiting and the wait status was maintained for 5 seconds)  | 个 | resourceId |
| IdleInXact  | 空闲事务数  | The number of transactions in the database that are in idle state at the time the capture is initiated on the database | 个 | resourceId |
| LongXact   | 执行时长超过1秒的事务数目  | Number of transactions with an execution time of more than 1 second in a capture cycle  | 个 | resourceId |
| Tps | 每秒事务数 | Average number of successful transactions executed per second (including rollbacks and commits)  | 次/秒 | resourceId |
| XactCommit | 事务提交数  | Average number of transactions committed per second  | 次/秒 | resourceId |
| XactRollback   | 事务回滚数  | Average number of transactions rolled back per second  | 次/秒 | resourceId |
| ReadWriteCalls | 请求数  | Total number of requests in a statistical cycle  | 次 | resourceId |
| ReadCalls | 读请求数  | Number of read requests in a statistical cycle  | 次 | resourceId |
| WriteCalls | 写请求数  | Number of write requests in a statistical cycle  | 次 | resourceId |
| OtherCalls | 其他请求数  | Number of other requests (begin, create, non-DML, DDL, DQL operations) in a statistical cycle  | 次 | resourceId |
| HitPercent | 缓冲区缓存命中率  | Hit rate of all SQL statements executed in a request cycle  | % | resourceId |
| SqlRuntimeAvg | 平均执行时延  | Average execution latency of all SQL statements in a statistical cycle  | ms | resourceId |
| SqlRuntimeMax | 最长 TOP10 执行时延  | Average execution latency of the top 10 longest SQLs in a statistical period  | ms | resourceId |
| SqlRuntimeMin | 最短 TOP10 执行时延  | Average execution latency of the top 10 shortest SQLs in a statistical cycle  | ms | resourceId |
| SlowQueryCnt | 慢查询数量  | Number of slow queries in a collection cycle  | 个 | resourceId |
| LongQuery | 执行时长超过1秒的 SQL 数  | Number of SQL queries that take longer than 1s to execute when a collection is initiated against the database.  | 个 | resourceId |
| 2pc | 2pc事务数  | Number of current 2PC transactions when initiating a collection against the database  | 个 | resourceId |
| Long2pc | 超过5s未提交的 2PC 事务数  | Number of 2PC transactions with a current execution time of more than 5s when the database initiates a collection  | 个 | resourceId |
| Deadlocks | 死锁数  | Number of all deadlocks in an acquisition cycle  | 个 | resourceId |
| Memory | 内存占用量  | Memory Used  | MB | resourceId |
| MemoryRate | 内存使用率  | Memory Used Percentage of Total Occupancy  | % | resourceId |

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
    "RelatedInstance"  : "{实例 JSON 数据}",
    "ReplicaSets"      : "{实例 JSON 数据}",
    "StandbyInstances" : "[]",
    "message"          : "{实例 JSON 数据}",
  }
}
```

## Logging {#logging}

### Slow query statistics

#### Preconditions

> Tip 1: The code running of this script depends on the collection of PostgreSQL instance objects. If the custom collection of PostgreSQL object is not configured, the slow log script cannot collect slow log data.


#### Installation script

On the basis of the previous, you need to install another script for **PostgreSQL slow query statistics log collection **

In "Manage/Script Marketplace", click and install the corresponding script package:

- 「观测云集成（腾讯云-PostgreSQL慢查询日志采集）  」(ID：`guance_tencentcloud_postgresql_slowlog`)

After data is synchronized, you can view the data in Logs of the observation cloud.

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
      "message"     : "{慢查询 JSON 数据}"
  }
}


```

> * Note: The fields in tags and Fields may change with subsequent updates *
>
> Tip 1: The tags value is supplemented by a custom object
>
> Tip 2: 'fields.message' is the JSON serialized string
>
> Tip 3: 'fields.Slowlog' records each record for all slow query details

### Appendice

#### TencentCloud-PostgreSQL「Region」

Please refer to the official Tencent documentation:

- [TencentCloud-MongoDB Region ID](https://cloud.tencent.com/document/api/409/16764)


#### TencentCloud-PostgreSQL「Slow Log Information Documentation」
Please refer to the official Tencent documentation:

- [TencentCloud-PostgreSQL Slow Log Details Documentation](https://cloud.tencent.com/document/api/409/60541)

