
# ClickHouse
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

ClickHouse collector can collect various metrics actively exposed by ClickHouse server instances, such as the number of statements executed, memory storage, IO interaction and other metrics, and collect the metrics into Guance Cloud to help you monitor and analyze various abnormal situations of ClickHouse.

## Preconditions {#requirements}

ClickHouse version >=v20.1.2.4

Find the following code snippet in the config.xml configuration file of clickhouse-server, uncomment it, and set the port number exposed by metrics (which is unique if you choose it yourself). Restart after modification (if it is a cluster, every machine needs to operate).

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

Field description:

- HTTP Routing of `endpoint` Prometheus Server Fetch Metrics
- `port` number of the port endpoint
- `metrics` grabs exposed metrics flags from ClickHouse's `system.metrics` table
- `events` grabs exposed event flags from ClickHouse's `table.events`.
- `asynchronous_metrics` grabs exposed asynchronous_metrics flags from ClickHouse's `system.asynchronous_metrics` table

See [ClickHouse official documents](https://ClickHouse.com/docs/en/operations/server-configuration-parameters/settings/#server_configuration_parameters-prometheus){:target="_blank"}

=== "Host Installation"

    Go to the `conf.d/clickhouse` directory under the DataKit installation directory, copy `clickhousev1.conf.sample` and name it `clickhousev1.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.clickhousev1]]
      ## Exporter URLs.
      # urls = ["http://127.0.0.1:9363/metrics"]
    
      ## Unix Domain Socket URL. Using socket to request data when not empty.
      uds_path = ""
    
      ## Ignore URL request errors.
      ignore_req_err = false
    
      ## Collector alias.
      source = "clickhouse"
    
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
    
      ## Send collected metrics to center as log.
      ## When 'service' field is empty, using 'service tag' as measurement set name.
      [inputs.clickhousev1.as_logging]
        enable = false
        service = "service_name"
    
      ## Customize tags.
      [inputs.clickhousev1.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
      
      ## (Optional) Collect interval: (defaults to "30s").
      # interval = "30s"
    
      ## (Optional) Timeout: (defaults to "30s").
      # timeout = "30s"
      
    ```
    
    After configuration, [restart DataKit](datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    At present, you can [inject collector configuration in ConfigMap mode](datakit-daemonset-deploy.md#configmap-setting)。

## Measurements {#measurements}

For all the following data collections, a global tag named `host` is appended by default (the tag value is the host name where the DataKit is located), or other tags can be customized in the configuration through `[inputs.prom.tags]`(Hostname can be added to the cluster).

``` toml
    [inputs.prom.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
```

## Metrics {#metrics}





### `ClickHouseAsyncMetrics`



- tag


| Tag | Description |
|  ----  | --------|
|`cpu`|cpu id|
|`disk`|disk name|
|`eth`|eth id|
|`host`|host name|
|`unit`|unit name|

- field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`AsynchronousHeavyMetricsCalculationTimeSpent`|Time in seconds spent for calculation of asynchronous heavy tables related metrics this is the overhead of asynchronous metrics.|int|count|
|`AsynchronousHeavyMetricsUpdateInterval`|Heavy (tables related) metrics update interval|int|count|
|`AsynchronousMetricsCalculationTimeSpent`|Time in seconds spent for calculation of asynchronous metrics this is the overhead of asynchronous metrics.|int|count|
|`AsynchronousMetricsUpdateInterval`|Metrics update interval|int|count|
|`BlockActiveTime`|Time in seconds the block device had the IO requests queued. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|int|count|
|`BlockDiscardBytes`|Number of discarded bytes on the block device. These operations are relevant for SSD. Discard operations are not used by ClickHouse, but can be used by other processes on the system. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|int|count|
|`BlockDiscardMerges`|Number of discard operations requested from the block device and merged together by the OS IO scheduler. These operations are relevant for SSD. Discard operations are not used by ClickHouse, but can be used by other processes on the system. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|int|count|
|`BlockDiscardOps`|Number of discard operations requested from the block device. These operations are relevant for SSD. Discard operations are not used by ClickHouse, but can be used by other processes on the system. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|int|count|
|`BlockDiscardTime`|Time in seconds spend in discard operations requested from the block device, summed across all the operations. These operations are relevant for SSD. Discard operations are not used by ClickHouse, but can be used by other processes on the system. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|int|count|
|`BlockInFlightOps`|This value counts the number of I/O requests that have been issued to the device driver but have not yet completed. It does not include IO requests that are in the queue but not yet issued to the device driver. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|int|count|
|`BlockQueueTime`|This value counts the number of milliseconds that IO requests have waited on this block device. If there are multiple IO requests waiting, this value will increase as the product of the number of milliseconds times the number of requests waiting. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|int|count|
|`BlockReadBytes`|Number of bytes read from the block device. It can be lower than the number of bytes read from the filesystem due to the usage of the OS page cache, that saves IO. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|int|count|
|`BlockReadMerges`|Number of read operations requested from the block device and merged together by the OS IO scheduler. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|int|count|
|`BlockReadOps`|Number of read operations requested from the block device. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|int|count|
|`BlockReadTime`|Time in seconds spend in read operations requested from the block device, summed across all the operations. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|int|count|
|`BlockWriteBytes`|Number of bytes written to the block device. It can be lower than the number of bytes written to the filesystem due to the usage of the OS page cache, that saves IO. A write to the block device may happen later than the corresponding write to the filesystem due to write-through caching. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|int|count|
|`BlockWriteMerges`|Number of write operations requested from the block device and merged together by the OS IO scheduler. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|int|count|
|`BlockWriteOps`|Number of write operations requested from the block device. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|int|count|
|`BlockWriteTime`|Time in seconds spend in write operations requested from the block device, summed across all the operations. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Source: `/sys/block`.|int|count|
|`CPUFrequencyMHz`|The current frequency of the CPU, in MHz. Most of the modern CPUs adjust the frequency dynamically for power saving and Turbo Boosting.|int|count|
|`CompiledExpressionCacheBytes`|Total bytes used for the cache of JIT-compiled code.|int|count|
|`CompiledExpressionCacheCount`|Total entries in the cache of JIT-compiled code.|int|count|
|`DiskAvailable`|Available bytes on the disk (virtual filesystem). Remote `filesystems` can show a large value like 16 EiB.|int|count|
|`DiskTotal`|The total size in bytes of the disk (virtual filesystem). Remote `filesystems` can show a large value like 16 EiB.|int|count|
|`DiskUnreserved`|Available bytes on the disk (virtual filesystem) without the reservations for merges, fetches, and moves. Remote `filesystems` can show a large value like 16 EiB.|int|count|
|`DiskUsed`|Used bytes on the disk (virtual filesystem). Remote `filesystems` not always provide this information.|int|count|
|`FilesystemCacheBytes`|Total bytes in the `cache` virtual filesystem. This cache is hold on disk.|int|count|
|`FilesystemCacheFiles`|Total number of cached file segments in the `cache` virtual filesystem. This cache is hold on disk.|int|count|
|`FilesystemLogsPathAvailableBytes`|Available bytes on the volume where ClickHouse logs path is mounted. If this value approaches zero, you should tune the log rotation in the configuration file.|int|count|
|`FilesystemLogsPathAvailableINodes`|The number of available `inodes` on the volume where ClickHouse logs path is mounted.|int|count|
|`FilesystemLogsPathTotalBytes`|The size of the volume where ClickHouse logs path is mounted, in bytes. It's recommended to have at least 10 GB for logs.|int|count|
|`FilesystemLogsPathTotalINodes`|The total number of `inodes` on the volume where ClickHouse logs path is mounted.|int|count|
|`FilesystemLogsPathUsedBytes`|Used bytes on the volume where ClickHouse logs path is mounted.|int|count|
|`FilesystemLogsPathUsedINodes`|The number of used `inodes` on the volume where ClickHouse logs path is mounted.|int|count|
|`FilesystemMainPathAvailableBytes`|Available bytes on the volume where the main ClickHouse path is mounted.|int|count|
|`FilesystemMainPathAvailableINodes`|The number of available `inodes` on the volume where the main ClickHouse path is mounted. If it is close to zero, it indicates a misconfiguration, and you will get 'no space left on device' even when the disk is not full.|int|count|
|`FilesystemMainPathTotalBytes`|The size of the volume where the main ClickHouse path is mounted, in bytes.|int|count|
|`FilesystemMainPathTotalINodes`|The total number of `inodes` on the volume where the main ClickHouse path is mounted. If it is less than 25 million, it indicates a misconfiguration.|int|count|
|`FilesystemMainPathUsedBytes`|Used bytes on the volume where the main ClickHouse path is mounted.|int|count|
|`FilesystemMainPathUsedINodes`|The number of used `inodes` on the volume where the main ClickHouse path is mounted. This value mostly corresponds to the number of files.|int|count|
|`HTTPThreads`|Number of threads in the server of the HTTP interface (without TLS).|int|count|
|`InterserverThreads`|Number of threads in the server of the replicas communication protocol (without TLS).|int|count|
|`Jitter`|The difference in time the thread for calculation of the asynchronous metrics was scheduled to wake up and the time it was in fact, woken up. A proxy-indicator of overall system latency and responsiveness.|int|count|
|`LoadAverage`|The whole system load, averaged with exponential smoothing over 1 minute. The load represents the number of threads across all the processes (the scheduling entities of the OS kernel), that are currently running by CPU or waiting for IO, or ready to run but not being scheduled at this point of time. This number includes all the processes, not only `clickhouse-server`. The number can be greater than the number of CPU cores, if the system is overloaded, and many processes are ready to run but waiting for CPU or IO.|int|count|
|`MMapCacheCells`|The number of files opened with `mmap` (mapped in memory). This is used for queries with the setting `local_filesystem_read_method` set to  `mmap`. The files opened with `mmap` are kept in the cache to avoid costly TLB flushes.|int|count|
|`MarkCacheBytes`|Total size of mark cache in bytes|int|count|
|`MarkCacheFiles`|Total number of mark files cached in the mark cache|int|count|
|`MaxPartCountForPartition`|Maximum number of parts per partition across all partitions of all tables of MergeTree family. Values larger than 300 indicates misconfiguration, overload, or massive data loading.|int|count|
|`MemoryCode`|The amount of virtual memory mapped for the pages of machine code of the server process, in bytes.|int|count|
|`MemoryDataAndStack`|The amount of virtual memory mapped for the use of stack and for the allocated memory, in bytes. It is unspecified whether it includes the per-thread stacks and most of the allocated memory, that is allocated with the `mmap` system call. This metric exists only for completeness reasons. I recommend to use the `MemoryResident` metric for monitoring.|int|count|
|`MemoryResident`|The amount of physical memory used by the server process, in bytes.|int|count|
|`MemoryShared`|The amount of memory used by the server process, that is also shared by another processes, in bytes. ClickHouse does not use shared memory, but some memory can be labeled by OS as shared for its own reasons. This metric does not make a lot of sense to watch, and it exists only for completeness reasons.|int|count|
|`MemoryVirtual`|The size of the virtual address space allocated by the server process, in bytes. The size of the virtual address space is usually much greater than the physical memory consumption, and should not be used as an estimate for the memory consumption. The large values of this metric are totally normal, and makes only technical sense.|int|count|
|`MySQLThreads`|Number of threads in the server of the MySQL compatibility protocol.|int|count|
|`NetworkReceiveBytes`|Number of bytes received via the network interface. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|int|count|
|`NetworkReceiveDrop`|Number of bytes a packet was dropped while received via the network interface. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|int|count|
|`NetworkReceiveErrors`|Number of times error happened receiving via the network interface. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|int|count|
|`NetworkReceivePackets`|Number of network packets received via the network interface. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|int|count|
|`NetworkSendBytes`|Number of bytes sent via the network interface. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|int|count|
|`NetworkSendDrop`|Number of times a packed was dropped while sending via the network interface. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|int|count|
|`NetworkSendErrors`|Number of times error (e.g. TCP retransmit) happened while sending via the network interface. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|int|count|
|`NetworkSendPackets`|Number of network packets sent via the network interface. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|int|count|
|`NumberOfDatabases`|Total number of databases on the server.|int|count|
|`NumberOfDetachedByUserParts`|The total number of parts detached from MergeTree tables by users with the `ALTER TABLE DETACH` query (as opposed to unexpected, broken or ignored parts). The server does not care about detached parts and they can be removed.|int|count|
|`NumberOfDetachedParts`|The total number of parts detached from MergeTree tables. A part can be detached by a user with the `ALTER TABLE DETACH` query or by the server itself it the part is broken, unexpected or unneeded. The server does not care about detached parts and they can be removed.|int|count|
|`NumberOfTables`|Total number of tables summed across the databases on the server, excluding the databases that cannot contain MergeTree tables. The excluded database engines are those who generate the set of tables on the fly, like `Lazy`, `MySQL`, `PostgreSQL`, `SQlite`.|int|count|
|`OSContextSwitches`|The number of context switches that the system underwent on the host machine. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|int|count|
|`OSGuestNiceTime`|The ratio of time spent running a virtual CPU for guest operating systems under the control of the Linux kernel, when a guest was set to a higher priority (See `man procfs`). This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. This metric is irrelevant for ClickHouse, but still exists for completeness. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|int|count|
|`OSGuestNiceTimeCPU`|The ratio of time spent running a virtual CPU for guest operating systems under the control of the Linux kernel, when a guest was set to a higher priority (See `man procfs`). This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. This metric is irrelevant for ClickHouse, but still exists for completeness. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|int|count|
|`OSGuestNiceTimeNormalized`|The value is similar to `OSGuestNiceTime` but divided to the number of CPU cores to be measured in the [0..1] interval regardless of the number of cores. This allows you to average the values of this metric across multiple servers in a cluster even if the number of cores is non-uniform, and still get the average resource utilization metric.|int|count|
|`OSGuestTime`|The ratio of time spent running a virtual CPU for guest operating systems under the control of the Linux kernel (See `man procfs`). This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. This metric is irrelevant for ClickHouse, but still exists for completeness. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|int|count|
|`OSGuestTimeCPU`|The ratio of time spent running a virtual CPU for guest operating systems under the control of the Linux kernel (See `man procfs`). This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. This metric is irrelevant for ClickHouse, but still exists for completeness. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|int|count|
|`OSGuestTimeNormalized`|The value is similar to `OSGuestTime` but divided to the number of CPU cores to be measured in the [0..1] interval regardless of the number of cores. This allows you to average the values of this metric across multiple servers in a cluster even if the number of cores is non-uniform, and still get the average resource utilization metric.|int|count|
|`OSIOWaitTime`|The ratio of time the CPU core was not running the code but when the OS kernel did not run any other process on this CPU as the processes were waiting for IO. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|int|count|
|`OSIOWaitTimeCPU`|The ratio of time the CPU core was not running the code but when the OS kernel did not run any other process on this CPU as the processes were waiting for IO. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|int|count|
|`OSIOWaitTimeNormalized`|The value is similar to `OSIOWaitTime` but divided to the number of CPU cores to be measured in the [0..1] interval regardless of the number of cores. This allows you to average the values of this metric across multiple servers in a cluster even if the number of cores is non-uniform, and still get the average resource utilization metric.|int|count|
|`OSIdleTime`|The ratio of time the CPU core was idle (not even ready to run a process waiting for IO) from the OS kernel standpoint. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. This does not include the time when the CPU was under-utilized due to the reasons internal to the CPU (memory loads, `pipeline stalls`, branch `mispredictions`, running another SMT core). The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|int|count|
|`OSIdleTimeCPU`|The ratio of time the CPU core was idle (not even ready to run a process waiting for IO) from the OS kernel standpoint. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. This does not include the time when the CPU was under-utilized due to the reasons internal to the CPU (memory loads, `pipeline stalls`, branch `mispredictions`, running another SMT core). The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|int|count|
|`OSIdleTimeNormalized`|The value is similar to `OSIdleTime` but divided to the number of CPU cores to be measured in the [0..1] interval regardless of the number of cores. This allows you to average the values of this metric across multiple servers in a cluster even if the number of cores is non-uniform, and still get the average resource utilization metric.|int|count|
|`OSInterrupts`|The number of interrupts on the host machine. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|int|count|
|`OSIrqTime`|The ratio of time spent for running hardware interrupt requests on the CPU. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. A high number of this metric may indicate hardware misconfiguration or a very high network load. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|int|count|
|`OSIrqTimeCPU`|The ratio of time spent for running hardware interrupt requests on the CPU. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. A high number of this metric may indicate hardware misconfiguration or a very high network load. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|int|count|
|`OSIrqTimeNormalized`|The value is similar to `OSIrqTime` but divided to the number of CPU cores to be measured in the [0..1] interval regardless of the number of cores. This allows you to average the values of this metric across multiple servers in a cluster even if the number of cores is non-uniform, and still get the average resource utilization metric.|int|count|
|`OSMemoryAvailable`|The amount of memory available to be used by programs, in bytes. This is very similar to the `OSMemoryFreePlusCached` metric. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|int|count|
|`OSMemoryBuffers`|The amount of memory used by OS kernel buffers, in bytes. This should be typically small, and large values may indicate a misconfiguration of the OS. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|int|count|
|`OSMemoryCached`|The amount of memory used by the OS page cache, in bytes. Typically, almost all available memory is used by the OS page cache - high values of this metric are normal and expected. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|int|count|
|`OSMemoryFreePlusCached`|The amount of free memory plus OS page cache memory on the host system, in bytes. This memory is available to be used by programs. The value should be very similar to `OSMemoryAvailable`. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|int|count|
|`OSMemoryFreeWithoutCached`|The amount of free memory on the host system, in bytes. This does not include the memory used by the OS page cache memory, in bytes. The page cache memory is also available for usage by programs, so the value of this metric can be confusing. See the `OSMemoryAvailable` metric instead. For convenience we also provide the `OSMemoryFreePlusCached` metric, that should be somewhat similar to OSMemoryAvailable. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|int|count|
|`OSMemorySwapCached`|The amount of memory in swap that was also loaded in RAM. Swap should be disabled on production systems. If the value of this metric is large, it indicates a misconfiguration.  This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|int|count|
|`OSMemoryTotal`|The total amount of memory on the host system, in bytes.|int|count|
|`OSNiceTime`|The ratio of time the CPU core was running `userspace` code with higher priority. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|int|count|
|`OSNiceTimeCPU`|The ratio of time the CPU core was running `userspace` code with higher priority. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|int|count|
|`OSNiceTimeNormalized`|The value is similar to `OSNiceTime` but divided to the number of CPU cores to be measured in the [0..1] interval regardless of the number of cores. This allows you to average the values of this metric across multiple servers in a cluster even if the number of cores is non-uniform, and still get the average resource utilization metric.|int|count|
|`OSOpenFiles`|The total number of opened files on the host machine. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|int|count|
|`OSProcessesBlocked`|Number of threads blocked waiting for I/O to complete (`man procfs`). This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|int|count|
|`OSProcessesCreated`|The number of processes created. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|int|count|
|`OSProcessesRunning`|The number of runnable (running or ready to run) threads by the operating system. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`.|int|count|
|`OSSoftIrqTime`|The ratio of time spent for running software interrupt requests on the CPU. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. A high number of this metric may indicate inefficient software running on the system. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|int|count|
|`OSSoftIrqTimeCPU`|The ratio of time spent for running software interrupt requests on the CPU. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. A high number of this metric may indicate inefficient software running on the system. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|int|count|
|`OSSoftIrqTimeNormalized`|The value is similar to `OSSoftIrqTime` but divided to the number of CPU cores to be measured in the [0..1] interval regardless of the number of cores. This allows you to average the values of this metric across multiple servers in a cluster even if the number of cores is non-uniform, and still get the average resource utilization metric.|int|count|
|`OSStealTime`|The ratio of time spent in other operating systems by the CPU when running in a virtualized environment. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Not every virtualized environments present this metric, and most of them don't. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|int|count|
|`OSStealTimeCPU`|The ratio of time spent in other operating systems by the CPU when running in a virtualized environment. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. Not every virtualized environments present this metric, and most of them don't. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|int|count|
|`OSStealTimeNormalized`|The value is similar to `OSStealTime` but divided to the number of CPU cores to be measured in the [0..1] interval regardless of the number of cores. This allows you to average the values of this metric across multiple servers in a cluster even if the number of cores is non-uniform, and still get the average resource utilization metric.|int|count|
|`OSSystemTime`|The ratio of time the CPU core was running OS kernel (system) code. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|int|count|
|`OSSystemTimeCPU`|The ratio of time the CPU core was running OS kernel (system) code. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|int|count|
|`OSSystemTimeNormalized`|The value is similar to `OSSystemTime` but divided to the number of CPU cores to be measured in the [0..1] interval regardless of the number of cores. This allows you to average the values of this metric across multiple servers in a cluster even if the number of cores is non-uniform, and still get the average resource utilization metric.|int|count|
|`OSThreadsRunnable`|The total number of 'runnable' threads, as the OS kernel scheduler seeing it.|int|count|
|`OSThreadsTotal`|The total number of threads, as the OS kernel scheduler seeing it.|int|count|
|`OSUptime`|The uptime of the host server (the machine where ClickHouse is running), in seconds.|int|count|
|`OSUserTime`|The ratio of time the CPU core was running `userspace` code. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. This includes also the time when the CPU was under-utilized due to the reasons internal to the CPU (memory loads, `pipeline stalls`, branch `mispredictions`, running another SMT core). The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|int|count|
|`OSUserTimeCPU`|The ratio of time the CPU core was running `userspace` code. This is a system-wide metric, it includes all the processes on the host machine, not just `clickhouse-server`. This includes also the time when the CPU was under-utilized due to the reasons internal to the CPU (memory loads, `pipeline stalls`, branch `mispredictions`, running another SMT core). The value for a single CPU core will be in the interval [0..1]. The value for all CPU cores is calculated as a sum across them [0..num cores].|int|count|
|`OSUserTimeNormalized`|The value is similar to `OSUserTime` but divided to the number of CPU cores to be measured in the [0..1] interval regardless of the number of cores. This allows you to average the values of this metric across multiple servers in a cluster even if the number of cores is non-uniform, and still get the average resource utilization metric.|int|count|
|`PostgreSQLThreads`|Number of threads in the server of the PostgreSQL compatibility protocol.|int|count|
|`PrometheusThreads`|Number of threads in the server of the Prometheus endpoint. Note: Prometheus endpoints can be also used via the usual HTTP/HTTPs ports.|int|count|
|`ReplicasMaxAbsoluteDelay`|Maximum difference in seconds between the most fresh replicated part and the most fresh data part still to be replicated, across Replicated tables. A very high value indicates a replica with no data.|int|count|
|`ReplicasMaxInsertsInQueue`|Maximum number of INSERT operations in the queue (still to be replicated) across Replicated tables.|int|count|
|`ReplicasMaxMergesInQueue`|Maximum number of merge operations in the queue (still to be applied) across Replicated tables.|int|count|
|`ReplicasMaxQueueSize`|Maximum queue size (in the number of operations like get, merge) across Replicated tables.|int|count|
|`ReplicasMaxRelativeDelay`|Maximum difference between the replica delay and the delay of the most up-to-date replica of the same table, across Replicated tables.|int|count|
|`ReplicasSumInsertsInQueue`|Sum of INSERT operations in the queue (still to be replicated) across Replicated tables.|int|count|
|`ReplicasSumMergesInQueue`|Sum of merge operations in the queue (still to be applied) across Replicated tables.|int|count|
|`ReplicasSumQueueSize`|Sum queue size (in the number of operations like get, merge) across Replicated tables.|int|count|
|`TCPThreads`|Number of threads in the server of the TCP protocol (without TLS).|int|count|
|`Temperature`|The temperature of the corresponding device in ℃. A sensor can return an unrealistic value. Source: `/sys/class/thermal`|int|count|
|`TotalBytesOfMergeTreeTables`|Total amount of bytes (compressed, including data and indices) stored in all tables of MergeTree family.|int|count|
|`TotalPartsOfMergeTreeTables`|Total amount of data parts in all tables of MergeTree family. Numbers larger than 10 000 will negatively affect the server startup time and it may indicate unreasonable choice of the partition key.|int|count|
|`TotalRowsOfMergeTreeTables`|Total amount of rows (records) stored in all tables of MergeTree family.|int|count|
|`UncompressedCacheBytes`|Total size of uncompressed cache in bytes. Uncompressed cache does not usually improve the performance and should be mostly avoided.|int|count|
|`UncompressedCacheCells`|Total number of entries in the uncompressed cache. Each entry represents a decompressed block of data. Uncompressed cache does not usually improve performance and should be mostly avoided.|int|count|
|`Uptime`|The server uptime in seconds. It includes the time spent for server initialization before accepting connections.|int|count|
|`jemalloc_active`|An internal metric of the low-level memory allocator (jemalloc).|int|count|
|`jemalloc_allocated`|An internal metric of the low-level memory allocator (jemalloc).|int|count|
|`jemalloc_arenas_all_dirty_purged`|An internal metric of the low-level memory allocator (jemalloc).|int|count|
|`jemalloc_arenas_all_muzzy_purged`|An internal metric of the low-level memory allocator (jemalloc).|int|count|
|`jemalloc_arenas_all_pactive`|An internal metric of the low-level memory allocator (jemalloc).|int|count|
|`jemalloc_arenas_all_pdirty`|An internal metric of the low-level memory allocator (jemalloc).|int|count|
|`jemalloc_arenas_all_pmuzzy`|An internal metric of the low-level memory allocator (jemalloc).|int|count|
|`jemalloc_background_thread_num_runs`|An internal metric of the low-level memory allocator (jemalloc).|int|count|
|`jemalloc_background_thread_num_threads`|An internal metric of the low-level memory allocator (jemalloc).|int|count|
|`jemalloc_background_thread_run_intervals`|An internal metric of the low-level memory allocator (jemalloc).|int|count|
|`jemalloc_epoch`|An internal incremental update number of the statistics of jemalloc (Jason Evans' memory allocator), used in all other `jemalloc` metrics.|int|count|
|`jemalloc_mapped`|An internal metric of the low-level memory allocator (jemalloc).|int|count|
|`jemalloc_metadata`|An internal metric of the low-level memory allocator (jemalloc).|int|count|
|`jemalloc_metadata_thp`|An internal metric of the low-level memory allocator (jemalloc).|int|count|
|`jemalloc_resident`|An internal metric of the low-level memory allocator (jemalloc).|int|count|
|`jemalloc_retained`|An internal metric of the low-level memory allocator (jemalloc).|int|count| 





### `ClickHouseMetrics`



- tag


| Tag | Description |
|  ----  | --------|
|`host`|host name|

- field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`ActiveAsyncDrainedConnections`|Number of active connections drained asynchronously.|int|count|
|`ActiveSyncDrainedConnections`|Number of active connections drained synchronously.|int|count|
|`AggregatorThreads`|Number of threads in the Aggregator thread pool.|int|count|
|`AggregatorThreadsActive`|Number of threads in the Aggregator thread pool running a task.|int|count|
|`AsyncDrainedConnections`|Number of connections drained asynchronously.|int|count|
|`AsyncInsertCacheSize`|Number of async insert hash id in cache|int|count|
|`AsynchronousInsertThreads`|Number of threads in the AsynchronousInsert thread pool.|int|count|
|`AsynchronousInsertThreadsActive`|Number of threads in the AsynchronousInsert thread pool running a task.|int|count|
|`AsynchronousReadWait`|Number of threads waiting for asynchronous read.|int|count|
|`BackgroundBufferFlushSchedulePoolSize`|Limit on number of tasks in BackgroundBufferFlushSchedulePool|int|count|
|`BackgroundBufferFlushSchedulePoolTask`|Number of active tasks in BackgroundBufferFlushSchedulePool. This pool is used for periodic Buffer flushes|int|count|
|`BackgroundCommonPoolSize`|Limit on number of tasks in an associated background pool|int|count|
|`BackgroundCommonPoolTask`|Number of active tasks in an associated background pool|int|count|
|`BackgroundDistributedSchedulePoolSize`|Limit on number of tasks in BackgroundDistributedSchedulePool|int|count|
|`BackgroundDistributedSchedulePoolTask`|Number of active tasks in BackgroundDistributedSchedulePool. This pool is used for distributed sends that is done in background.|int|count|
|`BackgroundFetchesPoolSize`|Limit on number of simultaneous fetches in an associated background pool|int|count|
|`BackgroundFetchesPoolTask`|Number of active fetches in an associated background pool|int|count|
|`BackgroundMergesAndMutationsPoolSize`|Limit on number of active merges and mutations in an associated background pool|int|count|
|`BackgroundMergesAndMutationsPoolTask`|Number of active merges and mutations in an associated background pool|int|count|
|`BackgroundMessageBrokerSchedulePoolSize`|Limit on number of tasks in BackgroundProcessingPool for message streaming|int|count|
|`BackgroundMessageBrokerSchedulePoolTask`|Number of active tasks in BackgroundProcessingPool for message streaming|int|count|
|`BackgroundMovePoolSize`|Limit on number of tasks in BackgroundProcessingPool for moves|int|count|
|`BackgroundMovePoolTask`|Number of active tasks in BackgroundProcessingPool for moves|int|count|
|`BackgroundPoolTask`|Number of active tasks in BackgroundProcessingPool (merges, mutations, or replication queue bookkeeping)|int|count|
|`BackgroundSchedulePoolSize`|Limit on number of tasks in BackgroundSchedulePool. This pool is used for periodic ReplicatedMergeTree tasks, like cleaning old data parts, altering data parts, replica re-initialization, etc.|int|count|
|`BackgroundSchedulePoolTask`|Number of active tasks in BackgroundSchedulePool. This pool is used for periodic ReplicatedMergeTree tasks, like cleaning old data parts, altering data parts, replica re-initialization, etc.|int|count|
|`BackupsIOThreads`|Number of threads in the BackupsIO thread pool.|int|count|
|`BackupsIOThreadsActive`|Number of threads in the BackupsIO thread pool running a task.|int|count|
|`BackupsThreads`|Number of threads in the thread pool for BACKUP.|int|count|
|`BackupsThreadsActive`|Number of threads in thread pool for BACKUP running a task.|int|count|
|`BrokenDistributedFilesToInsert`|Number of files for asynchronous insertion into Distributed tables that has been marked as broken. This metric will starts from 0 on start. Number of files for every shard is summed.|int|count|
|`CacheDetachedFileSegments`|Number of existing detached cache file segments|int|count|
|`CacheDictionaryThreads`|Number of threads in the CacheDictionary thread pool.|int|count|
|`CacheDictionaryThreadsActive`|Number of threads in the CacheDictionary thread pool running a task.|int|count|
|`CacheDictionaryUpdateQueueBatches`|Number of 'batches' (a set of keys) in update queue in CacheDictionaries.|int|count|
|`CacheDictionaryUpdateQueueKeys`|Exact number of keys in update queue in CacheDictionaries.|int|count|
|`CacheFileSegments`|Number of existing cache file segments|int|count|
|`ContextLockWait`|Number of threads waiting for lock in Context. This is global lock.|int|count|
|`DDLWorkerThreads`|Number of threads in the DDLWorker thread pool for ON CLUSTER queries.|int|count|
|`DDLWorkerThreadsActive`|Number of threads in the `DDLWORKER` thread pool for ON CLUSTER queries running a task.|int|count|
|`DatabaseCatalogThreads`|Number of threads in the DatabaseCatalog thread pool.|int|count|
|`DatabaseCatalogThreadsActive`|Number of threads in the DatabaseCatalog thread pool running a task.|int|count|
|`DatabaseOnDiskThreads`|Number of threads in the DatabaseOnDisk thread pool.|int|count|
|`DatabaseOnDiskThreadsActive`|Number of threads in the DatabaseOnDisk thread pool running a task.|int|count|
|`DatabaseOrdinaryThreads`|Number of threads in the Ordinary database thread pool.|int|count|
|`DatabaseOrdinaryThreadsActive`|Number of threads in the Ordinary database thread pool running a task.|int|count|
|`DelayedInserts`|Number of INSERT queries that are throttled due to high number of active data parts for partition in a MergeTree table.|int|count|
|`DestroyAggregatesThreads`|Number of threads in the thread pool for destroy aggregate states.|int|count|
|`DestroyAggregatesThreadsActive`|Number of threads in the thread pool for destroy aggregate states running a task.|int|count|
|`DictCacheRequests`|Number of requests in fly to data sources of dictionaries of cache type.|int|count|
|`DiskObjectStorageAsyncThreads`|Number of threads in the async thread pool for DiskObjectStorage.|int|count|
|`DiskObjectStorageAsyncThreadsActive`|Number of threads in the async thread pool for DiskObjectStorage running a task.|int|count|
|`DiskSpaceReservedForMerge`|Disk space reserved for currently running background merges. It is slightly more than the total size of currently merging parts.|int|count|
|`DistributedFilesToInsert`|Number of pending files to process for asynchronous insertion into Distributed tables. Number of files for every shard is summed.|int|count|
|`DistributedInsertThreads`|Number of threads used for INSERT into Distributed.|int|count|
|`DistributedInsertThreadsActive`|Number of threads used for INSERT into Distributed running a task.|int|count|
|`DistributedSend`|Number of connections to remote servers sending data that was INSERTed into Distributed tables. Both synchronous and asynchronous mode.|int|count|
|`EphemeralNode`|Number of ephemeral nodes hold in ZooKeeper.|int|count|
|`FilesystemCacheElements`|Filesystem cache elements (file segments)|int|count|
|`FilesystemCacheReadBuffers`|Number of active cache buffers|int|count|
|`FilesystemCacheSize`|Filesystem cache size in bytes|int|count|
|`GlobalThread`|Number of threads in global thread pool.|int|count|
|`GlobalThreadActive`|Number of threads in global thread pool running a task.|int|count|
|`HTTPConnection`|Number of connections to HTTP server|int|count|
|`HashedDictionaryThreads`|Number of threads in the HashedDictionary thread pool.|int|count|
|`HashedDictionaryThreadsActive`|Number of threads in the HashedDictionary thread pool running a task.|int|count|
|`IOPrefetchThreads`|Number of threads in the IO `prefertch` thread pool.|int|count|
|`IOPrefetchThreadsActive`|Number of threads in the IO prefetch thread pool running a task.|int|count|
|`IOThreads`|Number of threads in the IO thread pool.|int|count|
|`IOThreadsActive`|Number of threads in the IO thread pool running a task.|int|count|
|`IOUringInFlightEvents`|Number of io_uring SQEs in flight|int|count|
|`IOUringPendingEvents`|Number of io_uring SQEs waiting to be submitted|int|count|
|`IOWriterThreads`|Number of threads in the IO writer thread pool.|int|count|
|`IOWriterThreadsActive`|Number of threads in the IO writer thread pool running a task.|int|count|
|`InterserverConnection`|Number of connections from other replicas to fetch parts|int|count|
|`KafkaAssignedPartitions`|Number of partitions Kafka tables currently assigned to|int|count|
|`KafkaBackgroundReads`|Number of background reads currently working (populating materialized views from Kafka)|int|count|
|`KafkaConsumers`|Number of active Kafka consumers|int|count|
|`KafkaConsumersInUse`|Number of consumers which are currently used by direct or background reads|int|count|
|`KafkaConsumersWithAssignment`|Number of active Kafka consumers which have some partitions assigned.|int|count|
|`KafkaLibrdkafkaThreads`|Number of active `librdkafka` threads|int|count|
|`KafkaProducers`|Number of active Kafka producer created|int|count|
|`KafkaWrites`|Number of currently running inserts to Kafka|int|count|
|`KeeperAliveConnections`|Number of alive connections|int|count|
|`KeeperOutstandingRequets`|Number of outstanding requests|int|count|
|`LocalThread`|Number of threads in local thread pools. The threads in local thread pools are taken from the global thread pool.|int|count|
|`LocalThreadActive`|Number of threads in local thread pools running a task.|int|count|
|`MMappedAllocBytes`|Sum bytes of mmapped allocations|int|count|
|`MMappedAllocs`|Total number of mmapped allocations|int|count|
|`MMappedFileBytes`|Sum size of mmapped file regions.|int|count|
|`MMappedFiles`|Total number of mmapped files.|int|count|
|`MarksLoaderThreads`|Number of threads in thread pool for loading marks.|int|count|
|`MarksLoaderThreadsActive`|Number of threads in the thread pool for loading marks running a task.|int|count|
|`MaxDDLEntryID`|Max processed DDL entry of DDLWorker.|int|count|
|`MaxPushedDDLEntryID`|Max DDL entry of DDLWorker that pushed to zookeeper.|int|count|
|`MemoryTracking`|Total amount of memory (bytes) allocated by the server.|int|count|
|`Merge`|Number of executing background merges|int|count|
|`MergeTreeAllRangesAnnouncementsSent`|The current number of announcement being sent in flight from the remote server to the initiator server about the set of data parts (for MergeTree tables). Measured on the remote server side.|int|count|
|`MergeTreeBackgroundExecutorThreads`|Number of threads in the MergeTreeBackgroundExecutor thread pool.|int|count|
|`MergeTreeBackgroundExecutorThreadsActive`|Number of threads in the MergeTreeBackgroundExecutor thread pool running a task.|int|count|
|`MergeTreeDataSelectExecutorThreads`|Number of threads in the MergeTreeDataSelectExecutor thread pool.|int|count|
|`MergeTreeDataSelectExecutorThreadsActive`|Number of threads in the MergeTreeDataSelectExecutor thread pool running a task.|int|count|
|`MergeTreePartsCleanerThreads`|Number of threads in the MergeTree parts cleaner thread pool.|int|count|
|`MergeTreePartsCleanerThreadsActive`|Number of threads in the MergeTree parts cleaner thread pool running a task.|int|count|
|`MergeTreePartsLoaderThreads`|Number of threads in the MergeTree parts loader thread pool.|int|count|
|`MergeTreePartsLoaderThreadsActive`|Number of threads in the MergeTree parts loader thread pool running a task.|int|count|
|`MergeTreeReadTaskRequestsSent`|The current number of callback requests in flight from the remote server back to the initiator server to choose the read task (for MergeTree tables). Measured on the remote server side.|int|count|
|`Move`|Number of currently executing moves|int|count|
|`MySQLConnection`|Number of client connections using MySQL protocol|int|count|
|`NetworkReceive`|Number of threads receiving data from network. Only ClickHouse-related network interaction is included, not by 3rd party libraries.|int|count|
|`NetworkSend`|Number of threads sending data to network. Only ClickHouse-related network interaction is included, not by 3rd party libraries.|int|count|
|`OpenFileForRead`|Number of files open for reading|int|count|
|`OpenFileForWrite`|Number of files open for writing|int|count|
|`ParallelFormattingOutputFormatThreads`|Number of threads in the ParallelFormattingOutputFormatThreads thread pool.|int|count|
|`ParallelFormattingOutputFormatThreadsActive`|Number of threads in the ParallelFormattingOutputFormatThreads thread pool running a task.|int|count|
|`ParallelParsingInputFormatThreads`|Number of threads in the ParallelParsingInputFormat thread pool.|int|count|
|`ParallelParsingInputFormatThreadsActive`|Number of threads in the ParallelParsingInputFormat thread pool running a task.|int|count|
|`ParquetDecoderThreads`|Number of threads in the ParquetBlockInputFormat thread pool running a task.|int|count|
|`ParquetDecoderThreadsActive`|Number of threads in the ParquetBlockInputFormat thread pool.|int|count|
|`PartMutation`|Number of mutations (ALTER DELETE/UPDATE)|int|count|
|`PartsActive`|Active data part, used by current and upcoming SELECTs.|int|count|
|`PartsCommitted`|Deprecated. See PartsActive.|int|count|
|`PartsCompact`|Compact parts.|int|count|
|`PartsDeleteOnDestroy`|Part was moved to another disk and should be deleted in own destructor.|int|count|
|`PartsDeleting`|Not active data part with identity `refcounter`, it is deleting right now by a cleaner.|int|count|
|`PartsInMemory`|In-memory parts.|int|count|
|`PartsOutdated`|Not active data part, but could be used by only current SELECTs, could be deleted after SELECTs finishes.|int|count|
|`PartsPreActive`|The part is in data_parts, but not used for SELECTs.|int|count|
|`PartsPreCommitted`|Deprecated. See PartsPreActive.|int|count|
|`PartsTemporary`|The part is generating now, it is not in data_parts list.|int|count|
|`PartsWide`|Wide parts.|int|count|
|`PendingAsyncInsert`|Number of asynchronous inserts that are waiting for flush.|int|count|
|`PostgreSQLConnection`|Number of client connections using PostgreSQL protocol|int|count|
|`Query`|Number of executing queries|int|count|
|`QueryPipelineExecutorThreads`|Number of threads in the PipelineExecutor thread pool.|int|count|
|`QueryPipelineExecutorThreadsActive`|Number of threads in the PipelineExecutor thread pool running a task.|int|count|
|`QueryPreempted`|Number of queries that are stopped and waiting due to 'priority' setting.|int|count|
|`QueryThread`|Number of query processing threads|int|count|
|`RWLockActiveReaders`|Number of threads holding read lock in a table RWLock.|int|count|
|`RWLockActiveWriters`|Number of threads holding write lock in a table RWLock.|int|count|
|`RWLockWaitingReaders`|Number of threads waiting for read on a table RWLock.|int|count|
|`RWLockWaitingWriters`|Number of threads waiting for write on a table RWLock.|int|count|
|`Read`|Number of read (read, pread, `io_getevents`, etc.) `syscalls` in fly|int|count|
|`ReadTaskRequestsSent`|The current number of callback requests in flight from the remote server back to the initiator server to choose the read task (for s3Cluster table function and similar). Measured on the remote server side.|int|count|
|`ReadonlyReplica`|Number of Replicated tables that are currently in readonly state due to re-initialization after ZooKeeper session loss or due to startup without ZooKeeper configured.|int|count|
|`RemoteRead`|Number of read with remote reader in fly|int|count|
|`ReplicatedChecks`|Number of data parts checking for consistency|int|count|
|`ReplicatedFetch`|Number of data parts being fetched from replica|int|count|
|`ReplicatedSend`|Number of data parts being sent to replicas|int|count|
|`RestartReplicaThreads`|Number of threads in the RESTART REPLICA thread pool.|int|count|
|`RestartReplicaThreadsActive`|Number of threads in the RESTART REPLICA thread pool running a task.|int|count|
|`RestoreThreads`|Number of threads in the thread pool for RESTORE.|int|count|
|`RestoreThreadsActive`|Number of threads in the thread pool for RESTORE running a task.|int|count|
|`Revision`|Revision of the server. It is a number incremented for every release or release candidate except patch releases.|int|count|
|`S3Requests`|S3 requests|int|count|
|`SendExternalTables`|Number of connections that are sending data for external tables to remote servers. External tables are used to implement GLOBAL IN and GLOBAL JOIN operators with distributed `subqueries`.|int|count|
|`SendScalars`|Number of connections that are sending data for scalars to remote servers.|int|count|
|`StartupSystemTablesThreads`|Number of threads in the StartupSystemTables thread pool.|int|count|
|`StartupSystemTablesThreadsActive`|Number of threads in the StartupSystemTables thread pool running a task.|int|count|
|`StorageBufferBytes`|Number of bytes in buffers of Buffer tables|int|count|
|`StorageBufferRows`|Number of rows in buffers of Buffer tables|int|count|
|`StorageDistributedThreads`|Number of threads in the StorageDistributed thread pool.|int|count|
|`StorageDistributedThreadsActive`|Number of threads in the StorageDistributed thread pool running a task.|int|count|
|`StorageHiveThreads`|Number of threads in the StorageHive thread p`threadpool`ool.|int|count|
|`StorageHiveThreadsActive`|Number of threads in the StorageHive thread pool running a task.|int|count|
|`StorageS3Threads`|Number of threads in the StorageS3 thread pool.|int|count|
|`StorageS3ThreadsActive`|Number of threads in the StorageS3 thread pool running a task.|int|count|
|`SyncDrainedConnections`|Number of connections drained synchronously.|int|count|
|`SystemReplicasThreads`|Number of threads in the system.replicas thread pool.|int|count|
|`SystemReplicasThreadsActive`|Number of threads in the system.replicas thread pool running a task.|int|count|
|`TCPConnection`|Number of connections to TCP server (clients with native interface), also included server-server distributed query connections|int|count|
|`TablesLoaderThreads`|Number of threads in the tables loader thread pool.|int|count|
|`TablesLoaderThreadsActive`|Number of threads in the tables loader thread pool running a task.|int|count|
|`TablesToDropQueueSize`|Number of dropped tables, that are waiting for background data removal.|int|count|
|`TemporaryFilesForAggregation`|Number of temporary files created for external aggregation|int|count|
|`TemporaryFilesForJoin`|Number of temporary files created for JOIN|int|count|
|`TemporaryFilesForSort`|Number of temporary files created for external sorting|int|count|
|`TemporaryFilesUnknown`|Number of temporary files created without known purpose|int|count|
|`ThreadPoolFSReaderThreads`|Number of threads in the thread pool for local_filesystem_read_method=`threadpool`.|int|count|
|`ThreadPoolFSReaderThreadsActive`|Number of threads in the thread pool for local_filesystem_read_method=`threadpool` running a task.|int|count|
|`ThreadPoolRemoteFSReaderThreads`|Number of threads in the thread pool for remote_filesystem_read_method=`threadpool`.|int|count|
|`ThreadPoolRemoteFSReaderThreadsActive`|Number of threads in the thread pool for remote_filesystem_read_method=`threadpool` running a task.|int|count|
|`ThreadsInOvercommitTracker`|Number of waiting threads inside of `OvercommitTracker`|int|count|
|`TotalTemporaryFiles`|Number of temporary files created|int|count|
|`VersionInteger`|Version of the server in a single integer number in base-1000. For example, version 11.22.33 is translated to 11022033.|int|count|
|`Write`|Number of write (write, pwrite, `io_getevents`, etc.) `syscalls` in fly|int|count|
|`ZooKeeperRequest`|Number of requests to ZooKeeper in fly.|int|count|
|`ZooKeeperSession`|Number of sessions (connections) to ZooKeeper. Should be no more than one, because using more than one connection to ZooKeeper may lead to bugs due to lack of `linearizability` (stale reads) that ZooKeeper consistency model allows.|int|count|
|`ZooKeeperWatch`|Number of watches (event subscriptions) in ZooKeeper.|int|count| 





### `ClickHouseProfileEvents`



- tag


| Tag | Description |
|  ----  | --------|
|`host`|host name|

- field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`AIORead`|Number of reads with Linux or FreeBSD AIO interface|int|count|
|`AIOReadBytes`|Number of bytes read with Linux or FreeBSD AIO interface|int|count|
|`AIOWrite`|Number of writes with Linux or FreeBSD AIO interface|int|count|
|`AIOWriteBytes`|Number of bytes written with Linux or FreeBSD AIO interface|int|count|
|`AggregationHashTablesInitializedAsTwoLevel`|How many hash tables were `inited` as two-level for aggregation.|int|count|
|`AggregationPreallocatedElementsInHashTables`|How many elements were preallocated in hash tables for aggregation.|int|count|
|`ArenaAllocBytes`|Number of bytes allocated for memory Arena (used for GROUP BY and similar operations)|int|count|
|`ArenaAllocChunks`|Number of chunks allocated for memory Arena (used for GROUP BY and similar operations)|int|count|
|`AsyncInsertBytes`|Data size in bytes of asynchronous INSERT queries.|int|count|
|`AsyncInsertCacheHits`|Number of times a duplicate hash id has been found in asynchronous INSERT hash id cache.|int|count|
|`AsyncInsertQuery`|Same as InsertQuery, but only for asynchronous INSERT queries.|int|count|
|`AsynchronousReadWaitMicroseconds`|Time spent in waiting for asynchronous reads.|int|count|
|`AsynchronousRemoteReadWaitMicroseconds`|Time spent in waiting for asynchronous remote reads.|int|count|
|`BackgroundLoadingMarksTasks`|Number of background tasks for loading marks|int|count|
|`CachedReadBufferCacheWriteBytes`|Bytes written from source (remote fs, etc) to filesystem cache|int|count|
|`CachedReadBufferCacheWriteMicroseconds`|Time spent writing data into filesystem cache|int|count|
|`CachedReadBufferReadFromCacheBytes`|Bytes read from filesystem cache|int|count|
|`CachedReadBufferReadFromCacheMicroseconds`|Time reading from filesystem cache|int|count|
|`CachedReadBufferReadFromSourceBytes`|Bytes read from filesystem cache source (from remote fs, etc)|int|count|
|`CachedReadBufferReadFromSourceMicroseconds`|Time reading from filesystem cache source (from remote filesystem, etc)|int|count|
|`CachedWriteBufferCacheWriteBytes`|Bytes written from source (remote fs, etc) to filesystem cache|int|count|
|`CachedWriteBufferCacheWriteMicroseconds`|Time spent writing data into filesystem cache|int|count|
|`CannotRemoveEphemeralNode`|Number of times an error happened while trying to remove ephemeral node. This is not an issue, because our implementation of ZooKeeper library guarantee that the session will expire and the node will be removed.|int|count|
|`CannotWriteToWriteBufferDiscard`|Number of stack traces dropped by query profiler or signal handler because pipe is full or cannot write to pipe.|int|count|
|`CompileExpressionsBytes`|Number of bytes used for expressions compilation.|int|count|
|`CompileExpressionsMicroseconds`|Total time spent for compilation of expressions to LLVM code.|int|count|
|`CompileFunction`|Number of times a compilation of generated LLVM code (to create fused function for complex expressions) was initiated.|int|count|
|`CompiledFunctionExecute`|Number of times a compiled function was executed.|int|count|
|`CompressedReadBufferBlocks`|Number of compressed blocks (the blocks of data that are compressed independent of each other) read from compressed sources (files, network).|int|count|
|`CompressedReadBufferBytes`|Number of uncompressed bytes (the number of bytes after decompression) read from compressed sources (files, network).|int|count|
|`ContextLock`|Number of times the lock of Context was acquired or tried to acquire. This is global lock.|int|count|
|`CreatedHTTPConnections`|Total amount of created HTTP connections (counter increase every time connection is created).|int|count|
|`CreatedLogEntryForMerge`|Successfully created log entry to merge parts in ReplicatedMergeTree.|int|count|
|`CreatedLogEntryForMutation`|Successfully created log entry to mutate parts in ReplicatedMergeTree.|int|count|
|`CreatedReadBufferAIO`|Created read buffer AIO|int|count|
|`CreatedReadBufferAIOFailed`|Created read buffer AIO Failed|int|count|
|`CreatedReadBufferDirectIO`|Number of times a read buffer with O_DIRECT was created for reading data (while choosing among other read methods).|int|count|
|`CreatedReadBufferDirectIOFailed`|Number of times a read buffer with O_DIRECT was attempted to be created for reading data (while choosing among other read methods), but the OS did not allow it (due to lack of filesystem support or other reasons) and we fallen back to the ordinary reading method.|int|count|
|`CreatedReadBufferMMap`|Number of times a read buffer using `mmap` was created for reading data (while choosing among other read methods).|int|count|
|`CreatedReadBufferMMapFailed`|Number of times a read buffer with `mmap` was attempted to be created for reading data (while choosing among other read methods), but the OS did not allow it (due to lack of filesystem support or other reasons) and we fallen back to the ordinary reading method.|int|count|
|`CreatedReadBufferOrdinary`|Number of times ordinary read buffer was created for reading data (while choosing among other read methods).|int|count|
|`DNSError`|Total count of errors in DNS resolution|int|count|
|`DataAfterMergeDiffersFromReplica`|Number of times data after merge is not byte-identical to the data on another replicas. There could be several reasons|int|count|
|`DataAfterMutationDiffersFromReplica`|Number of times data after mutation is not byte-identical to the data on another replicas. In addition to the reasons described in 'DataAfterMergeDiffersFromReplica', it is also possible due to non-deterministic mutation.|int|count|
|`DelayedInserts`|Number of times the INSERT of a block to a MergeTree table was throttled due to high number of active data parts for partition.|int|count|
|`DelayedInsertsMilliseconds`|Total number of milliseconds spent while the INSERT of a block to a MergeTree table was throttled due to high number of active data parts for partition.|int|count|
|`DictCacheKeysExpired`|Number of keys looked up in the dictionaries of 'cache' types and found in the cache but they were obsolete.|int|count|
|`DictCacheKeysHit`|Number of keys looked up in the dictionaries of 'cache' types and found in the cache.|int|count|
|`DictCacheKeysNotFound`|Number of keys looked up in the dictionaries of 'cache' types and not found.|int|count|
|`DictCacheKeysRequested`|Number of keys requested from the data source for the dictionaries of 'cache' types.|int|count|
|`DictCacheKeysRequestedFound`|Number of keys requested from the data source for dictionaries of 'cache' types and found in the data source.|int|count|
|`DictCacheKeysRequestedMiss`|Number of keys requested from the data source for dictionaries of 'cache' types but not found in the data source.|int|count|
|`DictCacheLockReadNs`|Number of nanoseconds spend in waiting for read lock to lookup the data for the dictionaries of 'cache' types.|int|count|
|`DictCacheLockWriteNs`|Number of nanoseconds spend in waiting for write lock to update the data for the dictionaries of 'cache' types.|int|count|
|`DictCacheRequestTimeNs`|Number of nanoseconds spend in querying the external data sources for the dictionaries of 'cache' types.|int|count|
|`DictCacheRequests`|Number of bulk requests to the external data sources for the dictionaries of 'cache' types.|int|count|
|`DirectorySync`|Number of times the `F_FULLFSYNC/fsync/fdatasync` function was called for directories.|int|count|
|`DirectorySyncElapsedMicroseconds`|Total time spent waiting for `F_FULLFSYNC/fsync/fdatasync` syscall for directories.|int|count|
|`DiskReadElapsedMicroseconds`|Total time spent waiting for read syscall. This include reads from page cache.|int|count|
|`DiskS3AbortMultipartUpload`|Number of DiskS3 API AbortMultipartUpload calls.|int|count|
|`DiskS3CompleteMultipartUpload`|Number of DiskS3 API CompleteMultipartUpload calls.|int|count|
|`DiskS3CopyObject`|Number of DiskS3 API CopyObject calls.|int|count|
|`DiskS3CreateMultipartUpload`|Number of DiskS3 API CreateMultipartUpload calls.|int|count|
|`DiskS3DeleteObjects`|Number of DiskS3 API DeleteObject(s) calls.|int|count|
|`DiskS3GetObject`|Number of DiskS3 API GetObject calls.|int|count|
|`DiskS3GetObjectAttributes`|Number of DiskS3 API GetObjectAttributes calls.|int|count|
|`DiskS3GetRequestThrottlerCount`|Number of DiskS3 GET and SELECT requests passed through throttler.|int|count|
|`DiskS3GetRequestThrottlerSleepMicroseconds`|Total time a query was sleeping to conform DiskS3 GET and SELECT request throttling.|int|count|
|`DiskS3HeadObject`|Number of DiskS3 API HeadObject calls.|int|count|
|`DiskS3ListObjects`|Number of DiskS3 API ListObjects calls.|int|count|
|`DiskS3PutObject`|Number of DiskS3 API PutObject calls.|int|count|
|`DiskS3PutRequestThrottlerCount`|Number of DiskS3 PUT, COPY, POST and LIST requests passed through throttler.|int|count|
|`DiskS3PutRequestThrottlerSleepMicroseconds`|Total time a query was sleeping to conform DiskS3 PUT, COPY, POST and LIST request throttling.|int|count|
|`DiskS3ReadMicroseconds`|Time of GET and HEAD requests to DiskS3 storage.|int|count|
|`DiskS3ReadRequestsCount`|Number of GET and HEAD requests to DiskS3 storage.|int|count|
|`DiskS3ReadRequestsErrors`|Number of non-throttling errors in GET and HEAD requests to DiskS3 storage.|int|count|
|`DiskS3ReadRequestsRedirects`|Number of redirects in GET and HEAD requests to DiskS3 storage.|int|count|
|`DiskS3ReadRequestsThrottling`|Number of 429 and 503 errors in GET and HEAD requests to DiskS3 storage.|int|count|
|`DiskS3UploadPart`|Number of DiskS3 API UploadPart calls.|int|count|
|`DiskS3UploadPartCopy`|Number of DiskS3 API UploadPartCopy calls.|int|count|
|`DiskS3WriteMicroseconds`|Time of POST, DELETE, PUT and PATCH requests to DiskS3 storage.|int|count|
|`DiskS3WriteRequestsCount`|Number of POST, DELETE, PUT and PATCH requests to DiskS3 storage.|int|count|
|`DiskS3WriteRequestsErrors`|Number of non-throttling errors in POST, DELETE, PUT and PATCH requests to DiskS3 storage.|int|count|
|`DiskS3WriteRequestsRedirects`|Number of redirects in POST, DELETE, PUT and PATCH requests to DiskS3 storage.|int|count|
|`DiskS3WriteRequestsThrottling`|Number of 429 and 503 errors in POST, DELETE, PUT and PATCH requests to DiskS3 storage.|int|count|
|`DiskWriteElapsedMicroseconds`|Total time spent waiting for write syscall. This include writes to page cache.|int|count|
|`DistributedConnectionFailAtAll`|Total count when distributed connection fails after all retries finished.|int|count|
|`DistributedConnectionFailTry`|Total count when distributed connection fails with retry.|int|count|
|`DistributedConnectionMissingTable`|Number of times we rejected a replica from a distributed query, because it did not contain a table needed for the query.|int|count|
|`DistributedConnectionStaleReplica`|Number of times we rejected a replica from a distributed query, because some table needed for a query had replication lag higher than the configured threshold.|int|count|
|`DistributedDelayedInserts`|Number of times the INSERT of a block to a Distributed table was throttled due to high number of pending bytes.|int|count|
|`DistributedDelayedInsertsMilliseconds`|Total number of milliseconds spent while the INSERT of a block to a Distributed table was throttled due to high number of pending bytes.|int|count|
|`DistributedRejectedInserts`|Number of times the INSERT of a block to a Distributed table was rejected with 'Too many bytes' exception due to high number of pending bytes.|int|count|
|`DistributedSyncInsertionTimeoutExceeded`|A timeout has exceeded while waiting for shards during synchronous insertion into a Distributed table (with 'insert_distributed_sync' = 1)|int|count|
|`DuplicatedInsertedBlocks`|Number of times the INSERTed block to a ReplicatedMergeTree table was deduplicated.|int|count|
|`ExecuteShellCommand`|Number of shell command executions.|int|count|
|`ExternalAggregationCompressedBytes`|Number of bytes written to disk for aggregation in external memory.|int|count|
|`ExternalAggregationMerge`|Number of times temporary files were merged for aggregation in external memory.|int|count|
|`ExternalAggregationUncompressedBytes`|Amount of data (uncompressed, before compression) written to disk for aggregation in external memory.|int|count|
|`ExternalAggregationWritePart`|Number of times a temporary file was written to disk for aggregation in external memory.|int|count|
|`ExternalDataSourceLocalCacheReadBytes`|Bytes read from local cache buffer in RemoteReadBufferCache|int|count|
|`ExternalJoinCompressedBytes`|Number of compressed bytes written for JOIN in external memory.|int|count|
|`ExternalJoinMerge`|Number of times temporary files were merged for JOIN in external memory.|int|count|
|`ExternalJoinUncompressedBytes`|Amount of data (uncompressed, before compression) written for JOIN in external memory.|int|count|
|`ExternalJoinWritePart`|Number of times a temporary file was written to disk for JOIN in external memory.|int|count|
|`ExternalProcessingCompressedBytesTotal`|Number of compressed bytes written by external processing (sorting/aggravating/joining)|int|count|
|`ExternalProcessingFilesTotal`|Number of files used by external processing (sorting/aggravating/joining)|int|count|
|`ExternalProcessingUncompressedBytesTotal`|Amount of data (uncompressed, before compression) written by external processing (sorting/aggravating/joining)|int|count|
|`ExternalSortCompressedBytes`|Number of compressed bytes written for sorting in external memory.|int|count|
|`ExternalSortMerge`|Number of times temporary files were merged for sorting in external memory.|int|count|
|`ExternalSortUncompressedBytes`|Amount of data (uncompressed, before compression) written for sorting in external memory.|int|count|
|`ExternalSortWritePart`|Number of times a temporary file was written to disk for sorting in external memory.|int|count|
|`FailedAsyncInsertQuery`|Number of failed ASYNC INSERT queries.|int|count|
|`FailedInsertQuery`|Same as FailedQuery, but only for INSERT queries.|int|count|
|`FailedQuery`|Number of failed queries.|int|count|
|`FailedSelectQuery`|Same as FailedQuery, but only for SELECT queries.|int|count|
|`FileOpen`|Number of files opened.|int|count|
|`FileSegmentCacheWriteMicroseconds`|Metric per file segment. Time spend writing data to cache|int|count|
|`FileSegmentPredownloadMicroseconds`|Metric per file segment. Time spent `predownloading` data to cache (`predownloading` - finishing file segment download (after someone who failed to do that) up to the point current thread was requested to do)|int|count|
|`FileSegmentReadMicroseconds`|Metric per file segment. Time spend reading from file|int|count|
|`FileSegmentUsedBytes`|Metric per file segment. How many bytes were actually used from current file segment|int|count|
|`FileSegmentWaitReadBufferMicroseconds`|Metric per file segment. Time spend waiting for internal read buffer (includes cache waiting)|int|count|
|`FileSegmentWriteMicroseconds`|Metric per file segment. Time spend writing cache|int|count|
|`FileSync`|Number of times the `F_FULLFSYNC/fsync/fdatasync` function was called for files.|int|count|
|`FileSyncElapsedMicroseconds`|Total time spent waiting for `F_FULLFSYNC/fsync/fdatasync` syscall for files.|int|count|
|`FunctionExecute`|Number of SQL ordinary function calls (SQL functions are called on per-block basis, so this number represents the number of blocks).|int|count|
|`HardPageFaults`|The number of hard page faults in query execution threads. High values indicate either that you forgot to turn off swap on your server, or eviction of memory pages of the ClickHouse binary during very high memory pressure, or successful usage of the `mmap` read method for the tables data.|int|count|
|`HedgedRequestsChangeReplica`|Total count when timeout for changing replica expired in hedged requests.|int|count|
|`IOBufferAllocBytes`|Number of bytes allocated for IO buffers (for ReadBuffer/WriteBuffer).|int|count|
|`IOBufferAllocs`|Number of allocations of IO buffers (for ReadBuffer/WriteBuffer).|int|count|
|`IOUringCQEsCompleted`|Total number of successfully completed io_uring CQEs|int|count|
|`IOUringCQEsFailed`|Total number of completed io_uring CQEs with failures|int|count|
|`IOUringSQEsResubmits`|Total number of io_uring SQE resubmits performed|int|count|
|`IOUringSQEsSubmitted`|Total number of io_uring SQEs submitted|int|count|
|`InsertQuery`|Same as Query, but only for INSERT queries.|int|count|
|`InsertQueryTimeMicroseconds`|Total time of INSERT queries.|int|count|
|`InsertedBytes`|Number of bytes (uncompressed; for columns as they stored in memory) INSERTed to all tables.|int|count|
|`InsertedCompactParts`|Number of parts inserted in Compact format.|int|count|
|`InsertedInMemoryParts`|Number of parts inserted in InMemory format.|int|count|
|`InsertedRows`|Number of rows INSERTed to all tables.|int|count|
|`InsertedWideParts`|Number of parts inserted in Wide format.|int|count|
|`InvoluntaryContextSwitches`|Involuntary context switches|int|count|
|`KafkaBackgroundReads`|Number of background reads populating materialized views from Kafka since server start|int|count|
|`KafkaCommitFailures`|Number of failed commits of consumed offsets to Kafka (usually is a sign of some data duplication)|int|count|
|`KafkaCommits`|Number of successful commits of consumed offsets to Kafka (normally should be the same as KafkaBackgroundReads)|int|count|
|`KafkaConsumerErrors`|Number of errors reported by `librdkafka` during polls|int|count|
|`KafkaDirectReads`|Number of direct selects from Kafka tables since server start|int|count|
|`KafkaMessagesFailed`|Number of Kafka messages ClickHouse failed to parse|int|count|
|`KafkaMessagesPolled`|Number of Kafka messages polled from `librdkafka` to ClickHouse|int|count|
|`KafkaMessagesProduced`|Number of messages produced to Kafka|int|count|
|`KafkaMessagesRead`|Number of Kafka messages already processed by ClickHouse|int|count|
|`KafkaProducerErrors`|Number of errors during producing the messages to Kafka|int|count|
|`KafkaProducerFlushes`|Number of explicit flushes to Kafka producer|int|count|
|`KafkaRebalanceAssignments`|Number of partition assignments (the final stage of consumer group `rebalance`)|int|count|
|`KafkaRebalanceErrors`|Number of failed consumer group `rebalances`|int|count|
|`KafkaRebalanceRevocations`|Number of partition revocations (the first stage of consumer group `rebalance`)|int|count|
|`KafkaRowsRead`|Number of rows parsed from Kafka messages|int|count|
|`KafkaRowsRejected`|Number of parsed rows which were later rejected (due to `rebalances` / errors or similar reasons). Those rows will be consumed again after the `rebalance`.|int|count|
|`KafkaRowsWritten`|Number of rows inserted into Kafka tables|int|count|
|`KafkaWrites`|Number of writes (inserts) to Kafka tables |int|count|
|`KeeperCheckRequest`|Number of check requests|int|count|
|`KeeperCommits`|Number of successful commits|int|count|
|`KeeperCommitsFailed`|Number of failed commits|int|count|
|`KeeperCreateRequest`|Number of create requests|int|count|
|`KeeperExistsRequest`|Number of exists requests|int|count|
|`KeeperGetRequest`|Number of get requests|int|count|
|`KeeperLatency`|Keeper latency|int|count|
|`KeeperListRequest`|Number of list requests|int|count|
|`KeeperMultiReadRequest`|Number of multi read requests|int|count|
|`KeeperMultiRequest`|Number of multi requests|int|count|
|`KeeperPacketsReceived`|Packets received by keeper server|int|count|
|`KeeperPacketsSent`|Packets sent by keeper server|int|count|
|`KeeperReadSnapshot`|Number of snapshot read(serialization)|int|count|
|`KeeperRemoveRequest`|Number of remove requests|int|count|
|`KeeperRequestTotal`|Total requests number on keeper server|int|count|
|`KeeperSaveSnapshot`|Number of snapshot save|int|count|
|`KeeperSetRequest`|Number of set requests|int|count|
|`KeeperSnapshotApplys`|Number of snapshot applying|int|count|
|`KeeperSnapshotApplysFailed`|Number of failed snapshot applying|int|count|
|`KeeperSnapshotCreations`|Number of snapshots creations|int|count|
|`KeeperSnapshotCreationsFailed`|Number of failed snapshot creations|int|count|
|`LoadedMarksCount`|Number of marks loaded (total across columns).|int|count|
|`LoadedMarksMemoryBytes`|Size of in-memory representations of loaded marks.|int|count|
|`LocalReadThrottlerBytes`|Bytes passed through 'max_local_read_bandwidth_for_server'/'max_local_read_bandwidth' throttler.|int|count|
|`LocalReadThrottlerSleepMicroseconds`|Total time a query was sleeping to conform 'max_local_read_bandwidth_for_server'/'max_local_read_bandwidth' throttling.|int|count|
|`LocalWriteThrottlerBytes`|Bytes passed through 'max_local_write_bandwidth_for_server'/'max_local_write_bandwidth' throttler.|int|count|
|`LocalWriteThrottlerSleepMicroseconds`|Total time a query was sleeping to conform 'max_local_write_bandwidth_for_server'/'max_local_write_bandwidth' throttling.|int|count|
|`LogDebug`|Number of log messages with level Debug|int|count|
|`LogError`|Number of log messages with level Error|int|count|
|`LogFatal`|Number of log messages with level Fatal|int|count|
|`LogInfo`|Number of log messages with level Info|int|count|
|`LogTest`|Number of log messages with level Test|int|count|
|`LogTrace`|Number of log messages with level Trace|int|count|
|`LogWarning`|Number of log messages with level Warning|int|count|
|`MMappedFileCacheHits`|Number of times a file has been found in the MMap cache (for the `mmap` read_method), so we didn't have to `mmap` it again.|int|count|
|`MMappedFileCacheMisses`|Number of times a file has not been found in the MMap cache (for the `mmap` read_method), so we had to `mmap` it again.|int|count|
|`MainConfigLoads`|Number of times the main configuration was reloaded.|int|count|
|`MarkCacheHits`|Number of times an entry has been found in the mark cache, so we didn't have to load a mark file.|int|count|
|`MarkCacheMisses`|Number of times an entry has not been found in the mark cache, so we had to load a mark file in memory, which is a costly operation, adding to query latency.|int|count|
|`MemoryAllocatorPurge`|Total number of times memory allocator purge was requested|int|count|
|`MemoryAllocatorPurgeTimeMicroseconds`|Total number of times memory allocator purge was requested|int|count|
|`MemoryOvercommitWaitTimeMicroseconds`|Total time spent in waiting for memory to be freed in `OvercommitTracker`.|int|count|
|`Merge`|Number of launched background merges.|int|count|
|`MergeTreeAllRangesAnnouncementsSent`|The number of announcement sent from the remote server to the initiator server about the set of data parts (for MergeTree tables). Measured on the remote server side.|int|count|
|`MergeTreeAllRangesAnnouncementsSentElapsedMicroseconds`|Time spent in sending the announcement from the remote server to the initiator server about the set of data parts (for MergeTree tables). Measured on the remote server side.|int|count|
|`MergeTreeDataProjectionWriterBlocks`|Number of blocks INSERTed to MergeTree tables projection. Each block forms a data part of level zero.|int|count|
|`MergeTreeDataProjectionWriterBlocksAlreadySorted`|Number of blocks INSERTed to MergeTree tables projection that appeared to be already sorted.|int|count|
|`MergeTreeDataProjectionWriterCompressedBytes`|Bytes written to filesystem for data INSERTed to MergeTree tables projection.|int|count|
|`MergeTreeDataProjectionWriterRows`|Number of rows INSERTed to MergeTree tables projection.|int|count|
|`MergeTreeDataProjectionWriterUncompressedBytes`|Uncompressed bytes (for columns as they stored in memory) INSERTed to MergeTree tables projection.|int|count|
|`MergeTreeDataWriterBlocks`|Number of blocks INSERTed to MergeTree tables. Each block forms a data part of level zero.|int|count|
|`MergeTreeDataWriterBlocksAlreadySorted`|Number of blocks INSERTed to MergeTree tables that appeared to be already sorted.|int|count|
|`MergeTreeDataWriterCompressedBytes`|Bytes written to filesystem for data INSERTed to MergeTree tables.|int|count|
|`MergeTreeDataWriterRows`|Number of rows INSERTed to MergeTree tables.|int|count|
|`MergeTreeDataWriterUncompressedBytes`|Uncompressed bytes (for columns as they stored in memory) INSERTed to MergeTree tables.|int|count|
|`MergeTreeMetadataCacheDelete`|Number of `rocksdb` deletes(used for merge tree metadata cache)|int|count|
|`MergeTreeMetadataCacheGet`|Number of `rocksdb` reads(used for merge tree metadata cache)|int|count|
|`MergeTreeMetadataCacheHit`|Number of times the read of meta file was done from MergeTree metadata cache|int|count|
|`MergeTreeMetadataCacheMiss`|Number of times the read of meta file was not done from MergeTree metadata cache|int|count|
|`MergeTreeMetadataCachePut`|Number of `rocksdb` puts(used for merge tree metadata cache)|int|count|
|`MergeTreeMetadataCacheSeek`|Number of `rocksdb` seeks(used for merge tree metadata cache)|int|count|
|`MergeTreePrefetchedReadPoolInit`|Time spent preparing tasks in MergeTreePrefetchedReadPool|int|count|
|`MergeTreeReadTaskRequestsReceived`|The number of callbacks requested from the remote server back to the initiator server to choose the read task (for MergeTree tables). Measured on the initiator server side.|int|count|
|`MergeTreeReadTaskRequestsSent`|The number of callbacks requested from the remote server back to the initiator server to choose the read task (for MergeTree tables). Measured on the remote server side.|int|count|
|`MergeTreeReadTaskRequestsSentElapsedMicroseconds`|Time spent in callbacks requested from the remote server back to the initiator server to choose the read task (for MergeTree tables). Measured on the remote server side.|int|count|
|`MergedIntoCompactParts`|Number of parts merged into Compact format.|int|count|
|`MergedIntoInMemoryParts`|Number of parts in merged into InMemory format.|int|count|
|`MergedIntoWideParts`|Number of parts merged into Wide format.|int|count|
|`MergedRows`|Rows read for background merges. This is the number of rows before merge.|int|count|
|`MergedUncompressedBytes`|Uncompressed bytes (for columns as they stored in memory) that was read for background merges. This is the number before merge.|int|count|
|`MergesTimeMilliseconds`|Total time spent for background merges.|int|count|
|`NetworkReceiveBytes`|Total number of bytes received from network. Only ClickHouse-related network interaction is included, not by 3rd party libraries.|int|count|
|`NetworkReceiveElapsedMicroseconds`|Total time spent waiting for data to receive or receiving data from network. Only ClickHouse-related network interaction is included, not by 3rd party libraries.|int|count|
|`NetworkSendBytes`|Total number of bytes send to network. Only ClickHouse-related network interaction is included, not by 3rd party libraries.|int|count|
|`NetworkSendElapsedMicroseconds`|Total time spent waiting for data to send to network or sending data to network. Only ClickHouse-related network interaction is included, not by 3rd party libraries.|int|count|
|`NotCreatedLogEntryForMerge`|Log entry to merge parts in ReplicatedMergeTree is not created due to concurrent log update by another replica.|int|count|
|`NotCreatedLogEntryForMutation`|Log entry to mutate parts in ReplicatedMergeTree is not created due to concurrent log update by another replica.|int|count|
|`OSCPUVirtualTimeMicroseconds`|CPU time spent seen by OS. Does not include involuntary waits due to virtualization.|int|count|
|`OSCPUWaitMicroseconds`|Total time a thread was ready for execution but waiting to be scheduled by OS, from the OS point of view.|int|count|
|`OSIOWaitMicroseconds`|Total time a thread spent waiting for a result of IO operation, from the OS point of view. This is real IO that doesn't include page cache.|int|count|
|`OSReadBytes`|Number of bytes read from disks or block devices. Doesn't include bytes read from page cache. May include excessive data due to block size, `readahead`, etc.|int|count|
|`OSReadChars`|Number of bytes read from filesystem, including page cache.|int|count|
|`OSWriteBytes`|Number of bytes written to disks or block devices. Doesn't include bytes that are in page cache dirty pages. May not include data that was written by OS asynchronously.|int|count|
|`OSWriteChars`|Number of bytes written to filesystem, including page cache.|int|count|
|`ObsoleteReplicatedParts`|Number of times a data part was covered by another data part that has been fetched from a replica (so, we have marked a covered data part as obsolete and no longer needed).|int|count|
|`OpenedFileCacheHits`|Number of times a file has been found in the opened file cache, so we didn't have to open it again.|int|count|
|`OpenedFileCacheMisses`|Number of times a file has been found in the opened file cache, so we had to open it again.|int|count|
|`OtherQueryTimeMicroseconds`|Total time of queries that are not SELECT or INSERT.|int|count|
|`OverflowAny`|Number of times approximate GROUP BY was in effect: when aggregation was performed only on top of first 'max_rows_to_group_by' unique keys and other keys were ignored due to 'group_by_overflow_mode' = 'any'.|int|count|
|`OverflowBreak`|Number of times, data processing was canceled by query complexity limitation with setting '*_overflow_mode' = 'break' and the result is incomplete.|int|count|
|`OverflowThrow`|Number of times, data processing was canceled by query complexity limitation with setting '*_overflow_mode' = 'throw' and exception was thrown.|int|count|
|`PerfAlignmentFaults`|Number of alignment faults. These happen when unaligned memory accesses happen; the kernel can handle these but it reduces performance. This happens only on some architectures (never on x86).|int|count|
|`PerfBranchInstructions`|Retired branch instructions. Prior to Linux 2.6.35, this used the wrong event on AMD processors.|int|count|
|`PerfBranchMisses`|`Mispredicted` branch instructions.|int|count|
|`PerfBusCycles`|Bus cycles, which can be different from total cycles.|int|count|
|`PerfCacheMisses`|Cache misses. Usually this indicates Last Level Cache misses; this is intended to be used in con-junction with the `PERFCOUNTHWCACHEREFERENCES` event to calculate cache miss rates.|int|count|
|`PerfCacheReferences`|Cache accesses. Usually this indicates Last Level Cache accesses but this may vary depending on your CPU. This may include prefetches and coherency messages; again this depends on the design of your CPU.|int|count|
|`PerfContextSwitches`|Number of context switches|int|count|
|`PerfCpuClock`|The CPU clock, a high-resolution per-CPU timer|int|count|
|`PerfCpuCycles`|Total cycles. Be wary of what happens during CPU frequency scaling.|int|count|
|`PerfCpuMigrations`|Number of times the process has migrated to a new CPU|int|count|
|`PerfDataTLBMisses`|Data TLB misses|int|count|
|`PerfDataTLBReferences`|Data TLB references|int|count|
|`PerfEmulationFaults`|Number of emulation faults. The kernel sometimes traps on unimplemented instructions and emulates them for user space. This can negatively impact performance.|int|count|
|`PerfInstructionTLBMisses`|Instruction TLB misses|int|count|
|`PerfInstructionTLBReferences`|Instruction TLB references|int|count|
|`PerfInstructions`|Retired instructions. Be careful, these can be affected by various issues, most notably hardware interrupt counts.|int|count|
|`PerfLocalMemoryMisses`|Local NUMA node memory read `missesubqueriess`|int|count|
|`PerfLocalMemoryReferences`|Local NUMA node memory reads|int|count|
|`PerfMinEnabledRunningTime`|Running time for event with minimum enabled time. Used to track the amount of event multiplexing|int|count|
|`PerfMinEnabledTime`|For all events, minimum time that an event was enabled. Used to track event multiplexing influence|int|count|
|`PerfRefCpuCycles`|Total cycles; not affected by CPU frequency scaling.|int|count|
|`PerfStalledCyclesBackend`|Stalled cycles during retirement.|int|count|
|`PerfStalledCyclesFrontend`|Stalled cycles during issue.|int|count|
|`PerfTaskClock`|A clock count specific to the task that is running|int|count|
|`PolygonsAddedToPool`|A polygon has been added to the cache (pool) for the 'pointInPolygon' function.|int|count|
|`PolygonsInPoolAllocatedBytes`|The number of bytes for polygons added to the cache (pool) for the 'pointInPolygon' function.|int|count|
|`Query`|Number of queries to be interpreted and potentially executed. Does not include queries that failed to parse or were rejected due to AST size limits, quota limits or limits on the number of simultaneously running queries. May include internal queries initiated by ClickHouse itself. Does not count `subqueries`.|int|count|
|`QueryCacheHits`|Number of times a query result has been found in the query cache (and query computation was avoided).|int|count|
|`QueryCacheMisses`|Number of times a query result has not been found in the query cache (and required query computation).|int|count|
|`QueryMaskingRulesMatch`|Number of times query masking rules was successfully matched.|int|count|
|`QueryMemoryLimitExceeded`|Number of times when memory limit exceeded for query.|int|count|
|`QueryProfilerRuns`|Number of times QueryProfiler had been run.|int|count|
|`QueryProfilerSignalOverruns`|Number of times we drop processing of a query profiler signal due to overrun plus the number of signals that OS has not delivered due to overrun.|int|count|
|`QueryTimeMicroseconds`|Total time of all queries.|int|count|
|`RWLockAcquiredReadLocks`|Number of times a read lock was acquired (in a heavy RWLock).|int|count|
|`RWLockAcquiredWriteLocks`|Number of times a write lock was acquired (in a heavy RWLock).|int|count|
|`RWLockReadersWaitMilliseconds`|Total time spent waiting for a read lock to be acquired (in a heavy RWLock).|int|count|
|`RWLockWritersWaitMilliseconds`|Total time spent waiting for a write lock to be acquired (in a heavy RWLock).|int|count|
|`ReadBackoff`|Number of times the number of query processing threads was lowered due to slow reads.|int|count|
|`ReadBufferAIORead`|Read buffer AIO read|int|count|
|`ReadBufferAIOReadBytes`|Read buffer AIO read bytes|int|count|
|`ReadBufferFromFileDescriptorRead`|Number of reads (read/pread) from a file descriptor. Does not include sockets.|int|count|
|`ReadBufferFromFileDescriptorReadBytes`|Number of bytes read from file descriptors. If the file is compressed, this will show the compressed data size.|int|count|
|`ReadBufferFromFileDescriptorReadFailed`|Number of times the read (read/pread) from a file descriptor have failed.|int|count|
|`ReadBufferFromS3Bytes`|Bytes read from S3.|int|count|
|`ReadBufferFromS3InitMicroseconds`|Time spent initializing connection to S3.|int|count|
|`ReadBufferFromS3Microseconds`|Time spent on reading from S3.|int|count|
|`ReadBufferFromS3RequestsErrors`|Number of exceptions while reading from S3.|int|count|
|`ReadBufferSeekCancelConnection`|Number of seeks which lead to new connection (s3, http)|int|count|
|`ReadCompressedBytes`|Number of bytes (the number of bytes before decompression) read from compressed sources (files, network).|int|count|
|`ReadTaskRequestsReceived`|The number of callbacks requested from the remote server back to the initiator server to choose the read task (for s3Cluster table function and similar). Measured on the initiator server side.|int|count|
|`ReadTaskRequestsSent`|The number of callbacks requested from the remote server back to the initiator server to choose the read task (for s3Cluster table function and similar). Measured on the remote server side.|int|count|
|`ReadTaskRequestsSentElapsedMicroseconds`|Time spent in callbacks requested from the remote server back to the initiator server to choose the read task (for s3Cluster table function and similar). Measured on the remote server side.|int|count|
|`RealTimeMicroseconds`|Total (wall clock) time spent in processing (queries and other tasks) threads (note that this is a sum).|int|count|
|`RegexpCreated`|Compiled regular expressions. Identical regular expressions compiled just once and cached forever.|int|count|
|`RejectedInserts`|Number of times the INSERT of a block to a MergeTree table was rejected with 'Too many parts' exception due to high number of active data parts for partition.|int|count|
|`RemoteFSBuffers`|Number of buffers created for asynchronous reading from remote filesystem|int|count|
|`RemoteFSCancelledPrefetches`|Number of canceled `prefecthes` (because of seek)|int|count|
|`RemoteFSLazySeeks`|Number of lazy seeks|int|count|
|`RemoteFSPrefetchedBytes`|Number of bytes from prefetched buffer|int|count|
|`RemoteFSPrefetchedReads`|Number of reads from prefetched buffer|int|count|
|`RemoteFSPrefetches`|Number of prefetches made with asynchronous reading from remote filesystem|int|count|
|`RemoteFSSeeks`|Total number of seeks for async buffer|int|count|
|`RemoteFSSeeksWithReset`|Number of seeks which lead to a new connection|int|count|
|`RemoteFSUnprefetchedBytes`|Number of bytes from un prefetched buffer|int|count|
|`RemoteFSUnprefetchedReads`|Number of reads from un prefetched buffer|int|count|
|`RemoteFSUnusedPrefetches`|Number of prefetches pending at buffer destruction|int|count|
|`RemoteReadThrottlerBytes`|Bytes passed through 'max_remote_read_network_bandwidth_for_server'/'max_remote_read_network_bandwidth' throttler.|int|count|
|`RemoteReadThrottlerSleepMicroseconds`|Total time a query was sleeping to conform 'max_remote_read_network_bandwidth_for_server'/'max_remote_read_network_bandwidth' throttling.|int|count|
|`RemoteWriteThrottlerBytes`|Bytes passed through 'max_remote_write_network_bandwidth_for_server'/'max_remote_write_network_bandwidth' throttler.|int|count|
|`RemoteWriteThrottlerSleepMicroseconds`|Total time a query was sleeping to conform 'max_remote_write_network_bandwidth_for_server'/'max_remote_write_network_bandwidth' throttling.|int|count|
|`ReplicaPartialShutdown`|How many times Replicated table has to `deinitialize` its state due to session expiration in ZooKeeper. The state is reinitialized every time when ZooKeeper is available again.|int|count|
|`ReplicatedDataLoss`|Number of times a data part that we wanted doesn't exist on any replica (even on replicas that are offline right now). That data parts are definitely lost. This is normal due to asynchronous replication (if quorum inserts were not enabled), when the replica on which the data part was written was failed and when it became online after fail it doesn't contain that data part.|int|count|
|`ReplicatedPartChecks`|Number of times we had to perform advanced search for a data part on replicas or to clarify the need of an existing data part.|int|count|
|`ReplicatedPartChecksFailed`|Number of times the advanced search for a data part on replicas did not give result or when unexpected part has been found and moved away.|int|count|
|`ReplicatedPartFailedFetches`|Number of times a data part was failed to download from replica of a ReplicatedMergeTree table.|int|count|
|`ReplicatedPartFetches`|Number of times a data part was downloaded from replica of a ReplicatedMergeTree table.|int|count|
|`ReplicatedPartFetchesOfMerged`|Number of times we prefer to download already merged part from replica of ReplicatedMergeTree table instead of performing a merge ourself (usually we prefer doing a merge ourself to save network traffic). This happens when we have not all source parts to perform a merge or when the data part is old enough.|int|count|
|`ReplicatedPartMerges`|Number of times data parts of ReplicatedMergeTree tables were successfully merged.|int|count|
|`ReplicatedPartMutations`|Number of times data parts of ReplicatedMergeTree tables were successfully mutated.|int|count|
|`S3AbortMultipartUpload`|Number of S3 API AbortMultipartUpload calls.|int|count|
|`S3CompleteMultipartUpload`|Number of S3 API CompleteMultipartUpload calls.|int|count|
|`S3CopyObject`|Number of S3 API CopyObject calls.|int|count|
|`S3CreateMultipartUpload`|Number of S3 API CreateMultipartUpload calls.|int|count|
|`S3DeleteObjects`|Number of S3 API DeleteObject(s) calls.|int|count|
|`S3GetObject`|Number of S3 API GetObject calls.|int|count|
|`S3GetObjectAttributes`|Number of S3 API GetObjectAttributes calls.|int|count|
|`S3GetRequestThrottlerCount`|Number of S3 GET and SELECT requests passed through throttler.|int|count|
|`S3GetRequestThrottlerSleepMicroseconds`|Total time a query was sleeping to conform S3 GET and SELECT request throttling.|int|count|
|`S3HeadObject`|Number of S3 API HeadObject calls.|int|count|
|`S3ListObjects`|Number of S3 API ListObjects calls.|int|count|
|`S3PutObject`|Number of S3 API PutObject calls.|int|count|
|`S3PutRequestThrottlerCount`|Number of S3 PUT, COPY, POST and LIST requests passed through throttler.|int|count|
|`S3PutRequestThrottlerSleepMicroseconds`|Total time a query was sleeping to conform S3 PUT, COPY, POST and LIST request throttling.|int|count|
|`S3ReadBytes`|Read bytes (incoming) in GET and HEAD requests to S3 storage.|int|count|
|`S3ReadMicroseconds`|Time of GET and HEAD requests to S3 storage.|int|count|
|`S3ReadRequestsCount`|Number of GET and HEAD requests to S3 storage.|int|count|
|`S3ReadRequestsErrors`|Number of non-throttling errors in GET and HEAD requests to S3 storage.|int|count|
|`S3ReadRequestsRedirects`|Number of redirects in GET and HEAD requests to S3 storage.|int|count|
|`S3ReadRequestsThrottling`|Number of 429 and 503 errors in GET and HEAD requests to S3 storage.|int|count|
|`S3UploadPart`|Number of S3 API UploadPart calls.|int|count|
|`S3UploadPartCopy`|Number of S3 API UploadPartCopy calls.|int|count|
|`S3WriteBytes`|Write bytes (outgoing) in POST, DELETE, PUT and PATCH requests to S3 storage.|int|count|
|`S3WriteMicroseconds`|Time of POST, DELETE, PUT and PATCH requests to S3 storage.|int|count|
|`S3WriteRequestsCount`|Number of POST, DELETE, PUT and PATCH requests to S3 storage.|int|count|
|`S3WriteRequestsErrors`|Number of non-throttling errors in POST, DELETE, PUT and PATCH requests to S3 storage.|int|count|
|`S3WriteRequestsRedirects`|Number of redirects in POST, DELETE, PUT and PATCH requests to S3 storage.|int|count|
|`S3WriteRequestsThrottling`|Number of 429 and 503 errors in POST, DELETE, PUT and PATCH requests to S3 storage.|int|count|
|`ScalarSubqueriesCacheMiss`|Number of times a read from a scalar sub query was not cached and had to be calculated completely|int|count|
|`ScalarSubqueriesGlobalCacheHit`|Number of times a read from a scalar sub query was done using the global cache|int|count|
|`ScalarSubqueriesLocalCacheHit`|Number of times a read from a scalar sub query was done using the local cache|int|count|
|`SchemaInferenceCacheEvictions`|Number of times a schema from cache was evicted due to overflow|int|count|
|`SchemaInferenceCacheHits`|Number of times a schema from cache was used for schema inference|int|count|
|`SchemaInferenceCacheInvalidations`|Number of times a schema in cache became invalid due to changes in data|int|count|
|`SchemaInferenceCacheMisses`|Number of times a schema is not in cache while schema inference|int|count|
|`Seek`|Number of times the 'lseek' function was called.|int|count|
|`SelectQuery`|Same as Query, but only for SELECT queries.|int|count|
|`SelectQueryTimeMicroseconds`|Total time of SELECT queries.|int|count|
|`SelectedBytes`|Number of bytes (uncompressed; for columns as they stored in memory) SELECTed from all tables.|int|count|
|`SelectedMarks`|Number of marks (index granules) selected to read from a MergeTree table.|int|count|
|`SelectedParts`|Number of data parts selected to read from a MergeTree table.|int|count|
|`SelectedRanges`|Number of (non-adjacent) ranges in all data parts selected to read from a MergeTree table.|int|count|
|`SelectedRows`|Number of rows SELECTed from all tables.|int|count|
|`ServerStartupMilliseconds`|Time elapsed from starting server to listening to sockets in milliseconds|int|count|
|`SleepFunctionCalls`|Number of times a sleep function (sleep, sleepEachRow) has been called.|int|count|
|`SleepFunctionMicroseconds`|Time spent sleeping due to a sleep function call.|int|count|
|`SlowRead`|Number of reads from a file that were slow. This indicate system overload. Thresholds are controlled by read_backoff_* settings.|int|count|
|`SoftPageFaults`|The number of soft page faults in query execution threads. Soft page fault usually means a miss in the memory allocator cache which required a new memory mapping from the OS and subsequent allocation of a page of physical memory.|int|count|
|`StorageBufferErrorOnFlush`|Number of times a buffer in the 'Buffer' table has not been able to flush due to error writing in the destination table.|int|count|
|`StorageBufferFlush`|Number of times a buffer in a 'Buffer' table was flushed.|int|count|
|`StorageBufferLayerLockReadersWaitMilliseconds`|Time for waiting for Buffer layer during reading.|int|count|
|`StorageBufferLayerLockWritersWaitMilliseconds`|Time for waiting free Buffer layer to write to (can be used to tune Buffer layers).|int|count|
|`StorageBufferPassedAllMinThresholds`|Number of times a criteria on min thresholds has been reached to flush a buffer in a 'Buffer' table.|int|count|
|`StorageBufferPassedBytesFlushThreshold`|Number of times background-only flush threshold on bytes has been reached to flush a buffer in a 'Buffer' table. This is expert-only metric. If you read this and you are not an expert, stop reading.|int|count|
|`StorageBufferPassedBytesMaxThreshold`|Number of times a criteria on max bytes threshold has been reached to flush a buffer in a 'Buffer' table.|int|count|
|`StorageBufferPassedRowsFlushThreshold`|Number of times background-only flush threshold on rows has been reached to flush a buffer in a 'Buffer' table. This is expert-only metric. If you read this and you are not an expert, stop reading.|int|count|
|`StorageBufferPassedRowsMaxThreshold`|Number of times a criteria on max rows threshold has been reached to flush a buffer in a 'Buffer' table.|int|count|
|`StorageBufferPassedTimeFlushThreshold`|Number of times background-only flush threshold on time has been reached to flush a buffer in a 'Buffer' table. This is expert-only metric. If you read this and you are not an expert, stop reading.|int|count|
|`StorageBufferPassedTimeMaxThreshold`|Number of times a criteria on max time threshold has been reached to flush a buffer in a 'Buffer' table.|int|count|
|`SuspendSendingQueryToShard`|Total count when sending query to shard was suspended when async_query_sending_for_remote is enabled.|int|count|
|`SynchronousRemoteReadWaitMicroseconds`|Time spent in waiting for synchronous remote reads.|int|count|
|`SystemTimeMicroseconds`|Total time spent in processing (queries and other tasks) threads executing CPU instructions in OS kernel space. This include time CPU `pipeline` was stalled due to cache misses, branch `mispredictions`, hyper-threading, etc.|int|count|
|`TableFunctionExecute`|Number of table function calls.|int|count|
|`ThreadPoolReaderPageCacheHit`|Number of times the read inside ThreadPoolReader was done from page cache.|int|count|
|`ThreadPoolReaderPageCacheHitBytes`|Number of bytes read inside ThreadPoolReader when it was done from page cache.|int|count|
|`ThreadPoolReaderPageCacheHitElapsedMicroseconds`|Time spent reading data from page cache in ThreadPoolReader.|int|count|
|`ThreadPoolReaderPageCacheMiss`|Number of times the read inside ThreadPoolReader was not done from page cache and was hand off to thread pool.|int|count|
|`ThreadPoolReaderPageCacheMissBytes`|Number of bytes read inside ThreadPoolReader when read was not done from page cache and was hand off to thread pool.|int|count|
|`ThreadPoolReaderPageCacheMissElapsedMicroseconds`|Time spent reading data inside the asynchronous job in ThreadPoolReader - when read was not done from page cache.|int|count|
|`ThreadpoolReaderReadBytes`|Bytes read from a `threadpool` task in asynchronous reading|int|count|
|`ThreadpoolReaderSubmit`|Bytes read from a `threadpool` task in asynchronous reading|int|count|
|`ThreadpoolReaderTaskMicroseconds`|Time spent getting the data in asynchronous reading|int|count|
|`ThrottlerSleepMicroseconds`|Total time a query was sleeping to conform all throttling settings.|int|count|
|`UncompressedCacheHits`|Number of times a block of data has been found in the uncompressed cache (and decompression was avoided).|int|count|
|`UncompressedCacheMisses`|Number of times a block of data has not been found in the uncompressed cache (and required decompression).|int|count|
|`UncompressedCacheWeightLost`|Number of bytes evicted from the uncompressed cache.|int|count|
|`UserTimeMicroseconds`|Total time spent in processing (queries and other tasks) threads executing CPU instructions in user space. This include time CPU `pipeline` was stalled due to cache misses, branch `mispredictions`, hyper-threading, etc.|int|count|
|`VoluntaryContextSwitches`|Voluntary context switches|int|count|
|`WaitMarksLoadMicroseconds`|Time spent loading marks|int|count|
|`WaitPrefetchTaskMicroseconds`|Time spend waiting for prefetched reader|int|count|
|`WriteBufferAIOWrite`|Write Buffer AIO Write|int|count|
|`WriteBufferAIOWriteBytes`|Write buffer AIO write bytes|int|count|
|`WriteBufferFromFileDescriptorWrite`|Number of writes (write/pwrite) to a file descriptor. Does not include sockets.|int|count|
|`WriteBufferFromFileDescriptorWriteBytes`|Number of bytes written to file descriptors. If the file is compressed, this will show compressed data size.|int|count|
|`WriteBufferFromFileDescriptorWriteFailed`|Number of times the write (write/pwrite) to a file descriptor have failed.|int|count|
|`WriteBufferFromS3Bytes`|Bytes written to S3.|int|count|
|`WriteBufferFromS3Microseconds`|Time spent on writing to S3.|int|count|
|`WriteBufferFromS3RequestsErrors`|Number of exceptions while writing to S3.|int|count|
|`ZooKeeperBytesReceived`|Number of bytes received over network while communicating with ZooKeeper.|int|count|
|`ZooKeeperBytesSent`|Number of bytes send over network while communicating with ZooKeeper.|int|count|
|`ZooKeeperCheck`|Number of 'check' requests to ZooKeeper. Usually they don't make sense in isolation, only as part of a complex transaction.|int|count|
|`ZooKeeperClose`|Number of times connection with ZooKeeper has been closed voluntary.|int|count|
|`ZooKeeperCreate`|Number of 'create' requests to ZooKeeper.|int|count|
|`ZooKeeperExists`|Number of 'exists' requests to ZooKeeper.|int|count|
|`ZooKeeperGet`|Number of 'get' requests to ZooKeeper.|int|count|
|`ZooKeeperHardwareExceptions`|Number of exceptions while working with ZooKeeper related to network (connection loss or similar).|int|count|
|`ZooKeeperInit`|Number of times connection with ZooKeeper has been established.|int|count|
|`ZooKeeperList`|Number of 'list' (getChildren) requests to ZooKeeper.|int|count|
|`ZooKeeperMulti`|Number of 'multi' requests to ZooKeeper (compound transactions).|int|count|
|`ZooKeeperOtherExceptions`|Number of exceptions while working with ZooKeeper other than ZooKeeperUserExceptions and ZooKeeperHardwareExceptions.|int|count|
|`ZooKeeperRemove`|Number of 'remove' requests to ZooKeeper.|int|count|
|`ZooKeeperSet`|Number of 'set' requests to ZooKeeper.|int|count|
|`ZooKeeperSync`|Number of 'sync' requests to ZooKeeper. These requests are rarely needed or usable.|int|count|
|`ZooKeeperTransactions`|Number of ZooKeeper operations, which include both read and write operations as well as multi-transactions.|int|count|
|`ZooKeeperUserExceptions`|Number of exceptions while working with ZooKeeper related to the data (no node, bad version or similar).|int|count|
|`ZooKeeperWaitMicroseconds`|Number of microseconds spent waiting for responses from ZooKeeper after creating a request, summed across all the requesting threads.|int|count|
|`ZooKeeperWatchResponse`|Number of times watch notification has been received from ZooKeeper.|int|count| 





### `ClickHouseStatusInfo`



- tag


| Tag | Description |
|  ----  | --------|
|`host`|host name|

- field list


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`DictionaryStatus`|Dictionary Status.|int|count| 


