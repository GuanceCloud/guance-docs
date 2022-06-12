
# JVM

- DataKit 版本：1.4.0
- 文档发布日期：2022-06-12 10:58:47
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

这里我们提供俩类 JVM 指标采集方式，一种方案是 Jolokia，一种是 ddtrace。如何选择的方式，我们有如下建议：

- 如果采集诸如 Kafka 等 java 开发的中间件 JVM 指标，我们推荐 Jolokia 方案。 ddtrace 偏重于链路追踪（APM），且有一定的运行开销，对于中间件而言，链路追踪意义不大。
- 如果采集自己开发的 java 应用 JVM 指标，我们推荐 ddtrace 方案，除了能采集 JVM 指标外，还能实现链路追踪（APM）数据采集

## 通过 ddtrace 采集 JVM 指标

DataKit 内置了 [statsd 采集器](statsd)，用于接收网络上发送过来的 statsd 协议的数据。此处我们利用 ddtrace 来采集 JVM 的指标数据，并通过 statsd 协议发送给 DataKit。

### 准备 statsd 配置

这里推荐使用如下的 statsd 配置来采集 ddtrace JVM 指标。将其拷贝到 `conf.d/statsd` 目录下，并命名为 `ddtrace-jvm-statsd.conf`：

```toml
[[inputs.statsd]]
  protocol = "udp"

  ## Address and port to host UDP listener on
  service_address = ":8125"

  ## separator to use between elements of a statsd metric
  metric_separator = "_"

  drop_tags = ["runtime-id"]
  metric_mapping = [
    "jvm_:jvm",
    "datadog_tracer_:ddtrace",
  ]

  # 以下配置无需关注...

  delete_gauges = true
  delete_counters = true
  delete_sets = true
  delete_timings = true

  ## Percentiles to calculate for timing & histogram stats
  percentiles = [50.0, 90.0, 99.0, 99.9, 99.95, 100.0]

  ## Parses tags in the datadog statsd format
  ## http://docs.datadoghq.com/guides/dogstatsd/
  parse_data_dog_tags = true

  ## Parses datadog extensions to the statsd format
  datadog_extensions = true

  ## Parses distributions metric as specified in the datadog statsd format
  ## https://docs.datadoghq.com/developers/metrics/types/?tab=distribution#definition
  datadog_distributions = true

  ## Number of UDP messages allowed to queue up, once filled,
  ## the statsd server will start dropping packets
  allowed_pending_messages = 10000

  ## Number of timing/histogram values to track per-measurement in the
  ## calculation of percentiles. Raising this limit increases the accuracy
  ## of percentiles but also increases the memory usage and cpu time.
  percentile_limit = 1000

  ## Max duration (TTL) for each metric to stay cached/reported without being updated.
  #max_ttl = "1000h"

  [inputs.statsd.tags]
  # some_tag = "your-tag-value" 
  # some_other_tag = "your-other-tag-value"
```

关于这里的配置说明：

- `service_address` 此处设置成 `:8125`，指 ddtrace 将 jvm 指标发送出来的目标地址
- `drop_tags` 此处我们将 `runtime-id` 丢弃，因为其可能导致时间线爆炸。如确实需要该字段，将其从 `drop_tags` 中移除即可
- `metric_mapping` 在 ddtrace 发送出来的原始数据中，有俩类指标，它们的指标名称分别以 `jvm_` 和 `datadog_tracer_` 开头，故我们将它们统一规约到俩类指标集中，一个是 `jvm`，一个是 `ddtrace` 自身运行指标

### 启动 java 应用

一种可行的 JVM 部署方式如下：

```shell
java -javaagent:dd-java-agent.jar \
	-Ddd.profiling.enabled=true \
	-Ddd.logs.injection=true \
	-Ddd.trace.sample.rate=1 \
	-Ddd.service=my-app \
	-Ddd.env=staging \
	-Ddd.agent.host=localhost \
	-Ddd.agent.port=9529 \
	-Ddd.jmxfetch.enabled=true \
	-Ddd.jmxfetch.check-period=1000 \
	-Ddd.jmxfetch.statsd.host=127.0.0.1  \
	-Ddd.jmxfetch.statsd.port=8125 \
	-Ddd.version=1.0 \
	-jar your-app.jar
```

