---
title     : 'Apache'
summary   : 'The Apache collector can gather request counts, connection counts, and more from Apache services.'
tags:
  - 'MIDDLEWARE'
  - 'WEB SERVER'
__int_icon      : 'icon/apache'
dashboard :
  - desc  : 'Apache'
    path  : 'dashboard/en/apache'
monitor   :
  - desc  : 'Apache'
    path  : 'monitor/en/apache'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The Apache collector gathers request counts, connection counts, and other data from Apache services, sending metrics to <<< custom_key.brand_name >>> for monitoring and analysis of various Apache anomalies.

## Configuration {#config}

### Prerequisites {#requirements}

- Apache version >= `2.4.6 (Unix)`. Tested versions:
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

- Enable Apache `mod_status`, by adding the following in the Apache configuration file:

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
=== "HOST Installation"

    Navigate to the `conf.d/apache` directory under the DataKit installation directory, copy `apache.conf.sample` and rename it to `apache.conf`. Example as follows:
    
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

    Currently, you can enable the collector by injecting its configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Measurement {#metric}

All the collected data will append global election tags by default. You can also specify additional tags through `[inputs.apache.tags]` in the configuration:

``` toml
 [inputs.apache.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `apache` {#apache}

The collected Metrics are influenced by the environment where Apache is installed. The metrics shown on the `http://<your-apache-server>/server-status?auto` page will prevail.

- Tags


| Tag | Description |
|  ----  | --------|
|`host`|Hostname.|
|`server_mpm`|Apache server Multi-Processing Module, `prefork`, `worker` and `event`. Optional.|
|`server_version`|Apache server version. Optional.|
|`url`|Apache server status url.|

- Metrics List


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



- Tags


| Tag | Description |
|  ----  | --------|
|`col_co_status`|Current status of collector on Apache(`OK/NotOK`)|
|`host`|The server host address|
|`ip`|Connection IP of the Apache|
|`name`|Object uniq ID|
|`reason`|If status not ok, we'll get some reasons about the status|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`display_name`|Displayed name in UI|string|-|
|`uptime`|Current Apache uptime|int|s|
|`version`|Current version of Apache|string|-|



## Custom Objects {#object}





### `web_server`



- Tags


| Tag | Description |
|  ----  | --------|
|`col_co_status`|Current status of collector on Apache(`OK/NotOK`)|
|`host`|The server host address|
|`ip`|Connection IP of the Apache|
|`name`|Object uniq ID|
|`reason`|If status not ok, we'll get some reasons about the status|

- Metrics List


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`display_name`|Displayed name in UI|string|-|
|`uptime`|Current Apache uptime|int|s|
|`version`|Current version of Apache|string|-|




## LOG Collection {#logging}

To collect Apache logs, open the `files` option in `apache.conf` and input the absolute path of the Apache log files. For example:

```toml
[[inputs.apache]]
  ...
  [inputs.apache.log]
    files = [
      "/var/log/apache2/error.log",
      "/var/log/apache2/access.log"
    ]
```

After enabling log collection, logs with source (`source`) set to `apache` will be generated by default.

<!-- markdownlint-disable MD046 -->
???+ attention

    DataKit must be installed on the HOST where Apache is located to collect Apache logs.
<!-- markdownlint-enable -->

### Pipeline Field Explanation {#pipeline}

- Apache Error Log Parsing

Error log text example:

``` log
[Tue May 19 18:39:45.272121 2021] [access_compat:error] [pid 9802] [client ::1:50547] AH01797: client denied by server configuration: /Library/WebServer/Documents/server-status
```

Parsed field list:

| Field Name   | Field Value                | Description                         |
| ---          | ---                        | ---                                 |
| `status`     | `error`                    | Log level                           |
| `pid`        | `9802`                     | Process id                          |
| `type`       | `access_compat`            | Log type                            |
| `time`       | `1621391985000000000`      | Nanosecond timestamp (as line protocol time) |

- Apache Access Log Parsing

Access log text example:

``` log
127.0.0.1 - - [17/May/2021:14:51:09 +0800] "GET /server-status?auto HTTP/1.1" 200 917
```

Parsed field list:

| Field Name         | Field Value                | Description                         |
| ---               | ---                        | ---                                 |
| `status`          | `info`                     | Log level                           |
| `ip_or_host`      | `127.0.0.1`                | Requesting IP or host               |
| `http_code`       | `200`                      | HTTP status code                    |
| `http_method`     | `GET`                      | HTTP request type                   |
| `http_url`        | `/`                        | HTTP request URL                    |
| `http_version`    | `1.1`                      | HTTP version                        |
| `time`            | `1621205469000000000`      | Nanosecond timestamp (as line protocol time) |