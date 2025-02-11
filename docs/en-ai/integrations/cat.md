---
title: 'Dianping CAT'
summary: 'A performance, capacity, and business metrics monitoring system developed by Meituan Dianping'
__int_icon: 'icon/cat'
tags:
  - 'Trace Analysis'
dashboard:
  - desc: 'CAT Monitoring View'
    path: 'dashboard/en/cat'
monitor:
  - desc: 'Not Available'
    path: '-'
---

[:octicons-tag-24: Version-1.9.0](../datakit/changelog.md#cl-1.9.0) ·
[:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:


---

[Dianping-cat](https://github.com/dianping/cat){:target="_blank"}, abbreviated as CAT, is an open-source distributed real-time monitoring system primarily used for monitoring system performance, capacity, and business metrics. It was developed by Meituan Dianping and has been widely adopted since its open-sourcing.

CAT collects various metrics data from the system, such as CPU, memory, network, disk, etc., to perform real-time monitoring and analysis, helping developers quickly locate and resolve system issues. Additionally, it provides some common monitoring features like alerts, statistics, log analysis, etc., making it convenient for developers to monitor and analyze the system.

## Data Types {#data}

Data transmission protocols:

- plaintext: Plain text mode, currently not supported by DataKit.
- native: Text format with specific delimiters, currently supported by DataKit.

Data classification:

| Abbreviation | Type               | Description      | Supported by Current DataKit Version | Corresponding Guance Data Type |
| ------------ | ------------------ | ---------------- | ------------------------------------ | ------------------------------- |
| t            | transaction start  | Transaction start | true                                 | trace                           |
| T            | transaction end    | Transaction end   | true                                 | trace                           |
| E            | event              | Event            | false                                | -                               |
| M            | metric             | Custom metric    | false                                | -                               |
| L            | trace              | Trace            | false                                | -                               |
| H            | heartbeat          | Heartbeat        | true                                 | Metrics                         |


## Client Startup Modes {#cat-start}

- Starting CAT server mode

    - All data resides in DataKit; CAT's web interface no longer displays any data, so starting it is not meaningful and will result in errors on the page: **CAT service [xxx.xxx] has encountered a problem**.
    - Configuration of client behavior can be done during client startup.
    - The CAT server also sends transaction data to DK, causing a large amount of junk data to appear on the Guance page.

- Not starting CAT server: Configure in DataKit

    - `startTransactionTypes`: Defines custom transaction types that CAT automatically creates. Multiple types are separated by semicolons.
    - `block`: Specifies a threshold for blocking monitoring in milliseconds. When a transaction's execution time exceeds this threshold, CAT logs the blocking situation.
    - `routers`: Specifies the addresses and ports of CAT servers, separated by semicolons. CAT automatically sends data to these servers for reliability and disaster recovery.
    - `sample`: Specifies the sampling rate, i.e., only a portion of the data is sent to the CAT server. Values range from 0 to 1, where 1 means all data is sent, and 0 means no data is sent.
    - `matchTransactionTypes`: Defines matching rules for custom transaction types, typically used for API service monitoring to specify which interfaces need performance monitoring.


Therefore, it is not recommended to start a `cat_home` (CAT server) service. Relevant configurations can be set in `client.xml`; see the following section.

## Configuration {#config}

### Client Configuration {#client-config}

```xml
<?xml version="1.0" encoding="utf-8"?>
<config mode="client">
    <servers>
        <!-- datakit ip, cat port , http port -->
        <server ip="10.200.6.16" port="2280" http-port="9529"/>
    </servers>
</config>
```

> Note: Port 9529 in the configuration is DataKit's HTTP port. Port 2280 is the CAT collector's port.

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/cat` directory under the DataKit installation directory, copy `cat.conf.sample`, and rename it to `cat.conf`. Example:
    
    ```toml
        
    [[inputs.cat]]
      ## tcp port
      tcp_port = "2280"
    
      ##native or plaintext, datakit only supports native(NT1)!!!
      decode = "native"
    
      ## Default cat-client Kvs configs.
      startTransactionTypes = "Cache.;Squirrel."
      MatchTransactionTypes = "SQL"
      block = "false"
      routers = "127.0.0.1:2280;"
      sample = "1.0"
    
      ## global tags.
      # [inputs.cat.tags]
        # key1 = "value1"
        # key2 = "value2"
        # ...
    
    
    ```

    After configuring, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the configuration via [ConfigMap](datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

---

Configuration file notes:

1. `startTransactionTypes` `MatchTransactionTypes` `block` `routers` `sample` are data returned to the client.
2. `routers` should be DataKit's IP or domain name.
3. `tcp_port` corresponds to the server IP address configured in the client.

---

## Guance Traces and Metrics {#trace-metric}

### Guance Traces {#guance-trace}

Log in to Guance, click APM -> Traces to view trace details.

<!-- markdownlint-disable MD033 -->
<figure>
  <img src="https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/songlongqi/cat/cat-gateway.png" style="height: 500px" alt="Trace Details Page">
  <figcaption> Trace Details Page </figcaption>
</figure>

### Guance Metrics {#guance-metric}

First, [download the dashboard](https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/songlongqi/cat/DianPing-Cat%20Monitoring%20View.json){:target="_blank"}

In Guance, click Scenarios -> Dashboards -> Create Dashboard. Import the downloaded JSON file.

Effect display:

<!-- markdownlint-disable MD046 MD033 -->
<figure>
  <img src="https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/songlongqi/cat/metric.png" style="height: 500px" alt="CAT Monitoring View">
  <figcaption> CAT Monitoring View </figcaption>
</figure>

## Data Field Explanation {#fields}

### Metric Types {metric}

- Metric tags

| Tag           | Description                  |
| ------------- | ---------------------------- |
| `domain`      | IP address.                  |
| `hostName`    | Host name.                   |
| `os_arch`     | CPU architecture: AMD/ARM.   |
| `os_name`     | OS name: 'Windows/Linux/Mac'.|
| `os_version`  | OS kernel version.           |
| `runtime_java-version` | Java version.       |
| `runtime_user-dir` | Path of jar.            |
| `runtime_user-name` | User name.             |

- Metric list

| Metric                | Description                       | Type | Unit |
| --------------------- | --------------------------------- | ---- | ---- |
| `disk_free`           | Free disk size.                   | float | B    |
| `disk_total`          | Total disk size of data nodes.    | float | B    |
| `disk_usable`         | Used disk size.                   | float | B    |
| `memory_free`         | Free memory size.                 | float | count|
| `memory_heap-usage`   | Heap memory usage.                | float | count|
| `memory_max`          | Max memory usage.                 | float | count|
| `memory_non-heap-usage` | Non-heap memory usage.         | float | count|
| `memory_total`        | Total memory size.                | float | count|
| `os_available-processors` | Number of available processors.| float | count|
| `os_committed-virtual-memory` | Committed virtual memory. | float | B    |
| `os_free-physical-memory` | Free physical memory.         | float | B    |
| `os_free-swap-space`  | Free swap space size.             | float | B    |
| `os_system-load-average` | Average system load.           | float | percent|
| `os_total-physical-memory` | Total physical memory.       | float | B    |
| `os_total-swap-space` | Total swap space size.            | float | B    |
| `runtime_start-time`  | Start time.                       | int   | s    |
| `runtime_up-time`     | Runtime.                          | int   | ms   |
| `thread_cat_thread_count` | Number of threads used by CAT.| float | count|
| `thread_count`        | Total number of threads.          | float | count|
| `thread_daemon_count` | Number of daemon threads.         | float | count|
| `thread_http_thread_count` | Number of HTTP threads.       | float | count|
| `thread_peek_count`   | Thread peek.                      | float | count|
| `thread_pigeon_thread_count` | Number of pigeon threads.   | float | count|
| `thread_total_started_count` | Total started threads.      | float | count|

### Tracing Fields {tracing}

- Tags (String type)

| Tag            | Description                        |
| -------------- | ---------------------------------- |
| `container_host` | Container hostname. Optional.    |
| `dk_fingerprint` | DataKit fingerprint is DataKit hostname |
| `endpoint`      | Endpoint info. Optional.          |
| `env`           | Application environment info. Optional. |
| `host`          | Hostname.                         |
| `http_method`   | HTTP request method name. Optional. |
| `http_route`    | HTTP route. Optional.             |
| `http_status_code` | HTTP response code. Optional.   |
| `http_url`      | HTTP URL. Optional.               |
| `operation`     | Span name                         |
| `project`       | Project name. Optional.           |
| `service`       | Service name. Optional.           |
| `source_type`   | Tracing source type               |
| `span_type`     | Span type                         |
| `status`        | Span status                       |
| `version`       | Application version info. Optional. |

- Metrics (Non-string types or long strings)

| Metric         | Description                     | Type | Unit |
| -------------- | ------------------------------- | ---- | ---- |
| `duration`     | Duration of span                | int  | μs   |
| `message`      | Origin content of span          | string | -    |
| `parent_id`    | Parent span ID of current span  | string | -    |
| `resource`     | Resource name producing current span | string | -    |
| `span_id`      | Span id                         | string | -    |
| `start`        | Start time of span              | int   | usec |
| `trace_id`     | Trace id                        | string | -    |