注意：

- 关于 `dd-jave-agent.jar` 包的下载，参见 [这里](ddtrace)
- 建议给如下几个字段命名：
	- `service` 用于表示该 JVM 数据来自哪个应用
	- `env` 用于表示该 JVM 数据来自某个应用的哪个环境（如 prod/testing/preprod 等）

- 此处几个选项的意义：
	- `-Ddd.jmxfetch.check-period` 表示采集频率，单位为毫秒
	- `-Ddd.jmxfetch.statsd.host=127.0.0.1` 表示 DataKit 上 statsd 采集器的连接地址
	- `-Ddd.jmxfetch.statsd.port=8125` 表示 DataKit 上 statsd 采集器的 UDP 连接端口，默认为 8125
	- `-Ddd.trace.health.xxx` ddtrace 自身指标数据采集和发送设置
  - 如果要开启链路追踪（APM）可追加如下两个参数（DataKit HTTP 地址）
		- `-Ddd.agent.host=localhost`
		- `-Ddd.agent.port=9529`

开启后，大概能采集到如下指标：

- `buffer_pool_direct_capacity`
- `buffer_pool_direct_count`
- `buffer_pool_direct_used`
- `buffer_pool_mapped_capacity`
- `buffer_pool_mapped_count`
- `buffer_pool_mapped_used`
- `cpu_load_process`
- `cpu_load_system`
- `gc_eden_size`
- `gc_major_collection_count`
- `gc_major_collection_time`
- `gc_metaspace_size`
- `gc_minor_collection_count`
- `gc_minor_collection_time`
- `gc_old_gen_size`
- `gc_survivor_size`
- `heap_memory_committed`
- `heap_memory_init`
- `heap_memory_max`
- `heap_memory`
- `loaded_classes`
- `non_heap_memory_committed`
- `non_heap_memory_init`
- `non_heap_memory_max`
- `non_heap_memory`
- `os_open_file_descriptors`
- `thread_count`

其中每个指标有如下 tags （实际 tags 受 java 启动参数以及 statsd 配置影响）

- `env`
- `host`
- `instance`
- `jmx_domain`
- `metric_type`
- `name`
- `service`
- `type`
- `version`

## 通过 Jolokia 采集 JVM 指标

JVM 采集器可以通过 JMX 来采取很多指标，并将指标采集到观测云，帮助分析 Java 运行情况。

## 前置条件

