---
title: 'CockroachDB'
summary: 'Collect metrics data from CockroachDB'
__int_icon: 'icon/cockroachdb'
tags:
  - 'database'
dashboard:
  - desc: 'CockroachDB'
    path: 'dashboard/en/cockroachdb'
monitor:
  - desc: 'CockroachDB'
    path: 'monitor/en/cockroachdb'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The CockroachDB collector is used to collect metrics data related to CockroachDB, currently supporting only Prometheus format.

Tested versions:

- [x] CockroachDB 19.2
- [x] CockroachDB 20.2
- [x] CockroachDB 21.2
- [x] CockroachDB 22.2
- [x] CockroachDB 23.2.4

## Configuration {#config}

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Enter the `conf.d/db` directory under the DataKit installation directory, copy `cockroachdb.conf.sample` and rename it to `cockroachdb.conf`. Example configuration:
    
    ```toml
        
    [[inputs.prom]]
      ## Collector alias.
      source = "cockroachdb"
    
      ## Exporter URLs.
      urls = ["http://localhost:8080/_status/vars"]
    
      ## (Optional) Collect interval: (defaults to "30s").
      # interval = "30s"
    
      ## (Optional) Timeout: (defaults to "30s").
      # timeout = "30s"
    
      ## Stream Size. 
      ## The source stream segmentation size, (defaults to 1).
      ## 0 means the source stream is undivided. 
      stream_size = 0
    
      ## Unix Domain Socket URL. Using socket to request data when not empty.
      # uds_path = ""
    
      ## Ignore URL request errors.
      # ignore_req_err = false
    
      ## Collect data output.
      ## Fill this when you want to collect the data to a local file or center.
      ## After filling, you can use 'datakit debug --prom-conf /path/to/this/conf' to debug local storage measurement set.
      ## Use '--prom-conf' when prioritizing debugging data in the 'output' path.
      # output = "/abs/path/to/file"
    
      ## Collect data upper limit as bytes.
      ## Only available when setting output to a local file.
      ## If collected data exceeds the limit, the data will be dropped.
      ## Default is 32MB.
      # max_file_size = 0
    
      ## Metrics type whitelist. Optional: counter, gauge, histogram, summary
      ## Example: metric_types = ["counter", "gauge"], only collect 'counter' and 'gauge'.
      ## Default collects all.
      # metric_types = []
    
      ## Metrics name whitelist.
      ## Regex supported. Multiple supported, conditions met when one matches.
      ## Collect all if empty.
      # metric_name_filter = ["cpu"]
    
      ## Metrics name blacklist.
      ## If a word is both in the blacklist and whitelist, blacklist has priority.
      ## Regex supported. Multiple supported, conditions met when one matches.
      ## Collect all if empty.
      # metric_name_filter_ignore = ["foo","bar"]
    
      ## Measurement prefix.
      ## Add prefix to measurement set name.
      measurement_prefix = ""
    
      ## Measurement name.
      ## If measurement_name is empty, split the metric name by '_', the first field after split becomes the measurement set name, the rest become the current metric name.
      ## If measurement_name is not empty, use this as the measurement set name.
      ## Always add 'measurement_prefix' prefix at last.
      measurement_name = "cockroachdb"
    
      ## TLS configuration.
      # tls_open = false
      # tls_ca = "/tmp/ca.crt"
      # tls_cert = "/tmp/peer.crt"
      # tls_key = "/tmp/peer.key"
    
      ## Set to 'true' to enable election.
      election = true
    
      ## Disable setting host tag for this input.
      disable_host_tag = false
    
      ## Disable setting instance tag for this input.
      disable_instance_tag = false
    
      ## Disable info tag for this input.
      disable_info_tag = false
    
      ## Ignore tags. Multiple supported.
      ## The matched tags will be dropped, but the item will still be sent.
      # tags_ignore = ["xxxx"]
    
      ## Customize authentication. Currently supports Bearer Token only.
      ## Filling in 'token' or 'token_file' is acceptable.
      # [inputs.prom.auth]
        # type = "bearer_token"
        # token = "xxxxxxxx"
        # token_file = "/tmp/token"
    
      ## Customize measurement set name.
      ## Treat those metrics with prefix as one set.
      ## Prioritizes over 'measurement_name' configuration.
      # [[inputs.prom.measurements]]
        # prefix = "sql_"
        # name = "cockroachdb_sql"
      
      # [[inputs.prom.measurements]]
        # prefix = "txn_"
        # name = "cockroachdb_txn"
    
      ## Not collecting those data when tag matches.
      # [inputs.prom.ignore_tag_kv_match]
        # key1 = [ "val1.*", "val2.*"]
        # key2 = [ "val1.*", "val2.*"]
    
      ## Add HTTP headers to data pulling (Example basic authentication).
      # [inputs.prom.http_headers]
        # Authorization = "Basic bXl0b21jYXQ="
    
      ## Rename tag keys in prom data.
      [inputs.prom.tags_rename]
        overwrite_exist_tags = false
    
      # [inputs.prom.tags_rename.mapping]
        # tag1 = "new-name-1"
        # tag2 = "new-name-2"
    
      ## Send collected metrics to center as logs.
      ## When 'service' field is empty, use 'service tag' as measurement set name.
      [inputs.prom.as_logging]
        enable = false
        service = "service_name"
    
      ## Customize tags.
      # [inputs.prom.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can inject the collector configuration via [ConfigMap method](../datakit/datakit-daemonset-deploy.md#configmap-setting) or configure ENV_DATAKIT_INPUTS to enable the collector.

<!-- markdownlint-enable -->

## Metrics {#metric}



### `cockroachdb`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Host name.|
|`instance`|Instance endpoint.|
|`le`|Histogram quantile.|
|`node_id`|Node ID.|
|`store`|Store ID.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`abortspanbytes`|Number of bytes in the abort span.|float|B|
|`addsstable_applications`|[OpenMetrics v1] Number of SSTable ingestion applied (i.e., applied by Replicas).|float|count|
|`addsstable_applications_count`|[OpenMetrics v2] Number of SSTable ingestion applied (i.e., applied by Replicas).|float|count|
|`addsstable_copies`|[OpenMetrics v1] Number of SSTable ingestion that required copying files during application.|float|count|
|`addsstable_copies_count`|[OpenMetrics v2] Number of SSTable ingestion that required copying files during application.|float|count|
|`addsstable_delay_count`|Amount by which evaluation of AddSSTable requests was delayed.|float|ns|
|`addsstable_delay_enginebackpressure`|Amount by which evaluation of AddSSTable requests was delayed by storage-engine back pressure.|float|ns|
|`addsstable_proposals`|[OpenMetrics v1] Number of SSTable ingestion proposed (i.e., sent to Raft by lease holders).|float|count|
|`addsstable_proposals_count`|[OpenMetrics v2] Number of SSTable ingestion proposed (i.e., sent to Raft by lease holders).|float|count|
|`admission_admitted_elastic_cpu`|Number of requests admitted.|float|count|
|`admission_admitted_elastic_cpu_bulk_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_elastic_cpu_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_kv`|[OpenMetrics v1] Number of KV requests admitted.|float|count|
|`admission_admitted_kv_bulk_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_kv_count`|[OpenMetrics v2] Number of KV requests admitted.|float|count|
|`admission_admitted_kv_high_pri`|Number of requests admitted.|float|count|
|`admission_admitted_kv_locking_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_kv_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_kv_stores`|[OpenMetrics v1] Number of KV stores requests admitted.|float|count|
|`admission_admitted_kv_stores_bulk_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_kv_stores_count`|[OpenMetrics v2] Number of KV stores requests admitted.|float|count|
|`admission_admitted_kv_stores_high_pri`|Number of requests admitted.|float|count|
|`admission_admitted_kv_stores_locking_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_kv_stores_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_kv_stores_ttl_low_pri`|Number of requests admitted.|float|count|
|`admission_admitted_sql_kv_response`|[OpenMetrics v1] Number of SQL KV response requests admitted.|float|count|
|`admission_admitted_sql_kv_response_count`|[OpenMetrics v2] Number of SQL KV response requests admitted.|float|count|
|`admission_admitted_sql_kv_response_locking_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_sql_kv_response_locking_pri`||float|count|
|`admission_admitted_sql_kv_response_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_sql_leaf_start`|[OpenMetrics v1] Number of SQL leaf start requests admitted.|float|count|
|`admission_admitted_sql_leaf_start_count`|[OpenMetrics v2] Number of SQL leaf start requests admitted.|float|count|
|`admission_admitted_sql_leaf_start_locking_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_sql_leaf_start_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_sql_root_start`|[OpenMetrics v1] Number of SQL root start requests admitted.|float|count|
|`admission_admitted_sql_root_start_count`|[OpenMetrics v2] Number of SQL root start requests admitted.|float|count|
|`admission_admitted_sql_root_start_locking_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_sql_root_start_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_sql_sql_response`|[OpenMetrics v1] Number of Distributed SQL response requests admitted.|float|count|
|`admission_admitted_sql_sql_response_count`|[OpenMetrics v2] Number of Distributed SQL response requests admitted.|float|count|
|`admission_admitted_sql_sql_response_locking_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_sql_sql_response_normal_pri`|Number of requests admitted.|float|count|
|`admission_elastic_cpu_acquired_nanos`|Total CPU nanoseconds acquired by elastic work.|float|ns|
|`admission_elastic_cpu_available_nanos`|Instantaneous available CPU nanoseconds per second ignoring utilization limit.|float|ns|
|`admission_elastic_cpu_max_available_nanos`|Maximum available CPU nanoseconds per second ignoring utilization limit.|float|ns|
|`admission_elastic_cpu_nanos_exhausted_duration`|Total duration when elastic CPU nanoseconds were exhausted, in microseconds.|float|count|
|`admission_elastic_cpu_over_limit_durations_bucket`|Measurement of how much over the prescribed limit elastic requests ran (not recorded if requests don't run over).|float|ns|
|`admission_elastic_cpu_over_limit_durations_count`|Measurement of how much over the prescribed limit elastic requests ran (not recorded if requests don't run over).|float|ns|
|`admission_elastic_cpu_over_limit_durations_sum`|Measurement of how much over the prescribed limit elastic requests ran (not recorded if requests don't run over).|float|ns|
|`admission_elastic_cpu_pre_work_nanos`|Total CPU nanoseconds spent doing pre-work, before doing elastic work.|float|ns|
|`admission_elastic_cpu_returned_nanos`|Total CPU nanoseconds returned by elastic work.|float|ns|
|`admission_elastic_cpu_utilization`|CPU utilization by elastic work.|float|percent|
|`admission_elastic_cpu_utilization_limit`|Utilization limit set for the elastic CPU work.|float|percent|
|`admission_errored_elastic_cpu`|Number of requests not admitted due to error.|float|count|
|`admission_errored_elastic_cpu_bulk_normal_pri`|Number of requests not admitted due to error.|float|count|
|`admission_errored_elastic_cpu_normal_pri`|Number of requests not admitted due to error.|float|count|
|`admission_errored_kv`|[OpenMetrics v1] Number of KV requests not admitted due to error.|float|count|
|`admission_errored_kv_bulk_normal_pri`|Number of requests admitted.|float|count|
|`admission_errored_kv_countt`|[OpenMetrics v2] Number of KV requests not admitted due to error.|float|count|
|`admission_errored_kv_high_pri`|Number of requests not admitted due to error.|float|count|
|`admission_errored_kv_locking_normal_pri`|Number of requests not admitted due to error.|float|count|
|`admission_errored_kv_normal_pri`|Number of requests not admitted due to error.|float|count|
|`admission_errored_kv_stores`|[OpenMetrics v1] Number of KV stores requests not admitted due to error.|float|count|
|`admission_errored_kv_stores_bulk_normal_pri`|Number of requests not admitted due to error.|float|count|
|`admission_errored_kv_stores_countt`|[OpenMetrics v2] Number of KV stores requests not admitted due to error.|float|count|
|`admission_errored_kv_stores_high_pri`|Number of requests not admitted due to error.|float|count|
|`admission_errored_kv_stores_locking_normal_pri`|Number of requests not admitted due to error.|float|count|
|`admission_errored_kv_stores_normal_pri`|Number of requests not admitted due to error.|float|count|
|`admission_errored_kv_stores_ttl_low_pri`|Number of requests not admitted due to error.|float|count|
|`admission_errored_sql_kv_response`|[OpenMetrics v1] Number of SQL KV requests not admitted due to error.|float|count|
|`admission_errored_sql_kv_response_count`|[OpenMetrics v2] Number of SQL KV requests not admitted due to error.|float|count|
|`admission_errored_sql_kv_response_locking_normal_pri`|Number of requests not admitted due to error.|float|count|
|`admission_errored_sql_kv_response_normal_pri`|Number of requests not admitted due to error.|float|count|
|`admission_errored_sql_leaf_start`|[OpenMetrics v1] Number of SQL leaf start requests not admitted due to error.|float|count|
|`admission_errored_sql_leaf_start_count`|[OpenMetrics v2] Number of SQL leaf start requests not admitted due to error.|float|count|
|`admission_errored_sql_leaf_start_locking_normal_pri`|Number of requests not admitted due to error.|float|count|
|`admission_errored_sql_leaf_start_normal_pri`|Number of requests not admitted due to error.|float|count|
|`admission_errored_sql_root_start`|[OpenMetrics v1] Number of SQL root start requests not admitted due to error.|float|count|
|`admission_errored_sql_root_start_count`|[OpenMetrics v2] Number of SQL root start requests not admitted due to error.|float|count|
|`admission_errored_sql_root_start_locking_normal_pri`|Number of requests not admitted due to error.|float|count|
|`admission_errored_sql_root_start_normal_pri`|Number of requests not admitted due to error.|float|count|
|`admission_errored_sql_sql_response`|[OpenMetrics v1] Number of Distributed SQL requests not admitted due to error.|float|count|
|`admission_errored_sql_sql_response_count`|[OpenMetrics v2] Number of Distributed SQL start requests not admitted due to error.|float|count|
|`admission_errored_sql_sql_response_locking_normal_pri`|Number of requests not admitted due to error.|float|count|
|`admission_errored_sql_sql_response_normal_pri`|Number of requests not admitted due to error.|float|count|
|`admission_granter_cpu_load_long_period_duration_kv`|Total duration when CPULoad was being called with a long period, in microseconds.|float|count|
|`admission_granter_cpu_load_short_period_duration_kv`|Total duration when CPULoad was being called with a short period, in microseconds.|float|count|
|`admission_granter_elastic_io_tokens_available_kv`|Number of tokens available.|float|count|
|`admission_granter_io_tokens_available_kv`|Number of tokens available.|float|count|
|`admission_granter_io_tokens_bypassed_kv`|Total number of tokens taken by work bypassing admission control (for example, follower writes without flow control).|float|count|
|`admission_granter_io_tokens_exhausted_duration_kv`|[OpenMetrics v1] Total duration when IO tokens were exhausted, in microseconds.|float|count|
|`admission_granter_io_tokens_exhausted_duration_kv_count`|[OpenMetrics v2] Total duration when IO tokens were exhausted, in microseconds.|float|count|
|`admission_granter_io_tokens_returned_kv`|Total number of tokens returned.|float|count|
|`admission_granter_io_tokens_taken_kv`|Total number of tokens taken.|float|count|
|`admission_granter_slot_adjuster_decrements_kv`|Number of decrements of the total KV slots.|float|count|
|`admission_granter_slot_adjuster_increments_kv`|Number of increments of the total KV slots.|float|count|
|`admission_granter_slots_exhausted_duration_kv`|Total duration when KV slots were exhausted, in microseconds.|float|count|
|`admission_granter_total_slots_kv`|[OpenMetrics v1 & v2] Total slots for KV work.|float|count|
|`admission_granter_used_slots_kv`|[OpenMetrics v1 & v2] Used slots for KV work.|float|count|
|`admission_granter_used_slots_sql_leaf_start`|[OpenMetrics v1 & v2] Used slots for SQL leaf start work.|float|count|
|`admission_granter_used_slots_sql_root_start`|[OpenMetrics v1 & v2] Used slots for SQL root start work.|float|count|
|`admission_io_overload`|1-normalized float indicating whether IO admission control considers the store as overloaded with respect to compaction out of L0 (considers sub-level and file counts).|float|count|
|`admission_l0_compacted_bytes_kv`|Total bytes compacted out of L0 (used to generate IO tokens).|float|count|
|`admission_l0_tokens_produced_kv`|Total number of generated tokens of L0.|float|count|
|`admission_raft_paused_replicas`|Number of followers (i.e., Replicas) to which replication is currently paused to help them recover from I/O overload.Such Replicas will be ignored for the purposes of proposal quota, and will not receive replication traffic. They are essentially treated as offline for the purpose of replication. This serves as a crude form of admission control.The count is emitted by the leaseholder of each range.|float|count|
|`admission_raft_paused_replicas_dropped_msgs`|Number of messages dropped instead of being sent to paused replicas.The messages are dropped to help these replicas to recover from I/O overload.|float|count|
|`admission_requested_elastic_cpu`|Number of requests.|float|count|
|`admission_requested_elastic_cpu_bulk_normal_pri`|Number of requests.|float|count|
|`admission_requested_elastic_cpu_normal_pri`|Number of requests.|float|count|
|`admission_requested_kv`|[OpenMetrics v1] Number of KV admission requests.|float|count|
|`admission_requested_kv_bulk_normal_pri`|Number of requests admitted.|float|count|
|`admission_requested_kv_count`|[OpenMetrics v2] Number of KV admission requests.|float|count|
|`admission_requested_kv_high_pri`|Number of requests.|float|count|
|`admission_requested_kv_locking_normal_pri`|Number of requests.|float|count|
|`admission_requested_kv_normal_pri`|Number of requests.|float|count|
|`admission_requested_kv_stores`|[OpenMetrics v2] Number of KV stores admission requests.|float|count|
|`admission_requested_kv_stores_bulk_normal_pri`|Number of requests.|float|count|
|`admission_requested_kv_stores_high_pri`|Number of requests.|float|count|
|`admission_requested_kv_stores_locking_normal_pri`|Number of requests.|float|count|
|`admission_requested_kv_stores_normal_pri`|Number of requests.|float|count|
|`admission_requested_kv_stores_ttl_low_pri`|Number of requests.|float|count|
|`admission_requested_sql_kv_response`|[OpenMetrics v1] Number of SQL KV admission requests.|float|count|
|`admission_requested_sql_kv_response_count`|[OpenMetrics v2] Number of SQL KV admission requests.|float|count|
|`admission_requested_sql_kv_response_locking_normal_pri`|Number of requests.|float|count|
|`admission_requested_sql_kv_response_normal_pri`|Number of requests.|float|count|
|`admission_requested_sql_leaf_start`|[OpenMetrics v1] Number of SQL leaf start admission requests.|float|count|
|`admission_requested_sql_leaf_start_count`|[OpenMetrics v2] Number of SQL leaf start admission requests.|float|count|
|`admission_requested_sql_leaf_start_locking_normal_pri`|Number of requests.|float|count|
|`admission_requested_sql_leaf_start_normal_pri`|Number of requests.|float|count|
|`admission_requested_sql_root_start`|Number of requests.|float|count|
|`admission_requested_sql_root_start_locking_normal_pri`|Number of requests.|float|count|
|`admission_requested_sql_root_start_normal_pri`|Number of requests.|float|count|
|`admission_requested_sql_sql_response`|[OpenMetrics v1] Number of Distributed SQL admission requests.|float|count|
|`admission_requested_sql_sql_response_count`|[OpenMetrics v2] Number of Distributed SQL admission requests.|float|count|
|`admission_requested_sql_sql_response_locking_normal_pri`|Number of requests.|float|count|
|`admission_requested_sql_sql_response_normal_pri`|Number of requests.|float|count|
|`admission_scheduler_latency_listener_p99_nanos`|The scheduling latency at p99 as observed by the scheduler latency listener.|float|ns|
|`admission_wait_durations_elastic_cpu_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_elastic_cpu_bulk_normal_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_elastic_cpu_bulk_normal_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_elastic_cpu_bulk_normal_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_elastic_cpu_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_elastic_cpu_normal_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_elastic_cpu_normal_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_elastic_cpu_normal_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_elastic_cpu_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv`|[OpenMetrics v1] Wait time durations for KV requests that waited.|float|ns|
|`admission_wait_durations_kv_bucket`|[OpenMetrics v2] Wait time durations for KV requests that waited.|float|ns|
|`admission_wait_durations_kv_bulk_normal_pri`|Number of requests admitted.|float|count|
|`admission_wait_durations_kv_count`|[OpenMetrics v2] Wait time durations for KV requests that waited.|float|ns|
|`admission_wait_durations_kv_high_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_high_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_high_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_locking_normal_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_locking_normal_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_locking_normal_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_normal_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_normal_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_normal_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores`|[OpenMetrics v1] Wait time durations for KV stores requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_bucket`|[OpenMetrics v2] Wait time durations for KV stores requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_bulk_normal_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_bulk_normal_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_bulk_normal_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_count`|[OpenMetrics v2] Wait time durations for KV stores requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_high_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_high_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_high_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_locking_normal_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_locking_normal_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_locking_normal_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_normal_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_normal_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_normal_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_sum`|[OpenMetrics v2] Wait time durations for KV stores requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_ttl_low_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_ttl_low_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_ttl_low_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_sum`|[OpenMetrics v2] Wait time durations for KV requests that waited.|float|ns|
|`admission_wait_durations_sql_kv_response`|[OpenMetrics v1] Wait time durations for SQL KV response requests that waited.|float|ns|
|`admission_wait_durations_sql_kv_response_bucket`|[OpenMetrics v2] Wait time durations for SQL KV response requests that waited.|float|ns|
|`admission_wait_durations_sql_kv_response_count`|[OpenMetrics v2] Wait time durations for SQL KV response requests that waited.|float|ns|
|`admission_wait_durations_sql_kv_response_locking_normal_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_kv_response_locking_normal_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_kv_response_locking_normal_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_kv_response_normal_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_kv_response_normal_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_kv_response_normal_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_kv_response_sum`|[OpenMetrics v2] Wait time durations for SQL KV response requests that waited.|float|ns|
|`admission_wait_durations_sql_leaf_start`|[OpenMetrics v1] Wait time durations for SQL leaf start requests that waited.|float|ns|
|`admission_wait_durations_sql_leaf_start_bucket`|[OpenMetrics v2] Wait time durations for SQL leaf start requests that waited.|float|ns|
|`admission_wait_durations_sql_leaf_start_count`|[OpenMetrics v2] Wait time durations for SQL leaf start requests that waited.|float|ns|
|`admission_wait_durations_sql_leaf_start_locking_normal_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_leaf_start_locking_normal_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_leaf_start_locking_normal_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_leaf_start_normal_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_leaf_start_normal_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_leaf_start_normal_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_leaf_start_sum`|[OpenMetrics v2] Wait time durations for SQL leaf start requests that waited.|float|ns|
|`admission_wait_durations_sql_root_start_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_root_start_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_root_start_locking_normal_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_root_start_locking_normal_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_root_start_locking_normal_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_root_start_normal_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_root_start_normal_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_root_start_normal_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_root_start_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_sql_response`|[OpenMetrics v1] Wait time durations for Distributed SQL requests that waited.|float|ns|
|`admission_wait_durations_sql_sql_response_bucket`|[OpenMetrics v2] Wait time durations for Distributed SQL requests that waited.|float|ns|
|`admission_wait_durations_sql_sql_response_count`|[OpenMetrics v2] Wait time durations for Distributed SQL requests that waited.|float|ns|
|`admission_wait_durations_sql_sql_response_locking_normal_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_sql_response_locking_normal_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_sql_response_locking_normal_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_sql_response_normal_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_sql_response_normal_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_sql_response_normal_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_sql_sql_response_sum`|[OpenMetrics v2] Wait time durations for Distributed SQL requests that waited.|float|ns|
|`admission_wait_queue_length_elastic_cpu`|Length of wait queue.|float|count|
|`admission_wait_queue_length_elastic_cpu_bulk_normal_pri`|Length of wait queue.|float|count|
|`admission_wait_queue_length_elastic_cpu_normal_pri`|Length of wait queue.|float|count|
|`admission_wait_queue_length_kv`|[OpenMetrics v1 & v2] Length of KV wait queue.|float|count|
|`admission_wait_queue_length_kv_bulk_normal_pri`|Number of requests admitted.|float|count|
|`admission_wait_queue_length_kv_high_pri`|Length of wait queue.|float|count|
|`admission_wait_queue_length_kv_locking_normal_pri`|Length of wait queue.|float|count|
|`admission_wait_queue_length_kv_normal_pri`|Length of wait queue.|float|count|
|`admission_wait_queue_length_kv_stores`|[OpenMetrics v1 & v2] Length of KV stores wait queue.|float|count|
|`admission_wait_queue_length_kv_stores_bulk_normal_pri`|Length of wait queue.|float|count|
|`admission_wait_queue_length_kv_stores_high_pri`|Length of wait queue.|float|count|
|`admission_wait_queue_length_kv_stores_locking_normal_pri`|Length of wait queue.|float|count|
|`admission_wait_queue_length_kv_stores_normal_pri`|Length of wait queue.|float|count|
|`admission_wait_queue_length_kv_stores_ttl_low_pri`|Length of wait queue.|float|count|
|`admission_wait_queue_length_sql_kv_response`|[OpenMetrics v1 & v2] Length of SQL KV wait queue.|float|count|
|`admission_wait_queue_length_sql_kv_response_locking_normal_pri`|Length of wait queue.|float|count|
|`admission_wait_queue_length_sql_kv_response_normal_pri`|Length of wait queue.|float|count|
|`admission_wait_queue_length_sql_leaf_start`|[OpenMetrics v1 & v2] Length of SQL leaf start wait queue.|float|count|
|`admission_wait_queue_length_sql_leaf_start_locking_normal_pri`|Length of wait queue.|float|count|
|`admission_wait_queue_length_sql_leaf_start_normal_pri`|Length of wait queue.|float|count|
|`admission_wait_queue_length_sql_root_start`|Length of wait queue.|float|count|
|`admission_wait_queue_length_sql_root_start_locking_normal_pri`|Length of wait queue.|float|count|
|`admission_wait_queue_length_sql_root_start_normal_pri`|Length of wait queue.|float|count|
|`admission_wait_queue_length_sql_sql_response`|[OpenMetrics v1 & v2] Length of Distributed SQL wait queue.|float