
# SQLServer

- DataKit 版本：1.4.0
- 文档发布日期：2022-06-12 10:58:47
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

SQL Server 采集器采集 SQL Server `waitstats`、`database_io` 等相关指标

## 前置条件

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

## 配置

进入 DataKit 安装目录下的 `conf.d/db` 目录，复制 `sqlserver.conf.sample` 并命名为 `sqlserver.conf`。示例如下：

```toml

[[inputs.sqlserver]]
  ## your sqlserver host ,example ip:port
  host = ""

  ## your sqlserver user,password
	## We recommend **use simple password** here, only use [a-zA-Z_0-9], do not
	## use special characters, such as #, @, $, theses characters may cause
	## error on parsing sqlserver connection string.
  user = ""
  password = ""

  ## (optional) collection interval, default is 10s
  interval = "10s"

  # [inputs.sqlserver.log]
  # files = []
  # #grok pipeline script path
  # pipeline = "sqlserver.p"

  [inputs.sqlserver.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"

```

配置好后，重启 DataKit 即可。

## 指标集

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

- 指标列表


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

- 指标列表


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

- 指标列表


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

- 指标列表


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

- 指标列表


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




## 日志采集

如需采集 SQL Server 的日志，可在 sqlserver.conf 中 将 `files` 打开，并写入 SQL Server 日志文件的绝对路径。比如：

```toml
    [[inputs.sqlserver]]
      ...
      [inputs.sqlserver.log]
        files = ["/var/opt/mssql/log/error.log"]
```

  
开启日志采集以后，默认会产生日志来源（`source`）为 `sqlserver` 的日志。

>注意：必须将 DataKit 安装在 SQL Server 所在主机才能采集 SQL Server 日志

## 日志 pipeline 功能切割字段说明

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
