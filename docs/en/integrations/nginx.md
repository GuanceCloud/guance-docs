
Nginx
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

NGINX collector can take many metrics from NGINX instances, such as the total number of requests, connections, cache and other metrics, and collect the metrics into Guance Cloud to help monitor and analyze various abnormal situations of NGINX.

## Preconditions {#requirements}

- NGINX version >= `1.8.0`; Already tested version:
    - [x] 1.23.2
    - [x] 1.22.1
    - [x] 1.21.6
    - [x] 1.18.0
    - [x] 1.14.2
    - [x] 1.8.0

- NGINX collects the data of `http_stub_status_module` by default. When the `http_stub_status_module` is opened, see [here](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html){:target="_blank"}, which will report the data of NGINX measurements later.

- If you are using [VTS](https://github.com/vozlt/nginx-module-vts){:target="_blank"} or want to monitor more data, it is recommended to turn on VTS-related data collection by setting the option `use_vts` to `true` in `nginx.conf`. For how to start VTS, see [here](https://github.com/vozlt/nginx-module-vts#synopsis){:target="_blank"}.

- After VTS function is turned on, the following measurements can be generated:

    - `nginx`
    - `nginx_server_zone`
    - `nginx_upstream_zone` (NGINX needs to configure [`upstream` related configuration](http://nginx.org/en/docs/http/ngx_http_upstream_module.html){:target="_blank"})
    - `nginx_cache_zone`    (NGINX needs to configure [`cache` related configuration](https://docs.nginx.com/nginx/admin-guide/content-cache/content-caching/){:target="_blank"})

- Take the example of generating the `nginx_upstream_zone` measurements. An example of NGINX-related configuration is as follows:

```
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

- After the VTS function has been turned on, it is no longer necessary to collect the data of the `http_stub_status_module` module, because the data of the VTS module will include the data of the `http_stub_status_module` module.

## Configuration {#config}

Go to the `conf.d/nginx` directory under the DataKit installation directory, copy `nginx.conf.sample` and name it `nginx.conf`. Examples are as follows:

```toml
[[inputs.nginx]]
# Nginx status URL.
# (Default) If not use with VTS, the formula is like this: "http://localhost:80/basic_status".
# If using with VTS, the formula is like this: "http://localhost:80/status/format/json".
url = "http://localhost:80/basic_status"

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
#files = ["/var/log/nginx/access.log","/var/log/nginx/error.log"]
## grok pipeline script path
#pipeline = "nginx.p"
[inputs.nginx.tags]
# some_tag = "some_value"
# more_tag = "some_other_value"
# ...
```

???+ warnning

    `url` are configurable, `/basic_status` are prefereed.

After configuration, restart DataKit.

## Measurements {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.nginx.tags]`:

``` toml
 [inputs.nginx.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `nginx`

- tag


| Tag | Description |
|  ----  | --------|
|`host`|host name which installed nginx|
|`nginx_port`|nginx server port|
|`nginx_server`|nginx server host|
|`nginx_version`|nginx version, exist when using vts|

- metric list


| Metric | Description | Type | Unit |
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

- tag


| Tag | Description |
|  ----  | --------|
|`host`|host name which installed nginx|
|`nginx_port`|nginx server port|
|`nginx_server`|nginx server host|
|`nginx_version`|nginx version|
|`server_zone`|server zone|

- metric list


| Metric | Description | Type | Unit |
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

- tag


| Tag | Description |
|  ----  | --------|
|`host`|host name which installed nginx|
|`nginx_port`|nginx server port|
|`nginx_server`|nginx server host|
|`nginx_version`|nginx version|
|`upstream_server`|upstream server|
|`upstream_zone`|upstream zone|

- metric list


| Metric | Description | Type | Unit |
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

- tag


| Tag | Description |
|  ----  | --------|
|`cache_zone`|cache zone|
|`host`|host name which installed nginx|
|`nginx_port`|nginx server port|
|`nginx_server`|nginx server host|
|`nginx_version`|nginx version|

- metric list


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






## Log Collection {#logging}

To collect NGINX logs, open `files` in NGINX.conf and write to the absolute path of the NGINX log file. For example:

```
    [[inputs.nginx]]
      ...
      [inputs.nginx.log]
		files = ["/var/log/nginx/access.log","/var/log/nginx/error.log"]
```


When log collection is turned on, logs with a log `source` of `nginx` are generated by default.

>Note: DataKit must be installed on the NGINX host to collect NGINX logs.


## Log Pipeline Feature Cut Field Description {#pipeline}

- NGINX error log cutting

Example error log text:
```
2021/04/21 09:24:04 [alert] 7#7: *168 write() to "/var/log/nginx/access.log" failed (28: No space left on device) while logging request, client: 120.204.196.129, server: localhost, request: "GET / HTTP/1.1", host: "47.98.103.73"
```

The list of cut fields is as follows:

| Field Name       | Field Value                                   | Description                         |
| ---          | ---                                      | ---                          |
| status       | error                                    | Log level (alert changed to error)   |
| client_ip    | 120.204.196.129                          | client ip address            |
| server       | localhost                                | server address                  |
| http_method  | GET                                      | http request mode                |
| http_url     | /                                        | http request url                 |
| http_version | 1.1                                      | http version                 |
| ip_or_host   | 47.98.103.73                             | requestor ip or host             |
| msg          | 7#7: *168 write()...host: \"47.98.103.73 | Log content                     |
| time         | 1618968244000000000                      | Nanosecond timestamp (as line protocol time) |

Example of error log text:

```
2021/04/29 16:24:38 [emerg] 50102#0: unexpected ";" in /usr/local/etc/nginx/nginx.conf:23
```

The list of cut fields is as follows:

| Field Name | Field Value                                                          | Description                         |
| ---    | ---                                                             | ---                          |
| status | error                                                           | Log level (emerg changed to error)   |
| msg    | 50102#0: unexpected \";\" in /usr/local/etc/nginx/nginx.conf:23 | log content                     |
| time   | 1619684678000000000                                             | Nanosecond timestamp (as row protocol time) |

- NGINX access log cutting

Example of access log text:
```
127.0.0.1 - - [24/Mar/2021:13:54:19 +0800] "GET /basic_status HTTP/1.1" 200 97 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.72 Safari/537.36"
```

The list of cut fields is as follows:

| Field Name       | Field Value                       | Description                         |
| ---          | ---                          | ---                          |
| client_ip    | 127.0.0.1                    | Log level (emerg changed to error)   |
| status       | ok                           | log level                     |
| status_code  | 200                          | http code                    |
| http_method  | GET                          | http request method                |
| http_url     | /basic_status                | http request url                 |
| http_version | 1.1                          | http version                 |
| agent        | Mozilla/5.0... Safari/537.36 | User-Agent                   |
| browser      | Chrome                       | browser                       |
| browserVer   | 89.0.4389.72                 | browser version                   |
| isMobile     | false                        | Is it a cell phone                     |
| engine       | AppleWebKit                  | engine                         |
| os           | Intel Mac OS X 11_1_0        | system                         |
| time         | 1619243659000000000          | Nanosecond timestamp (as line protocol time) |
