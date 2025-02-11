---
title     : 'ZooKeeper'
summary   : 'Collect ZooKeeper related Metrics information'
__int_icon: 'icon/zookeeper'
dashboard :
  - desc  : 'Zookeeper monitoring view'
    path  : 'dashboard/zh/zookeeper'
monitor   :
  - desc  : 'Zookeeper detection library'
    path  : 'monitor/zh/zookeeper'
---

<!-- markdownlint-disable MD025 -->
# ZooKeeper
<!-- markdownlint-enable -->
---

## Installation and Deployment {#config}

Note: The example ZooKeeper version is 3.6.3 (CentOS). Versions 3.6+ have many more metrics than previous versions. If you are using a version prior to 3.6, some metrics may not be collected.

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
- Download and install [zookeeper_exporter](https://github.com/carlpett/zookeeper_exporter/releases/download/v1.1.0/zookeeper_exporter), assign execution permissions with `chmod +x`, and start it. The default port is 9141, and you can verify the data using the command:

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

    ## Ignore request errors for URLs
    ignore_req_err = false

    ## Collector alias
    source = "zookeeper"

    ## Output source for collected data
    # Configure this to write collected data to a local file instead of sending it to the center
    # You can then use the `datakit --prom-conf /path/to/this/conf` command to debug locally saved Mearsurement
    # If the URL is configured as a local file path, the `--prom-conf` option takes precedence when debugging output path data
    # output = "/abs/path/to/file"
    > 
    ## Maximum size of collected data, in bytes
    # Set a maximum size limit for collected data when writing it to a local file
    # If the size of the collected data exceeds this limit, the data will be discarded
    # The default maximum size limit is set to 32MB
    # max_file_size = 0

    ## Metric type filter, options are counter, gauge, histogram, summary
    # By default, only counter and gauge types of metrics are collected
    # If empty, no filtering is performed
    metric_types = ["counter", "gauge"]

    ## Metric name filter
    # Supports regular expressions; multiple configurations can be set, where satisfying any one condition suffices
    # If empty, no filtering is performed
    # metric_name_filter = ["cpu"]

    ## Prefix for Mearsurement names
    # Configuring this adds a prefix to the Mearsurement names
    measurement_prefix = ""

    ## Mearsurement name
    # By default, the metric name is split by underscores ("_"), with the first field becoming the Mearsurement name and the remaining fields becoming the current metric name
    # If `measurement_name` is configured, the metric name splitting does not occur
    # The final Mearsurement name will include the `measurement_prefix` prefix
    # measurement_name = "prom"

    ## Collection interval "ns", "us" (or "µs"), "ms", "s", "m", "h"
    interval = "10s"

    ## Filter tags, multiple tags can be configured
    # Matching tags will be ignored
    # tags_ignore = ["xxxx"]

    ## TLS Configuration
    tls_open = false
    # tls_ca = "/tmp/ca.crt"
    # tls_cert = "/tmp/peer.crt"
    # tls_key = "/tmp/peer.key"

    ## Custom authentication method, currently only supports Bearer Token
    # Only one of `token` or `token_file` needs to be configured
    # [inputs.prom.auth]
    # type = "bearer_token"
    # token = "xxxxxxxx"
    # token_file = "/tmp/token"

    ## Custom Mearsurement names
    # Metrics containing the prefix `prefix` can be grouped into one Mearsurement
    # Custom Mearsurement name configuration takes precedence over `measurement_name`
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
- Restart DataKit (if you need to enable logging, configure log collection before restarting)

```bash
systemctl restart datakit
```

- Verify with DQL

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

## Metrics Details {#metric}
| **Name** | **Description** | **Metric Type** | **Availability** |
| --- | --- | --- | --- |
| **zookeeper_approximate_data_size** | Approximate size of the data held by the server | Metrics |  |
| **zookeeper_avg_latency** | Time taken by the server to respond to client requests (ms) | Metrics |  |
| **zookeeper_bytes_received** | Number of bytes received | Metrics |  |
| **zookeeper_bytes_sent** | Number of bytes sent | Metrics |  |
| **zookeeper_connections** | Total number of client connections (connections) | Metrics |  |
| **zookeeper_ephemerals_count** | Number of ephemeral nodes | Metrics |  |
| **zookeeper_instances** | Number of instances | Metrics |  |
| **zookeeper_latency.avg** | Average latency for server response to client requests (ms) | Metrics |  |
| **zookeeper_latency.max** | Maximum latency for server response to client requests (ms) | Metrics |  |
| **zookeeper_latency.min** | Minimum latency for server response to client requests (ms) | Metrics |  |
| **zookeeper_max_file_descriptor_count** | Maximum file descriptor count | Metrics |  |
| **zookeeper_max_latency** | Maximum latency for server response to client requests (ms) | Metrics |  |
| **zookeeper_min_latency** | Minimum latency for server response to client requests (ms) | Metrics |  |
| **zookeeper_nodes** | Number of `znode` in the ZooKeeper namespace (data) | Metrics |  |
| **zookeeper_num_alive_connections** | Total number of active client connections (connections) | Metrics |  |
| **zookeeper_open_file_descriptor_count** | Open file descriptor count | Metrics |  |
| **zookeeper_outstanding_requests** | Number of queued requests when the server load is insufficient and the number of continuous incoming requests exceeds its processing capacity (requests) | Metrics |  |
| **zookeeper_packets.received** | Number of packets received | Metrics |  |
| **zookeeper_packets.sent** | Number of packets sent | Metrics |  |
| **zookeeper_packets_received** | Number of packets received | Metrics |  |
| **zookeeper_packets_sent** | Number of packets sent | Metrics |  |
| **zookeeper_server_state** | Server state | Metrics |  |
| **zookeeper_watch_count** | Watch count | Metrics |  |
| **zookeeper_znode_count** | Number of `znode` in the ZooKeeper namespace (data) | Metrics |  |
| **zookeeper_zxid.count** | Count of zxid | Metrics |  |
| **zookeeper_zxid.epoch** | Epoch of zxid | Metrics |  |
| **zookeeper_add_dead_watcher_stall_time** | Add dead watcher stall time | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_bytes_received_count** | Number of bytes received (byte) | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_close_session_prep_time** | Histogram of close_session_prep_time | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_close_session_prep_time_count** | Total count of close_session_prep_time | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_close_session_prep_time_sum** | Sum of close_session_prep_time | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_commit_commit_proc_req_queued** | Histogram of commit_commit_proc_req_queued | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_commit_commit_proc_req_queued_count** | Total count of commit_commit_proc_req_queued | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_commit_commit_proc_req_queued_sum** | Sum of commit_commit_proc_req_queued | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_commit_count** | Number of commits executed on leader | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_commit_process_time** | Histogram of commit_process_time | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_commit_process_time_count** | Total count of commit_process_time | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_commit_process_time_sum** | Sum of commit_process_time | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_commit_propagation_latency** | Histogram of commit_propagation_latency | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_commit_propagation_latency_count** | Total count of commit_propagation_latency | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_commit_propagation_latency_sum** | Sum of commit_propagation_latency | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_concurrent_request_processing_in_commit_processor** | Histogram of concurrent_request_processing_in_commit_processor | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_concurrent_request_processing_in_commit_processor_count** | Total count of concurrent_request_processing_in_commit_processor | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_concurrent_request_processing_in_commit_processor_sum** | Sum of concurrent_request_processing_in_commit_processor | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_connection_drop_count** | Connection drop count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_connection_drop_probability** | Connection drop probability | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_connection_rejected** | Connection rejection count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_connection_request_count** | Incoming client connection request count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_connection_revalidate_count** | Connection revalidation count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_connection_token_deficit** | Histogram of connection_token_deficit | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_connection_token_deficit_count** | Total count of connection_token_deficit | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_connection_token_deficit_sum** | Sum of connection_token_deficit | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_dbinittime** | Time to reload database | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_dbinittime_count** | Time to reload database | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_dbinittime_sum** | Time to reload database | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_dead_watchers_cleaner_latency** | Histogram of dead_watchers_cleaner_latency | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_dead_watchers_cleaner_latency_count** | Total count of dead_watchers_cleaner_latency | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_dead_watchers_cleaner_latency_sum** | Sum of dead_watchers_cleaner_latency | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_dead_watchers_cleared** | Dead watchers cleared count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_dead_watchers_queued** | Dead watchers queued count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_diff_count** | Number of differential synchronization executions | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_digest_mismatches_count** | Digest mismatches count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_election_time** | Time between entering and leaving election | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_election_time_count** | Time between entering and leaving election | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_election_time_sum** | Time between entering and leaving election | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_ensemble_auth_fail** | Ensemble authentication failures | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_ensemble_auth_skip** | Ensemble authentication skips | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_ensemble_auth_success** | Ensemble authentication successes | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_follower_sync_time** | Time follower synchronizes with leader | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_follower_sync_time_count** | Follower synchronization time count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_follower_sync_time_sum** | Follower synchronization time sum | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_fsynctime** | Time to fsync transaction log | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_fsynctime_count** | Time to fsync transaction log | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_fsynctime_sum** | Time to fsync transaction log | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_global_sessions** | Global session count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_buffer_pool_capacity_bytes** | JVM buffer pool capacity (bytes) | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_buffer_pool_used_buffers** | JVM buffer pool used buffers | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_buffer_pool_used_bytes** | JVM buffer pool used bytes | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_classes_loaded** | Number of loaded classes | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_classes_loaded_total** | Total number of loaded classes | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_classes_unloaded_total** | Total number of unloaded classes | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_gc_collection_seconds_count** | Garbage collection collection seconds count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_gc_collection_seconds_sum** | Garbage collection collection seconds sum | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_info** | JVM information | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_memory_bytes_committed** | Committed memory bytes | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_memory_bytes_init** | Initialized memory bytes | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_memory_bytes_max** | Maximum memory bytes | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_memory_bytes_used** | Used memory bytes | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_memory_pool_allocated_bytes_total** | Allocated memory pool bytes total | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_memory_pool_bytes_committed** | Committed memory pool bytes | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_memory_pool_bytes_init** | Initialized memory pool bytes | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_memory_pool_bytes_max** | Maximum memory pool bytes | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_memory_pool_bytes_used** | Used memory pool bytes | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_threads_current** | Current threads | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_threads_daemon** | Daemon threads | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_threads_deadlocked** | Deadlocked threads | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_threads_deadlocked_monitor** | Deadlocked monitor threads | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_threads_peak** | Peak threads | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_threads_started_total** | Total started threads | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_jvm_threads_state** | Threads state | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_large_requests_rejected** | Large requests rejected count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_last_client_response_size** | Last client response size | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_learner_commit_received_count** | Learner commit received count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_learner_proposal_received_count** | Learner proposal received count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_local_sessions** | Local session count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_local_write_committed_time_ms** | Histogram of local_write_committed_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_local_write_committed_time_ms_count** | Total count of local_write_committed_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_local_write_committed_time_ms_sum** | Sum of local_write_committed_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_looking_count** | Number of transitions to looking state | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_max_client_response_size** | Maximum client response size | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_min_client_response_size** | Minimum client response size | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_netty_queued_buffer_capacity** | Histogram of netty_queued_buffer_capacity | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_netty_queued_buffer_capacity_count** | Total count of netty_queued_buffer_capacity | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_netty_queued_buffer_capacity_sum** | Sum of netty_queued_buffer_capacity | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_node_changed_watch_count** | Histogram of node_changed_watch_count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_node_changed_watch_count_count** | Total count of node_changed_watch_count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_node_changed_watch_count_sum** | Sum of node_changed_watch_count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_node_children_watch_count** | Histogram of node_children_watch_count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_node_children_watch_count_count** | Total count of node_children_watch_count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_node_children_watch_count_sum** | Sum of node_children_watch_count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_node_created_watch_count** | Histogram of node_created_watch_count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_node_created_watch_count_count** | Total count of node_created_watch_count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_node_created_watch_count_sum** | Sum of node_created_watch_count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_node_deleted_watch_count** | Histogram of node_deleted_watch_count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_node_deleted_watch_count_count** | Total count of node_deleted_watch_count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_node_deleted_watch_count_sum** | Sum of node_deleted_watch_count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_om_commit_process_time_ms** | Histogram of om_commit_process_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_om_commit_process_time_ms_count** | Total count of om_commit_process_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_om_commit_process_time_ms_sum** | Sum of om_commit_process_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_om_proposal_process_time_ms** | Histogram of om_proposal_process_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_om_proposal_process_time_ms_count** | Total count of om_proposal_process_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_om_proposal_process_time_ms_sum** | Sum of om_proposal_process_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_outstanding_changes_queued** | Outstanding changes queued count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_outstanding_changes_removed** | Outstanding changes removed count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_outstanding_tls_handshake** | Outstanding TLS handshake count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_pending_session_queue_size** | Histogram of pending_session_queue_size | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_pending_session_queue_size_count** | Total count of pending_session_queue_size | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_pending_session_queue_size_sum** | Sum of pending_session_queue_size | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_prep_process_time** | Histogram of prep_process_time | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_prep_process_time_count** | Total count of prep_process_time | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_prep_process_time_sum** | Sum of prep_process_time | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_prep_processor_queue_size** | Histogram of prep_processor_queue_size | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_prep_processor_queue_size_count** | Total count of prep_processor_queue_size | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_prep_processor_queue_size_sum** | Sum of prep_processor_queue_size | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_prep_processor_queue_time_ms** | Histogram of prep_processor_queue_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_prep_processor_queue_time_ms_count** | Total count of prep_processor_queue_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_prep_processor_queue_time_ms_sum** | Sum of prep_processor_queue_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_prep_processor_request_queued** | Prep processor request queued count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_process_cpu_seconds_total** | Total CPU seconds used by the process | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_process_max_fds** | Maximum file descriptors for the process | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_process_open_fds** | Open file descriptors for the process | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_process_resident_memory_bytes** | Resident memory bytes for the process | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_process_start_time_seconds** | Start time of the process | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_process_virtual_memory_bytes** | Virtual memory bytes for the process | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_propagation_latency** | End-to-end delay from leader proposal to committed data tree on a given host | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_propagation_latency_count** | End-to-end delay from leader proposal to committed data tree on a given host | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_propagation_latency_sum** | End-to-end delay from leader proposal to committed data tree on a given host | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_proposal_ack_creation_latency** | Histogram of proposal_ack_creation_latency | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_proposal_ack_creation_latency_count** | Total count of proposal_ack_creation_latency | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_proposal_ack_creation_latency_sum** | Sum of proposal_ack_creation_latency | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_proposal_count** | Proposal count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_proposal_latency** | Histogram of proposal_latency | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_proposal_latency_count** | Total count of proposal_latency | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_proposal_latency_sum** | Sum of proposal_latency | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_quit_leading_due_to_disloyal_voter** | Quit leading due to disloyal voter count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_quorum_ack_latency** | Histogram of quorum_ack_latency | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_quorum_ack_latency_count** | Total count of quorum_ack_latency | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_quorum_ack_latency_sum** | Sum of quorum_ack_latency | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_read_commit_proc_issued** | Histogram of read_commit_proc_issued | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_read_commit_proc_issued_count** | Total count of read_commit_proc_issued | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_read_commit_proc_issued_sum** | Sum of read_commit_proc_issued | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_read_commit_proc_req_queued** | Histogram of read_commit_proc_req_queued | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_read_commit_proc_req_queued_count** | Total count of read_commit_proc_req_queued | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_read_commit_proc_req_queued_sum** | Sum of read_commit_proc_req_queued | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_read_commitproc_time_ms** | Histogram of read_commitproc_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_read_commitproc_time_ms_count** | Total count of read_commitproc_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_read_commitproc_time_ms_sum** | Sum of read_commitproc_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_read_final_proc_time_ms** | Histogram of read_final_proc_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_read_final_proc_time_ms_count** | Total count of read_final_proc_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_read_final_proc_time_ms_sum** | Sum of read_final_proc_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_readlatency** | Histogram of readlatency for read requests | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_readlatency_count** | Total count of readlatency for read requests | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_readlatency_sum** | Sum of readlatency for read requests | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_reads_after_write_in_session_queue** | Histogram of reads_after_write_in_session_queue | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_reads_after_write_in_session_queue_count** | Total count of reads_after_write_in_session_queue | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_reads_after_write_in_session_queue_sum** | Sum of reads_after_write_in_session_queue | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_reads_issued_from_session_queue** | Histogram of reads_issued_from_session_queue | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_reads_issued_from_session_queue_count** | Total count of reads_issued_from_session_queue | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_reads_issued_from_session_queue_sum** | Sum of reads_issued_from_session_queue | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_request_commit_queued** | Queued request commit count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_request_throttle_wait_count** | Request throttle wait count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_requests_in_session_queue** | Histogram of requests_in_session_queue | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_requests_in_session_queue_count** | Total count of requests_in_session_queue | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_requests_in_session_queue_sum** | Sum of requests_in_session_queue | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_response_packet_cache_hits** | Response packet cache hits | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_response_packet_cache_misses** | Response packet cache misses | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_response_packet_get_children_cache_hits** | Response packet get children cache hits | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_response_packet_get_children_cache_misses** | Response packet get children cache misses | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_revalidate_count** | Revalidate count | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_server_write_committed_time_ms** | Histogram of server_write_committed_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_server_write_committed_time_ms_count** | Total count of server_write_committed_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_server_write_committed_time_ms_sum** | Sum of server_write_committed_time_ms | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_session_queues_drained** | Histogram of session_queues_drained | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_session_queues_drained_count** | Total count of session_queues_drained | Metrics | Applicable to Zookeeper 3.6+ |
| **zookeeper_session_queues