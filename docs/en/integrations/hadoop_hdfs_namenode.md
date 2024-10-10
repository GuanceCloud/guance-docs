---
title     : 'Hadoop HDFS NameNode'
summary   : 'Collect HDFS namenode metric information'
__int_icon: 'icon/hadoop-hdfs'
dashboard :
  - desc  : 'HDFS NameNode'
    path  : 'dashboard/en/hadoop_hdfs_namenode'
monitor   :
  - desc: 'HDFS NameNode'
    path: 'monitor/en/hadoop_hdfs_namenode'
---

<!-- markdownlint-disable MD025 -->
# Hadoop HDFS NameNode
<!-- markdownlint-enable -->

Collect HDFS namenode metric information.

## Installation and deployment {#config}

Since NameNode is developed in Java language, it can collect metric information using jmx exporter.

### 1. NameNode configuration

#### 1.1 Download jmx-exporter

Download link：`https://github.com/prometheus/jmx_exporter`

#### 1.2 Download jmx script

Download link：`https://github.com/lrwh/jmx-exporter/blob/main/hadoop-hdfs-namenode.yml`

#### 1.3 NameNode startup parameter adjustment

Add startup parameters to the namenode

> {{JAVA_GC_ARGS}} -javaagent:/opt/guance/jmx/jmx_exporter-1.0.1.jar=localhost:17107:/opt/guance/jmx/hadoop-hdfs-namenode.yml

#### 1.4 Restart NameNode

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Configure collector

By using jmx exporter, the `metrics` URL can be directly exposed, so it can be collected directly through the [`prom`](./prom.md) collector.

Go to the installation directory of [DataKit](./datakit_dir.md) and copy `prom.d/prom.sample` to `namenode.conf`.

> `cp prom.conf.sample namenode.conf`

Adjust the content of 'namenode. conf' as follows:

```toml

  urls = ["http://localhost:17107/metrics"]
  source ="hdfs-namenode"
  [inputs.prom.tags]
    component = "hdfs-namenode" 
  interval = "10s"
```

<!-- markdownlint-disable MD033 -->
<font color="red">*Adjust other configurations as needed*</font>
<!-- markdownlint-enable -->
，parameter adjustment instructions ：

<!-- markdownlint-disable MD004 -->
- urls：`jmx-exporter` metric address, fill in the URL of the metric exposed by the corresponding component here
- source：Collector alias, it is recommended to make a distinction
- keep_exist_metric_name: Maintain metric name
- interval：Collection interval
- inputs.prom.tags: Add additional tags

<!-- markdownlint-enable -->
### 3. Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metric {#metric}

### Hadoop Metric Set

The NameNode metric is located under the Hadoop metric set, and here we mainly introduce the description of NameNode related metrics

