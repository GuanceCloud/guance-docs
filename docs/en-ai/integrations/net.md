---
title: 'Net'
summary: 'Collect metrics data from network interfaces'
tags:
  - 'Host'
  - 'Network'
__int_icon: 'icon/net'
dashboard:
  - desc: 'Net'
    path: 'dashboard/en/net'
monitor:
  - desc: 'None'
    path: '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The Net collector is used to collect host network information, such as traffic data for each network interface. For Linux, it collects system-wide TCP and UDP statistics.

## Configuration {#config}

After successfully installing and starting DataKit, the Net collector will be enabled by default, so no manual activation is required.

<!-- markdownlint-disable MD046 -->

=== "Host Installation"

    Navigate to the `conf.d/host` directory under the DataKit installation directory, copy `net.conf.sample`, and rename it to `net.conf`. An example configuration is shown below:

    ```toml
        
    [[inputs.net]]
      ## (optional) collection interval, default is 10 seconds
      interval = '10s'
    
      ## By default, gathers stats from any up interface, but Linux does not include virtual interfaces.
      ## Setting interfaces using regular expressions will collect these expected interfaces.
      # interfaces = ['''eth[\w-]+''', '''lo''', ]
    
      ## Datakit does not collect network virtual interfaces under the Linux system.
      ## Setting enable_virtual_interfaces to true will collect virtual interface statistics for Linux.
      # enable_virtual_interfaces = true
    
      ## On Linux systems, also collects protocol statistics.
      ## Setting ignore_protocol_stats to true will skip reporting of protocol metrics.
      # ignore_protocol_stats = false
    
    [inputs.net.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can enable the collector via [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting) or by [setting ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting).

    Environment variables can also be used to modify configuration parameters (requires adding to ENV_DEFAULT_ENABLED_INPUTS):

    - **ENV_INPUT_NET_INTERVAL**

        Collector repetition interval

        **Field Type**: Duration

        **Collector Config Field**: `interval`

        **Default Value**: 10s

    - **ENV_INPUT_NET_IGNORE_PROTOCOL_STATS**

        Skip reporting protocol metrics

        **Field Type**: Boolean

        **Collector Config Field**: `ignore_protocol_stats`

        **Default Value**: false

    - **ENV_INPUT_NET_ENABLE_VIRTUAL_INTERFACES**

        Collect virtual network interfaces on Linux

        **Field Type**: Boolean

        **Collector Config Field**: `enable_virtual_interfaces`

        **Default Value**: false

    - **ENV_INPUT_NET_INTERFACES**

        Expected network interfaces (regex)

        **Field Type**: List

        **Collector Config Field**: `interfaces`

        **Example**: eth[\w-]+,lo

    - **ENV_INPUT_NET_TAGS**

        Custom tags. If the same tag exists in the configuration file, it will override it.

        **Field Type**: Map

        **Collector Config Field**: `tags`

        **Example**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

## Metrics {#metric}

By default, all collected data will append a global tag named `host` (tag value is the hostname where DataKit resides). Additional tags can be specified in the configuration using `[inputs.net.tags]`:

```toml
[inputs.net.tags]
 # some_tag = "some_value"
 # more_tag = "some_other_value"
 # ...
```



### `net`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|System hostname.|
|`interface`|Network interface name.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`bytes_recv`|The number of bytes received by the interface.|int|B|
|`bytes_recv/sec`|The number of bytes received by the interface per second.|int|B/S|
|`bytes_sent`|The number of bytes sent by the interface.|int|B|
|`bytes_sent/sec`|The number of bytes sent by the interface per second.|int|B/S|
|`drop_in`|The number of received packets dropped by the interface.|int|count|
|`drop_out`|The number of transmitted packets dropped by the interface.|int|count|
|`err_in`|The number of receive errors detected by the interface.|int|count|
|`err_out`|The number of transmit errors detected by the interface.|int|count|
|`packets_recv`|The number of packets received by the interface.|int|count|
|`packets_recv/sec`|The number of packets received by the interface per second.|int|count|
|`packets_sent`|The number of packets sent by the interface.|int|count|
|`packets_sent/sec`|The number of packets sent by the interface per second.|int|count|
|`tcp_activeopens`|It means the TCP layer sends a SYN, and comes into the SYN-SENT state.|int|count|
|`tcp_attemptfails`|The number of times TCP connections have made a direct transition to the CLOSED state from either the SYN-SENT state or the SYN-RCVD state, plus the number of times TCP connections have made a direct transition to the LISTEN state from the SYN-RCVD state.|int|count|
|`tcp_currestab`|The number of TCP connections for which the current state is either ESTABLISHED or CLOSE-WAIT.|int|count|
|`tcp_estabresets`|The number of times TCP connections have made a direct transition to the CLOSED state from either the ESTABLISHED state or the CLOSE-WAIT state.|int|count|
|`tcp_incsumerrors`|The number of incoming TCP segments in checksum error.|int|count|
|`tcp_inerrs`|The number of incoming TCP segments in error.|int|count|
|`tcp_insegs`|The number of packets received by the TCP layer.|int|count|
|`tcp_insegs/sec`|The number of packets received by the TCP layer per second.|int|count|
|`tcp_maxconn`|The limit on the total number of TCP connections the entity can support.|int|count|
|`tcp_outrsts`|The number of TCP segments sent containing the RST flag.|int|count|
|`tcp_outsegs`|The number of packets sent by the TCP layer.|int|count|
|`tcp_outsegs/sec`|The number of packets sent by the TCP layer per second.|int|count|
|`tcp_passiveopens`|It means the TCP layer receives a SYN, replies with a SYN+ACK, and comes into the SYN-RCVD state.|int|count|
|`tcp_retranssegs`|The total number of segments re-transmitted - that is, the number of TCP segments transmitted containing one or more previously transmitted octets.|int|count|
|`tcp_rtoalgorithm`|The algorithm used to determine the timeout value used for retransmitting unacknowledged octets.|int|count|
|`tcp_rtomax`|The maximum value permitted by a TCP implementation for the retransmission timeout, measured in milliseconds.|int|ms|
|`tcp_rtomin`|The minimum value permitted by a TCP implementation for the retransmission timeout, measured in milliseconds.|int|ms|
|`udp_ignoredmulti`|TODO|int|count|
|`udp_incsumerrors`|The number of incoming UDP datagrams in checksum error.|int|count|
|`udp_indatagrams`|The number of UDP datagrams delivered to UDP users.|int|count|
|`udp_indatagrams/sec`|The number of UDP datagrams delivered to UDP users per second.|int|count|
|`udp_inerrors`|The number of packet receive errors.|int|count|
|`udp_memerrors`|The number of memory errors.|int|count|
|`udp_noports`|The number of packets to unknown ports received.|int|count|
|`udp_outdatagrams`|The number of UDP datagrams sent from this entity.|int|count|
|`udp_outdatagrams/sec`|The number of UDP datagrams sent from this entity per second.|int|count|
|`udp_rcvbuferrors`|The number of receive buffer errors.|int|count|
|`udp_sndbuferrors`|The number of send buffer errors.|int|count|



## Further Reading {#more-readings}

- [eBPF Data Collection](ebpf.md)