---
title     : 'Apache'
summary   : 'Apache collector can collect the number of requests, connections, etc. from the Apache service'
__int_icon      : 'icon/apache'
dashboard :
  - desc  : 'Apache'
    path  : 'dashboard/en/apache'
monitor   :
  - desc  : 'Apache'
    path  : 'monitor/en/apache'
---

<!-- markdownlint-disable MD025 -->
# Apache
<!-- markdownlint-enable -->
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Apache collector can collect the number of requests, connections and others from Apache services, and collect indicators to Guance Cloud to help monitor and analyze various abnormal situations of Apache.

## Configuration {#config}

### Preconditions {#requirements}

- Apache version >= `2.4.6 (Unix)`. Already tested version:
    - [x] 2.4.56
    - [x] 2.4.54
    - [x] 2.4.41
    - [x] 2.4.38
    - [x] 2.4.29
    - [x] 2.4.6

- Default configuration path:
    - */etc/apache2/apache2.conf*
    - */etc/apache2/httpd.conf*
    - */usr/local/apache2/conf/httpd.conf*

- Open Apache `mod_status` and add the followings in Apache profile:

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
sudo apachectl restart
```

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host installation"

    Go to the `conf.d/apache` directory under the DataKit installation directory, copy `apache.conf.sample` and name it `apache.conf`. Examples are as follows:
    
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
    
    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [configMap injection collector configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).

## Metric {#metric}

For all of the following data collections, a global tag named  `host` is appended by default (the tag value is the host name of the DataKit); other tags can be specified in the configuration through `[inputs.apache.tags]`:

``` toml
 [inputs.apache.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `apache`

The collected metrics are affected by the environment in which Apache is installed. The metrics shown on the `http://<your-apache-server>/server-status?auto` page will prevail.

- tag


| Tag | Description |
|  ----  | --------|
|`host`|Hostname.|
|`server_mpm`|Apache server Multi-Processing Module, `prefork`, `worker` and `event`. Optional.|
|`server_version`|Apache server version. Optional.|
|`url`|Apache server status url.|

- metric list


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

## Log Collection {#logging}

To collect the Apache log, open  `files` in apache.conf and write to the absolute path of the Apache log file. For example:

```toml
[[inputs.apache]]
  ...
  [inputs.apache.log]
    files = [
      "/var/log/apache2/error.log",
      "/var/log/apache2/access.log"
    ]
```

When log collection is turned on, logs with `apache` log (`source`) will be generated by default.

<!-- markdownlint-disable MD046 -->
???+ attention

    DataKit must be installed on the host where Apache is located to collect Apache logs.
<!-- markdownlint-enable -->

## Log Pipeline Function Cut Field Description {#pipeline}

- Apache Error Log Cutting

Error Log Text Example

```log
[Tue May 19 18:39:45.272121 2021] [access_compat:error] [pid 9802] [client ::1:50547] AH01797: client denied by server configuration: /Library/WebServer/Documents/server-status
```

The list of cut fields is as follows:

| Field Name   | Field Value                | Description                         |
| ---      | ---                   | ---                          |
| `status` | `error`               | log level                     |
| `pid`    | `9802`                | process id                      |
| `type`   | `access_compat`       | log type                     |
| `time`   | `1621391985000000000` | nanosecond timestamp (as row protocol time) |

- Apache Access Log Cutting

Example of access log text:

```log
127.0.0.1 - - [17/May/2021:14:51:09 +0800] "GET /server-status?auto HTTP/1.1" 200 917
```

The list of cut fields is as follows:

| Field Name         | Field Value                | Description                         |
| ---            | ---                   | ---                          |
| `status`       | `info`                | log level                     |
| `ip_or_host`   | `127.0.0.1`           | requester ip or host             |
| `http_code`    | `200`                 | http status code             |
| `http_method`  | `GET`                 | http request type                |
| `http_url`     | `/`                   | http request url                 |
| `http_version` | `1.1`                 | http version                 |
| `time`         | `1621205469000000000` | nanosecond timestamp (as row protocol time) |
