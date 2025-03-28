---
title: 'Azure Redis Cache'
tags: 
  - 'AZURE'
summary: 'Collect Azure Redis Cache metric data'
__int_icon: 'icon/azure_redis_cache'
dashboard:
  - desc: 'Azure Redis Cache monitoring view'
    path: 'dashboard/en/azure_redis_cache'
monitor   :
  - desc  : 'Azure Cache Redis detection library'
    path  : 'monitor/en/azure_redis_cache'
---

Collect Azure Redis Cache metric data

## Configuration {#config}

### Install Func

It is recommended to enable the Guance Cloud integration - Extension - Managed Func: all preconditions will be automatically installed. Please continue with the script installation.

If you deploy Func manually, refer to [Manually deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}.

### Install the script

> Note: Please prepare the required Azure application registration information in advance and assign the role of `Monitoring Reader` to the application registration.

To synchronize the monitoring data of Azure Redis Cache, we install the corresponding collection script: `ID: guance_azure_redis`.

After clicking [Install], enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application registration Client ID
- `Azure Client Secret Value`: Client secret value, not the ID
- `Subscriptions`: Subscription ID. Separate multiple subscriptions with a comma.

Click [Deploy the startup script], and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click [Execute] to execute it immediately without waiting for the regular time. Wait a moment, and you can view the execution task records and corresponding logs.

### Verify

1. In 「Management / Automatic Trigger Configuration」, confirm that the corresponding task has an automatic trigger configuration. You can also check the task records and logs for any anomalies.
2. On the Guance Cloud platform, under 「Infrastructure - Resource Catalog」, check if asset information exists.
3. On the Guance Cloud platform, under 「Metrics」, check if the corresponding monitoring data is available.

## Metrics {#metric}

Collect Azure Redis Cache metrics. You can collect more metrics through configuration. [Supported metrics for Microsoft.Cache/redis](https://learn.microsoft.com/zh-cn/azure/azure-monitor/reference/supported-metrics/microsoft-cache-redis-metrics){:target="_blank"}

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
|`all_connections_closed_per_second_maximum`| Maximum number of connections closed per second for cache hits (instance-based) | count |
|`all_connections_created_per_second_maximum`| Maximum number of connections created per second for cache hits (instance-based) | count |
|`allcache_read_maximum`| Cache read (instance-based) | bytes/s |
|`allcache_write_maximum`| Cache write (instance-based) | bytes/s |
|`allcachehits_total`| Total number of cache hits (instance-based) | count |
|`allcachemisses_total`| Total number of cache misses (instance-based) | count |
|`allconnectedclients_maximum`| Maximum number of connected clients | count |
|`allevictedkeys_total`| Total number of evicted keys (instance-based) | count |
|`allexpiredkeys_total`| Total number of expired keys (instance-based) | count |
|`allgetcommands_total`| Total number of GET commands (instance-based) | count |
|`alloperations_per_second_maximum`| Maximum number of operations per second (instance-based) | count |
|`allpercentprocessortime_maximum`| CPU usage (instance-based) | %|
|`allserver_load_maximum`| Server load (instance-based) | % |
|`allsetcommands_total`| Total number of SET commands (instance-based) | count |
|`alltotalcommandsprocessed_total`| Total number of commands processed (instance-based) | count |
|`alltotalkeys_maximum`| Maximum number of total keys (instance-based) | count |
|`allusedmemory_maximum`| Maximum used memory (instance-based) | bytes |
|`allusedmemory_rss_maximum`| Maximum used memory RSS (instance-based) | bytes |
|`allusedmemorypercentage_maximum`| Maximum percentage of used memory (instance-based) | % |
|`cache_read_maximum`| Maximum cache read volume | bytes/s |
|`cache_write_maximum`| Maximum cache write volume | bytes/s |
|`cachehits_total`| Total number of cache hits | count |
|`cachemisses_total`| Total number of cache misses | bytes |
|`cachemissrate_total`| Total cache miss rate | bytes |
|`connected_clients_using_aadtoken_maximum`| Maximum number of connected clients using Microsoft Entra tokens (instance-based) | count |
|`connectedclients_maximum`| Maximum number of connected clients | count |
|`errors_maximum`| Maximum number of errors | count |
|`evictedkeys_total`| Total number of evicted keys | count |
|`expiredkeys_total`| Total number of expired keys | count |
|`getcommands_total`| Total number of GET commands | count |
|`latency_p_99_maximum`| Maximum 99th percentile latency | ms |
|`operations_per_second_maximum`| Maximum number of operations per second | count |
|`percent_processor_time_maximum`| CPU usage | % |
|`server_load_maximum`| Server load | - |
|`setcommands_total`| Total number of SET commands | count |
|`totalcommandsprocessed_total`| Total number of commands processed | count |
|`usedmemory_rss_maximum`| Maximum used memory RSS | bytes |
|`usedmemorypercentage_maximum`| Maximum percentage of used memory | % |
