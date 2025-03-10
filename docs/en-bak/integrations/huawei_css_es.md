---
title: 'HUAWEI CSS for Elasticsearch'
tags: 
  - Huawei Cloud
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/huawei_css_es'
dashboard:

  - desc: 'HUAWEI CLOUD Search Service CSS for Elasticsearch Dashboard'
    path: 'dashboard/zh/huawei_css_es'

monitor:
  - desc: 'HUAWEI CLOUD Search Service CSS for Elasticsearch Monitor'
    path: 'monitor/zh/huawei_css_es'

---


<!-- markdownlint-disable MD025 -->
# HUAWEI CLOUD CSS for Elasticsearch
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to monitor the cloud ,The data of the cloud asset is synchronized to the Guance.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically,Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip: Please prepare HUAWEI CLOUD AK that meets the requirements in advance（For simplicity's sake,You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of CSS for Elasticsearch cloud resources, we install the corresponding collection script:To access the [Script Market] via the web service of Func,search by css keywords,installation 「Guance Integration（HUAWEI CLOUD-CSS）」(ID：`guance_huaweicloud_css`)

Click [Install] and enter the corresponding parameters: HUAWEI CLOUD AK,SK,HUAWEI CLOUD account name.

Tap [Deploy startup Script]，The system automatically creates Startup script sets，And automatically configure the corresponding startup script.

After the script is installed,Find the script in「Development」in Func「Guance Integration（HUAWEI CLOUD-CSS）」,Expand to modify this script,find collector_configsandmonitor_configsEdit the content inregion_projects,Change the locale and Project ID to the actual locale and Project ID,Click Save Publish again.

