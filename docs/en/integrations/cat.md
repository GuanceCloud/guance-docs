---
title      : 'Dianping CAT'
summary    : 'Meituan Dianping’s performance, capacity, and business Metrics monitoring system'
__int_icon : 'icon/cat'
tags       :
  - 'APM'
dashboard :
  - desc  : 'Cat Monitoring View'
    path  : 'dashboard/en/cat'
monitor   :
  - desc  : 'Not Available'
    path  : '-'
---

[:octicons-tag-24: Version-1.9.0](../datakit/changelog.md#cl-1.9.0) ·
[:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:


---

[Dianping-cat](https://github.com/dianping/cat){:target="_blank"} is briefly called Cat, an open-source distributed real-time monitoring system mainly used for monitoring system performance, capacity, and business Metrics. It is a monitoring system developed by Meituan Dianping, which has been open-sourced and widely applied.

Cat collects various system Metrics data such as CPU, memory, network, disk, etc., for real-time monitoring and analysis, helping developers quickly locate and resolve system issues. In addition, it provides some common monitoring functions such as alerts, statistics, log analysis, etc., making it convenient for developers to monitor and analyze the system.

## Data Types {#data}

Data transmission protocol:

- plaintext : Plain text mode, Datakit currently does not support it.
- native : Text format with specific symbols as delimiters, currently supported by Datakit.


Data classification:

| Data Type Abbreviation | Type                | Description        | Is Current Version of Datakit Integrated? | Corresponding Data Type in <<< custom_key.brand_name >>>     |
|--------|-------------------|:----------|:------------------:|:-----------------|
| t      | transaction start | Transaction Start      |        true        | trace            |
| T      | transaction end   | Transaction End      |        true        | trace            |
| E      | event             | Event        |       false        | -                |
| M      | metric            | Custom Metrics     |       false        | -                |
| L      | trace             | Trace        |       false        | -                |
| H      | heartbeat         | Heartbeat       |        true        | Measurements               |



## Client Startup Mode {#cat-start}

- Start cat server mode

    - All data is in Datakit, the web page of cat has no data, so starting it doesn't make much sense, and the page shows errors: **CAT service [xxx.xxx] encountered an issue**
    - Configure client behavior during startup
    - The cat server will also send transaction data to dk, causing a large amount of garbage data on the <<< custom_key.brand_name >>> page


- Do not start cat server: Configure in Datakit

    - `startTransactionTypes`: Used to define custom transaction types; specified transaction types will be automatically created by Cat. Multiple transaction types are separated by semicolons.
    - `block`: Specifies a threshold for blocking monitoring in milliseconds. When the execution time of a transaction exceeds this threshold, Cat will record the blocking situation of that transaction.
    - `routers`: Specifies the address and port number of the Cat server. Multiple server addresses and port numbers are separated by semicolons. Cat will automatically send data to these servers to ensure data reliability and disaster recovery.
    - `sample`: Specifies the sampling rate, i.e., only part of the data will be sent to the Cat server. The value ranges from 0 to 1, where 1 means all data will be sent to the Cat server, and 0 means no data will be sent.
    - `matchTransactionTypes`: Defines matching rules for custom transaction types, typically used in API service monitoring to specify which interfaces' performance needs to be monitored.


Therefore: It is not recommended to start a cat_home (cat server) service. Relevant configurations can be done in client.xml, see below.

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

> Note: The 9529 port in the configuration is the http port of Datakit. 2280 is the port opened by the cat collector.

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Enter the `conf.d/cat` directory under the DataKit installation directory, copy `cat.conf.sample` and rename it to `cat.conf`. Example:
    
    ```toml
        
    [[inputs.cat]]
      ## tcp port
      tcp_port = "2280"
    
      ##native or plaintext, datakit only supports native(NT1) !!!
      decode = "native"
    
      ## This is default cat-client Kvs configs.
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

    Currently, you can enable the collector via [ConfigMap injection](datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

---

Notes for the configuration file:

1. `startTransactionTypes` `MatchTransactionTypes` `block` `routers` `sample` are data returned to the client side.
1. `routers` is the IP or domain name of Datakit.
1. `tcp_port` corresponds to the server IP address configured on the client side.

---

## <<< custom_key.brand_name >>> Tracing and Measurements {#trace-metric}

### <<< custom_key.brand_name >>> Tracing {#guance-trace}

Log in to <<< custom_key.brand_name >>>, click APM -> Trace to view trace details.

<!-- markdownlint-disable MD033 -->
<figure>
  <img src="https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/songlongqi/cat/cat-gateway.png" style="height: 500px" alt="Trace Details Page">
  <figcaption> Trace Details Page </figcaption>
</figure>


[//]: # (<img src="https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/songlongqi/cat/cat-gateway.png" height="500">  )

### <<< custom_key.brand_name >>> Measurements {#guance-metric}

First [download the dashboard](https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/songlongqi/cat/DianPing-Cat%20Monitoring%20View.json){:target="_blank"}

In <<< custom_key.brand_name >>>, click Use Cases -> Dashboard -> Create Dashboard. Import the downloaded JSON file.

Display Effect:

<!-- markdownlint-disable MD046 MD033 -->
<figure >
  <img src="https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/songlongqi/cat/metric.png" style="height: 500px" alt="Cat Monitoring View">
  <figcaption> Cat Monitoring View </figcaption>
</figure>

## Data Field Explanation {#fields}





### Measurement Types {#metric}



- Tags for Measurements


| Tag | Description |
|  ----  | --------|
|`domain`|IP address.|
|`hostName`|Host name.|
|`os_arch`|CPU architecture:AMD/ARM.|
|`os_name`|OS name:'Windows/Linux/Mac',etc.|
|`os_version`|The kernel version of the OS.|
|`runtime_java-version`|Java version.|
|`runtime_user-dir`|The path of jar.|
|`runtime_user-name`|User name.|

- List of Measurements


| Measurement | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`disk_free`|Free disk size.|float|B|
|`disk_total`|Total disk size of data nodes.|float|B|
|`disk_usable`|Used disk size.|float|B|
|`memory_free`|Free memory size.|float|count|
|`memory_heap-usage`|The usage of heap memory.|float|count|
|`memory_max`|Max memory usage.|float|count|
|`memory_non-heap-usage`|The usage of non heap memory.|float|count|
|`memory_total`|Total memory size.|float|count|
|`os_available-processors`|The number of available processors in the host.|float|count|
|`os_committed-virtual-memory`|Committed virtual memory size.|float|B|
|`os_free-physical-memory`|Free physical memory size.|float|B|
|`os_free-swap-space`|Free swap space size|float|B|
|`os_system-load-average`|Average system load.|float|percent|
|`os_total-physical-memory`|Total physical memory size.|float|B|
|`os_total-swap-space`|Total swap space size.|float|B|
|`runtime_start-time`|Start time.|int|s|
|`runtime_up-time`|Runtime.|int|ms|
|`thread_cat_thread_count`|The number of threads used by cat.|float|count|
|`thread_count`|Total number of threads.|float|count|
|`thread_daemon_count`|The number of daemon threads.|float|count|
|`thread_http_thread_count`|The number of http threads.|float|count|
|`thread_peek_count`|Thread peek.|float|count|
|`thread_pigeon_thread_count`|The number of pigeon threads.|float|count|
|`thread_total_started_count`|Total number of started threads.|float|count|






### Tracing Field Explanation {#tracing}



- Tags (String type)


| Tag | Description |
|  ----  | --------|
|`base_service`|Span Base service name|
|`container_host`|Container hostname. Available in OpenTelemetry. Optional.|
|`dk_fingerprint`|DataKit fingerprint is DataKit hostname|
|`endpoint`|Endpoint info. Available in SkyWalking, Zipkin. Optional.|
|`env`|Application environment info. Available in Jaeger. Optional.|
|`host`|Hostname.|
|`http_method`|HTTP request method name. Available in DDTrace, OpenTelemetry. Optional.|
|`http_route`|HTTP route. Optional.|
|`http_status_code`|HTTP response code. Available in DDTrace, OpenTelemetry. Optional.|
|`http_url`|HTTP URL. Optional.|
|`operation`|Span name|
|`project`|Project name. Available in Jaeger. Optional.|
|`service`|Service name. Optional.|
|`source_type`|Tracing source type|
|`span_type`|Span type|
|`status`|Span status|
|`version`|Application version info. Available in Jaeger. Optional.|

- Measurement list (non-String type, or long String type)


| Measurement | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`duration`|Duration of span|int|μs|
|`message`|Origin content of span|string|-|
|`parent_id`|Parent span ID of current span|string|-|
|`resource`|Resource name produce current span|string|-|
|`span_id`|Span id|string|-|
|`start`|start time of span.|int|usec|
|`trace_id`|Trace id|string|-|