---
title     : 'Hadoop HDFS NameNode'
summary   : '采集 HDFS namenode 指标信息'
__int_icon: 'icon/hadoop-hdfs'
dashboard :
  - desc  : 'HDFS NameNode'
    path  : 'dashboard/zh/hadoop-hdfs-namenode'
monitor   :
  - desc  : 'HDFS NameNode'
    path  : 'monitor/zh/hadoop_hdfs_namenode'
---

<!-- markdownlint-disable MD025 -->
# Hadoop HDFS NameNode
<!-- markdownlint-enable -->

采集 HDFS namenode 指标信息。

## 安装部署 {#config}

由于 NameNode 是 java 语言开发的，所以可以采用 jmx-exporter 的方式采集指标信息。

### 1. NameNode 配置

#### 1.1 下载 jmx-exporter

下载地址：`https://github.com/prometheus/jmx_exporter`

#### 1.2 下载 jmx 脚本

下载地址：`https://github.com/lrwh/jmx-exporter/blob/main/hadoop-hdfs-namenode.yml`

#### 1.3 NameNode 启动参数调整

在 namenode 的启动参数添加

> {{JAVA_GC_ARGS}} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17107:/opt/guance/jmx/hadoop-hdfs-namenode.yml

#### 1.4 重启 NameNode

### 2. DataKit 采集器配置

#### 2.1 [安装 DataKit](../datakit/datakit-install.md)

#### 2.2 配置采集器

通过 jmx-exporter 可以直接暴露`metrics` url，所以可以直接通过[`prom`](./prom.md)采集器进行采集。

进入 [DataKit 安装目录](./datakit_dir.md)下的 `conf.d/prom` ，复制 `prom.conf.sample` 为 `namenode.conf`。

> `cp prom.conf.sample namenode.conf`

调整`namenode.conf`内容如下：

