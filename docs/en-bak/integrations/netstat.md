---
title     : 'NetStat'
summary   : 'Collect NIC traffic metrics data'
tags:
  - 'NETWORK'
  - 'HOST'
__int_icon      : 'icon/netstat'
dashboard :
  - desc  : 'NetStat'
    path  : 'dashboard/en/netstat'
monitor   :
  - desc  : 'NetStat'
    path  : 'monitor/en/netstat'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Netstat metrics collection, including TCP/UDP connections, waiting for connections, waiting for requests to be processed, and so on.

## Config {#config}

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host deployment"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `netstat.conf.sample` and name it `netstat.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.netstat]]
      ##(Optional) Collect interval, default is 10 seconds
      interval = '10s'
    
    ## The ports you want display
    ## Can add tags too
    # [[inputs.netstat.addr_ports]]
      # ports = ["80","443"]
    
    ## Groups of ports and add different tags to facilitate statistics
    # [[inputs.netstat.addr_ports]]
      # ports = ["80","443"]
    # [inputs.netstat.addr_ports.tags]
      # service = "http"
    
    # [[inputs.netstat.addr_ports]]
      # ports = ["9529"]
    # [inputs.netstat.addr_ports.tags]
      # service = "datakit"
      # foo = "bar"
    
    ## Server may have multiple network cards
    ## Display only some network cards
    ## Can add tags too
    # [[inputs.netstat.addr_ports]]
      # ports = ["1.1.1.1:80","2.2.2.2:80"]
      # ports_match is preferred if both ports and ports_match configured
      # ports_match = ["*:80","*:443"]
    
    [inputs.netstat.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```
    
    Configuration Tips：

    ``` toml
    ## (1) Configure the ports of interest.
    [[inputs.netstat.addr_ports]]
      ports = ["80","443"]
    ```

    ``` toml
    # (2) Configure two groups of ports with different tags for easy statistics.
    [[inputs.netstat.addr_ports]]
      ports = ["80","443"]
      [inputs.netstat.addr_ports.tags]
        service = "http"

    [[inputs.netstat.addr_ports]]
        ports = ["9529"]
        [inputs.netstat.addr_ports.tags]
            service = "datakit"
    ```

    ``` toml
    # (3) The server has multiple NICs and only cares about certain ones.
    [[inputs.netstat.addr_ports]]
      ports = ["1.1.1.1:80","2.2.2.2:80"]
    ```

    ``` toml
    # (4) The server has multiple NICs, and the requirement to show this configuration on a per NIC basis will mask the ports configuration value.
    [[inputs.netstat.addr_ports]]
      ports = ["1.1.1.1:80","2.2.2.2:80"] // Invalid, masked by ports_match.
      ports_match = ["*:80","*:443"] // Valid.
    ```

    After configuration, restart DataKit.

=== "Kubernetes"

    Can be turned on by [ConfigMap Injection Collector Configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [Config ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) .

    Can also be turned on by environment variables, (needs to be added as the default collector in ENV_DEFAULT_ENABLED_INPUTS):
    
    - **ENV_INPUT_NETSTAT_INTERVAL**
    
        Collect interval
    
        **Type**: Duration
    
        **input.conf**: `interval`
    
        **Default**: 10s
    
    - **ENV_INPUT_NETSTAT_ADDR_PORTS**
    
        Groups of ports and add different tags to facilitate statistics
    
        **Type**: JSON
    
        **input.conf**: `addr_ports`
    
        **Example**: ["1.1.1.1:80","443"]
    
    - **ENV_INPUT_NETSTAT_TAGS**
    
        Customize tags. If there is a tag with the same name in the configuration file, it will be overwritten
    
        **Type**: Map
    
        **input.conf**: `tags`
    
        **Example**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->
---

## Metric {#metric}

For all the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.netstat.tags]`:

``` toml
 [inputs.netstat.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

Measurements for statistics regardless of port number: `netstat` ; Measurements for statistics by port number: `netstat_port`.



- Tags


| Tag | Description |
|  ----  | --------|
|`addr_port`|Addr and port. Optional.|
|`host`|Host name|
|`ip_version`|IP version, 4 for IPV4, 6 for IPV6, unknown for others|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`pid`|PID. Optional.|int|count|
|`tcp_close`|CLOSE : The number of TCP state be waiting for a connection termination request acknowledgement from remote TCP host.|int|count|
|`tcp_close_wait`|CLOSE_WAIT : The number of TCP state be waiting for a connection termination request from local user.|int|count|
|`tcp_closing`|CLOSING : The number of TCP state be waiting for a connection termination request acknowledgement from remote TCP host.|int|count|
|`tcp_established`|ESTABLISHED : The number of TCP state be open connection, data received to be delivered to the user. |int|count|
|`tcp_fin_wait1`|FIN_WAIT1 : The number of TCP state be waiting for a connection termination request from remote TCP host or acknowledgment of connection termination request sent previously.|int|count|
|`tcp_fin_wait2`|FIN_WAIT2 : The number of TCP state be waiting for connection termination request from remote TCP host.|int|count|
|`tcp_last_ack`|LAST_ACK : The number of TCP state be waiting for connection termination request acknowledgement previously sent to remote TCP host including its acknowledgement of connection termination request.|int|count|
|`tcp_listen`|LISTEN : The number of TCP state be waiting for a connection request from any remote TCP host.|int|count|
|`tcp_none`|NONE|int|count|
|`tcp_syn_recv`|SYN_RECV : The number of TCP state be waiting for confirmation of connection acknowledgement after both sender and receiver has sent / received connection request.|int|count|
|`tcp_syn_sent`|SYN_SENT : The number of TCP state be waiting for a machine connection request after sending a connecting request.|int|count|
|`tcp_time_wait`|TIME_WAIT : The number of TCP state be waiting sufficient time to pass to ensure remote TCP host received acknowledgement of its request for connection termination.|int|count|
|`udp_socket`|UDP : The number of UDP connection.|int|count|


