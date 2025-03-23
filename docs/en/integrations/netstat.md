---
title     : 'NetStat'
summary   : 'Collect network interface traffic Metrics data'
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

NetStat Metrics display, including Tcp connections, waiting connections, pending requests processing, Udp Socket connections, etc.

## Configuration {#config}

<!-- markdownlint-disable MD046 -->
=== "Host Deployment"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `netstat.conf.sample` and rename it to `netstat.conf`. Example as follows:

    ```toml
        
    [[inputs.netstat]]
      ##(Optional) Collect interval, default is 10 seconds
      interval = '10s'
    
    ## The ports you want to display
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
      # ports_match is preferred if both ports and ports_match are configured
      # ports_match = ["*:80","*:443"]
    
    [inputs.netstat.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```

    Configuration tips:

    ``` toml
    ## (1) Configure the port numbers of interest
    [[inputs.netstat.addr_ports]]
      ports = ["80","443"]
    ```

    ``` toml
    # (2) Configure two groups of ports with different tags for easier statistics
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
    # (3) Server has multiple network cards, only care about a few network cards
    [[inputs.netstat.addr_ports]]
      ports = ["1.1.1.1:80","2.2.2.2:80"]
    ```

    ``` toml
    # (4) Server has multiple network cards, require displaying each network card separately; this configuration will override the ports setting
    [[inputs.netstat.addr_ports]]
      ports = ["1.1.1.1:80","2.2.2.2:80"] // Invalid, overridden by ports_match
      ports_match = ["*:80","*:443"] // Valid
    ```

    After configuring, restart DataKit.

=== "Kubernetes"

    You can inject collector configurations via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting) or [configure ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) to enable the collector.

    It also supports modifying configuration parameters via environment variables (requires adding it to ENV_DEFAULT_ENABLED_INPUTS as a default collector):

    - **ENV_INPUT_NETSTAT_INTERVAL**
    
        Collector repeat interval duration
    
        **Field Type**: Duration
    
        **Collector Configuration Field**: `interval`
    
        **Default Value**: 10s
    
    - **ENV_INPUT_NETSTAT_ADDR_PORTS**
    
        Port grouping with different tags for easier statistics
    
        **Field Type**: JSON
    
        **Collector Configuration Field**: `addr_ports`
    
        **Example**: ["1.1.1.1:80","443"]
    
    - **ENV_INPUT_NETSTAT_TAGS**
    
        Custom tags. If the configuration file has tags with the same name, they will override them.
    
        **Field Type**: Map
    
        **Collector Configuration Field**: `tags`
    
        **Example**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->
---

## Metrics {#metric}

By default, all collected data appends a global tag named `host` (tag value is the hostname where DataKit resides). You can also specify other tags in the configuration through `[inputs.netstat.tags]`:

``` toml
 [inputs.netstat.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

Metrics set without port number statistics: `netstat`, Metrics set with port number statistics: `netstat_port`.



- Tags


| Tag | Description |
|  ----  | --------|
|`addr_port`|Addr and port. Optional.|
|`host`|Host name|
|`ip_version`|IP version, 4 for IPV4, 6 for IPV6, unknown for others|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`pid`|PID. Optional.|int|count|
|`tcp_close`|CLOSE : The number of TCP states waiting for a connection termination request acknowledgment from the remote TCP host.|int|count|
|`tcp_close_wait`|CLOSE_WAIT : The number of TCP states waiting for a connection termination request from the local user.|int|count|
|`tcp_closing`|CLOSING : The number of TCP states waiting for a connection termination request acknowledgment from the remote TCP host.|int|count|
|`tcp_established`|ESTABLISHED : The number of TCP states with open connections, data received to be delivered to the user.|int|count|
|`tcp_fin_wait1`|FIN_WAIT1 : The number of TCP states waiting for a connection termination request from the remote TCP host or acknowledgment of a previously sent connection termination request.|int|count|
|`tcp_fin_wait2`|FIN_WAIT2 : The number of TCP states waiting for a connection termination request from the remote TCP host.|int|count|
|`tcp_last_ack`|LAST_ACK : The number of TCP states waiting for acknowledgment of a previously sent connection termination request to the remote TCP host, including its acknowledgment of the connection termination request.|int|count|
|`tcp_listen`|LISTEN : The number of TCP states waiting for a connection request from any remote TCP host.|int|count|
|`tcp_none`|NONE|int|count|
|`tcp_syn_recv`|SYN_RECV : The number of TCP states waiting for confirmation of connection acknowledgment after both sender and receiver have sent/received a connection request.|int|count|
|`tcp_syn_sent`|SYN_SENT : The number of TCP states waiting for a machine connection request after sending a connecting request.|int|count|
|`tcp_time_wait`|TIME_WAIT : The number of TCP states waiting sufficient time to pass to ensure the remote TCP host received acknowledgment of its request for connection termination.|int|count|
|`udp_socket`|UDP : The number of UDP connections.|int|count|


