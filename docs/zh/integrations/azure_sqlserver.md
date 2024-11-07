---
title: 'Azure SQL Servers'
tags: 
  - 'AZURE'
summary: '采集 Azure SQL Servers 指标数据'
__int_icon: 'icon/azure_sqlserver'
dashboard:
  - desc: 'Azure SQL Servers 监控视图'
    path: 'dashboard/zh/azure_sqlserver'
---

<!-- markdownlint-disable MD025 -->
# Azure SQL Servers
<!-- markdownlint-enable -->

采集 Azure SQL Servers 指标数据。

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> 推荐部署 GSE 版

### 安装脚本

> 提示：请提前准备好符合要求的 Azure 应用注册信息，并将订阅 `Monitoring Reader`（监视查阅者） 的角色赋予给应用注册

同步 Azure-SQL Server 的监控数据，我们安装对应的采集脚本：「观测云集成（Azure-SQL Server Database 采集）」(ID：`guance_azure_sql_server_database`)

点击【安装】后，输入相应的参数：

- `Azure Tenant ID`：租户 ID
- `Azure Client ID`：应用注册 Client ID
- `Azure Client Secret Value`：客户端密码值，注意不是 ID
- `Subscriptions`：订阅 ID ,多个订阅用`,`分割

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-azure-sql-server-database/){:target="_blank"}

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置 Azure Sql Servers 监控数据后,默认的指标集如下, 可以通过配置的方式采集更多的指标 [Microsoft.Sql/servers/databases 受支持的指标](https://learn.microsoft.com/zh-cn/azure/azure-monitor/reference/supported-metrics/microsoft-sql-servers-databases-metrics){:target="_blank"}

| Metric Name | Description| Unit |
| ---- | ------ | ------ |
|`allocated_data_storage_average`|已分配的数据空间| byte|
|`app_cpu_billed_total`|计费的应用 CPU| count|
|`app_cpu_percent_average`|应用CPU 使用率| %|
|`app_memory_percent_average`|应用内存使用百分比| %|
|`availability_average`|可用性平均值| count|
|`blocked_by_firewall_total`|被防火墙阻止的总数| count|
|`connection_failed_user_error_total`|因用户错误导致连接失败的总数| count|
|`connection_successful_total`|成功连接的总数| count|
|`cpu_limit_average`|CPU限制平均值| count|
|`cpu_percent_average`|CPU使用百分比平均值| %|
|`cpu_used_average`|CPU使用平均值| count|
|`deadlock_total`|死锁总数| count|
|`diff_backup_size_bytes_maximum`|差异备份大小字节最大值| byte|
|`full_backup_size_bytes_maximum`|全备份大小字节最大值| byte|
|`log_backup_size_bytes_maximum`|日志备份大小字节最大值| byte|
|`log_write_percent_average`|日志写入百分比平均值| %|
|`physical_data_read_percent_average`|物理数据读取百分比平均值| %|
|`sessions_count_average`|会话数平均值| count|
|`sessions_percent_average`|会话百分比平均值| %|
|`sql_instance_cpu_percent_maximum`|SQL实例CPU百分比最大值| %|
|`sql_instance_memory_percent_maximum`|SQL实例内存百分比最大值| %|
|`storage_maximum`|已用数据空间| byte|
|`storage_percent_maximum`|已用数据空间百分比| %|
|`workers_percent_average`|工作线程百分比平均值| %|
|`xtp_storage_percent_average`|XTP存储百分比平均值| %|

