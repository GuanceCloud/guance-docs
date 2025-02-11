---
title: 'VolcEngine Redis'
tags: 
  - VolcEngine
summary: 'VolcEngine Redis Metrics Collection'
__int_icon: 'icon/volcengine_redis'
dashboard:
  - desc: 'VolcEngine Redis'
    path: 'dashboard/en/volcengine_redis/'
monitor:
  - desc: 'VolcEngine Redis Monitor'
    path: 'monitor/en/volcengine_redis'
---

<!-- markdownlint-disable MD025 -->
# VolcEngine Redis
<!-- markdownlint-enable -->


VolcEngine Redis metrics collection.

## Configuration {#config}

### Install Func

We recommend enabling Guance integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-hosted Func Deployment](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Prepare a VolcEngine AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize ECS cloud resource monitoring data, we install the corresponding collection script: 「Guance Integration (VolcEngine-ECS Collection)」(ID: `guance_volcengine_redis`)

After clicking 【Install】, enter the required parameters: VolcEngine AK and VolcEngine account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Once enabled, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, enable the log collection script accordingly. If you need to collect billing information, enable the cloud billing collection script.


We default to collecting some configurations; see the metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding task has an automatic trigger configuration and check the task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}

The default metric set is as follows. You can collect more metrics through configuration. [VolcEngine Cloud Monitoring Metrics Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_Redis){:target="_blank"}

