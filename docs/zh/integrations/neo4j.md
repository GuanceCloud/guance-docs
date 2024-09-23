---
title     : 'Neo4j'
summary   : '采集 Neo4j 的指标数据'
tags:
  - '数据库'
__int_icon      : 'icon/neo4j'
dashboard :
  - desc  : 'Neo4j'
    path  : 'dashboard/zh/neo4j'
monitor   :
  - desc  : 'Neo4j'
    path  : 'monitor/zh/neo4j'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Neo4j 采集器用于采集 Neo4j 相关的指标数据，目前只支持 Prometheus 格式的数据

已测试的版本：

- [x] Neo4j 5.11.0 enterprise
- [x] Neo4j 4.4.0 enterprise
- [x] Neo4j 3.4.0 enterprise
- [ ] Neo4j 3.3.0 enterprise 及以下版本不支持
- [ ] Neo4j 5.11.0 community community 版本均不支持


## 前置条件 {#requirements}

- 安装 Neo4j 服务
  
参见[官方安装文档](https://neo4j.com/docs/operations-manual/current/installation/){:target="_blank"}

- 验证是否正确安装

  在浏览器访问网址 `<ip>:7474` 可以进入 Neo4j 管理界面。

- 打开 Neo4j Prometheus 端口
  
  找到并编辑 Neo4j 启动配置文件，通常是在 `/etc/neo4j/neo4j.conf`

  尾部追加

  ```ini
  # Enable the Prometheus endpoint. Default is false.
  server.metrics.prometheus.enabled=true
  # The hostname and port to use as Prometheus endpoint.
  # A socket address is in the format <hostname>, <hostname>:<port>, or :<port>.
  # If missing, the port or hostname is acquired from server.default_listen_address.
  # The default is localhost:2004.
  server.metrics.prometheus.endpoint=0.0.0.0:2004
  ```

  参见[官方配置文档](https://neo4j.com/docs/operations-manual/current/monitoring/metrics/expose/#_prometheus){:target="_blank"}
  
- 重启 Neo4j 服务

<!-- markdownlint-disable MD046 -->
???+ tip

    - 采集数据需要用到 `2004` 端口，远程采集的时候，被采集服务器这些端口需要打开。
    - 0.0.0.0:2004 如果是本地采集，可以改为 localhost:2004。
<!-- markdownlint-enable -->

## 配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/neo4j` 目录，复制 `neo4j.conf.sample` 并命名为 `neo4j.conf`。示例如下：
    
    ```toml
        
    [[inputs.neo4j]]
      ## Exporter URLs.
      urls = ["http://127.0.0.1:2004/metrics"]
    
      ## TLS configuration.
      tls_open = false
      # tls_ca = "/tmp/ca.crt"
      # tls_cert = "/tmp/peer.crt"
      # tls_key = "/tmp/peer.key"
    
      ## Set to 'true' to enable election.
      election = true
    
      ## disable setting host tag for this input
      disable_host_tag = false
    
      ## disable setting instance tag for this input
      disable_instance_tag = false
    
      ## Customize tags.
      # [inputs.neo4j.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
      
      ## (Optional) Collect interval: (defaults to "30s").
      # interval = "30s"
    
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

<!-- markdownlint-enable -->

## 指标 {#metric}



### `neo4j`

- 标签


| Tag | Description |
|  ----  | --------|
|`bufferpool`|Pool name.|
|`database`|Database name.|
|`db`|Database name.|
|`gc`|Garbage collection name.|
|`host`|Host name.|
|`instance`|Instance endpoint.|
|`pool`|Pool name.|
|`quantile`|Histogram `quantile`.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`bolt_sessions_started`|(only for neo4j.v3) The total number of Bolt sessions started since this instance started.|float|count|
|`database_check_point_duration`|The duration, in milliseconds, of the last checkpoint event. Checkpoints should generally take several seconds to several minutes. Long checkpoints can be an issue, as these are invoked when the database stops, when a hot backup is taken, and periodically as well. Values over `30` minutes or so should be cause for some investigation.|float|ms|
|`database_check_point_events_total`|The total number of checkpoint events executed so far.|float|count|
|`database_check_point_flushed_bytes`|The accumulated number of bytes flushed during the last checkpoint event.|float|count|
|`database_check_point_io_limit`|The IO limit used during the last checkpoint event.|float|count|
|`database_check_point_io_performed`|The number of IOs from Neo4j perspective performed during the last check point event.|float|count|
|`database_check_point_limit_millis`|The time in milliseconds of limit used during the last checkpoint.|float|ms|
|`database_check_point_limit_times`|The times limit used during the last checkpoint.|float|ms|
|`database_check_point_pages_flushed`|The number of pages that were flushed during the last checkpoint event.|float|count|
|`database_check_point_total_time_total`|The total time, in milliseconds, spent in `checkpointing` so far.|float|ms|
|`database_cluster_catchup_tx_pull_requests_received_total`|TX pull requests received from secondaries.|float|count|
|`database_cluster_discovery_cluster_converged`|Discovery cluster convergence.|float|count|
|`database_cluster_discovery_cluster_members`|Discovery cluster member size.|float|count|
|`database_cluster_discovery_cluster_unreachable`|Discovery cluster unreachable size.|float|count|
|`database_cluster_discovery_replicated_data`|Size of replicated data structures.|float|count|
|`database_cluster_raft_append_index`|The append index of the Raft log. Each index represents a write transaction (possibly internal) proposed for commitment. The values mostly increase, but sometimes they can decrease as a consequence of leader changes. The append index should always be less than or equal to the commit index.|float|count|
|`database_cluster_raft_applied_index`|The applied index of the Raft log. Represents the application of the committed Raft log entries to the database and internal state. The applied index should always be bigger than or equal to the commit index. The difference between this and the commit index can be used to monitor how up-to-date the follower database is.|float|count|
|`database_cluster_raft_commit_index`|The commit index of the Raft log. Represents the commitment of previously appended entries. Its value increases monotonically if you do not unbind the cluster state. The commit index should always be bigger than or equal to the appended index.|float|count|
|`database_cluster_raft_in_flight_cache_element_count`|In-flight cache element count.|float|count|
|`database_cluster_raft_in_flight_cache_hits_total`|In-flight cache hits.|float|count|
|`database_cluster_raft_in_flight_cache_max_bytes`|In-flight cache max bytes.|float|B|
|`database_cluster_raft_in_flight_cache_max_elements`|In-flight cache maximum elements.|float|count|
|`database_cluster_raft_in_flight_cache_misses_total`|In-flight cache misses.|float|count|
|`database_cluster_raft_in_flight_cache_total_bytes`|In-flight cache total bytes.|float|B|
|`database_cluster_raft_is_leader`|Is this server the leader? Track this for each database primary in the cluster. It reports `0` if it is not the leader and `1` if it is the leader. The sum of all of these should always be `1`. However, there are transient periods in which the sum can be more than `1` because more than one member thinks it is the leader. Action may be needed if the metric shows `0` for more than 30 seconds.|float|count|
|`database_cluster_raft_last_leader_message`|The time elapsed since the last message from a leader in milliseconds. Should reset periodically.|float|ms|
|`database_cluster_raft_message_processing_delay`|The time the Raft message stays in the queue after being received and before being processed, i.e. append and commit to the store. The higher the value, the longer the messages wait to be processed. This metric is closely linked to disk write performance.(gauge)|float|ms|
|`database_cluster_raft_message_processing_timer`|Timer for Raft message processing.|float|count|
|`database_cluster_raft_raft_log_entry_prefetch_buffer_async_put`|Raft Log Entry Prefetch buffer async puts.|float|count|
|`database_cluster_raft_raft_log_entry_prefetch_buffer_bytes`|Raft Log Entry Prefetch total bytes.|float|B|
|`database_cluster_raft_raft_log_entry_prefetch_buffer_lag`|Raft Log Entry Prefetch Lag.|float|count|
|`database_cluster_raft_raft_log_entry_prefetch_buffer_size`|Raft Log Entry Prefetch buffer size.|float|B|
|`database_cluster_raft_raft_log_entry_prefetch_buffer_sync_put`|Raft Log Entry Prefetch buffer sync puts.|float|count|
|`database_cluster_raft_replication_attempt_total`|The total number of Raft replication requests attempts. It is bigger or equal to the replication requests.|float|count|
|`database_cluster_raft_replication_fail_total`|The total number of Raft replication attempts that have failed.|float|count|
|`database_cluster_raft_replication_maybe_total`|Raft Replication maybe count.|float|count|
|`database_cluster_raft_replication_new_total`|The total number of Raft replication requests. It increases with write transactions (possibly internal) activity.|float|count|
|`database_cluster_raft_replication_success_total`|The total number of Raft replication requests that have succeeded.|float|count|
|`database_cluster_raft_term`|The Raft Term of this server. It increases monotonically if you do not unbind the cluster state.|float|count|
|`database_cluster_raft_tx_retries_total`|Transaction retries.|float|count|
|`database_cluster_store_copy_pull_update_highest_tx_id_received_total`|The highest transaction id that has been pulled in the last pull updates by this instance.|float|count|
|`database_cluster_store_copy_pull_update_highest_tx_id_requested_total`|The highest transaction id requested in a pull update by this instance.|float|count|
|`database_cluster_store_copy_pull_updates_total`|The total number of pull requests made by this instance.|float|count|
|`database_count_node`|The total number of nodes in the database. A rough metric of how big your graph is. And if you are running a bulk insert operation you can see this tick up.|float|count|
|`database_count_relationship`|The total number of relationships in the database.|float|count|
|`database_cypher_replan_events_total`|The total number of times `Cypher` has decided to re-plan a query. Neo4j caches 1000 plans by default. Seeing sustained replanning events or large spikes could indicate an issue that needs to be investigated.|float|count|
|`database_cypher_replan_wait_time_total`|The total number of seconds waited between query replans.|float|s|
|`database_db_query_execution_failure_total`|Count of failed queries executed.|float|count|
|`database_db_query_execution_latency_millis`|Execution time in milliseconds of queries executed successfully.|float|ms|
|`database_db_query_execution_success_total`|Count of successful queries executed.|float|count|
|`database_ids_in_use_node`|The total number of nodes stored in the database. Informational, not an indication of any issue. Spikes or large increases indicate large data loads, which could correspond with some behavior you are investigating.|float|count|
|`database_ids_in_use_property`|The total number of different property names used in the database. Informational, not an indication of any issue. Spikes or large increases indicate large data loads, which could correspond with some behavior you are investigating.|float|count|
|`database_ids_in_use_relationship`|The total number of relationships stored in the database. Informational, not an indication of any issue. Spikes or large increases indicate large data loads, which could correspond with some behavior you are investigating.|float|count|
|`database_ids_in_use_relationship_type`|The total number of different relationship types stored in the database. Informational, not an indication of any issue. Spikes or large increases indicate large data loads, which could correspond with some behavior you are investigating.|float|count|
|`database_index_fulltext_populated_total`|The total number of `fulltext` index population jobs that have been completed.|float|count|
|`database_index_fulltext_queried_total`|The total number of times `fulltext` indexes have been queried.|float|B|
|`database_index_lookup_populated_total`|The total number of lookup index population jobs that have been completed.|float|count|
|`database_index_lookup_queried_total`|The total number of times lookup indexes have been queried.|float|count|
|`database_index_point_populated_total`|The total number of point index population jobs that have been completed.|float|count|
|`database_index_point_queried_total`|The total number of times point indexes have been queried.|float|count|
|`database_index_range_populated_total`|The total number of range index population jobs that have been completed.|float|count|
|`database_index_range_queried_total`|The total number of times range indexes have been queried.|float|count|
|`database_index_text_populated_total`|The total number of text index population jobs that have been completed.|float|count|
|`database_index_text_queried_total`|The total number of times text indexes have been queried.|float|count|
|`database_index_vector_populated_total`|The total number of vector index population jobs that have been completed.|float|count|
|`database_index_vector_queried_total`|The total number of times vector indexes have been queried.|float|count|
|`database_pool_free`|Available unused memory in the pool, in bytes.|float|B|
|`database_pool_total_size`|Sum total size of capacity of the heap and/or native memory pool.|float|B|
|`database_pool_total_used`|Sum total used heap and native memory in bytes.|float|B|
|`database_pool_used_heap`|Used or reserved heap memory in bytes.|float|B|
|`database_pool_used_native`|Used or reserved native memory in bytes.|float|B|
|`database_store_size_database`|The size of the database, in bytes. The total size of the database helps determine how much cache page is required. It also helps compare the total disk space used by the data store and how much is available.|float|B|
|`database_store_size_total`|The total size of the database and transaction logs, in bytes. The total size of the database helps determine how much cache page is required. It also helps compare the total disk space used by the data store and how much is available.|float|B|
|`database_transaction_active`|The number of currently active transactions. Informational, not an indication of any issue. Spikes or large increases could indicate large data loads or just high read load.|float|count|
|`database_transaction_active_read`|The number of currently active read transactions.|float|count|
|`database_transaction_active_write`|The number of currently active write transactions.|float|count|
|`database_transaction_committed_read_total`|The total number of committed read transactions. Informational, not an indication of any issue. Spikes or large increases indicate high read load.|float|count|
|`database_transaction_committed_total`|The total number of committed transactions. Informational, not an indication of any issue. Spikes or large increases indicate large data loads or just high read load.|float|count|
|`database_transaction_committed_write_total`|The total number of committed write transactions. Informational, not an indication of any issue. Spikes or large increases indicate large data loads, which could correspond with some behavior you are investigating.|float|count|
|`database_transaction_last_closed_tx_id_total`|The ID of the last closed transaction.|float|count|
|`database_transaction_last_committed_tx_id_total`|The ID of the last committed transaction. Track this for each instance. (Cluster) Track this for each primary, and each secondary. Might break into separate charts. It should show one line, ever increasing, and if one of the lines levels off or falls behind, it is clear that this member is no longer replicating data, and action is needed to rectify the situation.|float|count|
|`database_transaction_peak_concurrent_total`|The highest peak of concurrent transactions. This is a useful value to understand. It can help you with the design for the highest load scenarios and whether the Bolt thread settings should be altered.|float|count|
|`database_transaction_rollbacks_read_total`|The total number of rolled back read transactions.|float|count|
|`database_transaction_rollbacks_total`|The total number of rolled back transactions.|float|count|
|`database_transaction_rollbacks_write_total`|The total number of rolled back write transactions.  Seeing a lot of writes rolled back may indicate various issues with locking, transaction timeouts, etc.|float|count|
|`database_transaction_started_total`|The total number of started transactions.|float|count|
|`database_transaction_terminated_read_total`|The total number of terminated read transactions.|float|count|
|`database_transaction_terminated_total`|The total number of terminated transactions.|float|count|
|`database_transaction_terminated_write_total`|The total number of terminated write transactions.|float|count|
|`database_transaction_tx_size_heap`|The transactions' size on heap in bytes.|float|B|
|`database_transaction_tx_size_native`|The transactions' size in native memory in bytes.|float|B|
|`db_operation_count_create_total`|Count of successful database create operations.|float|count|
|`db_operation_count_drop_total`|Count of successful database drop operations.|float|count|
|`db_operation_count_failed_total`|Count of failed database operations.|float|count|
|`db_operation_count_recovered_total`|Count of database operations that failed previously but have recovered.|float|count|
|`db_operation_count_start_total`|Count of successful database start operations.|float|count|
|`db_operation_count_stop_total`|Count of successful database stop operations.|float|count|
|`db_state_count_desired_started`|Databases that desire to be started on this server.|float|count|
|`db_state_count_failed`|Databases in a failed state on this server.|float|count|
|`db_state_count_hosted`|Databases hosted on this server. Databases in states `started`, `store copying`, or `draining` are considered hosted.|float|count|
|`dbms_bolt_accumulated_processing_time_total`|The total amount of time in milliseconds that worker threads have been processing messages. Useful for monitoring load via Bolt drivers in combination with other metrics.|float|ms|
|`dbms_bolt_accumulated_queue_time_total`|(unsupported feature) When `internal.server.bolt.thread_pool_queue_size` is enabled,  the total time in milliseconds that a Bolt message waits in the processing queue before a Bolt worker thread becomes available to process it. Sharp increases in this value indicate that the server is running at capacity. If `internal.server.bolt.thread_pool_queue_size` is disabled, the value should be `0`, meaning that messages are directly handed off to worker threads.|float|ms|
|`dbms_bolt_connections_closed_total`|The total number of Bolt connections closed since startup. This includes both properly and abnormally ended connections. Useful for monitoring load via Bolt drivers in combination with other metrics.|float|count|
|`dbms_bolt_connections_idle`|The total number of Bolt connections that are not currently executing `Cypher` or returning results.|float|count|
|`dbms_bolt_connections_opened_total`|The total number of Bolt connections opened since startup. This includes both succeeded and failed connections. Useful for monitoring load via the Bolt drivers in combination with other metrics.|float|count|
|`dbms_bolt_connections_running`|The total number of Bolt connections that are currently executing `Cypher` and returning results. Useful to track the overall load on Bolt connections. This is limited to the number of Bolt worker threads that have been configured via `dbms.connector.bolt.thread_pool_max_size`. Reaching this maximum indicated the server is running at capacity.|float|count|
|`dbms_bolt_messages_done_total`|The total number of Bolt messages that have completed processing whether successfully or unsuccessfully. Useful for tracking overall load.|float|count|
|`dbms_bolt_messages_failed_total`|The total number of messages that have failed while processing. A high number of failures may indicate an issue with the server and further investigation of the logs is recommended.|float|count|
|`dbms_bolt_messages_received_total`|The total number of messages received via Bolt since startup. Useful to track general message activity in combination with other metrics.|float|count|
|`dbms_bolt_messages_started_total`|The total number of messages that have started processing since being received. A received message may have begun processing until a Bolt worker thread becomes available. A large gap observed between `bolt.messages_received` and `bolt.messages_started` could indicate the server is running at capacity.|float|count|
|`dbms_page_cache_bytes_read_total`|The total number of bytes read by the page cache.|float|B|
|`dbms_page_cache_bytes_written_total`|The total number of bytes written by the page cache.|float|B|
|`dbms_page_cache_eviction_exceptions_total`|The total number of exceptions seen during the eviction process in the page cache.|float|count|
|`dbms_page_cache_evictions_cooperative_total`|The total number of cooperative page evictions executed by the page cache due to low available pages.|float|count|
|`dbms_page_cache_evictions_total`|The total number of page evictions executed by the page cache.|float|count|
|`dbms_page_cache_flushes_total`|The total number of page flushes executed by the page cache.|float|count|
|`dbms_page_cache_hit_ratio`|The ratio of hits to the total number of lookups in the page cache. Performance relies on efficiently using the page cache, so this metric should be in the 98-100% range consistently. If it is much lower than that, then the database is going to disk too often.|float|percent|
|`dbms_page_cache_hits_total`|The total number of page hits happened in the page cache.|float|count|
|`dbms_page_cache_iops_total`|The total number of IO operations performed by page cache.|float|count|
|`dbms_page_cache_merges_total`|The total number of page merges executed by the page cache.|float|count|
|`dbms_page_cache_page_canceled_faults_total`|The total number of canceled page faults happened in the page cache.|float|count|
|`dbms_page_cache_page_fault_failures_total`|The total number of failed page faults happened in the page cache.|float|count|
|`dbms_page_cache_page_faults_total`|The total number of page faults happened in the page cache. If this continues to rise over time, it could be an indication that more page cache is needed.|float|count|
|`dbms_page_cache_pages_copied_total`|The total number of page copies happened in the page cache.|float|count|
|`dbms_page_cache_pins_total`|The total number of page pins executed by the page cache.|float|count|
|`dbms_page_cache_throttled_millis_total`|The total number of `millis` page cache flush IO limiter was throttled during ongoing IO operations.|float|count|
|`dbms_page_cache_throttled_times_total`|The total number of times page cache flush IO limiter was throttled during ongoing IO operations.|float|count|
|`dbms_page_cache_unpins_total`|The total number of page unpins executed by the page cache.|float|count|
|`dbms_page_cache_usage_ratio`|The ratio of number of used pages to total number of available pages. This metric shows what percentage of the allocated page cache is actually being used. If it is 100%, then it is likely that the hit ratio will start dropping, and you should consider allocating more RAM to page cache.|float|percent|
|`dbms_pool_free`|Available unused memory in the pool, in bytes.|float|B|
|`dbms_pool_total_size`|Sum total size of the capacity of the heap and/or native memory pool.|float|B|
|`dbms_pool_total_used`|Sum total used heap and native memory in bytes.|float|B|
|`dbms_pool_used_heap`|Used or reserved heap memory in bytes.|float|B|
|`dbms_pool_used_native`|Used or reserved native memory in bytes.|float|B|
|`dbms_routing_query_count_local_total`|The total number of queries executed locally.|float|count|
|`dbms_routing_query_count_remote_external_total`|The total number of queries executed remotely to a member of a different cluster.|float|count|
|`dbms_routing_query_count_remote_internal_total`|The total number of queries executed remotely to a member of the same cluster.|float|count|
|`dbms_vm_file_descriptors_count`|The current number of open file descriptors.|float|count|
|`dbms_vm_file_descriptors_maximum`|(OS setting) The maximum number of open file descriptors. It is recommended to be set to 40K file handles, because of the native and `Lucene` indexing Neo4j uses. If this metric gets close to the limit, you should consider raising it.|float|count|
|`dbms_vm_gc_count_total`|Total number of garbage collections.|float|count|
|`dbms_vm_gc_time_total`|Accumulated garbage collection time in milliseconds. Long GCs can be an indication of performance issues or potential instability. If this approaches the heartbeat timeout in a cluster, it may cause unwanted leader switches.|float|ms|
|`dbms_vm_heap_committed`|Amount of memory (in bytes) guaranteed to be available for use by the JVM.|float|B|
|`dbms_vm_heap_max`|Maximum amount of heap memory (in bytes) that can be used. This is the amount of heap space currently used at a given point in time. Monitor this to identify if you are maxing out consistently, in which case, you should increase the initial and max heap size, or if you are `underutilizing`, you should decrease the initial and max heap sizes.|float|B|
|`dbms_vm_heap_used`|Amount of memory (in bytes) currently used. This is the amount of heap space currently used at a given point in time. Monitor this to identify if you are maxing out consistently, in which case, you should increase the initial and max heap size, or if you are `underutilizing`, you should decrease the initial and max heap sizes.|float|B|
|`dbms_vm_memory_buffer_capacity`|Estimated total capacity of buffers in the pool.|float|B|
|`dbms_vm_memory_buffer_count`|Estimated number of buffers in the pool.|float|B|
|`dbms_vm_memory_buffer_used`|Estimated amount of memory used by the pool.|float|B|
|`dbms_vm_memory_pool`|Estimated amount of memory in bytes used by the pool.|float|B|
|`dbms_vm_pause_time_total`|Accumulated detected VM pause time.|float|ms|
|`dbms_vm_threads`|The total number of live threads including daemon and non-daemon threads.|float|count|
|`log_append_batch_size`|The size of the last transaction append batch.|float|count|
|`log_appended_bytes_total`|The total number of bytes appended to the transaction log.|float|B|
|`log_flushes_total`|The total number of transaction log flushes.|float|count|
|`log_rotation_duration`|The duration, in milliseconds, of the last log rotation event.|float|ms|
|`log_rotation_events_total`|The total number of transaction log rotations executed so far.|float|count|
|`log_rotation_total_time_total`|The total time, in milliseconds, spent in rotating transaction logs so far.|float|ms|
|`network_master_network_store_writes`|(only for neo4j.v3) The master network store writes.|float|count|
|`network_master_network_tx_writes`|(only for neo4j.v3) The master network transaction writes.|float|count|
|`network_slave_network_tx_writes`|(only for neo4j.v3)  The slave network transaction writes.|float|count|
|`server_threads_jetty_all`|The total number of threads (both idle and busy) in the jetty pool.|float|count|
|`server_threads_jetty_idle`|The total number of idle threads in the jetty pool.|float|count|
|`vm_thread_count`|(only for neo4j.v4) Estimated number of active threads in the current thread group.|float|count|
|`vm_thread_total`|(only for neo4j.v4) The total number of live threads including daemon and non-daemon threads.|float|count|


