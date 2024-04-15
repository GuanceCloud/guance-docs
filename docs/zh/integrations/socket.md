---
title     : 'Socket'
summary   : '采集 TCP/UDP 端口的指标数据'
__int_icon      : 'icon/socket'
dashboard :
  - desc  : 'Socket'
    path  : 'dashboard/zh/socket'
monitor   :
  - desc  : 'Socket'
    path  : 'monitor/zh/socket'
---

<!-- markdownlint-disable MD025 -->
# Socket
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-apple:

---

采集 UDP/TCP 端口指标数据。

## 配置 {#config}

### 前置条件 {#requrements}

UDP 指标需要操作系统有 `nc` 程序

<!-- markdownlint-disable MD046 -->
???+ attention

    socket 采集器适合做内网的 TCP/UDP 端口检测，对于公网服务，建议使用[拨测功能](dialtesting.md)。如果服务地址指向本机，请关闭采集器的选举（`election: false`）功能，否则会导致无效采集。
<!-- markdownlint-enable -->

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/socket` 目录，复制 `socket.conf.sample` 并命名为 `socket.conf`。示例如下：
    
    ```toml
        
    [[inputs.socket]]
      ## Support TCP/UDP.
      ## If the quantity to be detected is too large, it is recommended to open more collectors
      dest_url = [
        "tcp://host:port",
        "udp://host:port",
      ]
    
      ## @param interval - number - optional - default: 30
      interval = "30s"
    
      ## @param interval - number - optional - default: 10
      tcp_timeout = "10s"
    
      ## @param interval - number - optional - default: 10
      udp_timeout = "10s"
    
      ## set false to disable election
      election = true
    
    [inputs.socket.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```
    
    配置好后，重启 DataKit 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

## 指标 {#metric}

以下所有指标集，默认会追加 `proto/dest_host/dest_port` 全局 tag，也可以在配置中通过 `[inputs.socket.tags]` 指定其它标签：

``` toml
[inputs.socket.tags]
 # some_tag = "some_value"
 # more_tag = "some_other_value"
 # ...
```



### `tcp`

- 标签


| Tag | Description |
|  ----  | --------|
|`dest_host`|TCP domain or host, such as `wwww.baidu.com`, `1.2.3.4`|
|`dest_port`|TCP port, such as `80`|
|`proto`|Protocol, const to be `tcp`|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`response_time`|TCP connection time(without DNS query time)|int|μs|
|`response_time_with_dns`|TCP connection time(with DNS query time)|int|μs|
|`success`|1: success/-1: failed|int|-|



### `udp`

- 标签


| Tag | Description |
|  ----  | --------|
|`dest_host`|UDP host|
|`dest_port`|UDP port|
|`proto`|Protocol, const to be `udp`|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`success`|1: success/-1: failed|int|-|


