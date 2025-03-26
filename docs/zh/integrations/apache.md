---
title     : 'Apache'
summary   : 'Apache 采集器可以从 Apache 服务中采集请求数、连接数等'
tags:
  - '中间件'
  - 'WEB SERVER'
__int_icon      : 'icon/apache'
dashboard :
  - desc  : 'Apache'
    path  : 'dashboard/zh/apache'
monitor   :
  - desc  : 'Apache'
    path  : 'monitor/zh/apache'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Apache 采集器可以从 Apache 服务中采集请求数、连接数等，并将指标采集到<<<custom_key.brand_name>>>，帮助监控分析 Apache 各种异常情况。

## 配置 {#config}

### 前置条件 {#requirements}

- Apache 版本 >= `2.4.6 (Unix)`。已测试版本：
    - [x] 2.4.56
    - [x] 2.4.54
    - [x] 2.4.41
    - [x] 2.4.38
    - [x] 2.4.29
    - [x] 2.4.6

- 默认配置路径：
    - */etc/apache2/apache2.conf*
    - */etc/apache2/httpd.conf*
    - */usr/local/apache2/conf/httpd.conf*

- 开启 Apache `mod_status`，在 Apache 配置文件中添加：

```xml
<Location /server-status>
SetHandler server-status

Order Deny,Allow
Deny from all
Allow from [YOUR_IP]
</Location>
```

- 重启 Apache

