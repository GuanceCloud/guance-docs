---
title: 'Huawei Cloud DDS'
tags: 
  - Huawei Cloud
summary: 'Collect Huawei Cloud DDS Metrics data'
__int_icon: 'icon/huawei_dds'
dashboard:
  - desc: 'Huawei Cloud DDS built-in views'
    path: 'dashboard/en/huawei_dds/'

monitor:
  - desc: 'Huawei Cloud DDS monitors'
    path: 'monitor/en/huawei_dds/'
---

Collect Huawei Cloud DDS Metrics data

## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/)

> It is recommended to deploy the GSE version

### Installation Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize Huawei Cloud DDS monitoring data, we install the corresponding collection scripts:

- **guance_huaweicloud_dds**: Collects DDS monitoring Metrics data
- **guance_huaweicloud_dds_slowlog**: Collects DDS slow log data

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup scripts.

After the script is installed, find the script "Guance Integration (Huawei Cloud-DDS Collection)" / "Guance Integration (Huawei Cloud-DDS Slow Query Log Collection)" under "Development" in Func, expand and modify the script. Find and edit the contents of `collector_configs` and `monitor_configs` under `region_projects`, change the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the regular time. After a while, you can view the execution task records and corresponding logs.

### Verification

1. Confirm in "Management / Automatic Trigger Configuration" whether the corresponding tasks have the corresponding automatic trigger configurations. You can also view the corresponding task records and logs to check for any abnormalities.
2. On the Guance platform, check in "Infrastructure - Resource Catalog" whether there is asset information.
3. On the Guance platform, check in "Metrics" whether there is corresponding monitoring data.
4. On the Guance platform, check in "Logs" whether there is corresponding slow log data.

## Metrics {#metric}