```toml

  urls = ["http://localhost:17107/metrics"]
  source ="hdfs-namenode"
  [inputs.prom.tags]
    component = "hdfs-namenode" 
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

NameNode 指标位于 Hadoop 指标集下，这里主要介绍 NameNode 相关指标说明

| Metrics | 描述 |单位 |
| -- | -- |-- |
|`namenode_add_block_ops` |`添加块操作次数` | count |
|`namenode_allow_snapshot_ops` |`允许快照操作次数` | count |
|`namenode_block_capacity` |`块容量` | byte |
|`namenode_block_deletion_start_time` |`块删除开始时间` | count |
|`namenode_block_ops_batched` |`批量处理的块操作次数` | count |
|`namenode_block_ops_queued` |`排队的块操作次数` | count |
|`namenode_block_pool_used_space` |`使用的块池空间` | count |
|`namenode_block_received_and_deleted_ops` |`接收并删除的块操作次数` | count |
|`namenode_blocks` |`块数量` | count |
|`namenode_bytes_in_future_ecblock_groups` |`在未来EC块组中的字节数` | count |
|`namenode_bytes_in_future_replicated_blocks` |`在未来复制块中的字节数` | count |
|`namenode_bytes_with_future_generation_stamps` |`具有未来代际时间戳的字节数` | count |
|`namenode_cache_capacity` |`缓存容量` | byte |
|`namenode_cache_report_avg_time` |`缓存报告平均时间` | count |
|`namenode_cache_report_num_ops` |`缓存报告操作次数` | count |
|`namenode_cache_used` |`已使用的缓存` | count |
|`namenode_capacity` |`容量` | count |
|`namenode_capacity_remaining` |`剩余容量` | byte |
|`namenode_capacity_remaining_gb` |`剩余容量（GB）` | GB |
|`namenode_capacity_total_gb` |`总容量（GB）` | GB |
|`namenode_capacity_used` |`已使用的容量` | byte |
|`namenode_capacity_used_gb` |`已使用的容量（GB）` | GB |
|`namenode_capacity_used_non_dfs` |`非DFS使用的容量` | GB |
|`namenode_corrupt_blocks` |`损坏的块` | count |
|`namenode_corrupt_ecblock_groups` |`损坏的EC块组` | count |
|`namenode_corrupt_replicated_blocks` |`损坏的复制块` | count |
|`namenode_create_file_ops` |`创建文件操作次数` | count |
|`namenode_create_snapshot_ops` |`创建快照操作次数` | count |
|`namenode_create_symlink_ops` |`创建符号链接操作次数` | count |
|`namenode_delete_file_ops` |`删除文件操作次数` | count |
|`namenode_delete_snapshot_ops` |`删除快照操作次数` | count |
|`namenode_disallow_snapshot_ops` |`不允许快照操作次数` | count |
|`namenode_distinct_version_count` |`不同版本计数` | count |
|`namenode_distinct_versions` |`不同版本` | count |
|`namenode_dropped_pub_all` |`丢弃的pub_all` | count |
|`namenode_elapsed_time` |`经过时间` | ms |
|`namenode_estimated_capacity_lost` |`估计丢失的容量` | byte |
|`namenode_excess_blocks` |`多余的块` | count |
|`namenode_expired_heartbeats` |`过期的心跳` | count |
|`namenode_file_info_ops` |`文件信息操作次数` | count |
|`namenode_files` |`文件数量` | count |
|`namenode_files_appended` |`追加的文件数量` | count |
|`namenode_files_deleted` |`删除的文件数量` | count |
|`namenode_files_in_get_listing_ops` |`在获取列表操作中的文件数量` | count |
|`namenode_files_renamed` |`重命名的文件数量` | count |
|`namenode_files_truncated` |`截断的文件数量` | count |
|`namenode_free` |`空闲` | count |
|`namenode_fs_image_load_time` |`文件系统镜像加载时间` | ms |
|`namenode_fs_lock_queue_length` |`文件系统锁队列长度` | count |
|`namenode_gc_count` |`垃圾回收计数` | count |
|`namenode_generate_edektime_avg_time` |`生成EDEK时间平均时间` | ms |
|`namenode_generate_edektime_num_ops` |`生成EDEK操作次数` | count |
|`namenode_get_additional_datanode_ops` |`获取额外数据节点操作次数` | count |
|`namenode_highest_priority_low_redundancy_ecblocks` |`优先级最高的低冗余EC块` | count |
|`namenode_highest_priority_low_redundancy_replicated_blocks` |`优先级最高的低冗余复制块` | count |
|`namenode_last_checkpoint_time` |`上次检查点时间` | ms |
|`namenode_last_hatransition_time` |`上次HA转换时间` | ms |
|`namenode_last_written_transaction_id` |`最后写入的事务ID` | count |
|`namenode_list_snapshottable_dir_ops` |`列出可快照目录操作次数` | count |
|`namenode_lock_queue_length` |`锁队列长度` | count |
|`namenode_low_redundancy_ecblock_groups` |`低冗余EC块组` | count |
|`namenode_low_redundancy_replicated_blocks` |`低冗余复制块` | count |
|`namenode_max_objects` |`最大对象数` | count |
|`namenode_millis_since_last_loaded_edits` |`自上次加载编辑以来的毫秒数` | ms |
|`namenode_missing_blocks` |`缺失的块` | count |
|`namenode_missing_ecblock_groups` |`缺失的EC块组` | count |
|`namenode_missing_repl_one_blocks` |`缺失一个副本的块` | count |
|`namenode_missing_replicated_blocks` |`缺失的复制块` | count |
|`namenode_missing_replication_one_blocks` |`缺失一个副本的复制块` | count |
|`namenode_nnstarted_time_in_millis` |`启动时间（毫秒）` | ms |
|`namenode_non_dfs_used_space` |`非DFS使用的空間` | count |
|`namenode_num_active_clients` |`活动客户端数量` | count |
|`namenode_num_active_sinks` |`活动接收数据节点数量` | count |
|`namenode_num_active_sources` |`活动发送数据节点数量` | count |
|`namenode_num_all_sinks` |`所有接收数据节点数量` | count |
|`namenode_num_all_sources` |`所有发送数据节点数量` | count |
|`namenode_num_dead_data_nodes` |`死亡数据节点数量` | count |
|`namenode_num_decom_dead_data_nodes` |`已退用的死亡数据节点数量` | count |
|`namenode_num_decom_live_data_nodes` |`已退用的活跃数据节点数量` | count |
|`namenode_num_decommissioning_data_nodes` |`正在退用的数据节点数量` | count |
|`namenode_num_edit_log_loaded_avg_count` |`编辑日志加载平均计数` | count |
|`namenode_num_edit_log_loaded_num_ops` |`编辑日志加载操作次数` | count |
|`namenode_num_encryption_zones` |`加密区域数量` | count |
|`namenode_num_entering_maintenance_data_nodes` |`进入维护模式的数据节点数量` | count |
|`namenode_num_files_under_construction` |`正在构建的文件数量` | count |
|`namenode_num_in_maintenance_dead_data_nodes` |`维护中的死亡数据节点数量` | count |
|`namenode_num_in_maintenance_live_data_nodes` |`维护中的活跃数据节点数量` | count |
|`namenode_num_live_data_nodes` |`活跃数据节点数量` | count |
|`namenode_num_stale_data_nodes` |`过时数据节点数量` | count |
|`namenode_num_stale_storages` |`过时存储数量` | count |
|`namenode_num_timed_out_pending_reconstructions` |`超时待重建数量` | count |
|`namenode_num_times_re_replication_not_scheduled` |`未安排复制次数` | count |
|`namenode_number_of_missing_blocks` |`缺失块数量` | count |
|`namenode_number_of_missing_blocks_with_replication_factor_one` |`具有复制因子1的缺失块数量` | count |
|`namenode_number_of_snapshottable_dirs` |`可快照目录数量` | count |
|`namenode_pending_data_node_message_count` |`待处理数据节点消息计数` | count |
|`namenode_pending_deletion_blocks` |`待删除块数量` | count |
|`namenode_pending_deletion_ecblocks` |`待删除EC块数量` | count |
|`namenode_pending_deletion_replicated_blocks` |`待删除复制块数量` | count |
|`namenode_pending_reconstruction_blocks` |`待重建块数量` | count |
|`namenode_pending_replication_blocks` |`待复制块数量` | count |
|`namenode_percent_block_pool_used` |`块池使用百分比` | percent |
|`namenode_percent_complete` |`完成百分比` | percent |
|`namenode_percent_remaining` |`剩余百分比` | percent |
|`namenode_percent_used` |`已使用百分比` | percent |
|`namenode_postponed_misreplicated_blocks` |`推迟的错配块数量` | count |
|`namenode_publish_avg_time` |`发布平均时间` | ms |
|`namenode_publish_num_ops` |`发布操作次数` | count |
|`namenode_put_image_avg_time` |`放置镜像平均时间` | ms |
|`namenode_put_image_num_ops` |`放置镜像操作次数` | count |
|`namenode_rename_snapshot_ops` |`重命名快照操作次数` | count |
|`namenode_resource_check_time_avg_time` |`资源检查平均时间` | ms |
|`namenode_resource_check_time_num_ops` |`资源检查操作次数` | count |
|`namenode_safe_mode` |`安全模式` | count |
|`namenode_safe_mode_count` |`安全模式次数` | count |
|`namenode_safe_mode_elapsed_time` |`安全模式持续时间` | count |
|`namenode_safe_mode_percent_complete` |`安全模式完成百分比` | percent |
|`namenode_safe_mode_time` |`安全模式时间` | ms |
|`namenode_saving_checkpoint` |`保存检查点` | count |
|`namenode_saving_checkpoint_count` |`保存检查点次数` | count |
|`namenode_saving_checkpoint_elapsed_time` |`保存检查点持续时间` | ms |
|`namenode_saving_checkpoint_percent_complete` |`保存检查点完成百分比` | count |
|`namenode_scheduled_replication_blocks` |`计划复制块数量` | count |
|`namenode_stale_data_nodes` |`过时数据节点` | count |
|`namenode_storage_block_report_avg_time` |`存储块报告平均时间` | ms |
|`namenode_storage_block_report_num_ops` |`存储块报告操作次数` | count |
|`namenode_successful_re_replications` |`成功复制次数` | count |
|`namenode_syncs_avg_time` |`同步平均时间` | ms |
|`namenode_syncs_num_ops` |`同步操作次数` | count |
|`namenode_tag_total_sync_times` |`标签总同步次数` | count |
|`namenode_timeout_re_replications` |`超时复制次数` | count |
|`namenode_total_blocks` |`总块数量` | count |
|`namenode_total_ecblock_groups` |`总EC块组数量` | count |
|`namenode_total_file_ops` |`总文件操作次数` | count |
|`namenode_total_load` |`总负载` | count |
|`namenode_total_replicated_blocks` |`总复制块数量` | count |
|`namenode_total_sync_count` |`总同步次数` | count |
|`namenode_total_sync_times` |`总同步次数` | count |
|`namenode_transactions_avg_time` |`事务平均时间` | ms |
|`namenode_transactions_batched_in_sync` |`同步批处理事务数量` | count |
|`namenode_transactions_num_ops` |`事务操作次数` | count |
|`namenode_transactions_since_last_checkpoint` |`自上次检查点以来的事务数量` | count |
|`namenode_transactions_since_last_log_roll` |`自上次日志滚动以来的事务数量` | count |
|`namenode_under_replicated_blocks` |`副本不足块数量` | count |
|`namenode_used` |`已使用` | count |
|`namenode_volume_failures` |`卷故障次数` | count |
|`namenode_warm_up_edektime_avg_time` |`预热 EDEK 平均时间` | ms |
|`namenode_warm_up_edektime_num_ops` |`预热 EDEK 操作次数` | count |


