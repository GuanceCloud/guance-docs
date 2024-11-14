---
title: 'HUAWEI CLOUD DDS'
tags: 
  - Huawei Cloud
summary: 'Collect Huawei Cloud DDS metric data'
__int_icon: 'icon/huawei_dds'
dashboard:
  - desc: 'HUAWEI CLOUD DDS Monitoring View'
    path: 'dashboard/en/huawei_dds/'

monitor:
  - desc: 'HUAWEI CLOUD DDS Monitor'
    path: 'monitor/en/huawei_dds/'
---


Collect Huawei Cloud DDS metric data.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> Recommended deployment of GSE version

### Installation script

> Tip：Please prepare HUAWEI CLOUD AK that meets the requirements in advance（For simplicity's sake, you can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  HUAWEI CLOUD DDS cloud resources, we install the corresponding collection script:

- **guance_huaweicloud_dds**: Collect DDS monitoring indicator data
- **guance_huaweicloud_dds_slowlog**: Collect DDS slow log data

Click 【Install】 and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

Tap【Deploy startup Script】, the system automatically creates `Startup` script sets, and automatically configure the corresponding startup script.

After installing the script, find the script 「Guance Cloud Integration (Huawei Cloud-DDS Collection)」/ 「Guance Cloud Integration (Huawei Cloud-DDS Slow Query Log Collection)」 in the 「Development」 section of Func. Expand and modify the script, find collector_configs and monitor_configs, and edit the content in region_projects below. Change the region and Project ID to the actual region and Project ID, and then click save and publish.

In addition, in「Management / Automatic Trigger Configuration」 you can see the corresponding automatic trigger configuration. Click 【Execute】 to run it immediately, without waiting for the scheduled time. After a short moment, you can check the execution task records and corresponding logs.

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the guance cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the guance cloud platform, press 「Metrics」 to check whether monitoring data exists
4. On the guance cloud platform, check the「logs」 to see if there is corresponding slow log data

## Metric {#metric}

