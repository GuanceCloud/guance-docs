---
title     : 'NetStat'
summary   : '采集网卡流量指标数据'
__int_icon      : 'icon/netstat'
dashboard :
  - desc  : 'NetStat'
    path  : 'dashboard/zh/netstat'
monitor   :
  - desc  : 'NetStat'
    path  : 'monitor/zh/netstat'
---

<!-- markdownlint-disable MD025 -->
# NetStat
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

NetStat 指标展示，包括 Tcp 连接数、等待连接、等待处理请求、Udp Socket 连接等。

## 配置 {#config}

<!-- markdownlint-disable MD046 -->
=== "主机部署"

    进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `netstat.conf.sample` 并命名为 `netstat.conf`。示例如下：

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

    配置技巧：

    ``` toml
    ## (1) 配置关注的端口号
    [[inputs.netstat.addr_ports]]
      ports = ["80","443"]
    ```

    ``` toml
    # (2) 配置两组端口，加上不同的 tag，方便统计
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
    # (3) 服务器有多个网卡，只关心某几个网卡的情况
    [[inputs.netstat.addr_ports]]
      ports = ["1.1.1.1:80","2.2.2.2:80"]
    ```

    ``` toml
    # (4) 服务器有多个网卡，要求按每个网卡分别展示这个配置，会屏蔽掉 ports 的配置值
    [[inputs.netstat.addr_ports]]
      ports = ["1.1.1.1:80","2.2.2.2:80"] // 无效，被 ports_match 屏蔽
      ports_match = ["*:80","*:443"] // 有效
    ```

    配置好后，重启 DataKit 即可。

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    也支持以环境变量的方式修改配置参数（需要在 ENV_DEFAULT_ENABLED_INPUTS 中加为默认采集器）：

    - **ENV_INPUT_NETSTAT_INTERVAL**
    
        采集器重复间隔时长
    
        **Type**: TimeDuration
    
        **ConfField**: `interval`
    
        **Default**: 10s
    
    - **ENV_INPUT_NETSTAT_ADDR_PORTS**
    
        端口分组并添加不同的标签以便于统计
    
        **Type**: JSON
    
        **ConfField**: `addr_ports`
    
        **Example**: ["1.1.1.1:80","443"]
    
    - **ENV_INPUT_NETSTAT_TAGS**
    
        自定义标签。如果配置文件有同名标签，将会覆盖它
    
        **Type**: Map
    
        **ConfField**: `tags`
    
        **Example**: tag1=value1,tag2=value2

<!-- markdownlint-enable -->
---

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.netstat.tags]` 指定其它标签：

``` toml
 [inputs.netstat.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

不分端口号统计的指标集：`netstat`，分端口号统计的指标集：`netstat_port`。



- 标签


| Tag | Description |
|  ----  | --------|
|`addr_port`|Addr and port. Optional.|
|`host`|Host name|
|`ip_version`|IP version, 4 for IPV4, 6 for IPV6, unknown for others|

- 指标列表


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


