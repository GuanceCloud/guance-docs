---
title     : 'Exchange'
summary   : 'Collect metrics related to Exchange'
__int_icon: 'icon/exchange'
dashboard :
  - desc  : 'Exchange monitoring view'
    path  : 'dashboard/en/exchange'
---

<!-- markdownlint-disable MD025 -->

# Exchange
<!-- markdownlint-enable -->

## Installation and Deployment {#config}

Note: The example [Exchange exporter](https://github.com/prometheus-community/windows_exporter) version is 0.24.0 (Windows)

### Enable DataKit Collector

- Enable the DataKit Prom plugin, copy the sample file

```cmd
cd C:\Program Files\datakit\conf.d\prom
# Copy prom.conf.sample to prom.conf
```

- Modify the `prom.conf` configuration file

<!-- markdownlint-disable MD046 -->

??? quote "Configuration as follows"

    ```toml
    [[inputs.prom]]
    ## Exporter URLs
    urls = ["http://127.0.0.1:9182/metrics"]
    
    ## Ignore request errors for URLs
    ignore_req_err = false
    
    ## Collector alias
    source = "exchange"
    
    ## Output source for collected data
    # Configure this option to write collected data to a local file instead of sending it to the central system
    # You can then use the command `datakit --prom-conf /path/to/this/conf` to debug the locally saved Metrics
    # If the URL has already been configured as a local file path, the `--prom-conf` flag takes precedence in debugging the output path data
    # output = "/abs/path/to/file"
    > 
    ## Maximum size limit for collected data, in bytes
    # When outputting data to a local file, you can set a maximum size limit for the collected data
    # If the size of the collected data exceeds this limit, the data will be discarded
    # The default maximum size limit is set to 32MB
    # max_file_size = 0
    
    ## Metric type filtering, optional values are counter, gauge, histogram, summary
    # By default, only counter and gauge types of metrics are collected
    # If empty, no filtering is applied
    metric_types = ["counter", "gauge"]
    
    ## Metric name filtering
    # Supports regex, multiple configurations can be set, satisfying any one condition suffices
    # If empty, no filtering is applied
    # metric_name_filter = ["cpu"]
    
    ## Prefix for metric set names
    # Configure this option to add a prefix to the metric set names
    measurement_prefix = ""
    
    ## Metric set name
    # By default, the metric name is split by underscores "_", with the first part becoming the metric set name and the rest forming the current metric name
    # If `measurement_name` is configured, no splitting of the metric name occurs
    # The final metric set name will have the `measurement_prefix` added as a prefix
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
    # Metrics containing the prefix can be grouped into a single metric set
    # Custom metric set name configuration takes precedence over the `measurement_name` setting
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

- Restart DataKit (If you need to enable logging, configure log collection before restarting)

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

| Metric Set | Metric                                      | Meaning                                                         | Significance                                                     |
| ---------- | ------------------------------------------- | --------------------------------------------------------------- | ---------------------------------------------------------------- |
| exchange   | windows_exchange_owa_current_unique_users   | Number of unique users currently logged on to Outlook Web App   | Monitor the number of active users using OWA                    |
| exchange   | windows_net_packets_outbound_errors_total   | Number of outbound packet errors from the host NIC              | Normally, NIC should not have error packets. A non-zero value indicates network issues |
| exchange   | windows_exchange_workload_active_tasks      | Number of active tasks currently running in the background for workload management | Number of active workload management tasks                       |
| exchange   | windows_exchange_workload_queued_tasks      | Number of workload management tasks currently queued waiting to be processed | Shows the number of workload management tasks **queued for processing** |
| exchange   | usage_total                                 | CPU utilization                                                 | Reflects load                                                   |
| exchange   | available                                   | Available memory                                                | Reflects load                                                   |

### Web Category

| Metric Set | Metric                                       | Meaning                                                         | Monitoring Significance                                                   |
| ---------- | -------------------------------------------- | --------------------------------------------------------------- | ------------------------------------------------------------------------- |
| exchange   | windows_exchange_owa_current_unique_users    | Number of unique users currently logged on to Outlook Web App   | Monitor the number of active users using OWA, same as above               |
| exchange   | windows_exchange_owa_requests_total          | Number of requests handled by Outlook Web App per second        | OWA requests per second, reflecting OWA's busy status                     |
| exchange   | windows_exchange_activesync_requests_total   | Number of HTTP requests received from the client via ASP.NET per second. Shows current user load | Displays the rate of HTTP requests received via ASP.NET per second. Indicates the current Exchange ActiveSync request rate |

### RPC Category

| Metric Set | Metric                                  | Meaning                                                  | Monitoring Significance                                                   |
| ---------- | --------------------------------------- | -------------------------------------------------------- | ------------------------------------------------------------------------- |
| exchange   | windows_exchange_rpc_connection_count   | Total number of client connections maintained            | Shows the total number of maintained client connections                   |
| exchange   | windows_exchange_rpc_user_count         | Number of users                                          | Shows the number of users connected to the service                        |
| exchange   | windows_exchange_rpc_avg_latency_sec    | Average latency (seconds) over the past 1024 packets     | Shows the average latency over the past 1,024 packets (should be less than 250ms). Higher RPC response times affect user experience and Outlook processing time |
| exchange   | windows_exchange_rpc_operations_total   | Rate at which RPC operations occur                       | Rate of RPC operations                                                    |