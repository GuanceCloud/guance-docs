---
title: 'Tencent Cloud CLB Public'
tags: 
  - Tencent Cloud
summary: 'Use the script packages in the Script Market of the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/tencent_clb'
dashboard:

  - desc: 'Tencent Cloud CLB Public built-in view'
    path: 'dashboard/en/tencent_clb_public'

monitor:
  - desc: 'Tencent Cloud CLB Public monitor'
    path: 'monitor/en/tencent_clb_public'

---


<!-- markdownlint-disable MD025 -->
# Tencent Cloud CLB Public
<!-- markdownlint-enable -->

Use the script packages in the Script Market of the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable Guance Integration - Extension - DataFlux Func (Automata): all prerequisites will be automatically installed, please continue with the script installation

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize CLB_Public cloud resource monitoring data, we install the corresponding collection script: "Guance Integration (Tencent Cloud CLB Collection)" (ID: `guance_tencentcloud_clb`)

After clicking 【Install】, enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the regular time. After a short while, you can check the execution task records and corresponding logs.

We default collect some configurations, for more details see the Metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the automatic trigger configuration, and at the same time, you can check the corresponding task records and logs to check for any abnormalities.
2. On the Guance platform, under "Infrastructure / Custom", check if there is any asset information.
3. On the Guance platform, under "Metrics", check if there is any corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud - Cloud Monitoring, the default Measurement sets are as follows, and more metrics can be collected through configuration [Tencent Cloud Cloud Monitoring Metrics Details](https://cloud.tencent.com/document/product/248/51898){:target="_blank"}

| Metric Name          | Metric Description                 | Metric Explanation                                                     | Unit        | Statistical Granularity             |
| ------------------- | -------------------------- | ------------------------------------------------------------ | ----------- | -------------------- |
| `ClientConnum`        | Active connections from client to LB   | At a certain moment within the statistical granularity, the number of active connections from the client to the load balancer or listener. | Count          | 10s, 60s, 300s       |
| `ClientInactiveConn`  | Non-active connections from client to LB | At a certain moment within the statistical granularity, the number of non-active connections from the client to the load balancer or listener. | Count          | 10s, 60s, 300s       |
| `ClientConcurConn`    | Concurrent connections from client to LB   | At a certain moment within the statistical granularity, the number of concurrent connections from the client to the load balancer or listener. | Count          | 10s, 60s, 300s       |
| `ClientNewConn`       | New connections from client to LB   | Within the statistical granularity, the number of new connections from the client to the load balancer or listener.     | Count/second       | 10s, 60s, 300s       |
| `ClientInpkg`         | Incoming packets from client to LB       | Within the statistical granularity, the number of data packets sent by the client to the load balancer per second.         | Count/second       | 10s, 60s, 300s       |
| `ClientOutpkg`        | Outgoing packets from client to LB       | Within the statistical granularity, the number of data packets sent by the load balancer to the client per second.         | Count/second       | 10s, 60s, 300s       |
| `ClientAccIntraffic`  | Incoming traffic from client to LB       | Within the statistical granularity, the amount of traffic flowing into the load balancer from the client.                   | MB          | 10s, 60s, 300s       |
| `ClientAccOuttraffic` | Outgoing traffic from client to LB       | Within the statistical granularity, the amount of traffic flowing out from the load balancer to the client.                   | MB          | 10s, 60s, 300s       |
| `ClientIntraffic`     | Incoming bandwidth from client to LB       | Within the statistical granularity, the bandwidth used for traffic flowing into the load balancer from the client.               | Mbps        | 10s, 60s, 300s       |
| `ClientOuttraffic`    | Outgoing bandwidth from client to LB       | Within the statistical granularity, the bandwidth used for traffic flowing out from the load balancer to the client.               | Mbps        | 10s, 60s, 300s       |
| `InTraffic`           | Incoming bandwidth from LB to backend          | Within the statistical granularity, the bandwidth used for traffic flowing into the backend RS from the load balancer.             | Mbps        | 10s, 60s, 300s, 3600 |
| `OutTraffic`          | Outgoing bandwidth from LB to backend          | Within the statistical granularity, the bandwidth used for traffic flowing out from the backend RS to the load balancer.             | Mbps        | 10s, 60s, 300s, 3600 |
| `InPkg`               | Incoming packet count from LB to backend          | Within the statistical granularity, the number of data packets sent by the load balancer to the backend RS per second.       | Count/second       | 10s, 60s, 300s, 3600 |
| `OutPkg`              | Outgoing packet count from LB to backend          | Within the statistical granularity, the number of data packets sent by the backend RS to the load balancer per second.       | Count/second       | 10s, 60s, 300s, 3600 |
| `ConNum`              | Connection count from LB to backend          | Within the statistical granularity, the number of connections from the load balancer to the backend RS.                 | Count          | 60s, 300s, 3600s     |
| `NewConn`             | New connection count from LB to backend      | Within the statistical granularity, the number of new connections from the load balancer to the backend RS.             | Count/minute     | 60s, 300s, 3600s     |
| `DropTotalConns`      | Dropped connection count                 | Within the statistical granularity, the number of dropped connections on the load balancer or listener. This metric is only supported for standard account types, not traditional account types. The method to determine account type can be found in [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. | Count          | 60s, 300s, 3600s     |
| `IntrafficVipRatio`   | Incoming bandwidth utilization               | Within the statistical granularity, the utilization of incoming bandwidth when the client accesses the load balancer via the Internet. This metric is only supported for standard account types, not traditional account types. The method to determine account type can be found in [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}.| %           | 60s, 300s, 3600s     |
| `OuttrafficVipRatio`  | Outgoing bandwidth utilization               | Within the statistical granularity, the usage rate of outgoing bandwidth when the load balancer accesses the Internet. This metric is only supported for standard account types, not traditional account types. The method to determine account type can be found in [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}.| ％          | 60s, 300s, 3600s     |
| `ReqAvg`              | Average request time               | Within the statistical granularity, the average request time for the load balancer. This metric is an exclusive indicator for layer-7 listeners. | Milliseconds        | 60s, 300s, 3600s     |
| `ReqMax`              | Maximum request time               | Within the statistical granularity, the maximum request time for the load balancer. This metric is an exclusive indicator for layer-7 listeners. | Milliseconds        | 60s, 300s, 3600s     |
| `RspAvg`              | Average response time               | Within the statistical granularity, the average response time for the load balancer. This metric is an exclusive indicator for layer-7 listeners. | Milliseconds        | 60s, 300s, 3600s     |
| `RspMax`              | Maximum response time               | Within the statistical granularity, the maximum response time for the load balancer. This metric is an exclusive indicator for layer-7 listeners. | Milliseconds        | 60s, 300s, 3600s     |
| `RspTimeout`          | Response timeout count               | Within the statistical granularity, the number of timeouts for the load balancer responses. This metric is an exclusive indicator for layer-7 listeners. | Count/minute     | 60s, 300s, 3600s     |
| `SuccReq`             | Successful requests per minute           | Within the statistical granularity, the number of successful requests per minute for the load balancer. This metric is an exclusive indicator for layer-7 listeners. | Count/minute     | 60s, 300s, 3600s     |
| `TotalReq`            | Requests per second                 | Within the statistical granularity, the number of requests per second for the load balancer. This metric is an exclusive indicator for layer-7 listeners. | Count          | 60s, 300s, 3600s     |
| `ClbHttp3xx`          | CLB returns 3xx status codes      | Within the statistical granularity, the number of 3xx status codes returned by the load balancer (the sum of the return codes from the load balancer and the backend server). This metric is an exclusive indicator for layer-7 listeners. | Count/minute     | 60s, 300s, 3600s     |
| `ClbHttp4xx`          | CLB returns 4xx status codes      | Within the statistical granularity, the number of 4xx status codes returned by the load balancer (the sum of the return codes from the load balancer and the backend server). This metric is an exclusive indicator for layer-7 listeners. | Count/minute     | 60s, 300s, 3600s     |
| `ClbHttp5xx`          | CLB returns 5xx status codes      | Within the statistical granularity, the number of 5xx status codes returned by the load balancer (the sum of the return codes from the load balancer and the backend server). This metric is an exclusive indicator for layer-7 listeners. | Count/minute     | 60s, 300s, 3600s     |
| `Http2xx`             | 2xx status codes                 | Within the statistical granularity, the number of 2xx status codes returned by the backend server. This metric is an exclusive indicator for layer-7 listeners. | Count/minute     | 60s, 300s, 3600s     |
| `Http3xx`             | 3xx status codes                 | Within the statistical granularity, the number of 3xx status codes returned by the backend server. This metric is an exclusive indicator for layer-7 listeners. | Count/minute     | 60s, 300s, 3600s     |
| `Http4xx`             | 4xx status codes             | Within the statistical granularity, the number of 4xx status codes returned by the backend server. This metric is an exclusive indicator for layer-7 listeners. | Count/minute | 60s, 300s, 3600s |
| `Http5xx`             | 5xx status codes                 | Within the statistical granularity, the number of 5xx status codes returned by the backend server. This metric is an exclusive indicator for layer-7 listeners. | Count/minute     | 60s, 300s, 3600s     |
| `UnhealthRsCount`     | Health check anomaly count             | Within the statistical period, the number of health check anomalies for the load balancer.                   | Count          | 60s, 300s            |
| `InDropBits`          | Dropped incoming bandwidth | Within the statistical granularity, the number of requests dropped on the load balancer or listener. This metric is an exclusive indicator for layer-7 listeners. This metric is only supported for standard account types, not traditional account types. For determining the account type, refer to [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}.| Bytes | 60s, 300s, 3600s |
| `OutDropBits`         | Dropped outgoing bandwidth | Within the statistical granularity, the number of requests dropped on the load balancer or listener. This metric is an exclusive indicator for layer-7 listeners. This metric is only supported for standard account types, not traditional account types. For determining the account type, refer to [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. | Bytes | 60s, 300s, 3600s |
| `InDropPkts`          | Dropped incoming packets | Within the statistical granularity, the number of requests dropped on the load balancer or listener. This metric is an exclusive indicator for layer-7 listeners. This metric is only supported for standard account types, not traditional account types. For determining the account type, refer to [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. | Count/second | 60s, 300s, 3600s |
| `OutDropPkts`         | Dropped outgoing packets | Within the statistical granularity, the number of requests dropped on the load balancer or listener. This metric is an exclusive indicator for layer-7 listeners. This metric is only supported for standard account types, not traditional account types. For determining the account type, refer to [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. | Count/second | 60s, 300s, 3600s |
| `DropQps`             | Dropped QPS | Within the statistical granularity, the number of requests dropped on the load balancer or listener. This metric is an exclusive indicator for layer-7 listeners. This metric is only supported for standard account types, not traditional account types. For determining the account type, refer to [Determine Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. | Count | 60s, 300s |

## Objects {#object}
The structure of the collected Tencent Cloud CLB Public object data, which can be viewed in "Infrastructure - Custom"

```json
{
  "measurement": "tencentcloud_clb",
  "tags": {
    "name"            : "lb-xxxx",
    "RegionId"        : "ap-shanghai",
    "LoadBalancerId"  : "lb-xxxx",
    "LoadBalancerName": "lb-xxxx",
    "Address"         : "81.xxxx",
    "LoadBalancerType": "Public",
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