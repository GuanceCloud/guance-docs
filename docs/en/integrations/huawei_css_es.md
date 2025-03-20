---
title: 'Huawei Cloud Search Service CSS for Elasticsearch'
tags: 
  - Huawei Cloud
summary: 'Collect monitoring Metrics for Huawei Cloud Search Service CSS for Elasticsearch'
__int_icon: 'icon/huawei_css_es'
dashboard:

  - desc: 'Built-in views for Huawei Cloud Search Service CSS for Elasticsearch'
    path: 'dashboard/en/huawei_css_es'

monitor:
  - desc: 'Monitors for Huawei Cloud Search Service CSS for Elasticsearch'
    path: 'monitor/en/huawei_css_es'

---

Collect monitoring Metrics for Huawei Cloud Search Service CSS for Elasticsearch

## Configuration {#config}

### Install Func

It is recommended to activate the <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a qualified Huawei Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of Huawei Cloud Search Service CSS for Elasticsearch, we install the corresponding collection script: access the web service of func and enter 【Script Market】-【Details】, search by css keyword, and install 「<<< custom_key.brand_name >>> Integration (Huawei Cloud-CSS)」(ID: `guance_huaweicloud_css`)

After clicking 【Install】, input the corresponding parameters: Huawei Cloud AK, SK, Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set, and automatically configure the corresponding startup script.

After the script installation is complete, find the script 「<<< custom_key.brand_name >>> Integration (Huawei Cloud-CSS)」 in the "Development" section of Func, expand and modify this script. Find collector_configs and monitor_configs respectively and edit the content under region_projects. Change the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, see the corresponding automatic trigger configuration in the 「Management / Automatic Trigger Configuration」. Click 【Execute】, and it will be executed immediately without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.

### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the corresponding automatic trigger configurations. You can also check the corresponding task records and logs to see if there are any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, in 「Infrastructure - Resource Catalog」, check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, in 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}

