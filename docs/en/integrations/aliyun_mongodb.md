---
title: 'Alibaba Cloud MongoDB'
summary: 'Alibaba Cloud MongoDB replica set metrics display, including CPU usage, memory usage, disk usage, data disk space, log disk space, statement execution times per second, requests, connections, network traffic, replication latency, QPS, etc.'
__int_icon: 'icon/aliyun_mongodb'
Alibaba Cloud MongoDB shard cluster metrics display, including CPU usage, memory usage, disk usage, data disk space, log disk space, statement execution times per second, requests, connections, network traffic, replication latency, QPS, 

Alibaba Cloud MongoDB single node example metrics display, including CPU usage, memory usage, disk usage, disk space occupied by data, statement execution times per second, requests, connections, network traffic, QPS, etc.
__int_icon: 'icon/aliyun_mongodb_replicaset'

dashboard:
- desc: 'Alibaba Cloud MongoDB replicaset built-in view'
  path: 'dashboard/en/aliyun_mongodb_replicaset/'
- desc: 'Alibaba Cloud MongoDB sharded cluster built-in view'
  path: 'dashboard/en/aliyun_mongodb_sharding/'
- desc: 'Alibaba Cloud MongoDB single-node instance built-in view'
  path: 'dashboard/en/aliyun_mongodb_singlenode/'

monitor:
- desc: 'Alibaba Cloud MongoDB replicaset monitor'
  path: 'monitor/en/aliyun_mongodb_replicaset/'
- desc: 'Alibaba Cloud MongoDB sharded cluster monitor'
  path: 'monitor/en/aliyun_mongodb_sharding/'
- desc: 'Alibaba Cloud MongoDB single-node instance monitor'
  path: 'monitor/en/aliyun_mongodb_singlenode/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud
<!-- markdownlint-enable -->
Alibaba Cloud MongoDB replica set metrics display, including CPU usage, memory usage, disk usage, data disk space, log disk space, statement execution times per second, requests, connections, network traffic, replication latency, QPS, etc.

Alibaba Cloud MongoDB shard cluster metrics display, including CPU usage, memory usage, disk usage, data disk space, log disk space, statement execution times per second, requests, connections, network traffic, replication latency, QPS, etc.

Alibaba Cloud MongoDB single node example metrics display, including CPU usage, memory usage, disk usage, disk space occupied by data, statement execution times per second, requests, connections, network traffic, QPS, etc.

## Config {#config}

### Install Func

It is recommended to open Guance Integration-Extension-hosted Func: all preconditions are automatically installed, please continue with the script installation.

If their own deployment Func reference [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target = "_blank"}

> The GSE version is recommended

### Install scripts

> Tip: Please prepare the required Ali Cloud AK in advance (for simplicity, you can directly grant the global read-only permission 'ReadOnlyAccess')

To synchronize the monitoring data of ECS cloud resources, we install the corresponding acquisition script: 「Guance Integration（Aliyun - MongoDB Collect）」 (ID: 'guance_aliyun_mongodb')



After clicking "Install", input the corresponding parameters: Ali Cloud AK, Ali cloud account name.



Click [Deploy Startup Script], the system will automatically create the 'Startup' script set, and automatically configure the corresponding startup script.



Once enabled, you can see the corresponding auto-trigger configuration under 「Management / Crontab Config」. Click "Run", you can immediately execute once, without waiting for a regular time. After a few moments, you can review the execution of the task and the corresponding log.



> If you want to ingest the corresponding log, you should also enable the corresponding log ingest script. If you want to collect a bill, start the cloud bill collection script.

We collect some configurations by default, as described in the metrics column

