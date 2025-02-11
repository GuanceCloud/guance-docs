---
title     : 'CouchDB'
summary   : 'Collect metrics data from CouchDB'
tags:
  - 'database'
__int_icon      : 'icon/couchdb'
dashboard :
  - desc  : 'CouchDB'
    path  : 'dashboard/en/couchdb'
monitor   :
  - desc  : 'CouchDB'
    path  : 'monitor/en/couchdb'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The CouchDB collector is used to collect metrics data related to CouchDB, currently only supporting Prometheus formatted data.

Tested versions:

- [x] CouchDB 3.3.2
- [x] CouchDB 3.2
- [ ] CouchDB 3.1 and below versions are not supported

## Configuration {#config}

### Prerequisites {#requirements}

- Install the CouchDB service
  
  Refer to the [official installation documentation](https://docs.couchdb.org/en/stable/install/index.html){:target="_blank"}

- Verify the installation

  Access `<ip>:5984/_utils/` in your browser to enter the CouchDB management interface.

- Enable the CouchDB Prometheus port
  
  Locate and edit the CouchDB startup configuration file, usually found at `/opt/couchdb/etc/local.ini`

  ```ini
  [prometheus]
  additional_port = false
  bind_address = 127.0.0.1
  port = 17986
  ```

  Change to

  ```ini
  [prometheus]
  additional_port = true
  bind_address = 0.0.0.0
  port = 17986
  ```

  Refer to the [official configuration documentation](https://docs.couchdb.org/en/stable/config/misc.html#configuration-of-prometheus-endpoint){:target="_blank"}
  
- Restart the CouchDB service

<!-- markdownlint-disable MD046 -->
???+ tip

    - The ports `5984` and `17986` are required for data collection; these ports need to be open on the server being monitored for remote collection.
    - If collecting locally, there is no need to modify `bind_address = 127.0.0.1`.
<!-- markdownlint-enable -->

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/couchdb` directory under the DataKit installation directory, copy `couchdb.conf.sample` and rename it to `couchdb.conf`. An example is as follows:
    
    ```toml
        
    [[inputs.prom]]
      ## Collector alias.
      source = "couchdb"
    
      ## Exporter URLs.
      urls = ["http://127.0.0.1:17986/_node/_local/_prometheus"]
    
      ## TLS configuration.
      tls_open = false
      # tls_ca = "/tmp/ca.crt"
      # tls_cert = "/tmp/peer.crt"
      # tls_key = "/tmp/peer.key"
    
      ## Set to 'true' to enable election.
      election = true
    
      ## Customize tags.
      [inputs.prom.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
      
      ## (Optional) Collect interval: (defaults to "30s").
      # interval = "30s"
    
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).

<!-- markdownlint-enable -->

## Metrics {#metric}



### `couchdb`

- Tags


| Tag | Description |
|  ----  | --------|
|`code`|HTTP response codes, such as 200, 201, 202, 204, 206, 301, 304, 400, 403, 404, 405, 406, 409, 412, 414, 415, 416, 417, 500, 501, 503.|
|`host`|Host name.|
|`instance`|Instance endpoint.|
|`level`|Log level, including `alert`, `critical`, `debug`, `emergency`, `error`, `info`, `notice`, `warning`.|
|`memory_type`|Erlang memory type, including `total`, `processes`, `processes_used`, `system`, `atom`, `atom_used`, `binary`, `code`, `ets`|
|`method`|HTTP request methods, including `COPY`, `DELETE`, `GET`, `HEAD`, `OPTIONS`, `POST`, `PUT`.|
|`quantile`|Histogram `quantile`.|
|`stage`|`Rexi` stream stage, like `init_stream`.|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`auth_cache_hits_total`|Number of authentication cache hits.|float|count|
|`auth_cache_misses_total`|Number of authentication cache misses.|float|count|
|`auth_cache_requests_total`|Number of authentication cache requests.|float|count|
|`coalesced_updates_interactive`|Number of coalesced interactive updates.|float|count|
|`coalesced_updates_replicated`|Number of coalesced replicated updates.|float|count|
|`collect_results_time_seconds`|Microsecond latency for calls to couch_db:collect_results.|float|ms|
|`commits_total`|Number of commits performed.|float|count|
|`couch_log_requests_total`|Number of logged `level` messages. `level` includes `alert`, `critical`, `debug`, `emergency`, `error`, `info`, `notice`, `warning`.|float|count|
|`couch_replicator_changes_manager_deaths_total`|Number of failed replicator changes managers.|float|count|
|`couch_replicator_changes_queue_deaths_total`|Number of failed replicator changes work queues.|float|count|
|`couch_replicator_changes_read_failures_total`|Number of failed replicator changes read failures.|float|count|
|`couch_replicator_changes_reader_deaths_total`|Number of failed replicator changes readers.|float|count|
|`couch_replicator_checkpoints_failure_total`|Number of failed checkpoint saves.|float|count|
|`couch_replicator_checkpoints_total`|Number of checkpoints successfully saved.|float|count|
|`couch_replicator_cluster_is_stable`|1 if cluster is stable, 0 if unstable.|float|count|
|`couch_replicator_connection_acquires_total`|Number of times connections are shared.|float|count|
|`couch_replicator_connection_closes_total`|Number of times a worker is gracefully shut down.|float|count|
|`couch_replicator_connection_creates_total`|Number of connections created.|float|count|
|`couch_replicator_connection_owner_crashes_total`|Number of times a connection owner crashes while owning at least one connection.|float|count|
|`couch_replicator_connection_releases_total`|Number of times ownership of a connection is released.|float|count|
|`couch_replicator_connection_worker_crashes_total`|Number of times a worker unexpectedly terminates.|float|count|
|`couch_replicator_db_scans_total`|Number of times replicator db scans have been started.|float|count|
|`couch_replicator_docs_completed_state_updates_total`|Number of `completed` state document updates.|float|count|
|`couch_replicator_docs_db_changes_total`|Number of db changes processed by replicator doc processor.|float|count|
|`couch_replicator_docs_dbs_created_total`|Number of db shard creations seen by replicator doc processor.|float|count|
|`couch_replicator_docs_dbs_deleted_total`|Number of db shard deletions seen by replicator doc processor.|float|count|
|`couch_replicator_docs_dbs_found_total`|Number of db shard found by replicator doc processor.|float|count|
|`couch_replicator_docs_failed_state_updates_total`|Number of `failed` state document updates.|float|count|
|`couch_replicator_failed_starts_total`|Number of replications that have failed to start.|float|count|
|`couch_replicator_jobs_adds_total`|Number of jobs added to replicator scheduler.|float|count|
|`couch_replicator_jobs_crashed`|Replicator scheduler crashed jobs.|float|count|
|`couch_replicator_jobs_crashes_total`|Number of job crashes noticed by replicator scheduler.|float|count|
|`couch_replicator_jobs_duplicate_adds_total`|Number of duplicate jobs added to replicator scheduler.|float|count|
|`couch_replicator_jobs_pending`|Replicator scheduler pending jobs.|float|count|
|`couch_replicator_jobs_removes_total`|Number of jobs removed from replicator scheduler.|float|count|
|`couch_replicator_jobs_running`|Replicator scheduler running jobs.|float|count|
|`couch_replicator_jobs_starts_total`|Number of jobs started by replicator scheduler.|float|count|
|`couch_replicator_jobs_stops_total`|Number of jobs stopped by replicator scheduler.|float|count|
|`couch_replicator_jobs_total`|Total number of replicator scheduler jobs.|float|count|
|`couch_replicator_requests_total`|Number of HTTP requests made by the replicator.|float|count|
|`couch_replicator_responses_failure_total`|Number of failed HTTP responses received by the replicator.|float|count|
|`couch_replicator_responses_total`|Number of successful HTTP responses received by the replicator.|float|count|
|`couch_replicator_stream_responses_failure_total`|Number of failed streaming HTTP responses received by the replicator.|float|count|
|`couch_replicator_stream_responses_total`|Number of successful streaming HTTP responses received by the replicator.|float|count|
|`couch_replicator_worker_deaths_total`|Number of failed replicator workers.|float|count|
|`couch_replicator_workers_started_total`|Number of replicator workers started.|float|count|
|`couch_server_lru_skip_total`|Number of couch_server LRU operations skipped.|float|count|
|`database_purges_total`|Number of times a database was purged.|float|count|
|`database_reads_total`|Number of times a document was read from a database.|float|count|
|`database_writes_total`|Number of times a database was changed.|float|count|
|`db_open_time_seconds`|Milliseconds required to open a database.|float|ms|
|`dbinfo_seconds`|Milliseconds required to retrieve DB info.|float|ms|
|`ddoc_cache_hit_total`|Number of design doc cache hits.|float|count|
|`ddoc_cache_miss_total`|Number of design doc cache misses.|float|count|
|`ddoc_cache_recovery_total`|Number of design doc cache recoveries.|float|count|
|`ddoc_cache_requests_failures_total`|Number of design doc cache request failures.|float|count|
|`ddoc_cache_requests_recovery_total`|Number of design doc cache request recoveries.|float|count|
|`ddoc_cache_requests_total`|Number of design doc cache requests.|float|count|
|`document_inserts_total`|Number of documents inserted.|float|count|
|`document_purges_failure_total`|Number of failed document purge operations.|float|count|
|`document_purges_success_total`|Number of successful document purge operations.|float|count|
|`document_purges_total_total`|Number of total document purge operations.|float|count|
|`document_writes_total`|Number of document write operations.|float|count|
|`dreyfus_httpd_search_seconds`|Distribution of overall search request latency as experienced by the end user.|float|ms|
|`dreyfus_index_await_seconds`|Length of an dreyfus_index await request.|float|ms|
|`dreyfus_index_group1_seconds`|Length of an dreyfus_index group1 request.|float|ms|
|`dreyfus_index_group2_seconds`|Length of an dreyfus_index group2 request.|float|ms|
|`dreyfus_index_info_seconds`|Length of an dreyfus_index info request.|float|ms|
|`dreyfus_index_search_seconds`|Length of an dreyfus_index search request.|float|ms|
|`dreyfus_rpc_group1_seconds`|Length of a group1 RPC worker.|float|ms|
|`dreyfus_rpc_group2_seconds`|Length of a group2 RPC worker.|float|ms|
|`dreyfus_rpc_info_seconds`|Length of an info RPC worker.|float|ms|
|`dreyfus_rpc_search_seconds`|Length of a search RPC worker.|float|ms|
|`erlang_context_switches_total`|Total number of context switches.|float|count|
|`erlang_dirty_cpu_scheduler_queues`|The total size of all dirty CPU scheduler run queues.|float|count|
|`erlang_distribution_recv_avg_bytes`|Average size of packets, in bytes, received by the socket.|float|B|
|`erlang_distribution_recv_cnt_packets_total`|Number of packets received by the socket.|float|count|
|`erlang_distribution_recv_dvi_bytes`|Average packet size deviation, in bytes, received by the socket.|float|B|
|`erlang_distribution_recv_max_bytes`|Size of the largest packet, in bytes, received by the socket.|float|B|
|`erlang_distribution_recv_oct_bytes_total`|Number of bytes received by the socket.|float|B|
|`erlang_distribution_send_avg_bytes`|Average size of packets, in bytes, sent by the socket.|float|B|
|`erlang_distribution_send_cnt_packets_total`|Number of packets sent by the socket.|float|count|
|`erlang_distribution_send_max_bytes`|Size of the largest packet, in bytes, sent by the socket.|float|B|
|`erlang_distribution_send_oct_bytes_total`|Number of bytes sent by the socket.|float|B|
|`erlang_distribution_send_pend_bytes`|Number of bytes waiting to be sent by the socket.|float|B|
|`erlang_ets_table`|Number of ETS tables.|float|count|
|`erlang_gc_collections_total`|Number of garbage collections by the Erlang emulator.|float|count|
|`erlang_gc_words_reclaimed_total`|Number of words reclaimed by garbage collections.|float|count|
|`erlang_io_recv_bytes_total`|The total number of bytes received through ports.|float|B|
|`erlang_io_sent_bytes_total`|The total number of bytes output to ports.|float|B|
|`erlang_memory_bytes`|Size of memory (in bytes) dynamically allocated by the Erlang emulator.|float|B|
|`erlang_message_queue_max`|Maximum size across all message queues.|float|count|
|`erlang_message_queue_min`|Minimum size across all message queues.|float|count|
|`erlang_message_queue_size`|Size of message queue.|float|count|
|`erlang_message_queues`|Total size of all message queues.|float|count|
|`erlang_process_limit`|The maximum number of simultaneously existing Erlang processes.|float|count|
|`erlang_processes`|The number of Erlang processes.|float|count|
|`erlang_reductions_total`|Total number of reductions.|float|count|
|`erlang_scheduler_queues`|The total size of all normal run queues.|float|count|
|`fabric_doc_update_errors_total`|Number of document update errors.|float|count|
|`fabric_doc_update_mismatched_errors_total`|Number of document update errors with multiple error types.|float|count|
|`fabric_doc_update_write_quorum_errors_total`|Number of write quorum errors.|float|count|
|`fabric_open_shard_timeouts_total`|Number of open shard timeouts.|float|count|
|`fabric_read_repairs_failures_total`|Number of failed read repair operations.|float|count|
|`fabric_read_repairs_total`|Number of successful read repair operations.|float|count|
|`fabric_worker_timeouts_total`|Number of worker timeouts.|float|count|
|`fsync_count_total`|Number of fsync calls.|float|count|
|`fsync_time`|Microseconds to call fsync.|float|ms|
|`global_changes_db_writes_total`|Number of db writes performed by global changes.|float|count|
|`global_changes_event_doc_conflict_total`|Number of conflicted event docs encountered by global changes.|float|count|
|`global_changes_listener_pending_updates`|Number of global changes updates pending writes in global_changes_listener.|float|count|
|`global_changes_rpcs_total`|Number of rpc operations performed by global_changes.|float|count|
|`global_changes_server_pending_updates`|Number of global changes updates pending writes in global_changes_server.|float|count|
|`httpd_aborted_requests_total`|Number of aborted requests.|float|count|
|`httpd_all_docs_timeouts_total`|Number of HTTP all_docs timeouts.|float|count|
|`httpd_bulk_docs_seconds`|Distribution of the number of docs in _bulk_docs requests.|float|ms|
|`httpd_bulk_requests_total`|Number of bulk requests.|float|count|
|`httpd_clients_requesting_changes_total`|Number of clients for continuous _changes.|float|count|
|`httpd_dbinfo`|Distribution of latencies for calls to retrieve DB info.|float|ms|
|`httpd_explain_timeouts_total`|Number of HTTP _explain timeouts.|float|count|
|`httpd_find_timeouts_total`|Number of HTTP find timeouts.|float|count|
|`httpd_partition_all_docs_requests_total`|Number of partition HTTP _all_docs requests.|float|count|
|`httpd_partition_all_docs_timeouts_total`|Number of partition HTTP all_docs timeouts.|float|count|
|`httpd_partition_explain_requests_total`|Number of partition HTTP _explain requests.|float|count|
|`httpd_partition_explain_timeouts_total`|Number of partition HTTP _explain timeouts.|float|count|
|`httpd_partition_find_requests_total`|Number of partition HTTP _find requests.|float|count|
|`httpd_partition_find_timeouts_total`|Number of partition HTTP find timeouts.|float|count|
|`httpd_partition_view_requests_total`|Number of partition HTTP view requests.|float|count|
|`httpd_partition_view_timeouts_total`|Number of partition HTTP view timeouts.|float|count|
|`httpd_purge_requests_total`|Number of purge requests.|float|count|
|`httpd_request_methods`|Number of HTTP `option` requests. `option` includes `COPY`, `DELETE`, `GET`, `HEAD`, `OPTIONS`, `POST`, `PUT`.|float|count|
|`httpd_requests_total`|Number of HTTP requests.|float|count|
|`httpd_status_codes`|Number of HTTP `status_codes` responses. `status_codes` includes 200, 201, 202, 204, 206, 301, 304, 400, 403, 404, 405, 406, 409, 412, 414, 415, 416, 417, 500, 501, 503.|float|count|
|`httpd_temporary_view_reads_total`|Number of temporary view reads.|float|count|
|`httpd_view_reads_total`|Number of view reads.|float|count|
|`httpd_view_timeouts_total`|Number of HTTP view timeouts.|float|count|
|`io_queue2_search_count_total`|Search IO directly triggered by client requests.|float|count|
|`io_queue_search_total`|Search IO directly triggered by client requests.|float|count|
|`legacy_checksums`|Number of legacy checksums found in couch_file instances.|float|count|
|`local_document_writes_total`|Number of document write operations.|float|count|
|`mango_docs_examined_total`|Number of documents examined by mango queries coordinated by this node.|float|count|
|`mango_evaluate_selector_total`|Number of mango selector evaluations.|float|count|
|`mango_keys_examined_total`|Number of keys examined by mango queries coordinated by this node.|float|count|
|`mango_query_invalid_index_total`|Number of mango queries that generated an invalid index warning.|float|count|
|`mango_query_time_seconds`|Length of time processing a mango query.|float|ms|
|`mango_quorum_docs_examined_total`|Number of documents examined by mango queries, using cluster quorum.|float|count|
|`mango_results_returned_total`|Number of rows returned by mango queries.|float|count|
|`mango_too_many_docs_scanned_total`|Number of mango queries that generated an index scan warning.|float|count|
|`mango_unindexed_queries_total`|Number of mango queries that could not use an index.|float|count|
|`mem3_shard_cache_eviction_total`|Number of shard cache evictions.|float|count|
|`mem3_shard_cache_hit_total`|Number of shard cache hits.|float|count|
|`mem3_shard_cache_miss_total`|Number of shard cache misses.|float|count|
|`mrview_emits_total`|Number of invocations of `emit` in map functions in the view server.|float|count|
|`mrview_map_doc_total`|Number of documents mapped in the view server.|float|count|
|`nouveau_active_searches_total`|Number of active search requests.|float|count|
|`nouveau_search_latency`|Distribution of overall search request latency as experienced by the end user.|float|ms|
|`open_databases_total`|Number of open databases.|float|count|
|`open_os_files_total`|Number of file descriptors CouchDB has open.|float|count|
|`pread_exceed_eof_total`|Number of attempts to read beyond the end of the db file.|float|count|
|`pread_exceed_limit_total`|Number of attempts to read beyond the set limit.|float|count|
|`query_server_acquired_processes_total`|Number of acquired external processes.|float|count|
|`query_server_process_errors_total`|Number of OS error process exits.|float|count|
|`query_server_process_exists_total`|Number of OS normal process exits.|float|count|
|`query_server_process_prompt_errors_total`|Number of OS process prompt errors.|float|count|
|`query_server_process_prompts_total`|Number of successful OS process prompts.|float|count|
|`query_server_process_starts_total`|Number of OS process starts.|float|count|
|`query_server_vdu_process_time_seconds`|Duration of validate_doc_update function calls.|float|ms|
|`query_server_vdu_rejects_total`|Number of rejections by validate_doc_update function.|float|count|
|`request_time_seconds`|Length of a request inside CouchDB without `MochiWeb`.|float|s|
|`rexi_buffered_total`|Number of `rexi` messages buffered.|float|count|
|`rexi_down_total`|Number of `rexi_DOWN` messages handled.|float|count|
|`rexi_dropped_total`|Number of `rexi` messages dropped from buffers.|float|count|
|`rexi_streams_timeout_stream_total`|Number of `rexi` stream timeouts.|float|count|
|`rexi_streams_timeout_total`|Number of `rexi` stream initialization timeouts.|float|count|
|`rexi_streams_timeout_wait_for_ack_total`|Number of `rexi` stream timeouts while waiting for `acks`.|float|count|
|`uptime_seconds`|CouchDB uptime.|float|s|


</input_content>
</example>
```