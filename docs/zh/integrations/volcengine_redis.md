---
title: '火山引擎 Redis'
tags: 
  - 火山引擎
summary: '火山引擎 Redis 指标采集'
__int_icon: 'icon/volcengine_redis'
dashboard:
  - desc: '火山引擎 Redis'
    path: 'dashboard/zh/volcengine_redis/'
monitor:
  - desc: '火山引擎 Redis 监控器'
    path: 'monitor/zh/volcengine_redis'
---

<!-- markdownlint-disable MD025 -->
# 火山引擎 Redis
<!-- markdownlint-enable -->


火山引擎 Redis 指标采集。

## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的火山引擎 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 ECS 云资源的监控数据，我们安装对应的采集脚本：「<<< custom_key.brand_name >>>集成（火山引擎-ECS采集）」(ID：`guance_volcengine_redis`)

点击【安装】后，输入相应的参数：火山引擎 AK、火山引擎账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。


我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://<<< custom_key.func_domain >>>/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}

默认的指标集如下, 可以通过配置的方式采集更多的指标 [火山引擎云监控指标详情](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_Redis){:target="_blank"}

|`MetricName` |`Subnamespace` |指标说明 |MetricUnit | Dimension|
| ---- |-------------------------------------| :----: |:----: |:----: |
|`AggregatedTotalQps` |`aggregated_proxy` |Proxy 节点上的总 QPS。 |Count/Second | ResourceID|
|`AggregatedMaxQueryLatency` |`aggregated_proxy` |Proxy 执行命令时 Server 端响应的时延最大值。 |Microsecond | ResourceID|
|`AggregatedResponseMaxBytes` |`aggregated_proxy` |Proxy 节点上单个响应的最大字节数。 |Bytes(SI) | ResourceID|
|`AggregatedUsedConn` |`aggregated_proxy` |已连接到 Proxy 的客户端连接数。 |Count | ResourceID|
|`AggregatedConnUtil` |`aggregated_proxy` |已使用连接数与实例支持的总连接数比值。 |Percent | ResourceID|
|`AggregatedReadQps` |`aggregated_proxy` |Proxy 节点上的读 QPS。 |Count/Second | ResourceID|
|`AggregatedWriteQps` |`aggregated_proxy` |Proxy 节点上的写 QPS。 |Count/Second | ResourceID|
|`AggregatedP99QueryLatency` |`aggregated_proxy` |将 Proxy 到 Server 节点的所有请求耗时从低到高排列，处于 99% 位置的请求耗时。 |Microsecond | ResourceID|
|`AggregatedPeakUsedConn` |`aggregated_proxy` |每秒代理节点的峰值已使用连接数。 |Count | ResourceID|
|`AggregatedAvgQueryLatency` |`aggregated_proxy` |Proxy 执行命令时 Server 端响应的时延平均值。 |Microsecond | ResourceID|
|`AggregatedTotalConnReceived` |`aggregated_proxy` |Proxy 启动后到指定查询时间之间已建立的连接总数。 |Count | ResourceID|
|`AggregatedNetworkPeakReceiveThroughput` |`aggregated_proxy` |每秒流入 Proxy 节点的网络峰值流量。 |Bytes/Second(SI) | ResourceID|
|`AggregatedNetworkPeakTransmitThroughput` |`aggregated_proxy` |每秒流出 Proxy 节点的网络峰值流量。 |Bytes/Second(SI) | ResourceID|
|`AggregatedCpuUtil` |`aggregated_server` |Server 节点的 CPU 使用率。 |Percent | ResourceID|
|`AggregatedKeyHitRate` |`aggregated_server` |Server 节点上读取 Key 时命中的比率。 |Percent | ResourceID|
|`AggregatedTotalKey` |`aggregated_server` |Server 节点上存储的 Key 总个数。 |Count | ResourceID|
|`AggregatedUsedMem` |`aggregated_server` |Server 节点上已使用的内存大小。 |Bytes(IEC) | ResourceID|
|`AggregatedMemUtil` |`aggregated_server` |Server 节点的内存使用率。 |Percent | ResourceID|
|`AggregatedExpiredKeyPerSec` |`aggregated_server` |实例每秒过期的 Key 数量。 |Count/Second | ResourceID|
|`AggregatedEvictedKeyPerSec` |`aggregated_server` |实例每秒逐出的 Key 数量。 |Count/Second | ResourceID|
|`AggregatedKeyWithExpiration` |`aggregated_server` |Server 节点启动后所有已设置过期时间的 Key 总数。 |Count | ResourceID|
|`AggregatedKeyHitPerSec` |`aggregated_server` |Server 节点上每秒命中的 Key 数量。 |Count/Second | ResourceID|
|`AggregatedKeyMissPerSec` |`aggregated_server` |Server 节点上每秒未命中的 Key 数量。 |Count/Second | ResourceID|
|`AggregatedNetworkPeakTransmitThroughput` |`aggregated_server` |每秒流入 Server 节点的网络峰值流量。 |Bytes/Second(SI) | ResourceID|
|`AggregatedNetworkPeakReceiveThroughput` |`aggregated_server` |每秒流出 Server 节点的网络峰值流量。 |Bytes/Second(SI) | ResourceID|
|`TotalQps` |`proxy` |Proxy 节点上的总 QPS。 |Count/Second | ResourceID,Node|
|`MaxQueryLatency` |`proxy` |Proxy 执行命令时 Server 端响应的时延最大值。 |Microsecond | ResourceID,Node|
|`ResponseMaxBytes` |`proxy` |Proxy 节点上单个响应的最大字节数。 |Bytes(SI) | ResourceID,Node|
|`UsedConn` |`proxy` |已连接到 Proxy 的客户端连接数。 |Count | ResourceID,Node|
|`ConnUtil` |`proxy` |使用连接数与 Proxy 节点支持的总连接数比值。 |Percent | Node,ResourceID|
|`ReadQps` |`proxy` |Proxy 节点上的读 QPS。 |Count/Second | Node,ResourceID|
|`WriteQps` |`proxy` |Proxy 节点上的写 QPS。 |Count/Second | Node,ResourceID|
|`P99QueryLatency` |`proxy` |将 Proxy 到 Server 节点的所有请求耗时从低到高排列，处于 99% 位置的请求耗时。 |Microsecond | Node,ResourceID|
|`PeakUsedConn` |`proxy` |每秒代理节点的峰值已使用连接数。 |Count | ResourceID,Node|
|`PeakConnUtil` |`proxy` |每秒代理节点的峰值连接数使用率。 |Percent | ResourceID,Node|
|`AvgQueryLatency` |`proxy` |Proxy 执行命令时 Server 端响应的时延平均值。 |Microsecond | ResourceID,Node|
|`TotalConnReceived` |`proxy` |Proxy 启动后到指定查询时间之间已建立的连接总数。 |Count | ResourceID,Node|
|`NetworkPeakReceiveThroughput` |`proxy` |每秒流入 Proxy 节点的网络峰值流量。 |Bytes/Second(SI) | ResourceID,Node|
|`CpuUtil` |`server` |Server 节点的 CPU 使用率。 |Percent | ResourceID,Node|
|`KeyHitRate` |`server` |Server 节点上读取 Key 时命中的比率。 |Percent | ResourceID,Node|
|`TotalKey` |`server` |Server 节点上存储的 Key 总个数。 |Count | ResourceID,Node|
|`UsedMem` |`server` |Server 节点上已使用的内存大小。 |Bytes(IEC) | ResourceID,Node|
|`ExpiredKeyPerSec` |`server` |Server 节点上每秒命中的 Key 数量。 |Count/Second | ResourceID,Node|
|`EvictedKeyPerSec` |`server` |Server 节点上每秒逐出的 Key 数量。 |Count/Second | ResourceID,Node|
|`MemUtil` |`server` |Server 节点的内存使用率。 |Percent | ResourceID,Node|
|`KeyWithExpiration` |`server` |Server 节点启动后所有已设置过期时间的 Key 总数。 |Count | Node,ResourceID|
|`KeyHitPerSec` |`server` |Server 节点上每秒命中的 Key 数量。 |Count/Second | Node,ResourceID|
|`KeyMissPerSec` |`server` |Server 节点上每秒未命中的 Key 数量。 |Count/Second | Node,ResourceID|
|`IsPrimary` |`server` |当前 Server 节点是否为主节点。 |None | Node,ResourceID|
|`NetworkReceiveThroughputUtil` |`server` |每秒流入 Server 节点的峰值带宽利用率。 |Percent | ResourceID,Node|
|`NetworkTransmitThroughputUtil` |`server` |每秒流出 Server 节点的峰值带宽利用率。 |Percent | ResourceID,Node|
|`NetworkPeakReceiveThroughput` |`server` |每秒流入 Server 节点的网络峰值流量。 |Bytes/Second(SI) | ResourceID,Node|
|`NetworkPeakTransmitThroughput` |`server` |每秒流出 Server 节点的网络峰值流量。 |Bytes/Second(SI) | ResourceID,Node|



## 对象 {#object}

采集到的火山引擎 Redis 对象数据结构, 可以从「基础设置-资源目录」里看到对象数据。

