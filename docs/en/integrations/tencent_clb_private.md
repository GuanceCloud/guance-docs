---
title: 'Tencent Cloud CLB Private'
tags: 
  - Tencent Cloud
summary: 'Use the script package series in the Script Market called "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance.'
__int_icon: 'icon/tencent_clb'
dashboard:

  - desc: 'Tencent Cloud CLB Private Built-in Views'
    path: 'dashboard/en/tencent_clb_private'

monitor:
  - desc: 'Tencent Cloud CLB Private Monitor'
    path: 'monitor/en/tencent_clb_private'

---


<!-- markdownlint-disable MD025 -->
# Tencent Cloud CLB Private
<!-- markdownlint-enable -->

Use the script package series in the Script Market called "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance Integration - Extension - DataFlux Func (Automata): all prerequisites will be automatically installed. Please proceed with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize Tencent Cloud CLB monitoring data, we install the corresponding collection script: "Guance Integration (Tencent Cloud-CLB Collection)" (ID: `guance_tencentcloud_clb`)

After clicking 【Install】, enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script automatically.

In addition, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】to immediately execute it once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We default to collecting some configurations. For more details, see the Metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the corresponding task records and logs for any anomalies.
2. On the Guance platform, in "Infrastructure / Custom", check if there are any asset information.
3. On the Guance platform, in "Metrics", check if there are any corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud - Cloud Monitoring, the default measurement sets are as follows. You can collect more metrics through configuration [Tencent Cloud Cloud Monitoring Metrics Details](https://cloud.tencent.com/document/product/248/51899){:target="_blank"}

| Metric Name      | Metric Description                 | Metric Explanation                                                     | Unit    | Statistical Granularity         |
| ---------- | -------------------------- | ------------------------------------------------------------ | ------- | ---------------- |
| `ClientConnum` | Number of active connections from client to LB   | At a certain moment within the statistical granularity, the number of active connections from the client to the load balancer or listener. | Count      | 10s、60s、300s   |
| `ClientInactiveConn` | Number of inactive connections from client to LB | At a certain moment within the statistical granularity, the number of inactive connections from the client to the load balancer or listener. | Count      | 10s、60s、300s   |
| `ClientConcurConn` | Number of concurrent connections from client to LB   | At a certain moment within the statistical granularity, the number of concurrent connections from the client to the load balancer or listener. | Count      | 10s、60s、300s   |
| `ClientNewConn` | Number of new connections from client to LB   | Within the statistical granularity, the number of new connections from the client to the load balancer or listener.     | Connections/second   | 10s、60s、300s   |
| `ClientInpkg` | Number of inbound packets from client to LB       | Within the statistical granularity, the number of data packets sent per second by the client to the load balancer.         | Packets/second   | 10s、60s、300s   |
| `ClientOutpkg` | Number of outbound packets from client to LB       | Within the statistical granularity, the number of data packets sent per second by the load balancer to the client.         | Packets/second   | 10s、60s、300s   |
| `ClientAccIntraffic` | Inbound traffic from client to LB       | Within the statistical granularity, the traffic flowing into the load balancer from the client.                   | MB      | 10s、60s、300s   |
| `ClientAccOuttraffic` | Outbound traffic from client to LB       | Within the statistical granularity, the traffic flowing out from the load balancer to the client.                   | MB      | 10s、60s、300s   |
| `ClientOuttraffic` | Outbound bandwidth from client to LB       | Within the statistical granularity, the bandwidth used for traffic flowing out from the load balancer to the client.               | Mbps    | 10s、60s、300s   |
| `ClientIntraffic` | Inbound bandwidth from client to LB       | Within the statistical granularity, the bandwidth used for traffic flowing into the load balancer from the client.                   | Mbps    | 10s、60s、300s   |
| `OutTraffic` | Outbound bandwidth from LB to backend          | Within the statistical granularity, the bandwidth used for traffic flowing out from the backend RS to the load balancer.             | Mbps    | 60s、300s        |
| `InTraffic` | Inbound bandwidth from LB to backend          | Within the statistical granularity, the bandwidth used for traffic flowing into the backend RS from the load balancer.             | Mbps    | 60s、300s        |
| `OutPkg`   | Outbound packet count from LB to backend          | Within the statistical granularity, the number of data packets sent per second by the backend RS to the load balancer.       | Packets/second   | 60s、300s        |
| `InPkg`    | Inbound packet count from LB to backend          | Within the statistical granularity, the number of data packets sent per second by the load balancer to the backend RS.       | Packets/second   | 60s、300s        |
| `ConNum`   | Connection count from LB to backend          | Within the statistical granularity, the number of connections from the load balancer to the backend RS.                 | Count      | 60s、300s        |
| `NewConn`  | New connection count from LB to backend      | Within the statistical granularity, the number of new connections from the load balancer to the backend RS.             | Connections/minute | 60s、300s        |
| `DropTotalConns` | Dropped connection count                 | Within the statistical granularity, the number of dropped connections on the load balancer or listener. This metric only supports standard account types, not traditional account types. The method for determining account type is detailed in [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. | Count      | 10s、60s、300s   |
| `InDropBits` | Dropped inbound bandwidth                 | Within the statistical granularity, the bandwidth dropped when the client accesses the load balancer via the internal network. This metric only supports standard account types, not traditional account types. The method for determining account type is detailed in [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. | Bytes    | 10s、60s、300s   |
| `OutDropBits` | Dropped outbound bandwidth                 | Within the statistical granularity, the bandwidth dropped when the load balancer accesses the internal network. This metric only supports standard account types, not traditional account types. The method for determining account type is detailed in [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. | Bytes    | 10s、60s、300s   |
| `InDropPkts` | Dropped inbound packets             | Within the statistical granularity, the number of packets dropped when the client accesses the load balancer via the internal network. This metric only supports standard account types, not traditional account types. The method for determining account type is detailed in [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. | Packets/second   | 10s、60s、300s   |
| `OutDropPkts` | Dropped outbound packets             | Within the statistical granularity, the number of packets dropped when the load balancer accesses the internal network. This metric only supports standard account types, not traditional account types. The method for determining account type is detailed in [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. | Packets/second   | 10s、60s、300s   |
| `DropQps`  | Dropped QPS                   | Within the statistical granularity, the number of requests dropped on the load balancer or listener. This metric is exclusive to layer-seven listeners. This metric only supports standard account types, not traditional account types. The method for determining account type is detailed in [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. | Count      | 60s、300s        |
| `IntrafficVipRatio` | Inbound bandwidth utilization               | Within the statistical granularity, the bandwidth utilization when the client accesses the load balancer via the internal network. This metric only supports standard account types, not traditional account types. The method for determining account type is detailed in [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. This metric is in beta testing. If you need to use it, submit a [ticket application](https://console.cloud.tencent.com/workorder/category?level1_id=6&level2_id=163&source=0&data_title=Load Balancer CLB&level3_id=1071&queue=96&scene_code=34639&step=2){:target="_blank"}. | %       | 10s、60s、300s   |
| `OuttrafficVipRatio` | Outbound bandwidth utilization               | Within the statistical granularity, the bandwidth usage when the load balancer accesses the internal network. This metric only supports standard account types, not traditional account types. The method for determining account type is detailed in [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. This metric is in beta testing. If you need to use it, submit a [ticket application](https://console.cloud.tencent.com/workorder/category?level1_id=6&level2_id=163&source=0&data_title=Load Balancer CLB&level3_id=1071&queue=96&scene_code=34639&step=2){:target="_blank"}. | ％      | 10s、60s、300s   |
| `ReqAvg`   | Average request time               | Within the statistical granularity, the average request time for the load balancer. This metric is exclusive to layer-seven listeners. | Milliseconds    | 60s、300s        |
| `ReqMax`   | Maximum request time               | Within the statistical granularity, the maximum request time for the load balancer. This metric is exclusive to layer-seven listeners. | Milliseconds    | 60s、300s        |
| `RspAvg`   | Average response time               | Within the statistical granularity, the average response time for the load balancer. This metric is exclusive to layer-seven listeners. | Milliseconds    | 60s、300s        |
| `RspMax`   | Maximum response time               | Within the statistical granularity, the maximum response time for the load balancer. This metric is exclusive to layer-seven listeners. | Milliseconds    | 60s、300s        |
| `RspTimeout` | Response timeout count               | Within the statistical granularity, the count of response timeouts for the load balancer. This metric is exclusive to layer-seven listeners. | Count/minute | 60s、300s        |
| `SuccReq`  | Successful request count per minute           | Within the statistical granularity, the count of successful requests per minute for the load balancer. This metric is exclusive to layer-seven listeners. | Count/minute | 60s、300s        |
| `TotalReq` | Request count per second                 | Within the statistical granularity, the request count per second for the load balancer. This metric is exclusive to layer-seven listeners. | Count      | 60s、300s        |
| `ClbHttp3xx` | CLB returned 3xx status codes      | Within the statistical granularity, the count of 3xx status codes returned by the load balancer (sum of load balancer and backend server return codes). This metric is exclusive to layer-seven listeners. | Count/minute | 60s、300s        |
| `ClbHttp4xx` | CLB returned 4xx status codes      | Within the statistical granularity, the count of 4xx status codes returned by the load balancer (sum of load balancer and backend server return codes). This metric is exclusive to layer-seven listeners. | Count/minute | 60s、300s        |
| `ClbHttp5xx` | CLB returned 5xx status codes      | Within the statistical granularity, the count of 5xx status codes returned by the load balancer (sum of load balancer and backend server return codes). This metric is exclusive to layer-seven listeners. | Count/minute | 60s、300s        |
| `Http2xx`  | 2xx status codes                 | Within the statistical granularity, the count of 2xx status codes returned by the backend server. This metric is exclusive to layer-seven listeners. | Count/minute | 60s、300s        |
| `Http3xx`  | 3xx status codes                 | Within the statistical granularity, the count of 3xx status codes returned by the backend server. This metric is exclusive to layer-seven listeners. | Count/minute | 60s、300s        |
| `Http4xx`  | 4xx status codes                 | Within the statistical granularity, the count of 4xx status codes returned by the backend server. This metric is exclusive to layer-seven listeners. | Count/minute | 60s、300s        |
| `Http5xx`  | 5xx status codes                 | Within the statistical granularity, the count of 5xx status codes returned by the backend server. This metric is exclusive to layer-seven listeners. | Count/minute | 60s、300s        |
| `UnhealthRsCount` | Health check exception count             | Within the statistical period, the count of health check exceptions for the load balancer.                   | Count      | 60s、300s        |

## Objects {#object}
The data structure of collected Tencent Cloud CLB Private objects can be viewed in "Infrastructure - Custom".

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