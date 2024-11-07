# Datakit 自身指标

---

为便于 Datakit 自身可观测性，我们在开发 Datakit 过程中，给相关的业务模块增加了很多 Prometheus 指标暴露，通过暴露这些指标，我们能方便的排查 Datakit 运行过程中的一些问题。

## 指标列表 {#metrics}

自 Datakit [1.5.9 版本](changelog.md#cl-1.5.9)以来，通过访问 `http://localhost:9529/metrics` 即可获取当前的指标列表，不同 Datakit 版本可能会对一些相关指标做调整，或者增删一些指标。

这些指标，在 [Datakit monitor](datakit-monitor.md) 展示中也会用到，只是 monitor 中为了展示上的友好型，做了一些优化处理。如果要查看原始的指标（或者 monitor 上没有展示出来的指标），我们可以通过 `curl` 和 `watch` 命令的组合来查看，比如获取 Datakit 进程 CPU 的使用情况：

```shell
# 每隔 3s 获取一次 CPU 使用率指标
$ watch -n 3 'curl -s http://localhost:9529/metrics | grep -a datakit_cpu_usage'

# HELP datakit_cpu_usage Datakit CPU usage(%)
# TYPE datakit_cpu_usage gauge
datakit_cpu_usage 4.9920266849857144
```

其它指标也能通过类似方式来观察，目前已有的指标如下（当前版本 1.62.1）：

<!-- 以下这些指标，通过执行 make show_metrics 方式能获取 -->

|POSITION|TYPE|NAME|LABELS|HELP|
|---|---|---|---|---|
|*internal/config*|GAUGE|`datakit_config_datakit_ulimit`|`status`|Datakit ulimit|
|*internal/dnswatcher*|COUNTER|`datakit_dns_domain_total`|`N/A`|DNS watched domain counter|
|*internal/dnswatcher*|COUNTER|`datakit_dns_ip_updated_total`|`domain`|Domain IP updated counter|
|*internal/dnswatcher*|COUNTER|`datakit_dns_watch_run_total`|`interval`|Watch run counter|
|*internal/dnswatcher*|SUMMARY|`datakit_dns_cost_seconds`|`domain,status`|DNS IP lookup cost|
|*internal/election*|COUNTER|`datakit_election_pause_total`|`id,namespace`|Input paused count when election failed|
|*internal/election*|COUNTER|`datakit_election_resume_total`|`id,namespace`|Input resume count when election OK|
|*internal/election*|GAUGE|`datakit_election_status`|`elected_id,id,namespace,status`|Datakit election status, if metric = 0, meas not elected, or the elected time(unix timestamp second)|
|*internal/election*|GAUGE|`datakit_election_inputs`|`namespace`|Datakit election input count|
|*internal/election*|SUMMARY|`datakit_election_seconds`|`namespace,status`|Election latency|
|*internal/goroutine*|GAUGE|`datakit_goroutine_alive`|`name`|Alive Goroutine count|
|*internal/goroutine*|COUNTER|`datakit_goroutine_recover_total`|`name`|Recovered Goroutine count|
|*internal/goroutine*|COUNTER|`datakit_goroutine_stopped_total`|`name`|Stopped Goroutine count|
|*internal/goroutine*|COUNTER|`datakit_goroutine_crashed_total`|`name`|Crashed goroutines count|
|*internal/goroutine*|GAUGE|`datakit_goroutine_groups`|`N/A`|Goroutine group count|
|*internal/goroutine*|SUMMARY|`datakit_goroutine_cost_seconds`|`name`|Goroutine running duration|
|*internal/httpapi*|SUMMARY|`datakit_http_api_elapsed_seconds`|`api,method,status`|API request cost|
|*internal/httpapi*|SUMMARY|`datakit_http_api_req_size_bytes`|`api,method,status`|API request body size|
|*internal/httpapi*|COUNTER|`datakit_http_api_total`|`api,method,status`|API request counter|
|*internal/httpapi*|GAUGE|`datakit_http_api_global_tags_last_updated`|`api,method,status`|Global tag updated timestamp, in second|
|*internal/httpcli*|SUMMARY|`datakit_httpcli_got_first_resp_byte_cost_seconds`|`from`|Got first response byte cost|
|*internal/httpcli*|COUNTER|`datakit_httpcli_tcp_conn_total`|`from,remote,type`|HTTP TCP connection count|
|*internal/httpcli*|COUNTER|`datakit_httpcli_conn_reused_from_idle_total`|`from`|HTTP connection reused from idle count|
|*internal/httpcli*|SUMMARY|`datakit_httpcli_conn_idle_time_seconds`|`from`|HTTP connection idle time|
|*internal/httpcli*|SUMMARY|`datakit_httpcli_dns_cost_seconds`|`from`|HTTP DNS cost|
|*internal/httpcli*|SUMMARY|`datakit_httpcli_tls_handshake_seconds`|`from`|HTTP TLS handshake cost|
|*internal/httpcli*|SUMMARY|`datakit_httpcli_http_connect_cost_seconds`|`from`|HTTP connect cost|
|*internal/io/dataway*|COUNTER|`datakit_io_dataway_skipped_point_total`|`category`|Skipped point count during encoding(Protobuf) point|
|*internal/io/dataway*|GAUGE|`datakit_io_dataway_wal_mem_len`|`category`|Dataway WAL's memory queue length|
|*internal/io/dataway*|SUMMARY|`datakit_io_flush_failcache_bytes`|`category`|IO flush fail-cache bytes(in gzip) summary|
|*internal/io/dataway*|SUMMARY|`datakit_io_build_body_cost_seconds`|`category,encoding,stage`|Build point HTTP body cost|
|*internal/io/dataway*|SUMMARY|`datakit_io_build_body_batches`|`category,encoding`|Batch HTTP body batches|
|*internal/io/dataway*|SUMMARY|`datakit_io_build_body_batch_bytes`|`category,encoding,type`|Batch HTTP body size|
|*internal/io/dataway*|SUMMARY|`datakit_io_build_body_batch_points`|`category,encoding`|Batch HTTP body points|
|*internal/io/dataway*|SUMMARY|`datakit_io_dataway_wal_flush`|`category,gzip,queue`|Dataway WAL worker flushed bytes|
|*internal/io/dataway*|COUNTER|`datakit_io_dataway_point_total`|`category,status`|Dataway uploaded points, partitioned by category and send status(HTTP status)|
|*internal/io/dataway*|COUNTER|`datakit_io_dataway_body_total`|`from,op,type`|Dataway total body|
|*internal/io/dataway*|COUNTER|`datakit_io_wal_point_total`|`category,status`|WAL queued points|
|*internal/io/dataway*|COUNTER|`datakit_io_dataway_point_bytes_total`|`category,enc,status`|Dataway uploaded points bytes, partitioned by category and pint send status(HTTP status)|
|*internal/io/dataway*|COUNTER|`datakit_io_dataway_http_drop_point_total`|`category,error`|Dataway write drop points|
|*internal/io/dataway*|SUMMARY|`datakit_io_dataway_api_latency_seconds`|`api,status`|Dataway HTTP request latency partitioned by HTTP API(method@url) and HTTP status|
|*internal/io/dataway*|COUNTER|`datakit_io_http_retry_total`|`api,status`|Dataway HTTP retried count|
|*internal/io/dataway*|SUMMARY|`datakit_io_grouped_request`|`category`|Grouped requests under sinker|
|*internal/io/filter*|COUNTER|`datakit_filter_update_total`|`N/A`|Filters(remote) updated count|
|*internal/io/filter*|GAUGE|`datakit_filter_last_update_timestamp_seconds`|`N/A`|Filter last update time|
|*internal/io/filter*|COUNTER|`datakit_filter_point_total`|`category,filters,source`|Filter points of filters|
|*internal/io/filter*|GAUGE|`datakit_filter_parse_error`|`error,filters`|Filter parse error|
|*internal/io/filter*|COUNTER|`datakit_filter_point_dropped_total`|`category,filters,source`|Dropped points of filters|
|*internal/io/filter*|SUMMARY|`datakit_filter_pull_latency_seconds`|`status`|Filter pull(remote) latency|
|*internal/io/filter*|SUMMARY|`datakit_filter_latency_seconds`|`category,filters,source`|Filter latency of these filters|
|*internal/io*|GAUGE|`datakit_io_queue_points`|`category`|IO module queued(cached) points|
|*internal/io*|COUNTER|`datakit_io_input_filter_point_total`|`name,category`|Input filtered point total|
|*internal/io*|COUNTER|`datakit_io_feed_total`|`name,category`|Input feed total|
|*internal/io*|GAUGE|`datakit_io_last_feed_timestamp_seconds`|`name,category`|Input last feed time(according to Datakit local time)|
|*internal/io*|SUMMARY|`datakit_input_collect_latency_seconds`|`name,category`|Input collect latency|
|*internal/io*|GAUGE|`datakit_io_chan_usage`|`category`|IO channel usage(length of the channel)|
|*internal/io*|GAUGE|`datakit_io_chan_capacity`|`category`|IO channel capacity|
|*internal/io*|SUMMARY|`datakit_io_feed_cost_seconds`|`category,from`|IO feed waiting(on block mode) seconds|
|*internal/io*|SUMMARY|`datakit_io_feed_point`|`name,category`|Input feed point|
|*internal/io*|GAUGE|`datakit_io_flush_workers`|`category`|IO flush workers|
|*internal/io*|COUNTER|`datakit_io_flush_total`|`category`|IO flush total|
|*internal/metrics*|COUNTER|`datakit_error_total`|`source,category`|Total errors, only count on error source, not include error message|
|*internal/metrics*|GAUGE|`datakit_goroutines`|`N/A`|Goroutine count within Datakit|
|*internal/metrics*|GAUGE|`datakit_mem_stat`|`type`|Datakit memory system bytes|
|*internal/metrics*|GAUGE|`datakit_heap_alloc_bytes`|`N/A`|Datakit memory heap bytes(Deprecated by `datakit_golang_mem_usage`)|
|*internal/metrics*|GAUGE|`datakit_sys_alloc_bytes`|`N/A`|Datakit memory system bytes(Deprecated by `datakit_golang_mem_usage`)|
|*internal/metrics*|GAUGE|`datakit_golang_mem_usage`|`type`|Datakit golang memory usage stats|
|*internal/metrics*|GAUGE|`datakit_cpu_usage`|`N/A`|Datakit CPU usage(%)|
|*internal/metrics*|GAUGE|`datakit_open_files`|`N/A`|Datakit open files(only available on Linux)|
|*internal/metrics*|GAUGE|`datakit_cpu_cores`|`N/A`|Datakit CPU cores|
|*internal/metrics*|GAUGE|`datakit_uptime_seconds`|`auto_update,docker,hostname,lite,elinker,resource_limit,version=?,build_at=?,branch=?,os_arch=?`|Datakit uptime|
|*internal/metrics*|GAUGE|`datakit_data_overuse`|`N/A`|Does current workspace's data(metric/logging) usage(if 0 not beyond, or with a unix timestamp when overuse occurred)|
|*internal/metrics*|COUNTER|`datakit_process_ctx_switch_total`|`type`|Datakit process context switch count(Linux only)|
|*internal/metrics*|COUNTER|`datakit_process_io_count_total`|`type`|Datakit process IO count|
|*internal/metrics*|COUNTER|`datakit_process_io_bytes_total`|`type`|Datakit process IO bytes count|
|*internal/ntp*|COUNTER|`datakit_ntp_sync_total`|`N/A`|Total count synced with remote NTP server|
|*internal/ntp*|SUMMARY|`datakit_ntp_time_diff`|`N/A`|Time difference(seconds) between remote NTP server|
|*internal/pipeline/offload*|COUNTER|`datakit_pipeline_offload_point_total`|`category,exporter,remote`|Pipeline offload processed total points|
|*internal/pipeline/offload*|COUNTER|`datakit_pipeline_offload_error_point_total`|`category,exporter,remote`|Pipeline offload processed total error points|
|*internal/pipeline/offload*|SUMMARY|`datakit_pipeline_offload_cost_seconds`|`category,exporter,remote`|Pipeline offload total cost|
|*internal/plugins/inputs/container/kubernetes*|GAUGE|`datakit_input_container_kubernetes_fetch_error`|`namespace,resource,error`|Kubernetes resource fetch error|
|*internal/plugins/inputs/container/kubernetes*|SUMMARY|`datakit_input_container_kubernetes_collect_cost_seconds`|`category`|Kubernetes collect cost|
|*internal/plugins/inputs/container/kubernetes*|SUMMARY|`datakit_input_container_kubernetes_collect_resource_cost_seconds`|`category,kind,fieldselector`|Kubernetes collect resource cost|
|*internal/plugins/inputs/container/kubernetes*|COUNTER|`datakit_input_container_kubernetes_collect_pts_total`|`category`|Kubernetes collect point total|
|*internal/plugins/inputs/container/kubernetes*|COUNTER|`datakit_input_container_kubernetes_pod_metrics_query_total`|`target`|Kubernetes query pod metrics count|
|*internal/plugins/inputs/container*|SUMMARY|`datakit_input_container_collect_cost_seconds`|`category`|Container collect cost|
|*internal/plugins/inputs/container*|COUNTER|`datakit_input_container_collect_pts_total`|`category`|Container collect point total|
|*internal/plugins/inputs/container*|SUMMARY|`datakit_input_container_total_collect_cost_seconds`|`category`|Total container collect cost|
|*internal/plugins/inputs/ddtrace*|COUNTER|`datakit_input_ddtrace_truncated_spans_total`|`input`|Truncated trace spans|
|*internal/plugins/inputs/ddtrace*|COUNTER|`datakit_input_ddtrace_dropped_trace_total`|`url`|Dropped illegal traces|
|*internal/plugins/inputs/ddtrace*|SUMMARY|`datakit_input_ddtrace_trace_spans`|`input`|Trace spans(include truncated spans)|
|*internal/plugins/inputs/dialtesting*|SUMMARY|`datakit_dialtesting_task_run_cost_seconds`|`region,protocol`|Task run time|
|*internal/plugins/inputs/dialtesting*|SUMMARY|`datakit_dialtesting_task_exec_time_interval_seconds`|`region,protocol`|Task execution time interval|
|*internal/plugins/inputs/dialtesting*|GAUGE|`datakit_dialtesting_worker_job_chan_number`|`type`|The number of the channel for the jobs|
|*internal/plugins/inputs/dialtesting*|GAUGE|`datakit_dialtesting_worker_job_number`|`N/A`|The number of the jobs to send data in parallel|
|*internal/plugins/inputs/dialtesting*|GAUGE|`datakit_dialtesting_worker_cached_points_number`|`region,protocol`|The number of cached points|
|*internal/plugins/inputs/dialtesting*|GAUGE|`datakit_dialtesting_worker_send_points_number`|`region,protocol,status`|The number of the points which have been sent|
|*internal/plugins/inputs/dialtesting*|SUMMARY|`datakit_dialtesting_worker_send_cost_seconds`|`region,protocol`|Time cost to send points|
|*internal/plugins/inputs/dialtesting*|GAUGE|`datakit_dialtesting_task_number`|`region,protocol`|The number of tasks|
|*internal/plugins/inputs/dialtesting*|GAUGE|`datakit_dialtesting_dataway_send_failed_number`|`region,protocol`|The number of failed sending|
|*internal/plugins/inputs/dialtesting*|SUMMARY|`datakit_dialtesting_pull_cost_seconds`|`region,is_first`|Time cost to pull tasks|
|*internal/plugins/inputs/dialtesting*|COUNTER|`datakit_dialtesting_task_synchronized_total`|`region,protocol`|Task synchronized number|
|*internal/plugins/inputs/dialtesting*|COUNTER|`datakit_dialtesting_task_invalid_total`|`region,protocol,fail_reason`|Invalid task number|
|*internal/plugins/inputs/dialtesting*|SUMMARY|`datakit_dialtesting_task_check_cost_seconds`|`region,protocol,status`|Task check time|
|*internal/plugins/inputs/graphite/cache*|GAUGE|`datakit_input_graphite_metric_mapper_cache_length`|`N/A`|The count of unique metrics currently cached.|
|*internal/plugins/inputs/graphite/cache*|COUNTER|`datakit_input_graphite_metric_cache_gets_total`|`N/A`|The count of total metric cache gets.|
|*internal/plugins/inputs/graphite/cache*|COUNTER|`datakit_input_graphite_metric_mapper_cache_hits_total`|`N/A`|The count of total metric cache hits.|
|*internal/plugins/inputs/graphite*|COUNTER|`datakit_input_graphite_tag_parse_failures_total`|`N/A`|Total count of samples with invalid tags|
|*internal/plugins/inputs/graphite*|GAUGE|`datakit_input_graphite_last_processed_timestamp_seconds`|`N/A`|Unix timestamp of the last processed graphite metric.|
|*internal/plugins/inputs/graphite*|GAUGE|`datakit_input_graphite_sample_expiry_seconds`|`N/A`|How long in seconds a metric sample is valid for.|
|*internal/plugins/inputs/kafkamq*|COUNTER|`datakit_input_kafkamq_consumer_message_total`|`topic,partition,status`|Kafka consumer message numbers from Datakit start|
|*internal/plugins/inputs/kafkamq*|COUNTER|`datakit_input_kafkamq_group_election_total`|`N/A`|Kafka group election count|
|*internal/plugins/inputs/kafkamq*|SUMMARY|`datakit_input_kafkamq_process_message_nano`|`topic`|kafkamq process message nanoseconds duration|
|*internal/plugins/inputs/kubernetesprometheus*|COUNTER|`datakit_input_kubernetesprometheus_resource_collect_pts_total`|`role,name`|The number of the points which have been sent|
|*internal/plugins/inputs/kubernetesprometheus*|GAUGE|`datakit_input_kubernetesprometheus_resource_target_number`|`role,name`|The number of the target|
|*internal/plugins/inputs/kubernetesprometheus*|SUMMARY|`datakit_input_kubernetesprometheus_resource_scrape_cost_seconds`|`role,name,url`|The scrape cost in seconds|
|*internal/plugins/inputs/kubernetesprometheus*|GAUGE|`datakit_input_kubernetesprometheus_worker_number`|`role,worker`|The number of the worker|
|*internal/plugins/inputs*|GAUGE|`datakit_inputs_instance`|`input`|Input instance count|
|*internal/plugins/inputs*|COUNTER|`datakit_inputs_crash_total`|`input`|Input crash count|
|*internal/plugins/inputs/ploffload*|GAUGE|`datakit_input_ploffload_chan_capacity`|`channel_name`|PlOffload channel capacity|
|*internal/plugins/inputs/ploffload*|GAUGE|`datakit_input_ploffload_chan_usage`|`channel_name`|PlOffload channel usage|
|*internal/plugins/inputs/ploffload*|COUNTER|`datakit_input_ploffload_point_total`|`category`|PlOffload processed total points|
|*internal/plugins/inputs/promremote*|SUMMARY|`datakit_input_promremote_collect_points`|`source`|Total number of promremote collection points|
|*internal/plugins/inputs/promremote*|SUMMARY|`datakit_input_promremote_time_diff_in_second`|`source`|Time diff with local time|
|*internal/plugins/inputs/promremote*|COUNTER|`datakit_input_promremote_no_time_points_total`|`source`|Total number of promremote collection no time points|
|*internal/plugins/inputs/promv2*|SUMMARY|`datakit_input_promv2_scrape_points`|`source,remote`|The number of points scrape from endpoint|
|*internal/plugins/inputs/proxy/bench/client*|GAUGE|`api_elapsed_seconds`|`N/A`|Proxied API elapsed seconds|
|*internal/plugins/inputs/proxy/bench/client*|COUNTER|`api_post_bytes_total`|`api,status`|Proxied API post bytes total|
|*internal/plugins/inputs/proxy/bench/client*|SUMMARY|`api_latency_seconds`|`api,status`|Proxied API latency|
|*internal/plugins/inputs/proxy*|COUNTER|`datakit_input_proxy_connect_total`|`client_ip`|Proxy connect(method CONNECT)|
|*internal/plugins/inputs/proxy*|COUNTER|`datakit_input_proxy_api_total`|`api,method`|Proxy API total|
|*internal/plugins/inputs/proxy*|SUMMARY|`datakit_input_proxy_api_latency_seconds`|`api,method,status`|Proxy API latency|
|*internal/plugins/inputs/rum*|COUNTER|`datakit_input_rum_session_replay_drop_total`|`app_id,env,version,service`|statistics the total count of session replay points which have been filtered by rules|
|*internal/plugins/inputs/rum*|COUNTER|`datakit_input_rum_session_replay_drop_bytes_total`|`app_id,env,version,service`|statistics the total bytes of session replay points which have been filtered by rules|
|*internal/plugins/inputs/rum*|COUNTER|`datakit_input_rum_locate_statistics_total`|`app_id,ip_status,locate_status`|locate by ip addr statistics|
|*internal/plugins/inputs/rum*|COUNTER|`datakit_input_rum_source_map_total`|`app_id,sdk_name,status,remark`|source map result statistics|
|*internal/plugins/inputs/rum*|GAUGE|`datakit_input_rum_loaded_zips`|`platform`|RUM source map currently loaded zip archive count|
|*internal/plugins/inputs/rum*|SUMMARY|`datakit_input_rum_source_map_duration_seconds`|`sdk_name,app_id,env,version`|statistics elapsed time in RUM source map(unit: second)|
|*internal/plugins/inputs/rum*|SUMMARY|`datakit_input_rum_session_replay_upload_latency_seconds`|`app_id,env,version,service,status_code`|statistics elapsed time in session replay uploading|
|*internal/plugins/inputs/rum*|COUNTER|`datakit_input_rum_session_replay_upload_failure_total`|`app_id,env,version,service,status_code`|statistics count of session replay points which which have unsuccessfully uploaded|
|*internal/plugins/inputs/rum*|COUNTER|`datakit_input_rum_session_replay_upload_failure_bytes_total`|`app_id,env,version,service,status_code`|statistics the total bytes of session replay points which have unsuccessfully uploaded|
|*internal/plugins/inputs/rum*|SUMMARY|`datakit_input_rum_session_replay_read_body_delay_seconds`|`app_id,env,version,service`|statistics the duration of reading session replay body|
|*internal/plugins/inputs/snmp*|SUMMARY|`datakit_input_snmp_discovery_cost`|`profile_type`|Discovery cost(in second)|
|*internal/plugins/inputs/snmp*|SUMMARY|`datakit_input_snmp_collect_cost`|`N/A`|Every loop collect cost(in second)|
|*internal/plugins/inputs/snmp*|SUMMARY|`datakit_input_snmp_device_collect_cost`|`class`|Device collect cost(in second)|
|*internal/plugins/inputs/snmp*|GAUGE|`datakit_input_snmp_alive_devices`|`class`|Alive devices|
|*internal/prom*|SUMMARY|`datakit_input_prom_collect_points`|`mode,source`|Total number of prom collection points|
|*internal/prom*|SUMMARY|`datakit_input_prom_http_get_bytes`|`mode,source`|HTTP get bytes|
|*internal/prom*|SUMMARY|`datakit_input_prom_http_latency_in_second`|`mode,source`|HTTP latency(in second)|
|*internal/prom*|GAUGE|`datakit_input_prom_stream_size`|`mode,source`|Stream size|
|*internal/statsd*|SUMMARY|`datakit_input_statsd_collect_points`|`N/A`|Total number of statsd collection points|
|*internal/statsd*|SUMMARY|`datakit_input_statsd_accept_bytes`|`N/A`|Accept bytes from network|
|*internal/tailer*|GAUGE|`datakit_input_logging_pending_byte_size`|`source,filepath`|The size of bytes that are pending processing|
|*internal/tailer*|COUNTER|`datakit_tailer_file_rotate_total`|`source,filepath`|Tailer rotate total|
|*internal/tailer*|COUNTER|`datakit_tailer_parse_fail_total`|`source,filepath,mode`|Tailer parse fail total|
|*internal/tailer*|GAUGE|`datakit_tailer_open_file_num`|`mode`|Tailer open file total|
|*internal/tailer*|COUNTER|`datakit_input_logging_socket_connect_status_total`|`network,status`|Connect and close count for net.conn|
|*internal/tailer*|COUNTER|`datakit_input_logging_socket_feed_message_count_total`|`network`|Socket feed to IO message count|
|*internal/tailer*|SUMMARY|`datakit_input_logging_socket_log_length`|`network`|Record the length of each log line|
|*internal/tailer*|GAUGE|`datakit_input_logging_pending_block_length`|`source,filepath`|The length of blocks that are pending processing|
|*internal/trace*|COUNTER|`datakit_input_tracing_total`|`input,service`|The total links number of Trace processed by the trace module|
|*internal/trace*|COUNTER|`datakit_input_sampler_total`|`input,service`|The sampler number of Trace processed by the trace module|
|*vendor/github.com/GuanceCloud/cliutils/diskcache*|SUMMARY|`diskcache_dropped_data`|`path,reason`|Dropped data during Put() when capacity reached.|
|*vendor/github.com/GuanceCloud/cliutils/diskcache*|COUNTER|`diskcache_rotate_total`|`path`|Cache rotate count, mean file rotate from data to data.0000xxx|
|*vendor/github.com/GuanceCloud/cliutils/diskcache*|COUNTER|`diskcache_remove_total`|`path`|Removed file count, if some file read EOF, remove it from un-read list|
|*vendor/github.com/GuanceCloud/cliutils/diskcache*|COUNTER|`diskcache_wakeup_total`|`path`|Wakeup count on sleeping write file|
|*vendor/github.com/GuanceCloud/cliutils/diskcache*|COUNTER|`diskcache_seek_back_total`|`path`|Seek back when Get() got any error|
|*vendor/github.com/GuanceCloud/cliutils/diskcache*|GAUGE|`diskcache_capacity`|`path`|Current capacity(in bytes)|
|*vendor/github.com/GuanceCloud/cliutils/diskcache*|GAUGE|`diskcache_max_data`|`path`|Max data to Put(in bytes), default 0|
|*vendor/github.com/GuanceCloud/cliutils/diskcache*|GAUGE|`diskcache_batch_size`|`path`|Data file size(in bytes)|
|*vendor/github.com/GuanceCloud/cliutils/diskcache*|GAUGE|`diskcache_size`|`path`|Current cache size(in bytes)|
|*vendor/github.com/GuanceCloud/cliutils/diskcache*|GAUGE|`diskcache_open_time`|`no_fallback_on_error,no_lock,no_pos,no_sync,path`|Current cache Open time in unix timestamp(second)|
|*vendor/github.com/GuanceCloud/cliutils/diskcache*|GAUGE|`diskcache_last_close_time`|`path`|Current cache last Close time in unix timestamp(second)|
|*vendor/github.com/GuanceCloud/cliutils/diskcache*|GAUGE|`diskcache_datafiles`|`path`|Current un-read data files|
|*vendor/github.com/GuanceCloud/cliutils/diskcache*|SUMMARY|`diskcache_stream_put`|`path`|Stream put times|
|*vendor/github.com/GuanceCloud/cliutils/diskcache*|SUMMARY|`diskcache_get_latency`|`path`|Get() cost seconds|
|*vendor/github.com/GuanceCloud/cliutils/diskcache*|SUMMARY|`diskcache_put_latency`|`path`|Put() cost seconds|
|*vendor/github.com/GuanceCloud/cliutils/diskcache*|SUMMARY|`diskcache_put_bytes`|`path`|Cache Put() bytes|
|*vendor/github.com/GuanceCloud/cliutils/diskcache*|SUMMARY|`diskcache_get_bytes`|`path`|Cache Get() bytes|
|*vendor/github.com/GuanceCloud/cliutils/point*|COUNTER|`pointpool_chan_get_total`|`N/A`|Get count from reserved channel|
|*vendor/github.com/GuanceCloud/cliutils/point*|COUNTER|`pointpool_chan_put_total`|`N/A`|Put count to reserved channel|
|*vendor/github.com/GuanceCloud/cliutils/point*|COUNTER|`pointpool_pool_get_total`|`N/A`|Get count from reserved channel|
|*vendor/github.com/GuanceCloud/cliutils/point*|COUNTER|`pointpool_pool_put_total`|`N/A`|Put count to reserved channel|
|*vendor/github.com/GuanceCloud/cliutils/point*|COUNTER|`pointpool_reserved_capacity`|`N/A`|Reserved capacity of the pool|
|*vendor/github.com/GuanceCloud/cliutils/point*|COUNTER|`pointpool_malloc_total`|`N/A`|New object malloc from pool|
|*vendor/github.com/GuanceCloud/cliutils/point*|COUNTER|`pointpool_escaped`|`N/A`|Points that not comes from pool|

### Golang 运行时指标 {#go-runtime-metrics}

Datakit 在其 `/metrics` 接口上也暴露了 Golang 运行时指标，指标示例如下：

```not-set
go_cgo_go_to_c_calls_calls_total 8447
go_gc_cycles_automatic_gc_cycles_total 10
go_gc_cycles_forced_gc_cycles_total 0
go_gc_cycles_total_gc_cycles_total 10
go_gc_duration_seconds{quantile="0"} 3.4709e-05
go_gc_duration_seconds{quantile="0.25"} 3.9917e-05
go_gc_duration_seconds{quantile="0.5"} 0.000138459
go_gc_duration_seconds{quantile="0.75"} 0.000211333
go_gc_duration_seconds{quantile="1"} 0.000693833
go_gc_duration_seconds_sum 0.001920708
go_gc_duration_seconds_count 10
go_gc_heap_allocs_by_size_bytes_bucket{le="8.999999999999998"} 16889
go_gc_heap_allocs_by_size_bytes_bucket{le="24.999999999999996"} 221293
go_gc_heap_allocs_by_size_bytes_bucket{le="64.99999999999999"} 365672
go_gc_heap_allocs_by_size_bytes_bucket{le="144.99999999999997"} 475633
go_gc_heap_allocs_by_size_bytes_bucket{le="320.99999999999994"} 507361
go_gc_heap_allocs_by_size_bytes_bucket{le="704.9999999999999"} 516511
go_gc_heap_allocs_by_size_bytes_bucket{le="1536.9999999999998"} 521176
go_gc_heap_allocs_by_size_bytes_bucket{le="3200.9999999999995"} 522802
go_gc_heap_allocs_by_size_bytes_bucket{le="6528.999999999999"} 524529
go_gc_heap_allocs_by_size_bytes_bucket{le="13568.999999999998"} 525164
go_gc_heap_allocs_by_size_bytes_bucket{le="27264.999999999996"} 525269
go_gc_heap_allocs_by_size_bytes_bucket{le="+Inf"} 525421
go_gc_heap_allocs_by_size_bytes_sum 7.2408264e+07
go_gc_heap_allocs_by_size_bytes_count 525421
go_gc_heap_allocs_bytes_total 7.2408264e+07
go_gc_heap_allocs_objects_total 525421
go_gc_heap_frees_by_size_bytes_bucket{le="8.999999999999998"} 11081
go_gc_heap_frees_by_size_bytes_bucket{le="24.999999999999996"} 168291
go_gc_heap_frees_by_size_bytes_bucket{le="64.99999999999999"} 271749
go_gc_heap_frees_by_size_bytes_bucket{le="144.99999999999997"} 352424
go_gc_heap_frees_by_size_bytes_bucket{le="320.99999999999994"} 378481
go_gc_heap_frees_by_size_bytes_bucket{le="704.9999999999999"} 385700
go_gc_heap_frees_by_size_bytes_bucket{le="1536.9999999999998"} 389443
go_gc_heap_frees_by_size_bytes_bucket{le="3200.9999999999995"} 390591
go_gc_heap_frees_by_size_bytes_bucket{le="6528.999999999999"} 392069
go_gc_heap_frees_by_size_bytes_bucket{le="13568.999999999998"} 392565
go_gc_heap_frees_by_size_bytes_bucket{le="27264.999999999996"} 392636
go_gc_heap_frees_by_size_bytes_bucket{le="+Inf"} 392747
go_gc_heap_frees_by_size_bytes_sum 5.3304296e+07
go_gc_heap_frees_by_size_bytes_count 392747
go_gc_heap_frees_bytes_total 5.3304296e+07
go_gc_heap_frees_objects_total 392747
go_gc_heap_goal_bytes 3.6016864e+07
go_gc_heap_objects_objects 132674
go_gc_heap_tiny_allocs_objects_total 36033
go_gc_limiter_last_enabled_gc_cycle 0
go_gc_pauses_seconds_bucket{le="9.999999999999999e-10"} 0
go_gc_pauses_seconds_bucket{le="9.999999999999999e-09"} 0
go_gc_pauses_seconds_bucket{le="9.999999999999998e-08"} 0
go_gc_pauses_seconds_bucket{le="1.0239999999999999e-06"} 0
go_gc_pauses_seconds_bucket{le="1.0239999999999999e-05"} 1
go_gc_pauses_seconds_bucket{le="0.00010239999999999998"} 15
go_gc_pauses_seconds_bucket{le="0.0010485759999999998"} 20
go_gc_pauses_seconds_bucket{le="0.010485759999999998"} 20
go_gc_pauses_seconds_bucket{le="0.10485759999999998"} 20
go_gc_pauses_seconds_bucket{le="+Inf"} 20
go_gc_pauses_seconds_sum 0.000656384
go_gc_pauses_seconds_count 20
go_gc_stack_starting_size_bytes 4096
go_goroutines 102
go_info{version="go1.19.5"} 1
go_memory_classes_heap_free_bytes 8.839168e+06
go_memory_classes_heap_objects_bytes 1.9103968e+07
go_memory_classes_heap_released_bytes 3.530752e+06
go_memory_classes_heap_stacks_bytes 2.4576e+06
go_memory_classes_heap_unused_bytes 8.011552e+06
go_memory_classes_metadata_mcache_free_bytes 3600
go_memory_classes_metadata_mcache_inuse_bytes 12000
go_memory_classes_metadata_mspan_free_bytes 77472
go_memory_classes_metadata_mspan_inuse_bytes 426960
go_memory_classes_metadata_other_bytes 6.201928e+06
go_memory_classes_os_stacks_bytes 0
go_memory_classes_other_bytes 1.931459e+06
go_memory_classes_profiling_buckets_bytes 1.489565e+06
go_memory_classes_total_bytes 5.2086024e+07
go_memstats_alloc_bytes 1.9103968e+07
go_memstats_alloc_bytes_total 7.2408264e+07
go_memstats_buck_hash_sys_bytes 1.489565e+06
go_memstats_frees_total 428780
go_memstats_gc_sys_bytes 6.201928e+06
go_memstats_heap_alloc_bytes 1.9103968e+07
go_memstats_heap_idle_bytes 1.236992e+07
go_memstats_heap_inuse_bytes 2.711552e+07
go_memstats_heap_objects 132674
go_memstats_heap_released_bytes 3.530752e+06
go_memstats_heap_sys_bytes 3.948544e+07
go_memstats_last_gc_time_seconds 1.6992580814748092e+09
go_memstats_lookups_total 0
go_memstats_mallocs_total 561454
go_memstats_mcache_inuse_bytes 12000
go_memstats_mcache_sys_bytes 15600
go_memstats_mspan_inuse_bytes 426960
go_memstats_mspan_sys_bytes 504432
go_memstats_next_gc_bytes 3.6016864e+07
go_memstats_other_sys_bytes 1.931459e+06
go_memstats_stack_inuse_bytes 2.4576e+06
go_memstats_stack_sys_bytes 2.4576e+06
go_memstats_sys_bytes 5.2086024e+07
go_sched_gomaxprocs_threads 10
go_sched_goroutines_goroutines 102
go_sched_latencies_seconds_bucket{le="9.999999999999999e-10"} 4886
go_sched_latencies_seconds_bucket{le="9.999999999999999e-09"} 4886
go_sched_latencies_seconds_bucket{le="9.999999999999998e-08"} 5883
go_sched_latencies_seconds_bucket{le="1.0239999999999999e-06"} 6669
go_sched_latencies_seconds_bucket{le="1.0239999999999999e-05"} 7191
go_sched_latencies_seconds_bucket{le="0.00010239999999999998"} 7531
go_sched_latencies_seconds_bucket{le="0.0010485759999999998"} 7567
go_sched_latencies_seconds_bucket{le="0.010485759999999998"} 7569
go_sched_latencies_seconds_bucket{le="0.10485759999999998"} 7569
go_sched_latencies_seconds_bucket{le="+Inf"} 7569
go_sched_latencies_seconds_sum 0.00988825
go_sched_latencies_seconds_count 7569
go_threads 16
```