Configure HUAWEI CLOUD DDS metric. You can collect more metrics by configuring them  [HUAWEI CLOUD DDS Metrics Details](https://support.huaweicloud.com/usermanual-dds/dds_03_0026.html){:target="_blank"}

| **MetricID**            |          **Metric Name**   | **Metric Meaning** | **Value Range**      | **Measured Object** | **Monitoring Period (Raw Metric)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `mongo001_command_ps`            |   Command execution frequency    | This indicator is used to calculate the average number of command statements executed on a node per second, measured in times per second. Unit: Executions/s   | ≥ 0 Executions/s  | DDS mongos node under document database cluster instance, primary node under document database instance, backup node under document database instance | 1 minute and 5 seconds                   |
| `mongo002_delete_ps`            |   Delete statement execution frequency   | This indicator is used to calculate the average number of times delete statements are executed on nodes per second. Unit: Executions/s            | ≥ 0 Executions/s         | DDS mongos node under document database cluster instance, primary node under document database instance, backup node under document database instance | 1 minute and 5 seconds              |
| `mongo003_insert_ps`            |    Insert statement execution frequency  | This indicator is used to calculate the average number of times insert statements are executed on nodes per second, measured in units of times per second. Unit: Executions/s | ≥ 0 Executions/s    | DDS mongos node under document database cluster instance, primary node under document database instance, backup node under document database instance   | 1 minute and 5 seconds              |
| `mongo004_query_ps`             |    Query statement execution frequency    | This indicator is used to calculate the average number of query statements executed on nodes per second. Unit: Executions/s | ≥ 0 Executions/s  | DDS mongos node under document database cluster instance, primary node under document database instance, backup node under document database instance | 1 minute and 5 seconds                 |
| `mongo006_getmore_ps`           |      Update statement execution frequency      | This indicator is used to calculate the average number of times update statements are executed on nodes per second. Unit: Executions/s   | 0 Executions/s      | DDS mongos node under document database cluster instance, primary node under document database instance, backup node under document database instance       | 1 minute and 5 seconds                    |
| `mongo007_chunk_num1`           |     Number of chunks in shard one    | This indicator is used to count the number of chunks in shard one. Unit: counts                           | 0~64 Counts       | Document database cluster instance       | 1 minute and 5 seconds                    |
| `mongo007_chunk_num2`       |      Number of chunks in shard 2      | This indicator is used to count the number of chunks in shard 2. Unit: counts           | 0~64 Counts       | Document database cluster instance       | 1 minute and 5 seconds                    |
| `mongo007_chunk_num3`         |   Number of chunks in shard 3    | This indicator is used to count the number of chunks in shard 3. Unit: counts           | 0~64 Counts | Document database cluster instance | 1 minute and 5 seconds                    |
| `mongo007_chunk_num4`          |  Number of chunks in shard 4  | This indicator is used to count the number of chunks in shard 4. Unit: counts           | 0~64 Counts | Document database cluster instance | 1 minute and 5 seconds                    |
| `mongo007_chunk_num5`          |  Number of chunks in shard 5  | This indicator is used to count the number of chunks in shard 5. Unit: counts          | 0~64 Counts | Document database cluster instance | 1 minute and 5 seconds                    |
| `mongo007_chunk_num6`           |  Number of chunks in shard 6   | This indicator is used to count the number of chunks in shard 6. Unit: counts          | 0~64 Counts   | Document database cluster instance | 1 minute and 5 seconds                    |
| `mongo007_chunk_num7`          |  Number of chunks in shard 7  | This indicator is used to count the number of chunks in shard 7. Unit: counts          | 0~64 Counts | Document database cluster instance | 1 minute and 5 seconds                    |
| `mongo007_chunk_num8`         | Number of chunks in shard 8  | This indicator is used to count the number of chunks in shard 8. Unit: counts          | 0~64 Counts | Document database cluster instance | 1 minute and 5 seconds                    |
| `mongo007_chunk_num9`        |    Number of chunks in shard 9    | This indicator is used to count the number of chunks in shard 9. Unit: counts         | 0~64 Counts   | Document database cluster instance | 1 minute and 5 seconds                    |
| `mongo007_chunk_num10`     | Number of chunks in shard 10 | This indicator is used to count the number of chunks in shard 10. Unit: counts            | 0~64 Counts      | Document database cluster instance | 1 minute and 5 seconds                    |
| `mongo007_chunk_num11`       |       Number of chunks in shard 11       | This indicator is used to count the number of chunks in shard 11. Unit: counts           | 0~64 Counts       | Document database cluster instance | 1 minute and 5 seconds                    |
| `mongo007_chunk_num12`        |       Number of chunks in shard 12       | This indicator is used to count the number of chunks in shard 12. Unit: counts            | 0~64 Counts       | Document database cluster instance | 1 minute and 5 seconds                    |
| `mongo008_connections` |     The current number of active connections for the instance     | This indicator is used to count the total number of connections attempting to connect to DDS instances. Unit: Counts                   | 0~200 Counts | Document database instance      | 1 minute and 5 seconds                    |
| `mongo009_migFail_num` |       The number of failed block migrations in the past day       | This indicator is used to count the number of block migration failures in the past day. Unit: Counts/s                       | ≥ 0 Counts/s | Document database cluster instance | 1 minute and 5 seconds                    |
| `mongo007_connections`     |     Current number of active connections     | This indicator is used to count the total number of connections attempting to connect to DDS instance nodes. Unit: Counts                   | 0~200 Counts | DDS mongos node under document database cluster instance, primary node under document database instance, backup node under document database instance的节点 | 1 minute and 5 seconds                    |
| `mongo007_connections_usage`    |     Current percentage of active connections     | This indicator is used to calculate the percentage of connections attempting to connect to an instance node compared to the available connections. Unit:%                   | 0~100% | DDS mongos node under document database cluster instance, primary node under document database instance, backup node under document database instance | 1 minute and 5 seconds                    |
| `mongo008_mem_resident`       |    Resident memory    | This indicator is used to calculate the current size of the resident memory. Unit: MB               | ≥ 0 MB   | DDS mongos node under document database cluster instance, primary node under document database instance, backup node under document database instance | 1 minute                    |
| `mongo009_mem_virtual`     |   Virtual memory   | This indicator is used to calculate the current size of virtual memory. Unit: MB                   | ≥ 0 MB   | DDS mongos node under document database cluster instance, primary node under document database instance, backup node under document database instance | 1 minute                    |
| `mongo010_regular_asserts_ps`     |   Conventional assertion frequency   | This indicator is used to calculate the frequency of routine assertions. Unit: Executions/s             | ≥ 0 Executions/s   | DDS mongos node under document database cluster instance, primary node under document database instance, backup node under document database instance | 1 minute                    |
| `mongo011_warning_asserts_ps`        |      Warning frequency      | This indicator is used to calculate the frequency of warnings. Unit: Executions/s           | ≥ 0 Executions/s   | DDS mongos node under document database cluster instance, primary node under document database instance, backup node under document database instance | 1 minute                    |
| `mongo012_msg_asserts_ps`       |       Message assertion frequency       | This indicator is used to calculate the frequency of message assertions. Unit: Executions/s             | ≥ 0 Executions/s   | DDS mongos node under document database cluster instance, primary node under document database instance, backup node under document database instance | 1 minute                    |
| `mongo013_user_asserts_ps`       |    User assertion frequency    | This indicator is used to calculate the frequency of user assertions. Unit: Executions/s           | ≥ 0 Executions/s   | DDS mongos node under document database cluster instance, primary node under document database instance, backup node under document database instance | 1 minute                    |
| `mongo014_queues_total`    |    Waiting for lock operation    | This indicator is used to count the number of operations currently waiting for a lock. Unit: Counts       | ≥ 0 Counts   |     This indicator is used to count the number of operations currently waiting for a lock. Unit: Counts | 1 minute                    |
| `mongo015_queues_readers`    |    The number of operations waiting to read the lock    | This indicator is used to count the number of operations currently waiting to read locks. Unit: Counts       | ≥ 0 Counts   |     The primary node under the document database instance and the backup node under the document database instance | 1 minute                    |
| `mongo016_queues_writers`    |    Number of operations waiting to write lock    | This indicator is used to count the number of operations currently waiting to write locks. Unit: Counts       | ≥ 0 Counts   |     The primary node under the document database instance and the backup node under the document database instance | 1 minute                    |
| `mongo017_page_faults`    |    Number of page missing errors    | This indicator is used to count the number of missing page errors on the current node. Unit: Counts       | ≥ 0 Counts   |     The primary node under the document database instance and the backup node under the document database instance | 1 minute                    |
| `mongo018_porfling_num`    |    Slow query count    | This indicator is used to count the total number of slow queries from the first 5 minutes to the current time point on the current node. Unit: Counts       | ≥ 0 Counts   |     The primary node under the document database instance and the backup node under the document database instance | 1 minute                    |
| `mongo019_cursors_open`    |    Current number of cursor maintenance    | This indicator is used to count the number of maintenance pointers on the current node. Unit: Counts       | ≥ 0 Counts   |     The primary node under the document database instance and the backup node under the document database instance | 1 minute                    |
| `mongo020_cursors_timeOut`    |    Service timeout cursor count    | This indicator is used to count the number of service timeout pointers on the current node. Unit: Counts       | ≥ 0 Counts   |     The primary node under the document database instance and the backup node under the document database instance | 1 minute                    |
| `mongo021_wt_cahe_usage`    |    Data volume in memory (WiredTiger engine)    | This indicator is used to calculate the current amount of data in memory (WiredTiger engine). Unit: MB       | ≥ 0 MB   |     The primary node under the document database instance and the backup node under the document database instance | 1 minute                    |
| `mongo022_wt_cahe_dirty`    |    Dirty data volume in memory (WiredTiger engine)    | This indicator is used to calculate the amount of dirty data in the current memory (WiredTiger engine). Unit: MB       | ≥ 0 MB   |     The primary node under the document database instance and the backup node under the document database instance | 1 minute                    |
| `mongo023_wInto_wtCache`    |    Frequency of writing to WireDiger memory    | This indicator is used to calculate the write frequency in the current memory (WiredTiger engine). Unit: ≥ bytes/s      | ≥ 0 Bytes/s   |     The primary node under the document database instance and the backup node under the document database instance | 1 minute                    |
| `mongo024_wFrom_wtCache`    |    Write frequency from WireDiger memory to disk    | This indicator is used to calculate the current frequency of memory writes to the disk (WiredTiger engine). Unit: bytes/s       | ≥ 0 Bytes/s   |     The main node under the document database instance | 1 minute                    |
| `mongo025_repl_oplog_win`    |    The available time in the Oplog of the master node   | This indicator is used to calculate the available time in the Oplog of the master node under the current instance. Unit: Hours       | ≥ 0 Hours   |    Node of backup node in document database instance | 1 minute                    |
| `mongo025_repl_headroom`    |   Overlapping duration of primary and backup Oplogs    | This indicator is used to calculate the duration of Oplog overlap between primary and secondary nodes in an instance. Unit: Seconds       | ≥ 0 Seconds   |     Backup node under document database instance | 1 minute                    |
| `mongo026_repl_lag`    |    Primary and backup delay    | This indicator is used to calculate the replication delay between the primary and secondary nodes in an instance. Unit: Seconds      | ≥ 0 Seconds   |     Backup node under document database instance | 1 minute                    |
| `mongo027_repl_command_ps`    |    Command execution frequency for backup node replication    | This indicator is used to calculate the average number of command statement executions per second replicated by Secondary nodes. Unit: Executions/s      | ≥ 0 Executions/s   |     Backup node under document database instance | 1 minute                    |
| `mongo028_repl_update_ps`    |    Update statement execution frequency for backup node replication    | This indicator is used to calculate the average number of times update statements are executed per second for replication of secondary nodes. Unit: Executions/s       | ≥ 0 Executions/s   |   Backup node under document database instance   | 1 minute                    |
| `mongo029_repl_delete_ps`    |    Execute delete statement for backup node replication    | This indicator is used to calculate the average number of delete statement executions per second for secondary node replication. Unit: Executions/s       | ≥ 0 Executions/s   |   Backup node under document database instance   | 1 minute                    |
| `mongo030_repl_insert_ps`    |    Execution frequency of insert statements for backup node replication    | This indicator is used to calculate the average number of insert statement executions per second for secondary node replication. Unit: Executions/s       | ≥ 0 Executions/s   |   Backup node under document database instance   | 1 minute                    |
| `mongo031_cpu_usage`         |    CPU usage rate    | This indicator is used to calculate the CPU utilization of the measured object. Unit:%       | 0~100%   |   DDS mongos node under document database cluster instance, primary node under document database instance, backup node under document database instance   | 1 minute                    |
| `mongo032_mem_usage`    |    Memory usage rate    | This indicator is used to measure the memory utilization of the measured object. Unit:%       | 0~100%   |   DDS mongos node under document database cluster instance, primary node under document database instance, backup node under document database instance   | 1 minute                    |
| `mongo033_bytes_out`    |    Network output throughput    |This indicator is used to calculate the average traffic output per second from all network adapters of the measurement object. Unit: bytes/s       | ≥ 0 Bytes/s   |   DDS mongos node under document database cluster instance, primary node under document database instance, backup node under document database instance   | 1 minute                      |
| `mongo034_bytes_in`    |    Network input throughput    | This indicator is used to calculate the average traffic input per second from all network adapters of the measurement object. Unit: bytes/s       | ≥ 0 Bytes/s   |   DDS mongos node under document database cluster instance, primary node under document database instance, backup node under document database instance   | 1 minute                    |
| `mongo035_disk_usage`    |    Disk utilization rate    | This indicator is used to measure the disk utilization of the object being measured. Unit:%       | 0~100%   |   DDS mongos node under document database cluster instance, primary node under document database instance, backup node under document database instance   | 1 minute                    |
| `mongo036_iops`    |    IOPS    | This indicator is used to calculate the average number of I/O requests processed by the system per unit time for the current instance node. Unit: Counts       | ≥ 0 Counts/s   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo037_read_throughput`    |    Hard disk read throughput    | The average number of bytes read per second on a hard drive. Unit: bytes/s       | ≥ 0 Bytes/s   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo038_write_throughput`    |   Hard disk write throughput    | The average number of bytes written per second on a hard drive. Unit: bytes/s     | ≥ 0 Bytes/s   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo039_avg_disk_sec_per_read`    |    Hard disk read time    | This indicator is used to calculate the average time taken to read the hard disk during a certain period of time. Unit: Seconds       | ≥ 0 Seconds   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo040_avg_disk_sec_per_write`    |    Hard disk write time    | This indicator is used to calculate the average time spent writing to the hard disk during a certain period of time. Unit: Seconds       | ≥ 0 Seconds   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo042_disk_total_size`    |   Total disk size    | This indicator is used to calculate the total disk size of the measured object. Unit: GB      | 0~1000 GB   |   DDS mongos node under document database cluster instance, primary node under document database instance, backup node under document database instance   | 1 minute                    |
| `mongo043_disk_used_size`    |   Disk usage    | This indicator is used to calculate the total disk size used by the measured object. Unit: GB      | 0~1000 GB   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo044_swap_usage`    |    SWAP utilization rate    | Swap memory SWAP usage percentage.          单位：%       | 0~100%   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo050_top_total_time`    |    The total time spent on the collection    | Mongotop-total time metric for collection and the total time spent on collection operations. Unit: Milliseconds       | ≥ 0 Milliseconds   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo051_top_read_time`    |    The total time spent on collective reading    | Mongotop-read time metric, the total time spent on collection read operations.   单位：Milliseconds       | ≥ 0 Milliseconds   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo052_top_write_time`    |    The total time spent on writing collections    | Mongotop-write time metric, the total time spent on collection read operations.   Unit：Milliseconds       | ≥ 0 Milliseconds   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo053_wt_flushes_status`    |    The number of triggers for the periodic checkpoint    | WireDiger records the number of times a checkpoint is triggered during a polling interval, in units of the number of occurrences during the cycle. Unit: Counts       | ≥ 0 Counts   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo054_wt_cache_used_percent`    |    Cache percentage in use of Wirediger    | The percentage of cache size used by Wiredtiger. Unit:%      | 0~100%   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo055_wt_cache_dirty_percent`    |    Cache percentage of Wirediger dirty data    | The percentage of cache size for Wirediger dirty data. Unit:%       | 0~100%   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo070_rocks_active_memtable`    |    Data size in memtable    | Collect the data size from the current active memtable. Unit: GB       | 0~100 GB   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo071_rocks_oplogcf_active_memtable`    |    The data size in the memtable on oplogCF    | Collect the data size currently used in the active memtable on OPLOGCF. Unit: GB       | 0~100GB   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo072_rocks_all_memtable`    |    The total data size in memtable and immutable mem    | Collect the total data size from the current memtable and immutable mem. Unit: GB       | 0~100GB   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo073_rocks_oplogcf_all_memtable`    |    The total data size in memtable and immutable mem on oplogCF    | Collect the total data size currently used for memtable and immutable mem on oplogCF. Unit: GB       | 0~100GB   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo074_rocks_snapshots`    |    The number of unreleased snapshots    | Collect the number of currently unreleased snapshots. Unit: Counts      | ≥ 0 Counts   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo075_rocks_oplogcf_snapshots`    |    The number of unreleased snapshots on oplogCF    |   Collect the number of unreleased snapshots on the current oplogCF. Unit: Counts       | ≥ 0 Counts   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo076_rocks_live_versions`    |    Number of versions of the activity    | Collect the current number of active versions. Unit: Counts       | ≥ 0 Counts   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo077_rocks_oplogcf_live_versions`    |    The number of active versions on OPLOGCF    | Collect the current number of active versions on OPLOGCF. Unit: Counts      | ≥ 0 Counts   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo078_rocks_block_cache`    |    The size of data residing in the blockcache    | Collect the size of the data currently residing in the blockcache. Unit: Counts       | ≥ 0 Counts   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo079_rocks_background_errors`    |    Accumulated number of errors in the background    | Collect and record the cumulative number of errors in the background. Unit: Counts       | ≥ 0 Counts   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo080_rocks_oplogcf_background_errors`    |    Accumulated number of errors in both the upper and lower levels of OPLOGCF    | Collect and record the cumulative number of errors in the background of OPLOGCF. Unit: Counts       | ≥ 0 Counts   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo081_rocks_conflict_bytes_usage`    |    Transaction writing conflict handling buffer usage rate    | Collect the usage rate of transaction write in conflict handling buffer. Unit:%       | 0~100%   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo082_rocks_uncommitted_keys`    |    The number of keys that have not been submitted    | Collect the current number of keys that have not been submitted. Unit: Counts       | ≥ 0 Counts   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo083_rocks_committed_keys`    |    The number of keys submitted    | Collect the current number of submitted keys. Unit: Counts       | ≥ 0 Counts   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo084_rocks_alive_txn`    |    The length of the active transaction linked list    | The length unit of the active transaction linked list for collecting records: Counts       | ≥ 0 Counts   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo085_rocks_read_queue`    |    Read the length of the queue    | Collect the length of the current read queue. Unit: Counts       | ≥ 0 Counts   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo086_rocks_commit_queue`    |    The length of the submission queue    | Collect the length of the current submission queue. Unit: Counts       | ≥ 0 Counts   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo087_rocks_ct_write_out`    |    Number of concurrent write transactions used    | Collect the current number of concurrent write transactions used, unit: Counts       | ≥ 0 Counts   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo088_rocks_ct_write_available`    |    Remaining available concurrent write transactions    | Collect the current remaining available concurrent write transactions. Unit: Counts       | ≥ 0 Counts   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo089_rocks_ct_read_out`    |    Concurrent read has been used    | Collect the current number of concurrent read transactions in use. Unit: Counts       | ≥ 0 Counts   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo090_rocks_ct_read_available`    |    Remaining available concurrent read transactions     | Collect the current remaining available concurrent read transactions. Unit: Counts       | ≥ 0 Counts   |   The primary node under the document database instance and the backup node under the document database instance   | 1 minute                    |
| `mongo091_active_session_count`    |    Number of active sessions per cycle    | This metric is used to count the number of active local sessions cached in memory by Mongo instances since the last refresh cycle. Unit: Counts       | ≥ 0 Counts   |  The primary node under the document database instance and the backup node under the document database instance are read-only nodes under the document database instance and hidden nodes under the document database instance    | 1 minute                    |
| `mongo092_rx_errors`    |    Receiving message error rate    | This indicator is used to calculate the ratio of the number of erroneous messages received to all received messages during the monitoring period. Unit:%      | 0～100%   |   Document database instance   | 1 minute and 5 seconds                   |
| `mongo093_rx_dropped`    |    Packet loss rate of received messages    | This indicator is used to monitor the ratio of the number of lost messages to all received messages during the monitoring period. Unit:%       | 0～100%   |   Document database instance   | 1 minute and 5 seconds                   |
| `mongo094_tx_errors`    |    Sending message error rate    | This indicator is used to monitor the ratio of the number of erroneous messages sent to the total number of messages sent during the monitoring period. Unit:%       | 0～100%   |   Document database instance   | 1 minute and 5 seconds                   |
| `mongo095_tx_dropped`    |    Packet loss rate for sending messages    | This indicator is used to monitor the ratio of the number of lost messages to the total number of messages sent during the monitoring period. Unit:%       | 0～100%   |   Document database instance   | 1 minute and 5 seconds                   |
| `mongo096_retrans_segs`    |    Number of retransmission packets    | This indicator is used to count the number of retransmission packets during the monitoring period. Unit: Counts       | ≥ 0 Counts   |   Document database instance   | 1 minute and 5 seconds                   |
| `mongo097_retrans_rate`    |    Resend ratio    | This indicator is used to monitor the proportion of retransmission packets during the monitoring period. Unit:%       | 0～100%   |   Document database instance   | 1 minute and 5 seconds                   |
| `mongo098_out_rsts_nums`    |    Number of RST sent    | This indicator is used to monitor the number of RST statistics during the monitoring period. Unit: Counts       | ≥ 0 Counts   |   Document database instance   | 1 minute and 5 seconds                   |
| `mongo099_read_time_average`    |    Average time spent reading commands    | This indicator is the average time consumption of read commands for a single node. Unit: Milliseconds       | ≥ 0 Milliseconds   |   Read only nodes under document database instance, document database replica set instance, primary node under document database instance, backup node under document database instance, hidden nodes under document database instance   | 1 minute                   |
| `mongo100_read_time_p99`    |    Reading command p99 takes time    | This indicator is the time consumption of the p99 read command for a single node. Unit: Milliseconds      | ≥ 0 Milliseconds   |   Read only nodes under document database instance, document database replica set instance, primary node under document database instance, backup node under document database instance, hidden nodes under document database instance   | 1 minute                   |
| `mongo101_read_time_p999`    |    Reading command p999 takes time    | This indicator is the time consumption of the p999 read command for a single node. Unit: Milliseconds      | ≥ 0 Milliseconds  |   Read only nodes under document database instance, document database replica set instance, primary node under document database instance, backup node under document database instance, hidden nodes under document database instance   | 1 minute                   |
| `mongo102_write_time_average`    |    Average command writing time    | This indicator is the average time spent writing commands for a single node. Unit: Milliseconds       | ≥ 0 Milliseconds   |   Read only nodes under document database instance, document database replica set instance, primary node under document database instance, backup node under document database instance, hidden nodes under document database instance   | 1 minute                   |
| `mongo103_write_time_p99`    |    Writing command p99 takes time    | This indicator is the time consumption of writing command p99 for a single node. Unit: Milliseconds       | ≥ 0 Milliseconds   |   Read only nodes under document database instance, document database replica set instance, primary node under document database instance, backup node under document database instance, hidden nodes under document database instance   | 1 minute                   |
| `mongo104_write_time_p999`    |    Writing command p999 takes time    | This indicator is the time consumption of writing command p999 for a single node. Unit: Milliseconds       | ≥ 0 Milliseconds   |   Read only nodes under document database instance, document database replica set instance, primary node under document database instance, backup node under document database instance, hidden nodes under document database instance   | 1 minute                   |
| `mongo105_command_time_average`    |    Average command time    | This indicator is the average time consumption of node commands for a single node. Unit: Milliseconds       | ≥ 0 Milliseconds   |   Read only nodes under document database instance, document database replica set instance, primary node under document database instance, backup node under document database instance, hidden nodes under document database instance   | 1 minute                   |
| `mongo106_command_time_p99`    |    Command P99 takes time    | This indicator is the command time of a single node, p99 time. Unit: Milliseconds       | ≥ 0 Milliseconds   |   Read only nodes under document database instance, document database replica set instance, primary node under document database instance, backup node under document database instance, hidden nodes under document database instance   | 1 minute                   |
| `mongo107_command_time_p999`    |    Command p999 takes time    | This indicator is the command time of a single node, p999 time. Unit: Milliseconds       | ≥ 0 Milliseconds   |   Read only nodes under document database instance, document database replica set instance, primary node under document database instance, backup node under document database instance, hidden nodes under document database instance   | 1 minute                   |
| `mongo108_txn_time_average`    |    Average transaction time    | This indicator is the average transaction time of a single node. Unit: Milliseconds       | ≥ 0 Milliseconds   |   Read only nodes under document database instance, document database replica set instance, primary node under document database instance, backup node under document database instance, hidden nodes under document database instance   | 1 minute                   |
| `mongo109_txn_time_p99`    |    Transaction P99 takes time    | This indicator represents the transaction p99 time consumption of a single node. Unit: Milliseconds       | ≥ 0 Milliseconds   |   Read only nodes under document database instance, document database replica set instance, primary node under document database instance, backup node under document database instance, hidden nodes under document database instance   | 1 minute                   |
| `mongo110_txn_time_p999`    |    Transaction p999 takes time    | This indicator is the p999 transaction time of a single node. Unit: Milliseconds       | ≥ 0 Milliseconds   |   Read only nodes under document database instance, document database replica set instance, primary node under document database instance, backup node under document database instance, hidden nodes under document database instance   | 1 minute                   |

## Object {#object}

The collected HUAWEI CLOUD ELB object data structure can see the object data from 「Infrastructure-custom-defined」

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
    "backup_strategy" : "{Instance JSON data}",
    "datastore"       : "{Instance JSON data}",
    "groups"          : "[Instance JSON data]",
    "time_zone"       : "",
    "message"         : "{Instance JSON data}"
  }
}
```

> *notice：`tags`、`fields`The fields in this section may change with subsequent updates*
>
> Tips 1：`tags.name`The value is the instance ID for unique identification
>
> Tips 2：
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`

