---
title: 'Tencent Cloud CDB'
tags: 
  - Tencent Cloud
summary: 'Use the script market "official script market" series script package to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>'
__int_icon: 'icon/tencent_cdb'
dashboard:

  - desc: 'Tencent Cloud CDB built-in views'
    path: 'dashboard/en/tencent_cdb'

monitor:
  - desc: 'Tencent Cloud CDB monitor'
    path: 'monitor/en/tencent_cdb'

---


<!-- markdownlint-disable MD025 -->
# Tencent Cloud CDB
<!-- markdownlint-enable -->

Use the script market "<<< custom_key.brand_name >>> Cloud Sync" series script package to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>


## Configuration {#config}

### Install Func

It is recommended to enable the <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites will be automatically installed, please continue with the script installation

If you deploy Func by yourself, refer to [Self-deploy Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Hint: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize the monitoring data of Tencent Cloud CDB, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Tencent Cloud-CDB Collection)" (ID: `guance_tencentcloud_cdb`)

After clicking 【Install】, enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Start Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding start script.

In addition, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.



We default collect some configurations, for more details see the Metrics section [Customize Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the automatic trigger configuration, and at the same time, you can check the corresponding task records and logs for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if there is any asset information.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}
Configure Tencent Cloud - Cloud Monitoring, the default metric set is as follows, you can collect more metrics via configuration [Tencent Cloud Cloud Monitoring Metric Details](https://cloud.tencent.com/document/product/248/45147){:target="_blank"}

### Resource Monitoring

| Metric English Name      | Metric Chinese Name   | Metric Description                                                     | Unit    | Dimensions                             | Statistical Granularity                       |
| --------------- | ------------ | ------------------------------------------------------------ | ------- | -------------------------------- | ------------------------------ |
| `BytesReceived` | Internal network inbound traffic   | Number of bytes received per second                                             | Bytes/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s   |
| `BytesSent`     | Internal network outbound traffic   | Number of bytes sent per second                                             | Bytes/second | InstanceId、InstanceType（optional） | 5s、 60s、 300s、3600s、86400s |
| `Capacity`      | Disk usage space | Includes MySQL data directory and  `binlog、relaylog、undolog、errorlog、slowlog` log space | MB      | InstanceId、InstanceType（optional） | 5s、 60s、 300s、3600s、86400s |
| `CpuUseRate`    | CPU utilization   | Idle overuse allowed, CPU utilization may exceed 100%                         | %       | InstanceId、InstanceType（optional） | 5s、 60s、 300s、3600s、86400s |
| `IOPS`          | IOPS         | Input/output per second (or read/write times)                                 | Times/second   | InstanceId、InstanceType（optional） | 5s、 60s、 300s、3600s、86400s |
| `MemoryUse`     | Memory usage     | Idle overuse allowed, actual memory usage may exceed the purchased specification                   | MB      | InstanceId、InstanceType（optional） | 5s、 60s、 300s、3600s、86400s |
| `MemoryUseRate` | Memory utilization   | Idle overuse allowed, memory utilization may exceed 100%                         | %       | InstanceId、InstanceType（optional） | 5s、 60s、 300s、3600s、86400s |
| `RealCapacity`  | Data usage space | Only includes MySQL data directory, excludes `binlog、relaylog、undolog、errorlog、slowlog` log space | MB      | InstanceId、InstanceType（optional） | 5s、 60s、 300s、3600s、86400s |
| `VolumeRate`    | Disk utilization   | Disk usage space/instance purchased space                                    | %       | InstanceId、InstanceType（optional） | 5s、 60s、 300s、3600s、86400s |

### Engine Monitoring (Standard) - **MyISAM**

| Metric English Name        | Metric Chinese Name            | Metric Description                    | Unit | Dimensions                             | Statistical Granularity                         |
| ----------------- | --------------------- | --------------------------- | ---- | -------------------------------- | -------------------------------- |
| `KeyCacheHitRate` | **myisam** cache hit rate | **myisam** engine cache hit rate | %    | InstanceId、InstanceType（optional） | 5s、 60s、 300s、 3600s、 86400s |
| `KeyCacheUseRate` | **myisam** cache usage rate | **myisam** engine cache usage rate | %    | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s     |

### Engine Monitoring (Standard) - **InnoDB**

| Metric English Name           | Metric Chinese Name                   | Metric Description                               | Unit  | Dimensions                             | Statistical Granularity                         |
| -------------------- | ---------------------------- | -------------------------------------- | ----- | -------------------------------- | -------------------------------- |
| `InnodbCacheHitRate` | **innodb** cache hit rate        | **Innodb** engine cache hit rate            | %     | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s     |
| `InnodbCacheUseRate` | **innodb** cache usage rate        | **Innodb** engine cache usage rate            | %     | InstanceId、InstanceType（optional） | 5s、 60s、 300s、 3600s、 86400s |
| `InnodbNumOpenFiles` | Current number of **InnoDB** open tables | **Innodb** engine current number of open tables        | Items    | InstanceId、InstanceType（optional） | 5s、 60s、 300s、 3600s、 86000s |
| `InnodbOsFileReads`  | **innodb** disk reads        | Number of times **Innodb** engine reads from disk files per second    | Times/second | InstanceId、InstanceType（optional） | 5s、 60s、 300s、 3600s、 86400s |
| `InnodbOsFileWrites` | **innodb** disk writes        | Number of times **Innodb** engine writes to disk files per second    | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `InnodbOsFsyncs`     | **innodbfsyn** calls          | Number of times **Innodb** engine calls fsync function per second | Times/second | InstanceId、InstanceType（optional） | 5s、 60s、 300s、 3600s、 86400s |

### Engine Monitoring (Standard) - Connections

| Metric English Name          | Metric Chinese Name     | Metric Description                                                     | Unit  | Dimensions                             | Statistical Granularity                     |
| ------------------- | -------------- | ------------------------------------------------------------ | ----- | -------------------------------- | ---------------------------- |
| `ConnectionUseRate` | Connection usage rate   | Current number of open connections/max connections                                    | %     | InstanceId、InstanceType（optional） | 5s、10s、60s、300s、3600s    |
| `MaxConnections`    | Maximum connections     | Maximum connections                                                   | Items    | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `Qps`               | Queries per second | Number of SQL queries executed per second by the database (including  insert、select、update、delete、replace), QPS primarily reflects the actual processing capability of the TencentDB instance | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `ThreadsConnected`  | Current connections     | Number of currently open connections                                         | Items    | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `Tps`               | Transactions per second | Number of transactions processed per second by the database                                 | Transactions/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |

### Engine Monitoring (Standard) - Access

| Metric English Name    | Metric Chinese Name | Metric Description                                    | Unit  | Dimensions                             | Statistical Granularity                     |
| ------------- | ---------- | ------------------------------------------- | ----- | -------------------------------- | ---------------------------- |
| `ComDelete`   | Deletes     | Number of deletes per second                                  | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `ComInsert`   | Inserts     | Number of inserts per second                                  | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `ComReplace`  | Replaces     | Number of replaces per second                                  | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、6400s  |
| `ComUpdate`   | Updates     | Number of updates per second                                  | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `Queries`     | Total accesses   | All executed SQL statements, including set, show, etc      | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `QueryRate`   | Access volume ratio | Number of operations executed per second QPS/recommended operations per second           | %     | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `SelectCount` | Selects     | Number of selects per second                                  | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `SelectScan`  | Full table scans | Number of full table search queries                      | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `SlowQueries` | Slow queries   | Number of queries taking longer than long_query_time seconds | Items    | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |

### Engine Monitoring (Standard) - Tables

| Metric English Name       | Metric Chinese Name     | Metric Description             | Unit  | Dimensions                             | Statistical Granularity                     |
| ---------------- | -------------- | -------------------- | ----- | -------------------------------- | ---------------------------- |
| `CreatedTmpTables` | Temporary memory tables quantity | Number of temporary tables created     | Items/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `TableLocksWaited` | Waiting table lock counts   | Number of times unable to immediately obtain table locks | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `OpenedTables`   | Opened tables count | Number of tables opened by the engine  | Items | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `TableLocksImmediate`| Immediately released table lock counts | Number of table locks about to be released by the engine  | Items | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |

### Engine Monitoring (Extended) - **Tmp**

| Metric English Name             | Metric Chinese Name     | Metric Description                 | Unit  | Dimensions                             | Statistical Granularity                     |
| ---------------------- | -------------- | ------------------------ | ----- | -------------------------------- | ---------------------------- |
| `CreatedTmpDiskTables` | Disk temporary tables quantity | Number of disk temporary tables created per second | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `CreatedTmpFiles`      | Temporary file quantity   | Number of temporary files created per second   | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |

### Engine Monitoring (Extended) - **Key**

| Metric English Name         | Metric Chinese Name             | Metric Description                                | Unit  | Dimensions                             | Statistical Granularity                     |
| ------------------ | ---------------------- | --------------------------------------- | ----- | -------------------------------- | ---------------------------- |
| `KeyBlocksUnused`  | Unused blocks in key cache | **myisam** engine unused key cache block count     | Items    | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `KeyBlocksUsed`    | Used blocks in key cache   | **myisam** engine used key cache block count     | Items    | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `KeyReadRequests`  | Key cache data block read requests   | **myisam** engine key cache block reads per second   | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `KeyReads`         | Hard drive data block read requests     | **myisam** engine hard drive data block reads per second | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `KeyWriteRequests` | Data block write to key buffer requests   | **myisam** engine key cache block writes per second     | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `KeyWrites`        | Data block write to disk requests     | **myisam** engine hard drive data block writes per second   | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |

### Engine Monitoring (Extended) - **InnoDB Row**

| Metric English Name             | Metric Chinese Name                          | Metric Description                            | Unit  | Dimensions                             | Statistical Granularity                         |
| ---------------------- | ----------------------------------- | ----------------------------------- | ----- | -------------------------------- | -------------------------------- |
| `InnodbRowLockTimeAvg` | **InnoDB** average row lock time (milliseconds) | **Innodb** engine average row lock duration     | ms    | InstanceId、InstanceType（optional） | 5s、 60s、 300s、 3600s、 86400s |
| `InnodbRowLockWaits`   | **InnoDB** row lock waits count             | **Innodb** engine row lock waits per second     | Times/second | InstanceId、InstanceType（optional） | 5s、 60s、 300s、 3600s、 86400s |
| `InnodbRowsDeleted`    | **InnoDB** rows deleted count                 | **Innodb** engine rows deleted per second       | Rows/second | InstanceId、InstanceType（optional） | 5s、 60s、 300s、 3600s、 86400s |
| `InnodbRowsInserted`   | **InnoDB** rows inserted count                 | **Innodb** engine rows inserted per second       | Rows/second | InstanceId、InstanceType（optional） | 5s、 60s、 300s、 3600s、 86400s |
| `InnodbRowsRead`       | **InnoDB** rows read count                 | **Innodb** engine rows read per second       | Rows/second | InstanceId、InstanceType（optional） | 5s、 60s、 300s、 3600s、 86400s |
| `InnodbRowsUpdated`    | **InnoDB** rows updated count                 | **Innodb** engine rows updated per second       | Rows/second | InstanceId、InstanceType（optional） | 5s、 60s、 300s、 3600s、86400s  |

### Engine Monitoring (Extended) - InnoDB Data

| Metric English Name          | Metric Chinese Name          | Metric Description                                    | Unit    | Dimensions                             | Statistical Granularity                     |
| ------------------- | ------------------- | ------------------------------------------- | ------- | -------------------------------- | ---------------------------- |
| `InnodbDataRead`    | **InnoDB** read volume   | **Innodb** engine bytes read per second | Bytes/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `InnodbDataReads`   | **InnoDB** total read volume | **Innodb** engine data read requests completed per second   | Times/second   | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `InnodbDataWrites`  | **InnoDB** total write volume | **Innodb** engine data write requests completed per second     | Times/second   | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `InnodbDataWritten` | **InnoDB** write volume   | **Innodb** engine bytes written per second   | Bytes/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |

### Engine Monitoring (Extended) - **Handler**

| Metric English Name           | Metric Chinese Name     | Metric Description                 | Unit  | Dimensions                             | Statistical Granularity                     |
| -------------------- | -------------- | ------------------------ | ----- | -------------------------------- | ---------------------------- |
| `HandlerCommit`      | Internal commits count     | Transaction commit requests per second       | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `HandlerReadRndNext` | Read next line request count | Next line read requests per second | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `HandlerRollback`    | Internal rollbacks count     | Transaction rollback requests per second     | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |

### Engine Monitoring (Extended) - **Buff**

| Metric English Name                     | Metric Chinese Name                  | Metric Description                                    | Unit  | Dimensions                             | Statistical Granularity                         |
| ------------------------------ | --------------------------- | ------------------------------------------- | ----- | -------------------------------- | -------------------------------- |
| `InnodbBufferPoolPagesFree`    | **InnoDB** free pages count           | **Innodb** engine free memory page count                 | Items    | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s             |
| `InnodbBufferPoolPagesTotal`   | **InnoDB** total pages count           | **Innodb** engine total memory page count               | Items    | InstanceId、InstanceType（optional） | 5s、 60s、 300s、 3600s、 86400s |
| `InnodbBufferPoolReadRequests` | **Innodb** buffer pool pre-read page count | **Innodb** engine logical read requests completed per second | Times/second | InstanceId、InstanceType（optional） | 5s、 60s、 300s、 3600s、 86400s |
| `InnodbBufferPoolReads`        | **Innodb** disk read page count     | **Innodb** engine physical read requests completed per second | Times/second | InstanceId、InstanceType（optional） | 5s、 60s、 300s、 3600s、 86400s |

### Engine Monitoring (Extended) - Others

| Metric English Name    | Metric Chinese Name | Metric Description             | Unit  | Dimensions                             | Statistical Granularity                    |
| ------------- | ---------- | -------------------- | ----- | -------------------------------- | --------------------------- |
| `LogCapacity` | Log usage | Engine log usage count   | MB    | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s        |
| `OpenFiles`   | Opened files count | Engine opened file count | Items/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600、86400s |

### Engine Monitoring (Extended) - Connections

| Metric English Name       | Metric Chinese Name     | Metric Description                   | Unit | Dimensions                             | Statistical Granularity                     |
| ---------------- | -------------- | -------------------------- | ---- | -------------------------------- | ---------------------------- |
| `ThreadsCreated` | Created threads count | Threads created for handling connections   | Items   | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `ThreadsRunning` | Running threads count   | Active (non-sleeping state) thread count | Items   | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |

### Engine Monitoring (Extended) - Access

| Metric English Name    | Metric Chinese Name | Metric Description     | Unit  | Dimensions                             | Statistical Granularity                     |
| ------------- | ---------- | ------------ | ----- | -------------------------------- | ---------------------------- |
| `ComCommit`   | Commits count     | Commit requests per second | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `ComRollback` | Rollbacks count     | Rollback requests per second | Times/second | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |

### Database Proxy (Proxy)

| Metric English Name                | Metric Chinese Name | Unit | Dimensions                     | Statistical Granularity                         |
| ------------------------- | ---------- | ---- | ------------------------ | -------------------------------- |
| `ProxyCpuUseRate`         | CPU utilization | %    | InstanceId、InstanceType | 5s、60s、300s、3600s、86400s     |
| `ProxyCurrentConnections` | Current connections | Items   | InstanceId、InstanceType | 5s、 60s、 300s、 3600s、 86400s |
| `ProxyMemoryUseRate`      | Memory utilization | %    | InstanceId、InstanceType | 5s、 60s、 300s、 3600s、 86400s |
| `ProxyQueries`            | Request count     | Items   | InstanceId、InstanceType | 5s、 60s、 300s、 3600s、 86400s |
| `ProxyRouteMaster`        | Write request count   | Items   | InstanceId、InstanceType | 5s、 60s、 300s、 3600s、 86400s |
| `ProxyRouteSlave`         | Read request count   | Items   | InstanceId、InstanceType | 5s、 60s、 300s、 3600s、 86400s |
| `ProxyMemoryUse`          | Memory usage   | MB   | InstanceId、InstanceType | 5s、 60s、 300s、 3600s、 86400s |

### Deployment Monitoring (Standby)

| Metric English Name                | Metric Chinese Name   | Metric Description             | Unit                                | Dimensions                             | Statistical Granularity                     |
| ------------------------- | ------------ | -------------------- | ----------------------------------- | -------------------------------- | ---------------------------- |
| `MasterSlaveSyncDistance` | Master-slave sync distance | Master-slave **binlog** gap | MB                                  | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `SecondsBehindMaster`     | Master-slave sync delay | Master-slave delay time         | Seconds                                  | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `SlaveIoRunning`          | IO thread status  | IO thread running status      | Status value（0-Yes，1-No，2-Connecting） | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |
| `SlaveSqlRunning`         | SQL thread status | SQL thread running status     | Status value（0-Yes，1-No）               | InstanceId、InstanceType（optional） | 5s、60s、300s、3600s、86400s |

## Objects {#object}
Collected Tencent Cloud CDB object data structure, which can be viewed from "Infrastructure - Custom"

```json
{
  "measurement": "tencentcloud_cdb",
  "tags": {
    "name"         : "cdb-xxxxxxx",
    "RegionId"     : "ap-shanghai",
    "Region"       : "ap-shanghai",
    "InstanceId"   : "cdb-imxxxx",
    "InstanceName" : "smart_check_test",
    "InstanceType" : "1",
    "Zone"         : "ap-shanghai-3",
    "ZoneName"     : "",
    "DeviceType"   : "UNIVERSAL",
    "EngineVersion": "8.0",
    "Vip"          : "172.xx.x.9",
    "Status"       : "1",
    "ProtectMode"  : "0",
    "ProjectId"    : "0",
    "PayType"      : "1",
    "WanStatus"    : "0"
  },
  "fields": {
    "WanPort"     : 0,
    "Memory"      : 1000,
    "Volume"      : 25,
    "DeadlineTime": "0000-00-00 00:00:00",
    "CreateTime"  : "2022-04-27 15:18:06",
    "message"     : "{JSON data for instance}"
  }
}
```

## Logs {#logging}

### Slow Query Statistics

#### Prerequisites

> Hint 1: Before using this collector, you must install the "<<< custom_key.brand_name >>> Core Package" and its supporting third-party dependency packages
>
> Hint 2: The code execution of this script depends on the CDB instance object collection. If the custom object collection for CDB is not configured, the slow log script cannot collect slow log data.

<!-- markdownlint-disable MD024 -->

#### Install Script

<!-- markdownlint-enable -->

On top of the previous setup, you need to install another script for collecting **CDB slow query statistics logs**

In the "Management / Script Market", click and install the corresponding script package:

- "<<< custom_key.brand_name >>> Integration (Tencent Cloud-CDB Slow Query Log Collection)" (ID: `guance_tencentcloud_cdb_slowlog`)

After data synchronization is normal, you can view the data in the "Logs" section of <<< custom_key.brand_name >>>.

The reported data example is as follows:

```json
{
  "measurement": "tencentcloud_cdb_slow_log",
  "tags": {
    "name"          : "cdb-llxxxxx",
    "Database"      : "test",
    "UserHost"      : "9.xxx.xxx.122",
    "UserName"      : "root",
    "InstanceId"    : "cdb-lxxxxtk8",
    "DeviceType"    : "UNIVERSAL",
    "EngineVersion" : "8.0",
    "InstanceName"  : "cdbxxxxx",
    "InstanceType"  : "1",
    "PayType"       : "1",
    "ProjectId"     : "0",
    "ProtectMode"   : "0",
    "Region"        : "ap-shanghai",
    "RegionId"      : "ap-shanghai",
    "Status"        : "1",
    "Vip"           : "172.xx.xxx.15",
    "WanStatus"     : "0",
    "Zone"          : "ap-shanghai-3",
    "account_name"  : "Script development Tencent account",
    "cloud_provider": "tencentcloud"
  },
  "fields": {
      "QueryTime"   : 3.000195,
      "SqlText"     : "select sleep(3)",
      "Timestamp"   : 1652933796,
      "LockTime"    : 0,
      "RowsExamined": 1,
      "RowsSent"    : 1,
      "SqlTemplate" : "select sleep(?);",
      "Md5"         : "26A15F1AE530F28F",
      "message"     : "{JSON data for instance}"
  }
}
```

Some parameter descriptions are as follows:

| Field           | Type    | Description                 |
| :------------- | :------ | :------------------- |
| `QueryTime`    | float   | SQL execution duration (seconds) |
| `Timestamp`    | integer | SQL execution timing       |
| `Md5`          | str     | SQL statement's MD5       |
| `LockTime`     | float   | Lock duration (seconds)         |
| `RowsExamined` | integer | Scanned rows             |
| `RowsSent`     | integer | Result set rows           |

> *Note: Fields in `tags`, `fields` may change with subsequent updates*
>
> Hint 1: `tags.name` value is the instance ID, used for unique identification
>
> Hint 2: `fields.message` is a JSON serialized string