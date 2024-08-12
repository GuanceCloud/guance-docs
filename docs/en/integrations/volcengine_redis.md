---
title: 'Volcengine Redis'
tags: 
  - Volcengine
summary: 'Volcengine Redis Metrics Collection'
dashboard:
  - desc: 'Volcengine Redis'
    path: 'dashboard/en/volcengine_redis/'
monitor:
  - desc: 'Volcengine Redis Monitor'
    path: 'monitor/en/volcengine_redis'
---

<!-- markdownlint-disable MD025 -->
# `Volcengine` Redis
<!-- markdownlint-enable -->

Volcengine Redis Metrics Collection.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script


> Tip：Please prepare `Volcenine`  AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of **Redis** cloud resources, we install the corresponding collection script：「Guance Integration（`Volcenine` -**Redis** Collect）」(ID：`guance_volcengine_redis`)

Click "Install" and enter the corresponding parameters: `Volcenine` AK, `Volcenine` account name.

tap "Deploy startup Script"，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click "Run"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs.

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists


## Metric  {#metric}

The default metric set is as follows. You can collect more metrics by configuring them [`Volcenine` Cloud Monitor Metrics Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_Redis){:target="_blank"}

| `MetricName` | `SubNamespace` | Description | MetricUnit | Dimension |
|---------------|-----------------|----------------------|------------|-----------|
| `AggregatedTotalQps` | `aggregated_proxy` | Total QPS on the Proxy node. | Count/Second | ResourceID |
| `AggregatedMaxQueryLatency` | `aggregated_proxy` | Maximum latency of the server's response when the Proxy executes a command. | Microsecond | ResourceID |
| `AggregatedResponseMaxBytes` | `aggregated_proxy` | Maximum bytes in a single response on the Proxy node. | Bytes(SI) | ResourceID |
| `AggregatedUsedConn` | `aggregated_proxy` | Number of client connections connected to the Proxy. | Count | ResourceID |
| `AggregatedConnUtil` | `aggregated_proxy` | Ratio of used connections to the total number of connections supported by the instance. | Percent | ResourceID |
| `AggregatedReadQps` | `aggregated_proxy` | Read QPS on the Proxy node. | Count/Second | ResourceID |
| `AggregatedWriteQps` | `aggregated_proxy` | Write QPS on the Proxy node. | Count/Second | ResourceID |
| `AggregatedP99QueryLatency` | `aggregated_proxy` | The request latency at the 99th percentile for all requests from the Proxy to the Server node. | Microsecond | ResourceID |
| `AggregatedPeakUsedConn` | `aggregated_proxy` | Peak number of used connections per second on the proxy node. | Count | ResourceID |
| `AggregatedAvgQueryLatency` | `aggregated_proxy` | Average latency of the server's response when the Proxy executes a command. | Microsecond | ResourceID |
| `AggregatedTotalConnReceived` | `aggregated_proxy` | Total number of connections established from the start of the Proxy to the specified query time. | Count | ResourceID |
| `AggregatedNetworkPeakReceiveThroughput` | `aggregated_proxy` | Peak network traffic flowing into the Proxy node per second. | Bytes/Second(SI) | ResourceID |
| `AggregatedNetworkPeakTransmitThroughput` | `aggregated_proxy` | Peak network traffic flowing out of the Proxy node per second. | Bytes/Second(SI) | ResourceID |
| `AggregatedCpuUtil` | `aggregated_server` | CPU utilization of the Server node. | Percent | ResourceID |
| `AggregatedKeyHitRate` | `aggregated_server` | Hit rate when reading Key on the Server node. | Percent | ResourceID |
| `AggregatedTotalKey` | `aggregated_server` | Total number of Keys stored on the Server node. | Count | ResourceID |
| `AggregatedUsedMem` | `aggregated_server` | Amount of memory used on the Server node. | Bytes(IEC) | ResourceID |
| `AggregatedMemUtil` | `aggregated_server` | Memory utilization of the Server node. | Percent | ResourceID |
| `AggregatedExpiredKeyPerSec` | `aggregated_server` | Number of Keys expired per second in the instance. | Count/Second | ResourceID |
| `AggregatedEvictedKeyPerSec` | `aggregated_server` | Number of Keys evicted per second in the instance. | Count/Second | ResourceID |
| `AggregatedKeyWithExpiration` | `aggregated_server` | Total number of Keys with expiration time set since the start of the Server node. | Count | ResourceID |
| `AggregatedKeyHitPerSec` | `aggregated_server` | Number of Keys hit per second on the Server node. | Count/Second | ResourceID |
| `AggregatedKeyMissPerSec` | `aggregated_server` | Number of Keys missed per second on the Server node. | Count/Second | ResourceID |
| `AggregatedNetworkPeakTransmitThroughput` | `aggregated_server` | Peak network traffic flowing into the Server node per second. | Bytes/Second(SI) | ResourceID |
| `AggregatedNetworkPeakReceiveThroughput` | `aggregated_server` | Peak network traffic flowing out of the Server node per second. | Bytes/Second(SI) | ResourceID |
| `TotalQps` | `proxy` | Total QPS on the Proxy node. | Count/Second | ResourceID, Node |
| `MaxQueryLatency` | `proxy` | Maximum latency of the server's response when the Proxy executes a command. | Microsecond | ResourceID, Node |
| `ResponseMaxBytes` | `proxy` | Maximum bytes in a single response on the Proxy node. | Bytes(SI) | ResourceID, Node |
| `UsedConn` | `proxy` | Number of client connections connected to the Proxy. | Count | ResourceID, Node |
| `ConnUtil` | `proxy` | Ratio of used connections to the total number of connections supported by the Proxy node. | Percent | Node, ResourceID |
| `ReadQps` | `proxy` | Read QPS on the Proxy node. | Count/Second | Node, ResourceID |
| `WriteQps` | `proxy` | Write QPS on the Proxy node. | Count/Second | Node, ResourceID |
| `P99QueryLatency` | `proxy` | The request latency at the 99th percentile for all requests from the Proxy to the Server node. | Microsecond | Node, ResourceID |
| `PeakUsedConn` | `proxy` | Peak number of used connections per second on the proxy node. | Count | ResourceID, Node |
| `PeakConnUtil` | `proxy` | Peak connection utilization per second on the proxy node. | Percent | ResourceID, Node |
| `AvgQueryLatency` | `proxy` | Average latency of the server's response when the Proxy executes a command. | Microsecond | ResourceID, Node |
| `TotalConnReceived` | `proxy` | Total number of connections established from the start of the Proxy to the specified query time. | Count | ResourceID, Node |
| `NetworkPeakReceiveThroughput` | `proxy` | Peak network traffic flowing into the Proxy node per second. | Bytes/Second(SI) | ResourceID, Node |
| `CpuUtil` | `server` | CPU utilization of the Server node. | Percent | ResourceID, Node |
| `KeyHitRate` | `server` | Hit rate when reading Key on the Server node. | Percent | ResourceID, Node |
| `TotalKey` | `server` | Total number of Keys stored on the Server node. | Count | ResourceID, Node |
| `UsedMem` | `server` | Amount of memory used on the Server node. | Bytes(IEC) | ResourceID, Node |
| `ExpiredKeyPerSec` | `server` | Number of Keys expired per second on the Server node. | Count/Second | ResourceID, Node |
| `EvictedKeyPerSec` | `server` | Number of Keys evicted per second on the Server node. | Count/Second | ResourceID, Node |
| `MemUtil` | `server` | Memory utilization of the Server node. | Percent | ResourceID, Node |
| `KeyWithExpiration` | `server` | Total number of Keys with expiration time set since the start of the Server node. | Count | Node, ResourceID |
| `KeyHitPerSec` | `server` | Number of Keys hit per second on the Server node. | Count/Second | Node, ResourceID |
| `KeyMissPerSec` | `server` | Number of Keys missed per second on the Server node. | Count/Second | Node, ResourceID |
| `IsPrimary` | `server` | Whether the current Server node is the primary node. | None | Node, ResourceID |
| `NetworkReceiveThroughputUtil` | `server` | Peak bandwidth utilization rate for network traffic flowing into the Server node per second. | Percent | ResourceID, Node |
| `NetworkTransmitThroughputUtil` | `server` | Peak bandwidth utilization rate for network traffic flowing out of the Server node per second. | Percent | ResourceID, Node |
| `NetworkPeakReceiveThroughput` | `server` | Peak network traffic flowing into the Server node per second. | Bytes/Second(SI) | ResourceID, Node |
| `NetworkPeakTransmitThroughput` | `server` | Peak network traffic flowing out of the Server node per second. | Bytes/Second(SI) | ResourceID, Node |


## Object  {#object}
The collected `Volcenine` Cloud **Redis** object data structure can see the object data from 「Infrastructure-Resource」


