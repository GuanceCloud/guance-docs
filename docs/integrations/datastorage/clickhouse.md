# ClickHouse
---

## 视图预览

![image](../imgs/input-clickhouse-1.png)

## 版本支持

操作系统支持：Windows/AMD 64, Windows/386, Linux/ARM, Linux/ARM 64, Linux/386, Linux/AMD 64, Darwin/AMD 64

## 前置条件

- <[安装 DataKit](../../datakit/datakit-install.md)>
- 在 clickhouse-server 的 `config.xml` 配置文件中找到如下的代码段，取消注释，并设置 metrics 暴露的端口号（具体哪个自己造择，唯一即可）。修改完成后重启（若为集群，则每台机器均需操作）。

```shell
vim /etc/clickhouse-server/config.xml
```

```java
<prometheus>
    <endpoint>/metrics</endpoint>
    <port>9363</port>
    <metrics>true</metrics>
    <events>true</events>
    <asynchronous_metrics>true</asynchronous_metrics>
</prometheus>
```

- `endpoint` Prometheus 服务器抓取指标的 HTTP 路由
- `port` 端点的端口号
- `metrics` 从 ClickHouse 的 `system.metrics` 表中抓取暴露的指标标志
- `events` 从 ClickHouse 的 `system.events` 表中抓取暴露的事件标志
- `asynchronous_metrics` 从 ClickHouse 中 `system.asynchronous_metrics` 表中抓取暴露的异步指标标志

## 安装配置

说明：示例 ClickHouse 版本为 ClickHouse v20.1.2.4 (CentOS)，各个不同版本指标可能存在差异。

### 部署实施

#### 指标采集 (必选)

1、 开启 DataKit ClickHouse 插件，复制 sample

```bash
cd /usr/local/datakit/conf.d/db
cp clickhousev1.conf.sample clickhousev1.conf
```

> **注意：**当前 ClickHouse 采集器版本为 v1 版本，更早的版本被废弃了，但因为兼容性考虑，此处将改进后的采集器版本重新命名一下。

2、 修改 `clickhousev1.conf` 配置文件

```bash
vi clickhousev1.conf
```

配置如下：

```yaml

[[inputs.prom]]
  ## Exporter 地址
  url = "http://127.0.0.1:9363/metrics"

  ## 采集器别名
  source = "clickhouse"

  ## 采集数据输出源
  # 配置此项，可以将采集到的数据写到本地文件而不将数据打到中心
  # 之后可以直接用 datakit --prom-conf /path/to/this/conf 命令对本地保存的指标集进行调试
  # 如果已经将url配置为本地文件路径，则--prom-conf优先调试output路径的数据
  # output = "/abs/path/to/file"

  ## 采集数据大小上限，单位为字节
  # 将数据输出到本地文件时，可以设置采集数据大小上限
  # 如果采集数据的大小超过了此上限，则采集的数据将被丢弃
  # 采集数据大小上限默认设置为32MB
  # max_file_size = 0

  ## 指标类型过滤, 可选值为 counter, gauge, histogram, summary
  # 默认只采集 counter 和 gauge 类型的指标
  # 如果为空，则不进行过滤
  metric_types = ["counter", "gauge"]

  ## 指标名称过滤
  # 支持正则，可以配置多个，即满足其中之一即可
  # 如果为空，则不进行过滤
  # metric_name_filter = ["cpu"]

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
  prefix = "ClickHouseProfileEvents_"
  name = "ClickHouseProfileEvents"

  [[inputs.prom.measurements]]
  prefix = "ClickHouseMetrics_"
  name = "ClickHouseMetrics"

  [[inputs.prom.measurements]]
  prefix = "ClickHouseAsyncMetrics_"
  name = "ClickHouseAsyncMetrics"

  [[inputs.prom.measurements]]
  prefix = "ClickHouseStatusInfo_"
  name = "ClickHouseStatusInfo"

  ## 自定义Tags(集群可添加主机名)
  [inputs.prom.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```

3、 重启 DataKit (如果需要开启日志，请配置日志采集再重启)

```bash
systemctl restart datakit
```

4、 ClickHouse 指标采集验证 `/usr/local/datakit/datakit -M |egrep "最近采集|clickhouse"`

![image](../imgs/input-clickhouse-2.png)

5、 DQL 验证