[Configuring custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Validation



1. In 「Management / Crontab Config」, confirm whether the corresponding automatic trigger configuration exists for the corresponding task, and check whether there is an exception in the corresponding task record and log

2. Check the presence of asset information in the Guance platform, 「Infrastructure / Custom」

3. In the Guance platform, 「Metrics」checks whether there is corresponding monitoring data.

## Metrics {#metric}

Ali Cloud-cloud monitoring is configured, the default collection metrics are as follows, and more metrics can be collected through configuration.

For more metrics, please refer to: [Aliyun Cloud monitoring metrics details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

### MongoDB Cloud Edition - Replica Set

<!-- markdownlint-disable MD025 -->
| Metric Id                  |   MetricCategory   | Metric Name            | Dimensions             | Statistics                       | Unit      | Min Periods |
| ---- | :----: | ------ | ------ | ---- | ---- | ---- |
| CPUUtilization             | **mongodb_replicaset** | CPU utilization              | userId,instanceId,role | Average,Minimum,Maximum          | %         | 60 s        |
| ConnectionAmount           | **mongodb_replicaset** | Connection Usage           | userId,instanceId,role | Average,Minimum,Maximum          | Count     | 60 s        |
| ConnectionUtilization      | **mongodb_replicaset** | Connection Utilization     | userId,instanceId,role | Average,Minimum,Maximum          | %         | 60 s        |
| DataDiskAmount             | **mongodb_replicaset** | The amount of disk space the data takes up     | userId,instanceId,role | Average,Minimum,Maximum          | bytes     | 60 s        |
| DiskUtilization            | **mongodb_replicaset** | Disk Utilization             | userId,instanceId,role | Average,Minimum,Maximum          | %         | 60 s        |
| IOPSUtilization            | **mongodb_replicaset** | IOPS Utilization             | userId,instanceId,role | Average,Minimum,Maximum          | %         | 60 s        |
| InstanceDiskAmount         | **mongodb_replicaset** | The amount of disk space the instance takes up     | userId,instanceId,role | Average,Minimum,Maximum          | bytes     | 60 s        |
| IntranetIn                 | **mongodb_replicaset** | Network incoming traffic             | userId,instanceId,role | Average,Minimum,Maximum          | bytes     | 60 s        |
| IntranetOut                | **mongodb_replicaset** | Network outgoing traffic             | userId,instanceId,role | Average,Minimum,Maximum          | bytes     | 60 s        |
| LogDiskAmount              | **mongodb_replicaset** | The amount of disk space the log takes up     | userId,instanceId,role | Average,Minimum,Maximum          | bytes     | 60 s        |
| MemoryUtilization          | **mongodb_replicaset** | Memory Utilization           | userId,instanceId,role | Average,Minimum,Maximum          | %         | 60 s        |
| NumberRequests             | **mongodb_replicaset** | Number of requests                 | userId,instanceId,role | Average,Minimum,Maximum          | Count     | 60 s        |
| OpCommand                  | **mongodb_replicaset** | Number of Command operations        | userId,instanceId,role | Average,Minimum,Maximum          | Frequency | 60 s        |
| OpDelete                   | **mongodb_replicaset** | Number of Delete operations         | userId,instanceId,role | Average,Minimum,Maximum          | Frequency | 60 s        |
| OpGetmore                  | **mongodb_replicaset** | Number of Getmore operations       | userId,instanceId,role | Average,Minimum,Maximum          | Frequency | 60 s        |
| OpInsert                   | **mongodb_replicaset** | Number of Insert operations         | userId,instanceId,role | Average,Minimum,Maximum          | Count     | 60 s        |
| OpQuery                    | **mongodb_replicaset** | Number of Query operations          | userId,instanceId,role | Average,Minimum,Maximum          | Frequency | 60 s        |
| OpUpdate                   | **mongodb_replicaset** | Number of Update operations         | userId,instanceId,role | Average,Minimum,Maximum          | Frequency | 60 s        |
| QPS                        | **mongodb_replicaset** | Average SQL queries per second      | userId,instanceId,role | Average,Minimum,Maximum          | Count     | 60 s        |
| ReplicationLag             | **mongodb_replicaset** | Replication latency               | userId,instanceId,role | Average,Maximum,Minimum,cms_null | seconds   | 60 s        |

<!-- markdownlint-enable -->

### MongoDB Cloud - Sharded Cluster

<!-- markdownlint-disable MD025 -->

| Metric Id                          |  MetricCategory   | Metric Name                    | Dimensions                             | Statistics                 | Unit      | Min Periods |
|------------------------------------|:-----------------:|--------------------------------|----------------------------------------|----------------------------|-----------| ---- |
| ShardingCPUUtilization             | mongodb_sharding  | CPU utilization                | userId,instanceId,**subinstanceId**,role   | Average,Minimum,Maximum    | %         | 60 s        |
| ShardingConnectionAmount           | mongodb_sharding  | Connection Usage               | userId,instanceId,**subinstanceId**,role   | Average,Minimum,Maximum    | Count     | 60 s        |
| ShardingConnectionUtilization      | mongodb_sharding  | Connection Utilization         | userId,instanceId,**subinstanceId**,role   | Average,Minimum,Maximum    | %         | 60 s        |
| ShardingDataDiskAmount             | mongodb_sharding  | The amount of disk space the data takes up     | userId,instanceId,**subinstanceId**,role   | Average,Minimum,Maximum    | Bytes     | 60 s        |
| ShardingDataDiskAmountOriginal     | mongodb_sharding  | ShardingDataDiskAmountOriginal | userId,instanceId,**subinstanceId**,role   | Average,Minimum,Maximum    | -         | 60 s        |
| ShardingDiskUtilization            | mongodb_sharding  | Disk Utilization                          | userId,instanceId,**subinstanceId**,role   | Average,Minimum,Maximum    | %         | 60 s        |
| ShardingIOPSUtilization            | mongodb_sharding  | IOPS Utilization                        | userId,instanceId,**subinstanceId**,role   | Average,Minimum,Maximum    | %     | 60 s        |
| ShardingInstanceDiskAmount         | mongodb_sharding  | Amount of disk space taken up                        | userId,instanceId,**subinstanceId**,role   | Average,Minimum,Maximum    | Bytes     | 60 s        |
| ShardingIntranetIn                 | mongodb_sharding  | Network incoming traffic                          | userId,instanceId,**subinstanceId**,role   | Average                    | Bytes     | 60 s        |
| ShardingIntranetOut                | mongodb_sharding  | Network outgoing traffic                          | userId,instanceId,**subinstanceId**,role   | Average                    | Bytes     | 60 s        |
| ShardingLogDiskAmount              | mongodb_sharding  | Disk space used by the log                    | userId,instanceId,**subinstanceId**,role   | Average,Minimum,Maximum    | Bytes         | 60 s        |
| ShardingMemoryUtilization          | mongodb_sharding  | Memory Utilization                          | userId,instanceId,**subinstanceId**,role   | Average,Minimum,Maximum    | %     | 60 s        |
| ShardingNumberRequests             | mongodb_sharding  | Number of requests                            | userId,instanceId,**subinstanceId**,role   | Average                    | Count | 60 s        |
| ShardingOpCommand                  | mongodb_sharding  | Number of Command operations                    | userId,instanceId,**subinstanceId**,role   | Average,Minimum,Maximum    | Count | 60 s        |
| ShardingOpDelete                   | mongodb_sharding  | Number of Delete operations                     | userId,instanceId,**subinstanceId**,role   | Average,Minimum,Maximum    | Count | 60 s        |
| ShardingOpGetmore                  | mongodb_sharding  | Number of Getmore operations                    | userId,instanceId,**subinstanceId**,role   | Average,Minimum,Maximum    | Count     | 60 s        |
| ShardingOpInsert                   | mongodb_sharding  | Number of Insert operations                     | userId,instanceId,**subinstanceId**,role   | Average,Minimum,Maximum    | Count | 60 s        |
| ShardingOpQuery                    | mongodb_sharding  | Number of Query operations                      | userId,instanceId,**subinstanceId**,role   | Average,Minimum,Maximum    | Count | 60 s        |

<!-- markdownlint-enable -->

### Cloud Database MongoDB Edition - Single Node instance

<!-- markdownlint-disable MD025 -->

| Metric Id                       |   MetricCategory   | Metric Name | Dimensions        | Statistics                 | Unit  | Min Periods |
|---------------------------------|:------------------:|-----------| ------ |----------------------------|-------| ---- |
| SingleNodeCPUUtilization        | **mongodb_singlenode** | CPU utilization    | userId,instanceId | Average,Minimum,Maximum    | %     | 60 s        |
| SingleNodeConnectionAmount      | **mongodb_singlenode** | Connection Usage    | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| SingleNodeConnectionUtilization | **mongodb_singlenode** | Connection Utilization    | userId,instanceId | Average,Minimum,Maximum    | %     | 60 s        |
| SingleNodeDataDiskAmount        | **mongodb_singlenode** | The amount of disk space the data takes up | userId,instanceId | Average,Minimum,Maximum    | bytes | 60 s        |
| SingleNodeDiskUtilization       | **mongodb_singlenode** | Disk Utilization      | userId,instanceId | Average,Minimum,Maximum    | %     | 60 s        |
| SingleNodeIntranetIn            | **mongodb_singlenode** | Network incoming traffic     | userId,instanceId | Average,Minimum,Maximum    | bytes | 60 s        |
| SingleNodeIntranetOut           | **mongodb_singlenode** | Network outgoing traffic     | userId,instanceId | Average,Minimum,Maximum    | bytes | 60 s        |
| SingleNodeMemoryUtilization     | **mongodb_singlenode** | Memory Utilization     | userId,instanceId | Average,Minimum,Maximum    | %     | 60 s        |
| SingleNodeNumberRequests        | **mongodb_singlenode** | Number of requests       | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| SingleNodeOpCommand             | **mongodb_singlenode** | Number of Command operations | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| SingleNodeOpDelete              | **mongodb_singlenode** | Number of Delete operations | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| SingleNodeOpGetmore             | **mongodb_singlenode** | Number of Getmore operations | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| SingleNodeOpInsert              | **mongodb_singlenode** | Number of Insert operations | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| SingleNodeOpQuery               | **mongodb_singlenode** | Number of Query operations | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| SingleNodeOpUpdate              | **mongodb_singlenode** | Number of Update operations | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| SingleNodeQPS                   | **mongodb_singlenode** | Queries Per Second       | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |

<!-- markdownlint-enable -->

## object {#object}

The collected Ali Cloud MongoDB object data structure, you can see the object data from the "Infrastructure-custom"

```json
{
  "measurement": "aliyun_mongodb",
  "tags": {
    "name"                 : "dds-bpxxxxxxxx",
    "DBInstanceType"       : "replicate",
    "ChargeType"           : "PrePaid",
    "Engine"               : "MongoDB",
    "DBInstanceClass"      : "dds.xxxxxxxx",
    "DBInstanceId"         : "dds-bpxxxxxxx",
    "ZoneId"               : "cn-hangzhou",
    "RegionId"             : "cn-hangzhou-h",
    "VPCId"                : "vpc-bpxxxxxxxx",
    "EngineVersion"        : "4.2",
    "CurrentKernelVersion" : "mongodb_20210204_4.0.14",
    "StorageEngine"        : "WiredTiger",
    "LockMode"             : "Unlock",
  },
  "fields": {
    "ExpireTime"       : "2020-11-18T08:47:11Z",
    "DBInstanceStorage": "20",
  }
}

```

## logging

### Slow query logs

#### Prerequisites

> Note: The code of this script depends on mongodb instance object collection to run. If mongodb's custom object collection is not configured, the slow log script cannot collect slow log data

#### Install the slow query ingest script

To start with, install a script for **MongoDB slow query ingestion**

In "Script Market - Official Script Market", go to "Details" and click to install the corresponding script package:

- 「Guance Integration（Aliyun -MongoDB Slow Query Log Collect）」 (ID: 'guance_aliyun_mongodb')

After the data is synchronized normally, the data can be viewed in the 「 logging 」 of the Guance.

Examples of reported data are as follows:

```json
{
  "measurement": "aliyun_mongodb_slowlog",
  "tags": {
    "name"                 : "dds-bpxxxxxxxx",
    "DBInstanceType"       : "replicate",
    "ChargeType"           : "PrePaid",
    "Engine"               : "MongoDB",
    "DBInstanceClass"      : "dds.xxxxxxxx",
    "DBInstanceId"         : "dds-bpxxxxxxx",
    "ZoneId"               : "cn-hangzhou",
    "RegionId"             : "cn-hangzhou-h",
    "VPCId"                : "vpc-bpxxxxxxxx",
    "EngineVersion"        : "4.2",
    "CurrentKernelVersion" : "mongodb_20210204_4.0.14",
    "StorageEngine"        : "WiredTiger",
    "DBName"               : "local",
    "HostAddress"          : "11.xxx.xxx.xx",
    "TableName"            : "oplog",
  },
  "fields": {
    "ExecutionStartTime": "1",
    "QueryTimes"        : "1",
    "ReturnRowCounts"   : "1",
    "KeysExamined"      : "1",
    "DocsExamined"      : "1",
  }
}

```

Some parameters are explained as follows:

<!-- markdownlint-disable MD025 -->

| field                 | type | illustrate                 |
| :------------------- | :--- | :------------------- |
| `QueryTimes`         | Int  | Execution time, in milliseconds |
| `ExecutionStartTime` | Str  | Execution start time,UTC time |

<!-- markdownlint-enable -->

> *Notice：`tags`、`fields` The fields in are subject to change with subsequent updates*
>
> Remind：`fields.message` is a JSON serialized string.

