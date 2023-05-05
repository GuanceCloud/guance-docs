
# Nginx

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

NGINX 采集器可以从 NGINX 实例中采取很多指标，比如请求总数连接数、缓存等多种指标，并将指标采集到观测云，帮助监控分析 NGINX 各种异常情况。

## 前置条件 {#requirements}

- NGINX 版本 >= `1.19.6`; 已测试的版本
    - [x] 1.20.2
    - [x] 1.21.6
    - [x] 1.22.1
    - [x] 1.23.3

- NGINX 默认采集 `http_stub_status_module` 模块的数据，开启 `http_stub_status_module` 模块参见[这里](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html){:target="_blank"}，开启了以后会上报 NGINX 指标集的数据;

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

## 配置 {#config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/nginx` 目录，复制 `nginx.conf.sample` 并命名为 `nginx.conf`。示例如下：
    
    ```toml
        [[inputs.nginx]]
    	# Nginx status URL.
    	# (Default) If not use with VTS, the formula is like this: "http://localhost:80/nginx_status".
    	# If using with VTS, the formula is like this: "http://localhost:80/status/format/json".
    	url = "http://localhost:80/nginx_status"
    
    	# ##(optional) collection interval, default is 30s
    	# interval = "30s"
    	use_vts = false
    	## Optional TLS Config
    	# tls_ca = "/xxx/ca.pem"
    	# tls_cert = "/xxx/cert.cer"
    	# tls_key = "/xxx/key.key"
    	## Use TLS but skip chain & host verification
    	insecure_skip_verify = false
    	# HTTP response timeout (default: 5s)
    	response_timeout = "20s"
    
        ## Set true to enable election
    	election = true
    
    	[inputs.nginx.log]
    	#	files = ["/var/log/nginx/access.log","/var/log/nginx/error.log"]
    	#	# grok pipeline script path
    	#	pipeline = "nginx.p"
    	[inputs.nginx.tags]
    	# some_tag = "some_value"
    	# more_tag = "some_other_value"
    	# ...
    ```
    
    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

???+ attention

    `url` 地址以 nginx 具体配置为准，一般常见的用法就是用 `/nginx_status` 这个路由。
<!-- markdownlint-enable -->

## 指标集 {#measurements}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.nginx.tags]` 指定其它标签：

``` toml
[inputs.nginx.tags]
 # some_tag = "some_value"
 # more_tag = "some_other_value"
 # ...
```



### `nginx`

- 标签


| Tag | Descrition |
|  ----  | --------|
|`host`|host mame which installed nginx|
|`nginx_port`|nginx server port|
|`nginx_server`|nginx server host|
|`nginx_version`|nginx version, exist when using vts|

- 指标列表


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`connection_accepts`|The total number of accepts client connections|int|count|
|`connection_active`|The current number of active client connections|int|count|
|`connection_handled`|The total number of handled client connections|int|count|
|`connection_reading`|The total number of reading client connections|int|count|
|`connection_requests`|The total number of requests client connections|int|count|
|`connection_waiting`|The total number of waiting client connections|int|count|
|`connection_writing`|The total number of writing client connections|int|count|
|`load_timestamp`|nginx process load time in milliseconds, exist when using vts|int|msec|



### `nginx_server_zone`

- 标签


| Tag | Descrition |
|  ----  | --------|
|`host`|host mame which installed nginx|
|`nginx_port`|nginx server port|
|`nginx_server`|nginx server host|
|`nginx_version`|nginx version|
|`server_zone`|server zone|

- 指标列表


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`received`|The total amount of data received from clients.|int|B|
|`requests`|The total number of client requests received from clients.|int|count|
|`response_1xx`|The number of responses with status codes 1xx|int|count|
|`response_2xx`|The number of responses with status codes 2xx|int|count|
|`response_3xx`|The number of responses with status codes 3xx|int|count|
|`response_4xx`|The number of responses with status codes 4xx|int|count|
|`response_5xx`|The number of responses with status codes 5xx|int|count|
|`send`|The total amount of data sent to clients.|int|B|



### `nginx_upstream_zone`

- 标签


| Tag | Descrition |
|  ----  | --------|
|`host`|host mame which installed nginx|
|`nginx_port`|nginx server port|
|`nginx_server`|nginx server host|
|`nginx_version`|nginx version|
|`upstream_server`|upstream server|
|`upstream_zone`|upstream zone|

- 指标列表


