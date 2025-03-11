---
title     : 'ZooKeeper'
summary   : 'Collect ZooKeeper related Metrics information'
__int_icon: 'icon/zookeeper'
dashboard :
  - desc  : 'ZooKeeper Monitoring View'
    path  : 'dashboard/en/zookeeper'
monitor   :
  - desc  : 'ZooKeeper Detection Library'
    path  : 'monitor/en/zookeeper'
---

<!-- markdownlint-disable MD025 -->
# ZooKeeper
<!-- markdownlint-enable -->
---

## Installation and Deployment {#config}

Note: The example ZooKeeper version is 3.6.3 (CentOS). Versions 3.6 and above provide many more metrics compared to previous versions. If you are using a version prior to 3.6, some metrics might not be collected.

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
- Download and install [zookeeper_exporter](https://github.com/carlpett/zookeeper_exporter/releases/download/v1.1.0/zookeeper_exporter), then use `chmod +x` to grant execution permissions and start it. The default port is 9141, and you can verify the data using the following command:

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
    urls = ["[http://127.0.0.1:9141/metrics"]](http://127.0.0.1:9141/metrics")

    ## Ignore request errors for URL
    ignore_req_err = false

    ## Collector alias
    source = "zookeeper"

    ## Output source for collected data
    # Configuring this option allows writing collected data to a local file instead of sending it to the center
    # Later, you can directly debug the saved Metrics with the command `datakit --prom-conf /path/to/this/conf`
    # If the URL is configured as a local file path, the `--prom-conf` option takes precedence in debugging the data at the output path
    # output = "/abs/path/to/file"
    > 
    ## Upper limit for the size of collected data, in bytes
    # When outputting data to a local file, you can set an upper limit for the size of collected data
    # If the size of collected data exceeds this limit, the data will be discarded
    # The default upper limit for the size of collected data is set to 32MB
    # max_file_size = 0

    ## Metric type filtering, optional values are counter, gauge, histogram, summary
    # By default, only counter and gauge types of metrics are collected
    # If empty, no filtering is applied
    metric_types = ["counter", "gauge"]

    ## Metric name filtering
    # Supports regex, multiple configurations can be made, satisfying any one of them is enough
    # If empty, no filtering is applied
    # metric_name_filter = ["cpu"]

    ## Prefix for metric set names
    # Configuring this option adds a prefix to the metric set name
    measurement_prefix = ""

    ## Metric set name
    # By default, the metric name is split by underscores "_", the first field after splitting becomes the metric set name, and the remaining fields become the current metric name
    # If `measurement_name` is configured, the metric name will not be split
    # The final metric set name will have the `measurement_prefix` prefix added
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
    # Only one of token or token_file needs to be configured
    # [inputs.prom.auth]
    # type = "bearer_token"
    # token = "xxxxxxxx"
    # token_file = "/tmp/token"

    ## Custom metric set names
    # Metrics containing the prefix `prefix` can be grouped into one metric set
    # Custom metric set name configuration takes precedence over the `measurement_name` option
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
- Restart DataKit (if log collection is required, configure it before restarting)

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

## Metric Details {#metric}
| **Name** | **Description** | **Metric Type** | **Availability** |
| --- | --- | --- | --- |
| **zookeeper_approximate_data_size** | Approximate size of the data | Metric |  |
| **zookeeper_avg_latency** | Time taken by the server to respond to client requests (ms) | Metric |  |
| **zookeeper_bytes_received** | Number of received bytes | Metric |  |
| **zookeeper_bytes_sent** | Number of sent bytes | Metric |  |
| **zookeeper_connections** | Total number of client connections (connections) | Metric |  |
| **zookeeper_ephemerals_count** | Number of ephemeral nodes | Metric |  |
| **zookeeper_instances** | Number of ZooKeeper instances | Metric |  |
| **zookeeper_latency.avg** | Time taken by the server to respond to client requests (ms) | Metric |  |
| **zookeeper_latency.max** | Time taken by the server to respond to client requests (ms) | Metric |  |
| **zookeeper_latency.min** | Time taken by the server to respond to client requests (ms) | Metric |  |
| **zookeeper_max_file_descriptor_count** | Maximum file descriptor count | Metric |  |
| **zookeeper_max_latency** | Time taken by the server to respond to client requests (ms) | Metric |  |
| **zookeeper_min_latency** | Time taken by the server to respond to client requests (ms) | Metric |  |
| **zookeeper_nodes** | Number of `znode` in the ZooKeeper namespace (nodes) | Metric |  |
| **zookeeper_num_alive_connections** | Total number of client connections (connections) | Metric |  |
| **zookeeper_open_file_descriptor_count** | Open file descriptor count | Metric |  |
| **zookeeper_outstanding_requests** | Number of queued requests when the server load is insufficient and the number of received continuous requests exceeds its processing capacity (requests) | Metric |  |
| **zookeeper_packets.received** | Number of received packets | Metric |  |
| **zookeeper_packets.sent** | Number of sent packets | Metric |  |
| **zookeeper_packets_received** | Number of received packets | Metric |  |
| **zookeeper_packets_sent** | Number of sent packets | Metric |  |
| **zookeeper_server_state** | Server state | Metric |  |
| **zookeeper_watch_count** | Watch count | Metric |  |
| **zookeeper_znode_count** | Number of `znode` in the ZooKeeper namespace | Metric |  |
| **zookeeper_zxid.count** |  | Metric |  |
| **zookeeper_zxid.epoch** |  | Metric |  |
| **zookeeper_add_dead_watcher_stall_time** |  | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_bytes_received_count** | Number of received bytes (byte) | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_close_session_prep_time** | Histogram of close_session_prep_time | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_close_session_prep_time_count** | Total count of close_session_prep_time | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_close_session_prep_time_sum** | Sum of close_session_prep_time | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_commit_commit_proc_req_queued** | Histogram of commit_commit_proc_req_queued | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_commit_commit_proc_req_queued_count** | Total count of commit_commit_proc_req_queued | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_commit_commit_proc_req_queued_sum** | Sum of commit_commit_proc_req_queued | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_commit_count** | Number of commits executed on the leader | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_commit_process_time** | Histogram of commit_process_time | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_commit_process_time_count** | Total count of commit_process_time | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_commit_process_time_sum** | Sum of commit_process_time | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_commit_propagation_latency** | Histogram of commit_propagation_latency | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_commit_propagation_latency_count** | Total count of commit_propagation_latency | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_commit_propagation_latency_sum** | Sum of commit_propagation_latency | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_concurrent_request_processing_in_commit_processor** | Histogram of concurrent_request_processing_in_commit_processor | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_concurrent_request_processing_in_commit_processor_count** | Total count of concurrent_request_processing_in_commit_processor | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_concurrent_request_processing_in_commit_processor_sum** | Sum of concurrent_request_processing_in_commit_processor | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_connection_drop_count** | Connection drop count | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_connection_drop_probability** | Connection drop probability | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_connection_rejected** | Connection rejected count | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_connection_request_count** | Number of incoming client connection requests | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_connection_revalidate_count** | Connection revalidation count | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_connection_token_deficit** | Histogram of connection_token_deficit | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_connection_token_deficit_count** | Total count of connection_token_deficit | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_connection_token_deficit_sum** | Sum of connection_token_deficit | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_dbinittime** | Time to reload database | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_dbinittime_count** | Time to reload database | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_dbinittime_sum** | Time to reload database | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_dead_watchers_cleaner_latency** | Histogram of dead_watchers_cleaner_latency | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_dead_watchers_cleaner_latency_count** | Total count of dead_watchers_cleaner_latency | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_dead_watchers_cleaner_latency_sum** | Sum of dead_watchers_cleaner_latency | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_dead_watchers_cleared** |  | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_dead_watchers_queued** |  | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_diff_count** | Number of differential synchronizations performed | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_digest_mismatches_count** |  | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_election_time** | Time between entering and leaving election | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_election_time_count** | Time between entering and leaving election | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_election_time_sum** | Time between entering and leaving election | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_ensemble_auth_fail** |  | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_ensemble_auth_skip** |  | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_ensemble_auth_success** |  | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_follower_sync_time** | Time taken for follower to sync with leader | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_follower_sync_time_count** | Count of follower sync time | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_follower_sync_time_sum** | Sum of follower sync time | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_fsynctime** | Time taken to fsync transaction logs | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_fsynctime_count** | Time taken to fsync transaction logs | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_fsynctime_sum** | Time taken to fsync transaction logs | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_global_sessions** | Global session count | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_buffer_pool_capacity_bytes** |  | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_buffer_pool_used_buffers** |  | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_buffer_pool_used_bytes** |  | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_classes_loaded** |  | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_classes_loaded_total** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_classes_unloaded_total** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_gc_collection_seconds_count** |  | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_gc_collection_seconds_sum** |  | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_info** |  | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_memory_bytes_committed** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_memory_bytes_init** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_memory_bytes_max** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_memory_bytes_used** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_memory_pool_allocated_bytes_total** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_memory_pool_bytes_committed** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_memory_pool_bytes_init** | (byte) | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_memory_pool_bytes_max** | (byte) | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_memory_pool_bytes_used** | (byte) | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_threads_current** |  | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_threads_daemon** |  | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_threads_deadlocked** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_threads_deadlocked_monitor** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_threads_peak** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_threads_started_total** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_jvm_threads_state** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_large_requests_rejected** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_last_client_response_size** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_learner_commit_received_count** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_learner_proposal_received_count** |  | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_local_sessions** | Local session count | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_local_write_committed_time_ms** | Histogram of local_write_committed_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_local_write_committed_time_ms_count** | Total count of local_write_committed_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_local_write_committed_time_ms_sum** | Sum of local_write_committed_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_looking_count** | Number of transitions to looking state | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_max_client_response_size** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_min_client_response_size** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_netty_queued_buffer_capacity** | Histogram of netty_queued_buffer_capacity | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_netty_queued_buffer_capacity_count** | Total count of netty_queued_buffer_capacity | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_netty_queued_buffer_capacity_sum** | Sum of netty_queued_buffer_capacity | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_node_changed_watch_count** | Histogram of node_changed_watch_count | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_node_changed_watch_count_count** | Total count of node_changed_watch_count | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_node_changed_watch_count_sum** | Sum of node_changed_watch_count | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_node_children_watch_count** | Histogram of node_children_watch_count | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_node_children_watch_count_count** | Total count of node_children_watch_count | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_node_children_watch_count_sum** | Sum of node_children_watch_count | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_node_created_watch_count** | Histogram of node_created_watch_count | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_node_created_watch_count_count** | Total count of node_created_watch_count | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_node_created_watch_count_sum** | Sum of node_created_watch_count | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_node_deleted_watch_count** | Histogram of node_deleted_watch_count | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_node_deleted_watch_count_count** | Total count of node_deleted_watch_count | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_node_deleted_watch_count_sum** | Sum of node_deleted_watch_count | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_om_commit_process_time_ms** | Histogram of om_commit_process_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_om_commit_process_time_ms_count** | Total count of om_commit_process_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_om_commit_process_time_ms_sum** | Sum of om_commit_process_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_om_proposal_process_time_ms** | Histogram of om_proposal_process_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_om_proposal_process_time_ms_count** | Total count of om_proposal_process_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_om_proposal_process_time_ms_sum** | Sum of om_proposal_process_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_outstanding_changes_queued** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_outstanding_changes_removed** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_outstanding_tls_handshake** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_pending_session_queue_size** | Histogram of pending_session_queue_size | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_pending_session_queue_size_count** | Total count of pending_session_queue_size | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_pending_session_queue_size_sum** | Sum of pending_session_queue_size | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_prep_process_time** | Histogram of prep_process_time | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_prep_process_time_count** | Total count of prep_process_time | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_prep_process_time_sum** | Sum of prep_process_time | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_prep_processor_queue_size** | Histogram of prep_processor_queue_size | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_prep_processor_queue_size_count** | Total count of prep_processor_queue_size | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_prep_processor_queue_size_sum** | Sum of prep_processor_queue_size | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_prep_processor_queue_time_ms** | Histogram of prep_processor_queue_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_prep_processor_queue_time_ms_count** | Total count of prep_processor_queue_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_prep_processor_queue_time_ms_sum** | Sum of prep_processor_queue_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_prep_processor_request_queued** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_process_cpu_seconds_total** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_process_max_fds** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_process_open_fds** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_process_resident_memory_bytes** | (byte) | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_process_start_time_seconds** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_process_virtual_memory_bytes** | (byte) | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_propagation_latency** | End-to-end delay from leader proposal to committed data tree on the given host | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_propagation_latency_count** | End-to-end delay from leader proposal to committed data tree on the given host | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_propagation_latency_sum** | End-to-end delay from leader proposal to committed data tree on the given host | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_proposal_ack_creation_latency** | Histogram of proposal_ack_creation_latency | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_proposal_ack_creation_latency_count** | Total count of proposal_ack_creation_latency | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_proposal_ack_creation_latency_sum** | Sum of proposal_ack_creation_latency | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_proposal_count** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_proposal_latency** | Histogram of proposal_latency | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_proposal_latency_count** | Total count of proposal_latency | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_proposal_latency_sum** | Sum of proposal_latency | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_quit_leading_due_to_disloyal_voter** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_quorum_ack_latency** | Histogram of quorum_ack_latency | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_quorum_ack_latency_count** | Total count of quorum_ack_latency | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_quorum_ack_latency_sum** | Sum of quorum_ack_latency | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_read_commit_proc_issued** | Histogram of read_commit_proc_issued | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_read_commit_proc_issued_count** | Total count of read_commit_proc_issued | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_read_commit_proc_issued_sum** | Sum of read_commit_proc_issued | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_read_commit_proc_req_queued** | Histogram of read_commit_proc_req_queued | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_read_commit_proc_req_queued_count** | Total count of read_commit_proc_req_queued | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_read_commit_proc_req_queued_sum** | Sum of read_commit_proc_req_queued | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_read_commitproc_time_ms** | Histogram of read_commitproc_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_read_commitproc_time_ms_count** | Total count of read_commitproc_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_read_commitproc_time_ms_sum** | Sum of read_commitproc_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_read_final_proc_time_ms** | Histogram of read_final_proc_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_read_final_proc_time_ms_count** | Total count of read_final_proc_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_read_final_proc_time_ms_sum** | Sum of read_final_proc_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_readlatency** | `readlatency` histogram for read request latency | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_readlatency_count** | Total count of `readlatency` for read request latency | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_readlatency_sum** | Sum of `readlatency` for read request latency | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_reads_after_write_in_session_queue** | Histogram of reads_after_write_in_session_queue | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_reads_after_write_in_session_queue_count** | Total count of reads_after_write_in_session_queue | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_reads_after_write_in_session_queue_sum** | Sum of reads_after_write_in_session_queue | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_reads_issued_from_session_queue** | Histogram of reads_issued_from_session_queue | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_reads_issued_from_session_queue_count** | Total count of reads_issued_from_session_queue | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_reads_issued_from_session_queue_sum** | Sum of reads_issued_from_session_queue | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_request_commit_queued** | Queued request commit count | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_request_throttle_wait_count** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_requests_in_session_queue** | Histogram of requests_in_session_queue | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_requests_in_session_queue_count** | Total count of requests_in_session_queue | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_requests_in_session_queue_sum** | Sum of requests_in_session_queue | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_response_packet_cache_hits** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_response_packet_cache_misses** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_response_packet_get_children_cache_hits** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_response_packet_get_children_cache_misses** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_revalidate_count** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_server_write_committed_time_ms** | Histogram of server_write_committed_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_server_write_committed_time_ms_count** | Total count of server_write_committed_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_server_write_committed_time_ms_sum** | Sum of server_write_committed_time_ms | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_session_queues_drained** | Histogram of session_queues_drained | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_session_queues_drained_count** | Total count of session_queues_drained | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_session_queues_drained_sum** | Sum of session_queues_drained | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_sessionless_connections_expired** | | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_snap_count** | Number of snapshot synchronizations performed | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_snapshottime** | Histogram of `snapshottime` for write snapshot time | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_snapshottime_count** | Total count of snapshot time for writing snapshots | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_snapshottime_sum** | Sum of snapshot time for writing snapshots | Metric | Available for Zookeeper 3.6+  |
| **zookeeper_stale_replies** | | Metric | Available for Zookeeper 3.6+|
| **zookeeper_stale_requests** | | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_stale_requests_dropped** | | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_stale_sessions_expired** | | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_startup_snap_load_time** | Histogram of startup_snap_load_time | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_startup_snap_load_time_count** | Total count of startup_snap_load_time | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_startup_snap_load_time_sum** | Sum of startup_snap_load_time | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_startup_txns_load_time** | Histogram of startup_txns_load_time | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_startup_txns_load_time_count** | Total count of startup_txns_load_time | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_startup_txns_load_time_sum** | Sum of startup_txns_load_time | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_startup_txns_loaded** | Histogram of startup_txns_loaded | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_startup_txns_loaded_count** | Total count of startup_txns_loaded | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_startup_txns_loaded_sum** | Sum of startup_txns_loaded | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_sync_process_time** | Histogram of sync_process_time | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_sync_process_time_count** | Total count of sync_process_time | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_sync_process_time_sum** | Sum of sync_process_time | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_sync_processor_batch_size** | Histogram of sync_processor_batch_size | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_sync_processor_batch_size_count** | Total count of sync_processor_batch_size | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_sync_processor_batch_size_sum** | Sum of sync_processor_batch_size | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_sync_processor_queue_and_flush_time_ms** | Histogram of sync_processor_queue_and_flush_time_ms | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_sync_processor_queue_and_flush_time_ms_count** | Total count of sync_processor_queue_and_flush_time_ms | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_sync_processor_queue_and_flush_time_ms_sum** | Sum of sync_processor_queue_and_flush_time_ms | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_sync_processor_queue_flush_time_ms** | Histogram of sync_processor_queue_flush_time_ms | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_sync_processor_queue_flush_time_ms_count** | Total count of sync_processor_queue_flush_time_ms | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_sync_processor_queue_flush_time_ms_sum** | Sum of sync_processor_queue_flush_time_ms | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_sync_processor_queue_size** | Histogram of sync_processor_queue_size | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_sync_processor_queue_size_count** | Total count of sync_processor_queue_size | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_sync_processor_queue_size_sum** | Sum of sync_processor_queue_size | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_sync_processor_queue_time_ms** | Histogram of sync_processor_queue_time_ms | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_sync_processor_queue_time_ms_count** | Total count of sync_processor_queue_time_ms | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_sync_processor_queue_time_ms_sum** | Sum of sync_processor_queue_time_ms | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_sync_processor_request_queued** | | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_time_waiting_empty_pool_in_commit_processor_read_ms** | Histogram of time_waiting_empty_pool_in_commit_processor_read_ms | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_time_waiting_empty_pool_in_commit_processor_read_ms_count** | Total count of time_waiting_empty_pool_in_commit_processor_read_ms | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_time_waiting_empty_pool_in_commit_processor_read_ms_sum** | Sum of time_waiting_empty_pool_in_commit_processor_read_ms | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_tls_handshake_exceeded** | | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_unrecoverable_error_count** | | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_updatelatency** | `updatelatency` histogram for update request latency | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_updatelatency_count** | Total count of `updatelatency` for update request latency | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_updatelatency_sum** | Sum of `updatelatency` for update request latency | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_uptime** | Uptime of the peer in the leading/following/observing state | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_write_batch_time_in_commit_processor** | Histogram of write_batch_time_in_commit_processor | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_write_batch_time_in_commit_processor_count** | Total count of write_batch_time_in_commit_processor | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_write_batch_time_in_commit_processor_sum** | Sum of write_batch_time_in_commit_processor | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_write_commit_proc_issued** | Histogram of write_commit_proc_issued | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_write_commit_proc_issued_count** | Total count of write_commit_proc_issued | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_write_commit_proc_issued_sum** | Sum of write_commit_proc_issued | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_write_commit_proc_req_queued** | Histogram of write_commit_proc_req_queued | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_write_commit_proc_req_queued_count** | Total count of write_commit_proc_req_queued | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_write_commit_proc_req_queued_sum** | Sum of write_commit_proc_req_queued | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_write_commitproc_time_ms** | Histogram of write_commitproc_time_ms | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_write_commitproc_time_ms_count** | Total count of write_commitproc_time_ms | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_write_commitproc_time_ms_sum** | Sum of write_commitproc_time_ms | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_write_final_proc_time_ms** | Histogram of write_final_proc_time_ms | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_write_final_proc_time_ms_count** | Total count of write_final_proc_time_ms | Metric | Available for Zookeeper 3.6+ |
| **zookeeper_write_final_proc_time_ms_sum** | Sum of write_final_proc_time_ms | Metric | Available for Zookeeper 3.6+ |

This concludes the detailed list of metrics available for ZooKeeper, especially focusing on versions 3.6 and above. Each metric provides valuable insights into the performance and health of your ZooKeeper cluster.
