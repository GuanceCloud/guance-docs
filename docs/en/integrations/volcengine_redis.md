---
title: 'Volcengine Redis'
tags: 
  - Volcengine
summary: 'Volcengine Redis Metrics Collection'
__int_icon: 'icon/volcengine_redis'
dashboard:
  - desc: 'Volcengine Redis'
    path: 'dashboard/en/volcengine_redis/'
monitor:
  - desc: 'Volcengine Redis Monitor'
    path: 'monitor/en/volcengine_redis'
---

<!-- markdownlint-disable MD025 -->
# Volcengine Redis
<!-- markdownlint-enable -->


Volcengine Redis metrics collection.

## Configuration {#config}

### Install Func

We recommend enabling <<< custom_key.brand_name >>> Integration - Extension - DataFlux Func (Automata): All prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare a Volcengine AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize ECS cloud resource monitoring data, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Volcengine-ECS Collection)" (ID: `guance_volcengine_redis`)

After clicking 【Install】, input the corresponding parameters: Volcengine AK, Volcengine account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script automatically.

Once enabled, you can find the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute it without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

> If you want to collect the corresponding logs, you also need to enable the relevant log collection script. If you want to collect billing information, you need to enable the cloud billing collection script.


We default to collecting some configurations; see the metrics section for details.

[Customize Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and check the corresponding task records and logs for any anomalies.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if asset information exists.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}

The default metric set is as follows. You can collect more metrics through configuration. [Volcengine Cloud Monitoring Metric Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_Redis){:target="_blank"}

