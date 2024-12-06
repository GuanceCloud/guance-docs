---
title     : 'HBase Region'
summary   : '采集 HBase Region 指标信息'
__int_icon: 'icon/hbase'
dashboard :
  - desc  : 'HBase Region 内置视图'
    path  : 'dashboard/zh/hbase_region'
---

采集 HBase Region 指标信息

## 配置 {#config}

### 1.HBase Region 配置

#### 1.1 下载 jmx-exporter

下载地址：`https://github.com/prometheus/jmx_exporter`

#### 1.2 下载 jmx 脚本

下载地址：`https://github.com/lrwh/jmx-exporter/blob/main/hbase.yaml`

#### 1.3 HBase Region 启动参数调整

在 HBase Region 的启动参数添加

> {{JAVA_GC_ARGS}} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:9407:/opt/guance/jmx/hbase.yaml

#### 1.4 重启 HBase

### 2. DataKit 采集器配置

#### 2.1 [安装 DataKit](../datakit/datakit-install.md)

#### 2.2 配置采集器

通过 jmx-exporter 可以直接暴露 `metrics` url，所以可以直接通过 [prom](./prom.md) 采集器进行采集。

进入 [DataKit 安装目录](./datakit_dir.md)下的 `conf.d/prom` ，复制 `prom.conf.sample` 为 `region.conf`。

> `cp prom.conf.sample region.conf`

调整`region.conf`内容如下：

