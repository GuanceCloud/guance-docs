
# 网络拨测
---

:fontawesome-brands-linux: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

该采集器是网络拨测结果数据采集，所有拨测产生的数据，上报观测云。

## 私有拨测节点部署 {#private-deploy}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    私有拨测节点部署，需在 [观测云页面创建私有拨测节点](../usability-monitoring/self-node.md)。创建完成后，将页面上相关信息填入 `conf.d/network/dialtesting.conf` 即可：

    进入 DataKit 安装目录下的 `conf.d/network` 目录，复制 `dialtesting.conf.sample` 并命名为 `dialtesting.conf`。示例如下：
    
    ```toml
        
    [[inputs.dialtesting]]
      # We can also configure a JSON path like "file:///your/dir/json-file-name"
      server = "https://dflux-dial.guance.com"
    
      # [require] node ID
      region_id = "default"
    
      # if server are dflux-dial.guance.com, ak/sk required
      ak = ""
      sk = ""
    
      # The interval to pull the tasks.
      pull_interval = "1m"
    
      # The timeout for the HTTP request.
      time_out = "1m"
    
      # The number of the workers.
      workers = 6
    
      max_send_fail_count = 16
    
      # Custom tags.
      [inputs.dialtesting.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ...
    ```

    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

---

???+ attention

    目前只有 Linux 的拨测节点才支持「路由跟踪」，跟踪数据会保存在相关指标的 [`traceroute`](dialtesting.md#fields) 字段中。
<!-- markdownlint-enable -->

## 拨测部署图 {#arch}

<figure markdown>
  ![](https://static.guance.com/images/datakit/dialtesting-net-arch.png){ width="800" }
</figure>

## 配置 {#config}

进入 DataKit 安装目录下的 `conf.d/network` 目录，复制 `dialtesting.conf.sample` 并命名为 `dialtesting.conf`。示例如下：

```toml

[[inputs.dialtesting]]
  # We can also configure a JSON path like "file:///your/dir/json-file-name"
  server = "https://dflux-dial.guance.com"

  # [require] node ID
  region_id = "default"

  # if server are dflux-dial.guance.com, ak/sk required
  ak = ""
  sk = ""

  # The interval to pull the tasks.
  pull_interval = "1m"

  # The timeout for the HTTP request.
  time_out = "1m"

  # The number of the workers.
  workers = 6

  max_send_fail_count = 16

  # Custom tags.
  [inputs.dialtesting.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

配置好后，重启 DataKit 即可。

## 指标集 {#measurements}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[[inputs.dialtesting.tags]]` 另择 host 来命名。



### `http_dial_testing`

- 标签


| Tag | Description |
|  ----  | --------|
|`city`|拨测发起所在城市|
|`country`|拨测发起所在国家|
|`dest_ip`|目标 IP, 如 127.0.0.1|
|`internal`|国内/海外，`true` 表示国内/`false` 表示国外|
|`isp`|运营商，电信/移动/联通|
|`name`|拨测名称|
|`proto`|HTTP 版本，如 `HTTP/1.0`|
|`province`|拨测发起所在省份|
|`status`|拨测状态，OK/FAIL|
|`status_code_class`|HTTP 状态码，如 `200`|
|`status_code_string`|HTTP 状态字符串，如 `200 OK`|
|`url`|拨测地址，如 `http://wwww.baidu.com`|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`fail_reason`|拨测失败原因|string|-|
|`message`|包括请求头（`request_header`）/请求体（`request_body`）/返回头（`response_header`）/返回体（`response_body`）/`fail_reason` 会冗余一份|string|-|
|`proto`|示例 HTTP/1.0|string|-|
|`response_body_size`|body 长度|int|B|
|`response_time`|HTTP 响应时间|int|μs|
|`status_code`|web page response code|int|-|
|`success`|只有 1/-1 两种状态。1 表示成功/-1 表示失败|int|-|



### `tcp_dial_testing`

- 标签


| Tag | Description |
|  ----  | --------|
|`city`|城市|
|`country`|国家|
|`dest_host`|示例 `wwww.baidu.com`|
|`dest_ip`|目标 IP, 如 127.0.0.1|
|`dest_port`|端口号，如 `80`|
|`internal`|国内/海外，`true` 表示国内/`false` 表示国外|
|`isp`|运营商，电信/移动/联通|
|`name`|拨测名称，如「百度测试」|
|`proto`|协议类型，此处统一为 `tcp`|
|`province`|省份|
|`status`|拨测状态，OK/FAIL|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`fail_reason`|拨测失败原因|string|-|
|`message`|包括响应时间（`response_time`）/错误原因（`fail_reason`）|string|-|
|`response_time`|TCP 连接时间 |int|μs|
|`response_time_with_dns`|连接时间（含 DNS 解析）|int|μs|
|`success`|只有 1/-1 两种状态。1 表示成功/-1 表示失败|int|-|
|`traceroute`|路由跟踪数据文本（JSON 格式）|string|-|



### `icmp_dial_testing`

- 标签


| Tag | Description |
|  ----  | --------|
|`city`|拨测发起所在城市，如杭州|
|`country`|拨测发起所在国家，如德国|
|`dest_host`|拨测地址，如 `wwww.baidu.com`|
|`internal`|国内/海外，`true` 表示国内/`false` 表示国外|
|`isp`|运营商，电信/移动/联通|
|`name`|拨测名称，如百度测试|
|`proto`|协议类型，此处统一为 `icmp`|
|`province`|拨测发起所在省份，如浙江|
|`status`|拨测状态，OK/FAIL|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`average_round_trip_time`|平均往返时间(RTT)|float|μs|
|`average_round_trip_time_in_millis`|平均往返时间(RTT). 本字段将被弃用|float|ms|
|`fail_reason`|拨测失败原因|string|-|
|`max_round_trip_time`|最大往返时间(RTT)|float|μs|
|`max_round_trip_time_in_millis`|最大往返时间(RTT). 本字段将被弃用|float|ms|
|`message`|包括平均 RTT 时间(average_round_trip_time)/错误原因(fail_reason)|string|-|
|`min_round_trip_time`|最小往返时间(RTT)|float|μs|
|`min_round_trip_time_in_millis`|最小往返时间(RTT). 本字段将被弃用|float|ms|
|`packet_loss_percent`|丢包率|float|-|
|`packets_received`|接受的数据包|int|count|
|`packets_sent`|发送的数据包|int|count|
|`std_round_trip_time`|往返时间(RTT)标准差|float|μs|
|`std_round_trip_time_in_millis`|往返时间（RTT）标准差。本字段将被弃用|float|ms|
|`success`|只有 1/-1 两种状态。1 表示成功/-1 表示失败|int|-|
|`traceroute`|路由跟踪数据文本(JSON 格式)|string|-|



### `websocket_dial_testing`

- 标签


| Tag | Description |
|  ----  | --------|
|`city`|拨测发起所在城市|
|`country`|拨测发起所在国家|
|`internal`|国内/海外，`true` 表示国内/`false` 表示国外|
|`isp`|运营商，电信/移动/联通|
|`name`|拨测名称|
|`proto`|协议类型，此处统一为 `websocket`|
|`province`|拨测发起所在省份|
|`status`|拨测状态，OK/FAIL|
|`url`|拨测地址，如 `ws://www.abc.com`|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`fail_reason`|拨测失败原因|string|-|
|`message`|包括响应时间(response_time)/错误原因(fail_reason)|string|-|
|`response_message`|拨测返回的消息|string|-|
|`response_time`|连接时间|int|μs|
|`response_time_with_dns`|连接时间（含 DNS 解析）|int|μs|
|`sent_message`|拨测发送的消息|string|-|
|`success`|只有 1/-1 两种状态。1 表示成功/-1 表示失败|int|-|



## `traceroute` 字段描述 {#fields}

`traceroute` 是「路由跟踪」数据的 JSON 文本，整个数据是一个数组对象，对象中的每个数组元素记录了一次路由探测的相关情况，示例如下：

```json
[
    {
        "total": 2,
        "failed": 0,
        "loss": 0,
        "avg_cost": 12700395,
        "min_cost": 11902041,
        "max_cost": 13498750,
        "std_cost": 1129043,
        "items": [
            {
                "ip": "10.8.9.1",
                "response_time": 13498750
            },
            {
                "ip": "10.8.9.1",
                "response_time": 11902041
            }
        ]
    },
    {
        "total": 2,
        "failed": 0,
        "loss": 0,
        "avg_cost": 13775021,
        "min_cost": 13740084,
        "max_cost": 13809959,
        "std_cost": 49409,
        "items": [
            {
                "ip": "10.12.168.218",
                "response_time": 13740084
            },
            {
                "ip": "10.12.168.218",
                "response_time": 13809959
            }
        ]
    }
]
```

**字段描述：**

| 字段       | 类型          | 说明                        |
| :---       | ---           | ---                         |
| `total`    | number        | 总探测次数                  |
| `failed`   | number        | 失败次数                    |
| `loss`     | number        | 失败百分比                  |
| `avg_cost` | number        | 平均耗时(μs)                |
| `min_cost` | number        | 最小耗时(μs)                |
| `max_cost` | number        | 最大耗时(μs)                |
| `std_cost` | number        | 耗时标准差(μs)              |
| `items`    | Item 的 Array | 每次探测信息([详见](dialtesting.md#item)) |

### Item {#item}

| 字段            | 类型   | 说明                        |
| :---            | ---    | ---                         |
| `ip`            | string | IP 地址，如果失败，值为 `*` |
| `response_time` | number | 响应时间(μs)                |
