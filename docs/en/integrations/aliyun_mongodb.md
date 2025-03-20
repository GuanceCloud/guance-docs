---
title: 'Alibaba Cloud MongoDB'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud MongoDB Replica Set Metrics Display, including CPU usage, memory usage, disk usage, data disk space occupied, log disk space occupied, number of statements executed per second, request count, connection count, network traffic, replication delay, QPS, etc.

Alibaba Cloud MongoDB Sharded Cluster Metrics Display, including CPU usage, memory usage, disk usage, data disk space occupied, log disk space occupied, number of statements executed per second, request count, connection count, network traffic, replication delay, QPS, etc.

Alibaba Cloud MongoDB Single Node Instance Metrics Display, including CPU usage, memory usage, disk usage, data disk space occupied, number of statements executed per second, request count, connection count, network traffic, QPS, etc.'
__int_icon: 'icon/aliyun_mongodb'

dashboard:
  - desc: 'Alibaba Cloud MongoDB Replica Set Built-in View'
    path: 'dashboard/en/aliyun_mongodb_replicaset/'
  - desc: 'Alibaba Cloud MongoDB Sharded Cluster Built-in View'
    path: 'dashboard/en/aliyun_mongodb_sharding/'
  - desc: 'Alibaba Cloud MongoDB Single Node Instance Built-in View'
    path: 'dashboard/en/aliyun_mongodb_singlenode/'

monitor:
  - desc: 'Alibaba Cloud MongoDB Replica Set Monitor'
    path: 'monitor/en/aliyun_mongodb_replicaset/'
  - desc: 'Alibaba Cloud MongoDB Sharded Cluster Monitor'
    path: 'monitor/en/aliyun_mongodb_sharding/'
  - desc: 'Alibaba Cloud MongoDB Single Node Instance Monitor'
    path: 'monitor/en/aliyun_mongodb_singlenode/'
---

<!-- markdownlint-disable MD025 -->

# Alibaba Cloud
<!-- markdownlint-enable -->


Alibaba Cloud MongoDB Replica Set Metrics Display, including CPU usage, memory usage, disk usage, data disk space occupied, log disk space occupied, number of statements executed per second, request count, connection count, network traffic, replication delay, QPS, etc.

Alibaba Cloud MongoDB Sharded Cluster Metrics Display, including CPU usage, memory usage, disk usage, data disk space occupied, log disk space occupied, number of statements executed per second, request count, connection count, network traffic, replication delay, QPS, etc.

Alibaba Cloud MongoDB Single Node Instance Metrics Display, including CPU usage, memory usage, disk usage, data disk space occupied, number of statements executed per second, request count, connection count, network traffic, QPS, etc.

## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> Integration - Extension - Managed Func: all prerequisites are automatically installed. Please continue with the script installation.


If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}


> It is recommended to deploy the GSE version.

### Installation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize ECS cloud resource monitoring data, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Alibaba Cloud - MongoDB Replica Set Collection)" (ID: `guance_aliyun_mongodb`)

After clicking 【Install】, input the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration." Click 【Execute】to execute immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you want to collect corresponding logs, you also need to enable the corresponding log collection script. If you want to collect bills, you need to enable the cloud bill collection script.



We default to collecting some configurations, for more details see the metrics section.

