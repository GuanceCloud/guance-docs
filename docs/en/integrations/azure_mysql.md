---
title: 'Azure MySQL'
tags: 
  - 'AZURE'
summary: 'Collect Azure MySQL Metrics data'
__int_icon: 'icon/azure_mysql'
dashboard:
  - desc: 'Azure MySQL monitoring view'
    path: 'dashboard/en/azure_mysql'
monitor   :
  - desc  : 'Azure MySQL detection library'
    path  : 'monitor/en/azure_mysql'
---

Collect Azure MySQL Metrics data.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> We recommend deploying the GSE version.

### Install Script

> Note: Please prepare the required Azure application registration information in advance and assign the `Monitoring Reader` role to the application registration.

To synchronize Azure MySQL monitoring data, we install the corresponding collection script: 「Guance Integration (Azure-DB For MySQL Flexible Server Collection)」(ID: `guance_azure_mysql_flexible_server`)

After clicking 【Install】, enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application Registration Client ID
- `Azure Client Secret Value`: Client secret value, note that it is not the ID
- `Subscriptions`: Subscription ID, multiple subscriptions are separated by `,`

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After starting, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to immediately execute once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and at the same time, you can check the corresponding task records and logs to check for any anomalies.
2. On the Guance platform, in 「Infrastructure / Custom」check if there is asset information.
3. On the Guance platform, in 「Metrics」check if there are corresponding monitoring data.

## Metrics {#metric}

After configuring Azure MySQL monitoring data, the default Measurement set is as follows. You can collect more Metrics through configuration [Microsoft.DBforMySQL/flexibleServers supported Metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-dbformysql-flexibleservers-metrics){:target="_blank"}

| Metric Name | Description| Unit |
| ---- | ------ | ------ |
| aborted_connections_total       | Total number of aborted connections                             | count |
| active_connections_maximum      | Maximum number of active connections                           | count |
| active_transactions_maximum     | Maximum number of active transactions                          | count |
| available_memory_bytes_average  | Average number of available memory bytes                       | byte |
| backup_storage_used_maximum     | Maximum backup storage used                                   | count |
| binlog_storage_used_maximum     | Maximum binary log storage used                               | count |
| com_alter_table_total           | Total number of alter table commands                          | count |
| com_create_db_total             | Total number of create database commands                       | count |
| com_create_table_total          | Total number of create table commands                         | count |
| com_delete_total                | Total number of delete commands                                | count |
| com_drop_db_total               | Total number of drop database commands                         | count |
| com_drop_table_total            | Total number of drop table commands                            | count |
| com_insert_total                | Total number of insert commands                                | count |
| com_select_total                | Total number of select commands                                | count |
| com_update_total                | Total number of update commands                                | count |
| cpu_credits_consumed_maximum    | Maximum CPU credits consumed                                  | count |
| cpu_credits_remaining_maximum   | Maximum remaining CPU credits                                 | count |
| cpu_percent_maximum             | Maximum CPU percentage                                         | byte |
| data_storage_used_maximum       | Maximum data storage used                                     | count |
| ibdata_1_storage_used_maximum   | Maximum ibdata1 storage used                                  | count |
| innodb_buffer_pool_pages_data_total | Total number of InnoDB buffer pool data pages              | count |
| innodb_buffer_pool_pages_dirty_total | Total number of InnoDB buffer pool dirty pages             | count |
| innodb_buffer_pool_pages_flushed_average | Average number of InnoDB buffer pool page flushes        | count |
| innodb_buffer_pool_pages_free_total | Total number of InnoDB buffer pool free pages               | count |
| innodb_buffer_pool_read_requests_total | Total number of InnoDB buffer pool read requests          | count |
| innodb_buffer_pool_reads_total  | Total number of InnoDB buffer pool reads                      | count |
| innodb_data_writes_total        | Total number of InnoDB data writes                           | count |
| innodb_row_lock_time_average    | Average InnoDB row lock wait time                            | milliseconds |
| innodb_row_lock_waits_maximum   | Maximum InnoDB row lock waits                                | count |
| io_consumption_percent_maximum  | Maximum I/O consumption percentage                            | byte |
| lock_deadlocks_maximum          | Maximum deadlocks                                           | count |
| lock_row_lock_waits_maximum     | Maximum row lock waits                                       | count |
| lock_timeouts_maximum           | Maximum lock timeouts                                        | count |
| memory_percent_maximum          | Maximum memory percentage                                    | % |
| network_bytes_egress_total      | Total egress network bytes                                   | byte |
| network_bytes_ingress_total     | Total ingress network bytes                                  | byte |
| others_storage_used_maximum     | Maximum other storage used                                   | count |
| queries_total                   | Total queries                                                | count |
| serverlog_storage_limit_maximum | Maximum server log storage limit                             | count |
| serverlog_storage_usage_maximum | Maximum server log storage usage                             | count |
| slow_queries_total              | Total slow queries                                           | count |
| storage_io_count_total          | Total storage I/O count                                      | count |
| storage_limit_maximum           | Maximum storage limit                                        | count |
| storage_percent_maximum         | Maximum storage percentage                                   | % |
| storage_throttle_count_maximum  | Maximum storage throttle count                               | count |
| storage_used_maximum            | Maximum storage used                                         | count |
| threads_running_total           | Total running threads                                        | count |
| total_connections_total         | Total connections                                            | count |
| trx_rseg_history_len_maximum    | Maximum transaction rollback segment history length            | count |
| uptime_maximum                  | Maximum uptime                                               | seconds |