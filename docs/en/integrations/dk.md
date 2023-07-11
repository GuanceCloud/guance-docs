---
title: 'DataKit Self Metrics'
summary: 'Collecting DataKit self metrics'
dashboard:
  - desc: 'Datakit Dashboard'
    path: 'dashboard/en/dk'

monitor:
  - desc: 'Datakit Monitor'
    path: 'monitor/en/dk.json'
---

# DataKit Metrics

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker: · [:octicons-tag-24: Version-1.10.0](changelog.md#cl-1.10.0)

---

This Input used to collect Datakit exported metrics, such as runtime/CPU/memory and various other metrics of each modules.

## Configuration {#config}

After Datakit startup, it will expose a lot of [Prometheus metrics](datakit-metrics.md), and the input `dk` can scrap
these metrics.

<!-- markdownlint-disable MD046 -->
=== "*dk.conf*"

    
    Go to the `conf.d/host` directory under the DataKit installation directory, copy `dk.conf.sample` and name it `dk.conf`. Examples are as follows:

    ```toml
        
    [[inputs.dk]]
    
      # See https://docs.guance.com/datakit/datakit-metrics/#metrics for all metrics exported by Datakit.
      metric_name_filter = [
        ### Collect all metrics(these may collect 300+ metrics of Datakit)
        ### if you want to collect all, make this rule the first in the list.
        # ".*",
    
        "datakit_http.*",       # HTTP API
        "datakit_goroutine.*",  # Goroutine
    
        ### runtime related
        "datakit_cpu_.*",
        "datakit_.*_alloc_bytes", # Memory
        "datakit_open_files",
        "datakit_uptime_seconds",
        "datakit_data_overuse",
        "datakit_process_.*",
    
        ### election
        "datakit_election_status",
    
        ### Dataway related
        #"datakit_io_dataway_.*",
        #"datakit_io_http_retry_total",
    
        ### Filter
        #"datakit_filter_.*",
    
        ### Input feed
        #".*_feed_.*",
      ]
    
      # keep empty to collect all types(count/gauge/summary/...)
      metric_types = []
    
      # collect frequency
      interval = "30s"
    
    [inputs.dk.tags]
       # tag1 = "val-1"
       # tag2 = "val-2"
    
    ```

    After configuration, [restart DataKit]().

=== "Kubernetes"

    Kubernetes supports modifying configuration parameters in the form of environment variables:

    | Environment Name                  | Description                                                            | Examples                                                                               |
    | :---                              | ---                                                                    | ---                                                                                    |
    | `ENV_INPUT_DK_ENABLE_ALL_METRICS` | Enable all metrics, this may collect more than 300+ metrics on Datakit | `on/yes/`                                                                              |
    | `ENV_INPUT_DK_ADD_METRICS`        | Add extra metrics (JSON array)                                         | `["datakit_io_.*", "datakit_pipeline_.*"]`, Available metrics list [here](datakit-metrics.md) |
    | `ENV_INPUT_DK_ONLY_METRICS`       | **Only** enalbe specified metrics(JSON array)                          | `["datakit_io_.*", "datakit_pipeline_.*"]`                                             |
<!-- markdownlint-enable -->

## Measurements {#metric}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration through `[inputs.cpu.tags]`:

``` toml
 [inputs.cpu.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `dk`



- tag

NA

- Metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`datakit_cpu_cores`|Datakit CPU cores|float|-|
|`datakit_cpu_usage`|Datakit CPU usage(%)|float|-|
|`datakit_data_overuse`|Does current workspace's data(metric/logging) usage(if 0 not beyond, or with a unix timestamp when overuse occurred)|float|-|
|`datakit_dialtesting_pull_cost_seconds`|Time cost to pull tasks|float|-|
|`datakit_dialtesting_task_check_cost_seconds`|Task check time|float|-|
|`datakit_dialtesting_task_invalid_total`|Invalid task number|float|-|
|`datakit_dialtesting_task_number`|The number of tasks|float|-|
|`datakit_dialtesting_task_run_cost_seconds`|Task run time|float|-|
|`datakit_dialtesting_task_synchronized_total`|Task synchronized number|float|-|
|`datakit_dns_cost_seconds`|DNS IP lookup cost|float|-|
|`datakit_dns_domain_total`|DNS watched domain counter|float|-|
|`datakit_dns_ip_updated_total`|Domain IP updated counter|float|-|
|`datakit_dns_watch_run_total`|Watch run counter|float|-|
|`datakit_election_inputs`|Datakit election input count|float|-|
|`datakit_election_pause_total`|Input paused count when election failed|float|-|
|`datakit_election_resume_total`|Input resume count when election OK|float|-|
|`datakit_election_seconds`|Election latency|float|-|
|`datakit_election_status`|Datakit election status, if metric = 0, meas not elected, or the elected time(unix timestamp second)|float|-|
|`datakit_error_total`|Total errors, only count on error source, not include error message|float|-|
|`datakit_filter_last_update_timestamp_seconds`|Filter last update time|float|-|
|`datakit_filter_latency_seconds`|Filter latency of these filters|float|-|
|`datakit_filter_point_dropped_total`|Dropped points of filters|float|-|
|`datakit_filter_point_total`|Filter points of filters|float|-|
|`datakit_filter_pull_latency_seconds`|Filter pull(remote) latency|float|-|
|`datakit_filter_update_total`|Filters(remote) updated count|float|-|
|`datakit_goroutine_alive`|Alive Goroutines|float|-|
|`datakit_goroutine_cost_seconds`|Goroutine running duration|float|-|
|`datakit_goroutine_groups`|Goroutine group count|float|-|
|`datakit_goroutine_stopped_total`|Stopped Goroutines|float|-|
|`datakit_goroutines`|Goroutine count within Datakit|float|-|
|`datakit_heap_alloc_bytes`|Datakit memory heap bytes|float|-|
|`datakit_http_api_elapsed_seconds`|API request cost|float|-|
|`datakit_http_api_req_size_bytes`|API request body size|float|-|
|`datakit_http_api_total`|API request counter|float|-|
|`datakit_httpcli_conn_idle_time_seconds`|HTTP connection idle time|float|-|
|`datakit_httpcli_conn_reused_from_idle_total`|HTTP connection reused from idle count|float|-|
|`datakit_httpcli_dns_cost_seconds`|HTTP DNS cost|float|-|
|`datakit_httpcli_got_first_resp_byte_cost_seconds`|Got first response byte cost|float|-|
|`datakit_httpcli_http_connect_cost_seconds`|HTTP connect cost|float|-|
|`datakit_httpcli_tcp_conn_total`|HTTP TCP connection count|float|-|
|`datakit_httpcli_tls_handshake_seconds`|HTTP TLS handshake cost|float|-|
|`datakit_input_collect_latency_seconds`|Input collect latency|float|-|
|`datakit_inputs_crash_total`|Input crash count|float|-|
|`datakit_inputs_instance`|Input instance count|float|-|
|`datakit_io_chan_capacity`|IO channel capacity|float|-|
|`datakit_io_chan_usage`|IO channel usage(length of the channel)|float|-|
|`datakit_io_dataway_api_latency_seconds`|Dataway HTTP request latency partitioned by HTTP API(method@url) and HTTP status|float|-|
|`datakit_io_dataway_not_sink_point_total`|Dataway not-Sinked points(condition or category not match)|float|-|
|`datakit_io_dataway_point_bytes_total`|Dataway uploaded points bytes, partitioned by category and pint send status(HTTP status)|float|-|
|`datakit_io_dataway_point_total`|Dataway uploaded points, partitioned by category and send status(HTTP status)|float|-|
|`datakit_io_dataway_sink_point_total`|Dataway Sinked points, partitioned by category and point send status(ok/failed/dropped)|float|-|
|`datakit_io_dataway_sink_total`|Dataway Sinked count, partitioned by category.|float|-|
|`datakit_io_feed_cost_seconds`|IO feed waiting(on block mode) seconds|float|-|
|`datakit_io_feed_drop_point_total`|IO feed drop(on non-block mode) points|float|-|
|`datakit_io_feed_point_total`|Input feed point total|float|-|
|`datakit_io_feed_total`|Input feed total|float|-|
|`datakit_io_flush_failcache_bytes`|IO flush fail-cache bytes(in gzip) summary|float|-|
|`datakit_io_flush_total`|IO flush total|float|-|
|`datakit_io_flush_workers`|IO flush workers|float|-|
|`datakit_io_http_retry_total`|Dataway HTTP retried count|float|-|
|`datakit_io_input_filter_point_total`|Input filtered point total|float|-|
|`datakit_io_last_feed_timestamp_seconds`|Input last feed time(according to Datakit local time)|float|-|
|`datakit_io_queue_points`|IO module queued(cached) points|float|-|
|`datakit_kafkamq_consumer_message_total`|Kafka consumer message numbers from Datakit start|float|-|
|`datakit_kafkamq_group_election_total`|Kafka group election count|float|-|
|`datakit_last_err`|Datakit errors(when error occurred), these errors come from inputs or any sub modules|float|-|
|`datakit_open_files`|Datakit open files(only available on Linux)|float|-|
|`datakit_pipeline_cost_seconds`|Pipeline total running time|float|-|
|`datakit_pipeline_drop_point_total`|Pipeline total dropped points|float|-|
|`datakit_pipeline_error_point_total`|Pipeline processed total error points|float|-|
|`datakit_pipeline_last_update_timestamp_seconds`|Pipeline last update time|float|-|
|`datakit_pipeline_point_total`|Pipeline processed total points|float|-|
|`datakit_process_ctx_switch_total`|Datakit process context switch count(Linux only)|float|-|
|`datakit_process_io_bytes_total`|Datakit process IO bytes count|float|-|
|`datakit_process_io_count_total`|Datakit process IO count|float|-|
|`datakit_prom_collect_points`|Total number of prom collection points|float|-|
|`datakit_prom_http_get_bytes`|HTTP get bytes|float|-|
|`datakit_prom_http_latency_in_second`|HTTP latency(in second)|float|-|
|`datakit_sys_alloc_bytes`|Datakit memory system bytes|float|-|
|`datakit_uptime_seconds`|Datakit uptime|float|-|


