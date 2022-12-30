<!-- This file required to translate to EN. -->

# SQLServer
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

---

SQL Server 采集器采集 SQL Server `waitstats`、`database_io` 等相关指标

## 前置条件 {#requrements}

- SQL Server 版本 >= 2019

- 创建用户：

Linux、Windows:

```
USE master;
GO
CREATE LOGIN [guance] WITH PASSWORD = N'yourpassword';
GO
GRANT VIEW SERVER STATE TO [guance];
GO
GRANT VIEW ANY DEFINITION TO [guance];
GO
```

aliyun RDS SQL Server:

```
USE master;
GO
CREATE LOGIN [guance] WITH PASSWORD = N'yourpassword';
GO

```

## 配置 {#config}

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
    
      ## configure db_filter to filter out metrics from certain databases according to their database_name tag.
      ## If leave blank, no metric from any database is filtered out.
      # db_filter = ["some_db_instance_name", "other_db_instance_name"]
    
      # [inputs.sqlserver.log]
      # files = []
      # #grok pipeline script path
      # pipeline = "sqlserver.p"
    
      [inputs.sqlserver.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
    
    ```
    
    配置好后，重启 DataKit 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

## 指标 {#measurements}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.sqlserver.tags]` 指定其它标签：

``` toml
 [inputs.sqlserver.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `sqlserver`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`sqlserver_host`|host name which installed sqlserver|

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`cpu_count`|Specifies the number of logical CPUs on the system. Not nullable.|int|count|
|`db_offline`|num of database state in offline|int|count|
|`db_online`|num of database state in online|int|count|
|`db_recovering`|num of database state in recovering|int|count|
|`db_recovery_pending`|num of database state in recovery_pending|int|count|
|`db_restoring`|num of database state in restoring|int|count|
|`db_suspect`|num of database state in suspect|int|count|
|`server_memory`|memory used|int|B|




### `sqlserver_performance`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`counter_name`|Name of the counter. To get more information about a counter, this is the name of the topic to select from the list of counters in Use SQL Server Objects.|
|`object_name`|Category to which this counter belongs.|
|`sqlserver_host`|host name which installed sqlserver|

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`cntr_value`|Current value of the counter.|int|count|




### `sqlserver_waitstats`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`sqlserver_host`|host name which installed sqlserver|
|`wait_category`|wait category info|
|`wait_type`|Name of the wait type. For more information, see Types of Waits, later in this topic|

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`max_wait_time_ms`|Maximum wait time on this wait type.|int|ms|
|`resource_wait_ms`|wait_time_ms-signal_wait_time_ms|int|ms|
|`signal_wait_time_ms`|Difference between the time that the waiting thread was signaled and when it started running|int|ms|
|`wait_time_ms`|Total wait time for this wait type in milliseconds. This time is inclusive of signal_wait_time_ms|int|ms|
|`waiting_tasks_count`|Number of waits on this wait type. This counter is incremented at the start of each wait.|int|count|




### `sqlserver_database_io`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`database_name`|database name|
|`file_type`|Description of the file type,ROWS、LOG、FILESTREAM、FULLTEXT (Full-text catalogs earlier than SQL Server 2008.)|
|`logical_filename`|Logical name of the file in the database|
|`physical_filename`|Operating-system file name.|
|`sqlserver_host`|host name which installed sqlserver|

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`read`|Number of reads issued on the file.|int|count|
|`read_bytes`|Total number of bytes read on this file|int|B|
|`read_latency_ms`|Total time, in milliseconds, that the users waited for reads issued on the file.|int|ms|
|`rg_read_stall_ms`|Does not apply to:: SQL Server 2008 through SQL Server 2012 (11.x).Total IO latency introduced by IO resource governance for reads|int|ms|
|`rg_write_stall_ms`|Does not apply to:: SQL Server 2008 through SQL Server 2012 (11.x).Total IO latency introduced by IO resource governance for writes. Is not nullable.|int|ms|
|`write_bytes`|Number of writes made on this file|int|B|
|`write_latency_ms`|Total time, in milliseconds, that users waited for writes to be completed on the file|int|ms|
|`writes`|Number of writes issued on the file.|int|count|




### `sqlserver_schedulers`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`cpu_id`|CPU ID assigned to the scheduler.|
|`scheduler_id`|ID of the scheduler. All schedulers that are used to run regular queries have ID numbers less than 1048576. Those schedulers that have IDs greater than or equal to 1048576 are used internally by SQL Server, such as the dedicated administrator connection scheduler. Is not nullable.|
|`sqlserver_host`|host name which installed sqlserver|

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
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

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`sqlserver_host`|host name which installed sqlserver|
|`volume_mount_point`|Mount point at which the volume is rooted. Can return an empty string. Returns null on Linux operating system.|

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`volume_available_space_bytes`|Available free space on the volume|int|B|
|`volume_total_space_bytes`|Total size in bytes of the volume|int|B|
|`volume_used_space_bytes`|Used size in bytes of the volume|int|B|






### `sqlserver_lock_database`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`db_name`|Name of the database under which this resource is scoped|
|`object`|ID or name of the entity in a database with which a resource is associated|
|`request_mode`|Mode of the request|
|`request_status`|Current status of this request|
|`request_type`|Request type|
|`resource_type`|Represents the resource type|
|`spid`|Session ID that currently owns this request, maximum length is 4 |

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`resource_database_id`|ID of the database under which this resource is scoped|int|count|




### `sqlserver_lock_table`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`db_name`|Name of the database under which this resource is scoped|
|`object_name`|Name of the entity in a database with which a resource is associated|
|`request_mode`|Mode of the request|
|`request_status`|Current status of this request|
|`resource_type`|Represents the resource type|

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`resource_session_id`|Session ID that currently owns this request|int|count|










### `sqlserver_database_size`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`name`|Name of the database|

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`data_size`|The size of file of Rows|float|KB|
|`log_size`|The size of file of Log|float|KB|




## 日志 {#logging}















### `sqlserver_lock_row`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`host_name`|Name of the client workstation that is specific to a session|
|`login_name`|SQL Server login name under which the session is currently executing|
|`session_status`|Status of the session|
|`text`|Text of the SQL query|

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`blocking_session_id`|ID of the session that is blocking the request|int|count|
|`cpu_time`|CPU time in milliseconds that is used by the request|int|ms|
|`last_request_end_time`|Time of the last completion of a request on the session, in second|int|ms|
|`last_request_start_time`|Time at which the last request on the session began, in second|int|ms|
|`logical_reads`|Number of logical reads that have been performed by the request|int|count|
|`memory_usage`|Number of 8-KB pages of memory used by this session|int|count|
|`row_count`|Number of rows returned on the session up to this point|int|count|
|`session_id`|ID of the session to which this request is related|int|count|








### `sqlserver_lock_dead`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`blocking_object_name`|Indicates the name of the object to which this partition belongs|
|`blocking_text`|Text of the SQL query which is blocking|
|`db_name`|Name of the database under which this resource is scoped|
|`request_mode`|Mode of the request|
|`requesting_text`|Text of the SQL query which is requesting|
|`resource_type`|Represents the resource type|

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`blocking_session_id`|ID of the session that is blocking the request|int|count|
|`request_session_id`|Session ID that currently owns this request|int|count|




### `sqlserver_logical_io`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`message`|Text of the SQL query|

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`avg_logical_io`|Average number of logical writes and logical reads|int|count|
|`creation_time`|The Unix time at which the plan was compiled, in millisecond|int|count|
|`execution_count`|Number of times that the plan has been executed since it was last compiled|int|count|
|`last_execution_time`|Last time at which the plan started executing, unix time in millisecond|int|count|
|`total_logical_io`|Total number of logical writes and logical reads|int|count|
|`total_logical_reads`|Total amount of logical reads|int|count|
|`total_logical_writes`|Total amount of logical writes|int|count|




### `sqlserver_worker_time`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`message`|Text of the SQL query|

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`avg_worker_time`|Average amount of CPU time, reported in milliseconds|int|count|
|`creation_time`|The Unix time at which the plan was compiled, in millisecond|int|count|
|`execution_count`|Number of times that the plan has been executed since it was last compiled|int|count|
|`last_execution_time`|Last time at which the plan started executing, unix time in millisecond|int|count|
|`total_worker_time`|Total amount of CPU time, reported in milliseconds|int|count|







## 日志采集 {#logging}

???+ attention

    必须将 DataKit 安装在 SQLServer 所在主机才能采集日志。

如需采集 SQL Server 的日志，可在 sqlserver.conf 中 将 `files` 打开，并写入 SQL Server 日志文件的绝对路径。比如：

```toml
    [[inputs.sqlserver]]
      ...
      [inputs.sqlserver.log]
        files = ["/var/opt/mssql/log/error.log"]
```


开启日志采集以后，默认会产生日志来源（`source`）为 `sqlserver` 的日志。

>注意：必须将 DataKit 安装在 SQL Server 所在主机才能采集 SQL Server 日志

### 日志 pipeline 功能切割字段说明 {#pipeline}

- SQL Server 通用日志切割

通用日志文本示例：
```
2021-05-28 10:46:07.78 spid10s     0 transactions rolled back in database 'msdb' (4:0). This is an informational message only. No user action is required
```

切割后的字段列表如下：

| 字段名 | 字段值              | 说明                                         |
| ---    | ---                 | ---                                          |
| msg    | spid...             | 日志内容                                     |
| time   | 1622169967780000000 | 纳秒时间戳（作为行协议时间）                 |
| origin | spid10s             | 源                                           |
| status | info                | 由于日志没有明确字段说明日志等级，默认为info |
