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

The CockroachDB collector is used to collect metrics data related to CockroachDB, currently only supporting Prometheus format.

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
      ## Use '--prom-conf' for debugging data in the 'output' path with higher priority.
      # output = "/abs/path/to/file"
    
      ## Collect data upper limit as bytes.
      ## Only available when setting output to a local file.
      ## If the collected data exceeds the limit, the data will be dropped.
      ## Default is 32MB.
      # max_file_size = 0
    
      ## Metrics type whitelist. Optional: counter, gauge, histogram, summary
      ## Example: metric_types = ["counter", "gauge"], only collect 'counter' and 'gauge'.
      ## Default collects all.
      # metric_types = []
    
      ## Metrics name whitelist.
      ## Regex supported. Multiple supported, conditions met when one matched.
      ## Collect all if empty.
      # metric_name_filter = ["cpu"]
    
      ## Metrics name blacklist.
      ## If a word is both in the blacklist and whitelist, the blacklist takes precedence.
      ## Regex supported. Multiple supported, conditions met when one matched.
      ## Collect all if empty.
      # metric_name_filter_ignore = ["foo","bar"]
    
      ## Measurement prefix.
      ## Add prefix to measurement set name.
      measurement_prefix = ""
    
      ## Measurement name.
      ## If measurement_name is empty, split the metric name by '_', the first field after splitting becomes the measurement set name, the rest become the current metric name.
      ## If measurement_name is not empty, use this as the measurement set name.
      ## Always add 'measurement_prefix' at the end.
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
      ## Treat those metrics with a prefix as one set.
      ## Takes precedence over 'measurement_name' configuration.
      # [[inputs.prom.measurements]]
        # prefix = "sql_"
        # name = "cockroachdb_sql"
      
      # [[inputs.prom.measurements]]
        # prefix = "txn_"
        # name = "cockroachdb_txn"
    
      ## Do not collect these data when the tag matches.
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
    
      ## Send collected metrics to center as log.
      ## When the 'service' field is empty, use 'service tag' as the measurement set name.
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
|`addsstable_applications`|[OpenMetrics v1] Number of SSTable ingestion applications (i.e., applied by Replicas).|float|count|
|`addsstable_applications_count`|[OpenMetrics v2] Number of SSTable ingestion applications (i.e., applied by Replicas).|float|count|
|`addsstable_copies`|[OpenMetrics v1] Number of SSTable ingestions that required copying files during application.|float|count|
|`addsstable_copies_count`|[OpenMetrics v2] Number of SSTable ingestions that required copying files during application.|float|count|
|`addsstable_delay_count`|Amount by which evaluation of AddSSTable requests was delayed.|float|ns|
|`addsstable_delay_enginebackpressure`|Amount by which evaluation of AddSSTable requests was delayed by storage-engine back pressure.|float|ns|
|`addsstable_proposals`|[OpenMetrics v1] Number of SSTable ingestion proposals (i.e., sent to Raft by lease holders).|float|count|
|`addsstable_proposals_count`|[OpenMetrics v2] Number of SSTable ingestion proposals (i.e., sent to Raft by lease holders).|float|count|
|`admission_admitted_elastic_cpu`|Number of requests admitted.|float|count|
|`admission_admitted_elastic_cpu_bulk_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_elastic_cpu_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_kv`|[OpenMetrics v1] Number of KV requests admitted.|float|count|
|`admission_admitted_kv_bulk_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_kv_count`|[OpenMetrics v2] Number of KV requests admitted.|float|count|
|`admission_admitted_kv_high_pri`|Number of requests admitted.|float|count|
|`admission_admitted_kv_locking_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_kv_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_kv_stores`|[OpenMetrics v1] Number of KV store requests admitted.|float|count|
|`admission_admitted_kv_stores_bulk_normal_pri`|Number of requests admitted.|float|count|
|`admission_admitted_kv_stores_count`|[OpenMetrics v2] Number of KV store requests admitted.|float|count|
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
|`admission_elastic_cpu_pre_work_nanos`|Total CPU nanoseconds spent doing pre-work before elastic work.|float|ns|
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
|`admission_errored_kv_stores`|[OpenMetrics v1] Number of KV store requests not admitted due to error.|float|count|
|`admission_errored_kv_stores_bulk_normal_pri`|Number of requests not admitted due to error.|float|count|
|`admission_errored_kv_stores_countt`|[OpenMetrics v2] Number of KV store requests not admitted due to error.|float|count|
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
|`admission_raft_paused_replicas`|Number of followers (i.e., Replicas) to which replication is currently paused to help them recover from I/O overload. Such Replicas are ignored for proposal quota and do not receive replication traffic. They are essentially treated as offline for replication purposes. This serves as a crude form of admission control. The count is emitted by the leaseholder of each range.|float|count|
|`admission_raft_paused_replicas_dropped_msgs`|Number of messages dropped instead of being sent to paused replicas. Messages are dropped to help these replicas recover from I/O overload.|float|count|
|`admission_requested_elastic_cpu`|Number of requests.|float|count|
|`admission_requested_elastic_cpu_bulk_normal_pri`|Number of requests.|float|count|
|`admission_requested_elastic_cpu_normal_pri`|Number of requests.|float|count|
|`admission_requested_kv`|[OpenMetrics v1] Number of KV admission requests.|float|count|
|`admission_requested_kv_bulk_normal_pri`|Number of requests admitted.|float|count|
|`admission_requested_kv_count`|[OpenMetrics v2] Number of KV admission requests.|float|count|
|`admission_requested_kv_high_pri`|Number of requests.|float|count|
|`admission_requested_kv_locking_normal_pri`|Number of requests.|float|count|
|`admission_requested_kv_normal_pri`|Number of requests.|float|count|
|`admission_requested_kv_stores`|[OpenMetrics v2] Number of KV store admission requests.|float|count|
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
|`admission_wait_durations_kv_stores`|[OpenMetrics v1] Wait time durations for KV store requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_bucket`|[OpenMetrics v2] Wait time durations for KV store requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_bulk_normal_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_bulk_normal_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_bulk_normal_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_count`|[OpenMetrics v2] Wait time durations for KV store requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_high_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_high_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_high_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_locking_normal_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_locking_normal_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_locking_normal_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_normal_pri_bucket`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_normal_pri_count`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_normal_pri_sum`|Wait time durations for requests that waited.|float|ns|
|`admission_wait_durations_kv_stores_sum`|[OpenMetrics v2] Wait time durations for KV store requests that waited.|float|ns|
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
|`admission_wait_queue_length_kv_stores`|[OpenMetrics v1 & v2] Length of KV store wait queue.|float|count|
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
|`admission_wait_queue_length_sql_sql_response`|[OpenMetrics v1 & v2] Length of Distributed SQL wait queue.|float|count|
|`admission_wait_queue_lengths_sql_root_start`|[OpenMetrics v1 & v2] Length of SQL root start wait queue.|float|count|
|`admission_wait_sum_kv`|[OpenMetrics v1] Total KV wait time in microseconds.|float|count|
|`admission_wait_sum_kv_count`|[OpenMetrics v2] Total KV wait time in microseconds.|float|count|
|`admission_wait_sum_kv_stores`|[OpenMetrics v1] Total KV store wait time in microseconds.|float|count|
|`admission_wait_sum_kv_stores_count`|[OpenMetrics v2] Total KV store wait time in microseconds.|float|count|
|`admission_wait_sum_sql_kv_response`|[OpenMetrics v1] Total SQL KV wait time in microseconds.|float|count|
|`admission_wait_sum_sql_kv_response_count`|[OpenMetrics v2] Total SQL KV wait time in microseconds.|float|count|
|`admission_wait_sum_sql_root_start`|[OpenMetrics v1] Total SQL root start wait time in microseconds.|float|count|
|`admission_wait_sum_sql_root_start_count`|[OpenMetrics v2] Total SQL root start wait time in microseconds.|float|count|
|`admission_wait_sum_sql_sql_response`|[OpenMetrics v1] Total Distributed SQL wait time in microseconds.|float|count|
|`admission_wait_sum_sql_sql_response_count`|[OpenMetrics v2] Total Distributed SQL wait time in microseconds.|float|count|
|`backup_last_failed_time_kms_inaccessible`|The Unix timestamp of the most recent failure of backup due to errKMSInaccessible by a backup specified as maintaining this metric.|float|count|
|`batch_requests_bytes`|Total byte count of batch requests processed.|float|B|
|`batch_requests_cross_region_bytes`|Total byte count of batch requests processed cross-region when region tiers are configured.|float|B|
|`batch_requests_cross_zone_bytes`|Total byte count of batch requests processed cross-zone within the same region when region and zone tiers are configured. However, if the region tiers are not configured, this count may also include batch data sent between different regions. Ensuring consistent configuration of region and zone tiers across nodes helps accurately monitor the transmitted data.|float|B|
|`batch_responses_bytes`|Total byte count of batch responses received.|float|B|
|`batch_responses_cross_region_bytes`|Total byte count of batch responses received cross-region when region tiers are configured.|float|B|
|`batch_responses_cross_zone_bytes`|Total byte count of batch responses received cross-zone within the same region when region and zone tiers are configured. However, if the region tiers are not configured, this count may also include batch data received between different regions. Ensuring consistent configuration of region and zone tiers across nodes helps accurately monitor the transmitted data.|float|B|
|`build_timestamp`|[OpenMetrics v1 & v2] Build information.|float|count|
|`capacity`||float|count|
|`capacity_available`|[OpenMetrics v1 & v2] Available storage capacity.|float|B|
|`capacity_reserved`|[OpenMetrics v1 & v2] Capacity reserved for snapshots.|float|B|
|`capacity_total`|[OpenMetrics v1 & v2] Total storage capacity.|float|B|
|`capacity_used`|[OpenMetrics v1 & v2] Used storage capacity.|float|B|
|`changefeed_admit_latency`|[OpenMetrics v1] Event admission latency: a difference between event Multi-Version Concurrency Control timestamp and the time it was admitted into the change feed Pipeline.|float|ns|
|`changefeed_admit_latency_bucket`|[OpenMetrics v2] Event admission latency: a difference between event Multi-Version Concurrency Control timestamp and the time it was admitted into the change feed Pipeline.|float|ns|
|`changefeed_admit_latency_count`|[OpenMetrics v2] Event admission latency: a difference between event Multi-Version Concurrency Control timestamp and the time it was admitted into the change feed Pipeline.|float|ns|
|`changefeed_admit_latency_sum`|[OpenMetrics v2] Event admission latency: a difference between event Multi-Version Concurrency Control timestamp and the time it was admitted into the change feed Pipeline.|float|ns|
|`changefeed_aggregator_progress`|The earliest timestamp up to which any aggregator is guaranteed to have emitted all values for.|float|count|
|`changefeed_backfill`|[OpenMetrics v1 & v2] Number of change feeds currently executing backfill.|float|count|
|`changefeed_backfill_count`|Number of change feeds currently executing backfill.|float|count|
|`changefeed_backfill_pending_ranges`|[OpenMetrics v1 & v2] Number of ranges in an ongoing backfill that are yet to be fully emitted.|float|count|
|`changefeed_batch_reduction_count`|Number of times a change feed aggregator node attempted to reduce the size of message batches it emitted to the Sink.|float|count|
|`changefeed_buffer_entries_allocated_mem`|Current quota pool memory allocation.|float|B|
|`changefeed_buffer_entries_flush`|Number of flush elements added to the buffer.|float|count|
|`changefeed_buffer_entries_in`|Total entries entering the buffer between Raft and change feed sinks.|float|count|
|`changefeed_buffer_entries_kv`|Number of KV elements added to the buffer.|float|count|
|`changefeed_buffer_entries_mem_acquired`|Total amount of memory acquired for entries as they enter the system.|float|count|
|`changefeed_buffer_entries_mem_released`|Total amount of memory released by the entries after they have been emitted.|float|count|
|`changefeed_buffer_entries_out`|Total entries leaving the buffer between Raft and change feed sinks.|float|count|
|`changefeed_buffer_entries_released`|Total entries processed, emitted, and acknowledged by the sinks.|float|count|
|`changefeed_buffer_entries_resolved`|Number of resolved elements added to the buffer.|float|count|
|`changefeed_buffer_pushback`|Total time spent waiting while the buffer was full.|float|ns|
|`changefeed_bytes_messages_pushback`|Total time spent throttled for bytes quota.|float|ns|
|`changefeed_checkpoint_hist_nanos_bucket`|Time spent checkpointing change feed progress.|float|ns|
|`changefeed_checkpoint_hist_nanos_count`|Time spent checkpointing change feed progress.|float|ns|
|`changefeed_checkpoint_hist_nanos_sum`|Time spent checkpointing change feed progress.|float|ns|
|`changefeed_checkpoint_progress`|The earliest timestamp of any change feed's persisted checkpoint (values prior to this timestamp will never need to be re-emitted).|float|count|
|`changefeed_cloudstorage_buffered_bytes`|The number of bytes buffered in cloud storage Sink files which have not been emitted yet.|float|count|
|`changefeed_commit_latency`|[OpenMetrics v1] Event commit latency: a difference between event Multi-Version Concurrency Control timestamp and the time it was acknowledged by the downstream Sink.|float|ns|
|`changefeed_commit_latency_bucket`|[OpenMetrics v2] Event commit latency: a difference between event Multi-Version Concurrency Control timestamp and the time it was acknowledged by the downstream Sink.|float|ns|
|`changefeed_commit_latency_count`|[OpenMetrics v2] Event commit latency: a difference between event Multi-Version Concurrency Control timestamp and the time it was acknowledged by the downstream Sink.|float|ns|
|`changefeed_commit_latency_sum`|[OpenMetrics v2] Event commit latency: a difference between event Multi-Version Concurrency Control timestamp and the time it was acknowledged by the downstream Sink.|float|ns|
|`changefeed_emitted_bytes`|Bytes emitted by all feeds.|float|B|
|`changefeed_emitted_bytes_count`|Bytes emitted by all feeds.|float|count|
|`changefeed_emitted_messages`|[OpenMetrics v1] Messages emitted by all feeds.|float|count|
|`changefeed_emitted_messages_count`|[OpenMetrics v2] Messages emitted by all feeds.|float|count|
|`changefeed_error_retries`|[OpenMetrics v1] Total retryable errors encountered by all change feeds.|float|count|
|`changefeed_error_retries_count`|[OpenMetrics v2] Total retryable errors encountered by all change feeds.|float|count|
|`changefeed_failures`|[OpenMetrics v1] Total number of change feed jobs which have failed.|float|count|
|`changefeed_failures_count`|[OpenMetrics v2] Total number of change feed jobs which have failed.|float|count|
|`changefeed_filtered_messages`|Messages filtered out by all feeds. This count does not include messages that may be filtered due to range constraints.|float|count|
|`changefeed_flush_hist_nanos_bucket`|Time spent flushing messages across all change feeds.|float|ns|
|`changefeed_flush_hist_nanos_count`|Time spent flushing messages across all change feeds.|float|ns|
|`changefeed_flush_hist_nanos_sum`|Time spent flushing messages across all change feeds.|float|ns|
|`changefeed_flush_messages_pushback`|Total time spent throttled for flush quota.|float|ns|
|`changefeed_flushed_bytes`|Bytes emitted by all feeds; may differ from `changefeed.emitted_bytes` when compression is enabled.|float|B|
|`changefeed_flushes`|Total flushes across all feeds.|float|count|
|`changefeed_forwarded_resolved_messages`|Resolved timestamps forwarded from the change aggregator to the change frontier.|float|count|
|`changefeed_frontier_updates`|Number of change frontier updates across all feeds.|float|count|
|`changefeed_internal_retry_message_count`|Number of messages for which an attempt to retry them within an aggregator node was made.|float|count|
|`changefeed_lagging_ranges`|The number of ranges considered to be lagging behind.|float|count|
|`changefeed_max_behind_nanos`|[OpenMetrics v1 & v2] Largest commit-to-emit duration of any running feed.|float|count|
|`changefeed_message_size_hist`|[OpenMetrics v1] Message size histogram.|float|count|
|`changefeed_message_size_hist_bucket`|[OpenMetrics v2] Message size histogram.|float|count|
|`changefeed_message_size_hist_count`|[OpenMetrics v2] Message size histogram.|float|count|
|`changefeed_message_size_hist_sum`|[OpenMetrics v2] Message size histogram.|float|count|
|`changefeed_messages_messages_pushback`|Total time spent throttled for messages quota.|float|ns|
|`changefeed_nprocs_consume_event_nanos_bucket`|Total time spent waiting to add an event to the parallel consumer.|float|ns|
|`changefeed_nprocs_consume_event_nanos_count`|Total time spent waiting to add an event to the parallel consumer.|float|ns|
|`changefeed_nprocs_consume_event_nanos_sum`|Total time spent waiting to add an event to the parallel consumer.|float|ns|
|`changefeed_nprocs_flush_nanos_bucket`|Total time spent idle waiting for the parallel consumer to flush.|float|ns|
|`changefeed_nprocs_flush_nanos_count`|Total time spent idle waiting for the parallel consumer to flush.|float|ns|
|`changefeed_nprocs_flush_nanos_sum`|Total time spent idle waiting for the parallel consumer to flush.|float|ns|
|`changefeed_nprocs_in_flight_count`|Number of buffered events in the parallel consumer.|float|count|
|`changefeed_parallel_io_queue_nanos_bucket`|Time spent with outgoing requests to the Sink waiting in queue due to inflight requests with conflicting keys.|float|ns|
|`changefeed_parallel_io_queue_nanos_count`|Time spent with outgoing requests to the Sink waiting in queue due to inflight requests with conflicting keys.|float|ns|
|`changefeed_parallel_io_queue_nanos_sum`|Time spent with outgoing requests to the Sink waiting in queue due to inflight requests with conflicting keys.|float|ns|
|`changefeed_queue_time`|Time KV event spent waiting to be processed.|float|ns|
|`changefeed_replan_count`||float|count|
|`changefeed_running`|[OpenMetrics v1 & v2] Number of currently running change feeds, including sinkless ones.|float|count|
|`changefeed_schema_registry_registrations`|Number of registration attempts with the schema registry.|float|count|
|`changefeed_schema_registry_retry_count`|Number of retries encountered when sending requests to the schema registry.|float|count|
|`changefeed_schemafeed_table_history_scans`|The number of table history scans during polling.|float|count|
|`changefeed_schemafeed_table_metadata`|Time blocked while verifying table metadata histories.|float|ns|
|`changefeed_sink_batch_hist_nanos_bucket`|Time spent batched in the Sink buffer before being flushed and acknowledged.|float|ns|
|`changefeed_sink_batch_hist_nanos_count`|Time spent batched in the Sink buffer before being flushed and acknowledged.|float|ns|
|`changefeed_sink_batch_hist_nanos_sum`|Time spent batched in the Sink buffer before being flushed and acknowledged.|float|ns|
|`changefeed_sink_io_inflight`|The number of keys currently inflight as IO requests being sent to the Sink.|float|count|
|`changefeed_size_based_flushes`|Total size-based flushes across all feeds.|float|count|
|`clock_offset_meannanos`|[OpenMetrics v1 & v2] Mean clock offset with other nodes in nanoseconds.|float|ns|
|`clock_offset_stddevnanos`|[OpenMetrics v1 & v2] Standard deviation clock offset with other nodes in nanoseconds.|float|ns|
|`cloud_read_bytes`|Number of bytes read.|float|B|
|`cloud_write_bytes`|Number of bytes written.|float|B|
|`cluster_preserve_downgrade_option_last_updated`|Timestamp of the last time the preserve downgrade option was updated.|float|count|
|`compactor_compactingnanos`|[OpenMetrics v1] Number of nanoseconds spent compacting ranges.|float|ns|
|`compactor_compactingnanos_count`|[OpenMetrics v2] Number of nanoseconds spent compacting ranges.|float|ns|
|`compactor_compactions_failure`|[OpenMetrics v1] Number of failed compaction requests sent to the storage engine.|float|count|
|`compactor_compactions_failure_count`|[OpenMetrics v2] Number of failed compaction requests sent to the storage engine.|float|count|
|`compactor_compactions_success`|[OpenMetrics v1] Number of successful compaction requests sent to the storage engine.|float|count|
|`compactor_compactions_success_count`|[OpenMetrics v2] Number of successful compaction requests sent to the storage engine.|float|count|
|`compactor_suggestionbytes_compacted`|[OpenMetrics v1] Number of logical bytes compacted from suggested compactions.|float|B|
|`compactor_suggestionbytes_compacted_count`|[OpenMetrics v2] Number of logical bytes compacted from suggested compactions.|float|B|
|`compactor_suggestionbytes_queued`|[OpenMetrics v1 & v2] Number of logical bytes in suggested compactions in the queue.|float|B|
|`compactor_suggestionbytes_skipped`|[OpenMetrics v1] Number of logical bytes in suggested compactions which were not compacted.|float|B|
|`compactor_suggestionbytes_skipped_count`|[OpenMetrics v2] Number of logical bytes in suggested compactions which were not compacted.|float|B|
|`distsender_batch_requests_cross_region_bytes`|Total byte count of replica-addressed batch requests processed cross-region when region tiers are configured.|float|B|
|`distsender_batch_requests_cross_zone_bytes`|Total byte count of replica-addressed batch requests processed cross-zone within the same region when region and zone tiers are configured. However, if the region tiers are not configured, this count may also include batch data sent between different regions. Ensuring consistent configuration of region and zone tiers across nodes helps accurately monitor the data transmitted.|float|B|
|`distsender_batch_requests_replica_addressed_bytes`|Total byte count of replica-addressed batch requests processed.|float|B|
|`distsender_batch_responses_cross_region_bytes`|Total byte count of replica-addressed batch responses received cross-region when region tiers are configured.|float|B|
|`distsender_batch_responses_cross_zone_bytes`|Total byte count of replica-addressed batch responses received cross-zone within the same region when region and zone tiers are configured. However, if the region tiers are not configured, this count may also include batch data received between different regions. Ensuring consistent configuration of region and zone tiers across nodes helps accurately monitor the data transmitted.|float|B|
|`distsender_batch_responses_replica_addressed_bytes`|Total byte count of replica-addressed batch responses received.|float|B|
|`distsender_batches`|Number of batches processed.|float|count|
|`distsender_batches_async_sent`|Number of partial batches sent asynchronously.|float|count|
|`distsender_batches_async_throttled`|Number of partial batches not sent asynchronously due to throttling.|float|count|
|`distsender_batches_partial`|[OpenMetrics v1] Number of partial batches processed.|float|count|
|`distsender_batches_partial_count`|[OpenMetrics v2] Number of partial batches processed.|float|count|
|`distsender_batches_total`|[OpenMetrics v1] Number of batches processed.|float|count|
|`distsender_batches_total_count`|[OpenMetrics v2] Number of batches processed.|float|count|
|`distsender_errors_inleasetransferbackoffs`|Number of times backed off due to NotLeaseHolderErrors during lease transfer.|float|count|
|`distsender_errors_notleaseholder`|[OpenMetrics v1] Number of NotLeaseHolderErrors encountered.|float|count|
|`distsender_errors_notleaseholder_count`|[OpenMetrics v2] Number of NotLeaseHolderErrors encountered.|float|count|
|`distsender_rangefeed_catchup_ranges`|Number of ranges in catchup mode. Counts the number of ranges with an active range feed performing a catchup scan.|float|count|
|`distsender_rangefeed_error_catchup_ranges`|Number of ranges in catchup mode which experienced an error.|float|count|
|`distsender_rangefeed_restart_ranges`|Number of ranges that were restarted due to transient errors.|float|count|
|`distsender_rangefeed_retry_logical_ops_missing`|Number of ranges that encountered retryable LOGICAL OPS MISSING error.|float|count|
|`distsender_rangefeed_retry_no_leaseholder`|Number of ranges that encountered retryable NO_LEASEHOLDER error.|float|count|
|`distsender_rangefeed_retry_node_not_found`|Number of ranges that encountered retryable NODE_NOT_FOUND error.|float|count|
|`distsender_rangefeed_retry_raft_snapshot`|Number of ranges that encountered retryable RAFT_SNAPSHOT error.|float|count|
|`distsender_rangefeed_retry_range_key_mismatch`|Number of ranges that encountered retryable RANGE_KEY_MISMATCH error.|float|count|
|`distsender_rangefeed_retry_range_merged`|Number of ranges that encountered retryable RANGE_MERGED error.|float|count|
|`distsender_rangefeed_retry_range_not_found`|Number of ranges that encountered retryable RANGE_NOT_FOUND error.|float|count|
|`distsender_rangefeed_retry_range_split`|Number of ranges that encountered retryable RANGE_SPLIT error.|float|count|
|`distsender_rangefeed_retry_rangefeed_closed`|Number of ranges that encountered retryable RANGEFEED_CLOSED error.|float|count|
|`distsender_rangefeed_retry_replica_removed`|Number of ranges that encountered retryable REPLICA_REMOVED error.|float|count|
|`distsender_rangefeed_retry_send`|Number of ranges that encountered retryable send error.|float|count|
|`distsender_rangefeed_retry_slow_consumer`|Number of ranges that encountered retryable SLOW_CONSUMER error.|float|count|
|`distsender_rangefeed_retry_store_not_found`|Number of ranges that encountered retryable STORE_NOT_FOUND error.|float|count|
|`distsender_rangefeed_retry_stuck`|Number of ranges that encountered retryable STUCK error.|float|count|
|`distsender_rangefeed_total_ranges`|Number of ranges executing range feed. Counts the number of ranges with an active range feed.|float|count|
|`distsender_rangelookups`|Number of range lookups.|float|count|
|`distsender_rpc_addsstable_sent`|Number of AddSSTable requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_adminchangereplicas_sent`|Number of AdminChangeReplicas requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_adminmerge_sent`|Number of AdminMerge requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_adminrelocaterange_sent`|Number of AdminRelocateRange requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_adminscatter_sent`|Number of AdminScatter requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_adminsplit_sent`|Number of AdminSplit requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_admintransferlease_sent`|Number of AdminTransferLease requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_adminunsplit_sent`|Number of Admin un split requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_adminverifyprotectedtimestamp_sent`|Number of AdminVerifyProtectedTimestamp requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_barrier_sent`|Number of Barrier requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_checkconsistency_sent`|Number of CheckConsistency requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_clearrange_sent`|Number of ClearRange requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_computechecksum_sent`|Number of ComputeChecksum requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_conditionalput_sent`|Number of ConditionalPut requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_delete_sent`|Number of Delete requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_deleterange_sent`|Number of DeleteRange requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_endtxn_sent`|Number of EndTxn requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_err_ambiguousresulterrtype`|Number of AmbiguousResultErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_batchtimestampbeforegcerrtype`|Number of BatchTimestampBeforeGCErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_communicationerrtype`|Number of CommunicationErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_conditionfailederrtype`|Number of ConditionFailedErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_errordetailtype`|Number of ErrorDetailType (tagged by their number) errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_indeterminatecommiterrtype`|Number of IndeterminateCommitErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_integeroverflowerrtype`|Number of IntegerOverflowErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_intentmissingerrtype`|Number of IntentMissingErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_internalerrtype`|Number of InternalErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_invalidleaseerrtype`|Number of InvalidLeaseErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_leaserejectederrtype`|Number of LeaseRejectedErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_lockconflicterrtype`|Number of LockConflictErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_mergeinprogresserrtype`|Number of MergeInProgressErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_mintimestampboundunsatisfiableerrtype`|Number of MinTimestampBoundUnsatisfiableErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_mvcchistorymutationerrtype`|Number of MVCCHistoryMutationErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_nodeunavailableerrtype`|Number of NodeUnavailableErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_notleaseholdererrtype`|Number of NotLeaseHolderErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_oprequirestxnerrtype`|Number of OpRequiresTxnErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_optimisticevalconflictserrtype`|Number of OptimisticEvalConflictsErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_raftgroupdeletederrtype`|Number of RaftGroupDeletedErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_rangefeedretryerrtype`|Number of RangeFeedRetryErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_rangekeymismatcherrtype`|Number of RangeKeyMismatchErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_rangenotfounderrtype`|Number of RangeNotFoundErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_readwithinuncertaintyintervalerrtype`|Number of ReadWithinUncertaintyIntervalErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_refreshfailederrtype`|Number of RefreshFailedErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_replicacorruptionerrtype`|Number of ReplicaCorruptionErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_replicatooolderrtype`|Number of ReplicaTooOldErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_storenotfounderrtype`|Number of StoreNotFoundErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_transactionabortederrtype`|Number of TransactionAbortedErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_transactionpusherrtype`|Number of TransactionPushErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_transactionretryerrtype`|Number of TransactionRetryErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_transactionretrywithprotorefresherrtype`|Number of TransactionRetryWithProtoRefreshErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_transactionstatuserrtype`|Number of TransactionStatusErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_txnalreadyencounterederrtype`|Number of TxnAlreadyEncounteredErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_unsupportedrequesterrtype`|Number of UnsupportedRequestErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_writeintenterrtype`|Number of WriteIntentErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_err_writetooolderrtype`|Number of WriteTooOldErrType errors received by replica-bound RPCs. Counts how often the specified type of error was received back from replicas as part of executing possibly range-spanning requests. Failures to reach the target replica will be accounted for as 'roachpb.CommunicationErrType' and unclassified errors as 'roachpb.InternalErrType'.|float|count|
|`distsender_rpc_export_sent`|Number of Export requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_gc_sent`|Number of GC requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_get_sent`|Number of Get requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_heartbeattxn_sent`|Number of HeartbeatTxn requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_increment_sent`|Number of Increment requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_initput_sent`|Number of InitPut requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_isspanempty_sent`|Number of IsSpanEmpty requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_leaseinfo_sent`|Number of LeaseInfo requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_merge_sent`|Number of Merge requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_migrate_sent`|Number of Migrate requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_probe_sent`|Number of Probe requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_pushtxn_sent`|Number of PushTxn requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_put_sent`|Number of Put requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_queryintent_sent`|Number of QueryIntent requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_querylocks_sent`|Number of QueryLocks requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_queryresolvedtimestamp_sent`|Number of QueryResolvedTimestamp requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_querytxn_sent`|Number of QueryTxn requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_rangestats_sent`|Number of RangeStats requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_recomputestats_sent`|Number of RecomputeStats requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_recovertxn_sent`|Number of RecoverTxn requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_refresh_sent`|Number of Refresh requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_refreshrange_sent`|Number of RefreshRange requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_requestlease_sent`|Number of RequestLease requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_resolveintent_sent`|Number of ResolveIntent requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_resolveintentrange_sent`|Number of ResolveIntentRange requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_reversescan_sent`|Number of ReverseScan requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_revertrange_sent`|Number of RevertRange requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_scan_sent`|Number of Scan requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_sent`|Number of replica-addressed RPCs sent.|float|count|
|`distsender_rpc_sent_local`|[OpenMetrics v1] Number of local RPCs sent.|float|count|
|`distsender_rpc_sent_local_count`|[OpenMetrics v2] Number of local RPCs sent.|float|count|
|`distsender_rpc_sent_nextreplicaerror`|[OpenMetrics v1] Number of RPCs sent due to per-replica errors.|float|count|
|`distsender_rpc_sent_nextreplicaerror_count`|[OpenMetrics v2] Number of RPCs sent due to per-replica errors.|float|count|
|`distsender_rpc_sent_total`|[OpenMetrics v1] Number of RPCs sent.|float|count|
|`distsender_rpc_sent_total_count`|[OpenMetrics v2] Number of replica-addressed RPCs sent.|float|count|
|`distsender_rpc_subsume_sent`|Number of Subsume requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_transferlease_sent`|Number of TransferLease requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_truncatelog_sent`|Number of TruncateLog requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`distsender_rpc_writebatch_sent`|Number of WriteBatch requests processed. Counts the requests in batches handed to DistSender, not the RPCs sent to individual Ranges as a result.|float|count|
|`exec_error`|[OpenMetrics v1] Number of batch KV requests that failed to execute on this node. These are warnings denoting cleanup rather than errors, and can be disregarded as part of operation.|float|count|
|`exec_error_count`|[OpenMetrics v2] Number of batch KV requests that failed to execute on this node. These are warnings denoting cleanup rather than errors, and can be disregarded as part of operation.|float|count|
|`exec_latency`|[OpenMetrics v1] Latency in nanoseconds of batch KV requests executed on this node.|float|ns|
|`exec_latency_bucket`|[OpenMetrics v2] Latency in nanoseconds of batch KV requests executed on this node.|float|ns|
|`exec_latency_count`|[OpenMetrics v2] Latency in nanoseconds of batch KV requests executed on this node.|float|ns|
|`exec_latency_sum`|[OpenMetrics v2] Latency in nanoseconds of batch KV requests executed on this node.|float|ns|
|`exec_success`|[OpenMetrics v1] Number of batch KV requests executed successfully on this node.|float|count|
|`exec_success_count`|[OpenMetrics v2] Number of batch KV requests executed successfully on this node.|float|count|
|`exportrequest_delay_count`|Number of Export requests delayed due to concurrent requests.|float|count|
|`follower_reads_success_count`|Number of successful follower reads.|float|count|
|`gcbytesage`|[OpenMetrics v1 & v2] Cumulative age of non-live data in seconds.|float|s|
|`gossip_bytes_received`|[OpenMetrics v1] Number of received gossip bytes.|float|B|
|`gossip_bytes_received_count`|[OpenMetrics v2] Number of received gossip bytes.|float|B|
|`gossip_bytes_sent`|[OpenMetrics v1] Number of sent gossip bytes.|float|B|
|`gossip_bytes_sent_count`|[OpenMetrics v2] Number of sent gossip bytes.|float|B|
|`gossip_connections_incoming`|[OpenMetrics v1 & v2] Number of active incoming gossip connections.|float|count|
|`gossip_connections_outgoing`|[OpenMetrics v1 & v2] Number of active outgoing gossip connections.|float|count|
|`gossip_connections_refused`|[OpenMetrics v1] Number of refused incoming gossip connections.|float|count|
|`gossip_connections_refused_count`|[OpenMetrics v2] Number of refused incoming gossip connections.|float|count|
|`gossip_infos_received`|[OpenMetrics v1] Number of received gossip Info objects.|float|count|
|`gossip_infos_received_count`|[OpenMetrics v2] Number of received gossip Info objects.|float|count|
|`gossip_infos_sent`|[OpenMetrics v1] Number of sent gossip Info objects.|float|count|
|`gossip_infos_sent_count`|[OpenMetrics v2] Number of sent gossip Info objects.|float|count|
|`intentage`|[OpenMetrics v1 & v2] Cumulative age of intents in seconds.|float|s|
|`intentbytes`|[OpenMetrics v1 & v2] Number of bytes in intent KV pairs.|float|B|
|`intentcount`|[OpenMetrics v1 & v2] Count of intent keys.|float|count|
|`intentresolver_async_throttled`|Number of intent resolution attempts not run asynchronously due to throttling.|float|count|
|`intentresolver_async_throttled_count`|Number of intent resolution attempts not run asynchronously due to throttling.|float|count|
|`intentresolver_finalized_txns_failed`|Number of finalized transaction cleanup failures. Transaction cleanup refers to the process of resolving all of a transaction's intents and then garbage collecting its transaction record.|float|count|
|`intentresolver_finalized_txns_failed_count`|Number of finalized transaction cleanup failures. Transaction cleanup refers to the process of resolving all of a transaction's intents and then garbage collecting its transaction record.|float|count|
|`intentresolver_intents_failed`|Number of intent resolution failures. The unit of measurement is a single intent, so if a batch of intent resolution requests fails, the metric will be incremented for each request in the batch.|float|count|
|`intentresolver_intents_failed_count`|Number of intent resolution failures. The unit of measurement is a single intent, so if a batch of intent resolution requests fails, the metric will be incremented for each request in the batch.|float|count|
|`intents_abort_attempts`|Count of (point or range) non-poisoning intent abort evaluation attempts.|float|count|
|`intents_abort_attempts_count`|Count of (point or range) non-poisoning intent abort evaluation attempts.|float|count|
|`intents_poison_attempts`|Count of (point or range) poisoning intent abort evaluation attempts.|float|count|
|`intents_poison_attempts_count`|Count of (point or range) poisoning intent abort evaluation attempts.|float|count|
|`intents_resolve_attempts`|Count of (point or range) intent commit evaluation attempts.|float|count|
|`intents_resolve_attempts_count`|Count of (point or range) intent commit evaluation attempts.|float|count|
|`jobs.auto_sql_stats_compaction.protected_record_count`||float|count|
|`jobs_adopt_iterations`|Number of job-adopt iterations performed by the registry.|float|count|
|`jobs_auto_config_env_runner_currently_idle`|Number of autoconfigenv_runner jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_auto_config_env_runner_currently_paused`|Number of autoconfigenv_runner jobs currently considered Paused.|float|count|
|`jobs_auto_config_env_runner_currently_running`|Number of autoconfigenv_runner jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_auto_config_env_runner_expired_pts_records`|Number of expired protected timestamp records owned by autoconfigenv_runner jobs.|float|count|
|`jobs_auto_config_env_runner_fail_or_cancel_completed`|Number of autoconfigenv_runner jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_auto_config_env_runner_fail_or_cancel_failed`|Number of autoconfigenv_runner jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_auto_config_env_runner_fail_or_cancel_retry_error`|Number of autoconfigenv_runner jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_auto_config_env_runner_protected_age_sec`|The age of the oldest PTS record protected by autoconfigenv_runner jobs.|float|s|
|`jobs_auto_config_env_runner_protected_record`|Number of protected timestamp records held by autoconfigenv_runner jobs.|float|count|
|`jobs_auto_config_env_runner_resume_completed`|Number of autoconfigenv_runner jobs which successfully resumed to completion.|float|count|
|`jobs_auto_config_env_runner_resume_failed`|Number of autoconfigenv_runner jobs which failed with a non-retryable error.|float|count|
|`jobs_auto_config_env_runner_resume_retry_error`|Number of autoconfigenv_runner jobs which failed with a retryable error.|float|count|
|`jobs_auto_config_runner_currently_idle`|Number of auto config runner jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_auto_config_runner_currently_paused`|Number of auto config runner jobs currently considered Paused.|float|count|
|`jobs_auto_config_runner_currently_running`|Number of auto config runner jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_auto_config_runner_expired_pts_records`|Number of expired protected timestamp records owned by auto config runner jobs.|float|count|
|`jobs_auto_config_runner_fail_or_cancel_completed`|Number of auto config runner jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_auto_config_runner_fail_or_cancel_failed`|Number of auto config runner jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_auto_config_runner_fail_or_cancel_retry_error`|Number of auto config runner jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_auto_config_runner_protected_age_sec`|The age of the oldest PTS record protected by auto config runner jobs.|float|s|
|`jobs_auto_config_runner_protected_record`|Number of protected timestamp records held by auto config runner jobs.|float|count|
|`jobs_auto_config_runner_resume_completed`|Number of auto config runner jobs which successfully resumed to completion.|float|count|
|`jobs_auto_config_runner_resume_failed`|Number of auto config runner jobs which failed with a non-retryable error.|float|count|
|`jobs_auto_config_runner_resume_retry_error`|Number of auto config runner jobs which failed with a retryable error.|float|count|
|`jobs_auto_config_task_currently_idle`|Number of auto_config_task jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_auto_config_task_currently_paused`|Number of auto_config_task jobs currently considered Paused.|float|count|
|`jobs_auto_config_task_currently_running`|Number of auto_config_task jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_auto_config_task_expired_pts_records`|Number of expired protected timestamp records owned by auto_config_task jobs.|float|count|
|`jobs_auto_config_task_fail_or_cancel_completed`|Number of auto_config_task jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_auto_config_task_fail_or_cancel_failed`|Number of auto_config_task jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_auto_config_task_fail_or_cancel_retry_error`|Number of auto_config_task jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_auto_config_task_protected_age_sec`|The age of the oldest PTS record protected by auto_config_task jobs.|float|s|
|`jobs_auto_config_task_protected_record`|Number of protected timestamp records held by auto_config_task jobs.|float|count|
|`jobs_auto_config_task_resume_completed`|Number of auto_config_task jobs which successfully resumed to completion.|float|count|
|`jobs_auto_config_task_resume_failed`|Number of auto_config_task jobs which failed with a non-retryable error.|float|count|
|`jobs_auto_config_task_resume_retry_error`|Number of auto_config_task jobs which failed with a retryable error.|float|count|
|`jobs_auto_create_stats_currently_idle`|Number of auto_create_stats jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_auto_create_stats_currently_paused`|Number of auto_create_stats jobs currently considered Paused.|float|count|
|`jobs_auto_create_stats_currently_running`|Number of auto_create_stats jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_auto_create_stats_expired_pts_records`|Number of expired protected timestamp records owned by auto_create_stats jobs.|float|count|
|`jobs_auto_create_stats_fail_or_cancel_completed`|Number of auto_create_stats jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_auto_create_stats_fail_or_cancel_failed`|Number of auto_create_stats jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_auto_create_stats_fail_or_cancel_retry_error`|Number of auto_create_stats jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_auto_create_stats_protected_age_sec`|The age of the oldest PTS record protected by auto_create_stats jobs.|float|s|
|`jobs_auto_create_stats_protected_record`|Number of protected timestamp records held by auto_create_stats jobs.|float|count|
|`jobs_auto_create_stats_resume_completed`|Number of auto_create_stats jobs which successfully resumed to completion.|float|count|
|`jobs_auto_create_stats_resume_failed`|Number of auto_create_stats jobs which failed with a non-retryable error.|float|count|
|`jobs_auto_create_stats_resume_retry_error`|Number of auto_create_stats jobs which failed with a retryable error.|float|count|
|`jobs_auto_schema_telemetry_currently_idle`|Number of auto_schema_telemetry jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_auto_schema_telemetry_currently_paused`|Number of auto_schema_telemetry jobs currently considered Paused.|float|count|
|`jobs_auto_schema_telemetry_currently_running`|Number of auto_schema_telemetry jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_auto_schema_telemetry_expired_pts_records`|Number of expired protected timestamp records owned by auto_schema_telemetry jobs.|float|count|
|`jobs_auto_schema_telemetry_fail_or_cancel_completed`|Number of auto_schema_telemetry jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_auto_schema_telemetry_fail_or_cancel_failed`|Number of auto_schema_telemetry jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_auto_schema_telemetry_fail_or_cancel_retry_error`|Number of auto_schema_telemetry jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_auto_schema_telemetry_protected_age_sec`|The age of the oldest PTS record protected by auto_schema_telemetry jobs.|float|s|
|`jobs_auto_schema_telemetry_protected_record`|Number of protected timestamp records held by auto_schema_telemetry jobs.|float|count|
|`jobs_auto_schema_telemetry_resume_completed`|Number of auto_schema_telemetry jobs which successfully resumed to completion.|float|count|
|`jobs_auto_schema_telemetry_resume_failed`|Number of auto_schema_telemetry jobs which failed with a non-retryable error.|float|count|
|`jobs_auto_schema_telemetry_resume_retry_error`|Number of auto_schema_telemetry jobs which failed with a retryable error.|float|count|
|`jobs_auto_span_config_reconciliation_currently_idle`|Number of autospanconfig_reconciliation jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_auto_span_config_reconciliation_currently_paused`|Number of autospanconfig_reconciliation jobs currently considered Paused.|float|count|
|`jobs_auto_span_config_reconciliation_currently_running`|Number of autospanconfig_reconciliation jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_auto_span_config_reconciliation_expired_pts_records`|Number of expired protected timestamp records owned by autospanconfig_reconciliation jobs.|float|count|
|`jobs_auto_span_config_reconciliation_fail_or_cancel_completed`|Number of autospanconfig_reconciliation jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_auto_span_config_reconciliation_fail_or_cancel_failed`|Number of autospanconfig_reconciliation jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_auto_span_config_reconciliation_fail_or_cancel_retry_error`|Number of autospanconfig_reconciliation jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_auto_span_config_reconciliation_protected_age_sec`|The age of the oldest PTS record protected by autospanconfig_reconciliation jobs.|float|s|
|`jobs_auto_span_config_reconciliation_protected_record`|Number of protected timestamp records held by autospanconfig_reconciliation jobs.|float|count|
|`jobs_auto_span_config_reconciliation_resume_completed`|Number of autospanconfig_reconciliation jobs which successfully resumed to completion.|float|count|
|`jobs_auto_span_config_reconciliation_resume_failed`|Number of autospanconfig_reconciliation jobs which failed with a non-retryable error.|float|count|
|`jobs_auto_span_config_reconciliation_resume_retry_error`|Number of autospanconfig_reconciliation jobs which failed with a retryable error.|float|count|
|`jobs_auto_sql_stats_compaction_currently_idle`|Number of autosqlstats_compaction jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_auto_sql_stats_compaction_currently_paused`|Number of autosqlstats_compaction jobs currently considered Paused.|float|count|
|`jobs_auto_sql_stats_compaction_currently_running`|Number of autosqlstats_compaction jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_auto_sql_stats_compaction_expired_pts_records`|Number of expired protected timestamp records owned by autosqlstats_compaction jobs.|float|count|
|`jobs_auto_sql_stats_compaction_fail_or_cancel_completed`|Number of autosqlstats_compaction jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_auto_sql_stats_compaction_fail_or_cancel_failed`|Number of autosqlstats_compaction jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_auto_sql_stats_compaction_fail_or_cancel_retry_error`|Number of autosqlstats_compaction jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_auto_sql_stats_compaction_protected_age_sec`|The age of the oldest PTS record protected by autosqlstats_compaction jobs.|float|s|
|`jobs_auto_sql_stats_compaction_protected_record`|Number of protected timestamp records held by autosqlstats_compaction jobs.|float|count|
|`jobs_auto_sql_stats_compaction_protected_record_count`||float|count|
|`jobs_auto_sql_stats_compaction_resume_completed`|Number of autosqlstats_compaction jobs which successfully resumed to completion.|float|count|
|`jobs_auto_sql_stats_compaction_resume_failed`|Number of autosqlstats_compaction jobs which failed with a non-retryable error.|float|count|
|`jobs_auto_sql_stats_compaction_resume_retry_error`|Number of autosqlstats_compaction jobs which failed with a retryable error.|float|count|
|`jobs_auto_update_sql_activity_currently_idle`|Number of autoupdatesql_activity jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_auto_update_sql_activity_currently_paused`|Number of autoupdatesql_activity jobs currently considered Paused.|float|count|
|`jobs_auto_update_sql_activity_currently_running`|Number of autoupdatesql_activity jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_auto_update_sql_activity_expired_pts_records`|Number of expired protected timestamp records owned by autoupdatesql_activity jobs.|float|count|
|`jobs_auto_update_sql_activity_fail_or_cancel_completed`|Number of autoupdatesql_activity jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_auto_update_sql_activity_fail_or_cancel_failed`|Number of autoupdatesql_activity jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_auto_update_sql_activity_fail_or_cancel_retry_error`|Number of autoupdatesql_activity jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_auto_update_sql_activity_protected_age_sec`|The age of the oldest PTS record protected by autoupdatesql_activity jobs.|float|s|
|`jobs_auto_update_sql_activity_protected_record`|Number of protected timestamp records held by autoupdatesql_activity jobs.|float|count|
|`jobs_auto_update_sql_activity_resume_completed`|Number of autoupdatesql_activity jobs which successfully resumed to completion.|float|count|
|`jobs_auto_update_sql_activity_resume_failed`|Number of autoupdatesql_activity jobs which failed with a non-retryable error.|float|count|
|`jobs_auto_update_sql_activity_resume_retry_error`|Number of autoupdatesql_activity jobs which failed with a retryable error.|float|count|
|`jobs_backup_currently_idle`|[OpenMetrics v1 & v2] Number of backup jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_backup_currently_paused`|Number of backup jobs currently considered Paused.|float|count|
|`jobs_backup_currently_running`|[OpenMetrics v1 & v2] Number of backup jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_backup_expired_pts_records`|Number of expired protected timestamp records owned by backup jobs.|float|count|
|`jobs_backup_fail_or_cancel_completed`|Number of backup jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_backup_fail_or_cancel_failed`|[OpenMetrics v1] Number of backup jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_backup_fail_or_cancel_failed_count`|[OpenMetrics v2] Number of backup jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_backup_fail_or_cancel_retry_error`|[OpenMetrics v1] Number of backup jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_backup_fail_or_cancel_retry_error_count`|[OpenMetrics v2] Number of backup jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_backup_protected_age_sec`|The age of the oldest PTS record protected by backup jobs.|float|s|
|`jobs_backup_protected_record`|Number of protected timestamp records held by backup jobs.|float|count|
|`jobs_backup_resume_completed`|Number of backup jobs which successfully resumed to completion.|float|count|
|`jobs_backup_resume_failed`|[OpenMetrics v1] Number of backup jobs which failed with a non-retryable error.|float|count|
|`jobs_backup_resume_failed_count`|[OpenMetrics v2] Number of backup jobs which failed with a non-retryable error.|float|count|
|`jobs_backup_resume_retry_error`|[OpenMetrics v1] Number of backup jobs which failed with a retryable error.|float|count|
|`jobs_backup_resume_retry_error_count`|[OpenMetrics v2] Number of backup jobs which failed with a retryable error.|float|count|
|`jobs_changefeed_currently_idle`|Number of change feed jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_changefeed_currently_paused`|Number of change feed jobs currently considered Paused.|float|count|
|`jobs_changefeed_currently_running`|Number of change feed jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_changefeed_expired_pts_records`|Number of expired protected timestamp records owned by change feed jobs.|float|count|
|`jobs_changefeed_fail_or_cancel_completed`|Number of change feed jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_changefeed_fail_or_cancel_failed`|Number of change feed jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_changefeed_fail_or_cancel_retry_error`|Number of change feed jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_changefeed_protected_age_sec`|The age of the oldest PTS record protected by change feed jobs.|float|s|
|`jobs_changefeed_protected_record`|Number of protected timestamp records held by change feed jobs.|float|count|
|`jobs_changefeed_resume_completed`|Number of change feed jobs which successfully resumed to completion.|float|count|
|`jobs_changefeed_resume_failed`|Number of change feed jobs which failed with a non-retryable error.|float|count|
|`jobs_changefeed_resume_retry_error`|[OpenMetrics v1] Number of change feed jobs which failed with a retryable error.|float|count|
|`jobs_changefeed_resume_retry_error_count`|[OpenMetrics v2] Number of change feed jobs which failed with a retryable error.|float|count|
|`jobs_claimed_jobs`|Number of jobs claimed in job-adopt iterations.|float|count|
|`jobs_create_stats_currently_idle`|Number of create_stats jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_create_stats_currently_paused`|Number of create_stats jobs currently considered Paused.|float|count|
|`jobs_create_stats_currently_running`|Number of create_stats jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_create_stats_expired_pts_records`|Number of expired protected timestamp records owned by create_stats jobs.|float|count|
|`jobs_create_stats_fail_or_cancel_completed`|Number of create_stats jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_create_stats_fail_or_cancel_failed`|Number of create_stats jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_create_stats_fail_or_cancel_retry_error`|Number of create_stats jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_create_stats_protected_age_sec`|The age of the oldest PTS record protected by create_stats jobs.|float|s|
|`jobs_create_stats_protected_record`|Number of protected timestamp records held by create_stats jobs.|float|count|
|`jobs_create_stats_resume_completed`|Number of create_stats jobs which successfully resumed to completion.|float|count|
|`jobs_create_stats_resume_failed`|Number of create_stats jobs which failed with a non-retryable error.|float|count|
|`jobs_create_stats_resume_retry_error`|Number of create_stats jobs which failed with a retryable error.|float|count|
|`jobs_import_currently_idle`|Number of import jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_import_currently_paused`|Number of import jobs currently considered Paused.|float|count|
|`jobs_import_currently_running`|Number of import jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_import_expired_pts_records`|Number of expired protected timestamp records owned by import jobs.|float|count|
|`jobs_import_fail_or_cancel_completed`|Number of import jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_import_fail_or_cancel_failed`|Number of import jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_import_fail_or_cancel_retry_error`|Number of import jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_import_protected_age_sec`|The age of the oldest PTS record protected by import jobs.|float|s|
|`jobs_import_protected_record`|Number of protected timestamp records held by import jobs.|float|count|
|`jobs_import_resume_completed`|Number of import jobs which successfully resumed to completion.|float|count|
|`jobs_import_resume_failed`|Number of import jobs which failed with a non-retryable error.|float|count|
|`jobs_import_resume_retry_error`|Number of import jobs which failed with a retryable error.|float|count|
|`jobs_key_visualizer_currently_idle`|Number of key_visualizer jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_key_visualizer_currently_paused`|Number of key_visualizer jobs currently considered Paused.|float|count|
|`jobs_key_visualizer_currently_running`|Number of key_visualizer jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_key_visualizer_expired_pts_records`|Number of expired protected timestamp records owned by key_visualizer jobs.|float|count|
|`jobs_key_visualizer_fail_or_cancel_completed`|Number of key_visualizer jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_key_visualizer_fail_or_cancel_failed`|Number of key_visualizer jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_key_visualizer_fail_or_cancel_retry_error`|Number of key_visualizer jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_key_visualizer_protected_age_sec`|The age of the oldest PTS record protected by key_visualizer jobs.|float|s|
|`jobs_key_visualizer_protected_record`|Number of protected timestamp records held by key_visualizer jobs.|float|count|
|`jobs_key_visualizer_resume_completed`|Number of key_visualizer jobs which successfully resumed to completion.|float|count|
|`jobs_key_visualizer_resume_failed`|Number of key_visualizer jobs which failed with a non-retryable error.|float|count|
|`jobs_key_visualizer_resume_retry_error`|Number of key_visualizer jobs which failed with a retryable error.|float|count|
|`jobs_metrics_task_failed`|Number of metrics SQL activity updater tasks that failed.|float|count|
|`jobs_migration_currently_idle`|Number of migration jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_migration_currently_paused`|Number of migration jobs currently considered Paused.|float|count|
|`jobs_migration_currently_running`|Number of migration jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_migration_expired_pts_records`|Number of expired protected timestamp records owned by migration jobs.|float|count|
|`jobs_migration_fail_or_cancel_completed`|Number of migration jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_migration_fail_or_cancel_failed`|Number of migration jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_migration_fail_or_cancel_retry_error`|Number of migration jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_migration_protected_age_sec`|The age of the oldest PTS record protected by migration jobs.|float|s|
|`jobs_migration_protected_record`|Number of protected timestamp records held by migration jobs.|float|count|
|`jobs_mvcc_statistics_update_currently_idle`|Number of mvcc_statistics_update jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_mvcc_statistics_update_currently_paused`|Number of mvcc_statistics_update jobs currently considered Paused.|float|count|
|`jobs_mvcc_statistics_update_currently_running`|Number of mvcc_statistics_update jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_mvcc_statistics_update_expired_pts_records`|Number of expired protected timestamp records owned by mvcc_statistics_update jobs.|float|count|
|`jobs_mvcc_statistics_update_fail_or_cancel_completed`|Number of mvcc_statistics_update jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_mvcc_statistics_update_fail_or_cancel_failed`|Number of mvcc_statistics_update jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_mvcc_statistics_update_fail_or_cancel_retry_error`|Number of mvcc_statistics_update jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_mvcc_statistics_update_protected_age_sec`|The age of the oldest PTS record protected by mvcc_statistics_update jobs.|float|s|
|`jobs_mvcc_statistics_update_protected_record`|Number of protected timestamp records held by mvcc_statistics_update jobs.|float|count|
|`jobs_mvcc_statistics_update_resume_completed`|Number of mvcc_statistics_update jobs which successfully resumed to completion.|float|count|
|`jobs_mvcc_statistics_update_resume_failed`|Number of mvcc_statistics_update jobs which failed with a non-retryable error.|float|count|
|`jobs_mvcc_statistics_update_resume_retry_error`|Number of mvcc_statistics_update jobs which failed with a retryable error.|float|count|
|`jobs_new_schema_change_currently_idle`|Number of new_schema_change jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_new_schema_change_currently_paused`|Number of new_schema_change jobs currently considered Paused.|float|count|
|`jobs_new_schema_change_currently_running`|Number of new_schema_change jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_new_schema_change_expired_pts_records`|Number of expired protected timestamp records owned by new_schema_change jobs.|float|count|
|`jobs_new_schema_change_fail_or_cancel_completed`|Number of new_schema_change jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_new_schema_change_fail_or_cancel_failed`|Number of new_schema_change jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_new_schema_change_fail_or_cancel_retry_error`|Number of new_schema_change jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_new_schema_change_protected_age_sec`|The age of the oldest PTS record protected by new_schema_change jobs.|float|s|
|`jobs_new_schema_change_protected_record`|Number of protected timestamp records held by new_schema_change jobs.|float|count|
|`jobs_new_schema_change_resume_completed`|Number of new_schema_change jobs which successfully resumed to completion.|float|count|
|`jobs_new_schema_change_resume_failed`|Number of new_schema_change jobs which failed with a non-retryable error.|float|count|
|`jobs_new_schema_change_resume_retry_error`|Number of new_schema_change jobs which failed with a retryable error.|float|count|
|`jobs_poll_jobs_stats_currently_idle`|Number of poll_jobs_stats jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_poll_jobs_stats_currently_paused`|Number of poll_jobs_stats jobs currently considered Paused.|float|count|
|`jobs_poll_jobs_stats_currently_running`|Number of poll_jobs_stats jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_poll_jobs_stats_expired_pts_records`|Number of expired protected timestamp records owned by poll_jobs_stats jobs.|float|count|
|`jobs_poll_jobs_stats_fail_or_cancel_completed`|Number of poll_jobs_stats jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_poll_jobs_stats_fail_or_cancel_failed`|Number of poll_jobs_stats jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_poll_jobs_stats_fail_or_cancel_retry_error`|Number of poll_jobs_stats jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_poll_jobs_stats_protected_age_sec`|The age of the oldest PTS record protected by poll_jobs_stats jobs.|float|s|
|`jobs_poll_jobs_stats_protected_record`|Number of protected timestamp records held by poll_jobs_stats jobs.|float|count|
|`jobs_poll_jobs_stats_resume_completed`|Number of poll_jobs_stats jobs which successfully resumed to completion.|float|count|
|`jobs_poll_jobs_stats_resume_failed`|Number of poll_jobs_stats jobs which failed with a non-retryable error.|float|count|
|`jobs_poll_jobs_stats_resume_retry_error`|Number of poll_jobs_stats jobs which failed with a retryable error.|float|count|
|`jobs_replication_stream_ingestion_currently_idle`|Number of replication_stream_ingestion jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_replication_stream_ingestion_currently_paused`|Number of replication_stream_ingestion jobs currently considered Paused.|float|count|
|`jobs_replication_stream_ingestion_currently_running`|Number of replication_stream_ingestion jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_replication_stream_ingestion_expired_pts_records`|Number of expired protected timestamp records owned by replication_stream_ingestion jobs.|float|count|
|`jobs_replication_stream_ingestion_fail_or_cancel_completed`|Number of replication_stream_ingestion jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_replication_stream_ingestion_fail_or_cancel_failed`|Number of replication_stream_ingestion jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_replication_stream_ingestion_fail_or_cancel_retry_error`|Number of replication_stream_ingestion jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_replication_stream_ingestion_protected_age_sec`|The age of the oldest PTS record protected by replication_stream_ingestion jobs.|float|s|
|`jobs_replication_stream_ingestion_protected_record`|Number of protected timestamp records held by replication_stream_ingestion jobs.|float|count|
|`jobs_replication_stream_ingestion_resume_completed`|Number of replication_stream_ingestion jobs which successfully resumed to completion.|float|count|
|`jobs_replication_stream_ingestion_resume_failed`|Number of replication_stream_ingestion jobs which failed with a non-retryable error.|float|count|
|`jobs_replication_stream_ingestion_resume_retry_error`|Number of replication_stream_ingestion jobs which failed with a retryable error.|float|count|
|`jobs_replication_stream_producer_currently_idle`|Number of replication_stream_producer jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_replication_stream_producer_currently_paused`|Number of replication_stream_producer jobs currently considered Paused.|float|count|
|`jobs_replication_stream_producer_currently_running`|Number of replication_stream_producer jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_replication_stream_producer_expired_pts_records`|Number of expired protected timestamp records owned by replication_stream_producer jobs.|float|count|
|`jobs_replication_stream_producer_fail_or_cancel_completed`|Number of replication_stream_producer jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_replication_stream_producer_fail_or_cancel_failed`|Number of replication_stream_producer jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_replication_stream_producer_fail_or_cancel_retry_error`|Number of replication_stream_producer jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_replication_stream_producer_protected_age_sec`|The age of the oldest PTS record protected by replication_stream_producer jobs.|float|s|
|`jobs_replication_stream_producer_protected_record`|Number of protected timestamp records held by replication_stream_producer jobs.|float|count|
|`jobs_replication_stream_producer_resume_completed`|Number of replication_stream_producer jobs which successfully resumed to completion.|float|count|
|`jobs_replication_stream_producer_resume_failed`|Number of replication_stream_producer jobs which failed with a non-retryable error.|float|count|
|`jobs_replication_stream_producer_resume_retry_error`|Number of replication_stream_producer jobs which failed with a retryable error.|float|count|
|`jobs_restore_currently_idle`|Number of restore jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_restore_currently_paused`|Number of restore jobs currently considered Paused.|float|count|
|`jobs_restore_currently_running`|Number of restore jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_restore_expired_pts_records`|Number of expired protected timestamp records owned by restore jobs.|float|count|
|`jobs_restore_fail_or_cancel_completed`|Number of restore jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_restore_fail_or_cancel_failed`|Number of restore jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_restore_fail_or_cancel_retry_error`|Number of restore jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_restore_protected_age_sec`|The age of the oldest PTS record protected by restore jobs.|float|s|
|`jobs_restore_protected_record`|Number of protected timestamp records held by restore jobs.|float|count|
|`jobs_restore_resume_completed`|Number of restore jobs which successfully resumed to completion.|float|count|
|`jobs_restore_resume_failed`|Number of restore jobs which failed with a non-retryable error.|float|count|
|`jobs_restore_resume_retry_error`|Number of restore jobs which failed with a retryable error.|float|count|
|`jobs_resumed_claimed_jobs`|Number of claimed-jobs resumed in job-adopt iterations.|float|count|
|`jobs_row_level_ttl_currently_idle`|Number of row_level_ttl jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_row_level_ttl_currently_paused`|Number of row_level_ttl jobs currently considered Paused.|float|count|
|`jobs_row_level_ttl_currently_running`|Number of row_level_ttl jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_row_level_ttl_delete_duration_bucket`|Duration for delete requests during row level TTL.|float|ns|
|`jobs_row_level_ttl_delete_duration_count`|Duration for delete requests during row level TTL.|float|ns|
|`jobs_row_level_ttl_delete_duration_sum`|Duration for delete requests during row level TTL.|float|ns|
|`jobs_row_level_ttl_expired_pts_records`|Number of expired protected timestamp records owned by row_level_ttl jobs.|float|count|
|`jobs_row_level_ttl_fail_or_cancel_completed`|Number of row_level_ttl jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_row_level_ttl_fail_or_cancel_failed`|Number of row_level_ttl jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_row_level_ttl_fail_or_cancel_retry_error`|Number of row_level_ttl jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_row_level_ttl_num_active_spans`|Number of active spans the TTL job is deleting from.|float|count|
|`jobs_row_level_ttl_protected_age_sec`|The age of the oldest PTS record protected by row_level_ttl jobs.|float|s|
|`jobs_row_level_ttl_protected_record`|Number of protected timestamp records held by row_level_ttl jobs.|float|count|
|`jobs_row_level_ttl_protected_record_count`||float|count|
|`jobs_row_level_ttl_resume_completed`|Number of row_level_ttl jobs which successfully resumed to completion.|float|count|
|`jobs_row_level_ttl_resume_failed`|Number of row_level_ttl jobs which failed with a non-retryable error.|float|count|
|`jobs_row_level_ttl_resume_retry_error`|Number of row_level_ttl jobs which failed with a retryable error.|float|count|
|`jobs_row_level_ttl_rows_deleted`|Number of rows deleted by the row level TTL job.|float|count|
|`jobs_row_level_ttl_rows_selected`|Number of rows selected for deletion by the row level TTL job.|float|count|
|`jobs_row_level_ttl_select_duration_bucket`|Duration for select requests during row level TTL.|float|ns|
|`jobs_row_level_ttl_select_duration_count`|Duration for select requests during row level TTL.|float|ns|
|`jobs_row_level_ttl_select_duration_sum`|Duration for select requests during row level TTL.|float|ns|
|`jobs_row_level_ttl_span_total_duration_bucket`|Duration for processing a span during row level TTL.|float|ns|
|`jobs_row_level_ttl_span_total_duration_count`|Duration for processing a span during row level TTL.|float|ns|
|`jobs_row_level_ttl_span_total_duration_sum`|Duration for processing a span during row level TTL.|float|ns|
|`jobs_row_level_ttl_total_expired_rows`|Approximate number of rows that have expired the TTL on the TTL table.|float|count|
|`jobs_row_level_ttl_total_rows`|Approximate number of rows on the TTL table.|float|count|
|`jobs_running_non_idle`|Number of running jobs that are not idle.|float|count|
|`jobs_schema_change_currently_idle`|Number of schema_change jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_schema_change_currently_paused`|Number of schema_change jobs currently considered Paused.|float|count|
|`jobs_schema_change_currently_running`|Number of schema_change jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_schema_change_expired_pts_records`|Number of expired protected timestamp records owned by schema_change jobs.|float|count|
|`jobs_schema_change_fail_or_cancel_completed`|Number of schema_change jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_schema_change_fail_or_cancel_failed`|Number of schema_change jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_schema_change_fail_or_cancel_retry_error`|Number of schema_change jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_schema_change_gc_currently_idle`|Number of schema_change_gc jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_schema_change_gc_currently_paused`|Number of schema_change_gc jobs currently considered Paused.|float|count|
|`jobs_schema_change_gc_currently_running`|Number of schema_change_gc jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_schema_change_gc_expired_pts_records`|Number of expired protected timestamp records owned by schema_change_gc jobs.|float|count|
|`jobs_schema_change_gc_fail_or_cancel_completed`|Number of schema_change_gc jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_schema_change_gc_fail_or_cancel_failed`|Number of schema_change_gc jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_schema_change_gc_fail_or_cancel_retry_error`|Number of schema_change_gc jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_schema_change_gc_protected_age_sec`|The age of the oldest PTS record protected by schema_change_gc jobs.|float|s|
|`jobs_schema_change_gc_protected_record`|Number of protected timestamp records held by schema_change_gc jobs.|float|count|
|`jobs_schema_change_gc_resume_completed`|Number of schema_change_gc jobs which successfully resumed to completion.|float|count|
|`jobs_schema_change_gc_resume_failed`|Number of schema_change_gc jobs which failed with a non-retryable error.|float|count|
|`jobs_schema_change_gc_resume_retry_error`|Number of schema_change_gc jobs which failed with a retryable error.|float|count|
|`jobs_schema_change_protected_age_sec`|The age of the oldest PTS record protected by schema_change jobs.|float|s|
|`jobs_schema_change_protected_record`|Number of protected timestamp records held by schema_change jobs.|float|count|
|`jobs_schema_change_resume_completed`|Number of schema_change jobs which successfully resumed to completion.|float|count|
|`jobs_schema_change_resume_failed`|Number of schema_change jobs which failed with a non-retryable error.|float|count|
|`jobs_schema_change_resume_retry_error`|Number of schema_change jobs which failed with a retryable error.|float|count|
|`jobs_stream_replication_fail_or_cancel_failed`||float|count|
|`jobs_typedesc_schema_change_currently_idle`|Number of typedesc_schema_change jobs currently considered Idle and can be freely shut down.|float|count|
|`jobs_typedesc_schema_change_currently_paused`|Number of typedesc_schema_change jobs currently considered Paused.|float|count|
|`jobs_typedesc_schema_change_currently_running`|Number of typedesc_schema_change jobs currently running in Resume or OnFailOrCancel state.|float|count|
|`jobs_typedesc_schema_change_expired_pts_records`|Number of expired protected timestamp records owned by typedesc_schema_change jobs.|float|count|
|`jobs_typedesc_schema_change_fail_or_cancel_completed`|Number of typedesc_schema_change jobs which successfully completed their failure or cancellation process.|float|count|
|`jobs_typedesc_schema_change_fail_or_cancel_failed`|Number of typedesc_schema_change jobs which failed with a non-retryable error on their failure or cancellation process.|float|count|
|`jobs_typedesc_schema_change_fail_or_cancel_retry_error`|Number of typedesc_schema_change jobs which failed with a retryable error on their failure or cancellation process.|float|count|
|`jobs_typedesc_schema_change_protected_age_sec`|The age of the oldest PTS record protected by typedesc_schema_change jobs.|float|s|
|`jobs_typedesc_schema_change_protected_record`|Number of protected timestamp records held by typedesc_schema_change jobs.|float|count|
|`jobs_typedesc_schema_change_resume_completed`|Number of typedesc_schema_change jobs which successfully resumed to completion.|float|count|
|`jobs_typedesc_schema_change_resume_failed`|Number of typedesc_schema_change jobs which failed with a non-retryable error.|float|count|
|`jobs_typedesc_schema_change_resume_retry_error`|Number of typedesc_schema_change jobs which failed with a retryable error.|float|count|
|`keybytes`|[OpenMetrics v1 & v2] Number of bytes taken up by keys.|float|B|
|`keycount`|[OpenMetrics v1 & v2] Count of all keys.|float|count|
|`kv_allocator_load_based_lease_transfers_cannot_find_better_candidate`|The number of times the allocator determined that the lease was on the best possible replica.|float|count|
|`kv_allocator_load_based_lease_transfers_delta_not_significant`|The number of times the allocator determined that the delta between the existing store and the best candidate was not significant.|float|count|
|`kv_allocator_load_based_lease_transfers_existing_not_overfull`|The number of times the allocator determined that the lease was not on an overfull store.|float|count|
|`kv_allocator_load_based_lease_transfers_follow_the_workload`|The number of times the allocator determined that the lease should be transferred to another replica for locality.|float|count|
|`kv_allocator_load_based_lease_transfers_missing_stats_for_existing_stores`|The number of times the allocator was missing QPS stats for the leaseholder.|float|count|
|`kv_allocator_load_based_lease_transfers_should_transfer`|The number of times the allocator determined that the lease should be transferred to another replica for better load distribution.|float|count|
|`kv_allocator_load_based_replica_rebalancing_cannot_find_better_candidate`|The number of times the allocator determined that the range was on the best possible stores.|float|count|
|`kv_allocator_load_based_replica_rebalancing_delta_not_significant`|The number of times the allocator determined that the delta between an existing store and the best replacement candidate was not high enough.|float|count|
|`kv_allocator_load_based_replica_rebalancing_existing_not_overfull`|The number of times the allocator determined that none of the range's replicas were on overfull stores.|float|count|
|`kv_allocator_load_based_replica_rebalancing_missing_stats_for_existing_store`|The number of times the allocator was missing the QPS stats for the existing store.|float|count|
|`kv_allocator_load_based_replica_rebalancing_should_transfer`|The number of times the allocator determined that the replica should be rebalanced to another store for better load distribution.|float|count|
|`kv_closed_timestamp_max_behind_nanos`|Largest latency between real-time and replica max closed timestamp.|float|ns|
|`kv_concurrency_avg_lock_hold_duration_nanos`|Average lock hold duration across locks currently held in lock tables. Does not include replicated locks (intents) that are not held in memory.|float|ns|
|`kv_concurrency_avg_lock_wait_duration_nanos`|Average lock wait duration across requests currently waiting in lock wait-queues.|float|ns|
|`kv_concurrency_lock_wait_queue_waiters`|Number of requests actively waiting in a lock wait-queue.|float|count|
|`kv_concurrency_locks`|Number of active locks held in lock tables. Does not include replicated locks (intents) that are not held in memory.|float|count|
|`kv_concurrency_locks_with_wait_queues`|Number of active locks held in lock tables with active wait-queues.|float|count|
|`kv_concurrency_max_lock_hold_duration_nanos`|Maximum length of time any lock in a lock table is held. Does not include replicated locks (intents) that are not held in memory.|float|ns|
|`kv_concurrency_max_lock_wait_duration_nanos`|Maximum lock wait duration across requests currently waiting in lock wait-queues.|float|ns|
|`kv_concurrency_max_lock_wait_queue_waiters_for_lock`|Maximum number of requests actively waiting in any single lock wait-queue.|float|count|
|`kv_loadsplitter_nosplitkey`|Load-based splitter could not find a split key.|float|count|
|`kv_loadsplitter_popularkey`|Load-based splitter could not find a split key and the most popular sampled split key occurs in >= 25% of the samples.|float|count|
|`kv_prober_planning_attempts`|Number of attempts at planning out probes made; in order to probe KV, we need to plan out which ranges to probe.|float|count|
|`kv_prober_planning_failures`|Number of attempts at planning out probes that failed; in order to probe KV, we need to plan out which ranges to probe. If planning fails, then kv prober is not able to send probes to all ranges. Consider alerting on this metric as a result.|float|count|
|`kv_prober_read_attempts`|Number of attempts made to read probe KV, regardless of outcome.|float|count|
|`kv_prober_read_failures`|Number of attempts made to read probe KV that failed, whether due to error or timeout.|float|count|
|`kv_prober_read_latency_bucket`|Latency of successful KV read probes.|float|ns|
|`kv_prober_read_latency_count`|Latency of successful KV read probes.|float|ns|
|`kv_prober_read_latency_sum`|Latency of successful KV read probes.|float|ns|
|`kv_prober_write_attempts`|Number of attempts made to write probe KV, regardless of outcome.|float|count|
|`kv_prober_write_failures`|Number of attempts made to write probe KV that failed, whether due to error or timeout.|float|count|
|`kv_prober_write_latency_bucket`|Latency of successful KV write probes.|float|ns|
|`kv_prober_write_latency_count`|Latency of successful KV write probes.|float|ns|
|`kv_prober_write_latency_sum`|Latency of successful KV write probes.|float|ns|
|`kv_prober_write_quarantine_oldest_duration`|The duration that the oldest range in the write quarantine pool has remained.|float|s|
|`kv_protectedts_reconciliation_errors`|Number of errors encountered during reconciliation runs on this node.|float|count|
|`kv_protectedts_reconciliation_num_runs`|Number of successful reconciliation runs on this node.|float|count|
|`kv_protectedts_reconciliation_records_processed`|Number of records processed without error during reconciliation on this node.|float|count|
|`kv_protectedts_reconciliation_records_removed`|Number of records removed during reconciliation runs on this node.|float|count|
|`kv_rangefeed_budget_allocation_blocked`|Number of times RangeFeed waited for budget availability.|float|count|
|`kv_rangefeed_budget_allocation_failed`|Number of times RangeFeed failed because memory budget was exceeded.|float|count|
|`kv_rangefeed_catchup_scan_nanos`|Time spent in RangeFeed catchup scan.|float|ns|
|`kv_rangefeed_mem_shared`|Memory usage by range feeds.|float|B|
|`kv_rangefeed_mem_system`|Memory usage by range feeds on system ranges.|float|B|
|`kv_rangefeed_processors_goroutine`|Number of active RangeFeed processors using goroutines.|float|count|
|`kv_rangefeed_processors_scheduler`|Number of active RangeFeed processors using scheduler.|float|count|
|`kv_rangefeed_registrations`|Number of active RangeFeed registrations.|float|count|
|`kv_rangefeed_scheduler_normal_latency_bucket`|KV RangeFeed normal scheduler latency.|float|ns|
|`kv_rangefeed_scheduler_normal_latency_count`|KV RangeFeed normal scheduler latency.|float|ns|
|`kv_rangefeed_scheduler_normal_latency_sum`|KV RangeFeed normal scheduler latency.|float|ns|
|`kv_rangefeed_scheduler_normal_queue_size`|Number of entries in the KV RangeFeed normal scheduler queue.|float|count|
|`kv_rangefeed_scheduler_system_latency_bucket`|KV RangeFeed system scheduler latency.|float|ns|
|`kv_rangefeed_scheduler_system_latency_count`|KV RangeFeed system scheduler latency.|float|ns|
|`kv_rangefeed_scheduler_system_latency_sum`|KV RangeFeed system scheduler latency.|float|ns|
|`kv_rangefeed_scheduler_system_queue_size`|Number of entries in the KV RangeFeed system scheduler queue.|float|count|
|`kv_replica_circuit_breaker_num_tripped_events`|Number of times the per-Replica circuit breakers tripped since process start.|float|count|
|`kv_replica_circuit_breaker_num_tripped_replicas`|Number of Replicas for which the per-Replica circuit breaker is currently tripped. A nonzero value indicates range or replica unavailability and should be investigated. Replicas in this state will fail-fast all inbound requests.|float|count|
|`kv_replica_read_batch_evaluate_dropped_latches_before_eval`|Number of times read-only batches dropped latches before evaluation.|float|count|
|`kv_replica_read_batch_evaluate_latency_bucket`|Execution duration for evaluating a BatchRequest on the read-only path after latches have been acquired. A measurement is recorded regardless of outcome (i.e., also in case of an error). If internal retries occur, each instance is recorded separately.|float|ns|
|`kv_replica_read_batch_evaluate_latency_count`|Execution duration for evaluating a BatchRequest on the read-only path after latches have been acquired. A measurement is recorded regardless of outcome (i.e., also in case of an error). If internal retries occur, each instance is recorded separately.|float|ns|
|`kv_replica_read_batch_evaluate_latency_sum`|Execution duration for evaluating a BatchRequest on the read-only path after latches have been acquired. A measurement is recorded regardless of outcome (i.e., also in case of an error). If internal retries occur, each instance is recorded separately.|float|ns|
|`kv_replica_read_batch_evaluate_without_interleaving_iter`|Number of read-only batches evaluated without an intent interleaving iterator.|float|count|
|`kv_replica_write_batch_evaluate_latency_bucket`|Execution duration for evaluating a BatchRequest on the read-write path after latches have been acquired. A measurement is recorded regardless of outcome (i.e., also in case of an error). If internal retries occur, each instance is recorded separately. Note that the measurement does not include the duration for replicating the evaluated command.|float|ns|
|`kv_replica_write_batch_evaluate_latency_count`|Execution duration for evaluating a BatchRequest on the read-write path after latches have been acquired. A measurement is recorded regardless of outcome (i.e., also in case of an error). If internal retries occur, each instance is recorded separately. Note that the measurement does not include the duration for replicating the evaluated command.|float|ns|
|`kv_replica_write_batch_evaluate_latency_sum`|Execution duration for evaluating a BatchRequest on the read-write path after latches have been acquired. A measurement is recorded regardless of outcome (i.e., also in case of an error). If internal retries occur, each instance is recorded separately. Note that the measurement does not include the duration for replicating the evaluated command.|float|ns|
|`kv_tenant_rate_limit_current_blocked`|Number of requests currently blocked by the rate limiter.|float|count|
|`kv_tenant_rate_limit_num_tenants`|Number of tenants currently being tracked.|float|count|
|`kv_tenant_rate_limit_read_batches_admitted`|Number of read batches admitted by the rate limiter.|float|count|
|`kv_tenant_rate_limit_read_bytes_admitted`|Number of read bytes admitted by the rate limiter.|float|B|
|`kv_tenant_rate_limit_read_requests_admitted`|Number of read requests admitted by the rate limiter.|float|count|
|`kv_tenant_rate_limit_write_batches_admitted`|Number of write batches admitted by the rate limiter.|float|count|
|`kv_tenant_rate_limit_write_bytes_admitted`|Number of write bytes admitted by the rate limiter.|float|B|
|`kv_tenant_rate_limit_write_requests_admitted`|Number of write requests admitted by the rate limiter.|float|count|
|`kvadmission_flow_controller_elastic_blocked_stream_count`|Number of replication streams with no flow tokens available for elastic requests.|float|count|
|`kvadmission_flow_controller_elastic_requests_admitted`|Number of elastic requests admitted by the flow controller.|float|count|
|`kvadmission_flow_controller_elastic_requests_bypassed`|Number of elastic waiting requests that bypassed the flow controller due to disconnecting streams.|float|count|
|`kvadmission_flow_controller_elastic_requests_errored`|Number of elastic requests that errored out while waiting for flow tokens.|float|count|
|`kvadmission_flow_controller_elastic_requests_waiting`|Number of elastic requests waiting for flow tokens.|float|count|
|`kvadmission_flow_controller_elastic_stream_count`|Total number of replication streams for elastic requests.|float|count|
|`kvadmission_flow_controller_elastic_tokens_available`|Flow tokens available for elastic requests, across all replication streams.|float|B|
|`kvadmission_flow_controller_elastic_tokens_deducted`|Flow tokens deducted by elastic requests, across all replication streams.|float|B|
|`kvadmission_flow_controller_elastic_tokens_returned`|Flow tokens returned by elastic requests, across all replication streams.|float|B|
|`kvadmission_flow_controller_elastic_tokens_unaccounted`|Flow tokens returned by elastic requests that were unaccounted for, across all replication streams.|float|B|
|`kvadmission_flow_controller_elastic_wait_duration_bucket`|Latency histogram for time elastic requests spent waiting for flow tokens.|float|ns|
|`kvadmission_flow_controller_elastic_wait_duration_count`|Latency histogram for time elastic requests spent waiting for flow tokens.|float|ns|
|`kvadmission_flow_controller_elastic_wait_duration_sum`|Latency histogram for time elastic requests spent waiting for flow tokens.|float|ns|
|`kvadmission_flow_controller_regular_blocked_stream_count`|Number of replication streams with no flow tokens available for regular requests.|float|count|
|`kvadmission_flow_controller_regular_requests_admitted`|Number of regular requests admitted by the flow controller.|float|count|
|`kvadmission_flow_controller_regular_requests_bypassed`|Number of regular waiting requests that bypassed the flow controller due to disconnecting streams.|float|count|
|`kvadmission_flow_controller_regular_requests_errored`|Number of regular requests that errored out while waiting for flow tokens.|float|count|
|`kvadmission_flow_controller_regular_requests_waiting`|Number of regular requests waiting for flow tokens.|float|count|
|`kvadmission_flow_controller_regular_stream_count`|Total number of replication streams for regular requests.|float|count|
|`kvadmission_flow_controller_regular_tokens_available`|Flow tokens available for regular requests, across all replication streams.|float|B|
|`kvadmission_flow_controller_regular_tokens_deducted`|Flow tokens deducted by regular requests, across all replication streams.|float|B|
|`kvadmission_flow_controller_regular_tokens_returned`|Flow tokens returned by regular requests, across all replication streams.|float|B|
|`kvadmission_flow_controller_regular_tokens_unaccounted`|Flow tokens returned by regular requests that were unaccounted for, across all replication streams.|float|B|
|`kvadmission_flow_controller_regular_wait_duration_bucket`|Latency histogram for time regular requests spent waiting for flow tokens.|float|ns|
|`kvadmission_flow_controller_regular_wait_duration_count`|Latency histogram for time regular requests spent waiting for flow tokens.|float|ns|
|`kvadmission_flow_controller_regular_wait_duration_sum`|Latency histogram for time regular requests spent waiting for flow tokens.|float|ns|
|`kvadmission_flow_handle_elastic_requests_admitted`|Number of elastic requests admitted by the flow handle.|float|count|
|`kvadmission_flow_handle_elastic_requests_errored`|Number of elastic requests that errored out while waiting for flow tokens, at the handle level.|float|count|
|`kvadmission_flow_handle_elastic_requests_waiting`|Number of elastic requests waiting for flow tokens, at the handle level.|float|count|
|`kvadmission_flow_handle_elastic_wait_duration_bucket`|Latency histogram for time elastic requests spent waiting for flow tokens, at the handle level.|float|ns|
|`kvadmission_flow_handle_elastic_wait_duration_count`|Latency histogram for time elastic requests spent waiting for flow tokens, at the handle level.|float|ns|
|`kvadmission_flow_handle_elastic_wait_duration_sum`|Latency histogram for time elastic requests spent waiting for flow tokens, at the handle level.|float|ns|
|`kvadmission_flow_handle_regular_requests_admitted`|Number of regular requests admitted by the flow handle.|float|count|
|`kvadmission_flow_handle_regular_requests_errored`|Number of regular requests that errored out while waiting for flow tokens, at the handle level.|float|count|
|`kvadmission_flow_handle_regular_requests_waiting`|Number of regular requests waiting for flow tokens, at the handle level.|float|count|
|`kvadmission_flow_handle_regular_wait_duration_bucket`|Latency histogram for time regular requests spent waiting for flow tokens, at the handle level.|float|ns|
|`kvadmission_flow_handle_regular_wait_duration_count`|Latency histogram for time regular requests spent waiting for flow tokens, at the handle level.|float|ns|
|`kvadmission_flow_handle_regular_wait_duration_sum`|Latency histogram for time regular requests spent waiting for flow tokens, at the handle level.|float|ns|
|`kvadmission_flow_handle_streams_connected`|Number of times we've connected to a stream, at the handle level.|float|count|
|`kvadmission_flow_handle_streams_disconnected`|Number of times we've disconnected from a stream, at the handle level.|float|count|
|`kvadmission_flow_token_dispatch_coalesced_elastic`|Number of coalesced elastic flow token dispatches (where we're informing the sender of a higher log entry being admitted).|float|count|
|`kvadmission_flow_token_dispatch_coalesced_regular`|Number of coalesced regular flow token dispatches (where we're informing the sender of a higher log entry being admitted).|float|count|
|`kvadmission_flow_token_dispatch_local_elastic`|Number of local elastic flow token dispatches.|float|count|
|`kvadmission_flow_token_dispatch_local_regular`|Number of local regular flow token dispatches.|float|count|
|`kvadmission_flow_token_dispatch_pending_elastic`|Number of pending elastic flow token dispatches.|float|count|
|`kvadmission_flow_token_dispatch_pending_nodes`|Number of nodes pending flow token dispatches.|float|count|
|`kvadmission_flow_token_dispatch_pending_regular`|Number of pending regular flow token dispatches.|float|count|
|`kvadmission_flow_token_dispatch_remote_elastic`|Number of remote elastic flow token dispatches.|float|count|
|`kvadmission_flow_token_dispatch_remote_regular`|Number of remote regular flow token dispatches.|float|count|
|`lastupdatenanos`|[OpenMetrics v1 & v2] Time in nanoseconds since Unix epoch at which bytes/keys/intents metrics were last updated.|float|ns|
|`leases_epoch`|[OpenMetrics v1 & v2] Number of replica leaseholders using epoch-based leases.|float|count|
|`leases_error`|[OpenMetrics v1] Number of failed lease requests.|float|count|
|`leases_error_count`|[OpenMetrics v2] Number of failed lease requests.|float|count|
|`leases_expiration`|[OpenMetrics v1 & v2] Number of replica leaseholders using expiration-based leases.|float|count|
|`leases_liveness`|Number of replica leaseholders for the liveness range(s).|float|count|
|`leases_preferences_less_preferred`|Number of replica leaseholders which satisfy a lease preference which is not the most preferred.|float|count|
|`leases_preferences_violating`|Number of replica leaseholders which violate lease preferences.|float|count|
|`leases_requests_latency_bucket`|Lease request latency (all types and outcomes, coalesced).|float|ns|
|`leases_requests_latency_count`|Lease request latency (all types and outcomes, coalesced).|float|ns|
|`leases_requests_latency_sum`|Lease request latency (all types and outcomes, coalesced).|float|ns|
|`leases_success`|[OpenMetrics v1] Number of successful lease requests.|float|count|
|`leases_success_count`|[OpenMetrics v2] Number of successful lease requests.|float|count|
|`leases_transfers_error`|[OpenMetrics v1] Number of failed lease transfers.|float|count|
|`leases_transfers_error_count`|[OpenMetrics v2] Number of failed lease transfers.|float|count|
|`leases_transfers_success`|[OpenMetrics v1] Number of successful lease transfers.|float|count|
|`leases_transfers_success_count`|[OpenMetrics v2] Number of successful lease transfers.|float|count|
|`livebytes`|[OpenMetrics v1 & v2] Number of bytes of live data (keys plus values).|float|B|
|`livecount`|[OpenMetrics v1 & v2] Count of live keys.|float|count|
|`liveness_epochincrements`|[OpenMetrics v1] Number of times this node has incremented its liveness epoch.|float|count|
|`liveness_epochincrements_count`|[OpenMetrics v2] Number of times this node has incremented its liveness epoch.|float|count|
|`liveness_heartbeatfailures`|[OpenMetrics v1] Number of failed node liveness heartbeats from this node.|float|count|
|`liveness_heartbeatfailures_count`|[OpenMetrics v2] Number of failed node liveness heartbeats from this node.|float|count|
|`liveness_heartbeatlatency`|[OpenMetrics v1] Node liveness heartbeat latency in nanoseconds.|float|ns|
|`liveness_heartbeatlatency_bucket`|[OpenMetrics v2] Node liveness heartbeat latency in nanoseconds.|float|ns|
|`liveness_heartbeatlatency_count`|[OpenMetrics v2] Node liveness heartbeat latency in nanoseconds.|float|ns|
|`liveness_heartbeatlatency_sum`|[OpenMetrics v2] Node liveness heartbeat latency in nanoseconds.|float|ns|
|`liveness_heartbeatsinflight`|Number of in-flight liveness heartbeats from this node.|float|count|
|`liveness_heartbeatsuccesses`|[OpenMetrics v1] Number of successful node liveness heartbeats from this node.|float|count|
|`liveness_heartbeatsuccesses_count`|[OpenMetrics v2] Number of successful node liveness heartbeats from this node.|float|count|
|`liveness_livenodes`|[OpenMetrics v1 & v2] Number of live nodes in the cluster (will be 0 if this node is not itself live).|float|count|
|`lockbytes`|Number of bytes taken up by replicated lock key-values (shared and exclusive strength, not intent strength).|float|B|
|`lockcount`|Count of replicated locks (shared, exclusive, and intent strength).|float|count|
|`log_buffered_messages_dropped`|Count of log messages that are dropped by buffered log sinks. When CockroachDB attempts to buffer a log message in a buffered log Sink whose buffer is already full, it drops the oldest buffered messages to make space for the new message.|float|count|
|`log_fluent_sink_conn_errors`|Number of connection errors experienced by fluent-server logging sinks.|float|count|
|`log_messages_count`|Count of messages logged on the node since startup. Note that this does not measure the fan-out of single log messages to the various configured logging sinks.|float|count|
|`node_id`|[OpenMetrics v1 & v2] Node ID with labels for advertised RPC and HTTP addresses.|float|count|
|`physical_replication_admit_latency_bucket`|Event admission latency: a difference between event Multi-Version Concurrency Control timestamp and the time it was admitted into ingestion processor.|float|ns|
|`physical_replication_admit_latency_count`|Event admission latency: a difference between event Multi-Version Concurrency Control timestamp and the time it was admitted into ingestion processor.|float|ns|
|`physical_replication_admit_latency_sum`|Event admission latency: a difference between event Multi-Version Concurrency Control timestamp and the time it was admitted into ingestion processor.|float|ns|
|`physical_replication_commit_latency_bucket`|Event commit latency: a difference between event Multi-Version Concurrency Control timestamp and the time it was flushed into disk. If we batch events, then the difference between the oldest event in the batch and flush is recorded.|float|ns|
|`physical_replication_commit_latency_count`|Event commit latency: a difference between event Multi-Version Concurrency Control timestamp and the time it was flushed into disk. If we batch events, then the difference between the oldest event in the batch and flush is recorded.|float|ns|
|`physical_replication_commit_latency_sum`|Event commit latency: a difference between event Multi-Version Concurrency Control timestamp and the time it was flushed into disk. If we batch events, then the difference between the oldest event in the batch and flush is recorded.|float|ns|
|`physical_replication_cutover_progress`|The number of ranges left to revert in order to complete an inflight cut over.|float|count|
|`physical_replication_distsql_replan_count`|Total number of dist SQL replanning events.|float|count|
|`physical_replication_earliest_data_checkpoint_span`|The earliest timestamp of the last checkpoint forwarded by an ingestion data processor.|float|count|
|`physical_replication_events_ingested`|Events ingested by all replication jobs.|float|count|
|`physical_replication_flush_hist_nanos_bucket`|Time spent flushing messages across all replication streams.|float|ns|
|`physical_replication_flush_hist_nanos_count`|Time spent flushing messages across all replication streams.|float|ns|
|`physical_replication_flush_hist_nanos_sum`|Time spent flushing messages across all replication streams.|float|ns|
|`physical_replication_flushes`|Total flushes across all replication jobs.|float|count|
|`physical_replication_job_progress_updates`|Total number of updates to the ingestion job progress.|float|count|
|`physical_replication_latest_data_checkpoint_span`|The latest timestamp of the last checkpoint forwarded by an ingestion data processor.|float|count|
|`physical_replication_logical_bytes`|Logical bytes (sum of keys + values) ingested by all replication jobs.|float|B|
|`physical_replication_replicated_time_seconds`|The replicated time of the physical replication stream in seconds since the Unix epoch.|float|s|
|`physical_replication_resolved_events_ingested`|Resolved events ingested by all replication jobs.|float|count|
|`physical_replication_running`|Number of currently running replication streams.|float|count|
|`physical_replication_sst_bytes`|SST bytes (compressed) sent to KV by all replication jobs.|float|B|
|`queue_consistency_pending`|[OpenMetrics v1 & v2] Number of pending replicas in the consistency checker queue.|float|count|
|`queue_consistency_process_failure`|[OpenMetrics v1] Number of replicas which failed processing in the consistency checker queue.|float|count|
|`queue_consistency_process_failure_count`|[OpenMetrics v2] Number of replicas which failed processing in the consistency checker queue.|float|count|
|`queue_consistency_process_success`|[OpenMetrics v1] Number of replicas successfully processed by the consistency checker queue.|float|count|
|`queue_consistency_process_success_count`|[OpenMetrics v2] Number of replicas successfully processed by the consistency checker queue.|float|count|
|`queue_consistency_processingnanos`|[OpenMetrics v1] Nanoseconds spent processing replicas in the consistency checker queue.|float|ns|
|`queue_consistency_processingnanos_count`|[OpenMetrics v2] Nanoseconds spent processing replicas in the consistency checker queue.|float|ns|
|`queue_gc_info_abortspanconsidered`|[OpenMetrics v1] Number of AbortSpan entries old enough to be considered for removal.|float|count|
|`queue_gc_info_abortspanconsidered_count`|[OpenMetrics v2] Number of AbortSpan entries old enough to be considered for removal.|float|count|
|`queue_gc_info_abortspangcnum`|[OpenMetrics v1] Number of AbortSpan entries fit for removal.|float|count|
|`queue_gc_info_abortspangcnum_count`|[OpenMetrics v2] Number of AbortSpan entries fit for removal.|float|count|
|`queue_gc_info_abortspanscanned`|[OpenMetrics v1] Number of transactions present in the AbortSpan scanned from the engine.|float|percent|
|`queue_gc_info_abortspanscanned_count`|[OpenMetrics v2] Number of transactions present in the AbortSpan scanned from the engine.|float|percent|
|`queue_gc_info_clearrangefailed`|Number of failed ClearRange operations during GC.|float|count|
|`queue_gc_info_clearrangesuccess`|Number of successful ClearRange operations during GC.|float|count|
|`queue_gc_info_enqueuehighpriority`|Number of replicas enqueued for GC with high priority.|float|count|
|`queue_gc_info_intentsconsidered`|[OpenMetrics v1] Number of 'old' intents.|float|count|
|`queue_gc_info_intentsconsidered_count`|[OpenMetrics v2] Number of 'old' intents.|float|count|
|`queue_gc_info_intenttxns`|[OpenMetrics v1] Number of associated distinct transactions.|float|percent|
|`queue_gc_info_intenttxns_count`|[OpenMetrics v2] Number of associated distinct transactions.|float|percent|
|`queue_gc_info_numkeysaffected`|[OpenMetrics v1] Number of keys with GC'able data.|float|count|
|`queue_gc_info_numkeysaffected_count`|[OpenMetrics v2] Number of keys with GC'able data.|float|count|
|`queue_gc_info_numrangekeysaffected`|Number of range keys GC'able.|float|count|
|`queue_gc_info_pushtxn`|[OpenMetrics v1] Number of attempted pushes.|float|count|
|`queue_gc_info_pushtxn_count`|[OpenMetrics v2] Number of attempted pushes.|float|count|
|`queue_gc_info_resolvefailed`|Number of cleanup intent failures during GC.|float|count|
|`queue_gc_info_resolvesuccess`|[OpenMetrics v1] Number of successful intent resolutions.|float|count|
|`queue_gc_info_resolvesuccess_count`|[OpenMetrics v2] Number of successful intent resolutions.|float|count|
|`queue_gc_info_resolvetotal`|[OpenMetrics v1] Number of attempted intent resolutions.|float|count|
|`queue_gc_info_resolvetotal_count`|[OpenMetrics v2] Number of attempted intent resolutions.|float|count|
|`queue_gc_info_transactionresolvefailed`|Number of intent cleanup failures for local transactions during GC.|float|count|
|`queue_gc_info_transactionspangcaborted`|[OpenMetrics v1] Number of GC'able entries corresponding to aborted txns.|float|count|
|`queue_gc_info_transactionspangcaborted_count`|[OpenMetrics v2] Number of GC'able entries corresponding to aborted txns.|float|count|
|`queue_gc_info_transactionspangccommitted`|[OpenMetrics v1] Number of GC'able entries corresponding to committed txns.|float|count|
|`queue_gc_info_transactionspangccommitted_count`|[OpenMetrics v2] Number of GC'able entries corresponding to committed txns.|float|count|
|`queue_gc_info_transactionspangcpending`|[OpenMetrics v1] Number of GC'able entries corresponding to pending txns.|float|count|
|`queue_gc_info_transactionspangcpending_count`|[OpenMetrics v2] Number of GC'able entries corresponding to pending txns.|float|count|
|`queue_gc_info_transactionspangcstaging`|Number of GC'able entries corresponding to staging txns.|float|count|
|`queue_gc_info_transactionspanscanned`|[OpenMetrics v1] Number of entries in transaction spans scanned from the engine.|float|count|
|`queue_gc_info_transactionspanscanned_count`|[OpenMetrics v2] Number of entries in transaction spans scanned from the engine.|float|count|
|`queue_gc_pending`|[OpenMetrics v1 & v2] Number of pending replicas in the GC queue.|float|count|
|`queue_gc_process_failure`|[OpenMetrics v1] Number of replicas which failed processing in the GC queue.|float|count|
|`queue_gc_process_failure_count`|[OpenMetrics v2] Number of replicas which failed processing in the GC queue.|float|count|
|`queue_gc_process_success`|[OpenMetrics v1] Number of replicas successfully processed by the GC queue.|float|count|
|`queue_gc_process_success_count`|[OpenMetrics v2] Number of replicas successfully processed by the GC queue.|float|count|
|`queue_gc_processingnanos`|[OpenMetrics v1] Nanoseconds spent processing replicas in the GC queue.|float|ns|
|`queue_gc_processingnanos_count`|[OpenMetrics v2] Nanoseconds spent processing replicas in the GC queue.|float|ns|
|`queue_merge_pending`|Number of pending replicas in the merge queue.|float|count|
|`queue_merge_process_failure`|Number of replicas which failed processing in the merge queue.|float|count|
|`queue_merge_process_success`|Number of replicas successfully processed by the merge queue.|float|count|
|`queue_merge_processingnanos`|Nanoseconds spent processing replicas in the merge queue.|float|ns|
|`queue_merge_purgatory`|Number of replicas in the merge queue's purgatory, waiting to become merge-able.|float|count|
|`queue_raftlog_pending`|[OpenMetrics v1 & v2] Number of pending replicas in the Raft log queue.|float|count|
|`queue_raftlog_process_failure`|[OpenMetrics v1] Number of replicas which failed processing in the Raft log queue.|float|count|
|`queue_raftlog_process_failure_count`|[OpenMetrics v2] Number of replicas which failed processing in the Raft log queue.|float|count|
|`queue_raftlog_process_success`|[OpenMetrics v1] Number of replicas successfully processed by the Raft log queue.|float|count|
|`queue_raftlog_process_success_count`|[OpenMetrics v2] Number of replicas successfully processed by the Raft log queue.|float|count|
|`queue_raftlog_processingnanos`|[OpenMetrics v1] Nanoseconds spent processing replicas in the Raft log queue.|float|ns|
|`queue_raftlog_processingnanos_count`|[OpenMetrics v2] Nanoseconds spent processing replicas in the Raft log queue.|float|ns|
|`queue_raftsnapshot_pending`|[OpenMetrics v1 & v2] Number of pending replicas in the Raft repair queue.|float|count|
|`queue_raftsnapshot_process_failure`|[OpenMetrics v1] Number of replicas which failed processing in the Raft repair queue.|float|count|
|`queue_raftsnapshot_process_failure_count`|[OpenMetrics v2] Number of replicas which failed processing in the Raft repair queue.|float|count|
|`queue_raftsnapshot_process_success`|[OpenMetrics v1] Number of replicas successfully processed by the Raft repair queue.|float|count|
|`queue_raftsnapshot_process_success_count`|[OpenMetrics v2] Number of replicas successfully processed by the Raft repair queue.|float|count|
|`queue_raftsnapshot_processingnanos`|[OpenMetrics v1] Nanoseconds spent processing replicas in the Raft repair queue.|float|ns|
|`queue_raftsnapshot_processingnanos_count`|[OpenMetrics v2] Nanoseconds spent processing replicas in the Raft repair queue.|float|ns|
|`queue_replicagc_pending`|[OpenMetrics v1 & v2] Number of pending replicas in the replica GC queue.|float|count|
|`queue_replicagc_process_failure`|[OpenMetrics v1] Number of replicas which failed processing in the replica GC queue.|float|count|
|`queue_replicagc_process_failure_count`|[OpenMetrics v2] Number of replicas which failed processing in the replica GC queue.|float|count|
|`queue_replicagc_process_success`|[OpenMetrics v1] Number of replicas successfully processed by the replica GC queue.|float|count|
|`queue_replicagc_process_success_count`|[OpenMetrics v2] Number of replicas successfully processed by the replica GC queue.|float|count|
|`queue_replicagc_processingnanos`|[OpenMetrics v1] Nanoseconds spent processing replicas in the replica GC queue.|float|ns|
|`queue_replicagc_processingnanos_count`|[OpenMetrics v2] Nanoseconds spent processing replicas in the replica GC queue.|float|ns|
|`queue_replicagc_removereplica`|[OpenMetrics v1] Number of replica removals attempted by the replica GC queue.|float|count|
|`queue_replicagc_removereplica_count`|[OpenMetrics v2] Number of replica removals attempted by the replica GC queue.|float|count|
|`queue_replicate_addnonvoterreplica`|Number of non-voter replica additions attempted by the replicate queue.|float|count|
|`queue_replicate_addreplica`|[OpenMetrics v1] Number of replica additions attempted by the replicate queue.|float|count|
|`queue_replicate_addreplica_count`|[OpenMetrics v2] Number of replica additions attempted by the replicate queue.|float|count|
|`queue_replicate_addreplica_error`|Number of failed replica additions processed by the replicate queue.|float|count|
|`queue_replicate_addreplica_success`|Number of successful replica additions processed by the replicate queue.|float|count|
|`queue_replicate_addvoterreplica`|Number of voter replica additions attempted by the replicate queue.|float|count|
|`queue_replicate_nonvoterpromotions`|Number of non-voters promoted to voters by the replicate queue.|float|count|
|`queue_replicate_pending`|[OpenMetrics v1 & v2] Number of pending replicas in the replicate queue.|float|count|
|`queue_replicate_process_failure`|[OpenMetrics v1] Number of replicas which failed processing in the replicate queue.|float|count|
|`queue_replicate_process_failure_count`|[OpenMetrics v2] Number of replicas which failed processing in the replicate queue.|float|count|
|`queue_replicate_process_success`|[OpenMetrics v1] Number of replicas successfully processed by the replicate queue.|float|count|
|`queue_replicate_process_success_count`|[OpenMetrics v2] Number of replicas successfully processed by the replicate queue.|float|count|
|`queue_replicate_processingnanos`|[OpenMetrics v1] Nanoseconds spent processing replicas in the replicate queue.|float|ns|
|`queue_replicate_processingnanos_count`|[OpenMetrics v2] Nanoseconds spent processing replicas in the replicate queue.|float|ns|
|`queue_replicate_purgatory`|[OpenMetrics v1 & v2] Number of replicas in the replicate queue's purgatory, awaiting allocation options.|float|count|
|`queue_replicate_rebalancenonvoterreplica`|Number of non-voter replica `rebalancer-initiated` additions attempted by the replicate queue.|float|count|
|`queue_replicate_rebalancereplica`|[OpenMetrics v1] Number of replica `rebalancer-initiated` additions attempted by the replicate queue.|float|count|
|`queue_replicate_rebalancereplica_count`|[OpenMetrics v2] Number of replica `rebalancer-initiated` additions attempted by the replicate queue.|float|count|
|`queue_replicate_rebalancevoterreplica`|Number of voter replica `rebalancer-initiated` additions attempted by the replicate queue.|float|count|
|`queue_replicate_removedeadnonvoterreplica`|Number of dead non-voter replica removals attempted by the replicate queue (typically in response to a node outage).|float|count|
|`queue_replicate_removedeadreplica`|[OpenMetrics v1] Number of dead replica removals attempted by the replicate queue (typically in response to a node outage).|float|count|
|`queue_replicate_removedeadreplica_count`|[OpenMetrics v2] Number of dead replica removals attempted by the replicate queue (typically in response to a node outage).|float|count|
|`queue_replicate_removedeadreplica_error`|Number of failed dead replica removals processed by the replicate queue.|float|count|
|`queue_replicate_removedeadreplica_success`|Number of successful dead replica removals processed by the replicate queue.|float|count|
|`queue_replicate_removedeadvoterreplica`|Number of dead voter replica removals attempted by the replicate queue (typically in response to a node outage).|float|count|
|`queue_replicate_removedecommissioningnonvoterreplica`|Number of decommissioning non-voter replica removals attempted by the replicate queue (typically in response to a node outage).|float|count|
|`queue_replicate_removedecommissioningreplica`|Number of decommissioning replica removals attempted by the replicate queue (typically in response to a node outage).|float|count|
|`queue_replicate_removedecommissioningreplica_error`|Number of failed decommissioning replica removals processed by the replicate queue.|float|count|
|`queue_replicate_removedecommissioningreplica_success`|Number of successful decommissioning replica removals processed by the replicate queue.|float|count|
|`queue_replicate_removedecommissioningvoterreplica`|Number of decommissioning voter replica removals attempted by the replicate queue (typically in response to a node outage).|float|count|
|`queue_replicate_removelearnerreplica`|Number of learner replica removals attempted by the replicate queue (typically due to internal race conditions).|float|count|
|`queue_replicate_removenonvoterreplica`|Number of non-voter replica removals attempted by the replicate queue (typically in response to a `rebalancer-initiated` addition).|float|count|
|`queue_replicate_removereplica`|[OpenMetrics v1] Number of replica removals attempted by the replicate queue (typically in response to a `rebalancer-initiated` addition).|float|count|
|`queue_replicate_removereplica_count`|[OpenMetrics v2] Number of replica removals attempted by the replicate queue (typically in response to a `rebalancer-initiated` addition).|float|count|
|`queue_replicate_removereplica_error`|Number of failed replica removals processed by the replicate queue.|float|count|
|`queue_replicate_removereplica_success`|Number of successful replica removals processed by the replicate queue.|float|count|
|`queue_replicate_removevoterreplica`|Number of voter replica removals attempted by the replicate queue (typically in response to a `rebalancer-initiated` addition).|float|count|
|`queue_replicate_replacedeadreplica_error`|Number of failed dead replica replacements processed by the replicate queue.|float|count|
|`queue_replicate_replacedeadreplica_success`|Number of successful dead replica replacements processed by the replicate queue.|float|count|
|`queue_replicate_replacedecommissioningreplica_error`|Number of failed decommissioning replica replacements processed by the replicate queue.|float|count|
|`queue_replicate_replacedecommissioningreplica_success`|Number of successful decommissioning replica replacements processed by the replicate queue.|float|count|
|`queue_replicate_transferlease`|[OpenMetrics v1] Number of range lease transfers attempted by the replicate queue.|float|count|
|`queue_replicate_transferlease_count`|[OpenMetrics v2] Number of range lease transfers attempted by the replicate queue.|float|count|
|`queue_replicate_voterdemotions`|Number of voters demoted to non-voters by the replicate queue.|float|count|
|`queue_split_load_based`|Number of range splits due to a range being greater than the configured max range load.|float|count|
|`queue_split_pending`|[OpenMetrics v1 & v2] Number of pending replicas in the split queue.|float|count|
|`queue_split_process_failure`|[OpenMetrics v1] Number of replicas which failed processing in the split queue.|float|count|
|`queue_split_process_failure_count`|[OpenMetrics v2] Number of replicas which failed processing in the split queue.|float|count|
|`queue_split_process_success`|[OpenMetrics v1] Number of replicas successfully processed by the split queue.|float|count|
|`queue_split_process_success_count`|[OpenMetrics v2] Number of replicas successfully processed by the split queue.|float|count|
|`queue_split_processingnanos`|[OpenMetrics v1] Nanoseconds spent processing replicas in the split queue.|float|ns|
|`queue_split_processingnanos_count`|[OpenMetrics v2] Nanoseconds spent processing replicas in the split queue.|float|ns|
|`queue_split_purgatory`|Number of replicas in the split queue's purgatory, waiting to become split table.|float|count|
|`queue_split_size_based`|Number of range splits due to a range being greater than the configured max range size.|float|count|
|`queue_split_span_config_based`|Number of range splits due to span configuration.|float|count|
|`queue_tsmaintenance_pending`|[OpenMetrics v1 & v2] Number of pending replicas in the time series maintenance queue.|float|count|
|`queue_tsmaintenance_process_failure`|[OpenMetrics v1] Number of replicas which failed processing in the time series maintenance queue.|float|count|
|`queue_tsmaintenance_process_failure_count`|[OpenMetrics v2] Number of replicas which failed processing in the time series maintenance queue.|float|count|
|`queue_tsmaintenance_process_success`|[OpenMetrics v1] Number of replicas successfully processed by the time series maintenance queue.|float|count|
|`queue_tsmaintenance_process_success_count`|[OpenMetrics v2] Number of replicas successfully processed by the time series maintenance queue.|float|count|
|`queue_tsmaintenance_processingnanos`|[OpenMetrics v1] Nanoseconds spent processing replicas in the time series maintenance queue.|float|ns|
|`queue_tsmaintenance_processingnanos_count`|[OpenMetrics v2] Nanoseconds spent processing replicas in the time series maintenance queue.|float|ns|
|`raft_commands_proposed`|Number of Raft commands proposed. The number of proposals and all kinds of re-proposals made by leaseholders. This metric approximates the number of commands submitted through Raft.|float|count|
|`raft_commands_reproposed_new_lai`|Number of Raft commands re-proposed with a newer LAI. The number of Raft commands that leaseholders re-proposed with a modified LAI. Such re-proposals happen for commands that are committed to Raft out of intended order and hence cannot be applied as is.|float|count|
|`raft_commands_reproposed_unchanged`|Number of Raft commands re-proposed without modification. The number of Raft commands that leaseholders re-proposed without modification. Such re-proposals happen for commands that are not committed/applied within a timeout and have a high chance of being dropped.|float|count|
|`raft_commandsapplied`|[OpenMetrics v1] Count of Raft commands applied.|float|count|
|`raft_commandsapplied_count`|[OpenMetrics v2] Count of Raft commands applied.|float|count|
|`raft_dropped`|Number of Raft proposals dropped (this counts individual `raftpb.Entry`, not `raftpb.MsgProp`).|float|count|
|`raft_dropped_leader`|Number of Raft proposals dropped by a Replica that believes itself to be the leader; each update also increments raft.dropped (this counts individual `raftpb.Entry`, not `raftpb.MsgProp`).|float|count|
|`raft_enqueued_pending`|[OpenMetrics v1 & v2] Number of pending outgoing messages in the Raft Transport queue.|float|count|
|`raft_entrycache_accesses`|Number of cache lookups in the Raft entry cache.|float|count|
|`raft_entrycache_bytes`|Aggregate size of all Raft entries in the Raft entry cache.|float|B|
|`raft_entrycache_hits`|Number of successful cache lookups in the Raft entry cache.|float|count|
|`raft_entrycache_read_bytes`|Counter of bytes in entries returned from the Raft entry cache.|float|B|
|`raft_entrycache_size`|Number of Raft entries in the Raft entry cache.|float|count|
|`raft_heartbeats_pending`|[OpenMetrics v1 & v2] Number of pending heartbeats and responses waiting to be coalesced.|float|count|
|`raft_process_applycommitted_latency_bucket`|Latency histogram for applying all committed Raft commands in a Raft ready. This measures the end-to-end latency of applying all commands in a Raft ready. Note that this closes over possibly multiple measurements of the 'raft.process.commandcommit.latency' metric, which receives data points for each sub-batch processed in the process.|float|ns|
|`raft_process_applycommitted_latency_count`|Latency histogram for applying all committed Raft commands in a Raft ready. This measures the end-to-end latency of applying all commands in a Raft ready. Note that this closes over possibly multiple measurements of the 'raft.process.commandcommit.latency' metric, which receives data points for each sub-batch processed in the process.|float|ns|
|`raft_process_applycommitted_latency_sum`|Latency histogram for applying all committed Raft commands in a Raft ready. This measures the end-to-end latency of applying all commands in a Raft ready. Note that this closes over possibly multiple measurements of the 'raft.process.commandcommit.latency' metric, which receives data points for each sub-batch processed in the process.|float|ns|
|`raft_process_commandcommit_latency`|[OpenMetrics v1] Latency histogram in nanoseconds for committing Raft commands.|float|ns|
|`raft_process_commandcommit_latency_bucket`|[OpenMetrics v2] Latency histogram in nanoseconds for committing Raft commands.|float|ns|
|`raft_process_commandcommit_latency_count`|[OpenMetrics v2] Latency histogram in nanoseconds for committing Raft commands.|float|ns|
|`raft_process_commandcommit_latency_sum`|[OpenMetrics v2] Latency histogram in nanoseconds for committing Raft commands.|float|ns|
|`raft_process_handleready_latency_bucket`|Latency histogram for handling a Raft ready. This measures the end-to-end latency of the Raft state advancement loop, including:<br>- snapshot application<br>- SST ingestion<br>- durably appending to the Raft log (i.e., includes fsync)<br>- entry application (including replicated side effects, notably log truncation).|float|ns|
|`raft_process_handleready_latency_count`|Latency histogram for handling a Raft ready. This measures the end-to-end latency of the Raft state advancement loop, including:<br>- snapshot application<br>- SST ingestion<br>- durably appending to the Raft log (i.e., includes fsync)<br>- entry application (including replicated side effects, notably log truncation).|float|ns|
|`raft_process_handleready_latency_sum`|Latency histogram for handling a Raft ready. This measures the end-to-end latency of the Raft state advancement loop, including:<br>- snapshot application<br>- SST ingestion<br>- durably appending to the Raft log (i.e., includes fsync)<br>- entry application (including replicated side effects, notably log truncation).|float|ns|
|`raft_process_logcommit_latency`|[OpenMetrics v1] Latency histogram in nanoseconds for committing Raft log entries.|float|ns|
|`raft_process_logcommit_latency_bucket`|[OpenMetrics v2] Latency histogram in nanoseconds for committing Raft log entries.|float|ns|
|`raft_process_logcommit_latency_count`|[OpenMetrics v2] Latency histogram in nanoseconds for committing Raft log entries.|float|ns|
|`raft_process_logcommit_latency_sum`|[OpenMetrics v2] Latency histogram in nanoseconds for committing Raft log entries.|float|ns|
|`raft_process_tickingnanos`|[OpenMetrics v1] Nanoseconds spent in store.processRaft() processing replica.Tick().|float|ns|
|`raft_process_tickingnanos_count`|[OpenMetrics v2] Nanoseconds spent in store.processRaft() processing replica.Tick().|float|ns|
|`raft_process_workingnanos`|[OpenMetrics v1] Nanoseconds spent in store.processRaft() working.|float|ns|
|`raft_process_workingnanos_count`|[OpenMetrics v2] Nanoseconds spent in store.processRaft() working.|float|ns|
|`raft_quota_pool_percent_used_bucket`|Histogram of proposal quota pool utilization (0-100) per leaseholder per metrics interval.|float|count|
|`raft_quota_pool_percent_used_count`|Histogram of proposal quota pool utilization (0-100) per leaseholder per metrics interval.|float|count|
|`raft_quota_pool_percent_used_sum`|Histogram of proposal quota pool utilization (0-100) per leaseholder per metrics interval.|float|count|
|`raft_rcvd_app`|[OpenMetrics v1] Number of MsgApp messages received by this store.|float|count|
|`raft_rcvd_app_count`|[OpenMetrics v2] Number of MsgApp messages received by this store.|float|count|
|`raft_rcvd_appresp`|[OpenMetrics v1] Number of MsgAppResp messages received by this store.|float|count|
|`raft_rcvd_appresp_count`|[OpenMetrics v2] Number of MsgAppResp messages received by this store.|float|count|
|`raft_rcvd_bytes`|Number of bytes in Raft messages received by this store. Note that this does not include raft snapshot received.|float|B|
|`raft_rcvd_cross_region_bytes`|Number of bytes received by this store for cross-region Raft messages (when region tiers are configured). Note that this does not include raft snapshot received.|float|B|
|`raft_rcvd_cross_zone_bytes`|Number of bytes received by this store for cross-zone, same-region Raft messages (when region and zone tiers are configured). If region tiers are not configured, this count may include data sent between different regions.|float|B|
|`raft_rcvd_dropped`|[OpenMetrics v1] Number of dropped incoming Raft messages.|float|count|
|`raft_rcvd_dropped_bytes`|Bytes of dropped incoming Raft messages.|float|B|
|`raft_rcvd_dropped_count`|[OpenMetrics v2] Number of dropped incoming Raft messages.|float|count|
|`raft_rcvd_heartbeat`|[OpenMetrics v1] Number of (coalesced, if enabled) MsgHeartbeat messages received by this store.|float|count|
|`raft_rcvd_heartbeat_count`|[OpenMetrics v2] Number of (coalesced, if enabled) MsgHeartbeat messages received by this store.|float|count|
|`raft_rcvd_heartbeatresp`|[OpenMetrics v1] Number of (coalesced, if enabled) MsgHeartbeatResp messages received by this store.|float|count|
|`raft_rcvd_heartbeatresp_count`|[OpenMetrics v2] Number of (coalesced, if enabled) MsgHeartbeatResp messages received by this store.|float|count|
|`raft_rcvd_prevote`|[OpenMetrics v1] Number of MsgPreVote messages received by this store.|float|count|
|`raft_rcvd_prevote_count`|[OpenMetrics v2] Number of MsgPreVote messages received by this store.|float|count|
|`raft_rcvd_prevoteresp`|[OpenMetrics v1] Number of MsgPreVoteResp messages received by this store.|float|count|
|`raft_rcvd_prevoteresp_count`|[OpenMetrics v2] Number of MsgPreVoteResp messages received by this store.|float|count|
|`raft_rcvd_prop`|[OpenMetrics v1] Number of MsgProp messages received by this store.|float|count|
|`raft_rcvd_prop_count`|[OpenMetrics v2] Number of MsgProp messages received by this store.|float|count|
|`raft_rcvd_queued_bytes`|Number of bytes in messages currently waiting for Raft processing.|float|B|
|`raft_rcvd_snap`|[OpenMetrics v1] Number of MsgSnap messages received by this store.|float|count|
|`raft_rcvd_snap_count`|[OpenMetrics v2] Number of MsgSnap messages received by this store.|float|count|
|`raft_rcvd_stepped_bytes`|Number of bytes in messages processed by Raft. Messages reflected here have been handed to Raft (via RawNode.Step). This does not imply that the messages are no longer held in memory or that IO has been performed.|float|B|
|`raft_rcvd_timeoutnow`|[OpenMetrics v1] Number of MsgTimeoutNow messages received by this store.|float|count|
|`raft_rcvd_timeoutnow_count`|[OpenMetrics v2] Number of MsgTimeoutNow messages received by this store.|float|count|
|`raft_rcvd_transferleader`|[OpenMetrics v1] Number of MsgTransferLeader messages received by this store.|float|count|
|`raft_rcvd_transferleader_count`|[OpenMetrics v2] Number of MsgTransferLeader messages received by this store.|float|count|
|`raft_rcvd_vote`|[OpenMetrics v1] Number of MsgVote messages received by this store.|float|count|
|`raft_rcvd_vote_count`|[OpenMetrics v2] Number of MsgVote messages received by this store.|float|count|
|`raft_rcvd_voteresp`|[OpenMetrics v1] Number of MsgVoteResp messages received by this store.|float|count|
|`raft_rcvd_voteresp_count`|[OpenMetrics v2] Number of MsgVoteResp messages received by this store.|float|count|
|`raft_replication_latency_bucket`|The duration elapsed between having evaluated a BatchRequest and it being reflected in the proposer's state machine (i.e., having applied fully). This encompasses time spent in the quota pool, in replication (including re-proposals), and application, but notably not sequencing latency (i.e., contention and latch acquisition).|float|ns|
|`raft_replication_latency_count`|The duration elapsed between having evaluated a BatchRequest and it being reflected in the proposer's state machine (i.e., having applied fully). This encompasses time spent in the quota pool, in replication (including re-proposals), and application, but notably not sequencing latency (i.e., contention and latch acquisition).|float|count|
|`raft_replication_latency_sum`|The duration elapsed between having evaluated a BatchRequest and it being reflected in the proposer's state machine (i.e., having applied fully). This encompasses time spent in the quota pool, in replication (including re-proposals), and application, but notably not sequencing latency (i.e., contention and latch acquisition).|float|ns|
|`raft_scheduler_latency`|Queueing durations for ranges waiting to be processed by the Raft scheduler. This histogram measures the delay from when a range is registered with the scheduler for processing to when it is actually processed. This does not include the duration of processing.|float|ns|
|`raft_scheduler_latency_bucket`|Queueing durations for ranges waiting to be processed by the Raft scheduler. This histogram measures the delay from when a range is registered with the scheduler for processing to when it is actually processed. This does not include the duration of processing.|float|ns|
|`raft_scheduler_latency_count`|Queueing durations for ranges waiting to be processed by the Raft scheduler. This histogram measures the delay from when a range is registered with the scheduler for processing to when it is actually processed. This does not include the duration of processing.|float|ns|
|`raft_scheduler_latency_sum`|Queueing durations for ranges waiting to be processed by the Raft scheduler. This histogram measures the delay from when a range is registered with the scheduler for processing to when it is actually processed. This does not include the duration of processing.|float|ns|
|`raft_sent_bytes`|Number of bytes in Raft messages sent by this store. Note that this does not include raft snapshot sent.|float|B|
|`raft_sent_cross_region_bytes`|Number of bytes sent by this store for cross-region Raft messages (when region tiers are configured). Note that this does not include raft snapshot sent.|float|B|
|`raft_sent_cross_zone_bytes`|Number of bytes sent by this store for cross-zone, same-region Raft messages (when region and zone tiers are configured). If region tiers are not configured, this count may include data sent between different regions. To ensure accurate monitoring of transmitted data, it is important to set up a consistent locality configuration across nodes. Note that this does not include raft snapshot sent.|float|B|
|`raft_storage_read_bytes`|Counter of `raftpb.Entry.Size()` read from Pebble for Raft log entries. These are the bytes returned from the (raft.Storage).Entries method that were not returned via the Raft entry cache. This metric plus the `raft.entrycache.read_bytes` metric represent the total bytes returned from the Entries method.|float|B|
|`raft_ticks`|[OpenMetrics v1] Number of Raft ticks queued.|float|count|
|`raft_ticks_count`|[OpenMetrics v2] Number of Raft ticks queued.|float|count|
|`raft_timeoutcampaign`|Number of Raft replicas campaigning after missed heartbeats from leader.|float|count|
|`raft_transport_flow_token_dispatches_dropped`|Number of flow token dispatches dropped by the Raft Transport.|float|count|
|`raft_transport_rcvd`|Number of Raft messages received by the Raft Transport.|float|count|
|`raft_transport_reverse_rcvd`|Messages received from the reverse direction of a stream. These messages should be rare. They are mostly informational and are not actual responses to Raft messages. Responses are received over another stream.|float|count|
|`raft_transport_reverse_sent`|Messages sent in the reverse direction of a stream. These messages should be rare. They are mostly informational and are not actual responses to Raft messages. Responses are sent over another stream.|float|count|
|`raft_transport_send_queue_bytes`|The total byte size of pending outgoing messages in the queue. The queue is composed of multiple bounded channels associated with different peers. A size higher than the average baseline could indicate issues streaming messages to at least one peer. Use this metric together with send-queue-size to have a fuller picture.|float|B|
|`raft_transport_send_queue_size`|Number of pending outgoing messages in the Raft Transport queue. The queue is composed of multiple bounded channels associated with different peers. The overall size of tens of thousands could indicate issues streaming messages to at least one peer. Use this metric in conjunction with send-queue-bytes.|float|count|
|`raft_transport_sends_dropped`|Number of Raft message sends dropped by the Raft Transport.|float|count|
|`raft_transport_sent`|Number of Raft messages sent by the Raft Transport.|float|count|
|`raftlog_behind`|[OpenMetrics v1 & v2] Number of Raft log entries followers on other stores are behind.|float|count|
|`raftlog_truncated`|[OpenMetrics v1] Number of Raft log entries truncated.|float|count|
|`raftlog_truncated_count`|[OpenMetrics v2] Number of Raft log entries truncated.|float|count|
|`range_adds`|[OpenMetrics v1] Number of range additions.|float|count|
|`range_adds_count`|[OpenMetrics v2] Number of range additions.|float|count|
|`range_merges`|Number of range merges.|float|count|
|`range_raftleaderremovals`|Number of times the current Raft leader was removed from a range.|float|count|
|`range_raftleadertransfers`|[OpenMetrics v1] Number of Raft leader transfers.|float|count|
|`range_raftleadertransfers_count`|[OpenMetrics v2] Number of Raft leader transfers.|float|count|
|`range_recoveries`|Count of offline loss of quorum recovery operations performed on ranges. This count increments for every range recovered in an offline loss of quorum recovery operation. The metric is updated when the node on which the survivor replicates starts following the recovery.|float|count|
|`range_removes`|[OpenMetrics v1] Number of range removals.|float|count|
|`range_removes_count`|[OpenMetrics v2] Number of range removals.|float|count|
|`range_snapshots_applied_initial`|Number of snapshots applied for initial up replication.|float|count|
|`range_snapshots_applied_non_voter`|Number of snapshots applied by non-voter replicas.|float|count|
|`range_snapshots_applied_voter`|Number of snapshots applied by voter replicas.|float|count|
|`range_snapshots_cross_region_rcvd_bytes`|Number of snapshot bytes received cross-region.|float|B|
|`range_snapshots_cross_region_sent_bytes`|Number of snapshot bytes sent cross-region.|float|B|
|`range_snapshots_cross_zone_rcvd_bytes`|Number of snapshot bytes received cross-zone within the same region or if region tiers are not configured. This count increases for each snapshot received between different zones within the same region. However, if the region tiers are not configured, this count may also include snapshot data received between different regions.|float|B|
|`range_snapshots_cross_zone_sent_bytes`|Number of snapshot bytes sent cross-zone within the same region or if region tiers are not configured. This count increases for each snapshot sent between different zones within the same region. However, if the region tiers are not configured, this count may also include snapshot data sent between different regions.|float|B|
|`range_snapshots_delegate_failures`|Number of snapshots that were delegated to a different node and resulted in failure on that delegate. There are numerous reasons a failure can occur on a delegate, such as timeout, the delegate Raft log being too far behind, or the delegate being too busy to send.|float|count|
|`range_snapshots_delegate_in_progress`|Number of delegated snapshots that are currently in-flight.|float|count|
|`range_snapshots_delegate_sent_bytes`|Bytes sent using a delegate. The number of bytes sent as a result of a delegate snapshot request that was originated from a different node. This metric is useful for validating the network savings of not sending cross-region traffic.|float|B|
|`range_snapshots_delegate_successes`|Number of snapshots that were delegated to a different node and resulted in success on that delegate. This does not count self-delegated snapshots.|float|count|
|`range_snapshots_generated`|[OpenMetrics v1] Number of generated snapshots.|float|count|
|`range_snapshots_generated_count`|[OpenMetrics v2] Number of generated snapshots.|float|count|
|`range_snapshots_normal_applied`|[OpenMetrics v1] Number of applied snapshots.|float|count|
|`range_snapshots_normal_applied_count`|[OpenMetrics v2] Number of applied snapshots.|float|count|
|`range_snapshots_preemptive_applied`|[OpenMetrics v1] Number of applied preemptive snapshots.|float|count|
|`range_snapshots_preemptive_applied_count`|[OpenMetrics v2] Number of applied preemptive snapshots.|float|count|
|`range_snapshots_rcvd_bytes`|Number of snapshot bytes received.|float|B|
|`range_snapshots_rebalancing_rcvd_bytes`|Number of rebalancing snapshot bytes received.|float|B|
|`range_snapshots_rebalancing_sent_bytes`|Number of rebalancing snapshot bytes sent.|float|B|
|`range_snapshots_recovery_rcvd_bytes`|Number of recovery snapshot bytes received.|float|B|
|`range_snapshots_recovery_sent_bytes`|Number of recovery snapshot bytes sent.|float|B|
|`range_snapshots_recv_failed`|Number of range snapshot initialization messages that errored out on the recipient, typically before any data is transferred.|float|count|
|`range_snapshots_recv_in_progress`|Number of non-empty snapshots being received.|float|count|
|`range_snapshots_recv_queue`|Number of snapshots queued to receive.|float|count|
|`range_snapshots_recv_queue_bytes`|Total size of all snapshots in the snapshot receive queue.|float|B|
|`range_snapshots_recv_total_in_progress`|Number of total snapshots being received.|float|count|
|`range_snapshots_recv_unusable`|Number of range snapshots that were fully transmitted but determined to be unnecessary or unusable.|float|count|
|`range_snapshots_send_in_progress`|Number of non-empty snapshots being sent.|float|count|
|`range_snapshots_send_queue`|Number of snapshots queued to send.|float|count|
|`range_snapshots_send_queue_bytes`|Total size of all snapshots in the snapshot send queue.|float|B|
|`range_snapshots_send_total_in_progress`|Number of total snapshots being sent.|float|count|
|`range_snapshots_sent_bytes`|Number of snapshot bytes sent.|float|B|
|`range_snapshots_unknown_rcvd_bytes`|Number of unknown snapshot bytes received.|float|B|
|`range_snapshots_unknown_sent_bytes`|Number of unknown snapshot bytes sent.|float|B|
|`range_splits`|Number of range splits.|float|count|
|`range_splits_total`|[OpenMetrics v1] Number of range splits.|float|count|
|`range_splits_total_count`|[OpenMetrics v2] Number of range splits.|float|count|
|`rangekeybytes`|Number of bytes taken up by range keys (e.g., Multi-Version Concurrency Control range tombstones).|float|B|
|`rangekeycount`|Count of all range keys (e.g., Multi-Version Concurrency Control range tombstones).|float|count|
|`ranges`|[OpenMetrics v1 & v2] Number of ranges.|float|count|
|`ranges_overreplicated`|[OpenMetrics v1 & v2] Number of ranges with more live replicas than the replication target.|float|count|
|`ranges_unavailable`|[OpenMetrics v1 & v2] Number of ranges with fewer live replicas than needed for quorum.|float|count|
|`ranges_underreplicated`|[OpenMetrics v1 & v2] Number of ranges with fewer live replicas than the replication target.|float|count|
|`rangevalbytes`|Number of bytes taken up by range key values (e.g., Multi-Version Concurrency Control range tombstones).|float|B|
|`rangevalcount`|Count of all range key values (e.g., Multi-Version Concurrency Control range tombstones).|float|count|
|`rebalancing_cpunanospersecond`|Average CPU nanoseconds spent on processing replica operations in the last 30 minutes.|float|ns|
|`rebalancing_lease_transfers`|Number of lease transfers motivated by store-level load imbalances.|float|count|
|`rebalancing_queriespersecond`|Number of kv-level requests received per second by the store, averaged over a large time period as used in rebalancing decisions.|float|count|
|`rebalancing_range_rebalances`|Number of range rebalance operations motivated by store-level load imbalances.|float|count|
|`rebalancing_readbytespersecond`|Number of bytes read recently per second, considering the last 30 minutes.|float|B|
|`rebalancing_readspersecond`|Number of keys read recently per second, considering the last 30 minutes.|float|count|
|`rebalancing_replicas_cpunanospersecond_bucket`|Histogram of average CPU nanoseconds spent on processing replica operations in the last 30 minutes.|float|ns|
|`rebalancing_replicas_cpunanospersecond_count`|Histogram of average CPU nanoseconds spent on processing replica operations in the last 30 minutes.|float|ns|
|`rebalancing_replicas_cpunanospersecond_sum`|Histogram of average CPU nanoseconds spent on processing replica operations in the last 30 minutes.|float|ns|
|`rebalancing_replicas_queriespersecond_bucket`|Histogram of average kv-level requests received per second by replicas on the store in the last 30 minutes.|float|count|
|`rebalancing_replicas_queriespersecond_count`|Histogram of average kv-level requests received per second by replicas on the store in the last 30 minutes.|float|count|
|`rebalancing_replicas_queriespersecond_sum`|Histogram of average kv-level requests received per second by replicas on the store in the last 30 minutes.|float|count|
|`rebalancing_requestspersecond`|Number of requests received recently per second, considering the last 30 minutes.|float|count|
|`rebalancing_state_imbalanced_overfull_options_exhausted`|Number of occurrences where this store was overfull but failed to shed load after exhausting available rebalance options.|float|count|
|`rebalancing_writebytespersecond`|Number of bytes written recently per second, considering the last 30 minutes.|float|B|
|`rebalancing_writespersecond`|[OpenMetrics v1 & v2] Number of keys written (i.e., applied by Raft) per second to the store, averaged over a large time period as used in rebalancing decisions.|float|count|
|`replicas`|Number of replicas.|float|count|
|`replicas_commandqueue_combinedqueuesize`|[OpenMetrics v1 & v2] Number of commands in all CommandQueues combined.|float|count|
|`replicas_commandqueue_combinedreadcount`|[OpenMetrics v1 & v2] Number of read-only commands in all CommandQueues combined.|float|count|
|`replicas_commandqueue_combinedwritecount`|[OpenMetrics v1 & v2] Number of read-write commands in all CommandQueues combined.|float|count|
|`replicas_commandqueue_maxoverlaps`|[OpenMetrics v1 & v2] Largest number of overlapping commands seen when adding to any CommandQueue.|float|count|
|`replicas_commandqueue_maxreadcount`|[OpenMetrics v1 & v2] Largest number of read-only commands in any CommandQueue.|float|count|
|`replicas_commandqueue_maxsize`|[OpenMetrics v1 & v2] Largest number of commands in any CommandQueue.|float|count|
|`replicas_commandqueue_maxtreesize`|[OpenMetrics v1 & v2] Largest number of intervals in any CommandQueue's interval tree.|float|count|
|`replicas_commandqueue_maxwritecount`|[OpenMetrics v1 & v2] Largest number of read-write commands in any CommandQueue.|float|count|
|`replicas_leaders`|[OpenMetrics v1 & v2] Number of Raft leaders.|float|count|
|`replicas_leaders_invalid_lease`|Number of replicas that are Raft leaders whose lease is invalid.|float|count|
|`replicas_leaders_not_leaseholders`|Number of replicas that are Raft leaders whose range lease is held by another store.|float|count|
|`replicas_leaseholders`|[OpenMetrics v1 & v2] Number of lease holders.|float|count|
|`replicas_quiescent`|[OpenMetrics v1 & v2] Number of quiesced replicas.|float|count|
|`replicas_reserved`|[OpenMetrics v1 & v2] Number of replicas reserved for snapshots.|float|count|
|`replicas_total`|[OpenMetrics v1 & v2] Number of replicas.|float|count|
|`replicas_uninitialized`|Number of uninitialized replicas, this does not include uninitialized replicas that can lie dormant in a persistent state.|float|count|
|`replication_flush_hist_nanos_count`||float|count|
|`replication_flush_hist_nanos_sum`||float|count|
|`replication_flushes`||float|count|
|`replication_job_progress_updates`||float|count|
|`requests_backpressure_split`|[OpenMetrics v1 & v2] Number of back-pressured writes waiting on a Range split.|float|count|
|`requests_slow_commandqueue`|[OpenMetrics v1 & v2] Number of requests that have been stuck for a long time in the command queue.|float|count|
|`requests_slow_distsender`|[OpenMetrics v1 & v2] Number of requests that have been stuck for a long time in the dist sender.|float|count|
|`requests_slow_latch`|Number of requests that have been stuck for a long time acquiring latches. Latches moderate access to the KV key space for the purpose of evaluating and replicating commands. A slow latch acquisition attempt is often caused by another request holding and not releasing its latches in a timely manner.|float|count|
|`requests_slow_lease`|[OpenMetrics v1 & v2] Number of requests that have been stuck for a long time acquiring a lease.|float|count|
|`requests_slow_raft`|[OpenMetrics v1 & v2] Number of requests that have been stuck for a long time in Raft.|float|count|
|`rocksdb_block_cache_hits`|[OpenMetrics v1 & v2] Count of block cache hits.|float|count|
|`rocksdb_block_cache_misses`|[OpenMetrics v1 & v2] Count of block cache misses.|float|count|
|`rocksdb_block_cache_pinned_usage`|[OpenMetrics v1 & v2] Bytes pinned by the block cache.|float|B|
|`rocksdb_block_cache_usage`|[OpenMetrics v1 & v2] Bytes used by the block cache.|float|B|
|`rocksdb_bloom_filter_prefix_checked`|Number of times the bloom filter was checked.|float|count|
|`rocksdb_bloom_filter_prefix_useful`|Number of times the bloom filter helped avoid iterator creation.|float|count|
|`rocksdb_compacted_bytes_read`|Bytes read during compaction.|float|B|
|`rocksdb_compacted_bytes_written`|Bytes written during compaction.|float|B|
|`rocksdb_compactions`|Number of table compactions.|float|count|
|`rocksdb_compactions_total`|[OpenMetrics v1 & v2] Number of table compactions.|float|count|
|`rocksdb_encryption_algorithm`|Algorithm in use for encryption-at-rest, see `ccl/storageccl/engineccl/enginepbccl/key_registry.proto`.|float|count|
|`rocksdb_estimated_pending_compaction`|Estimated pending compaction bytes.|float|B|
|`rocksdb_flushed_bytes`|Bytes written during flush.|float|B|
|`rocksdb_flushes`|Number of table flushes.|float|count|
|`rocksdb_flushes_total`|[OpenMetrics v1 & v2] Number of table flushes.|float|count|
|`rocksdb_ingested_bytes`|Bytes ingested.|float|B|
|`rocksdb_memtable_total_size`|[OpenMetrics v1 & v2] Current size of mem table in bytes.|float|B|
|`rocksdb_num_sstables`|[OpenMetrics v1 & v2] Number of RocksDB SSTables.|float|count|
|`rocksdb_read_amplification`|[OpenMetrics v1 & v2] Number of disk reads per query.|float|count|
|`rocksdb_table_readers_mem_estimate`|[OpenMetrics v1 & v2] Memory used by index and filter blocks.|float|count|
|`round_trip_latency`|[OpenMetrics v1] Distribution of round-trip latencies with other nodes in nanoseconds.|float|ns|
|`round_trip_latency_bucket`|[OpenMetrics v2] Distribution of round-trip latencies with other nodes in nanoseconds.|float|ns|
|`round_trip_latency_count`|[OpenMetrics v2] Distribution of round-trip latencies with other nodes in nanoseconds.|float|ns|
|`round_trip_latency_sum`|[OpenMetrics v2] Distribution of round-trip latencies with other nodes in nanoseconds.|float|ns|
|`rpc_batches_recv`|Number of batches processed.|float|count|
|`rpc_connection_avg_round_trip_latency`|Sum of exponentially weighted moving average of round-trip latencies, as measured through a gRPC RPC. Dividing this Gauge by `rpc.connection.healthy` gives an approximation of average latency, but the top-level round-trip-latency histogram is more useful. Instead, users should consult the label families of this metric if they are available.|float|ns|
|`rpc_connection_failures`|Counter of failed connections. This includes both the event in which a healthy connection terminates as well as unsuccessful reconnection attempts. Connections that are terminated as part of local node shutdown are excluded. Decommissioned peers are excluded.|float|count|
|`rpc_connection_healthy`|Gauge of current connections in a healthy state (i.e., bidirectionally connected and heart beating).|float|count|
|`rpc_connection_healthy_nanos`|Gauge of nanoseconds of healthy connection time. On the Prometheus endpoint scraped with the cluster setting `server.child_metrics.enabled` set, the constituent parts of this metric are available on a per-peer basis, and one can read off for how long a given peer has been connected.|float|ns|
|`rpc_connection_heartbeats`|Counter of successful heartbeats.|float|count|
|`rpc_connection_inactive`|Gauge of current connections in an inactive state and pending deletion; these are not healthy but are not tracked as unhealthy either because there is reason to believe that the connection is no longer relevant, for example if the node has since been seen under a new address.|float|count|
|`rpc_connection_unhealthy`|Gauge of current connections in an unhealthy state (not bidirectionally connected or heart beating).|float|count|
|`rpc_connection_unhealthy_nanos`|Gauge of nanoseconds of unhealthy connection time. On the Prometheus endpoint scraped with the cluster setting `server.child_metrics.enabled` set, the constituent parts of this metric are available on a per-peer basis, and one can read off for how long a given peer has been unreachable.|float|ns|
|`rpc_method_addsstable_recv`|Number of AddSSTable requests processed.|float|count|
|`rpc_method_adminchangereplicas_recv`|Number of AdminChangeReplicas requests processed.|float|count|
|`rpc_method_adminmerge_recv`|Number of AdminMerge requests processed.|float|count|
|`rpc_method_adminrelocaterange_recv`|Number of AdminRelocateRange requests processed.|float|count|
|`rpc_method_adminscatter_recv`|Number of AdminScatter requests processed.|float|count|
|`rpc_method_adminsplit_recv`|Number of AdminSplit requests processed.|float|count|
|`rpc_method_admintransferlease_recv`|Number of AdminTransferLease requests processed.|float|count|
|`rpc_method_adminunsplit_recv`|Number of Admin un split requests processed.|float|count|
|`rpc_method_adminverifyprotectedtimestamp_recv`|Number of AdminVerifyProtectedTimestamp requests processed.|float|count|
|`rpc_method_barrier_recv`|Number of Barrier requests processed.|float|count|
|`rpc_method_checkconsistency_recv`|Number of CheckConsistency requests processed.|float|count|
|`rpc_method_clearrange_recv`|Number of ClearRange requests processed.|float|count|
|`rpc_method_computechecksum_recv`|Number of ComputeChecksum requests processed.|float|count|
|`rpc_method_conditionalput_recv`|Number of ConditionalPut requests processed.|float|count|
|`rpc_method_delete_recv`|Number of Delete requests processed.|float|count|
|`rpc_method_deleterange_recv`|Number of DeleteRange requests processed.|float|count|
|`rpc_method_endtxn_recv`|Number of EndTxn requests processed.|float|count|
|`rpc_method_export_recv`|Number of Export requests processed.|float|count|
|`rpc_method_gc_recv`|Number of GC requests processed.|float|count|
|`rpc_method_get_recv`|Number of Get requests processed.|float|count|
|`rpc_method_heartbeattxn_recv`|Number of HeartbeatTxn requests processed.|float|count|
|`rpc_method_increment_recv`|Number of Increment requests processed.|float|count|
|`rpc_method_initput_recv`|Number of InitPut requests processed.|float|count|
|`rpc_method_isspanempty_recv`|Number of IsSpanEmpty requests processed.|float|count|
|`rpc_method_leaseinfo_recv`|Number of LeaseInfo requests processed.|float|count|
|`rpc_method_merge_recv`|Number of Merge requests processed.|float|count|
|`rpc_method_migrate_recv`|Number of Migrate requests processed.|float|count|
|`rpc_method_probe_recv`|Number of Probe requests processed.|float|count|
|`rpc_method_pushtxn_recv`|Number of PushTxn requests processed.|float|count|
|`rpc_method_put_recv`|Number of Put requests processed.|float|count|
|`rpc_method_queryintent_recv`|Number of QueryIntent requests processed.|float|count|
|`rpc_method_querylocks_recv`|Number of QueryLocks requests processed.|float|count|
|`rpc_method_queryresolvedtimestamp_recv`|Number of QueryResolvedTimestamp requests processed.|float|count|
|`rpc_method_querytxn_recv`|Number of QueryTxn requests processed.|float|count|
|`rpc_method_rangestats_recv`|Number of RangeStats requests processed.|float|count|
|`rpc_method_recomputestats_recv`|Number of RecomputeStats requests processed.|float|count|
|`rpc_method_recovertxn_recv`|Number of RecoverTxn requests processed.|float|count|
|`rpc_method_refresh_recv`|Number of Refresh requests processed.|float|count|
|`rpc_method_refreshrange_recv`|Number of RefreshRange requests processed.|float|count|
|`rpc_method_requestlease_recv`|Number of RequestLease requests processed.|float|count|
|`rpc_method_resolveintent_recv`|Number of ResolveIntent requests processed.|float|count|
|`rpc_method_resolveintentrange_recv`|Number of ResolveIntentRange requests processed.|float|count|
|`rpc_method_reversescan_recv`|Number of ReverseScan requests processed.|float|count|
|`rpc_method_revertrange_recv`|Number of RevertRange requests processed.|float|count|
|`rpc_method_scan_recv`|Number of Scan requests processed.|float|count|
|`rpc_method_subsume_recv`|Number of Subsume requests processed.|float|count|
|`rpc_method_transferlease_recv`|Number of TransferLease requests processed.|float|count|
|`rpc_method_truncatelog_recv`|Number of TruncateLog requests processed.|float|count|
|`rpc_method_writebatch_recv`|Number of WriteBatch requests processed.|float|count|
|`rpc_streams_mux_rangefeed_active`|Number of currently running MuxRangeFeed streams.|float|count|
|`rpc_streams_mux_rangefeed_recv`|Total number of MuxRangeFeed streams.|float|count|
|`rpc_streams_rangefeed_active`|Number of currently running RangeFeed streams.|float|count|
|`rpc_streams_rangefeed_recv`|Total number of RangeFeed streams.|float|count|
|`schedules_BACKUP_failed`|Number of BACKUP jobs failed.|float|count|
|`schedules_BACKUP_last_completed_time`|The Unix timestamp of the most recently completed backup by a schedule specified as maintaining this metric.|float|s|
|`schedules_BACKUP_protected_age_sec`|The age of the oldest PTS record protected by BACKUP schedules.|float|s|
|`schedules_BACKUP_protected_record_count`|Number of PTS records held by BACKUP schedules.|float|count|
|`schedules_BACKUP_started`|Number of BACKUP jobs started.|float|count|
|`schedules_BACKUP_succeeded`|Number of BACKUP jobs succeeded.|float|count|
|`schedules_CHANGEFEED_failed`|Number of CHANGE FEED jobs failed.|float|count|
|`schedules_CHANGEFEED_started`|Number of CHANGE FEED jobs started.|float|count|
|`schedules_CHANGEFEED_succeeded`|Number of CHANGE FEED jobs succeeded.|float|count|
|`schedules_backup_failed`|[OpenMetrics v1] Number of scheduled backup jobs failed.|float|count|
|`schedules_backup_failed_count`|[OpenMetrics v2] Number of scheduled backup jobs failed.|float|count|
|`schedules_backup_last_completed_time`|[OpenMetrics v1 & v2] The Unix timestamp of the most recently completed backup by a schedule specified as maintaining this metric.|float|s|
|`schedules_backup_started`|[OpenMetrics v1] Number of scheduled backup jobs started.|float|count|
|`schedules_backup_started_count`|[OpenMetrics v2] Number of scheduled backup jobs started.|float|count|
|`schedules_backup_succeeded`|[OpenMetrics v1] Number of scheduled backup jobs succeeded.|float|count|
|`schedules_backup_succeeded_count`|[OpenMetrics v2] Number of scheduled backup jobs succeeded.|float|count|
|`schedules_error`|Number of schedules which did not execute successfully.|float|count|
|`schedules_malformed`|Number of malformed schedules.|float|count|
|`schedules_round_jobs_started`|The number of jobs started.|float|count|
|`schedules_round_reschedule_skip`|The number of schedules rescheduled due to SKIP policy.|float|count|
|`schedules_round_reschedule_wait`|The number of schedules rescheduled due to WAIT policy.|float|count|
|`schedules_scheduled_row_level_ttl_executor_failed`|Number of scheduled-row-level-ttl-executor jobs failed.|float|count|
|`schedules_scheduled_row_level_ttl_executor_started`|Number of scheduled-row-level-ttl-executor jobs started.|float|count|
|`schedules_scheduled_row_level_ttl_executor_succeeded`|Number of scheduled-row-level-ttl-executor jobs succeeded.|float|count|
|`schedules_scheduled_schema_telemetry_executor_failed`|Number of scheduled-schema-telemetry-executor jobs failed.|float|count|
|`schedules_scheduled_schema_telemetry_executor_started`|Number of scheduled-schema-telemetry-executor jobs started.|float|count|
|`schedules_scheduled_schema_telemetry_executor_succeeded`|Number of scheduled-schema-telemetry-executor jobs succeeded.|float|count|
|`schedules_scheduled_sql_stats_compaction_executor_failed`|Number of `scheduled-sql-stats-compaction-executor` jobs failed.|float|count|
|`schedules_scheduled_sql_stats_compaction_executor_started`|Number of `scheduled-sql-stats-compaction-executor` jobs started.|float|count|
|`schedules_scheduled_sql_stats_compaction_executor_succeeded`|Number of `scheduled-sql-stats-compaction-executor` jobs succeeded.|float|count|
|`seconds_until_enterprise_license_expiry`|Seconds until enterprise license expiry (0 if no license present or running without enterprise features).|float|count|
|`security_certificate_expiration_ca`|Expiration for the CA certificate. 0 means no certificate or error.|float|count|
|`security_certificate_expiration_ca_client_tenant`|Expiration for the Tenant Client CA certificate. 0 means no certificate or error.|float|count|
|`security_certificate_expiration_client`|Minimum expiration for client certificates, labeled by SQL user. 0 means no certificate or error.|float|count|
|`security_certificate_expiration_client_ca`|Expiration for the client CA certificate. 0 means no certificate or error.|float|count|
|`security_certificate_expiration_client_tenant`|Expiration for the Tenant Client certificate. 0 means no certificate or error.|float|count|
|`security_certificate_expiration_node`|Expiration for the node certificate. 0 means no certificate or error.|float|count|
|`security_certificate_expiration_node_client`|Expiration for the node's client certificate. 0 means no certificate or error.|float|count|
|`security_certificate_expiration_ui`|Expiration for the UI certificate. 0 means no certificate or error.|float|count|
|`security_certificate_expiration_ui_ca`|Expiration for the UI CA certificate. 0 means no certificate or error.|float|count|
|`spanconfig_kvsubscriber_oldest_protected_record_nanos`|Difference between the current time and the oldest protected timestamp (sudden drops indicate a record being released; an ever-increasing number indicates that the oldest record is around and preventing GC if > configured GC TTL).|float|ns|
|`spanconfig_kvsubscriber_protected_record_count`|Number of protected timestamp records, as seen by KV.|float|count|
|`spanconfig_kvsubscriber_update_behind_nanos`|Difference between the current time and when the KVSubscriber received its last update (an ever-increasing number indicates that we're no longer receiving updates).|float|ns|
|`sql_bytesin`|[OpenMetrics v1] Number of SQL bytes received.|float|B|
|`sql_bytesin_count`|[OpenMetrics v2] Number of SQL bytes received.|float|B|
|`sql_bytesout`|[OpenMetrics v1] Number of SQL bytes sent.|float|B|
|`sql_bytesout_count`|[OpenMetrics v2] Number of SQL bytes sent.|float|B|
|`sql_conn_failures`|Number of SQL connection failures.|float|count|
|`sql_conn_latency`|[OpenMetrics v1] Latency to establish and authenticate a SQL connection.|float|ns|
|`sql_conn_latency_bucket`|[OpenMetrics v2] Latency to establish and authenticate a SQL connection.|float|ns|
|`sql_conn_latency_count`|[OpenMetrics v2] Latency to establish and authenticate a SQL connection.|float|ns|
|`sql_conn_latency_sum`|[OpenMetrics v2] Latency to establish and authenticate a SQL connection.|float|ns|
|`sql_conns`|[OpenMetrics v1 & v2] Number of active SQL connections.|float|count|
|`sql_conns_waiting_to_hash`|Number of SQL connection attempts that are being throttled in order to limit password hashing concurrency.|float|count|
|`sql_contention_resolver_failed_resolutions`|Number of failed transaction ID resolution attempts.|float|count|
|`sql_contention_resolver_queue_size`|Length of queued unresolved contention events.|float|count|
|`sql_contention_resolver_retries`|Number of times transaction ID resolution has been retried.|float|count|
|`sql_contention_txn_id_cache_miss`|Number of cache misses.|float|count|
|`sql_contention_txn_id_cache_read`|Number of cache reads.|float|count|
|`sql_copy_count`|Number of COPY SQL statements successfully executed.|float|count|
|`sql_copy_internal`|Number of COPY SQL statements successfully executed (internal queries).|float|count|
|`sql_copy_nonatomic_count`|Number of non-atomic COPY SQL statements successfully executed.|float|count|
|`sql_copy_nonatomic_count_internal`||float|count|
|`sql_copy_nonatomic_internal`|Number of non-atomic COPY SQL statements successfully executed (internal queries).|float|count|
|`sql_copy_nonatomic_started_count`|Number of non-atomic COPY SQL statements started.|float|count|
|`sql_copy_nonatomic_started_internal`|Number of non-atomic COPY SQL statements started (internal queries).|float|count|
|`sql_copy_started_count`|Number of COPY SQL statements started.|float|count|
|`sql_copy_started_internal`|Number of COPY SQL statements started (internal queries).|float|count|
|`sql_ddl_count`|[OpenMetrics v1 & v2] Number of SQL DDL statements.|float|count|
|`sql_ddl_internal`|Number of SQL DDL statements successfully executed (internal queries).|float|count|
|`sql_ddl_started`|Number of SQL DDL statements started.|float|count|
|`sql_ddl_started_count`|Number of SQL DELETE statements started.|float|count|
|`sql_ddl_started_internal`|Number of SQL DDL statements started (internal queries).|float|count|
|`sql_delete_count`|[OpenMetrics v1 & v2] Number of SQL DELETE statements.|float|count|
|`sql_delete_internal`|Number of SQL DELETE statements successfully executed (internal queries).|float|count|
|`sql_delete_started_count`|Number of SQL DELETE statements started (internal queries).|float|count|
|`sql_delete_started_internal`|Number of SQL DELETE statements started (internal queries).|float|count|
|`sql_disk_distsql_current`|Current SQL statement disk usage for distributed SQL.|float|B|
|`sql_disk_distsql_max_bucket`|Disk usage per SQL statement for distributed SQL.|float|B|
|`sql_disk_distsql_max_count`|Disk usage per SQL statement for distributed SQL.|float|B|
|`sql_disk_distsql_max_sum`|Disk usage per SQL statement for distributed SQL.|float|B|
|`sql_disk_distsql_spilled_bytes_read`|Number of bytes read from temporary disk storage as a result of spilling.|float|B|
|`sql_disk_distsql_spilled_bytes_written`|Number of bytes written to temporary disk storage as a result of spilling.|float|B|
|`sql_distsql_contended_queries`|[OpenMetrics v1] Number of SQL queries that experienced contention.|float|count|
|`sql_distsql_contended_queries_count`|[OpenMetrics v2] Number of SQL queries that experienced contention.|float|count|
|`sql_distsql_dist_query_rerun_locally`|Total number of cases where a distributed query error resulted in a local rerun.|float|count|
|`sql_distsql_dist_query_rerun_locally_failure_count`|Total number of cases where the local rerun of a distributed query resulted in an error.|float|count|
|`sql_distsql_exec_latency`|[OpenMetrics v1] Latency in nanoseconds of DistSQL statement execution.|float|ns|
|`sql_distsql_exec_latency_bucket`|Latency of DistSQL statement execution.|float|ns|
|`sql_distsql_exec_latency_count`|[OpenMetrics v2] Latency in nanoseconds of DistSQL statement execution.|float|ns|
|`sql_distsql_exec_latency_internal_bucket`|Latency of DistSQL statement execution (internal queries).|float|ns|
|`sql_distsql_exec_latency_internal_count`|Latency of DistSQL statement execution (internal queries).|float|ns|
|`sql_distsql_exec_latency_internal_sum`|Latency of DistSQL statement execution (internal queries).|float|ns|
|`sql_distsql_exec_latency_sum`|[OpenMetrics v2] Latency in nanoseconds of DistSQL statement execution.|float|ns|
|`sql_distsql_flows`|[OpenMetrics v2] Number of distributed SQL flows executed.|float|count|
|`sql_distsql_flows_active`|[OpenMetrics v1 & v2] Number of distributed SQL flows currently active.|float|count|
|`sql_distsql_flows_total`|[OpenMetrics v1] Number of distributed SQL flows executed.|float|count|
|`sql_distsql_flows_total_count`|Number of distributed SQL flows executed.|float|count|
|`sql_distsql_queries`|[OpenMetrics v2] Number of distributed SQL queries executed.|float|count|
|`sql_distsql_queries_active`|[OpenMetrics v1 & v2] Number of distributed SQL queries currently active.|float|count|
|`sql_distsql_queries_spilled`|Number of queries that have spilled to disk.|float|count|
|`sql_distsql_queries_total`|[OpenMetrics v1] Number of distributed SQL queries executed.|float|count|
|`sql_distsql_select`|[OpenMetrics v1 & v2] Number of DistSQL SELECT statements.|float|count|
|`sql_distsql_select_internal`|Number of DistSQL SELECT statements (internal queries).|float|count|
|`sql_distsql_service_latency`|[OpenMetrics v1] Latency in nanoseconds of DistSQL request execution.|float|ns|
|`sql_distsql_service_latency_bucket`|[OpenMetrics v2] Latency in nanoseconds of DistSQL request execution.|float|ns|
|`sql_distsql_service_latency_count`|[OpenMetrics v2] Latency in nanoseconds of DistSQL request execution.|float|ns|
|`sql_distsql_service_latency_internal`|Latency of DistSQL request execution (internal queries).|float|ns|
|`sql_distsql_service_latency_internal_bucket`|Latency of DistSQL request execution (internal queries).|float|ns|
|`sql_distsql_service_latency_internal_count`|Latency of DistSQL request execution (internal queries).|float|ns|
|`sql_distsql_service_latency_internal_sum`|Latency of DistSQL request execution (internal queries).|float|ns|
|`sql_distsql_service_latency_sum`|[OpenMetrics v2] Latency in nanoseconds of DistSQL request execution.|float|ns|
|`sql_distsql_vec_openfds`|Current number of open file descriptors used by vectorized external storage.|float|count|
|`sql_exec_latency`|[OpenMetrics v1] Latency in nanoseconds of SQL statement execution.|float|ns|
|`sql_exec_latency_bucket`|[OpenMetrics v2] Latency in nanoseconds of SQL statement execution.|float|ns|
|`sql_exec_latency_count`|[OpenMetrics v2] Latency in nanoseconds of SQL statement execution.|float|ns|
|`sql_exec_latency_internal`|Latency of SQL statement execution (internal queries).|float|ns|
|`sql_exec_latency_internal_bucket`|Latency of SQL statement execution (internal queries).|float|ns|
|`sql_exec_latency_internal_count`|Latency of SQL statement execution (internal queries).|float|ns|
|`sql_exec_latency_internal_sum`|Latency of SQL statement execution (internal queries).|float|ns|
|`sql_exec_latency_sum`|[OpenMetrics v2] Latency in nanoseconds of SQL statement execution.|float|ns|
|`sql_failure`|[OpenMetrics v1] Number of statements resulting in a planning or runtime error.|float|count|
|`sql_failure_count`|[OpenMetrics v2] Number of statements resulting in a planning or runtime error.|float|count|
|`sql_failure_internal`|Number of statements resulting in a planning or runtime error (internal queries).|float|count|
|`sql_feature_flag_denial`|Counter of the number of statements denied by a feature flag.|float|count|
|`sql_full_scan`|[OpenMetrics v1] Number of full table or index scans.|float|count|
|`sql_full_scan_count`|[OpenMetrics v2] Number of full table or index scans.|float|count|
|`sql_full_scan_internal`|Number of full table or index scans (internal queries).|float|count|
|`sql_guardrails_full_scan_rejected`|Number of full table or index scans that have been rejected because of disallow_full_table_scans guardrail.|float|count|
|`sql_guardrails_full_scan_rejected_internal`|Number of full table or index scans that have been rejected because of disallow_full_table_scans guardrail (internal queries).|float|count|
|`sql_guardrails_max_row_size_err`|Number of rows observed violating `sql.guardrails.maxrowsize_err`.|float|count|
|`sql_guardrails_max_row_size_err_internal`|Number of rows observed violating `sql.guardrails.maxrowsize_err` (internal queries).|float|count|
|`sql_guardrails_max_row_size_log`|Number of rows observed violating `sql.guardrails.maxrowsize_log`.|float|count|
|`sql_guardrails_max_row_size_log_internal`|Number of rows observed violating `sql.guardrails.maxrowsize_log` (internal queries).|float|count|
|`sql_guardrails_transaction_rows_read_err`|Number of transactions errored because of transactionrowsread_err guardrail.|float|count|
|`sql_guardrails_transaction_rows_read_err_internal`|Number of transactions errored because of transactionrowsread_err guardrail (internal queries).|float|count|
|`sql_guardrails_transaction_rows_read_log`|Number of transactions logged because of transactionrowsread_log guardrail.|float|count|
|`sql_guardrails_transaction_rows_read_log_internal`|Number of transactions logged because of transactionrowsread_log guardrail (internal queries).|float|count|
|`sql_guardrails_transaction_rows_written_err`|Number of transactions errored because of transactionrowswritten_err guardrail.|float|count|
|`sql_guardrails_transaction_rows_written_err_internal`|Number of transactions errored because of transactionrowswritten_err guardrail (internal queries).|float|count|
|`sql_guardrails_transaction_rows_written_log`|Number of transactions logged because of transactionrowswritten_log guardrail.|float|count|
|`sql_guardrails_transaction_rows_written_log_internal`|Number of transactions logged because of transactionrowswritten_log guardrail (internal queries).|float|count|
|`sql_hydrated_schema_cache_hits`|Counter on the number of cache hits.|float|count|
|`sql_hydrated_schema_cache_misses`|Counter on the number of cache misses.|float|count|
|`sql_hydrated_table_cache_hits`|Counter on the number of cache hits.|float|count|
|`sql_hydrated_table_cache_misses`|Counter on the number of cache misses.|float|count|
|`sql_hydrated_type_cache_hits`|Counter on the number of cache hits.|float|count|
|`sql_hydrated_type_cache_misses`|Counter on the number of cache misses.|float|count|
|`sql_hydrated_udf_cache_hits`|Counter on the number of cache hits.|float|count|
|`sql_hydrated_udf_cache_misses`|Counter on the number of cache misses.|float|count|
|`sql_insert`|[OpenMetrics v1 & v2] Number of SQL INSERT statements.|float|count|
|`sql_insert_internal`|Number of SQL INSERT statements successfully executed (internal queries).|float|count|
|`sql_insert_started`|Number of SQL INSERT statements started.|float|count|
|`sql_insert_started_internal`|Number of SQL INSERT statements started (internal queries).|float|count|
|`sql_insights_anomaly_detection_evictions`|Evictions of fingerprint latency summaries due to memory pressure.|float|count|
|`sql_insights_anomaly_detection_fingerprints`|Current number of statement fingerprints being monitored for anomaly detection.|float|count|
|`sql_insights_anomaly_detection_memory`|Current memory used to support anomaly detection.|float|B|
|`sql_leases_active`|The number of outstanding SQL schema leases.|float|count|
|`sql_mem_admin_current`|[OpenMetrics v1 & v2] Current SQL statement memory usage for admin.|float|count|
|`sql_mem_admin_max`|[OpenMetrics v1] Memory usage per SQL statement for admin.|float|count|
|`sql_mem_admin_max_bucket`|[OpenMetrics v2] Memory usage per SQL statement for admin.|float|count|
|`sql_mem_admin_max_count`|[OpenMetrics v2] Memory usage per SQL statement for admin.|float|count|
|`sql_mem_admin_max_sum`|[OpenMetrics v2] Memory usage per SQL statement for admin.|float|count|
|`sql_mem_admin_session_current`|[OpenMetrics v1 & v2] Current SQL session memory usage for admin.|float|count|
|`sql_mem_admin_session_max_bucket`|[OpenMetrics v2] Memory usage per SQL session for admin.|float|count|
|`sql_mem_admin_session_max_count`|[OpenMetrics v2] Memory usage per SQL session for admin.|float|count|
|`sql_mem_admin_session_max_sum`|[OpenMetrics v2] Memory usage per SQL session for admin.|float|count|
|`sql_mem_admin_txn_current`|[OpenMetrics v1 & v2] Current SQL transaction memory usage for admin.|float|count|
|`sql_mem_admin_txn_max`|[OpenMetrics v1] Memory usage per SQL transaction for admin.|float|count|
|`sql_mem_admin_txn_max_bucket`|[OpenMetrics v2] Memory usage per SQL transaction for admin.|float|count|
|`sql_mem_admin_txn_max_count`|[OpenMetrics v2] Memory usage per SQL transaction for admin.|float|count|
|`sql_mem_admin_txn_max_sum`|[OpenMetrics v2] Memory usage per SQL transaction for admin.|float|count|
|`sql_mem_bulk_current`|Current SQL statement memory usage for bulk operations.|float|B|
|`sql_mem_bulk_max`|Memory usage per SQL statement for bulk operations.|float|B|
|`sql_mem_bulk_max_bucket`|Memory usage per SQL statement for bulk operations.|float|B|
|`sql_mem_bulk_max_count`|Memory usage per SQL statement for bulk operations.|float|B|
|`sql_mem_bulk_max_sum`|Memory usage per SQL statement for bulk operations.|float|B|
|`sql_mem_client_current`|[OpenMetrics v1 & v2] Current SQL statement memory usage for client.|float|count|
|`sql_mem_client_max`|[OpenMetrics v1] Memory usage per SQL statement for client.|float|count|
|`sql_mem_client_max_bucket`|[OpenMetrics v2] Memory usage per SQL statement for client.|float|count|
|`sql_mem_client_max_count`|[OpenMetrics v2] Memory usage per SQL statement for client.|float|count|
|`sql_mem_client_max_sum`|[OpenMetrics v2] Memory usage per SQL statement for client.|float|count|
|`sql_mem_client_session_current`|[OpenMetrics v1 & v2] Current SQL session memory usage for client.|float|count|
|`sql_mem_client_session_max`|[OpenMetrics v1] Memory usage per SQL session for client.|float|count|
|`sql_mem_client_session_max_bucket`|[OpenMetrics v2] Memory usage per SQL session for client.|float|count|
|`sql_mem_client_session_max_count`|[OpenMetrics v2] Memory usage per SQL session for client.|float|count|
|`sql_mem_client_session_max_sum`|[OpenMetrics v2] Memory usage per SQL session for client.|float|count|
|`sql_mem_client_txn_current`|[OpenMetrics v1 & v2] Current SQL transaction memory usage for client.|float|count|
|`sql_mem_client_txn_max`|[OpenMetrics v1] Memory usage per SQL transaction for client.|float|count|
|`sql_mem_client_txn_max_bucket`|[OpenMetrics v2] Memory usage per SQL transaction for client.|float|count|
|`sql_mem_client_txn_max_count`|[OpenMetrics v2] Memory usage per SQL transaction for client.|float|count|
|`sql_mem_client_txn_max_sum`|[OpenMetrics v2] Memory usage per SQL transaction for client.|float|count|
|`sql_mem_conns_current`|[OpenMetrics v1 & v2] Current SQL statement memory usage for conns.|float|count|
|`sql_mem_conns_max`|[OpenMetrics v1] Memory usage per SQL statement for conns.|float|count|
|`sql_mem_conns_max_bucket`|[OpenMetrics v2] Memory usage per SQL statement for conns.|float|count|
|`sql_mem_conns_max_count`|[OpenMetrics v2] Memory usage per SQL statement for conns.|float|count|
|`sql_mem_conns_max_sum`|[OpenMetrics v2] Memory usage per SQL statement for conns.|float|count|
|`sql_mem_conns_session_current`|[OpenMetrics v1 & v2] Current SQL session memory usage for conns.|float|count|
|`sql_mem_conns_session_max`|[OpenMetrics v1] Memory usage per SQL session for conns.|float|count|
|`sql_mem_conns_session_max_bucket`|[OpenMetrics v2] Memory usage per SQL session for conns.|float|count|
|`sql_mem_conns_session_max_count`|[OpenMetrics v2] Memory usage per SQL session for conns.|float|count|
|`sql_mem_conns_session_max_sum`|[OpenMetrics v2] Memory usage per SQL session for conns.|float|count|
|`sql_mem_conns_txn_current`|[OpenMetrics v1 & v2] Current SQL transaction memory usage for conns.|float|count|
|`sql_mem_conns_txn_max`|[OpenMetrics v1] Memory usage per SQL transaction for conns.|float|count|
|`sql_mem_conns_txn_max_bucket`|[OpenMetrics v2] Memory usage per SQL transaction for conns.|float|count|
|`sql_mem_conns_txn_max_count`|[OpenMetrics v2] Memory usage per SQL transaction for conns.|float|count|
|`sql_mem_conns_txn_max_sum`|[OpenMetrics v2] Memory usage per SQL transaction for conns.|float|count|
|`sql_mem_distsql_current`|[OpenMetrics v1 & v2] Current SQL statement memory usage for distributed SQL.|float|count|
|`sql_mem_distsql_max`|[OpenMetrics v1] Memory usage per SQL statement for distributed SQL.|float|count|
|`sql_mem_distsql_max_bucket`|[OpenMetrics v2] Memory usage per SQL statement for distributed SQL.|float|count|
|`sql_mem_distsql_max_count`|[OpenMetrics v2] Memory usage per SQL statement for distributed SQL.|float|count|
|`sql_mem_distsql_max_sum`|[OpenMetrics v2] Memory usage per SQL statement for distributed SQL.|float|count|
|`sql_mem_internal_current`|[OpenMetrics v1 & v2] Current SQL statement memory usage for internal.|float|count|
|`sql_mem_internal_max`|[OpenMetrics v1] Memory usage per SQL statement for internal.|float|count|
|`sql_mem_internal_max_bucket`|[OpenMetrics v2] Memory usage per SQL statement for internal.|float|count|
|`sql_mem_internal_max_count`|[OpenMetrics v2] Memory usage per SQL statement for internal.|float|count|
|`sql_mem_internal_max_sum`|[OpenMetrics v2] Memory usage per SQL statement for internal.|float|count|
|`sql_mem_internal_session_current`|[OpenMetrics v1 & v2] Current SQL session memory usage for internal.|float|count|
|`sql_mem_internal_session_max`|[OpenMetrics v1] Memory usage per SQL session for internal.|float|count|
|`sql_mem_internal_session_max_bucket`|[OpenMetrics v2] Memory usage per SQL session for internal.|float|count|
|`sql_mem_internal_session_max_count`|[OpenMetrics v2] Memory usage per SQL session for internal.|float|count|
|`sql_mem_internal_session_max_sum`|[OpenMetrics v2] Memory usage per SQL session for internal.|float|count|
|`sql_mem_internal_session_prepared_current`|Current SQL session memory usage by prepared statements for internal.|float|B|
|`sql_mem_internal_session_prepared_max_bucket`|Memory usage by prepared statements per SQL session for internal.|float|B|
|`sql_mem_internal_session_prepared_max_count`|Memory usage by prepared statements per SQL session for internal.|float|B|
|`sql_mem_internal_session_prepared_max_sum`|Memory usage by prepared statements per SQL session for internal.|float|B|
|`sql_mem_internal_txn_current`|[OpenMetrics v1 & v2] Current SQL transaction memory usage for internal.|float|count|
|`sql_mem_internal_txn_max`|[OpenMetrics v1] Memory usage per SQL transaction for internal.|float|count|
|`sql_mem_internal_txn_max_bucket`|[OpenMetrics v2] Memory usage per SQL transaction for internal.|float|count|
|`sql_mem_internal_txn_max_count`|[OpenMetrics v2] Memory usage per SQL transaction for internal.|float|count|
|`sql_mem_internal_txn_max_sum`|[OpenMetrics v2] Memory usage per SQL transaction for internal.|float|count|
|`sql_mem_root_current`|Current SQL statement memory usage for root.|float|count|
|`sql_mem_root_max_bucket`|Memory usage per SQL statement for root.|float|B|
|`sql_mem_root_max_count`|Memory usage per SQL statement for root.|float|B|
|`sql_mem_root_max_sum`|Memory usage per SQL statement for root.|float|B|
|`sql_mem_sql_current`|Current SQL statement memory usage for SQL.|float|B|
|`sql_mem_sql_max`|Memory usage per SQL statement for SQL.|float|B|
|`sql_mem_sql_max_bucket`|Memory usage per SQL statement for SQL.|float|B|
|`sql_mem_sql_max_count`|Memory usage per SQL statement for SQL.|float|B|
|`sql_mem_sql_max_sum`|Memory usage per SQL statement for SQL.|float|B|
|`sql_mem_sql_session_current`|Current SQL session memory usage for SQL.|float|B|
|`sql_mem_sql_session_max`|Memory usage per SQL session for SQL.|float|B|
|`sql_mem_sql_session_max_bucket`|Memory usage per SQL session for SQL.|float|B|
|`sql_mem_sql_session_max_count`|Memory usage per SQL session for SQL.|float|B|
|`sql_mem_sql_session_max_sum`|Memory usage per SQL session for SQL.|float|B|
|`sql_mem_sql_session_prepared_current`|Current SQL session memory usage by prepared statements for SQL.|float|B|
|`sql_mem_sql_session_prepared_max`|Memory usage by prepared statements per SQL session for SQL.|float|B|
|`sql_mem_sql_session_prepared_max_bucket`|Memory usage by prepared statements per SQL session for SQL.|float|B|
|`sql_mem_sql_session_prepared_max_count`|Memory usage by prepared statements per SQL session for SQL.|float|B|
|`sql_mem_sql_session_prepared_max_sum`|Memory usage by prepared statements per SQL session for SQL.|float|B|
|`sql_mem_sql_txn_current`|Current SQL transaction memory usage for SQL.|float|B|
|`sql_mem_sql_txn_max`|Memory usage per SQL transaction for SQL.|float|B|
|`sql_mem_sql_txn_max_bucket`|Memory usage per SQL transaction for SQL.|float|B|
|`sql_mem_sql_txn_max_count`|Memory usage per SQL transaction for SQL.|float|B|
|`sql_mem_sql_txn_max_sum`|Memory usage per SQL transaction for SQL.|float|B|
|`sql_misc`|[OpenMetrics v1 & v2] Number of other SQL statements.|float|count|
|`sql_misc_internal`|Number of other SQL statements successfully executed (internal queries).|float|count|
|`sql_misc_started`|Number of other SQL statements started.|float|count|
|`sql_misc_started_internal`|Number of other SQL statements started (internal queries).|float|count|
|`sql_new_conns`|Counter of the number of SQL connections created.|float|count|
|`sql_optimizer_fallback`|Number of statements which the cost-based optimizer was unable to plan.|float|count|
|`sql_optimizer_fallback_internal`|Number of statements which the cost-based optimizer was unable to plan (internal queries).|float|count|
|`sql_optimizer_plan_cache_hits`|Number of non-prepared statements for which a cached plan was used.|float|count|
|`sql_optimizer_plan_cache_hits_internal`|Number of non-prepared statements for which a cached plan was used (internal queries).|float|count|
|`sql_optimizer_plan_cache_misses`|Number of non-prepared statements for which a cached plan was not used.|float|count|
|`sql_optimizer_plan_cache_misses_internal`|Number of non-prepared statements for which a cached plan was not used (internal queries).|float|count|
|`sql_pgwire_cancel`|Number of PostgreSQL Wire Protocol query cancel requests.|float|count|
|`sql_pgwire_cancel_ignored`|Number of PostgreSQL Wire Protocol query cancel requests that were ignored due to rate limiting.|float|count|
|`sql_pgwire_cancel_successful`|Number of PostgreSQL Wire Protocol query cancel requests that were successful.|float|count|
|`sql_pre_serve_bytesin`|Number of SQL bytes received prior to routing the connection to the target SQL server.|float|B|
|`sql_pre_serve_bytesout`|Number of SQL bytes sent prior to routing the connection to the target SQL server.|float|B|
|`sql_pre_serve_conn_failures`|Number of SQL connection failures prior to routing the connection to the target SQL server.|float|count|
|`sql_pre_serve_mem_cur`|Current memory usage for SQL connections prior to routing the connection to the target SQL server.|float|B|
|`sql_pre_serve_mem_max`|Memory usage for SQL connections prior to routing the connection to the target SQL server.|float|B|
|`sql_pre_serve_mem_max_bucket`|Memory usage for SQL connections prior to routing the connection to the target SQL server.|float|B|
|`sql_pre_serve_mem_max_count`|Memory usage for SQL connections prior to routing the connection to the target SQL server.|float|B|
|`sql_pre_serve_mem_max_sum`|Memory usage for SQL connections prior to routing the connection to the target SQL server.|float|B|
|`sql_pre_serve_new_conns`|Number of SQL connections created prior to routing the connection to the target SQL server.|float|count|
|`sql_query`|[OpenMetrics v1 & v2] Number of SQL queries.|float|count|
|`sql_query_internal`|Number of SQL queries executed (internal queries).|float|count|
|`sql_query_started`|Number of SQL queries started.|float|count|
|`sql_query_started_internal`|Number of SQL queries started (internal queries).|float|count|
|`sql_restart_savepoint`|Number of SAVE POINT cockroach_restart statements successfully executed.|float|count|
|`sql_restart_savepoint_internal`|Number of SAVE POINT cockroach_restart statements successfully executed (internal queries).|float|count|
|`sql_restart_savepoint_release`|Number of RELEASE SAVE POINT cockroach_restart statements successfully executed.|float|count|
|`sql_restart_savepoint_release_internal`|Number of RELEASE SAVE POINT cockroach_restart statements successfully executed (internal queries).|float|count|
|`sql_restart_savepoint_release_started`|Number of RELEASE SAVE POINT cockroach_restart statements started.|float|count|
|`sql_restart_savepoint_release_started_internal`|Number of RELEASE SAVE POINT cockroach_restart statements started (internal queries).|float|count|
|`sql_restart_savepoint_rollback`|Number of ROLLBACK TO SAVE POINT cockroach_restart statements successfully executed.|float|count|
|`sql_restart_savepoint_rollback_internal`|Number of ROLLBACK TO SAVE POINT cockroach_restart statements successfully executed (internal queries).|float|count|
|`sql_restart_savepoint_rollback_started`|Number of ROLLBACK TO SAVE POINT cockroach_restart statements started.|float|count|
|`sql_restart_savepoint_rollback_started_internal`|Number of ROLLBACK TO SAVE POINT cockroach_restart statements started (internal queries).|float|count|
|`sql_restart_savepoint_started`|Number of SAVE POINT cockroach_restart statements started.|float|count|
|`sql_restart_savepoint_started_internal`|Number of SAVE POINT cockroach_restart statements started (internal queries).|float|count|
|`sql_savepoint`|Number of SQL SAVE POINT statements successfully executed.|float|count|
|`sql_savepoint_internal`|Number of SQL SAVE POINT statements successfully executed (internal queries).|float|count|
|`sql_savepoint_release`|Number of RELEASE SAVE POINT statements successfully executed.|float|count|
|`sql_savepoint_release_internal`|Number of RELEASE SAVE POINT statements successfully executed (internal queries).|float|count|
|`sql_savepoint_release_started`|Number of RELEASE SAVE POINT statements started.|float|count|
|`sql_savepoint_release_started_internal`|Number of RELEASE SAVE POINT statements started (internal queries).|float|count|
|`sql_savepoint_rollback`|Number of ROLLBACK TO SAVE POINT statements successfully executed.|float|count|
|`sql_savepoint_rollback_internal`|Number of ROLLBACK TO SAVE POINT statements successfully executed (internal queries).|float|count|
|`sql_savepoint_rollback_started`|Number of ROLLBACK TO SAVE POINT statements started.|float|count|
|`sql_savepoint_rollback_started_internal`|Number of ROLLBACK TO SAVE POINT statements started (internal queries).|float|count|
|`sql_savepoint_started`|Number of SQL SAVE POINT statements started.|float|count|
|`sql_savepoint_started_internal`|Number of SQL SAVE POINT statements started (internal queries).|float|count|
|`sql_schema_changer_permanent_errors`|Counter of the number of permanent errors experienced by the schema changer.|float|count|
|`sql_schema_changer_retry_errors`|Counter of the number of retryable errors experienced by the schema changer.|float|count|
|`sql_schema_changer_running`|Gauge of currently running schema changes.|float|count|
|`sql_schema_changer_successes`|Counter of the number of schema changer resumes which succeed.|float|count|
|`sql_schema_invalid_objects`|Gauge of detected invalid objects within the system.descriptor table (measured by querying `crdbinternal.invalid` objects).|float|count|
|`sql_select`|[OpenMetrics v1 & v2] Number of SQL SELECT statements.|float|count|
|`sql_select_internal`|Number of SQL SELECT statements successfully executed (internal queries).|float|count|
|`sql_select_started`|Number of SQL SELECT statements started.|float|count|
|`sql_select_started_internal`|Number of SQL SELECT statements started (internal queries).|float|count|
|`sql_service_latency`|[OpenMetrics v1] Latency in nanoseconds of SQL request execution.|float|ns|
|`sql_service_latency_bucket`|[OpenMetrics v2] Latency in nanoseconds of SQL request execution.|float|ns|
|`sql_service_latency_count`|[OpenMetrics v2] Latency in nanoseconds of SQL request execution.|float|ns|
|`sql_service_latency_internal`|Latency of SQL request execution (internal queries).|float|ns|
|`sql_service_latency_internal_bucket`|Latency of SQL request execution (internal queries).|float|ns|
|`sql_service_latency_internal_count`|Latency of SQL request execution (internal queries).|float|ns|
|`sql_service_latency_internal_sum`|Latency of SQL request execution (internal queries).|float|ns|
|`sql_service_latency_sum`|[OpenMetrics v2] Latency in nanoseconds of SQL request execution.|float|ns|
|`sql_statements_active`|[OpenMetrics v1 & v2] Number of currently active user SQL statements.|float|count|
|`sql_statements_active_internal`|Number of currently active user SQL statements (internal queries).|float|count|
|`sql_stats_cleanup_rows_removed`|Number of stale statistics rows that are removed.|float|count|
|`sql_stats_discarded_current`|Number of fingerprint statistics being discarded.|float|count|
|`sql_stats_flush`|Number of times SQL Stats are flushed to persistent storage.|float|count|
|`sql_stats_flush_duration`|Time taken in nanoseconds to complete SQL Stats flush.|float|ns|
|`sql_stats_flush_duration_bucket`|Time taken in nanoseconds to complete SQL Stats flush.|float|ns|
|`sql_stats_flush_duration_count`|Time taken in nanoseconds to complete SQL Stats flush.|float|ns|
|`sql_stats_flush_duration_sum`|Time taken in nanoseconds to complete SQL Stats flush.|float|ns|
|`sql_stats_flush_error`|Number of errors encountered when flushing SQL Stats.|float|count|
|`sql_stats_mem_current`|Current memory usage for fingerprint storage.|float|B|
|`sql_stats_mem_max`|Memory usage for fingerprint storage.|float|B|
|`sql_stats_mem_max_bucket`|Memory usage for fingerprint storage.|float|B|
|`sql_stats_mem_max_count`|Memory usage for fingerprint storage.|float|B|
|`sql_stats_mem_max_sum`|Memory usage for fingerprint storage.|float|B|
|`sql_stats_reported_mem_current`|Current memory usage for reported fingerprint storage.|float|B|
|`sql_stats_reported_mem_max`|Memory usage for reported fingerprint storage.|float|B|
|`sql_stats_reported_mem_max_bucket`|Memory usage for reported fingerprint storage.|float|B|
|`sql_stats_reported_mem_max_count`|Memory usage for reported fingerprint storage.|float|B|
|`sql_stats_reported_mem_max_sum`|Memory usage for reported fingerprint storage.|float|B|
|`sql_stats_txn_stats_collection_duration`|Time taken in nanoseconds to collect transaction stats.|float|ns|
|`sql_stats_txn_stats_collection_duration_bucket`|Time taken in nanoseconds to collect transaction stats.|float|ns|
|`sql_stats_txn_stats_collection_duration_count`|Time taken in nanoseconds to collect transaction stats.|float|ns|
|`sql_stats_txn_stats_collection_duration_sum`|Time taken in nanoseconds to collect transaction stats.|float|ns|
|`sql_temp_object_cleaner_active_cleaners`|Number of cleaner tasks currently running on this node.|float|count|
|`sql_temp_object_cleaner_schemas_deletion_error`|Number of errored schema deletions by the temp object cleaner on this node.|float|count|
|`sql_temp_object_cleaner_schemas_deletion_success`|Number of successful schema deletions by the temp object cleaner on this node.|float|count|
|`sql_temp_object_cleaner_schemas_to_delete`|Number of schemas to be deleted by the temp object cleaner on this node.|float|count|
|`sql_txn_abort`|[OpenMetrics v1 & v2] Number of SQL transaction ABORT statements.|float|count|
|`sql_txn_abort_internal`|Number of SQL transaction abort errors (internal queries).|float|count|
|`sql_txn_begin`|[OpenMetrics v1 & v2] Number of SQL transaction BEGIN statements.|float|count|
|`sql_txn_begin_internal`|Number of SQL transaction BEGIN statements successfully executed (internal queries).|float|count|
|`sql_txn_begin_started`|Number of SQL transaction BEGIN statements started.|float|count|
|`sql_txn_begin_started_internal`|Number of SQL transaction BEGIN statements started (internal queries).|float|count|
|`sql_txn_commit`|[OpenMetrics v1 & v2] Number of SQL transaction COMMIT statements.|float|count|
|`sql_txn_commit_internal`|Number of SQL transaction COMMIT statements successfully executed (internal queries).|float|count|
|`sql_txn_commit_started`|Number of SQL transaction COMMIT statements started.|float|count|
|`sql_txn_commit_started_internal`|Number of SQL transaction COMMIT statements started (internal queries).|float|count|
|`sql_txn_contended`|Number of SQL transactions experienced contention.|float|count|
|`sql_txn_contended_internal`|Number of SQL transactions experienced contention (internal queries).|float|count|
|`sql_txn_latency`|[OpenMetrics v1] Latency of SQL transactions.|float|percent|
|`sql_txn_latency_bucket`|[OpenMetrics v2] Latency of SQL transactions.|float|ns|
|`sql_txn_latency_count`|[OpenMetrics v2] Latency of SQL transactions.|float|percent|
|`sql_txn_latency_internal_bucket`|Latency of SQL transactions (internal queries).|float|ns|
|`sql_txn_latency_internal_count`|Latency of SQL transactions (internal queries).|float|ns|
|`sql_txn_latency_internal_sum`|Latency of SQL transactions (internal queries).|float|ns|
|`sql_txn_latency_sum`|[OpenMetrics v2] Latency of SQL transactions.|float|percent|
|`sql_txn_rollback`|[OpenMetrics v1 & v2] Number of SQL transaction ROLLBACK statements.|float|count|
|`sql_txn_rollback_internal`|Number of SQL transaction ROLLBACK statements successfully executed (internal queries).|float|count|
|`sql_txn_rollback_started`|Number of SQL transaction ROLLBACK statements started.|float|count|
|`sql_txn_rollback_started_internal`|Number of SQL transaction ROLLBACK statements started (internal queries).|float|count|
|`sql_txns_open`|[OpenMetrics v1 & v2] Number of currently open user SQL transactions.|float|percent|
|`sql_txns_open_internal`|Number of currently open user SQL transactions (internal queries).|float|count|
|`sql_update`|[OpenMetrics v1 & v2] Number of SQL UPDATE statements.|float|count|
|`sql_update_internal`|Number of SQL UPDATE statements successfully executed (internal queries).|float|count|
|`sql_update_started`|Number of SQL UPDATE statements started.|float|count|
|`sql_update_started_internal`|Number of SQL UPDATE statements started (internal queries).|float|count|
|`sqlliveness_is_alive_cache_hits`|Number of calls to IsAlive that return from the cache.|float|count|
|`sqlliveness_is_alive_cache_misses`|Number of calls to IsAlive that do not return from the cache.|float|count|
|`sqlliveness_sessions_deleted`|Number of expired sessions which have been deleted.|float|count|
|`sqlliveness_sessions_deletion_runs`|Number of calls to delete sessions which have been performed.|float|count|
|`sqlliveness_write_failures`|Number of update or insert calls which have failed.|float|count|
|`sqlliveness_write_successes`|Number of update or insert calls successfully performed.|float|count|
|`storage_batch_commit`|Count of batch commits. See `storage.AggregatedBatchCommitStats` for details.|float|count|
|`storage_batch_commit_commit_wait_duration`|Cumulative time spent waiting for WAL sync, for batch commit. See `storage.AggregatedBatchCommitStats` for details.|float|ns|
|`storage_batch_commit_duration`|Cumulative time spent in batch commit. See `storage.AggregatedBatchCommitStats` for details.|float|ns|
|`storage_batch_commit_l0_stall_duration`|Cumulative time spent in a write stall due to high read amplification in L0, for batch commit. See `storage.AggregatedBatchCommitStats` for details.|float|ns|
|`storage_batch_commit_mem_stall_duration`|Cumulative time spent in a write stall due to too many mem tables, for batch commit. See `storage.AggregatedBatchCommitStats` for details.|float|ns|
|`storage_batch_commit_sem_wait_duration`|Cumulative time spent in semaphore wait, for batch commit. See `storage.AggregatedBatchCommitStats` for details.|float|ns|
|`storage_batch_commit_wal_queue_wait_duration`|Cumulative time spent waiting for memory blocks in the WAL queue, for batch commit. See `storage.AggregatedBatchCommitStats` for details.|float|ns|
|`storage_batch_commit_wal_rotation_duration`|Cumulative time spent waiting for WAL rotation, for batch commit. See `storage.AggregatedBatchCommitStats` for details.|float|ns|
|`storage_checkpoints`|The number of checkpoint directories found in storage. This is the number of directories found in the auxiliary/checkpoints directory. Each represents an immutable point-in-time storage engine checkpoint. They are cheap (consisting mostly of hard links), but over time they effectively become a full copy of the old state, which increases their relative cost.|float|count|
|`storage_compactions_duration`|Cumulative sum of all compaction durations. The rate of this value provides the effective compaction concurrency of a store, which can be useful to determine whether the maximum compaction concurrency is fully utilized.|float|ns|
|`storage_compactions_keys_pinned`|Cumulative count of storage engine KVs written to SSTables during flushes and compactions due to open LSM snapshots. Various subsystems of CockroachDB take LSM snapshots to maintain a consistent view of the database over an extended duration.|float|count|
|`storage_compactions_keys_pinned_bytes`|Cumulative size of storage engine KVs written to SSTables during flushes and compactions due to open LSM snapshots. Various subsystems of CockroachDB take LSM snapshots to maintain a consistent view of the database over an extended duration.|float|B|
|`storage_disk_slow`|Number of instances of disk operations taking longer than 10 seconds.|float|count|
|`storage_disk_stalled`|Number of instances of disk operations taking longer than 20 seconds.|float|count|
|`storage_flush_ingest`|Flushes performing an ingest (flushable ingestion).|float|count|
|`storage_flush_ingest_table`|Tables ingested via flushes (flushable ingestion).|float|count|
|`storage_flush_ingest_table_bytes`|Bytes ingested via flushes (flushable ingestion).|float|B|
|`storage_flush_utilization`|The percentage of time the storage engine is actively flushing mem tables to disk.|float|percent|
|`storage_ingest`|Number of successful ingestions performed.|float|count|
|`storage_iterator_block_load_bytes`|Bytes loaded by storage engine iterators (possibly cached). See `storage.AggregatedIteratorStats` for details.|float|B|
|`storage_iterator_block_load_cached_bytes`|Bytes loaded by storage engine iterators from the block cache. See `storage.AggregatedIteratorStats` for details.|float|B|
|`storage_iterator_block_load_read_duration`|Cumulative time storage engine iterators spent loading blocks from durable storage. See `storage.AggregatedIteratorStats` for details.|float|ns|
|`storage_iterator_external_seeks`|Cumulative count of seeks performed on storage engine iterators. See `storage.AggregatedIteratorStats` for details.|float|count|
|`storage_iterator_external_steps`|Cumulative count of steps performed on storage engine iterators. See `storage.AggregatedIteratorStats` for details.|float|count|
|`storage_iterator_internal_seeks`|Cumulative count of seeks performed internally within storage engine iterators. A value high relative to 'storage.iterator.external.seeks' is a good indication that there's an accumulation of garbage internally within the storage engine. See `storage.AggregatedIteratorStats` for details.|float|count|
|`storage_iterator_internal_steps`|Cumulative count of steps performed internally within storage engine iterators. A value high relative to 'storage.iterator.external.steps' is a good indication that there's an accumulation of garbage internally within the storage engine. See `storage.AggregatedIteratorStats` for more details.|float|count|
|`storage_keys_range_key_set`|Approximate count of RangeKeySet internal keys across the storage engine.|float|count|
|`storage_keys_tombstone`|Approximate count of DEL, SINGLE DEL, and RANGE DEL internal keys across the storage engine.|float|count|
|`storage_l0_bytes_flushed`|Number of bytes flushed (from mem tables) into Level 0.|float|B|
|`storage_l0_bytes_ingested`|Number of bytes ingested directly into Level 0.|float|B|
|`storage_l0_level_score`|Compaction score of level 0.|float|count|
|`storage_l0_level_size`|Size of the SSTables in level 0.|float|B|
|`storage_l0_num_files`|Number of SSTables in Level 0.|float|count|
|`storage_l0_sublevels`|Number of Level 0 sublevels.|float|count|
|`storage_l1_bytes_ingested`|Number of bytes ingested directly into Level 1.|float|B|
|`storage_l1_level_score`|Compaction score of level 1.|float|count|
|`storage_l1_level_size`|Size of the SSTables in level 1.|float|B|
|`storage_l2_bytes_ingested`|Number of bytes ingested directly into Level 2.|float|B|
|`storage_l2_level_score`|Compaction score of level 2.|float|count|
|`storage_l2_level_size`|Size of the SSTables in level 2.|float|B|
|`storage_l3_bytes_ingested`|Number of bytes ingested directly into Level 3.|float|B|
|`storage_l3_level_score`|Compaction score of level 3.|float|count|
|`storage_l3_level_size`|Size of the SSTables in level 3.|float|B|
|`storage_l4_bytes_ingested`|Number of bytes ingested directly into Level 4.|float|B|
|`storage_l4_level_score`|Compaction score of level 4.|float|count|
|`storage_l4_level_size`|Size of the SSTables in level 4.|float|B|
|`storage_l5_bytes_ingested`|Number of bytes ingested directly into Level 5.|float|B|
|`storage_l5_level_score`|Compaction score of level 5.|float|count|
|`storage_l5_level_size`|Size of the SSTables in level 5.|float|B|
|`storage_l6_bytes_ingested`|Number of bytes ingested directly into Level 6.|float|B|
|`storage_l6_level_score`|Compaction score of level 6.|float|count|
|`storage_l6_level_size`|Size of the SSTables in level 6.|float|B|
|`storage_marked_for_compaction_files`|Count of SSTables marked for compaction.|float|count|
|`storage_queue_store_failures`|Number of replicas which failed processing in replica queues due to retryable store errors.|float|count|
|`storage_secondary_cache`|The count of cache blocks in the secondary cache (not SSTable blocks).|float|count|
|`storage_secondary_cache_evictions`|The number of times a cache block was evicted from the secondary cache.|float|count|
|`storage_secondary_cache_reads_full_hit`|The number of reads where all data returned was read from the secondary cache.|float|count|
|`storage_secondary_cache_reads_multi_block`|The number of secondary cache reads that require reading data from 2+ cache blocks.|float|count|
|`storage_secondary_cache_reads_multi_shard`|The number of secondary cache reads that require reading data from 2+ shards.|float|count|
|`storage_secondary_cache_reads_no_hit`|The number of reads where no data returned was read from the secondary cache.|float|count|
|`storage_secondary_cache_reads_partial_hit`|The number of reads where some data returned was read from the secondary cache.|float|count|
|`storage_secondary_cache_reads_total`|The number of reads from the secondary cache.|float|count|
|`storage_secondary_cache_size`|The number of SSTable bytes stored in the secondary cache.|float|B|
|`storage_secondary_cache_write_back_failures`|The number of times writing a cache block to the secondary cache failed.|float|count|
|`storage_shared_storage_read`|Bytes read from shared storage.|float|B|
|`storage_shared_storage_write`|Bytes written to external storage.|float|B|
|`storage_single_delete_ineffectual`|Number of SingleDeletes that were ineffectual.|float|count|
|`storage_single_delete_invariant_violation`|Number of SingleDelete invariant violations.|float|count|
|`storage_wal_bytes_in`|The number of logical bytes the storage engine has written to the WAL.|float|count|
|`storage_wal_bytes_written`|The number of bytes the storage engine has written to the WAL.|float|count|
|`storage_wal_fsync_latency_bucket`|The write-ahead log fsync latency.|float|ns|
|`storage_wal_fsync_latency_count`|The write-ahead log fsync latency.|float|ns|
|`storage_wal_fsync_latency_sum`|The write-ahead log fsync latency.|float|ns|
|`storage_write_stall_nanos`|Total write stall duration in nanoseconds.|float|ns|
|`storage_write_stalls`|Number of instances of intentional write stalls to back pressure incoming writes.|float|count|
|`sys_cgo_allocbytes`|[OpenMetrics v1 & v2] Current bytes of memory allocated by cgo.|float|B|
|`sys_cgo_totalbytes`|[OpenMetrics v1 & v2] Total bytes of memory allocated by cgo, but not released.|float|B|
|`sys_cgocalls`|[OpenMetrics v1 & v2] Total number of cgo calls.|float|count|
|`sys_cpu_combined_percent_normalized`|[OpenMetrics v1 & v2] Current user+system CPU percentage, normalized 0-1 by the number of cores.|float|percent|
|`sys_cpu_host_combined_percent_normalized`|Current user+system CPU percentage across the whole machine, normalized 0-1 by the number of cores.|float|percent|
|`sys_cpu_now_ns`|The time when CPU measurements were taken, as nanoseconds since epoch.|float|ns|
|`sys_cpu_sys_ns`|[OpenMetrics v1 & v2] Total system CPU time in nanoseconds.|float|ns|
|`sys_cpu_sys_percent`|[OpenMetrics v1 & v2] Current system CPU percentage.|float|percent|
|`sys_cpu_user_ns`|[OpenMetrics v1 & v2] Total user CPU time in nanoseconds.|float|ns|
|`sys_cpu_user_percent`|[OpenMetrics v1 & v2] Current user CPU percentage.|float|percent|
|`sys_fd_open`|[OpenMetrics v1 & v2] Process open file descriptors.|float|count|
|`sys_fd_softlimit`|[OpenMetrics v1 & v2] Process open FD soft limit.|float|count|
|`sys_gc`|[OpenMetrics v2] Total number of GC runs.|float|count|
|`sys_gc_count`|[OpenMetrics v1] Total number of GC runs.|float|count|
|`sys_gc_pause_ns`|[OpenMetrics v1 & v2] Total GC pause in nanoseconds.|float|ns|
|`sys_gc_pause_percent`|[OpenMetrics v1 & v2] Current GC pause percentage.|float|percent|
|`sys_go_allocbytes`|[OpenMetrics v1 & v2] Current bytes of memory allocated by Go.|float|B|
|`sys_go_totalbytes`|[OpenMetrics v1 & v2] Total bytes of memory allocated by Go, but not released.|float|B|
|`sys_goroutines`|[OpenMetrics v1 & v2] Current number of goroutines.|float|count|
|`sys_host_disk_io_time`|Time spent reading from or writing to all disks since this process started.|float|ns|
|`sys_host_disk_iopsinprogress`|IO operations currently in progress on this host.|float|count|
|`sys_host_disk_read`|Disk read operations across all disks since this process started.|float|count|
|`sys_host_disk_read_bytes`|[OpenMetrics v1 & v2] Bytes read from all disks since this process started.|float|B|
|`sys_host_disk_read_count`|Disk read operations across all disks since this process started.|float|count|
|`sys_host_disk_read_time`|Time spent reading from all disks since this process started.|float|ns|
|`sys_host_disk_weightedio_time`|Weighted time spent reading from or writing to all disks since this process started.|float|ns|
|`sys_host_disk_write`|Disk write operations across all disks since this process started.|float|count|
|`sys_host_disk_write_bytes`|[OpenMetrics v1 & v2] Bytes written to all disks since this process started.|float|B|
|`sys_host_disk_write_count`|Disk write operations across all disks since this process started.|float|count|
|`sys_host_disk_write_time`|Time spent writing to all disks since this process started.|float|ns|
|`sys_host_net_recv_bytes`|[OpenMetrics v1 & v2] Bytes received on all network interfaces since this process started.|float|B|
|`sys_host_net_recv_packets`|Packets received on all network interfaces since this process started.|float|count|
|`sys_host_net_send_bytes`|[OpenMetrics v1 & v2] Bytes sent on all network interfaces since this process started.|float|B|
|`sys_host_net_send_packets`|Packets sent on all network interfaces since this process started.|float|count|
|`sys_rss`|[OpenMetrics v1 & v2] Memory Usage (Bytes).|float|B|
|`sys_runnable_goroutines_per_cpu`|Average number of goroutines that are waiting to run, normalized by the number of cores.|float|count|
|`sys_totalmem`|Total memory (both free and used).|float|B|
|`sys_uptime`|[OpenMetrics v1 & v2] Process uptime in seconds.|float|s|
|`sysbytes`|[OpenMetrics v1 & v2] Number of bytes in system KV pairs.|float|B|
|`syscount`|[OpenMetrics v1 & v2] Count of system KV pairs.|float|count|
|`tenant_consumption_cross_region_network_ru`|Total number of RUs charged for cross-region network traffic.|float|count|
|`tenant_consumption_external_io_egress_bytes`|Total number of bytes written to external services such as cloud storage providers.|float|count|
|`tenant_consumption_external_io_ingress_bytes`|Total number of bytes read from external services such as cloud storage providers.|float|count|
|`tenant_consumption_kv_request_units`|RU consumption attributable to KV.|float|count|
|`tenant_consumption_kv_request_units_count`|RU consumption attributable to KV.|float|count|
|`tenant_consumption_pgwire_egress_bytes`|Total number of bytes transferred from a SQL pod to the client.|float|count|
|`tenant_consumption_read_batches`|Total number of KV read batches.|float|count|
|`tenant_consumption_read_bytes`|Total number of bytes read from KV.|float|count|
|`tenant_consumption_read_requests`|Total number of KV read requests.|float|count|
|`tenant_consumption_request_units`|Total RU consumption.|float|count|
|`tenant_consumption_request_units_count`|Total RU consumption.|float|count|
|`tenant_consumption_sql_pods_cpu_seconds`|Total amount of CPU used by SQL pods.|float|s|
|`tenant_consumption_write_batches`|Total number of KV write batches.|float|count|
|`tenant_consumption_write_bytes`|Total number of bytes written to KV.|float|count|
|`tenant_consumption_write_requests`|Total number of KV write requests.|float|count|
|`timeseries_write_bytes`|[OpenMetrics v1] Total size in bytes of metric samples written to disk.|float|B|
|`timeseries_write_bytes_count`|[OpenMetrics v2] Total size in bytes of metric samples written to disk.|float|B|
|`timeseries_write_errors`|[OpenMetrics v1] Total errors encountered while attempting to write metrics to disk.|float|count|
|`timeseries_write_errors_count`|[OpenMetrics v2] Total errors encountered while attempting to write metrics to disk.|float|count|
|`timeseries_write_samples`|[OpenMetrics v1] Total number of metric samples written to disk.|float|count|
|`timeseries_write_samples_count`|[OpenMetrics v2] Total number of metric samples written to disk.|float|count|
|`totalbytes`|[OpenMetrics v1 & v2] Total number of bytes taken up by keys and values including non-live data.|float|B|
|`tscache_skl_pages`|Number of pages in the timestamp cache.|float|count|
|`tscache_skl_read_pages`|[OpenMetrics v1 & v2] Number of pages in the read timestamp cache.|float|count|
|`tscache_skl_read_rotations`|[OpenMetrics v1] Number of page rotations in the read timestamp cache.|float|count|
|`tscache_skl_read_rotations_count`|[OpenMetrics v2] Number of page rotations in the read timestamp cache.|float|count|
|`tscache_skl_rotations`|Number of page rotations in the timestamp cache.|float|count|
|`tscache_skl_write_pages`|[OpenMetrics v1 & v2] Number of pages in the write timestamp cache.|float|count|
|`tscache_skl_write_rotations`|[OpenMetrics v1] Number of page rotations in the write timestamp cache.|float|count|
|`tscache_skl_write_rotations_count`|[OpenMetrics v2] Number of page rotations in the write timestamp cache.|float|count|
|`txn_abandons`|[OpenMetrics v1] Number of abandoned KV transactions.|float|count|
|`txn_abandons_count`|[OpenMetrics v2] Number of abandoned KV transactions.|float|count|
|`txn_aborts`|[OpenMetrics v1] Number of aborted KV transactions.|float|count|
|`txn_aborts_count`|[OpenMetrics v2] Number of aborted KV transactions.|float|count|
|`txn_autoretries`|[OpenMetrics v1] Number of automatic retries to avoid serializable restarts.|float|count|
|`txn_autoretries_count`|[OpenMetrics v2] Number of automatic retries to avoid serializable restarts.|float|count|
|`txn_commit_waits`|Number of KV transactions that had to commit-wait on commit in order to ensure linear serialization. This generally happens to transactions writing to global ranges.|float|count|
|`txn_commit_waits_before_commit_trigger`|Number of KV transactions that had to commit-wait on the server before committing because they had a commit trigger.|float|count|
|`txn_commits`|[OpenMetrics v1] Number of committed KV transactions (including 1PC).|float|count|
|`txn_commits1PC`|[OpenMetrics v1] Number of committed one-phase KV transactions.|float|count|
|`txn_commits1PC_count`|[OpenMetrics v2] Number of committed one-phase KV transactions.|float|count|
|`txn_commits_count`|[OpenMetrics v2] Number of committed KV transactions (including 1PC).|float|count|
|`txn_condensed_intent_spans`|[OpenMetrics v1] KV transactions that have exceeded their intent tracking memory budget (`kv.transaction.maxintentsbytes`). See also `txn.condensedintentspans_gauge` for a gauge of such transactions currently running.|float|count|
|`txn_condensed_intent_spans_gauge`|KV transactions currently running that have exceeded their intent tracking memory budget (`kv.transaction.maxintentsbytes`). See also `txn.condensedintentspans` for a perpetual counter/rate.|float|count|
|`txn_condensed_intent_spans_rejected`|KV transactions that have been aborted because they exceeded their intent tracking memory budget (`kv.transaction.maxintentsbytes`). Rejection is caused by `kv.transaction.rejectovermaxintentsbudget`.|float|count|
|`txn_durations`|[OpenMetrics v1] KV transaction durations in nanoseconds.|float|ns|
|`txn_durations_bucket`|[OpenMetrics v2] KV transaction durations in nanoseconds.|float|ns|
|`txn_durations_count`|[OpenMetrics v2] KV transaction durations in nanoseconds.|float|ns|
|`txn_durations_sum`|[OpenMetrics v2] KV transaction durations in nanoseconds.|float|ns|
|`txn_parallelcommits`|Number of KV transaction parallel commit attempts.|float|count|
|`txn_parallelcommits_auto_retries`|Number of commit tries after successful failed parallel commit attempts.|float|count|
|`txn_refresh_auto_retries`|Number of request retries after successful client-side refreshes.|float|count|
|`txn_refresh_fail`|Number of failed client-side transaction refreshes.|float|count|
|`txn_refresh_fail_with_condensed_spans`|Number of failed client-side refreshes for transactions whose read tracking lost fidelity because of condensing. Such a failure could be a false conflict. Failures counted here are also counted in `txn.refresh.fail`, and the respective transactions are also counted in `txn.refresh.memorylimitexceeded`.|float|count|
|`txn_refresh_memory_limit_exceeded`|Number of transactions which exceed the refresh span bytes limit, causing their read spans to be condensed.|float|count|
|`txn_refresh_success`|Number of successful client-side transaction refreshes. A refresh may be preemptive or reactive. A reactive refresh is performed after a request throws an error because a refresh is needed for it to succeed. In these cases, the request will be re-issued as an auto-retry (see `txn.refresh.auto_retries`) after the refresh succeeds.|float|count|
|`txn_refresh_success_server_side`|Number of successful server-side transaction refreshes.|float|count|
|`txn_restarts`|[OpenMetrics v1] Number of restarted KV transactions.|float|count|
|`txn_restarts_asyncwritefailure`|Number of restarts due to async consensus writes that failed to leave intents.|float|count|
|`txn_restarts_bucket`|[OpenMetrics v2] Number of restarted KV transactions.|float|count|
|`txn_restarts_commitdeadlineexceeded`|Number of restarts due to a transaction exceeding its deadline.|float|count|
|`txn_restarts_count`|[OpenMetrics v2] Number of restarted KV transactions.|float|count|
|`txn_restarts_deleterange`|[OpenMetrics v1] Number of restarts due to a forwarded commit timestamp and a DeleteRange command.|float|count|
|`txn_restarts_deleterange_count`|[OpenMetrics v2] Number of restarts due to a forwarded commit timestamp and a DeleteRange command.|float|count|
|`txn_restarts_possiblereplay`|[OpenMetrics v1] Number of restarts due to possible replays of command batches at the storage layer.|float|count|
|`txn_restarts_possiblereplay_count`|[OpenMetrics v2] Number of restarts due to possible replays of command batches at the storage layer.|float|count|
|`txn_restarts_readwithinuncertainty`|Number of restarts due to reading a new value within the uncertainty interval.|float|count|
|`txn_restarts_serializable`|[OpenMetrics v1] Number of restarts due to a forwarded commit timestamp and isolation=SERIALIZABLE.|float|count|
|`txn_restarts_serializable_count`|[OpenMetrics v2] Number of restarts due to a forwarded commit timestamp and isolation=SERIALIZABLE.|float|count|
|`txn_restarts_sum`|[OpenMetrics v2] Number of restarted KV transactions.|float|count|
|`txn_restarts_txnaborted`|Number of restarts due to an abort by a concurrent transaction (usually due to deadlock).|float|count|
|`txn_restarts_txnpush`|Number of restarts due to a transaction push failure.|float|count|
|`txn_restarts_unknown`|Number of restarts due to unknown reasons.|float|count|
|`txn_restarts_writetooold`|[OpenMetrics v1] Number of restarts due to a concurrent writer committing first.|float|count|
|`txn_restarts_writetooold_count`|[OpenMetrics v2] Number of restarts due to a concurrent writer committing first.|float|count|
|`txn_restarts_writetoooldmulti`|Number of restarts due to multiple concurrent writers committing first.|float|count|
|`txn_rollbacks_async_failed`|Number of KV transactions that failed to send abort asynchronously, which is not always retried.|float|count|
|`txn_rollbacks_failed`|Number of KV transactions that failed to send final abort.|float|count|
|`txn_server_side_1PC_failure`|Number of batches that attempted to commit using 1PC and failed.|float|count|
|`txn_server_side_1PC_success`|Number of batches that attempted to commit using 1PC and succeeded.|float|count|
|`txn_server_side_retry_read_evaluation_failure`|Number of read batches that were not successfully refreshed server-side.|float|count|
|`txn_server_side_retry_read_evaluation_success`|Number of read batches that were successfully refreshed server-side.|float|count|
|`txn_server_side_retry_uncertainty_interval_error_failure`|Number of batches that ran into uncertainty interval errors that were not successfully refreshed server-side.|float|count|
|`txn_server_side_retry_uncertainty_interval_error_success`|Number of batches that ran into uncertainty interval errors that were successfully refreshed server-side.|float|count|
|`txn_server_side_retry_write_evaluation_failure`|Number of write batches that were not successfully refreshed server-side.|float|count|
|`txn_server_side_retry_write_evaluation_success`|Number of write batches that were successfully refreshed server-side.|float|count|
|`txnrecovery_attempts`|Number of transaction recovery attempts executed.|float|count|
|`txnrecovery_attempts_pending`|Number of transaction recovery attempts currently in-flight.|float|count|
|`txnrecovery_failures`|Number of transaction recovery attempts that failed.|float|count|
|`txnrecovery_successes_aborted`|Number of transaction recovery attempts that aborted a transaction.|float|count|
|`txnrecovery_successes_committed`|Number of transaction recovery attempts that committed a transaction.|float|count|
|`txnrecovery_successes_pending`|Number of transaction recovery attempts that left a transaction pending.|float|count|
|`txnwaitqueue_deadlocks`|Number of deadlocks detected by the txn wait queue.|float|count|
|`txnwaitqueue_deadlocks_total`|Number of deadlocks detected by the txn wait queue.|float|count|
|`txnwaitqueue_pushee_waiting`|Number of pushers on the txn wait queue.|float|count|
|`txnwaitqueue_pusher_slow`|The total number of cases where a pusher waited more than the excessive wait threshold.|float|count|
|`txnwaitqueue_pusher_wait_time_bucket`|Histogram of durations spent in queue by pushers.|float|ns|
|`txnwaitqueue_pusher_wait_time_count`|Histogram of durations spent in queue by pushers.|float|ns|
|`txnwaitqueue_pusher_wait_time_sum`|Histogram of durations spent in queue by pushers.|float|ns|
|`txnwaitqueue_pusher_waiting`|Number of pushers on the txn wait queue.|float|count|
|`txnwaitqueue_query_wait_time_bucket`|Histogram of durations spent in queue by queries.|float|ns|
|`txnwaitqueue_query_wait_time_count`|Histogram of durations spent in queue by queries.|float|ns|
|`txnwaitqueue_query_wait_time_sum`|Histogram of durations spent in queue by queries.|float|ns|
|`txnwaitqueue_query_waiting`|Number of transaction status queries waiting for an updated transaction record.|float|count|
|`valbytes`|[OpenMetrics v1 & v2] Number of bytes taken up by values.|float|B|
|`valcount`|[OpenMetrics v1 & v2] Count of all values.|float|count|

