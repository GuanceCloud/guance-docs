---
title: 'Tencent Cloud CDB'
tags: 
  - Tencent Cloud
summary: 'Use the script packages from the official script market to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/tencent_cdb'
dashboard:

  - desc: 'Built-in views for Tencent Cloud CDB'
    path: 'dashboard/en/tencent_cdb'

monitor:
  - desc: 'Tencent Cloud CDB Monitor'
    path: 'monitor/en/tencent_cdb'

---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud CDB
<!-- markdownlint-enable -->

Use the "Guance Cloud Sync" series of script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable Guance Integration - Extension - Managed Func: all prerequisites are automatically installed. Continue with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant read-only access `ReadOnlyAccess`)

To synchronize the monitoring data of Tencent Cloud CDB, install the corresponding collection script: "Guance Integration (Tencent Cloud-CDB Collection)" (ID: `guance_tencentcloud_cdb`)

After clicking 【Install】, enter the required parameters: Tencent Cloud AK and Tencent Cloud account name.

Click 【Deploy Start Script】, and the system will automatically create a `Startup` script set and configure the corresponding start scripts.

Additionally, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.


We have collected some configurations by default; for more details, see [Configuration of Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the corresponding task records and logs for any anomalies.
2. In the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. In the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud-Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Tencent Cloud Cloud Monitoring Metric Details](https://cloud.tencent.com/document/product/248/45147){:target="_blank"}

### Resource Monitoring

| Metric English Name | Metric Chinese Name | Description                                                     | Unit     | Dimensions                              | Statistical Granularity                      |
| ------------------- | -------------------- | --------------------------------------------------------------- | -------- | --------------------------------------- | -------------------------------------------- |
| `BytesReceived`     | Internal Network Inbound Traffic | Number of bytes received per second                            | Bytes/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                 |
| `BytesSent`         | Internal Network Outbound Traffic | Number of bytes sent per second                                | Bytes/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                 |
| `Capacity`          | Disk Usage Space     | Includes MySQL data directory and `binlog`, `relaylog`, `undolog`, `errorlog`, `slowlog` log space | MB       | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                 |
| `CpuUseRate`        | CPU Utilization      | Allows idle overuse, CPU utilization may exceed 100%             | %        | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                 |
| `IOPS`              | IOPS                 | Input/output operations per second                             | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                 |
| `MemoryUse`         | Memory Usage         | Allows idle overuse, actual memory usage may exceed purchased specifications | MB       | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                 |
| `MemoryUseRate`     | Memory Utilization   | Allows idle overuse, memory utilization may exceed 100%          | %        | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                 |
| `RealCapacity`      | Data Usage Space     | Only includes MySQL data directory, excluding `binlog`, `relaylog`, `undolog`, `errorlog`, `slowlog` log space | MB       | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                 |
| `VolumeRate`        | Disk Utilization     | Disk used space / instance purchased space                      | %        | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                 |

### Engine Monitoring (Standard) - **MyISAM**

| Metric English Name        | Metric Chinese Name            | Description                    | Unit | Dimensions                              | Statistical Granularity                         |
| -------------------------- | ------------------------------ | ------------------------------ | ---- | ---------------------------------------- | ----------------------------------------------- |
| `KeyCacheHitRate`           | **myisam** Cache Hit Rate      | **myisam** engine cache hit rate | %    | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                   |
| `KeyCacheUseRate`           | **myisam** Cache Usage Rate    | **myisam** engine cache usage rate | %    | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                   |

### Engine Monitoring (Standard) - **InnoDB**

| Metric English Name           | Metric Chinese Name                  | Description                               | Unit  | Dimensions                              | Statistical Granularity                         |
| ----------------------------- | ------------------------------------ | ----------------------------------------- | ----- | ---------------------------------------- | ----------------------------------------------- |
| `InnodbCacheHitRate`           | **innodb** Cache Hit Rate            | **Innodb** engine cache hit rate          | %     | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                   |
| `InnodbCacheUseRate`           | **innodb** Cache Usage Rate          | **Innodb** engine cache usage rate        | %     | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                   |
| `InnodbNumOpenFiles`           | Number of Open Tables in **InnoDB**  | Number of tables currently opened by **Innodb** engine | count | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                   |
| `InnodbOsFileReads`            | **innodb** Reads from Disk           | Number of times **Innodb** engine reads disk files per second | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                   |
| `InnodbOsFileWrites`           | **innodb** Writes to Disk            | Number of times **Innodb** engine writes disk files per second | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                   |
| `InnodbOsFsyncs`               | **innodbfsyn** Calls                 | Number of times **Innodb** engine calls fsync function per second | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                   |

### Engine Monitoring (Standard) - Connections

| Metric English Name          | Metric Chinese Name     | Description                                                     | Unit  | Dimensions                              | Statistical Granularity                     |
| ---------------------------- | ----------------------- | --------------------------------------------------------------- | ----- | ---------------------------------------- | ------------------------------------------- |
| `ConnectionUseRate`           | Connection Utilization  | Current open connections / maximum connections                  | %     | InstanceId, InstanceType (optional)    | 5s, 10s, 60s, 300s, 3600s                  |
| `MaxConnections`              | Maximum Connections     | Maximum number of connections                                   | count | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `Qps`                         | Queries Per Second      | SQL statements executed per second (including insert, select, update, delete, replace). QPS mainly reflects the actual processing capability of TencentDB instances | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `ThreadsConnected`            | Current Connections     | Number of currently open connections                            | count | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `Tps`                         | Transactions Per Second | Number of transactions processed per second                     | count/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |

### Engine Monitoring (Standard) - Access

| Metric English Name    | Metric Chinese Name | Description                                    | Unit  | Dimensions                              | Statistical Granularity                     |
| ---------------------- | ------------------- | ----------------------------------------------- | ----- | ---------------------------------------- | ------------------------------------------- |
| `ComDelete`            | Deletes             | Number of deletes per second                   | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `ComInsert`            | Inserts             | Number of inserts per second                   | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `ComReplace`           | Replaces            | Number of replaces per second                  | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 6400s               |
| `ComUpdate`            | Updates             | Number of updates per second                   | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `Queries`              | Total Access Volume | All executed SQL statements, including set, show, etc. | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `QueryRate`            | Access Volume Ratio | Queries per second QPS / Recommended queries per second | %     | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `SelectCount`          | Selects             | Number of selects per second                   | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `SelectScan`           | Full Table Scans    | Number of full table search queries executed   | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `SlowQueries`          | Slow Queries        | Number of queries taking longer than long_query_time seconds | count | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |

### Engine Monitoring (Standard) - Tables

| Metric English Name       | Metric Chinese Name     | Description             | Unit  | Dimensions                              | Statistical Granularity                     |
| ------------------------- | ----------------------- | ----------------------- | ----- | ---------------------------------------- | ------------------------------------------- |
| `CreatedTmpTables`        | Temporary Tables Created | Number of temporary tables created | count/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `TableLocksWaited`        | Table Lock Waits        | Number of times table lock could not be obtained immediately | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `OpenedTables`            | Opened Tables           | Number of tables already opened by the engine | count | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `TableLocksImmediate`     | Immediate Table Lock Releases | Number of table locks released immediately by the engine | count | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |

### Engine Monitoring (Extended) - **Tmp**

| Metric English Name             | Metric Chinese Name     | Description                 | Unit  | Dimensions                              | Statistical Granularity                     |
| ------------------------------- | ----------------------- | --------------------------- | ----- | ---------------------------------------- | ------------------------------------------- |
| `CreatedTmpDiskTables`          | Disk Temporary Tables Created | Number of disk temporary tables created per second | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `CreatedTmpFiles`               | Temporary Files Created | Number of temporary files created per second | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |

### Engine Monitoring (Extended) - **Key**

| Metric English Name         | Metric Chinese Name             | Description                                | Unit  | Dimensions                              | Statistical Granularity                     |
| --------------------------- | ------------------------------- | ------------------------------------------ | ----- | ---------------------------------------- | ------------------------------------------- |
| `KeyBlocksUnused`            | Unused Key Cache Blocks         | Number of unused key cache blocks in **myisam** engine | count | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `KeyBlocksUsed`              | Used Key Cache Blocks           | Number of used key cache blocks in **myisam** engine | count | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `KeyReadRequests`            | Key Cache Block Reads           | Number of times key cache blocks were read per second in **myisam** engine | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `KeyReads`                    | Disk Block Reads                | Number of times disk blocks were read per second in **myisam** engine | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `KeyWriteRequests`            | Key Buffer Write Requests       | Number of times key cache blocks were written per second in **myisam** engine | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `KeyWrites`                   | Disk Block Writes               | Number of times disk blocks were written per second in **myisam** engine | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |

### Engine Monitoring (Extended) - **InnoDB Row**

| Metric English Name             | Metric Chinese Name                          | Description                            | Unit  | Dimensions                              | Statistical Granularity                         |
| ------------------------------- | -------------------------------------------- | -------------------------------------- | ----- | ---------------------------------------- | ----------------------------------------------- |
| `InnodbRowLockTimeAvg`           | Average **InnoDB** Row Lock Time (ms)       | Average duration of row locks in **Innodb** engine | ms    | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                   |
| `InnodbRowLockWaits`             | **InnoDB** Row Lock Waits                   | Number of times row locks were waited per second in **Innodb** engine | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                   |
| `InnodbRowsDeleted`              | **InnoDB** Rows Deleted                     | Number of rows deleted per second in **Innodb** engine | rows/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                   |
| `InnodbRowsInserted`             | **InnoDB** Rows Inserted                    | Number of rows inserted per second in **Innodb** engine | rows/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                   |
| `InnodbRowsRead`                 | **InnoDB** Rows Read                        | Number of rows read per second in **Innodb** engine | rows/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                   |
| `InnodbRowsUpdated`              | **InnoDB** Rows Updated                     | Number of rows updated per second in **Innodb** engine | rows/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 86400s                          |

### Engine Monitoring (Extended) - InnoDB Data

| Metric English Name          | Metric Chinese Name          | Description                                    | Unit    | Dimensions                              | Statistical Granularity                     |
| ---------------------------- | ---------------------------- | ---------------------------------------------- | ------- | ---------------------------------------- | ------------------------------------------- |
| `InnodbDataRead`             | **InnoDB** Data Read         | Number of bytes of data read per second in **Innodb** engine | bytes/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `InnodbDataReads`            | **InnoDB** Total Data Reads  | Number of data reads completed per second in **Innodb** engine | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `InnodbDataWrites`           | **InnoDB** Total Data Writes | Number of data writes completed per second in **Innodb** engine | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `InnodbDataWritten`          | **InnoDB** Data Written      | Number of bytes of data written per second in **Innodb** engine | bytes/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |

### Engine Monitoring (Extended) - **Handler**

| Metric English Name           | Metric Chinese Name     | Description                 | Unit  | Dimensions                              | Statistical Granularity                     |
| ----------------------------- | ----------------------- | --------------------------- | ----- | ---------------------------------------- | ------------------------------------------- |
| `HandlerCommit`               | Internal Commits        | Number of commit operations per second | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `HandlerReadRndNext`          | Next Row Reads          | Number of requests to read next row per second | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `HandlerRollback`             | Internal Rollbacks      | Number of rollbacks per second | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |

### Engine Monitoring (Extended) - **Buff**

| Metric English Name                     | Metric Chinese Name                  | Description                                    | Unit  | Dimensions                              | Statistical Granularity                         |
| ---------------------------------------- | ------------------------------------ | ---------------------------------------------- | ----- | ---------------------------------------- | ----------------------------------------------- |
| `InnodbBufferPoolPagesFree`             | **InnoDB** Free Pages                | Number of free pages in **Innodb** engine memory | count | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s                           |
| `InnodbBufferPoolPagesTotal`            | **InnoDB** Total Pages               | Total number of pages occupied by **Innodb** engine in memory | count | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                   |
| `InnodbBufferPoolReadRequests`          | **Innodb** Buffer Pool Pre-read Pages | Number of logical read requests completed per second in **Innodb** engine | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                   |
| `InnodbBufferPoolReads`                 | **Innodb** Disk Page Reads           | Number of physical read requests completed per second in **Innodb** engine | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s                   |

### Engine Monitoring (Extended) - Others

| Metric English Name    | Metric Chinese Name | Description             | Unit  | Dimensions                              | Statistical Granularity                    |
| ---------------------- | ------------------- | ----------------------- | ----- | ---------------------------------------- | ------------------------------------------ |
| `LogCapacity`          | Log Usage           | Number of logs used by the engine | MB    | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s                      |
| `OpenFiles`            | Open Files          | Number of files opened by the engine | count/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600, 86400s               |

### Engine Monitoring (Extended) - Connections

| Metric English Name       | Metric Chinese Name     | Description                   | Unit | Dimensions                              | Statistical Granularity                     |
| ------------------------- | ----------------------- | ----------------------------- | ---- | ---------------------------------------- | ------------------------------------------- |
| `ThreadsCreated`          | Threads Created         | Number of threads created to handle connections | count | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `ThreadsRunning`          | Running Threads         | Number of active (non-sleeping state) threads | count | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |

### Engine Monitoring (Extended) - Access

| Metric English Name    | Metric Chinese Name | Description     | Unit  | Dimensions                              | Statistical Granularity                     |
| ---------------------- | ------------------- | --------------- | ----- | ---------------------------------------- | ------------------------------------------- |
| `ComCommit`            | Commits             | Number of commits per second | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `ComRollback`          | Rollbacks           | Number of rollbacks per second | times/sec | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |

### Database Proxy (Proxy)

| Metric English Name                | Metric Chinese Name | Unit | Dimensions                     | Statistical Granularity                         |
| ---------------------------------- | ------------------- | ---- | ------------------------------ | ----------------------------------------------- |
| `ProxyCpuUseRate`                  | CPU Utilization     | %    | InstanceId, InstanceType       | 5s, 60s, 300s, 3600s, 86400s                    |
| `ProxyCurrentConnections`          | Current Connections | count | InstanceId, InstanceType       | 5s, 60s, 300s, 3600s, 86400s                    |
| `ProxyMemoryUseRate`               | Memory Utilization  | %    | InstanceId, InstanceType       | 5s, 60s, 300s, 3600s, 86400s                    |
| `ProxyQueries`                     | Query Count         | count | InstanceId, InstanceType       | 5s, 60s, 300s, 3600s, 86400s                    |
| `ProxyRouteMaster`                 | Write Request Count | count | InstanceId, InstanceType       | 5s, 60s, 300s, 3600s, 86400s                    |
| `ProxyRouteSlave`                  | Read Request Count  | count | InstanceId, InstanceType       | 5s, 60s, 300s, 3600s, 86400s                    |
| `ProxyMemoryUse`                   | Memory Usage        | MB   | InstanceId, InstanceType       | 5s, 60s, 300s, 3600s, 86400s                    |

### Deployment Monitoring (Standby)

| Metric English Name                | Metric Chinese Name   | Description             | Unit                                  | Dimensions                              | Statistical Granularity                     |
| ---------------------------------- | -------------------- | ----------------------- | ------------------------------------- | ---------------------------------------- | ------------------------------------------- |
| `MasterSlaveSyncDistance`          | Master-Slave Sync Distance | Difference in **binlog** between master and slave | MB                                      | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `SecondsBehindMaster`              | Master-Slave Delay Time | Delay time between master and slave | seconds                                | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `SlaveIoRunning`                   | IO Thread Status     | IO thread running status | Status value (0-Yes, 1-No, 2-Connecting) | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |
| `SlaveSqlRunning`                  | SQL Thread Status    | SQL thread running status | Status value (0-Yes, 1-No)             | InstanceId, InstanceType (optional)    | 5s, 60s, 300s, 3600s, 86400s              |

## Objects {#object}
Collected Tencent Cloud CDB object data structure can be viewed in "Infrastructure - Custom"

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
    "message"     : "{instance JSON data}"
  }
}
```

## Logs {#logging}

### Slow Query Statistics

#### Prerequisites

> Note 1: Before using this collector, the "Guance Integration Core Package" and its dependent third-party packages must be installed.
>
> Note 2: This script's code depends on CDB instance object collection. If CDB custom object collection is not configured, the slow log script cannot collect slow log data.

<!-- markdownlint-disable MD024 -->

#### Install Script

<!-- markdownlint-enable -->

On top of the previous setup, you need to install another script for collecting **CDB Slow Query Statistics Logs**

In "Management / Script Market", click and install the corresponding script package:

- "Guance Integration (Tencent Cloud-CDB Slow Query Log Collection)" (ID: `guance_tencentcloud_cdb_slowlog`)

After data synchronization is normal, you can view the data in the "Logs" section of Guance.

Sample reported data:

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
      "message"     : "{instance JSON data}"
  }
}
```

Part of the parameter descriptions are as follows:

| Field           | Type    | Description                 |
| :------------- | :------ | :-------------------------- |
| `QueryTime`    | float   | SQL execution duration (seconds) |
| `Timestamp`    | integer | SQL execution timestamp      |
| `Md5`          | str     | MD5 of SQL statement         |
| `LockTime`     | float   | Lock duration (seconds)      |
| `RowsExamined` | integer | Number of rows scanned       |
| `RowsSent`     | integer | Number of result set rows    |

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Note 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Note 2: `fields.message` is a JSON serialized string.