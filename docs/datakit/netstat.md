
# NetStat
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Netstat 指标采集，包括 TCP/UDP 连接数、等待连接、等待处理请求等。

## 前置条件 {#precondition}

暂无

## 配置 {#input-config}

=== "主机部署"

    进入 DataKit 安装目录下的 `conf.d/host` 目录，复制 `netstat.conf.sample` 并命名为 `netstat.conf`。示例如下：

    ```toml
        
    [[inputs.netstat]]
      ##(optional) collect interval, default is 10 seconds
      interval = '10s'
    
    [inputs.netstat.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```

    配置好后，重启 DataKit 即可。

=== "Kubernetes"

    Kubernetes 中支持以环境变量的方式修改配置参数：


    | 环境变量名                   | 对应的配置参数项 | 参数示例                                                     |
    |:-----------------------------| ---              | ---                                                          |
    | `ENV_INPUT_NETSTAT_TAGS`     | `tags`           | `tag1=value1,tag2=value2` 如果配置文件中有同名 tag，会覆盖它 |
    | `ENV_INPUT_NETSTAT_INTERVAL` | `interval`       | `10s`                                                        |

---

## 指标集 {#measurements}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.netstat.tags]` 指定其它标签：

``` toml
 [inputs.netstat.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `netstat`

-  标签 


| 标签名 | 描述    |
|  ----  | --------|
|`host`|主机名|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
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


