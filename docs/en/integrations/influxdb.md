---
title     : 'InfluxDB'
summary   : 'Collect InfluxDB Metrics data'
tags:
  - 'Database'
__int_icon      : 'icon/influxdb'
dashboard :
  - desc  : 'InfluxDB'
    path  : 'dashboard/en/influxdb'
  - desc  : 'InfluxDB v2'
    path  : 'dashboard/en/influxdb_v2'
monitor   :
  - desc  : 'InfluxDB v2'
    path  : 'monitor/en/influxdb_v2'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The InfluxDB collector is used to collect data from InfluxDB.

## InfluxDB Collector Configuration {#config}

### Prerequisites {#requirements}

- The InfluxDB collector is only applicable to InfluxDB v1.x.
- For InfluxDB v2.x, the prom collector should be used for data collection.

Tested versions:

- [x] 1.8.10

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Enter the `conf.d/influxdb` directory under the DataKit installation directory, copy `influxdb.conf.sample`, and rename it to `influxdb.conf`. An example is as follows:
    
    ```toml
        
    [[inputs.influxdb]]
      url = "http://localhost:8086/debug/vars"
    
      ## (optional) collect interval, default is 10 seconds
      interval = '10s'
      
      ## Username and password to send using HTTP Basic Authentication.
      # username = ""
      # password = ""
    
      ## http request & header timeout
      timeout = "5s"
    
      ## Set true to enable election
      election = true
    
      ## TLS config
      # [inputs.influxdb.tlsconf]
        # insecure_skip_verify = true
        ## Following ca_certs/cert/cert_key are optional, if insecure_skip_verify = true.
        # ca_certs = ["/opt/tls/ca.crt"]
        # cert = "/opt/tls/client.root.crt"
        # cert_key = "/opt/tls/client.root.key"
        ## we can encode these file content in base64 format:
        # ca_certs_base64 = ["LONG_BASE64_STRING......"]
        # cert_base64 = "LONG_BASE64_STRING......"
        # cert_key_base64 = "LONG_BASE64_STRING......"
        # server_name = "your-SNI-name"
    
      # [inputs.influxdb.log]
      # files = []
      # #grok pipeline script path
      # pipeline = "influxdb.p"
    
      [inputs.influxdb.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

### InfluxDB v2.x {#prom-config}

```toml
[[inputs.prom]]
  ## Exporter HTTP URL.
  url = "http://127.0.0.1:8086/metrics"

  metric_types = ["counter", "gauge"]

  interval = "10s"

  ## TLS configuration.
  tls_open = false
  # tls_ca = "/tmp/ca.crt"
  # tls_cert = "/tmp/peer.crt"
  # tls_key = "/tmp/peer.key"

  [[inputs.prom.measurements]]
    prefix = "boltdb_"
    name = "influxdb_v2_boltdb"

  [[inputs.prom.measurements]]
    prefix = "go_"
    name = "influxdb_v2_go"
  
  ## Histogram type.
  # [[inputs.prom.measurements]]
  #   prefix = "http_api_request_"
  #   name = "influxdb_v2_http_request"

  [[inputs.prom.measurements]]
    prefix = "influxdb_"
    name = "influxdb_v2"
  
  [[inputs.prom.measurements]]
    prefix = "service_"
    name = "influxdb_v2_service"

  [[inputs.prom.measurements]]
    prefix = "task_"
    name = "influxdb_v2_task" 

  ## Customize tags.
  [inputs.prom.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"

```

## Metrics {#metric}

By default, all collected data will append a global election tag. Additional tags can be specified in the configuration using `[inputs.influxdb.tags]`:

``` toml
 [inputs.influxdb.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `influxdb_cq`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|System hostname.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`query_fail`|The total number of continuous queries that executed but failed.|float|-|
|`query_ok`|The total number of continuous queries that executed successfully.|float|-|



### `influxdb_database`

- Tags


| Tag | Description |
|  ----  | --------|
|`database`|Database name.|
|`host`|System hostname.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`num_measurements`|The current number of measurements in the specified database.|float|-|
|`num_series`|The current series cardinality of the specified database. |float|-|



### `influxdb_httpd`

- Tags


| Tag | Description |
|  ----  | --------|
|`bind`|Bind port.|
|`host`|System hostname.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`auth_fail`|The number of HTTP requests that were aborted due to authentication being required, but not supplied or incorrect.|float|-|
|`client_error`|The number of HTTP responses due to client errors, with a 4XX HTTP status code.|float|-|
|`flux_query_req`|The number of Flux query requests served.|float|-|
|`flux_query_req_duration_ns`|The duration (wall-time), in nanoseconds, spent executing Flux query requests.|float|ns|
|`ping_req`|The number of times InfluxDB HTTP server served the /ping HTTP endpoint.|float|-|
|`points_written_dropped`|The number of points dropped by the storage engine.|float|-|
|`points_written_fail`|The number of points accepted by the HTTP /write endpoint, but unable to be persisted.|float|-|
|`points_written_ok`|The number of points successfully accepted and persisted by the HTTP /write endpoint.|float|-|
|`prom_read_req`|The number of read requests to the Prometheus /read endpoint.|float|-|
|`prom_write_req`|The number of write requests to the Prometheus /write endpoint.|float|-|
|`query_req`|The number of query requests.|float|-|
|`query_req_duration_ns`|The total query request duration, in nanosecond (ns).|float|ns|
|`query_resp_bytes`|The total number of bytes returned in query responses.|float|B|
|`recovered_panics`|The total number of panics recovered by the HTTP handler.|float|-|
|`req`|The total number of HTTP requests served.|float|-|
|`req_active`|The number of currently active requests.|float|-|
|`req_duration_ns`|The duration (wall time), in nanoseconds, spent inside HTTP requests.|float|ns|
|`server_error`|The number of HTTP responses due to server errors.|float|-|
|`status_req`|The number of status requests served using the HTTP /status endpoint.|float|-|
|`values_written_ok`|The number of values (fields) successfully accepted and persisted by the HTTP /write endpoint.|float|-|
|`write_req`|The number of write requests served using the HTTP /write endpoint.|float|-|
|`write_req_active`|The number of currently active write requests.|float|-|
|`write_req_bytes`|The total number of bytes of line protocol data received by write requests, using the HTTP /write endpoint.|float|B|
|`write_req_duration_ns`|The duration (wall time), in nanoseconds, of write requests served using the /write HTTP endpoint.|float|ns|



### `influxdb_memstats`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|System hostname.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`alloc`|The currently allocated number of bytes of heap objects.|float|B|
|`buck_hash_sys`|The bytes of memory in profiling bucket hash tables.|float|B|
|`frees`|The cumulative number of freed (live) heap objects.|float|-|
|`gc_cpu_fraction`|The fraction of CPU time used by the garbage collection cycle.|float|-|
|`gc_sys`|The bytes of memory in garbage collection metadata.|float|B|
|`heap_alloc`|The size, in bytes, of all heap objects.|float|B|
|`heap_idle`|The number of bytes of idle heap objects.|float|B|
|`heap_inuse`|The number of bytes in in-use spans.|float|B|
|`heap_objects`|The number of allocated heap objects.|float|-|
|`heap_released`|The number of bytes of physical memory returned to the OS.|float|B|
|`heap_sys`|The number of bytes of heap memory obtained from the OS.|float|B|
|`last_gc`|Time the last garbage collection finished, as nanoseconds since 1970 (the UNIX epoch).|float|nsec|
|`lookups`|The number of pointer lookups performed by the runtime.|float|-|
|`mallocs`|The total number of heap objects allocated.|float|-|
|`mcache_inuse`|The bytes of allocated mcache structures.|float|B|
|`mcache_sys`|The bytes of memory obtained from the OS for mcache structures.|float|B|
|`mspan_inuse`|The bytes of allocated mcache structures.|float|B|
|`mspan_sys`|The bytes of memory obtained from the OS for `mspan`.|float|B|
|`next_gc`|The target heap size of the next garbage collection cycle.|float|-|
|`num_forced_gc`|The number of GC cycles that were forced by the application calling the GC function.|float|-|
|`num_gc`|The number of completed garbage collection cycles.|float|-|
|`other_sys`|The number of bytes of memory used other than `heap_sys/stacks_sys/mspan_sys/mcache_sys/buckhash_sys/gc_sys`.|float|B|
|`pause_ns`|The time garbage collection cycles are paused in nanoseconds.|float|ns|
|`pause_total_ns`|The total time garbage collection cycles are paused in nanoseconds.|float|ns|
|`stack_inuse`|The number of bytes in in-use stacks.|float|B|
|`stack_sys`|The total number of bytes of memory obtained from the stack in use.|float|B|
|`sys`|The cumulative bytes allocated for heap objects.|float|B|
|`total_alloc`|The cumulative bytes allocated for heap objects.|float|B|



### `influxdb_queryExecutor`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|System hostname.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`queries_active`|The number of active queries currently being handled.|float|-|
|`queries_executed`|The number of queries executed (started).|float|-|
|`queries_finished`|The number of queries that have finished executing.|float|-|
|`query_duration_ns`|The duration (wall time), in nanoseconds, of every query executed. |float|ns|
|`recovered_panics`|The number of panics recovered by the Query Executor.|float|-|



### `influxdb_runtime`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|System hostname.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`alloc`|The currently allocated number of bytes of heap objects.|float|B|
|`frees`|The cumulative number of freed (live) heap objects.|float|-|
|`heap_alloc`|The size, in bytes, of all heap objects.|float|B|
|`heap_idle`|The number of bytes of idle heap objects.|float|B|
|`heap_inuse`|The number of bytes in in-use spans.|float|B|
|`heap_objects`|The number of allocated heap objects.|float|-|
|`heap_released`|The number of bytes of physical memory returned to the OS.|float|B|
|`heap_sys`|The number of bytes of heap memory obtained from the OS.|float|B|
|`lookups`|The number of pointer lookups performed by the runtime.|float|-|
|`mallocs`|The total number of heap objects allocated.|float|-|
|`num_gc`|The number of completed garbage collection cycles.|float|-|
|`num_goroutine`|The total number of Go routines.|float|-|
|`pause_total_ns`|The total time garbage collection cycles are paused in nanoseconds.|float|ns|
|`sys`|The cumulative bytes allocated for heap objects.|float|B|
|`total_alloc`|The cumulative bytes allocated for heap objects.|float|B|



### `influxdb_shard`

- Tags


| Tag | Description |
|  ----  | --------|
|`database`|Database name.|
|`engine`|Engine.|
|`host`|System hostname.|
|`id`|ID.|
|`index_type`|Index type.|
|`path`|Path.|
|`retention_policy`|Retention policy.|
|`wal_path`|Wal path.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`disk_bytes`|The size, in bytes, of the shard, including the size of the data directory and the WAL directory.|float|B|
|`fields_create`|The number of fields created.|float|-|
|`series_create`|Then number of series created.|float|-|
|`write_bytes`|The number of bytes written to the shard.|float|B|
|`write_points_dropped`|The number of requests to write points t dropped from a write.|float|-|
|`write_points_err`|The number of requests to write points that failed to be written due to errors.|float|-|
|`write_points_ok`|The number of points written successfully.|float|-|
|`write_req`|The total number of write requests.|float|-|
|`write_req_err`|The total number of write requests that failed due to errors.|float|-|
|`write_req_ok`|The total number of successful write requests.|float|-|
|`write_values_ok`|The number of write values successfully.|float|-|



### `influxdb_subscriber`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|System hostname.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`create_failures`|The number of subscriptions that failed to be created.|float|-|
|`points_written`|The total number of points that were successfully written to subscribers.|float|-|
|`write_failures`|The total number of batches that failed to be written to subscribers.|float|-|



### `influxdb_tsm1_cache`

- Tags


| Tag | Description |
|  ----  | --------|
|`database`|Database name.|
|`engine`|Engine.|
|`host`|System hostname.|
|`id`|ID.|
|`index_type`|Index type.|
|`path`|Path.|
|`retention_policy`|Retention policy.|
|`wal_path`|Wal path.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cache_age_ms`|The duration, in milliseconds, since the cache was last snapshotted at sample time.|float|ms|
|`cached_bytes`|The total number of bytes that have been written into snapshots.|float|B|
|`disk_bytes`|The size, in bytes, of on-disk snapshots.|float|B|
|`mem_bytes`|The size, in bytes, of in-memory cache.|float|B|
|`snapshot_count`|The current level (number) of active snapshots.|float|-|
|`wal_compaction_time_ms`|The duration, in milliseconds, that the commit lock is held while compacting snapshots.|float|ms|
|`write_dropped`|The total number of writes dropped due to timeouts.|float|-|
|`write_err`|The total number of writes that failed.|float|-|
|`write_ok`|The total number of successful writes.|float|-|



### `influxdb_tsm1_engine`

- Tags


| Tag | Description |
|  ----  | --------|
|`database`|Database name.|
|`engine`|Engine.|
|`host`|System hostname.|
|`id`|ID.|
|`index_type`|Index type.|
|`path`|Path.|
|`retention_policy`|Retention policy.|
|`wal_path`|Wal path.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cache_compaction_duration`|The duration (wall time), in nanoseconds, spent in cache compactions.|float|ns|
|`cache_compaction_err`|The number of cache compactions that have failed due to errors.|float|-|
|`cache_compactions`|The total number of cache compactions that have ever run.|float|-|
|`cache_compactions_active`|The number of cache compactions that are currently running.|float|-|
|`tsm_full_compaction_duration`|The duration (wall time), in nanoseconds, spent in full compactions.|float|-|
|`tsm_full_compaction_err`|The total number of TSM full compactions that have failed due to errors.|float|-|
|`tsm_full_compaction_queue`|The current number of pending TMS Full compactions.|float|-|
|`tsm_full_compactions`|The total number of TSM full compactions that have ever run.|float|-|
|`tsm_full_compactions_active`|The number of TSM full compactions currently running.|float|-|
|`tsm_level1_compaction_duration`|The duration (wall time), in nanoseconds, spent in TSM level 1 compactions.|float|ns|
|`tsm_level1_compaction_err`|The total number of TSM level 1 compactions that have failed due to errors.|float|-|
|`tsm_level1_compaction_queue`|The current number of pending TSM level 1 compactions.|float|-|
|`tsm_level1_compactions`|The total number of TSM level 1 compactions that have ever run.|float|-|
|`tsm_level1_compactions_active`|The number of TSM level 1 compactions that are currently running.|float|-|
|`tsm_level2_compaction_duration`|The duration (wall time), in nanoseconds, spent in TSM level 2 compactions.|float|ns|
|`tsm_level2_compaction_err`|The number of TSM level 2 compactions that have failed due to errors.|float|-|
|`tsm_level2_compaction_queue`|The current number of pending TSM level 2 compactions.|float|-|
|`tsm_level2_compactions`|The total number of TSM level 2 compactions that have ever run.|float|-|
|`tsm_level2_compactions_active`|The number of TSM level 2 compactions that are currently running.|float|-|
|`tsm_level3_compaction_duration`|The duration (wall time), in nanoseconds, spent in TSM level 3 compactions.|float|ns|
|`tsm_level3_compaction_err`|The number of TSM level 3 compactions that have failed due to errors.|float|-|
|`tsm_level3_compaction_queue`|The current number of pending TSM level 3 compactions.|float|-|
|`tsm_level3_compactions`|The total number of TSM level 3 compactions that have ever run.|float|-|
|`tsm_level3_compactions_active`|The number of TSM level 3 compactions that are currently running.|float|-|
|`tsm_optimize_compaction_duration`|The duration (wall time), in nanoseconds, spent during TSM optimize compactions.|float|ns|
|`tsm_optimize_compaction_err`|The total number of TSM optimize compactions that have failed due to errors.|float|-|
|`tsm_optimize_compaction_queue`|The current number of pending TSM optimize compactions.|float|-|
|`tsm_optimize_compactions`|The total number of TSM optimize compactions that have ever run.|float|-|
|`tsm_optimize_compactions_active`|The number of TSM optimize compactions that are currently running.|float|-|



### `influxdb_tsm1_filestore`

- Tags


| Tag | Description |
|  ----  | --------|
|`database`|Database name.|
|`engine`|Engine.|
|`host`|System hostname.|
|`id`|ID.|
|`index_type`|Index type.|
|`path`|Path.|
|`retention_policy`|Retention policy.|
|`wal_path`|Wal path.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`disk_bytes`|The size, in bytes, of disk usage by the TSM file store.|float|B|
|`num_files`|The total number of files in the TSM file store.|float|-|



### `influxdb_tsm1_wal`

- Tags


| Tag | Description |
|  ----  | --------|
|`database`|Database name.|
|`engine`|Engine.|
|`host`|System hostname.|
|`id`|ID.|
|`index_type`|Index type.|
|`path`|Path.|
|`retention_policy`|Retention policy.|
|`wal_path`|Wal path.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`current_segment_disk_bytes`|The current size, in bytes, of the segment disk.|float|B|
|`old_segments_disk_bytes`|The size, in bytes, of the segment disk.|float|B|
|`write_err`|The number of writes that failed due to errors.|float|-|
|`write_ok`|The number of writes that succeeded.|float|-|



### `influxdb_write`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|System hostname.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`point_req`|The total number of every point requested to be written to this data node.|float|-|
|`point_req_local`|The total number of point requests that have been attempted to be written into a shard on the same (local) node.|float|-|
|`req`|The total number of batches of points requested to be written to this node.|float|-|
|`sub_write_drop`|The total number of batches of points that failed to be sent to the subscription dispatcher.|float|-|
|`sub_write_ok`|The total number of batches of points that were successfully sent to the subscription dispatcher.|float|-|
|`write_drop`|The total number of write requests for points that have been dropped due to timestamps not matching any existing retention policies.|float|-|
|`write_error`|The total number of batches of points that were not successfully written, due to a failure to write to a local or remote shard.|float|-|
|`write_ok`|The total number of batches of points written at the requested consistency level.|float|-|
|`write_timeout`|The total number of write requests that failed to complete within the default write timeout duration.|float|-|



## Logging {#logging}

To collect InfluxDB logs, you can enable `files` in `influxdb.conf` and specify the absolute path of the InfluxDB log file. For example:

```toml
[inputs.influxdb.log]
    # Enter the absolute path
    files = ["/path/to/demo.log"] 
    ## grok pipeline script path
    pipeline = "influxdb.p"
```
