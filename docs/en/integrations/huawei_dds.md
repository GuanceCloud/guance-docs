---
title: 'Huawei Cloud DDS'
tags: 
  - Huawei Cloud
summary: 'Collect Huawei Cloud DDS Metrics data'
__int_icon: 'icon/huawei_dds'
dashboard:
  - desc: 'Huawei Cloud DDS built-in view'
    path: 'dashboard/en/huawei_dds/'

monitor:
  - desc: 'Huawei Cloud DDS monitor'
    path: 'monitor/en/huawei_dds/'
---

Collect Huawei Cloud DDS Metrics data

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/)

> Recommendation: Deploy the GSE version

### Install Script

> Note: Prepare a qualified Huawei Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize Huawei Cloud DDS monitoring data, we install the corresponding collection scripts:

- **guance_huaweicloud_dds**: Collects DDS monitoring Metrics data
- **guance_huaweicloud_dds_slowlog**: Collects DDS slow log data

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

After the script is installed, find the script 「Guance Integration (Huawei Cloud-DDS Collection)」/「Guance Integration (Huawei Cloud-DDS Slow Query Log Collection)」in the Func 「Development」section, expand and modify the script, edit the contents of `collector_configs` and `monitor_configs`, change the region and Project ID to the actual region and Project ID, then click Save and Publish.

Additionally, in 「Management / Automatic Trigger Configuration」, you can see the corresponding automatic trigger configuration. Click 【Execute】to immediately execute once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

### Verification

1. In 「Management / Automatic Trigger Configuration」confirm that the corresponding automatic trigger configuration exists for the task, and check the task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」, check if there is asset information.
3. On the Guance platform, under 「Metrics」check if there is corresponding monitoring data.
4. On the Guance platform, under 「Logs」check if there is corresponding slow log data.

## Metrics {#metric}

