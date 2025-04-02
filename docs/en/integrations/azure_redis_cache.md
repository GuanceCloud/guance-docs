---
title: 'Azure Redis Cache'
tags: 
  - 'AZURE'
summary: 'Collect metrics data from Azure Redis Cache'
__int_icon: 'icon/azure_redis_cache'
dashboard:
  - desc: 'Azure Redis Cache monitoring view'
    path: 'dashboard/en/azure_redis_cache'
monitor   :
  - desc  : 'Azure Cache Redis detection library'
    path  : 'monitor/en/azure_redis_cache'
---

Collect metrics data from Azure Redis Cache

## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - hosted Func: all prerequisites are automatically installed, please continue with the script installation

If you deploy Func yourself, refer to [Self-deploy Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare the required Azure application registration information in advance and assign the `Monitoring Reader` role to the application registration.

To synchronize the monitoring data of Azure Redis Cache, we install the corresponding collection script: 「Integration (Azure-Redis Cache Collection)」(ID: `guance_azure_redis`)

After clicking 【Install】, enter the corresponding parameters:

- `Azure Tenant ID`: Tenant ID
- `Azure Client ID`: Application registration Client ID
- `Azure Client Secret Value`: Client secret value, note it is not the ID
- `Subscriptions`: Subscription ID, multiple subscriptions can be separated by `,`

Click 【Deploy Start Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding start script.

After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to immediately execute once without waiting for the scheduled time. After a while, you can check the execution task records and corresponding logs.

### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding task has an automatic trigger configuration, and you can check the corresponding task records and logs to see if there are any abnormalities.
2. In <<< custom_key.brand_name >>>, 「Infrastructure - Resource Catalog」check if asset information exists.
3. In <<< custom_key.brand_name >>>, 「Metrics」check if there are corresponding monitoring data.

## Metrics {#metric}

Collect Azure Redis Cache metrics, you can collect more metrics through configuration [Microsoft.Cache/redis supported metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-cache-redis-metrics){:target="_blank"}

| Metric Name | Description | Unit |
| ---- | ------ | ------ |
|`all_connections_closed_per_second_maximum`| Connections closed per second due to cache hits (instance-based) | count |
|`all_connections_created_per_second_maximum`| Connections created per second due to cache hits (instance-based) | count |
|`allcache_read_maximum`| Cache reads (instance-based) | bytes/s |
|`allcache_write_maximum`| Cache writes (instance-based) | bytes/s |
|`allcachehits_total`| Cache hit count (instance-based) | count |
|`allcachemisses_total`| Cache miss count (instance-based) | count |
|`allconnectedclients_maximum`| Number of connected clients | count |
|`allevictedkeys_total`| Number of evicted keys (instance-based) | count |
|`allexpiredkeys_total`| Number of expired keys (instance-based) | count |
|`allgetcommands_total`| Get command count (instance-based) | count |
|`alloperations_per_second_maximum`| Operations per second (instance-based) | count |
|`allpercentprocessortime_maximum`| CPU (instance-based) | %|
|`allserver_load_maximum`| Server load (instance-based) | % |
|`allsetcommands_total`| Set command count (instance-based) | count |
|`alltotalcommandsprocessed_total`| Total operation count (instance-based) | count |
|`alltotalkeys_maximum`| Total key count (instance-based) | count |
|`allusedmemory_maximum`| Used memory (instance-based) | bytes |
|`allusedmemory_rss_maximum`| Used memory RSS (instance-based) | bytes |
|`allusedmemorypercentage_maximum`| Used memory percentage (instance-based) | % |
|`cache_read_maximum`| Cache read volume | bytes/s |
|`cache_write_maximum`| Cache write volume | bytes/s |
|`cachehits_total`| Cache hit count | count |
|`cachemisses_total`| Cache miss count | bytes |
|`cachemissrate_total`| Cache miss rate | bytes |
|`connected_clients_using_aadtoken_maximum`| Connected clients using Microsoft Entra token (instance-based) | count |
|`connectedclients_maximum`| Number of connected clients | count |
|`errors_maximum`| Error count | count |
|`evictedkeys_total`| Number of evicted keys | count |
|`expiredkeys_total`| Number of expired keys | count |
|`getcommands_total`| Get command count | count |
|`latency_p_99_maximum`| 99th percentile latency | ms |
|`operations_per_second_maximum`| Operations per second | count |
|`percent_processor_time_maximum`| CPU | % |
|`server_load_maximum`| Server load | - |
|`setcommands_total`| Set command count | count |
|`totalcommandsprocessed_total`| Total operation count | count |
|`usedmemory_rss_maximum`| Used memory RSS | bytes |
|`usedmemorypercentage_maximum`| Used memory percentage | % |