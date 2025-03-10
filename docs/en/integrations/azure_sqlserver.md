---
title: 'Azure SQL Servers'
tags: 
  - 'AZURE'
summary: 'Collect metrics data from Azure SQL Servers'
__int_icon: 'icon/azure_sqlserver'
dashboard:
  - desc: 'Azure SQL Servers monitoring view'
    path: 'dashboard/en/azure_sqlserver'
---

<!-- markdownlint-disable MD025 -->
# Azure SQL Servers
<!-- markdownlint-enable -->

Collect metrics data from Azure SQL Servers.

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> It is recommended to deploy the GSE version.

### Install Script

> Note: Please prepare the required Azure application registration information in advance and assign the `Monitoring Reader` role to the application registration.

To synchronize Azure-SQL Server monitoring data, we install the corresponding collection script: 「Guance Integration (Azure-SQL Server Database Collection)」(ID: `guance_azure_sql_server_database`)

After clicking 【Install】, enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application Registration Client ID
- `Azure Client Secret Value`: Client secret value, not the ID
- `Subscriptions`: Subscription ID, multiple subscriptions are separated by `,`

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

We have collected some configurations by default; for more details, see the Metrics section.

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-azure-sql-server-database/){:target="_blank"}

### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm that the corresponding tasks have the automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」, check if there is asset information.
3. On the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}

After configuring Azure SQL Servers monitoring data, the default metric set is as follows. More metrics can be collected through configuration. [Supported metrics for Microsoft.Sql/servers/databases](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-sql-servers-databases-metrics){:target="_blank"}

| Metric Name | Description| Unit |
| ---- | ------ | ------ |
|`allocated_data_storage_average`|Allocated data space| byte|
|`app_cpu_billed_total`|Billed application CPU| count|
|`app_cpu_percent_average`|Application CPU usage| %|
|`app_memory_percent_average`|Application memory usage percentage| %|
|`availability_average`|Average availability| count|
|`blocked_by_firewall_total`|Total number blocked by firewall| count|
|`connection_failed_user_error_total`|Total number of connection failures due to user error| count|
|`connection_successful_total`|Total number of successful connections| count|
|`cpu_limit_average`|Average CPU limit| count|
|`cpu_percent_average`|Average CPU usage percentage| %|
|`cpu_used_average`|Average CPU usage| count|
|`deadlock_total`|Total number of deadlocks| count|
|`diff_backup_size_bytes_maximum`|Maximum differential backup size in bytes| byte|
|`full_backup_size_bytes_maximum`|Maximum full backup size in bytes| byte|
|`log_backup_size_bytes_maximum`|Maximum log backup size in bytes| byte|
|`log_write_percent_average`|Average log write percentage| %|
|`physical_data_read_percent_average`|Average physical data read percentage| %|
|`sessions_count_average`|Average session count| count|
|`sessions_percent_average`|Average session percentage| %|
|`sql_instance_cpu_percent_maximum`|Maximum SQL instance CPU percentage| %|
|`sql_instance_memory_percent_maximum`|Maximum SQL instance memory percentage| %|
|`storage_maximum`|Used data space| byte|
|`storage_percent_maximum`|Used data space percentage| %|
|`workers_percent_average`|Average worker thread percentage| %|
|`xtp_storage_percent_average`|Average XTP storage percentage| %|