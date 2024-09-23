---
title      : '点评 CAT'
summary    : '美团点评的性能、容量和业务指标监控系统'
__int_icon : 'icon/cat'
tags       :
  - '链路追踪'
dashboard :
  - desc  : 'Cat 监控视图'
    path  : 'dashboard/zh/cat'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

[:octicons-tag-24: Version-1.9.0](../datakit/changelog.md#cl-1.9.0) ·
[:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:


---

[Dianping-cat](https://github.com/dianping/cat){:target="_blank"}  简称 Cat， 是一个开源的分布式实时监控系统，主要用于监控系统的性能、容量和业务指标等。它是美团点评公司研发的一款监控系统，目前已经开源并得到了广泛的应用。

Cat 通过采集系统的各种指标数据，如 CPU、内存、网络、磁盘等，进行实时监控和分析，帮助开发人员快速定位和解决系统问题。同时，它还提供了一些常用的监控功能，如告警、统计、日志分析等，方便开发人员进行系统监控和分析。

## 数据类型 {#data}

数据传输协议：

- plaintext : 纯文本模式， Datakit 目前暂时不支持。
- native ： 以特定符号为分隔符的文本形式，目前 Datakit 已经支持。


数据分类：

| 数据类型简写 | 类型                | 说明        | 当前版本的 Datakit 是否接入 | 对应到观测云中的数据类型     |
|--------|-------------------|:----------|:------------------:|:-----------------|
| t      | transaction start | 事务开始      |        true        | trace            |
| T      | transaction end   | 事务结束      |        true        | trace            |
| E      | event             | 事件        |       false        | -                |
| M      | metric            | 自定义指标     |       false        | -                |
| L      | trace             | 链路        |       false        | -                |
| H      | heartbeat         | 心跳包       |        true        | 指标               |




## 客户端的启动模式 {#cat-start}

- 启动 cat server 模式

    - 数据全在 Datakit 中，cat 的 web 页面已经没有数据，所以启动的意义不大，并且页面报错： **出问题 CAT 的服务端[xxx.xxx]**
    - 配置客户端行为可以在 client 的启动中做
    - cat server 也会将 transaction 数据发送到 dk，造成观测云页面大量的垃圾数据


- 不启动 cat server： 在 Datakit 中配置

    - `startTransactionTypes`：用于定义自定义事务类型，指定的事务类型会被 Cat 自动创建。多个事务类型之间使用分号进行分隔。
    - `block`：指定一个阈值用于阻塞监控，单位为毫秒。当某个事务的执行时间大于该阈值时，会触发 Cat 记录该事务的阻塞情况。
    - `routers`：指定 Cat 服务端的地址和端口号，多个服务器地址和端口号之间使用分号进行分隔。Cat 会自动将数据发送到这些服务器上，以保证数据的可靠性和容灾性。
    - `sample`：指定采样率，即只有一部分数据会被发送到 Cat 服务器。取值范围为 0 到 1，其中 1 表示全部数据都会被发送到 Cat 服务器，0 表示不发送任何数据。
    - `matchTransactionTypes`：用于定义自定义事务类型的匹配规则，通常用于 Api 服务监控中，指定需要监控哪些接口的性能。


所以： 不建议去开启一个 cat_home（cat server） 服务。相应的配置可以在 client.xml 中配置，请看下文。

## 配置 {#config}

### 客户端配置 {#client-config}

```xml
<?xml version="1.0" encoding="utf-8"?>
<config mode="client">
    <servers>
        <!-- datakit ip, cat port , http port -->
        <server ip="10.200.6.16" port="2280" http-port="9529"/>
    </servers>
</config>
```

> 注意：配置中的 9529 端口是 Datakit 的 http 端口。2280 是 cat 采集器开通的 2280 端口。

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/cat` 目录，复制 `cat.conf.sample` 并命名为 `cat.conf`。示例如下：
    
    ```toml
        
    [[inputs.cat]]
      ## tcp port
      tcp_port = "2280"
    
      ##native or plaintext, datakit only support native(NT1) !!!
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

    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

---

配置文件注意的地方：

1. `startTransactionTypes` `MatchTransactionTypes` `block` `routers` `sample` 是返回给 client 端的数据
1. `routers` 是 Datakit 的 ip 或者域名
1. `tcp_port` 对应的是 client 端配置 servers ip 地址

---

## 观测云链路和指标 {#trace-metric}

### 观测云链路 {#guance-trace}

登录观测云，点击 应用性能检测 -> 链路 查看链路详情。

<!-- markdownlint-disable MD033 -->
<figure>
  <img src="https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/songlongqi/cat/cat-gateway.png" style="height: 500px" alt="链路详情页面">
  <figcaption> 链路详情页面 </figcaption>
</figure>


[//]: # (<img src="https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/songlongqi/cat/cat-gateway.png" height="500">  )

### 观测云指标 {#guance-metric}

先[下载仪表板](https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/songlongqi/cat/DianPing-Cat%20%E7%9B%91%E6%8E%A7%E8%A7%86%E5%9B%BE.json){:target="_blank"}

在观测云，点击 场景 -> 仪表板 -> 新建仪表板。 导入下载好的 JSON 文件即可。

效果展示：

<!-- markdownlint-disable MD046 MD033 -->
<figure >
  <img src="https://df-storage-dev.oss-cn-hangzhou.aliyuncs.com/songlongqi/cat/metric.png" style="height: 500px" alt="cat 监控视图">
  <figcaption> cat 监控视图 </figcaption>
</figure>


## 数据字段说明 {#fields}







### 指标类型 {metric}



- 指标的标签


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

- 指标列表


| Metric | Description | Type | Unit |
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






### 链路字段说明 {tracing}



- 标签（String 类型）


| Tag | Description |
|  ----  | --------|
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

- 指标列表（非 String 类型，或者长 String 类型）


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`duration`|Duration of span|int|μs|
|`message`|Origin content of span|string|-|
|`parent_id`|Parent span ID of current span|string|-|
|`resource`|Resource name produce current span|string|-|
|`span_id`|Span id|string|-|
|`start`|start time of span.|int|usec|
|`trace_id`|Trace id|string|-|





