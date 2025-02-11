---
title     : 'Nginx'
summary   : 'Collect metrics data from Nginx'
tags:
  - 'WEB SERVER'
  - 'Middleware'
__int_icon      : 'icon/nginx'
dashboard :
  - desc  : 'Nginx'
    path  : 'dashboard/en/nginx'
  - desc  : 'Nginx(VTS) Monitoring View'
    path  : 'dashboard/en/nginx_vts'
monitor   :
  - desc  : 'Not Available'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The Nginx collector can gather many metrics from an Nginx instance, such as total requests, connections, cache metrics, and more. It sends these metrics to Guance for monitoring and analyzing various anomalies in Nginx.

## Configuration {#config}

### Prerequisites {#requirements}

- Nginx version >= `1.8.0`; tested versions:
    - [x] 1.23.2
    - [x] 1.22.1
    - [x] 1.21.6
    - [x] 1.18.0
    - [x] 1.14.2
    - [x] 1.8.0

- By default, the Nginx collector gathers data from the `http_stub_status_module`. To enable the `http_stub_status_module`, refer to [this link](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html){:target="_blank"}. Once enabled, it will report Mearsurement data;

- If you are using [VTS](https://github.com/vozlt/nginx-module-vts){:target="_blank"} or want to monitor more data, it is recommended to enable VTS-related data collection. Set the option `use_vts` to `true` in `nginx.conf`. How to enable VTS, see [here](https://github.com/vozlt/nginx-module-vts#synopsis){:target="_blank"};

- After enabling the VTS feature, the following Mearsurements can be generated:

    - `nginx`
    - `nginx_server_zone`
    - `nginx_upstream_zone` (Nginx needs to configure [`upstream` settings](http://nginx.org/en/docs/http/ngx_http_upstream_module.html){:target="_blank"})
    - `nginx_cache_zone` (Nginx needs to configure [`cache` settings](https://docs.nginx.com/nginx/admin-guide/content-cache/content-caching/){:target="_blank"})

- Taking the generation of the `nginx_upstream_zone` Mearsurement as an example, the relevant Nginx configuration is as follows:

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

- After enabling the VTS function, there is no need to collect data from the `http_stub_status_module` because the VTS module data includes the `http_stub_status_module` data.

- For Nginx Plus users who still want to use `http_stub_status_module` to collect basic data, they also need to enable the `http_api_module` in the Nginx configuration file ([reference](https://nginx.org/en/docs/http/ngx_http_api_module.html){:target="_blank"}) and set `status_zone` in the `server` they want to monitor. Example configuration is as follows:

``` nginx
# Enable http_api_module
server {
  listen 8080;
  location /api {
     api write=on;
  }
}
# Monitor more metrics
server {
  listen 80;
  status_zone <ZONE_NAME>;
  ...
}
```

- To enable Nginx Plus collection, set the option `use_plus_api` to `true` in `nginx.conf` and uncomment `plus_api_url`. Note that VTS functionality is not supported by Nginx Plus.

- Nginx Plus generates additional Mearsurements:

    - `nginx_location_zone`

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/nginx` directory under the DataKit installation directory, copy `nginx.conf.sample` and rename it to `nginx.conf`. An example is as follows:
    
    ```toml
        
    [[inputs.nginx]]
      ## Nginx status URL.
      ## (Default) If not using VTS, the formula is like this: "http://localhost:80/basic_status".
      ## If using VTS, the formula is like this: "http://localhost:80/status/format/json".
      url = "http://localhost:80/basic_status"
      # If using Nginx Plus, this formula is like this: "http://localhost:8080/api/<api_version>".
      # Note: Nginx Plus does not support VTS and should be used with http_stub_status_module (Default)
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
    
    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).

???+ attention

    The `url` address depends on the specific Nginx configuration. A common usage is `/basic_status`.

<!-- markdownlint-enable -->

## Metrics {#metric}

By default, all collected data will append global election tags, and other tags can be specified through `[inputs.nginx.tags]` in the configuration:

``` toml
[inputs.nginx.tags]
 # some_tag = "some_value"
 # more_tag = "some_other_value"
 # ...
```



### `nginx`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Host name where Nginx is installed|
|`nginx_port`|Nginx server port|
|`nginx_server`|Nginx server host|
|`nginx_version`|Nginx version, exists when using vts|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`connection_accepts`|The total number of accepted client connections|int|count|
|`connection_active`|The current number of active client connections|int|count|
|`connection_dropped`|The total number of dropped client connections|int|count|
|`connection_handled`|The total number of handled client connections|int|count|
|`connection_reading`|The total number of reading client connections|int|count|
|`connection_requests`|The total number of client requests|int|count|
|`connection_waiting`|The total number of waiting client connections|int|count|
|`connection_writing`|The total number of writing client connections|int|count|
|`load_timestamp`|Nginx process load time in milliseconds, exists when using vts|int|msec|
|`pid`|The pid of the Nginx process (only for Nginx Plus)|int|count|
|`ppid`|The ppid of the Nginx process (only for Nginx Plus)|int|count|



### `nginx_server_zone`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Host name where Nginx is installed|
|`nginx_port`|Nginx server port|
|`nginx_server`|Nginx server host|
|`nginx_version`|Nginx version|
|`server_zone`|Server zone|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`code_200`|The number of responses with status code 200 (only for Nginx Plus)|int|count|
|`code_301`|The number of responses with status code 301 (only for Nginx Plus)|int|count|
|`code_404`|The number of responses with status code 404 (only for Nginx Plus)|int|count|
|`code_503`|The number of responses with status code 503 (only for Nginx Plus)|int|count|
|`discarded`|The number of discarded requests (only for Nginx Plus)|int|count|
|`processing`|The number of requests being processed (only for Nginx Plus)|int|count|
|`received`|The total amount of data received from clients.|int|B|
|`requests`|The total number of client requests received from clients.|int|count|
|`response_1xx`|The number of responses with status codes 1xx|int|count|
|`response_2xx`|The number of responses with status codes 2xx|int|count|
|`response_3xx`|The number of responses with status codes 3xx|int|count|
|`response_4xx`|The number of responses with status codes 4xx|int|count|
|`response_5xx`|The number of responses with status codes 5xx|int|count|
|`responses`|The total number of responses (only for Nginx Plus)|int|count|
|`send`|The total amount of data sent to clients.|int|B|



### `nginx_upstream_zone`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Host name where Nginx is installed|
|`nginx_port`|Nginx server port|
|`nginx_server`|Nginx server host|
|`nginx_version`|Nginx version|
|`upstream_server`|Upstream server|
|`upstream_zone`|Upstream zone|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active`|The number of active connections (only for Nginx Plus)|int|count|
|`backup`|Whether it is configured as a backup server (only for Nginx Plus)|int|count|
|`fails`|The number of failed requests (only for Nginx Plus)|int|count|
|`received`|The total number of bytes received from this server.|int|B|
|`request_count`|The total number of client requests received from server.|int|count|
|`response_1xx`|The number of responses with status codes 1xx|int|count|
|`response_2xx`|The number of responses with status codes 2xx|int|count|
|`response_3xx`|The number of responses with status codes 3xx|int|count|
|`response_4xx`|The number of responses with status codes 4xx|int|count|
|`response_5xx`|The number of responses with status codes 5xx|int|count|
|`send`|The total number of bytes sent to clients.|int|B|
|`state`|The current state of the server (only for Nginx Plus)|int|count|
|`unavail`|The number of unavailable servers (only for Nginx Plus)|int|count|
|`weight`|Weights used when load balancing (only for Nginx Plus)|int|count|



### `nginx_cache_zone`

- Tags


| Tag | Description |
|  ----  | --------|
|`cache_zone`|Cache zone|
|`host`|Host name where Nginx is installed|
|`nginx_port`|Nginx server port|
|`nginx_server`|Nginx server host|
|`nginx_version`|Nginx version|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`max_size`|The limit on the maximum size of the cache specified in the configuration|int|B|
|`received`|The total number of bytes received from the cache.|int|B|
|`responses_bypass`|The number of cache bypasses|int|count|
|`responses_expired`|The number of expired caches|int|count|
|`responses_hit`|The number of cache hits|int|count|
|`responses_miss`|The number of cache misses|int|count|
|`responses_revalidated`|The number of revalidated caches|int|count|
|`responses_scarce`|The number of scarce caches|int|count|
|`responses_stale`|The number of stale caches|int|count|
|`responses_updating`|The number of updating caches|int|count|
|`send`|The total number of bytes sent from the cache.|int|B|
|`used_size`|The current size of the cache.|int|B|



### `nginx_location_zone`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Host name where Nginx is installed|
|`location_zone`|Location zone|
|`nginx_port`|Nginx server port|
|`nginx_server`|Nginx server host|
|`nginx_version`|Nginx version|

- Metric List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`code_200`|The number of 200 status codes (only for Nginx Plus)|int|count|
|`code_301`|The number of 301 status codes (only for Nginx Plus)|int|count|
|`code_404`|The number of 404 status codes (only for Nginx Plus)|int|count|
|`code_503`|The number of 503 status codes (only for Nginx Plus)|int|count|
|`discarded`|The total number of discarded requests (only for Nginx Plus)|int|B|
|`received`|The total number of received bytes (only for Nginx Plus)|int|B|
|`requests`|The number of requests (only for Nginx Plus)|int|B|
|`response`|The number of responses (only for Nginx Plus)|int|B|
|`response_1xx`|The number of 1xx responses (only for Nginx Plus)|int|count|
|`response_2xx`|The number of 2xx responses (only for Nginx Plus)|int|count|
|`response_3xx`|The number of 3xx responses (only for Nginx Plus)|int|count|
|`response_4xx`|The number of 4xx responses (only for Nginx Plus)|int|count|
|`response_5xx`|The number of 5xx responses (only for Nginx Plus)|int|count|
|`sent`|The total number of sent bytes (only for Nginx Plus)|int|count|



## Logging {#logging}

To collect logs from Nginx, open `files` in `nginx.conf` and enter the absolute path of the Nginx log files. For example:

```toml
[[inputs.nginx]]
  ...
  [inputs.nginx.log]
    files = ["/var/log/nginx/access.log","/var/log/nginx/error.log"]
```

After enabling log collection, logs with the source (`source`) set to `nginx` will be generated by default.

> Note: DataKit must be installed on the same host as Nginx to collect Nginx logs.

### Log Pipeline Field Parsing Explanation {#pipeline}

- Nginx Error Log Parsing

Error log text example:

```log
2021/04/21 09:24:04 [alert] 7#7: *168 write() to "/var/log/nginx/access.log" failed (28: No space left on device) while logging request, client: 120.204.196.129, server: localhost, request: "GET / HTTP/1.1", host: "47.98.103.73"
```

Parsed field list:

| Field Name       | Field Value                                   | Description                           |
| ---              | ---                                           | ---                                    |
| status           | error                                         | Log level (`alert` converted to `error`) |
| client_ip        | 120.204.196.129                               | Client IP address                     |
| server           | localhost                                     | Server address                        |
| http_method      | GET                                           | HTTP request method                   |
| http_url         | /                                             | HTTP request URL                      |
| http_version     | 1.1                                           | HTTP version                          |
| ip_or_host       | 47.98.103.73                                  | Requesting IP or host                 |
| msg              | 7#7: *168 write()...host: \"47.98.103.73     | Log content                           |
| time             | 1618968244000000000                           | Nanosecond timestamp (as line protocol time) |

Error log text example:

```log
2021/04/29 16:24:38 [emerg] 50102#0: unexpected ";" in /usr/local/etc/nginx/nginx.conf:23
```

Parsed field list:

| Field Name   | Field Value                                                            | Description                               |
| ---          | ---                                                                    | ---                                       |
| `status`     | `error`                                                                | Log level (`emerg` converted to `error`)  |
| `msg`        | `50102#0: unexpected \";\" in /usr/local/etc/nginx/nginx.conf:23`      | Log content                               |
| `time`       | `1619684678000000000`                                                  | Nanosecond timestamp (as line protocol time) |

- Nginx Access Log Parsing

Access log text example:

```log
127.0.0.1 - - [24/Mar/2021:13:54:19 +0800] "GET /basic_status HTTP/1.1" 200 97 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.72 Safari/537.36"
```

Parsed field list:

| Field Name         | Field Value                         | Description                               |
| ---                | ---                                 | ---                                       |
| `client_ip`        | `127.0.0.1`                         | Client IP address                         |
| `status`           | `ok`                                | Log level                                 |
| `status_code`      | `200`                               | HTTP Code                                 |
| `http_method`      | `GET`                               | HTTP request method                       |
| `http_url`         | `/basic_status`                     | HTTP request URL                          |
| `http_version`     | `1.1`                               | HTTP Version                              |
| `agent`            | `Mozilla/5.0... Safari/537.36`      | User-Agent                                |
| `browser`          | `Chrome`                            | Browser                                   |
| `browserVer`       | `89.0.4389.72`                      | Browser version                           |
| `isMobile`         | `false`                             | Whether mobile                            |
| `engine`           | `AppleWebKit`                       | Engine                                    |
| `os`               | `Intel Mac OS X 11_1_0`             | Operating system                          |
| `time`             | `1619243659000000000`               | Nanosecond timestamp (as line protocol time) |

## Tracing {#tracing}

### Prerequisites

- [x] Install nginx (>=1.9.13)

***This module only supports Linux operating systems***


### Installing the Nginx OpenTracing Plugin

The Nginx OpenTracing plugin is an open-source tracing plugin based on C++, which works with `Jaeger`, `Zipkin`, `LightStep`, and `Datadog`.

- [Download](https://github.com/opentracing-contrib/nginx-opentracing/releases){:target="_blank"} the plugin corresponding to your current Nginx version. You can check the current Nginx version using the following command:

```shell
$ nginx -v
nginx version: nginx/1.18.0 (Ubuntu)
```

- Extract the downloaded file:

```shell
tar zxf linux-amd64-nginx-ot16-ngx_http_module.so.tgz -C /usr/lib/nginx/modules
```

- Configure the plugin

Add the following lines at the top of the `nginx.conf` file:

```nginx
load_module modules/ngx_http_opentracing_module.so;
```


### Installing the DDAgent Nginx OpenTracing Plugin

DDAgent Nginx OpenTracing Plugin is an implementation based on `Nginx OpenTracing`, with different APM vendors having their own encoding and decoding implementations.

- [Download `dd-opentracing-cpp`](https://github.com/DataDog/dd-opentracing-cpp/releases/latest){:target="_blank"}, either `libdd_opentracing.so` or `linux-amd64-libdd_opentracing_plugin.so.gz`

- Configure Nginx

```nginx

opentracing_load_tracer /etc/nginx/tracer/libdd_opentracing.so /etc/nginx/tracer/dd.json;
opentracing on; # Enable OpenTracing
opentracing_tag http_user_agent $http_user_agent;
opentracing_trace_locations off;
opentracing_propagate_context;
opentracing_operation_name nginx-$host;

```

`opentracing_load_tracer`: Loads the `opentracing` APM plugin path
`opentracing_propagate_context;`: Indicates that context propagation is required on the trace

- Configure DDTrace

`dd.json` configures `ddtrace` information such as `service`, `agent_host`, etc., as shown below:

```json
{
  "environment": "test",
  "service": "nginx",
  "operation_name_override": "nginx.handle",
  "agent_host": "localhost",
  "agent_port": 9529
}
```

- Nginx log configuration

Inject Trace information into Nginx logs. Edit as follows:

```nginx
log_format with_trace_id '$remote_addr - $http_x_forwarded_user [$time_local] "$request" '
                         '$status $body_bytes_sent "$http_referer" '
                         '"$http_user_agent" "$http_x_forwarded_for" '
                         '"$opentracing_context_x_datadog_trace_id" "$opentracing_context_x_datadog_parent_id"';

access_log /var/log/nginx/access-with-trace.log with_trace_id;
```

> **Note:** The `log_format` keyword tells Nginx to define a set of log rules. `with_trace_id` is the rule name, which can be modified. Ensure the same name is used when specifying the log path below. The path and filename in `access_log` can be changed. Typically, the original Nginx has log rules configured, so we can configure multiple rules and output different log formats to different files, retaining the original `access_log` rule and path unchanged, adding a new log rule containing trace information named a different log file for different log tools to read.

- Verify the plugin is working correctly


Run the following command to verify:

```shell
$:/etc/nginx# nginx -t
info: DATADOG TRACER CONFIGURATION - {"agent_url":"http://localhost:9529","analytics_enabled":false,"analytics_sample_rate":null,"date":"2023-09-25T14:33:40+0800","enabled":true,"env":"prod","lang":"cpp","lang_version":"201402","operation_name_override":"nginx.handle","report_hostname":false,"sampling_rules":"[]","service":"nginx","version":"v1.3.7"}
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

`info: DATADOG TRACER CONFIGURATION` indicates that DDTrace has been successfully loaded.

### Service Link Forwarding

After Nginx generates trace information, it needs to forward related request headers to the backend to form a linked operation between Nginx and the backend.

> *If Nginx trace information does not match DDTrace, check if this step was performed correctly.*

Add the following configuration under the corresponding `server`'s `location`:

```nginx
location ^~ / {
    ...
    proxy_set_header X-datadog-trace-id $opentracing_context_x_datadog_trace_id;
    proxy_set_header X-datadog-parent-id $opentracing_context_x_datadog_parent_id;
    ...
    }

```

### Load Nginx Configuration

Run the following command to apply the Nginx configuration:

```shell
root@liurui:/etc/nginx/tracer# nginx -s reload
info: DATADOG TRACER CONFIGURATION - {"agent_url":"http://localhost:9529","analytics_enabled":false,"analytics_sample_rate":null,"date":"2023-09-25T11:30:10+0800","enabled":true,"env":"prod","lang":"cpp","lang_version":"201402","operation_name_override":"nginx.handle","report_hostname":false,"sampling_rules":"[]","service":"nginx","version":"v1.3.7"}
root@liurui:/etc/nginx/tracer# 
```


If you encounter the following error:

```shell
root@liurui:/etc/nginx/conf.d# nginx -s reload
info: DATADOG TRACER CONFIGURATION - {"agent_url":"http://localhost:9529","analytics_enabled":false,"analytics_sample_rate":null,"date":"2023-09-25T12:28:53+0800","enabled":true,"env":"prod","lang":"cpp","lang_version":"201402","operation_name_override":"nginx.handle","report_hostname":false,"sampling_rules":"[]","service":"nginx","version":"v1.3.7"}
nginx: [warn] could not build optimal proxy_headers_hash, you should increase either proxy_headers_hash_max_size: 512 or proxy_headers_hash_bucket_size: 64; ignoring proxy_headers_hash_bucket_size

```

Then add the following configuration in the `http` module of `nginx.conf`:

```shell
http {

    ...
    proxy_headers_hash_max_size 1024;
    proxy_headers_hash_bucket_size 128;

    ...
}

```