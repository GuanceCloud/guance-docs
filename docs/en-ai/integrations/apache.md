---
title: 'Apache'
summary: 'The Apache collector can gather metrics such as request counts and connection numbers from Apache services'
tags:
  - 'Middleware'
  - 'WEB SERVER'
__int_icon: 'icon/apache'
dashboard:
  - desc: 'Apache'
    path: 'dashboard/en/apache'
monitor:
  - desc: 'Apache'
    path: 'monitor/en/apache'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The Apache collector can gather metrics such as request counts and connection numbers from Apache services and send them to Guance, helping monitor and analyze various anomalies in Apache.

## Configuration {#config}

### Prerequisites {#requirements}

- Apache version >= `2.4.6 (Unix)`. Tested versions include:
    - [x] 2.4.56
    - [x] 2.4.54
    - [x] 2.4.41
    - [x] 2.4.38
    - [x] 2.4.29
    - [x] 2.4.6

- Default configuration paths:
    - */etc/apache2/apache2.conf*
    - */etc/apache2/httpd.conf*
    - */usr/local/apache2/conf/httpd.conf*

- Enable Apache `mod_status` by adding the following to the Apache configuration file:

```xml
<Location /server-status>
SetHandler server-status

Order Deny,Allow
Deny from all
Allow from [YOUR_IP]
</Location>
```

- Restart Apache

```shell
$ sudo apachectl restart
...
```

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/apache` directory under the DataKit installation directory, copy `apache.conf.sample`, and rename it to `apache.conf`. Example configuration:
    
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

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Metrics Set {#metric}

All collected data will append the global election tag by default, or you can specify additional tags using `[inputs.apache.tags]` in the configuration:

```toml
 [inputs.apache.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `apache` {#apache}

The collected metrics are influenced by the environment in which Apache is installed. The metrics shown on the `http://<your-apache-server>/server-status?auto` page will prevail.

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Hostname.|
|`server_mpm`|Apache server Multi-Processing Module, `prefork`, `worker` and `event`. Optional.|
|`server_version`|Apache server version. Optional.|
|`url`|Apache server status URL.|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`busy_workers`|The number of workers serving requests.|int|count|
|`closing_connection`|The amount of workers that are currently closing a connection|int|count|
|`conns_async_closing`|The number of asynchronous closing connections, not supported on Windows|int|count|
|`conns_async_keep_alive`|The number of asynchronous keep alive connections, not supported on Windows|int|count|
|`conns_async_writing`|The number of asynchronous writes connections, not supported on Windows|int|count|
|`conns_total`|The total number of requests performed, not supported on Windows|int|count|
|`cpu_load`|The percent of CPU used, not supported on Windows. Optional.|float|percent|
|`disabled`|These slots will never be able to handle any requests, indicates a misconfiguration.|int|count|
|`dns_lookup`|The workers waiting on a DNS lookup|int|count|
|`gracefully_finishing`|The number of workers finishing their request|int|count|
|`idle_cleanup`|These workers were idle and their process is being stopped|int|count|
|`idle_workers`|The number of idle workers|int|count|
|`keepalive`|The workers intended for a new request from the same client, because it asked to keep the connection alive|int|count|
|`logging`|The workers writing something to the Apache logs|int|count|
|`max_workers`|The maximum number of workers Apache can start.|int|count|
|`net_bytes`|The total number of bytes served.|int|B|
|`net_hits`|The total number of requests performed|int|count|
|`open_slot`|The amount of workers that Apache can still start before hitting the maximum number of workers|int|count|
|`reading_request`|The workers reading the incoming request|int|count|
|`sending_reply`|The number of workers sending a reply/response or waiting on a script (like PHP) to finish so they can send a reply|int|count|
|`starting_up`|The workers that are still starting up and not yet able to handle a request|int|count|
|`uptime`|The amount of time the server has been running|int|s|
|`waiting_for_connection`|The number of workers that can immediately process an incoming request|int|count|



## Custom Objects {#object}





## Log Collection {#logging}

To collect Apache logs, you can enable the `files` option in `apache.conf` and specify the absolute paths to the Apache log files. For example:

```toml
[[inputs.apache]]
  ...
  [inputs.apache.log]
    files = [
      "/var/log/apache2/error.log",
      "/var/log/apache2/access.log"
    ]
```

After enabling log collection, logs with the source (`source`) set to `apache` will be generated by default.

<!-- markdownlint-disable MD046 -->
???+ attention

    DataKit must be installed on the same host as Apache to collect Apache logs.
<!-- markdownlint-enable -->

### Pipeline Field Explanation {#pipeline}

- Parsing of Apache Error Logs

Example error log text:

```log
[Tue May 19 18:39:45.272121 2021] [access_compat:error] [pid 9802] [client ::1:50547] AH01797: client denied by server configuration: /Library/WebServer/Documents/server-status
```

Parsed fields list:

| Field Name | Field Value                | Description                         |
| ---        | ---                        | ---                                 |
| `status`   | `error`                    | Log level                           |
| `pid`      | `9802`                     | Process ID                          |
| `type`     | `access_compat`            | Log type                            |
| `time`     | `1621391985000000000`      | Nanosecond timestamp (as line protocol time) |

- Parsing of Apache Access Logs

Example access log text:

```log
127.0.0.1 - - [17/May/2021:14:51:09 +0800] "GET /server-status?auto HTTP/1.1" 200 917
```

Parsed fields list:

| Field Name     | Field Value                | Description                         |
| ---            | ---                        | ---                                 |
| `status`       | `info`                     | Log level                           |
| `ip_or_host`   | `127.0.0.1`                | Requesting IP or host               |
| `http_code`    | `200`                      | HTTP status code                    |
| `http_method`  | `GET`                      | HTTP request method                 |
| `http_url`     | `/`                        | HTTP request URL                    |
| `http_version` | `1.1`                      | HTTP version                        |
| `time`         | `1621205469000000000`      | Nanosecond timestamp (as line protocol time) |