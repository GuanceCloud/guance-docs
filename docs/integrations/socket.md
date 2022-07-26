
# TCP/UDP
---

- DataKit 版本：1.4.9
- 操作系统支持：:fontawesome-brands-linux: :fontawesome-brands-apple:

socket 采集器用于采集 UDP/TCP 端口信息。

## 前置条件

UDP 指标需要操作系统有 `nc` 程序

## 配置

进入 DataKit 安装目录下的 `conf.d/socket` 目录，复制 `socket.conf.sample` 并命名为 `socket.conf`。示例如下：

```toml

[[inputs.socket]]
  ## support tcp, udp.If the quantity to be detected is too large, it is recommended to open more collectors
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

## 指标集

以下所有指标集，默认会追加 `proto/dest_host/dest_port` 全局 tag，也可以在配置中通过 `[inputs.socket.tags]` 指定其它标签：

``` toml
 [inputs.socket.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `tcp`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`dest_host`|示例 wwww.baidu.com|
|`dest_port`|示例 80|
|`proto`|示例 tcp|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`response_time`|TCP 连接时间, 单位us|int|μs|
|`response_time_with_dns`|连接时间（含DNS解析）, 单位us|int|μs|
|`success`|只有 1/-1 两种状态, 1 表示成功, -1 表示失败|int|-|



### `udp`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`dest_host`|目的主机的host|
|`dest_port`|目的主机的端口号|
|`proto`|示例 udp|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`success`|只有 1/-1 两种状态, 1 表示成功, -1 表示失败|int|-|