In addition, the corresponding automatic trigger configuration is displayed in「Management / Crontab Config」. Tap [Run],It can be executed immediately once,without waiting for a periodic time.After a while,you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-rds-postgresql/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure HUAWEI CLOUD - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [HUAWEI CLOUD Monitor Metrics Details](https://support.huaweicloud.com/usermanual-css/css_01_0042.html){:target="_blank"}

### Instance monitoring metric

HUAWEI CLOUD CSS for Elasticsearch instance performance monitoring metric,as shown in the table below.

| Metric ID                                     | Metric name                                | Metric meaning                                                     |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Value range&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| Monitoring cycle(original metric)&nbsp;&nbsp; |
| ------------------------------------------ | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `status`|Cluster Health Status| This metric is used to measure the status of the monitoring object.|0, 1, 2, 3;<br>0: The cluster is 100% available.<br>1: Data is complete, but some replicas are missing. High availability is weakened to some extent, and there is a risk. Please pay attention to the cluster situation in a timely manner.<br>2: Data is missing, and using the cluster will result in exceptions.<br>3: Failed to obtain the cluster status.|1 minute|
| `indices_count`|Index Number| The number of indexes in the CSS cluster.|≥ 0|1 minute|
| `total_shards_count`|Shard Number| The number of shards in the CSS cluster.|≥ 0|1 minute|
| `primary_shards_count`|Primary Shard Number| The number of primary shards in the CSS cluster.|≥ 0|1 minute|
| `coordinating_nodes_count`|Coordination Node Number| The number of coordination nodes in the CSS cluster.|≥ 0|1 minute|
| `data_nodes_count`|Data Node Number| The number of data nodes in the CSS cluster.|≥ 0|1 minute|
| `SearchRate`|Average Query Rate| The QPS of the queries, which is the average number of queries per second in the cluster.|≥ 0|1 minute|
| `IndexingRate`|Average Index Rate| The TPS of the indexes, which is the average number of indexes per second in the cluster.|≥ 0|1 minute|
| `IndexingLatency`|Average Index Latency| The average time required for a shard to complete an index operation.|≥ 0 ms|1 minute|
| `SearchLatency`|Average Query Latency| The average time required for a shard to complete a search operation.|≥ 0 ms|1 minute|
| `avg_cpu_usage`|Average CPU Usage| The average CPU utilization of each node in the CSS cluster.|0-100%|1 minute|
| `avg_mem_used_percent`|Average Memory Usage Ratio| The average ratio of memory usage of each node in the CSS cluster.|0-100%|1 minute|
| `disk_util`|Disk Usage Ratio| This metric is used to measure the disk usage ratio of the monitoring object.|0-100%|1 minute|
| `avg_load_average`|Average Node Load Value| The average value of the number of tasks queued in the operating system for each node in the CSS cluster per minute.|≥ 0|1 minute|
| `avg_jvm_heap_usage`|Average JVM Heap Usage Ratio| The average ratio of JVM heap memory usage of each node in the CSS cluster.|0-100%|1 minute|
| `sum_current_opened_http_count`|Current Number of Open HTTP Connections| The total number of open and unclosed HTTP connections for each node in the CSS cluster.|≥ 0|1 minute|
| `avg_thread_pool_write_queue`|Average Number of Queued Tasks in the Write Queue| The average number of queued tasks in the write thread pool for each node in the CSS cluster.|≥ 0|1 minute|
| `avg_thread_pool_search_queue`|Average Number of Queued Tasks in the Search Queue| The average number of queued tasks in the search thread pool for each node in the CSS cluster.|≥ 0|1 minute|
| `avg_thread_pool_force_merge_queue`|Average Number of Queued Tasks in the ForceMerge Queue| The average number of queued tasks in the force merge thread pool for each node in the CSS cluster.|≥ 0|1 minute|
| `avg_thread_pool_write_rejected`|Average Number of Rejected Tasks in the Write Queue| The average number of rejected tasks in the write thread pool for each node in the CSS cluster.|≥ 0|1 minute|
| `avg_jvm_old_gc_count`|Average Number of JVM Garbage Collection in the Old Generation| The average cumulative number of garbage collection runs in the old generation of each node in the CSS cluster.|≥ 0|1 minute|
| `avg_jvm_old_gc_time`|Average JVM Garbage Collection Time in the Old Generation| The average cumulative time spent on garbage collection runs in the old generation of each node in the CSS cluster.|≥ 0 ms|1 minute|
| `avg_jvm_young_gc_count`|Average Number of JVM Garbage Collection in the Young Generation| The average cumulative number of garbage collection runs in the young generation of each node in the CSS cluster.|≥ 0|1 minute|
| `avg_jvm_young_gc_time`|Average JVM Garbage Collection Time in the Young Generation| The average cumulative time spent on garbage collection runs in the young generation of each node in the CSS cluster.|≥ 0 ms|1 minute|

## Object {#object}

The collected HUAWEI CLOUD CSS for Elasticsearch object data structure can see the object data from「Infrastructure-Custom」

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

Some parameter descriptions are as follows:
| parameter name     | illustrate  |
| ------------------ | ----------- |
| `status` | Cluster status value   |
| `updated`  | The last modification time of the cluster, in the format of ISO8601 |
| `bandwidthSize` | Public network bandwidth, unit: `Mbit/s`  |
| `actions` |  The current behavior of the cluster  |
| `period` | Whether it is a package period cluster   |

status (cluster status value) value meaning:
| value     | illustrate         |
| --------- | ------------------ |
| `100` | Creating   |
| `200` | Available   |
| `303` | unavailable   |

Actions (current behavior of the cluster) value meaning:
| value     | illustrate         |
| --------- | ------------------ |
| `REBOOTING` | Restart   |
| `GROWING` | Expansion   |
| `RESTORING` | Restoring the cluster   |
| `SNAPSHOTTING` | Create snapshot   |

period value meaning:
| value     | illustrate         |
| --------- | ------------------ |
| `true` | Periodic billing cluster   |
| `false` | On-demand billing cluster   |

> *notice:`tags`、`fields`The fields in this section may change with subsequent updates*
>
> Tip: `tags.name` The value is the cluster ID as a unique identification
