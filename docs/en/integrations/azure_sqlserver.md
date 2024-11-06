---
title: 'Azure SQL Servers'
tags:
  - 'AZURE'
summary: 'Collect Azure SQL Servers metric data'
__int_icon: 'icon/azure_sqlserver'
dashboard:
  - desc: 'Azure SQL Servers'
    path: 'dashboard/en/azure_sqlserver'
---

<!-- markdownlint-disable MD025 -->
# Azure SQL Servers
<!-- markdownlint-enable -->

Collect Azure SQL Servers metric data.

## Config {#config}

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> Recommend deploying GSE (Game Server Engine) edition translation.

### Installation script


> Tip: Please prepare the required Azure application registration information in advance and assign the role of subscribing to `Monitoring Reader` to the application registration

To synchronize the monitoring data of Azure Virtual Machines resources, we install the corresponding collection script ID：`guance_azure_sql_server_database`


After clicking on **Install**, enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application Registration Client ID
- `Azure Client Secret Value`: Client password value, note not ID
- `Subscriptions`: subscription ID, multiple subscriptions used `,` split


tap **Deploy startup Script**，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in "**Management / Crontab Config**". Click "**Run**"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-azure-sql-server-database/){:target="_blank"}



### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Azure Sql Servers monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Microsoft.Sql/servers/databases](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-sql-servers-databases-metrics){:target="_blank"}

| Metric Name | Description| Unit |
| ---- | ------ | ------ |
| allocated_data_storage_average | Average Allocated Data Storage | byte |
| app_cpu_billed_total | Total Billed Application CPU | count |
| app_cpu_percent_average | Average Application CPU Usage Percentage | % |
| app_memory_percent_average | Average Application Memory Usage Percentage | % |
| availability_average | Average Availability | count |
| blocked_by_firewall_total | Total Blocked by Firewall | count |
| connection_failed_user_error_total | Total Connection Failures Due to User Error | count |
| connection_successful_total | Total Successful Connections | count |
| cpu_limit_average | Average CPU Limit | count |
| cpu_percent_average | Average CPU Usage Percentage | % |
| cpu_used_average | Average CPU Usage | count |
| deadlock_total | Total Deadlocks | count |
| diff_backup_size_bytes_maximum | Maximum Differential Backup Size in Bytes | byte |
| full_backup_size_bytes_maximum | Maximum Full Backup Size in Bytes | byte |
| log_backup_size_bytes_maximum | Maximum Log Backup Size in Bytes | byte |
| log_write_percent_average | Average Log Write Percentage | % |
| physical_data_read_percent_average | Average Physical Data Read Percentage | % |
| sessions_count_average | Average Session Count | count |
| sessions_percent_average | Average Session Percentage | % |
| sql_instance_cpu_percent_maximum | Maximum SQL Instance CPU Percentage | % |
| sql_instance_memory_percent_maximum | Maximum SQL Instance Memory Percentage | % |
| storage_maximum | Maximum Used Data Storage | byte |
| storage_percent_maximum | Maximum Used Data Storage Percentage | % |
| workers_percent_average | Average Worker Thread Percentage | % |
| xtp_storage_percent_average | Average XTP Storage Percentage | % |
