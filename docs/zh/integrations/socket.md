---
title     : 'Socket'
summary   : '采集 TCP/UDP 端口的指标数据'
<<<<<<< HEAD
<<<<<<< HEAD
icon      : 'icon/socket'
=======
__int_icon      : 'icon/socket'
>>>>>>> bcdb7fa10debda85713fee55db2e1181e9301f46
=======
__int_icon      : 'icon/socket'
>>>>>>> c66e8140414e8da5bc40d96d0cea42cd2412a7c6
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

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/socket` 目录，复制 `socket.conf.sample` 并命名为 `socket.conf`。示例如下：
    
    ```toml
        
    [[inputs.socket]]
      ## Support TCP/UDP.
      ## If the quantity to be detected is too large, it is recommended to open more collectors
      dest_url = ["tcp://host:port", "udp://host:port"]
    
      ## @param interval - number - optional - default: 30
      interval = "30s"
      ## @param interval - number - optional - default: 10
      udp_timeout = "10s"
      ## @param interval - number - optional - default: 10
      tcp_timeout = "10s"
    
    [inputs.socket.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    ```
    
    配置好后，重启 DataKit 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
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
|`dest_host`|示例 `wwww.baidu.com`|
|`dest_port`|示例 80|
|`proto`|示例 `tcp`|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`response_time`|TCP 连接时间|int|μs|
|`response_time_with_dns`|连接时间（含 DNS 解析）|int|μs|
|`success`|只有 1/-1 两种状态。1 表示成功/-1 表示失败|int|-|



### `udp`

- 标签


| Tag | Description |
|  ----  | --------|
|`dest_host`|目的主机的 host|
|`dest_port`|目的主机的端口号|
|`proto`|示例 `udp`|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`success`|只有 1/-1 两种状态。1 表示成功/-1 表示失败|int|-|


