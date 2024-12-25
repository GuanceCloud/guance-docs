---
title     : 'Nginx'
summary   : '采集 Nginx 的指标数据'
tags:
  - 'WEB SERVER'
  - '中间件'
__int_icon      : 'icon/nginx'
dashboard :
  - desc  : 'Nginx'
    path  : 'dashboard/zh/nginx'
  - desc  : 'Nginx(VTS) 监控视图'
    path  : 'dashboard/zh/nginx_vts'
monitor   :
  - desc  : '暂无'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

NGINX 采集器可以从 NGINX 实例中采取很多指标，比如请求总数连接数、缓存等多种指标，并将指标采集到观测云，帮助监控分析 NGINX 各种异常情况。

## 配置 {#config}

### 前置条件 {#requirements}

- NGINX 版本 >= `1.8.0`; 已测试的版本：
    - [x] 1.23.2
    - [x] 1.22.1
    - [x] 1.21.6
    - [x] 1.18.0
    - [x] 1.14.2
    - [x] 1.8.0

- NGINX 默认采集 `http_stub_status_module` 模块的数据，开启 `http_stub_status_module` 模块参见[这里](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html){:target="_blank"}，开启了以后会上报 NGINX 指标集的数据；

- 如果您正在使用 [VTS](https://github.com/vozlt/nginx-module-vts){:target="_blank"} 或者想监控更多数据，建议开启 VTS 相关数据采集，可在 `nginx.conf` 中将选项 `use_vts` 设置为 `true`。如何开启 VTS 参见[这里](https://github.com/vozlt/nginx-module-vts#synopsis){:target="_blank"};

- 开启 VTS 功能后，能产生如下指标集：

    - `nginx`
    - `nginx_server_zone`
    - `nginx_upstream_zone` (NGINX 需配置 [`upstream` 相关配置](http://nginx.org/en/docs/http/ngx_http_upstream_module.html){:target="_blank"})
    - `nginx_cache_zone`    (NGINX 需配置 [`cache` 相关配置](https://docs.nginx.com/nginx/admin-guide/content-cache/content-caching/){:target="_blank"})

- 以产生 `nginx_upstream_zone` 指标集为例，NGINX 相关配置示例如下：

``` nginx
...
http {
   ...
   upstream your-upstreamname {
     server upstream-ip:upstream-port;
  }
   server {
   ...
   location / {
   root  html;
   index  index.html index.htm;
   proxy_pass http://yourupstreamname;
}}}
```

- 已经开启了 VTS 功能以后，不必再去采集 `http_stub_status_module` 模块的数据，因为 VTS 模块的数据会包括 `http_stub_status_module` 模块的数据

- NGINX Plus 用户仍可以使用 `http_stub_status_module` 采集基础数据，同时需要在 NGINX 配置文件中开启 `http_api_module` 模块 ([参考](https://nginx.org/en/docs/http/ngx_http_api_module.html){:target="_blank"})，并在想要监控的 `server` 中设置 `status_zone`，配置示例如下：

``` nginx
# 开启 http_api_module
server {
  listen 8080;
  location /api {
     api write=on;
  }
}
# 监控更多指标
server {
  listen 80;
  status_zone <ZONE_NAME>;
  ...
}
```

- 开启 NGINX Plus 采集需要在 `nginx.conf` 中将选项 `use_plus_api` 设置为 `true`，并将 `plus_api_url` 的注释去除。（注意， VTS 功能暂不支持 NGINX Plus）

- NGINX Plus 额外产生如下指标集：

    - `nginx_location_zone`

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/nginx` 目录，复制 `nginx.conf.sample` 并命名为 `nginx.conf`。示例如下：
    
    ```toml
        
    [[inputs.nginx]]
      ## Nginx status URL.
      ## (Default) If not use with VTS, the formula is like this: "http://localhost:80/basic_status".
      ## If using with VTS, the formula is like this: "http://localhost:80/status/format/json".
      url = "http://localhost:80/basic_status"
      # If using Nginx Plus, this formula is like this: "http://localhost:8080/api/<api_version>".
      # Note: Nginx Plus not support VTS and should be used with http_stub_status_module (Default)
      # plus_api_url = "http://localhost:8080/api/9"
    
      ## Optional Can set ports as [<form>,<to>], Datakit will collect all ports.
      # ports = [80,80]
    
      ## Optional collection interval, default is 10s
      # interval = "30s"
      use_vts = false
      use_plus_api = false
      ## Optional TLS Config
      # tls_ca = "/xxx/ca.pem"
      # tls_cert = "/xxx/cert.cer"
      # tls_key = "/xxx/key.key"
      ## Use TLS but skip chain & host verification
      insecure_skip_verify = false
      ## HTTP response timeout (default: 5s)
      response_timeout = "20s"
    
      ## Set true to enable election
      election = true
    
    # [inputs.nginx.log]
      # files = ["/var/log/nginx/access.log","/var/log/nginx/error.log"]
      ## grok pipeline script path
      # pipeline = "nginx.p"
    # [inputs.nginx.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```
    
    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

???+ attention

    `url` 地址以 nginx 具体配置为准，一般常见的用法就是用 `/basic_status` 这个路由。
<!-- markdownlint-enable -->

## 指标 {#metric}

以下所有数据采集，默认会追加全局选举 tag，也可以在配置中通过 `[inputs.nginx.tags]` 指定其它标签：

``` toml
[inputs.nginx.tags]
 # some_tag = "some_value"
 # more_tag = "some_other_value"
 # ...
```



### `nginx`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|Host name which installed nginx|
|`nginx_port`|Nginx server port|
|`nginx_server`|Nginx server host|
|`nginx_version`|Nginx version, exist when using vts|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`connection_accepts`|The total number of accepts client connections|int|count|
|`connection_active`|The current number of active client connections|int|count|
|`connection_dropped`|The total number of dropped client connections|int|count|
|`connection_handled`|The total number of handled client connections|int|count|
|`connection_reading`|The total number of reading client connections|int|count|
|`connection_requests`|The total number of requests client connections|int|count|
|`connection_waiting`|The total number of waiting client connections|int|count|
|`connection_writing`|The total number of writing client connections|int|count|
|`load_timestamp`|Nginx process load time in milliseconds, exist when using vts|int|msec|
|`pid`|The pid of nginx process (only for Nginx plus)|int|count|
|`ppid`|The ppid of nginx process (only for Nginx plus)|int|count|



### `nginx_server_zone`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|host name which installed nginx|
|`nginx_port`|nginx server port|
|`nginx_server`|nginx server host|
|`nginx_version`|nginx version|
|`server_zone`|server zone|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`code_200`|The number of responses with status code 200 (only for Nginx plus)|int|count|
|`code_301`|The number of responses with status code 301 (only for Nginx plus)|int|count|
|`code_404`|The number of responses with status code 404 (only for Nginx plus)|int|count|
|`code_503`|The number of responses with status code 503 (only for Nginx plus)|int|count|
|`discarded`|The number of requests being discarded (only for Nginx plus)|int|count|
|`processing`|The number of requests being processed (only for Nginx plus)|int|count|
|`received`|The total amount of data received from clients.|int|B|
|`requests`|The total number of client requests received from clients.|int|count|
|`response_1xx`|The number of responses with status codes 1xx|int|count|
|`response_2xx`|The number of responses with status codes 2xx|int|count|
|`response_3xx`|The number of responses with status codes 3xx|int|count|
|`response_4xx`|The number of responses with status codes 4xx|int|count|
|`response_5xx`|The number of responses with status codes 5xx|int|count|
|`responses`|The total number of responses (only for Nginx plus)|int|count|
|`send`|The total amount of data sent to clients.|int|B|



### `nginx_upstream_zone`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|host name which installed nginx|
|`nginx_port`|nginx server port|
|`nginx_server`|nginx server host|
|`nginx_version`|nginx version|
|`upstream_server`|upstream server|
|`upstream_zone`|upstream zone|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active`|The number of active connections (only for Nginx plus)|int|count|
|`backup`|Whether it is configured as a backup server (only for Nginx plus)|int|count|
|`fails`|The number of failed requests (only for Nginx plus)|int|count|
|`received`|The total number of bytes received from this server.|int|B|
|`request_count`|The total number of client requests received from server.|int|count|
|`response_1xx`|The number of responses with status codes 1xx|int|count|
|`response_2xx`|The number of responses with status codes 2xx|int|count|
|`response_3xx`|The number of responses with status codes 3xx|int|count|
|`response_4xx`|The number of responses with status codes 4xx|int|count|
|`response_5xx`|The number of responses with status codes 5xx|int|count|
|`send`|The total number of bytes sent to clients.|int|B|
|`state`|The current state of the server (only for Nginx plus)|int|count|
|`unavail`|The number of unavailable server (only for Nginx plus)|int|count|
|`weight`|Weights used when load balancing (only for Nginx plus)|int|count|



### `nginx_cache_zone`

- 标签


| Tag | Description |
|  ----  | --------|
|`cache_zone`|cache zone|
|`host`|host name which installed nginx|
|`nginx_port`|nginx server port|
|`nginx_server`|nginx server host|
|`nginx_version`|nginx version|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`max_size`|The limit on the maximum size of the cache specified in the configuration|int|B|
|`received`|The total number of bytes received from the cache.|int|B|
|`responses_bypass`|The number of cache bypass|int|count|
|`responses_expired`|The number of cache expired|int|count|
|`responses_hit`|The number of cache hit|int|count|
|`responses_miss`|The number of cache miss|int|count|
|`responses_revalidated`|The number of cache revalidated|int|count|
|`responses_scarce`|The number of cache scarce|int|count|
|`responses_stale`|The number of cache stale|int|count|
|`responses_updating`|The number of cache updating|int|count|
|`send`|The total number of bytes sent from the cache.|int|B|
|`used_size`|The current size of the cache.|int|B|



### `nginx_location_zone`

- 标签


| Tag | Description |
|  ----  | --------|
|`host`|host name which installed nginx|
|`location_zone`|cache zone|
|`nginx_port`|nginx server port|
|`nginx_server`|nginx server host|
|`nginx_version`|nginx version|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`code_200`|The number of 200 code (only for Nginx plus)|int|count|
|`code_301`|The number of 301 code (only for Nginx plus)|int|count|
|`code_404`|The number of 404 code (only for Nginx plus)|int|count|
|`code_503`|The number of 503 code (only for Nginx plus)|int|count|
|`discarded`|The total number of discarded request (only for Nginx plus)|int|B|
|`received`|The total number of received bytes (only for Nginx plus)|int|B|
|`requests`|The number of requests (only for Nginx plus)|int|B|
|`response`|The number of response (only for Nginx plus)|int|B|
|`response_1xx`|The number of 1xx response (only for Nginx plus)|int|count|
|`response_2xx`|The number of 2xx response (only for Nginx plus)|int|count|
|`response_3xx`|The number of 3xx response (only for Nginx plus)|int|count|
|`response_4xx`|The number of 4xx response (only for Nginx plus)|int|count|
|`response_5xx`|The number of 5xx response (only for Nginx plus)|int|count|
|`sent`|The total number of send bytes (only for Nginx plus)|int|count|



## 自定义对象 {#object}























## 日志 {#logging}

如需采集 NGINX 的日志，可在 nginx.conf 中 将 `files` 打开，并写入 NGINX 日志文件的绝对路径。比如：

```toml
[[inputs.nginx]]
  ...
  [inputs.nginx.log]
    files = ["/var/log/nginx/access.log","/var/log/nginx/error.log"]
```

开启日志采集以后，默认会产生日志来源（`source`）为 `nginx` 的日志。

> 注意：必须将 DataKit 安装在 NGINX 所在主机才能采集 NGINX 日志。

### 日志 Pipeline 功能切割字段说明 {#pipeline}

- NGINX 错误日志切割

错误日志文本示例：

```log
2021/04/21 09:24:04 [alert] 7#7: *168 write() to "/var/log/nginx/access.log" failed (28: No space left on device) while logging request, client: 120.204.196.129, server: localhost, request: "GET / HTTP/1.1", host: "47.98.103.73"
```

切割后的字段列表如下：

| 字段名       | 字段值                                   | 说明                           |
| ---          | ---                                      | ---                            |
| status       | error                                    | 日志等级（alert 转成了 error） |
| client_ip    | 120.204.196.129                          | client IP 地址                 |
| server       | localhost                                | server 地址                    |
| http_method  | GET                                      | http 请求方式                  |
| http_url     | /                                        | http 请求 URL                  |
| http_version | 1.1                                      | http version                   |
| ip_or_host   | 47.98.103.73                             | 请求方 IP 或者 host            |
| msg          | 7#7: *168 write()...host: \"47.98.103.73 | 日志内容                       |
| time         | 1618968244000000000                      | 纳秒时间戳（作为行协议时间）   |

错误日志文本示例：

```log
2021/04/29 16:24:38 [emerg] 50102#0: unexpected ";" in /usr/local/etc/nginx/nginx.conf:23
```

切割后的字段列表如下：

| 字段名   | 字段值                                                            | 说明                               |
| ---      | ---                                                               | ---                                |
| `status` | `error`                                                           | 日志等级（`emerg` 转成了 `error`） |
| `msg`    | `50102#0: unexpected \";\" in /usr/local/etc/nginx/nginx.conf:23` | 日志内容                           |
| `time`   | `1619684678000000000`                                             | 纳秒时间戳（作为行协议时间）       |

- NGINX 访问日志切割

访问日志文本示例：

```log
127.0.0.1 - - [24/Mar/2021:13:54:19 +0800] "GET /basic_status HTTP/1.1" 200 97 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.72 Safari/537.36"
```

切割后的字段列表如下：

| 字段名         | 字段值                         | 说明                               |
| ---            | ---                            | ---                                |
| `client_ip`    | `127.0.0.1`                    | 日志等级（`emerg` 转成了 `error`） |
| `status`       | `ok`                           | 日志等级                           |
| `status_code`  | `200`                          | HTTP Code                          |
| `http_method`  | `GET`                          | HTTP 请求方式                      |
| `http_url`     | `/basic_status`                | HTTP 请求 URL                      |
| `http_version` | `1.1`                          | HTTP Version                       |
| `agent`        | `Mozilla/5.0... Safari/537.36` | User-Agent                         |
| `browser`      | `Chrome`                       | 浏览器                             |
| `browserVer`   | `89.0.4389.72`                 | 浏览器版本                         |
| `isMobile`     | `false`                        | 是否手机                           |
| `engine`       | `AppleWebKit`                  | 引擎                               |
| `os`           | `Intel Mac OS X 11_1_0`        | 系统                               |
| `time`         | `1619243659000000000`          | 纳秒时间戳（作为行协议时间）       |

## 链路 {#tracing}

### 前提条件

- [x] 安装 nginx (>=1.9.13)

***该模块只支持 linux 操作系统***


### 安装 Nginx OpenTracing 插件

Nginx OpenTracing 插件是 OpenTracing 开源的链路追踪插件，基于 C++ 编写，可以工作于 `Jaeger`、`Zipkin`、`LightStep`、`Datadog`.

- [下载](https://github.com/opentracing-contrib/nginx-opentracing/releases){:target="_blank"} 与当前 Nginx 版本对应的插件，通过以下命令可以查看当前 Nginx 版本

```shell
$ nginx -v
nginx version: nginx/1.18.0 (Ubuntu)
```

- 解压

```shell
tar zxf linux-amd64-nginx-ot16-ngx_http_module.so.tgz -C /usr/lib/nginx/modules
```

- 配置插件

在 `nginx.conf` 文件最上面新增以下信息

```nginx
load_module modules/ngx_http_opentracing_module.so;
```


### 安装 DDAgent Nginx OpenTracing 插件

DDAgent Nginx OpenTracing 插件是基于 `Nginx OpenTracing` 的一套厂商的实现，不同的 APM 会有各自的编解码实现。

- [下载 `dd-opentracing-cpp`](https://github.com/DataDog/dd-opentracing-cpp/releases/latest){:target="_blank"},`libdd_opentracing.so` 或者 `linux-amd64-libdd_opentracing_plugin.so.gz`

- 配置 Nginx

```nginx

opentracing_load_tracer /etc/nginx/tracer/libdd_opentracing.so /etc/nginx/tracer/dd.json;
opentracing on; # Enable OpenTracing
opentracing_tag http_user_agent $http_user_agent;
opentracing_trace_locations off;
opentracing_propagate_context;
opentracing_operation_name nginx-$host;

```

`opentracing_load_tracer` ： 加载 `opentracing` 的 `apm` 插件路径
`opentracing_propagate_context;` : 表示链路上下文需要进行传递

- 配置 DDTrace

`dd.json` 用于配置 `ddtrace` 信息，如：`service`、`agent_host` 等，内容如下：

```json
{
  "environment": "test",
  "service": "nginx",
  "operation_name_override": "nginx.handle",
  "agent_host": "localhost",
  "agent_port": 9529
}
```

- nginx 日志配置

将 Trace 信息注入到 Nginx 日志中。可按如下示例编辑：

```nginx
log_format with_trace_id '$remote_addr - $http_x_forwarded_user [$time_local] "$request" '
                         '$status $body_bytes_sent "$http_referer" '
                         '"$http_user_agent" "$http_x_forwarded_for" '
                         '"$opentracing_context_x_datadog_trace_id" "$opentracing_context_x_datadog_parent_id"';

access_log /var/log/nginx/access-with-trace.log with_trace_id;
```

> **说明：**`log_format` 关键字告诉 Nginx 这里定义了一套日志规则， `with_trace_id` 是规则名，可以自己修改，注意在下方指定日志路径时要用一样的名字来关联该日志的规则。`access_log` 中的路径和文件名可以更换。通常情况下原 Nginx 是配有日志规则的，我们可以配置多条规则，并将不同的日志格式输出到不同的文件，即保留原 `access_log` 规则及路径不变，新增一个包含 trace 信息的日志规则，命名为不同的日志文件，供不同的日志工具读取。

- 验证插件是否正常使用


执行以下命令进行校验

```shell
$:/etc/nginx# nginx -t
info: DATADOG TRACER CONFIGURATION - {"agent_url":"http://localhost:9529","analytics_enabled":false,"analytics_sample_rate":null,"date":"2023-09-25T14:33:40+0800","enabled":true,"env":"prod","lang":"cpp","lang_version":"201402","operation_name_override":"nginx.handle","report_hostname":false,"sampling_rules":"[]","service":"nginx","version":"v1.3.7"}
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

`info: DATADOG TRACER CONFIGURATION` 表示已经成功加载了 DDTrace 。

### 服务链路转发

Nginx 产生链路信息后，需要将相关请求头信息转发给后端，可以形成 Nginx 与后端的链路串联操作。

> *如果出现 Nginx 链路信息与 DDTrace 不匹配，则需要检查这一步是否规范操作。*

需要在对应的 `server` 下的 `location` 添加以下配置

```nginx
location ^~ / {
    ...
    proxy_set_header X-datadog-trace-id $opentracing_context_x_datadog_trace_id;
    proxy_set_header X-datadog-parent-id $opentracing_context_x_datadog_parent_id;
    ...
    }

```

### 加载 Nginx 配置

执行以下命令使 Nginx 配置生效：

```shell
root@liurui:/etc/nginx/tracer# nginx -s reload
info: DATADOG TRACER CONFIGURATION - {"agent_url":"http://localhost:9529","analytics_enabled":false,"analytics_sample_rate":null,"date":"2023-09-25T11:30:10+0800","enabled":true,"env":"prod","lang":"cpp","lang_version":"201402","operation_name_override":"nginx.handle","report_hostname":false,"sampling_rules":"[]","service":"nginx","version":"v1.3.7"}
root@liurui:/etc/nginx/tracer# 
```


如果出现以下错误：

```shell
root@liurui:/etc/nginx/conf.d# nginx -s reload
info: DATADOG TRACER CONFIGURATION - {"agent_url":"http://localhost:9529","analytics_enabled":false,"analytics_sample_rate":null,"date":"2023-09-25T12:28:53+0800","enabled":true,"env":"prod","lang":"cpp","lang_version":"201402","operation_name_override":"nginx.handle","report_hostname":false,"sampling_rules":"[]","service":"nginx","version":"v1.3.7"}
nginx: [warn] could not build optimal proxy_headers_hash, you should increase either proxy_headers_hash_max_size: 512 or proxy_headers_hash_bucket_size: 64; ignoring proxy_headers_hash_bucket_size

```

则需要在 `nginx.conf` 的 `http` 模块追加以下配置：

```shell
http {

    ...
    proxy_headers_hash_max_size 1024;
    proxy_headers_hash_bucket_size 128;

    ...
}

```
