---
title: 'Tencent Cloud MongoDB'
tags: 
  - Tencent Cloud
summary: 'Use the script packages in the Script Market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance'
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

Use the script packages in the Script Market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize MongoDB cloud resource monitoring data, we install the corresponding collection script: "Guance Integration (Tencent Cloud-MongoDB Collection)" (ID: `guance_tencentcloud_mongodb`)

After clicking 【Install】, enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

After enabling, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute it once without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

By default, we collect some configurations; for details, see the metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}

### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration and check the task records and logs for any anomalies.
2. On the Guance platform, in "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, in "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}

After configuring Tencent Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Tencent Cloud Cloud Monitoring Metric Details](https://cloud.tencent.com/document/product/248/45104){:target="_blank"}

### Request Type

| Metric English Name | Metric Chinese Name       | Meaning                         | Unit | Dimension            |
|---------------------|---------------------------|---------------------------------|------|----------------------|
| `Inserts_sum`          | Write request count        | Number of writes per unit time  | Times | target (instance ID) |
| `Reads_sum`            | Read request count         | Number of reads per unit time   | Times | target (instance ID) |
| `Updates_sum`          | Update request count       | Number of updates per unit time | Times | target (instance ID) |
| `Deletes_sum`          | Delete request count       | Number of deletes per unit time | Times | target (instance ID) |
| `Counts_sum`           | Count request count        | Number of counts per unit time  | Times | target (instance ID) |
| `Success_sum`          | Successful request count   | Number of successful requests   | Times | target (instance ID) |
| `Commands_sum`         | Command request count      | Number of command requests      | Times | target (instance ID) |
| `Qps_sum`              | Requests per second        | Operations per second including CRUD | Times/sec | target (instance ID) |
| `CountPerSecond_sum`   | Counts per second          | Counts per second               | Times/sec | target (instance ID) |
| `DeletePerSecond_sum`  | Deletes per second         | Deletes per second              | Times/sec | target (instance ID) |
| `InsertPerSecond_sum`  | Inserts per second         | Inserts per second              | Times/sec | target (instance ID) |
| `ReadPerSecond_sum`    | Reads per second           | Reads per second                | Times/sec | target (instance ID) |
| `UpdatePerSecond_sum`  | Updates per second         | Updates per second              | Times/sec | target (instance ID) |

### Latency Request Type

| Metric English Name     | Metric Chinese Name                  | Meaning                                             | Unit | Dimension            |
|-------------------------|---------------------------------------|-----------------------------------------------------|------|----------------------|
| `Delay10_sum`             | Requests with latency between 10-50ms | Number of successful requests delayed between 10ms-50ms | Times | target (instance ID) |
| `Delay50_sum`             | Requests with latency between 50-100ms | Number of successful requests delayed between 50ms-100ms | Times | target (instance ID) |
| `Delay100_sum`            | Requests with latency over 100ms      | Number of successful requests delayed over 100ms     | Times | target (instance ID) |
| `AvgAllRequestDelay_sum`  | Average delay of all requests        | Average delay of all requests                       | ms    | target (instance ID) |

### Connection Type

| Metric English Name  | Metric Chinese Name | Meaning                                               | Unit | Dimension            |
|----------------------|---------------------|-------------------------------------------------------|------|----------------------|
| `ClusterConn_max`     | Cluster connection count | Total cluster connections, i.e., connections received by the current cluster proxy | Times | target (instance ID) |
| `Connper_max`         | Connection usage rate  | Proportion of current cluster connections to total configured connections | %     | target (instance ID) |

### System Type

| Metric English Name     | Metric Chinese Name | Meaning                                              | Unit | Dimension            |
|-------------------------|---------------------|------------------------------------------------------|------|----------------------|
| `ClusterDiskusage`       | Disk usage rate     | Proportion of actual storage space used by the cluster to total configured capacity | %    | target (instance ID) |

### Ingress and Egress Traffic Type

| Metric English Name | Metric Chinese Name | Meaning           | Unit  | Dimension                 |
|---------------------|---------------------|-------------------|-------|---------------------------|
| `ClusterNetin`       | Ingress traffic     | Cluster ingress traffic | Bytes | **target** (instance ID)  |
| `ClusterNetout`      | Egress traffic      | Cluster egress traffic | Bytes | **target** (instance ID)  |

### MongoDB Replica Set

#### 1. System Type

| Metric English Name     | Metric Chinese Name | Meaning             | Unit | Dimension                   |
|-------------------------|---------------------|---------------------|------|-----------------------------|
| `ReplicaDiskusage`       | Disk usage rate     | Replica set capacity usage rate | %    | **target** (replica set ID) |

#### 2. Master-Slave Type

| Metric English Name     | Metric Chinese Name | Meaning                                         | Unit | Dimension                    |
|-------------------------|---------------------|-------------------------------------------------|------|-------------------------------|
| `SlaveDelay`             | Master-slave delay  | Average delay between master and slave per unit time | Seconds | target (replica set ID)      |
| `Oplogreservedtime`      | **oplog** retention time | Time difference between the last and first operation in the **oplog** records | Hours | target (replica set ID)      |

#### 3. Cache Type

| Metric English Name | Metric Chinese Name | Meaning                          | Unit | Dimension                     |
|---------------------|---------------------|----------------------------------|------|-------------------------------|
| `CacheDirty`         | Cache dirty data percentage | Current percentage of dirty data in memory cache | %    | target (replica set ID)       |
| `CacheUsed`          | Cache usage percentage      | Current cache usage percentage  | %    | target (replica set ID)       |
| `HitRatio`           | Cache hit ratio            | Current cache hit ratio          | %    | target (replica set ID)       |

### Mongo Node

<!-- markdownlint-disable MD024 -->

#### 1. System Type

<!-- markdownlint-enable -->

| Metric English Name         | Metric Chinese Name | Meaning                     | Unit  | Dimension               |
|----------------------------|---------------------|-----------------------------|-------|-------------------------|
| `CpuUsage`                  | CPU usage rate      | CPU usage rate              | %     | target (node ID)        |
| `MemUsage`                  | Memory usage rate   | Memory usage rate           | %     | target (node ID)        |
| `NetIn`                     | Network ingress     | Network ingress             | MB/s  | target (node ID)        |
| `NetOut`                    | Network egress      | Network egress              | MB/s  | target (node ID)        |
| `Disk`                      | Node disk usage     | Node disk usage             | MB    | target (node ID)        |
| `Conn`                      | Connection count    | Connection count            | Times | target (node ID)        |
| `ActiveSession`             | Active session count| Active session count        | Times | target (node ID)        |
| `NodeOplogReservedTime`     | **Oplog** retention time | Node **oplog** retention time | -     | target (node ID)        |
| `NodeHitRatio`              | Cache hit ratio     | Cache hit ratio             | %     | target (node ID)        |
| `NodeCacheUsed`             | Cache usage percentage | Cache memory usage as a percentage of total memory | %     | target (node ID)        |
| `NodeSlavedelay`            | Master-slave delay  | Slave node delay            | s     | target (node ID)        |
| `Diskusage`                 | Node disk usage rate | Node disk usage rate        | %     | target (node ID)        |
| `Ioread`                    | Disk read count     | Disk read IOPS              | Times/sec | target (node ID)        |
| `Iowrite`                   | Disk write count    | Disk write IOPS             | Times/sec | target (node ID)        |
| `NodeCacheDirty`            | Cache dirty data percentage | Percentage of dirty data in cache | %     | target (node ID)        |

#### 2. Read and Write Type

| Metric English Name | Metric Chinese Name                 | Meaning                       | Unit | Dimension               |
|---------------------|-------------------------------------|-------------------------------|------|-------------------------|
| `Qr`                | Number of read requests in queue    | Number of read requests in queue | Count | target (node ID)        |
| `Qw`                | Number of write requests in queue   | Number of write requests in queue | Count | target (node ID)        |
| `Ar`                | WT engine active read               | Number of active read requests  | Count | target (node ID)        |
| `Aw`                | WT engine active write              | Number of active write requests | Count | target (node ID)        |

#### 3. Latency & Request Type

| Metric English Name              | Metric Chinese Name                     | Meaning                           | Unit  | Dimension               |
|----------------------------------|------------------------------------------|-----------------------------------|-------|-------------------------|
| `NodeAvgAllRequestDelay`         | Average latency of all requests         | Average delay of all requests at the node | ms    | target (node ID)        |
| `NodeDelay100`                   | Number of requests with latency > 100ms | Number of requests with latency > 100ms | Times | target (node ID)        |
| `NodeDelay10`                    | Number of requests with latency 10-50ms | Number of requests with latency 10-50ms | Times | target (node ID)        |
| `NodeDelay50`                    | Number of requests with latency 50-100ms | Number of requests with latency 50-100ms | Times | target (node ID)        |
| `NodeSuccessPerSecond`           | Number of successful requests per second | Number of successful requests per second | Times/sec | target (node ID)        |
| `NodeCountPerSecond`             | Number of count requests per second     | Number of count requests per second | Times/sec | target (node ID)        |
| `NodeDeletePerSecond`            | Number of delete requests per second    | Number of delete requests per second | Times/sec | target (node ID)        |
| `NodeInsertPerSecond`            | Number of insert requests per second    | Number of insert requests per second | Times/sec | target (node ID)        |
| `NodeReadPerSecond`              | Number of read requests per second      | Number of read requests per second | Times/sec | target (node ID)        |
| `NodeUpdatePerSecond`            | Number of update requests per second    | Number of update requests per second | Times/sec | target (node ID)        |
| `SuccessPerSecond`               | Total requests                          | Number of successful requests per second | Times/sec | target (node ID)        |

#### 4. TTL Index Type

| Metric English Name | Metric Chinese Name         | Meaning               | Unit | Dimension               |
|---------------------|-----------------------------|-----------------------|------|-------------------------|
| `TtlDeleted`        | Number of TTL-deleted documents | Number of TTL-deleted documents | Count | target (node ID)        |
| `TtlPass`           | TTL rotation rounds          | TTL rotation rounds   | Count | target (node ID)        |

## Objects {#object}

The structure of the collected Tencent Cloud MongoDB object data can be seen from "Infrastructure - Custom"

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

> Note 1: The code execution of this script depends on MongoDB instance object collection. If MongoDB custom object collection is not configured, the slow log script cannot collect slow log data.

<!-- markdownlint-disable MD024 -->

#### Install Script

<!-- markdownlint-enable -->

On top of the previous setup, you need to install another script for collecting MongoDB slow query statistics logs.

In "Manage / Script Market", click and install the corresponding script package:

- "Guance Integration (Tencent Cloud-MongoDB Slow Query Log Collection)" (ID: `guance_tencentcloud_mongodb_slowlog`)

After data synchronization is normal, you can view the data in the "Logs" section of Guance.

An example of reported data is as follows:

```json
{
  "measurement": "tencentcloud_mongodb_slow_log",
  "tags": {

  },
  "fields": {
      "Slowlog": "Slow log details",
      "message": "{instance JSON data}"
  }
}
```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Note 1: `tags` values are supplemented by custom objects.
>
> Note 2: `fields.message` is a JSON serialized string.
>
> Note 3: `fields.Slowlog` represents each record of all slow query details.