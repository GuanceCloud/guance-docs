
# 网络拨测
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

# dialtesting

该采集器是网络拨测结果数据采集，所有拨测产生的数据，上报观测云。

## 私有拨测节点部署 {#private-deploy}

=== "主机安装"

    私有拨测节点部署，需在 [观测云页面创建私有拨测节点](../usability-monitoring/self-node.md)。创建完成后，将页面上相关信息填入 `conf.d/network/dialtesting.conf` 即可：

    进入 DataKit 安装目录下的 `conf.d/network` 目录，复制 `dialtesting.conf.sample` 并命名为 `dialtesting.conf`。示例如下：
    
    ```toml
    #  中心任务存储的服务地址
    server = "https://dflux-dial.guance.com"
    
    # require，节点惟一标识ID
    region_id = "reg_c2jlokxxxxxxxxxxx"
    
    # 若server配为中心任务服务地址时，需要配置相应的ak或者sk
    ak = "ZYxxxxxxxxxxxx"
    sk = "BNFxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    
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

    目前只有 linux 的拨测节点才支持「路由跟踪」，跟踪数据会保存在相关指标的 [traceroute](#fields) 字段中。

## 拨测部署图 {#arch}

<figure markdown>
  ![](https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/images/datakit/dialtesting-net-arch.png){ width="800" }
</figure>

## 配置 {#config}

进入 DataKit 安装目录下的 `conf.d/network` 目录，复制 `dialtesting.conf.sample` 并命名为 `dialtesting.conf`。示例如下：

```toml

[[inputs.dialtesting]]
  # 中心任务存储的服务地址，即df_dialtesting center service。
  # 此处同时可配置成本地json 文件全路径 "file:///your/dir/json-file-name", 为task任务的json字符串。
  server = "https://dflux-dial.guance.com"

  # require，节点惟一标识ID
  region_id = "default"

  # 若server配为中心任务服务地址时，需要配置相应的ak或者sk
  ak = ""
  sk = ""

  pull_interval = "1m"

  time_out = "1m"
  workers = 6

  # 发送数据失败最大次数，根据任务的post_url进行累计，超过最大次数后，发送至该地址的拨测任务将退出
  max_send_fail_count = 16

  [inputs.dialtesting.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

配置好后，重启 DataKit 即可。

## 指标集 {#measurements}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[[inputs.dialtesting.tags]]` 另择 host 来命名。



### `http_dial_testing`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`city`|示例 杭州|
|`country`|示例 中国|
|`internal`|示例 true（国内 true /海外 false）|
|`isp`|示例 电信/移动/联通|
|`name`|示例：拨测名称,百度测试|
|`proto`|示例 HTTP/1.0|
|`province`|示例 浙江|
|`status`|示例 OK/FAIL 两种状态 |
|`status_code_class`|示例 2xx|
|`status_code_string`|示例 200 OK|
|`url`|示例 http://wwww.baidu.com|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`fail_reason`|拨测失败原因|string|-|
|`message`|包括请求头(request_header)/请求体(request_body)/返回头(response_header)/返回体(response_body)/fail_reason 冗余一份|string|-|
|`proto`|示例 HTTP/1.0|string|-|
|`response_body_size`|body 长度|int|B|
|`response_time`|HTTP 相应时间, 单位 ms|int|μs|
|`status_code`|web page response code|int|-|
|`success`|只有 1/-1 两种状态, 1 表示成功, -1 表示失败|int|-|



### `tcp_dial_testing`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`city`|示例 杭州|
|`country`|示例 中国|
|`dest_host`|示例 wwww.baidu.com|
|`dest_port`|示例 80|
|`internal`|示例 true（国内 true /海外 false）|
|`isp`|示例 电信/移动/联通|
|`name`|示例 拨测名称,百度测试|
|`proto`|示例 tcp|
|`province`|示例 浙江|
|`status`|示例 OK/FAIL 两种状态 |

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`fail_reason`|拨测失败原因|string|-|
|`message`|包括响应时间(response_time_in_micros)/错误原因(fail_reason)|string|-|
|`response_time`|TCP 连接时间, 单位|int|μs|
|`response_time_with_dns`|连接时间（含DNS解析）, 单位|int|μs|
|`success`|只有 1/-1 两种状态, 1 表示成功, -1 表示失败|int|-|
|`traceroute`|路由跟踪数据文本(JSON格式)|string|-|



### `icmp_dial_testing`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`city`|示例 杭州|
|`country`|示例 中国|
|`dest_host`|示例 wwww.baidu.com|
|`internal`|示例 true（国内 true /海外 false）|
|`isp`|示例 电信/移动/联通|
|`name`|示例 拨测名称,百度测试|
|`proto`|示例 icmp|
|`province`|示例 浙江|
|`status`|示例 OK/FAIL 两种状态 |

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`average_round_trip_time_in_millis`|平均往返时间(RTT)|float|ms|
|`fail_reason`|拨测失败原因|string|-|
|`max_round_trip_time_in_millis`|最大往返时间(RTT)|float|ms|
|`message`|包括平均RTT时间(average_round_trip_time_in_millis)/错误原因(fail_reason)|string|-|
|`min_round_trip_time_in_millis`|最小往返时间(RTT)|float|ms|
|`packet_loss_percent`|丢包率|float|ms|
|`packets_received`|接受的数据包|int|count|
|`packets_sent`|发送的数据包|int|count|
|`std_round_trip_time_in_millis`|往返时间(RTT)标准差|float|ms|
|`success`|只有 1/-1 两种状态, 1 表示成功, -1 表示失败|int|-|
|`traceroute`|路由跟踪数据文本(JSON格式)|string|-|



### `websocket_dial_testing`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`city`|示例 杭州|
|`country`|示例 中国|
|`internal`|示例 true（国内 true /海外 false）|
|`isp`|示例 电信/移动/联通|
|`name`|示例 拨测名称,百度测试|
|`proto`|示例 websocket|
|`province`|示例 浙江|
|`status`|示例 OK/FAIL 两种状态 |
|`url`|示例 ws://www.abc.com|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`fail_reason`|拨测失败原因|string|-|
|`message`|包括响应时间(response_time_in_micros)/错误原因(fail_reason)|string|-|
|`response_message`|拨测返回的消息|string|-|
|`response_time`|连接时间, 单位|int|μs|
|`response_time_with_dns`|连接时间（含DNS解析）, 单位|int|μs|
|`sent_message`|拨测发送的消息|string|-|
|`success`|只有 1/-1 两种状态, 1 表示成功, -1 表示失败|int|-|




## `traceroute` 字段描述 {#fields}

traceroute 是「路由跟踪」数据的 JSON 文本，整个数据是一个数组对象，对象中的每个数组元素记录了一次路由探测的相关情况，示例如下：

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
| `avg_cost` | number        | 平均耗时(ns)                |
| `min_cost` | number        | 最小耗时(ns)                |
| `max_cost` | number        | 最大耗时(ns)                |
| `std_cost` | number        | 耗时标准差(ns)              |
| `items`    | Item 的 Array | 每次探测信息([详见](#item)) |

### Item {#item}

| 字段            | 类型   | 说明                      |
| :---            | ---    | ---                       |
| `ip`            | string | IP 地址，如果失败，值为 * |
| `response_time` | number | 响应时间(ns)              |