Configure Huawei Cloud DDS Metrics. You can collect more Metrics through configuration [Huawei Cloud DDS Metrics Details](https://support.huaweicloud.com/usermanual-dds/dds_03_0026.html){:target="_blank"}

| **Metric ID**            |          **Metric Name**   | **Metric Meaning** | **Value Range**      | **Measurement Object** | **Monitoring Period (Raw Metric)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `mongo001_command_ps`            |   command execution frequency    | This metric is used to count the average number of times per second command statements are executed on a node. Unit: Executions/s   | ≥ 0 Executions/s  | Document database instance Document database cluster instance's dds mongos node Document database instance's primary node Document database instance's secondary node | 1 minute 5 seconds                   |
| `mongo002_delete_ps`            |   delete statement execution frequency   | This metric is used to count the average number of times per second delete statements are executed on a node. Unit: Executions/s            | ≥ 0 Executions/s         | Document database instance Document database cluster instance's dds mongos node Document database instance's primary node Document database instance's secondary node | 1 minute 5 seconds              |
| `mongo003_insert_ps`            |    insert statement execution frequency  | This metric is used to count the average number of times per second insert statements are executed on a node. Unit: Executions/s | ≥ 0 Executions/s    | Document database instance Document database cluster instance's dds mongos node Document database instance's primary node Document database instance's secondary node   | 1 minute 5 seconds              |
| `mongo004_query_ps`             |    query statement execution frequency    | This metric is used to count the average number of times per second query statements are executed on a node. Unit: Executions/s | ≥ 0 Executions/s  | Document database instance Document database cluster instance's dds mongos node Document database instance's primary node Document database instance's secondary node | 1 minute 5 seconds                 |
| `mongo006_getmore_ps`           |      update statement execution frequency      | This metric is used to count the average number of times per second update statements are executed on a node. Unit: Executions/s   | 0 Executions/s      | Document database instance Document database cluster instance's dds mongos node Document database instance's primary node Document database instance's secondary node       | 1 minute 5 seconds                    |
| `mongo007_chunk_num1`           |     chunk count for shard one    | This metric counts the number of chunks for shard one. Unit: counts                           | 0~64 Counts       | Document database cluster instance   | 1 minute 5 seconds                    |
| `mongo007_chunk_num2`       |      chunk count for shard two      | This metric counts the number of chunks for shard two. Unit: counts           | 0~64 Counts       | Document database cluster instance       | 1 minute 5 seconds                    |
| `mongo007_chunk_num3`         |   chunk count for shard three    | This metric counts the number of chunks for shard three. Unit: counts           | 0~64 Counts | Document database cluster instance | 1 minute 5 seconds                    |
| `mongo007_chunk_num4`          |  chunk count for shard four  | This metric counts the number of chunks for shard four. Unit: counts           | 0~64 Counts | Document database cluster instance | 1 minute 5 seconds                    |
| `mongo007_chunk_num5`          |  chunk count for shard five  | This metric counts the number of chunks for shard five. Unit: counts          | 0~64 Counts | Document database cluster instance | 1 minute 5 seconds                    |
| `mongo007_chunk_num6`           |  chunk count for shard six   | This metric counts the number of chunks for shard six. Unit: counts          | 0~64 Counts   | Document database cluster instance | 1 minute 5 seconds                    |
| `mongo007_chunk_num7`          |  chunk count for shard seven  | This metric counts the number of chunks for shard seven. Unit: counts          | 0~64 Counts | Document database cluster instance | 1 minute 5 seconds                    |
| `mongo007_chunk_num8`         | chunk count for shard eight  | This metric counts the number of chunks for shard eight. Unit: counts          | 0~64 Counts | Document database cluster instance | 1 minute 5 seconds                    |
| `mongo007_chunk_num9`        |    chunk count for shard nine    | This metric counts the number of chunks for shard nine. Unit: counts         | 0~64 Counts   | Document database cluster instance | 1 minute 5 seconds                    |
| `mongo007_chunk_num10`     | chunk count for shard ten | This metric counts the number of chunks for shard ten. Unit: counts            | 0~64 Counts      | Document database cluster instance | 1 minute 5 seconds                    |
| `mongo007_chunk_num11`       |       chunk count for shard eleven       | This metric counts the number of chunks for shard eleven. Unit: counts           | 0~64 Counts       | Document database cluster instance | 1 minute 5 seconds                    |
| `mongo007_chunk_num12`        |       chunk count for shard twelve       | This metric counts the number of chunks for shard twelve. Unit: counts            | 0~64 Counts       | Document database cluster instance | 1 minute 5 seconds                    |
| `mongo008_connections` |     current active connections     | This metric counts the total number of connections attempting to connect to the DDS instance. Unit: Counts                   | 0~200 Counts | Document database instance      | 1 minute 5 seconds                    |
| `mongo009_migFail_num` |       failed block migrations over the past day       | This metric counts the number of failed block migrations over the past day. Unit: Counts/s                       | ≥ 0 Counts/s | Document database cluster instance | 1 minute 5 seconds                    |
| `mongo007_connections`     |     current active connections     | This metric counts the total number of connections attempting to connect to the DDS instance node. Unit: Counts                   | 0~200 Counts | Document database instance Document database cluster instance's dds mongos node Document database instance's primary node Document database instance's secondary node | 1 minute 5 seconds                    |
| `mongo007_connections_usage`    |     percentage of current active connections     | This metric counts the percentage of connections attempting to connect to the instance node out of available connections. Unit: %                   | 0~100% | Document database cluster instance's dds mongos node Document database instance's primary node Document database instance's secondary node | 1 minute 5 seconds                    |
| `mongo008_mem_resident`       |    resident memory    | This metric counts the current size of resident memory. Unit: MB               | ≥ 0 MB   | Document database cluster instance's dds mongos node Document database instance's primary node Document database instance's secondary node | 1 minute                    |
| `mongo009_mem_virtual`     |   virtual memory   | This metric counts the current size of virtual memory. Unit: MB                   | ≥ 0 MB   | Document database cluster instance's dds mongos node Document database instance's primary node Document database instance's secondary node | 1 minute                    |
| `mongo010_regular_asserts_ps`     |   regular assertion frequency   | This metric counts the regular assertion frequency. Unit: Executions/s             | ≥ 0 Executions/s   | Document database cluster instance's dds mongos node Document database instance's primary node Document database instance's secondary node | 1 minute                    |
| `mongo011_warning_asserts_ps`        |      warning frequency      | This metric counts the warning frequency. Unit: Executions/s           | ≥ 0 Executions/s   | Document database cluster instance's dds mongos node Document database instance's primary node Document database instance's secondary node | 1 minute                    |
| `mongo012_msg_asserts_ps`       |       message assertion frequency       | This metric counts the message assertion frequency. Unit: Executions/s             | ≥ 0 Executions/s   | Document database cluster instance's dds mongos node Document database instance's primary node Document database instance's secondary node | 1 minute                    |
| `mongo013_user_asserts_ps`       |    user assertion frequency    | This metric counts the user assertion frequency. Unit: Executions/s           | ≥ 0 Executions/s   | Document database cluster instance's dds mongos node Document database instance's primary node Document database instance's secondary node | 1 minute                    |
| `mongo014_queues_total`    |    operations waiting for locks    | This metric counts the current number of operations waiting for locks.  Unit: Counts       | ≥ 0 Counts   |     Document database instance's primary node Document database instance's secondary node | 1 minute                    |
| `mongo015_queues_readers`    |    operations waiting for read locks    | This metric counts the current number of operations waiting for read locks.  Unit: Counts       | ≥ 0 Counts   |     Document database instance's primary node Document database instance's secondary node | 1 minute                    |
| `mongo016_queues_writers`    |    operations waiting for write locks    | This metric counts the current number of operations waiting for write locks.  Unit: Counts       | ≥ 0 Counts   |     Document database instance's primary node Document database instance's secondary node | 1 minute                    |
| `mongo017_page_faults`    |    page fault count    | This metric counts the current number of page faults on the node.  Unit: Counts       | ≥ 0 Counts   |     Document database instance's primary node Document database instance's secondary node | 1 minute                    |
| `mongo018_porfling_num`    |    slow query count    | This metric counts the total number of slow queries from the last 5 minutes to the current time point on the node.  Unit: Counts       | ≥ 0 Counts   |     Document database instance's primary node Document database instance's secondary node | 1 minute                    |
| `mongo019_cursors_open`    |    current open cursor count    | This metric counts the current number of open cursors on the node. Unit: Counts       | ≥ 0 Counts   |     Document database instance's primary node Document database instance's secondary node | 1 minute                    |
| `mongo020_cursors_timeOut`    |    service timeout cursor count    | This metric counts the current number of service timeout cursors on the node.  Unit: Counts       | ≥ 0 Counts   |     Document database instance's primary node Document database instance's secondary node | 1 minute                    |
| `mongo021_wt_cahe_usage`    |    amount of data in memory (WiredTiger engine)    | This metric counts the current amount of data in memory (WiredTiger engine).  Unit: MB       | ≥ 0 MB   |     Document database instance's primary node Document database instance's secondary node | 1 minute                    |
| `mongo022_wt_cahe_dirty`    |    amount of dirty data in memory (WiredTiger engine)    | This metric counts the current amount of dirty data in memory (WiredTiger engine).  Unit: MB       | ≥ 0 MB   |     Document database instance's primary node Document database instance's secondary node | 1 minute                    |
| `mongo023_wInto_wtCache`    |    frequency of writes into WiredTiger memory    | This metric counts the current frequency of writes into memory (WiredTiger engine).  Unit: ≥ Bytes/s      | ≥ 0 Bytes/s   |     Document database instance's primary node Document database instance's secondary node | 1 minute                    |
| `mongo024_wFrom_wtCache`    |    frequency of writes from WiredTiger memory to disk    | This metric counts the current frequency of writes from memory to disk (WiredTiger engine).  Unit: Bytes/s       | ≥ 0 Bytes/s   |     Document database instance's primary node | 1 minute                    |
| `mongo025_repl_oplog_win`    |    available time in Oplog on primary node    | This metric counts the available time in Oplog on the current instance's primary node.  Unit: Hours       | ≥ 0 Hours   |    Document database instance's secondary node | 1 minute                    |
| `mongo025_repl_headroom`    |   overlap duration of Oplog between primary and secondary nodes    | This metric counts the overlap duration of Oplog between the instance's primary node and Secondary node.  Unit: Seconds       | ≥ 0 Seconds   |     Document database instance's secondary node | 1 minute                    |
| `mongo026_repl_lag`    |    replication delay between primary and secondary nodes    | This metric counts the replication delay between the instance's primary node and Secondary node.  Unit: Seconds      |≥ 0 Seconds   |     Document database instance's secondary node | 1 minute                    |
| `mongo027_repl_command_ps`    |    command execution frequency replicated by secondary node    | This metric counts the average number of times per second Secondary node replicates command statements.  Unit: Executions/s      | ≥ 0 Executions/s   |     Document database instance's secondary node | 1 minute                    |
| `mongo028_repl_update_ps`    |    update statement execution frequency replicated by secondary node    | This metric counts the average number of times per second Secondary node replicates update statements.  Unit: Executions/s       | ≥ 0 Executions/s   |   Document database instance's secondary node   | 1 minute                    |
| `mongo029_repl_delete_ps`    |    delete statement execution frequency replicated by secondary node    | This metric counts the average number of times per second Secondary node replicates delete statements.  Unit: Executions/s       | ≥ 0 Executions/s   |   Document database instance's secondary node   | 1 minute                    |
| `mongo030_repl_insert_ps`    |    insert statement execution frequency replicated by secondary node    | This metric counts the average number of times per second Secondary node replicates insert statements.  Unit: Executions/s       | ≥ 0 Executions/s   |   Document database instance's secondary node   | 1 minute                    |
| `mongo031_cpu_usage`         |    CPU usage    | This metric counts the CPU utilization of the measurement object.    Unit: %       | 0~100%   |   Document database cluster instance's dds mongos node Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo032_mem_usage`    |    memory usage    | This metric counts the memory utilization of the measurement object.        Unit: %       | 0~100%   |   Document database cluster instance's dds mongos node Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo033_bytes_out`    |    network output throughput    | This metric counts the average number of bytes per second output from all network adapters of the measurement object.  Unit: Bytes/s       | ≥ 0 Bytes/s   |   Document database cluster instance's dds mongos node Document database instance's primary node Document database instance's secondary node   | 1 minute                      |
| `mongo034_bytes_in`    |    network input throughput    | This metric counts the average number of bytes per second input to all network adapters of the measurement object.   Unit: Bytes/s       | ≥ 0 Bytes/s   |   Document database cluster instance's dds mongos node Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo035_disk_usage`    |    disk usage    | This metric counts the disk utilization of the measurement object.   Unit: %       | 0~100%   |   Document database cluster instance's dds mongos node Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo036_iops`    |    IOPS    | This metric counts the number of I/O requests processed per unit time for the current instance node (average value).  Unit: Counts       | ≥ 0 Counts/s   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo037_read_throughput`    |    hard drive read throughput    | Average number of bytes read per second from the hard drive.  Unit: Bytes/s       | ≥ 0 Bytes/s   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo038_write_throughput`    |   hard drive write throughput    | Average number of bytes written per second to the hard drive.   Unit: Bytes/s      | ≥ 0 Bytes/s   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo039_avg_disk_sec_per_read`    |    hard drive read latency    | This metric counts the average time taken per read operation during a period.   Unit: Seconds       | ≥ 0 Seconds   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo040_avg_disk_sec_per_write`    |    hard drive write latency    | This metric counts the average time taken per write operation during a period.   Unit: Seconds       | ≥ 0 Seconds   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo042_disk_total_size`    |    total disk size    | This metric counts the total size of the disk for the measurement object.   Unit: GB      | 0~1000 GB   |   Document database cluster instance's dds mongos node Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo043_disk_used_size`    |   used disk space    | This metric counts the total used size of the disk for the measurement object.   Unit: GB      | 0~1000 GB   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo044_swap_usage`    |    SWAP usage    | Percentage of SWAP memory usage.          Unit: %       | 0~100%   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo050_top_total_time`    |    total time spent on collections    | Mongotop-total time metric, sum of time spent on collection operations.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo051_top_read_time`    |    total time spent on reads    | Mongotop-read time metric, sum of time spent on read operations.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo052_top_write_time`    |    total time spent on writes    | Mongotop-write time metric, sum of time spent on write operations.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo053_wt_flushes_status`    |    number of periodic Checkpoints triggered    | Number of checkpoints triggered during a WiredTiger polling interval, recorded as occurrences within the period.   Unit: Counts       | ≥ 0 Counts   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo054_wt_cache_used_percent`    |    percentage of WiredTiger cache in use    | Percentage of WiredTiger cache currently in use.   Unit: %       | 0~100%   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo055_wt_cache_dirty_percent`    |    percentage of dirty data in WiredTiger cache    | Percentage of dirty data in WiredTiger cache.   Unit: %       | 0~100%   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo070_rocks_active_memtable`    |    size of data in memtable    | Collects the size of data in the current active memtable.   Unit: GB       | 0~100 GB   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo071_rocks_oplogcf_active_memtable`    |    size of data in oplogcf memtable    | Collects the size of data in the current active memtable used for oplogcf.   Unit: GB       | 0~100GB   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo072_rocks_all_memtable`    |    total size of data in memtable and immutable-mem    | Collects the total size of data in the current memtable and immutable-mem.   Unit: GB       | 0~100GB   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo073_rocks_oplogcf_all_memtable`    |    total size of data in oplogcf memtable and immutable-mem    | Collects the total size of data in the current memtable and immutable-mem used for oplogcf.   Unit: GB       | 0~100GB   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo074_rocks_snapshots`    |    number of unreleased snapshots    | Collects the number of unreleased snapshots.   Unit: Counts       | ≥ 0 Counts   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo075_rocks_oplogcf_snapshots`    |    number of unreleased snapshots on oplogcf    | Collects the number of unreleased snapshots on oplogcf.   Unit: Counts       | ≥ 0 Counts   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo076_rocks_live_versions`    |    number of active versions    | Collects the number of active versions.   Unit: Counts       | ≥ 0 Counts   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo077_rocks_oplogcf_live_versions`    |    number of active versions on oplogcf    | Collects the number of active versions on oplogcf.   Unit: Counts       | ≥ 0 Counts   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo078_rocks_block_cache`    |    size of data residing in blockcache    | Collects the size of data residing in blockcache.   Unit: Counts       | ≥ 0 Counts   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo079_rocks_background_errors`    |    cumulative background error count    | Collects the cumulative background error count.   Unit: Counts       | ≥ 0 Counts   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo080_rocks_oplogcf_background_errors`    |    cumulative background error count on oplogcf    | Collects the cumulative background error count on oplogcf.   Unit: Counts       | ≥ 0 Counts   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo081_rocks_conflict_bytes_usage`    |    buffer usage rate for handling write-write conflicts in transactions    | Collects the buffer usage rate for handling write-write conflicts in transactions.   Unit: %       | 0~100%   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo082_rocks_uncommitted_keys`    |    number of uncommitted keys    | Collects the number of uncommitted keys.   Unit: Counts       | ≥ 0 Counts   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo083_rocks_committed_keys`    |    number of committed keys    | Collects the number of committed keys.   Unit: Counts       | ≥ 0 Counts   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo084_rocks_alive_txn`    |    length of active transaction chain    | Collects the length of the active transaction chain.   Unit: Counts       | ≥ 0 Counts   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo085_rocks_read_queue`    |    length of read queue    | Collects the length of the current read queue.   Unit: Counts       | ≥ 0 Counts   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo086_rocks_commit_queue`    |    length of commit queue    | Collects the length of the current commit queue.   Unit: Counts       | ≥ 0 Counts   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo087_rocks_ct_write_out`    |    number of concurrent write transactions used    | Collects the number of concurrent write transactions used.   Unit: Counts       | ≥ 0 Counts   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo088_rocks_ct_write_available`    |    number of remaining available concurrent write transactions    | Collects the number of remaining available concurrent write transactions.   Unit: Counts       | ≥ 0 Counts   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo089_rocks_ct_read_out`    |    number of concurrent reads used    | Collects the number of concurrent read transactions used.   Unit: Counts       | ≥ 0 Counts   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo090_rocks_ct_read_available`    |    number of remaining available concurrent read transactions     | Collects the number of remaining available concurrent read transactions.   Unit: Counts       | ≥ 0 Counts   |   Document database instance's primary node Document database instance's secondary node   | 1 minute                    |
| `mongo091_active_session_count`    |    number of active sessions in the period    | This metric counts the number of all active local sessions cached in memory by the Mongo instance since the last refresh cycle.   Unit: Counts       | ≥ 0 Counts   |  Document database instance Read-only node of Document database replica set instance Primary node of Document database instance Secondary node of Document database instance Hidden node of Document database instance    | 1 minute                    |
| `mongo092_rx_errors`    |    receive packet error rate    | This metric counts the ratio of error packets received to all received packets during the monitoring period.   Unit: %      | 0～100%   |   Document database instance   | 1 minute 5 seconds                   |
| `mongo093_rx_dropped`    |    receive packet drop rate    | This metric counts the ratio of dropped packets received to all received packets during the monitoring period.   Unit: %       | 0～100%   |   Document database instance   | 1 minute 5 seconds                   |
| `mongo094_tx_errors`    |    send packet error rate    | This metric counts the ratio of error packets sent to all sent packets during the monitoring period.   Unit: %       | 0～100%   |   Document database instance   | 1 minute 5 seconds                   |
| `mongo095_tx_dropped`    |    send packet drop rate    | This metric counts the ratio of dropped packets sent to all sent packets during the monitoring period.   Unit: %       | 0～100%   |   Document database instance   | 1 minute 5 seconds                   |
| `mongo096_retrans_segs`    |    retransmitted packet count    | This metric counts the number of retransmitted packets during the monitoring period.   Unit: Counts       | ≥ 0 Counts   |   Document database instance   | 1 minute 5 seconds                   |
| `mongo097_retrans_rate`    |    retransmission ratio    | This metric counts the retransmission ratio during the monitoring period.   Unit: %       | 0～100%   |   Document database instance   | 1 minute 5 seconds                   |
| `mongo098_out_rsts_nums`    |    RST packet count sent    | This metric counts the number of RST packets sent during the monitoring period.   Unit: Counts       | ≥ 0 Counts   |   Document database instance   | 1 minute 5 seconds                   |
| `mongo099_read_time_average`    |    average read command latency    | This metric is the average read command latency for a single node.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document database instance Read-only node of Document database replica set instance Primary node of Document database instance Secondary node of Document database instance Hidden node of Document database instance   | 1 minute                   |
| `mongo100_read_time_p99`    |    p99 read command latency    | This metric is the p99 read command latency for a single node.   Unit: Milliseconds      | ≥ 0 Milliseconds   |   Document database instance Read-only node of Document database replica set instance Primary node of Document database instance Secondary node of Document database instance Hidden node of Document database instance   | 1 minute                   |
| `mongo101_read_time_p999`    |    p999 read command latency    | This metric is the p999 read command latency for a single node.   Unit: Milliseconds      | ≥ 0 Milliseconds  |   Document database instance Read-only node of Document database replica set instance Primary node of Document database instance Secondary node of Document database instance Hidden node of Document database instance   | 1 minute                   |
| `mongo102_write_time_average`    |    average write command latency    | This metric is the average write command latency for a single node.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document database instance Read-only node of Document database replica set instance Primary node of Document database instance Secondary node of Document database instance Hidden node of Document database instance   | 1 minute                   |
| `mongo103_write_time_p99`    |    p99 write command latency    | This metric is the p99 write command latency for a single node.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document database instance Read-only node of Document database replica set instance Primary node of Document database instance Secondary node of Document database instance Hidden node of Document database instance   | 1 minute                   |
| `mongo104_write_time_p999`    |    p999 write command latency    | This metric is the p999 write command latency for a single node.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document database instance Read-only node of Document database replica set instance Primary node of Document database instance Secondary node of Document database instance Hidden node of Document database instance   | 1 minute                   |
| `mongo105_command_time_average`    |    average command latency    | This metric is the average command latency for a single node.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document database instance Read-only node of Document database replica set instance Primary node of Document database instance Secondary node of Document database instance Hidden node of Document database instance   | 1 minute                   |
| `mongo106_command_time_p99`    |    p99 command latency    | This metric is the p99 command latency for a single node.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document database instance Read-only node of Document database replica set instance Primary node of Document database instance Secondary node of Document database instance Hidden node of Document database instance   | 1 minute                   |
| `mongo107_command_time_p999`    |    p999 command latency    | This metric is the p999 command latency for a single node.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document database instance Read-only node of Document database replica set instance Primary node of Document database instance Secondary node of Document database instance Hidden node of Document database instance   | 1 minute                   |
| `mongo108_txn_time_average`    |    average transaction latency    | This metric is the average transaction latency for a single node.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document database instance Read-only node of Document database replica set instance Primary node of Document database instance Secondary node of Document database instance Hidden node of Document database instance   | 1 minute                   |
| `mongo109_txn_time_p99`    |    p99 transaction latency    | This metric is the p99 transaction latency for a single node.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document database instance Read-only node of Document database replica set instance Primary node of Document database instance Secondary node of Document database instance Hidden node of Document database instance   | 1 minute                   |
| `mongo110_txn_time_p999`    |    p999 transaction latency    | This metric is the p999 transaction latency for a single node.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document database instance Read-only node of Document database replica set instance Primary node of Document database instance Secondary node of Document database instance Hidden node of Document database instance   | 1 minute                   |

## Objects {#object}

After data synchronization is normal, you can view the data in the "Infrastructure - Resource Catalog" of Guance.

```json
{
  "measurement": "huaweicloud_dds",
  "tags": {
    "RegionId"              : "cn-south-1",
    "project_id"            : "756ada1aa17e4049b2a16ea41```json
"enterprise_project_id" : "",
    "instance_id"           : "16b35ebaba1c44c39d9c24bae742ca97in02",
    "instance_name"         : "dds-3ed3",
    "status"                : "normal"
  },
  "fields": {
    "engine"            : "wiredTiger",
    "db_user_name"      : "rwuser",
    "mode"              : "",
    "pay_mode"          : "0",
    "port"              : "8635",
    "security_group_id" : "7aa51dbf-xxxx-xxxx-xxxx-dad3c4828b58",
    "ssl"               : "1",
    "vpc_id"            : "674e9b42-xxxx-xxxx-xxxx-5abcc565b961",
    "backup_strategy"   : "{Instance JSON Data}",
    "datastore"         : "{Instance JSON Data}",
    "groups"            : "[{Instance JSON Data}]",
    "create_time"       : "2024-10-29T03:28:46",
    "update_time"       : "2024-11-04T13:21:35"
  }
}
```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.instance_id` is the instance ID, used as a unique identifier.
>
> Tip 2:
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`