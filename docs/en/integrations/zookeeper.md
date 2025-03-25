---
title     : 'ZooKeeper'
summary   : 'Collect ZooKeeper related Metrics information'
__int_icon: 'icon/zookeeper'
dashboard :
  - desc  : 'ZooKeeper monitoring view'
    path  : 'dashboard/en/zookeeper'
monitor   :
  - desc  : 'ZooKeeper detection library'
    path  : 'monitor/en/zookeeper'
---

<!-- markdownlint-disable MD025 -->
# ZooKeeper
<!-- markdownlint-enable -->
---

## Installation and Deployment {#config}

Note: The example ZooKeeper version is 3.6.3 (CentOS). Versions 3.6+ will have more metrics than previous versions. If you are using a version prior to 3.6, some metrics may not be collected.


### Enable Zookeeper Metrics

- Enable the Metrics Providers configuration in Zookeeper (default configuration file location: Zookeeper installation directory `/conf/zoo.cfg`) and add `4lw.commands.whitelist=*`

```shell
> ## Metrics Providers
> #
> # [https://prometheus.io](https://prometheus.io) Metrics Exporter
> metricsProvider.className=org.apache.zookeeper.metrics.prometheus.PrometheusMetricsProvider
> metricsProvider.httpPort=7000
> metricsProvider.exportJvmInfo=true
> 4lw.commands.whitelist=*
```

