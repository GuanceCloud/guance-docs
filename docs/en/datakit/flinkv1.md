<!-- This file required to translate to EN. -->

# Flink
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

Flink 采集器可以从 Flink 实例中采取很多指标，比如 Flink 服务器状态和网络的状态等多种指标，并将指标采集到 DataFlux ，帮助你监控分析 Flink 各种异常情况。

## 安装部署 {#install-flink}

说明：示例 Flink 版本为： flink 1.14.2 (CentOS)，各个不同版本指标可能存在差异

## 前置条件 {#requirements}

目前 Flink 官方提供两种 metrics 上报方式: [Prometheus](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/deployment/metric_reporters/#prometheus){:target="_blank"} 和 [PrometheusPushGateway](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/deployment/metric_reporters/#prometheuspushgateway){:target="_blank"}。它们主要的区别是:

- PrometheusPushGateway 方式是把集群所有的 metrics 统一汇报给 pushgateway，所以需要额外安装 pushgateway
- Prometheus 方式需要集群每个节点暴露一个唯一端口，不需要额外安装其它软件，但需要 N 个可用端口，配置略微复杂

### PrometheusPushGateway 方式（推荐） {#push-gateway}

- 下载和安装：pushgateway 可以在 [Prometheuse 官方页面](https://prometheus.io/download/#pushgateway){:target="_blank"} 进行下载。

启动 pushgateway:（此命令仅供参考，具体命令根据实际环境可能有所不同）

```shell
nohup ./pushgateway &
```

- 配置 `flink-conf.yaml` 把 metrics 统一汇报给 pushgateway

配置 Flink 的配置文件 `conf/flink-conf.yaml` 示例:

```bash
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

### Prometheus 方式 {#prometheus}

- 配置 `flink-conf.yaml` 暴露各个节点的 metrics。配置 Flink 的配置文件 `conf/flink-conf.yaml` 示例:

```bash
metrics.reporter.prom.class: org.apache.flink.metrics.prometheus.PrometheusReporter
metrics.reporter.prom.port: 9250-9260 # 各个节点的端口区间，根据节点数量有所不同，一个端口对应一个节点
```

- 启动 Flink: `./bin/start-cluster.sh`（此命令仅供参考，具体命令根据实际环境可能有所不同）

- 可以访问外网的主机<[安装 Datakit](https://www.yuque.com/dataflux/datakit/datakit-install)>
- 更改 Flink 配置添加如下内容，开启 Prometheus 采集

```bash
metrics.reporter.prom.class: org.apache.flink.metrics.prometheus.PrometheusReporter
metrics.reporter.prom.port: 9250-9260
```

> 注意：`metrics.reporter.prom.port` 设置请参考集群 jobmanager 和 taskmanager 数量而定

- 重启 Flink 集群应用配置
- curl http://{Flink iP}:9250-9260 返回结果正常即可开始采集

## 指标集 {#measurements}

默认情况下，Flink 会收集多个指标，这些[指标](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/ops/metrics/#system-metrics)可提供对当前状态的深入洞察



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