| Metric | Descrition | Type | Unit |
| ---- |---- | :---:    | :----: |
|`received`|The total number of bytes received from this server.|int|B|
|`request_count`|The total number of client requests received from server.|int|count|
|`response_1xx`|The number of responses with status codes 1xx|int|count|
|`response_2xx`|The number of responses with status codes 2xx|int|count|
|`response_3xx`|The number of responses with status codes 3xx|int|count|
|`response_4xx`|The number of responses with status codes 4xx|int|count|
|`response_5xx`|The number of responses with status codes 5xx|int|count|
|`send`|The total number of bytes sent to clients.|int|B|



### `nginx_cache_zone`

- 标签


| Tag | Descrition |
|  ----  | --------|
|`cache_zone`|cache zone|
|`host`|host mame which installed nginx|
|`nginx_port`|nginx server port|
|`nginx_server`|nginx server host|
|`nginx_version`|nginx version|

- 指标列表


| Metric | Descrition | Type | Unit |
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



## 日志采集 {#logging}

如需采集 NGINX 的日志，可在 nginx.conf 中 将 `files` 打开，并写入 NGINX 日志文件的绝对路径。比如：

```toml
[[inputs.nginx]]
  ...
  [inputs.nginx.log]
    files = ["/var/log/nginx/access.log","/var/log/nginx/error.log"]
```

开启日志采集以后，默认会产生日志来源（`source`）为 `nginx` 的日志。

> 注意：必须将 DataKit 安装在 NGINX 所在主机才能采集 NGINX 日志。

## 日志 Pipeline 功能切割字段说明 {#pipeline}

- NGINX 错误日志切割

错误日志文本示例：

```log
2021/04/21 09:24:04 [alert] 7#7: *168 write() to "/var/log/nginx/access.log" failed (28: No space left on device) while logging request, client: 120.204.196.129, server: localhost, request: "GET / HTTP/1.1", host: "47.98.103.73"
```

切割后的字段列表如下：

| 字段名       | 字段值                                   | 说明                         |
| ---          | ---                                      | ---                          |
| status       | error                                    | 日志等级(alert 转成了 error) |
| client_ip    | 120.204.196.129                          | client IP 地址               |
| server       | localhost                                | server 地址                  |
| http_method  | GET                                      | http 请求方式                |
| http_url     | /                                        | http 请求 URL                |
| http_version | 1.1                                      | http version                 |
| ip_or_host   | 47.98.103.73                             | 请求方 IP 或者 host          |
| msg          | 7#7: *168 write()...host: \"47.98.103.73 | 日志内容                     |
| time         | 1618968244000000000                      | 纳秒时间戳（作为行协议时间） |

错误日志文本示例：

```log
2021/04/29 16:24:38 [emerg] 50102#0: unexpected ";" in /usr/local/etc/nginx/nginx.conf:23
```

切割后的字段列表如下：

| 字段名   | 字段值                                                            | 说明                             |
| ---      | ---                                                               | ---                              |
| `status` | `error`                                                           | 日志等级(`emerg` 转成了 `error`) |
| `msg`    | `50102#0: unexpected \";\" in /usr/local/etc/nginx/nginx.conf:23` | 日志内容                         |
| `time`   | `1619684678000000000`                                             | 纳秒时间戳（作为行协议时间）     |

- NGINX 访问日志切割

访问日志文本示例:

```log
127.0.0.1 - - [24/Mar/2021:13:54:19 +0800] "GET /basic_status HTTP/1.1" 200 97 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.72 Safari/537.36"
```

切割后的字段列表如下：

| 字段名         | 字段值                         | 说明                             |
| ---            | ---                            | ---                              |
| `client_ip`    | `127.0.0.1`                    | 日志等级(`emerg` 转成了 `error`) |
| `status`       | `ok`                           | 日志等级                         |
| `status_code`  | `200`                          | HTTP Code                        |
| `http_method`  | `GET`                          | HTTP 请求方式                    |
| `http_url`     | `/basic_status`                | HTTP 请求 URL                    |
| `http_version` | `1.1`                          | HTTP Version                     |
| `agent`        | `Mozilla/5.0... Safari/537.36` | User-Agent                       |
| `browser`      | `Chrome`                       | 浏览器                           |
| `browserVer`   | `89.0.4389.72`                 | 浏览器版本                       |
| `isMobile`     | `false`                        | 是否手机                         |
| `engine`       | `AppleWebKit`                  | 引擎                             |
| `os`           | `Intel Mac OS X 11_1_0`        | 系统                             |
| `time`         | `1619243659000000000`          | 纳秒时间戳（作为行协议时间）     |