Configure Huawei Cloud DDS Metrics. You can collect more Metrics through configuration [Huawei Cloud DDS Metrics details](https://support.huaweicloud.com/usermanual-dds/dds_03_0026.html){:target="_blank"}

| **Metric ID**            |          **Metric Name**   | **Metric Meaning** | **Value Range**      | **Measurement Object** | **Monitoring Period (Raw Metric)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `mongo001_command_ps`            |   Command Execution Frequency    | This metric counts the average number of command statements executed per second on the node. Unit: Executions/s   | ≥ 0 Executions/s  | Document Database Instance Document Database Cluster Instance's dds mongos node Document Database Instance's primary node Document Database Instance's secondary node | 1 minute 5 seconds                   |
| `mongo002_delete_ps`            |   Delete Statement Execution Frequency   | This metric counts the average number of delete statements executed per second on the node. Unit: Executions/s            | ≥ 0 Executions/s         | Document Database Instance Document Database Cluster Instance's dds mongos node Document Database Instance's primary node Document Database Instance's secondary node | 1 minute 5 seconds              |
| `mongo003_insert_ps`            |    Insert Statement Execution Frequency  | This metric counts the average number of insert statements executed per second on the node. Unit: Executions/s | ≥ 0 Executions/s    | Document Database Instance Document Database Cluster Instance's dds mongos node Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute 5 seconds              |
| `mongo004_query_ps`             |    Query Statement Execution Frequency    | This metric counts the average number of query statements executed per second on the node. Unit: Executions/s | ≥ 0 Executions/s  | Document Database Instance Document Database Cluster Instance's dds mongos node Document Database Instance's primary node Document Database Instance's secondary node | 1 minute 5 seconds                 |
| `mongo006_getmore_ps`           |      Update Statement Execution Frequency      | This metric counts the average number of update statements executed per second on the node. Unit: Executions/s   | 0 Executions/s      | Document Database Instance Document Database Cluster Instance's dds mongos node Document Database Instance's primary node Document Database Instance's secondary node       | 1 minute 5 seconds                    |
| `mongo007_chunk_num1`           |     Number of Chunks in Shard 1    | This metric counts the number of chunks in shard 1. Unit: Counts                           | 0~64 Counts       | Document Database Cluster Instance   | 1 minute 5 seconds                    |
| `mongo007_chunk_num2`       |      Number of Chunks in Shard 2      | This metric counts the number of chunks in shard 2. Unit: Counts           | 0~64 Counts       | Document Database Cluster Instance       | 1 minute 5 seconds                    |
| `mongo007_chunk_num3`         |   Number of Chunks in Shard 3    | This metric counts the number of chunks in shard 3. Unit: Counts           | 0~64 Counts | Document Database Cluster Instance | 1 minute 5 seconds                    |
| `mongo007_chunk_num4`          |  Number of Chunks in Shard 4  | This metric counts the number of chunks in shard 4. Unit: Counts           | 0~64 Counts | Document Database Cluster Instance | 1 minute 5 seconds                    |
| `mongo007_chunk_num5`          |  Number of Chunks in Shard 5  | This metric counts the number of chunks in shard 5. Unit: Counts          | 0~64 Counts | Document Database Cluster Instance | 1 minute 5 seconds                    |
| `mongo007_chunk_num6`           |  Number of Chunks in Shard 6   | This metric counts the number of chunks in shard 6. Unit: Counts          | 0~64 Counts   | Document Database Cluster Instance | 1 minute 5 seconds                    |
| `mongo007_chunk_num7`          |  Number of Chunks in Shard 7  | This metric counts the number of chunks in shard 7. Unit: Counts          | 0~64 Counts | Document Database Cluster Instance | 1 minute 5 seconds                    |
| `mongo007_chunk_num8`         | Number of Chunks in Shard 8  | This metric counts the number of chunks in shard 8. Unit: Counts          | 0~64 Counts | Document Database Cluster Instance | 1 minute 5 seconds                    |
| `mongo007_chunk_num9`        |    Number of Chunks in Shard 9    | This metric counts the number of chunks in shard 9. Unit: Counts         | 0~64 Counts   | Document Database Cluster Instance | 1 minute 5 seconds                    |
| `mongo007_chunk_num10`     | Number of Chunks in Shard 10 | This metric counts the number of chunks in shard 10. Unit: Counts            | 0~64 Counts      | Document Database Cluster Instance | 1 minute 5 seconds                    |
| `mongo007_chunk_num11`       |       Number of Chunks in Shard 11       | This metric counts the number of chunks in shard 11. Unit: Counts           | 0~64 Counts       | Document Database Cluster Instance | 1 minute 5 seconds                    |
| `mongo007_chunk_num12`        |       Number of Chunks in Shard 12       | This metric counts the number of chunks in shard 12. Unit: Counts            | 0~64 Counts       | Document Database Cluster Instance | 1 minute 5 seconds                    |
| `mongo008_connections` |     Current Active Connections     | This metric counts the total number of connections attempting to connect to the DDS instance. Unit: Counts                   | 0~200 Counts | Document Database Instance      | 1 minute 5 seconds                    |
| `mongo009_migFail_num` |       Block Migration Failures in the Past Day       | This metric counts the number of block migration failures in the past day. Unit: Counts/s                       | ≥ 0 Counts/s | Document Database Cluster Instance | 1 minute 5 seconds                    |
| `mongo007_connections`     |     Current Active Connections     | This metric counts the total number of connections attempting to connect to the DDS instance node. Unit: Counts                   | 0~200 Counts | Document Database Instance Document Database Cluster Instance's dds mongos node Document Database Instance's primary node Document Database Instance's secondary node | 1 minute 5 seconds                    |
| `mongo007_connections_usage`    |     Percentage of Current Active Connections     | This metric counts the percentage of connections attempting to connect to the instance node out of available connections. Unit: %                   | 0~100% | Document Database Cluster Instance's dds mongos node Document Database Instance's primary node Document Database Instance's secondary node | 1 minute 5 seconds                    |
| `mongo008_mem_resident`       |    Resident Memory    | This metric counts the current size of resident memory. Unit: MB               | ≥ 0 MB   | Document Database Cluster Instance's dds mongos node Document Database Instance's primary node Document Database Instance's secondary node | 1 minute                    |
| `mongo009_mem_virtual`     |   Virtual Memory   | This metric counts the current size of virtual memory. Unit: MB                   | ≥ 0 MB   | Document Database Cluster Instance's dds mongos node Document Database Instance's primary node Document Database Instance's secondary node | 1 minute                    |
| `mongo010_regular_asserts_ps`     |   Regular Assertion Frequency   | This metric counts the frequency of regular assertions. Unit: Executions/s             | ≥ 0 Executions/s   | Document Database Cluster Instance's dds mongos node Document Database Instance's primary node Document Database Instance's secondary node | 1 minute                    |
| `mongo011_warning_asserts_ps`        |      Warning Frequency      | This metric counts the frequency of warnings. Unit: Executions/s           | ≥ 0 Executions/s   | Document Database Cluster Instance's dds mongos node Document Database Instance's primary node Document Database Instance's secondary node | 1 minute                    |
| `mongo012_msg_asserts_ps`       |       Message Assertion Frequency       | This metric counts the frequency of message assertions. Unit: Executions/s             | ≥ 0 Executions/s   | Document Database Cluster Instance's dds mongos node Document Database Instance's primary node Document Database Instance's secondary node | 1 minute                    |
| `mongo013_user_asserts_ps`       |    User Assertion Frequency    | This metric counts the frequency of user assertions. Unit: Executions/s           | ≥ 0 Executions/s   | Document Database Cluster Instance's dds mongos node Document Database Instance's primary node Document Database Instance's secondary node | 1 minute                    |
| `mongo014_queues_total`    |    Operations Waiting for Locks    | This metric counts the current number of operations waiting for locks.  Unit: Counts       | ≥ 0 Counts   |     Document Database Instance's primary node Document Database Instance's secondary node | 1 minute                    |
| `mongo015_queues_readers`    |    Operations Waiting for Read Locks    | This metric counts the current number of operations waiting for read locks.  Unit: Counts       | ≥ 0 Counts   |     Document Database Instance's primary node Document Database Instance's secondary node | 1 minute                    |
| `mongo016_queues_writers`    |    Operations Waiting for Write Locks    | This metric counts the current number of operations waiting for write locks.  Unit: Counts       | ≥ 0 Counts   |     Document Database Instance's primary node Document Database Instance's secondary node | 1 minute                    |
| `mongo017_page_faults`    |    Page Fault Count    | This metric counts the number of page faults on the current node.  Unit: Counts       | ≥ 0 Counts   |     Document Database Instance's primary node Document Database Instance's secondary node | 1 minute                    |
| `mongo018_porfling_num`    |    Slow Query Count    | This metric counts the total number of slow queries from the last 5 minutes to the current time point on the current node.  Unit: Counts       | ≥ 0 Counts   |     Document Database Instance's primary node Document Database Instance's secondary node | 1 minute                    |
| `mongo019_cursors_open`    |    Current Open Cursors    | This metric counts the number of open cursors on the current node. Unit: Counts       | ≥ 0 Counts   |     Document Database Instance's primary node Document Database Instance's secondary node | 1 minute                    |
| `mongo020_cursors_timeOut`    |    Timed-out Cursors    | This metric counts the number of timed-out cursors on the current node.  Unit: Counts       | ≥ 0 Counts   |     Document Database Instance's primary node Document Database Instance's secondary node | 1 minute                    |
| `mongo021_wt_cahe_usage`    |    Amount of Data in Memory (WiredTiger Engine)    | This metric counts the amount of data in memory (WiredTiger engine).  Unit: MB       | ≥ 0 MB   |     Document Database Instance's primary node Document Database Instance's secondary node | 1 minute                    |
| `mongo022_wt_cahe_dirty`    |    Amount of Dirty Data in Memory (WiredTiger Engine)    | This metric counts the amount of dirty data in memory (WiredTiger engine).  Unit: MB       | ≥ 0 MB   |     Document Database Instance's primary node Document Database Instance's secondary node | 1 minute                    |
| `mongo023_wInto_wtCache`    |    Frequency of Writing into WiredTiger Memory    | This metric counts the frequency of writing into memory (WiredTiger engine).  Unit: ≥ Bytes/s      | ≥ 0 Bytes/s   |     Document Database Instance's primary node Document Database Instance's secondary node | 1 minute                    |
| `mongo024_wFrom_wtCache`    |    Frequency of Writing from WiredTiger Memory to Disk    | This metric counts the frequency of writing from memory to disk (WiredTiger engine).  Unit: Bytes/s       | ≥ 0 Bytes/s   |     Document Database Instance's primary node | 1 minute                    |
| `mongo025_repl_oplog_win`    |    Available Time in Oplog on Primary Node    | This metric counts the available time in the Oplog on the current instance's primary node.  Unit: Hours       | ≥ 0 Hours   |    Document Database Instance's secondary node | 1 minute                    |
| `mongo025_repl_headroom`    |   Overlap Duration of Oplog Between Primary and Secondary Nodes    | This metric counts the overlap duration of the Oplog between the primary node and the Secondary node.  Unit: Seconds       | ≥ 0 Seconds   |     Document Database Instance's secondary node | 1 minute                    |
| `mongo026_repl_lag`    |    Replication Lag Between Primary and Secondary Nodes    | This metric counts the replication lag between the primary node and the Secondary node.  Unit: Seconds      |≥ 0 Seconds   |     Document Database Instance's secondary node | 1 minute                    |
| `mongo027_repl_command_ps`    |    Command Execution Frequency on Secondary Node    | This metric counts the average number of command statements replicated per second on the Secondary node.  Unit: Executions/s      | ≥ 0 Executions/s   |     Document Database Instance's secondary node | 1 minute                    |
| `mongo028_repl_update_ps`    |    Update Statement Execution Frequency on Secondary Node    | This metric counts the average number of update statements replicated per second on the Secondary node.  Unit: Executions/s       | ≥ 0 Executions/s   |   Document Database Instance's secondary node   | 1 minute                    |
| `mongo029_repl_delete_ps`    |    Delete Statement Execution Frequency on Secondary Node    | This metric counts the average number of delete statements replicated per second on the Secondary node.  Unit: Executions/s       | ≥ 0 Executions/s   |   Document Database Instance's secondary node   | 1 minute                    |
| `mongo030_repl_insert_ps`    |    Insert Statement Execution Frequency on Secondary Node    | This metric counts the average number of insert statements replicated per second on the Secondary node.  Unit: Executions/s       | ≥ 0 Executions/s   |   Document Database Instance's secondary node   | 1 minute                    |
| `mongo031_cpu_usage`         |    CPU Usage    | This metric counts the CPU utilization of the measurement object.    Unit: %       | 0~100%   |   Document Database Cluster Instance's dds mongos node Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo032_mem_usage`    |    Memory Usage    | This metric counts the memory utilization of the measurement object.        Unit: %       | 0~100%   |   Document Database Cluster Instance's dds mongos node Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo033_bytes_out`    |    Network Output Throughput    | This metric counts the average number of bytes output per second from all network adapters of the measurement object.  Unit: Bytes/s       | ≥ 0 Bytes/s   |   Document Database Cluster Instance's dds mongos node Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                      |
| `mongo034_bytes_in`    |    Network Input Throughput    | This metric counts the average number of bytes input per second from all network adapters of the measurement object.   Unit: Bytes/s       | ≥ 0 Bytes/s   |   Document Database Cluster Instance's dds mongos node Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo035_disk_usage`    |    Disk Usage    | This metric counts the disk utilization of the measurement object.   Unit: %       | 0~100%   |   Document Database Cluster Instance's dds mongos node Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo036_iops`    |    IOPS    | This metric counts the average number of I/O requests processed by the system per unit time (average value).  Unit: Counts/s       | ≥ 0 Counts/s   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo037_read_throughput`    |    Disk Read Throughput    | Average number of bytes read per second from the disk.  Unit: Bytes/s       | ≥ 0 Bytes/s   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo038_write_throughput`    |   Disk Write Throughput    | Average number of bytes written per second to the disk.   Unit: Bytes/s      | ≥ 0 Bytes/s   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo039_avg_disk_sec_per_read`    |    Disk Read Latency    | This metric counts the average time taken for each disk read over a certain period.   Unit: Seconds       | ≥ 0 Seconds   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo040_avg_disk_sec_per_write`    |    Disk Write Latency    | This metric counts the average time taken for each disk write over a certain period.   Unit: Seconds       | ≥ 0 Seconds   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo042_disk_total_size`    |    Total Disk Size    | This metric counts the total size of the disk.   Unit: GB      | 0~1000 GB   |   Document Database Cluster Instance's dds mongos node Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo043_disk_used_size`    |   Used Disk Space    | This metric counts the total used space on the disk.   Unit: GB      | 0~1000 GB   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo044_swap_usage`    |    SWAP Usage    | Swap memory SWAP usage rate as a percentage.          Unit: %       | 0~100%   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo050_top_total_time`    |    Total Time Spent on Collection Operations    | Mongotop-total time metric, sum of time spent on collection operations.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo051_top_read_time`    |    Total Time Spent on Read Operations    | Mongotop-read time metric, sum of time spent on read operations.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo052_top_write_time`    |    Total Time Spent on Write Operations    | Mongotop-write time metric, sum of time spent on write operations.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo053_wt_flushes_status`    |    Number of Checkpoint Triggers in Period    | Number of checkpoint triggers during a WiredTiger polling interval, recorded in units of occurrences within the period.   Unit: Counts       | ≥ 0 Counts   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo054_wt_cache_used_percent`    |    Percentage of WiredTiger Cache Usage    | Percentage of WiredTiger cache usage.   Unit: %       | 0~100%   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo055_wt_cache_dirty_percent`    |    Percentage of Dirty Data in WiredTiger Cache    | Percentage of dirty data in WiredTiger cache.   Unit: %       | 0~100%   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo070_rocks_active_memtable`    |    Data Size in Active Memtable    | Data size in the current active memtable.   Unit: GB       | 0~100 GB   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo071_rocks_oplogcf_active_memtable`    |    Data Size in Active Memtable on Oplogcf    | Data size in the current active memtable on oplogcf.   Unit: GB       | 0~100GB   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo072_rocks_all_memtable`    |    Total Data Size in Memtable and Immutable-Mem    | Total data size in the current memtable and immutable-mem.   Unit: GB       | 0~100GB   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo073_rocks_oplogcf_all_memtable`    |    Total Data Size in Memtable and Immutable-Mem on Oplogcf    | Total data size in the current memtable and immutable-mem on oplogcf.   Unit: GB       | 0~100GB   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo074_rocks_snapshots`    |    Number of Unreleased Snapshots    | Number of unreleased snapshots.   Unit: Counts       | ≥ 0 Counts   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo075_rocks_oplogcf_snapshots`    |    Number of Unreleased Snapshots on Oplogcf    | Number of unreleased snapshots on oplogcf.   Unit: Counts       | ≥ 0 Counts   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo076_rocks_live_versions`    |    Number of Active Versions    | Number of active versions.   Unit: Counts       | ≥ 0 Counts   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo077_rocks_oplogcf_live_versions`    |    Number of Active Versions on Oplogcf    | Number of active versions on oplogcf.   Unit: Counts       | ≥ 0 Counts   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo078_rocks_block_cache`    |    Data Size in Blockcache    | Data size in blockcache.   Unit: Counts       | ≥ 0 Counts   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo079_rocks_background_errors`    |    Cumulative Background Errors    | Cumulative background errors.   Unit: Counts       | ≥ 0 Counts   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo080_rocks_oplogcf_background_errors`    |    Cumulative Background Errors on Oplogcf    | Cumulative background errors on oplogcf.   Unit: Counts       | ≥ 0 Counts   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo081_rocks_conflict_bytes_usage`    |    Buffer Usage Rate for Write Conflicts    | Buffer usage rate for handling write conflicts in transactions.   Unit: %       | 0~100%   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo082_rocks_uncommitted_keys`    |    Number of Uncommitted Keys    | Number of uncommitted keys.   Unit: Counts       | ≥ 0 Counts   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo083_rocks_committed_keys`    |    Number of Committed Keys    | Number of committed keys.   Unit: Counts       | ≥ 0 Counts   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo084_rocks_alive_txn`    |    Length of Active Transaction Chain    | Length of active transaction chain.   Unit: Counts       | ≥ 0 Counts   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo085_rocks_read_queue`    |    Length of Read Queue    | Length of read queue.   Unit: Counts       | ≥ 0 Counts   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo086_rocks_commit_queue`    |    Length of Commit Queue    | Length of commit queue.   Unit: Counts       | ≥ 0 Counts   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo087_rocks_ct_write_out`    |    Number of Concurrent Write Transactions Used    | Number of concurrent write transactions currently in use.   Unit: Counts       | ≥ 0 Counts   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo088_rocks_ct_write_available`    |    Remaining Available Concurrent Write Transactions    | Number of remaining available concurrent write transactions.   Unit: Counts       | ≥ 0 Counts   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo089_rocks_ct_read_out`    |    Number of Concurrent Reads Used    | Number of concurrent reads currently in use.   Unit: Counts       | ≥ 0 Counts   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo090_rocks_ct_read_available`    |    Remaining Available Concurrent Reads    | Number of remaining available concurrent reads.   Unit: Counts       | ≥ 0 Counts   |   Document Database Instance's primary node Document Database Instance's secondary node   | 1 minute                    |
| `mongo091_active_session_count`    |    Number of Active Sessions in Period    | This metric counts the number of all active local sessions cached in memory since the last refresh cycle.   Unit: Counts       | ≥ 0 Counts   |  Document Database Instance Document Database Replica Set Instance's read-only node Document Database Instance's primary node Document Database Instance's secondary node Document Database Instance's hidden node    | 1 minute                    |
| `mongo092_rx_errors`    |    Received Packet Error Rate    | This metric counts the ratio of error packets received to the total number of received packets during the monitoring period.   Unit: %      | 0～100%   |   Document Database Instance   | 1 minute 5 seconds                   |
| `mongo093_rx_dropped`    |    Received Packet Drop Rate    | This metric counts the ratio of dropped packets received to the total number of received packets during the monitoring period.   Unit: %       | 0～100%   |   Document Database Instance   | 1 minute 5 seconds                   |
| `mongo094_tx_errors`    |    Sent Packet Error Rate    | This metric counts the ratio of error packets sent to the total number of sent packets during the monitoring period.   Unit: %       | 0～100%   |   Document Database Instance   | 1 minute 5 seconds                   |
| `mongo095_tx_dropped`    |    Sent Packet Drop Rate    | This metric counts the ratio of dropped packets sent to the total number of sent packets during the monitoring period.   Unit: %       | 0～100%   |   Document Database Instance   | 1 minute 5 seconds                   |
| `mongo096_retrans_segs`    |    Retransmission Count    | This metric counts the number of retransmissions during the monitoring period.   Unit: Counts       | ≥ 0 Counts   |   Document Database Instance   | 1 minute 5 seconds                   |
| `mongo097_retrans_rate`    |    Retransmission Ratio    | This metric counts the ratio of retransmissions during the monitoring period.   Unit: %       | 0～100%   |   Document Database Instance   | 1 minute 5 seconds                   |
| `mongo098_out_rsts_nums`    |    Sent RST Count    | This metric counts the number of RSTs sent during the monitoring period.   Unit: Counts       | ≥ 0 Counts   |   Document Database Instance   | 1 minute 5 seconds                   |
| `mongo099_read_time_average`    |    Average Read Command Latency    | This metric is the average latency of read commands on a single node.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document Database Instance Document Database Replica Set Instance's read-only node Document Database Instance's primary node Document Database Instance's secondary node Document Database Instance's hidden node   | 1 minute                   |
| `mongo100_read_time_p99`    |    p99 Read Command Latency    | This metric is the p99 latency of read commands on a single node.   Unit: Milliseconds      | ≥ 0 Milliseconds   |   Document Database Instance Document Database Replica Set Instance's read-only node Document Database Instance's primary node Document Database Instance's secondary node Document Database Instance's hidden node   | 1 minute                   |
| `mongo101_read_time_p999`    |    p999 Read Command Latency    | This metric is the p999 latency of read commands on a single node.   Unit: Milliseconds      | ≥ 0 Milliseconds  |   Document Database Instance Document Database Replica Set Instance's read-only node Document Database Instance's primary node Document Database Instance's secondary node Document Database Instance's hidden node   | 1 minute                   |
| `mongo102_write_time_average`    |    Average Write Command Latency    | This metric is the average latency of write commands on a single node.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document Database Instance Document Database Replica Set Instance's read-only node Document Database Instance's primary node Document Database Instance's secondary node Document Database Instance's hidden node   | 1 minute                   |
| `mongo103_write_time_p99`    |    p99 Write Command Latency    | This metric is the p99 latency of write commands on a single node.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document Database Instance Document Database Replica Set Instance's read-only node Document Database Instance's primary node Document Database Instance's secondary node Document Database Instance's hidden node   | 1 minute                   |
| `mongo104_write_time_p999`    |    p999 Write Command Latency    | This metric is the p999 latency of write commands on a single node.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document Database Instance Document Database Replica Set Instance's read-only node Document Database Instance's primary node Document Database Instance's secondary node Document Database Instance's hidden node   | 1 minute                   |
| `mongo105_command_time_average`    |    Average Command Latency    | This metric is the average latency of commands on a single node.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document Database Instance Document Database Replica Set Instance's read-only node Document Database Instance's primary node Document Database Instance's secondary node Document Database Instance's hidden node   | 1 minute                   |
| `mongo106_command_time_p99`    |    p99 Command Latency    | This metric is the p99 latency of commands on a single node.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document Database Instance Document Database Replica Set Instance's read-only node Document Database Instance's primary node Document Database Instance's secondary node Document Database Instance's hidden node   | 1 minute                   |
| `mongo107_command_time_p999`    |    p999 Command Latency    | This metric is the p999 latency of commands on a single node.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document Database Instance Document Database Replica Set Instance's read-only node Document Database Instance's primary node Document Database Instance's secondary node Document Database Instance's hidden node   | 1 minute                   |
| `mongo108_txn_time_average`    |    Average Transaction Latency    | This metric is the average latency of transactions on a single node.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document Database Instance Document Database Replica Set Instance's read-only node Document Database Instance's primary node Document Database Instance's secondary node Document Database Instance's hidden node   | 1 minute                   |
| `mongo109_txn_time_p99`    |    p99 Transaction Latency    | This metric is the p99 latency of transactions on a single node.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document Database Instance Document Database Replica Set Instance's read-only node Document Database Instance's primary node Document Database Instance's secondary node Document Database Instance's hidden node   | 1 minute                   |
| `mongo110_txn_time_p999`    |    p999 Transaction Latency    | This metric is the p999 latency of transactions on a single node.   Unit: Milliseconds       | ≥ 0 Milliseconds   |   Document Database Instance Document Database Replica Set Instance's read-only node Document Database Instance's primary node Document Database Instance's secondary node Document Database Instance's hidden node   | 1 minute                   |

## Objects {#object}

After data synchronization is successful, you can view the data in the Guance platform under 「Infrastructure / Custom (Objects)」

```json
{
  "measurement": "huaweicloud_dds",
  "tags": {
    "RegionId"          : "cn-south-1",
    "db_user_name"      : "rwuser",
    "engine"            : "wiredTiger",
    "instance_id"       : "16b35ebaba1c44c39d9c24bae742ca97in02",
    "instance_name"     : "dds-3ed3",
    "name"              : "16b35ebaba1c44c39d9c24bae742ca97in02",
    "pay_mode"          : "0",
    "port"              : "8635",
    "project_id"        : "756ada1aa17e4049b2a16ea41912e52d",
    "security_group_id" : "7aa51dbf-xxxx-xxxx-xxxx-dad3c4828b58",
    "status"            : "normal",
    "subnet_id"         : "f1df08c5-xxxx-xxxx-xxxx-de435a51007b",
    "vpc_id"            : "674e9b42-xxxx-xxxx-xxxx-5abcc565b961"
  },
  "fields": {
    "actions"         : "[]",
    "create_time"     : "2024-10-29T03:28:46",
    "update_time"     : "2024-11-04T13:21:35",
    "backup_strategy" : "{Instance JSON Data}",
    "datastore"       : "{Instance JSON Data}",
    "groups"          : "[{Instance JSON Data}]",
    "time_zone"       : "",
    "message"         : "{Instance JSON Data}"
  }
}
```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Tip 2:
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`
```

After data synchronization is successful, you can view the data in the Guance platform under 「Infrastructure / Custom (Objects)」.

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Tip 2:
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`

This completes the translation. If there are any additional sections or details you need translated, please let me know!