---
title: 'Azure MySQL'
tags: 
  - 'AZURE'
summary: '采集 Azure MySQL 指标数据'
__int_icon: 'icon/azure_mysql'
dashboard:
  - desc: 'Azure MySQL 监控视图'
    path: 'dashboard/zh/azure_mysql'
monitor   :
  - desc  : 'Azure MySQL 检测库'
    path  : 'monitor/zh/azure_mysql'
---

采集 Azure MySQL 指标数据。

## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

> 推荐部署 GSE 版

### 安装脚本

> 提示：请提前准备好符合要求的 Azure 应用注册信息，并将订阅 `Monitoring Reader`（监视查阅者） 的角色赋予给应用注册

同步 Azure MySQL 的监控数据，我们安装对应的采集脚本：「<<< custom_key.brand_name >>>集成（Azure-DB For MySQL Flexible Server 采集）」(ID：`guance_azure_mysql_flexible_server`)

点击【安装】后，输入相应的参数：

- `Azure Tenant ID`：租户 ID
- `Azure Client ID`：应用注册 Client ID
- `Azure Client Secret Value`：客户端密码值，注意不是 ID
- `Subscriptions`：订阅 ID ,多个订阅用`,`分割

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置 Azure MySQL 监控数据后,默认的指标集如下, 可以通过配置的方式采集更多的指标 [Microsoft.DBforMySQL/flexibleServers 受支持的指标](https://learn.microsoft.com/zh-cn/azure/azure-monitor/reference/supported-metrics/microsoft-dbformysql-flexibleservers-metrics){:target="_blank"}

| Metric Name | Description| Unit |
| ---- | ------ | ------ |
| aborted_connections_total       | 中断连接总数                             | count |
| active_connections_maximum      | 最大活动连接数                           | count |
| active_transactions_maximum     | 最大活动事务数                           | count |
| available_memory_bytes_average  | 平均可用内存字节数                       | byte |
| backup_storage_used_maximum     | 最大备份存储使用量                       | count |
| binlog_storage_used_maximum     | 最大二进制日志存储使用量                 | count |
| com_alter_table_total           | 修改表命令总数                           | count |
| com_create_db_total             | 创建数据库命令总数                       | count |
| com_create_table_total          | 创建表命令总数                           | count |
| com_delete_total                | 删除命令总数                             | count |
| com_drop_db_total               | 删除数据库命令总数                       | count |
| com_drop_table_total            | 删除表命令总数                           | count |
| com_insert_total                | 插入命令总数                             | count |
| com_select_total                | 选择命令总数                             | count |
| com_update_total                | 更新命令总数                             | count |
| cpu_credits_consumed_maximum    | 最大已使用 CPU 积分                        | count |
| cpu_credits_remaining_maximum   | 最大剩余 CPU 积分                          | count |
| cpu_percent_maximum             | 最大CPU百分比                            | byte |
| data_storage_used_maximum       | 最大数据存储使用量                       | count |
| ibdata_1_storage_used_maximum   | 最大 ibdata1 存储使用量                    | count |
| innodb_buffer_pool_pages_data_total | InnoDB 缓冲池数据页总数                   | count |
| innodb_buffer_pool_pages_dirty_total | InnoDB 缓冲池脏页总数                     | count |
| innodb_buffer_pool_pages_flushed_average | InnoDB 缓冲池页刷新平均数                 | count |
| innodb_buffer_pool_pages_free_total | InnoDB 缓冲池空闲页总数                   | count |
| innodb_buffer_pool_read_requests_total | InnoDB 缓冲池读请求总数                   | count |
| innodb_buffer_pool_reads_total  | InnoDB 缓冲池读操作总数                   | count |
| innodb_data_writes_total        | InnoDB 数据写入总数                      | count |
| innodb_row_lock_time_average    | InnoDB行锁等待时间平均数                 | 毫秒 |
| innodb_row_lock_waits_maximum   | 最大 InnoDB 行锁等待次数                   | count |
| io_consumption_percent_maximum  | 最大 I/O 消耗百分比                        | byte |
| lock_deadlocks_maximum          | 最大死锁次数                             | count |
| lock_row_lock_waits_maximum     | 最大行锁等待次数                         | count |
| lock_timeouts_maximum           | 最大锁超时次数                           | count |
| memory_percent_maximum          | 最大内存百分比                           | % |
| network_bytes_egress_total      | 总传出网络字节数                         | byte |
| network_bytes_ingress_total     | 总传入网络字节数                         | byte |
| others_storage_used_maximum     | 其他存储最大使用量                       | count |
| queries_total                   | 总查询数                                 | count |
| serverlog_storage_limit_maximum | 最大服务器日志存储限制                   | count |
| serverlog_storage_usage_maximum | 最大服务器日志存储使用量                 | count |
| slow_queries_total              | 慢查询总数                               | count |
| storage_io_count_total          | 总存储I/O计数                            | count |
| storage_limit_maximum           | 最大存储限制                             | count |
| storage_percent_maximum         | 最大存储百分比                           | % |
| storage_throttle_count_maximum  | 最大存储限制计数                         | count |
| storage_used_maximum            | 最大存储使用量                           | count |
| threads_running_total           | 总运行线程数                             | count |
| total_connections_total         | 总连接数                                 | count |
| trx_rseg_history_len_maximum    | 最大事务回滚段历史长度                   | count |
| uptime_maximum                  | 最大运行时间                             | 秒 |
