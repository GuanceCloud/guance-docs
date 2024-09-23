---
title     : 'Cassandra'
summary   : '采集 Cassandra 的指标数据'
tags      :
  - '数据库'
__int_icon: 'icon/cassandra'
dashboard :
  - desc  : 'Cassandra'
    path  : 'dashboard/zh/cassandra'
monitor   :
  - desc  : 'Cassandra'
    path  : 'monitor/zh/cassandra'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

可以使用 [DDTrace](ddtrace.md) 采集 Cassandra 指标。采集数据流向如下：Cassandra -> DDTrace -> DataKit(StatsD)。

可以看到 DataKit 已经集成了 [StatsD](https://github.com/statsd/statsd){:target="_blank"} 的服务端，DDTrace 采集 Cassandra 的数据后使用 StatsD 的协议报告给了 Datakit。

## 配置 {#config}

### 前置条件 {#requrements}

- 已测试的版本：
    - [x] 5.0
    - [x] 4.1.3
    - [x] 3.11.15
    - [x] 3.0.24
    - [x] 2.1.22

- 下载 `dd-java-agent.jar` 包，参见 [这里](ddtrace.md){:target="_blank"};

- Datakit 侧：参见 [StatsD](statsd.md){:target="_blank"} 的配置。

- Cassandra 侧：

在 */usr/local/cassandra/bin* 下创建文件 *setenv.sh* 并赋予执行权限，再写入以下内容：

```shell
export CATALINA_OPTS="-javaagent:dd-java-agent.jar \
                      -Ddd.jmxfetch.enabled=true \
                      -Ddd.jmxfetch.statsd.host=${DATAKIT_HOST} \
                      -Ddd.jmxfetch.statsd.port=${DATAKIT_STATSD_HOST} \
                      -Ddd.jmxfetch.cassandra.enabled=true"
```

参数说明如下：

- `javaagent`: 这个填写 `dd-java-agent.jar` 的完整路径；
- `Ddd.jmxfetch.enabled`: 填 `true`, 表示开启 DDTrace 的采集功能；
- `Ddd.jmxfetch.statsd.host`: 填写 Datakit 监听的网络地址。不含端口号；
- `Ddd.jmxfetch.statsd.port`: 填写 Datakit 监听的端口号。一般为 `11002`，由 Datakit 侧的配置决定；
- `Ddd.jmxfetch.Cassandra.enabled`: 填 `true`, 表示开启 DDTrace 的 Cassandra 采集功能。开启后会多出名为 `cassandra` 的指标集；

重启 Cassandra 使配置生效。

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/db` 目录，复制 `cassandra.conf.sample` 并命名为 `cassandra.conf`。示例如下：
    
    ```toml
        
    [[inputs.statsd]]
      ## Collector alias.
      source = "statsd/cassandra"
    
      ## Collect interval, default is 10 seconds. (optional)
      # interval = '10s'
    
      protocol = "udp"
    
      ## Address and port to host UDP listener on: (defaults to ":8125")
      service_address = ":11002"
    
      ## Tag request metric. Used for distinguish feed metric name.
      ## eg, DD_TAGS=source_key:tomcat,host_key:cn-shanghai-sq5ei
      ## eg, -Ddd.tags=source_key:tomcat,host_key:cn-shanghai-sq5ei
      # statsd_source_key = "source_key"
      # statsd_host_key   = "host_key"
      ## Indicate whether report tag statsd_source_key and statsd_host_key.
      # save_above_key    = false
    
      delete_gauges = true
      delete_counters = true
      delete_sets = true
      delete_timings = true
    
      ## Counter metric is float in new Datakit version, set true if want be int.
      # set_counter_int = false
    
      ## Percentiles to calculate for timing & histogram stats
      percentiles = [50.0, 90.0, 99.0, 99.9, 99.95, 100.0]
    
      ## separator to use between elements of a statsd metric
      metric_separator = "_"
    
      ## Parses tags in the datadog statsd format
      ## http://docs.datadoghq.com/guides/dogstatsd/
      parse_data_dog_tags = true
    
      ## Parses datadog extensions to the statsd format
      datadog_extensions = true
    
      ## Parses distributions metric as specified in the datadog statsd format
      ## https://docs.datadoghq.com/developers/metrics/types/?tab=distribution#definition
      datadog_distributions = true
    
      ## We do not need following tags(they may create tremendous of time-series under influxdb's logic)
      ## Examples:
      ## "runtime-id", "metric-type"
      drop_tags = [ ]
    
      ## All metric-name prefixed with 'jvm_' are set to influxdb's measurement 'jvm'
      ## All metric-name prefixed with 'stats_' are set to influxdb's measurement 'stats'
      ## Attention: Must add these word in statsd conf file.
      metric_mapping = ["cassandra_:cassandra", "jvm_:cassandra_jvm", "jmx_:cassandra_jmx", "datadog_:cassandra_datadog"]
    
      ## Number of UDP messages allowed to queue up, once filled,
      ## the statsd server will start dropping packets, default is 128.
      # allowed_pending_messages = 128
    
      ## Number of timing/histogram values to track per-measurement in the
      ## calculation of percentiles. Raising this limit increases the accuracy
      ## of percentiles but also increases the memory usage and cpu time.
      percentile_limit = 1000
    
      ## Max duration (TTL) for each metric to stay cached/reported without being updated.
      # max_ttl = "1000h"
    
      [inputs.statsd.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    ```
    
    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

---

<!-- markdownlint-enable -->

## 指标 {#metric}



### `cassandra`

- 标签


| Tag | Description |
|  ----  | --------|
|`columnfamily`|'columnfamily'=batches 'columnfamily'=built_views 'columnfamily'=columns  'columnfamily'='paxos' 'columnfamily'=peer|
|`host`|Host name.|
|`instance`|Instance name.|
|`jmx_domain`|JMX domain.|
|`keyspace`|'keyspace'=system 'keyspace'=system_schema |
|`metric_type`|Metric type.|
|`name`|Type name.|
|`path`|path=request|
|`runtime-id`|Runtime id.|
|`scope`|scope=ReadStage scope=MutationStage scope=HintsDispatcher scope='MemtableFlushWriter' scope='MemtablePostFlush'|
|`service`|Service name.|
|`table`|table=IndexInfo,table=available_ranges,table=batches,table=built_views,|
|`type`|Object type.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active_tasks`|The number of tasks that the thread pool is actively executing.|float|count|
|`bloom_filter_false_ratio`|The ratio of Bloom filter false positives to total checks.|float|count|
|`bytes_flushed_count`|The amount of data that was flushed since (re)start.|float|B|
|`cas_commit_latency_75th_percentile`|The latency of 'paxos' commit round - p75.|float|ms|
|`cas_commit_latency_95th_percentile`|The latency of 'paxos' commit round - p95.|float|ms|
|`cas_commit_latency_one_minute_rate`|The number of 'paxos' commit round per second.|float|req/s|
|`cas_prepare_latency_75th_percentile`|The latency of 'paxos' prepare round - p75.|float|ms|
|`cas_prepare_latency_95th_percentile`|The latency of 'paxos' prepare round - p95.|float|ms|
|`cas_prepare_latency_one_minute_rate`|The number of 'paxos' prepare round per second.|float|req/s|
|`cas_propose_latency_75th_percentile`|The latency of 'paxos' propose round - p75.|float|ms|
|`cas_propose_latency_95th_percentile`|The latency of 'paxos' propose round - p95.|float|ms|
|`cas_propose_latency_one_minute_rate`|The number of 'paxos' propose round per second.|float|req/s|
|`col_update_time_delta_histogram_75th_percentile`|The column update time delta - p75.|float|ms|
|`col_update_time_delta_histogram_95th_percentile`|The column update time delta - p95.|float|ms|
|`col_update_time_delta_histogram_min`|The column update time delta - min.|float|ms|
|`compaction_bytes_written_count`|The amount of data that was compacted since (re)start.|float|B|
|`compression_ratio`|The compression ratio for all SSTables. A low value means a high compression contrary to what the name suggests. Formula used is: 'size of the compressed SSTable / size of original'|float|percent|
|`currently_blocked_tasks`|The number of currently blocked tasks for the thread pool.|float|count|
|`currently_blocked_tasks_count`|The number of currently blocked tasks for the thread pool.|float|count|
|`db_droppable_tombstone_ratio`|The estimate of the droppable tombstone ratio.|float|percent|
|`dropped_one_minute_rate`|The tasks dropped during execution for the thread pool.|float|count|
|`exceptions_count`|The number of exceptions thrown from 'Storage' metrics.|float|count|
|`key_cache_hit_rate`|The key cache hit rate.|float|count|
|`latency_75th_percentile`|The client request latency - p75.|float|ms|
|`latency_95th_percentile`|The client request latency - p95.|float|ms|
|`latency_one_minute_rate`|The number of client requests.|float|req/s|
|`live_disk_space_used_count`|The disk space used by live SSTables (only counts in use files).|float|B|
|`live_ss_table_count`|Number of live (in use) SSTables.|float|count|
|`load_count`|The disk space used by live data on a node.|float|B|
|`max_partition_size`|The size of the largest compacted partition.|float|B|
|`max_row_size`|The size of the largest compacted row.|float|B|
|`mean_partition_size`|The average size of compacted partition.|float|B|
|`mean_row_size`|The average size of compacted rows.|float|B|
|`metrics_75th_percentile`|Metrics - p75.|float|count|
|`metrics_95th_percentile`|Metrics - p95.|float|count|
|`metrics_count`|Metrics count.|float|count|
|`metrics_one_minute_rate`|The number of metrics.|float|count|
|`metrics_value`|Metrics value.|float|count|
|`net_down_endpoint_count`|The number of unhealthy nodes in the cluster. They represent each individual node's view of the cluster and thus should not be summed across reporting nodes.|float|count|
|`net_up_endpoint_count`|The number of healthy nodes in the cluster. They represent each individual node's view of the cluster and thus should not be summed across reporting nodes.|float|count|
|`nodetool_status_load`|Amount of file system data under the 'cassandra' data directory without snapshot content.|float|B|
|`nodetool_status_owns`|Percentage of the data owned by the node per data center times the replication factor.|float|percent|
|`nodetool_status_replication_availability`|Percentage of data available per 'keyspace' times replication factor.|float|percent|
|`nodetool_status_replication_factor`|Replication factor per 'keyspace'.|float|count|
|`nodetool_status_status`|Node status: up (1) or down (0).|float|bool|
|`pending_compactions`|The number of pending compactions.|float|count|
|`pending_flushes_count`|The number of pending flushes.|float|count|
|`pending_tasks`|The number of pending tasks for the thread pool.|float|count|
|`range_latency_75th_percentile`|The local range request latency - p75.|float|ms|
|`range_latency_95th_percentile`|The local range request latency - p95.|float|ms|
|`range_latency_one_minute_rate`|The number of local range requests.|float|req/s|
|`read_latency_75th_percentile`|The local read latency - p75.|float|ms|
|`read_latency_95th_percentile`|The local read latency - p95.|float|ms|
|`read_latency_99th_percentile`|The local read latency - p99.|float|ms|
|`read_latency_one_minute_rate`|The number of local read requests.|float|req/s|
|`row_cache_hit_count`|The number of row cache hits.|float|count|
|`row_cache_hit_out_of_range_count`|The number of row cache hits that do not satisfy the query filter and went to disk.|float|count|
|`row_cache_miss_count`|The number of table row cache misses.|float|count|
|`snapshots_size`|The disk space truly used by snapshots.|float|B|
|`ss_tables_per_read_histogram_75th_percentile`|The number of SSTable data files accessed per read - p75.|float|count|
|`ss_tables_per_read_histogram_95th_percentile`|The number of SSTable data files accessed per read - p95.|float|count|
|`timeouts_count`|Count of requests not acknowledged within configurable timeout window.|float|count|
|`timeouts_one_minute_rate`|Recent timeout rate, as an exponentially weighted moving average over a one-minute interval.|float|count|
|`tombstone_scanned_histogram_75th_percentile`|Number of tombstones scanned per read - p75.|float|count|
|`tombstone_scanned_histogram_95th_percentile`|Number of tombstones scanned per read - p95.|float|count|
|`total_blocked_tasks`|Total blocked tasks|float|count|
|`total_blocked_tasks_count`|Total count of blocked tasks|float|count|
|`total_commit_log_size`|The size used on disk by commit logs.|float|B|
|`total_disk_space_used_count`|Total disk space used by SSTables including obsolete ones waiting to be garbage collected|float|B|
|`view_lock_acquire_time_75th_percentile`|The time taken acquiring a partition lock for materialized view updates - p75.|float|ms|
|`view_lock_acquire_time_95th_percentile`|The time taken acquiring a partition lock for materialized view updates - p95.|float|ms|
|`view_lock_acquire_time_one_minute_rate`|The number of requests to acquire a partition lock for materialized view updates.|float|count|
|`view_read_time_75th_percentile`|The time taken during the local read of a materialized view update - p75.|float|ms|
|`view_read_time_95th_percentile`|The time taken during the local read of a materialized view update - p95.|float|ms|
|`view_read_time_one_minute_rate`|The number of local reads for materialized view updates.|float|count|
|`waiting_on_free_memtable_space_75th_percentile`|The time spent waiting for free mem table space either on- or off-heap - p75.|float|ms|
|`waiting_on_free_memtable_space_95th_percentile`|The time spent waiting for free mem table space either on- or off-heap - p95.|float|ms|
|`write_latency_75th_percentile`|The local write latency - p75.|float|ms|
|`write_latency_95th_percentile`|The local write latency - p95.|float|ms|
|`write_latency_99th_percentile`|The local write latency - p99.|float|ms|
|`write_latency_one_minute_rate`|The number of local write requests.|float|req/s|



### `cassandra_jvm`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|Host name.|
|`instance`|Instance name.|
|`jmx_domain`|JMX domain.|
|`metric_type`|Metric type.|
|`name`|Type name.|
|`runtime-id`|Runtime id.|
|`service`|Service name.|
|`type`|Object type.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`buffer_pool_direct_capacity`|Measure of total memory capacity of direct buffers.|float|B|
|`buffer_pool_direct_count`|Number of direct buffers in the pool.|float|count|
|`buffer_pool_direct_used`|Measure of memory used by direct buffers.|float|B|
|`buffer_pool_mapped_capacity`|Measure of total memory capacity of mapped buffers.|float|B|
|`buffer_pool_mapped_count`|Number of mapped buffers in the pool.|float|count|
|`buffer_pool_mapped_used`|Measure of memory used by mapped buffers.|float|B|
|`cpu_load_process`|Recent CPU utilization for the process.|float|percent|
|`cpu_load_system`|Recent CPU utilization for the whole system.|float|percent|
|`daemon_code_cache_used`|The number of daemon threads.|float|count|
|`daemon_thread_count`|Daemon thread count.|float|count|
|`gc_cms_count`|The total number of garbage collections that have occurred.|float|count|
|`gc_code_cache_used`|GC code cache used.|float|count|
|`gc_eden_size`|The 'eden' size in garbage collection.|float|B|
|`gc_major_collection_count`|The rate of major garbage collections. Set new_gc_metrics: true to receive this metric.|float|count|
|`gc_major_collection_time`|The fraction of time spent in major garbage collection. Set new_gc_metrics: true to receive this metric.|float|PPM|
|`gc_metaspace_size`|The `metaspace` size in garbage collection.|float|B|
|`gc_minor_collection_count`|The rate of minor garbage collections. Set new_gc_metrics: true to receive this metric.|float|count|
|`gc_minor_collection_time`|The fraction of time spent in minor garbage collection. Set new_gc_metrics: true to receive this metric.|float|PPM|
|`gc_old_gen_size`|The ond gen size in garbage collection.|float|B|
|`gc_parnew_time`|The approximate accumulated garbage collection time elapsed.|float|ms|
|`gc_survivor_size`|The survivor size in garbage collection.|float|B|
|`heap_memory`|The total Java heap memory used.|float|B|
|`heap_memory_committed`|The total Java heap memory committed to be used.|float|B|
|`heap_memory_init`|The initial Java heap memory allocated.|float|B|
|`heap_memory_max`|The maximum Java heap memory available.|float|B|
|`loaded_classes`|Number of classes currently loaded.|float|count|
|`non_heap_memory`|The total Java non-heap memory used. Non-heap memory is: `Metaspace + CompressedClassSpace + CodeCache`.|float|B|
|`non_heap_memory_committed`|The total Java non-heap memory committed to be used.|float|B|
|`non_heap_memory_init`|The initial Java non-heap memory allocated.|float|B|
|`non_heap_memory_max`|The maximum Java non-heap memory available.|float|B|
|`os_open_file_descriptors`|The number of file descriptors used by this process (only available for processes run as the dd-agent user)|float|count|
|`peak_thread_count`|The peak number of live threads.|float|count|
|`thread_count`|The number of live threads.|float|count|
|`total_thread_count`|The number of total threads.|float|count|



### `cassandra_jmx`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|Host name.|
|`instance`|Instance name.|
|`jmx_domain`|JMX domain.|
|`metric_type`|Metric type.|
|`name`|Type name.|
|`runtime-id`|Runtime id.|
|`service`|Service name.|
|`type`|Object type.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`gc_cms.count`|The total number of garbage collections that have occurred.|float|count|
|`gc_major_collection_count`|The rate of major garbage collections. Set new_gc_metrics: true to receive this metric.|float|count|
|`gc_major_collection_time`|The fraction of time spent in major garbage collection. Set new_gc_metrics: true to receive this metric.|float|PPM|
|`gc_minor_collection_count`|The rate of minor garbage collections. Set new_gc_metrics: true to receive this metric.|float|count|
|`gc_minor_collection_time`|The fraction of time spent in minor garbage collection. Set new_gc_metrics: true to receive this metric.|float|PPM|
|`gc_parnew.time`|The approximate accumulated garbage collection time elapsed.|float|ms|
|`heap_memory`|The total Java heap memory used.|float|B|
|`heap_memory_committed`|The total Java heap memory committed to be used.|float|B|
|`heap_memory_init`|The initial Java heap memory allocated.|float|B|
|`heap_memory_max`|The maximum Java heap memory available.|float|B|
|`non_heap_memory`|The total Java non-heap memory used. Non-heap memory is calculated as follows: 'Metaspace' + CompressedClassSpace + CodeCache|float|B|
|`non_heap_memory_committed`|The total Java non-heap memory committed to be used.|float|B|
|`non_heap_memory_init`|The initial Java non-heap memory allocated.|float|B|
|`non_heap_memory_max`|The maximum Java non-heap memory available.|float|B|
|`thread_count`|The number of live threads.|float|count|



### `cassandra_datadog`

- 标签


| Tag | Description |
|  ----  | --------|
|`endpoint`|Endpoint.|
|`host`|Host name.|
|`lang`|Lang type.|
|`lang_interpreter`|Lang interpreter.|
|`lang_interpreter_vendor`|Lang interpreter vendor.|
|`lang_version`|Lang version.|
|`metric_type`|Metric type.|
|`priority`|Priority.|
|`service`|Service name.|
|`stat`|Stat.|
|`tracer_version`|Tracer version.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`tracer_agent_discovery_time`|Tracer agent discovery time.|float|ms|
|`tracer_api_errors_total`|Tracer api errors total.|float|count|
|`tracer_api_requests_total`|Tracer api requests total.|float|count|
|`tracer_flush_bytes_total`|Tracer flush bytes total.|float|count|
|`tracer_flush_traces_total`|Tracer flush traces total.|float|count|
|`tracer_queue_enqueued_bytes`|Tracer queue enqueued bytes.|float|count|
|`tracer_queue_enqueued_spans`|Tracer queue enqueued spans.|float|count|
|`tracer_queue_enqueued_traces`|Tracer queue enqueued traces.|float|count|
|`tracer_queue_max_length`|Tracer queue max length.|float|count|
|`tracer_scope_activate_count`|Tracer scope activate count.|float|count|
|`tracer_scope_close_count`|Tracer scope close count.|float|count|
|`tracer_span_pending_created`|Tracer span pending created.|float|count|
|`tracer_span_pending_finished`|Tracer span pending finished.|float|count|
|`tracer_trace_agent_discovery_time`|Tracer trace agent discovery time.|float|count|
|`tracer_trace_agent_send_time`|Tracer trace agent send time.|float|count|
|`tracer_trace_pending_created`|Tracer trace pending created.|float|count|
|`tracer_tracer_trace_buffer_fill_time`|Tracer trace buffer fill time.|float|count|


