
# Apache
---

- DataKit 版本：1.4.2
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

Apache 采集器可以从 Apache 服务中采集请求数、连接数等，并将指标采集到观测云，帮助监控分析 Apache 各种异常情况。

## 前置条件

- Apache 版本 >= 2.4.46 (Unix)

- 一般发行版 Linux 会自带 Apache,如需下载[参见](https://httpd.apache.org/download.cgi){:target="_blank"}

- 默认配置路径: `/etc/apache2/apache2.conf`,`/etc/apache2/httpd.conf`

- 开启 Apache `mod_status`,在 Apache 配置文件中添加:

```
<Location /server-status>
SetHandler server-status

Order Deny,Allow
Deny from all
Allow from your_ip
</Location>
```

- 重启 Apache

```sudo apachectl restart```


## 配置

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

  # [inputs.apache.log]
  # files = []
  # #grok pipeline script path
  # pipeline = "apache.p"

  [inputs.apache.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ... 
```

配置好后，重启 DataKit 即可。

## 指标集

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.apache.tags]` 指定其它标签：

``` toml
 [inputs.apache.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `apache`

采集到的指标，受 Apache 安装环境影响。具体以 `http://<your-apache-server>/server-status?auto` 页面展示的为准。

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`server_mpm`|apache server Multi-Processing Module,prefork、worker and event|
|`server_version`|apache server version|
|`url`|apache server status url|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`busy_workers`|The number of workers serving requests.|int|count|
|`closing_connection`|The amount of workers that are currently closing a connection|int|count|
|`conns_async_closing`|The number of asynchronous closing connections,windows not support|int|count|
|`conns_async_keep_alive`|The number of asynchronous keep alive connections,windows not support|int|count|
|`conns_async_writing`|The number of asynchronous writes connections,windows not support|int|count|
|`conns_total`|The total number of requests performed,windows not support|int|count|
|`cpu_load`|The percent of CPU used,windows not support|float|percent|
|`dns_lookup`|The workers waiting on a DNS lookup|int|count|
|`gracefully_finishing`|The number of workers finishing their request|int|count|
|`idle_cleanup`|These workers were idle and their process is being stopped|int|count|
|`idle_workers`|The number of idle workers|int|count|
|`keepalive`|The workers intended for a new request from the same client, because it asked to keep the connection alive|int|count|
|`logging`|The workers writing something to the Apache logs|int|count|
|`net_bytes`|The total number of bytes served.|int|B|
|`net_hits`|The total number of requests performed|int|count|
|`open_slot`|The amount of workers that Apache can still start before hitting the maximum number of workers|int|count|
|`reading_request`|The workers reading the incoming request|int|count|
|`sending_reply`|The number of workers sending a reply/response or waiting on a script (like PHP) to finish so they can send a reply|int|count|
|`starting_up`|The workers that are still starting up and not yet able to handle a request|int|count|
|`uptime`|The amount of time the server has been running|int|s|
|`waiting_for_connection`|The number of workers that can immediately process an incoming request|int|count|

 


## 日志采集

如需采集 Apache 的日志，可在 apache.conf 中 将 `files` 打开，并写入 Apache 日志文件的绝对路径。比如：

```
    [[inputs.apache]]
      ...
      [inputs.apache.log]
		files = ["/var/log/apache2/error.log","/var/log/apache2/access.log"]
```


开启日志采集以后，默认会产生日志来源（`source`）为 `apache` 的日志。

>注意：必须将 DataKit 安装在 Apache 所在主机才能采集 Apache 日志

## 日志 pipeline 功能切割字段说明

- Apache 错误日志切割 

错误日志文本示例：

```
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

访问日志文本示例:

``` 
127.0.0.1 - - [17/May/2021:14:51:09 +0800] "GET /server-status?auto HTTP/1.1" 200 917
```

切割后的字段列表如下：

| 字段名         | 字段值                | 说明                         |
| ---            | ---                   | ---                          |
| `status`       | `info`                | 日志等级                     |
| `ip_or_host`   | `127.0.0.1`           | 请求方ip或者host             |
| `http_code`    | `200`                 | http status code             |
| `http_method`  | `GET`                 | http 请求类型                |
| `http_url`     | `/`                   | http 请求url                 |
| `http_version` | `1.1`                 | http version                 |
| `time`         | `1621205469000000000` | 纳秒时间戳（作为行协议时间） |
