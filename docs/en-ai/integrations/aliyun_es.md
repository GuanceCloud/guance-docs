---
title: 'Alibaba Cloud ElasticSearch'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud ElasticSearch metrics display, including cluster status, index QPS, node CPU/memory/disk usage, etc.'
__int_icon: 'icon/aliyun_es'
dashboard:
  - desc: 'Alibaba Cloud ElasticSearch built-in views'
    path: 'dashboard/en/aliyun_es/'

monitor:
  - desc: 'Alibaba Cloud ElasticSearch monitor'
    path: 'monitor/en/aliyun_elasticsearch/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud ElasticSearch
<!-- markdownlint-enable -->

Alibaba Cloud ElasticSearch metrics display, including cluster status, index QPS, node CPU/memory/disk usage, etc.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize the monitoring data of ElasticSearch cloud resources, we install the corresponding collection script: 「Guance Integration (Alibaba Cloud-ElasticSearch Collection)」(ID: `guance_aliyun_elasticsearch`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy and Start Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, you also need to enable the corresponding log collection script. If you need to collect billing information, you need to enable the cloud billing collection script.

We default to collecting some configurations, details are shown in the metrics section.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any abnormalities.
2. On the Guance platform, in 「Infrastructure / Custom」check if asset information exists.
3. On the Guance platform, in 「Metrics」check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Alibaba Cloud Cloud Monitoring Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                       |              Metric Name              | Dimensions              | Statistics      | Unit         |
| ---- | :----: | ---- | ---- | ---- |
| `ClusterAutoSnapshotLatestStatus` |               Snapshot Status                | userId,clusterId        | Maximum         | value        |
| `ClusterIndexQPS`               |              Cluster Write QPS              | userId,clusterId        | Average         | Count/Second |
| `ClusterQueryQPS`               |              Cluster Query QPS              | userId,clusterId        | Average         | Count/Second |
| `ClusterStatus`                 |               Cluster Status                | userId,clusterId        | Value,Maximum   | value        |
| `NodeCPUUtilization`            |    elasticsearch instance node CPU utilization     | userId,clusterId,nodeIP | Average,Maximum | %            |
| `NodeDiskUtilization`           |    elasticsearch instance node disk utilization    | userId,clusterId,nodeIP | Average,Maximum | %            |
| `NodeHeapMemoryUtilization`     | elasticsearch instance node HeapMemory utilization | userId,clusterId,nodeIP | Average,Maximum | %            |
| `NodeLoad_1m`                   |              Node Load_1m              | userId,clusterId,nodeIP | Average         | value        |
| `NodeStatsDataDiskR`            |         Number of read requests completed per second          | userId,clusterId,nodeIP | Maximum         | count        |
| `NodeStatsDataDiskRm`           |           Size read per second            | userId,clusterId,nodeIP | Maximum         | MB/s         |
| `NodeStatsDataDiskUtil`         |                IOUtil                 | userId,clusterId,nodeIP | Maximum         | %            |
| `NodeStatsDataDiskW`            |         Number of write requests completed per second          | userId,clusterId,nodeIP | Maximum         | count        |
| `NodeStatsDataDiskWm`           |           Size written per second            | userId,clusterId,nodeIP | Maximum         | MB/s         |
| `NodeStatsExceptionLogCount`    |             Exception Count             | userId,clusterId,nodeIP | Maximum         | Count        |
| `NodeStatsFullGcCollectionCount` |              Full GC Count               | userId,clusterId,nodeIP | Maximum         | Count        |
| `NodeStatsNetworkinPackages`    |            Network Inbound Packets             | userId,clusterId,nodeIP | Maximum         | count        |
| `NodeStatsNetworkinRate`        | Network Inbound Rate | userId,clusterId,nodeIP | Maximum | kB/s |
| `NodeStatsNetworkoutPackages`   | Network Outbound Packets | userId,clusterId,nodeIP | Maximum | count |
| `NodeStatsNetworkoutRate`       | Network Outbound Rate | userId,clusterId,nodeIP | Maximum | kB/s |
| `NodeStatsTcpEstablished`       | Established TCP Connections | userId,clusterId,nodeIP | Maximum | count |

## Objects {#object}

The collected Alibaba Cloud ElasticSearch object data structure can be viewed from 「Infrastructure - Custom」:

```json
{
  "measurement": "aliyun_elasticsearch",
  "tags": {
    "RegionId"       : "cn-hangzhou",
    "esVersion"      : "7.4.0_with_X-Pack",
    "instanceId"     : "es-cn-xxxx",
    "name"           : "es-cn-xxxx",
    "paymentType"    : "prepaid",
    "resourceGroupId": "rg-acfm2l3p7xxxx",
    "serviceVpc"     : "True",
    "status"         : "active"
  },
  "fields": {
    "advancedDedicateMaster": false,
    "createdAt"             : "2021-04-07T06:10:50.527Z",
    "extendConfigs"         : "[ {Cluster Extension Parameter Configuration JSON Data}, ...]",
    "message"               : "{Instance JSON Data}"
  }
}
```

## Logs {#logging}

### Prerequisites
> Note 1: Before using this collector, you must install the 「Guance Integration Core Package」and its associated third-party dependency packages.
> Note 2: This script's code execution depends on the mongodb instance object collection. If custom object collection for MongoDB is not configured, the slow log script cannot collect slow log data.

<!-- markdownlint-disable MD024 -->

### Install Script

<!-- markdownlint-enable -->

On top of the previous setup, you need to install another script for **Elasticsearch log collection**.

In 「Management / Script Market」click and install the corresponding script package:

- 「Guance Integration (Alibaba Cloud-ElasticSearch Collection)」(ID: `guance_aliyun_elasticsearch_log`)


### Data Reporting Format
After data synchronization, you can view the data in the 「Infrastructure - Custom Objects」section of Guance.

Example of reported data:

```json
{
  "measurement": "aliyun_elasticsearch_log",
  "tags": {
    "RegionId"       : "cn-hangzhou",
    "esVersion"      : "7.10.0_with_X-Pack",
    "host"           : "10.14.xxx.xxx",
    "instanceId"     : "es-cn-xxxx",
    "name"           : "es-cn-xxxx",
    "paymentType"    : "prepaid",
    "resourceGroupId": "rg-aekzkcwe4dxxxx",
    "serviceVpc"     : "True",
    "status"         : "active"
  },
  "fields": {
    "timestamp"        : 1684304299000,
    "contentCollection": "[ {Detailed Log JSON Data}, ...]",
    "message"          : "{Instance JSON Data}"
  }
}

```

log_types (log types) values and meanings:

| Value | Description |
| ---- |---- |
| `INSTANCELOG` | Main Log |
| `SEARCHSLOW` | Searching Slow Log |
| `INDEXINGSLOW` | Indexing Slow Log |
| `JVMLOG` | GC Log |
| `ES_SEARCH_ACCESS_LOG` | ES Access Log |
| `AUDIT` | Audit Log |

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
> Note 1: The value of tags.name is the instance ID, used as a unique identifier.
> Note 2: `fields.message` is a JSON serialized string.