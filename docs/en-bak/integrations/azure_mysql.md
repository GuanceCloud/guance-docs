---
title: 'Azure MySQL'
tags:
  - 'AZURE'
summary: 'Collect Azure MySQL metric data'
__int_icon: 'icon/azure_mysql'
dashboard:
  - desc: 'Azure MySQL'
    path: 'dashboard/en/azure_mysql'
monitor   :
  - desc  : 'Azure MySQL'
    path  : 'monitor/en/azure_mysql'
---

Collect Azure MySQL metric data.

## Config {#config}

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> Recommend deploying GSE (Game Server Engine) edition translation.

### Installation script


> Tip: Please prepare the required Azure application registration information in advance and assign the role of subscribing to `Monitoring Reader` to the application registration

To synchronize the monitoring data of Azure Virtual Machines resources, we install the corresponding collection script: `ID:guance_azure_mysql_flexible_server`

After clicking on **Install**, enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application Registration Client ID
- `Azure Client Secret Value`: Client password value, note not ID
- `Subscriptions`: subscription ID, multiple subscriptions used `,` split


tap **Deploy startup Script**，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in "**Management / Crontab Config**". Click "**Run**"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs.



### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Configure Azure Virtual Machines monitoring. The default metric set is as follows. You can collect more metrics by configuring them  [Microsoft.DBforMySQL/flexibleServers](https://learn.microsoft.com/zh-cn/azure/azure-monitor/reference/supported-metrics/microsoft-dbformysql-flexibleservers-metrics){:target="_blank"}

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
| aborted_connections_total | Total number of aborted connections | count |
| active_connections_maximum | Maximum number of active connections | count |
| active_transactions_maximum | Maximum number of active transactions | count |
| available_memory_bytes_average | Average available memory in bytes | byte |
| backup_storage_used_maximum | Maximum backup storage used | count |
| binlog_storage_used_maximum | Maximum binary log storage used | count |
| com_alter_table_total | Total number of ALTER TABLE commands | count |
| com_create_db_total | Total number of CREATE DATABASE commands | count |
| com_create_table_total | Total number of CREATE TABLE commands | count |
| com_delete_total | Total number of DELETE commands | count |
| com_drop_db_total | Total number of DROP DATABASE commands | count |
| com_drop_table_total | Total number of DROP TABLE commands | count |
| com_insert_total | Total number of INSERT commands | count |
| com_select_total | Total number of SELECT commands | count |
| com_update_total | Total number of UPDATE commands | count |
| cpu_credits_consumed_maximum | Maximum CPU credits consumed | count |
| cpu_credits_remaining_maximum | Maximum CPU credits remaining | count |
| cpu_percent_maximum | Maximum CPU utilization percentage | % |
| data_storage_used_maximum | Maximum data storage used | count |
| ibdata_1_storage_used_maximum | Maximum ibdata1 storage used | count |
| innodb_buffer_pool_pages_data_total | Total number of InnoDB buffer pool data pages | count |
| innodb_buffer_pool_pages_dirty_total | Total number of InnoDB buffer pool dirty pages | count |
| innodb_buffer_pool_pages_flushed_average | Average number of InnoDB buffer pool pages flushed | count |
| innodb_buffer_pool_pages_free_total | Total number of InnoDB buffer pool free pages | count |
| innodb_buffer_pool_read_requests_total | Total number of InnoDB buffer pool read requests | count |
| innodb_buffer_pool_reads_total | Total number of InnoDB buffer pool read operations | count |
| innodb_data_writes_total | Total number of InnoDB data writes | count |
| innodb_row_lock_time_average | Average InnoDB row lock wait time | milliseconds |
| innodb_row_lock_waits_maximum | Maximum number of InnoDB row lock waits | count |
| io_consumption_percent_maximum | Maximum I/O consumption percentage | % |
| lock_deadlocks_maximum | Maximum number of deadlocks | count |
| lock_row_lock_waits_maximum | Maximum number of row lock waits | count |
| lock_timeouts_maximum | Maximum number of lock timeouts | count |
| memory_percent_maximum | Maximum memory utilization percentage | % |
| network_bytes_egress_total | Total number of bytes sent out over the network | byte |
| network_bytes_ingress_total | Total number of bytes received over the network | byte |
| others_storage_used_maximum | Maximum usage of other storage | count |
| queries_total | Total number of queries | count |
| serverlog_storage_limit_maximum | Maximum server log storage limit | count |
| serverlog_storage_usage_maximum | Maximum server log storage used | count |
| slow_queries_total | Total number of slow queries | count |
| storage_io_count_total | Total number of storage I/O operations | count |
| storage_limit_maximum | Maximum storage limit | count |
| storage_percent_maximum | Maximum storage utilization percentage | % |
| storage_throttle_count_maximum | Maximum number of storage throttle events | count |
| storage_used_maximum | Maximum storage used | count |
| threads_running_total | Total number of running threads | count |
| total_connections_total | Total number of connections | count |
| trx_rseg_history_len_maximum | Maximum length of the transaction rollback segment history | count |
| uptime_maximum | Maximum uptime | seconds |