```bash
[root@df-solution-ecs-018 prom]# datakit -Q
dql > M::ClickHouseAsyncMetrics LIMIT 1
-----------------[ r1.ClickHouseAsyncMetrics.s1 ]-----------------
 AsynchronousMetricsCalculationTimeSpent 0.000474
                     BlockActiveTime_vda 0.000006
                   BlockDiscardBytes_vda 0
                  BlockDiscardMerges_vda 0
                     BlockDiscardOps_vda 0
                    BlockDiscardTime_vda 0
                    BlockInFlightOps_vda 0
                      BlockQueueTime_vda 0.000013
                      BlockReadBytes_vda 0
                     BlockReadMerges_vda 0
                        BlockReadOps_vda 0
                       BlockReadTime_vda 0
                     BlockWriteBytes_vda 937984
                    BlockWriteMerges_vda 22
                       BlockWriteOps_vda 33
                      BlockWriteTime_vda 0.000012
                       CPUFrequencyMHz_0 2500.002000
                       CPUFrequencyMHz_1 2500.002000
                       CPUFrequencyMHz_2 2500.002000
                       CPUFrequencyMHz_3 2500.002000
            CompiledExpressionCacheBytes 0
            CompiledExpressionCacheCount 0
                   DiskAvailable_default 34984001536
                       DiskTotal_default 53675536384
                  DiskUnreserved_default 34984001536
                        DiskUsed_default 18691534848
        FilesystemLogsPathAvailableBytes 34984001536
       FilesystemLogsPathAvailableINodes 26006042
            FilesystemLogsPathTotalBytes 53675536384
           FilesystemLogsPathTotalINodes 26213824
             FilesystemLogsPathUsedBytes 18691534848
            FilesystemLogsPathUsedINodes 207782
        FilesystemMainPathAvailableBytes 34984001536
       FilesystemMainPathAvailableINodes 26006042
            FilesystemMainPathTotalBytes 53675536384
           FilesystemMainPathTotalINodes 26213824
             FilesystemMainPathUsedBytes 18691534848
            FilesystemMainPathUsedINodes 207782
                             HTTPThreads 0
                      InterserverThreads 0
                                  Jitter 0.000058
                            LoadAverage1 0
                           LoadAverage15 0.010000
                            LoadAverage5 0
                          MMapCacheCells 0
                          MarkCacheBytes 0
                          MarkCacheFiles 0
                MaxPartCountForPartition 5
                              MemoryCode 419885056
                      MemoryDataAndStack 1954865152
                          MemoryResident 381829120
                            MemoryShared 284856320
                           MemoryVirtual 2833399808
                            MySQLThreads 0
             NetworkReceiveBytes_docker0 0
     NetworkReceiveBytes_docker_gwbridge 0
                NetworkReceiveBytes_eth0 916
         NetworkReceiveBytes_veth09a999a 0
         NetworkReceiveBytes_veth1e1555d 0
         NetworkReceiveBytes_veth2d84a52 0
         NetworkReceiveBytes_veth3c5f604 0
         NetworkReceiveBytes_veth6a3f86c 0
         NetworkReceiveBytes_veth803fef3 0
         NetworkReceiveBytes_veth8f068fa 0
         NetworkReceiveBytes_veth961c694 0
         NetworkReceiveBytes_vethcd18fbd 0
              NetworkReceiveDrop_docker0 0
      NetworkReceiveDrop_docker_gwbridge 0
                 NetworkReceiveDrop_eth0 0
          NetworkReceiveDrop_veth09a999a 0
          NetworkReceiveDrop_veth1e1555d 0
          NetworkReceiveDrop_veth2d84a52 0
          NetworkReceiveDrop_veth3c5f604 0
          NetworkReceiveDrop_veth6a3f86c 0
          NetworkReceiveDrop_veth803fef3 0
          NetworkReceiveDrop_veth8f068fa 0
          NetworkReceiveDrop_veth961c694 0
          NetworkReceiveDrop_vethcd18fbd 0
            NetworkReceiveErrors_docker0 0
    NetworkReceiveErrors_docker_gwbridge 0
               NetworkReceiveErrors_eth0 0
        NetworkReceiveErrors_veth09a999a 0
        NetworkReceiveErrors_veth1e1555d 0
        NetworkReceiveErrors_veth2d84a52 0
        NetworkReceiveErrors_veth3c5f604 0
        NetworkReceiveErrors_veth6a3f86c 0
        NetworkReceiveErrors_veth803fef3 0
        NetworkReceiveErrors_veth8f068fa 0
        NetworkReceiveErrors_veth961c694 0
        NetworkReceiveErrors_vethcd18fbd 0
           NetworkReceivePackets_docker0 0
   NetworkReceivePackets_docker_gwbridge 0
              NetworkReceivePackets_eth0 1
       NetworkReceivePackets_veth09a999a 0
       NetworkReceivePackets_veth1e1555d 0
       NetworkReceivePackets_veth2d84a52 0
       NetworkReceivePackets_veth3c5f604 0
       NetworkReceivePackets_veth6a3f86c 0
       NetworkReceivePackets_veth803fef3 0
       NetworkReceivePackets_veth8f068fa 0
       NetworkReceivePackets_veth961c694 0
       NetworkReceivePackets_vethcd18fbd 0
                NetworkSendBytes_docker0 0
        NetworkSendBytes_docker_gwbridge 0
                   NetworkSendBytes_eth0 296
            NetworkSendBytes_veth09a999a 0
            NetworkSendBytes_veth1e1555d 0
            NetworkSendBytes_veth2d84a52 0
            NetworkSendBytes_veth3c5f604 0
            NetworkSendBytes_veth6a3f86c 0
            NetworkSendBytes_veth803fef3 0
            NetworkSendBytes_veth8f068fa 0
            NetworkSendBytes_veth961c694 0
            NetworkSendBytes_vethcd18fbd 0
                 NetworkSendDrop_docker0 0
         NetworkSendDrop_docker_gwbridge 0
                    NetworkSendDrop_eth0 0
             NetworkSendDrop_veth09a999a 0
             NetworkSendDrop_veth1e1555d 0
             NetworkSendDrop_veth2d84a52 0
             NetworkSendDrop_veth3c5f604 0
             NetworkSendDrop_veth6a3f86c 0
             NetworkSendDrop_veth803fef3 0
             NetworkSendDrop_veth8f068fa 0
             NetworkSendDrop_veth961c694 0
             NetworkSendDrop_vethcd18fbd 0
               NetworkSendErrors_docker0 0
       NetworkSendErrors_docker_gwbridge 0
                  NetworkSendErrors_eth0 0
           NetworkSendErrors_veth09a999a 0
           NetworkSendErrors_veth1e1555d 0
           NetworkSendErrors_veth2d84a52 0
           NetworkSendErrors_veth3c5f604 0
           NetworkSendErrors_veth6a3f86c 0
           NetworkSendErrors_veth803fef3 0
           NetworkSendErrors_veth8f068fa 0
           NetworkSendErrors_veth961c694 0
           NetworkSendErrors_vethcd18fbd 0
              NetworkSendPackets_docker0 0
      NetworkSendPackets_docker_gwbridge 0
                 NetworkSendPackets_eth0 2
          NetworkSendPackets_veth09a999a 0
          NetworkSendPackets_veth1e1555d 0
          NetworkSendPackets_veth2d84a52 0
          NetworkSendPackets_veth3c5f604 0
          NetworkSendPackets_veth6a3f86c 0
          NetworkSendPackets_veth803fef3 0
          NetworkSendPackets_veth8f068fa 0
          NetworkSendPackets_veth961c694 0
          NetworkSendPackets_vethcd18fbd 0
                       NumberOfDatabases 5
                          NumberOfTables 81
                       OSContextSwitches 10241
                         OSGuestNiceTime 0
                     OSGuestNiceTimeCPU0 0
                     OSGuestNiceTimeCPU1 0
                     OSGuestNiceTimeCPU2 0
                     OSGuestNiceTimeCPU3 0
               OSGuestNiceTimeNormalized 0
                             OSGuestTime 0
                         OSGuestTimeCPU0 0
                         OSGuestTimeCPU1 0
                         OSGuestTimeCPU2 0
                         OSGuestTimeCPU3 0
                   OSGuestTimeNormalized 0
                            OSIOWaitTime 0
                        OSIOWaitTimeCPU0 0
                        OSIOWaitTimeCPU1 0
                        OSIOWaitTimeCPU2 0.009999
                        OSIOWaitTimeCPU3 0
                  OSIOWaitTimeNormalized 0
                              OSIdleTime 3.859776
                          OSIdleTimeCPU0 0.969944
                          OSIdleTimeCPU1 0.959944
                          OSIdleTimeCPU2 0.959944
                          OSIdleTimeCPU3 0.969944
                    OSIdleTimeNormalized 0.964944
                            OSInterrupts 6659
                               OSIrqTime 0
                           OSIrqTimeCPU0 0
                           OSIrqTimeCPU1 0
                           OSIrqTimeCPU2 0
                           OSIrqTimeCPU3 0
                     OSIrqTimeNormalized 0
                       OSMemoryAvailable 2885054464
                         OSMemoryBuffers 1114112
                          OSMemoryCached 2715803648
                  OSMemoryFreePlusCached 2866614272
               OSMemoryFreeWithoutCached 150810624
                           OSMemoryTotal 7863308288
                              OSNiceTime 0
                          OSNiceTimeCPU0 0
                          OSNiceTimeCPU1 0
                          OSNiceTimeCPU2 0
                          OSNiceTimeCPU3 0
                    OSNiceTimeNormalized 0
                             OSOpenFiles 3648
                      OSProcessesBlocked 0
                      OSProcessesCreated 7
                      OSProcessesRunning 1
                           OSSoftIrqTime 0
                       OSSoftIrqTimeCPU0 0
                       OSSoftIrqTimeCPU1 0
                       OSSoftIrqTimeCPU2 0
                       OSSoftIrqTimeCPU3 0
                 OSSoftIrqTimeNormalized 0
                             OSStealTime 0
                         OSStealTimeCPU0 0
                         OSStealTimeCPU1 0
                         OSStealTimeCPU2 0
                         OSStealTimeCPU3 0
                   OSStealTimeNormalized 0
                            OSSystemTime 0.019999
                        OSSystemTimeCPU0 0.009999
                        OSSystemTimeCPU1 0.009999
                        OSSystemTimeCPU2 0.009999
                        OSSystemTimeCPU3 0
                  OSSystemTimeNormalized 0.005000
                       OSThreadsRunnable 1
                          OSThreadsTotal 932
                                OSUptime 1569326.150000
                              OSUserTime 0.059997
                          OSUserTimeCPU0 0.019999
                          OSUserTimeCPU1 0.009999
                          OSUserTimeCPU2 0.019999
                          OSUserTimeCPU3 0.009999
                    OSUserTimeNormalized 0.014999
                       PostgreSQLThreads 0
                       PrometheusThreads 1
                ReplicasMaxAbsoluteDelay 0
               ReplicasMaxInsertsInQueue 0
                ReplicasMaxMergesInQueue 0
                    ReplicasMaxQueueSize 0
                ReplicasMaxRelativeDelay 0
               ReplicasSumInsertsInQueue 0
                ReplicasSumMergesInQueue 0
                    ReplicasSumQueueSize 0
                              TCPThreads 0
             TotalBytesOfMergeTreeTables 853326
             TotalPartsOfMergeTreeTables 17
              TotalRowsOfMergeTreeTables 386427
                  UncompressedCacheBytes 0
                  UncompressedCacheCells 0
                                  Uptime 1321
                                    host 'df-solution-ecs-018'
                         jemalloc_active 92450816
                      jemalloc_allocated 83260600
        jemalloc_arenas_all_dirty_purged 525994
        jemalloc_arenas_all_muzzy_purged 448467
             jemalloc_arenas_all_pactive 22571
              jemalloc_arenas_all_pdirty 6479
              jemalloc_arenas_all_pmuzzy 1044
     jemalloc_background_thread_num_runs 0
  jemalloc_background_thread_num_threads 0
jemalloc_background_thread_run_intervals 0
                          jemalloc_epoch 1324
                         jemalloc_mapped 150528000
                       jemalloc_metadata 15701760
                   jemalloc_metadata_thp 0
                       jemalloc_resident 133472256
                       jemalloc_retained 80158720
                                    time 2022-01-06 16:04:01 +0800 CST
---------
1 rows, 1 series, cost 14.096273ms
```

6、 指标预览

![image](../imgs/input-clickhouse-3.png)

#### 插件标签 (非必选)
参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 ClickHouse 指标都会带有 `service = "ClickHouseAsyncMetrics"` 的标签，可以进行快速查询。
- 相关文档 <[TAG 在观测云中的最佳实践](../../best-practices/insight/tag.md)>
```
# 示例
[inputs.prom.tags]
  service = "ClickHouseAsyncMetrics"
```

重启 DataKit

```
systemctl restart datakit
```

## 场景视图
<暂无>


##  [指标详解](../../../datakit/clickhousev1#metrics)

## 最佳实践

<暂无>

## 故障排查

<[无数据上报排查](../../datakit/why-no-data.md)>

