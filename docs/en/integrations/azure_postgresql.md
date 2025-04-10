---
title: 'Azure PostgreSQL'
tags: 
  - 'AZURE'
summary: 'Collect Azure PostgreSQL Metrics data'
__int_icon: 'icon/azure_postgresql'
dashboard:
  - desc: 'Azure PostgreSQL'
    path: 'dashboard/en/azure_postgresql'
monitor   :
  - desc  : 'Azure PostgreSQL'
    path  : 'monitor/en/azure_postgresql'
---

Collect Azure PostgreSQL Metrics data

## Configuration {#config}

### Install Func

It is recommended to enable the <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites will be automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare the required Azure application registration information in advance and assign the `Monitoring Reader` role to the application registration.

1. Log in to the Func console, click on 【Script Market】, enter the official script market, and search for `guance_azure_postgresql_flexible_server`
2. After clicking 【Install】, input the corresponding parameters: `Azure Tenant ID`, `Azure Client ID`, `Azure Client Secret Value`, `Subscriptions`
3. Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.
4. After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. Wait a moment, then check the execution task records and corresponding logs.

### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm that the corresponding task has the appropriate automatic trigger configuration. You can also view the task records and logs to check for any anomalies.
2. In <<< custom_key.brand_name >>>, under 「Infrastructure - Resource Catalog」, check if asset information exists.
3. In <<< custom_key.brand_name >>>, under 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}

Collect Azure PostgreSQL Metrics. More metrics can be collected via configuration. Refer to [Microsoft.DBforPostgreSQL/flexibleServers Supported Metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-dbforpostgresql-flexibleservers-metrics){:target="_blank"}

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
|`all_connections_closed_per_second_maximum`| Number of connections closed per second (instance-based) | count |
|`all_connections_created_per_second_maximum`| Number of connections created per second (instance-based) | count |
|`allcache_read_maximum`| Cache reads (instance-based) | bytes/s |
|`allcache_write_maximum`| Cache writes (instance-based) | bytes/s |
|`allcachehits_total`| Cache hits (instance-based) | count |
|`allcachemisses_total`| Cache misses (instance-based) | count |
|`allconnectedclients_maximum`| Number of connected clients | count |
|`allevictedkeys_total`| Number of evicted keys (instance-based) | count |
|`allexpiredkeys_total`| Number of expired keys (instance-based) | count |
|`allgetcommands_total`| Get commands (instance-based) | count |
|`alloperations_per_second_maximum`| Operations per second (instance-based) | count |
|`allpercentprocessortime_maximum`| CPU (instance-based) | %|
|`allserver_load_maximum`| Server load (instance-based) | % |
|`allsetcommands_total`| Set commands (instance-based) | count |
|`alltotalcommandsprocessed_total`| Total commands processed (instance-based) | count |
|`alltotalkeys_maximum`| Total number of keys (instance-based) | count |
|`allusedmemory_maximum`| Used memory (instance-based) | bytes |
|`allusedmemory_rss_maximum`| Used memory RSS (instance-based) | bytes |
|`allusedmemorypercentage_maximum`| Used memory percentage (instance-based) | % |
|`cache_read_maximum`| Cache read volume | bytes/s |
|`cache_write_maximum`| Cache write volume | bytes/s |
|`cachehits_total`| Cache hits | count |
|`cachemisses_total`| Cache misses | bytes |
|`cachemissrate_total`| Cache miss rate | bytes |
|`connected_clients_using_aadtoken_maximum`| Connected clients using Microsoft Entra token (instance-based) | count |
|`connectedclients_maximum`| Connected clients | count |
|`errors_maximum`| Errors | count |
|`evictedkeys_total`| Evicted keys | count |
|`expiredkeys_total`| Expired keys | count |
|`getcommands_total`| Get commands | count |
|`latency_p_99_maximum`| 99th percentile latency | ms |
|`operations_per_second_maximum`| Operations per second | count |
|`percent_processor_time_maximum`| CPU | % |
|`server_load_maximum`| Server load | - |
|`setcommands_total`| Set commands | count |
|`totalcommandsprocessed_total`| Total commands processed | count |
|`usedmemory_rss_maximum`| Used memory RSS | bytes |
|`usedmemorypercentage_maximum`| Used memory percentage | % |