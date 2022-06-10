
# Flink

- DataKit 版本：1.4.0
- 文档发布日期：2022-06-10 10:51:49
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

Flink 采集器可以从 Flink 实例中采取很多指标，比如 Flink 服务器状态和网络的状态等多种指标，并将指标采集到 DataFlux ，帮助你监控分析 Flink 各种异常情况。

下面以版本 1.14 为例。

## 前置条件

目前 Flink 官方提供两种 metrics 上报方式: [Prometheus](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/deployment/metric_reporters/#prometheus) 和 [PrometheusPushGateway](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/deployment/metric_reporters/#prometheuspushgateway)。

它们主要的区别是:
- PrometheusPushGateway 方式是把集群所有的 metrics 统一汇报给 pushgateway，所以需要额外安装 pushgateway
- Prometheus 方式需要集群每个节点暴露一个唯一端口，不需要额外安装其它软件，但需要 N 个可用端口，配置略微复杂

### PrometheusPushGateway 方式（推荐）

#### pushgateway 下载与启动

可以在 [Prometheuse 官方页面](https://prometheus.io/download/#pushgateway) 进行下载。

启动 pushgateway: `nohup ./pushgateway &`（此命令仅供参考，具体命令根据实际环境可能有所不同）

#### 配置 `flink-conf.yaml` 把 metrics 统一汇报给 pushgateway

配置 Flink 的配置文件 `conf/flink-conf.yaml` 示例:

```yml
metrics.reporter.promgateway.class: org.apache.flink.metrics.prometheus.PrometheusPushGatewayReporter # 固定这个值，不能改
metrics.reporter.promgateway.host: localhost # promgateway 的 IP 地址
metrics.reporter.promgateway.port: 9091 # promgateway 的监听端口
metrics.reporter.promgateway.interval: 15 SECONDS # 采集间隔
metrics.reporter.promgateway.groupingKey: k1=v1;k2=v2

# 以下是可选参数
# metrics.reporter.promgateway.jobName: myJob
# metrics.reporter.promgateway.randomJobNameSuffix: true
# metrics.reporter.promgateway.deleteOnShutdown: false
```

启动 Flink: `./bin/start-cluster.sh`（此命令仅供参考，具体命令根据实际环境可能有所不同）

### Prometheus 方式

#### 配置 `flink-conf.yaml` 暴露各个节点的 metrics

配置 Flink 的配置文件 `conf/flink-conf.yaml` 示例:

```yml
metrics.reporter.prom.class: org.apache.flink.metrics.prometheus.PrometheusReporter
metrics.reporter.prom.port: 9250-9260 # 各个节点的端口区间，根据节点数量有所不同，一个端口对应一个节点
```

启动 Flink: `./bin/start-cluster.sh`（此命令仅供参考，具体命令根据实际环境可能有所不同）

## 配置

进入 DataKit 安装目录下的 `conf.d/flink` 目录，复制如下示例并命名为 `flink.conf`。示例如下：

```toml

[[inputs.prom]]
  url = "http://<pushgateway-host>:9091/metrics"

  ## 采集器别名
  source = "flink"

  ## 指标类型过滤, 可选值为 counter, gauge, histogram, summary
  # 默认只采集 counter 和 gauge 类型的指标
  # 如果为空，则不进行过滤
  metric_types = ["counter", "gauge"]

  ## 指标名称过滤
  # 支持正则，可以配置多个，即满足其中之一即可
  # 如果为空，则不进行过滤
  # metric_name_filter = [""]

  ## 指标集名称前缀
  # 配置此项，可以给指标集名称添加前缀
  measurement_prefix = ""

  ## 指标集名称
  # 默认会将指标名称以下划线"_"进行切割，切割后的第一个字段作为指标集名称，剩下字段作为当前指标名称
  # 如果配置measurement_name, 则不进行指标名称的切割
  # 最终的指标集名称会添加上measurement_prefix前缀
  # measurement_name = "prom"

  ## 采集间隔 "ns", "us" (or "µs"), "ms", "s", "m", "h"
  interval = "10s"

  ## 过滤tags, 可配置多个tag
  # 匹配的tag将被忽略
  # tags_ignore = ["xxxx"]

  ## TLS 配置
  tls_open = false
  # tls_ca = "/tmp/ca.crt"
  # tls_cert = "/tmp/peer.crt"
  # tls_key = "/tmp/peer.key"

  ## 自定义指标集名称
  # 可以将包含前缀prefix的指标归为一类指标集
  # 自定义指标集名称配置优先measurement_name配置项
  [[inputs.prom.measurements]]
  prefix = "flink_jobmanager_"
  name = "flink_jobmanager"

  [[inputs.prom.measurements]]
  prefix = "flink_taskmanager_"
  name = "flink_taskmanager"

  ## 自定义认证方式，目前仅支持 Bearer Token
  # [inputs.prom.auth]
  # type = "bearer_token"
  # token = "xxxxxxxx"
  # token_file = "/tmp/token"

  ## 自定义Tags
  # some_tag = "some_value"
 
```

配置好后，重启 DataKit 即可。

## 指标集



### `Jobmanager`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`host`|host name|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`Status_JVM_CPU_Load`|The recent CPU usage of the JVM.|int|count|
|`Status_JVM_CPU_Time`|The CPU time used by the JVM.|int|count|
|`Status_JVM_ClassLoader_ClassesLoaded`|The total number of classes loaded since the start of the JVM.|int|count|
|`Status_JVM_ClassLoader_ClassesUnloaded`|The total number of classes unloaded since the start of the JVM.|int|count|
|`Status_JVM_GarbageCollector_Copy_Count`|The total number of collections that have occurred.|int|count|
|`Status_JVM_GarbageCollector_Copy_Time`|The total time spent performing garbage collection.|int|count|
|`Status_JVM_GarbageCollector_MarkSweepCompact_Count`|The total number of collections that have occurred.|int|count|
|`Status_JVM_GarbageCollector_MarkSweepCompact_Time`|The total time spent performing garbage collection.|int|count|
|`Status_JVM_Memory_Direct_Count`|The number of buffers in the direct buffer pool.|int|count|
|`Status_JVM_Memory_Direct_MemoryUsed`|The amount of memory used by the JVM for the direct buffer pool.|int|count|
|`Status_JVM_Memory_Direct_TotalCapacity`|The total capacity of all buffers in the direct buffer pool.|int|count|
|`Status_JVM_Memory_Heap_Committed`|The amount of heap memory guaranteed to be available to the JVM.|int|count|
|`Status_JVM_Memory_Heap_Max`|The maximum amount of heap memory that can be used for memory management.|int|count|
|`Status_JVM_Memory_Heap_Used`|The amount of heap memory currently used.|int|count|
|`Status_JVM_Memory_Mapped_Count`|The number of buffers in the mapped buffer pool.|int|count|
|`Status_JVM_Memory_Mapped_MemoryUsed`|The amount of memory used by the JVM for the mapped buffer pool.|int|count|
|`Status_JVM_Memory_Mapped_TotalCapacity`|The number of buffers in the mapped buffer pool.|int|count|
|`Status_JVM_Memory_Metaspace_Committed`|The amount of memory guaranteed to be available to the JVM in the Metaspace memory pool (in bytes).|int|count|
|`Status_JVM_Memory_Metaspace_Max`|The maximum amount of memory that can be used in the Metaspace memory pool (in bytes).|int|count|
|`Status_JVM_Memory_Metaspace_Used`|Used bytes of a given JVM memory area|int|count|
|`Status_JVM_Memory_NonHeap_Committed`|The amount of non-heap memory guaranteed to be available to the JVM.|int|count|
|`Status_JVM_Memory_NonHeap_Max`|The maximum amount of non-heap memory that can be used for memory management|int|count|
|`Status_JVM_Memory_NonHeap_Used`|The amount of non-heap memory currently used.|int|count|
|`Status_JVM_Threads_Count`|The total number of live threads.|int|count|
|`numRegisteredTaskManagers`|The number of registered taskmanagers.|int|count|
|`numRunningJobs`|The number of running jobs.|int|count|
|`taskSlotsAvailable`|The number of available task slots.|int|count|
|`taskSlotsTotal`|The total number of task slots.|int|count|



### `Taskmanager`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`host`|host name|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`Status_Flink_Memory_Managed_Total`|The total amount of managed memory.|int|count|
|`Status_Flink_Memory_Managed_Used`|The amount of managed memory currently used.|int|count|
|`Status_JVM_CPU_Load`|The recent CPU usage of the JVM.|int|count|
|`Status_JVM_CPU_Time`|The CPU time used by the JVM.|int|count|
|`Status_JVM_ClassLoader_ClassesLoaded`|The total number of classes loaded since the start of the JVM.|int|count|
|`Status_JVM_ClassLoader_ClassesUnloaded`|The total number of classes unloaded since the start of the JVM.|int|count|
|`Status_JVM_GarbageCollector_G1_Old_Generation_Count`|The total number of collections that have occurred.|int|count|
|`Status_JVM_GarbageCollector_G1_Old_Generation_Time`|The total time spent performing garbage collection.|int|count|
|`Status_JVM_GarbageCollector_G1_Young_Generation_Count`|The total number of collections that have occurred.|int|count|
|`Status_JVM_GarbageCollector_G1_Young_Generation_Time`|The total time spent performing garbage collection.|int|count|
|`Status_JVM_Memory_Direct_Count`|The number of buffers in the direct buffer pool.|int|count|
|`Status_JVM_Memory_Direct_MemoryUsed`|The amount of memory used by the JVM for the direct buffer pool.|int|count|
|`Status_JVM_Memory_Direct_TotalCapacity`|The total capacity of all buffers in the direct buffer pool.|int|count|
|`Status_JVM_Memory_Heap_Committed`|The amount of heap memory guaranteed to be available to the JVM.|int|count|
|`Status_JVM_Memory_Heap_Max`|The maximum amount of heap memory that can be used for memory management.|int|count|
|`Status_JVM_Memory_Heap_Used`|The amount of heap memory currently used.|int|count|
|`Status_JVM_Memory_Mapped_Count`|The number of buffers in the mapped buffer pool.|int|count|
|`Status_JVM_Memory_Mapped_MemoryUsed`|The amount of memory used by the JVM for the mapped buffer pool.|int|count|
|`Status_JVM_Memory_Mapped_TotalCapacity`|The number of buffers in the mapped buffer pool.|int|count|
|`Status_JVM_Memory_Metaspace_Committed`|The amount of memory guaranteed to be available to the JVM in the Metaspace memory pool (in bytes).|int|count|
|`Status_JVM_Memory_Metaspace_Max`|The maximum amount of memory that can be used in the Metaspace memory pool (in bytes).|int|count|
|`Status_JVM_Memory_Metaspace_Used`|Used bytes of a given JVM memory area|int|count|
|`Status_JVM_Memory_NonHeap_Committed`|The amount of non-heap memory guaranteed to be available to the JVM.|int|count|
|`Status_JVM_Memory_NonHeap_Max`|The maximum amount of non-heap memory that can be used for memory management|int|count|
|`Status_JVM_Memory_NonHeap_Used`|The amount of non-heap memory currently used.|int|count|
|`Status_JVM_Threads_Count`|The total number of live threads.|int|count|
|`Status_Network_AvailableMemorySegments`|The number of unused memory segments.|int|count|
|`Status_Network_TotalMemorySegments`|The number of allocated memory segments.|int|count|
|`Status_Shuffle_Netty_AvailableMemory`|The amount of unused memory in bytes.|int|count|
|`Status_Shuffle_Netty_AvailableMemorySegments`|The number of unused memory segments.|int|count|
|`Status_Shuffle_Netty_TotalMemory`|The amount of allocated memory in bytes.|int|count|
|`Status_Shuffle_Netty_TotalMemorySegments`|The number of allocated memory segments.|int|count|
|`Status_Shuffle_Netty_UsedMemory`|The amount of used memory in bytes.|int|count|
|`Status_Shuffle_Netty_UsedMemorySegments`|The number of used memory segments.|int|count|


