---
title     : 'ElasticSearch'
summary   : '采集 ElasticSearch 的指标数据'
tags:
  - '数据库'
__int_icon      : 'icon/elasticsearch'
dashboard :
  - desc  : 'ElasticSearch'
    path  : 'dashboard/zh/elasticsearch'
monitor   :
  - desc  : 'ElasticSearch'
    path  : 'monitor/zh/elasticsearch'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

ElasticSearch 采集器主要采集节点运行情况、集群健康、JVM 性能状况、索引性能、检索性能等。

## 配置 {#config}

### 前置条件 {#requirements}

- ElasticSearch 版本 >= 6.0.0
- ElasticSearch 默认采集 `Node Stats` 指标，如果需要采集 `Cluster-Health` 相关指标，需要设置 `cluster_health = true`
- 设置 `cluster_health = true` 可产生如下指标集
    - `elasticsearch_cluster_health`
- 设置 `cluster_stats = true` 可产生如下指标集
    - `elasticsearch_cluster_stats`

### 用户权限配置 {#user-permission}

如果开启账号密码访问，需要配置相应的权限，否则会导致监控信息获取失败错误。

目前支持 [Elasticsearch](elasticsearch.md#perm-es)、[Open Distro for Elasticsearch](elasticsearch.md#perm-open-es) 和 [OpenSearch](elasticsearch.md#perm-opensearch)。

#### Elasticsearch {#perm-es}

- 创建角色 `monitor`，设置如下权限

```http
POST /_security/role/monitor
{
  "applications": [],
  "cluster": [
      "monitor"
  ],
  "indices": [
      {
          "allow_restricted_indices": false,
          "names": [
              "*"
          ],
          "privileges": [
              "manage_ilm",
              "monitor"
          ]
      }
  ],
  "run_as": []
}
```

- 创建自定义用户，并赋予新创建的 `monitor` 角色。
- 其他信息请参考配置文件说明

#### Open Distro for ElasticSearch {#perm-open-es}

- 创建用户
- 创建角色 `monitor`，设置如下权限：

``` http
PUT _opendistro/_security/api/roles/monitor
{
  "description": "monitor es cluster",
  "cluster_permissions": [
    "cluster:admin/opendistro/ism/managedindex/explain",
    "cluster_monitor",
    "cluster_composite_ops_ro"
  ],
  "index_permissions": [
    {
      "index_patterns": [
        "*"
      ],
      "fls": [],
      "masked_fields": [],
      "allowed_actions": [
        "read",
        "indices_monitor"
      ]
    }
  ],
  "tenant_permissions": []
}
```

- 设置角色与用户之间的映射关系

#### OpenSearch {#perm-opensearch}

- 创建用户
- 创建角色 `monitor`，设置如下权限：

``` http
PUT _plugins/_security/api/roles/monitor
{
  "description": "monitor es cluster",
  "cluster_permissions": [
    "cluster:admin/opendistro/ism/managedindex/explain",
    "cluster_monitor",
    "cluster_composite_ops_ro"
  ],
  "index_permissions": [
    {
      "index_patterns": [
        "*"
      ],
      "fls": [],
      "masked_fields": [],
      "allowed_actions": [
        "read",
        "indices_monitor"
      ]
    }
  ],
  "tenant_permissions": []
}
```

- 设置角色与用户之间的映射关系

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/db` 目录，复制 `elasticsearch.conf.sample` 并命名为 `elasticsearch.conf`。示例如下：
    
    ```toml
        
    [[inputs.elasticsearch]]
      ## Elasticsearch server url
      # Basic Authentication is allowed
      # servers = ["http://user:pass@localhost:9200"]
      servers = ["http://localhost:9200"]
    
      ## Collect interval
      # Time unit: "ns", "us", "ms", "s", "m", "h"
      interval = "10s"
    
      ## HTTP timeout
      http_timeout = "5s"
    
      ## Distribution: elasticsearch, opendistro, opensearch
      distribution = "elasticsearch"
    
      ## Set local true to collect the metrics of the current node only.
      # Or you can set local false to collect the metrics of all nodes in the cluster.
      local = false
    
      ## Set true to collect the health metric of the cluster.
      cluster_health = true
    
      ## Set cluster health level, either indices or cluster.
      # cluster_health_level = "indices"
    
      ## Whether to collect the stats of the cluster.
      cluster_stats = true 
    
      ## Set true to collect cluster stats only from the master node.
      cluster_stats_only_from_master = true
    
      ## Indices to be collected, such as _all.
      indices_include = ["_all"]
    
      ## Indices level, may be one of "shards", "cluster", "indices".
      # Currently only "shards" is implemented.
      indices_level = "shards"
    
      ## Specify the metrics to be collected for the node stats, such as "indices", "os", "process", "jvm", "thread_pool", "fs", "transport", "http", "breaker".
      # node_stats = ["jvm", "http"]
    
      ## HTTP Basic Authentication
      # username = ""
      # password = ""
    
      ## TLS Config
      tls_open = false
      # tls_ca = "/etc/telegraf/ca.pem"
      # tls_cert = "/etc/telegraf/cert.pem"
      # tls_key = "/etc/telegraf/key.pem"
      ## Use TLS but skip chain & host verification
      # insecure_skip_verify = false
    
      ## Set true to enable election
      election = true
    
      # [inputs.elasticsearch.log]
      # files = []
      # #grok pipeline script path
      # pipeline = "elasticsearch.p"
    
      [inputs.elasticsearch.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

## 指标 {#metric}

以下所有数据采集，默认会追加全局选举 tag，也可以在配置中通过 `[inputs.elasticsearch.tags]` 指定其它标签：

``` toml
[inputs.elasticsearch.tags]
# some_tag = "some_value"
# more_tag = "some_other_value"
# ...
```



### `elasticsearch_node_stats`

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name`|Name of the cluster, based on the Cluster name setting setting.|
|`node_attribute_ml.enabled`|Set to true (default) to enable machine learning APIs on the node.|
|`node_attribute_ml.machine_memory`|The machine’s memory that machine learning may use for running analytics processes.|
|`node_attribute_ml.max_open_jobs`|The maximum number of jobs that can run simultaneously on a node.|
|`node_attribute_xpack.installed`|Show whether xpack is installed.|
|`node_host`|Network host for the node, based on the network.host setting.|
|`node_id`|The id for the node.|
|`node_name`|Human-readable identifier for the node.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`fs_data_0_available_in_gigabytes`|Total number of gigabytes available to this Java virtual machine on this file store.|float|B|
|`fs_data_0_free_in_gigabytes`|Total number of unallocated gigabytes in the file store.|float|B|
|`fs_data_0_total_in_gigabytes`|Total size (in gigabytes) of the file store.|float|B|
|`fs_io_stats_devices_0_operations`|The total number of read and write operations for the device completed since starting Elasticsearch.|float|count|
|`fs_io_stats_devices_0_read_kilobytes`|The total number of kilobytes read for the device since starting Elasticsearch.|float|count|
|`fs_io_stats_devices_0_read_operations`|The total number of read operations for the device completed since starting Elasticsearch.|float|count|
|`fs_io_stats_devices_0_write_kilobytes`|The total number of kilobytes written for the device since starting Elasticsearch.|float|count|
|`fs_io_stats_devices_0_write_operations`|The total number of write operations for the device completed since starting Elasticsearch.|float|count|
|`fs_io_stats_total_operations`|The total number of read and write operations across all devices used by Elasticsearch completed since starting Elasticsearch.|float|count|
|`fs_io_stats_total_read_kilobytes`|The total number of kilobytes read across all devices used by Elasticsearch since starting Elasticsearch.|float|count|
|`fs_io_stats_total_read_operations`|The total number of read operations for across all devices used by Elasticsearch completed since starting Elasticsearch.|float|count|
|`fs_io_stats_total_write_kilobytes`|The total number of kilobytes written across all devices used by Elasticsearch since starting Elasticsearch.|float|count|
|`fs_io_stats_total_write_operations`|The total number of write operations across all devices used by Elasticsearch completed since starting Elasticsearch.|float|count|
|`fs_timestamp`|Last time the file stores statistics were refreshed. Recorded in milliseconds since the Unix Epoch.|float|msec|
|`fs_total_available_in_gigabytes`|Total number of gigabytes available to this Java virtual machine on all file stores.|float|B|
|`fs_total_free_in_gigabytes`|Total number of unallocated gigabytes in all file stores.|float|B|
|`fs_total_total_in_gigabytes`|Total size (in gigabytes) of all file stores.|float|B|
|`http_current_open`|Current number of open HTTP connections for the node.|float|count|
|`indices_fielddata_evictions`|Total number of evictions from the field data cache across all shards assigned to selected nodes.|float|count|
|`indices_fielddata_memory_size_in_bytes`|Total amount, in bytes, of memory used for the field data cache across all shards assigned to selected nodes.|float|B|
|`indices_get_missing_time_in_millis`|Time in milliseconds spent performing failed get operations.|float|ms|
|`indices_get_missing_total`|Total number of failed get operations.|float|count|
|`jvm_gc_collectors_old_collection_count`|Number of JVM garbage collectors that collect old generation objects.|float|count|
|`jvm_gc_collectors_old_collection_time_in_millis`|Total time in milliseconds spent by JVM collecting old generation objects.|float|ms|
|`jvm_gc_collectors_young_collection_count`|Number of JVM garbage collectors that collect young generation objects.|float|count|
|`jvm_gc_collectors_young_collection_time_in_millis`|Total time in milliseconds spent by JVM collecting young generation objects.|float|ms|
|`jvm_mem_heap_committed_in_bytes`|Amount of memory, in bytes, available for use by the heap.|float|B|
|`jvm_mem_heap_used_percent`|Percentage of memory currently in use by the heap.|float|count|
|`os_cpu_load_average_15m`|Fifteen-minute load average on the system (field is not present if fifteen-minute load average is not available).|float|count|
|`os_cpu_load_average_1m`|One-minute load average on the system (field is not present if one-minute load average is not available).|float|count|
|`os_cpu_load_average_5m`| Five-minute load average on the system (field is not present if five-minute load average is not available).|float|count|
|`os_cpu_percent`|Recent CPU usage for the whole system, or -1 if not supported.|float|count|
|`os_mem_total_in_bytes`|Total amount of physical memory in bytes.|float|B|
|`os_mem_used_in_bytes`|Amount of used physical memory in bytes.|float|B|
|`os_mem_used_percent`|Percentage of used memory.|float|percent|
|`process_open_file_descriptors`|Number of opened file descriptors associated with the current or -1 if not supported.|float|count|
|`thread_pool_force_merge_queue`|Number of tasks in queue for the thread pool|float|count|
|`thread_pool_force_merge_rejected`|Number of tasks rejected by the thread pool executor.|float|count|
|`thread_pool_rollup_indexing_queue`|Number of tasks in queue for the thread pool|float|count|
|`thread_pool_rollup_indexing_rejected`|Number of tasks rejected by the thread pool executor.|float|count|
|`thread_pool_search_queue`|Number of tasks in queue for the thread pool|float|count|
|`thread_pool_search_rejected`|Number of tasks rejected by the thread pool executor.|float|count|
|`thread_pool_transform_indexing_queue`|Number of tasks in queue for the thread pool|float|count|
|`thread_pool_transform_indexing_rejected`|Number of tasks rejected by the thread pool executor.|float|count|
|`transport_rx_size_in_bytes`|Size of RX packets received by the node during internal cluster communication.|float|B|
|`transport_tx_size_in_bytes`|Size of TX packets sent by the node during internal cluster communication.|float|B|



### `elasticsearch_indices_stats`

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name`|Name of the cluster, based on the Cluster name setting setting.|
|`index_name`|Name of the index. The name '_all' target all data streams and indices in a cluster.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`index_number_of_replicas`|Number of replicas.|float|count|
|`index_number_of_shards`|Number of shards.|float|count|
|`primaries_docs_count`|Number of documents. Only for the primary shards.|float|count|
|`primaries_docs_deleted`|Number of deleted documents. Only for the primary shards.|float|count|
|`primaries_flush_total`|Number of flush operations. Only for the primary shards.|float|count|
|`primaries_flush_total_time_in_millis`|Total time in milliseconds spent performing flush operations. Only for the primary shards.|float|ms|
|`primaries_get_missing_total`|Total number of failed get operations. Only for the primary shards.|float|count|
|`primaries_indexing_index_current`|Number of indexing operations currently running. Only for the primary shards.|float|count|
|`primaries_indexing_index_time_in_millis`|Total time in milliseconds spent performing indexing operations. Only for the primary shards.|float|ms|
|`primaries_indexing_index_total`|Total number of indexing operations. Only for the primary shards.|float|count|
|`primaries_merges_current_docs`|Number of document merges currently running. Only for the primary shards.|float|count|
|`primaries_merges_total`|Total number of merge operations. Only for the primary shards.|float|count|
|`primaries_merges_total_docs`|Total number of merged documents. Only for the primary shards.|float|count|
|`primaries_merges_total_time_in_millis`|Total time in milliseconds spent performing merge operations. Only for the primary shards.|float|ms|
|`primaries_refresh_total`|Total number of refresh operations. Only for the primary shards.|float|count|
|`primaries_refresh_total_time_in_millis`|Total time in milliseconds spent performing refresh operations. Only for the primary shards.|float|ms|
|`primaries_search_fetch_current`|Number of fetch operations currently running. Only for the primary shards.|float|count|
|`primaries_search_fetch_time_in_millis`|Time in milliseconds spent performing fetch operations. Only for the primary shards.|float|ms|
|`primaries_search_fetch_total`|Total number of fetch operations. Only for the primary shards.|float|count|
|`primaries_search_query_current`|Number of query operations currently running. Only for the primary shards.|float|count|
|`primaries_search_query_time_in_millis`|Time in milliseconds spent performing query operations. Only for the primary shards.|float|ms|
|`primaries_search_query_total`|Total number of query operations. Only for the primary shards.|float|count|
|`primaries_store_size_in_bytes`|Total size, in bytes, of all shards assigned to selected nodes. Only for the primary shards.|float|B|
|`total_docs_count`|Number of documents.|float|B|
|`total_docs_deleted`|Number of deleted documents.|float|B|
|`total_flush_total`|Number of flush operations.|float|count|
|`total_flush_total_time_in_millis`|Total time in milliseconds spent performing flush operations.|float|ms|
|`total_get_missing_total`|Total number of failed get operations.|float|count|
|`total_indexing_index_current`|Number of indexing operations currently running.|float|count|
|`total_indexing_index_time_in_millis`|Total time in milliseconds spent performing indexing operations.|float|ms|
|`total_indexing_index_total`|Total number of indexing operations.|float|count|
|`total_merges_current_docs`|Number of document merges currently running.|float|count|
|`total_merges_total`|Total number of merge operations.|float|count|
|`total_merges_total_docs`|Total number of merged documents.|float|count|
|`total_merges_total_time_in_millis`|Total time in milliseconds spent performing merge operations.|float|ms|
|`total_refresh_total`|Total number of refresh operations.|float|count|
|`total_refresh_total_time_in_millis`|Total time in milliseconds spent performing refresh operations.|float|ms|
|`total_search_fetch_current`|Number of fetch operations currently running.|float|count|
|`total_search_fetch_time_in_millis`|Time in milliseconds spent performing fetch operations.|float|ms|
|`total_search_fetch_total`|Total number of fetch operations.|float|count|
|`total_search_query_current`|Number of query operations currently running.|float|count|
|`total_search_query_time_in_millis`|Time in milliseconds spent performing query operations.|float|ms|
|`total_search_query_total`|Total number of query operations.|float|count|
|`total_store_size_in_bytes`|Total size, in bytes, of all shards assigned to selected nodes.|float|B|



### `elasticsearch_cluster_stats`

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name`|Name of the cluster, based on the cluster.name setting.|
|`node_name`|Name of the node.|
|`status`|Health status of the cluster, based on the state of its primary and replica shards.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`nodes_process_open_file_descriptors_avg`|Average number of concurrently open file descriptors. Returns -1 if not supported.|float|count|



### `elasticsearch_cluster_health`

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name`|Name of the cluster.|
|`cluster_status`|The cluster status: red, yellow, green.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active_primary_shards`|The number of active primary shards in the cluster.|int|count|
|`active_shards`|The number of active shards in the cluster.|int|count|
|`indices_lifecycle_error_count`|The number of indices that are managed by ILM and are in an error state.|int|count|
|`initializing_shards`|The number of shards that are currently initializing.|int|count|
|`number_of_data_nodes`|The number of data nodes in the cluster.|int|count|
|`number_of_pending_tasks`|The total number of pending tasks.|int|count|
|`relocating_shards`|The number of shards that are relocating from one node to another.|int|count|
|`status_code`|The health as a number: red = 3, yellow = 2, green = 1.|int|count|
|`unassigned_shards`|The number of shards that are unassigned to a node.|int|count|



## 自定义对象 {#object}



















## 日志 {#logging}

<!-- markdownlint-disable MD046 -->
???+ attention

    日志采集仅支持采集已安装 DataKit 主机上的日志
<!-- markdownlint-enable -->

如需采集 ElasticSearch 的日志，可在 elasticsearch.conf 中 将 `files` 打开，并写入 ElasticSearch 日志文件的绝对路径。比如：

```toml
[[inputs.elasticsearch]]
  ...
[inputs.elasticsearch.log]
files = ["/path/to/your/file.log"]
```

开启日志采集以后，默认会产生日志来源（`source`）为 `elasticsearch` 的日志。

### 日志 Pipeline 功能切割字段说明 {#pipeline}

- ElasticSearch 通用日志切割
  
通用日志文本示例：

``` log
[2021-06-01T11:45:15,927][WARN ][o.e.c.r.a.DiskThresholdMonitor] [master] high disk watermark [90%] exceeded on [A2kEFgMLQ1-vhMdZMJV3Iw][master][/tmp/elasticsearch-cluster/nodes/0] free: 17.1gb[7.3%], shards will be relocated away from this node; currently relocating away shards totalling [0] bytes; the node is expected to continue to exceed the high disk watermark when these relocations are complete
```

切割后的字段列表如下：

| 字段名 | 字段值                         | 说明         |
| ---    | ---                            | ---          |
| time   | 1622519115927000000            | 日志产生时间 |
| name   | o.e.c.r.a.DiskThresholdMonitor | 组件名称     |
| status | WARN                           | 日志等级     |
| nodeId | master                         | 节点名称     |

- ElasticSearch 搜索慢日志切割
  
搜索慢日志文本示例：

``` log
[2021-06-01T11:56:06,712][WARN ][i.s.s.query              ] [master] [shopping][0] took[36.3ms], took_millis[36], total_hits[5 hits], types[], stats[], search_type[QUERY_THEN_FETCH], total_shards[1], source[{"query":{"match":{"name":{"query":"Nariko","operator":"OR","prefix_length":0,"max_expansions":50,"fuzzy_transpositions":true,"lenient":false,"zero_terms_query":"NONE","auto_generate_synonyms_phrase_query":true,"boost":1.0}}},"sort":[{"price":{"order":"desc"}}]}], id[], 
```

切割后的字段列表如下：

| 字段名   | 字段值              | 说明             |
| ---      | ---                 | ---              |
| time     | 1622519766712000000 | 日志产生时间     |
| name     | i.s.s.query         | 组件名称         |
| status   | WARN                | 日志等级         |
| nodeId   | master              | 节点名称         |
| index    | shopping            | 索引名称         |
| duration | 36000000            | 请求耗时，单位 ns|

- ElasticSearch 索引慢日志切割

索引慢日志文本示例：

``` log
[2021-06-01T11:56:19,084][WARN ][i.i.s.index              ] [master] [shopping/X17jbNZ4SoS65zKTU9ZAJg] took[34.1ms], took_millis[34], type[_doc], id[LgC3xXkBLT9WrDT1Dovp], routing[], source[{"price":222,"name":"hello"}]
```

切割后的字段列表如下：

| 字段名   | 字段值              | 说明             |
| ---      | ---                 | ---              |
| time     | 1622519779084000000 | 日志产生时间     |
| name     | i.i.s.index         | 组件名称         |
| status   | WARN                | 日志等级         |
| nodeId   | master              | 节点名称         |
| index    | shopping            | 索引名称         |
| duration | 34000000            | 请求耗时，单位 ns|
