---
title     : 'ElasticSearch'
summary   : 'Collect ElasticSearch metrics'
tags:
  - 'DATA STORES'
__int_icon      : 'icon/elasticsearch'
dashboard :
  - desc  : 'ElasticSearch'
    path  : 'dashboard/en/elasticsearch'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

ElasticSearch collector mainly collects node operation, cluster health, JVM performance, metric performance, retrieval performance and so on.

## Configuration {#config}

### Preconditions {#requirements}

- ElasticSearch version >= 6.0.0
- ElasticSearch collects `Node Stats` metrics by default. If you need to collect `Cluster-Health` related metrics, you need to set `cluster_health = true`
- Setting `cluster_health = true` produces the following measurement
    - `elasticsearch_cluster_health`

- Setting `cluster_stats = true` produces the following measurement
    - `elasticsearch_cluster_stats`

### User Rights Configuration {#user-permission}

If the account password access is turned on, the corresponding permissions need to be configured, otherwise it will lead to the failure of obtaining monitoring information. Elasticsearch, Open District for Elasticsearch, and OpenSearch are currently supported.

#### Elasticsearch {#perm-es}

- Create the role `monitor` and set the following permissions.

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

- Create a custom user and assign the newly created `monitor` role.
- Please refer to the profile description for additional information.

#### Open Distro for Elasticsearch {#perm-open-es}

- Create a user
- Create the role `monitor` and set the following permissions:

```http
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

- Set the mapping relationship between roles and users

#### OpenSearch {#perm-opensearch}

- Create a user
- Create the role `monitor`, and set the following permissions:

```http
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

### Collector Configuration {#input-config}

- Set the mapping relationship between roles and users

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/db` directory under the DataKit installation directory, copy `elasticsearch.conf.sample` and name it `elasticsearch.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.elasticsearch]]
      ## Elasticsearch server url
      # Basic Authentication is allowed
      # servers = ["http://user:pass@localhost:9200"]
      servers = ["http://localhost:9200"]
    
      ## Collect interval
      # Time unit: "ns", "us" (or "µs"), "ms", "s", "m", "h"
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

    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap injection collector configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Metric {#metric}

For all of the following data collections, the global election tags will added automatically, we can add extra tags in `[inputs.elasticsearch.tags]` if needed:

``` toml
[inputs.elasticsearch.tags]
# some_tag = "some_value"
# more_tag = "some_other_value"
# ...
```



### `elasticsearch_node_stats`

- Tags


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

- Metrics


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

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster_name`|Name of the cluster, based on the Cluster name setting setting.|
|`index_name`|Name of the index. The name '_all' target all data streams and indices in a cluster.|

- Metrics


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

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster_name`|Name of the cluster, based on the cluster.name setting.|
|`node_name`|Name of the node.|
|`status`|Health status of the cluster, based on the state of its primary and replica shards.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`nodes_process_open_file_descriptors_avg`|Average number of concurrently open file descriptors. Returns -1 if not supported.|float|count|



### `elasticsearch_cluster_health`

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster_name`|Name of the cluster.|
|`cluster_status`|The cluster status: red, yellow, green.|

- Metrics


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



## Custom Object {#object}



















## Logging {#logging}

<!-- markdownlint-disable MD046 -->
???+ attention

    Log collection only supports log collection on installed DataKit hosts

To collect ElasticSearch logs, open `files` in ElasticSearch.conf and write to the absolute path of the ElasticSearch log file. For example:

```toml
[[inputs.elasticsearch]]
  ...
[inputs.elasticsearch.log]
files = ["/path/to/your/file.log"]
```
<!-- markdownlint-enable -->

When log collection is turned on, a log with a log `source` of `elasticsearch` is generated by default.

### Log Pipeline Feature Cut Field Description {#pipeline}

- ElasticSearch Universal Log Cutting
  
Example of common log text:

```log
[2021-06-01T11:45:15,927][WARN ][o.e.c.r.a.DiskThresholdMonitor] [master] high disk watermark [90%] exceeded on [A2kEFgMLQ1-vhMdZMJV3Iw][master][/tmp/elasticsearch-cluster/nodes/0] free: 17.1gb[7.3%], shards will be relocated away from this node; currently relocating away shards totalling [0] bytes; the node is expected to continue to exceed the high disk watermark when these relocations are complete
```

The list of cut fields is as follows:

| Field Name | Field Value                         | Description         |
| ---    | ---                            | ---          |
| time   | 1622519115927000000            | Log generation time |
| name   | o.e.c.r.a.DiskThresholdMonitor | Component name     |
| status | WARN                           | Log level     |
| nodeId | master                         | Node name     |

- ElasticSearch Search for Slow Log Cutting
  
Example of Searching for Slow Log Text:

```log
[2021-06-01T11:56:06,712][WARN ][i.s.s.query              ] [master] [shopping][0] took[36.3ms], took_millis[36], total_hits[5 hits], types[], stats[], search_type[QUERY_THEN_FETCH], total_shards[1], source[{"query":{"match":{"name":{"query":"Nariko","operator":"OR","prefix_length":0,"max_expansions":50,"fuzzy_transpositions":true,"lenient":false,"zero_terms_query":"NONE","auto_generate_synonyms_phrase_query":true,"boost":1.0}}},"sort":[{"price":{"order":"desc"}}]}], id[], 
```

The list of cut fields is as follows:

| Field Name   | Field Value              | Description             |
| ---      | ---                 | ---              |
| time     | 1622519766712000000 | Log generation time     |
| name     | i.s.s.query         | Component name         |
| status   | WARN                | Log level         |
| nodeId   | master              | Node name         |
| index    | shopping            | Index name         |
| duration | 36000000            | Request time, in ns |

- ElasticSearch Index Slow Log Cutting

Example of indexing slow log text:

```log
[2021-06-01T11:56:19,084][WARN ][i.i.s.index              ] [master] [shopping/X17jbNZ4SoS65zKTU9ZAJg] took[34.1ms], took_millis[34], type[_doc], id[LgC3xXkBLT9WrDT1Dovp], routing[], source[{"price":222,"name":"hello"}]
```

The list of cut fields is as follows:

| Field Name   | Field Value              | Description             |
| ---      | ---                 | ---              |
| time     | 1622519779084000000 | Log generation time     |
| name     | i.i.s.index         | Component name         |
| status   | WARN                | Log level         |
| nodeId   | master              | Node name         |
| index    | shopping            | Index name         |
| duration | 34000000            | Request time, in ns |
