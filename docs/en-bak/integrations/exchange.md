---
title     : 'Exchange'
summary   : 'Collect Exchange related metric information'
__int_icon: 'icon/exchange'
dashboard :
  - desc  : 'exchange monitoring view'
    path  : 'dashboard/zh/exchange'
---

<!-- markdownlint-disable MD025 -->

# Exchange
<!-- markdownlint-enable -->

## Installation and Deployment {#config}

Note: Example [Exchange exporter](https://github.com/prometheus-community/windows_exporter) version is 0.24.0 (Windows)

### Turn on the DataKit collector

- Turn on the DataKit Prom plugin and copy the sample file

```cmd
cd C:\Program Files\datakit\conf.d\prom
# Copy prom.conf.sample as prom.conf
```

- Modify the `prom.conf` configuration file

<!-- markdownlint-disable MD046 -->

??? Quote "The configuration is as follows"

    ```toml
    [[inputs.prom]]
    ## Exporter URLs
    urls = ["http://127.0.0.1:9182/metrics"]
    
    ## Ignore request errors for the url
    ignore_req_err = false
    
    ## Collector alias
    source = "exchange"
    
    ## Data collection output source
    # Configuring this item can write the collected data to a local file instead of sending the data to the center
    # You can then directly use the datakit --prom-conf /path/to/this/conf command to debug the locally saved metric set
    # If the url is configured as a local file path, --prom-conf will preferentially debug the data of the output path
    # output = "/abs/path/to/file"
    > 
    ## Maximum size of collected data, in bytes
    # When outputting data to a local file, you can set the maximum size of collected data
    # If the size of the collected data exceeds this limit, the collected data will be discarded
    # The maximum size of collected data is set to 32MB by default
    # max_file_size = 0
    
    ## Filter metric types, optional values are counter, gauge, histogram, summary
    # By default, only counter and gauge type metrics are collected
    # If it is empty, no filtering is performed
    metric_types = ["counter", "gauge"]
    
    ## Filter metric names
    # Support regex, can configure multiple, i.e., satisfaction of one is sufficient
    # If it is empty, no filtering is performed
    # metric_name_filter = ["cpu"]
    
    ## Metric set name prefix
    # Configuring this item can add a prefix to the metric set name
    measurement_prefix = ""
    
    ## Metric set name
    # By default, the metric name will be split with an underscore "_", and the first field after the split will be used as the metric set name, and the remaining fields as the current metric name
    # If measurement_name is configured, the metric name will not be split
    # The final metric set name will add the measurement_prefix prefix
    # measurement_name = "prom"
    
    ## Collection interval "ns", "us" (or "µs"), "ms", "s", "m", "h"
    interval = "10s"
    
    ## Filter tags, you can configure multiple tags
    # Matching tags will be ignored
    # tags_ignore = ["xxxx"]
    
    ## TLS configuration
    tls_open = false
    # tls_ca = "/tmp/ca.crt"
    # tls_cert = "/tmp/peer.crt"
    # tls_key = "/tmp/peer.key"
    
    ## Custom authentication method, currently only supports Bearer Token
    # token and token_file: only one of them needs to be configured
    # [inputs.prom.auth]
    # type = "bearer_token"
    # token = "xxxxxxxx"
    # token_file = "/tmp/token"
    
    ## Custom metric set name
    # You can group metrics with the prefix prefix into one type of metric set
    # The custom metric set name configuration takes precedence over the measurement_name configuration item
    #[[inputs.prom.measurements]]
    #  prefix = "cpu_"
    #  name = "cpu"
    
    # [[inputs.prom.measurements]]
    # prefix = "mem_"
    # name = "mem"
    
    ## Custom Tags
    [inputs.prom.tags]
      service = "exchange"
    # more_tag = "some_other_value"
    ```
<!-- markdownlint-enable -->

- Restart DataKit (if you need to turn on the log, please configure the log collection and restart)

```bash
systemctl restart datakit
```

- DQL verification

```bash
[root@df-solution-ecs-018 prom]# datakit -Q

Flag -Q deprecated, please use datakit help to use recommend flags.

dqlcmd: &cmds.dqlCmd{json:false, autoJSON:false, verbose:false, csv:"", forceWriteCSV:false, dqlString:"", token:"tkn_9a49a7e9343c432eb0b99a297401c3bb", host:"0.0.0.0:9529", log:"", dqlcli:(*http.Client)(0xc0009a5800)}
dql > M::exchange LIMIT 1
-----------------[ r1.exchange.s1 ]-----------------
                              
                   windows_ad_atq_average_request_latency 0
                           windows_ad_atq_current_threads 44
                      windows_ad_atq_outstanding_requests 0
                          windows_ad_ldap_client_sessions '1.0'
  windows_ad_replication_inbound_properties_updated_total '0.0'
                windows_ad_replication_pending_operations '0.0'
                                  .....
                              
                                      windows_cs_hostname 2
                         windows_cs_physical_memory_bytes 0
                                                     time 2023-11-1 16:00:10 +0800 CST
                      windows_exchange_owa_requests_total 0
                          windows_exchange_rpc_user_count 0                                   
                              windows_exporter_build_info 0
                                                   uptime 2858680025
              windows_exporter_collector_duration_seconds 0
---------
1 rows, 1 series, cost 40.297037ms
```

## Detailed Explanation of Metrics {#metric}

### General Classification

| Metric Set | Metric                                        | Meaning                                                     | Metric Meaning                                               |
| ---------- | --------------------------------------------- | ----------------------------------------------------------- | ------------------------------------------------------------ |
| exchange   | windows_exchange_owa_current_unique_users     | Number of unique users currently logged on to Outlook Web App | Monitor the number of active users using OWA                 |
| exchange   | windows_net_packets_outbound_errors_total     | The number of errors in the host network card outbound      | Normally, the network card should not have an error package number, if this number is not 0, it means there are errors at the network level |
| exchange   | windows_exchange_workload_active_tasks        | Number of active tasks currently running in the background for workload management | The number of active tasks for Workload                      |
| exchange   | windows_exchange_workload_queued_tasks        | Number of workload management tasks that are currently queued up waiting to be processed | Shows the number of workload management tasks currently **queued up for processing**. |
| exchange   | usage_total                                   | CPU utilization                                             | Reflects the load                                            |
| exchange   | available                                     | The amount of available memory                              | Reflects the load                                            |

### Web Classification

| Metric Set | Metric                                    | Meaning                                                     | Monitoring Meaning                                           |
| ---------- | ----------------------------------------- | ----------------------------------------------------------- | ------------------------------------------------------------ |
| exchange   | windows_exchange_owa_current_unique_users  | Number of unique users currently logged on to Outlook Web App | Monitor the number of active users using OWA, same as above  |
| exchange   | windows_exchange_owa_requests_total        | Number of requests handled by Outlook Web App per second     | The number of requests per second handled by OWA, reflecting the busyness of OWA |
| exchange   | windows_exchange_activesync_requests_total | Num HTTP requests received from the client via ASP.NET per sec. Shows Current user load | Shows the number of HTTP requests received per second from the client via ASP.NET. Determines the current Exchange ActiveSync request rate |

### RPC Classification

| Metric Set | Metric                               | Meaning                                                | Monitoring Meaning                                           |
| ---------- | ------------------------------------ | ------------------------------------------------------- | ------------------------------------------------------------ |
| exchange   | windows_exchange_rpc_connection_count | Total number of client connections maintained           | Shows the total number of client connections maintained      |
| exchange   | windows_exchange_rpc_user_count       | Number of users                                        | Shows the number of users connected to the service.          |
| exchange   | windows_exchange_rpc_avg_latency_sec  | The latency (sec), averaged for the past 1024 packets  | Shows the average latency (milliseconds) of the past 1,024 packets. Should be less than 250ms. Higher RPC response values will affect user experience and Outlook processing time |
| exchange   | windows_exchange_rpc_operations_total | The rate at which RPC operations occur                  | The rate of RPC operations                                    |
