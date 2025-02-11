---
title: 'Huawei Cloud Search Service CSS for Elasticsearch'
tags: 
  - Huawei Cloud
summary: 'The core performance Metrics of the Huawei Cloud Search Service CSS for Elasticsearch include query latency, indexing speed, search speed, disk usage, and CPU usage. These are key Metrics for evaluating and optimizing Elasticsearch performance.'
__int_icon: 'icon/huawei_css_es'
dashboard:

  - desc: 'Built-in Views for Huawei Cloud Search Service CSS for Elasticsearch'
    path: 'dashboard/en/huawei_css_es'

monitor:
  - desc: 'Monitors for Huawei Cloud Search Service CSS for Elasticsearch'
    path: 'monitor/en/huawei_css_es'

---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud Search Service CSS for Elasticsearch
<!-- markdownlint-enable -->

The core performance Metrics of the Huawei Cloud Search Service CSS for Elasticsearch include query latency, indexing speed, search speed, disk usage, and CPU usage. These are key Metrics for evaluating and optimizing Elasticsearch performance.


## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize monitoring data from the Huawei Cloud Search Service CSS for Elasticsearch, we install the corresponding collection script: visit the web service of func, go to 【Script Market】-【Details】, search by the keyword "css", and install 「Guance Integration (Huawei Cloud-CSS)」(ID: `guance_huaweicloud_css`).

After clicking 【Install】, enter the required parameters: Huawei Cloud AK, SK, and Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the startup script accordingly.

After the script is installed, find the script 「Guance Integration (Huawei Cloud-CSS)」 under 「Development」 in Func, expand and modify this script, locate `collector_configs` and `monitor_configs`, and edit the content of `region_projects`. Change the region and Project ID to the actual ones, then click Save and Publish.

