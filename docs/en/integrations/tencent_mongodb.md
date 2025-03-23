---
title: 'Tencent Cloud MongoDB'
tags: 
  - Tencent Cloud
summary: 'Use the script packages in the Script Market of the "<<< custom_key.brand_name >>> Cloud Sync" series to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>.'
__int_icon: 'icon/tencent_mongodb'
dashboard:

  - desc: 'Tencent Cloud MongoDB built-in views'
    path: 'dashboard/en/tencent_mongodb'

monitor:
  - desc: 'Tencent Cloud MongoDB monitor'
    path: 'monitor/en/tencent_mongodb'

---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud MongoDB
<!-- markdownlint-enable -->

Use the script packages in the Script Market of the "<<< custom_key.brand_name >>> Cloud Sync" series to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>.

## Configuration {#config}

### Install Func

We recommend enabling the <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a qualified Tencent Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of MongoDB cloud resources, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Tencent Cloud-MongoDB Collection)" (ID: `guance_tencentcloud_mongodb`)

After clicking 【Install】, enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Start Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding start script.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】to immediately execute it once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations, see the metrics section [Customize Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}

### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and at the same time, you can check the corresponding task records and logs for any anomalies.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}

After configuring Tencent Cloud - Cloud Monitoring, the default metric sets are as follows. You can collect more metrics through configuration [Tencent Cloud Cloud Monitoring Metric Details](https://cloud.tencent.com/document/product/248/45104){:target="_blank"}

### Request Class

| Metric English Name      | Metric Chinese Name             | Meaning                        | Unit  | Dimensions              |
| --------------- | ---------------------- | --------------------------- | ----- | ----------------- |
| `Inserts_sum`       | Write request count           | Number of writes within a unit of time          | Times    | target (Instance ID) |
| `Reads_sum`         | Read request count           | Number of reads within a unit of time          | Times    | target (Instance ID) |
| `Updates_sum`       | Update request count           | Number of updates within a unit of time          | Times    | target (Instance ID) |
| `Deletes_sum`       | Delete request count           | Number of deletes within a unit of time          | Times    | target (Instance ID) |
| `Counts_sum`        | Count request count         | Number of counts within a unit of time       | Times    | target (Instance ID) |
| `Success_sum`       | Successful request count           | Number of successful requests within a unit of time      | Times    | target (Instance ID) |
| `Commands_sum`      | Command request count       | Number of command requests within a unit of time | Times    | target (Instance ID) |
| `Qps_sum`           | Requests per second         | Operations per second, including CRUD operations  | Times/sec | target (Instance ID) |
| `CountPerSecond_sum` | Counts per second request count  | Count requests per second       | Times/sec | target (Instance ID) |
| `DeletePerSecond_sum` | Deletes per second request count | Delete requests per second      | Times/sec | target (Instance ID) |
| `InsertPerSecond_sum` | Inserts per second request count | Insert requests per second      | Times/sec | target (Instance ID) |
| `ReadPerSecond_sum` | Reads per second request count   | Read requests per second        | Times/sec | target (Instance ID) |
| `UpdatePerSecond_sum` | Updates per second request count | Update requests per second      | Times/sec | target (Instance ID) |

### Latency Request Class

| Metric English Name         | Metric Chinese Name                   | Meaning                                     | Unit | Dimensions              |
| ------------------ | ---------------------------- | ---------------------------------------- | ---- | ----------------- |
| `Delay10_sum`          | Request count with latency between 10 - 50 milliseconds  | Number of successful requests with delay between 10ms - 50ms within a unit of time  | Times   | target (Instance ID) |
| `Delay50_sum`          | Request count with latency between 50 - 100 milliseconds | Number of successful requests with delay between 50ms - 100ms within a unit of time | Times   | target (Instance ID) |
| `Delay100_sum`         | Request count with latency over 100 milliseconds    | Number of successful requests with delay over 100ms within a unit of time    | Times   | target (Instance ID) |
| `AvgAllRequestDelay_sum` | Average delay of all requests             | Average delay of all requests                         | ms   | target (Instance ID) |

### Connection Class

| Metric English Name  | Metric Chinese Name | Meaning                                        | Unit | Dimensions              |
| ----------- | ---------- | ------------------------------------------- | ---- | ----------------- |
| `ClusterConn_max` | Cluster connection count | Total cluster connections, referring to the number of connections received by the current cluster proxy | Times   | target (Instance ID) |
| `Connper_max`   | Connection usage rate | Proportion of the current cluster's connections to the total cluster connection configuration      | %    | target (Instance ID) |

### System Class

| Metric English Name         | Metric Chinese Name | Meaning                                       | Unit | Dimensions              |
| ------------------ | ---------- | ------------------------------------------ | ---- | ----------------- |
| `ClusterDiskusage` | Disk usage rate | Proportion of actual storage space occupied by the cluster to the total capacity configuration | %    | target (Instance ID) |

### Inbound and Outbound Traffic Class

| Metric English Name      | Metric Chinese Name | Meaning           | Unit  | Dimensions                  |
| --------------- | ---------- | -------------- | ----- | --------------------- |
| `ClusterNetin`  | Inbound traffic     | Cluster network inbound traffic | Bytes | **target** (Instance ID) |
| `ClusterNetout` | Outbound traffic     | Cluster network outbound traffic | Bytes | **target** (Instance ID) |

### MongoDB Replica Set

#### 1. System Class

| Metric English Name         | Metric Chinese Name | Meaning             | Unit | Dimensions                    |
| ------------------ | ---------- | ---------------- | ---- | ----------------------- |
| `ReplicaDiskusage` | Disk usage rate | Replica set capacity usage rate | %    | **target** (Replica Set ID) |

#### 2. Master-Slave Class

| Metric English Name          | Metric Chinese Name         | Meaning                                         | Unit | Dimensions                |
| ------------------- | ------------------ | -------------------------------------------- | ---- | ------------------- |
| `SlaveDelay`        | Master-slave delay           | Average master-slave delay within a unit of time                       | Seconds   | target (Replica Set ID) |
| `Oplogreservedtime` | **oplog** retention time | Difference in time between the last operation and the first operation in the **oplog** records | Hours | target (Replica Set ID) |

#### 3. Cache Class

| Metric English Name   | Metric Chinese Name         | Meaning                          | Unit | Dimensions               |
| ------------ | ------------------ | ----------------------------- | ---- | ------------------ |
| `CacheDirty` | Cache dirty data percentage | Percentage of dirty data in the current memory Cache | %    | target (Replica Set ID) |
| `CacheUsed`  | Cache usage percentage   | Current Cache usage percentage         | %    | target (Replica Set ID) |
| `HitRatio`   | Cache hit rate       | Current Cache hit rate             | %    | target (Replica Set ID) |

### Mongo Node

<!-- markdownlint-disable MD024 -->

#### 1. System Class

<!-- markdownlint-enable -->

| Metric English Name              | Metric Chinese Name         | Meaning                     | Unit  | Dimensions             |
| ----------------------- | ------------------ | ------------------------ | ----- | ---------------- |
| `CpuUsage`              | CPU usage         | CPU usage               | %     | target (Node ID) |
| `MemUsage`              | Memory usage         | Memory usage               | %     | target (Node ID) |
| `NetIn`                 | Network inbound traffic         | Network inbound traffic               | MB/s  | target (Node ID) |
| `NetOut`                | Network outbound traffic         | Network outbound traffic               | MB/s  | target (Node ID) |
| `Disk`                  | Node disk usage       | Node disk usage             | MB    | target (Node ID) |
| `Conn`                  | Connection count             | Connection count                   | Times    | target (Node ID) |
| `ActiveSession`         | Active session count  | Active session count        | Times    | target (Node ID) |
| `NodeOplogReservedTime` | **Oplog** retention duration | Node **oplog** retention duration  | -     | target (Node ID) |
| `NodeHitRatio`          | Cache hit rate       | Cache hit rate             | %     | target (Node ID) |
| `NodeCacheUsed`         | Cache usage percentage   | Cache usage percentage in total memory | %     | target (Node ID) |
| `NodeSlavedelay`        | Master-slave delay           | Slave node delay               | s     | target (Node ID) |
| `Diskusage`             | Node disk usage rate     | Node disk usage rate           | %     | target (Node ID) |
| `Ioread`                | Disk read count         | Disk read IOPS              | Times/sec | target (Node ID) |
| `Iowrite`               | Disk write count         | Disk write IOPS              | Times/sec | target (Node ID) |
| `NodeCacheDirty`        | Cache dirty data percentage | Cache dirty data ratio       | %     | target (Node ID) |

#### 2. Read/Write Class

| Metric English Name | Metric Chinese Name                 | Meaning                       | Unit | Dimensions             |
| ---------- | -------------------------- | -------------------------- | ---- | ---------------- |
| `Qr`       | Read request queue count  | Read request queue count  | Count   | target (Node ID) |
| `Qw`       | Write request queue count | Write request queue count | Count   | target (Node ID) |
| `Ar`       | WT engine ActiveRead        | Active Read request count          | Count   | target (Node ID) |
| `Aw`       | WT engine ActiveWrite         | Active Write request count         | Count   | target (Node ID) |

#### 3. Latency & Request Class

| Metric English Name               | Metric Chinese Name                     | Meaning                           | Unit  | Dimensions             |
| ------------------------ | ------------------------------ | ------------------------------ | ----- | ---------------- |
| `NodeAvgAllRequestDelay` | Average delay of all requests               | Node average delay of all requests           | ms    | target (Node ID) |
| `NodeDelay100`           | Node request count with delay over 100 milliseconds      | Node request count with delay over 100 milliseconds      | Times    | target (Node ID) |
| `NodeDelay10`            | Node request count with delay between 10-50 milliseconds  | Node request count with delay between 10-50 milliseconds  | Times    | target (Node ID) |
| `NodeDelay50`            | Node request count with delay between 50-100 milliseconds | Node request count with delay between 50-100 milliseconds | Times    | target (Node ID) |
| `NodeSuccessPerSecond`   | Node request success count per second           | Node request success count per second           | Times/sec | target (Node ID) |
| `NodeCountPerSecond`     | Node count request count per second      | Node count request count per second      | Times/sec | target (Node ID) |
| `NodeDeletePerSecond`    | Node delete request count per second     | Node delete request count per second     | Times/sec | target (Node ID) |
| `NodeInsertPerSecond`    | Node insert request count per second     | Node insert request count per second     | Times/sec | target (Node ID) |
| `NodeReadPerSecond`      | Node read request count per second       | Node read request count per second       | Times/sec | target (Node ID) |
| `NodeUpdatePerSecond`    | Node update request count per second     | Node update request count per second     | Times/sec | target (Node ID) |
| `SuccessPerSecond`       | Total requests                         | Node request success count per second           | Times/sec | target (Node ID) |

#### 4. TTL Index Class

| Metric English Name   | Metric Chinese Name         | Meaning               | Unit | Dimensions             |
| ------------ | ------------------ | ------------------ | ---- | ---------------- |
| `TtlDeleted` | TTL deleted data count | TTL deleted data count | Count   | target (Node ID) |
| `TtlPass`    | TTL operation cycles       | TTL operation cycles       | Count   | target (Node ID) |

## Objects {#object}

The structure of Tencent Cloud MongoDB objects collected can be seen from "Infrastructure - Custom".

```json
{
  "measurement": "tencentcloud_mongodb",
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
    "RelatedInstance"  : "{Instance JSON data}",
    "ReplicaSets"      : "{Instance JSON data}",
    "StandbyInstances" : "[]",
    "message"          : "{Instance JSON data}",
  }
}
```

## Logs {#logging}

### Slow Query Statistics

#### Prerequisites

> Note 1: The code execution of this script depends on MongoDB instance object collection. If MongoDB custom object collection is not configured, the slow log script cannot collect slow log data.

<!-- markdownlint-disable MD024 -->

#### Install Script

<!-- markdownlint-enable -->

On top of the previous setup, you need to install another script corresponding to **MongoDB Slow Query Log Collection**

In "Manage / Script Market", click and install the corresponding script package:

- "<<< custom_key.brand_name >>> Integration (Tencent Cloud-MongoDB Slow Query Log Collection)" (ID: `guance_tencentcloud_mongodb_slowlog`)

After the data is synchronized normally, you can view the data in the "Logs" section of <<< custom_key.brand_name >>>.

An example of the reported data is as follows:

```json
{
  "measurement": "tencentcloud_mongodb_slow_log",
  "tags": {

  },
  "fields": {
      "Slowlog": "Slow log details",
      "message": "{Instance JSON data}"
  }
}
```

> *Note: Fields in `tags`, `fields` may change with subsequent updates.*
>
> Note 1: `tags` values are supplemented by custom objects.
>
> Note 2: `fields.message` is a string serialized in JSON format.
>
> Note 3: `fields.Slowlog` represents each record of all slow query details.