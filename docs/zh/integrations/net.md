---
title     : 'Net'
summary   : '采集网卡的指标数据'
tags:
  - '主机'
  - '网络'
__int_icon: 'icon/net'
dashboard :
  - desc  : 'Net'
    path  : 'dashboard/zh/net'
monitor   :
  - desc  : '暂无'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Net 采集器用于采集主机网络信息，如各网络接口的流量信息等。对于 Linux 将采集系统范围 TCP 和 UDP 统计信息。

## 配置 {#config}

成功安装 DataKit 并启动后，会默认开启 Net 采集器，无需手动开启。

<!-- markdownlint-disable MD046 -->

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `net.conf.sample` 并命名为 `net.conf`。示例如下：

    ```toml
        
    [[inputs.net]]
      ## (optional) collect interval, default is 10 seconds
      interval = '10s'
    
      ## By default, gathers stats from any up interface, but Linux does not contain virtual interfaces.
      ## Setting interfaces using regular expressions will collect these expected interfaces.
      # interfaces = ['''eth[\w-]+''', '''lo''', ]
    
      ## Datakit does not collect network virtual interfaces under the linux system.
      ## Setting enable_virtual_interfaces to true will collect virtual interfaces stats for linux.
      # enable_virtual_interfaces = true
    
      ## On linux systems also collects protocol stats.
      ## Setting ignore_protocol_stats to true will skip reporting of protocol metrics.
      # ignore_protocol_stats = false
    
    [inputs.net.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    也支持以环境变量的方式修改配置参数（需要在 ENV_DEFAULT_ENABLED_INPUTS 中加为默认采集器）：

    - **ENV_INPUT_NET_INTERVAL**
    
        采集器重复间隔时长
    
        **字段类型**: Duration
    
        **采集器配置字段**: `interval`
    
        **默认值**: 10s
    
    - **ENV_INPUT_NET_IGNORE_PROTOCOL_STATS**
    
        跳过协议度量的报告
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `ignore_protocol_stats`
    
        **默认值**: false
    
    - **ENV_INPUT_NET_ENABLE_VIRTUAL_INTERFACES**
    
        采集 Linux 的虚拟网卡
    
        **字段类型**: Boolean
    
        **采集器配置字段**: `enable_virtual_interfaces`
    
        **默认值**: false
    
    - **ENV_INPUT_NET_INTERFACES**
    
        期望采集的网卡（正则）
    
        **字段类型**: List
    
        **采集器配置字段**: `interfaces`
    
        **示例**: eth[\w-]+,lo
    
    - **ENV_INPUT_NET_TAGS**
    
        自定义标签。如果配置文件有同名标签，将会覆盖它
    
        **字段类型**: Map
    
        **采集器配置字段**: `tags`
    
        **示例**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.net.tags]` 指定其它标签：

```toml
[inputs.net.tags]
 # some_tag = "some_value"
 # more_tag = "some_other_value"
 # ...
```



### `net`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|System hostname.|
|`interface`|Network interface name.|

- 指标列表


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
|`tcp_activeopens`|It means the TCP layer sends a SYN, and come into the SYN-SENT state.|int|count|
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
|`tcp_passiveopens`|It means the TCP layer receives a SYN, replies a SYN+ACK, come into the SYN-RCVD state.|int|count|
|`tcp_retranssegs`|The total number of segments re-transmitted - that is, the number of TCP segments transmitted containing one or more previously transmitted octets.|int|count|
|`tcp_rtoalgorithm`|The algorithm used to determine the timeout value used for retransmitting unacknowledged octets.|int|count|
|`tcp_rtomax`|The maximum value permitted by a TCP implementation for the retransmission timeout, measured in milliseconds.|int|ms|
|`tcp_rtomin`|The minimum value permitted by a TCP implementation for the retransmission timeout, measured in milliseconds.|int|ms|
|`udp_ignoredmulti`|TODO|int|count|
|`udp_incsumerrors`|The number of incoming UDP datagram in checksum error.s|int|count|
|`udp_indatagrams`|The number of UDP datagram delivered to UDP users.|int|count|
|`udp_indatagrams/sec`|The number of UDP datagram delivered to UDP users per second.|int|count|
|`udp_inerrors`|The number of packet receive errors.|int|count|
|`udp_memerrors`|The number of memory errors.|int|count|
|`udp_noports`|The number of packets to unknown port received.|int|count|
|`udp_outdatagrams`|The number of UDP datagram sent from this entity.|int|count|
|`udp_outdatagrams/sec`|The number of UDP datagram sent from this entity per second.|int|count|
|`udp_rcvbuferrors`|The number of receive buffer errors.|int|count|
|`udp_sndbuferrors`|The number of send buffer errors.|int|count|



## 延伸阅读 {#more-readings}

- [eBPF 数据采集](ebpf.md)
