---
title: '华为云 DCS'
tags: 
  - 华为云
summary: '采集华为云 DCS 指标数据'
__int_icon: 'icon/huawei_dcs'
dashboard:

  - desc: '华为云 DCS 内置视图'
    path: 'dashboard/zh/huawei_dcs'

monitor:
  - desc: '华为云 DCS 监控器'
    path: 'monitor/zh/huawei_dcs'

---

采集华为云 DCS 指标数据

## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步华为云 DCS 的监控数据，我们安装对应的采集脚本:

- **guance_huaweicloud_dcs**: 采集华为云 DCS 指标数据
- **guance_huaweicloud_dcs_slowlog**：采集华为云 DCS 慢日志数据

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在 Func 中「开发」里找到脚本「{{{ custom_key.brand_name }}}集成（华为云-DCS采集）」/「{{{ custom_key.brand_name }}}集成 (华为云-DCS慢查询日志采集) 」，展开修改脚本，找 collector_configs 和 monitor_configs 分别编辑下面 region_projects 中的内容，将地域和 Project ID,更改为实际的地域和 Project ID，再点击保存发布。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据
4. 在{{{ custom_key.brand_name }}}平台，「日志」查看是否有对应日志数据

## 指标 {#metric}

配置华为云 DCS 监控指标，可以通过配置的方式采集更多的指标 [华为云 DCS 指标详情](https://support.huaweicloud.com/usermanual-dcs/dcs-ug-0713011.html){:target="_blank"}

### Redis 3.0实例监控指标

![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/china/zh-cn/support/resource/framework/v3/images/support-doc-new-note.svg){:target="_blank"}说明：

- DCS Redis 3.0已下线，暂停售卖，建议使用Redis 4.0及以上版本。
- 监控指标的维度请参考[维度](https://support.huaweicloud.com/usermanual-dcs/dcs-ug-0713011.html#dcs-ug-0713011__section10507421184117){:target="_blank"}。

| 指标ID                       | 指标名称             | 指标含义                                                     | 取值范围                   | 测量对象                    | 监控周期（原始指标） |
| ---------------------------- | -------------------- | ------------------------------------------------------------ | -------------------------- | --------------------------- | -------------------- |
| `cpu_usage`                  | CPU利用率            | 该指标对于统计周期内的测量对象的CPU使用率进行多次采样，表示多次采样的最高值。单位：%。如果是单机/主备实例，该指标为主节点的CPU值。如果是Proxy集群实例，该指标为各个Proxy节点的平均值。 | 0-100%                     | Redis实例（单机/主备/集群） | 1分钟                |
| `memory_usage`               | 内存利用率           | 该指标用于统计测量对象的内存利用率。单位：%。**须知：**内存利用率统计是扣除预留内存的。 | 0-100%                     | Redis实例（单机/主备/集群） | 1分钟                |
| `net_in_throughput`          | 网络输入吞吐量       | 该指标用于统计网口平均每秒的输入流量。单位：byte/s。         | >=0字节/秒                 | Redis实例（单机/主备/集群） | 1分钟                |
| `net_out_throughput`         | 网络输出吞吐量       | 该指标用于统计网口平均每秒的输出流量。单位：byte/s。         | >=0字节/秒                 | Redis实例（单机/主备/集群） | 1分钟                |
| `connected_clients`          | 活跃的客户端数量     | 该指标用于统计已连接的客户端数量，包括系统监控、配置同步和业务相关的连接数，不包括来自从节点的连接。 | >=0                        | Redis实例（单机/主备/集群） | 1分钟                |
| `client_longest_out_list`    | 客户端最长输出列表   | 该指标用于统计客户端所有现存连接的最长输出列表。             | >=0                        | Redis实例（单机/主备/集群） | 1分钟                |
| `client_biggest_in_buf`      | 客户端最大输入缓冲   | 该指标用于统计客户端所有现存连接的最大输入数据长度。单位：byte。 | >=0byte                    | Redis实例（单机/主备/集群） | 1分钟                |
| `blocked_clients`            | 阻塞的客户端数量     | 该指标用于被阻塞操作挂起的客户端的数量。阻塞操作如**BLPOP**，**BRPOP**，**BRPOPLPUSH**。 | >=0                        | Redis实例（单机/主备/集群） | 1分钟                |
| `used_memory`                | 已用内存             | 该指标用于统计Redis已使用的内存字节数。单位：byte。          | >=0byte                    | Redis实例（单机/主备/集群） | 1分钟                |
| `used_memory_rss`            | 已用内存RSS          | 该指标用于统计Redis已使用的RSS内存。即实际驻留“在内存中”的内存数。包含堆内存，但不包括换出的内存。单位：byte。 | >=0byte                    | Redis实例（单机/主备/集群） | 1分钟                |
| `used_memory_peak`           | 已用内存峰值         | 该指标用于统计Redis服务器启动以来使用内存的峰值。单位：byte。 | >=0byte                    | Redis实例（单机/主备/集群） | 1分钟                |
| `used_memory_lua`            | Lua已用内存          | 该指标用于统计Lua引擎已使用的内存字节。单位：byte。          | >=0byte                    | Redis实例（单机/主备/集群） | 1分钟                |
| `memory_frag_ratio`          | 内存碎片率           | 该指标用于统计当前的内存碎片率。其数值上等于used_memory_rss / used_memory。 | >=0                        | Redis实例（单机/主备/集群） | 1分钟                |
| `total_connections_received` | 新建连接数           | 该指标用于统计周期内新建的连接数。                           | >=0                        | Redis实例（单机/主备/集群） | 1分钟                |
| `total_commands_processed`   | 处理的命令数         | 该指标用于统计周期内处理的命令数。                           | >=0                        | Redis实例（单机/主备/集群） | 1分钟                |
| `instantaneous_ops`          | 每秒并发操作数       | 该指标用于统计每秒处理的命令数。                             | >=0                        | Redis实例（单机/主备/集群） | 1分钟                |
| `total_net_input_bytes`      | 网络收到字节数       | 该指标用于统计周期内收到的字节数。单位：byte。               | >=0byte                    | Redis实例（单机/主备/集群） | 1分钟                |
| `total_net_output_bytes`     | 网络发送字节数       | 该指标用于统计周期内发送的字节数。单位：byte。               | >=0byte                    | Redis实例（单机/主备/集群） | 1分钟                |
| `instantaneous_input_kbps`   | 网络瞬时输入流量     | 该指标用于统计瞬时的输入流量。单位：KB/s。                   | >=0KB/s                    | Redis实例（单机/主备/集群） | 1分钟                |
| `instantaneous_output_kbps`  | 网络瞬时输出流量     | 该指标用于统计瞬时的输出流量。单位：KB/s。                   | >=0KB/s                    | Redis实例（单机/主备/集群） | 1分钟                |
| `rejected_connections`       | 已拒绝的连接数       | 该指标用于统计周期内因为超过**maxclients**而拒绝的连接数量。 | >=0                        | Redis实例（单机/主备/集群） | 1分钟                |
| `expired_keys`               | 已过期的键数量       | 该指标用于统计周期内因过期而被删除的键数量                   | >=0                        | Redis实例（单机/主备/集群） | 1分钟                |
| `evicted_keys`               | 已逐出的键数量       | 该指标用于统计周期内因为内存不足被删除的键数量。             | >=0                        | Redis实例（单机/主备/集群） | 1分钟                |
| `keyspace_hits`              | **Keyspace**命中次数 | 该指标用于统计周期内在主字典中查找命中次数。                 | >=0                        | Redis实例（单机/主备/集群） | 1分钟                |
| `keyspace_misses`            | **Keyspace**错过次数 | 该指标用于统计周期内在主字典中查找不命中次数。               | >=0                        | Redis实例（单机/主备/集群） | 1分钟                |
| `pubsub_channels`            | Pubsub通道个数       | 该指标用于统计Pub/Sub通道个数。                              | >=0                        | Redis实例（单机/主备/集群） | 1分钟                |
| `pubsub_patterns`            | Pubsub模式个数       | 该指标用于统计Pub/Sub模式个数。                              | >=0                        | Redis实例（单机/主备/集群） | 1分钟                |
| `keyspace_hits_perc`         | 缓存命中率           | 该指标用于统计Redis的缓存命中率，其命中率算法为：`keyspace_hits/(keyspace_hits+keyspace_misses)`单位：%。 | 0-100%                     | Redis实例（单机/主备/集群） | 1分钟                |
| `command_max_delay`          | 命令最大时延         | 统计实例的命令最大时延。单位：ms。                           | >=0ms                      | Redis实例（单机/主备/集群） | 1分钟                |
| `auth_errors`                | 认证失败次数         | 统计实例的认证失败次数。                                     | >=0                        | Redis实例（单机/主备）      | 1分钟                |
| `is_slow_log_exist`          | 是否存在慢日志       | 统计实例是否存在慢日志。![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**说明：**该监控不统计由`migrate、slaveof、config、bgsave、bgrewriteaof`命令导致的慢日志。 | 1：表示存在0：表示不存在。 | Redis实例（单机/主备）      | 1分钟                |
| `keys`                       | 缓存键总数           | 该指标用于统计Redis缓存中键总数。                            | >=0                        | Redis实例（单机/主备）      | 1分钟                |

### Redis 4.0、Redis 5.0 和 Redis 6.0 实例监控指标

![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/china/zh-cn/support/resource/framework/v3/images/support-doc-new-note.svg){:target="_blank"}说明：

- 监控指标的维度请参考[维度](https://support.huaweicloud.com/usermanual-dcs/dcs-ug-0713011.html#dcs-ug-0713011__section10507421184117){:target="_blank"}。
- 实例监控是对主节点数据汇总后的监控。
- 部分实例监控指标，是对从主节点和从节点汇聚的指标，请参考[表3](https://support.huaweicloud.com/usermanual-dcs/dcs-ug-0713011.html#dcs-ug-0713011__table1496722055110){:target="_blank"}中“指标含义”的说明。



| 指标ID                       | 指标名称             | 指标含义                                                     | 取值范围                   | 测量对象                        | 监控周期（原始指标） |
| ---------------------------- | -------------------- | ------------------------------------------------------------ | -------------------------- | ------------------------------- | -------------------- |
| `cpu_usage`                  | CPU利用率            | 该指标对于统计周期内的测量对象的CPU使用率进行多次采样，表示多次采样的最高值。单位：%。 | 0-100%                     | Redis实例（单机/主备/读写分离） | 1分钟                |
| `cpu_avg_usage`              | CPU平均使用率        | 该指标对于统计周期内的测量对象的CPU使用率进行多次采样，表示多次采样的平均值。单位：%。 | 0-100%                     | Redis实例（单机/主备/读写分离） | 1分钟                |
| `command_max_delay`          | 命令最大时延         | 统计实例的命令最大时延。单位为ms。                           | >=0ms                      | Redis实例                       | 1分钟                |
| `total_connections_received` | 新建连接数           | 该指标用于统计周期内新建的连接数。                           | >=0                        | Redis实例                       | 1分钟                |
| `is_slow_log_exist`          | 是否存在慢日志       | 统计实例是否存在慢日志。![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**说明：**该监控不统计由`migrate、slaveof、config、bgsave、bgrewriteaof`命令导致的慢日志。 | 1：表示存在0：表示不存在。 | Redis实例                       | 1分钟                |
| `memory_usage`               | 内存利用率           | 该指标用于统计测量对象的内存利用率。单位：%。                | 0-100%                     | Redis实例                       | 1分钟                |
| `expires`                    | 有过期时间的键总数   | 该指标用于统计Redis缓存中将会过期失效的键数目。              | >=0                        | Redis实例                       | 1分钟                |
| `keyspace_hits_perc`         | 缓存命中率           | 该指标用于统计Redis的缓存命中率，其命中率算法为：`_hits/(keyspace_hits+keyspace_misses)`从主节点和从节点汇聚的指标。单位：%。 | 0-100%                     | Redis实例                       | 1分钟                |
| `used_memory`                | 已用内存             | 该指标用于统计Redis已使用的内存字节数。单位：可在控制台进行选择，如KB、MB、byte等。 | >=0                        | Redis实例                       | 1分钟                |
| `used_memory_dataset`        | 数据集使用内存       | 该指标用于统计Redis中数据集使用的内存。单位：可在控制台进行选择，如KB、MB、byte等。 | >=0                        | Redis实例                       | 1分钟                |
| `used_memory_dataset_perc`   | 数据集使用内存百分比 | 该指标用于统计Redis中数据集使用的内存所占总内存百分比。从主节点和从节点汇聚的指标。单位：%。 | 0-100%                     | Redis实例                       | 1分钟                |
| `used_memory_rss`            | 已用内存RSS          | 该指标用于统计Redis已使用的RSS内存。即实际驻留“在内存中”的内存数。包含堆内存，但不包括换出的内存。单位：可在控制台进行选择，如KB、MB、byte等。 | >=0                        | Redis实例                       | 1分钟                |
| `instantaneous_ops`          | 每秒并发操作数       | 该指标用于统计每秒处理的命令数。                             | >=0                        | Redis实例                       | 1分钟                |
| `keyspace_misses`            | **Keyspace**错过次数 | 该指标用于统计周期内在主字典中查找不命中次数。从主节点和从节点汇聚的指标。 | >=0                        | Redis实例                       | 1分钟                |
| `keys`                       | 缓存键总数           | 该指标用于统计Redis缓存中键总数。                            | >=0                        | Redis实例                       | 1分钟                |
| `blocked_clients`            | 阻塞的客户端数量     | 该指标用于被阻塞操作挂起的客户端的数量。                     | >=0                        | Redis实例                       | 1分钟                |
| `connected_clients`          | 活跃的客户端数量     | 该指标用于统计已连接的客户端数量，包括系统监控、配置同步和业务相关的连接数，不包括来自从节点的连接。 | >=0                        | Redis实例                       | 1分钟                |
| `del`                        | DEL                  | 该指标用于统计平均每秒del操作数。单位：Count/s               | 0-500000 Count/s           | Redis实例                       | 1分钟                |
| `evicted_keys`               | 已逐出的键数量       | 该指标用于统计周期内因为内存不足被删除的键数量。从主节点和从节点汇聚的命令统计指标。 | >=0                        | Redis实例                       | 1分钟                |
| `expire`                     | **EXPIRE**           | 该指标用于统计平均每秒**expire**操作数。单位：Count/s        | 0-500000 Count/s           | Redis实例                       | 1分钟                |
| `expired_keys`               | 已过期的键数量       | 该指标用于统计周期内因过期而被删除的键数量。从主节点和从节点汇聚的命令统计指标。 | >=0                        | Redis实例                       | 1分钟                |
| `get`                        | **GET**              | 该指标用于统计平均每秒get操作数。从主节点和从节点汇聚的命令统计指标。单位：Count/s | 0-500000 Count/s           | Redis实例                       | 1分钟                |
| `hdel`                       | **HDEL**             | 该指标用于统计平均每秒**hdel**操作数。单位：Count/s          | 0-500000 Count/s           | Redis实例                       | 1分钟                |
| `hget`                       | **HGET**             | 该指标用于统计平均每秒**hget**操作数。从主节点和从节点汇聚的命令统计指标。单位：Count/s | 0-500000 Count/s           | Redis实例                       | 1分钟                |
| `hmget`                      | **HMGET**            | 该指标用于统计平均每秒**hmget**操作数。从主节点和从节点汇聚的命令统计指标。单位：Count/s | 0-500000 Count/s           | Redis实例                       | 1分钟                |
| `hmset`                      | **HMSET**            | 该指标用于统计平均每秒**hmset**操作数。单位：Count/s         | 0-500000 Count/s           | Redis实例                       | 1分钟                |
| `hset`                       | **HSET**             | 该指标用于统计平均每秒**hset**操作数。单位：Count/s          | 0-500000 Count/s           | Redis实例                       | 1分钟                |
| `instantaneous_input_kbps`   | 网络瞬时输入流量     | 该指标用于统计瞬时的输入流量。单位：KB/s。                   | >=0KB/s                    | Redis实例                       | 1分钟                |
| `instantaneous_output_kbps`  | 网络瞬时输出流量     | 该指标用于统计瞬时的输出流量。单位：KB/s。                   | >=0KB/s                    | Redis实例                       | 1分钟                |
| `memory_frag_ratio`          | 内存碎片率           | 该指标用于统计当前的内存碎片率                               | >=0                        | Redis实例                       | 1分钟                |
| `mget`                       | **MGET**             | 该指标用于统计平均每秒**mget**操作数。从主节点和从节点汇聚的命令统计指标。单位：Count/s | 0-500000 Count/s           | Redis实例                       | 1分钟                |
| `mset`                       | **MSET**             | 该指标用于统计平均每秒**mset**操作数。单位：Count/s          | 0-500000 Count/s           | Redis实例                       | 1分钟                |
| `pubsub_channels`            | Pubsub通道个数       | 该指标用于统计Pub/Sub通道个数。                              | >=0                        | Redis实例                       | 1分钟                |
| `pubsub_patterns`            | Pubsub模式个数       | 该指标用于统计Pub/Sub模式个数。                              | >=0                        | Redis实例                       | 1分钟                |
| `set`                        | SET                  | 该指标用于统计平均每秒set操作数。单位：Count/s               | 0-500000 Count/s           | Redis实例                       | 1分钟                |
| `used_memory_lua`            | Lua已用内存          | 该指标用于统计Lua引擎已使用的内存字节。单位：可在控制台进行选择，如KB、MB、byte等。 | >=0                        | Redis实例                       | 1分钟                |
| `used_memory_peak`           | 已用内存峰值         | 该指标用于统计Redis服务器启动以来使用内存的峰值。单位：可在控制台进行选择，如KB、MB、byte等。 | >=0                        | Redis实例                       | 1分钟                |
| `sadd`                       | **Sadd**             | 该指标用于统计平均每秒**sadd**操作数。单位：Count/s          | 0-500000 Count/s           | Redis实例                       | 1分钟                |
| `smembers`                   | **Smembers**         | 该指标用于统计平均每秒**smembers**操作数。从主节点和从节点汇聚的命令统计指标。单位：Count/s | 0-500000 Count/s           | Redis实例                       | 1分钟                |
| `setex`                      | **SETEX**            | 每秒**setex**操作数。单位：Count/s                           | 0-500000 Count/s           | Redis实例                       | 1分钟                |
| `rx_controlled`              | 流控次数             | 该指标用于统计周期内被流控的次数。这个指标值大于0时，表示当前被使用带宽超过最大带宽限制被流控。单位：Count。 | >=0                        | Redis实例                       | 1分钟                |
| `bandwidth_usage`            | 带宽使用率           | 计算当前流量带宽与最大带宽限制的百分比。                     | 0-200%                     | Redis实例                       | 1分钟                |
| `command_max_rt`             | 最大时延             | 节点从接收命令到发出响应的时延最大值。单位：us。             | >=0us                      | Redis实例（单机）               | 1分钟                |
| `command_avg_rt`             | 平均时延             | 节点从接收命令到发出响应的时延平均值。单位：us。             | >=0us                      | Redis实例（单机）               | 1分钟                |

### Redis实例数据节点监控指标

![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/china/zh-cn/support/resource/framework/v3/images/support-doc-new-note.svg){:target="_blank"}说明：

- Redis主备、读写分离、集群实例支持数据节点监控。
- 监控指标的维度请参考[维度](https://support.huaweicloud.com/usermanual-dcs/dcs-ug-0713011.html#dcs-ug-0713011__section10507421184117){:target="_blank"}。

| 指标ID                       | 指标名称           | 指标含义                                                     | 取值范围                   | 测量对象                                                     | 监控周期（原始指标） |
| ---------------------------- | ------------------ | ------------------------------------------------------------ | -------------------------- | ------------------------------------------------------------ | -------------------- |
| `cpu_usage`                  | CPU利用率          | 该指标对于统计周期内的测量对象的CPU使用率进行多次采样，表示多次采样的最高值。单位：%。 | 0-100%                     | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `cpu_avg_usage`              | CPU平均使用率      | 该指标对于统计周期内的测量对象的CPU使用率进行多次采样，表示多次采样的平均值。单位：%。 | 0-100%                     | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |
| `memory_usage`               | 内存利用率         | 该指标用于统计测量对象的内存利用率。单位：%。                | 0-100%                     | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `connected_clients`          | 活跃的客户端数量   | 该指标用于统计已连接的客户端数量，包括系统监控、配置同步和业务相关的连接数，不包括来自从节点的连接。 | >=0                        | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `client_longest_out_list`    | 客户端最长输出列表 | 该指标用于统计客户端所有现存连接的最长输出列表。             | >=0                        | Redis 3.0、4.0版本主备、读写分离、集群实例数据节点           | 1分钟                |
| `client_biggest_in_buf`      | 客户端最大输入缓冲 | 该指标用于统计客户端所有现存连接的最大输入数据长度。单位：可在控制台进行选择，如KB、MB、byte等。 | >=0                        | Redis 3.0、4.0版本主备、读写分离、集群实例数据节点           | 1分钟                |
| `blocked_clients`            | 阻塞的客户端数量   | 该指标用于被阻塞操作挂起的客户端的数量。阻塞操作如**BLPOP**，**BRPOP**，**BRPOPLPUSH**。 | >=0                        | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `used_memory`                | 已用内存           | 该指标用于统计Redis已使用的内存字节数。单位：可在控制台进行选择，如KB、MB、byte等。 | >=0                        | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `used_memory_rss`            | 已用内存RSS        | 该指标用于统计Redis已使用的RSS内存。即实际驻留“在内存中”的内存数，包含堆内存，但不包括换出的内存。单位：可在控制台进行选择，如KB、MB、byte等。 | >=0                        | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `used_memory_peak`           | 已用内存峰值       | 该指标用于统计Redis服务器启动以来使用内存的峰值。单位：可在控制台进行选择，如KB、MB、byte等。 | >=0                        | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `used_memory_lua`            | Lua已用内存        | 该指标用于统计Lua引擎已使用的内存字节。单位：可在控制台进行选择，如KB、MB、byte等。 | >=0                        | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `memory_frag_ratio`          | 内存碎片率         | 该指标用于统计当前的内存碎片率。其数值上等于used_memory_rss / used_memory。 | >=0                        | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `total_connections_received` | 新建连接数         | 该指标用于统计周期内新建的连接数。                           | >=0                        | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `total_commands_processed`   | 处理的命令数       | 该指标用于统计周期内处理的命令数。                           | >=0                        | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `instantaneous_ops`          | 每秒并发操作数     | 该指标用于统计每秒处理的命令数。                             | >=0                        | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `total_net_input_bytes`      | 网络收到字节数     | 该指标用于统计周期内收到的字节数。单位：可在控制台进行选择，如KB、MB、byte等。 | >=0                        | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `total_net_output_bytes`     | 网络发送字节数     | 该指标用于统计周期内发送的字节数。单位：可在控制台进行选择，如KB、MB、byte等。 | >=0                        | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `instantaneous_input_kbps`   | 网络瞬时输入流量   | 该指标用于统计瞬时的输入流量。单位：KB/s。                   | >=0KB/s                    | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `instantaneous_output_kbps`  | 网络瞬时输出流量   | 该指标用于统计瞬时的输出流量。单位：KB/s。                   | >=0KB/s                    | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| rejected_connections         | 已拒绝的连接数     | 该指标用于统计周期内因为超过**maxclients**而拒绝的连接数量。 | >=0                        | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `expired_keys`               | 已过期的键数量     | 该指标用于统计周期内因过期而被删除的键数量。                 | >=0                        | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `evicted_keys`               | 已逐出的键数量     | 该指标用于统计周期内因为内存不足被删除的键数量。             | >=0                        | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `pubsub_channels`            | Pubsub通道个数     | 该指标用于统计Pub/Sub通道个数。                              | >=0                        | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `pubsub_patterns`            | Pubsub模式个数     | 该指标用于统计Pub/Sub模式个数。                              | >=0                        | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `keyspace_hits_perc`         | 缓存命中率         | 该指标用于统计Redis的缓存命中率，其命中率算法为：keyspace_hits/(keyspace_hits+keyspace_misses)单位：%。 | 0-100%                     | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `command_max_delay`          | 命令最大时延       | 统计节点的命令最大时延。单位：ms。                           | >=0ms                      | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `is_slow_log_exist`          | 是否存在慢日志     | 统计节点是否存在慢日志。![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**说明：**该监控不统计由`migrate、slaveof、config、bgsave、bgrewriteaof`命令导致的慢查询。 | 1：表示存在0：表示不存在。 | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `keys`                       | 缓存键总数         | 该指标用于统计Redis缓存中键总数。                            | >=0                        | Redis主备、读写分离、集群实例数据节点                        | 1分钟                |
| `sadd`                       | **SADD**           | 该指标用于统计平均每秒**sadd**操作数。单位：Count/s          | 0-500000 Count/s           | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |
| `smembers`                   | **SMEMBERS**       | 该指标用于统计平均每秒**smembers**操作数。单位：Count/s      | 0-500000 Count/s           | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |
| `ms_repl_offset`             | 主从数据同步差值   | 该指标用于统计主从节点之间的数据同步差值。                   | -                          | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点的**备节点** | 1分钟                |
| `del`                        | **DEL**            | 该指标用于统计平均每秒del操作数。单位：Count/s               | 0-500000 Count/s           | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |
| `expire`                     | **EXPIRE**         | 该指标用于统计平均每秒expire操作数。单位：Count/s            | 0-500000 Count/s           | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |
| `get`                        | GET                | 该指标用于统计平均每秒get操作数。单位：Count/s               | 0-500000 Count/s           | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |
| `hdel`                       | **HDEL**           | 该指标用于统计平均每秒**hdel**操作数。单位：Count/s          | 0-500000 Count/s           | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |
| `hget`                       | **HGET**           | 该指标用于统计平均每秒**hget**操作数。单位：Count/s          | 0-500000 Count/s           | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |
| `hmget`                      | **HMGET**          | 该指标用于统计平均每秒**hmget**操作数。单位：Count/s         | 0-500000 Count/s           | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |
| `hmset`                      | **HMSET**          | 该指标用于统计平均每秒**hmset**操作数。单位：Count/s         | 0-500000 Count/s           | Redis 4.0/Redis 5.0主备、集群，Redis 6.0主备实例数据节点     | 1分钟                |
| `hset`                       | **HSET**           | 该指标用于统计平均每秒**hset**操作数。单位：Count/s          | 0-500000 Count/s           | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |
| `mget`                       | **MGET**           | 该指标用于统计平均每秒**mget**操作数。单位：Count/s          | 0-500000 Count/s           | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |
| `mset`                       | **MSET**           | 该指标用于统计平均每秒**mset**操作数。单位：Count/s          | 0-500000 Count/s           | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |
| `set`                        | SET                | 该指标用于统计平均每秒set操作数。单位：Count/s               | 0-500000 Count/s           | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |
| `rx_controlled`              | 流控次数           | 该指标用于统计周期内被流控的次数。这个指标值大于0时，表示当前被使用带宽超过最大带宽限制被流控。单位：Count。 | >=0                        | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |
| `bandwidth_usage`            | 带宽使用率         | 计算当前流量带宽与最大带宽限制的百分比。                     | 0-200%                     | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |
| `connections_usage`          | 连接数使用率       | 该指标用于统计当前连接数与最大连接数限制的百分比。单位：%。  | 0-100%                     | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |
| `command_max_rt`             | 最大时延           | 节点从接收命令到发出响应的时延最大值。单位：us。             | >=0us                      | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |
| `command_avg_rt`             | 平均时延           | 节点从接收命令到发出响应的时延平均值。单位：us。             | >=0us                      | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |
| `sync_full`                  | 全量同步次数       | 该指标用于统计Redis服务器启动以来总共完成的全量同步次数。    | >=0                        | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |
| `slow_log_counts`            | 慢日志出现次数     | 该指标用于统计在一个统计周期内，慢日志出现的次数。           | >=0                        | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |
| `setex`                      | **SETEX**          | 每秒**setex**操作数。单位：Count/s                           | 0-500000 Count/s           | Redis 4.0、5.0、6.0版本主备、读写分离、集群实例数据节点      | 1分钟                |

### Proxy节点监控指标

![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/china/zh-cn/support/resource/framework/v3/images/support-doc-new-note.svg){:target="_blank"}说明：

- Proxy集群和读写分离实例支持Proxy节点监控指标。
- 监控指标的维度请参考[维度](https://support.huaweicloud.com/usermanual-dcs/dcs-ug-0713011.html#dcs-ug-0713011__section10507421184117){:target="_blank"}。

| 指标ID              | 指标名称           | 指标含义                                                     | 取值范围         | 测量对象                         | 监控周期（原始指标） |
| ------------------- | ------------------ | ------------------------------------------------------------ | ---------------- | -------------------------------- | -------------------- |
| cpu_usage           | CPU利用率          | 该指标对于统计周期内的测量对象的CPU使用率进行多次采样，表示多次采样的最高值。单位：%。 | 0-100%           | Redis 3.0 Proxy集群实例Proxy节点 | 1分钟                |
| memory_usage        | 内存利用率         | 该指标用于统计测量对象的内存利用率。单位：%。                | 0-100%           | Redis 3.0 Proxy集群实例Proxy节点 | 1分钟                |
| p_connected_clients | 活跃的客户端数量   | 该指标用于统计已连接的客户端数量。                           | >=0              | Redis 3.0 Proxy集群实例Proxy节点 | 1分钟                |
| max_rxpck_per_sec   | 网卡包接收最大速率 | 该指标用于统计测量对象网卡在统计周期内每秒接收的最大数据包数。单位：包/秒 | 0-10000000包/秒  | Redis 3.0 Proxy集群实例Proxy节点 | 1分钟                |
| max_txpck_per_sec   | 网卡包发送最大速率 | 该指标用于统计测量对象网卡在统计周期内每秒发送的最大数据包数。单位：包/秒 | 0-10000000包/秒  | Redis 3.0 Proxy集群实例Proxy节点 | 1分钟                |
| max_rxkB_per_sec    | 入网最大带宽       | 该指标用于统计测量对象网卡每秒接收的最大数据量。单位：KB/s。 | >= 0KB/s         | Redis 3.0 Proxy集群实例Proxy节点 | 1分钟                |
| max_txkB_per_sec    | 出网最大带宽       | 该指标用于统计测量对象网卡每秒发送的最大数据量。单位：KB/s。 | >= 0KB/s         | Redis 3.0 Proxy集群实例Proxy节点 | 1分钟                |
| avg_rxpck_per_sec   | 网卡包接收平均速率 | 该指标用于统计测量对象网卡在统计周期内每秒接收的平均数据包数。单位：包/秒 | 0-10000000 包/秒 | Redis 3.0 Proxy集群实例Proxy节点 | 1分钟                |
| avg_txpck_per_sec   | 网卡包发送平均速率 | 该指标用于统计测量对象网卡在统计周期内每秒发送的平均数据包数。单位：包/秒 | 0-10000000 包/秒 | Redis 3.0 Proxy集群实例Proxy节点 | 1分钟                |
| avg_rxkB_per_sec    | 入网平均带宽       | 该指标用于统计测量对象网卡每秒接收的平均数据量。单位：KB/s。 | >= 0KB/s         | Redis 3.0 Proxy集群实例Proxy节点 | 1分钟                |
| avg_txkB_per_sec    | 出网平均带宽       | 该指标用于统计测量对象网卡每秒发送的平均数据量。单位：KB/s。 | >= 0KB/s         | Redis 3.0 Proxy集群实例Proxy节点 | 1分钟                |

| 指标ID                      | 指标名称         | 指标含义                                                     | 取值范围               | 测量对象                         | 监控周期（原始指标） |
| --------------------------- | ---------------- | ------------------------------------------------------------ | ---------------------- | -------------------------------- | -------------------- |
| `node_status`               | 实例节点状态     | 显示Proxy节点状态是否正常。                                  | 0：表示正常1：表示异常 | Proxy集群、读写分离实例Proxy节点 | 1分钟                |
| `cpu_usage`                 | CPU利用率        | 该指标对于统计周期内的测量对象的CPU使用率进行多次采样，表示多次采样的最高值。单位：%。 | 0-100%                 | Proxy集群、读写分离实例Proxy节点 | 1分钟                |
| `cpu_avg_usage`             | CPU平均使用率    | 该指标对于统计周期内的测量对象的CPU使用率进行多次采样，表示多次采样的平均值。单位：%。 | 0-100%                 | Proxy集群、读写分离实例Proxy节点 | 1分钟                |
| `memory_usage`              | 内存利用率       | 该指标用于统计测量对象的内存利用率。单位：%。                | 0-100%                 | Proxy集群、读写分离实例Proxy节点 | 1分钟                |
| `connected_clients`         | 活跃的客户端数量 | 该指标用于统计已连接的客户端数量，包括系统监控、配置同步和业务相关的连接数，不包括来自从节点的连接。 | >=0                    | Proxy集群、读写分离实例Proxy节点 | 1分钟                |
| `instantaneous_ops`         | 每秒并发操作数   | 该指标用于统计每秒处理的命令数。                             | >=0                    | Proxy集群、读写分离实例Proxy节点 | 1分钟                |
| `instantaneous_input_kbps`  | 网络瞬时输入流量 | 该指标用于统计瞬时的输入流量。单位：KB/s。                   | >=0KB/s                | Proxy集群、读写分离实例Proxy节点 | 1分钟                |
| `instantaneous_output_kbps` | 网络瞬时输出流量 | 该指标用于统计瞬时的输出流量。单位：KB/s。                   | >=0KB/s                | Proxy集群、读写分离实例Proxy节点 | 1分钟                |
| `total_net_input_bytes`     | 网络收到字节数   | 该指标用于统计周期内收到的字节数。单位：可在控制台进行选择，如KB、MB、byte等。 | >=0                    | Proxy集群、读写分离实例Proxy节点 | 1分钟                |
| `total_net_output_bytes`    | 网络发送字节数   | 该指标用于统计周期内发送的字节数。单位：可在控制台进行选择，如KB、MB、byte等。 | >=0                    | Proxy集群、读写分离实例Proxy节点 | 1分钟                |
| `connections_usage`         | 连接数使用率     | 该指标用于统计当前连接数与最大连接数限制的百分比。单位：%。  | 0-100%                 | Proxy集群、读写分离实例Proxy节点 | 1分钟                |
| `command_max_rt`            | 最大时延         | 节点从接收命令到发出响应的时延最大值。单位：us。             | >=0us                  | Proxy集群、读写分离实例Proxy节点 | 1分钟                |
| `command_avg_rt`            | 平均时延         | 节点从接收命令到发出响应的时延平均值。单位：us。             | >=0us                  | Proxy集群、读写分离实例Proxy节点 | 1分钟                |

### Memcached实例监控指标

![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/china/zh-cn/support/resource/framework/v3/images/support-doc-new-note.svg){:target="_blank"}说明：

监控指标的维度请参考[维度](https://support.huaweicloud.com/usermanual-dcs/dcs-ug-0713011.html#dcs-ug-0713011__section10507421184117){:target="_blank"}。

| 指标ID                         | 指标名称                 | 指标含义                                                     | 取值范围                   | 测量对象      | 监控周期（原始指标） |
| ------------------------------ | ------------------------ | ------------------------------------------------------------ | -------------------------- | ------------- | -------------------- |
| `cpu_usage`                    | CPU利用率                | 该指标对于统计周期内的测量对象的CPU使用率进行多次采样，表示多次采样的最高值。单位：%。 | 0-100%                     | Memcached实例 | 1分钟                |
| `memory_usage`                 | 内存利用率               | 该指标用于统计测量对象的内存利用率。单位：%。                | 0-100%                     | Memcached实例 | 1分钟                |
| `net_in_throughput`            | 网络输入吞吐量           | 该指标用于统计网口平均每秒的输入流量。单位：byte/s。         | >= 0byte/s                 | Memcached实例 | 1分钟                |
| `net_out_throughput`           | 网络输出吞吐量           | 该指标用于统计网口平均每秒的输出流量。单位：byte/s。         | >= 0byte/s                 | Memcached实例 | 1分钟                |
| `mc_connected_clients`         | 活跃的客户端数量         | 该指标用于统计已连接的客户端数量，不包括来自从节点的连接。   | >=0                        | Memcached实例 | 1分钟                |
| `mc_used_memory`               | 已用内存                 | 该指标用于统计已使用的内存字节数。单位：byte。               | >=0byte                    | Memcached实例 | 1分钟                |
| `mc_used_memory_rss`           | 已用内存RSS              | 该指标用于统计已使用的RSS内存。即实际驻留“在内存中”的内存数。包含堆内存，但不包括换出的内存。单位：byte。 | >=0byte                    | Memcached实例 | 1分钟                |
| `mc_used_memory_peak`          | 已用内存峰值             | 该指标用于统计服务器启动以来使用内存的峰值。单位：byte。     | >=0byte                    | Memcached实例 | 1分钟                |
| `mc_memory_frag_ratio`         | 内存碎片率               | 该指标用于统计当前的内存碎片率。其数值上等于used_memory_rss / used_memory。 | >=0                        | Memcached实例 | 1分钟                |
| `mc_connections_received`      | 新建连接数               | 该指标用于统计周期内新建的连接数。                           | >=0                        | Memcached实例 | 1分钟                |
| `mc_commands_processed`        | 处理的命令数             | 该指标用于统计周期内处理的命令数。                           | >=0                        | Memcached实例 | 1分钟                |
| `mc_instantaneous_ops`         | 每秒并发操作数           | 该指标用于统计每秒处理的命令数。                             | >=0                        | Memcached实例 | 1分钟                |
| `mc_net_input_bytes`           | 网络收到字节数           | 该指标用于统计周期内收到的字节数。单位：byte。               | >=0byte                    | Memcached实例 | 1分钟                |
| `mc_net_output_bytes`          | 网络发送字节数           | 该指标用于统计周期内发送的字节数。单位：byte。               | >=0byte                    | Memcached实例 | 1分钟                |
| `mc_instantaneous_input_kbps`  | 网络瞬时输入流量         | 该指标用于统计瞬时的输入流量。单位：KB/s。                   | >=0KB/s                    | Memcached实例 | 1分钟                |
| `mc_instantaneous_output_kbps` | 网络瞬时输出流量         | 该指标用于统计瞬时的输出流量。单位：KB/s。                   | >=0KB/s                    | Memcached实例 | 1分钟                |
| `mc_rejected_connections`      | 已拒绝的连接数           | 该指标用于统计周期内因为超过**maxclients**而拒绝的连接数量。 | >=0                        | Memcached实例 | 1分钟                |
| `mc_expired_keys`              | 已过期的键数量           | 该指标用于统计周期内因过期而被删除的键数量。                 | >=0                        | Memcached实例 | 1分钟                |
| `mc_evicted_keys`              | 已驱逐的键数量           | 该指标用于统计周期内因为内存不足被删除的键数量。             | >=0                        | Memcached实例 | 1分钟                |
| `mc_cmd_get`                   | 数据查询请求次数         | 该指标用于统计服务收到的数据查询请求次数。                   | >=0                        | Memcached实例 | 1分钟                |
| `mc_cmd_set`                   | 数据存储请求次数         | 该指标用于统计服务收到的数据存储请求次数。                   | >=0                        | Memcached实例 | 1分钟                |
| `mc_cmd_flush`                 | 数据清空请求次数         | 该指标用于统计服务收到的数据清空请求次数。                   | >=0                        | Memcached实例 | 1分钟                |
| `mc_cmd_touch`                 | 数据有效期修改请求次数   | 该指标用于统计服务收到的数据有效期修改请求次数。             | >=0                        | Memcached实例 | 1分钟                |
| `mc_get_hits`                  | 数据查询命中次数         | 该指标用于统计数据查询成功次数。                             | >=0                        | Memcached实例 | 1分钟                |
| `mc_get_misses`                | 数据查询未命中次数       | 该指标用于统计数据因键不存在而失败的查询次数。               | >=0                        | Memcached实例 | 1分钟                |
| `mc_delete_hits`               | 数据删除命中次数         | 该指标用于统计数据删除成功次数。                             | >=0                        | Memcached实例 | 1分钟                |
| `mc_delete_misses`             | 数据删除未命中次数       | 该指标用于统计因键不存在而失败的数据删除次数。               | >=0                        | Memcached实例 | 1分钟                |
| `mc_incr_hits`                 | 算数加命中次数           | 该指标用于统计算数加操作成功次数。                           | >=0                        | Memcached实例 | 1分钟                |
| `mc_incr_misses`               | 算数加未命中次数         | 该指标用于统计因键不存在而失败的算数加操作次数。             | >=0                        | Memcached实例 | 1分钟                |
| `mc_decr_hits`                 | 算数减命中次数           | 该指标用于统计算数减操作成功次数。                           | >=0                        | Memcached实例 | 1分钟                |
| `mc_decr_misses`               | 算数减未命中次数         | 该指标用于统计因键不存在而失败的算数减操作次数。             | >=0                        | Memcached实例 | 1分钟                |
| `mc_cas_hits`                  | CAS命中次数              | 该指标用于统计CAS操作成功次数。                              | >=0                        | Memcached实例 | 1分钟                |
| `mc_cas_misses`                | CAS未命中次数            | 该指标用于统计因键不存在而失败的CAS操作次数。                | >=0                        | Memcached实例 | 1分钟                |
| `mc_cas_badval`                | CAS数值不匹配次数        | 该指标用于统计因CAS值不匹配而失败的CAS次数。                 | >=0                        | Memcached实例 | 1分钟                |
| `mc_touch_hits`                | 数据有效期修改命中次数   | 该指标用于统计数据有效期修改成功次数。                       | >=0                        | Memcached实例 | 1分钟                |
| `mc_touch_misses`              | 数据有效期修改未命中次数 | 该指标用于统计因键不存在而失败的数据有效期修改次数。         | >=0                        | Memcached实例 | 1分钟                |
| `mc_auth_cmds`                 | 认证请求次数             | 该指标用于统计认证请求次数。                                 | >=0                        | Memcached实例 | 1分钟                |
| `mc_auth_errors`               | 认证失败次数             | 该指标用于统计认证失败次数。                                 | >=0                        | Memcached实例 | 1分钟                |
| `mc_curr_items`                | 存储的数据条目           | 该指标用于统计存储的数据条目。                               | >=0                        | Memcached实例 | 1分钟                |
| `mc_command_max_delay`         | 命令最大时延             | 统计命令最大时延。单位：ms。                                 | >=0ms                      | Memcached实例 | 1分钟                |
| `mc_is_slow_log_exist`         | 是否存在慢日志           | 统计实例是否存在慢日志。![img](https://res-static.hc-cdn.cn/aem/content/dam/cloudbu-site/archive/hk/en-us/support/resource/framework/v3/images/support-doc-en-note.png){:target="_blank"}**说明：**该监控不统计由**migrate**、**slaveof**、**config**、**bgsave**、**bgrewriteaof**命令导致的慢日志。 | 1：表示存在0：表示不存在。 | Memcached实例 | 1分钟                |
| `mc_keyspace_hits_perc`        | 访问命中率               | 统计实例的访问码命中率。单位：%。                            | 0-100%                     | Memcached实例 | 1分钟                |

## 对象 {#object}

```json
{
  "measurement": "huaweicloud_redis",
  "tags": {
    "name"              : "71be0037-xxxx-xxxx-xxxx-b6b91f134066",
    "instance_id"       : "71be0037-xxxx-xxxx-xxxx-b6b91f134066",
    "instance_name"     : "dcs-iash",
    "RegionId"          : "cn-north-4",
    "project_id"        : "c631f04625xxxxxxxxxxf253c62d48585",
    "engine"            : "Redis",
    "engine_version"    : "5.0",
    "status"            : "RUNNING",
    "az_codes"          : "[\"cn-north-4c\", \"cn-north-4a\"]",
    "port"              : "6379",
    "ip"                : "192.xxx.x.144",
    "charging_mode"     : "0",
    "no_password_access": "true",
    "enable_publicip"   : "False"
  },
  "fields": {
    "created_at" : "2022-07-12T07:29:56.875Z",
    "max_memory" : 128,
    "used_memory": 2,
    "capacity"   : 0,
    "description": "",
    "message"    : "{实例 JSON 数据}"
  }
}
```

部分字段说明如下：

| 字段                 | 类型    | 说明                                                         |
| :------------------- | :------ | :----------------------------------------------------------- |
| `ip`                 | String  | 连接缓存实例的 IP 地址。如果是集群实例，返回多个 IP 地址，使用逗号分隔。如：192.168.0.1，192.168.0.2。 |
| `charging_mode`      | String  | 计费模式，0 表示按需计费，1 表示包年/包月计费。              |
| `no_password_access` | String  | 是否允许免密码访问缓存实例： true：该实例无需密码即可访问。 false：该实例必须通过密码认证才能访问 |
| `enable_publicip`    | String  | Redis 缓存实例是否开启公网访问功能 True：开启 False：不开启  |
| `max_memory`         | Integer | 总内存，单位：MB。                                           |
| `used_memory`        | Integer | 已使用的内存，单位：MB。                                     |
| `capacity`           | Integer | 缓存容量（G Byte）。                                         |
| `status`             | String  | **CREATING** ：申请缓存实例后，在缓存实例状态进入运行中之前的状态。 **CREATEFAILED**：缓存实例处于创建失败的状态。 **RUNNING**：缓存实例正常运行状态。 **RESTARTING**：缓存实例正在进行重启操作。 **FROZEN**：缓存实例处于已冻结状态，用户可以在“我的订单”中续费开启冻结的缓存实例。 **EXTENDING**：缓存实例处于正在扩容的状态。 **RESTORING**：缓存实例数据恢复中的状态。 **FLUSHING**：缓存实例数据清空中的状态。 |

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：以下字段均为 JSON 序列化后字符串 - `fields.message` - `tags.az_codes`