| Metrics | Description |Unit|
|:--------|:----|:----|
|`namenode_add_block_ops` |`Add block operation times` | count |
|`namenode_allow_snapshot_ops` |`Allow snapshot operation times` | count |
|`namenode_block_capacity` |`Block capacity` | byte |
|`namenode_block_deletion_start_time` |`Starting time of block deletion` | count |
|`namenode_block_ops_batched` |`Number of block operations for batch processing` | count |
|`namenode_block_ops_queued` |`The number of block operations queued` | count |
|`namenode_block_pool_used_space` |`Used block pool space` | count |
|`namenode_block_received_and_deleted_ops` |`Number of block operations received and deleted` | count |
|`namenode_blocks` |`Number of Blocks` | count |
|`namenode_bytes_in_future_ecblock_groups` |`The number of bytes in future EC block groups` | count |
|`namenode_bytes_in_future_replicated_blocks` |`The number of bytes in future replicated blocks` | count |
|`namenode_bytes_with_future_generation_stamps` |`The number of bytes with future generation timestamps` | count |
|`namenode_cache_capacity` |`Cache capacity` | byte |
|`namenode_cache_report_avg_time` |`Cache report average time` | count |
|`namenode_cache_report_num_ops` |`Number of cache report operations` | count |
|`namenode_cache_used` |`Used cache` | count |
|`namenode_capacity` |`capacity` | count |
|`namenode_capacity_remaining` |`Remaining capacity` | byte |
|`namenode_capacity_remaining_gb` |`Remaining capacity (GB)` | GB |
|`namenode_capacity_total_gb` |`Total capacity (GB)` | GB |
|`namenode_capacity_used` |`Used capacity` | byte |
|`namenode_capacity_used_gb` |`Used capacity (GB)` | GB |
|`namenode_capacity_used_non_dfs` |`Capacity used by non DFS` | GB |
|`namenode_corrupt_blocks` |`Damaged block` | count |
|`namenode_corrupt_ecblock_groups` |`Damaged EC block assembly` | count |
|`namenode_corrupt_replicated_blocks` |`Damaged replication block` | count |
|`namenode_create_file_ops` |`Number of file creation operations` | count |
|`namenode_create_snapshot_ops` |`Number of snapshot creation operations` | count |
|`namenode_create_symlink_ops` |`Number of symbol link creation operations` | count |
|`namenode_delete_file_ops` |`Number of file deletion operations` | count |
|`namenode_delete_snapshot_ops` |`Number of snapshot deletion operations` | count |
|`namenode_disallow_snapshot_ops` |`The number of times snapshot operations are not allowed` | count |
|`namenode_distinct_version_count` |`Different version counts` | count |
|`namenode_distinct_versions` |`Different version` | count |
|`namenode_dropped_pub_all` |`Discarded pub_all` | count |
|`namenode_elapsed_time` |`Over time` | ms |
|`namenode_estimated_capacity_lost` |`Estimate the lost capacity` | byte |
|`namenode_excess_blocks` |`Excess blocks` | count |
|`namenode_expired_heartbeats` |`Expired heartbeat` | count |
|`namenode_file_info_ops` |`Number of file information operations` | count |
|`namenode_files` |`Number of files` | count |
|`namenode_files_appended` |`Number of additional files added` | count |
|`namenode_files_deleted` |`Number of deleted files` | count |
|`namenode_files_in_get_listing_ops` |`The number of files in the get list operation` | count |
|`namenode_files_renamed` |`Number of renamed files` | count |
|`namenode_files_truncated` |`Number of truncated files` | count |
|`namenode_free` |`Free` | count |
|`namenode_fs_image_load_time` |`File system image loading time` | ms |
|`namenode_fs_lock_queue_length` |`The lock queue length of the file system` | count |
|`namenode_gc_count` |`Garbage collection count` | count |
|`namenode_generate_edektime_avg_time` |`Generate EDEK average time` | ms |
|`namenode_generate_edektime_num_ops` |`Number of operations to generate EDEK` | count |
|`namenode_get_additional_datanode_ops` |`The number of operations to obtain additional data nodes` | count |
|`namenode_highest_priority_low_redundancy_ecblocks` |`The highest priority low redundancy EC block` | count |
|`namenode_highest_priority_low_redundancy_replicated_blocks` |`The highest priority low redundancy replication block` | count |
|`namenode_last_checkpoint_time` |`Last checkpoint time` | ms |
|`namenode_last_hatransition_time` |`Last HA conversion time` | ms |
|`namenode_last_written_transaction_id` |`The last transaction ID written` | count |
|`namenode_list_snapshottable_dir_ops` |`List the number of operations that can snapshot directories` | count |
|`namenode_lock_queue_length` |`The length of the lock queue` | count |
|`namenode_low_redundancy_ecblock_groups` |`Low redundancy EC block group` | count |
|`namenode_low_redundancy_replicated_blocks` |`Low redundancy replication block` | count |
|`namenode_max_objects` |`Maximum number of objects` | count |
|`namenode_millis_since_last_loaded_edits` |`Milliseconds since last loading edit` | ms |
|`namenode_missing_blocks` |`Missing blocks` | count |
|`namenode_missing_ecblock_groups` |`Missing EC block group` | count |
|`namenode_missing_repl_one_blocks` |`Missing a block of a replica` | count |
|`namenode_missing_replicated_blocks` |`Missing replicated blocks` | count |
|`namenode_missing_replication_one_blocks` |`Missing replication block for one copy` | count |
|`namenode_nnstarted_time_in_millis` |`Start time (milliseconds)` | ms |
|`namenode_non_dfs_used_space` |`Space used by non DFS` | count |
|`namenode_num_active_clients` |`Number of active clients` | count |
|`namenode_num_active_sinks` |`Number of activity receiving data nodes` | count |
|`namenode_num_active_sources` |`The number of activity sending data nodes` | count |
|`namenode_num_all_sinks` |`The number of all receiving data nodes` | count |
|`namenode_num_all_sources` |`The number of all sending data nodes` | count |
|`namenode_num_dead_data_nodes` |`The number of dead data nodes` | count |
|`namenode_num_decom_dead_data_nodes` |`The number of retired dead data nodes` | count |
|`namenode_num_decom_live_data_nodes` |`The number of active data nodes that have been retired` | count |
|`namenode_num_decommissioning_data_nodes` |`The number of data nodes being retired` | count |
|`namenode_num_edit_log_loaded_avg_count` |`Edit log loading average count` | count |
|`namenode_num_edit_log_loaded_num_ops` |`Number of loading operations for editing logs` | count |
|`namenode_num_encryption_zones` |`Number of encrypted areas` | count |
|`namenode_num_entering_maintenance_data_nodes` |`Number of data nodes entering maintenance mode` | count |
|`namenode_num_files_under_construction` |`Number of files being built` | count |
|`namenode_num_in_maintenance_dead_data_nodes` |`Number of dead data nodes in maintenance` | count |
|`namenode_num_in_maintenance_live_data_nodes` |`Number of active data nodes under maintenance` | count |
|`namenode_num_live_data_nodes` |`Number of active data nodes` | count |
|`namenode_num_stale_data_nodes` |`Number of outdated data nodes` | count |
|`namenode_num_stale_storages` |`Outdated storage quantity` | count |
|`namenode_num_timed_out_pending_reconstructions` |`Number of timeout waiting to be rebuilt` | count |
|`namenode_num_times_re_replication_not_scheduled` |`No replication times scheduled` | count |
|`namenode_number_of_missing_blocks` |`Number of missing blocks` | count |
|`namenode_number_of_missing_blocks_with_replication_factor_one` |`Number of missing blocks with replication factors` | count |
|`namenode_number_of_snapshottable_dirs` |`Number of snapshot directories available` | count |
|`namenode_pending_data_node_message_count` |`Pending data node message count` | count |
|`namenode_pending_deletion_blocks` |`Number of blocks to be deleted` | count |
|`namenode_pending_deletion_ecblocks` |`Number of EC blocks to be deleted` | count |
|`namenode_pending_deletion_replicated_blocks` |`Number of copied blocks to be deleted` | count |
|`namenode_pending_reconstruction_blocks` |`Number of blocks to be reconstructed` | count |
|`namenode_pending_replication_blocks` |`Number of blocks to be copied` | count |
|`namenode_percent_block_pool_used` |`Percentage of block pool usage` | percent |
|`namenode_percent_complete` |`Completion percentage` | percent |
|`namenode_percent_remaining` |`Remaining percentage` | percent |
|`namenode_percent_used` |`Used percentage` | percent |
|`namenode_postponed_misreplicated_blocks` |`Number of delayed mismatch blocks` | count |
|`namenode_publish_avg_time` |`The average time of publication` | ms |
|`namenode_publish_num_ops` |`Number of published operations` | count |
|`namenode_put_image_avg_time` |`Average time to place images` | ms |
|`namenode_put_image_num_ops` |`Number of mirror placement operations` | count |
|`namenode_rename_snapshot_ops` |`Number of snapshot renaming operations` | count |
|`namenode_resource_check_time_avg_time` |`Average time for resource inspection` | ms |
|`namenode_resource_check_time_num_ops` |`Number of resource check operations` | count |
|`namenode_safe_mode` |`Safe mode` | count |
|`namenode_safe_mode_count` |`Safe mode frequency
` | count |
|`namenode_safe_mode_elapsed_time` |`Duration of Safe Mode
` | count |
|`namenode_safe_mode_percent_complete` |`Security mode completion percentage` | percent |
|`namenode_safe_mode_time` |`Safe mode time` | ms |
|`namenode_saving_checkpoint` |`Save Checkpoints` | count |
|`namenode_saving_checkpoint_count` |`Save checkpoint count` | count |
|`namenode_saving_checkpoint_elapsed_time` |`Save checkpoint duration` | ms |
|`namenode_saving_checkpoint_percent_complete` |`Save checkpoint completion percentage` | count |
|`namenode_scheduled_replication_blocks` |`Plan to copy the number of blocks` | count |
|`namenode_stale_data_nodes` |`Outdated data nodes` | count |
|`namenode_storage_block_report_avg_time` |`Storage block report average time` | ms |
|`namenode_storage_block_report_num_ops` |`Storage block report operation times` | count |
|`namenode_successful_re_replications` |`Number of successful copies` | count |
|`namenode_syncs_avg_time` |`Synchronization average time` | ms |
|`namenode_syncs_num_ops` |`Number of synchronization operations` | count |
|`namenode_tag_total_sync_times` |`Total number of tag synchronizations` | count |
|`namenode_timeout_re_replications` |`Timeout replication times` | count |
|`namenode_total_blocks` |`Total number of blocks` | count |
|`namenode_total_ecblock_groups` |`Total number of EC block groups` | count |
|`namenode_total_file_ops` |`Total number of file operations` | count |
|`namenode_total_load` |`Total load` | count |
|`namenode_total_replicated_blocks` |`Total number of copied blocks` | count |
|`namenode_total_sync_count` |`Total synchronization counts` | count |
|`namenode_total_sync_times` |`Total synchronization times` | count |
|`namenode_transactions_avg_time` |`Average transaction time` | ms |
|`namenode_transactions_batched_in_sync` |`Synchronize batch processing transaction quantity` | count |
|`namenode_transactions_num_ops` |`Number of transaction operations` | count |
|`namenode_transactions_since_last_checkpoint` |`The number of transactions since the last checkpoint` | count |
|`namenode_transactions_since_last_log_roll` |`The number of transactions since the last log roll` | count |
|`namenode_under_replicated_blocks` |`Insufficient number of blocks in the replica` | count |
|`namenode_used` |`Used already` | count |
|`namenode_volume_failures` |`Number of roll failures` | count |
|`namenode_warm_up_edektime_avg_time` |`Average preheating time for EDEK` | ms |
|`namenode_warm_up_edektime_num_ops` |`Preheating EDEK operation times` | count |


