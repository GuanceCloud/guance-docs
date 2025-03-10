---
title     : 'Active Directory'
summary   : 'Collect metrics related to Active Directory'
__int_icon: 'icon/active_directory'
dashboard :
  - desc  : 'Active Directory monitoring view'
    path  : 'dashboard/en/active_directory'
---

<!-- markdownlint-disable MD025 -->

# Active Directory
<!-- markdownlint-enable -->

## Installation and Deployment {#config}

Note: The example [Active Directory exporter](https://github.com/prometheus-community/windows_exporter) version is 0.24.0 (Windows)

### Enable DataKit Collector

- Enable the DataKit Prom plugin and copy the sample file

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
    source = "active_directory"
    
    ## Output source for collected data
    # Configuring this will write the collected data to a local file instead of sending it to the center
    # Later, you can use the datakit --prom-conf /path/to/this/conf command to debug the locally saved Metrics
    # If the URL is already configured as a local file path, then the --prom-conf option takes precedence in debugging the output path data
    # output = "/abs/path/to/file"
    > 
    ## Maximum size of collected data, in bytes
    # When outputting data to a local file, you can set a maximum size limit for the collected data
    # If the size of the collected data exceeds this limit, the data will be discarded
    # The default maximum size is set to 32MB
    # max_file_size = 0
    
    ## Metric type filter, optional values are counter, gauge, histogram, summary
    # By default, only counter and gauge types of metrics are collected
    # If empty, no filtering is performed
    metric_types = ["counter", "gauge"]
    
    ## Metric name filter
    # Supports regular expressions, multiple configurations can be specified, satisfying any one is enough
    # If empty, no filtering is performed
    # metric_name_filter = ["cpu"]
    
    ## Prefix for metric set names
    # Configuring this adds a prefix to the metric set names
    measurement_prefix = ""
    
    ## Metric set name
    # By default, the metric name is split by underscores "_", with the first field becoming the metric set name and the remaining fields becoming the current metric name
    # If measurement_name is configured, the metric name will not be split
    # The final metric set name will have the measurement_prefix prefix added
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
    # Only one of token and token_file needs to be configured
    # [inputs.prom.auth]
    # type = "bearer_token"
    # token = "xxxxxxxx"
    # token_file = "/tmp/token"
    
    ## Custom metric set names
    # Metrics containing the prefix can be grouped into one metric set
    # Custom metric set name configuration takes precedence over measurement_name
    #[[inputs.prom.measurements]]
    #  prefix = "cpu_"
    #  name = "cpu"
    
    # [[inputs.prom.measurements]]
    # prefix = "mem_"
    # name = "mem"
    
    ## Custom Tags
    [inputs.prom.tags]
      service = "active_directory"
    # more_tag = "some_other_value"
    ```
<!-- markdownlint-enable -->

- Restart DataKit (if you need to enable logging, configure log collection before restarting)

```bash
systemctl restart datakit
```

- DQL Verification

```bash
[root@df-solution-ecs-018 prom]# datakit -Q

Flag -Q deprecated, please use datakit help to use recommended flags.

dqlcmd: &cmds.dqlCmd{json:false, autoJSON:false, verbose:false, csv:"", forceWriteCSV:false, dqlString:"", token:"tkn_9a49a7e9343c432eb0b99a297401c3bb", host:"0.0.0.0:9529", log:"", dqlcli:(*http.Client)(0xc0009a5800)}
dql > M::active_directory LIMIT 1
-----------------[ r1.active_directory.s1 ]-----------------
                              
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

## Detailed Metrics {#metric}

| **Name**                                              | **Description**                                              | **Metric Meaning**                                                 | **Unit** | **Dimensions** |
| ----------------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | -------- | -------------- |
| windows_ad_replication_pending_synchronizations       | Shows the number of directory synchronizations that are queued for this server but not yet processed. | Displays the number of directory synchronizations queued for this server but not yet processed. | count    | host           |
| windows_ad_replication_sync_requests_total            | Shows the number of sync requests made to neighbors.         | Displays the number of sync requests made to neighbors.         | count    | host           |
| windows_ad_replication_sync_requests_success_total    | Shows the number of sync requests made to the neighbors that successfully returned. | Displays the number of sync requests made to the neighbors that successfully returned. | count    | host           |
| windows_ad_ldap_active_threads                        | Shows the current number of threads in use by the LDAP subsystem of the local directory service. | Displays the current number of threads used by the LDAP subsystem of the local directory service. | count    | host           |
| windows_ad_ldap_last_bind_time_seconds                | Shows the time, in milliseconds, taken for the last successful LDAP bind. | Displays the time taken for the last successful LDAP bind in milliseconds. | count    | host           |
| windows_ad_ldap_searches_total                        | Shows the number at which LDAP clients perform search operations. | Displays the number of search operations performed by LDAP clients. | count    | host           |
| windows_ad_ldap_writes_total                          | Shows the number at which LDAP clients perform write operations. | Displays the number of write operations performed by LDAP clients. | count    | host           |
| windows_ad_ldap_client_sessions                       | This is the number of sessions opened by LDAP clients at the time the data is taken. | Displays the number of sessions opened by LDAP clients when the data is collected. | count    | host           |
| windows_ad_replication_inbound_sync_objects_remaining | Shows the number of objects remaining before full synchronization is complete (at setup). | Displays the number of objects remaining before full synchronization is complete (at setup). | count    | host           |
| windows_ad_replication_inbound_objects_updated_total  | Shows the number of objects received from neighbors through inbound replication. A neighbor is a domain controller from which the local domain controller replicates locally. | Displays the number of objects received from neighbors through inbound replication. Neighbors are domain controllers from which the local domain controller replicates locally. | count    | host           |
| windows_ad_replication_inbound_objects_filtered_total | Shows the number of objects received from inbound replication partners that contained no updates that needed to be applied. | Displays the number of objects received from inbound replication partners that contained no updates that needed to be applied. | count    | host           |