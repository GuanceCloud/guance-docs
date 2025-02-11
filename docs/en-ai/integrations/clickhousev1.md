---
title: 'ClickHouse'
summary: 'Collect metrics data from ClickHouse'
__int_icon: 'icon/clickhouse'
tags:
  - 'Database'
dashboard:
  - desc: 'ClickHouse'
    path: 'dashboard/en/clickhouse'
monitor:
  - desc: 'Not available yet'
    path: '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The ClickHouse collector can gather various metrics exposed by the ClickHouse server instance, such as statement execution counts and memory storage, IO interactions, and many other metrics. It then sends these metrics to Guance for monitoring and analyzing any anomalies in ClickHouse.

## Configuration {#config}

### Prerequisites {#requirements}

- ClickHouse version >=v20.1.2.4
- In the `config.xml` configuration file of the ClickHouse Server, find the following code segment, uncomment it, and set the port number for exposing metrics (choose a unique one). After modification, restart the service (if it is a cluster, each machine must be operated).

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

Field descriptions:

- `endpoint`: HTTP route for Prometheus server to scrape metrics.
- `port`: Port number of the endpoint.
- `metrics`: Flag to enable scraping exposed metrics from ClickHouse's `system.metrics` table.
- `events`: Flag to enable scraping exposed events from ClickHouse's `system.events` table.
- `asynchronous_metrics`: Flag to enable scraping exposed asynchronous metrics from ClickHouse's `system.asynchronous_metrics` table.

Refer to [ClickHouse Official Documentation](https://ClickHouse.com/docs/en/operations/server-configuration-parameters/settings/#server_configuration_parameters-prometheus){:target="_blank"}

### Collector Configuration {input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Enter the `conf.d/clickhousev1` directory under the DataKit installation directory, copy `clickhousev1.conf.sample`, and rename it to `clickhousev1.conf`. Example configuration:
    
    ```toml
        
    [[inputs.clickhousev1]]
      ## Exporter URLs.
      urls = ["http://127.0.0.1:9363/metrics"]
    
      ## Unix Domain Socket URL. Using socket to request data when not empty.
      uds_path = ""
    
      ## Ignore URL request errors.
      ignore_req_err = false
    
      ## Collect data output.
      ## Fill this when wanting to collect data to a local file or center.
      ## After filling, use 'datakit debug --prom-conf /path/to/this/conf' to debug local storage measurement set.
      ## Use '--prom-conf' when prioritizing debugging data in 'output' path.
      # output = "/abs/path/to/file"
    
      ## Collect data upper limit as bytes.
      ## Only available when setting output to a local file.
      ## If collected data exceeds the limit, the data will be dropped.
      ## Default is 32MB.
      # max_file_size = 0
    
      ## Metrics type whitelist. Optional: counter, gauge, histogram, summary
      ## Example: metric_types = ["counter", "gauge"], only collect 'counter' and 'gauge'.
      ## Default collect all.
      # metric_types = []
    
      ## Metrics name whitelist.
      ## Regex supported. Multi-supported, conditions met when one matched.
      ## Collect all if empty.
      # metric_name_filter = ["cpu"]
    
      ## Metrics name blacklist.
      ## If a word is both in the blacklist and whitelist, blacklist takes precedence.
      ## Regex supported. Multi-supported, conditions met when one matched.
      ## Collect all if empty.
      # metric_name_filter_ignore = ["foo","bar"]
    
      ## Measurement prefix.
      ## Add prefix to measurement set name.
      measurement_prefix = ""
    
      ## Measurement name.
      ## If measurement_name is empty, split metric name by '_', the first field after split as measurement set name, the rest as current metric name.
      ## If measurement_name is not empty, use this as measurement set name.
      ## Always add 'measurement_prefix' prefix at last.
      # measurement_name = "clickhouse"
    
      ## TLS configuration.
      tls_open = false
      # tls_ca = "/tmp/ca.crt"
      # tls_cert = "/tmp/peer.crt"
      # tls_key = "/tmp/peer.key"
    
      ## Set to 'true' to enable election.
      election = true
    
      ## Disable setting host tag for this input
      disable_host_tag = false
    
      ## Disable setting instance tag for this input
      disable_instance_tag = false
    
      ## Disable info tag for this input
      disable_info_tag = false
    
      ## Ignore tags. Multi-supported.
      ## The matched tags will be dropped, but the item will still be sent.
      # tags_ignore = ["xxxx"]
    
      ## Customize authentication. Currently supports Bearer Token only.
      ## Filling in 'token' or 'token_file' is acceptable.
      # [inputs.clickhousev1.auth]
        # type = "bearer_token"
        # token = "xxxxxxxx"
        # token_file = "/tmp/token"
    
      ## Customize measurement set name.
      ## Treat those metrics with prefix as one set.
      ## Prioritize over 'measurement_name' configuration.
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
    
      ## Do not collect data when tag matches.
      [inputs.clickhousev1.ignore_tag_kv_match]
        # key1 = [ "val1.*", "val2.*"]
        # key2 = [ "val1.*", "val2.*"]
    
      ## Add HTTP headers to data pulling.
      [inputs.clickhousev1.http_headers]
        # Root = "passwd"
        # Michael = "1234"
    
      ## Rename tag keys in ClickHouse data.
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
      
      ## (Optional) Collection interval: (defaults to "30s").
      # interval = "30s"
    
      ## (Optional) Timeout: (defaults to "30s").
      # timeout = "30s"
      
    ```

    After configuring, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap method](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Metrics {#metric}

By default, all collected data will append global election tags, and additional tags can be specified in the configuration through `[inputs.clickhousev1.tags]`:

``` toml
[inputs.prom.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```



### `ClickHouseAsyncMetrics`



- Tags


| Tag | Description |
| ---- | --------|
|`cpu`|CPU ID|
|`disk`|Disk name|
|`eth`|Ethernet ID|
|`host`|Host name|
|`instance`|Instance endpoint|
|`unit`|Unit name|

- Field List


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
|`MaxPartCountForPartition`|Maximum number of parts per partition across all partitions of all tables of MergeTree family. Values larger than 300 indicate misconfiguration, overload, or massive data loading.|float|count|
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
|`OSStealTimeCPU`|The ratio of time spent in other operating systems by the CPU when running in a virtualized environment. This is