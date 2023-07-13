---
title     : 'SQLServer'
summary   : '采集 SQLServer 的指标数据'
<<<<<<< HEAD
<<<<<<< HEAD
icon      : 'icon/sqlserver'
=======
__int_icon      : 'icon/sqlserver'
>>>>>>> bcdb7fa10debda85713fee55db2e1181e9301f46
=======
__int_icon      : 'icon/sqlserver'
>>>>>>> c66e8140414e8da5bc40d96d0cea42cd2412a7c6
dashboard :
  - desc  : 'SQLServer'
    path  : 'dashboard/zh/sqlserver'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# SQLServer
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "Election Enabled")

---

SQL Server 采集器采集 SQL Server `waitstats`、`database_io` 等相关指标


## 配置 {#config}

### 前置条件 {#requrements}

- SQL Server 版本 >= 2019

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

### 采集器配置 {#input-config}

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/db` 目录，复制 `sqlserver.conf.sample` 并命名为 `sqlserver.conf`。示例如下：
    
    ```toml
        
    [[inputs.sqlserver]]
      ## your sqlserver host ,example ip:port
      host = ""
    
      ## your sqlserver user,password
      user = ""
      password = ""
    
      ## (optional) collection interval, default is 10s
      interval = "10s"
    
      ## by default, support TLS 1.2 and above.
      ## set to true if server side uses TLS 1.0 or TLS 1.1
      allow_tls10 = false
    
      ## Set true to enable election
      election = true
    
      ## Database name to query. Default is master.
      database = "master"
    
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
    
    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。
<!-- markdownlint-enable -->

#### 日志采集配置 {#logging-config}

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

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.sqlserver.tags]` 指定其它标签：

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
|`sqlserver_host`|host name which installed SQLServer|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`committed_memory`|The amount of memory committed to the memory manager|int|B|
|`cpu_count`|Specifies the number of logical CPUs on the system. Not nullable|int|count|
|`db_offline`|num of database state in offline|int|count|
|`db_online`|num of database state in online|int|count|
|`db_recovering`|num of database state in recovering|int|count|
|`db_recovery_pending`|num of database state in recovery_pending|int|count|
|`db_restoring`|num of database state in restoring|int|count|
|`db_suspect`|num of database state in suspect|int|count|
|`physical_memory`|Total physical memory on the machine|int|B|
|`server_memory`|memory used|int|B|
|`target_memory`|Amount of memory that can be consumed by the memory manager. When this value is larger than the committed memory, then the memory manager will try to obtain more memory. When it is smaller, the memory manager will try to shrink the amount of memory committed.|int|B|
|`uptime`|Total time elapsed since the last computer restart|int|ms|
|`virtual_memory`|Amount of virtual memory available to the process in user mode.|int|B|




### `sqlserver_performance`

- 标签


| Tag | Description |
|  ----  | --------|
|`counter_name`|Name of the counter. To get more information about a counter, this is the name of the topic to select from the list of counters in Use SQL Server Objects.|
|`counter_type`|Type of the counter|
|`instance`|Name of the specific instance of the counter|
|`object_name`|Category to which this counter belongs.|
|`sqlserver_host`|host name which installed SQLServer|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cntr_value`|Current value of the counter|float|count|




### `sqlserver_waitstats`

- 标签


| Tag | Description |
|  ----  | --------|
|`sqlserver_host`|host name which installed SQLServer|
|`wait_category`|wait category info|
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
|`database_name`|database name|
|`file_type`|Description of the file type, `ROWS/LOG/FILESTREAM/FULLTEXT` (Full-text catalogs earlier than SQL Server 2008.)|
|`logical_filename`|Logical name of the file in the database|
|`physical_filename`|Operating-system file name.|
|`sqlserver_host`|host name which installed SQLServer|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`read_bytes`|Total number of bytes read on this file|int|B|
|`read_latency_ms`|Total time, in milliseconds, that the users waited for reads issued on the file.|int|ms|
|`reads`|Number of reads issued on the file.|int|count|
|`rg_read_stall_ms`|Does not apply to:: SQL Server 2008 through SQL Server 2012 (11.x).Total IO latency introduced by IO resource governance for reads|int|ms|
|`rg_write_stall_ms`|Does not apply to:: SQL Server 2008 through SQL Server 2012 (11.x).Total IO latency introduced by IO resource governance for writes. Is not nullable.|int|ms|
|`write_bytes`|Number of writes made on this file|int|B|
|`write_latency_ms`|Total time, in milliseconds, that users waited for writes to be completed on the file|int|ms|
|`writes`|Number of writes issued on the file.|int|count|




### `sqlserver_schedulers`

- 标签


| Tag | Description |
|  ----  | --------|
|`cpu_id`|CPU ID assigned to the scheduler.|
|`scheduler_id`|ID of the scheduler. All schedulers that are used to run regular queries have ID numbers less than 1048576. Those schedulers that have IDs greater than or equal to 1048576 are used internally by SQL Server, such as the dedicated administrator connection scheduler. Is not nullable.|
|`sqlserver_host`|host name which installed SQLServer|

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
|`sqlserver_host`|host name which installed SQLServer|
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
|`file_type`|File type: 0 = Rows, 1 = Log, 2 = FILESTREAM, 3 =  Identified for informational purposes only, 4 = Full-text|
|`physical_name`|Operating-system file name|
|`state`|Database file state: 0 = Online, 1 = Restoring, 2 = Recovering, 3 = Recovery_Pending, 4 = Suspect, 5 = Unknown, 6 = Offline, 7 = Defunct|
|`state_desc`|Description of the file state|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`size`|Current size of the database file|int|KB|




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
| ---      | ---                   | ---                                           |
| `msg`    | `spid...`             | 日志内容                                      |
| `time`   | `1622169967780000000` | 纳秒时间戳（作为行协议时间）                  |
| `origin` | `spid10s`             | 源                                            |
| `status` | `info`                | 由于日志没有明确字段说明日志等级，默认为 info |
