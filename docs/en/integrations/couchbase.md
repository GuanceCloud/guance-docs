---
title     : 'Couchbase'
summary   : 'Collect metrics data related to Couchbase servers'
tags:
  - 'DATABASE'
__int_icon      : 'icon/couchbase'
dashboard :
  - desc  : 'Built-in views for Couchbase'
    path  : 'dashboard/en/couchbase'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The Couchbase collector is used to collect metrics data related to Couchbase servers.

The Couchbase collector supports remote collection and can run on various operating systems.

Tested versions:

- [x] Couchbase enterprise-7.2.0
- [x] Couchbase community-7.2.0

## Configuration {#config}

### Prerequisites {#requirements}

- Install Couchbase service
  
[Official Documentation - CentOS/RHEL Installation](https://docs.couchbase.com/server/current/install/install-intro.html){:target="_blank"}

[Official Documentation - Debian/Ubuntu Installation](https://docs.couchbase.com/server/current/install/ubuntu-debian-install.html){:target="_blank"}

[Official Documentation - Windows Installation](https://docs.couchbase.com/server/current/install/install-package-windows.html){:target="_blank"}

- Verify the correct installation

  Access the URL `<ip>:8091` in a browser to enter the Couchbase management interface.

<!-- markdownlint-disable MD046 -->
???+ tip

    - Data collection will use ports `8091` `9102` `18091` `19102`. When collecting remotely, these ports need to be open on the server being collected.
<!-- markdownlint-enable -->

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/couchbase` directory under the DataKit installation directory, copy `couchbase.conf.sample` and name it `couchbase.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.couchbase]]
      ## Collect interval, default is 30 seconds. (optional)
      # interval = "30s"
    
      ## Timeout: (defaults to "5s"). (optional)
      # timeout = "5s"
    
      ## Scheme, "http" or "https".
      scheme = "http"
    
      ## Host url or ip.
      host = "127.0.0.1"
    
      ## Host port. If "https" will be 18091.
      port = 8091
    
      ## Additional host port for index metric. If "https" will be 19102.
      additional_port = 9102
    
      ## Host user name.
      user = "Administrator"
    
      ## Host password.
      password = "123456"
    
      ## TLS configuration.
      tls_open = false
      # tls_ca = ""
      # tls_cert = "/var/cb/clientcertfiles/travel-sample.pem"
      # tls_key = "/var/cb/clientcertfiles/travel-sample.key"
    
      ## Disable setting host tag for this input
      disable_host_tag = false
    
      ## Disable setting instance tag for this input
      disable_instance_tag = false
    
      ## Set to 'true' to enable election.
      election = true
    
    # [inputs.couchbase.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Can be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [Config ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) .

    Can also be turned on by environment variables, (needs to be added as the default collector in ENV_DEFAULT_ENABLED_INPUTS):
    
    - **ENV_INPUT_COUCHBASE_INTERVAL**
    
        Collect interval
    
        **Field Type**: Duration
    
        **input.conf**: `interval`
    
        **Default**: 30s
    
    - **ENV_INPUT_COUCHBASE_TIMEOUT**
    
        Timeout
    
        **Type**: Duration
    
        **input.conf**: `timeout`
    
        **Default**: 5s
    
    - **ENV_INPUT_COUCHBASE_SCHEME**
    
        URL Scheme
    
        **Type**: String
    
        **input.conf**: `scheme`
    
        **Example**: http or https
    
    - **ENV_INPUT_COUCHBASE_HOST**
    
        server URL
    
        **Type**: String
    
        **input.conf**: `host`
    
        **Example**: 127.0.0.1
    
    - **ENV_INPUT_COUCHBASE_PORT**
    
        Host port, If https will be 18091
    
        **Type**: Int
    
        **input.conf**: `port`
    
        **Example**: 8091 or 18091
    
    - **ENV_INPUT_COUCHBASE_ADDITIONAL_PORT**
    
        Additional host port for index metric, If https will be 19102
    
        **Type**: Int
    
        **input.conf**: `additional_port`
    
        **Example**: 9102 or 19102
    
    - **ENV_INPUT_COUCHBASE_USER**
    
        User name
    
        **Type**: String
    
        **input.conf**: `user`
    
        **Example**: Administrator
    
    - **ENV_INPUT_COUCHBASE_PASSWORD**
    
        Password
    
        **Type**: String
    
        **input.conf**: `password`
    
        **Example**: 123456
    
    - **ENV_INPUT_COUCHBASE_TLS_OPEN**
    
        TLS open
    
        **Type**: Boolean
    
        **input.conf**: `tls_open`
    
        **Default**: false
    
    - **ENV_INPUT_COUCHBASE_TLS_CA**
    
        TLS configuration
    
        **Type**: String
    
        **input.conf**: `tls_ca`
    
        **Example**: /opt/ca.crt
    
    - **ENV_INPUT_COUCHBASE_TLS_CERT**
    
        TLS configuration
    
        **Type**: String
    
        **input.conf**: `tls_cert`
    
        **Example**: /opt/peer.crt
    
    - **ENV_INPUT_COUCHBASE_TLS_KEY**
    
        TLS configuration
    
        **Type**: String
    
        **input.conf**: `tls_key`
    
        **Example**: /opt/peer.key
    
    - **ENV_INPUT_COUCHBASE_ELECTION**
    
        Enable election
    
        **Type**: Boolean
    
        **input.conf**: `election`
    
        **Default**: true
    
    - **ENV_INPUT_COUCHBASE_TAGS**
    
        Customize tags. If there is a tag with the same name in the configuration file, it will be overwritten
    
        **Type**: Map
    
        **input.conf**: `tags`
    
        **Example**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

### TLS config {#tls}

TLS requires support from the Couchbase enterprise version

[Official Documentation - Configure Server Certificates](https://docs.couchbase.com/server/current/manage/manage-security/configure-server-certificates.html){:target="_blank"}

[Official Documentation - Configure Client Certificates](https://docs.couchbase.com/server/current/manage/manage-security/configure-client-certificates.html){:target="_blank"}

## Metrics {#metric}



### `cbnode`

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster`|Cluster name.|
|`host`|Host name.|
|`instance`|Instance endpoint.|
|`node`|Node IP.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cluster_membership`|Whether or not node is part of the CB cluster.|float|count|
|`failover`|Failover.|float|count|
|`failover_complete`|Failover complete.|float|count|
|`failover_incomplete`|Failover incomplete.|float|count|
|`failover_node`|Failover node.|float|count|
|`graceful_failover_fail`|Graceful failover fail.|float|count|
|`graceful_failover_start`|Graceful failover start.|float|count|
|`graceful_failover_success`|Graceful failover success.|float|count|
|`healthy`|Is this node healthy.|float|bool|
|`interestingstats_cmd_get`|Number of reads (get operations) per second from this bucket. (measured from cmd_get).|float|req/s|
|`interestingstats_couch_docs_actual_disk_size`|The size of all data service files on disk for this bucket, including the data itself, metadata, and temporary files. (measured from couch_docs_actual_disk_size).|float|B|
|`interestingstats_couch_docs_data_size`|Bytes of active data in this bucket. (measured from couch_docs_data_size).|float|B|
|`interestingstats_couch_spatial_data_size`|Interestingstats couch spatial data size.|float|B|
|`interestingstats_couch_spatial_disk_size`|Interestingstats couch spatial disk size.|float|B|
|`interestingstats_couch_views_actual_disk_size`|Bytes of active items in all the views for this bucket on disk (measured from couch_views_actual_disk_size).|float|B|
|`interestingstats_couch_views_data_size`|Bytes of active data for all the views in this bucket. (measured from couch_views_data_size).|float|B|
|`interestingstats_curr_items`|Current number of unique items in Couchbase.|float|count|
|`interestingstats_curr_items_tot`|Current number of items in Couchbase including replicas.|float|count|
|`interestingstats_ep_bg_fetched`|Number of reads per second from disk for this bucket. (measured from ep_bg_fetched).|float|req/s|
|`interestingstats_get_hits`|Number of get operations per second for data that this bucket contains. (measured from get_hits).|float|req/s|
|`interestingstats_mem_used`|Total memory used in bytes. (as measured from mem_used).|float|B|
|`interestingstats_ops`|Total operations per second (including `XDCR`) to this bucket. (measured from cmd_get + cmd_set + incr_misses + incr_hits + decr_misses + decr_hits + delete_misses + delete_hits + ep_num_ops_del_meta + ep_num_ops_get_meta + ep_num_ops_set_meta).|float|req/s|
|`interestingstats_vb_active_number_non_resident`|Interestingstats vb active number non resident.|float|count|
|`interestingstats_vb_replica_curr_items`|Number of items in replica vBuckets in this bucket. (measured from vb_replica_curr_items).|float|count|
|`memcached_memory_allocated`|Memcached memory allocated.|float|B|
|`memcached_memory_reserved`|Memcached memory reserved.|float|B|
|`memory_free`|Memory free.|float|B|
|`memory_total`|Memory total.|float|B|
|`rebalance_failure`|Rebalance failure.|float|count|
|`rebalance_start`|Rebalance start.|float|count|
|`rebalance_stop`|Rebalance stop.|float|count|
|`rebalance_success`|Rebalance success.|float|count|
|`systemstats_cpu_utilization_rate`|Percentage of CPU in use across all available cores on this server.|float|percent|
|`systemstats_mem_free`|Bytes of memory not in use on this server.|float|B|
|`systemstats_mem_total`|Bytes of total memory available on this server.|float|B|
|`systemstats_swap_total`|Bytes of total swap space available on this server.|float|B|
|`systemstats_swap_used`|Bytes of swap space in use on this server.|float|B|
|`uptime`|Uptime.|float|s|



### `cbbucketinfo`

- Tags


| Tag | Description |
|  ----  | --------|
|`bucket`|Bucket name.|
|`cluster`|Cluster name.|
|`host`|Host name.|
|`instance`|Instance endpoint.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`basic_dataused_bytes`|Basic data used.|float|B|
|`basic_diskfetches`|Basic disk fetches.|float|bool|
|`basic_diskused_bytes`|Basic disk used.|float|B|
|`basic_itemcount`|BucketItemCount first tries to retrieve an accurate bucket count via N1QL, but falls back to the REST API if that cannot be done (when there's no index to count all items in a bucket).|float|count|
|`basic_memused_bytes`|Basic memory used.|float|B|
|`basic_opspersec`|Basic ops per second.|float|s|
|`basic_quota_user_percent`|Basic quota percent used.|float|percent|



### `cbtask`

- Tags


| Tag | Description |
|  ----  | --------|
|`bucket`|Bucket name.|
|`cluster`|Cluster name.|
|`host`|Host name.|
|`instance`|Instance endpoint.|
|`node`|Node IP.|
|`source`|Source ID.|
|`target`|Target ID.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active_vbuckets_left`|Number of Active VBuckets remaining.|float|count|
|`cluster_logs_collection_progress`|Progress of a cluster logs collection task.|float|count|
|`compacting_progress`|Progress of a bucket compaction task.|int|count|
|`docs_total`|Docs total.|float|count|
|`docs_transferred`|Docs transferred.|float|count|
|`node_rebalance_progress`|Progress of a rebalance task per node.|float|count|
|`rebalance_progress`|Progress of a rebalance task.|float|count|
|`replica_vbuckets_left`|Number of Replica VBuckets remaining.|float|count|
|`xdcr_changes_left`|Number of updates still pending replication.|float|count|
|`xdcr_docs_checked`|Number of documents checked for changes.|float|count|
|`xdcr_docs_written`|Number of documents written to the destination cluster.|float|count|
|`xdcr_errors`|Number of errors.|float|count|
|`xdcr_paused`|Is this replication paused.|float|count|



### `cbquery`

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster`|Cluster name.|
|`host`|Host name.|
|`instance`|Instance endpoint.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active_requests`|Active number of requests.|float|count|
|`avg_req_time`|Average request time.|float|ms|
|`avg_response_size`|Average response size.|float|B|
|`avg_result_count`|Average result count.|float|count|
|`avg_svc_time`|Average service time.|float|ms|
|`errors`|Number of query errors.|float|count|
|`invalid_requests`|Number of invalid requests.|float|count|
|`queued_requests`|Number of queued requests.|float|count|
|`request_time`|Query request time.|float|ms|
|`requests`|Number of query requests.|float|count|
|`requests_1000ms`|Number of requests that take longer than 1000 ms per second.|float|req/s|
|`requests_250ms`|Number of requests that take longer than 250 ms per second.|float|req/s|
|`requests_5000ms`|Number of requests that take longer than 5000 ms per second.|float|req/s|
|`requests_500ms`|Number of requests that take longer than 500 ms per second.|float|req/s|
|`result_count`|Query result count.|float|count|
|`result_size`|Query result size.|float|B|
|`selects`|Number of queries involving SELECT.|float|count|
|`service_time`|Query service time.|float|ms|
|`warnings`|Number of query warnings.|float|count|



### `cbindex`

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster`|Cluster name.|
|`host`|Host name.|
|`instance`|Instance endpoint.|
|`keyspace`|Key space name.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`avg_scan_latency`|Average time to serve a scan request (nanoseconds).|float|ns|
|`cache_hit_percent`|Percentage of memory accesses that were served from the managed cache.|float|percent|
|`cache_hits`|Accesses to this index data from RAM.|float|count|
|`cache_misses`|Accesses to this index data from disk.|float|count|
|`frag_percent`|Percentage fragmentation of the index.|float|percent|
|`items_count`|The number of items currently indexed.|float|count|
|`memory_quota`|Index Service memory quota.|float|B|
|`memory_used`|Index Service memory used.|float|B|
|`num_docs_indexed`|Number of documents indexed by the indexer since last startup.|float|count|
|`num_docs_pending_queued`|Number of documents pending to be indexed.|float|count|
|`num_requests`|Number of requests served by the indexer since last startup.|float|count|
|`num_rows_returned`|Total number of rows returned so far by the indexer.|float|count|
|`ram_percent`|Percentage of Index RAM quota in use across all indexes on this server.|float|percent|
|`remaining_ram`|Bytes of Index RAM quota still available on this server.|float|B|
|`resident_percent`|Percentage of the data held in memory.|float|percent|



### `cbfts`

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster`|Cluster name.|
|`host`|Host name.|
|`instance`|Instance endpoint.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`curr_batches_blocked_by_herder`|Number of DCP batches blocked by the FTS throttler due to high memory consumption.|float|count|
|`num_bytes_used_ram`|Amount of RAM used by FTS on this server.|float|B|
|`total_queries_rejected_by_herder`|Number of fts queries rejected by the FTS throttler due to high memory consumption.|float|count|



### `cbcbas`

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster`|Cluster name.|
|`host`|Host name.|
|`instance`|Instance endpoint.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`disk_used`|The total disk size used by Analytics.|float|B|
|`gc_count`|Number of JVM garbage collections for Analytics node.|float|count|
|`gc_time`|The amount of time in milliseconds spent performing JVM garbage collections for Analytics node.|float|ms|
|`heap_used`|Amount of JVM heap used by Analytics on this server.|float|count|
|`io_reads`|Number of disk bytes read on Analytics node per second.|float|B/S|
|`io_writes`|Number of disk bytes written on Analytics node per second.|float|B/S|
|`system_load_avg`|System load for Analytics node.|float|count|
|`thread_count`|Number of threads for Analytics node.|float|count|



### `cbeventing`

- Tags


| Tag | Description |
|  ----  | --------|
|`cluster`|Cluster name.|
|`host`|Host name.|
|`instance`|Instance endpoint.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`bucket_op_exception_count`|Eventing bucket op exception count.|float|count|
|`checkpoint_failure_count`|Checkpoint failure count.|float|count|
|`dcp_backlog`|Mutations yet to be processed by the function.|float|count|
|`failed_count`|Mutations for which the function execution failed.|float|count|
|`n1ql_op_exception_count`|Number of disk bytes read on Analytics node per second.|float|B|
|`on_delete_failure`|Number of disk bytes written on Analytics node per second.|float|B/S|
|`on_delete_success`|System load for Analytics node.|float|count|
|`on_update_failure`|On update failure.|float|count|
|`on_update_success`|On update success.|float|count|
|`processed_count`|Mutations for which the function has finished processing.|float|count|
|`test_bucket_op_exception_count`|Test bucket op exception count.|float|count|
|`test_checkpoint_failure_count`|Test eventing bucket op exception count.|float|count|
|`test_dcp_backlog`|Test dcp backlog.|float|count|
|`test_failed_count`|Test failed count.|float|count|
|`test_n1ql_op_exception_count`|Test n1ql op exception count.|float|count|
|`test_on_delete_failure`|Test on delete failure.|float|count|
|`test_on_delete_success`|Test on delete success.|float|count|
|`test_on_update_failure`|Test on update failure.|float|count|
|`test_on_update_success`|Test on update success.|float|count|
|`test_processed_count`|Test processed count.|float|count|
|`test_timeout_count`|Test timeout count.|float|count|
|`timeout_count`|Function execution timed-out while processing.|float|count|



### `cbpernodebucket`

- Tags


| Tag | Description |
|  ----  | --------|
|`bucket`|Bucket name.|
|`cluster`|Cluster name.|
|`host`|Host name.|
|`instance`|Instance endpoint.|
|`node`|Node IP.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`avg_active_timestamp_drift`|Average drift (in seconds) between mutation timestamps and the local time for active vBuckets. (measured from ep_active_hlc_drift and ep_active_hlc_drift_count).|float|s|
|`avg_bg_wait_seconds`|avg_bg_wait_seconds.|float|s|
|`avg_disk_commit_time`|Average disk commit time in seconds as from disk_update histogram of timings.|float|s|
|`avg_disk_update_time`|Average disk update time in microseconds as from disk_update histogram of timings.|float|ms|
|`avg_replica_timestamp_drift`|Average drift (in seconds) between mutation timestamps and the local time for replica vBuckets. (measured from ep_replica_hlc_drift and ep_replica_hlc_drift_count).|float|s|
|`bg_wait_count`|Bg wait count.|float|count|
|`bg_wait_total`|Bg wait total.|float|count|
|`bytes_read`|Bytes Read.|float|B|
|`bytes_written`|Bytes written.|float|B|
|`cas_bad_val`|Compare and Swap bad values.|float|count|
|`cas_hits`|Number of operations with a CAS id per second for this bucket.|float|req/s|
|`cas_misses`|Compare and Swap misses.|float|count|
|`cmd_get`|Number of reads (get operations) per second from this bucket.|float|req/s|
|`cmd_set`|Number of writes (set operations) per second to this bucket.|float|req/s|
|`couch_docs_actual_disk_size`|The size of all data files for this bucket, including the data itself, meta data and temporary files.|float|B|
|`couch_docs_data_size`|The size of active data in this bucket.|float|B|
|`couch_docs_disk_size`|The size of all data files for this bucket, including the data itself, meta data and temporary files.|float|B|
|`couch_docs_fragmentation`|How much fragmented data there is to be compacted compared to real data for the data files in this bucket.|float|count|
|`couch_spatial_data_size`|Couch spatial data size.|float|B|
|`couch_spatial_disk_size`|Couch spatial disk size.|float|B|
|`couch_spatial_ops`|Couch spatial ops.|float|count|
|`couch_total_disk_size`|The total size on disk of all data and view files for this bucket.|float|B|
|`couch_views_actual_disk_size`|The size of all active items in all the indexes for this bucket on disk.|float|B|
|`couch_views_data_size`|The size of active data on for all the indexes in this bucket.|float|B|
|`couch_views_disk_size`|Couch views disk size.|float|B|
|`couch_views_fragmentation`|How much fragmented data there is to be compacted compared to real data for the view index files in this bucket.|float|count|
|`couch_views_ops`|All the view reads for all design documents including scatter gather.|float|count|
|`cpu_idle_ms`|CPU idle milliseconds.|float|ms|
|`cpu_local_ms`|CPU local ms.|float|ms|
|`cpu_utilization_rate`|Percentage of CPU in use across all available cores on this server.|float|percent|
|`curr_connections`|Number of connections to this server including connections from external client SDKs, proxies, DCP requests and internal statistic gathering.|float|count|
|`curr_items`|Number of items in active vBuckets in this bucket.|float|count|
|`curr_items_tot`|Total number of items in this bucket.|float|count|
|`decr_hits`|Decrement hits.|float|count|
|`decr_misses`|Decrement misses.|float|count|
|`delete_hits`|Number of delete operations per second for this bucket.|float|req/s|
|`delete_misses`|Number of delete operations per second for data that this bucket does not contain. (measured from delete_misses).|float|req/s|
|`disk_commit_count`|Disk commit count.|float|count|
|`disk_commit_total`|Disk commit total.|float|count|
|`disk_update_count`|Disk update count.|float|count|
|`disk_update_total`|Disk update total.|float|B|
|`disk_write_queue`|Number of items waiting to be written to disk in this bucket. (measured from ep_queue_size+ep_flusher_todo).|float|count|
|`ep_active_ahead_exceptions`|Total number of ahead exceptions (when timestamp drift between mutations and local time has exceeded 5000000 μs) per second for all active vBuckets.|float|req/s|
|`ep_active_hlc_drift`|Ep active hlc drift.|float|s|
|`ep_active_hlc_drift_count`|Ep active hlc drift count.|float|s|
|`ep_bg_fetched`|Number of reads per second from disk for this bucket.|float|req/s|
|`ep_cache_miss_rate`|Percentage of reads per second to this bucket from disk as opposed to RAM.|float|req/s|
|`ep_clock_cas_drift_threshold_exceeded`|Ep clock cas drift threshold exceeded.|float|s|
|`ep_data_read_failed`|Number of disk read failures. (measured from ep_data_read_failed).|float|count|
|`ep_data_write_failed`|Number of disk write failures. (measured from ep_data_write_failed).|float|count|
|`ep_dcp_2i_backoff`|Number of backoffs for indexes DCP connections.|float|count|
|`ep_dcp_2i_count`|Number of indexes DCP connections.|float|count|
|`ep_dcp_2i_items_remaining`|Number of indexes items remaining to be sent.|float|count|
|`ep_dcp_2i_items_sent`|Number of indexes items sent.|float|count|
|`ep_dcp_2i_producers`|Number of indexes producers.|float|count|
|`ep_dcp_2i_total_backlog_size`|Ep dcp 2i total backlog size.|float|B|
|`ep_dcp_2i_total_bytes`|Number of bytes per second being sent for indexes DCP connections.|float|B/S|
|`ep_dcp_cbas_backoff`|Number of backoffs per second for analytics DCP connections (measured from ep_dcp_cbas_backoff).|float|req/s|
|`ep_dcp_cbas_count`|Number of internal analytics DCP connections in this bucket (measured from ep_dcp_cbas_count).|float|count|
|`ep_dcp_cbas_items_remaining`|Number of items remaining to be sent to consumer in this bucket.|float|count|
|`ep_dcp_cbas_items_sent`|Number of items per second being sent for a producer for this bucket.|float|req/s|
|`ep_dcp_cbas_producer_count`|Number of analytics senders for this bucket (measured from ep_dcp_cbas_producer_count).|float|count|
|`ep_dcp_cbas_total_backlog_size`|Ep dcp `cbas` total backlog size.|float|count|
|`ep_dcp_fts_backlog_size`|Ep dcp fts backlog size.|float|count|
|`ep_dcp_fts_backoff`|Ep dcp fts backoff.|float|count|
|`ep_dcp_fts_count`|Ep dcp fts count.|float|count|
|`ep_dcp_fts_items_remaining`|Ep dcp fts items remaining.|float|count|
|`ep_dcp_fts_items_sent`|Ep dcp fts items sent.|float|count|
|`ep_dcp_fts_producer_count`|Ep dcp fts producer count.|float|count|
|`ep_dcp_fts_total_bytes`|Ep dcp fts total bytes.|float|B|
|`ep_dcp_other_backoff`|Number of backoffs for other DCP connections.|float|count|
|`ep_dcp_other_count`|Number of other DCP connections in this bucket.|float|count|
|`ep_dcp_other_items_remaining`|Number of items remaining to be sent to consumer in this bucket (measured from ep_dcp_other_items_remaining).|float|count|
|`ep_dcp_other_items_sent`|Number of items per second being sent for a producer for this bucket (measured from ep_dcp_other_items_sent).|float|req/s|
|`ep_dcp_other_producer_count`|Number of other senders for this bucket.|float|count|
|`ep_dcp_other_total_backlog_size`|Ep dcp other total backlog size.|float|B|
|`ep_dcp_other_total_bytes`|Number of bytes per second being sent for other DCP connections for this bucket.|float|B/S|
|`ep_dcp_replica_backoff`|Number of backoffs for replication DCP connections.|float|count|
|`ep_dcp_replica_count`|Number of internal replication DCP connections in this bucket.|float|count|
|`ep_dcp_replica_items_remaining`|Number of items remaining to be sent to consumer in this bucket.|float|count|
|`ep_dcp_replica_items_sent`|Number of items per second being sent for a producer for this bucket.|float|req/s|
|`ep_dcp_replica_producer_count`|Number of replication senders for this bucket.|float|count|
|`ep_dcp_replica_total_backlog_size`|Ep dcp replica total backlog size.|float|B|
|`ep_dcp_replica_total_bytes`|Number of bytes per second being sent for replication DCP connections for this bucket.|float|B|
|`ep_dcp_total_bytes`|Ep dcp total bytes.|float|B|
|`ep_dcp_views_backoff`|Number of backoffs for views DCP connections.|float|count|
|`ep_dcp_views_count`|Number of views DCP connections.|float|count|
|`ep_dcp_views_indexes_backoff`|Ep dcp views indexes backoff.|float|count|
|`ep_dcp_views_indexes_count`|Ep dcp views indexes count.|float|count|
|`ep_dcp_views_indexes_items_remaining`|Ep dcp views indexes items remaining.|float|count|
|`ep_dcp_views_indexes_items_sent`|Ep dcp views indexes items sent.|float|count|
|`ep_dcp_views_indexes_producer_count`|Ep dcp views indexes producer count.|float|count|
|`ep_dcp_views_indexes_total_backlog_size`|Ep dcp views indexes total backlog size.|float|B|
|`ep_dcp_views_indexes_total_bytes`|Ep dcp views indexes total bytes.|float|B|
|`ep_dcp_views_items_remaining`|Number of views items remaining to be sent.|float|count|
|`ep_dcp_views_items_sent`|Number of views items sent.|float|count|
|`ep_dcp_views_producer_count`|Number of views producers.|float|count|
|`ep_dcp_views_total_backlog_size`|Ep dcp views total backlog size.|float|B|
|`ep_dcp_views_total_bytes`|Number bytes per second being sent for views DCP connections.|float|B/S|
|`ep_dcp_xdcr_backoff`|Number of backoffs for `XDCR` DCP connections.|float|count|
|`ep_dcp_xdcr_count`|Number of internal `XDCR` DCP connections in this bucket.|float|count|
|`ep_dcp_xdcr_items_remaining`|Number of items remaining to be sent to consumer in this bucket.|float|count|
|`ep_dcp_xdcr_items_sent`|Number of items per second being sent for a producer for this bucket.|float|req/s|
|`ep_dcp_xdcr_producer_count`|Number of `XDCR` senders for this bucket.|float|count|
|`ep_dcp_xdcr_total_backlog_size`|Ep dcp `XDCR` total backlog size.|float|B|
|`ep_dcp_xdcr_total_bytes`|Number of bytes per second being sent for `XDCR` DCP connections for this bucket.|float|B/S|
|`ep_diskqueue_drain`|Total number of items per second being written to disk in this bucket.|float|req/s|
|`ep_diskqueue_fill`|Total number of items per second being put on the disk queue in this bucket.|float|req/s|
|`ep_diskqueue_items`|Total number of items waiting to be written to disk in this bucket.|float|count|
|`ep_flusher_todo`|Number of items currently being written.|float|count|
|`ep_item_commit_failed`|Number of times a transaction failed to commit due to storage errors.|float|count|
|`ep_kv_size`|Total amount of user data cached in RAM in this bucket.|float|count|
|`ep_max_size`|The maximum amount of memory this bucket can use.|float|B|
|`ep_mem_high_wat`|High water mark for auto-evictions.|float|count|
|`ep_mem_low_wat`|Low water mark for auto-evictions.|float|count|
|`ep_meta_data_memory`|Total amount of item metadata consuming RAM in this bucket.|float|B|
|`ep_num_non_resident`|Number of non-resident items.|float|count|
|`ep_num_ops_del_meta`|Number of delete operations per second for this bucket as the target for `XDCR`.|float|req/s|
|`ep_num_ops_del_ret_meta`|Number of delRetMeta operations per second for this bucket as the target for `XDCR`.|float|req/s|
|`ep_num_ops_get_meta`|Number of metadata read operations per second for this bucket as the target for `XDCR`.|float|req/s|
|`ep_num_ops_set_meta`|Number of set operations per second for this bucket as the target for `XDCR`.|float|req/s|
|`ep_num_ops_set_ret_meta`|Number of setRetMeta operations per second for this bucket as the target for `XDCR`.|float|req/s|
|`ep_num_value_ejects`|Total number of items per second being ejected to disk in this bucket.|float|req/s|
|`ep_oom_errors`|Number of times unrecoverable OOMs happened while processing operations.|float|count|
|`ep_ops_create`|Total number of new items being inserted into this bucket.|float|count|
|`ep_ops_update`|Number of items updated on disk per second for this bucket.|float|req/s|
|`ep_overhead`|Extra memory used by transient data like persistence queues or checkpoints.|float|B|
|`ep_queue_size`|Number of items queued for storage.|float|count|
|`ep_replica_ahead_exceptions`|Percentage of all items cached in RAM in this bucket.|float|percent|
|`ep_replica_hlc_drift`|The sum of the total Absolute Drift, which is the accumulated drift observed by the vBucket. Drift is always accumulated as an absolute value.|float|s|
|`ep_replica_hlc_drift_count`|Ep replica hlc drift count.|float|s|
|`ep_resident_items_rate`|Percentage of all items cached in RAM in this bucket.|float|percent|
|`ep_tmp_oom_errors`|Number of back-offs sent per second to client SDKs due to OOM situations from this bucket.|float|req/s|
|`ep_vb_total`|Total number of vBuckets for this bucket.|float|count|
|`evictions`|Number of evictions.|float|count|
|`get_hits`|Number of get hits.|float|count|
|`get_misses`|Number of get misses.|float|count|
|`hibernated_requests`|Number of streaming requests on port 8091 now idle.|float|count|
|`hibernated_waked`|Rate of streaming request wakeups on port 8091.|float|req/s|
|`hit_ratio`|Hit ratio.|float|rate|
|`incr_hits`|Number of increment hits.|float|count|
|`incr_misses`|Number of increment misses.|float|count|
|`mem_actual_free`|Amount of RAM available on this server.|float|B|
|`mem_actual_used`|Memory actual used.|float|B|
|`mem_free`|Amount of Memory free.|float|B|
|`mem_total`|Memory total.|float|B|
|`mem_used`|Amount of memory used.|float|B|
|`mem_used_sys`|Memory used sys.|float|B|
|`misses`|Number of misses.|float|count|
|`ops`|Total amount of operations per second to this bucket.|float|req/s|
|`rest_requests`|Rate of http requests on port 8091.|float|req/s|
|`swap_total`|Total amount of swap available.|float|count|
|`swap_used`|Amount of swap space in use on this server.|float|count|
|`vb_active_eject`|Number of items per second being ejected to disk from active vBuckets in this bucket.|float|req/s|
|`vb_active_itm_memory`|Amount of active user data cached in RAM in this bucket.|float|count|
|`vb_active_meta_data_memory`|Amount of active item metadata consuming RAM in this bucket.|float|count|
|`vb_active_num`|Number of vBuckets in the active state for this bucket.|float|count|
|`vb_active_num_non_resident`|Number of non resident vBuckets in the active state for this bucket.|float|count|
|`vb_active_ops_create`|New items per second being inserted into active vBuckets in this bucket.|float|req/s|
|`vb_active_ops_update`|Number of items updated on active vBucket per second for this bucket.|float|req/s|
|`vb_active_queue_age`|Sum of disk queue item age in milliseconds.|float|ms|
|`vb_active_queue_drain`|Number of active items per second being written to disk in this bucket.|float|req/s|
|`vb_active_queue_fill`|Number of active items per second being put on the active item disk queue in this bucket.|float|req/s|
|`vb_active_queue_items`|Vb active queue items.|float|count|
|`vb_active_queue_size`|Number of active items waiting to be written to disk in this bucket.|float|count|
|`vb_active_resident_items_ratio`|Percentage of active items cached in RAM in this bucket.|float|percent|
|`vb_avg_active_queue_age`|Sum of disk queue item age in milliseconds.|float|ms|
|`vb_avg_pending_queue_age`|Average age in seconds of pending items in the pending item queue for this bucket and should be transient during rebalancing.|float|s|
|`vb_avg_replica_queue_age`|Average age in seconds of replica items in the replica item queue for this bucket.|float|s|
|`vb_avg_total_queue_age`|Average age in seconds of all items in the disk write queue for this bucket.|float|s|
|`vb_pending_curr_items`|Number of items in pending vBuckets in this bucket and should be transient during rebalancing.|float|count|
|`vb_pending_eject`|Number of items per second being ejected to disk from pending vBuckets in this bucket and should be transient during rebalancing.|float|req/s|
|`vb_pending_itm_memory`|Amount of pending user data cached in RAM in this bucket and should be transient during rebalancing.|float|count|
|`vb_pending_meta_data_memory`|Amount of pending item metadata consuming RAM in this bucket and should be transient during rebalancing.|float|count|
|`vb_pending_num`|Number of vBuckets in the pending state for this bucket and should be transient during rebalancing.|float|count|
|`vb_pending_num_non_resident`|Number of non resident vBuckets in the pending state for this bucket.|float|count|
|`vb_pending_ops_create`|New items per second being instead into pending vBuckets in this bucket and should be transient during rebalancing.|float|req/s|
|`vb_pending_ops_update`|Number of items updated on pending vBucket per second for this bucket.|float|req/s|
|`vb_pending_queue_age`|Sum of disk pending queue item age in milliseconds.|float|ms|
|`vb_pending_queue_drain`|Number of pending items per second being written to disk in this bucket and should be transient during rebalancing.|float|req/s|
|`vb_pending_queue_fill`|Number of pending items per second being put on the pending item disk queue in this bucket and should be transient during rebalancing.|float|req/s|
|`vb_pending_queue_size`|Number of pending items waiting to be written to disk in this bucket and should be transient during rebalancing.|float|count|
|`vb_pending_resident_items_ratio`|Percentage of items in pending state buckets cached in RAM in this bucket.|float|percent|
|`vb_replica_curr_items`|Number of items in replica vBuckets in this bucket.|float|count|
|`vb_replica_eject`|Number of items per second being ejected to disk from replica vBuckets in this bucket.|float|req/s|
|`vb_replica_itm_memory`|Amount of replica user data cached in RAM in this bucket.|float|count|
|`vb_replica_meta_data_memory`|Amount of replica item metadata consuming in RAM in this bucket.|float|count|
|`vb_replica_num`|Number of vBuckets in the replica state for this bucket.|float|count|
|`vb_replica_num_non_resident`|Vb replica num non resident.|float|count|
|`vb_replica_ops_create`|New items per second being inserted into replica vBuckets in this bucket.|float|req/s|
|`vb_replica_ops_update`|Number of items updated on replica vBucket per second for this bucket.|float|req/s|
|`vb_replica_queue_age`|Sum of disk replica queue item age in milliseconds.|float|ms|
|`vb_replica_queue_drain`|Number of replica items per second being written to disk in this bucket.|float|req/s|
|`vb_replica_queue_fill`|Number of replica items per second being put on the replica item disk queue in this bucket.|float|req/s|
|`vb_replica_queue_size`|Number of replica items waiting to be written to disk in this bucket.|float|count|
|`vb_replica_resident_items_ratio`|Percentage of active items cached in RAM in this bucket.|float|count|
|`vb_total_queue_age`|Vb total queue age.|float|ms|
|`xdc_ops`|Total `XDCR` operations per second for this bucket.|float|req/s|



### `cbbucketstat`

- Tags


| Tag | Description |
|  ----  | --------|
|`bucket`|Bucket name.|
|`cluster`|Cluster name.|
|`host`|Host name.|
|`instance`|Instance endpoint.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`avg_active_timestamp_drift`|Average drift (in seconds) per mutation on active vBuckets.|float|s|
|`avg_bg_wait_seconds`|Average background fetch time in seconds.|float|s|
|`avg_disk_commit_time`|Average disk commit time in seconds as from disk_update histogram of timings.|float|s|
|`avg_disk_update_time`|Average disk update time in microseconds as from disk_update histogram of timings.|float|μs|
|`avg_replica_timestamp_drift`|Average drift (in seconds) per mutation on replica vBuckets.|float|s|
|`cas_badval`|Compare and Swap bad values.|float|count|
|`cas_hits`|Number of operations with a CAS id per second for this bucket.|float|req/s|
|`cas_misses`|Compare and Swap misses.|float|count|
|`cmd_get`|Number of reads (get operations) per second from this bucket.|float|req/s|
|`cmd_set`|Number of writes (set operations) per second to this bucket.|float|req/s|
|`couch_docs_actual_disk_size`|The size of all data files for this bucket, including the data itself, meta data and temporary files.|float|B|
|`couch_docs_data_size`|The size of active data in this bucket.|float|B|
|`couch_docs_disk_size`|The size of all data files for this bucket, including the data itself, meta data and temporary files.|float|B|
|`couch_docs_fragmentation`|How much fragmented data there is to be compacted compared to real data for the data files in this bucket.|float|B|
|`couch_total_disk_size`|The total size on disk of all data and view files for this bucket.|float|B|
|`couch_views_actual_disk_size`|The size of all active items in all the indexes for this bucket on disk.|float|B|
|`couch_views_data_size`|The size of active data on for all the indexes in this bucket.|float|B|
|`couch_views_fragmentation`|How much fragmented data there is to be compacted compared to real data for the view index files in this bucket.|float|B|
|`couch_views_ops`|All the view reads for all design documents including scatter gather.|float|count|
|`cpu_idle_ms`|CPU idle milliseconds.|float|ms|
|`cpu_local_ms`|CPU local ms.|float|ms|
|`cpu_utilization_rate`|Percentage of CPU in use across all available cores on this server.|float|percent|
|`curr_connections`|Number of connections to this server including connections from external client SDKs, proxies, DCP requests and internal statistic gathering.|float|count|
|`curr_items`|Number of items in active vBuckets in this bucket.|float|count|
|`curr_items_tot`|Total number of items in this bucket.|float|count|
|`decr_hits`|Decrement hits.|float|count|
|`decr_misses`|Decrement misses.|float|count|
|`delete_hits`|Number of delete operations per second for this bucket.|float|req/s|
|`delete_misses`|Delete misses.|float|count|
|`disk_commits`|Disk commits.|float|count|
|`disk_updates`|Disk updates.|float|count|
|`disk_write_queue`|Number of items waiting to be written to disk in this bucket.|float|count|
|`ep_active_ahead_exceptions`|Total number of ahead exceptions for  all active vBuckets.|float|count|
|`ep_active_hlc_drift`|Ep active hlc drift.|float|s|
|`ep_bg_fetched`|Number of reads per second from disk for this bucket.|float|req/s|
|`ep_cache_miss_rate`|Percentage of reads per second to this bucket from disk as opposed to RAM.|float|percent|
|`ep_clock_cas_drift_threshold_exceeded`|Ep clock cas drift threshold exceeded.|float|s|
|`ep_dcp_2i_backoff`|Number of backoffs for indexes DCP connections.|float|count|
|`ep_dcp_2i_connections`|Number of indexes DCP connections.|float|count|
|`ep_dcp_2i_items_remaining`|Number of indexes items remaining to be sent.|float|count|
|`ep_dcp_2i_items_sent`|Number of indexes items sent.|float|count|
|`ep_dcp_2i_producers`|Number of indexes producers.|float|count|
|`ep_dcp_2i_total_backlog_size`|Ep dcp 2i total backlog size.|float|B|
|`ep_dcp_2i_total_bytes`|Number bytes per second being sent for indexes DCP connections.|float|B/S|
|`ep_dcp_other_backoff`|Number of backoffs for other DCP connections.|float|count|
|`ep_dcp_other_items_remaining`|Number of items remaining to be sent to consumer in this bucket.|float|count|
|`ep_dcp_other_items_sent`|Number of items per second being sent for a producer for this bucket.|float|req/s|
|`ep_dcp_other_producers`|Number of other senders for this bucket.|float|count|
|`ep_dcp_other_total_backlog_size`|Ep dcp other total backlog size.|float|B|
|`ep_dcp_other_total_bytes`|Number of bytes per second being sent for other DCP connections for this bucket.|float|B/S|
|`ep_dcp_others`|Number of other DCP connections in this bucket.|float|count|
|`ep_dcp_replica_backoff`|Number of backoffs for replication DCP connections.|float|count|
|`ep_dcp_replica_items_remaining`|Number of items remaining to be sent to consumer in this bucket.|float|count|
|`ep_dcp_replica_items_sent`|Number of items per second being sent for a producer for this bucket.|float|req/s|
|`ep_dcp_replica_producers`|Number of replication senders for this bucket.|float|count|
|`ep_dcp_replica_total_backlog_size`|Ep dcp replica total backlog size.|float|B|
|`ep_dcp_replica_total_bytes`|Number of bytes per second being sent for replication DCP connections for this bucket.|float|B/S|
|`ep_dcp_replicas`|Number of internal replication DCP connections in this bucket.|float|count|
|`ep_dcp_views_backoffs`|Number of backoffs for views DCP connections.|float|count|
|`ep_dcp_views_connections`|Number of views DCP connections.|float|count|
|`ep_dcp_views_items_remaining`|Number of views items remaining to be sent.|float|count|
|`ep_dcp_views_items_sent`|Number of views items sent.|float|count|
|`ep_dcp_views_producers`|Number of views producers.|float|count|
|`ep_dcp_views_total_backlog_size`|Ep dcp views total backlog size.|float|B|
|`ep_dcp_views_total_bytes`|Number bytes per second being sent for views DCP connections.|float|B/S|
|`ep_dcp_xdcr_backoff`|Number of backoffs for `XDCR` DCP connections.|float|count|
|`ep_dcp_xdcr_connections`|Number of internal `XDCR` DCP connections in this bucket.|float|count|
|`ep_dcp_xdcr_items_remaining`|Number of items remaining to be sent to consumer in this bucket.|float|count|
|`ep_dcp_xdcr_items_sent`|Number of items per second being sent for a producer for this bucket.|float|req/s|
|`ep_dcp_xdcr_producers`|Number of `XDCR` senders for this bucket.|float|count|
|`ep_dcp_xdcr_total_backlog_size`|Ep dcp `XDCR` total backlog size.|float|B|
|`ep_dcp_xdcr_total_bytes`|Number of bytes per second being sent for `XDCR` DCP connections for this bucket.|float|B/S|
|`ep_diskqueue_drain`|Total number of items per second being written to disk in this bucket.|float|req/s|
|`ep_diskqueue_fill`|Total number of items per second being put on the disk queue in this bucket.|float|req/s|
|`ep_diskqueue_items`|Total number of items waiting to be written to disk in this bucket.|float|count|
|`ep_flusher_todo`|Number of items currently being written.|float|count|
|`ep_item_commit_failed`|Number of times a transaction failed to commit due to storage errors.|float|count|
|`ep_kv_size`|Total amount of user data cached in RAM in this bucket.|float|count|
|`ep_max_size_bytes`|The maximum amount of memory this bucket can use.|float|B|
|`ep_mem_high_wat_bytes`|High water mark for auto-evictions.|float|B|
|`ep_mem_low_wat_bytes`|Low water mark for auto-evictions.|float|B|
|`ep_meta_data_memory`|Total amount of item metadata consuming RAM in this bucket.|float|B|
|`ep_num_non_resident`|Number of non-resident items.|float|count|
|`ep_num_ops_del_meta`|Number of delete operations per second for this bucket as the target for `XDCR`.|float|req/s|
|`ep_num_ops_del_ret_meta`|Number of delRetMeta operations per second for this bucket as the target for `XDCR`.|float|req/s|
|`ep_num_ops_get_meta`|Number of metadata read operations per second for this bucket as the target for `XDCR`.|float|req/s|
|`ep_num_ops_set_meta`|Number of set operations per second for this bucket as the target for `XDCR`.|float|req/s|
|`ep_num_ops_set_ret_meta`|Number of setRetMeta operations per second for this bucket as the target for `XDCR`.|float|req/s|
|`ep_num_value_ejects`|Total number of items per second being ejected to disk in this bucket.|float|req/s|
|`ep_oom_errors`|Number of times unrecoverable OOMs happened while processing operations.|float|count|
|`ep_ops_create`|Total number of new items being inserted into this bucket.|float|count|
|`ep_ops_update`|Number of items updated on disk per second for this bucket.|float|req/s|
|`ep_overhead`|Extra memory used by transient data like persistence queues or checkpoints.|float|B|
|`ep_queue_size`|Number of items queued for storage.|float|count|
|`ep_replica_ahead_exceptions`|Total number of ahead exceptions (when timestamp drift between mutations and local time has exceeded 5000000 μs) per second for all replica vBuckets.|float|req/s|
|`ep_replica_hlc_drift`|The sum of the total Absolute Drift, which is the accumulated drift observed by the vBucket. Drift is always accumulated as an absolute value.|float|s|
|`ep_resident_items_rate`|Percentage of all items cached in RAM in this bucket.|float|count|
|`ep_tmp_oom_errors`|Number of back-offs sent per second to client SDKs due to OOM situations from this bucket.|float|req/s|
|`ep_vbuckets`|Total number of vBuckets for this bucket.|float|count|
|`evictions`|Number of evictions.|float|count|
|`get_hits`|Number of get hits.|float|count|
|`get_misses`|Number of get misses.|float|count|
|`hibernated_requests`|Number of streaming requests on port 8091 now idle.|float|count|
|`hibernated_waked`|Rate of streaming request wakeups on port 8091.|float|percent|
|`hit_ratio`|Hit ratio.|float|percent|
|`incr_hits`|Number of increment hits.|float|count|
|`incr_misses`|Number of increment misses.|float|count|
|`mem_actual_free`|Amount of RAM available on this server.|float|B|
|`mem_actual_used_bytes`|Memory actually used in bytes.|float|B|
|`mem_bytes`|Total amount of memory available.|float|B|
|`mem_free_bytes`|Amount of Memory free.|float|B|
|`mem_used_bytes`|Amount of memory used.|float|B|
|`mem_used_sys_bytes`|System memory in use.|float|B|
|`misses`|Number of misses.|float|count|
|`ops`|Total amount of operations per second to this bucket.|float|req/s|
|`read_bytes`|Bytes read.|float|B|
|`rest_requests`|Rate of http requests on port 8091.|float|B/S|
|`swap_bytes`|Total amount of swap available.|float|B|
|`swap_used`|Amount of swap space in use on this server.|float|B|
|`vbuckets_active_eject`|Number of items per second being ejected to disk from active vBuckets in this bucket.|float|req/s|
|`vbuckets_active_itm_memory`|Amount of active user data cached in RAM in this bucket.|float|count|
|`vbuckets_active_meta_data_memory`|Amount of active item metadata consuming RAM in this bucket.|float|B|
|`vbuckets_active_num`|Number of vBuckets in the active state for this bucket.|float|count|
|`vbuckets_active_num_non_resident`|Number of non resident vBuckets in the active state for this bucket.|float|count|
|`vbuckets_active_ops_create`|New items per second being inserted into active vBuckets in this bucket.|float|req/s|
|`vbuckets_active_ops_update`|Number of items updated on active vBucket per second for this bucket.|float|req/s|
|`vbuckets_active_queue_age`|Sum of disk queue item age in milliseconds.|float|ms|
|`vbuckets_active_queue_drain`|Number of active items per second being written to disk in this bucket.|float|req/s|
|`vbuckets_active_queue_fill`|Number of active items per second being put on the active item disk queue in this bucket.|float|req/s|
|`vbuckets_active_queue_size`|Number of active items waiting to be written to disk in this bucket.|float|count|
|`vbuckets_active_resident_items_ratio`|Percentage of active items cached in RAM in this bucket.|float|percent|
|`vbuckets_avg_active_queue_age`|Average age in seconds of active items in the active item queue for this bucket.|float|s|
|`vbuckets_avg_pending_queue_age`|Average age in seconds of pending items in the pending item queue for this bucket and should be transient during rebalancing.|float|s|
|`vbuckets_avg_replica_queue_age`|Average age in seconds of replica items in the replica item queue for this bucket.|float|s|
|`vbuckets_avg_total_queue_age`|Average age in seconds of all items in the disk write queue for this bucket.|float|s|
|`vbuckets_pending_curr_items`|Number of items in pending vBuckets in this bucket and should be transient during rebalancing.|float|count|
|`vbuckets_pending_eject`|Number of items per second being ejected to disk from pending vBuckets in this bucket and should be transient during rebalancing.|float|req/s|
|`vbuckets_pending_itm_memory`|Amount of pending user data cached in RAM in this bucket and should be transient during rebalancing.|float|count|
|`vbuckets_pending_meta_data_memory`|Amount of pending item metadata consuming RAM in this bucket and should be transient during rebalancing.|float|count|
|`vbuckets_pending_num`|Number of vBuckets in the pending state for this bucket and should be transient during rebalancing.|float|count|
|`vbuckets_pending_num_non_resident`|Number of non resident vBuckets in the pending state for this bucket.|float|count|
|`vbuckets_pending_ops_create`|New items per second being instead into pending vBuckets in this bucket and should be transient during rebalancing.|float|req/s|
|`vbuckets_pending_ops_update`|Number of items updated on pending vBucket per second for this bucket.|float|req/s|
|`vbuckets_pending_queue_age`|Sum of disk pending queue item age in milliseconds.|float|ms|
|`vbuckets_pending_queue_drain`|Number of pending items per second being written to disk in this bucket and should be transient during rebalancing.|float|req/s|
|`vbuckets_pending_queue_fill`|Number of pending items per second being put on the pending item disk queue in this bucket and should be transient during rebalancing.|float|req/s|
|`vbuckets_pending_queue_size`|Number of pending items waiting to be written to disk in this bucket and should be transient during rebalancing.|float|count|
|`vbuckets_pending_resident_items_ratio`|Percentage of items in pending state vb cached in RAM in this bucket.|float|percent|
|`vbuckets_replica_curr_items`|Number of items in replica vBuckets in this bucket.|float|count|
|`vbuckets_replica_eject`|Number of items per second being ejected to disk from replica vBuckets in this bucket.|float|req/s|
|`vbuckets_replica_itm_memory`|Amount of replica user data cached in RAM in this bucket.|float|count|
|`vbuckets_replica_meta_data_memory`|Amount of replica item metadata consuming in RAM in this bucket.|float|B|
|`vbuckets_replica_num`|Number of vBuckets in the replica state for this bucket.|float|count|
|`vbuckets_replica_num_non_resident`|vb replica num non resident.|float|count|
|`vbuckets_replica_ops_create`|New items per second being inserted into replica vBuckets in this bucket.|float|req/s|
|`vbuckets_replica_ops_update`|Number of items updated on replica vBucket per second for this bucket.|float|req/s|
|`vbuckets_replica_queue_age`|Sum of disk replica queue item age in milliseconds.|float|ms|
|`vbuckets_replica_queue_drain`|Number of replica items per second being written to disk in this bucket.|float|req/s|
|`vbuckets_replica_queue_fill`|Number of replica items per second being put on the replica item disk queue in this bucket.|float|req/s|
|`vbuckets_replica_queue_size`|Number of replica items waiting to be written to disk in this bucket.|float|count|
|`vbuckets_replica_resident_items_ratio`|Percentage of replica items cached in RAM in this bucket.|float|percent|
|`vbuckets_total_queue_age`|Sum of disk queue item age in milliseconds.|float|ms|
|`written_bytes`|Bytes written.|float|B|
|`xdc_ops`|Total `XDCR` operations per second for this bucket.|float|req/s|