---
title: 'Tencent Cloud CDB'
summary:  'Use the " Official Script Market " series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/tencent_cdb'
dashboard:

  - desc: 'Tencent Cloud CDB dashboard'
    path: 'dashboard/zh/tencent_cdb'

monitor:
  - desc: 'Tencent Cloud CDB monitor'
    path: 'monitor/zh/tencent_cdb'

---


<!-- markdownlint-disable MD025 -->
# Tencent Cloud CDB
<!-- markdownlint-enable -->

Use the「Official Script Market」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.


## Config {#config}

### Install Func

Recommend opening「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script
> Tip : Please prepare Tencent Cloud AK that meets the requirements in advance ( For simplicity's sake,You can directly grant the global read-only permission`ReadOnlyAccess`)

To synchronize the monitoring data of CLB Public cloud resources, we install the corresponding collection script : 「Guance Integration (Tencent Cloud - CDBCollect)」(ID : `guance_tencentcloud_clb`)

Click  [ Install ]  and enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

tap [ Deploy startup Script ]  , The system automatically creates `Startup` script sets, And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」Click [ Run ] , you can immediately execute once, without waiting for a regular time . After a while, you can view task execution records and corresponding logs.

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verify

1. Into「Management / Crontab Config」, Check whether the automatic triggering configuration exists for the corresponding task, and check whether the task records and logs are abnormal.
2. On the Observing cloud platform, click [ Infrastructure / Custom ] to check whether asset information exists.
3. On the observing cloud platform, click [ Metric ] to check whether monitoring data exists

## Metric {#metric}
Configure 「Guance Integration ( Tencent Cloud - CDBCollect)」,The default metric set is as follows. More metrics can be collected through configuration [TencentDB for MySQL Monitoring Metrics details](https://www.tencentcloud.com/document/product/248/11006){:target="_blank"}

### Resources monitoring

| Parameter      | Metric Name   |  Description                                                      |   Unit     |   Dimension                              |  Statistical Period                        |
| --------------- | ------------ | ------------------------------------------------------------ | ------- | -------------------------------- | ------------------------------ |
| `BytesReceived` | Private network inbound traffic   | Number of bytes received per second                                             | B/sec | InstanceId , InstanceType (optional) | 5s , 60s , 300s , 3600s , 86400s   |
| `BytesSent`     | Private network outbound traffic   | Number of bytes sent per second                                             | B/sec | InstanceId , InstanceType (optional) | 5s ,  60s ,  300s , 3600s , 86400s |
| `Capacity`      | Disk usage | Including the space taken up by the MySQL data directory and logs (**binlog**, **relaylog**, **undolog**, errorlog, and **slowlog**) | MB      | InstanceId , InstanceType (optional) | 5s ,  60s ,  300s , 3600s , 86400s |
| `CpuUseRate`    | CPU usage   | If overuse of idle resources is permitted, the CPU utilization may exceed 100%.          | %       | InstanceId , InstanceType  (optional)   | 5s ,  60s ,  300s , 3600s , 86400s |
| `IOPS`          | Input/output operations per second         | Input and output operations (or number of reads/writes) per second      | Times/sec  | InstanceId , InstanceType (optional)  | 5s ,  60s ,  300s , 3600s , 86400s |
| `MemoryUse`     | Memory usage    | If overuse of idle resources is permitted, the memory utilization may exceed 100%.              | MB      | InstanceId , InstanceType  (optional)   | 5s ,  60s ,  300s , 3600s , 86400s |
| `MemoryUseRate` | Memory utilization   | If overuse of idle resources is permitted, the memory utilization may exceed 100%.       | %       | InstanceId , InstanceType  (optional)   | 5s ,  60s ,  300s , 3600s , 86400s |
| `RealCapacity`  | Data usage | The space taken up by the MySQL data directory, excluding that by logs (**binlog**, **relaylog**, **undolog**, errorlog, or **slowlog**) | MB      | InstanceId , InstanceType  (optional)   | 5s ,  60s ,  300s , 3600s , 86400s |
| `VolumeRate`    | Disk utilization   | Used disk space / purchased instance space                      | %       | InstanceId , InstanceType  (optional)   | 5s ,  60s ,  300s , 3600s , 86400s |

### Engine (general) - MyISAM

|  Parameter         |  Metric Name             |  Description                     |   Unit  |   Dimension                              |  Statistical Period                          |
| ----------------- | --------------------- | --------------------------- | ---- | -------------------------------- | -------------------------------- |
| `KeyCacheHitRate` | **MyISAM** cache hit rate | Cache hit rate of the **MyISAM** engine | %    | InstanceId , InstanceType  (optional)   | 5s ,  60s ,  300s ,  3600s ,  86400s |
| `KeyCacheUseRate` | **MyISAM** cache utilization | Cache utilization of the **MyISAM** engine | %    | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s     |

### Engine (general) - InnoDB

|  Parameter            |  Metric Name                    |  Description                                |   Unit   |   Dimension                              |  Statistical Period                          |
| -------------------- | ---------------------------- | -------------------------------------- | ----- | -------------------------------- | -------------------------------- |
| `InnodbCacheHitRate` | **innodb** cache hit rate        | Cache hit ratio of the **InnoDB** engine            | %     | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s     |
| `InnodbCacheUseRate` | **InnoDB** cache utilization    | Cache utilization of the **InnoDB** engine         | %     | InstanceId , InstanceType  (optional)   | 5s ,  60s ,  300s ,  3600s ,  86400s |
| `InnodbNumOpenFiles` | Number of tables opened in the **InnoDB** engine currently | Number of tables opened in the **InnoDB** engine currently       | Table(s)   | InstanceId , InstanceType  (optional)   | 5s ,  60s ,  300s ,  3600s ,  86400s |
| `InnodbOsFileReads`  | Number of **InnoDB** disk reads       | Number of times disk files are read per second by the **InnoDB** engine  | Times/sec | InstanceId , InstanceType  (optional)   | 5s ,  60s ,  300s ,  3600s ,  86400s |
| `InnodbOsFileWrites` | Number of **InnoDB** disk writes        | Number of times disk files are written per second by the **InnoDB** engine    | Times/sec | InstanceId , InstanceType  (optional)   | 5s ,  60s ,  300s ,  3600s ,  86400s |
| `InnodbOsFsyncs`     | Number of fsync calls by **InnoDB**          | Number of times the fsync function is called per second by the **InnoDB** engine | Times/sec | InstanceId , InstanceType  (optional)   | 5s ,  60s ,  300s ,  3600s ,  86400s |

### Engine (general) - connection

|  Parameter           |  Metric Name      |  Description                                                      |   Unit   |   Dimension                              |  Statistical Period                      |
| ------------------- | -------------- | ------------------------------------------------------------ | ----- | -------------------------------- | ---------------------------- |
| `ConnectionUseRate` | Connection utilization   | Number of current connections/maximum number of connections allowed     | %     | InstanceId , InstanceType  (optional)   | 5s , 10s , 60s , 300s , 3600s    |
| `MaxConnections`    | Maximum number of connections    | Maximum number of connections allowed    | Connection(s)    | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `Qps`               | Number of queries processed per second | Number of SQL queries processed (including the execution of the INSERT, SELECT, UPDATE, DELETE, and REPLACE statements) in the database per second. It is a metric of the actual processing capability of TencentDB instances. | Times/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `ThreadsConnected`  | Current connections     | Number of current connections      | 个    | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `Tps`               | Transactions per second | Number of transactions performed in the database per second          | Transaction(s)/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |

### Engine (general) - access

|  Parameter     |  Metric Name  |  Description                                     |   Unit   |   Dimension                              |  Statistical Period                      |
| ------------- | ---------- | ------------------------------------------- | ----- | -------------------------------- | ---------------------------- |
| `ComDelete`   | Number of deletions     | Number of deletions per second                                  | Deletion(s)/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `ComInsert`   | Number of insertions     | Number of insertions per second                               | Insertion(s)/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `ComReplace`  | Number of replacements     | Number of replacements per second                                  | Replacement(s)/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 6400s  |
| `ComUpdate`   | Number of updates     | Number of updates per second                                  | Update(s)/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `Queries`     | Total number of queries   | All SQL statements executed, including SET and SHOW   | Times/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `QueryRate`   | Query rate | Actual QPS / recommended QPS           | %     | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `SelectCount` | Number of times the SELECT statement is executed     | Number of times the SELECT statement is executed per second          | Times/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `SelectScan`  | Number of full-table scans | Number of full-table scans performed   | Times/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `SlowQueries` | Number of slow queries   | Number of queries that take more than long_query_time to execute | Query/Queries    | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |

### Engine (general) - table

|  Parameter        |  Metric Name      |  Description              |   Unit   |   Dimension                              |  Statistical Period                      |
| ---------------- | -------------- | -------------------- | ----- | -------------------------------- | ---------------------------- |
| `CreatedTmpTables` | Number of temp tables | Number of temp tables created     | Table(s)/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `TableLocksWaited` | Number of table lock waits   | Number of table locks that cannot be obtained immediately | Times/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `OpenedTables`   | Number of opened tables | Number of tables opened by the engine  | Table(s) | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `TableLocksImmediate`| Number of table locks released immediately | Number of table locks released immediately by the engine  | Lock(s) | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |


### Engine (extended) - Tmp

|  Parameter              |  Metric Name      |  Description                  |   Unit   |   Dimension                              |  Statistical Period                      |
| ---------------------- | -------------- | ------------------------ | ----- | -------------------------------- | ---------------------------- |
| `CreatedTmpDiskTables` | Number of temp disk tables | Number of temp disk tables created per second | Times/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `CreatedTmpFiles`      | Number of temporary files   | Number of temporary files created per second   | Times/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |

### Engine (extended) - key

|  Parameter          |  Metric Name              |  Description                                 |   Unit   |   Dimension                              |  Statistical Period                      |
| ------------------ | ---------------------- | --------------------------------------- | ----- | -------------------------------- | ---------------------------- |
| `KeyBlocksUnused`  | Number of unused blocks in the key cache | Number of unused blocks in the **myisam** key cache     | Block(s)    | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `KeyBlocksUsed`    | Number of used blocks in the key cache   | Number of used blocks in the **myisam** key cache     | Block(s)    | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `KeyReadRequests`  | Number of data block reads from the key cache   | Number of times the **myisam** engine reads data blocks from the key cache   | Times/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `KeyReads`         | Number of data block reads from the hard disk     | Number of times the **myisam** engine reads data blocks from the hard disk per second | Times/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `KeyWriteRequests` | Number of data block writes into the key cache   | Number of times the **myisam** engine writes data blocks into the key cache     | Times/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `KeyWrites`        | Number of data block writes into the hard disk     | Number of times the **myisam** engine writes data blocks into the hard disk per second   | Times/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |

### Engine (extended) - InnoDB row

|  Parameter              |  Metric Name                           |  Description                             |   Unit   |   Dimension                              |  Statistical Period                          |
| ---------------------- | ----------------------------------- | ----------------------------------- | ----- | -------------------------------- | -------------------------------- |
| `InnodbRowLockTimeAvg` | Average time of locking a InnoDB row | Average time the InnoDB engine spends locking a row     | ms    | InstanceId , InstanceType  (optional)   | 5s ,  60s ,  300s ,  3600s ,  86400s |
| `InnodbRowLockWaits`   | Number of InnoDB row lock waits             | Number of times the InnoDB engine waits to lock a row per second | Times/sec | InstanceId , InstanceType  (optional)   | 5s ,  60s ,  300s ,  3600s ,  86400s |
| `InnodbRowsDeleted`    | Number of rows deleted from InnoDB                | Number of rows deleted from the InnoDB engine per second       | Row(s)/sec | InstanceId , InstanceType  (optional)   | 5s ,  60s ,  300s ,  3600s ,  86400s |
| `InnodbRowsInserted`   | Number of rows inserted into InnoDB                | Number of rows inserted into the InnoDB engine per second       | Row(s)/sec | InstanceId , InstanceType  (optional)   | 5s ,  60s ,  300s ,  3600s ,  86400s |
| `InnodbRowsRead`       | Number of InnoDB row reads                 | Number of rows read by the InnoDB engine per second       | Row(s)/sec | InstanceId , InstanceType  (optional)   | 5s ,  60s ,  300s ,  3600s ,  86400s |
| `InnodbRowsUpdated`    | Number of updated InnoDB rows               | Number of rows updated by the InnoDB engine per second      | Row(s)/sec | InstanceId , InstanceType  (optional)   | 5s ,  60s ,  300s ,  3600s , 86400s  |

### Engine (extended) - InnoDB data

|  Parameter           |  Metric Name           |  Description                                     |   Unit     |   Dimension                              |  Statistical Period                      |
| ------------------- | ------------------- | ------------------------------------------- | ------- | -------------------------------- | ---------------------------- |
| `InnodbDataRead`    | Size of data read by InnoDB   | Size of data read by the InnoDB engine per second in bytes | B/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `InnodbDataReads`   | Total number of InnoDB data reads | Number of data reads handled by the InnoDB engine per second   | Times/sec  | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `InnodbDataWrites`  | Total number of InnoDB data writes | Number of data writes processed by the InnoDB engine per second     | Times/sec   | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `InnodbDataWritten` | Size of data written to InnoDB   | Size of data written to the InnoDB engine per second in bytes   | B/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |

### Engine monitoring (extended) - handler

|  Parameter            |  Metric Name      |  Description                  |   Unit   |   Dimension                              |  Statistical Period                      |
| -------------------- | -------------- | ------------------------ | ----- | -------------------------------- | ---------------------------- |
| `HandlerCommit`      | Number of internal commits     | Number of transaction commits per second    | Times/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `HandlerReadRndNext` | Number of read-next-row requests  | Number of requests to read the next row per second    | Times/sec | InstanceId , InstanceType (optional)  | 5s , 60s , 300s , 3600s , 86400s |
| `HandlerRollback`    | Number of internal rollbacks    | Number of transaction rollbacks per second     | Times/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |

### Engine (extended) - buffer

|  Parameter                      |  Metric Name                   |  Description                                     |   Unit   |   Dimension                              |  Statistical Period                          |
| ------------------------------ | --------------------------- | ------------------------------------------- | ----- | -------------------------------- | -------------------------------- |
| `InnodbBufferPoolPagesFree`    | Number of InnoDB blank pages           | Number of blank pages in the InnoDB buffer pool                 | Page(s)   | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s             |
| `InnodbBufferPoolPagesTotal`   | Total number of InnoDB pages           | Total number of memory pages taken up by the InnoDB engine               | Page(s)   | InstanceId , InstanceType  (optional)   | 5s ,  60s ,  300s ,  3600s ,  86400s |
| `InnodbBufferPoolReadRequests` | Number of times pages are pre-fetched into the InnoDB buffer pool | Number of logic read requests processed by the InnoDB engine per second | Times/sec | InstanceId , InstanceType  (optional)   | 5s ,  60s ,  300s ,  3600s ,  86400s |
| `InnodbBufferPoolReads`        | Number of InnoDB physical reads     | Number of physical read requests processed by the InnoDB engine per second | Times/sec | InstanceId , InstanceType  (optional)   | 5s ,  60s ,  300s ,  3600s ,  86400s |

### Engine (extended) - others

|  Parameter     |  Metric Name  |  Description              |   Unit   |   Dimension                              |  Statistical Period                     |
| ------------- | ---------- | -------------------- | ----- | -------------------------------- | --------------------------- |
| `LogCapacity` | Log usage | Size of logs used by the engine   | MB    | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s        |
| `OpenFiles`   | Number of opened files | Number of files opened by the engine | File(s)/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600 , 86400s |

### Engine (extended) - connection

|  Parameter        |  Metric Name      |  Description                    |   Unit  |   Dimension                              |  Statistical Period                      |
| ---------------- | -------------- | -------------------------- | ---- | -------------------------------- | ---------------------------- |
| `ThreadsCreated` | Number of created threads | Number of threads created to process connections   | Thread(s)   | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `ThreadsRunning` | Number of running threads   | Number of running (non-idle) threads | InstanceId, InstanceType (optional)   | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |

### Engine (extended) - access

|  Parameter     |  Metric Name  |  Description      |   Unit   |   Dimension                              |  Statistical Period                      |
| ------------- | ---------- | ------------ | ----- | -------------------------------- | ---------------------------- |
| `ComCommit`   | Number of commits     | Number of commits per second | Times/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `ComRollback` | Number of rollbacks     | Number of rollbacks per second | Times/sec | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |


### Deployment (replica)

|  Parameter                 |  Metric Name    |  Description              |   Unit                                 |   Dimension                              |  Statistical Period                      |
| ------------------------- | ------------ | -------------------- | ----------------------------------- | -------------------------------- | ---------------------------- |
| `MasterSlaveSyncDistance` | Source-replica delay in size | Source-replica **binlog** delay in size | MB                                  | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `SecondsBehindMaster`     | Source-replica delay in time | Source-replica delay in time         | Sec                                  | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `SlaveIoRunning`          | IO thread status  | IO thread status      | Values: 0: Yes; 1: No; 2: Connecting | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |
| `SlaveSqlRunning`         | SQL thread status | SQL thread status    | Values: 0: Yes; 1: No; 2: Connecting             | InstanceId , InstanceType  (optional)   | 5s , 60s , 300s , 3600s , 86400s |

## Object {#object}
The collected Tencent Cloud CDB object data structure can be seen from "Infrastructure - Custom"

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
    "message"     : "{Instance JSON data}"
  }
}
```

## Logging {#logging}

### Slow query statistics

#### Precondition

> Note: The execution of the script depends on CDB instance object collection. If the custom object collection of CDB is not configured, the slow log script cannot collect slow log data

<!-- markdownlint-disable MD024 -->

#### Installation script

<!-- markdownlint-enable -->

On the basis of the previous, you need to install another script ** that corresponds to the collection of CDB slow query statistics logs

In "Script Marketplace - Official Script Market", click and install the corresponding script package:

- 「Guance Integration ( Tencent Cloud - CDB Slow Query Log Collect)  」(ID : `guance_tencentcloud_cdb_slowlog`)

After data is synchronized, you can view the data in 'Logs' of the observation cloud.

The following is an example of the reported data:

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
    "account_name"  : "脚本开发用 腾讯 Tencent 账号",
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
      "message"     : "{Instance JSON data}"
  }
}
```

Some parameters are described as follows:

| Field           | Type    | Description         |
| :------------- | :------ | :------------------- |
| `QueryTime`    | float   | SQL execution time (seconds) |
| `Timestamp`    | integer | SQL execution timing      |
| `Md5`          | str     | MD5 of the SQL statement    |
| `LockTime`     | float   | Lock duration (seconds)       |
| `RowsExamined` | integer | Number of scanning lines             |
| `RowsSent`     | integer | Number of rows in the result set          |

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: `tags.name` is the instance ID as a unique identifier.
>
> Tip 2: `fields.message` is the JSON serialized string.
