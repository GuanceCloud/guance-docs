---
title: 'Alibaba Cloud MongoDB'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud MongoDB Replica Set metrics display, including CPU usage, memory usage, disk usage, data disk space usage, log disk space usage, statements executed per second, number of requests, number of connections, network traffic, replication lag, QPS, etc.

Alibaba Cloud MongoDB Sharding Cluster metrics display, including CPU usage, memory usage, disk usage, data disk space usage, log disk space usage, statements executed per second, number of requests, number of connections, network traffic, replication lag, QPS, etc.

Alibaba Cloud MongoDB Single Node Instance metrics display, including CPU usage, memory usage, disk usage, data disk space usage, statements executed per second, number of requests, number of connections, network traffic, QPS, etc.'
__int_icon: 'icon/aliyun_mongodb'

dashboard:
  - desc: 'Alibaba Cloud MongoDB Replica Set built-in view'
    path: 'dashboard/en/aliyun_mongodb_replicaset/'
  - desc: 'Alibaba Cloud MongoDB Sharding Cluster built-in view'
    path: 'dashboard/en/aliyun_mongodb_sharding/'
  - desc: 'Alibaba Cloud MongoDB Single Node Instance built-in view'
    path: 'dashboard/en/aliyun_mongodb_singlenode/'

monitor:
  - desc: 'Alibaba Cloud MongoDB Replica Set monitor'
    path: 'monitor/en/aliyun_mongodb_replicaset/'
  - desc: 'Alibaba Cloud MongoDB Sharding Cluster monitor'
    path: 'monitor/en/aliyun_mongodb_sharding/'
  - desc: 'Alibaba Cloud MongoDB Single Node Instance monitor'
    path: 'monitor/en/aliyun_mongodb_singlenode/'
---

<!-- markdownlint-disable MD025 -->

# Alibaba Cloud
<!-- markdownlint-enable -->


Alibaba Cloud MongoDB Replica Set metrics display, including CPU usage, memory usage, disk usage, data disk space usage, log disk space usage, statements executed per second, number of requests, number of connections, network traffic, replication lag, QPS, etc.

Alibaba Cloud MongoDB Sharding Cluster metrics display, including CPU usage, memory usage, disk usage, data disk space usage, log disk space usage, statements executed per second, number of requests, number of connections, network traffic, replication lag, QPS, etc.

Alibaba Cloud MongoDB Single Node Instance metrics display, including CPU usage, memory usage, disk usage, data disk space usage, statements executed per second, number of requests, number of connections, network traffic, QPS, etc.

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - expansion - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.


If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


> It is recommended to deploy the GSE version

### Install Script

> Note: Please prepare the required Alibaba Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize ECS cloud resource monitoring data, we install the corresponding collection script: "Guance Integration (Alibaba Cloud-MongoDB Replica Set Collection)" (ID: `guance_aliyun_mongodb`)

Click 【Install】, then enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

After enabling, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】to run it immediately without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, you also need to enable the corresponding log collection script. If you need to collect billing data, you need to enable the cloud billing collection script.