```toml
  urls = ["http://localhost:9407/metrics"]
  source ="hbase-region"
  [inputs.prom.tags]
    component = "hbase-region" 
  interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*其他配置按需调整*</font>，调整参数说明 ：
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD004 -->
- urls：`jmx-exporter`指标地址，这里填写对应组件暴露出来的指标 url
- source：采集器别名，建议做区分
- keep_exist_metric_name: 保持指标名称
- interval：采集间隔
- inputs.prom.tags: 新增额外的 tag
<!-- markdownlint-enable -->

### 3. 重启 DataKit

[重启Datakit](../datakit/datakit-service-how-to.md#manage-service)

## 指标 {#metric}

### Hadoop 指标集

HBase Region 指标位于 Hadoop 指标集下，这里主要介绍 Hbase Region 相关指标说明

| Metrics | 描述 |单位 |
|:--------|:-----|:--|
|`hadoop_hbase_regionCount` |`区域服务器托管的区域数量` | count |
|`hadoop_hbase_storeFileCount` |`当前由regionserver管理的磁盘上的存储文件数` | count |
|`hadoop_hbase_storeFileSize` |`磁盘上存储文件的聚合大小` | byte |
|`hadoop_hbase_hlogFileCount` |`尚未归档的预写日志数` | count |
|`hadoop_hbase_totalRequestCount` |`收到的请求总数` | count |
|`hadoop_hbase_readRequestCount` |`收到的读取请求数` | count |
|`hadoop_hbase_writeRequestCount` |`收到的写入请求数` | count |
|`hadoop_hbase_numOpenConnections` |`RPC层的打开连接数` | count |
|`hadoop_hbase_numActiveHandler` |`主动为请求提供服务的RPC处理程序的数量` | count |
|`hadoop_hbase_numCallsInGeneralQueue` |`当前排队的用户请求数` | count |
|`hadoop_hbase_numCallsInReplicationQueue` |`从复制中收到的当前排队操作的数量` | count |
|`hadoop_hbase_numCallsInPriorityQueue` |`当前排队的优先级（内部管家）请求的数量` | count |
|`hadoop_hbase_flushQueueLength` |`memstore刷新队列的当前深度` | count |
|`hadoop_hbase_updatesBlockedTime` |`已阻止更新的毫秒数，因此可以刷新memstore` | ms |
|`hadoop_hbase_compactionQueueLength` |`压缩请求队列的当前深度` | count |
|`hadoop_hbase_blockCacheHitCount` |`块缓存命中数` | count |
|`hadoop_hbase_blockCacheMissCount` |`memstore刷新队列的当前深度` | count |
|`hadoop_hbase_blockCacheExpressHitPercent` |`打开缓存请求的时间百分比达到缓存` | count |
|`hadoop_hbase_percentFilesLocal` |`可从本地DataNode读取的存储文件数据的百分比` | count |
|`hadoop_hbase_append_99th_percentile` |`Append操作时间的第99百分位值` | ms |
|`hadoop_hbase_delete_99th_percentile` |`Delete操作时间的第99百分位值` | ms |
|`hadoop_hbase_get_99th_percentile` |`Get操作时间的第99百分位值` | ms |
|`hadoop_hbase_checkandput_99th_percentile` |`CheckAndPut操作时间的第99百分位值` | ms |
|`hadoop_hbase_checkanddelete_99th_percentile` |`CheckAndDelete操作时间的第99百分位值` | ms |
|`hadoop_hbase_increment_99th_percentile` |`Increment操作时间的第99百分位值` | ms |
|`hadoop_hbase_hedgedreadwins` |`hedged读操作的成功次数` | count |
|`hadoop_hbase_hedgedreads` |`hedged读操作的总数` | count |
|`hadoop_hbase_hedgedreadopsincurthread` |`当前线程中hedged读操作的数量` | count |
|`hadoop_hbase_l1cachehitratio` |`L1缓存的命中率` | % |
|`hadoop_hbase_l1cachemissratio` |`L1缓存的未命中率` | % |
|`hadoop_hbase_l2cachehitratio` |`L2缓存的命中率` | % |
|`hadoop_hbase_l2cachemissratio` |`L2缓存的未命中率` | % |
|`hadoop_hbase_logerror` |`记录的错误数量` | count |
|`hadoop_hbase_logfatal` |`记录的致命错误数量` | count |
|`hadoop_hbase_loginfo` |`记录的信息级别日志数量` | count |
|`hadoop_hbase_logwarn` |`记录的警告数量` | count |
|`hadoop_hbase_majorcompactiontime_max` |`压缩操作的最大时间` | ms |
|`hadoop_hbase_majorcompactiontime_mean` |`压缩操作的平均时间` | ms |
|`hadoop_hbase_majorcompactiontime_median` |`压缩操作的中位数时间` | ms |
|`hadoop_hbase_majorcompactiontime_min` |`压缩操作的最小时间` | ms |
|`hadoop_hbase_maxstorefileage` |`最大存储文件年龄` | count |
|`hadoop_hbase_memheapcommittedm` |`堆内存中已提交的内存量` | MB |
|`hadoop_hbase_memheapmaxm` |`堆内存的最大量` | MB |
|`hadoop_hbase_memheapusedm` |`堆内存中已使用的内存量` | MB |
|`hadoop_hbase_memmaxm` |`总内存的最大量` | MB |
|`hadoop_hbase_memnonheapcommittedm` |`非堆内存中已提交的内存量` | MB |
|`hadoop_hbase_memnonheapmaxm` |`非堆内存的最大量` | MB |
|`hadoop_hbase_memnonheapusedm` |`非堆内存中已使用的内存量` | MB |
|`hadoop_hbase_mobfilecachehitpercent` |`MOB文件缓存的命中率百分比` | % |
|`hadoop_hbase_mutationswithoutwalcount` |`没有写前日志（WAL）的变更次数` | count |
|`hadoop_hbase_averageregionsize` |`区域的平均大小` | MB |
|`hadoop_hbase_avgstorefileage` |`存储文件的平均年龄` | ms |
|`hadoop_hbase_blockcachecount` |`块缓存中的块总数` | count |
|`hadoop_hbase_blockcachecounthitpercent` |`块缓存的命中率百分比` | % |
|`hadoop_hbase_blockcachedatahitcount` |`块缓存中的数据块命中次数` | count |
|`hadoop_hbase_blockcacheevictioncount` |`块缓存的驱逐次数` | count |
|`hadoop_hbase_blockcachehitcount` |`块缓存的命中次数` | count |
|`hadoop_hbase_blockcachemisscount` |`块缓存的未命中次数` | count |
|`hadoop_hbase_compactioninputfilecount_99th_percentile` |`压缩操作输入文件数量的第99百分位值` | count |
|`hadoop_hbase_compactionoutputfilecount_99th_percentile` |`压缩操作输出文件数量的第99百分位值` | count |
|`hadoop_hbase_compactiontime_99th_percentile` |`压缩操作时间的第99百分位值` | ms |
|`hadoop_hbase_flushedmemstorebytes` |`被刷新的MemStore字节数` | byte |
|`hadoop_hbase_flushedoutputbytes` |`被刷新的输出字节数` | byte |
|`hadoop_hbase_flushmemstoresize_99th_percentile` |`刷新MemStore大小的第99百分位值` | byte |
|`hadoop_hbase_flushoutputsize_99th_percentile` |`刷新输出大小的第99百分位值` | byte |
|`hadoop_hbase_flushtime_99th_percentile` |`刷新操作时间的第99百分位值` | ms |
|`hadoop_hbase_get_25th_percentile` |`Get操作时间的第25百分位值` | ms |
|`hadoop_hbase_slowappendcount` |`慢Append操作的次数` | count |
|`hadoop_hbase_slowdeletecount` |`慢Delete操作的次数` | count |
|`hadoop_hbase_slowgetcount` |`慢Get操作的次数` | count |
|`hadoop_hbase_slowincrementcount` |`慢Increment操作的次数` | count |
|`hadoop_hbase_slowputcount` |`慢Put操作的次数` | count |
|`hadoop_hbase_snapshotavgtime` |`快照操作的平均时间` | ms |
|`hadoop_hbase_snapshotnumops` |`快照操作的总次数` | count |
|`hadoop_hbase_source_logeditsread` |`Source读取的日志编辑数` | count |
|`hadoop_hbase_source_shippedbytes` |`Source发货的字节数` | byte |
|`hadoop_hbase_source_shippedops` |`Source发货的操作数` | count |
|`hadoop_hbase_splitreuestcount` |`分裂请求的次数` | count |
|`hadoop_hbase_splitsuccesscount` |`分裂成功的总次数` | count |
|`hadoop_hbase_staticbloomsize` |`静态布隆过滤器的大小` | count |
|`hadoop_hbase_staticindexsize` |`静态索引的大小` | count |
|`hadoop_hbase_storefileindexsize` |`存储文件索引的大小` | count |
|`hadoop_hbase_storefilesize` |`存储文件的大小` | count |
|`hadoop_hbase_successfullogrolls` |`成功的日志滚动次数` | count |
|`hadoop_hbase_synctime_99th_percentile` |`同步操作时间的第99百分位值` | ms |
|`hadoop_hbase_tunerdonothingcounter` |`调优器无操作的次数` | count |
|`hadoop_hbase_updatesblockedtime` |`更新操作被阻塞的时间` | ms |
|`hadoop_hbase_writereuestcount` |`写请求的总次数` | count |
|`hadoop_hbase_writtenbytes` |`写入的总字节数` | byte |
|`hadoop_hbase_zerocopybytesread` |`零拷贝读取的字节数` | byte |
