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

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> We recommend deploying the GSE version.

### Installation Script

> Note: Please prepare the required Azure application registration information in advance and assign the `Monitoring Reader` role to the application registration.

To synchronize Azure-SQL Server monitoring data, we install the corresponding collection script: 「Guance Integration (Azure-SQL Server Database Collection)」(ID: `guance_azure_sql_server_database`)

After clicking 【Install】, enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application registration Client ID
- `Azure Client Secret Value`: Client secret value, note it is not the ID
- `Subscriptions`: Subscription ID, multiple subscriptions can be separated by `,`

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup scripts.

After starting, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

We collect some configurations by default; for more details, see the Metrics section.

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-azure-sql-server-database/){:target="_blank"}

### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and at the same time, you can check the corresponding task records and logs to see if there are any abnormalities.
2. On the Guance platform, under 「Infrastructure / Custom」check if there is asset information.
3. On the Guance platform, under 「Metrics」check if there are corresponding monitoring data.

## Metrics {#metric}

After configuring Azure Sql Servers monitoring data, the default metric set is as follows. You can collect more metrics through configuration [Microsoft.Sql/servers/databases supported metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-sql-servers-databases-metrics){:target="_blank"}

| Metric Name | Description| Unit |
| ---- | ------ | ------ |
|`allocated_data_storage_average`|Allocated data space| byte|
|`app_cpu_billed_total`|Billed application CPU| count|
|`app_cpu_percent_average`|Application CPU usage| %|
|`app_memory_percent_average`|Application memory usage percentage| %|
|`availability_average`|Availability average| count|
|`blocked_by_firewall_total`|Total number blocked by firewall| count|
|`connection_failed_user_error_total`|Total connection failures due to user error| count|
|`connection_successful_total`|Total successful connections| count|
|`cpu_limit_average`|CPU limit average| count|
|`cpu_percent_average`|CPU usage percentage average| %|
|`cpu_used_average`|Average CPU usage| count|
|`deadlock_total`|Total deadlocks| count|
|`diff_backup_size_bytes_maximum`|Maximum differential backup size in bytes| byte|
|`full_backup_size_bytes_maximum`|Maximum full backup size in bytes| byte|
|`log_backup_size_bytes_maximum`|Maximum log backup size in bytes| byte|
|`log_write_percent_average`|Log write percentage average| %|
|`physical_data_read_percent_average`|Physical data read percentage average| %|
|`sessions_count_average`|Average session count| count|
|`sessions_percent_average`|Average session percentage| %|
|`sql_instance_cpu_percent_maximum`|Maximum SQL instance CPU percentage| %|
|`sql_instance_memory_percent_maximum`|Maximum SQL instance memory percentage| %|
|`storage_maximum`|Used data space| byte|
|`storage_percent_maximum`|Used data space percentage| %|
|`workers_percent_average`|Average worker thread percentage| %|
|`xtp_storage_percent_average`|XTP storage percentage average| %|