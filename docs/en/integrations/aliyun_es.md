---
title: 'Aliyun ElasticSearch'
summary: 'Aliyun ElasticSearch metrics display, including cluster status, index QPS, node CPU/memory/disk utilization and so on.' 
__int_icon: 'icon/aliyun_es'
dashboard:
  - desc: 'Aliyun ElasticSearch Monitoring View'
    path: 'dashboard/zh/aliyun_es/'

monitor:
  - desc: 'Aliyun ElasticSearch Monitor'
    path: 'monitor/zh/aliyun_elasticsearch/'
---

<!-- markdownlint-disable MD025 -->
# Aliyun ElasticSearch
<!-- markdownlint-enable -->

Aliyun ElasticSearch metrics display, including cluster status, index QPS, node CPU/memory/disk utilization and so on.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of ElasticSearch cloud resources, we install the corresponding collection script：「Guance Integration（Aliyun -ElasticSearch Collect）」(ID：`guance_aliyun_elasticsearch`)


Click "Install" and enter the corresponding parameters: Aliyun AK, Aliyun account name.

Click [Deploy Startup Scripts], the system will automatically create the `Startup` script set and automatically configure the corresponding startup scripts.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click "Run"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs.

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Ali Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Alibaba Cloud Monitor Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                       |              Metric Name              | Dimensions              | Statistics      | Unit         |
| ---- | :----: | ---- | ---- | ---- |
| `ClusterAutoSnapshotLatestStatus` |               snapshot state                | userId,clusterId        | Maximum         | value        |
| `ClusterIndexQPS`                 |              Cluster Write QPS              | userId,clusterId        | Average         | Count/Second |
| `ClusterQueryQPS`                |              Cluster Query QPS              | userId,clusterId        | Average         | Count/Second |
| `ClusterStatus`                   |               cluster state                | userId,clusterId        | Value,Maximum   | value        |
| `NodeCPUUtilization`              |    elasticsearch instance node CPU utilization     | userId,clusterId,nodeIP | Average,Maximum | %            |
| `NodeDiskUtilization`             |    elasticsearch instance node disk usage    | userId,clusterId,nodeIP | Average,Maximum | %            |
| `NodeHeapMemoryUtilization`       | elasticsearch instance node HeapMemory usage rate | userId,clusterId,nodeIP | Average,Maximum | %            |
| `NodeLoad_1m`                     |              Node Load_1m              | userId,clusterId,nodeIP | Average         | value        |
| `NodeStatsDataDiskR`              |         Number of read requests completed per second          | userId,clusterId,nodeIP | Maximum         | count        |
| `NodeStatsDataDiskRm`             |           Read size per second            | userId,clusterId,nodeIP | Maximum         | MB/s         |
| `NodeStatsDataDiskUtil`           |                IOUtil                 | userId,clusterId,nodeIP | Maximum         | %            |
| `NodeStatsDataDiskW`              |         Number of write requests completed per second          | userId,clusterId,nodeIP | Maximum         | count        |
| `NodeStatsDataDiskWm`             |           Size of writes per second            | userId,clusterId,nodeIP | Maximum         | MB/s         |
| `NodeStatsExceptionLogCount`      |             Number of Exception             | userId,clusterId,nodeIP | Maximum         | Count        |
| `NodeStatsFullGcCollectionCount`  |              Number of FullGc               | userId,clusterId,nodeIP | Maximum         | Count        |
| `NodeStatsNetworkinPackages`      |            Node Network Inflow Packets             | userId,clusterId,nodeIP | Maximum         | count        |
| `NodeStatsNetworkinRate` | Data inflow rate | userId,clusterId,nodeIP | Maximum | kB/s |
| `NodeStatsNetworkoutPackages` | Node Network Outflow Package | userId,clusterId,nodeIP | Maximum | count |
| `NodeStatsNetworkoutRate` | Data outflow rate | userId,clusterId,nodeIP | Maximum | kB/s |
| `NodeStatsTcpEstablished` | Number of node TCP links | userId,clusterId,nodeIP | Maximum | count |

## Object {#object}

The collected Alibaba Cloud ElasticSearch object data structure can see the object data from「Infrastructure-Custom」


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
    "extendConfigs"         : "[ {Cluster Expansion Parameter Configuration JSON data}, ...]",
    "message"               : "{Instance JSON data}"
  }
}
```

## Logging {#logging}

### Prerequisites
> Note: The code of this script depends on elasticsearch instance object collection to run. If elasticsearch's custom object collection is not configured, the slow log script cannot collect slow log data

### Install the slow query ingest script
To start with, install a script for **elasticsearch Scripts for log collection**

In "Script Market - Official Script Market", go to "Details" and click to install the corresponding script package:

- 「Guance Integration (Aliyun-ElasticSearch Acquisition)」(ID：`guance_aliyun_elasticsearch_log`)

### Data reporting format
After the data is properly synchronized, you can view the data in "Infrastructure - Custom Objects" in Guance.

Examples of reported data are as follows:

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
    "contentCollection": "[ {Log Details JSON data}, ...]",
    "message"          : "{Instance JSON data}"
  }
}

```

log_types,Meaning of log_types assignment:

| value | clarification |
| ---- |---- |
| `INSTANCELOG` | Main Log |
| `SEARCHSLOW` | Slow searching logs |
| `INDEXINGSLOW` | indexing slow logs |
| `JVMLOG` | GC Log |
| `ES_SEARCH_ACCESS_LOG` | ES Access Log |
| `AUDIT` | Audit log |

> *Notice：`tags`、`fields` The fields in are subject to change with subsequent updates*
>
> Remind：`fields.message` is a JSON serialized string.
