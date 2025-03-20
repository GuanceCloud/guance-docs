---
title     : 'Nginx'
summary   : 'Collect metrics data from Nginx'
tags:
  - 'WEB SERVER'
  - 'MIDDLEWARE'
__int_icon      : 'icon/nginx'
dashboard :
  - desc  : 'Nginx'
    path  : 'dashboard/en/nginx'
  - desc  : 'Nginx(VTS) Monitoring View'
    path  : 'dashboard/en/nginx_vts'
monitor   :
  - desc  : 'None for now'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The NGINX collector can collect many metrics from an NGINX instance, such as the total number of requests, connections, cache-related metrics, and more. It sends these metrics to <<< custom_key.brand_name >>> to help monitor and analyze various abnormal situations with NGINX.

## Configuration {#config}

### Prerequisites {#requirements}

- NGINX version >= `1.8.0`; tested versions:
    - [x] 1.23.2
    - [x] 1.22.1
    - [x] 1.21.6
    - [x] 1.18.0
    - [x] 1.14.2
    - [x] 1.8.0

- The NGINX collector by default collects data from the `http_stub_status_module`. To enable the `http_stub_status_module`, refer to [this link](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html){:target="_blank"}. Once enabled, it will report NGINX measurement data;

- If you are using [VTS](https://github.com/vozlt/nginx-module-vts){:target="_blank"} or want to monitor more data, it is recommended to enable VTS-related data collection. In the `nginx.conf`, set the option `use_vts` to `true`. How to enable VTS, see [here](https://github.com/vozlt/nginx-module-vts#synopsis){:target="_blank"};

- After enabling the VTS feature, the following measurement sets can be generated:

    - `nginx`
    - `nginx_server_zone`
    - `nginx_upstream_zone` (NGINX needs to configure [`upstream` related configurations](http://nginx.org/en/docs/http/ngx_http_upstream_module.html){:target="_blank"})
    - `nginx_cache_zone`    (NGINX needs to configure [`cache` related configurations](https://docs.nginx.com/nginx/admin-guide/content-cache/content-caching/){:target="_blank"})

- As an example for generating the `nginx_upstream_zone` measurement set, the NGINX configuration would look like this:

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

- After enabling the VTS feature, there is no need to collect data from the `http_stub_status_module`, because the VTS module data includes the `http_stub_status_module` data.

- NGINX Plus users can still use the `http_stub_status_module` to collect basic data. They also need to enable the `http_api_module` in the NGINX configuration file ([reference](https://nginx.org/en/docs/http/ngx_http_api_module.html){:target="_blank"}) and set `status_zone` in the `server` they want to monitor. Example configuration:

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

- To enable NGINX Plus collection, in the `nginx.conf`, set the option `use_plus_api` to `true` and remove the comment from `plus_api_url`. (Note: VTS functionality is not currently supported by NGINX Plus.)

- NGINX Plus generates additional measurement sets:

    - `nginx_location_zone`

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "HOST"

    Go to the `conf.d/nginx` directory under the DataKit installation directory, copy `nginx.conf.sample` and rename it to `nginx.conf`. Example:

    ```toml
        
    [[inputs.nginx]]
      ## Nginx status URL.
      ## (Default) If not used with VTS, the formula looks like this: "http://localhost:80/basic_status".
      ## If used with VTS, the formula looks like this: "http://localhost:80/status/format/json".
      url = "http://localhost:80/basic_status"
      # If using Nginx Plus, the formula looks like this: "http://localhost:8080/api/<api_version>".
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

    Currently, you can enable the collector by injecting the collector configuration via a [ConfigMap method](../datakit/datakit-daemonset-deploy.md#configmap-setting).

???+ attention

    The `url` should follow the specific NGINX configuration, commonly using `/basic_status` route.
<!-- markdownlint-enable -->

## Metrics {#metric}

By default, all collected data appends global election tags and can specify other tags through `[inputs.nginx.tags]` in the configuration:

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
|`host`|Host name where nginx is installed|
|`nginx_port`|Nginx server port|
|`nginx_server`|Nginx server host|
|`nginx_version`|Nginx version, exist when using vts|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`connection_accepts`|The total number of accepted client connections|int|count|
|`connection_active`|The current number of active client connections|int|count|
|`connection_dropped`|The total number of dropped client connections|int|count|
|`connection_handled`|The total number of handled client connections|int|count|
|`connection_reading`|The total number of reading client connections|int|count|
|`connection_requests`|The total number of requested client connections|int|count|
|`connection_waiting`|The total number of waiting client connections|int|count|
|`connection_writing`|The total number of writing client connections|int|count|
|`load_timestamp`|Nginx process load time in milliseconds, exist when using vts|int|msec|
|`pid`|The pid of nginx process (only for Nginx plus)|int|count|
|`ppid`|The ppid of nginx process (only for Nginx plus)|int|count|






### `nginx_server_zone`

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Host name where nginx is installed|
|`nginx_port`|Nginx server port|
|`nginx_server`|Nginx server host|
|`nginx_version`|Nginx version|
|`server_zone`|Server zone|

- Metrics List


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

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Host name where nginx is installed|
|`nginx_port`|Nginx server port|
|`nginx_server`|Nginx server host|
|`nginx_version`|Nginx version|
|`upstream_server`|Upstream server|
|`upstream_zone`|Upstream zone|

- Metrics List


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
|`unavail`|The number of unavailable servers (only for Nginx plus)|int|count|
|`weight`|Weights used when load balancing (only for Nginx plus)|int|count|






### `nginx_cache_zone`

- Tags


| Tag | Description |
|  ----  | --------|
|`cache_zone`|Cache zone|
|`host`|Host name where nginx is installed|
|`nginx_port`|Nginx server port|
|`nginx_server`|Nginx server host|
|`nginx_version`|Nginx version|

- Metrics List


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

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Host name where nginx is installed|
|`location_zone`|Cache zone|
|`nginx_port`|Nginx server port|
|`nginx_server`|Nginx server host|
|`nginx_version`|Nginx version|

- Metrics List


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







## Custom Objects {#custom_object}

























### `web_server`



- Tags


| Tag | Description |
|  ----  | --------|
|`col_co_status`|Current status of collector on Nginx(`OK/NotOK`)|
|`host`|The server host address|
|`ip`|Connection IP of the Nginx|
|`name`|Object uniq ID|
|`reason`|If status not ok, we'll get some reasons about the status|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`display_name`|Displayed name in UI|string|-|
|`uptime`|Current Nginx uptime|int|s|
|`version`|Current version of Nginx|string|-|




## Logs {#logging}

To collect logs from NGINX, open `files` in nginx.conf and enter the absolute path of the NGINX log file. For example:

```toml
[[inputs.nginx]]
  ...
  [inputs.nginx.log]
    files = ["/var/log/nginx/access.log","/var/log/nginx/error.log"]
```

After enabling log collection, logs with the source (`source`) as `nginx` will be generated by default.

> Note: DataKit must be installed on the same HOST where NGINX is located to collect NGINX logs.

### Log Pipeline Field Splitting Explanation {#pipeline}

- NGINX Error Log Splitting

Error log text example:

```log
2021/04/21 09:24:04 [alert] 7#7: *168 write() to "/var/log/nginx/access.log" failed (28: No space left on device) while logging request, client: 120.204.196.129, server: localhost, request: "GET / HTTP/1.1", host: "47.98.103.73"
```

The list of fields after splitting is as follows:

| Field Name       | Field Value                                   | Description                           |
| ---          | ---                                      | ---                            |
| status       | error                                    | Log level (alert converted to error) |
| client_ip    | 120.204.196.129                          | Client IP address                 |
| server       | localhost                                | Server address                    |
| http_method  | GET                                      | HTTP request method                  |
| http_url     | /                                        | HTTP request URL                  |
| http_version | 1.1                                      | HTTP version                   |
| ip_or_host   | 47.98.103.73                             | Requesting party IP or host            |
| msg          | 7#7: *168 write()...host: \"47.98.103.73 | Log content                       |
| time         | 1618968244000000000                      | Nanosecond timestamp (as line protocol time)   |

Error log text example:

```log
2021/04/29 16:24:38 [emerg] 50102#0: unexpected ";" in /usr/local/etc/nginx/nginx.conf:23
```

The list of fields after splitting is as follows:

| Field Name   | Field Value                                                            | Description                               |
| ---      | ---                                                               | ---                                |
| `status` | `error`                                                           | Log level (`emerg` converted to `error`) |
| `msg`    | `50102#0: unexpected \";\" in /usr/local/etc/nginx/nginx.conf:23` | Log content                           |
| `time`   | `1619684678000000000`                                             | Nanosecond timestamp (as line protocol time)       |

- NGINX Access Log Splitting

Access log text example:

```log
127.0.0.1 - - [24/Mar/2021:13:54:19 +0800] "GET /basic_status HTTP/1.1" 200 97 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.72 Safari/537.36"
```

The list of fields after splitting is as follows:

| Field Name         | Field Value                         | Description                               |
| ---            | ---                            | ---                                |
| `client_ip`    | `127.0.0.1`                    | Log level (`emerg` converted to `error`) |
| `status`       | `ok`                           | Log level                           |
| `status_code`  | `200`                          | HTTP Code                          |
| `http_method`  | `GET`                          | HTTP request method                      |
| `http_url`     | `/basic_status`                | HTTP request URL                      |
| `http_version` | `1.1`                          | HTTP Version                       |
| `agent`        | `Mozilla/5.0... Safari/537.36` | User-Agent                         |
| `browser`      | `Chrome`                       | Browser                             |
| `browserVer`   | `89.0.4389.72`                 | Browser version                         |
| `isMobile`     | `false`                        | Is mobile                           |
| `engine`       | `AppleWebKit`                  | Engine                               |
| `os`           | `Intel Mac OS X 11_1_0`        | System                               |
| `time`         | `1619243659000000000`          | Nanosecond timestamp (as line protocol time)       |

## Tracing {#tracing}

### Prerequisites {#trace-requirements}

- [x] Install nginx (>=1.9.13)

***This module only supports Linux operating systems***

### Install Nginx OpenTracing Plugin {#install-otp}

The Nginx OpenTracing plugin is an open-source tracing plugin based on OpenTracing written in C++ that works with `Jaeger`, `Zipkin`, `LightStep`, and `Datadog`.

- [Download](https://github.com/opentracing-contrib/nginx-opentracing/releases){:target="_blank"} the plugin corresponding to your current Nginx version. You can check the current Nginx version with the following command:

```shell
$ nginx -v
nginx version: nginx/1.18.0 (Ubuntu)
```

- Extract

```shell
tar zxf linux-amd64-nginx-ot16-ngx_http_module.so.tgz -C /usr/lib/nginx/modules
```

- Configure the plugin

Add the following information at the top of the `nginx.conf` file:

```nginx
load_module modules/ngx_http_opentracing_module.so;
```


### Install DDAgent Nginx OpenTracing Plugin {#install-ddp}

The DDAgent Nginx OpenTracing plugin is an implementation based on `Nginx OpenTracing` provided by vendors, each APM has its own encoding and decoding implementations.

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

`opentracing_load_tracer` : Loads the `opentracing` `apm` plugin path
`opentracing_propagate_context;` : Indicates that the context needs to be passed along the trace

- Configure DDTrace

`dd.json` is used to configure `ddtrace` information such as `service`, `agent_host`, etc., content as follows:

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

> **Note:** The `log_format` keyword tells Nginx that a log rule is defined here, `with_trace_id` is the rule name, which can be modified. Ensure that the same name is used when specifying the log path below to associate it with the log rule. The path and filename in `access_log` can be changed. Typically, the original Nginx is already equipped with log rules, and multiple rules can be configured, outputting different log formats to different files, i.e., keeping the original `access_log` rule and path unchanged, adding a new log rule containing trace information, naming it a different log file, for different log tools to read.

- Verify if the plugin is working properly


Run the following command to verify:

```shell
$:/etc/nginx# nginx -t
info: DATADOG TRACER CONFIGURATION - {"agent_url":"http://localhost:9529","analytics_enabled":false,"analytics_sample_rate":null,"date":"2023-09-25T14:33:40+0800","enabled":true,"env":"prod","lang":"cpp","lang_version":"201402","operation_name_override":"nginx.handle","report_hostname":false,"sampling_rules":"[]","service":"nginx","version":"v1.3.7"}
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

`info: DATADOG TRACER CONFIGURATION` indicates that DDTrace has been successfully loaded.

### Service Trace Forwarding {#trace-propagate}

After Nginx generates trace information, the relevant request header information needs to be forwarded to the backend, forming a linked operation between Nginx and the backend.

> *If Nginx trace information does not match DDTrace, ensure that this step has been performed correctly.*

Add the following configuration under the corresponding `server`'s `location`

```nginx
location ^~ / {
    ...
    proxy_set_header X-datadog-trace-id $opentracing_context_x_datadog_trace_id;
    proxy_set_header X-datadog-parent-id $opentracing_context_x_datadog_parent_id;
    ...
    }

```

### Load Nginx Configuration {#load-config}

Run the following command to make the Nginx configuration take effect:

```shell
root@liurui:/etc/nginx/tracer# nginx -s reload
info: DATADOG TRACER CONFIGURATION - {"agent_url":"http://localhost:9529","analytics_enabled":false,"analytics_sample_rate":null,"date":"2023-09-25T11:30:10+0800","enabled":true,"env":"prod","lang":"cpp","lang_version":"201402","operation_name_override":"nginx.handle","report_hostname":false,"sampling_rules":"[]","service":"nginx","version":"v1.3.7"}
root@liurui:/etc/nginx/tracer# 
```


If the following error appears:

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