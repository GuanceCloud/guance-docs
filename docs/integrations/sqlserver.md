
# SQLServer
---

## 视图预览

SQLServer 性能指标展示：CPU，内存，事务，日志，临时表，物理文件 IO，备份，任务调度等

![image](imgs/input-sqlserver-1.png)

![image](imgs/input-sqlserver-2.png)

![image](imgs/input-sqlserver-3.png)

![image](imgs/input-sqlserver-4.png)

![image](imgs/input-sqlserver-5.png)

## 版本支持

操作系统支持：Linux / Windows

## 前置条件

- 服务器 <[安装 DataKit](../datakit/datakit-install.md)>
- 创建监控用户 (Public 权限)

```
USE master;
GO
CREATE LOGIN [user] WITH PASSWORD = N'password';
GO
GRANT VIEW SERVER STATE TO [user];
GO
GRANT VIEW ANY DEFINITION TO [user];
GO
```

## 安装配置

说明：示例 SQLServer 版本为 Microsoft SQL Server 2016 (RTM) - 13.0.1601.5 (X64)

### 部署实施

#### 指标采集 (必选)

1、 开启 DataKit SQLServer 插件，复制 sample 文件

```
进入 C:\Program Files\datakit\conf.d\db
复制 sqlserver.conf.sample 为 sqlserver.conf
```

2、 修改 sqlserver.conf 配置文件

参数说明

- host：服务连接地址
- user：用户名
- password：密码
- interval：数据采集频率
```
[[inputs.sqlserver]]
  host = "host"
  user = "user"
  password = "password"
  interval = "10s"
```

3、 重启 DataKit (如果需要开启日志，请配置日志采集再重启)

```
services.msc 找到 datakit 重新启动
```

指标预览

![image](imgs/input-sqlserver-6.png)

#### 日志采集 (非必选)

参数说明

- files：日志文件路径 (通常填写访问日志和错误日志)
- pipeline：日志切割文件(内置)，实际文件路径 /usr/local/datakit/pipeline/sqlserver.p
- 相关文档 <[DataFlux pipeline 文本数据处理](../datakit/pipeline.md)>

```
[inputs.sqlserver.log]
files = ["C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Log\ERRORLOG"]
pipeline = "sqlserver.p"
```

重启 DataKit (如果需要开启自定义标签，请配置插件标签再重启)

```
systemctl restart datakit
```
#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 sqlserver 指标都会带有 app = oa 的标签，可以进行快速查询
- 相关文档 <[DataFlux Tag 应用最佳实践](../best-practices/insight/tag.md)>
- 
```
# 示例
[inputs.sqlserver.tags]
   app = "oa"
```

重启 DataKit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 内置模板库 - SQLServer 监控视图> 

## 指标详解

**SQLServer**

| 指标 | 描述 | 数据类型 | 单位 |
| --- | --- | --- | --- |
| `cpu_count` | Specifies the number of logical CPUs on the system. Not nullable. | int | count |
| `db_offline` | num of database state in offline | int | count |
| `db_online` | num of database state in online | int | count |
| `db_recovering` | num of database state in recovering | int | count |
| `db_recovery_pending` | num of database state in recovery_pending | int | count |
| `db_restoring` | num of database state in restoring | int | count |
| `db_suspect` | num of database state in suspect | int | count |
| `server_memory` | memory used | int | B |

**SQLServer Performance**

| 指标 | 描述 | 数据类型 | 单位 |
| --- | --- | --- | --- |
| `cntr_value` | Current value of the counter. | int | count |

**SQLServer Waitstats**

| 指标 | 描述 | 数据类型 | 单位 |
| --- | --- | --- | --- |
| `max_wait_time_ms` | Maximum wait time on this wait type. | int | ms |
| `resource_wait_ms` | wait_time_ms-signal_wait_time_ms | int | ms |
| `signal_wait_time_ms` | Difference between the time that the waiting thread was signaled and when it started running | int | ms |
| `wait_time_ms` | Total wait time for this wait type in milliseconds. This time is inclusive of signal_wait_time_ms | int | ms |
| `waiting_tasks_count` | Number of waits on this wait type. This counter is incremented at the start of each wait. | int | count |

**SQLServer Database IO**

| 指标 | 描述 | 数据类型 | 单位 |
| --- | --- | --- | --- |
| `read` | Number of reads issued on the file. | int | count |
| `read_bytes` | Total number of bytes read on this file | int | B |
| `read_latency_ms` | Total time, in milliseconds, that the users waited for reads issued on the file. | int | ms |
| `rg_read_stall_ms` | Does not apply to:: SQL Server 2008 through SQL Server 2012 (11.x).Total IO latency introduced by IO resource governance for reads | int | ms |
| `rg_write_stall_ms` | Does not apply to:: SQL Server 2008 through SQL Server 2012 (11.x).Total IO latency introduced by IO resource governance for writes. Is not nullable. | int | ms |
| `write_bytes` | Number of writes made on this file | int | B |
| `write_latency_ms` | Total time, in milliseconds, that users waited for writes to be completed on the file | int | ms |
| `writes` | Number of writes issued on the file. | int | count |

**SQLServer Schedulers**

| 指标 | 描述 | 数据类型 | 单位 |
| --- | --- | --- | --- |
| `active_workers_count` | Number of workers that are active. An active worker is never preemptive, must have an associated task, and is either running, runnable, or suspended. Is not nullable. | int | count |
| `context_switches_count` | Number of context switches that have occurred on this scheduler | int | count |
| `current_tasks_count` | Number of current tasks that are associated with this scheduler. | int | count |
| `current_workers_count` | Number of workers that are associated with this scheduler. This count includes workers that are not assigned any task. Is not nullable. | int | count |
| `is_idle` | Scheduler is idle. No workers are currently running | bool | - |
| `is_online` | If SQL Server is configured to use only some of the available processors on the server, this configuration can mean that some schedulers are mapped to processors that are not in the affinity mask. If that is the case, this column returns 0. This value means that the scheduler is not being used to process queries or batches. | bool | - |
| `load_factor` | Internal value that indicates the perceived load on this scheduler | int | count |
| `pending_disk_io_count` | Number of pending I/Os that are waiting to be completed. | int | count |
| `preemptive_switches_count` | Number of times that workers on this scheduler have switched to the preemptive mode | int | count |
| `runnable_tasks_count` | Number of workers, with tasks assigned to them, that are waiting to be scheduled on the runnable queue. | int | count |
| `total_cpu_usage_ms` | Applies to: SQL Server 2016 (13.x) and laterTotal CPU consumed by this scheduler as reported by non-preemptive workers. | int | ms |
| `total_scheduler_delay_ms` | Applies to: SQL Server 2016 (13.x) and laterThe time between one worker switching out and another one switching in | int | ms |
| `work_queue_count` | Number of tasks in the pending queue. These tasks are waiting for a worker to pick them up | int | count |
| `yield_count` | Internal value that is used to indicate progress on this scheduler. This value is used by the Scheduler Monitor to determine whether a worker on the scheduler is not yielding to other workers on time. | int | count |

## 常见问题排查

<[无数据上报排查](../datakit/why-no-data.md)>