Configure Huawei Cloud CSS Metrics. More Metrics can be collected through configuration [Huawei Cloud CSS Metric Details](https://support.huaweicloud.com/usermanual-css/css_01_0042.html){:target="_blank"}

### Instance Monitoring Metrics

The instance performance monitoring Metrics for Huawei Cloud Search Service CSS for Elasticsearch are shown in the following table. For more Metrics, please refer to [Table 1](https://support.huaweicloud.com/usermanual-rds/rds_pg_06_0001.html){:target="_blank"}

| Metric ID                                       | Metric Name                                | Metric Meaning                                                     |           Value Range           | Monitoring Period (Raw Metric) |
| -------------------------------------------- | --------------------------------------- | ------------------------------------------------------------ | ------------------ | -------------------- |
| `status`|Cluster Health Status|This Metric is used to statistically measure the status of the monitored object.|0,1,2,3;<br>0: The cluster is 100% available.<br>1: The data is complete, but some replicas are missing. High availability is somewhat weakened, posing risks, so please pay attention to the cluster situation promptly.<br>2: Data is missing, and anomalies will occur when using the cluster.<br>3: Cluster status not obtained.|1 minute|
| `indices_count`|Index Count|Number of indices in the CSS cluster.|≥ 0|1 minute|
| `total_shards_count`|Shard Count|Number of shards in the CSS cluster.|≥ 0|1 minute|
| `primary_shards_count`|Primary Shard Count|Number of primary shards in the CSS cluster.|≥ 0|1 minute|
| `coordinating_nodes_count`|Coordinating Node Count|Number of coordinating nodes in the CSS cluster.|≥ 0|1 minute|
| `data_nodes_count`|Data Node Count|Number of data nodes in the CSS cluster.|≥ 0|1 minute|
| `SearchRate`|Average Query Rate|Query QPS, the average number of query operations per second performed by the cluster.|≥ 0|1 minute|
| `IndexingRate`|Average Indexing Rate|Ingest TPS, the average number of indexing operations per second performed by the cluster.|≥ 0|1 minute|
| `IndexingLatency`|Average Indexing Latency|Average time required to complete an indexing operation on a shard.|≥ 0 ms|1 minute|
| `SearchLatency`|Average Query Latency|Average time required to complete a search operation on a shard.|≥ 0 ms|1 minute|
| `avg_cpu_usage`|Average CPU Usage|Average CPU utilization across all nodes in the CSS cluster.|0-100%|1 minute|
| `avg_mem_used_percent`|Average Used Memory Ratio|Average ratio of memory used across all nodes in the CSS cluster.|0-100%|1 minute|
| `disk_util`|Disk Utilization|This Metric is used to statistically measure the disk usage of the object.|0-100%|1 minute|
| `avg_load_average`|Average Node Load Value|Average value of the 1-minute average queue length across all nodes in the CSS cluster within the operating system.|≥ 0|1 minute|
| `avg_jvm_heap_usage`|Average JVM Heap Usage|Average JVM heap memory usage across all nodes in the CSS cluster.|0-100%|1 minute|
| `sum_current_opened_http_count`|Current Opened HTTP Connections|Sum of Http connections opened and not yet closed across all nodes in the CSS cluster.|≥ 0|1 minute|
| `avg_thread_pool_write_queue`|Average Number of Queued Tasks in Write Queue|Average number of queued tasks in the write thread pool across all nodes in the CSS cluster.|≥ 0|1 minute|
| `avg_thread_pool_search_queue`|Average Number of Queued Tasks in Search Queue|Average number of queued tasks in the search thread pool across all nodes in the CSS cluster.|≥ 0|1 minute|
| `avg_thread_pool_force_merge_queue`|Average Number of Queued Tasks in ForceMerge Queue|Average number of queued tasks in the force merge thread pool across all nodes in the CSS cluster.|≥ 0|1 minute|
| `avg_thread_pool_write_rejected`|Average Number of Rejected Tasks in Write Queue|Average number of rejected tasks in the write thread pool across all nodes in the CSS cluster.|≥ 0|1 minute|
| `avg_jvm_old_gc_count`|Average JVM Old Generation GC Count|Average cumulative value of the number of times "old generation" garbage collection has run across all nodes in the CSS cluster.|≥ 0|1 minute|
| `avg_jvm_old_gc_time`|Average JVM Old Generation GC Time|Average cumulative value of the time spent executing "old generation" garbage collection across all nodes in the CSS cluster.|≥ 0 ms|1 minute|
| `avg_jvm_young_gc_count`|Average JVM Young Generation GC Count|Average cumulative value of the number of times "young generation" garbage collection has run across all nodes in the CSS cluster.|≥ 0|1 minute|
| `avg_jvm_young_gc_time`|Average JVM Young Generation GC Time|Average cumulative value of the time spent executing "young generation" garbage collection across all nodes in the CSS cluster.|≥ 0 ms|1 minute|


## Objects {#object}

The Object data structure for the collected Huawei Cloud Search Service CSS for Elasticsearch can be seen in 「Infrastructure - Resource Catalog」

```json
{
  "measurement": "huaweicloud_css",
  "tags": {
    "RegionId"                   : "cn-north-4",
    "project_id"                 : "xxxxxxx",
    "enterpriseProjectId"        : "",
    "instance_id"                : "xxxxxxx-xxxxxxx-xxxxxxx-00001",
    "instance_name"              : "css-3384",
    "publicIp"                   : "xxxxx",
    "status"                     : "100",
    "endpoint"                   : "192.168.0.100:9200",
  },
  "fields": {
    "vpc_id"                     : "3dda7d4b-aec0-4838-a91a-28xxxxxxxx",
    "subnetId"                   : "xxxxx",
    "securityGroupId"            : "xxxxxxx",
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

Descriptions of some parameters are as follows:

| Parameter Name     | Description         |
| :------- | :----------- |
| `status` | Cluster status value   |
| `updated`  | Last modified time of the cluster, ISO8601 format |
| `bandwidthSize` | Public bandwidth, unit: `Mbit/s`   |
| `actions` | Current actions of the cluster   |
| `period` | Whether it is a subscription cluster   |

Meanings of the values for status (cluster status value):

| Value     | Description         |
| :------- | :----------- |
| `100`|Creating|
| `200`|Available|
| `303`|Unavailable|

Meanings of the values for actions (current actions of the cluster):

| Value     | Description         |
| :------- | :----------- |
| `REBOOTING` | Rebooting   |
| `GROWING` | Scaling up   |
| `RESTORING` | Restoring the cluster   |
| `SNAPSHOTTING` | Creating a snapshot   |

Meanings of the values for period:

| Value     | Description         |
| :------- | :----------- |
| `true` | Subscription-billed cluster   |
| `false` | Pay-as-you-go billed cluster   |

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Hint: The value of `tags.instance_id` is the cluster ID, which serves as a unique identifier.