```shell
$ sudo apachectl restart
...
```

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/apache` 目录，复制 `apache.conf.sample` 并命名为 `apache.conf`。示例如下：
    
    ```toml
        
    [[inputs.apache]]
      url = "http://127.0.0.1/server-status?auto"
      # ##(optional) collection interval, default is 30s
      # interval = "30s"
    
      # username = ""
      # password = ""
    
      ## Optional TLS Config
      # tls_ca = "/xxx/ca.pem"
      # tls_cert = "/xxx/cert.cer"
      # tls_key = "/xxx/key.key"
      ## Use TLS but skip chain & host verification
      insecure_skip_verify = false
    
      ## Set true to enable election
      election = true
    
      # [inputs.apache.log]
      # files = []
      # #grok pipeline script path
      # pipeline = "apache.p"
    
      [inputs.apache.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
      # ... 
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

## 指标集 {#metric}

以下所有数据采集，默认会追加全局选举 tag，也可以在配置中通过 `[inputs.apache.tags]` 指定其它标签：

``` toml
 [inputs.apache.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `apache` {#apache}

The collected metrics are affected by the environment in which Apache is installed. The metrics shown on the `http://<your-apache-server>/server-status?auto` page will prevail.

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|Hostname.|
|`server_mpm`|Apache server Multi-Processing Module, `prefork`, `worker` and `event`. Optional.|
|`server_version`|Apache server version. Optional.|
|`url`|Apache server status url.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`busy_workers`|The number of workers serving requests.|int|count|
|`closing_connection`|The amount of workers that are currently closing a connection|int|count|
|`conns_async_closing`|The number of asynchronous closing connections,windows not support|int|count|
|`conns_async_keep_alive`|The number of asynchronous keep alive connections,windows not support|int|count|
|`conns_async_writing`|The number of asynchronous writes connections,windows not support|int|count|
|`conns_total`|The total number of requests performed,windows not support|int|count|
|`cpu_load`|The percent of CPU used,windows not support. Optional.|float|percent|
|`disabled`|These slots will never be able to handle any requests, indicates a misconfiguration.|int|count|
|`dns_lookup`|The workers waiting on a DNS lookup|int|count|
|`gracefully_finishing`|The number of workers finishing their request|int|count|
|`idle_cleanup`|These workers were idle and their process is being stopped|int|count|
|`idle_workers`|The number of idle workers|int|count|
|`keepalive`|The workers intended for a new request from the same client, because it asked to keep the connection alive|int|count|
|`logging`|The workers writing something to the Apache logs|int|count|
|`max_workers`|The maximum number of workers apache can start.|int|count|
|`net_bytes`|The total number of bytes served.|int|B|
|`net_hits`|The total number of requests performed|int|count|
|`open_slot`|The amount of workers that Apache can still start before hitting the maximum number of workers|int|count|
|`reading_request`|The workers reading the incoming request|int|count|
|`sending_reply`|The number of workers sending a reply/response or waiting on a script (like PHP) to finish so they can send a reply|int|count|
|`starting_up`|The workers that are still starting up and not yet able to handle a request|int|count|
|`uptime`|The amount of time the server has been running|int|s|
|`waiting_for_connection`|The number of workers that can immediately process an incoming request|int|count|



### `web_server` {#web_server}



- 标签


| Tag | Description |
|  ----  | --------|
|`col_co_status`|Current status of collector on Apache(`OK/NotOK`)|
|`host`|The server host address|
|`ip`|Connection IP of the Apache|
|`name`|Object uniq ID|
|`reason`|If status not ok, we'll get some reasons about the status|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`display_name`|Displayed name in UI|string|-|
|`uptime`|Current Apache uptime|int|s|
|`version`|Current version of Apache|string|-|



## 自定义对象 {#object}









### `web_server`



- 标签


| Tag | Description |
|  ----  | --------|
|`col_co_status`|Current status of collector on Apache(`OK/NotOK`)|
|`host`|The server host address|
|`ip`|Connection IP of the Apache|
|`name`|Object uniq ID|
|`reason`|If status not ok, we'll get some reasons about the status|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`display_name`|Displayed name in UI|string|-|
|`uptime`|Current Apache uptime|int|s|
|`version`|Current version of Apache|string|-|




## 日志采集 {#logging}

如需采集 Apache 的日志，可在 apache.conf 中 将 `files` 打开，并写入 Apache 日志文件的绝对路径。比如：

```toml
[[inputs.apache]]
  ...
  [inputs.apache.log]
    files = [
      "/var/log/apache2/error.log",
      "/var/log/apache2/access.log"
    ]
```

开启日志采集以后，默认会产生日志来源（`source`）为 `apache` 的日志。

<!-- markdownlint-disable MD046 -->
???+ attention

    必须将 DataKit 安装在 Apache 所在主机才能采集 Apache 日志
<!-- markdownlint-enable -->

### Pipeline 字段说明 {#pipeline}

- Apache 错误日志切割

错误日志文本示例：

``` log
[Tue May 19 18:39:45.272121 2021] [access_compat:error] [pid 9802] [client ::1:50547] AH01797: client denied by server configuration: /Library/WebServer/Documents/server-status
```

切割后的字段列表如下：

| 字段名   | 字段值                | 说明                         |
| ---      | ---                   | ---                          |
| `status` | `error`               | 日志等级                     |
| `pid`    | `9802`                | 进程 id                      |
| `type`   | `access_compat`       | 日志类型                     |
| `time`   | `1621391985000000000` | 纳秒时间戳（作为行协议时间） |

- Apache 访问日志切割

访问日志文本示例：

``` log
127.0.0.1 - - [17/May/2021:14:51:09 +0800] "GET /server-status?auto HTTP/1.1" 200 917
```

切割后的字段列表如下：

| 字段名         | 字段值                | 说明                         |
| ---            | ---                   | ---                          |
| `status`       | `info`                | 日志等级                     |
| `ip_or_host`   | `127.0.0.1`           | 请求方 IP 或者 host          |
| `http_code`    | `200`                 | http status code             |
| `http_method`  | `GET`                 | http 请求类型                |
| `http_url`     | `/`                   | http 请求 URL                |
| `http_version` | `1.1`                 | http version                 |
| `time`         | `1621205469000000000` | 纳秒时间戳（作为行协议时间） |
