---
title: 'Azure Redis Cache'
tags: 
  - 'AZURE'
summary: '采集 Azure Redis Cache 指标数据'
__int_icon: 'icon/azure_redis_cache'
dashboard:
  - desc: 'Azure Redis Cache 监控视图'
    path: 'dashboard/zh/azure_redis_cache'
monitor   :
  - desc  : 'Azure Cache Redis 检测库'
    path  : 'monitor/zh/azure_redis_cache'
---

采集 Azure Redis Cache 指标数据

## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的 Azure 应用注册信息，并将订阅 `Monitoring Reader`（监视查阅者） 的角色赋予给应用注册

同步 Azure Redis Cache 的监控数据，我们安装对应的采集脚本：「集成（Azure-Redis Cache 采集）」(ID：`guance_azure_redis`)

点击【安装】后，输入相应的参数：

- `Azure Tenant ID`：租户 ID
- `Azure Client ID`：应用注册 Client ID
- `Azure Client Secret Value`：客户端密码值，注意不是 ID
- `Subscriptions`：订阅 ID ,多个订阅用`,`分割

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 - 资源目录」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}

采集 Azure Redis Cache 指标,可以通过配置的方式采集更多的指标[Microsoft.Cache/redis 支持的指标](https://learn.microsoft.com/zh-cn/azure/azure-monitor/reference/supported-metrics/microsoft-cache-redis-metrics){:target="_blank"}

| 指标名称 | 描述 | 单位 |
| ---- | ------ | ------ |
|`all_connections_closed_per_second_maximum`| 缓存命中每秒关闭的连接数（基于实例） | count |
|`all_connections_created_per_second_maximum`| 缓存命中每秒创建的连接数（基于实例） | count |
|`allcache_read_maximum`| 缓存读取（基于实例） | bytes/s |
|`allcache_write_maximum`| 缓存写入 （基于实例）| bytes/s |
|`allcachehits_total`| 缓存命中数（基于实例） | count |
|`allcachemisses_total`|  缓存未命中数（基于实例） | count |
|`allconnectedclients_maximum`| 连接的客户端数 | count |
|`allevictedkeys_total`| 逐出的密钥数（基于实例） | count |
|`allexpiredkeys_total`| 过期的密钥数（基于实例） | count |
|`allgetcommands_total`| 获取数（基于实例） | count |
|`alloperations_per_second_maximum`| 每秒操作数（基于实例） | count |
|`allpercentprocessortime_maximum`| CPU（基于实例） | %|
|`allserver_load_maximum`| 服务器负载（基于实例） | % |
|`allsetcommands_total`| 设置数（基于实例） | count |
|`alltotalcommandsprocessed_total`| 总操作数（基于实例） | count |
|`alltotalkeys_maximum`| 总密钥数（基于实例） | count |
|`allusedmemory_maximum`| 已用内存（基于实例） | bytes |
|`allusedmemory_rss_maximum`| 已用内存 RSS（基于实例） | bytes |
|`allusedmemorypercentage_maximum`| 已用内存百分比 （基于实例）| % |
|`cache_read_maximum`| 缓存读取量 | bytes/s |
|`cache_write_maximum`| 缓存写入量 | bytes/s |
|`cachehits_total`| 缓存命中数 | count |
|`cachemisses_total`| 缓存未命中数 | bytes |
|`cachemissrate_total`| 缓存未命中率 | bytes |
|`connected_clients_using_aadtoken_maximum`| 使用 Microsoft Entra 令牌（基于实例）的连接客户端 | count |
|`connectedclients_maximum`| 连接的客户端数 | count |
|`errors_maximum`| 错误数 | count |
|`evictedkeys_total`| 逐出的密钥数 | count |
|`expiredkeys_total`| 过期的密钥数 | count |
|`getcommands_total`| 获取数 | count |
|`latency_p_99_maximum`| 第 99 个百分位延迟 | ms |
|`operations_per_second_maximum`| 每秒操作数 | count |
|`percent_processor_time_maximum`| CPU | % |
|`server_load_maximum`| 服务器负载 | - |
|`setcommands_total`| 设置数 | count |
|`totalcommandsprocessed_total`| 总操作数 | count |
|`usedmemory_rss_maximum`| 已用内存 RSS | bytes |
|`usedmemorypercentage_maximum`| 已用内存百分比 | % |