|`MetricName` |`Subnamespace` |Metric Description |MetricUnit | Dimension|
| ---- |-------------------------------------| :----: |:----: |:----: |
|`AggregatedTotalQps` |`aggregated_proxy` |Total QPS on Proxy nodes. |Count/Second | ResourceID|
|`AggregatedMaxQueryLatency` |`aggregated_proxy` |Maximum latency of Server response when executing commands on Proxy. |Microsecond | ResourceID|
|`AggregatedResponseMaxBytes` |`aggregated_proxy` |Maximum bytes per single response on Proxy nodes. |Bytes(SI) | ResourceID|
|`AggregatedUsedConn` |`aggregated_proxy` |Number of client connections connected to Proxy. |Count | ResourceID|
|`AggregatedConnUtil` |`aggregated_proxy` |Ratio of used connections to total supported connections on instances. |Percent | ResourceID|
|`AggregatedReadQps` |`aggregated_proxy` |Read QPS on Proxy nodes. |Count/Second | ResourceID|
|`AggregatedWriteQps` |`aggregated_proxy` |Write QPS on Proxy nodes. |Count/Second | ResourceID|
|`AggregatedP99QueryLatency` |`aggregated_proxy` |99th percentile request latency from Proxy to Server nodes. |Microsecond | ResourceID|
|`AggregatedPeakUsedConn` |`aggregated_proxy` |Peak number of used connections on proxy nodes per second. |Count | ResourceID|
|`AggregatedAvgQueryLatency` |`aggregated_proxy` |Average latency of Server response when executing commands on Proxy. |Microsecond | ResourceID|
|`AggregatedTotalConnReceived` |`aggregated_proxy` |Total number of connections established from Proxy startup to specified query time. |Count | ResourceID|
|`AggregatedNetworkPeakReceiveThroughput` |`aggregated_proxy` |Peak network inflow throughput to Proxy nodes per second. |Bytes/Second(SI) | ResourceID|
|`AggregatedNetworkPeakTransmitThroughput` |`aggregated_proxy` |Peak network outflow throughput from Proxy nodes per second. |Bytes/Second(SI) | ResourceID|
|`AggregatedCpuUtil` |`aggregated_server` |CPU utilization on Server nodes. |Percent | ResourceID|
|`AggregatedKeyHitRate` |`aggregated_server` |Hit rate of Key reads on Server nodes. |Percent | ResourceID|
|`AggregatedTotalKey` |`aggregated_server` |Total number of Keys stored on Server nodes. |Count | ResourceID|
|`AggregatedUsedMem` |`aggregated_server` |Memory size used on Server nodes. |Bytes(IEC) | ResourceID|
|`AggregatedMemUtil` |`aggregated_server` |Memory utilization on Server nodes. |Percent | ResourceID|
|`AggregatedExpiredKeyPerSec` |`aggregated_server` |Number of expired Keys per second on instances. |Count/Second | ResourceID|
|`AggregatedEvictedKeyPerSec` |`aggregated_server` |Number of evicted Keys per second on instances. |Count/Second | ResourceID|
|`AggregatedKeyWithExpiration` |`aggregated_server` |Total number of Keys with expiration set since Server node startup. |Count | ResourceID|
|`AggregatedKeyHitPerSec` |`aggregated_server` |Number of Keys hit per second on Server nodes. |Count/Second | ResourceID|
|`AggregatedKeyMissPerSec` |`aggregated_server` |Number of Keys missed per second on Server nodes. |Count/Second | ResourceID|
|`AggregatedNetworkPeakTransmitThroughput` |`aggregated_server` |Peak network inflow throughput to Server nodes per second. |Bytes/Second(SI) | ResourceID|
|`AggregatedNetworkPeakReceiveThroughput` |`aggregated_server` |Peak network outflow throughput from Server nodes per second. |Bytes/Second(SI) | ResourceID|
|`TotalQps` |`proxy` |Total QPS on Proxy nodes. |Count/Second | ResourceID,Node|
|`MaxQueryLatency` |`proxy` |Maximum latency of Server response when executing commands on Proxy. |Microsecond | ResourceID,Node|
|`ResponseMaxBytes` |`proxy` |Maximum bytes per single response on Proxy nodes. |Bytes(SI) | ResourceID,Node|
|`UsedConn` |`proxy` |Number of client connections connected to Proxy. |Count | ResourceID,Node|
|`ConnUtil` |`proxy` |Ratio of used connections to total supported connections on Proxy nodes. |Percent | Node,ResourceID|
|`ReadQps` |`proxy` |Read QPS on Proxy nodes. |Count/Second | Node,ResourceID|
|`WriteQps` |`proxy` |Write QPS on Proxy nodes. |Count/Second | Node,ResourceID|
|`P99QueryLatency` |`proxy` |99th percentile request latency from Proxy to Server nodes. |Microsecond | Node,ResourceID|
|`PeakUsedConn` |`proxy` |Peak number of used connections on proxy nodes per second. |Count | ResourceID,Node|
|`PeakConnUtil` |`proxy` |Peak connection utilization on proxy nodes per second. |Percent | ResourceID,Node|
|`AvgQueryLatency` |`proxy` |Average latency of Server response when executing commands on Proxy. |Microsecond | ResourceID,Node|
|`TotalConnReceived` |`proxy` |Total number of connections established from Proxy startup to specified query time. |Count | ResourceID,Node|
|`NetworkPeakReceiveThroughput` |`proxy` |Peak network inflow throughput to Proxy nodes per second. |Bytes/Second(SI) | ResourceID,Node|
|`CpuUtil` |`server` |CPU utilization on Server nodes. |Percent | ResourceID,Node|
|`KeyHitRate` |`server` |Hit rate of Key reads on Server nodes. |Percent | ResourceID,Node|
|`TotalKey` |`server` |Total number of Keys stored on Server nodes. |Count | ResourceID,Node|
|`UsedMem` |`server` |Memory size used on Server nodes. |Bytes(IEC) | ResourceID,Node|
|`ExpiredKeyPerSec` |`server` |Number of expired Keys per second on Server nodes. |Count/Second | ResourceID,Node|
|`EvictedKeyPerSec` |`server` |Number of evicted Keys per second on Server nodes. |Count/Second | ResourceID,Node|
|`MemUtil` |`server` |Memory utilization on Server nodes. |Percent | ResourceID,Node|
|`KeyWithExpiration` |`server` |Total number of Keys with expiration set since Server node startup. |Count | Node,ResourceID|
|`KeyHitPerSec` |`server` |Number of Keys hit per second on Server nodes. |Count/Second | Node,ResourceID|
|`KeyMissPerSec` |`server` |Number of Keys missed per second on Server nodes. |Count/Second | Node,ResourceID|
|`IsPrimary` |`server` |Whether the current Server node is the primary node. |None | Node,ResourceID|
|`NetworkReceiveThroughputUtil` |`server` |Peak bandwidth utilization of network inflow to Server nodes per second. |Percent | ResourceID,Node|
|`NetworkTransmitThroughputUtil` |`server` |Peak bandwidth utilization of network outflow from Server nodes per second. |Percent | ResourceID,Node|
|`NetworkPeakReceiveThroughput` |`server` |Peak network inflow throughput to Server nodes per second. |Bytes/Second(SI) | ResourceID,Node|
|`NetworkPeakTransmitThroughput` |`server` |Peak network outflow throughput from Server nodes per second. |Bytes/Second(SI) | ResourceID,Node|



## Objects {#object}

The structure of VolcEngine Redis object data collected can be viewed in the 「Basic Settings - Resource Catalog」.

</input_content>
<target_language>英语</target_language>
</input>