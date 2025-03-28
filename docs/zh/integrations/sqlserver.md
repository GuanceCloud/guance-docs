---
title     : 'SQLServer'
summary   : '采集 SQLServer 的指标数据'
tags:
  - '数据库'
__int_icon      : 'icon/sqlserver'
dashboard :
  - desc  : 'SQLServer'
    path  : 'dashboard/zh/sqlserver'
monitor   :
  - desc  : 'SQLServer 监控器'
    path  : 'monitor/zh/sqlserver'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

SQL Server 采集器采集 SQL Server `waitstats`、`database_io` 等相关指标

## 配置 {#config}

SQL Server 版本 >= 2008, 已测试的版本：

- [x] 2017
- [x] 2019
- [x] 2022

### 前置条件 {#requrements}

- 创建用户：

Linux、Windows:

```sql
USE master;
GO
CREATE LOGIN [guance] WITH PASSWORD = N'yourpassword';
GO
GRANT VIEW SERVER STATE TO [guance];
GO
GRANT VIEW ANY DEFINITION TO [guance];
GO
```

Aliyun RDS SQL Server:

```sql
USE master;
GO
CREATE LOGIN [guance] WITH PASSWORD = N'yourpassword';
GO
```

<!-- markdownlint-disable MD046 -->
???+ attention "注意事项"

    注意，执行上述操作需要相应权限的帐号，否则可能会导致用户创建失败或者授权失败。

    - 自建的 SQL Server 需要具备 WITH GRANT OPTION、CREATE ANY LOGIN、CREATE ANY USER、ALTER ANY LOGIN 权限的用户，也可以直接使用具有 sysadmin 角色的用户或者 local 用户授权。
    - RDS for SQL Server 则需要使用高权限账号进行授权。

