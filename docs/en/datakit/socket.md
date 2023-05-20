
# TCP/UDP
---

:fontawesome-brands-linux: :fontawesome-brands-apple:

---

The socket collector is used to collect UDP/TCP port information.

## Preconditions {#requrements}

UDP metrics require the operating system to have `nc` programs.

## Configuration {#config}

=== "Host Installation"

    Go to the `conf.d/socket` directory under the DataKit installation directory, copy `socket.conf.sample` and name it `socket.conf`. Examples are as follows:
    
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
    
    After configuration, restart DataKit.

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap Injection Collector Configuration](datakit-daemonset-deploy.md#configmap-setting).

## Measurements {#requrements}

For all of the following measurements, the `proto/dest_host/dest_port` global tag is appended by default, or other tags can be specified in the configuration by `[inputs.socket.tags]`:

``` toml
 [inputs.socket.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `tcp`

- tag


| Tag | Description |
|  ----  | --------|
|`dest_host`|示例 `wwww.baidu.com`|
|`dest_port`|示例 80|
|`proto`|示例 `tcp`|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`response_time`|TCP 连接时间, 单位 us|int|μs|
|`response_time_with_dns`|连接时间（含 DNS 解析）, 单位 us|int|μs|
|`success`|只有 1/-1 两种状态, 1 表示成功, -1 表示失败|int|-|



### `udp`

- tag


| Tag | Description |
|  ----  | --------|
|`dest_host`|目的主机的 host|
|`dest_port`|目的主机的端口号|
|`proto`|示例 `udp`|

- metric list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`success`|只有 1/-1 两种状态, 1 表示成功, -1 表示失败|int|-|


