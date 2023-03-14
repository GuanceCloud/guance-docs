
# NetStat
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Netstat metrics collection, including TCP/UDP connections, waiting for connections, waiting for requests to be processed, and so on.

## Preconditions {#precondition}

None

## Configuration {#input-config}

=== "Host deployment"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `netstat.conf.sample` and name it `netstat.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.netstat]]
      ##(Optional) Collect interval, default is 10 seconds
      interval = '10s'
    
      ## The ports you want display
      ## Can add tags too
      # [[inputs.netstat.addr_ports]]
      #   ports = ["80","443"]
    
      ## Groups of ports and add different tags to facilitate statistics
      # [[inputs.netstat.addr_ports]]
      #   ports = ["80","443"]
      #   [inputs.netstat.addr_ports.tags]
      #     service = "http"
      # [[inputs.netstat.addr_ports]]
      #   ports = ["9529"]
      #   [inputs.netstat.addr_ports.tags]
      #     service = "datakit"
      #     foo = "bar"
    
      ## Server may have multiple network cards
      ## Display only some network cards
      ## Can add tags too
      # [[inputs.netstat.addr_ports]]
      #   ports = ["1.1.1.1:80","2.2.2.2:80"]
      #   ports_match is preferred if both ports and ports_match configured
      #   ports_match = ["*:80","*:443"]
    
    [inputs.netstat.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```
    
    After configuration, restart DataKit.

=== "Kubernetes"

    Kubernetes supports modifying configuration parameters in the form of environment variables:


    | Environment Variable Name                          | Corresponding Configuration Parameter Item | Parameter Example |
    |:-----------------------------     | ---            | ---   |
    | `ENV_INPUT_NETSTAT_TAGS`          | `tags`         | `tag1=value1,tag2=value2`; If there is a tag with the same name in the configuration file, it will be overwritten. |
    | `ENV_INPUT_NETSTAT_INTERVAL`      | `interval`     | `10s` |
    | `ENV_INPUT_NETSTAT_ADDR_PORTS`    | `ports`        | `["1.1.1.1:80","443"]` |

---

## Measurements {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.netstat.tags]`:

``` toml
 [inputs.netstat.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

Measurements for statistics regardless of port number: `netstat` ; Measurements for statistics by port number: `netstat_port`.



- tag


| Tag | Descrition |
|  ----  | --------|
|`addr_port`|Addr and port|
|`host`|Host name|
|`ip_version`|IP version, 4 for IPV4, 6 for IPV6, unknown for others|

- metric list


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`pid`|PID.|int|count|
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


