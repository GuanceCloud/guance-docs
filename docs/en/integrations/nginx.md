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

The NGINX collector can collect many metrics from NGINX instances, such as total number of connections, cache statistics, and more. It sends these metrics to Guance to help monitor and analyze various anomalies in NGINX.

## Configuration {#config}

### Prerequisites {#requirements}

- NGINX version >= `1.8.0`; tested versions:
    - [x] 1.23.2
    - [x] 1.22.1
    - [x] 1.21.6
    - [x] 1.18.0
    - [x] 1.14.2
    - [x] 1.8.0

- NGINX collects data by default from the `http_stub_status_module`. To enable the `http_stub_status_module`, refer to [this link](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html){:target="_blank"}. Once enabled, it will report NGINX measurement data;

- If you are using [VTS](https://github.com/vozlt/nginx-module-vts){:target="_blank"} or want to monitor more data, it is recommended to enable VTS-related data collection. Set the option `use_vts` to `true` in the `nginx.conf`. For instructions on how to enable VTS, see [here](https://github.com/vozlt/nginx-module-vts#synopsis){:target="_blank"};

- After enabling the VTS feature, it can generate the following measurements:

    - `nginx`
    - `nginx_server_zone`
    - `nginx_upstream_zone` (NGINX needs to configure [`upstream`](http://nginx.org/en/docs/http/ngx_http_upstream_module.html){:target="_blank"})
    - `nginx_cache_zone` (NGINX needs to configure [`cache`](https://docs.nginx.com/nginx/admin-guide/content-cache/content-caching/){:target="_blank"})

- As an example to generate the `nginx_upstream_zone` measurement set, the relevant NGINX configuration is as follows:

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

- Once the VTS feature is enabled, there is no need to collect data from the `http_stub_status_module` module again because the VTS module's data includes the `http_stub_status_module` data.

- NGINX Plus users can still use the `http_stub_status_module` to collect basic data. Additionally, they need to enable the `http_api_module` in the NGINX configuration file ([reference](https://nginx.org/en/docs/http/ngx_http_api_module.html){:target="_blank"}) and set `status_zone` in the `server` they want to monitor. Example configuration:

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

- To enable NGINX Plus collection, set the option `use_plus_api` to `true` in the `nginx.conf` and uncomment `plus_api_url`. Note that the VTS feature is not supported for NGINX Plus.

- NGINX Plus additionally generates the following measurement sets:

    - `nginx_location_zone`

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Enter the `conf.d/nginx` directory under the DataKit installation directory, copy `nginx.conf.sample` and rename it to `nginx.conf`. An example is as follows:
    
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

    Currently, you can inject the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting) to enable the collector.

???+ attention

    The `url` address depends on the specific NGINX configuration, commonly using `/basic_status`.

<!-- markdownlint-enable -->

## Metrics {#metric}

All collected data defaults to appending global election tags. You can also specify other tags through `[inputs.nginx.tags]` in the configuration:

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
|`host`|Host name where NGINX is installed|
|`nginx_port`|NGINX server port|
|`nginx_server`|NGINX server host|
|`nginx_version`|NGINX version, exists when using vts|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`connection_accepts`|Total number of accepted client connections|int|count|
|`connection_active`|Current number of active client connections|int|count|
|`connection_dropped`|Total number of dropped client connections|int|count|
|`connection_handled`|Total number of handled client connections|int|count|
|`connection_reading`|Total number of reading client connections|int|count|
|`connection_requests`|Total number of client requests|int|count|
|`connection_waiting`|Total number of waiting client connections|int|count|
|`connection_writing`|Total number of writing client connections|int|count|
|`load_timestamp`|NGINX process load time in milliseconds, exists when using vts|int|msec|
|`pid`|Process ID of NGINX (only for NGINX Plus)|int|count|
|`ppid`|Parent Process ID of NGINX (only for NGINX Plus)|int|count|






### `nginx_server_zone`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Host name where NGINX is installed|
|`nginx_port`|NGINX server port|
|`nginx_server`|NGINX server host|
|`nginx_version`|NGINX version|
|`server_zone`|Server zone|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`code_200`|Number of responses with status code 200 (only for NGINX Plus)|int|count|
|`code_301`|Number of responses with status code 301 (only for NGINX Plus)|int|count|
|`code_404`|Number of responses with status code 404 (only for NGINX Plus)|int|count|
|`code_503`|Number of responses with status code 503 (only for NGINX Plus)|int|count|
|`discarded`|Number of discarded requests (only for NGINX Plus)|int|count|
|`processing`|Number of processing requests (only for NGINX Plus)|int|count|
|`received`|Total amount of data received from clients.|int|B|
|`requests`|Total number of client requests received from clients.|int|count|
|`response_1xx`|Number of responses with status codes 1xx|int|count|
|`response_2xx`|Number of responses with status codes 2xx|int|count|
|`response_3xx`|Number of responses with status codes 3xx|int|count|
|`response_4xx`|Number of responses with status codes 4xx|int|count|
|`response_5xx`|Number of responses with status codes 5xx|int|count|
|`responses`|Total number of responses (only for NGINX Plus)|int|count|
|`send`|Total amount of data sent to clients.|int|B|






### `nginx_upstream_zone`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Host name where NGINX is installed|
|`nginx_port`|NGINX server port|
|`nginx_server`|NGINX server host|
|`nginx_version`|NGINX version|
|`upstream_server`|Upstream server|
|`upstream_zone`|Upstream zone|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active`|Number of active connections (only for NGINX Plus)|int|count|
|`backup`|Whether configured as a backup server (only for NGINX Plus)|int|count|
|`fails`|Number of failed requests (only for NGINX Plus)|int|count|
|`received`|Total number of bytes received from this server.|int|B|
|`request_count`|Total number of client requests received from server.|int|count|
|`response_1xx`|Number of responses with status codes 1xx|int|count|
|`response_2xx`|Number of responses with status codes 2xx|int|count|
|`response_3xx`|Number of responses with status codes 3xx|int|count|
|`response_4xx`|Number of responses with status codes 4xx|int|count|
|`response_5xx`|Number of responses with status codes 5xx|int|count|
|`send`|Total number of bytes sent to clients.|int|B|
|`state`|Current state of the server (only for NGINX Plus)|int|count|
|`unavail`|Number of unavailable servers (only for NGINX Plus)|int|count|
|`weight`|Weights used when load balancing (only for NGINX Plus)|int|count|






### `nginx_cache_zone`

- Tags


| Tag | Description |
|  ----  | --------|
|`cache_zone`|Cache zone|
|`host`|Host name where NGINX is installed|
|`nginx_port`|NGINX server port|
|`nginx_server`|NGINX server host|
|`nginx_version`|NGINX version|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`max_size`|Limit on the maximum size of the cache specified in the configuration|int|B|
|`received`|Total number of bytes received from the cache.|int|B|
|`responses_bypass`|Number of cache bypasses|int|count|
|`responses_expired`|Number of expired caches|int|count|
|`responses_hit`|Number of cache hits|int|count|
|`responses_miss`|Number of cache misses|int|count|
|`responses_revalidated`|Number of revalidated caches|int|count|
|`responses_scarce`|Number of scarce caches|int|count|
|`responses_stale`|Number of stale caches|int|count|
|`responses_updating`|Number of updating caches|int|count|
|`send`|Total number of bytes sent from the cache.|int|B|
|`used_size`|Current size of the cache.|int|B|






### `nginx_location_zone`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Host name where NGINX is installed|
|`location_zone`|Location zone|
|`nginx_port`|NGINX server port|
|`nginx_server`|NGINX server host|
|`nginx_version`|NGINX version|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`code_200`|Number of 200 status codes (only for NGINX Plus)|int|count|
|`code_301`|Number of 301 status codes (only for NGINX Plus)|int|count|
|`code_404`|Number of 404 status codes (only for NGINX Plus)|int|count|
|`code_503`|Number of 503 status codes (only for NGINX Plus)|int|count|
|`discarded`|Total number of discarded requests (only for NGINX Plus)|int|B|
|`received`|Total number of received bytes (only for NGINX Plus)|int|B|
|`requests`|Number of requests (only for NGINX Plus)|int|B|
|`response`|Number of responses (only for NGINX Plus)|int|B|
|`response_1xx`|Number of 1xx responses (only for NGINX Plus)|int|count|
|`response_2xx`|Number of 2xx responses (only for NGINX Plus)|int|count|
|`response_3xx`|Number of 3xx responses (only for NGINX Plus)|int|count|
|`response_4xx`|Number of 4xx responses (only for NGINX Plus)|int|count|
|`response_5xx`|Number of 5xx responses (only for NGINX Plus)|int|count|
|`sent`|Total number of sent bytes (only for NGINX Plus)|int|count|







## Custom Objects {#custom_object}

























### `web_server`



- Tags


| Tag | Description |
|  ----  | --------|
|`col_co_status`|Current status of collector on NGINX (`OK/NotOK`)|
|`host`|Server host address|
|`ip`|Connection IP of the NGINX|
|`name`|Object unique ID|
|`reason`|If status not ok, we'll get some reasons about the status|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`display_name`|Displayed name in UI|string|-|
|`uptime`|Current NGINX uptime|int|s|
|`version`|Current version of NGINX|string|-|




## Logging {#logging}

To collect logs from NGINX, you can open `files` in `nginx.conf` and write the absolute path of the NGINX log files. For example:

```toml
[[inputs.nginx]]
  ...
  [inputs.nginx.log]
    files = ["/var/log/nginx/access.log","/var/log/nginx/error.log"]
```

After enabling log collection, logs with source (`source`) as `nginx` will be generated by default.

> **Note:** DataKit must be installed on the same host as NGINX to collect NGINX logs.

### Log Pipeline Field Parsing Explanation {#pipeline}

- NGINX Error Log Parsing

Error log text example:

```log
2021/04/21 09:24:04 [alert] 7#7: *168 write() to "/var/log/nginx/access.log" failed (28: No space left on device) while logging request, client: 120.204.196.129, server: localhost, request: "GET / HTTP/1.1", host: "47.98.103.73"
```

Parsed field list:

| Field Name       | Field Value                                   | Description                           |
| ---          | ---                                      | ---                            |
| status       | error                                    | Log level (alert converted to error) |
| client_ip    | 120.204.196.129                          | Client IP address                 |
| server       | localhost                                | Server address                    |
| http_method  | GET                                      | HTTP request method                  |
| http_url     | /                                        | HTTP request URL                      |
| http_version | 1.1                                      | HTTP version                       |
| ip_or_host   | 47.98.103.73                             | Requesting party IP or host            |
| msg          | 7#7: *168 write()...host: \"47.98.103.73 | Log content                       |
| time         | 1618968244000000000                      | Nanosecond timestamp (as line protocol time)   |

Error log text example:

```log
2021/04/29 16:24:38 [emerg] 50102#0: unexpected ";" in /usr/local/etc/nginx/nginx.conf:23
```

Parsed field list:

| Field Name   | Field Value                                                            | Description                               |
| ---      | ---                                                               | ---                                |
| `status` | `error`                                                           | Log level (`emerg` converted to `error`) |
| `msg`    | `50102#0: unexpected \";\" in /usr/local/etc/nginx/nginx.conf:23` | Log content                           |
| `time`   | `1619684678000000000`                                             | Nanosecond timestamp (as line protocol time)       |

- NGINX Access Log Parsing

Access log text example:

```log
127.0.0.1 - - [24/Mar/2021:13:54:19 +0800] "GET /basic_status HTTP/1.1" 200 97 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.72 Safari/537.36"
```

Parsed field list:

| Field Name         | Field Value                         | Description                               |
| ---            | ---                            | ---                                |
| `client_ip`    | `127.0.0.1`                    | Client IP address                   |
| `status`       | `ok`                           | Log level                           |
| `status_code`  | `200`                          | HTTP Code                          |
| `http_method`  | `GET`                          | HTTP request method                      |
| `http_url`     | `/basic_status`                | HTTP request URL                      |
| `http_version` | `1.1`                          | HTTP Version                       |
| `agent`        | `Mozilla/5.0... Safari/537.36` | User-Agent                         |
| `browser`      | `Chrome`                       | Browser                             |
| `browserVer`   | `89.0.4389.72`                 | Browser version                         |
| `isMobile`     | `false`                        | Whether mobile                           |
| `engine`       | `AppleWebKit`                  | Engine                               |
| `os`           | `Intel Mac OS X 11_1_0`        | Operating system                               |
| `time`         | `1619243659000000000`          | Nanosecond timestamp (as line protocol time)       |

## Tracing {#tracing}

### Prerequisites {#trace-requirements}

- [x] Install nginx (>=1.9.13)

***This module only supports Linux operating systems***

### Install Nginx OpenTracing Plugin {#install-otp}

The Nginx OpenTracing plugin is an open-source tracing plugin based on C++ that works with `Jaeger`, `Zipkin`, `LightStep`, `Datadog`.

- [Download](https://github.com/opentracing-contrib/nginx-opentracing/releases){:target="_blank"} the plugin corresponding to your current NGINX version. You can check the current NGINX version with the following command:

```shell
$ nginx -v
nginx version: nginx/1.18.0 (Ubuntu)
```

- Extract the archive:

```shell
tar zxf linux-amd64-nginx-ot16-ngx_http_module.so.tgz -C /usr/lib/nginx/modules
```

- Configure the plugin

Add the following information at the top of the `nginx.conf` file:

```nginx
load_module modules/ngx_http_opentracing_module.so;
```


### Install DDAgent Nginx OpenTracing Plugin {#install-ddp}

DDAgent Nginx OpenTracing plugin is an implementation by vendors based on `Nginx OpenTracing`. Different APMs have their own encoding and decoding implementations.

- [Download `dd-opentracing-cpp`](https://github.com/DataDog/dd-opentracing-cpp/releases/latest){:target="_blank"}, either `libdd_opentracing.so` or `linux-amd64-libdd_opentracing_plugin.so.gz`

- Configure NGINX

```nginx

opentracing_load_tracer /etc/nginx/tracer/libdd_opentracing.so /etc/nginx/tracer/dd.json;
opentracing on; # Enable OpenTracing
opentracing_tag http_user_agent $http_user_agent;
opentracing_trace_locations off;
opentracing_propagate_context;
opentracing_operation_name nginx-$host;

```

`opentracing_load_tracer` : Load the `opentracing` `apm` plugin path  
`opentracing_propagate_context;` : Indicates that the context needs to be propagated along the trace

- Configure DDTrace

`dd.json` is used to configure `ddtrace` information such as `service`, `agent_host`, etc. Its content is as follows:

```json
{
  "environment": "test",
  "service": "nginx",
  "operation_name_override": "nginx.handle",
  "agent_host": "localhost",
  "agent_port": 9529
}
```

- NGINX log configuration

Inject Trace information into NGINX logs. Edit as follows:

```nginx
log_format with_trace_id '$remote_addr - $http_x_forwarded_user [$time_local] "$request" '
                         '$status $body_bytes_sent "$http_referer" '
                         '"$http_user_agent" "$http_x_forwarded_for" '
                         '"$opentracing_context_x_datadog_trace_id" "$opentracing_context_x_datadog_parent_id"';

access_log /var/log/nginx/access-with-trace.log with_trace_id;
```

> **Note:** The `log_format` keyword tells NGINX that a set of log rules is being defined here. `with_trace_id` is the rule name, which can be modified. Ensure that the same name is used when specifying the log path below to associate the log rule. The path and filename in `access_log` can be changed. Typically, the original NGINX has configured log rules, so multiple rules can be configured, outputting different log formats to different files—retaining the original `access_log` rule and path unchanged while adding a new log rule with trace information, named a different log file for different log tools to read.

- Verify if the plugin is working properly

Run the following command to verify:

```shell
$:/etc/nginx# nginx -t
info: DATADOG TRACER CONFIGURATION - {"agent_url":"http://localhost:9529","analytics_enabled":false,"analytics_sample_rate":null,"date":"2023-09-25T14:33:40+0800","enabled":true,"env":"prod","lang":"cpp","lang_version":"201402","operation_name_override":"nginx.handle","report_hostname":false,"sampling_rules":"[]","service":"nginx","version":"v1.3.7"}
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

`info: DATADOG TRACER CONFIGURATION` indicates that DDTrace has been successfully loaded.

### Service Trace Propagation {#trace-propagate}

After NGINX generates trace information, related request headers need to be forwarded to the backend to form a linked trace between NGINX and the backend.

> *If there is a mismatch between NGINX trace information and DDTrace, check whether this step was performed correctly.*

Add the following configuration under the corresponding `server`'s `location`:

```nginx
location ^~ / {
    ...
    proxy_set_header X-datadog-trace-id $opentracing_context_x_datadog_trace_id;
    proxy_set_header X-datadog-parent-id $opentracing_context_x_datadog_parent_id;
    ...
    }

```

### Load NGINX Configuration {#load-config}

Run the following command to apply the NGINX configuration:

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

Then add the following configuration to the `http` module in `nginx.conf`:

```shell
http {

    ...
    proxy_headers_hash_max_size 1024;
    proxy_headers_hash_bucket_size 128;

    ...
}

```
