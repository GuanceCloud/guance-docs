---
title     : 'Exchange'
summary   : 'Collect Exchange related Metrics information'
__int_icon: 'icon/exchange'
dashboard :
  - desc  : 'exchange monitoring view'
    path  : 'dashboard/en/exchange'
---

<!-- markdownlint-disable MD025 -->

# Exchange
<!-- markdownlint-enable -->

## Installation and Deployment {#config}

Note: Example [Exchange exporter](https://github.com/prometheus-community/windows_exporter) version is 0.24.0 (Windows)

### Enable DataKit Collector

- Enable the DataKit Prom plugin, copy the sample file

```cmd
cd C:\Program Files\datakit\conf.d\prom
# Copy prom.conf.sample as prom.conf
```

- Modify the `prom.conf` configuration file

<!-- markdownlint-disable MD046 -->

??? quote "Configuration as follows"

    ```toml
    [[inputs.prom]]
    ## Exporter URLs
    urls = ["http://127.0.0.1:9182/metrics"]
    
    ## Ignore request errors for url
    ignore_req_err = false
    
    ## Collector alias
    source = "exchange"
    
    ## Data collection output source
    # Configuring this item can write the collected data to a local file without sending it to the center
    # You can later directly debug the locally saved Measurements using the command datakit --prom-conf /path/to/this/conf
    # If the url has already been configured as a local file path, then the --prom-conf will prioritize debugging the data in the output path
    # output = "/abs/path/to/file"
    > 
    ## Upper limit of collected data size, in bytes
    # When outputting data to a local file, you can set an upper limit for the size of collected data
    # If the size of the collected data exceeds this upper limit, the collected data will be discarded
    # The default upper limit for the size of collected data is set to 32MB
    # max_file_size = 0
    
    ## Metric type filtering, optional values are counter, gauge, histogram, summary
    # By default, only counter and gauge types of metrics are collected
    # If empty, no filtering will occur
    metric_types = ["counter", "gauge"]
    
    ## Metric name filtering
    # Supports regex, multiple configurations can be applied, meaning any one match suffices
    # If empty, no filtering will occur
    # metric_name_filter = ["cpu"]
    
    ## Prefix for Measurement names
    # Configuring this item can add a prefix to Measurement names
    measurement_prefix = ""
    
    ## Measurement name
    # By default, the metric name will be split by underscores "_", with the first field after splitting used as the Measurement name, and the remaining fields as the current metric name
    # If measurement_name is configured, the metric name will not be split
    # The final Measurement name will have the measurement_prefix prefix added
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
    # token and token_file: only one needs to be configured
    # [inputs.prom.auth]
    # type = "bearer_token"
    # token = "xxxxxxxx"
    # token_file = "/tmp/token"
    
    ## Custom Measurement names
    # Can group metrics containing the prefix prefix into one class of Measurements
    # Custom Measurement name configuration takes precedence over the measurement_name configuration item
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

- Restart DataKit (If log activation is required, configure log collection before restarting)

```bash
systemctl restart datakit
```

- DQL Verification

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

## Metric Details {#metric}

### General Category

| Measurement Set | Metric                                     | Meaning                                                       | Metric Significance                                              |
| -------------- | ------------------------------------------ | ------------------------------------------------------------- | ---------------------------------------------------------------- |
| exchange       | windows_exchange_owa_current_unique_users  | Number of unique users currently logged on to Outlook Web App | Monitors the number of active users using OWA                  |
| exchange       | windows_net_packets_outbound_errors_total | Outgoing network interface error count                        | Under normal circumstances, there should be no error packages. A non-zero value indicates network-level issues. |
| exchange       | windows_exchange_workload_active_tasks     | Number of active tasks currently running in the background for workload management | Number of active tasks for workload management                  |
| exchange       | windows_exchange_workload_queued_tasks     | Number of workload management tasks that are currently queued up waiting to be processed | Displays the number of workload management tasks **currently queued** and waiting to be processed. |
| exchange       | usage_total                                | CPU utilization                                               | Reflects load                                                   |
| exchange       | available                                  | Available memory count                                        | Reflects load                                                   |

### Web Category

| Measurement Set | Metric                                       | Meaning                                                       | Monitoring Significance                                          |
| -------------- | -------------------------------------------- | ------------------------------------------------------------- | --------------------------------------------------------------- |
| exchange       | windows_exchange_owa_current_unique_users    | Number of unique users currently logged on to Outlook Web App | Monitors the number of active users using OWA, same as above  |
| exchange       | windows_exchange_owa_requests_total          | Number of requests handled by Outlook Web App per second      | Shows the number of requests OWA handles per second, reflecting its busy state |
| exchange       | windows_exchange_activesync_requests_total   | Num HTTP requests received from the client via ASP.NET per sec. Shows Current user load | Displays the number of HTTP requests received per second from clients via ASP.NET. Determines the current Exchange ActiveSync request rate |

### RPC Category

| Measurement Set | Metric                                  | Meaning                                                       | Monitoring Significance                                          |
| -------------- | --------------------------------------- | ------------------------------------------------------------- | --------------------------------------------------------------- |
| exchange       | windows_exchange_rpc_connection_count    | Total number of client connections maintained                 | Shows the total number of maintained client connections         |
| exchange       | windows_exchange_rpc_user_count         | Number of users                                              | Displays the number of users connected to the service           |
| exchange       | windows_exchange_rpc_avg_latency_sec    | The latency (sec), averaged for the past 1024 packets         | Shows the average latency in milliseconds for the past 1,024 packets. Should be less than 250ms. Higher RPC response times affect user experience and Outlook processing time |
| exchange       | windows_exchange_rpc_operations_total   | The rate at which RPC operations occur                        | Rate at which RPC operations occur                               |