[Customize Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration. You can also check the corresponding task records and logs for any anomalies.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom," check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics," check if there is corresponding monitoring data.

## Metrics {#metric}
By configuring Alibaba Cloud - Cloud Monitoring, the following default metrics are collected. More metrics can be collected through configuration.
For more metrics, please refer to: [Alibaba Cloud Cloud Monitoring Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

### Cloud Database MongoDB Edition - Replica Set

<!-- markdownlint-disable MD025 -->
| Metric Id                  |   MetricCategory   | Metric Name            | Dimensions             | Statistics                       | Unit      | Min Periods |
| ---- | :----: | ------ | ------ | ---- | ---- | ---- |
| `CPUUtilization`           | `mongodb_replicaset` | CPU usage              | userId,instanceId,role | Average,Minimum,Maximum          | %         | 60 s        |
| `ConnectionAmount`         | `mongodb_replicaset` | Connection usage       | userId,instanceId,role | Average,Minimum,Maximum          | Count     | 60 s        |
| `ConnectionUtilization`    | `mongodb_replicaset` | Connection utilization | userId,instanceId,role | Average,Minimum,Maximum          | %         | 60 s        |
| `DataDiskAmount`           | `mongodb_replicaset` | Data disk space used   | userId,instanceId,role | Average,Minimum,Maximum          | bytes     | 60 s        |
| `DiskUtilization`          | `mongodb_replicaset` | Disk utilization       | userId,instanceId,role | Average,Minimum,Maximum          | %         | 60 s        |
| `IOPSUtilization`          | `mongodb_replicaset` | IOPS utilization       | userId,instanceId,role | Average,Minimum,Maximum          | %         | 60 s        |
| `InstanceDiskAmount`       | `mongodb_replicaset` | Instance disk space used | userId,instanceId,role | Average,Minimum,Maximum          | bytes     | 60 s        |
| `IntranetIn`               | `mongodb_replicaset` | Internal network inbound traffic | userId,instanceId,role | Average,Minimum,Maximum          | bytes     | 60 s        |
| `IntranetOut`              | `mongodb_replicaset` | Internal network outbound traffic | userId,instanceId,role | Average,Minimum,Maximum          | bytes     | 60 s        |
| `LogDiskAmount`            | `mongodb_replicaset` | Log disk space used    | userId,instanceId,role | Average,Minimum,Maximum          | bytes     | 60 s        |
| `MemoryUtilization`        | `mongodb_replicaset` | Memory utilization     | userId,instanceId,role | Average,Minimum,Maximum          | %         | 60 s        |
| `NumberRequests`           | `mongodb_replicaset` | Number of requests     | userId,instanceId,role | Average,Minimum,Maximum          | Count     | 60 s        |
| `OpCommand`                | `mongodb_replicaset` | Command operation count | userId,instanceId,role | Average,Minimum,Maximum          | Frequency | 60 s        |
| `OpDelete`                 | `mongodb_replicaset` | Delete operation count | userId,instanceId,role | Average,Minimum,Maximum          | Frequency | 60 s        |
| `OpGetmore`                | `mongodb_replicaset` | **Getmore** operation count | userId,instanceId,role | Average,Minimum,Maximum          | Frequency | 60 s        |
| `OpInsert`                 | `mongodb_replicaset` | Insert operation count | userId,instanceId,role | Average,Minimum,Maximum          | Count     | 60 s        |
| `OpQuery`                  | `mongodb_replicaset` | Query operation count  | userId,instanceId,role | Average,Minimum,Maximum          | Frequency | 60 s        |
| `OpUpdate`                 | `mongodb_replicaset` | Update operation count | userId,instanceId,role | Average,Minimum,Maximum          | Frequency | 60 s        |
| `QPS`                      | `mongodb_replicaset` | Average SQL queries per second | userId,instanceId,role | Average,Minimum,Maximum          | Count     | 60 s        |
| `ReplicationLag`           | `mongodb_replicaset` | Replication delay      | userId,instanceId,role | Average,Maximum,Minimum,cms_null | seconds   | 60 s        |

<!-- markdownlint-enable -->

### Cloud Database MongoDB Edition - Sharded Cluster

<!-- markdownlint-disable MD025 -->

| Metric Id                          |  MetricCategory   | Metric Name                    | Dimensions                             | Statistics                 | Unit      | Min Periods |
|------------------------------------|:-----------------:|--------------------------------|----------------------------------------|----------------------------|-----------| ---- |
| `ShardingCPUUtilization`           | `mongodb_sharding` | CPU usage                         | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | %         | 60 s        |
| `ShardingConnectionAmount`         | `mongodb_sharding` | Connection usage                         | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Count     | 60 s        |
| `ShardingConnectionUtilization`    | `mongodb_sharding` | Connection utilization                         | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | %         | 60 s        |
| `ShardingDataDiskAmount`           | `mongodb_sharding` | Data disk space used                      | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Bytes     | 60 s        |
| `ShardingDataDiskAmountOriginal`   | `mongodb_sharding` | ShardingDataDiskAmountOriginal | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | -         | 60 s        |
| `ShardingDiskUtilization`          | `mongodb_sharding` | Disk utilization                          | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | %         | 60 s        |
| `ShardingIOPSUtilization`          | `mongodb_sharding` | IOPS utilization                        | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | %     | 60 s        |
| `ShardingInstanceDiskAmount`       | `mongodb_sharding` | Disk space used                        | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Bytes     | 60 s        |
| `ShardingIntranetIn`               | `mongodb_sharding` | Internal network inbound traffic                          | `userId,instanceId,subinstanceId,role` | Average                    | Bytes     | 60 s        |
| `ShardingIntranetOut`              | `mongodb_sharding` | Internal network outbound traffic                          | `userId,instanceId,subinstanceId,role` | Average                    | Bytes     | 60 s        |
| `ShardingLogDiskAmount`            | `mongodb_sharding` | Log disk capacity used                    | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Bytes         | 60 s        |
| `ShardingMemoryUtilization`        | `mongodb_sharding` | Memory utilization                          | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | %     | 60 s        |
| `ShardingNumberRequests`           | `mongodb_sharding` | Number of requests                            | `userId,instanceId,subinstanceId,role` | Average                    | Count | 60 s        |
| `ShardingOpCommand`                | `mongodb_sharding` | Command operation count                    | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Count | 60 s        |
| `ShardingOpDelete`                 | `mongodb_sharding` | Delete operation count                     | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Count | 60 s        |
| `ShardingOpGetmore`                | `mongodb_sharding` | **Getmore** operation count                | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Count     | 60 s        |
| `ShardingOpInsert`                 | `mongodb_sharding` | Insert operation count                     | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Count | 60 s        |
| `ShardingOpQuery`                  | `mongodb_sharding` | Query operation count                      | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Count | 60 s        |

<!-- markdownlint-enable -->

### Cloud Database MongoDB Edition - Single Node Instance

<!-- markdownlint-disable MD025 -->

| Metric Id                       |   MetricCategory   | Metric Name | Dimensions        | Statistics                 | Unit  | Min Periods |
|---------------------------------|:------------------:|-----------| ------ |----------------------------|-------| ---- |
| `SingleNodeCPUUtilization`      | `mongodb_singlenode` | CPU usage    | userId,instanceId | Average,Minimum,Maximum    | %     | 60 s        |
| `SingleNodeConnectionAmount`    | `mongodb_singlenode` | Connection usage    | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeConnectionUtilization` | `mongodb_singlenode` | Connection utilization    | userId,instanceId | Average,Minimum,Maximum    | %     | 60 s        |
| `SingleNodeDataDiskAmount`      | `mongodb_singlenode` | Data disk space used | userId,instanceId | Average,Minimum,Maximum    | bytes | 60 s        |
| `SingleNodeDiskUtilization`     | `mongodb_singlenode` | Disk utilization     | userId,instanceId | Average,Minimum,Maximum    | %     | 60 s        |
| `SingleNodeIntranetIn`          | `mongodb_singlenode` | Internal network inbound traffic     | userId,instanceId | Average,Minimum,Maximum    | bytes | 60 s        |
| `SingleNodeIntranetOut`         | `mongodb_singlenode` | Internal network outbound traffic     | userId,instanceId | Average,Minimum,Maximum    | bytes | 60 s        |
| `SingleNodeMemoryUtilization`   | `mongodb_singlenode` | Memory utilization     | userId,instanceId | Average,Minimum,Maximum    | %     | 60 s        |
| `SingleNodeNumberRequests`      | `mongodb_singlenode` | Number of requests       | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeOpCommand`           | `mongodb_singlenode` | Command operation count | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeOpDelete`            | `mongodb_singlenode` | Delete operation count | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeOpGetmore`           | `mongodb_singlenode` | **Getmore** operation count | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeOpInsert`            | `mongodb_singlenode` | Insert operation count | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeOpQuery`             | `mongodb_singlenode` | Query operation count | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeOpUpdate`            | `mongodb_singlenode` | Update operation count | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeQPS`                 | `mongodb_singlenode` | QPS       | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |

<!-- markdownlint-enable -->

## Objects {#object}

The structure of Alibaba Cloud MongoDB objects collected can be viewed under "Infrastructure - Custom."

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
    "DBInstanceDescription": "Business System",
    "LockMode"             : "Unlock",
  },
  "fields": {
    "ExpireTime"       : "2020-11-18T08:47:11Z",
    "DBInstanceStorage": "20",
    "ReplicaSets"      : "{Connection Address JSON Data}",
    "message"          : "{Instance JSON Data}",
  }
}