- Restart the ZooKeeper cluster to apply the configuration.
- Download and install [zookeeper_exporter](https://github.com/carlpett/zookeeper_exporter/releases/download/v1.1.0/zookeeper_exporter) in the ZooKeeper cluster, assign execution permissions with chmod +x, and start it. The default port is 9141, and you can verify the data through the command.

```bash
[root@d ~]# curl 0.0.0.0:9141/metrics
zk_sync_process_time{quantile="0_5",zk_host="172.16.0.196:2181"} NaN
zk_proposal_latency_sum{zk_host="172.16.0.196:2181"} 0.0
zk_read_final_proc_time_ms{quantile="0_5",zk_host="172.16.0.196:2181"} NaN
zk_process_start_time_seconds{zk_host="172.16.0.23:2181"} 1.645516624379E9
zk_jvm_buffer_pool_capacity_bytes{pool="direct",zk_host="172.16.0.194:2181"} 287560.0
zk_time_waiting_empty_pool_in_commit_processor_read_ms_sum{zk_host="172.16.0.194:2181"} 0.0
zk_stale_requests_dropped{zk_host="172.16.0.23:2181"} 0.0
zk_open_file_descriptor_count{zk_host="172.16.0.196:2181"} 83.0
zk_commit_commit_proc_req_queued_sum{zk_host="172.16.0.194:2181"} 0.0
zk_write_final_proc_time_ms_count{zk_host="172.16.0.194:2181"} 0.0
zk_election_time{quantile="0_5",zk_host="172.16.0.23:2181"} NaN
zk_connection_token_deficit_count{zk_host="172.16.0.23:2181"} 2.0
......
```

### Enable DataKit Collector

- Enable the DataKit Prom plugin and copy the sample file

```bash
/usr/local/datakit/conf.d/prom
cp prom.conf.sample prom.conf
```

- Modify the `prom.conf` configuration file

<!-- markdownlint-disable MD046 -->

??? quote "Configuration as follows"

    ```toml
    [[inputs.prom]]
    ## Exporter URLs
    urls = ["[http://127.0.0.1:9141/metrics"]](http://127.0.0.1:9141/metrics"])

    ## Ignore request errors for URL
    ignore_req_err = false

    ## Collector alias
    source = "zookeeper"

    ## Output source for collected data
    # Configuring this will write the collected data to a local file instead of sending it to the center
    # You can then directly use the datakit --prom-conf /path/to/this/conf command to debug the locally saved Measurement
    # If the URL has been configured as a local file path, then --prom-conf will prioritize debugging the output path data
    # output = "/abs/path/to/file"
    > 
    ## Upper limit for collected data size, in bytes
    # When outputting data to a local file, you can set an upper limit for the collected data size
    # If the size of the collected data exceeds this limit, the data will be discarded
    # The default upper limit for collected data size is set to 32MB
    # max_file_size = 0

    ## Metric type filtering, optional values are counter, gauge, histogram, summary
    # By default, only counter and gauge types of metrics are collected
    # If left empty, no filtering will occur
    metric_types = ["counter", "gauge"]

    ## Metric name filtering
    # Supports regular expressions, multiple configurations can be made, i.e., satisfying any one of them will suffice
    # If left empty, no filtering will occur
    # metric_name_filter = ["cpu"]

    ## Prefix for Measurement names
    # Configuring this will add a prefix to the Measurement names
    measurement_prefix = ""

    ## Measurement name
    # By default, the metric name will be split by underscores "_", with the first field after the split becoming the Measurement name and the remaining fields becoming the current metric name
    # If measurement_name is configured, the metric name will not be split
    # The final Measurement name will have the measurement_prefix prefix added
    # measurement_name = "prom"

    ## Collection interval "ns", "us" (or "µs"), "ms", "s", "m", "h"
    interval = "10s"

    ## Filter tags, multiple tags can be configured
    # Matching tags will be ignored
    # tags_ignore = ["xxxx"]

    ## TLS configuration
    tls_open = false
    # tls_ca = "/tmp/ca.crt"
    # tls_cert = "/tmp/peer.crt"
    # tls_key = "/tmp/peer.key"

    ## Custom authentication method, currently only supports Bearer Token
    # token and token_file: only one needs to be configured
    # [inputs.prom.auth]
    # type = "bearer_token"
    # token = "xxxxxxxx"
    # token_file = "/tmp/token"

    ## Custom Measurement names
    # Metrics containing the prefix prefix can be grouped into one Measurement
    # Custom Measurement name configuration takes precedence over measurement_name configuration
    #[[inputs.prom.measurements]]
    #  prefix = "cpu_"
    #  name = "cpu"

    # [[inputs.prom.measurements]]
    # prefix = "mem_"
    # name = "mem"

    ## Custom Tags
    [inputs.prom.tags]
      service = "zookeeper"
    # more_tag = "some_other_value"
    ```
<!-- markdownlint-enable -->
- Restart DataKit (if log enabling is required, configure log collection before restarting)

```bash
systemctl restart datakit
```

- DQL Verification

```bash
[root@df-solution-ecs-018 prom]# datakit -Q

Flag -Q deprecated, please use datakit help to use recommend flags.

dqlcmd: &cmds.dqlCmd{json:false, autoJSON:false, verbose:false, csv:"", forceWriteCSV:false, dqlString:"", token:"tkn_9a49a7e9343c432eb0b99a297401c3bb", host:"0.0.0.0:9529", log:"", dqlcli:(*http.Client)(0xc0009a5800)}
dql > M::zookeeper LIMIT 1
-----------------[ r1.zookeeper.s1 ]-----------------
                            add_dead_watcher_stall_time 0
                                  approximate_data_size 44
                                      auth_failed_count 0
                            avg_close_session_prep_time '1.0'
                      avg_commit_commit_proc_req_queued '0.0'
                                avg_commit_process_time '0.0'
                                .....
                          sync_processor_request_queued 2
                                          throttled_ops 0
                                                   time 2022-02-22 16:00:10 +0800 CST
                                 tls_handshake_exceeded 0
                              unrecoverable_error_count 0
                                 unsuccessful_handshake 0
                                                 uptime 2858680025
                                                version '3.7.0-e3704b390a6697bfdf4b0bef79e3da7a4f6bac4b'
                                              version_1 <nil>
                                            watch_bytes 0
                                            watch_count 0
                                            znode_count 5
---------
1 rows, 1 series, cost 40.297037ms
```

## Metric {#metric}
| **Metic** | **Description** | **Data type** |**Availability**|
| --- | --- | --- | --- |
|**zookeeper_approximate_data_size** |required for the server to respond to client requests (ms) | Measurement |  |
|**zookeeper_avg_latency** | Number of bytes received | Measurement | |
|**zookeeper_bytes_received** | Number of bytes sent | Measurement | |
|**zookeeper_connections** | Total number of client connections (connections) | Measurement | |
|**zookeeper_ephemerals_count** | | Measurement | |
|**zookeeper_instances** | | Measurement | |
|**zookeeper_latency_avg** | Time required for the server to respond to client requests (ms) | Measurement | |
|**zookeeper_latency_max** | Time required for the server to respond to client requests (ms) | Measurement | |
|**zookeeper_latency_min** | Time required for the server to respond to client requests (ms) | Measurement | |
|**zookeeper_max_file_descriptor_count** | | Measurement | |
|**zookeeper_max_latency** | Time required for the server to respond to client requests (ms) | Measurement | |
|**zookeeper_min_latency** | Time required for the server to respond to client requests (ms) | Measurement | |
|**zookeeper_nodes** | Number of 'znode' nodes in ZooKeeper namespace (data) | Measurement | |
|**zookeeper_num_alive_connections**| Total number of client connections (connections) | Measurement | |
|**zookeeper_open_file_descriptor_count** | | Measurement | |
|**zookeeper_outstanding_requests**| Number of requests queued when the server is under load and receives more requests than it can handle (number of requests) | Metrics | |
|**zookeeper_packets_received**| Number of received packets | Measurement | |
|**zookeeper_packets_sent** | Number of data packets sent | Measurement | |
|**zookeeper_server_state** | | Measurement | |
|**zookeeper_watch_count** |  | Measurement |  |
|**zookeeper_znode_count** |Number of `znode` in ZooKeeper namespace (data)| Measurement |  |
|**zookeeper_zxid.count**|  | Measurement |  |
|**zookeeper_zxid.epoch**|  | Measurement |  |
|**zookeeper_add_dead_watcher_stall_time** | | Measurement | Suitable for Zookeeper 3.6+|
|**zookeeper_bytes_received_count**| Number of bytes received | Measurement | Applicable to Zookeeper 3.6+|
|**zookeeper_close_session_prep_time** | Histogram of close_session_prep_time   | Metrics | Suitable for Zookeeper 3.6+|
|**zookeeper_close_session_prep_time_count** | Total count of close_session_prep_time | metric | applicable to Zookeeper 3.6+|
|**zookeeper_close_session_prep_time_sum** | Sum of close_session_prep_time  | metric | applicable to Zookeeper 3.6+|
|**zookeeper_commit_commit_proc_req_queued** | Histogram  of commit_commit_proc_req_queued | Metrics | Suitable for Zookeeper 3.6+|
|**zookeeper_commit_commit_proc_req_queued_count** | Total count  of commit_commit_proc_req_queued | Metrics | Applicable to Zookeeper 3.6+|
|**zookeeper_commit_commit_proc_req_queued_sum** | Sum  of commit_commit_proc_req_queued | metric | applies to Zookeeper 3.6+|
|**zookeeper_commit_count** | Number of submissions executed on the leader | Measurement | Applicable to Zookeeper 3.6+|
|**zookeeper_commit_process_time** | Histogram of commit_process_time | Metrics | Suitable for Zookeeper 3.6+|
|**zookeeper_commit_process_time_count**| Total count of commit_process_time  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_commit_process_time_sum**|  Sum of commit_process_time | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_commit_propagation_latency**| Histogram  of commit_propagation_latency | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_commit_propagation_latency_count**| Total count of commit_propagation_latency   | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_commit_propagation_latency_sum**| Sum  of commit_propagation_latency  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_concurrent_request_processing_in_commit_processor**| concurrent_request_processing_in_commit_processor  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_concurrent_request_processing_in_commit_processor_count**| concurrent_request_processing_in_commit_processor  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_concurrent_request_processing_in_commit_processor_sum**| concurrent_request_processing_in_commit_processor  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_connection_drop_count**|  Connection disconnection count | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_connection_drop_probability**| Connection drop probability | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_connection_rejected**| connection rejected count | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_connection_request_count**| Number of incoming client connection requests | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_connection_revalidate_count**| Connection revalidation count | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_connection_token_deficit**| Histogram of connection_token_deficit  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_connection_token_deficit_count**| Total count of connection_token_deficit  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_connection_token_deficit_sum**| Sum of connection_token_deficit  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_dbinittime**| Histogram of Time to reload database | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_dbinittime_count**| Total count of  Time to reload database | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_dbinittime_sum**| Sum of Time to reload database | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_dead_watchers_cleaner_latency**| Histogram of dead_watchers_cleaner_latency  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_dead_watchers_cleaner_latency_count**| Total count of dead_watchers_cleaner_latency  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_dead_watchers_cleaner_latency_sum**| Sum of dead_watchers_cleaner_latency  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_dead_watchers_cleared**|   | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_dead_watchers_queued**|   | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_diff_count**| Number of differential synchronizations performed | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_digest_mismatches_count**|   | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_election_time**| Histogram of Time between entering and leaving the election | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_election_time_count**| Total count of Time between entering and leaving the election | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_election_time_sum**|  Sum of Time between entering and leaving the election | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_ensemble_auth_fail**|  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_ensemble_auth_skip**|   | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_ensemble_auth_success**|    | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_follower_sync_time**| Histogram of The synchronization time between follower and leader | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_follower_sync_time_count**| Total count of  The synchronization time between follower and leader | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_follower_sync_time_sum**| Sum of The synchronization time between follower and leader | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_fsynctime**| Histogram of Time of fsync transaction log | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_fsynctime_count**| Total count of Time of fsync transaction log | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_fsynctime_sum**|  Sum of Time of fsync transaction log | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_global_sessions**| Global Session Count | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_buffer_pool_capacity_bytes**|  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_buffer_pool_used_buffers**|  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_buffer_pool_used_bytes**|  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_classes_loaded**|  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_classes_loaded_total**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_classes_unloaded_total**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_gc_collection_seconds_count**|  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_gc_collection_seconds_sum**|  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_info**|  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_memory_bytes_committed**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_memory_bytes_init**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_memory_bytes_max**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_memory_bytes_used**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_memory_pool_allocated_bytes_total**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_memory_pool_bytes_committed**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_memory_pool_bytes_init**| （byte） | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_memory_pool_bytes_max**| （byte） | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_memory_pool_bytes_used**| （byte） | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_threads_current**|  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_threads_daemon**|  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_threads_deadlocked**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_threads_deadlocked_monitor**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_threads_peak**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_threads_started_total**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_jvm_threads_state**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_large_requests_rejected**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_last_client_response_size**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_learner_commit_received_count**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_learner_proposal_received_count**|  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_local_sessions**| Local Session Count | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_local_write_committed_time_ms**| Histogram of local_write_committed_time_ms | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_local_write_committed_time_ms_count**| Total count of local_write_committed_time_ms | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_local_write_committed_time_ms_sum**| Sum of local_write_committed_time_ms | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_looking_count**| Number of transitions to viewing status | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_max_client_response_size**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_min_client_response_size**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_netty_queued_buffer_capacity**| Histogram of netty_queued_buffer_capacity | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_netty_queued_buffer_capacity_count**| Total count of netty_queued_buffer_capacity | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_netty_queued_buffer_capacity_sum**| Sum of netty_queued_buffer_capacity | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_node_changed_watch_count**| Histogram of node_changed_watch_count  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_node_changed_watch_count_count**| Total count of node_changed_watch_count  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_node_changed_watch_count_sum**| Sum of node_changed_watch_count  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_node_children_watch_count**| Histogram of node_children_watch_count  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_node_children_watch_count_count**| Total count of node_children_watch_count  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_node_children_watch_count_sum**| Sum of node_children_watch_count  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_node_created_watch_count**| Histogram of node_created_watch_count  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_node_created_watch_count_count**| Total count of node_created_watch_count  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_node_created_watch_count_sum**| Sum of node_created_watch_count  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_node_deleted_watch_count**| Histogram of node_deleted_watch_count  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_node_deleted_watch_count_count**| Total count of  node_deleted_watch_count  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_node_deleted_watch_count_sum**|  Sum of node_deleted_watch_count  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_om_commit_process_time_ms**| Histogram of om_commit_process_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_om_commit_process_time_ms_count**| Total count of om_commit_process_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_om_commit_process_time_ms_sum**| Sum of om_commit_process_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_om_proposal_process_time_ms**| Histogram of om_proposal_process_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_om_proposal_process_time_ms_count**| Total count of om_proposal_process_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_om_proposal_process_time_ms_sum**| Sum of om_proposal_process_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_outstanding_changes_queued**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_outstanding_changes_removed**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_outstanding_tls_handshake**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_pending_session_queue_size**| Histogram of pending_session_queue_size  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_pending_session_queue_size_count**| Total count of pending_session_queue_size  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_pending_session_queue_size_sum**| Sum of pending_session_queue_size  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_prep_process_time**| Histogram of prep_process_time  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_prep_process_time_count**| Total count of prep_process_time  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_prep_process_time_sum**| Sum of prep_process_time  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_prep_processor_queue_size**| Histogram of prep_processor_queue_size  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_prep_processor_queue_size_count**| Total count of prep_processor_queue_size  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_prep_processor_queue_size_sum**| Sum of prep_processor_queue_size  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_prep_processor_queue_time_ms**|  Histogram of prep_processor_queue_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_prep_processor_queue_time_ms_count**| Total count of prep_processor_queue_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_prep_processor_queue_time_ms_sum**| Sum of prep_processor_queue_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_prep_processor_request_queued**|   | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_process_cpu_seconds_total**|    | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_process_max_fds**|  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_process_open_fds**|  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_process_resident_memory_bytes**| (byte) | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_process_start_time_seconds**|  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_process_virtual_memory_bytes**| (byte) | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_propagation_latency**| Histogram of propagation delay from leader to host | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_propagation_latency_count**| Total count of propagation delay from leader to host | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_propagation_latency_sum**| Sum of propagation delay from leader to host | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_proposal_ack_creation_latency**| Histogram of proposal_ack_creation_latency  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_proposal_ack_creation_latency_count**| Total count of proposal_ack_creation_latency  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_proposal_ack_creation_latency_sum**| Sum of proposal_ack_creation_latency  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_proposal_count**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_proposal_latency**|  Histogram of proposal_latency  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_proposal_latency_count**| Total count of proposal_latency  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_proposal_latency_sum**|  Sum of proposal_latency  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_quit_leading_due_to_disloyal_voter**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_quorum_ack_latency**|  Histogram of quorum_ack_latency  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_quorum_ack_latency_count**|  Total count of quorum_ack_latency  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_quorum_ack_latency_sum**|  Sum of quorum_ack_latency  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_read_commit_proc_issued**|  Histogram of read_commit_proc_issued  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_read_commit_proc_issued_count**|  Total count of read_commit_proc_issued  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_read_commit_proc_issued_sum**|  Sum of read_commit_proc_issued  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_read_commit_proc_req_queued**| Histogram of read_commit_proc_req_queued  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_read_commit_proc_req_queued_count**| Total count of read_commit_proc_req_queued  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_read_commit_proc_req_queued_sum**| Sum of read_commit_proc_req_queued  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_read_commitproc_time_ms**| Histogram of read_commitproc_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_read_commitproc_time_ms_count**| Total count of read_commitproc_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_read_commitproc_time_ms_sum**| Sum of read_commitproc_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_read_final_proc_time_ms**|  Histogram of read_final_proc_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_read_final_proc_time_ms_count**| Total count of read_final_proc_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_read_final_proc_time_ms_sum**| Sum of  read_final_proc_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_readlatency**|  Histogram of `readlatency`  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_readlatency_count**|   Total count of `readlatency`  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_readlatency_sum**|  Sum of `readlatency` | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_reads_after_write_in_session_queue**| Histogram of reads_after_write_in_session_queue  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_reads_after_write_in_session_queue_count**| Total count of reads_after_write_in_session_queue  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_reads_after_write_in_session_queue_sum**| Sum of reads_after_write_in_session_queue  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_reads_issued_from_session_queue**| Histogram of reads_issued_from_session_queue  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_reads_issued_from_session_queue_count**| Total count of  reads_issued_from_session_queue  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_reads_issued_from_session_queue_sum**| Sum of  reads_issued_from_session_queue  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_request_commit_queued**|  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_request_throttle_wait_count**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_requests_in_session_queue**| Histogram of requests_in_session_queue  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_requests_in_session_queue_count**| Total count of requests_in_session_queue  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_requests_in_session_queue_sum**| Sum of requests_in_session_queue  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_response_packet_cache_hits**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_response_packet_cache_misses**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_response_packet_get_children_cache_hits**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_response_packet_get_children_cache_misses**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_revalidate_count**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_server_write_committed_time_ms**| Histogram of server_write_committed_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_server_write_committed_time_ms_count**|  Total count of server_write_committed_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**ookeeper_server_write_committed_time_ms_sum**| Sum of server_write_committed_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_session_queues_drained**|  Histogram of session_queues_drained  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_session_queues_drained_count**| Total count of session_queues_drained  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_session_queues_drained_sum**| Sum of session_queues_drained  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_sessionless_connections_expired**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_snap_count**|  Histogram of Number of snapshot synchronizations performed | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_snapshottime**|  Total snapshot time Time written to the snapshot  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_snapshottime_count**| Total count of  snapshot time Time written to the snapshot | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_snapshottime_sum**|  Sum of snapshot time Time written to the snapshot | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_stale_replies**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_stale_requests**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_stale_requests_dropped**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_stale_sessions_expired**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_startup_snap_load_time**| Histogram of startup_snap_load_time  |  |  |
|**zookeeper_startup_snap_load_time_count**|  Total count of startup_snap_load_time  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_startup_snap_load_time_sum**|  Sum of startup_snap_load_time | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_startup_txns_load_time**| Histogram of startup_txns_load_time  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_startup_txns_load_time_count**| Total count of startup_txns_load_time  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_startup_txns_load_time_sum**|  Sum of startup_txns_load_time | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_startup_txns_loaded**| Histogram of startup_txns_loaded  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_startup_txns_loaded_count**| Total count of startup_txns_loaded  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_startup_txns_loaded_sum**|  Sum of startup_txns_loaded  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_sync_process_time**|  Histogram of sync_process_time  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_sync_process_time_count**| Total count of sync_process_time  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_sync_process_time_sum**|  Sum of sync_process_time  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_sync_processor_batch_size**| Histogram of sync_processor_batch_size  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_sync_processor_batch_size_count**| Total count of sync_processor_batch_size  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_sync_processor_batch_size_sum**| Sum of sync_processor_batch_size  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_sync_processor_queue_and_flush_time_ms**| Histogram of sync_processor_queue_and_flush_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_sync_processor_queue_and_flush_time_ms_count**| Total count of sync_processor_queue_and_flush_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_sync_processor_queue_and_flush_time_ms_sum**| Sum of  sync_processor_queue_and_flush_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_sync_processor_queue_flush_time_ms**| Histogram of sync_processor_queue_flush_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_sync_processor_queue_flush_time_ms_count**| Total count of sync_processor_queue_flush_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_sync_processor_queue_flush_time_ms_sum**| Sum of sync_processor_queue_flush_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_sync_processor_queue_size**| Histogram of sync_processor_queue_size  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_sync_processor_queue_size_count**| Total count of sync_processor_queue_size  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_sync_processor_queue_size_sum**| Sum of sync_processor_queue_size  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_sync_processor_queue_time_ms**| Histogram of sync_processor_queue_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_sync_processor_queue_time_ms_count**| Total count of sync_processor_queue_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_sync_processor_queue_time_ms_sum**| Sum of sync_processor_queue_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_sync_processor_request_queued**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_time_waiting_empty_pool_in_commit_processor_read_ms**| Histogram | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_time_waiting_empty_pool_in_commit_processor_read_ms_count**| Total count of Total count | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_time_waiting_empty_pool_in_commit_processor_read_ms_sum**| Sum | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_tls_handshake_exceeded**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_unrecoverable_error_count**| | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_updatelatency**|  Histogram of `updatelatency` | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_updatelatency_count**| Total count of `updatelatency`  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_updatelatency_sum**|  Sum of `updatelatency`  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_uptime** |Normal running time for peers in table lead/follow/observation state| Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_write_batch_time_in_commit_processor**| Histogram of write_batch_time_in_commit_processor  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_write_batch_time_in_commit_processor_count**| Total count of write_batch_time_in_commit_processor  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_write_batch_time_in_commit_processor_sum**| Sum of write_batch_time_in_commit_processor  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_write_commit_proc_issued**| Histogram of write_commit_proc_issued  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_write_commit_proc_issued_count**| Total count of write_commit_proc_issued  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_write_commit_proc_issued_sum**| Sum of write_commit_proc_issued  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_write_commit_proc_req_queued**| Histogram of write_commit_proc_req_queued  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_write_commit_proc_req_queued_count**| Total count of write_commit_proc_req_queued  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_write_commit_proc_req_queued_sum**| Sum of write_commit_proc_req_queued  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_write_commitproc_time_ms**| Histogram of write_commitproc_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_write_commitproc_time_ms_count**| Total count of write_commitproc_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_write_commitproc_time_ms_sum**| Sum of write_commitproc_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_write_final_proc_time_ms**| Histogram of write_final_proc_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_write_final_proc_time_ms_count**| Total count of write_final_proc_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
|**zookeeper_write_final_proc_time_ms_sum**|  Sum of write_final_proc_time_ms  | Metrics | Suitable for Zookeeper 3.6+  |
