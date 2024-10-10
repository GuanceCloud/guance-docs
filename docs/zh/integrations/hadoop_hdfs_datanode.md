---
title     : 'Hadoop HDFS DataNode'
summary   : '采集 HDFS datanode 指标信息'
__int_icon: 'icon/hadoop-hdfs'
dashboard :
  - desc  : 'HDFS DataNode'
    path  : 'dashboard/zh/hadoop-hdfs-datanode'
monitor   :
  - desc  : 'HDFS DataNode'
    path  : 'monitor/zh/hadoop_hdfs_datanode'
---

<!-- markdownlint-disable MD025 -->
# Hadoop HDFS DataNode
<!-- markdownlint-enable -->

采集 HDFS datanode 指标信息。

## 安装部署 {#config}

由于 DataNode 是 java 语言开发的，所以可以采用 jmx-exporter 的方式采集指标信息。

### 1. DataNode 配置

#### 1.1 下载 jmx-exporter

下载地址：`https://github.com/prometheus/jmx_exporter`

#### 1.2 下载 jmx 脚本

下载地址：`https://github.com/lrwh/jmx-exporter/blob/main/hadoop-hdfs-datanode.yml`

#### 1.3 DataNode 启动参数调整

在 datanode 的启动参数添加

> {{JAVA_GC_ARGS}} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17106:/opt/guance/jmx/hadoop-hdfs-datanode.yml

#### 1.4 重启 DataNode

### 2. DataKit 采集器配置

#### 2.1 [安装 DataKit](../datakit/datakit-install.md)

#### 2.2 配置采集器

通过 jmx-exporter 可以直接暴露`metrics` url，所以可以直接通过[`prom`](./prom.md)采集器进行采集。

进入 [DataKit 安装目录](./datakit_dir.md)下的 `conf.d/prom` ，复制 `prom.conf.sample` 为 `datanode.conf`。

> `cp prom.conf.sample datanode.conf`

调整`datanode.conf`内容如下：

