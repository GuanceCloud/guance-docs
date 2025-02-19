---
title      : 'ClickHouse'
summary    : '采集 ClickHouse 的指标数据'
__int_icon : 'icon/clickhouse'
tags:
  - '数据库'
dashboard  :
  - desc   : 'ClickHouse'
    path   : 'dashboard/zh/clickhouse'
monitor    :
  - desc   : '暂无'
    path   : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

ClickHouse 采集器可以采集 ClickHouse 服务器实例主动暴露的多种指标，比如语句执行数量和内存存储量，IO 交互等多种指标，并将指标采集到{{{ custom_key.brand_name }}}，帮助你监控分析 ClickHouse 各种异常情况。

## 配置 {#config}

### 前置条件 {#requirements}

- ClickHouse 版本 >=v20.1.2.4
- 在 ClickHouse Server 的 `config.xml` 配置文件中找到如下的代码段，取消注释，并设置 metrics 暴露的端口号（具体哪个自己选择，唯一即可）。修改完成后重启（若为集群，则每台机器均需操作）。

```shell
vim /etc/clickhouse-server/config.xml
```

```xml
<prometheus>
    <endpoint>/metrics</endpoint>
    <port>9363</port>
    <metrics>true</metrics>
    <events>true</events>
    <asynchronous_metrics>true</asynchronous_metrics>
</prometheus>
```

字段说明：

- `endpoint` Prometheus 服务器抓取指标的 HTTP 路由
- `port` 端点的端口号
- `metrics` 从 ClickHouse 的 `system.metrics` 表中抓取暴露的指标标志
- `events` 从 ClickHouse 的 `system.events` 表中抓取暴露的事件标志
- `asynchronous_metrics` 从 ClickHouse 中 `system.asynchronous_metrics` 表中抓取暴露的异步指标标志

