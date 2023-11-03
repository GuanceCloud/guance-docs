---
title     : 'Active Directory'
summary   : 'Collect Active Directory related metrics information'
__int_icon: 'icon/active_directory'
dashboard :
  - desc  : 'Active Directory monitoring view'
    path  : 'dashboard/zh/active_directory'
---

<!-- markdownlint-disable MD025 -->

# Active Directory
<!-- markdownlint-enable -->

## Installation and Deployment {#config}

Note: The sample [Active Directory exporter](https://github.com/prometheus-community/windows_exporter) version is 0.24.0 (Windows)

### Enable the DataKit collector

- Enable the DataKit Prom plugin and copy the sample file

```cmd
cd C:\Program Files\datakit\conf.d\prom
# Copy prom.conf.sample to prom.conf
```

- Modify the `prom.conf` configuration file

<!-- markdownlint-disable MD046 -->

??? quote "Configuration is as follows"

    ```toml
    [[inputs.prom]]
    ## Exporter URLs
    urls = ["http://127.0.0.1:9182/metrics"]
    
    ## Ignore request errors to the url
    ignore_req_err = false
    
    ## Collector alias
    source = "active_directory"
    
    ## Collection data output source
    # Configuring this item, you can write the collected data to a local file instead of hitting the center
    # You can then use the datakit --prom-conf /path/to/this/conf command to debug the locally saved metric set directly
    # If the url is configured as a local file path, then --prom-conf will debug the data of the output path first
    # output = "/abs/path/to/file"
    > 
    ## The upper limit of the collection data size, in bytes
    # When outputting data to a local file, you can set the upper limit of the collection data size
    # If the size of the collected data exceeds this limit, the collected data will be discarded
    # The upper limit of the collection data size is set to 32MB by default
    # max_file_size = 0
    
    ## Metric type filtering, optional values are counter, gauge, histogram, summary
    # By default, only counter and gauge type metrics are collected
    # If it is empty, no filtering is performed
    metric_types = ["counter", "gauge"]
    
    ## Metric name filtering
    # Supports regular expressions, multiple configurations can be made, that is, one of them can be met
    # If it is empty, no filtering is performed
    # metric_name_filter = ["cpu"]
    
    ## Metric set name prefix
    # Configuring this item, you can add a prefix to the metric set name
    measurement_prefix = ""
    
    ## Metric set name
    # By default, the metric name is split with an underscore "_", the first field after the split is used as the metric set name, and the remaining fields are used as the current metric name
    # If measurement_name is configured, the metric name is not split
    # The final metric set name will add the measurement_prefix prefix
    # measurement_name = "prom"
    
    ## Collection interval "ns", "us" (or "µs"), "ms", "s", "m", "h"
    interval = "10s"
    
    ## Filter tags, multiple tags can be configured
    # The matching tag will be ignored
    # tags_ignore = ["xxxx"]
    
    ## TLS Configuration
    tls_open = false
    # tls_ca = "/tmp/ca.crt"
    # tls_cert = "/tmp/peer.crt"
    # tls_key = "/tmp/peer.key"
    
    ## Custom authentication method, currently only supports Bearer Token
    # token 和 token_file: Only one of them needs to be configured
    # [inputs.prom.auth]
    # type = "bearer_token"
    # token = "xxxxxxxx"
    # token_file = "/tmp/token"
    
    ## Custom metric set name
    # You can classify metrics with the prefix prefix into one class of metric sets
    # The configuration of custom metric set names takes precedence over the configuration item measurement_name
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

- Restart DataKit (if you need to enable logging, please configure log collection and restart)

```bash
systemctl restart datakit
```

- DQL verification

```bash
[root@df-solution-ecs-018 prom]# datakit -Q

Flag -Q deprecated, please use datakit help to use recommend flags.

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

| **Name**                                              | **Description**                                              | **Metric Meaning**                                                 | **Unit** | **Dimension** |
| ----------------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | -------- | -------- |
| windows_ad_replication_pending_synchronizations       | Shows the number of directory synchronizations that are queued for this server but not yet processed.                 | Shows the number of directory synchronizations that are queued for this server but not yet processed. | count    | host     |
| windows_ad_replication_sync_requests_total            | Display the number of synchronization requests sent to the neighbor.                                 | Shows the number of sync requests made to neighbors. | count    | host     |
| windows_ad_replication_sync_requests_success_total    | Display the number of synchronization requests successfully returned from the neighbor.                 | Shows the number of sync requests made to the neighbors that successfully returned. | count    | host     |
| windows_ad_ldap_active_threads                        | Display the number of threads currently used by the local directory service LDAP subsystem.              | Shows the current number of threads in use by the LDAP subsystem of the local directory service. | count    | host     |
| windows_ad_ldap_last_bind_time_seconds                | Display the time required for the last successful LDAP binding (in milliseconds).                   | Shows the time, in milliseconds, taken for the last successful LDAP bind. | count    | host     |
| windows_ad_ldap_searches_total                        | Display the number of times the LDAP client performs search operations.                         | Shows the number at which LDAP clients perform search operations. | count    | host     |
| windows_ad_ldap_writes_total                          | Display the number of times the LDAP client performs write operations.                           | Shows the number at which LDAP clients perform write operations. | count    | host     |
| windows_ad_ldap_client_sessions                       | This is the number of sessions opened by the LDAP client when collecting data.                     | This is the number of sessions opened by LDAP clients at the time the data is taken. | count    | host     |
| windows_ad_replication_inbound_sync_objects_remaining | Display the number of remaining objects before the full synchronization is completed (when setting).                 | Shows the number of objects remaining before full synchronization is complete (at setup). | count    | host     |
| windows_ad_replication_inbound_objects_updated_total  | Display the number of objects received from neighbors through inbound replication. The neighbor is the domain controller that the local domain controller replicates locally. | Shows the number of objects received from neighbors through inbound replication. A neighbor is a domain controller from which the local domain controller replicates locally. | count    | host     |
| windows_ad_replication_inbound_objects_filtered_total | Display the number of objects received from inbound replication partners that do not contain updates needing to be applied.| Shows the number of objects received from inbound replication partners that contained no updates that needed to be applied. | count    | host     |