Additionally, in 「Management / Automatic Trigger Configuration」, you can see the corresponding automatic trigger configuration. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, some configurations are collected; see the Metrics section for details [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-css/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, in 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, in 「Metrics」, check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Huawei Cloud Cloud Monitoring, the default Mearsurement set is as follows. You can collect more Metrics through configuration [Huawei Cloud Cloud Monitoring Metrics Details](https://support.huaweicloud.com/usermanual-css/css_01_0042.html){:target="_blank"}

### Instance Monitoring Metrics

Performance monitoring Metrics for Huawei Cloud Search Service CSS for Elasticsearch instances are shown in the following table. For more Metrics, refer to [Table 1](https://support.huaweicloud.com/usermanual-rds/rds_pg_06_0001.html){:target="_blank"}

| Metric ID                                       | Metric Name                                | Metric Meaning                                                     | Value Range           | Monitoring Period (Raw Metrics) |
| -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `status`|Cluster Health Status|This metric measures the status of the monitored object.|0,1,2,3;<br>0: The cluster is 100% available.<br>1: Data is complete, but some replicas are missing. High availability is somewhat weakened, posing a risk. Monitor the cluster situation promptly.<br>2: Data is missing, and using the cluster will result in anomalies.<br>3: Cluster status not obtained.|1 minute|
| `indices_count`|Number of Indices|Number of indices in the CSS cluster.|≥ 0|1 minute|
| `total_shards_count`|Total Number of Shards|Total number of shards in the CSS cluster.|≥ 0|1 minute|
| `primary_shards_count`|Number of Primary Shards|Number of primary shards in the CSS cluster.|≥ 0|1 minute|
| `coordinating_nodes_count`|Number of Coordinating Nodes|Number of coordinating nodes in the CSS cluster.|≥ 0|1 minute|
| `data_nodes_count`|Number of Data Nodes|Number of data nodes in the CSS cluster.|≥ 0|1 minute|
| `SearchRate`|Average Query Rate|Query QPS, average number of queries per second performed by the cluster.|≥ 0|1 minute|
| `IndexingRate`|Average Indexing Rate|Ingest TPS, average number of indexing operations per second performed by the cluster.|≥ 0|1 minute|
| `IndexingLatency`|Average Indexing Latency|Average time taken to complete an indexing operation on a shard.|≥ 0 ms|1 minute|
| `SearchLatency`|Average Query Latency|Average time taken to complete a search operation on a shard.|≥ 0 ms|1 minute|
| `avg_cpu_usage`|Average CPU Usage|Average CPU utilization across all nodes in the CSS cluster.|0-100%|1 minute|
| `avg_mem_used_percent`|Average Used Memory Ratio|Average ratio of used memory across all nodes in the CSS cluster.|0-100%|1 minute|
| `disk_util`|Disk Utilization|This metric measures the disk usage of the monitored object.|0-100%|1 minute|
| `avg_load_average`|Average Node Load Value|Average number of queued tasks over 1 minute across all nodes in the CSS cluster.|≥ 0|1 minute|
| `avg_jvm_heap_usage`|Average JVM Heap Usage|Average JVM heap memory usage across all nodes in the CSS cluster.|0-100%|1 minute|
| `sum_current_opened_http_count`|Current Opened HTTP Connections|Sum of open and un-closed HTTP connections across all nodes in the CSS cluster.|≥ 0|1 minute|
| `avg_thread_pool_write_queue`|Average Queued Tasks in Write Queue|Average number of queued tasks in the write thread pool across all nodes in the CSS cluster.|≥ 0|1 minute|
| `avg_thread_pool_search_queue`|Average Queued Tasks in Search Queue|Average number of queued tasks in the search thread pool across all nodes in the CSS cluster.|≥ 0|1 minute|
| `avg_thread_pool_force_merge_queue`|Average Queued Tasks in ForceMerge Queue|Average number of queued tasks in the force merge thread pool across all nodes in the CSS cluster.|≥ 0|1 minute|
| `avg_thread_pool_write_rejected`|Average Rejected Tasks in Write Queue|Average number of rejected tasks in the write thread pool across all nodes in the CSS cluster.|≥ 0|1 minute|
| `avg_jvm_old_gc_count`|Average Old Generation GC Count|Average cumulative value of old generation garbage collection runs across all nodes in the CSS cluster.|≥ 0|1 minute|
| `avg_jvm_old_gc_time`|Average Old Generation GC Time|Average cumulative time spent on old generation garbage collection across all nodes in the CSS cluster.|≥ 0 ms|1 minute|
| `avg_jvm_young_gc_count`|Average Young Generation GC Count|Average cumulative value of young generation garbage collection runs across all nodes in the CSS cluster.|≥ 0|1 minute|
| `avg_jvm_young_gc_time`|Average Young Generation GC Time|Average cumulative time spent on young generation garbage collection across all nodes in the CSS cluster.|≥ 0 ms|1 minute|


## Objects {#object}

The data structure of the objects collected from the Huawei Cloud Search Service CSS for Elasticsearch can be viewed in 「Infrastructure - Custom」

```json
{
  "measurement": "huaweicloud_css",
  "tags": {
    "name"                       : "xxxxx",
    "publicIp"                   : "xxxxx",
    "id"                         : "xxxxx",
    "status"                     : "100",
    "endpoint"                   : "192.168.0.100:9200",
    "vpc_id"                     : "3dda7d4b-aec0-4838-a91a-28xxxxxxxx",
    "instance_name"              : "css-3384",
    "subnetId"                   : "xxxxx",
    "securityGroupId"            : "xxxxxxx",
    "enterpriseProjectId"        : "xxxxxxx",
    "project_id"                 : "xxxxxxx",
    "RegionId"                   : "cn-north-4"
  },
  "fields": {
    "datastore"                           : "{\"supportSecuritymode\": false, \"type\": \"elasticsearch\", \"version\": \"7.6.2\"}",
    "instances"                           : "[{\"azCode\": \"cn-east-3a\", \"id\": \"95f61e90-507b-48d4-8ac5-53dcefd155a3\", \"ip\": \"192.168.0.140\", \"name\": \"css-test-ess-esn-1-1\", \"specCode\": \"ess.spec-kc1.xlarge.2\", \"status\": \"200\", \"type\": \"ess\", \"volume\": {\"size\": 40, \"type\": \"HIGH\"}}]",
    "publicKibanaResp"                    : "xxxx",
    "elbWhiteList"                        : "xxxx",
    "updated"                             : "2023-06-27T07:35:29",
    "created"                             : "2023-06-27T07:35:29",
    "bandwidthSize"                       : "100",
    "actions"                             : "REBOOTING",
    "tags"                                : "xxxx",
    "period"                              : true, 
  }
}
```

Parameter descriptions are as follows:
| Parameter Name     | Description         |
| :------- | :----------- |
| `status` | Cluster status value   |
| `updated`  | Last modified time of the cluster, in ISO8601 format |
| `bandwidthSize` | Public network bandwidth, unit: `Mbit/s`   |
| `actions` | Current action of the cluster   |
| `period` | Whether it is a subscription-based cluster   |

Status (cluster status value) meanings:
| Value     | Description         |
| :------- | :----------- |
| `100`|Creating|
| `200`|Available|
| `303`|Unavailable|

Actions (current action of the cluster) meanings:
| Value     | Description         |
| :------- | :----------- |
| `REBOOTING` | Rebooting   |
| `GROWING` | Scaling up   |
| `RESTORING` | Restoring the cluster   |
| `SNAPSHOTTING` | Creating a snapshot   |

Period meanings:
| Value     | Description         |
| :------- | :----------- |
| `true` | Subscription-based billing cluster   |
| `false` | Pay-as-you-go billing cluster   |

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Note: The value of `tags.name` is the cluster ID, which serves as a unique identifier