---
title: 'Tencent Cloud CDB'
tags: 
  - Tencent Cloud
summary: 'Use the official script package from the script market to synchronize cloud monitoring and cloud asset data to Guance'
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

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant it read-only permissions `ReadOnlyAccess`)

To synchronize the monitoring data of Tencent Cloud CDB, install the corresponding collection script: "Guance Integration (Tencent Cloud-CDB Collection)" (ID: `guance_tencentcloud_cdb`)

After clicking 【Install】, enter the required parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Additionally, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】to run it immediately without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.


We have collected some configurations by default; for more details, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Tencent Cloud Cloud Monitoring Metric Details](https://cloud.tencent.com/document/product/248/45147){:target="_blank"}

### Resource Monitoring

| Metric Name      | Metric Description   | Explanation                                                     | Unit    | Dimensions                             | Statistical Granularity                       |
| --------------- | ------------ | ------------------------------------------------------------ | ------- | -------------------------------- | ------------------------------ |
| `BytesReceived` | Internal Network Inbound Traffic   | Number of bytes received per second                                             | Bytes/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s   |
| `BytesSent`     | Internal Network Outbound Traffic   | Number of bytes sent per second                                             | Bytes/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `Capacity`      | Disk Usage Space | Includes MySQL data directory and  `binlog, relaylog, undolog, errorlog, slowlog` log space | MB      | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `CpuUseRate`    | CPU Utilization   | Idle overuse allowed, CPU utilization may exceed 100%                         | %       | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `IOPS`          | IOPS         | Input/output operations per second                                 | ops/sec   | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `MemoryUse`     | Memory Usage     | Idle overuse allowed, actual memory usage may exceed purchased specifications                   | MB      | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `MemoryUseRate` | Memory Utilization   | Idle overuse allowed, memory utilization may exceed 100%                         | %       | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `RealCapacity`  | Data Usage Space | Only includes MySQL data directory, excluding  `binlog, relaylog, undolog, errorlog, slowlog` log space | MB      | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `VolumeRate`    | Disk Utilization   | Disk usage space / instance purchased space                                    | %       | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |

### Engine Monitoring (Standard) - **MyISAM**

| Metric Name        | Metric Description            | Explanation                    | Unit | Dimensions                             | Statistical Granularity                         |
| ----------------- | --------------------- | --------------------------- | ---- | -------------------------------- | -------------------------------- |
| `KeyCacheHitRate` | **myisam** Cache Hit Rate | **myisam** engine cache hit rate | %    | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `KeyCacheUseRate` | **myisam** Cache Usage Rate | **myisam** engine cache usage rate | %    | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s     |

### Engine Monitoring (Standard) - **InnoDB**

| Metric Name           | Metric Description                   | Explanation                               | Unit  | Dimensions                             | Statistical Granularity                         |
| -------------------- | ---------------------------- | -------------------------------------- | ----- | -------------------------------- | -------------------------------- |
| `InnodbCacheHitRate` | **innodb** Cache Hit Rate        | **Innodb** engine cache hit rate            | %     | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s     |
| `InnodbCacheUseRate` | **innodb** Cache Usage Rate        | **Innodb** engine cache usage rate            | %     | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s     |
| `InnodbNumOpenFiles` | Current Number of Open Tables in **InnoDB** | Number of currently open tables in **Innodb** engine        | count    | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s     |
| `InnodbOsFileReads`  | **innodb** Disk Reads        | Number of times **Innodb** engine reads disk files per second    | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s     |
| `InnodbOsFileWrites` | **innodb** Disk Writes        | Number of times **Innodb** engine writes disk files per second    | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s     |
| `InnodbOsFsyncs`     | **innodbfsyn** Count          | Number of times **Innodb** engine calls fsync function per second | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s     |

### Engine Monitoring (Standard) - Connections

| Metric Name          | Metric Description     | Explanation                                                     | Unit  | Dimensions                             | Statistical Granularity                     |
| ------------------- | -------------- | ------------------------------------------------------------ | ----- | -------------------------------- | ---------------------------- |
| `ConnectionUseRate` | Connection Utilization   | Current number of open connections / maximum connections                                    | %     | InstanceId, InstanceType (optional) | 5s, 10s, 60s, 300s, 3600s    |
| `MaxConnections`    | Maximum Connections     | Maximum number of connections                                                   | count    | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `Qps`               | Queries Per Second | Number of SQL queries executed per second (including insert, select, update, delete, replace). QPS mainly reflects the actual processing capability of the TencentDB instance | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `ThreadsConnected`  | Current Connections     | Number of currently open connections                                         | count    | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `Tps`               | Transactions Per Second | Number of transactions processed per second                                 | txns/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |

### Engine Monitoring (Standard) - Access

| Metric Name    | Metric Description | Explanation                                    | Unit  | Dimensions                             | Statistical Granularity                     |
| ------------- | ---------- | ------------------------------------------- | ----- | -------------------------------- | ---------------------------- |
| `ComDelete`   | Delete Count     | Number of deletes per second                                  | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `ComInsert`   | Insert Count     | Number of inserts per second                                  | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `ComReplace`  | Replace Count     | Number of replaces per second                                  | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 6400s  |
| `ComUpdate`   | Update Count     | Number of updates per second                                  | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `Queries`     | Total Query Volume   | All executed SQL statements, including set, show, etc      | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `QueryRate`   | Query Volume Ratio | Queries per second QPS / Recommended queries per second           | %     | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `SelectCount` | Select Count     | Number of selects per second                                  | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `SelectScan`  | Full Table Scan Count | Number of full table scans executed                      | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `SlowQueries` | Slow Query Count   | Number of queries taking longer than long_query_time seconds | count    | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |

### Engine Monitoring (Standard) - Tables

| Metric Name       | Metric Description     | Explanation             | Unit  | Dimensions                             | Statistical Granularity                     |
| ---------------- | -------------- | -------------------- | ----- | -------------------------------- | ---------------------------- |
| `CreatedTmpTables` | Temporary Tables Created | Number of temporary tables created     | tables/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `TableLocksWaited` | Times Waiting for Table Locks   | Number of times unable to immediately obtain a table lock | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `OpenedTables`   | Number of Opened Tables | Number of tables opened by the engine  | count | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `TableLocksImmediate`| Immediately Released Table Locks | Number of table locks released immediately by the engine  | count | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |

### Engine Monitoring (Extended) - **Tmp**

| Metric Name             | Metric Description     | Explanation                 | Unit  | Dimensions                             | Statistical Granularity                     |
| ---------------------- | -------------- | ------------------------ | ----- | -------------------------------- | ---------------------------- |
| `CreatedTmpDiskTables` | Disk Temporary Tables Created | Number of disk temporary tables created per second | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `CreatedTmpFiles`      | Temporary Files Created   | Number of temporary files created per second   | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |

### Engine Monitoring (Extended) - **Key**

| Metric Name         | Metric Description             | Explanation                                | Unit  | Dimensions                             | Statistical Granularity                     |
| ------------------ | ---------------------- | --------------------------------------- | ----- | -------------------------------- | ---------------------------- |
| `KeyBlocksUnused`  | Unused Key Buffer Blocks | Number of unused key buffer blocks in **myisam** engine     | count    | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `KeyBlocksUsed`    | Used Key Buffer Blocks   | Number of used key buffer blocks in **myisam** engine     | count    | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `KeyReadRequests`  | Key Buffer Read Requests   | Number of key buffer block reads per second in **myisam** engine   | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `KeyReads`         | Disk Reads | Number of disk reads per second in **myisam** engine   | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `KeyWriteRequests` | Key Buffer Write Requests | Number of key buffer block writes per second in **myisam** engine     | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `KeyWrites`        | Disk Writes | Number of disk writes per second in **myisam** engine   | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |

### Engine Monitoring (Extended) - **InnoDB Row**

| Metric Name             | Metric Description                          | Explanation                            | Unit  | Dimensions                             | Statistical Granularity                         |
| ---------------------- | ----------------------------------- | ----------------------------------- | ----- | -------------------------------- | -------------------------------- |
| `InnodbRowLockTimeAvg` | Average Time to Acquire Row Lock (ms) | Average duration of row locks in **Innodb** engine     | ms    | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `InnodbRowLockWaits`   | Row Lock Waits             | Number of times **Innodb** engine waits for row locks per second | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `InnodbRowsDeleted`    | Rows Deleted                 | Number of rows deleted per second in **Innodb** engine       | rows/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `InnodbRowsInserted`   | Rows Inserted                 | Number of rows inserted per second in **Innodb** engine       | rows/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `InnodbRowsRead`       | Rows Read                 | Number of rows read per second in **Innodb** engine       | rows/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `InnodbRowsUpdated`    | Rows Updated                 | Number of rows updated per second in **Innodb** engine       | rows/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |

### Engine Monitoring (Extended) - InnoDB Data

| Metric Name          | Metric Description          | Explanation                                    | Unit    | Dimensions                             | Statistical Granularity                     |
| ------------------- | ------------------- | ------------------------------------------- | ------- | -------------------------------- | ---------------------------- |
| `InnodbDataRead`    | **InnoDB** Data Read   | Number of bytes read per second in **Innodb** engine | Bytes/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `InnodbDataReads`   | **InnoDB** Total Reads | Number of reads completed per second in **Innodb** engine   | ops/sec   | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `InnodbDataWrites`  | **InnoDB** Total Writes | Number of writes completed per second in **Innodb** engine     | ops/sec   | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `InnodbDataWritten` | **InnoDB** Data Written | Number of bytes written per second in **Innodb** engine   | Bytes/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |

### Engine Monitoring (Extended) - **Handler**

| Metric Name           | Metric Description     | Explanation                 | Unit  | Dimensions                             | Statistical Granularity                     |
| -------------------- | -------------- | ------------------------ | ----- | -------------------------------- | ---------------------------- |
| `HandlerCommit`      | Internal Commits     | Number of transaction commits per second       | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `HandlerReadRndNext` | Next Row Read Requests | Number of next row read requests per second | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `HandlerRollback`    | Internal Rollbacks     | Number of transaction rollbacks per second     | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |

### Engine Monitoring (Extended) - **Buff**

| Metric Name                     | Metric Description                  | Explanation                                    | Unit  | Dimensions                             | Statistical Granularity                         |
| ------------------------------ | --------------------------- | ------------------------------------------- | ----- | -------------------------------- | -------------------------------- |
| `InnodbBufferPoolPagesFree`    | **InnoDB** Free Pages           | Number of free pages in **Innodb** engine memory                 | count    | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s             |
| `InnodbBufferPoolPagesTotal`   | **InnoDB** Total Pages           | Total number of pages used by **Innodb** engine memory               | count    | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `InnodbBufferPoolReadRequests` | **Innodb** Buffer Pool Pre-reads | Number of logical read requests completed per second in **Innodb** engine | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `InnodbBufferPoolReads`        | **Innodb** Disk Reads     | Number of physical read requests completed per second in **Innodb** engine | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |

### Engine Monitoring (Extended) - Other

| Metric Name    | Metric Description | Explanation             | Unit  | Dimensions                             | Statistical Granularity                    |
| ------------- | ---------- | -------------------- | ----- | -------------------------------- | --------------------------- |
| `LogCapacity` | Log Usage | Number of logs used by the engine   | MB    | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s        |
| `OpenFiles`   | Open File Count | Number of files opened by the engine | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |

### Engine Monitoring (Extended) - Connections

| Metric Name       | Metric Description     | Explanation                   | Unit | Dimensions                             | Statistical Granularity                     |
| ---------------- | -------------- | -------------------------- | ---- | -------------------------------- | ---------------------------- |
| `ThreadsCreated` | Created Threads Count | Number of threads created to handle connections   | count   | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `ThreadsRunning` | Running Threads Count   | Number of active (non-sleeping state) threads | count   | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |

### Engine Monitoring (Extended) - Access

| Metric Name    | Metric Description | Explanation     | Unit  | Dimensions                             | Statistical Granularity                     |
| ------------- | ---------- | ------------ | ----- | -------------------------------- | ---------------------------- |
| `ComCommit`   | Commit Count     | Number of commits per second | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `ComRollback` | Rollback Count     | Number of rollbacks per second | ops/sec | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |

### Database Proxy (Proxy)

| Metric Name                | Metric Description | Unit | Dimensions                     | Statistical Granularity                         |
| ------------------------- | ---------- | ---- | ------------------------ | -------------------------------- |
| `ProxyCpuUseRate`         | CPU Utilization | %    | InstanceId, InstanceType | 5s, 60s, 300s, 3600s, 86400s     |
| `ProxyCurrentConnections` | Current Connections | count   | InstanceId, InstanceType | 5s, 60s, 300s, 3600s, 86400s |
| `ProxyMemoryUseRate`      | Memory Utilization | %    | InstanceId, InstanceType | 5s, 60s, 300s, 3600s, 86400s |
| `ProxyQueries`            | Request Count     | count   | InstanceId, InstanceType | 5s, 60s, 300s, 3600s, 86400s |
| `ProxyRouteMaster`        | Write Request Count   | count   | InstanceId, InstanceType | 5s, 60s, 300s, 3600s, 86400s |
| `ProxyRouteSlave`         | Read Request Count   | count   | InstanceId, InstanceType | 5s, 60s, 300s, 3600s, 86400s |
| `ProxyMemoryUse`          | Memory Usage   | MB   | InstanceId, InstanceType | 5s, 60s, 300s, 3600s, 86400s |

### Deployment Monitoring (Secondary)

| Metric Name                | Metric Description   | Explanation             | Unit                                | Dimensions                             | Statistical Granularity                     |
| ------------------------- | ------------ | -------------------- | ----------------------------------- | -------------------------------- | ---------------------------- |
| `MasterSlaveSyncDistance` | Master-Slave Sync Distance | Binlog gap between master and slave | MB                                  | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `SecondsBehindMaster`     | Master-Slave Sync Delay | Delay time between master and slave         | Seconds                                  | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `SlaveIoRunning`          | IO Thread Status  | IO thread running status      | Status value (0-Yes, 1-No, 2-Connecting) | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |
| `SlaveSqlRunning`         | SQL Thread Status | SQL thread running status     | Status value (0-Yes, 1-No)               | InstanceId, InstanceType (optional) | 5s, 60s, 300s, 3600s, 86400s |

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
    "message"     : "{instance JSON data}"
  }
}
```

## Logs {#logging}

### Slow Query Statistics

#### Prerequisites

> Note 1: Before using this collector, you must install the "Guance Integration Core Package" and its dependent third-party packages
>
> Note 2: This script depends on the collection of CDB instance objects. If CDB custom object collection is not configured, the slow query log script cannot collect slow query log data

<!-- markdownlint-disable MD024 -->

#### Install Script

<!-- markdownlint-enable -->

On top of the previous setup, you need to install another script for collecting CDB slow query statistics logs.

In "Management / Script Market," click and install the corresponding script package:

- "Guance Integration (Tencent Cloud-CDB Slow Query Log Collection)" (ID: `guance_tencentcloud_cdb_slowlog`)

After data synchronization is successful, you can view the data in the "Logs" section of Guance.

Example of reported data:

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
    "account_name"  : "Script Development Account for Tencent",
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

Explanation of some parameters:

| Field           | Type    | Description                 |
| :------------- | :------ | :------------------- |
| `QueryTime`    | float   | Execution time of the SQL (seconds) |
| `Timestamp`    | integer | Execution timestamp of the SQL       |
| `Md5`          | str     | MD5 hash of the SQL statement       |
| `LockTime`     | float   | Lock time (seconds)         |
| `RowsExamined` | integer | Number of rows scanned             |
| `RowsSent`     | integer | Number of rows returned in result set           |

> *Note: Fields in `tags`, `fields` may change with subsequent updates.*
>
> Note 1: The value of `tags.name` is the instance ID, used for unique identification.
>
> Note 2: `fields.message` is a JSON serialized string.