详见[ClickHouse 官方文档](https://ClickHouse.com/docs/en/operations/server-configuration-parameters/settings/#server_configuration_parameters-prometheus){:target="_blank"}

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/clickhousev1` 目录，复制 `clickhousev1.conf.sample` 并命名为 `clickhousev1.conf`。示例如下：
    
    ```toml
        
    [[inputs.clickhousev1]]
      ## Exporter URLs.
      urls = ["http://127.0.0.1:9363/metrics"]
    
      ## Unix Domain Socket URL. Using socket to request data when not empty.
      uds_path = ""
    
      ## Ignore URL request errors.
      ignore_req_err = false
    
      ## Collect data output.
      ## Fill this when want to collect the data to local file nor center.
      ## After filling, could use 'datakit debug --prom-conf /path/to/this/conf' to debug local storage measurement set.
      ## Using '--prom-conf' when priority debugging data in 'output' path.
      # output = "/abs/path/to/file"
    
      ## Collect data upper limit as bytes.
      ## Only available when set output to local file.
      ## If collect data exceeded the limit, the data would be dropped.
      ## Default is 32MB.
      # max_file_size = 0
    
      ## Metrics type whitelist. Optional: counter, gauge, histogram, summary
      ## Example: metric_types = ["counter", "gauge"], only collect 'counter' and 'gauge'.
      ## Default collect all.
      # metric_types = []
    
      ## Metrics name whitelist.
      ## Regex supported. Multi supported, conditions met when one matched.
      ## Collect all if empty.
      # metric_name_filter = ["cpu"]
    
      ## Metrics name blacklist.
      ## If a word both in blacklist and whitelist, blacklist priority.
      ## Regex supported. Multi supported, conditions met when one matched.
      ## Collect all if empty.
      # metric_name_filter_ignore = ["foo","bar"]
    
      ## Measurement prefix.
      ## Add prefix to measurement set name.
      measurement_prefix = ""
    
      ## Measurement name.
      ## If measurement_name is empty, split metric name by '_', the first field after split as measurement set name, the rest as current metric name.
      ## If measurement_name is not empty, using this as measurement set name.
      ## Always add 'measurement_prefix' prefix at last.
      # measurement_name = "clickhouse"
    
      ## TLS configuration.
      tls_open = false
      # tls_ca = "/tmp/ca.crt"
      # tls_cert = "/tmp/peer.crt"
      # tls_key = "/tmp/peer.key"
    
      ## Set to 'true' to enable election.
      election = true
    
      ## disable setting host tag for this input
      disable_host_tag = false
    
      ## disable setting instance tag for this input
      disable_instance_tag = false
    
      ## disable info tag for this input
      disable_info_tag = false
    
      ## Ignore tags. Multi supported.
      ## The matched tags would be dropped, but the item would still be sent.
      # tags_ignore = ["xxxx"]
    
      ## Customize authentification. For now support Bearer Token only.
      ## Filling in 'token' or 'token_file' is acceptable.
      # [inputs.clickhousev1.auth]
        # type = "bearer_token"
        # token = "xxxxxxxx"
        # token_file = "/tmp/token"
    
      ## Customize measurement set name.
      ## Treat those metrics with prefix as one set.
      ## Prioritier over 'measurement_name' configuration.
      [[inputs.clickhousev1.measurements]]
        prefix = "ClickHouseProfileEvents_"
        name = "ClickHouseProfileEvents"
    
      [[inputs.clickhousev1.measurements]]
        prefix = "ClickHouseMetrics_"
        name = "ClickHouseMetrics"
    
      [[inputs.clickhousev1.measurements]]
        prefix = "ClickHouseAsyncMetrics_"
        name = "ClickHouseAsyncMetrics"
    
      [[inputs.clickhousev1.measurements]]
        prefix = "ClickHouseStatusInfo_"
        name = "ClickHouseStatusInfo"
    
      ## Not collecting those data when tag matched.
      [inputs.clickhousev1.ignore_tag_kv_match]
        # key1 = [ "val1.*", "val2.*"]
        # key2 = [ "val1.*", "val2.*"]
    
      ## Add HTTP headers to data pulling.
      [inputs.clickhousev1.http_headers]
        # Root = "passwd"
        # Michael = "1234"
    
      ## Rename tag key in clickhouse data.
      [inputs.clickhousev1.tags_rename]
        overwrite_exist_tags = false
      [inputs.clickhousev1.tags_rename.mapping]
        # tag1 = "new-name-1"
        # tag2 = "new-name-2"
        # tag3 = "new-name-3"
    
      ## Customize tags.
      [inputs.clickhousev1.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
      
      ## (Optional) Collect interval: (defaults to "30s").
      # interval = "30s"
    
      ## (Optional) Timeout: (defaults to "30s").
      # timeout = "30s"
      
    ```

    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

## 指标 {#metric}

以下所有数据采集，默认会追加全局选举 tag，也可以在配置中通过 `[inputs.clickhousev1.tags]` 指定其它标签：

``` toml
[inputs.prom.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```





### `ClickHouseAsyncMetrics`



- 标签


| Tag | Description |
|  ----  | --------|
|`cpu`|Cpu id|
|`disk`|Disk name|
|`eth`|Eth id|
|`host`|Host name|
|`instance`|Instance endpoint|
|`unit`|Unit name|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`AsynchronousHeavyMetricsCalculationTimeSpent`|Time in seconds spent for calculation of asynchronous heavy tables related metrics this is the overhead of asynchronous metrics.|float|s|
|`AsynchronousHeavyMetricsUpdateInterval`|Heavy (tables related) metrics update interval|float|s|
|`AsynchronousMetricsCalculationTimeSpent`|Time in seconds spent for calculation of asynchronous metrics this is the overhead of asynchronous metrics.|float|s|
|`AsynchronousMetricsUpdateInterval`|Metrics update interval|float|s|
|`BlockActiveTime`|Time in seconds the block device had the IO requests queued. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|float|s|
|`BlockDiscardBytes`|Number of discarded bytes on the block device. These operations are relevant for SSD. Discard operations are not used by ClickHouse, but can be used by other processes on the system. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|float|B|
|`BlockDiscardMerges`|Number of discard operations requested from the block device and merged together by the OS IO scheduler. These operations are relevant for SSD. Discard operations are not used by ClickHouse, but can be used by other processes on the system. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|float|count|
|`BlockDiscardOps`|Number of discard operations requested from the block device. These operations are relevant for SSD. Discard operations are not used by ClickHouse, but can be used by other processes on the system. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|float|count|
|`BlockDiscardTime`|Time in seconds spend in discard operations requested from the block device, summed across all the operations. These operations are relevant for SSD. Discard operations are not used by ClickHouse, but can be used by other processes on the system. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|float|s|
|`BlockInFlightOps`|This value counts the number of I/O requests that have been issued to the device driver but have not yet completed. It does not include IO requests that are in the queue but not yet issued to the device driver. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|float|count|
|`BlockQueueTime`|This value counts the number of milliseconds that IO requests have waited on this block device. If there are multiple IO requests waiting, this value will increase as the product of the number of milliseconds times the number of requests waiting. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|float|ms|
|`BlockReadBytes`|Number of bytes read from the block device. It can be lower than the number of bytes read from the filesystem due to the usage of the OS page cache, that saves IO. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|float|B|
|`BlockReadMerges`|Number of read operations requested from the block device and merged together by the OS IO scheduler. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|float|count|
|`BlockReadOps`|Number of read operations requested from the block device. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|float|count|
|`BlockReadTime`|Time in seconds spend in read operations requested from the block device, summed across all the operations. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|float|s|
|`BlockWriteBytes`|Number of bytes written to the block device. It can be lower than the number of bytes written to the filesystem due to the usage of the OS page cache, that saves IO. A write to the block device may happen later than the corresponding write to the filesystem due to write-through caching. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|float|B|
|`BlockWriteMerges`|Number of write operations requested from the block device and merged together by the OS IO scheduler. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|float|count|
|`BlockWriteOps`|Number of write operations requested from the block device. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|float|count|
|`BlockWriteTime`|Time in seconds spend in write operations requested from the block device, summed across all the operations. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|float|s|
|`CPUFrequencyMHz`|The current frequency of the CPU, in MHz. Most of the modern CPUs adjust the frequency dynamically for power saving and Turbo Boosting.|float|MHz|
|`CompiledExpressionCacheBytes`|Total bytes used for the cache of JIT-compiled code.|float|B|
|`CompiledExpressionCacheCount`|Total entries in the cache of JIT-compiled code.|float|count|
|`DiskAvailable`|Available bytes on the disk (virtual filesystem). Remote `filesystems` can show a large value like 16 EiB.|float|B|
|`DiskTotal`|The total size in bytes of the disk (virtual filesystem). Remote `filesystems` can show a large value like 16 EiB.|float|B|
|`DiskUnreserved`|Available bytes on the disk (virtual filesystem) without the reservations for merges, fetches, and moves. Remote `filesystems` can show a large value like 16 EiB.|float|B|
|`DiskUsed`|Used bytes on the disk (virtual filesystem). Remote `filesystems` not always provide this information.|float|B|
|`FilesystemCacheBytes`|Total bytes in the `cache` virtual filesystem. This cache is hold on disk.|float|B|
|`FilesystemCacheFiles`|Total number of cached file segments in the `cache` virtual filesystem. This cache is hold on disk.|float|count|
|`FilesystemLogsPathAvailableBytes`|Available bytes on the volume where ClickHouse logs path is mounted. If this value approaches zero, you should tune the log rotation in the configuration file.|float|B|
|`FilesystemLogsPathAvailableINodes`|The number of available `inodes` on the volume where ClickHouse logs path is mounted.|float|count|
|`FilesystemLogsPathTotalBytes`|The size of the volume where ClickHouse logs path is mounted, in bytes. It's recommended to have at least 10 GB for logs.|float|B|
|`FilesystemLogsPathTotalINodes`|The total number of `inodes` on the volume where ClickHouse logs path is mounted.|float|count|
|`FilesystemLogsPathUsedBytes`|Used bytes on the volume where ClickHouse logs path is mounted.|float|B|
|`FilesystemLogsPathUsedINodes`|The number of used `inodes` on the volume where ClickHouse logs path is mounted.|float|count|
|`FilesystemMainPathAvailableBytes`|Available bytes on the volume where the main ClickHouse path is mounted.|float|B|
|`FilesystemMainPathAvailableINodes`|The number of available `inodes` on the volume where the main ClickHouse path is mounted. If it is close to zero, it indicates a misconfiguration, and you will get 'no space left on device' even when the disk is not full.|float|count|
|`FilesystemMainPathTotalBytes`|The size of the volume where the main ClickHouse path is mounted, in bytes.|float|B|
|`FilesystemMainPathTotalINodes`|The total number of `inodes` on the volume where the main ClickHouse path is mounted. If it is less than 25 million, it indicates a misconfiguration.|float|count|
|`FilesystemMainPathUsedBytes`|Used bytes on the volume where the main ClickHouse path is mounted.|float|B|
|`FilesystemMainPathUsedINodes`|The number of used `inodes` on the volume where the main ClickHouse path is mounted. This value mostly corresponds to the number of files.|float|count|
|`HTTPThreads`|Number of threads in the server of the HTTP interface (without TLS).|float|count|
|`InterserverThreads`|Number of threads in the server of the replicas communication protocol (without TLS).|float|count|
|`Jitter`|The difference in time the thread for calculation of the asynchronous metrics was scheduled to wake up and the time it was in fact, woken up. A proxy-indicator of overall system latency and responsiveness.|float|-|
|`LoadAverage`|The whole system load, averaged with exponential smoothing over 1 minute. The load represents the number of threads across all the processes (the scheduling entities of the OS kernel), that are currently running by CPU or waiting for IO, or ready to run but not being scheduled at this point of time. This number includes all the processes, not only `clickhouse-server`. The number can be greater than the number of CPU cores, if the system is overloaded, and many processes are ready to run but waiting for CPU or IO.|float|count|
|`MMapCacheCells`|The number of files opened with `mmap` (mapped in memory). This is used for queries with the setting `local_filesystem_read_method` set to  `mmap`. The files opened with `mmap` are kept in the cache to avoid costly TLB flushes.|float|count|
|`MarkCacheBytes`|Total size of mark cache in bytes|float|B|
|`MarkCacheFiles`|Total number of mark files cached in the mark cache|float|count|
|`MaxPartCountForPartition`|Maximum number of parts per partition across all partitions of all tables of MergeTree family. Values larger than 300 indicates misconfiguration, overload, or massive data loading.|float|count|
|`MemoryCode`|The amount of virtual memory mapped for the pages of machine code of the server process, in bytes.|float|B|
|`MemoryDataAndStack`|The amount of virtual memory mapped for the use of stack and for the allocated memory, in bytes. It is unspecified whether it includes the per-thread stacks and most of the allocated memory, that is allocated with the `mmap` system call. This metric exists only for completeness reasons. I recommend to use the `MemoryResident` metric for monitoring.|float|B|
|`MemoryResident`|The amount of physical memory used by the server process, in bytes.|float|B|
|`MemoryShared`|The amount of memory used by the server process, that is also shared by another processes, in bytes. ClickHouse does not use shared memory, but some memory can be labeled by OS as shared for its own reasons. This metric does not make a lot of sense to watch, and it exists only for completeness reasons.|float|B|
|`MemoryVirtual`|The size of the virtual address space allocated by the server process, in bytes. The size of the virtual address space is usually much greater than the physical memory consumption, and should not be used as an estimate for the memory consumption. The large values of this metric are totally normal, and makes only technical sense.|float|B|
|`MySQLThreads`|Number of threads in the server of the MySQL compatibility protocol.|float|count|
|`NetworkReceiveBytes`|Number of bytes received via the network interface. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|float|B|
|`NetworkReceiveDrop`|Number of bytes a packet was dropped while received via the network interface. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|float|B|
|`NetworkReceiveErrors`|Number of times error happened receiving via the network interface. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|float|count|
|`NetworkReceivePackets`|Number of network packets received via the network interface. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|float|count|
|`NetworkSendBytes`|Number of bytes sent via the network interface. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|float|B|
|`NetworkSendDrop`|Number of times a packed was dropped while sending via the network interface. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|float|count|
|`NetworkSendErrors`|Number of times error (e.g. TCP retransmit) happened while sending via the network interface. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|float|count|
|`NetworkSendPackets`|Number of network packets sent via the network interface. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|float|count|
|`NumberOfDatabases`|Total number of databases on the server.|float|count|
|`NumberOfDetachedByUserParts`|The total number of parts detached from MergeTree tables by users with the `ALTER TABLE DETACH` query (as opposed to unexpected, broken or ignored parts). The server does not care about detached parts and they can be removed.|float|count|
|`NumberOfDetachedParts`|The total number of parts detached from MergeTree tables. A part can be detached by a user with the `ALTER TABLE DETACH` query or by the server itself it the part is broken, unexpected or unneeded. The server does not care about detached parts and they can be removed.|float|count|
|`NumberOfTables`|Total number of tables summed across the databases on the server, excluding the databases that cannot contain MergeTree tables. The excluded database engines are those who generate the set of tables on the fly, like `Lazy`, `MySQL`, `PostgreSQL`, `SQlite`.|float|count|
|`OSContextSwitches`|The number of context switches that the system underwent on the host machine. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|float|count|
|`OSGuestNiceTime`|The ratio of time spent running a virtual CPU for guest operating systems under the control of the Linux kernel, when a guest was set to a higher priority (See `man procfs`). This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. This metric is irrelevant for ClickHouse, but still exists for completeness. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|float|rate|
|`OSGuestNiceTimeCPU`|The ratio of time spent running a virtual CPU for guest operating systems under the control of the Linux kernel, when a guest was set to a higher priority (See `man procfs`). This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. This metric is irrelevant for ClickHouse, but still exists for completeness. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|float|rate|
|`OSGuestNiceTimeNormalized`|The value is similar to `OSGuestNiceTime` but divided to the number of CPU cores to be measured in the [0..1] interval regardless of the number of cores. This allows you to average the values of this metric across multiple servers in a cluster even if the number of cores is non-uniform, and still get the average resource utilization metric.|float|rate|
|`OSGuestTime`|The ratio of time spent running a virtual CPU for guest operating systems under the control of the Linux kernel (See `man procfs`). This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. This metric is irrelevant for ClickHouse, but still exists for completeness. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|float|rate|
|`OSGuestTimeCPU`|The ratio of time spent running a virtual CPU for guest operating systems under the control of the Linux kernel (See `man procfs`). This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. This metric is irrelevant for ClickHouse, but still exists for completeness. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|float|rate|
|`OSGuestTimeNormalized`|The value is similar to `OSGuestTime` but divided to the number of CPU cores to be measured in the [0..1] interval regardless of the number of cores. This allows you to average the values of this metric across multiple servers in a cluster even if the number of cores is non-uniform, and still get the average resource utilization metric.|float|rate|
|`OSIOWaitTime`|The ratio of time the CPU core was not running the code but when the OS kernel did not run any other process on this CPU as the processes were waiting for IO. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|float|rate|
|`OSIOWaitTimeCPU`|The ratio of time the CPU core was not running the code but when the OS kernel did not run any other process on this CPU as the processes were waiting for IO. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|float|rate|
|`OSIOWaitTimeNormalized`|The value is similar to `OSIOWaitTime` but divided to the number of CPU cores to be measured in the [0..1] interval regardless of the number of cores. This allows you to average the values of this metric across multiple servers in a cluster even if the number of cores is non-uniform, and still get the average resource utilization metric.|float|rate|
|`OSIdleTime`|The ratio of time the CPU core was idle (not even ready to run a process waiting for IO) from the OS kernel standpoint. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. This does not include the time when the CPU was under-utilized due to the reasons internal to the CPU (memory loads, `pipeline stalls`, branch `mispredictions`, running another SMT core). The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|float|rate|
|`OSIdleTimeCPU`|The ratio of time the CPU core was idle (not even ready to run a process waiting for IO) from the OS kernel standpoint. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. This does not include the time when the CPU was under-utilized due to the reasons internal to the CPU (memory loads, `pipeline stalls`, branch `mispredictions`, running another SMT core). The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|float|rate|
|`OSIdleTimeNormalized`|The value is similar to `OSIdleTime` but divided to the number of CPU cores to be measured in the [0..1] interval regardless of the number of cores. This allows you to average the values of this metric across multiple servers in a cluster even if the number of cores is non-uniform, and still get the average resource utilization metric.|float|rate|
|`OSInterrupts`|The number of interrupts on the host machine. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|float|count|
|`OSIrqTime`|The ratio of time spent for running hardware interrupt requests on the CPU. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. A high number of this metric may indicate hardware misconfiguration or a very high network load. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|float|rate|
|`OSIrqTimeCPU`|The ratio of time spent for running hardware interrupt requests on the CPU. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. A high number of this metric may indicate hardware misconfiguration or a very high network load. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|float|rate|
|`OSIrqTimeNormalized`|The value is similar to `OSIrqTime` but divided to the number of CPU cores to be measured in the [0..1] interval regardless of the number of cores. This allows you to average the values of this metric across multiple servers in a cluster even if the number of cores is non-uniform, and still get the average resource utilization metric.|float|rate|
|`OSMemoryAvailable`|The amount of memory available to be used by programs, in bytes. This is very similar to the `OSMemoryFreePlusCached` metric. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|float|B|
|`OSMemoryBuffers`|The amount of memory used by OS kernel buffers, in bytes. This should be typically small, and large values may indicate a misconfiguration of the OS. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|float|B|
|`OSMemoryCached`|The amount of memory used by the OS page cache, in bytes. Typically, almost all available memory is used by the OS page cache - high values of this metric are normal and expected. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|float|B|
|`OSMemoryFreePlusCached`|The amount of free memory plus OS page cache memory on the host system, in bytes. This memory is available to be used by programs. The value should be very similar to `OSMemoryAvailable`. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|float|B|
|`OSMemoryFreeWithoutCached`|The amount of free memory on the host system, in bytes. This does not include the memory used by the OS page cache memory, in bytes. The page cache memory is also available for usage by programs, so the value of this metric can be confusing. See the `OSMemoryAvailable` metric instead. For convenience we also provide the `OSMemoryFreePlusCached` metric, that should be somewhat similar to OSMemoryAvailable. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|float|B|
|`OSMemorySwapCached`|The amount of memory in swap that was also loaded in RAM. Swap should be disabled on production systems. If the value of this metric is large, it indicates a misconfiguration.  This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|float|B|
|`OSMemoryTotal`|The total amount of memory on the host system, in bytes.|float|B|
|`OSNiceTime`|The ratio of time the CPU core was running `userspace` code with higher priority. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|float|rate|
|`OSNiceTimeCPU`|The ratio of time the CPU core was running `userspace` code with higher priority. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|float|rate|
|`OSNiceTimeNormalized`|The value is similar to `OSNiceTime` but divided to the number of CPU cores to be measured in the [0..1] interval regardless of the number of cores. This allows you to average the values of this metric across multiple servers in a cluster even if the number of cores is non-uniform, and still get the average resource utilization metric.|float|rate|
|`OSOpenFiles`|The total number of opened files on the host machine. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|float|count|
|`OSProcessesBlocked`|Number of threads blocked waiting for I/O to complete (`man procfs`). This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|float|count|
|`OSProcessesCreated`|The number of processes created. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|float|count|
|`OSProcessesRunning`|The number of runnable (running or ready to run) threads by the operating system. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|float|count|
|`OSSoftIrqTime`|The ratio of time spent for running software interrupt requests on the CPU. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. A high number of this metric may indicate inefficient software running on the system. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|float|rate|
|`OSSoftIrqTimeCPU`|The ratio of time spent for running software interrupt requests on the CPU. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. A high number of this metric may indicate inefficient software running on the system. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|float|rate|
|`OSSoftIrqTimeNormalized`|The value is similar to `OSSoftIrqTime` but divided to the number of CPU cores to be measured in the [0..1] interval regardless of the number of cores. This allows you to average the values of this metric across multiple servers in a cluster even if the number of cores is non-uniform, and still get the average resource utilization metric.|float|rate|
|`OSStealTime`|The ratio of time spent in other operating systems by the CPU when running in a virtualized environment. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Not every virtualized environments present this metric, and most of them don't. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|float|rate|
|`OSStealTimeCPU`|The ratio of time spent in other operating systems by the CPU when running in a virtualized environment. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Not every virtualized environments present this metric, and most of them don't. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|float|rate|
|`OSStealTimeNormalized`|The value is similar to `OSStealTime` but divided to the number of CPU cores to be measured in the [0..1] interval regardless of the number of cores. This allows you to average the values of this metric across multiple servers in a cluster even if the number of cores is non-uniform, and still get the average resource utilization metric.|float|rate|
|`OSSystemTime`|The ratio of time the CPU core was running OS kernel (system) code. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|float|rate|
|`OSSystemTimeCPU`|The ratio of time the CPU core was running OS kernel (system) code. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|float|rate|
|`OSSystemTimeNormalized`|The value is similar to `OSSystemTime` but divided to the number of CPU cores to be measured in the [0..1] interval regardless of the number of cores. This allows you to average the values of this metric across multiple servers in a cluster even if the number of cores is non-uniform, and still get the average resource utilization metric.|float|rate|
|`OSThreadsRunnable`|The total number of 'runnable' threads, as the OS kernel scheduler seeing it.|float|count|
|`OSThreadsTotal`|The total number of threads, as the OS kernel scheduler seeing it.|float|count|
|`OSUptime`|The uptime of the host server (the machine where ClickHouse is running), in seconds.|float|s|
|`OSUserTime`|The ratio of time the CPU core was running `userspace` code. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. This includes also the time when the CPU was under-utilized due to the reasons internal to the CPU (memory loads, `pipeline stalls`, branch `mispredictions`, running another SMT core). The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|float|rate|
|`OSUserTimeCPU`|The ratio of time the CPU core was running `userspace` code. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. This includes also the time when the CPU was under-utilized due to the reasons internal to the CPU (memory loads, `pipeline stalls`, branch `mispredictions`, running another SMT core). The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|float|rate|
|`OSUserTimeNormalized`|The value is similar to `OSUserTime` but divided to the number of CPU cores to be measured in the [0..1] interval regardless of the number of cores. This allows you to average the values of this metric across multiple servers in a cluster even if the number of cores is non-uniform, and still get the average resource utilization metric.|float|rate|
|`PostgreSQLThreads`|Number of threads in the server of the PostgreSQL compatibility protocol.|float|count|
|`PrometheusThreads`|Number of threads in the server of the Prometheus endpoint. Note: Prometheus endpoints can be also used via the usual HTTP/HTTPs ports.|float|count|
|`ReplicasMaxAbsoluteDelay`|Maximum difference in seconds between the most fresh replicated part and the most fresh data part still to be replicated, across Replicated tables. A very high value indicates a replica with no data.|float|s|
|`ReplicasMaxInsertsInQueue`|Maximum number of INSERT operations in the queue (still to be replicated) across Replicated tables.|float|count|
|`ReplicasMaxMergesInQueue`|Maximum number of merge operations in the queue (still to be applied) across Replicated tables.|float|count|
|`ReplicasMaxQueueSize`|Maximum queue size (in the number of operations like get, merge) across Replicated tables.|float|count|
|`ReplicasMaxRelativeDelay`|Maximum difference between the replica delay and the delay of the most up-to-date replica of the same table, across Replicated tables.|float|s|
|`ReplicasSumInsertsInQueue`|Sum of INSERT operations in the queue (still to be replicated) across Replicated tables.|float|count|
|`ReplicasSumMergesInQueue`|Sum of merge operations in the queue (still to be applied) across Replicated tables.|float|count|
|`ReplicasSumQueueSize`|Sum queue size (in the number of operations like get, merge) across Replicated tables.|float|count|
|`TCPThreads`|Number of threads in the server of the TCP protocol (without TLS).|float|count|
|`Temperature`|The temperature of the corresponding device in ℃. A sensor can return an unrealistic value. Source: `/sys/class/thermal`|float|C|
|`TotalBytesOfMergeTreeTables`|Total amount of bytes (compressed, including data and indices) stored in all tables of MergeTree family.|float|B|
|`TotalPartsOfMergeTreeTables`|Total amount of data parts in all tables of MergeTree family. Numbers larger than 10 000 will negatively affect the server startup time and it may indicate unreasonable choice of the partition key.|float|count|
|`TotalRowsOfMergeTreeTables`|Total amount of rows (records) stored in all tables of MergeTree family.|float|count|
|`UncompressedCacheBytes`|Total size of uncompressed cache in bytes. Uncompressed cache does not usually improve the performance and should be mostly avoided.|float|B|
|`UncompressedCacheCells`|Total number of entries in the uncompressed cache. Each entry represents a decompressed block of data. Uncompressed cache does not usually improve performance and should be mostly avoided.|float|B|
|`Uptime`|The server uptime in seconds. It includes the time spent for server initialization before accepting connections.|float|s|
|`jemalloc_active`|Total number of bytes in active pages allocated by the application. This is a multiple of the page size, and greater than or equal to.|float|B|
|`jemalloc_allocated`|Total number of bytes allocated by the application.|float|B|
|`jemalloc_arenas_all_dirty_purged`|Number of `madvise()` or similar calls made to purge dirty pages.|float|count|
|`jemalloc_arenas_all_muzzy_purged`|Number of muzzy page purge sweeps performed.|float|count|
|`jemalloc_arenas_all_pactive`|Number of pages in active extents.|float|count|
|`jemalloc_arenas_all_pdirty`|Number of pages within unused extents that are potentially dirty, and for which `madvise()` or similar has not been called. |float|count|
|`jemalloc_arenas_all_pmuzzy`|Number of pages within unused extents that are muzzy.|float|count|
|`jemalloc_background_thread_num_runs`|Total number of runs from all background threads.|float|count|
|`jemalloc_background_thread_num_threads`|Number of background threads running currently.|float|count|
|`jemalloc_background_thread_run_intervals`|Average run interval in nanoseconds of background threads.|float|ns|
|`jemalloc_epoch`|An internal incremental update number of the statistics of jemalloc (Jason Evans' memory allocator), used in all other jemalloc metrics.|float|count|
|`jemalloc_mapped`|If a value is passed in, refresh the data from which the `mallctl*()` functions report values, and increment the epoch. Return the current epoch. This is useful for detecting whether another thread caused a refresh..|float|-|
|`jemalloc_metadata`|Total number of bytes dedicated to metadata, which comprise base allocations used for bootstrap-sensitive allocator metadata structures .|float|B|
|`jemalloc_metadata_thp`|Number of transparent huge pages (THP) used for metadata.|float|count|
|`jemalloc_resident`|Maximum number of bytes in physically resident data pages mapped by the allocator.|float|B|
|`jemalloc_retained`|Total number of bytes in virtual memory mappings.|float|B|






### `ClickHouseMetrics`



- 标签


| Tag | Description |
|  ----  | --------|
|`host`|Host name|
|`instance`|Instance endpoint|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`ActiveAsyncDrainedConnections`|Number of active connections drained asynchronously.|float|count|
|`ActiveSyncDrainedConnections`|Number of active connections drained synchronously.|float|count|
|`AggregatorThreads`|Number of threads in the Aggregator thread pool.|float|count|
|`AggregatorThreadsActive`|Number of threads in the Aggregator thread pool running a task.|float|count|
|`AsyncDrainedConnections`|Number of connections drained asynchronously.|float|count|
|`AsyncInsertCacheSize`|Number of async insert hash id in cache|float|count|
|`AsynchronousInsertThreads`|Number of threads in the AsynchronousInsert thread pool.|float|count|
|`AsynchronousInsertThreadsActive`|Number of threads in the AsynchronousInsert thread pool running a task.|float|count|
|`AsynchronousReadWait`|Number of threads waiting for asynchronous read.|float|count|
|`BackgroundBufferFlushSchedulePoolSize`|Limit on number of tasks in BackgroundBufferFlushSchedulePool|float|count|
|`BackgroundBufferFlushSchedulePoolTask`|Number of active tasks in BackgroundBufferFlushSchedulePool. This pool is used for periodic Buffer flushes|float|count|
|`BackgroundCommonPoolSize`|Limit on number of tasks in an associated background pool|float|count|
|`BackgroundCommonPoolTask`|Number of active tasks in an associated background pool|float|count|
|`BackgroundDistributedSchedulePoolSize`|Limit on number of tasks in BackgroundDistributedSchedulePool|float|count|
|`BackgroundDistributedSchedulePoolTask`|Number of active tasks in BackgroundDistributedSchedulePool. This pool is used for distributed sends that is done in background.|float|count|
|`BackgroundFetchesPoolSize`|Limit on number of simultaneous fetches in an associated background pool|float|count|
|`BackgroundFetchesPoolTask`|Number of active fetches in an associated background pool|float|count|
|`BackgroundMergesAndMutationsPoolSize`|Limit on number of active merges and mutations in an associated background pool|float|count|
|`BackgroundMergesAndMutationsPoolTask`|Number of active merges and mutations in an associated background pool|float|count|
|`BackgroundMessageBrokerSchedulePoolSize`|Limit on number of tasks in BackgroundProcessingPool for message streaming|float|count|
|`BackgroundMessageBrokerSchedulePoolTask`|Number of active tasks in BackgroundProcessingPool for message streaming|float|count|
|`BackgroundMovePoolSize`|Limit on number of tasks in BackgroundProcessingPool for moves|float|count|
|`BackgroundMovePoolTask`|Number of active tasks in BackgroundProcessingPool for moves|float|count|
|`BackgroundPoolTask`|Number of active tasks in BackgroundProcessingPool (merges, mutations, or replication queue bookkeeping)|float|count|
|`BackgroundSchedulePoolSize`|Limit on number of tasks in BackgroundSchedulePool. This pool is used for periodic ReplicatedMergeTree tasks, like cleaning old data parts, altering data parts, replica re-initialization, etc.|float|count|
|`BackgroundSchedulePoolTask`|Number of active tasks in BackgroundSchedulePool. This pool is used for periodic ReplicatedMergeTree tasks, like cleaning old data parts, altering data parts, replica re-initialization, etc.|float|count|
|`BackupsIOThreads`|Number of threads in the BackupsIO thread pool.|float|count|
|`BackupsIOThreadsActive`|Number of threads in the BackupsIO thread pool running a task.|float|count|
|`BackupsThreads`|Number of threads in the thread pool for BACKUP.|float|count|
|`BackupsThreadsActive`|Number of threads in thread pool for BACKUP running a task.|float|count|
|`BrokenDistributedFilesToInsert`|Number of files for asynchronous insertion into Distributed tables that has been marked as broken. This metric will starts from 0 on start. Number of files for every shard is summed.|float|count|
|`CacheDetachedFileSegments`|Number of existing detached cache file segments|float|count|
|`CacheDictionaryThreads`|Number of threads in the CacheDictionary thread pool.|float|count|
|`CacheDictionaryThreadsActive`|Number of threads in the CacheDictionary thread pool running a task.|float|count|
|`CacheDictionaryUpdateQueueBatches`|Number of 'batches' (a set of keys) in update queue in CacheDictionaries.|float|count|
|`CacheDictionaryUpdateQueueKeys`|Exact number of keys in update queue in CacheDictionaries.|float|count|
|`CacheFileSegments`|Number of existing cache file segments|float|count|
|`ContextLockWait`|Number of threads waiting for lock in Context. This is global lock.|float|count|
|`DDLWorkerThreads`|Number of threads in the DDLWorker thread pool for ON CLUSTER queries.|float|count|
|`DDLWorkerThreadsActive`|Number of threads in the `DDLWORKER` thread pool for ON CLUSTER queries running a task.|float|count|
|`DatabaseCatalogThreads`|Number of threads in the DatabaseCatalog thread pool.|float|count|
|`DatabaseCatalogThreadsActive`|Number of threads in the DatabaseCatalog thread pool running a task.|float|count|
|`DatabaseOnDiskThreads`|Number of threads in the DatabaseOnDisk thread pool.|float|count|
|`DatabaseOnDiskThreadsActive`|Number of threads in the DatabaseOnDisk thread pool running a task.|float|count|
|`DatabaseOrdinaryThreads`|Number of threads in the Ordinary database thread pool.|float|count|
|`DatabaseOrdinaryThreadsActive`|Number of threads in the Ordinary database thread pool running a task.|float|count|
|`DelayedInserts`|Number of INSERT queries that are throttled due to high number of active data parts for partition in a MergeTree table.|float|count|
|`DestroyAggregatesThreads`|Number of threads in the thread pool for destroy aggregate states.|float|count|
|`DestroyAggregatesThreadsActive`|Number of threads in the thread pool for destroy aggregate states running a task.|float|count|
|`DictCacheRequests`|Number of requests in fly to data sources of dictionaries of cache type.|float|count|
|`DiskObjectStorageAsyncThreads`|Number of threads in the async thread pool for DiskObjectStorage.|float|count|
|`DiskObjectStorageAsyncThreadsActive`|Number of threads in the async thread pool for DiskObjectStorage running a task.|float|count|
|`DiskSpaceReservedForMerge`|Disk space reserved for currently running background merges. It is slightly more than the total size of currently merging parts.|float|B|
|`DistributedFilesToInsert`|Number of pending files to process for asynchronous insertion into Distributed tables. Number of files for every shard is summed.|float|count|
|`DistributedInsertThreads`|Number of threads used for INSERT into Distributed.|float|count|
|`DistributedInsertThreadsActive`|Number of threads used for INSERT into Distributed running a task.|float|count|
|`DistributedSend`|Number of connections to remote servers sending data that was INSERTed into Distributed tables. Both synchronous and asynchronous mode.|float|count|
|`EphemeralNode`|Number of ephemeral nodes hold in ZooKeeper.|float|count|
|`FilesystemCacheElements`|Filesystem cache elements (file segments)|float|count|
|`FilesystemCacheReadBuffers`|Number of active cache buffers|float|count|
|`FilesystemCacheSize`|Filesystem cache size in bytes|float|B|
|`GlobalThread`|Number of threads in global thread pool.|float|count|
|`GlobalThreadActive`|Number of threads in global thread pool running a task.|float|count|
|`HTTPConnection`|Number of connections to HTTP server|float|count|
|`HashedDictionaryThreads`|Number of threads in the HashedDictionary thread pool.|float|count|
|`HashedDictionaryThreadsActive`|Number of threads in the HashedDictionary thread pool running a task.|float|count|
|`IOPrefetchThreads`|Number of threads in the IO `prefertch` thread pool.|float|count|
|`IOPrefetchThreadsActive`|Number of threads in the IO prefetch thread pool running a task.|float|count|
|`IOThreads`|Number of threads in the IO thread pool.|float|count|
|`IOThreadsActive`|Number of threads in the IO thread pool running a task.|float|count|
|`IOUringInFlightEvents`|Number of io_uring SQEs in flight|float|count|
|`IOUringPendingEvents`|Number of io_uring SQEs waiting to be submitted|float|count|
|`IOWriterThreads`|Number of threads in the IO writer thread pool.|float|count|
|`IOWriterThreadsActive`|Number of threads in the IO writer thread pool running a task.|float|count|
|`InterserverConnection`|Number of connections from other replicas to fetch parts|float|count|
|`KafkaAssignedPartitions`|Number of partitions Kafka tables currently assigned to|float|count|
|`KafkaBackgroundReads`|Number of background reads currently working (populating materialized views from Kafka)|float|count|
|`KafkaConsumers`|Number of active Kafka consumers|float|count|
|`KafkaConsumersInUse`|Number of consumers which are currently used by direct or background reads|float|count|
|`KafkaConsumersWithAssignment`|Number of active Kafka consumers which have some partitions assigned.|float|count|
|`KafkaLibrdkafkaThreads`|Number of active `librdkafka` threads|float|count|
|`KafkaProducers`|Number of active Kafka producer created|float|count|
|`KafkaWrites`|Number of currently running inserts to Kafka|float|count|
|`KeeperAliveConnections`|Number of alive connections|float|count|
|`KeeperOutstandingRequets`|Number of outstanding requests|float|count|
|`LocalThread`|Number of threads in local thread pools. The threads in local thread pools are taken from the global thread pool.|float|count|
|`LocalThreadActive`|Number of threads in local thread pools running a task.|float|count|
|`MMappedAllocBytes`|Sum bytes of mmapped allocations|float|B|
|`MMappedAllocs`|Total number of mmapped allocations|float|count|
|`MMappedFileBytes`|Sum size of mmapped file regions.|float|B|
|`MMappedFiles`|Total number of mmapped files.|float|count|
|`MarksLoaderThreads`|Number of threads in thread pool for loading marks.|float|count|
|`MarksLoaderThreadsActive`|Number of threads in the thread pool for loading marks running a task.|float|count|
|`MaxDDLEntryID`|Max processed DDL entry of DDLWorker.|float|count|
|`MaxPushedDDLEntryID`|Max DDL entry of DDLWorker that pushed to zookeeper.|float|count|
|`MemoryTracking`|Total amount of memory (bytes) allocated by the server.|float|B|
|`Merge`|Number of executing background merges|float|count|
|`MergeTreeAllRangesAnnouncementsSent`|The current number of announcement being sent in flight from the remote server to the initiator server about the set of data parts (for MergeTree tables). Measured on the remote server side.|float|count|
|`MergeTreeBackgroundExecutorThreads`|Number of threads in the MergeTreeBackgroundExecutor thread pool.|float|count|
|`MergeTreeBackgroundExecutorThreadsActive`|Number of threads in the MergeTreeBackgroundExecutor thread pool running a task.|float|count|
|`MergeTreeDataSelectExecutorThreads`|Number of threads in the MergeTreeDataSelectExecutor thread pool.|float|count|
|`MergeTreeDataSelectExecutorThreadsActive`|Number of threads in the MergeTreeDataSelectExecutor thread pool running a task.|float|count|
|`MergeTreePartsCleanerThreads`|Number of threads in the MergeTree parts cleaner thread pool.|float|count|
|`MergeTreePartsCleanerThreadsActive`|Number of threads in the MergeTree parts cleaner thread pool running a task.|float|count|
|`MergeTreePartsLoaderThreads`|Number of threads in the MergeTree parts loader thread pool.|float|count|
|`MergeTreePartsLoaderThreadsActive`|Number of threads in the MergeTree parts loader thread pool running a task.|float|count|
|`MergeTreeReadTaskRequestsSent`|The current number of callback requests in flight from the remote server back to the initiator server to choose the read task (for MergeTree tables). Measured on the remote server side.|float|count|
|`Move`|Number of currently executing moves|float|count|
|`MySQLConnection`|Number of client connections using MySQL protocol|float|count|
|`NetworkReceive`|Number of threads receiving data from network. Only ClickHouse-related network interaction is included, not by 3rd party libraries.|float|count|
|`NetworkSend`|Number of threads sending data to network. Only ClickHouse-related network interaction is included, not by 3rd party libraries.|float|count|
|`OpenFileForRead`|Number of files open for reading|float|count|
|`OpenFileForWrite`|Number of files open for writing|float|count|
|`ParallelFormattingOutputFormatThreads`|Number of threads in the ParallelFormattingOutputFormatThreads thread pool.|float|count|
|`ParallelFormattingOutputFormatThreadsActive`|Number of threads in the ParallelFormattingOutputFormatThreads thread pool running a task.|float|count|
|`ParallelParsingInputFormatThreads`|Number of threads in the ParallelParsingInputFormat thread pool.|float|count|
|`ParallelParsingInputFormatThreadsActive`|Number of threads in the ParallelParsingInputFormat thread pool running a task.|float|count|
|`ParquetDecoderThreads`|Number of threads in the ParquetBlockInputFormat thread pool running a task.|float|count|
|`ParquetDecoderThreadsActive`|Number of threads in the ParquetBlockInputFormat thread pool.|float|count|
|`PartMutation`|Number of mutations (ALTER DELETE/UPDATE)|float|count|
|`PartsActive`|Active data part, used by current and upcoming SELECTs.|float|count|
|`PartsCommitted`|Deprecated. See PartsActive.|float|count|
|`PartsCompact`|Compact parts.|float|count|
|`PartsDeleteOnDestroy`|Part was moved to another disk and should be deleted in own destructor.|float|count|
|`PartsDeleting`|Not active data part with identity `refcounter`, it is deleting right now by a cleaner.|float|count|
|`PartsInMemory`|In-memory parts.|float|count|
|`PartsOutdated`|Not active data part, but could be used by only current SELECTs, could be deleted after SELECTs finishes.|float|count|
|`PartsPreActive`|The part is in data_parts, but not used for SELECTs.|float|count|
|`PartsPreCommitted`|Deprecated. See PartsPreActive.|float|count|
|`PartsTemporary`|The part is generating now, it is not in data_parts list.|float|count|
|`PartsWide`|Wide parts.|float|count|
|`PendingAsyncInsert`|Number of asynchronous inserts that are waiting for flush.|float|count|
|`PostgreSQLConnection`|Number of client connections using PostgreSQL protocol|float|count|
|`Query`|Number of executing queries|float|count|
|`QueryPipelineExecutorThreads`|Number of threads in the PipelineExecutor thread pool.|float|count|
|`QueryPipelineExecutorThreadsActive`|Number of threads in the PipelineExecutor thread pool running a task.|float|count|
|`QueryPreempted`|Number of queries that are stopped and waiting due to 'priority' setting.|float|count|
|`QueryThread`|Number of query processing threads|float|count|
|`RWLockActiveReaders`|Number of threads holding read lock in a table RWLock.|float|count|
|`RWLockActiveWriters`|Number of threads holding write lock in a table RWLock.|float|count|
|`RWLockWaitingReaders`|Number of threads waiting for read on a table RWLock.|float|count|
|`RWLockWaitingWriters`|Number of threads waiting for write on a table RWLock.|float|count|
|`Read`|Number of read (`read`, `pread`, `io_getevents`, etc.) `syscalls` in fly|float|count|
|`ReadTaskRequestsSent`|The current number of callback requests in flight from the remote server back to the initiator server to choose the read task (for s3Cluster table function and similar). Measured on the remote server side.|float|count|
|`ReadonlyReplica`|Number of Replicated tables that are currently in readonly state due to re-initialization after ZooKeeper session loss or due to startup without ZooKeeper configured.|float|count|
|`RemoteRead`|Number of read with remote reader in fly|float|count|
|`ReplicatedChecks`|Number of data parts checking for consistency|float|count|
|`ReplicatedFetch`|Number of data parts being fetched from replica|float|count|
|`ReplicatedSend`|Number of data parts being sent to replicas|float|count|
|`RestartReplicaThreads`|Number of threads in the RESTART REPLICA thread pool.|float|count|
|`RestartReplicaThreadsActive`|Number of threads in the RESTART REPLICA thread pool running a task.|float|count|
|`RestoreThreads`|Number of threads in the thread pool for RESTORE.|float|count|
|`RestoreThreadsActive`|Number of threads in the thread pool for RESTORE running a task.|float|count|
|`Revision`|Revision of the server. It is a number incremented for every release or release candidate except patch releases.|float|count|
|`S3Requests`|S3 requests|float|count|
|`SendExternalTables`|Number of connections that are sending data for external tables to remote servers. External tables are used to implement GLOBAL IN and GLOBAL JOIN operators with distributed `subqueries`.|float|count|
|`SendScalars`|Number of connections that are sending data for scalars to remote servers.|float|count|
|`StartupSystemTablesThreads`|Number of threads in the StartupSystemTables thread pool.|float|count|
|`StartupSystemTablesThreadsActive`|Number of threads in the StartupSystemTables thread pool running a task.|float|count|
|`StorageBufferBytes`|Number of bytes in buffers of Buffer tables|float|B|
|`StorageBufferRows`|Number of rows in buffers of Buffer tables|float|count|
|`StorageDistributedThreads`|Number of threads in the StorageDistributed thread pool.|float|count|
|`StorageDistributedThreadsActive`|Number of threads in the StorageDistributed thread pool running a task.|float|count|
|`StorageHiveThreads`|Number of threads in the StorageHive thread p`threadpool`ool.|float|count|
|`StorageHiveThreadsActive`|Number of threads in the StorageHive thread pool running a task.|float|count|
|`StorageS3Threads`|Number of threads in the StorageS3 thread pool.|float|count|
|`StorageS3ThreadsActive`|Number of threads in the StorageS3 thread pool running a task.|float|count|
|`SyncDrainedConnections`|Number of connections drained synchronously.|float|count|
|`SystemReplicasThreads`|Number of threads in the system.replicas thread pool.|float|count|
|`SystemReplicasThreadsActive`|Number of threads in the system.replicas thread pool running a task.|float|count|
|`TCPConnection`|Number of connections to TCP server (clients with native interface), also included server-server distributed query connections|float|count|
|`TablesLoaderThreads`|Number of threads in the tables loader thread pool.|float|count|
|`TablesLoaderThreadsActive`|Number of threads in the tables loader thread pool running a task.|float|count|
|`TablesToDropQueueSize`|Number of dropped tables, that are waiting for background data removal.|float|count|
|`TemporaryFilesForAggregation`|Number of temporary files created for external aggregation|float|count|
|`TemporaryFilesForJoin`|Number of temporary files created for JOIN|float|count|
|`TemporaryFilesForSort`|Number of temporary files created for external sorting|float|count|
|`TemporaryFilesUnknown`|Number of temporary files created without known purpose|float|count|
|`ThreadPoolFSReaderThreads`|Number of threads in the thread pool for local_filesystem_read_method=`threadpool`.|float|count|
|`ThreadPoolFSReaderThreadsActive`|Number of threads in the thread pool for local_filesystem_read_method=`threadpool` running a task.|float|count|
|`ThreadPoolRemoteFSReaderThreads`|Number of threads in the thread pool for remote_filesystem_read_method=`threadpool`.|float|count|
|`ThreadPoolRemoteFSReaderThreadsActive`|Number of threads in the thread pool for remote_filesystem_read_method=`threadpool` running a task.|float|count|
|`ThreadsInOvercommitTracker`|Number of waiting threads inside of `OvercommitTracker`|float|count|
|`TotalTemporaryFiles`|Number of temporary files created|float|count|
|`VersionInteger`|Version of the server in a single integer number in base-1000. For example, version 11.22.33 is translated to 11022033.|float|count|
|`Write`|Number of write (`write`/`pwrite`/`io_getevents`, etc.) `syscalls` in fly|float|count|
|`ZooKeeperRequest`|Number of requests to ZooKeeper in fly.|float|count|
|`ZooKeeperSession`|Number of sessions (connections) to ZooKeeper. Should be no more than one, because using more than one connection to ZooKeeper may lead to bugs due to lack of `linearizability` (stale reads) that ZooKeeper consistency model allows.|float|count|
|`ZooKeeperWatch`|Number of watches (event subscriptions) in ZooKeeper.|float|count|






### `ClickHouseProfileEvents`



- 标签


| Tag | Description |
|  ----  | --------|
|`host`|Host name|
|`instance`|Instance endpoint|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`AIORead`|Number of reads with Linux or FreeBSD AIO interface|float|count|
|`AIOReadBytes`|Number of bytes read with Linux or FreeBSD AIO interface|float|B|
|`AIOWrite`|Number of writes with Linux or FreeBSD AIO interface|float|count|
|`AIOWriteBytes`|Number of bytes written with Linux or FreeBSD AIO interface|float|B|
|`AggregationHashTablesInitializedAsTwoLevel`|How many hash tables were `inited` as two-level for aggregation.|float|count|
|`AggregationPreallocatedElementsInHashTables`|How many elements were preallocated in hash tables for aggregation.|float|count|
|`ArenaAllocBytes`|Number of bytes allocated for memory Arena (used for GROUP BY and similar operations)|float|count|
|`ArenaAllocChunks`|Number of chunks allocated for memory Arena (used for GROUP BY and similar operations)|float|count|
|`AsyncInsertBytes`|Data size in bytes of asynchronous INSERT queries.|float|B|
|`AsyncInsertCacheHits`|Number of times a duplicate hash id has been found in asynchronous INSERT hash id cache.|float|count|
|`AsyncInsertQuery`|Same as InsertQuery, but only for asynchronous INSERT queries.|float|count|
|`AsynchronousReadWaitMicroseconds`|Time spent in waiting for asynchronous reads.|float|ms|
|`AsynchronousRemoteReadWaitMicroseconds`|Time spent in waiting for asynchronous remote reads.|float|ms|
|`BackgroundLoadingMarksTasks`|Number of background tasks for loading marks|float|count|
|`CachedReadBufferCacheWriteBytes`|Bytes written from source (remote fs, etc) to filesystem cache|float|B|
|`CachedReadBufferCacheWriteMicroseconds`|Time spent writing data into filesystem cache|float|ms|
|`CachedReadBufferReadFromCacheBytes`|Bytes read from filesystem cache|float|B|
|`CachedReadBufferReadFromCacheMicroseconds`|Time reading from filesystem cache|float|ms|
|`CachedReadBufferReadFromSourceBytes`|Bytes read from filesystem cache source (from remote fs, etc)|float|B|
|`CachedReadBufferReadFromSourceMicroseconds`|Time reading from filesystem cache source (from remote filesystem, etc)|float|ms|
|`CachedWriteBufferCacheWriteBytes`|Bytes written from source (remote fs, etc) to filesystem cache|float|B|
|`CachedWriteBufferCacheWriteMicroseconds`|Time spent writing data into filesystem cache|float|ms|
|`CannotRemoveEphemeralNode`|Number of times an error happened while trying to remove ephemeral node. This is not an issue, because our implementation of ZooKeeper library guarantee that the session will expire and the node will be removed.|float|count|
|`CannotWriteToWriteBufferDiscard`|Number of stack traces dropped by query profiler or signal handler because pipe is full or cannot write to pipe.|float|count|
|`CompileExpressionsBytes`|Number of bytes used for expressions compilation.|float|B|
|`CompileExpressionsMicroseconds`|Total time spent for compilation of expressions to LLVM code.|float|ms|
|`CompileFunction`|Number of times a compilation of generated LLVM code (to create fused function for complex expressions) was initiated.|float|count|
|`CompiledFunctionExecute`|Number of times a compiled function was executed.|float|count|
|`CompressedReadBufferBlocks`|Number of compressed blocks (the blocks of data that are compressed independent of each other) read from compressed sources (files, network).|float|count|
|`CompressedReadBufferBytes`|Number of uncompressed bytes (the number of bytes after decompression) read from compressed sources (files, network).|float|B|
|`ContextLock`|Number of times the lock of Context was acquired or tried to acquire. This is global lock.|float|count|
|`CreatedHTTPConnections`|Total amount of created HTTP connections (counter increase every time connection is created).|float|count|
|`CreatedLogEntryForMerge`|Successfully created log entry to merge parts in ReplicatedMergeTree.|float|count|
|`CreatedLogEntryForMutation`|Successfully created log entry to mutate parts in ReplicatedMergeTree.|float|count|
|`CreatedReadBufferAIO`|Created read buffer AIO|float|count|
|`CreatedReadBufferAIOFailed`|Created read buffer AIO Failed|float|count|
|`CreatedReadBufferDirectIO`|Number of times a read buffer with O_DIRECT was created for reading data (while choosing among other read methods).|float|count|
|`CreatedReadBufferDirectIOFailed`|Number of times a read buffer with O_DIRECT was attempted to be created for reading data (while choosing among other read methods), but the OS did not allow it (due to lack of filesystem support or other reasons) and we fallen back to the ordinary reading method.|float|count|
|`CreatedReadBufferMMap`|Number of times a read buffer using `mmap` was created for reading data (while choosing among other read methods).|float|count|
|`CreatedReadBufferMMapFailed`|Number of times a read buffer with `mmap` was attempted to be created for reading data (while choosing among other read methods), but the OS did not allow it (due to lack of filesystem support or other reasons) and we fallen back to the ordinary reading method.|float|count|
|`CreatedReadBufferOrdinary`|Number of times ordinary read buffer was created for reading data (while choosing among other read methods).|float|count|
|`DNSError`|Total count of errors in DNS resolution|float|count|
|`DataAfterMergeDiffersFromReplica`|Number of times data after merge is not byte-identical to the data on another replicas. There could be several reasons|float|count|
|`DataAfterMutationDiffersFromReplica`|Number of times data after mutation is not byte-identical to the data on another replicas. In addition to the reasons described in 'DataAfterMergeDiffersFromReplica', it is also possible due to non-deterministic mutation.|float|count|
|`DelayedInserts`|Number of times the INSERT of a block to a MergeTree table was throttled due to high number of active data parts for partition.|float|count|
|`DelayedInsertsMilliseconds`|Total number of milliseconds spent while the INSERT of a block to a MergeTree table was throttled due to high number of active data parts for partition.|float|ms|
|`DictCacheKeysExpired`|Number of keys looked up in the dictionaries of 'cache' types and found in the cache but they were obsolete.|float|count|
|`DictCacheKeysHit`|Number of keys looked up in the dictionaries of 'cache' types and found in the cache.|float|count|
|`DictCacheKeysNotFound`|Number of keys looked up in the dictionaries of 'cache' types and not found.|float|count|
|`DictCacheKeysRequested`|Number of keys requested from the data source for the dictionaries of 'cache' types.|float|count|
|`DictCacheKeysRequestedFound`|Number of keys requested from the data source for dictionaries of 'cache' types and found in the data source.|float|count|
|`DictCacheKeysRequestedMiss`|Number of keys requested from the data source for dictionaries of 'cache' types but not found in the data source.|float|count|
|`DictCacheLockReadNs`|Number of nanoseconds spend in waiting for read lock to lookup the data for the dictionaries of 'cache' types.|float|ms|
|`DictCacheLockWriteNs`|Number of nanoseconds spend in waiting for write lock to update the data for the dictionaries of 'cache' types.|float|ms|
|`DictCacheRequestTimeNs`|Number of nanoseconds spend in querying the external data sources for the dictionaries of 'cache' types.|float|ms|
|`DictCacheRequests`|Number of bulk requests to the external data sources for the dictionaries of 'cache' types.|float|count|
|`DirectorySync`|Number of times the `F_FULLFSYNC/fsync/fdatasync` function was called for directories.|float|count|
|`DirectorySyncElapsedMicroseconds`|Total time spent waiting for `F_FULLFSYNC/fsync/fdatasync` syscall for directories.|float|ms|
|`DiskReadElapsedMicroseconds`|Total time spent waiting for read syscall. This include reads from page cache.|float|ms|
|`DiskS3AbortMultipartUpload`|Number of DiskS3 API AbortMultipartUpload calls.|float|count|
|`DiskS3CompleteMultipartUpload`|Number of DiskS3 API CompleteMultipartUpload calls.|float|count|
|`DiskS3CopyObject`|Number of DiskS3 API CopyObject calls.|float|count|
|`DiskS3CreateMultipartUpload`|Number of DiskS3 API CreateMultipartUpload calls.|float|count|
|`DiskS3DeleteObjects`|Number of DiskS3 API DeleteObject(s) calls.|float|count|
|`DiskS3GetObject`|Number of DiskS3 API GetObject calls.|float|count|
|`DiskS3GetObjectAttributes`|Number of DiskS3 API GetObjectAttributes calls.|float|count|
|`DiskS3GetRequestThrottlerCount`|Number of DiskS3 GET and SELECT requests passed through throttler.|float|count|
|`DiskS3GetRequestThrottlerSleepMicroseconds`|Total time a query was sleeping to conform DiskS3 GET and SELECT request throttling.|float|ms|
|`DiskS3HeadObject`|Number of DiskS3 API HeadObject calls.|float|count|
|`DiskS3ListObjects`|Number of DiskS3 API ListObjects calls.|float|count|
|`DiskS3PutObject`|Number of DiskS3 API PutObject calls.|float|count|
|`DiskS3PutRequestThrottlerCount`|Number of DiskS3 PUT, COPY, POST and LIST requests passed through throttler.|float|count|
|`DiskS3PutRequestThrottlerSleepMicroseconds`|Total time a query was sleeping to conform DiskS3 PUT, COPY, POST and LIST request throttling.|float|ms|
|`DiskS3ReadMicroseconds`|Time of GET and HEAD requests to DiskS3 storage.|float|ms|
|`DiskS3ReadRequestsCount`|Number of GET and HEAD requests to DiskS3 storage.|float|count|
|`DiskS3ReadRequestsErrors`|Number of non-throttling errors in GET and HEAD requests to DiskS3 storage.|float|count|
|`DiskS3ReadRequestsRedirects`|Number of redirects in GET and HEAD requests to DiskS3 storage.|float|count|
|`DiskS3ReadRequestsThrottling`|Number of 429 and 503 errors in GET and HEAD requests to DiskS3 storage.|float|count|
|`DiskS3UploadPart`|Number of DiskS3 API UploadPart calls.|float|count|
|`DiskS3UploadPartCopy`|Number of DiskS3 API UploadPartCopy calls.|float|count|
|`DiskS3WriteMicroseconds`|Time of POST, DELETE, PUT and PATCH requests to DiskS3 storage.|float|count|
|`DiskS3WriteRequestsCount`|Number of POST, DELETE, PUT and PATCH requests to DiskS3 storage.|float|count|
|`DiskS3WriteRequestsErrors`|Number of non-throttling errors in POST, DELETE, PUT and PATCH requests to DiskS3 storage.|float|count|
|`DiskS3WriteRequestsRedirects`|Number of redirects in POST, DELETE, PUT and PATCH requests to DiskS3 storage.|float|count|
|`DiskS3WriteRequestsThrottling`|Number of 429 and 503 errors in POST, DELETE, PUT and PATCH requests to DiskS3 storage.|float|count|
|`DiskWriteElapsedMicroseconds`|Total time spent waiting for write syscall. This include writes to page cache.|float|ms|
|`DistributedConnectionFailAtAll`|Total count when distributed connection fails after all retries finished.|float|ms|
|`DistributedConnectionFailTry`|Total count when distributed connection fails with retry.|float|ms|
|`DistributedConnectionMissingTable`|Number of times we rejected a replica from a distributed query, because it did not contain a table needed for the query.|float|count|
|`DistributedConnectionStaleReplica`|Number of times we rejected a replica from a distributed query, because some table needed for a query had replication lag higher than the configured threshold.|float|count|
|`DistributedDelayedInserts`|Number of times the INSERT of a block to a Distributed table was throttled due to high number of pending bytes.|float|count|
|`DistributedDelayedInsertsMilliseconds`|Total number of milliseconds spent while the INSERT of a block to a Distributed table was throttled due to high number of pending bytes.|float|ms|
|`DistributedRejectedInserts`|Number of times the INSERT of a block to a Distributed table was rejected with 'Too many bytes' exception due to high number of pending bytes.|float|count|
|`DistributedSyncInsertionTimeoutExceeded`|A timeout has exceeded while waiting for shards during synchronous insertion into a Distributed table (with 'insert_distributed_sync' = 1)|float|count|
|`DuplicatedInsertedBlocks`|Number of times the INSERTed block to a ReplicatedMergeTree table was deduplicated.|float|count|
|`ExecuteShellCommand`|Number of shell command executions.|float|count|
|`ExternalAggregationCompressedBytes`|Number of bytes written to disk for aggregation in external memory.|float|B|
|`ExternalAggregationMerge`|Number of times temporary files were merged for aggregation in external memory.|float|count|
|`ExternalAggregationUncompressedBytes`|Amount of data (uncompressed, before compression) written to disk for aggregation in external memory.|float|B|
|`ExternalAggregationWritePart`|Number of times a temporary file was written to disk for aggregation in external memory.|float|count|
|`ExternalDataSourceLocalCacheReadBytes`|Bytes read from local cache buffer in RemoteReadBufferCache|float|B|
|`ExternalJoinCompressedBytes`|Number of compressed bytes written for JOIN in external memory.|float|B|
|`ExternalJoinMerge`|Number of times temporary files were merged for JOIN in external memory.|float|count|
|`ExternalJoinUncompressedBytes`|Amount of data (uncompressed, before compression) written for JOIN in external memory.|float|B|
|`ExternalJoinWritePart`|Number of times a temporary file was written to disk for JOIN in external memory.|float|count|
|`ExternalProcessingCompressedBytesTotal`|Number of compressed bytes written by external processing (sorting/aggravating/joining)|float|B|
|`ExternalProcessingFilesTotal`|Number of files used by external processing (sorting/aggravating/joining)|float|count|
|`ExternalProcessingUncompressedBytesTotal`|Amount of data (uncompressed, before compression) written by external processing (sorting/aggravating/joining)|float|B|
|`ExternalSortCompressedBytes`|Number of compressed bytes written for sorting in external memory.|float|B|
|`ExternalSortMerge`|Number of times temporary files were merged for sorting in external memory.|float|count|
|`ExternalSortUncompressedBytes`|Amount of data (uncompressed, before compression) written for sorting in external memory.|float|B|
|`ExternalSortWritePart`|Number of times a temporary file was written to disk for sorting in external memory.|float|count|
|`FailedAsyncInsertQuery`|Number of failed ASYNC INSERT queries.|float|count|
|`FailedInsertQuery`|Same as FailedQuery, but only for INSERT queries.|float|count|
|`FailedQuery`|Number of failed queries.|float|count|
|`FailedSelectQuery`|Same as FailedQuery, but only for SELECT queries.|float|count|
|`FileOpen`|Number of files opened.|float|count|
|`FileSegmentCacheWriteMicroseconds`|Metric per file segment. Time spend writing data to cache|float|ms|
|`FileSegmentPredownloadMicroseconds`|Metric per file segment. Time spent `predownloading` data to cache (`predownloading` - finishing file segment download (after someone who failed to do that) up to the point current thread was requested to do)|float|ms|
|`FileSegmentReadMicroseconds`|Metric per file segment. Time spend reading from file|float|ms|
|`FileSegmentUsedBytes`|Metric per file segment. How many bytes were actually used from current file segment|float|B|
|`FileSegmentWaitReadBufferMicroseconds`|Metric per file segment. Time spend waiting for internal read buffer (includes cache waiting)|float|ms|
|`FileSegmentWriteMicroseconds`|Metric per file segment. Time spend writing cache|float|ms|
|`FileSync`|Number of times the `F_FULLFSYNC/fsync/fdatasync` function was called for files.|float|count|
|`FileSyncElapsedMicroseconds`|Total time spent waiting for `F_FULLFSYNC/fsync/fdatasync` syscall for files.|float|ms|
|`FunctionExecute`|Number of SQL ordinary function calls (SQL functions are called on per-block basis, so this number represents the number of blocks).|float|count|
|`HardPageFaults`|The number of hard page faults in query execution threads. High values indicate either that you forgot to turn off swap on your server, or eviction of memory pages of the ClickHouse binary during very high memory pressure, or successful usage of the `mmap` read method for the tables data.|float|count|
|`HedgedRequestsChangeReplica`|Total count when timeout for changing replica expired in hedged requests.|float|count|
|`IOBufferAllocBytes`|Number of bytes allocated for IO buffers (for ReadBuffer/WriteBuffer).|float|B|
|`IOBufferAllocs`|Number of allocations of IO buffers (for ReadBuffer/WriteBuffer).|float|count|
|`IOUringCQEsCompleted`|Total number of successfully completed io_uring CQEs|float|count|
|`IOUringCQEsFailed`|Total number of completed io_uring CQEs with failures|float|count|
|`IOUringSQEsResubmits`|Total number of io_uring SQE resubmits performed|float|count|
|`IOUringSQEsSubmitted`|Total number of io_uring SQEs submitted|float|count|
|`InsertQuery`|Same as Query, but only for INSERT queries.|float|count|
|`InsertQueryTimeMicroseconds`|Total time of INSERT queries.|float|ms|
|`InsertedBytes`|Number of bytes (uncompressed; for columns as they stored in memory) INSERTed to all tables.|float|B|
|`InsertedCompactParts`|Number of parts inserted in Compact format.|float|count|
|`InsertedInMemoryParts`|Number of parts inserted in InMemory format.|float|count|
|`InsertedRows`|Number of rows INSERTed to all tables.|float|count|
|`InsertedWideParts`|Number of parts inserted in Wide format.|float|count|
|`InvoluntaryContextSwitches`|Involuntary context switches|float|count|
|`KafkaBackgroundReads`|Number of background reads populating materialized views from Kafka since server start|float|count|
|`KafkaCommitFailures`|Number of failed commits of consumed offsets to Kafka (usually is a sign of some data duplication)|float|count|
|`KafkaCommits`|Number of successful commits of consumed offsets to Kafka (normally should be the same as KafkaBackgroundReads)|float|count|
|`KafkaConsumerErrors`|Number of errors reported by `librdkafka` during polls|float|count|
|`KafkaDirectReads`|Number of direct selects from Kafka tables since server start|float|count|
|`KafkaMessagesFailed`|Number of Kafka messages ClickHouse failed to parse|float|count|
|`KafkaMessagesPolled`|Number of Kafka messages polled from `librdkafka` to ClickHouse|float|count|
|`KafkaMessagesProduced`|Number of messages produced to Kafka|float|count|
|`KafkaMessagesRead`|Number of Kafka messages already processed by ClickHouse|float|count|
|`KafkaProducerErrors`|Number of errors during producing the messages to Kafka|float|count|
|`KafkaProducerFlushes`|Number of explicit flushes to Kafka producer|float|count|
|`KafkaRebalanceAssignments`|Number of partition assignments (the final stage of consumer group `rebalance`)|float|count|
|`KafkaRebalanceErrors`|Number of failed consumer group `rebalances`|float|count|
|`KafkaRebalanceRevocations`|Number of partition revocations (the first stage of consumer group `rebalance`)|float|count|
|`KafkaRowsRead`|Number of rows parsed from Kafka messages|float|count|
|`KafkaRowsRejected`|Number of parsed rows which were later rejected (due to `rebalances` / errors or similar reasons). Those rows will be consumed again after the `rebalance`.|float|count|
|`KafkaRowsWritten`|Number of rows inserted into Kafka tables|float|count|
|`KafkaWrites`|Number of writes (inserts) to Kafka tables |float|count|
|`KeeperCheckRequest`|Number of check requests|float|count|
|`KeeperCommits`|Number of successful commits|float|count|
|`KeeperCommitsFailed`|Number of failed commits|float|count|
|`KeeperCreateRequest`|Number of create requests|float|count|
|`KeeperExistsRequest`|Number of exists requests|float|count|
|`KeeperGetRequest`|Number of get requests|float|count|
|`KeeperLatency`|Keeper latency|float|count|
|`KeeperListRequest`|Number of list requests|float|count|
|`KeeperMultiReadRequest`|Number of multi read requests|float|count|
|`KeeperMultiRequest`|Number of multi requests|float|count|
|`KeeperPacketsReceived`|Packets received by keeper server|float|count|
|`KeeperPacketsSent`|Packets sent by keeper server|float|count|
|`KeeperReadSnapshot`|Number of snapshot read(serialization)|float|count|
|`KeeperRemoveRequest`|Number of remove requests|float|count|
|`KeeperRequestTotal`|Total requests number on keeper server|float|count|
|`KeeperSaveSnapshot`|Number of snapshot save|float|count|
|`KeeperSetRequest`|Number of set requests|float|count|
|`KeeperSnapshotApplys`|Number of snapshot applying|float|count|
|`KeeperSnapshotApplysFailed`|Number of failed snapshot applying|float|count|
|`KeeperSnapshotCreations`|Number of snapshots creations|float|count|
|`KeeperSnapshotCreationsFailed`|Number of failed snapshot creations|float|count|
|`LoadedMarksCount`|Number of marks loaded (total across columns).|float|count|
|`LoadedMarksMemoryBytes`|Size of in-memory representations of loaded marks.|float|B|
|`LocalReadThrottlerBytes`|Bytes passed through 'max_local_read_bandwidth_for_server'/'max_local_read_bandwidth' throttler.|float|B|
|`LocalReadThrottlerSleepMicroseconds`|Total time a query was sleeping to conform 'max_local_read_bandwidth_for_server'/'max_local_read_bandwidth' throttling.|float|ms|
|`LocalWriteThrottlerBytes`|Bytes passed through 'max_local_write_bandwidth_for_server'/'max_local_write_bandwidth' throttler.|float|B|
|`LocalWriteThrottlerSleepMicroseconds`|Total time a query was sleeping to conform 'max_local_write_bandwidth_for_server'/'max_local_write_bandwidth' throttling.|float|ms|
|`LogDebug`|Number of log messages with level Debug|float|count|
|`LogError`|Number of log messages with level Error|float|count|
|`LogFatal`|Number of log messages with level Fatal|float|count|
|`LogInfo`|Number of log messages with level Info|float|count|
|`LogTest`|Number of log messages with level Test|float|count|
|`LogTrace`|Number of log messages with level Trace|float|count|
|`LogWarning`|Number of log messages with level Warning|float|count|
|`MMappedFileCacheHits`|Number of times a file has been found in the MMap cache (for the `mmap` read_method), so we didn't have to `mmap` it again.|float|count|
|`MMappedFileCacheMisses`|Number of times a file has not been found in the MMap cache (for the `mmap` read_method), so we had to `mmap` it again.|float|count|
|`MainConfigLoads`|Number of times the main configuration was reloaded.|float|count|
|`MarkCacheHits`|Number of times an entry has been found in the mark cache, so we didn't have to load a mark file.|float|count|
|`MarkCacheMisses`|Number of times an entry has not been found in the mark cache, so we had to load a mark file in memory, which is a costly operation, adding to query latency.|float|count|
|`MemoryAllocatorPurge`|Total number of times memory allocator purge was requested|float|ms|
|`MemoryAllocatorPurgeTimeMicroseconds`|Total number of times memory allocator purge was requested|float|ms|
|`MemoryOvercommitWaitTimeMicroseconds`|Total time spent in waiting for memory to be freed in `OvercommitTracker`.|float|ms|
|`Merge`|Number of launched background merges.|float|count|
|`MergeTreeAllRangesAnnouncementsSent`|The number of announcement sent from the remote server to the initiator server about the set of data parts (for MergeTree tables). Measured on the remote server side.|float|count|
|`MergeTreeAllRangesAnnouncementsSentElapsedMicroseconds`|Time spent in sending the announcement from the remote server to the initiator server about the set of data parts (for MergeTree tables). Measured on the remote server side.|float|ms|
|`MergeTreeDataProjectionWriterBlocks`|Number of blocks INSERTed to MergeTree tables projection. Each block forms a data part of level zero.|float|count|
|`MergeTreeDataProjectionWriterBlocksAlreadySorted`|Number of blocks INSERTed to MergeTree tables projection that appeared to be already sorted.|float|count|
|`MergeTreeDataProjectionWriterCompressedBytes`|Bytes written to filesystem for data INSERTed to MergeTree tables projection.|float|B|
|`MergeTreeDataProjectionWriterRows`|Number of rows INSERTed to MergeTree tables projection.|float|count|
|`MergeTreeDataProjectionWriterUncompressedBytes`|Uncompressed bytes (for columns as they stored in memory) INSERTed to MergeTree tables projection.|float|B|
|`MergeTreeDataWriterBlocks`|Number of blocks INSERTed to MergeTree tables. Each block forms a data part of level zero.|float|count|
|`MergeTreeDataWriterBlocksAlreadySorted`|Number of blocks INSERTed to MergeTree tables that appeared to be already sorted.|float|count|
|`MergeTreeDataWriterCompressedBytes`|Bytes written to filesystem for data INSERTed to MergeTree tables.|float|B|
|`MergeTreeDataWriterRows`|Number of rows INSERTed to MergeTree tables.|float|count|
|`MergeTreeDataWriterUncompressedBytes`|Uncompressed bytes (for columns as they stored in memory) INSERTed to MergeTree tables.|float|B|
|`MergeTreeMetadataCacheDelete`|Number of `rocksdb` deletes(used for merge tree metadata cache)|float|count|
|`MergeTreeMetadataCacheGet`|Number of `rocksdb` reads(used for merge tree metadata cache)|float|count|
|`MergeTreeMetadataCacheHit`|Number of times the read of meta file was done from MergeTree metadata cache|float|count|
|`MergeTreeMetadataCacheMiss`|Number of times the read of meta file was not done from MergeTree metadata cache|float|count|
|`MergeTreeMetadataCachePut`|Number of `rocksdb` puts(used for merge tree metadata cache)|float|count|
|`MergeTreeMetadataCacheSeek`|Number of `rocksdb` seeks(used for merge tree metadata cache)|float|count|
|`MergeTreePrefetchedReadPoolInit`|Time spent preparing tasks in MergeTreePrefetchedReadPool|float|ms|
|`MergeTreeReadTaskRequestsReceived`|The number of callbacks requested from the remote server back to the initiator server to choose the read task (for MergeTree tables). Measured on the initiator server side.|float|count|
|`MergeTreeReadTaskRequestsSent`|The number of callbacks requested from the remote server back to the initiator server to choose the read task (for MergeTree tables). Measured on the remote server side.|float|count|
|`MergeTreeReadTaskRequestsSentElapsedMicroseconds`|Time spent in callbacks requested from the remote server back to the initiator server to choose the read task (for MergeTree tables). Measured on the remote server side.|float|count|
|`MergedIntoCompactParts`|Number of parts merged into Compact format.|float|count|
|`MergedIntoInMemoryParts`|Number of parts in merged into InMemory format.|float|count|
|`MergedIntoWideParts`|Number of parts merged into Wide format.|float|count|
|`MergedRows`|Rows read for background merges. This is the number of rows before merge.|float|count|
|`MergedUncompressedBytes`|Uncompressed bytes (for columns as they stored in memory) that was read for background merges. This is the number before merge.|float|B|
|`MergesTimeMilliseconds`|Total time spent for background merges.|float|ms|
|`NetworkReceiveBytes`|Total number of bytes received from network. Only ClickHouse-related network interaction is included, not by 3rd party libraries.|float|B|
|`NetworkReceiveElapsedMicroseconds`|Total time spent waiting for data to receive or receiving data from network. Only ClickHouse-related network interaction is included, not by 3rd party libraries.|float|ms|
|`NetworkSendBytes`|Total number of bytes send to network. Only ClickHouse-related network interaction is included, not by 3rd party libraries.|float|B|
|`NetworkSendElapsedMicroseconds`|Total time spent waiting for data to send to network or sending data to network. Only ClickHouse-related network interaction is included, not by 3rd party libraries.|float|ms|
|`NotCreatedLogEntryForMerge`|Log entry to merge parts in ReplicatedMergeTree is not created due to concurrent log update by another replica.|float|count|
|`NotCreatedLogEntryForMutation`|Log entry to mutate parts in ReplicatedMergeTree is not created due to concurrent log update by another replica.|float|count|
|`OSCPUVirtualTimeMicroseconds`|CPU time spent seen by OS. Does not include involuntary waits due to virtualization.|float|ms|
|`OSCPUWaitMicroseconds`|Total time a thread was ready for execution but waiting to be scheduled by OS, from the OS point of view.|float|ms|
|`OSIOWaitMicroseconds`|Total time a thread spent waiting for a result of IO operation, from the OS point of view. This is real IO that does not include page cache.|float|ms|
|`OSReadBytes`|Number of bytes read from disks or block devices. Does not include bytes read from page cache. May include excessive data due to block size, `readahead`, etc.|float|B|
|`OSReadChars`|Number of bytes read from filesystem, including page cache.|float|B|
|`OSWriteBytes`|Number of bytes written to disks or block devices. Does not include bytes that are in page cache dirty pages. May not include data that was written by OS asynchronously.|float|B|
|`OSWriteChars`|Number of bytes written to filesystem, including page cache.|float|B|
|`ObsoleteReplicatedParts`|Number of times a data part was covered by another data part that has been fetched from a replica (so, we have marked a covered data part as obsolete and no longer needed).|float|count|
|`OpenedFileCacheHits`|Number of times a file has been found in the opened file cache, so we didn't have to open it again.|float|count|
|`OpenedFileCacheMisses`|Number of times a file has been found in the opened file cache, so we had to open it again.|float|count|
|`OtherQueryTimeMicroseconds`|Total time of queries that are not SELECT or INSERT.|float|ms|
|`OverflowAny`|Number of times approximate GROUP BY was in effect: when aggregation was performed only on top of first 'max_rows_to_group_by' unique keys and other keys were ignored due to 'group_by_overflow_mode' = 'any'.|float|count|
|`OverflowBreak`|Number of times, data processing was canceled by query complexity limitation with setting '*_overflow_mode' = 'break' and the result is incomplete.|float|count|
|`OverflowThrow`|Number of times, data processing was canceled by query complexity limitation with setting '*_overflow_mode' = 'throw' and exception was thrown.|float|count|
|`PerfAlignmentFaults`|Number of alignment faults. These happen when unaligned memory accesses happen; the kernel can handle these but it reduces performance. This happens only on some architectures (never on x86).|float|count|
|`PerfBranchInstructions`|Retired branch instructions. Prior to Linux 2.6.35, this used the wrong event on AMD processors.|float|count|
|`PerfBranchMisses`|`Mispredicted` branch instructions.|float|count|
|`PerfBusCycles`|Bus cycles, which can be different from total cycles.|float|count|
|`PerfCacheMisses`|Cache misses. Usually this indicates Last Level Cache misses; this is intended to be used in con-junction with the `PERFCOUNTHWCACHEREFERENCES` event to calculate cache miss rates.|float|count|
|`PerfCacheReferences`|Cache accesses. Usually this indicates Last Level Cache accesses but this may vary depending on your CPU. This may include prefetches and coherency messages; again this depends on the design of your CPU.|float|count|
|`PerfContextSwitches`|Number of context switches|float|count|
|`PerfCpuClock`|The CPU clock, a high-resolution per-CPU timer|float|count|
|`PerfCpuCycles`|Total cycles. Be wary of what happens during CPU frequency scaling.|float|count|
|`PerfCpuMigrations`|Number of times the process has migrated to a new CPU|float|count|
|`PerfDataTLBMisses`|Data TLB misses|float|count|
|`PerfDataTLBReferences`|Data TLB references|float|count|
|`PerfEmulationFaults`|Number of emulation faults. The kernel sometimes traps on unimplemented instructions and emulates them for user space. This can negatively impact performance.|float|count|
|`PerfInstructionTLBMisses`|Instruction TLB misses|float|count|
|`PerfInstructionTLBReferences`|Instruction TLB references|float|count|
|`PerfInstructions`|Retired instructions. Be careful, these can be affected by various issues, most notably hardware interrupt counts.|float|count|
|`PerfLocalMemoryMisses`|Local NUMA node memory read `missesubqueriess`|float|B|
|`PerfLocalMemoryReferences`|Local NUMA node memory reads|float|B|
|`PerfMinEnabledRunningTime`|Running time for event with minimum enabled time. Used to track the amount of event multiplexing|float|ms|
|`PerfMinEnabledTime`|For all events, minimum time that an event was enabled. Used to track event multiplexing influence|float|ms|
|`PerfRefCpuCycles`|Total cycles; not affected by CPU frequency scaling.|float|count|
|`PerfStalledCyclesBackend`|Stalled cycles during retirement.|float|count|
|`PerfStalledCyclesFrontend`|Stalled cycles during issue.|float|count|
|`PerfTaskClock`|A clock count specific to the task that is running|float|count|
|`PolygonsAddedToPool`|A polygon has been added to the cache (pool) for the 'pointInPolygon' function.|float|count|
|`PolygonsInPoolAllocatedBytes`|The number of bytes for polygons added to the cache (pool) for the 'pointInPolygon' function.|float|B|
|`Query`|Number of queries to be interpreted and potentially executed. Does not include queries that failed to parse or were rejected due to AST size limits, quota limits or limits on the number of simultaneously running queries. May include internal queries initiated by ClickHouse itself. Does not count `subqueries`.|float|count|
|`QueryCacheHits`|Number of times a query result has been found in the query cache (and query computation was avoided).|float|count|
|`QueryCacheMisses`|Number of times a query result has not been found in the query cache (and required query computation).|float|count|
|`QueryMaskingRulesMatch`|Number of times query masking rules was successfully matched.|float|count|
|`QueryMemoryLimitExceeded`|Number of times when memory limit exceeded for query.|float|count|
|`QueryProfilerRuns`|Number of times QueryProfiler had been run.|float|count|
|`QueryProfilerSignalOverruns`|Number of times we drop processing of a query profiler signal due to overrun plus the number of signals that OS has not delivered due to overrun.|float|count|
|`QueryTimeMicroseconds`|Total time of all queries.|float|ms|
|`RWLockAcquiredReadLocks`|Number of times a read lock was acquired (in a heavy RWLock).|float|count|
|`RWLockAcquiredWriteLocks`|Number of times a write lock was acquired (in a heavy RWLock).|float|count|
|`RWLockReadersWaitMilliseconds`|Total time spent waiting for a read lock to be acquired (in a heavy RWLock).|float|ms|
|`RWLockWritersWaitMilliseconds`|Total time spent waiting for a write lock to be acquired (in a heavy RWLock).|float|ms|
|`ReadBackoff`|Number of times the number of query processing threads was lowered due to slow reads.|float|count|
|`ReadBufferAIORead`|Read buffer AIO read|float|count|
|`ReadBufferAIOReadBytes`|Read buffer AIO read bytes|float|B|
|`ReadBufferFromFileDescriptorRead`|Number of reads (`read`/`pread`) from a file descriptor. Does not include sockets.|float|count|
|`ReadBufferFromFileDescriptorReadBytes`|Number of bytes read from file descriptors. If the file is compressed, this will show the compressed data size.|float|B|
|`ReadBufferFromFileDescriptorReadFailed`|Number of times the read (`read`/`pread`) from a file descriptor have failed.|float|count|
|`ReadBufferFromS3Bytes`|Bytes read from S3.|float|B|
|`ReadBufferFromS3InitMicroseconds`|Time spent initializing connection to S3.|float|ms|
|`ReadBufferFromS3Microseconds`|Time spent on reading from S3.|float|ms|
|`ReadBufferFromS3RequestsErrors`|Number of exceptions while reading from S3.|float|count|
|`ReadBufferSeekCancelConnection`|Number of seeks which lead to new connection (s3, http)|float|count|
|`ReadCompressedBytes`|Number of bytes (the number of bytes before decompression) read from compressed sources (files, network).|float|B|
|`ReadTaskRequestsReceived`|The number of callbacks requested from the remote server back to the initiator server to choose the read task (for s3Cluster table function and similar). Measured on the initiator server side.|float|count|
|`ReadTaskRequestsSent`|The number of callbacks requested from the remote server back to the initiator server to choose the read task (for s3Cluster table function and similar). Measured on the remote server side.|float|count|
|`ReadTaskRequestsSentElapsedMicroseconds`|Time spent in callbacks requested from the remote server back to the initiator server to choose the read task (for s3Cluster table function and similar). Measured on the remote server side.|float|ms|
|`RealTimeMicroseconds`|Total (wall clock) time spent in processing (queries and other tasks) threads (note that this is a sum).|float|ms|
|`RegexpCreated`|Compiled regular expressions. Identical regular expressions compiled just once and cached forever.|float|count|
|`RejectedInserts`|Number of times the INSERT of a block to a MergeTree table was rejected with 'Too many parts' exception due to high number of active data parts for partition.|float|count|
|`RemoteFSBuffers`|Number of buffers created for asynchronous reading from remote filesystem|float|count|
|`RemoteFSCancelledPrefetches`|Number of canceled `prefecthes` (because of seek)|float|count|
|`RemoteFSLazySeeks`|Number of lazy seeks|float|count|
|`RemoteFSPrefetchedBytes`|Number of bytes from prefetched buffer|float|count|
|`RemoteFSPrefetchedReads`|Number of reads from prefetched buffer|float|count|
|`RemoteFSPrefetches`|Number of prefetches made with asynchronous reading from remote filesystem|float|count|
|`RemoteFSSeeks`|Total number of seeks for async buffer|float|count|
|`RemoteFSSeeksWithReset`|Number of seeks which lead to a new connection|float|count|
|`RemoteFSUnprefetchedBytes`|Number of bytes from un prefetched buffer|float|B|
|`RemoteFSUnprefetchedReads`|Number of reads from un prefetched buffer|float|count|
|`RemoteFSUnusedPrefetches`|Number of prefetches pending at buffer destruction|float|count|
|`RemoteReadThrottlerBytes`|Bytes passed through 'max_remote_read_network_bandwidth_for_server'/'max_remote_read_network_bandwidth' throttler.|float|B|
|`RemoteReadThrottlerSleepMicroseconds`|Total time a query was sleeping to conform 'max_remote_read_network_bandwidth_for_server'/'max_remote_read_network_bandwidth' throttling.|float|ms|
|`RemoteWriteThrottlerBytes`|Bytes passed through 'max_remote_write_network_bandwidth_for_server'/'max_remote_write_network_bandwidth' throttler.|float|B|
|`RemoteWriteThrottlerSleepMicroseconds`|Total time a query was sleeping to conform 'max_remote_write_network_bandwidth_for_server'/'max_remote_write_network_bandwidth' throttling.|float|ms|
|`ReplicaPartialShutdown`|How many times Replicated table has to `deinitialize` its state due to session expiration in ZooKeeper. The state is reinitialized every time when ZooKeeper is available again.|float|count|
|`ReplicatedDataLoss`|Number of times a data part that we wanted does not exist on any replica (even on replicas that are offline right now). That data parts are definitely lost. This is normal due to asynchronous replication (if quorum inserts were not enabled), when the replica on which the data part was written was failed and when it became online after fail it does not contain that data part.|float|count|
|`ReplicatedPartChecks`|Number of times we had to perform advanced search for a data part on replicas or to clarify the need of an existing data part.|float|count|
|`ReplicatedPartChecksFailed`|Number of times the advanced search for a data part on replicas did not give result or when unexpected part has been found and moved away.|float|count|
|`ReplicatedPartFailedFetches`|Number of times a data part was failed to download from replica of a ReplicatedMergeTree table.|float|count|
|`ReplicatedPartFetches`|Number of times a data part was downloaded from replica of a ReplicatedMergeTree table.|float|count|
|`ReplicatedPartFetchesOfMerged`|Number of times we prefer to download already merged part from replica of ReplicatedMergeTree table instead of performing a merge ourself (usually we prefer doing a merge ourself to save network traffic). This happens when we have not all source parts to perform a merge or when the data part is old enough.|float|count|
|`ReplicatedPartMerges`|Number of times data parts of ReplicatedMergeTree tables were successfully merged.|float|count|
|`ReplicatedPartMutations`|Number of times data parts of ReplicatedMergeTree tables were successfully mutated.|float|count|
|`S3AbortMultipartUpload`|Number of S3 API AbortMultipartUpload calls.|float|count|
|`S3CompleteMultipartUpload`|Number of S3 API CompleteMultipartUpload calls.|float|count|
|`S3CopyObject`|Number of S3 API CopyObject calls.|float|count|
|`S3CreateMultipartUpload`|Number of S3 API CreateMultipartUpload calls.|float|count|
|`S3DeleteObjects`|Number of S3 API DeleteObject(s) calls.|float|count|
|`S3GetObject`|Number of S3 API GetObject calls.|float|count|
|`S3GetObjectAttributes`|Number of S3 API GetObjectAttributes calls.|float|count|
|`S3GetRequestThrottlerCount`|Number of S3 GET and SELECT requests passed through throttler.|float|count|
|`S3GetRequestThrottlerSleepMicroseconds`|Total time a query was sleeping to conform S3 GET and SELECT request throttling.|float|ms|
|`S3HeadObject`|Number of S3 API HeadObject calls.|float|count|
|`S3ListObjects`|Number of S3 API ListObjects calls.|float|count|
|`S3PutObject`|Number of S3 API PutObject calls.|float|count|
|`S3PutRequestThrottlerCount`|Number of S3 PUT, COPY, POST and LIST requests passed through throttler.|float|count|
|`S3PutRequestThrottlerSleepMicroseconds`|Total time a query was sleeping to conform S3 PUT, COPY, POST and LIST request throttling.|float|ms|
|`S3ReadBytes`|Read bytes (incoming) in GET and HEAD requests to S3 storage.|float|B|
|`S3ReadMicroseconds`|Time of GET and HEAD requests to S3 storage.|float|ms|
|`S3ReadRequestsCount`|Number of GET and HEAD requests to S3 storage.|float|count|
|`S3ReadRequestsErrors`|Number of non-throttling errors in GET and HEAD requests to S3 storage.|float|count|
|`S3ReadRequestsRedirects`|Number of redirects in GET and HEAD requests to S3 storage.|float|count|
|`S3ReadRequestsThrottling`|Number of 429 and 503 errors in GET and HEAD requests to S3 storage.|float|count|
|`S3UploadPart`|Number of S3 API UploadPart calls.|float|count|
|`S3UploadPartCopy`|Number of S3 API UploadPartCopy calls.|float|count|
|`S3WriteBytes`|Write bytes (outgoing) in POST, DELETE, PUT and PATCH requests to S3 storage.|float|B|
|`S3WriteMicroseconds`|Time of POST, DELETE, PUT and PATCH requests to S3 storage.|float|ms|
|`S3WriteRequestsCount`|Number of POST, DELETE, PUT and PATCH requests to S3 storage.|float|count|
|`S3WriteRequestsErrors`|Number of non-throttling errors in POST, DELETE, PUT and PATCH requests to S3 storage.|float|count|
|`S3WriteRequestsRedirects`|Number of redirects in POST, DELETE, PUT and PATCH requests to S3 storage.|float|count|
|`S3WriteRequestsThrottling`|Number of 429 and 503 errors in POST, DELETE, PUT and PATCH requests to S3 storage.|float|count|
|`ScalarSubqueriesCacheMiss`|Number of times a read from a scalar sub query was not cached and had to be calculated completely|float|count|
|`ScalarSubqueriesGlobalCacheHit`|Number of times a read from a scalar sub query was done using the global cache|float|count|
|`ScalarSubqueriesLocalCacheHit`|Number of times a read from a scalar sub query was done using the local cache|float|count|
|`SchemaInferenceCacheEvictions`|Number of times a schema from cache was evicted due to overflow|float|count|
|`SchemaInferenceCacheHits`|Number of times a schema from cache was used for schema inference|float|count|
|`SchemaInferenceCacheInvalidations`|Number of times a schema in cache became invalid due to changes in data|float|count|
|`SchemaInferenceCacheMisses`|Number of times a schema is not in cache while schema inference|float|count|
|`Seek`|Number of times the 'lseek' function was called.|float|count|
|`SelectQuery`|Same as Query, but only for SELECT queries.|float|count|
|`SelectQueryTimeMicroseconds`|Total time of SELECT queries.|float|ms|
|`SelectedBytes`|Number of bytes (uncompressed; for columns as they stored in memory) SELECTed from all tables.|float|B|
|`SelectedMarks`|Number of marks (index granules) selected to read from a MergeTree table.|float|count|
|`SelectedParts`|Number of data parts selected to read from a MergeTree table.|float|count|
|`SelectedRanges`|Number of (non-adjacent) ranges in all data parts selected to read from a MergeTree table.|float|count|
|`SelectedRows`|Number of rows SELECTed from all tables.|float|count|
|`ServerStartupMilliseconds`|Time elapsed from starting server to listening to sockets in milliseconds|float|ms|
|`SleepFunctionCalls`|Number of times a sleep function (sleep, sleepEachRow) has been called.|float|count|
|`SleepFunctionMicroseconds`|Time spent sleeping due to a sleep function call.|float|ms|
|`SlowRead`|Number of reads from a file that were slow. This indicate system overload. Thresholds are controlled by read_backoff_* settings.|float|count|
|`SoftPageFaults`|The number of soft page faults in query execution threads. Soft page fault usually means a miss in the memory allocator cache which required a new memory mapping from the OS and subsequent allocation of a page of physical memory.|float|count|
|`StorageBufferErrorOnFlush`|Number of times a buffer in the 'Buffer' table has not been able to flush due to error writing in the destination table.|float|count|
|`StorageBufferFlush`|Number of times a buffer in a 'Buffer' table was flushed.|float|count|
|`StorageBufferLayerLockReadersWaitMilliseconds`|Time for waiting for Buffer layer during reading.|float|ms|
|`StorageBufferLayerLockWritersWaitMilliseconds`|Time for waiting free Buffer layer to write to (can be used to tune Buffer layers).|float|ms|
|`StorageBufferPassedAllMinThresholds`|Number of times a criteria on min thresholds has been reached to flush a buffer in a 'Buffer' table.|float|count|
|`StorageBufferPassedBytesFlushThreshold`|Number of times background-only flush threshold on bytes has been reached to flush a buffer in a 'Buffer' table. This is expert-only metric. If you read this and you are not an expert, stop reading.|float|count|
|`StorageBufferPassedBytesMaxThreshold`|Number of times a criteria on max bytes threshold has been reached to flush a buffer in a 'Buffer' table.|float|count|
|`StorageBufferPassedRowsFlushThreshold`|Number of times background-only flush threshold on rows has been reached to flush a buffer in a 'Buffer' table. This is expert-only metric. If you read this and you are not an expert, stop reading.|float|count|
|`StorageBufferPassedRowsMaxThreshold`|Number of times a criteria on max rows threshold has been reached to flush a buffer in a 'Buffer' table.|float|count|
|`StorageBufferPassedTimeFlushThreshold`|Number of times background-only flush threshold on time has been reached to flush a buffer in a 'Buffer' table. This is expert-only metric. If you read this and you are not an expert, stop reading.|float|count|
|`StorageBufferPassedTimeMaxThreshold`|Number of times a criteria on max time threshold has been reached to flush a buffer in a 'Buffer' table.|float|count|
|`SuspendSendingQueryToShard`|Total count when sending query to shard was suspended when async_query_sending_for_remote is enabled.|float|count|
|`SynchronousRemoteReadWaitMicroseconds`|Time spent in waiting for synchronous remote reads.|float|ms|
|`SystemTimeMicroseconds`|Total time spent in processing (queries and other tasks) threads executing CPU instructions in OS kernel space. This include time CPU `pipeline` was stalled due to cache misses, branch `mispredictions`, hyper-threading, etc.|float|ms|
|`TableFunctionExecute`|Number of table function calls.|float|count|
|`ThreadPoolReaderPageCacheHit`|Number of times the read inside ThreadPoolReader was done from page cache.|float|count|
|`ThreadPoolReaderPageCacheHitBytes`|Number of bytes read inside ThreadPoolReader when it was done from page cache.|float|B|
|`ThreadPoolReaderPageCacheHitElapsedMicroseconds`|Time spent reading data from page cache in ThreadPoolReader.|float|ms|
|`ThreadPoolReaderPageCacheMiss`|Number of times the read inside ThreadPoolReader was not done from page cache and was hand off to thread pool.|float|count|
|`ThreadPoolReaderPageCacheMissBytes`|Number of bytes read inside ThreadPoolReader when read was not done from page cache and was hand off to thread pool.|float|B|
|`ThreadPoolReaderPageCacheMissElapsedMicroseconds`|Time spent reading data inside the asynchronous job in ThreadPoolReader - when read was not done from page cache.|float|ms|
|`ThreadpoolReaderReadBytes`|Bytes read from a `threadpool` task in asynchronous reading|float|B|
|`ThreadpoolReaderSubmit`|Bytes read from a `threadpool` task in asynchronous reading|float|B|
|`ThreadpoolReaderTaskMicroseconds`|Time spent getting the data in asynchronous reading|float|ms|
|`ThrottlerSleepMicroseconds`|Total time a query was sleeping to conform all throttling settings.|float|ms|
|`UncompressedCacheHits`|Number of times a block of data has been found in the uncompressed cache (and decompression was avoided).|float|count|
|`UncompressedCacheMisses`|Number of times a block of data has not been found in the uncompressed cache (and required decompression).|float|count|
|`UncompressedCacheWeightLost`|Number of bytes evicted from the uncompressed cache.|float|B|
|`UserTimeMicroseconds`|Total time spent in processing (queries and other tasks) threads executing CPU instructions in user space. This include time CPU `pipeline` was stalled due to cache misses, branch `mispredictions`, hyper-threading, etc.|float|ms|
|`VoluntaryContextSwitches`|Voluntary context switches|float|count|
|`WaitMarksLoadMicroseconds`|Time spent loading marks|float|ms|
|`WaitPrefetchTaskMicroseconds`|Time spend waiting for prefetched reader|float|ms|
|`WriteBufferAIOWrite`|Write Buffer AIO Write|float|count|
|`WriteBufferAIOWriteBytes`|Write buffer AIO write bytes|float|B|
|`WriteBufferFromFileDescriptorWrite`|Number of writes (`write`/`pwrite`) to a file descriptor. Does not include sockets.|float|count|
|`WriteBufferFromFileDescriptorWriteBytes`|Number of bytes written to file descriptors. If the file is compressed, this will show compressed data size.|float|B|
|`WriteBufferFromFileDescriptorWriteFailed`|Number of times the write (`write`/`pwrite`) to a file descriptor have failed.|float|count|
|`WriteBufferFromS3Bytes`|Bytes written to S3.|float|B|
|`WriteBufferFromS3Microseconds`|Time spent on writing to S3.|float|ms|
|`WriteBufferFromS3RequestsErrors`|Number of exceptions while writing to S3.|float|count|
|`ZooKeeperBytesReceived`|Number of bytes received over network while communicating with ZooKeeper.|float|B|
|`ZooKeeperBytesSent`|Number of bytes send over network while communicating with ZooKeeper.|float|B|
|`ZooKeeperCheck`|Number of 'check' requests to ZooKeeper. Usually they don't make sense in isolation, only as part of a complex transaction.|float|count|
|`ZooKeeperClose`|Number of times connection with ZooKeeper has been closed voluntary.|float|count|
|`ZooKeeperCreate`|Number of 'create' requests to ZooKeeper.|float|count|
|`ZooKeeperExists`|Number of 'exists' requests to ZooKeeper.|float|count|
|`ZooKeeperGet`|Number of 'get' requests to ZooKeeper.|float|count|
|`ZooKeeperHardwareExceptions`|Number of exceptions while working with ZooKeeper related to network (connection loss or similar).|float|count|
|`ZooKeeperInit`|Number of times connection with ZooKeeper has been established.|float|count|
|`ZooKeeperList`|Number of 'list' (getChildren) requests to ZooKeeper.|float|count|
|`ZooKeeperMulti`|Number of 'multi' requests to ZooKeeper (compound transactions).|float|count|
|`ZooKeeperOtherExceptions`|Number of exceptions while working with ZooKeeper other than ZooKeeperUserExceptions and ZooKeeperHardwareExceptions.|float|count|
|`ZooKeeperRemove`|Number of 'remove' requests to ZooKeeper.|float|count|
|`ZooKeeperSet`|Number of 'set' requests to ZooKeeper.|float|count|
|`ZooKeeperSync`|Number of 'sync' requests to ZooKeeper. These requests are rarely needed or usable.|float|count|
|`ZooKeeperTransactions`|Number of ZooKeeper operations, which include both read and write operations as well as multi-transactions.|float|count|
|`ZooKeeperUserExceptions`|Number of exceptions while working with ZooKeeper related to the data (no node, bad version or similar).|float|count|
|`ZooKeeperWaitMicroseconds`|Number of microseconds spent waiting for responses from ZooKeeper after creating a request, summed across all the requesting threads.|float|ms|
|`ZooKeeperWatchResponse`|Number of times watch notification has been received from ZooKeeper.|float|count|






### `ClickHouseStatusInfo`



- 标签


| Tag | Description |
|  ----  | --------|
|`host`|Host name|
|`instance`|Instance endpoint|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`DictionaryStatus`|Dictionary Status.|float|-|