```toml

  urls = ["http://localhost:17106/metrics"]
  source ="hdfs-datanode"
  [inputs.prom.tags]
    component = "hdfs-datanode" 
  interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*其他配置按需调整*</font>
<!-- markdownlint-enable -->
，调整参数说明 ：

<!-- markdownlint-disable MD004 -->
- urls：`jmx-exporter`指标地址，这里填写对应组件暴露出来的指标 url
- source：采集器别名，建议做区分
- keep_exist_metric_name: 保持指标名称
- interval：采集间隔
- inputs.prom.tags: 新增额外的 tag
<!-- markdownlint-enable -->

### 3. 重启 DataKit

[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service)

## 指标 {#metric}

### Hadoop 指标集

DataNode 指标位于 Hadoop 指标集下，这里主要介绍 DataNode 相关指标说明

| Metrics | 描述 |单位 |
|:--------|:-----|:--|
|`datanode_block_verification_failures` |`数据节点块校验失败次数` | count |
|`datanode_blocks_cached` |`数据节点缓存的块数量` | count |
|`datanode_blocks_read` |`数据节点读取的块数量` | count |
|`datanode_blocks_removed` |`数据节点移除的块数量` | count |
|`datanode_blocks_replicated` |`数据节点复制的块数量` | count |
|`datanode_blocks_uncached` |`数据节点未缓存的块数量` | count |
|`datanode_blocks_verified` |`数据节点已验证的块数量` | count |
|`datanode_blocks_written` |`数据节点写入的块数量` | count |
|`datanode_bytes_read` |`数据节点读取的字节数` | byte |
|`datanode_bytes_written` |`数据节点写入的字节数` | byte |
|`datanode_cache_capacity` |`数据节点缓存容量` | byte |
| `datanode_cache_reports_avg_time` | `数据节点缓存报告平均时间` | ms |
|`datanode_cache_reports_num_ops` |`数据节点缓存报告操作次数` | count |
|`datanode_cache_used` |`数据节点已使用的缓存量` | byte |
|`datanode_capacity` |`数据节点容量` | count |
|`datanode_data_node_active_xceivers_count` |`数据节点活跃接收器数量` | count |
|`datanode_datanode_network_errors` |`数据节点网络错误次数` | count |
| `datanode_dfs_used` | `数据节点已使用的DFS空间` | btye |
|`datanode_dropped_pub_all` |`数据节点丢失的发布消息总数` | count |
|`datanode_estimated_capacity_lost` |`数据节点估计丢失的容量` | byte |
| `datanode_flush_io_rate_avg_time` | `数据节点刷新I/O平均速率时间` | ms |
|`datanode_flush_io_rate_num_ops` |`数据节点刷新I/O操作次数` | count |
|`datanode_flush_nanos_avg_time` |`数据节点刷新操作平均耗时（纳秒）` | ns |
|`datanode_flush_nanos_num_ops` |`数据节点刷新操作次数` | count |
|`datanode_fsync_count` |`数据节点fsync操作次数` | count |
|`datanode_heartbeats_avg_time` |`数据节点心跳平均时间` | ms |
|`datanode_heartbeats_num_ops` |`数据节点心跳操作次数` | count |
|`datanode_heartbeats_total_avg_time` |`数据节点总心跳平均时间` | ms |
|`datanode_heartbeats_total_num_ops` |`数据节点总心跳操作次数` | count |
|`datanode_incremental_block_reports_avg_time` |`数据节点增量块报告平均时间` | ms |
|`datanode_incremental_block_reports_num_ops` |`数据节点增量块报告操作次数` | count |
|`datanode_lifelines_avg_time` |`数据节点生命周期信号平均时间` | ms |
|`datanode_lifelines_num_ops` |`数据节点生命周期信号操作次数` | count |
|`datanode_metadata_operation_rate_avg_time` |`数据节点元数据操作平均速率时间` | ms |
|`datanode_metadata_operation_rate_num_ops` |`数据节点元数据操作次数` | count |
|`datanode_num_active_sinks` |`数据节点活跃接收器数量` | count |
|`datanode_num_active_sources` |`数据节点活跃源数量` | count |
|`datanode_num_all_sinks` |`数据节点所有接收器数量` | count |
|`datanode_num_all_sources` |`数据节点所有源数量` | count |
|`datanode_num_blocks_cached` |`数据节点缓存的块数量` | count |
|`datanode_num_blocks_failed_to_cache` |`数据节点缓存失败的块数量` | count |
|`datanode_num_blocks_failed_to_un_cache` |`数据节点未缓存失败的块数量` | count |
|`datanode_num_blocks_failed_to_uncache` |`数据节点取消缓存失败的块数量` | count |
|`datanode_num_failed_volumes` |`数据节点失败的卷数量` | count |
|`datanode_publish_avg_time` |`数据节点发布平均时间` | ms |
|`datanode_publish_num_ops` |`数据节点发布操作次数` | count |
|`datanode_ram_disk_blocks_deleted_before_lazy_persisted` |`数据节点延迟持久化前删除的RAM磁盘块数量` | count |
|`datanode_ram_disk_blocks_evicted` |`数据节点逐出的RAM磁盘块数量` | count |
|`datanode_ram_disk_blocks_read_hits` |`数据节点RAM磁盘块读命中次数` | count |
|`datanode_ram_disk_blocks_write` |`数据节点RAM磁盘块写入次数` | count |
|`datanode_ram_disk_bytes_write` |`数据节点RAM磁盘写入字节数` | byte |
|`datanode_read_block_op_avg_time` |`数据节点读块操作平均时间` | ms |
|`datanode_read_block_op_num_ops` |`数据节点读块操作次数` | count |
|`datanode_read_io_rate_avg_time` |`数据节点读I/O平均速率时间` | ms |
|`datanode_read_io_rate_num_ops` |`数据节点读I/O操作次数` | count |
|`datanode_reads_from_local_client` |`数据节点来自本地客户端的读取次数` | count |
|`datanode_reads_from_remote_client` |`数据节点来自远程客户端的读取次数` | count |
|`datanode_remaining` |`数据节点剩余空间` | byte |
|`datanode_remote_bytes_read` |`数据节点远程读取字节数` | byte |
|`datanode_remote_bytes_written` |`数据节点远程写入字节数` | byte |
|`datanode_replace_block_op_avg_time` |`数据节点替换块操作平均时间` | ms |
|`datanode_replace_block_op_num_ops` |`数据节点替换块操作次数` | count |
|`datanode_send_data_packet_blocked_on_network_nanos_avg_time` |`数据节点发送数据包网络阻塞平均耗时（纳秒）` | ns |
|`datanode_send_data_packet_blocked_on_network_nanos_num_ops` |`数据节点发送数据包网络阻塞操作次数` | count |
|`datanode_send_data_packet_transfer_nanos_avg_time` |`数据节点发送数据包传输平均耗时（纳秒）` | ns |
|`datanode_send_data_packet_transfer_nanos_num_ops` |`数据节点发送数据包传输操作次数` | count |
|`datanode_snapshot_avg_time` |`数据节点快照平均时间` | ms |
|`datanode_snapshot_num_ops` |`数据节点快照操作次数` | count |
| `datanode_sync_io_rate_avg_time` | `数据节点同步I/O平均速率时间` | ms |
|`datanode_sync_io_rate_num_ops` |`数据节点同步I/O操作次数` |count  |
|`datanode_total_data_file_ios` |`数据节点总数据文件I/O次数` | count |
|`datanode_total_file_io_errors` |`数据节点总文件I/O错误次数` | count |
|`datanode_total_metadata_operations` |`数据节点总元数据操作次数` | count |
| `datanode_total_read_time` | `数据节点总读取时间` | ms |
| `datanode_total_write_time` | `数据节点总写入时间` | ms |
|`datanode_volume_failures` |`数据节点卷失败次数` | count |
|`datanode_write_block_op_avg_time` |`数据节点写块操作平均时间` | ms  |
|`datanode_write_block_op_num_ops` |`数据节点写块操作次数` | count |
|`datanode_write_io_rate_avg_time` |`数据节点写I/O平均速率时间` | ms |
|`datanode_write_io_rate_num_ops` |`数据节点写I/O操作次数` | count |
|`datanode_writes_from_local_client` |`数据节点来自本地客户端的写入次数` | count |
|`datanode_writes_from_remote_client` |`数据节点来自远程客户端的写入次数` | count |
|`datanode_xceiver_count` |`数据节点接收器数量` | count |
|`datanode_xmits_in_progress` |`数据节点正在进行的传输次数` | count |