We default to collecting some configurations, see the metrics section for details.

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, in "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, in "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}
By default, after configuring Alibaba Cloud - Cloud Monitoring, the following metrics are collected. You can collect more metrics through configuration.
For more metrics, please refer to: [Alibaba Cloud Cloud Monitoring Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

### Cloud Database MongoDB Edition - Replica Set

<!-- markdownlint-disable MD025 -->
| Metric Id                  |   MetricCategory   | Metric Name            | Dimensions             | Statistics                       | Unit      | Min Periods |
| ---- | :----: | ------ | ------ | ---- | ---- | ---- |
| `CPUUtilization`           | `mongodb_replicaset` | CPU Utilization        | userId,instanceId,role | Average,Minimum,Maximum          | %         | 60 s        |
| `ConnectionAmount`         | `mongodb_replicaset` | Connection Count       | userId,instanceId,role | Average,Minimum,Maximum          | Count     | 60 s        |
| `ConnectionUtilization`    | `mongodb_replicaset` | Connection Utilization | userId,instanceId,role | Average,Minimum,Maximum          | %         | 60 s        |
| `DataDiskAmount`           | `mongodb_replicaset` | Data Disk Usage        | userId,instanceId,role | Average,Minimum,Maximum          | bytes     | 60 s        |
| `DiskUtilization`          | `mongodb_replicaset` | Disk Utilization       | userId,instanceId,role | Average,Minimum,Maximum          | %         | 60 s        |
| `IOPSUtilization`          | `mongodb_replicaset` | IOPS Utilization       | userId,instanceId,role | Average,Minimum,Maximum          | %         | 60 s        |
| `InstanceDiskAmount`       | `mongodb_replicaset` | Instance Disk Usage    | userId,instanceId,role | Average,Minimum,Maximum          | bytes     | 60 s        |
| `IntranetIn`               | `mongodb_replicaset` | Intranet Inbound Traffic | userId,instanceId,role | Average,Minimum,Maximum          | bytes     | 60 s        |
| `IntranetOut`              | `mongodb_replicaset` | Intranet Outbound Traffic | userId,instanceId,role | Average,Minimum,Maximum          | bytes     | 60 s        |
| `LogDiskAmount`            | `mongodb_replicaset` | Log Disk Usage         | userId,instanceId,role | Average,Minimum,Maximum          | bytes     | 60 s        |
| `MemoryUtilization`        | `mongodb_replicaset` | Memory Utilization     | userId,instanceId,role | Average,Minimum,Maximum          | %         | 60 s        |
| `NumberRequests`           | `mongodb_replicaset` | Number of Requests     | userId,instanceId,role | Average,Minimum,Maximum          | Count     | 60 s        |
| `OpCommand`                | `mongodb_replicaset` | Command Operation Count | userId,instanceId,role | Average,Minimum,Maximum          | Frequency | 60 s        |
| `OpDelete`                 | `mongodb_replicaset` | Delete Operation Count | userId,instanceId,role | Average,Minimum,Maximum          | Frequency | 60 s        |
| `OpGetmore`                | `mongodb_replicaset` | **Getmore** Operation Count | userId,instanceId,role | Average,Minimum,Maximum          | Frequency | 60 s        |
| `OpInsert`                 | `mongodb_replicaset` | Insert Operation Count | userId,instanceId,role | Average,Minimum,Maximum          | Count     | 60 s        |
| `OpQuery`                  | `mongodb_replicaset` | Query Operation Count  | userId,instanceId,role | Average,Minimum,Maximum          | Frequency | 60 s        |
| `OpUpdate`                 | `mongodb_replicaset` | Update Operation Count | userId,instanceId,role | Average,Minimum,Maximum          | Frequency | 60 s        |
| `QPS`                      | `mongodb_replicaset` | Queries Per Second     | userId,instanceId,role | Average,Minimum,Maximum          | Count     | 60 s        |
| `ReplicationLag`           | `mongodb_replicaset` | Replication Lag        | userId,instanceId,role | Average,Maximum,Minimum,cms_null | seconds   | 60 s        |

<!-- markdownlint-enable -->

### Cloud Database MongoDB Edition - Sharding Cluster

<!-- markdownlint-disable MD025 -->

| Metric Id                          |  MetricCategory   | Metric Name                    | Dimensions                             | Statistics                 | Unit      | Min Periods |
|------------------------------------|:-----------------:|--------------------------------|----------------------------------------|----------------------------|-----------| ---- |
| `ShardingCPUUtilization`           | `mongodb_sharding` | CPU Utilization                | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | %         | 60 s        |
| `ShardingConnectionAmount`         | `mongodb_sharding` | Connection Count               | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Count     | 60 s        |
| `ShardingConnectionUtilization`    | `mongodb_sharding` | Connection Utilization         | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | %         | 60 s        |
| `ShardingDataDiskAmount`           | `mongodb_sharding` | Data Disk Usage                | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Bytes     | 60 s        |
| `ShardingDataDiskAmountOriginal`   | `mongodb_sharding` | Original Data Disk Usage       | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | -         | 60 s        |
| `ShardingDiskUtilization`          | `mongodb_sharding` | Disk Utilization               | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | %         | 60 s        |
| `ShardingIOPSUtilization`          | `mongodb_sharding` | IOPS Utilization               | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | %     | 60 s        |
| `ShardingInstanceDiskAmount`       | `mongodb_sharding` | Instance Disk Usage            | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Bytes     | 60 s        |
| `ShardingIntranetIn`               | `mongodb_sharding` | Intranet Inbound Traffic       | `userId,instanceId,subinstanceId,role` | Average                    | Bytes     | 60 s        |
| `ShardingIntranetOut`              | `mongodb_sharding` | Intranet Outbound Traffic      | `userId,instanceId,subinstanceId,role` | Average                    | Bytes     | 60 s        |
| `ShardingLogDiskAmount`            | `mongodb_sharding` | Log Disk Usage                 | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Bytes         | 60 s        |
| `ShardingMemoryUtilization`        | `mongodb_sharding` | Memory Utilization             | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | %     | 60 s        |
| `ShardingNumberRequests`           | `mongodb_sharding` | Number of Requests             | `userId,instanceId,subinstanceId,role` | Average                    | Count | 60 s        |
| `ShardingOpCommand`                | `mongodb_sharding` | Command Operation Count        | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Count | 60 s        |
| `ShardingOpDelete`                 | `mongodb_sharding` | Delete Operation Count         | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Count | 60 s        |
| `ShardingOpGetmore`                | `mongodb_sharding` | **Getmore** Operation Count    | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Count     | 60 s        |
| `ShardingOpInsert`                 | `mongodb_sharding` | Insert Operation Count         | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Count | 60 s        |
| `ShardingOpQuery`                  | `mongodb_sharding` | Query Operation Count          | `userId,instanceId,subinstanceId,role` | Average,Minimum,Maximum    | Count | 60 s        |

<!-- markdownlint-enable -->

### Cloud Database MongoDB Edition - Single Node Instance

<!-- markdownlint-disable MD025 -->

| Metric Id                       |   MetricCategory   | Metric Name | Dimensions        | Statistics                 | Unit  | Min Periods |
|---------------------------------|:------------------:|-----------| ------ |----------------------------|-------| ---- |
| `SingleNodeCPUUtilization`      | `mongodb_singlenode` | CPU Utilization    | userId,instanceId | Average,Minimum,Maximum    | %     | 60 s        |
| `SingleNodeConnectionAmount`    | `mongodb_singlenode` | Connection Count    | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeConnectionUtilization` | `mongodb_singlenode` | Connection Utilization    | userId,instanceId | Average,Minimum,Maximum    | %     | 60 s        |
| `SingleNodeDataDiskAmount`      | `mongodb_singlenode` | Data Disk Usage | userId,instanceId | Average,Minimum,Maximum    | bytes | 60 s        |
| `SingleNodeDiskUtilization`     | `mongodb_singlenode` | Disk Utilization     | userId,instanceId | Average,Minimum,Maximum    | %     | 60 s        |
| `SingleNodeIntranetIn`          | `mongodb_singlenode` | Intranet Inbound Traffic     | userId,instanceId | Average,Minimum,Maximum    | bytes | 60 s        |
| `SingleNodeIntranetOut`         | `mongodb_singlenode` | Intranet Outbound Traffic     | userId,instanceId | Average,Minimum,Maximum    | bytes | 60 s        |
| `SingleNodeMemoryUtilization`   | `mongodb_singlenode` | Memory Utilization     | userId,instanceId | Average,Minimum,Maximum    | %     | 60 s        |
| `SingleNodeNumberRequests`      | `mongodb_singlenode` | Number of Requests       | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeOpCommand`           | `mongodb_singlenode` | Command Operation Count | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeOpDelete`            | `mongodb_singlenode` | Delete Operation Count | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeOpGetmore`           | `mongodb_singlenode` | **Getmore** Operation Count | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeOpInsert`            | `mongodb_singlenode` | Insert Operation Count | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeOpQuery`             | `mongodb_singlenode` | Query Operation Count | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeOpUpdate`            | `mongodb_singlenode` | Update Operation Count | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |
| `SingleNodeQPS`                 | `mongodb_singlenode` | Queries Per Second       | userId,instanceId | Average,Minimum,Maximum    | Count | 60 s        |

<!-- markdownlint-enable -->

## Objects {#object}

The structure of collected Alibaba Cloud MongoDB objects can be viewed in "Infrastructure - Custom"

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
    "ReplicaSets"      : "{JSON connection address data}",
    "message"          : "{JSON instance data}",
  }
}

```

## Logs {#logging}

### Slow Query Logs

#### Prerequisites

> Note: The code execution of this script depends on the MongoDB instance object collection. If MongoDB custom object collection is not configured, the slow log script cannot collect slow log data.

#### Install Slow Query Collection Script

On top of the previous setup, you need to install a corresponding **MongoDB Slow Query Collection Script**

In the "Script Market - Official Script Market", go into "Details" and click to install the corresponding script package:

- "Guance Integration (Alibaba Cloud-MongoDB Slow Query Log Collection)" (ID: `guance_aliyun_mongodb`)

After the data is synchronized normally, you can view the data in the "Logs" section of Guance.

Example of reported data:

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

Explanation of some parameters:

<!-- markdownlint-disable MD025 -->

| Field                 | Type | Description                 |
| :------------------- | :--- | :------------------- |
| `QueryTimes`         | Int  | Execution duration, in milliseconds |
| `ExecutionStartTime` | Str  | Execution start time, UTC time |

<!-- markdownlint-enable -->

> *Note: The fields in `tags` and `fields` may change with subsequent updates*
>
> Note: `fields.message` is a JSON serialized string