### 采集器配置 {#input-config}

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/db` 目录，复制 `sqlserver.conf.sample` 并命名为 `sqlserver.conf`。示例如下：
    
    ```toml
        
    [[inputs.sqlserver]]
      ## your sqlserver host ,example ip:port
      host = ""
    
      ## your sqlserver user,password
      user = ""
      password = ""
    
      ## Instance name. If not specified, a connection to the default instance is made.
      instance_name = ""
    
      ## Database name to query. Default is master.
      database = "master"
    
      ## by default, support TLS 1.2 and above.
      ## set to true if server side uses TLS 1.0 or TLS 1.1
      allow_tls10 = false
    
      ## connection timeout default: 30s
      connect_timeout = "30s"
    
      ## Metric name in metric_exclude_list will not be collected.
      metric_exclude_list = [""]
    
      ## parameters to be added to the connection string
      ## Examples:
      ##   "encrypt=disable"
      ##   "certificate=/path/to/cert.pem"
      ## reference: https://github.com/microsoft/go-mssqldb?tab=readme-ov-file#connection-parameters-and-dsn 
      #
      # connection_parameters = "encrypt=disable"
    
      ## (optional) collection interval, default is 10s
      interval = "10s"
    
    
      ## Set true to enable election
      election = true
    
      ## configure db_filter to filter out metrics from certain databases according to their database_name tag.
      ## If leave blank, no metric from any database is filtered out.
      # db_filter = ["some_db_instance_name", "other_db_instance_name"]
    
    
      ## Run a custom SQL query and collect corresponding metrics.
      #
      # [[inputs.sqlserver.custom_queries]]
      #   sql = '''
      #     select counter_name,cntr_type,cntr_value
      #     from sys.dm_os_performance_counters
      #   '''
      #   metric = "sqlserver_custom_stat"
      #   tags = ["counter_name","cntr_type"]
      #   fields = ["cntr_value"]
    
      # [inputs.sqlserver.log]
      # files = []
      # #grok pipeline script path
      # pipeline = "sqlserver.p"
    
      [inputs.sqlserver.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```
    
    配置好后，[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

### 日志采集配置 {#logging-config}

<!-- markdownlint-disable MD046 -->
???+ attention

    必须将 DataKit 安装在 SQLServer 所在主机才能采集日志。
<!-- markdownlint-enable -->

如需采集 SQL Server 的日志，可在 *sqlserver.conf* 中 将 `files` 打开，并写入 SQL Server 日志文件的绝对路径。比如：

```toml hl_lines="4"
[[inputs.sqlserver]]
    ...
    [inputs.sqlserver.log]
        files = ["/var/opt/mssql/log/error.log"]
```

开启日志采集以后，默认会产生日志来源（*source*）为 `sqlserver` 的日志。

## 指标 {#metric}

以下所有数据采集，默认会追加全局选举 tag，也可以在配置中通过 `[inputs.sqlserver.tags]` 指定其它标签：

``` toml
 [inputs.sqlserver.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

<!-- markdownlint-disable MD024 -->


### `sqlserver`

- 标签


| Tag | Description |
|  ----  | --------|
|`sqlserver_host`|Host name which installed SQLServer|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`committed_memory`|The amount of memory committed to the memory manager. Version > 2008|int|B|
|`cpu_count`|Specifies the number of logical CPUs on the system. Not nullable|int|count|
|`db_offline`|Num of database state in offline|int|count|
|`db_online`|Num of database state in online|int|count|
|`db_recovering`|Num of database state in recovering|int|count|
|`db_recovery_pending`|Num of database state in recovery_pending|int|count|
|`db_restoring`|Num of database state in restoring|int|count|
|`db_suspect`|Num of database state in suspect|int|count|
|`physical_memory`|Total physical memory on the machine. Version > 2008|int|B|
|`server_memory`|Memory used|int|B|
|`target_memory`|Amount of memory that can be consumed by the memory manager. When this value is larger than the committed memory, then the memory manager will try to obtain more memory. When it is smaller, the memory manager will try to shrink the amount of memory committed. Version > 2008|int|B|
|`uptime`|Total time elapsed since the last computer restart|int|ms|
|`virtual_memory`|Amount of virtual memory available to the process in user mode. Version > 2008|int|B|




### `sqlserver_performance`

- 标签


| Tag | Description |
|  ----  | --------|
|`counter_name`|Name of the counter. To get more information about a counter, this is the name of the topic to select from the list of counters in Use SQL Server Objects.|
|`counter_type`|Type of the counter|
|`instance`|Name of the specific instance of the counter|
|`object_name`|Category to which this counter belongs.|
|`sqlserver_host`|Host name which installed SQLServer|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active_transactions`|Number of active transactions across all databases on the SQL Server instance.|int|count|
|`auto_param_attempts`|Number of auto-parameterization attempts per second.|int|count|
|`backup_restore_throughput`|Read/write throughput for backup and restore operations of a database per second.|int|count|
|`batch_requests`|The number of batch requests per second.|int|count|
|`buffer_cache_hit_ratio`|The ratio of data pages found and read from the buffer cache over all data page requests.|float|percent|
|`cache_object_counts`|Number of cache objects in the cache.|int|count|
|`cache_pages`|Number of 8-kilobyte (KB) pages used by cache objects.|int|count|
|`checkpoint_pages`|The number of pages flushed to disk per second by a checkpoint or other operation that require all dirty pages to be flushed.|int|count|
|`cntr_value`|Current value of the counter|int|count|
|`connection_memory`|Specifies the total amount of dynamic memory the server is using for maintaining connections.|int|KB|
|`database_cache_memory`|Specifies the amount of memory the server is currently using for the database pages cache.|int|KB|
|`deadlocks`|Number of lock requests per second that resulted in a deadlock.|int|count|
|`failed_auto_params`|Number of failed auto-parameterization attempts per second.|int|count|
|`flow_control`|Number of times flow-control initiated in the last second. Flow Control Time (ms/sec) divided by Flow Control/sec is the average time per wait.|int|count|
|`full_scans`|Number of unrestricted full scans per second. These can be either base-table or full-index scans.|int|count|
|`granted_workspace_memory`|Specifies the total amount of memory currently granted to executing processes, such as hash, sort, bulk copy, and index creation operations.|int|KB|
|`latch_waits`|Number of latch requests that could not be granted immediately.|int|count|
|`lock_memory`|Specifies the total amount of dynamic memory the server is using for locks.|int|KB|
|`lock_waits`|The number of times per second that SQL Server is unable to retain a lock right away for a resource.|int|count|
|`log_bytes_flushed`|Total number of log bytes flushed.|int|B|
|`log_flush_wait_time`|Total wait time (in milliseconds) to flush the log. On an Always On secondary database, this value indicates the wait time for log records to be hardened to disk.|int|ms|
|`log_flushes`|Number of log flushes per second.|int|count|
|`log_pool_memory`|Total amount of dynamic memory the server is using for Log Pool.|int|KB|
|`longest_transaction_running_time`|The time (in seconds) that the oldest active transaction has been running. Only works if database is under read committed snapshot isolation level.|int|ms|
|`memory_grants_outstanding`|Specifies the total number of processes that have successfully acquired a workspace memory grant.|int|count|
|`memory_grants_pending`|Specifies the total number of processes waiting for a workspace memory grant.|int|count|
|`optimizer_memory`|Specifies the total amount of dynamic memory the server is using for query optimization.|int|KB|
|`page_life_expectancy`|Duration that a page resides in the buffer pool.|int|ms|
|`page_reads`|Indicates the number of physical database page reads that are issued per second. This statistic displays the total number of physical page reads across all databases.|int|count|
|`page_splits`|The number of page splits per second.|int|count|
|`page_writes`|Indicates the number of physical database page writes that are issued per second.|int|count|
|`processes_blocked`|The number of processes blocked.|int|count|
|`safe_auto_params`|Number of safe auto-parameterization attempts per second.|int|count|
|`sql_cache_memory`|Specifies the amount of memory the server is using for the dynamic SQL cache.|int|KB|
|`sql_compilations`|The number of SQL compilations per second.|int|count|
|`sql_re_compilations`|The number of SQL re-compilations per second.|int|count|
|`stolen_server_memory`|Specifies the amount of memory the server is using for purposes other than database pages.|int|KB|
|`total_server_memory`|Specifies the amount of memory the server has committed using the memory manager.|int|KB|
|`transaction_delay`|Total delay in waiting for unterminated commit acknowledgment for all the current transactions, in milliseconds.|int|count|
|`transactions`|Number of transactions started for the SQL Server instance per second.|int|count|
|`user_connections`|Number of user connections.|int|count|
|`version_cleanup_rate`|The cleanup rate of the version store in tempdb.|int|KB|
|`version_generation_rate`|The generation rate of the version store in tempdb.|int|KB|
|`version_store_size`|The size of the version store in tempdb.|int|KB|
|`write_transactions`|Number of transactions that wrote to all databases on the SQL Server instance and committed, in the last second.|int|count|




### `sqlserver_waitstats`

- 标签


| Tag | Description |
|  ----  | --------|
|`sqlserver_host`|Host name which installed SQLServer|
|`wait_category`|Wait category info|
|`wait_type`|Name of the wait type. For more information, see Types of Waits, later in this topic|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`max_wait_time_ms`|Maximum wait time on this wait type.|int|ms|
|`resource_wait_ms`|wait_time_ms-signal_wait_time_ms|int|ms|
|`signal_wait_time_ms`|Difference between the time that the waiting thread was signaled and when it started running|int|ms|
|`wait_time_ms`|Total wait time for this wait type in milliseconds. This time is inclusive of signal_wait_time_ms|int|ms|
|`waiting_tasks_count`|Number of waits on this wait type. This counter is incremented at the start of each wait.|int|count|




### `sqlserver_database_io`

- 标签


| Tag | Description |
|  ----  | --------|
|`database_name`|Database name|
|`file_type`|Description of the file type, `ROWS/LOG/FILESTREAM/FULLTEXT` (Full-text catalogs earlier than SQL Server 2008.)|
|`logical_filename`|Logical name of the file in the database|
|`physical_filename`|Operating-system file name.|
|`sqlserver_host`|Host name which installed SQLServer|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`read_bytes`|Total number of bytes read on this file|int|B|
|`read_latency_ms`|Total time, in milliseconds, that the users waited for reads issued on the file.|int|ms|
|`reads`|Number of reads issued on the file.|int|count|
|`rg_read_stall_ms`|Does not apply to:: SQL Server 2008 through SQL Server 2012 (11.x).Total IO latency introduced by IO resource governance for reads|int|ms|
|`rg_write_stall_ms`|Does not apply to:: SQL Server 2008 through SQL Server 2012 (11.x).Total IO latency introduced by IO resource governance for writes. Is not nullable.|int|ms|
|`write_bytes`|Total number of bytes written to the file|int|B|
|`write_latency_ms`|Total time, in milliseconds, that users waited for writes to be completed on the file|int|ms|
|`writes`|Number of writes issued on the file.|int|count|




### `sqlserver_schedulers`

- 标签


| Tag | Description |
|  ----  | --------|
|`cpu_id`|CPU ID assigned to the scheduler.|
|`scheduler_id`|ID of the scheduler. All schedulers that are used to run regular queries have ID numbers less than 1048576. Those schedulers that have IDs greater than or equal to 1048576 are used internally by SQL Server, such as the dedicated administrator connection scheduler. Is not nullable.|
|`sqlserver_host`|Host name which installed SQLServer|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active_workers_count`|Number of workers that are active. An active worker is never preemptive, must have an associated task, and is either running, runnable, or suspended. Is not nullable.|int|count|
|`context_switches_count`|Number of context switches that have occurred on this scheduler|int|count|
|`current_tasks_count`|Number of current tasks that are associated with this scheduler.|int|count|
|`current_workers_count`|Number of workers that are associated with this scheduler. This count includes workers that are not assigned any task. Is not nullable.|int|count|
|`is_idle`|Scheduler is idle. No workers are currently running|bool|-|
|`is_online`|If SQL Server is configured to use only some of the available processors on the server, this configuration can mean that some schedulers are mapped to processors that are not in the affinity mask. If that is the case, this column returns 0. This value means that the scheduler is not being used to process queries or batches.|bool|-|
|`load_factor`|Internal value that indicates the perceived load on this scheduler|int|count|
|`pending_disk_io_count`|Number of pending I/Os that are waiting to be completed.|int|count|
|`preemptive_switches_count`|Number of times that workers on this scheduler have switched to the preemptive mode|int|count|
|`runnable_tasks_count`|Number of workers, with tasks assigned to them, that are waiting to be scheduled on the runnable queue.|int|count|
|`total_cpu_usage_ms`|Applies to: SQL Server 2016 (13.x) and laterTotal CPU consumed by this scheduler as reported by non-preemptive workers.|int|ms|
|`total_scheduler_delay_ms`|Applies to: SQL Server 2016 (13.x) and laterThe time between one worker switching out and another one switching in|int|ms|
|`work_queue_count`|Number of tasks in the pending queue. These tasks are waiting for a worker to pick them up|int|count|
|`yield_count`|Internal value that is used to indicate progress on this scheduler. This value is used by the Scheduler Monitor to determine whether a worker on the scheduler is not yielding to other workers on time.|int|count|




### `sqlserver_volumespace`

- 标签


| Tag | Description |
|  ----  | --------|
|`sqlserver_host`|Host name which installed SQLServer|
|`volume_mount_point`|Mount point at which the volume is rooted. Can return an empty string. Returns null on Linux operating system.|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`volume_available_space_bytes`|Available free space on the volume|int|B|
|`volume_total_space_bytes`|Total size in bytes of the volume|int|B|
|`volume_used_space_bytes`|Used size in bytes of the volume|int|B|














### `sqlserver_database_size`

- 标签


| Tag | Description |
|  ----  | --------|
|`database_name`|Name of the database|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`data_size`|The size of file of Rows|float|KB|
|`log_size`|The size of file of Log|float|KB|




### `sqlserver_database_backup`

- 标签


| Tag | Description |
|  ----  | --------|
|`database`|Database name|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`backup_count`|The total count of successful backups made for a database|int|count|




### `sqlserver_database_files`

- 标签


| Tag | Description |
|  ----  | --------|
|`database`|Database name|
|`file_id`|ID of the file within database|
|`file_type`|File type: 0 = Rows, 1 = Log, 2 = File-Stream, 3 = Identified for informational purposes only, 4 = Full-text|
|`physical_name`|Operating-system file name|
|`state`|Database file state: 0 = Online, 1 = Restoring, 2 = Recovering, 3 = Recovery_Pending, 4 = Suspect, 5 = Unknown, 6 = Offline, 7 = Defunct|
|`state_desc`|Description of the file state|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`size`|Current size of the database file|int|KB|






## 自定义对象 {#object}





























































### `database`



- 标签


| Tag | Description |
|  ----  | --------|
|`col_co_status`|Current status of collector on SQLServer(`OK/NotOK`)|
|`host`|The server host address|
|`ip`|Connection IP of the SQLServer|
|`name`|Object uniq ID|
|`reason`|If status not ok, we'll get some reasons about the status|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`display_name`|Displayed name in UI|string|-|
|`uptime`|Current SQLServer uptime|int|s|
|`version`|Current version of SQLServer|string|-|




## 日志 {#logging}

以下指标集均以日志形式收集，所有日志等级均为 `info`。















### `sqlserver_lock_row`

- 标签

NA

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`blocking_session_id`|ID of the session that is blocking the request|int|count|
|`cpu_time`|CPU time in milliseconds that is used by the request|int|ms|
|`host_name`|Name of the client workstation that is specific to a session|string|TODO|
|`last_request_end_time`|Time of the last completion of a request on the session, in second|int|ms|
|`last_request_start_time`|Time at which the last request on the session began, in second|int|ms|
|`logical_reads`|Number of logical reads that have been performed by the request|int|count|
|`login_name`|SQL Server login name under which the session is currently executing|string|TODO|
|`memory_usage`|Number of 8-KB pages of memory used by this session|int|count|
|`message`|Text of the SQL query|string|TODO|
|`row_count`|Number of rows returned on the session up to this point|int|count|
|`session_id`|ID of the session to which this request is related|int|count|
|`session_status`|Status of the session|string|TODO|




### `sqlserver_lock_table`

- 标签

NA

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`db_name`|Name of the database under which this resource is scoped|string|TODO|
|`object_name`|Name of the entity in a database with which a resource is associated|string|TODO|
|`request_mode`|Mode of the request|string|TODO|
|`request_session_id`|Session ID that currently owns this request|int|count|
|`request_status`|Current status of this request|string|TODO|
|`resource_type`|Represents the resource type|string|TODO|




### `sqlserver_lock_dead`

- 标签

NA

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`blocking_object_name`|Indicates the name of the object to which this partition belongs|string|TODO|
|`blocking_session_id`|ID of the session that is blocking the request|int|count|
|`blocking_text`|Text of the SQL query which is blocking|string|TODO|
|`db_name`|Name of the database under which this resource is scoped|string|TODO|
|`message`|Text of the SQL query which is blocking|string|TODO|
|`request_mode`|Mode of the request|string|TODO|
|`request_session_id`|Session ID that currently owns this request|int|count|
|`requesting_text`|Text of the SQL query which is requesting|string|TODO|
|`resource_type`|Represents the resource type|string|TODO|




### `sqlserver_logical_io`

- 标签


| Tag | Description |
|  ----  | --------|
|`message`|Text of the SQL query|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`avg_logical_io`|Average number of logical writes and logical reads|int|count|
|`creation_time`|The Unix time at which the plan was compiled, in millisecond|int|count|
|`execution_count`|Number of times that the plan has been executed since it was last compiled|int|count|
|`last_execution_time`|Last time at which the plan started executing, unix time in millisecond|int|count|
|`total_logical_io`|Total number of logical writes and logical reads|int|count|
|`total_logical_reads`|Total amount of logical reads|int|count|
|`total_logical_writes`|Total amount of logical writes|int|count|




### `sqlserver_worker_time`

- 标签


| Tag | Description |
|  ----  | --------|
|`message`|Text of the SQL query|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`avg_worker_time`|Average amount of CPU time, reported in milliseconds|int|count|
|`creation_time`|The Unix time at which the plan was compiled, in millisecond|int|count|
|`execution_count`|Number of times that the plan has been executed since it was last compiled|int|count|
|`last_execution_time`|Last time at which the plan started executing, unix time in millisecond|int|count|
|`total_worker_time`|Total amount of CPU time, reported in milliseconds|int|count|











<!-- markdownlint-enable -->

### 日志 Pipeline 功能切割字段说明 {#pipeline}

SQL Server 通用日志文本示例：

```log
2021-05-28 10:46:07.78 spid10s     0 transactions rolled back in database 'msdb' (4:0). This is an informational message only. No user action is required
```

切割后的字段列表如下：

| 字段名   | 字段值                | 说明                                          |
| -------- | --------------------- | --------------------------------------------- |
| `msg`    | `spid...`             | 日志内容                                      |
| `time`   | `1622169967780000000` | 纳秒时间戳（作为行协议时间）                  |
| `origin` | `spid10s`             | 源                                            |
| `status` | `info`                | 由于日志没有明确字段说明日志等级，默认为 info |
