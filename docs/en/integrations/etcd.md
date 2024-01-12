---
title     : 'etcd'
summary   : 'Collect etcd metrics'
__int_icon      : 'icon/etcd'
dashboard :
  - desc  : 'etcd'
    path  : 'dashboard/zh/etcd'
  - desc  : 'etcd-k8s'
    path  : 'dashboard/zh/etcd-k8s'    
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# etcd
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The tcd collector can take many metrics from the etcd instance, such as the status of the etcd server and network, and collect the metrics to DataFlux to help you monitor and analyze various abnormal situations of etcd.

## Configuration {#config}

### Preconditions {#requirements}

etcd version >= 3, Already tested version:

- [x] 3.5.7
- [x] 3.4.24
- [x] 3.3.27

Open etcd, the default metrics interface is `http://localhost:2379/metrics`, or you can modify it in your configuration file.

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/etcd` directory under the DataKit installation directory, copy `etcd.conf.sample` and name it `etcd.conf`. Examples are as follows:

    ```toml
        
    [[inputs.etcd]]
      ## Exporter URLs.
      urls = ["http://127.0.0.1:2379/metrics"]
    
      ## TLS configuration.
      tls_open = false
      # tls_ca = "/tmp/ca.crt"
      # tls_cert = "/tmp/peer.crt"
      # tls_key = "/tmp/peer.key"
    
      ## Set to 'true' to enable election.
      election = true
    
      ## Ignore tags. Multi supported.
      ## The matched tags would be dropped, but the item would still be sent.
      # tags_ignore = ["xxxx"]
    
      ## Customize tags.
      [inputs.etcd.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      
      ## (Optional) Collect interval: (defaults to "30s").
      # interval = "30s"
    
    ```
    
    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap injection collector configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Metric {#metric}



### `etcd`

- tag


| Tag | Description |
|  ----  | --------|
|`action`|Action.|
|`cluster_version`|Cluster version.|
|`code`|Code.|
|`grpc_code`|GRPC code.|
|`grpc_method`|GRPC method.|
|`grpc_service`|GRPC service name.|
|`grpc_type`|GRPC type.|
|`host`|Hostname.|
|`instance`|Instance.|
|`server_go_version`|Server go version.|
|`server_id`|Server ID.|
|`server_version`|Server version.|
|`version`|Version.|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`etcd_cluster_version`|Which version is running. 1 for 'cluster_version' label with current cluster version|float|count|
|`etcd_debugging_auth_revision`|The current revision of auth store.|float|count|
|`etcd_debugging_disk_backend_commit_rebalance_duration_seconds`|The latency distributions of commit.rebalance called by bboltdb backend.|float|count|
|`etcd_debugging_disk_backend_commit_spill_duration_seconds`|The latency distributions of commit.spill called by bboltdb backend.|float|count|
|`etcd_debugging_disk_backend_commit_write_duration_seconds`|The latency distributions of commit.write called by bboltdb backend.|float|count|
|`etcd_debugging_lease_granted_total`|The total number of granted leases.|float|count|
|`etcd_debugging_lease_renewed_total`|The number of renewed leases seen by the leader.|float|count|
|`etcd_debugging_lease_revoked_total`|The total number of revoked leases.|float|count|
|`etcd_debugging_lease_ttl_total`|Bucketed histogram of lease TTLs.|float|count|
|`etcd_debugging_mvcc_compact_revision`|The revision of the last compaction in store.|float|count|
|`etcd_debugging_mvcc_current_revision`|The current revision of store.|float|count|
|`etcd_debugging_mvcc_db_compaction_keys_total`|Total number of db keys compacted.|float|count|
|`etcd_debugging_mvcc_db_compaction_last`|The unix time of the last db compaction. Resets to 0 on start.|float|count|
|`etcd_debugging_mvcc_db_compaction_pause_duration_milliseconds`|Bucketed histogram of db compaction pause duration.|float|count|
|`etcd_debugging_mvcc_db_compaction_total_duration_milliseconds`|Bucketed histogram of db compaction total duration.|float|count|
|`etcd_debugging_mvcc_db_total_size_in_bytes`|Total size of the underlying database physically allocated in bytes.|float|count|
|`etcd_debugging_mvcc_delete_total`|Total number of deletes seen by this member.|float|count|
|`etcd_debugging_mvcc_events_total`|Total number of events sent by this member.|float|count|
|`etcd_debugging_mvcc_index_compaction_pause_duration_milliseconds`|Bucketed histogram of index compaction pause duration.|float|count|
|`etcd_debugging_mvcc_keys_total`|Total number of keys.|float|count|
|`etcd_debugging_mvcc_pending_events_total`|Total number of pending events to be sent.|float|count|
|`etcd_debugging_mvcc_put_total`|Total number of puts seen by this member.|float|count|
|`etcd_debugging_mvcc_range_total`|Total number of ranges seen by this member.|float|count|
|`etcd_debugging_mvcc_slow_watcher_total`|Total number of unsynced slow watchers.|float|count|
|`etcd_debugging_mvcc_total_put_size_in_bytes`|The total size of put kv pairs seen by this member.|float|count|
|`etcd_debugging_mvcc_txn_total`|Total number of txns seen by this member.|float|count|
|`etcd_debugging_mvcc_watch_stream_total`|Total number of watch streams.|float|count|
|`etcd_debugging_mvcc_watcher_total`|Total number of watchers.|float|count|
|`etcd_debugging_server_alarms`|Alarms for every member in cluster. 1 for 'server_id' label with current ID. 2 for 'alarm_type' label with type of this alarm|float|count|
|`etcd_debugging_server_lease_expired_total`|The total number of expired leases.|float|count|
|`etcd_debugging_snap_save_marshalling_duration_seconds`|The marshaling cost distributions of save called by snapshot.|float|count|
|`etcd_debugging_snap_save_total_duration_seconds`|The total latency distributions of save called by snapshot.|float|count|
|`etcd_debugging_store_expires_total`|Total number of expired keys.|float|count|
|`etcd_debugging_store_reads_failed_total`|Failed read actions by (get/getRecursive), local to this member.|float|count|
|`etcd_debugging_store_reads_total`|Total number of reads action by (get/getRecursive), local to this member.|float|count|
|`etcd_debugging_store_watch_requests_total`|Total number of incoming watch requests (new or reestablished).|float|count|
|`etcd_debugging_store_watchers`|Count of currently active watchers.|float|count|
|`etcd_debugging_store_writes_failed_total`|Failed write actions (e.g. set/compareAndDelete), seen by this member.|float|count|
|`etcd_debugging_store_writes_total`|Total number of writes (e.g. set/compareAndDelete) seen by this member.|float|count|
|`etcd_disk_backend_commit_duration_seconds`|The latency distributions of commit called by backend.|float|count|
|`etcd_disk_backend_defrag_duration_seconds`|The latency distribution of backend defragmentation.|float|count|
|`etcd_disk_backend_snapshot_duration_seconds`|The latency distribution of backend snapshots.|float|count|
|`etcd_disk_defrag_inflight`|Whether or not defrag is active on the member. 1 means active, 0 means not.|float|count|
|`etcd_disk_wal_fsync_duration_seconds`|The latency distributions of fsync called by WAL.|float|count|
|`etcd_disk_wal_write_bytes_total`|Total number of bytes written in WAL.|float|count|
|`etcd_grpc_proxy_cache_hits_total`|Total number of cache hits|float|count|
|`etcd_grpc_proxy_cache_keys_total`|Total number of keys/ranges cached|float|count|
|`etcd_grpc_proxy_cache_misses_total`|Total number of cache misses|float|count|
|`etcd_grpc_proxy_events_coalescing_total`|Total number of events coalescing|float|count|
|`etcd_grpc_proxy_watchers_coalescing_total`|Total number of current watchers coalescing|float|count|
|`etcd_mvcc_db_open_read_transactions`|The number of currently open read transactions|float|count|
|`etcd_mvcc_db_total_size_in_bytes`|Total size of the underlying database physically allocated in bytes.|float|count|
|`etcd_mvcc_db_total_size_in_use_in_bytes`|Total size of the underlying database logically in use in bytes.|float|count|
|`etcd_mvcc_delete_total`|Total number of deletes seen by this member.|float|count|
|`etcd_mvcc_hash_duration_seconds`|The latency distribution of storage hash operation.|float|count|
|`etcd_mvcc_hash_rev_duration_seconds`|The latency distribution of storage hash by revision operation.|float|count|
|`etcd_mvcc_put_total`|Total number of puts seen by this member.|float|count|
|`etcd_mvcc_range_total`|Total number of ranges seen by this member.|float|count|
|`etcd_mvcc_txn_total`|Total number of txns seen by this member.|float|count|
|`etcd_network_active_peers`|The current number of active peer connections.|float|count|
|`etcd_network_client_grpc_received_bytes_total`|The total number of bytes received from grpc clients.|float|count|
|`etcd_network_client_grpc_sent_bytes_total`|The total number of bytes sent to grpc clients.|float|count|
|`etcd_network_disconnected_peers_total`|The total number of disconnected peers.|float|count|
|`etcd_network_known_peers`|The current number of known peers.|float|count|
|`etcd_network_peer_received_bytes_total`|The total number of bytes received from peers.|float|count|
|`etcd_network_peer_received_failures_total`|The total number of receive failures from peers.|float|count|
|`etcd_network_peer_round_trip_time_seconds`|Round-Trip-Time histogram between peers|float|count|
|`etcd_network_peer_sent_bytes_total`|The total number of bytes sent to peers.|float|count|
|`etcd_network_peer_sent_failures_total`|The total number of send failures from peers.|float|count|
|`etcd_network_server_stream_failures_total`|The total number of stream failures from the local server.|float|count|
|`etcd_network_snapshot_receive_failures`|Total number of snapshot receive failures|float|count|
|`etcd_network_snapshot_receive_inflights_total`|Total number of inflight snapshot receives|float|count|
|`etcd_network_snapshot_receive_success`|Total number of successful snapshot receives|float|count|
|`etcd_network_snapshot_receive_total_duration_seconds`|Total latency distributions of v3 snapshot receives|float|count|
|`etcd_network_snapshot_send_failures`|Total number of snapshot send failures|float|count|
|`etcd_network_snapshot_send_inflights_total`|Total number of inflight snapshot sends|float|count|
|`etcd_network_snapshot_send_success`|Total number of successful snapshot sends|float|count|
|`etcd_network_snapshot_send_total_duration_seconds`|Total latency distributions of v3 snapshot sends|float|count|
|`etcd_server_apply_duration_seconds`|The latency distributions of v2 apply called by backend.|float|count|
|`etcd_server_client_requests_total`|The total number of client requests per client version.|float|count|
|`etcd_server_go_version`|Which Go version server is running with. 1 for 'server_go_version' label with current version.|float|count|
|`etcd_server_has_leader`|Whether or not a leader exists. 1 is existence, 0 is not.|float|count|
|`etcd_server_health_failures`|The total number of failed health checks|float|count|
|`etcd_server_health_success`|The total number of successful health checks|float|count|
|`etcd_server_heartbeat_send_failures_total`|The total number of leader heartbeat send failures (likely overloaded from slow disk).|float|count|
|`etcd_server_id`|Server or member ID in hexadecimal format. 1 for 'server_id' label with current ID.|float|count|
|`etcd_server_is_leader`|Whether or not this member is a leader. 1 if is, 0 otherwise.|float|count|
|`etcd_server_is_learner`|Whether or not this member is a learner. 1 if is, 0 otherwise.|float|count|
|`etcd_server_leader_changes_seen_total`|The number of leader changes seen.|float|count|
|`etcd_server_learner_promote_failures`|The total number of failed learner promotions (likely learner not ready) while this member is leader.|float|count|
|`etcd_server_learner_promote_successes`|The total number of successful learner promotions while this member is leader.|float|count|
|`etcd_server_proposals_applied_total`|The total number of consensus proposals applied.|float|count|
|`etcd_server_proposals_committed_total`|The total number of consensus proposals committed.|float|count|
|`etcd_server_proposals_failed_total`|The total number of failed proposals seen.|float|count|
|`etcd_server_proposals_pending`|The current number of pending proposals to commit.|float|count|
|`etcd_server_quota_backend_bytes`|Current backend storage quota size in bytes.|float|count|
|`etcd_server_read_indexes_failed_total`|The total number of failed read indexes seen.|float|count|
|`etcd_server_slow_apply_total`|The total number of slow apply requests (likely overloaded from slow disk).|float|count|
|`etcd_server_slow_read_indexes_total`|The total number of pending read indexes not in sync with leader's or timed out read index requests.|float|count|
|`etcd_server_snapshot_apply_in_progress_total`|1 if the server is applying the incoming snapshot. 0 if none.|float|count|
|`etcd_server_version`|Which version is running. 1 for 'server_version' label with current version.|float|count|
|`etcd_snap_db_fsync_duration_seconds`|The latency distributions of fsyncing .snap.db file|float|count|
|`etcd_snap_db_save_total_duration_seconds`|The total latency distributions of v3 snapshot save|float|count|
|`etcd_snap_fsync_duration_seconds`|The latency distributions of fsync called by snap.|float|count|
|`go_gc_duration_seconds`|A summary of the pause duration of garbage collection cycles.|float|count|
|`go_goroutines`|Number of goroutines that currently exist.|float|count|
|`go_info`|Information about the Go environment.|float|count|
|`go_memstats_alloc_bytes`|Number of bytes allocated and still in use.|float|count|
|`go_memstats_alloc_bytes_total`|Total number of bytes allocated, even if freed.|float|count|
|`go_memstats_buck_hash_sys_bytes`|Number of bytes used by the profiling bucket hash table.|float|count|
|`go_memstats_frees_total`|Total number of frees.|float|count|
|`go_memstats_gc_cpu_fraction`|The fraction of this program's available CPU time used by the GC since the program started.|float|count|
|`go_memstats_gc_sys_bytes`|Number of bytes used for garbage collection system metadata.|float|count|
|`go_memstats_heap_alloc_bytes`|Number of heap bytes allocated and still in use.|float|count|
|`go_memstats_heap_idle_bytes`|Number of heap bytes waiting to be used.|float|count|
|`go_memstats_heap_inuse_bytes`|Number of heap bytes that are in use.|float|count|
|`go_memstats_heap_objects`|Number of allocated objects.|float|count|
|`go_memstats_heap_released_bytes`|Number of heap bytes released to OS.|float|count|
|`go_memstats_heap_sys_bytes`|Number of heap bytes obtained from system.|float|count|
|`go_memstats_last_gc_time_seconds`|Number of seconds since 1970 of last garbage collection.|float|count|
|`go_memstats_lookups_total`|Total number of pointer lookups.|float|count|
|`go_memstats_mallocs_total`|Total number of mallocs.|float|count|
|`go_memstats_mcache_inuse_bytes`|Number of bytes in use by mcache structures.|float|count|
|`go_memstats_mcache_sys_bytes`|Number of bytes used for mcache structures obtained from system.|float|count|
|`go_memstats_mspan_inuse_bytes`|Number of bytes in use by mspan structures.|float|count|
|`go_memstats_mspan_sys_bytes`|Number of bytes used for mspan structures obtained from system.|float|count|
|`go_memstats_next_gc_bytes`|Number of heap bytes when next garbage collection will take place.|float|count|
|`go_memstats_other_sys_bytes`|Number of bytes used for other system allocations.|float|count|
|`go_memstats_stack_inuse_bytes`|Number of bytes in use by the stack allocator.|float|count|
|`go_memstats_stack_sys_bytes`|Number of bytes obtained from system for stack allocator.|float|count|
|`go_memstats_sys_bytes`|Number of bytes obtained from system.|float|count|
|`go_threads`|Number of OS threads created.|float|count|
|`grpc_server_handled_total`|Total number of RPCs completed on the server, regardless of success or failure.|float|count|
|`grpc_server_msg_received_total`|Total number of RPC stream messages received on the server.|float|count|
|`grpc_server_msg_sent_total`|Total number of gRPC stream messages sent by the server.|float|count|
|`grpc_server_started_total`|Total number of RPCs started on the server.|float|count|
|`os_fd_limit`|The file descriptor limit.|float|count|
|`os_fd_used`|The number of used file descriptors.|float|count|
|`process_cpu_seconds_total`|Total user and system CPU time spent in seconds|float|count|
|`process_max_fds`|Maximum number of open file descriptors|float|count|
|`process_open_fds`|Number of open file descriptors|float|count|
|`process_resident_memory_bytes`|Resident memory size in bytes|float|count|
|`process_start_time_seconds`|Start time of the process since unix epoch in seconds|float|count|
|`process_virtual_memory_bytes`|Virtual memory size in bytes|float|count|
|`process_virtual_memory_max_bytes`|Maximum amount of virtual memory available in bytes|float|count|
|`promhttp_metric_handler_requests_in_flight`|Current number of scrapes being served.|float|count|
|`promhttp_metric_handler_requests_total`|Total number of scrapes by HTTP status code.|float|count|