安装或下载 [Jolokia](https://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-jvm/1.6.2/jolokia-jvm-1.6.2-agent.jar)。DataKit 安装目录下的 `data` 目录中已经有下载好的 Jolokia jar 包。通过如下方式开启 Java 应用： 

```shell
java -javaagent:/path/to/jolokia-jvm-agent.jar=port=8080,host=localhost -jar your_app.jar
```

## 配置

进入 DataKit 安装目录下的 `conf.d/jvm` 目录，复制 `jvm.conf.sample` 并命名为 `jvm.conf`。示例如下：

```toml
[[inputs.jvm]]
  # default_tag_prefix      = ""
  # default_field_prefix    = ""
  # default_field_separator = "."

  # username = ""
  # password = ""
  # response_timeout = "5s"

  ## Optional TLS config
  # tls_ca   = "/var/private/ca.pem"
  # tls_cert = "/var/private/client.pem"
  # tls_key  = "/var/private/client-key.pem"
  # insecure_skip_verify = false

  ## Monitor Intreval
  # interval   = "60s"

  # Add agents URLs to query
  urls = ["http://localhost:8080/jolokia"]

  ## Add metrics to read
  [[inputs.jvm.metric]]
    name  = "java_runtime"
    mbean = "java.lang:type=Runtime"
    paths = ["Uptime"]

  [[inputs.jvm.metric]]
    name  = "java_memory"
    mbean = "java.lang:type=Memory"
    paths = ["HeapMemoryUsage", "NonHeapMemoryUsage", "ObjectPendingFinalizationCount"]

  [[inputs.jvm.metric]]
    name     = "java_garbage_collector"
    mbean    = "java.lang:name=*,type=GarbageCollector"
    paths    = ["CollectionTime", "CollectionCount"]
    tag_keys = ["name"]

  [[inputs.jvm.metric]]
    name  = "java_threading"
    mbean = "java.lang:type=Threading"
    paths = ["TotalStartedThreadCount", "ThreadCount", "DaemonThreadCount", "PeakThreadCount"]

  [[inputs.jvm.metric]]
    name  = "java_class_loading"
    mbean = "java.lang:type=ClassLoading"
    paths = ["LoadedClassCount", "UnloadedClassCount", "TotalLoadedClassCount"]

  [[inputs.jvm.metric]]
    name     = "java_memory_pool"
    mbean    = "java.lang:name=*,type=MemoryPool"
    paths    = ["Usage", "PeakUsage", "CollectionUsage"]
    tag_keys = ["name"]

  [inputs.jvm.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

配置好后，重启 DataKit 即可。

## 指标集

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.jvm.tags]` 指定其它标签：

``` toml
 [inputs.jvm.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `java_runtime`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`jolokia_agent_url`|jolokia agent url path|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`Uptime`|The total runtime.|int|ms|



### `java_memory`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`jolokia_agent_url`|jolokia agent url path|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`HeapMemoryUsagecommitted`|The total Java heap memory committed to be used.|int|B|
|`HeapMemoryUsageinit`|The initial Java heap memory allocated.|int|B|
|`HeapMemoryUsagemax`|The maximum Java heap memory available.|int|B|
|`HeapMemoryUsageused`|The total Java heap memory used.|int|B|
|`NonHeapMemoryUsagecommitted`|The total Java non-heap memory committed to be used.|int|B|
|`NonHeapMemoryUsageinit`|The initial Java non-heap memory allocated.|int|B|
|`NonHeapMemoryUsagemax`|The maximum Java non-heap memory available.|int|B|
|`NonHeapMemoryUsageused`|The total Java non-heap memory used.|int|B|
|`ObjectPendingFinalizationCount`|The count of object pending finalization.|int|count|



### `java_garbage_collector`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`jolokia_agent_url`|jolokia agent url path|
|`name`|the name of GC generation|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`CollectionCount`|The number of GC that have occurred.|int|count|
|`CollectionTime`|The approximate GC collection time elapsed.|int|B|



### `java_threading`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`jolokia_agent_url`|jolokia agent url path|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`DaemonThreadCount`|The count of daemon thread.|int|count|
|`PeakThreadCount`|The peak count of thread.|int|count|
|`ThreadCount`|The count of thread.|int|count|
|`TotalStartedThreadCount`|The total count of started thread.|int|count|



### `java_class_loading`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`jolokia_agent_url`|jolokia agent url path|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`LoadedClassCount`|The count of loaded class.|int|count|
|`TotalLoadedClassCount`|The total count of loaded class.|int|count|
|`UnloadedClassCount`|The count of unloaded class.|int|count|



### `java_memory_pool`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`jolokia_agent_url`|jolokia agent url path|
|`name`|the name of space|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`PeakUsagecommitted`|The total peak Java memory pool committed to be used|int|B|
|`PeakUsageinit`|The initial peak Java memory pool allocated|int|B|
|`PeakUsagemax`|The maximum peak Java  memory pool available.|int|B|
|`PeakUsageused`|The total peak Java memory pool used.|int|B|
|`Usagecommitted`|The total Java memory pool committed to be used|int|B|
|`Usageinit`|The initial Java memory pool allocated|int|B|
|`Usagemax`|The maximum Java  memory pool available.|int|B|
|`Usageused`|The total Java memory pool used.|int|B|



## 延伸阅读

- [DDTrace Java 示例](ddtrace-java)
- [SkyWalking](skywalking)
- [Opentelemetry Java 示例](opentelemetry-java)
