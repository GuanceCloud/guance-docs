---
title     : 'Doris'
summary   : 'Collect metrics of Doris'
__int_icon      : 'icon/doris'
dashboard :
  - desc  : 'Doris'
    path  : 'dashboard/en/doris'
monitor   :
  - desc  : 'Doris'
    path  : 'monitor/en/doris'
---

<!-- markdownlint-disable MD025 -->
# Doris
<!-- markdownlint-enable -->
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Doris collector is used to collect metric data related to Doris, and currently it only supports data in Prometheus format.

## Configuration {#config}

Already tested version:

- [x] 2.0.0

### Preconditions {#requirements}

Doris defaults to enabling the Prometheus port

Check front-end: curl ip: 8030/metrics

Check backend: curl ip: 8040/metrics

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "host installation"

    Go to the `conf.d/db` directory under the DataKit installation directory, copy `doris.conf.sample` and name it `doris.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.prom]]
      ## Collector alias.
      source = "doris"
    
      ## (Optional) Collect interval: (defaults to "30s").
      # interval = "15s"
    
      ## Exporter URLs.
      urls = ["http://127.0.0.1:8030/metrics","http://127.0.0.1:8040/metrics"]
    
      ## Stream Size. 
      ## The source stream segmentation size.
      ## Default 1, source stream undivided. 
      stream_size = 0
    
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
    
      ## Measurement name.
      ## If measurement_name is empty, split metric name by '_', the first field after split as measurement set name, the rest as current metric name.
      ## If measurement_name is not empty, using this as measurement set name.
      ## Always add 'measurement_prefix' prefix at last.
      measurement_name = "doris_common"
    
    ## Customize measurement set name.
    ## Treat those metrics with prefix as one set.
    ## Prioritier over 'measurement_name' configuration.
    [[inputs.prom.measurements]]
      prefix = "doris_fe_"
      name = "doris_fe"
    
    [[inputs.prom.measurements]]
      prefix = "doris_be_"
      name = "doris_be"
    
    [[inputs.prom.measurements]]
      prefix = "jvm_"
      name = "doris_jvm"
    
    ## Customize tags.
    # [inputs.prom.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```
    
    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Can be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [Config ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) .

<!-- markdownlint-enable -->

## Metric {#metric}



### `doris_fe`

- tag