```

## Logs {#logging}

### Slow Query Logs

#### Prerequisites

> Note: The code execution of this script depends on the collection of MongoDB instance objects. If MongoDB custom object collection is not configured, the slow log script cannot collect slow log data.

#### Install Slow Query Collection Script

On top of the previous steps, you need to install another script corresponding to **MongoDB Slow Query Collection**

In the "Script Market - Official Script Market," go to "Details" and click to install the corresponding script package:

- "<<< custom_key.brand_name >>> Integration (Alibaba Cloud - MongoDB Slow Query Log Collection)" (ID: `guance_aliyun_mongodb`)

After the data synchronizes normally, you can view the data in the "Logs" section of <<< custom_key.brand_name >>>.

An example of the reported data is as follows:

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
    "DBInstanceDescription": "Business System",
    "DBName"               : "local",
    "AccountName"          : "AliCloud Account for Script Development",
    "HostAddress"          : "11.xxx.xxx.xx",
    "TableName"            : "oplog",
  },
  "fields": {
    "SQLText"           : "{SQL Statement}",
    "ExecutionStartTime": "1",
    "QueryTimes"        : "1",
    "ReturnRowCounts"   : "1",
    "KeysExamined"      : "1",
    "DocsExamined"      : "1",
  }
}

```

Some parameter descriptions are as follows:

<!-- markdownlint-disable MD025 -->

| Field                 | Type | Description                 |
| :------------------- | :--- | :------------------- |
| `QueryTimes`         | Int  | Execution duration, unit in milliseconds |
| `ExecutionStartTime` | Str  | Execution start time, UTC time |

<!-- markdownlint-enable -->

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Note: `fields.message` is a JSON serialized string.