|`MetricName` |`Subnamespace` |Metric Description |MetricUnit | Dimension|
| ---- |-------------------------------------| :----: |:----: |:----: |
|`AggregatedTotalQps` |`aggregated_proxy` |Total QPS on Proxy nodes. |Count/Second | ResourceID|
|`AggregatedMaxQueryLatency` |`aggregated_proxy` |Maximum latency when Proxy executes commands on the Server side. |Microsecond | ResourceID|
|`AggregatedResponseMaxBytes` |`aggregated_proxy` |Maximum number of bytes in a single response on Proxy nodes. |Bytes(SI) | ResourceID|
|`AggregatedUsedConn` |`aggregated_proxy` |Number of client connections connected to Proxy. |Count | ResourceID|
|`AggregatedConnUtil` |`aggregated_proxy` |Ratio of used connections to total supported connections by the instance. |Percent | ResourceID|
|`AggregatedReadQps` |`aggregated_proxy` |Read QPS on Proxy nodes. |Count/Second | ResourceID|
|`AggregatedWriteQps` |`aggregated_proxy` |Write QPS on Proxy nodes. |Count/Second | ResourceID|
|`AggregatedP99QueryLatency` |`aggregated_proxy` |The request latency at the 99% position when sorting all request latencies from low to high between Proxy and Server nodes. |Microsecond | ResourceID|
|`AggregatedPeakUsedConn` |`aggregated_proxy` |Peak number of used connections per second on proxy nodes. |Count | ResourceID|
|`AggregatedAvgQueryLatency` |`aggregated_proxy` |Average latency when Proxy executes commands on the Server side. |Microsecond | ResourceID|
|`AggregatedTotalConnReceived` |`aggregated_proxy` |Total number of connections established between Proxy startup and the specified query time. |Count | ResourceID|
|`AggregatedNetworkPeakReceiveThroughput` |`aggregated_proxy` |Peak network throughput flowing into Proxy nodes per second. |Bytes/Second(SI) | ResourceID|
|`AggregatedNetworkPeakTransmitThroughput` |`aggregated_proxy` |Peak network throughput flowing out of Proxy nodes per second. |Bytes/Second(SI) | ResourceID|
|`AggregatedCpuUtil` |`aggregated_server` |CPU utilization of Server nodes. |Percent | ResourceID|
|`AggregatedKeyHitRate` |`aggregated_server` |Percentage of Key hits when reading Keys on Server nodes. |Percent | ResourceID|
|`AggregatedTotalKey` |`aggregated_server` |Total number of Keys stored on Server nodes. |Count | ResourceID|
|`AggregatedUsedMem` |`aggregated_server` |Amount of memory used on Server nodes. |Bytes(IEC) | ResourceID|
|`AggregatedMemUtil` |`aggregated_server` |Memory utilization of Server nodes. |Percent | ResourceID|
|`AggregatedExpiredKeyPerSec` |`aggregated_server` |Number of expired Keys per second on instances. |Count/Second | ResourceID|
|`AggregatedEvictedKeyPerSec` |`aggregated_server` |Number of evicted Keys per second on instances. |Count/Second | ResourceID|
|`AggregatedKeyWithExpiration` |`aggregated_server` |Total number of Keys with expiration times set since Server node startup. |Count | ResourceID|
|`AggregatedKeyHitPerSec` |`aggregated_server` |Number of Keys hit per second on Server nodes. |Count/Second | ResourceID|
|`AggregatedKeyMissPerSec` |`aggregated_server` |Number of Keys missed per second on Server nodes. |Count/Second | ResourceID|
|`AggregatedNetworkPeakTransmitThroughput` |`aggregated_server` |Peak network throughput flowing into Server nodes per second. |Bytes/Second(SI) | ResourceID|
|`AggregatedNetworkPeakReceiveThroughput` |`aggregated_server` |Peak network throughput flowing out of Server nodes per second. |Bytes/Second(SI) | ResourceID|
|`TotalQps` |`proxy` |Total QPS on Proxy nodes. |Count/Second | ResourceID,Node|
|`MaxQueryLatency` |`proxy` |Maximum latency when Proxy executes commands on the Server side. |Microsecond | ResourceID,Node|
|`ResponseMaxBytes` |`proxy` |Maximum number of bytes in a single response on Proxy nodes. |Bytes(SI) | ResourceID,Node|
|`UsedConn` |`proxy` |Number of client connections connected to Proxy. |Count | ResourceID,Node|
|`ConnUtil` |`proxy` |Ratio of used connections to total supported connections by Proxy nodes. |Percent | Node,ResourceID|
|`ReadQps` |`proxy` |Read QPS on Proxy nodes. |Count/Second | Node,ResourceID|
|`WriteQps` |`proxy` |Write QPS on Proxy nodes. |Count/Second | Node,ResourceID|
|`P99QueryLatency` |`proxy` |The request latency at the 99% position when sorting all request latencies from low to high between Proxy and Server nodes. |Microsecond | Node,ResourceID|
|`PeakUsedConn` |`proxy` |Peak number of used connections per second on proxy nodes. |Count | ResourceID,Node|
|`PeakConnUtil` |`proxy` |Peak connection utilization per second on proxy nodes. |Percent | ResourceID,Node|
|`AvgQueryLatency` |`proxy` |Average latency when Proxy executes commands on the Server side. |Microsecond | ResourceID,Node|
|`TotalConnReceived` |`proxy` |Total number of connections established between Proxy startup and the specified query time. |Count | ResourceID,Node|
|`NetworkPeakReceiveThroughput` |`proxy` |Peak network throughput flowing into Proxy nodes per second. |Bytes/Second(SI) | ResourceID,Node|
|`CpuUtil` |`server` |CPU utilization of Server nodes. |Percent | ResourceID,Node|
|`KeyHitRate` |`server` |Percentage of Key hits when reading Keys on Server nodes. |Percent | ResourceID,Node|
|`TotalKey` |`server` |Total number of Keys stored on Server nodes. |Count | ResourceID,Node|
|`UsedMem` |`server` |Amount of memory used on Server nodes. |Bytes(IEC) | ResourceID,Node|
|`ExpiredKeyPerSec` |`server` |Number of Keys hit per second on Server nodes. |Count/Second | ResourceID,Node|
|`EvictedKeyPerSec` |`server` |Number of Keys evicted per second on Server nodes. |Count/Second | ResourceID,Node|
|`MemUtil` |`server` |Memory utilization of Server nodes. |Percent | ResourceID,Node|
|`KeyWithExpiration` |`server` |Total number of Keys with expiration times set since Server node startup. |Count | Node,ResourceID|
|`KeyHitPerSec` |`server` |Number of Keys hit per second on Server nodes. |Count/Second | Node,ResourceID|
|`KeyMissPerSec` |`server` |Number of Keys missed per second on Server nodes. |Count/Second | Node,ResourceID|
|`IsPrimary` |`server` |Whether the current Server node is the primary node. |None | Node,ResourceID|
|`NetworkReceiveThroughputUtil` |`server` |Peak bandwidth utilization flowing into Server nodes per second. |Percent | ResourceID,Node|
|`NetworkTransmitThroughputUtil` |`server` |Peak bandwidth utilization flowing out of Server nodes per second. |Percent | ResourceID,Node|
|`NetworkPeakReceiveThroughput` |`server` |Peak network throughput flowing into Server nodes per second. |Bytes/Second(SI) | ResourceID,Node|
|`NetworkPeakTransmitThroughput` |`server` |Peak network throughput flowing out of Server nodes per second. |Bytes/Second(SI) | ResourceID,Node|



## Objects {#object}

The structure of the collected Volcengine Redis object data can be viewed in the "Basic Settings - Resource Catalog".
</translated_content>