---
title: 'Tencent Cloud CLB Private'
tags: 
  - Tencent Cloud
summary: 'Use the "Guance Cloud Sync" series script packages from the Script Market to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/tencent_clb'
dashboard:

  - desc: 'Built-in views for Tencent Cloud CLB Private'
    path: 'dashboard/en/tencent_clb_private'

monitor:
  - desc: 'Monitors for Tencent Cloud CLB Private'
    path: 'monitor/en/tencent_clb_private'

---


<!-- markdownlint-disable MD025 -->
# Tencent Cloud CLB Private
<!-- markdownlint-enable -->

Use the "Guance Cloud Sync" series script packages from the Script Market to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

We recommend enabling the Guance Integration - Extension - DataFlux Func (Automata): All prerequisites are automatically installed, please proceed with the script installation.

If you deploy Func on your own, refer to [Deploy Func on Your Own](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant read-only access `ReadOnlyAccess`)

To synchronize the monitoring data of Tencent Cloud CLB, we install the corresponding collection script: "Guance Integration (Tencent Cloud-CLB Collection)" (ID: `guance_tencentcloud_clb`)

Click [Install], then enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click [Deploy Startup Script], the system will automatically create a `Startup` script set and configure the corresponding startup script.

Additionally, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click [Execute] to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations; for details, see the metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the automatic trigger configuration and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Tencent Cloud Cloud Monitoring Metrics Details](https://cloud.tencent.com/document/product/248/51899){:target="_blank"}

| Metric Name | Metric Description | Metric Explanation | Unit | Statistical Granularity |
| ----------- | ------------------ | ------------------- | ---- | ----------------------- |
| `ClientConnum` | Active connections from client to LB | At a certain moment within the statistical granularity, the number of active connections from the client to the load balancer or listener. | Count | 10s, 60s, 300s |
| `ClientInactiveConn` | Inactive connections from client to LB | At a certain moment within the statistical granularity, the number of inactive connections from the client to the load balancer or listener. | Count | 10s, 60s, 300s |
| `ClientConcurConn` | Concurrent connections from client to LB | At a certain moment within the statistical granularity, the number of concurrent connections from the client to the load balancer or listener. | Count | 10s, 60s, 300s |
| `ClientNewConn` | New connections from client to LB | Within the statistical granularity, the number of new connections from the client to the load balancer or listener. | Count/sec | 10s, 60s, 300s |
| `ClientInpkg` | Incoming packets from client to LB | Within the statistical granularity, the number of packets sent by the client to the load balancer per second. | Count/sec | 10s, 60s, 300s |
| `ClientOutpkg` | Outgoing packets from client to LB | Within the statistical granularity, the number of packets sent by the load balancer to the client per second. | Count/sec | 10s, 60s, 300s |
| `ClientAccIntraffic` | Incoming traffic from client to LB | Within the statistical granularity, the amount of traffic flowing into the load balancer from the client. | MB | 10s, 60s, 300s |
| `ClientAccOuttraffic` | Outgoing traffic from client to LB | Within the statistical granularity, the amount of traffic flowing out from the load balancer to the client. | MB | 10s, 60s, 300s |
| `ClientOuttraffic` | Outgoing bandwidth from client to LB | Within the statistical granularity, the bandwidth used by the load balancer to send data to the client. | Mbps | 10s, 60s, 300s |
| `ClientIntraffic` | Incoming bandwidth from client to LB | Within the statistical granularity, the bandwidth used by the client to send data to the load balancer. | Mbps | 10s, 60s, 300s |
| `OutTraffic` | Outgoing bandwidth from LB to backend | Within the statistical granularity, the bandwidth used by the backend RS to send data to the load balancer. | Mbps | 60s, 300s |
| `InTraffic` | Incoming bandwidth from LB to backend | Within the statistical granularity, the bandwidth used by the load balancer to send data to the backend RS. | Mbps | 60s, 300s |
| `OutPkg` | Outgoing packets from LB to backend | Within the statistical granularity, the number of packets sent by the backend RS to the load balancer per second. | Count/sec | 60s, 300s |
| `InPkg` | Incoming packets from LB to backend | Within the statistical granularity, the number of packets sent by the load balancer to the backend RS per second. | Count/sec | 60s, 300s |
| `ConNum` | Connections from LB to backend | Within the statistical granularity, the number of connections from the load balancer to the backend RS. | Count | 60s, 300s |
| `NewConn` | New connections from LB to backend | Within the statistical granularity, the number of new connections from the load balancer to the backend RS. | Count/min | 60s, 300s |
| `DropTotalConns` | Dropped connections | Within the statistical granularity, the number of dropped connections on the load balancer or listener. This metric only supports standard account types, not traditional account types. Refer to [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"} for account type determination. | Count | 10s, 60s, 300s |
| `InDropBits` | Dropped incoming bandwidth | Within the statistical granularity, the bandwidth dropped when the client accesses the load balancer via the internal network. This metric only supports standard account types, not traditional account types. Refer to [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"} for account type determination. | Bytes | 10s, 60s, 300s |
| `OutDropBits` | Dropped outgoing bandwidth | Within the statistical granularity, the bandwidth dropped when the load balancer accesses the internal network. This metric only supports standard account types, not traditional account types. Refer to [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"} for account type determination. | Bytes | 10s, 60s, 300s |
| `InDropPkts` | Dropped incoming packets | Within the statistical granularity, the number of packets dropped when the client accesses the load balancer via the internal network. This metric only supports standard account types, not traditional account types. Refer to [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"} for account type determination. | Count/sec | 10s, 60s, 300s |
| `OutDropPkts` | Dropped outgoing packets | Within the statistical granularity, the number of packets dropped when the load balancer accesses the internal network. This metric only supports standard account types, not traditional account types. Refer to [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"} for account type determination. | Count/sec | 10s, 60s, 300s |
| `DropQps` | Dropped QPS | Within the statistical granularity, the number of requests dropped on the load balancer or listener. This metric is unique to Layer 7 listeners. This metric only supports standard account types, not traditional account types. Refer to [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"} for account type determination. | Count | 60s, 300s |
| `IntrafficVipRatio` | Incoming bandwidth utilization | Within the statistical granularity, the bandwidth utilization when the client accesses the load balancer via the internal network. This metric only supports standard account types, not traditional account types. Refer to [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"} for account type determination. This metric is in beta testing; submit a [ticket application](https://console.cloud.tencent.com/workorder/category?level1_id=6&level2_id=163&source=0&data_title=Load Balancer CLB&level3_id=1071&queue=96&scene_code=34639&step=2){:target="_blank"} if you need to use it. | % | 10s, 60s, 300s |
| `OuttrafficVipRatio` | Outgoing bandwidth utilization | Within the statistical granularity, the bandwidth utilization when the load balancer accesses the internal network. This metric only supports standard account types, not traditional account types. Refer to [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"} for account type determination. This metric is in beta testing; submit a [ticket application](https://console.cloud.tencent.com/workorder/category?level1_id=6&level2_id=163&source=0&data_title=Load Balancer CLB&level3_id=1071&queue=96&scene_code=34639&step=2){:target="_blank"} if you need to use it. | % | 10s, 60s, 300s |
| `ReqAvg` | Average request time | Within the statistical granularity, the average request time for the load balancer. This metric is unique to Layer 7 listeners. | Milliseconds | 60s, 300s |
| `ReqMax` | Maximum request time | Within the statistical granularity, the maximum request time for the load balancer. This metric is unique to Layer 7 listeners. | Milliseconds | 60s, 300s |
| `RspAvg` | Average response time | Within the statistical granularity, the average response time for the load balancer. This metric is unique to Layer 7 listeners. | Milliseconds | 60s, 300s |
| `RspMax` | Maximum response time | Within the statistical granularity, the maximum response time for the load balancer. This metric is unique to Layer 7 listeners. | Milliseconds | 60s, 300s |
| `RspTimeout` | Number of response timeouts | Within the statistical granularity, the number of response timeouts for the load balancer. This metric is unique to Layer 7 listeners. | Count/min | 60s, 300s |
| `SuccReq` | Successful requests per minute | Within the statistical granularity, the number of successful requests per minute for the load balancer. This metric is unique to Layer 7 listeners. | Count/min | 60s, 300s |
| `TotalReq` | Requests per second | Within the statistical granularity, the number of requests per second for the load balancer. This metric is unique to Layer 7 listeners. | Count | 60s, 300s |
| `ClbHttp3xx` | CLB returns 3xx status codes | Within the statistical granularity, the number of 3xx status codes returned by the load balancer (sum of load balancer and backend server return codes). This metric is unique to Layer 7 listeners. | Count/min | 60s, 300s |
| `ClbHttp4xx` | CLB returns 4xx status codes | Within the statistical granularity, the number of 4xx status codes returned by the load balancer (sum of load balancer and backend server return codes). This metric is unique to Layer 7 listeners. | Count/min | 60s, 300s |
| `ClbHttp5xx` | CLB returns 5xx status codes | Within the statistical granularity, the number of 5xx status codes returned by the load balancer (sum of load balancer and backend server return codes). This metric is unique to Layer 7 listeners. | Count/min | 60s, 300s |
| `Http2xx` | 2xx status codes | Within the statistical granularity, the number of 2xx status codes returned by the backend server. This metric is unique to Layer 7 listeners. | Count/min | 60s, 300s |
| `Http3xx` | 3xx status codes | Within the statistical granularity, the number of 3xx status codes returned by the backend server. This metric is unique to Layer 7 listeners. | Count/min | 60s, 300s |
| `Http4xx` | 4xx status codes | Within the statistical granularity, the number of 4xx status codes returned by the backend server. This metric is unique to Layer 7 listeners. | Count/min | 60s, 300s |
| `Http5xx` | 5xx status codes | Within the statistical granularity, the number of 5xx status codes returned by the backend server. This metric is unique to Layer 7 listeners. | Count/min | 60s, 300s |
| `UnhealthRsCount` | Health check anomalies | Within the statistical period, the number of health check anomalies for the load balancer. | Count | 60s, 300s |

## Objects {#object}
The collected Tencent Cloud CLB Private object data structure can be seen in the "Infrastructure - Custom" section.

``` json
{
  "measurement": "tencentcloud_clb",
  "tags": {
    "name"            : "lb-xxxx",
    "RegionId"        : "ap-shanghai",
    "LoadBalancerId"  : "lb-xxxx",
    "LoadBalancerName": "lb-xxxx",
    "Address"         : "81.xxxx",
    "LoadBalancerType": "Private",
    "Status"          : "1",
    "VpcId"           : "vpc-xxxx",
    "Zone"            : "ap-shanghai-3",
    "ChargeType"      : "POSTPAID_BY_HOUR"
  },
  "fields": {
    "CreateTime": "2022-04-27 15:19:49",
    "listeners" : "{Listener JSON data}",
    "message"   : "{Instance JSON data}"
  }
}
```