| Tag | Description |
|  ----  | --------|
|`catalog`|Catalog.|
|`host`|Host name.|
|`instance`|Instance endpoint.|
|`job`|Job type.|
|`method`|Method type.|
|`name`|Metric name.|
|`quantile`|quantile.|
|`state`|State.|
|`type`|Metric type.|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cache_added`|Cumulative value of the number.|float|count|
|`cache_hit`|Count of cache hits.|float|count|
|`connection_total`|Current number of FE MySQL port connections.|float|count|
|`counter_hit_sql_block_rule`|Number of queries blocked by SQL BLOCK RULE.|float|count|
|`edit_log`|Value of metadata log.|float|count|
|`edit_log_clean`|The number of times the historical metadata log was cleared.|float|count|
|`editlog_write_latency_ms`|metadata log write latency . For example, {quantile=0.75} indicates the 75th percentile write latency .|float|ms|
|`external_schema_cache`|SpecifyExternal Catalog _ The number of corresponding schema caches.|float|count|
|`hive_meta_cache`|Specify External Hive Meta store Catalog The number of corresponding partition caches.|float|count|
|`image_clean`|The number of times cleaning of historical metadata image files.|float|count|
|`image_push`|The number of times cleaning of historical metadata image files.|float|count|
|`image_write`|The Number of to generate metadata image files.|float|count|
|`job`|Current count of different job types and different job statuses. For example, {job=load, type=INSERT, state=LOADING} represents an import job of type INSERT and the number of jobs in the LOADING state.|float|count|
|`max_journal_id`|The maximum metadata log ID of the current FE node . If it is Master FE , it is the maximum ID currently written , if it is a non- Master FE , represents the maximum ID of the metadata log currently being played back.|float|count|
|`max_tablet_compaction_score`|The largest compaction score value among all BE nodes.|float|percent|
|`publish_txn_num`|Specify the number of transactions being published by the DB . For example, { db =test} indicates the number of transactions currently being published by DB test.|float|count|
|`qps`|Current number of FE queries per second ( only query requests are counted ).|float|req/s|
|`query_err`|Value of error query.|float|count|
|`query_err_rate`|Error queries per second.|float|req/s|
|`query_instance_begin`|Specify the fragment where the user request starts Number of instances . For example, {user=test_u} represents the user test_u Number of instances to start requesting.|float|count|
|`query_instance_num`|Specifies the fragment that the user is currently requesting Number of instances . For example, {user=test_u} represents the user test_u The number of instances currently being requested.|float|count|
|`query_latency_ms`|Percentile statistics of query request latency. For example, {quantile=0.75} indicates the query delay at the 75th percentile.|float|ms|
|`query_latency_ms_db`|Percentile statistics of query request delay of each DB . For example, {quantile=0.75,db=test} indicates the query delay of the 75th percentile of DB test.|float|ms|
|`query_olap_table`|The statistics of the number of requests for the internal table ( `OlapTable` ).|float|count|
|`query_rpc_failed`|RPC failures sent to the specified BE . For example, { be=192.168.10.1} indicates the number of RPC failures sent to BE with IP address 192.168.10.1.|float|count|
|`query_rpc_size`|Specify the RPC data size of BE . For example, { be=192.168.10.1} indicates the number of RPC data bytes sent to BE with IP address 192.168.10.1.|float|count|
|`query_rpc_total`|Of RPCs sent to the specified BE . For example, { be=192.168.10.1} indicates the number of RPCs sent to BE with IP address 192.168.10.1.|float|count|
|`query_total`|All query requests.|float|count|
|`report_queue_size`|The queue length of various periodic reporting tasks of BE on the FE side.|float|count|
|`request_total`|All operation requests received through the MySQL port (including queries and other statements ).|float|count|
|`routine_load_error_rows`|Count the total number of error rows for all Routine Load jobs in the cluster.|float|count|
|`routine_load_receive_bytes`|The amount of data received by all Routine Load jobs in the cluster.|float|B|
|`routine_load_rows`|Count the number of data rows received by all Routine Load jobs in the cluster.|float|count|
|`rps`|Current number of FE requests per second (including queries and other types of statements ).|float|count|
|`scheduled_tablet_num`|Tablets being scheduled by the Master FE node . Includes replicas being repaired and replicas being balanced.|float|count|
|`tablet_max_compaction_score`|The compaction core reported by each BE node . For example, { backend=172.21.0.1:9556} represents the reported value of BE 172.21.0.1:9556.|float|percent|
|`tablet_num`|Current total number of tablets on each BE node . For example, {backend=172.21.0.1:9556} indicates the current number of tablets of the BE 172.21.0.1:9556.|float|count|
|`tablet_status_count`|Statistics Master FE node The cumulative value of the number of tablets scheduled by the tablet scheduler.|float|count|
|`thread_pool`|Count the number of working threads and queuing status of various thread pools . active_thread_num Indicates the number of tasks being executed . pool_size Indicates the total number of threads in the thread pool . task_in_queue Indicates the number of tasks being queued.|float|count|
|`thrift_rpc_latency_ms`|The RPC requests received by each method of the FE thrift interface take time. For example, {method=report} indicates that the RPC request received by the report method takes time.|float|ms|
|`thrift_rpc_total`|RPC requests received by each method of the FE thrift interface . For example, {method=report} indicates the number of RPC requests received by the report method.|float|count|
|`txn_counter`|Value of the number of imported transactions in each status.|float|count|
|`txn_exec_latency_ms`|Percentile statistics of transaction execution time. For example, {quantile=0.75} indicates the 75th percentile transaction execution time.|float|ms|
|`txn_num`|Specifies the number of transactions being performed by the DB . For example, { db =test} indicates the number of transactions currently being executed by DB test.|float|count|
|`txn_publish_latency_ms`|Percentile statistics of transaction publish time. For example, {quantile=0.75} indicates that the 75th percentile transaction publish time is.|float|ms|
|`txn_replica_num`|Specifies the number of replicas opened by the transaction being executed by the DB . For example, { db =test} indicates the number of copies opened by the transaction currently being executed by DB test.|float|count|
|`txn_status`|Count the number of import transactions currently in various states. For example, {type=committed} indicates the number of transactions in the committed state.|float|count|



### `doris_be`

- tag


| Tag | Description |
|  ----  | --------|
|`device`|Device name.|
|`host`|Host name.|
|`instance`|Instance endpoint.|
|`mode`|Metric mode.|
|`name`|Metric name.|
|`path`|File path.|
|`quantile`|quantile.|
|`status`|Metric status.|
|`type`|Metric type.|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active_scan_context_count`|The number of scanners currently opened directly from the outside.|float|count|
|`add_batch_task_queue_size`|When recording import, the queue size of the thread pool that receives the batch.|float|count|
|`agent_task_queue_size`|Display the length of each Agent Task processing queue, such as {type=CREATE_TABLE} Indicates the length of the CREATE_TABLE task queue.|float|count|
|`all_rowsets_num`|All currently `rowset` number of.|float|count|
|`all_segments_num`|The number of all current segments.|float|count|
|`brpc_endpoint_stub_count`|Created _ The number of `brpc` stubs used for interaction between BEs.|float|count|
|`brpc_function_endpoint_stub_count`|Created _ The number of `brpc` stubs used to interact with Remote RPC.|float|count|
|`cache_capacity`|Record the capacity of the specified LRU Cache.|float|B|
|`cache_hit_count`|Record the number of hits in the specified LRU Cache.|float|count|
|`cache_hit_ratio`|Record the hit rate of the specified LRU Cache.|float|percent|
|`cache_lookup_count`|Record the number of times the specified LRU Cache is searched.|float|B|
|`cache_usage`|Record the usage of the specified LRU Cache.|float|B|
|`cache_usage_ratio`|Record the usage of the specified LRU Cache.|float|percent|
|`chunk_pool_local_core_alloc_count`|ChunkAllocator , the number of times memory is allocated from the memory queue of the bound core.|float|count|
|`chunk_pool_other_core_alloc_count`|ChunkAllocator , the number of times memory is allocated from the memory queue of other cores.|float|count|
|`chunk_pool_reserved_bytes`|ChunkAllocator The amount of memory reserved in.|float|B|
|`chunk_pool_system_alloc_cost_ns`|SystemAllocator The cumulative value of time spent applying for memory.|float|ns|
|`chunk_pool_system_alloc_count`|SystemAllocator Number of times to apply for memory.|float|count|
|`chunk_pool_system_free_cost_ns`|SystemAllocator Cumulative value of time taken to release memory.|float|ns|
|`chunk_pool_system_free_count`|SystemAllocator The number of times memory is released.|float|count|
|`compaction_bytes_total`|Value of the amount of data processed by compaction.|float|B|
|`compaction_deltas_total`|Processed by compaction `rowset` The cumulative value of the number.|float|count|
|`compaction_used_permits`|The number of tokens used by the Compaction task.|float|count|
|`compaction_waitting_permits`|Compaction tokens awaiting.|float|count|
|`cpu`|CPU related metrics metrics, from /proc/stat collection. Each value of each logical core will be collected separately . like {device=cpu0,mode =nice} Indicates the nice value of cpu0.|float|count|
|`data_stream_receiver_count`|Number of data receiving terminals Receiver.|float|count|
|`disk_bytes_read`|The cumulative value of disk reads. from /proc/ `diskstats` collection. The values of each disk will be collected separately . like {device=vdd} express vvd disk value.|float|B|
|`disk_bytes_written`|The cumulative value of disk writes.|float|B|
|`disk_io_time_ms`|The dis io time.|float|ms|
|`disk_io_time_weighted`|The dis io time weighted.|float|ms|
|`disk_read_time_ms`|The dis reads time.|float|ms|
|`disk_reads_completed`|The dis reads completed.|float|B|
|`disk_write_time_ms`|The disk write time.|float|ms|
|`disk_writes_completed`|The disk writes completed.|float|B|
|`disks_avail_capacity`|Specify the remaining space on the disk where the specified data directory is located. like {path=path1} express /path1 The remaining space on the disk where the directory is located.|float|B|
|`disks_compaction_num`|Compaction tasks being executed on the specified data directory . like {path=path1} means /path1 The number of tasks being executed on the directory.|float|count|
|`disks_compaction_score`|Specifies the number of compaction tokens being executed on the data directory. like {path=path1} means /path1 Number of tokens being executed on the directory.|float|percent|
|`disks_local_used_capacity`|The specified data directory is located.|float|B|
|`disks_remote_used_capacity`|The specified data directory is located.|float|B|
|`disks_state`|Specifies the disk status of the data directory . 1 means normal. 0 means abnormal.|float|bool|
|`disks_total_capacity`|Capacity of the disk where the specified data directory is located.|float|B|
|`engine_requests_total`|Engine_requests total on BE.|float|count|
|`fd_num_limit`|System file handle limit upper limit. from /proc/sys/fs/file-nr collection.|float|count|
|`fd_num_used`|The number of file handles used by the system . from /proc/sys/fs/file-nr collection.|float|count|
|`file_created_total`|Cumulative number of local file creation times.|float|count|
|`fragment_endpoint_count`|Value of various task execution statuses on BE.|float|count|
|`fragment_instance_count`|The number of fragment instances currently received.|float|count|
|`fragment_request_duration_us`|All fragment `intance` The cumulative execution time of.|float|μs|
|`fragment_requests_total`|The cumulative number of executed fragment instances.|float|count|
|`fragment_thread_pool_queue_size`|Current query execution thread pool waiting queue.|float|count|
|`heavy_work_active_threads`|Number of active threads in heavy thread pool.|float|count|
|`heavy_work_max_threads`|Number of heavy thread pool threads.|float|count|
|`heavy_work_pool_queue_size`|The maximum length of the heavy thread pool queue will block the submission of work if it exceeds it.|float|count|
|`light_work_active_threads`|Number of active threads in light thread pool.|float|count|
|`light_work_max_threads`|Number of light thread pool threads.|float|count|
|`light_work_pool_queue_size`|The maximum length of the light thread pool queue . If it exceeds the maximum length, the submission of work will be blocked.|float|count|
|`load_average`|Machine Load Avg Metric metrics. For example, {mode=15_minutes} is 15 minutes Load Avg.|float|count|
|`load_bytes`|Cumulative quantity sent through tablet Sink.|float|B|
|`load_channel_count`|The number of load channels currently open.|float|count|
|`load_rows`|Cumulative number of rows sent through tablet Sink.|float|count|
|`local_bytes_read_total`|Depend on LocalFileReader Number of bytes read.|float|B|
|`local_bytes_written_total`|Depend on LocalFileWriter Number of bytes written.|float|B|
|`local_file_open_reading`|Currently open LocalFileReader number.|float|count|
|`local_file_reader_total`|Opened LocalFileReader Cumulative count of.|float|count|
|`local_file_writer_total`|Opened LocalFileWriter cumulative count.|float|count|
|`max_disk_io_util_percent`|value of the disk with the largest IO UTIL among all disks.|float|percent|
|`max_network_receive_bytes_rate`|The maximum receive rate calculated among all network cards.|float|B/S|
|`max_network_send_bytes_rate`|The calculated maximum sending rate among all network cards.|float|B/S|
|`mem_consumption`|Specifies the current memory overhead of the module . For example, {type=compaction} represents the current total memory overhead of the compaction module.|float|B|
|`memory_allocated_bytes`|BE process physical memory size, taken from /proc/self/status/ VmRSS.|float|B|
|`memory_jemalloc`|Jemalloc stats, taken from `je_mallctl`.|float|B|
|`memory_pgpgin`|The amount of data written by the system from disk to memory page.|float|B|
|`memory_pgpgout`|The amount of data written to disk by system memory pages.|float|B|
|`memory_pool_bytes_total`|all MemPool The size of memory currently occupied. Statistical value, does not represent actual memory usage.|float|B|
|`memory_pswpin`|The number of times the system swapped from disk to memory.|float|B|
|`memory_pswpout`|The number of times the system swapped from memory to disk.|float|B|
|`memtable_flush_duration_us`|value of the time taken to write `memtable` to disk.|float|μs|
|`memtable_flush_total`|number of `memtable` writes to disk.|float|count|
|`meta_request_duration`|Access RocksDB The cumulative time consumption of meta in.|float|μs|
|`meta_request_total`|Access RocksDB The cumulative number of meta requests.|float|count|
|`network_receive_bytes`|each network card are accumulated. Collected from /proc/net/dev.|float|B|
|`network_receive_packets`|each network card is accumulated. Collected from /proc/net/dev.|float|count|
|`network_send_bytes`|each network card . Collected from /proc/net/dev.|float|B|
|`network_send_packets`|The total number of packets sent by each network card is accumulated. Collected from /proc/net/dev.|float|count|
|`proc`|The number of processes currently .|float|count|
|`process_fd_num_limit_hard`|BE process. pass /proc/ pid /limits collection.|float|count|
|`process_fd_num_limit_soft`|BE process. pass /proc/ pid /limits collection.|float|count|
|`process_fd_num_used`|The number of file handles used by the BE process. pass /proc/ pid /limits collection.|float|count|
|`process_thread_num`|BE process threads. pass /proc/ pid /task collection.|float|count|
|`query_cache_memory_total_byte`|Number of bytes occupied by Query Cache.|float|B|
|`query_cache_partition_total_count`|Current number of Partition Cache caches.|float|count|
|`query_cache_sql_total_count`|Current number of SQL Cache caches.|float|count|
|`query_scan_bytes`|Read the cumulative value of the data amount. Here we only count reads `Olap` The amount of data in the table.|float|B|
|`query_scan_bytes_per_second`|According to doris_be_query_scan_bytes Calculated read rate.|float|B/S|
|`query_scan_rows`|Read the cumulative value of the number of rows. Here we only count reads `Olap` The amount of data in the table. and is RawRowsRead (Some data rows may be skipped by the index and not actually read, but will still be recorded in this value ).|float|count|
|`result_block_queue_count`|The number of fragment instances in the current query result cache.|float|count|
|`result_buffer_block_count`|The number of queries in the current query result cache.|float|count|
|`routine_load_task_count`|The number of routine load tasks currently being executed.|float|count|
|`rowset_count_generated_and_in_use`|New and in use since the last startup The number of `rowset` ids.|float|count|
|`s3_bytes_read_total`|S3FileReader The cumulative number.|float|count|
|`s3_file_open_reading`|currently open S3FileReader number.|float|count|
|`scanner_thread_pool_queue_size`|used for `OlapScanner` The current queued number of thread pools.|float|B|
|`segment_read`|Value of the number of segments read.|float|count|
|`send_batch_thread_pool_queue_size`|The number of queues in the thread pool used to send data packets when importing.|float|count|
|`send_batch_thread_pool_thread_num`|The number of threads in the thread pool used to send packets when importing.|float|count|
|`small_file_cache_count`|Currently cached by BE.|float|count|
|`snmp_tcp_in_errs`|tcp packet reception errors. Collected from /proc/net/ SNMP.|float|count|
|`snmp_tcp_in_segs`|tcp packets sent . Collected from /proc/net/ SNMP.|float|count|
|`snmp_tcp_out_segs`|tcp packets sent. Collected from /proc/net/ SNMP.|float|count|
|`snmp_tcp_retrans_segs`|TCP packet retransmissions . Collected from /proc/net/ SNMP.|float|count|
|`stream_load`|Value of the number received by stream load.|float|count|
|`stream_load_pipe_count`|Current stream load data pipelines.|float|count|
|`stream_load_txn_request`|Value of the number of transactions by stream load.|float|count|
|`streaming_load_current_processing`|Number of stream load tasks currently running.|float|count|
|`streaming_load_duration_ms`|The cumulative value of the execution time of all stream load tasks.|float|ms|
|`streaming_load_requests_total`|Value of the number of stream load tasks.|float|count|
|`tablet_base_max_compaction_score`|The current largest Base Compaction Score.|float|percent|
|`tablet_cumulative_max_compaction_score`|Same as above. Current largest Cumulative Compaction Score.|float|percent|
|`tablet_version_num_distribution`|The histogram of the number of tablet versions.|float|count|
|`thrift_connections_total`|Thrift connections created . like {name=heartbeat} Indicates the cumulative number of connections to the heartbeat service.|float|count|
|`thrift_current_connections`|Current number of thrift connections. like {name=heartbeat} Indicates the current number of connections to the heartbeat service.|float|count|
|`thrift_opened_clients`|Thrift clients currently open . like {name=frontend} Indicates the number of clients accessing the FE service.|float|count|
|`thrift_used_clients`|Thrift clients currently in use . like {name=frontend} Indicates the number of clients being used to access the FE service.|float|count|
|`timeout_canceled_fragment_count`|Cumulative value of the number of fragment instances canceled due to timeout.|float|count|
|`unused_rowsets_count`|The number of currently abandoned `rowsets`.|float|count|
|`upload_fail_count`|Cumulative value of `rowset` failed to be uploaded to remote storage.|float|count|
|`upload_rowset_count`|Cumulative number of `rowsets` successfully uploaded to remote storage.|float|count|
|`upload_total_byte`|Value of `rowset` data successfully uploaded to remote storage.|float|B|



### `doris_common`

- tag


| Tag | Description |
|  ----  | --------|
|`host`|Host name.|
|`instance`|Instance endpoint.|
|`name`|Metric name.|
|`state`|Metric state.|
|`type`|Metric type.|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`node_info`|Node_number.|float|count|
|`system_meminfo`|FE node machines. Collected from /proc/meminfo . include buffers , cached , memory_available , memory_free , memory_total.|float|B|
|`system_snmp`|FE node machines. Collected from /proc/net/ SNMP.|float|count|



### `doris_jvm`

- tag


| Tag | Description |
|  ----  | --------|
|`host`|Host name.|
|`instance`|Instance endpoint.|
|`type`|Metric type.|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`heap_size_bytes`|JVM memory metrics. The tags include max, used, committed , corresponding to the maximum value, used and requested memory respectively.|float|B|
|`non_heap_size_bytes`|JVM off-heap memory statistics.|float|B|
|`old_gc`|Cumulative value of GC.|float|count|
|`old_size_bytes`|JVM old generation memory statistics.|float|B|
|`thread`|JVM thread count statistics.|float|count|
|`young_size_bytes`|JVM new generation memory statistics.|float|B|



