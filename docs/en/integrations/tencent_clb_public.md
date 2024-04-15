---
title: 'Tencent Cloud CLB Public'
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/tencent_clb'
dashboard:

  - desc: 'Tencent Cloud CLB Public Monitoring View'
    path: 'dashboard/zh/tencent_clb_public'

monitor:
  - desc: 'Tencent Cloud CLB Public Monitor'
    path: 'monitor/zh/tencent_clb_public'

---


<!-- markdownlint-disable MD025 -->
# Tencent CLB Public
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.


## config {#config}

### Install Func

Recommend opening「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script
> Tip：Please prepare Tencent Cloud AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of CLB Public cloud resources, we install the corresponding collection script：「Guance Integration（Tencent Cloud CLBCollect）」(ID：`guance_tencentcloud_clb`)

Click 【Install】 and enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.。

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Configure Tencent Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Tencent Cloud Monitor Metrics Details](https://www.tencentcloud.com/document/product/248/10997){:target="_blank"}


| Parameter          | Metric                 | Description                                                     | Unit        | Statistical Granularity             |
| ------------------- | -------------------------- | ------------------------------------------------------------ | ----------- | -------------------- |
| `ClientConnum`        | Client-CLB active connections | Number of active connections initiated from the client to the CLB instance or listener at a certain time point in the statistical period. | -         | 10s、60s、300s       |
| `ClientInactiveConn`  | Client-CLB inactive connections | Number of inactive connections initiated from the client to the CLB instance or listener at a certain time point in the statistical period. | -          | 10s、60s、300s       |
| `ClientConcurConn`    | Client-CLB concurrent connections | Number of concurrent connections initiated from the client to the CLB instance or listener at a certain time point in the statistical period. | -          | 10s、60s、300s       |
| `ClientNewConn`       | Client-CLB new connections | Number of new connections initiated from the client to the CLB instance in the statistical period. | -      | 10s、60s、300s       |
| `ClientInpkg`         | Client-CLB inbound packets | Number of data packets sent from the client to the CLB instance per second in the statistical period. | Count/s | 10s、60s、300s       |
| `ClientOutpkg`        | Client-CLB outbound packets | Number of data packets sent from the CLB instance to the client per second in the statistical period. | Count/s | 10s、60s、300s       |
| `ClientAccIntraffic`  | Client-CLB inbound traffic | Volume of inbound traffic from the client to the CLB instance in the statistical period. | MB          | 10s、60s、300s       |
| `ClientAccOuttraffic` | Client-CLB outbound traffic | Volume of outbound traffic from the CLB instance to the client in the statistical period. | MB          | 10s、60s、300s       |
| `ClientIntraffic`     | Client-CLB inbound bandwidth | Inbound bandwidth used by the traffic from the client to the CLB instance in the statistical period. | Mbps        | 10s、60s、300s       |
| `ClientOuttraffic`    | Client-CLB outbound bandwidth | Outbound bandwidth used by the traffic from the CLB instance to the client in the statistical period. | Mbps        | 10s、60s、300s       |
| `InTraffic`           | CLB-real server inbound bandwidth | Inbound bandwidth used by the traffic from the CLB instance to real servers in the statistical period. | Mbps        | 10s、60s、300s、3600 |
| `OutTraffic`          | CLB-real server outbound bandwidth | Outbound bandwidth used by the traffic from real servers to the CLB instance in the statistical period. | Mbps        | 10s、60s、300s、3600 |
| `InPkg`               | CLB-real server inbound packets | Number of data packets sent from the CLB instance to real servers per second in the statistical period. | Count/s | 10s、60s、300s、3600 |
| `OutPkg`              | CLB-real server outbound packets | Number of data packets sent from real servers to the CLB instance per second in the statistical period. | Count/s | 10s、60s、300s、3600 |
| `ConNum`              | CLB-real server connections | Number of connections initiated from the CLB instance to real servers in the statistical period. | -          | 60s、300s、3600s     |
| `NewConn`             | CLB-real server new connections | Number of new connections initiated from the CLB instance to real servers in the statistical period. | Count/min | 60s、300s、3600s     |
| `DropTotalConns`      | Dropped connections | Number of connections dropped by the CLB instance or listener in the statistical period.This metric is supported by only standard accounts but not traditional accounts. | -          | 60s、300s、3600s     |
| `IntrafficVipRatio`   | Inbound bandwidth utilization | Utilization of the bandwidth for the client to access the CLB instance over the public network in the statistical period.This metric is supported by only standard accounts but not traditional accounts. It is currently in beta test. To try it out, [submit a ticket](https://console.tencentcloud.com/workorder/category) {:target="_blank"} for application. | %           | 60s、300s、3600s     |
| `OuttrafficVipRatio`  | Outbound bandwidth utilization | Utilization of the bandwidth for the client to access the CLB instance over the public network in the statistical period.This metric is supported by only standard accounts but not traditional accounts. It is currently in beta test. To try it out, [submit a ticket](https://console.tencentcloud.com/workorder/category) {:target="_blank"} for application. | ％          | 60s、300s、3600s     |
| `ReqAvg`              | Average request time | Average request time of the CLB instance in the statistical period.This metric is available to layer-7 listeners only. | ms      | 60s、300s、3600s     |
| `ReqMax`              | Maximum request time | Maximum request time of the CLB instance in the statistical period.This metric is available to layer-7 listeners only. | ms      | 60s、300s、3600s     |
| `RspAvg`              | Average response time | Average response time of the CLB instance in the statistical period.This metric is available to layer-7 listeners only. | ms      | 60s、300s、3600s     |
| `RspMax`              | Maximum response time | Maximum response time of the CLB instance in the statistical period.This metric is available to layer-7 listeners only. | ms      | 60s、300s、3600s     |
| `RspTimeout`          | Timed-out responses | Number of timed-out responses of the CLB instance per minute in the statistical period.This metric is available to layer-7 listeners only. | Count/min | 60s、300s、3600s     |
| `SuccReq`             | Successful requests per minute | Number of successful requests of the CLB instance per minute in the statistical period.This metric is available to layer-7 listeners only. | Count/min | 60s、300s、3600s     |
| `TotalReq`            | Requests per second | Number of requests of the CLB instance per second in the statistical period.This metric is available to layer-7 listeners only. | -          | 60s、300s、3600s     |
| `ClbHttp3xx`          | 3xx status codes returned by CLB | Total number of 3xx status codes returned by the CLB instance and real servers in the statistical period.This metric is available to layer-7 listeners only. | Count/min | 60s、300s、3600s     |
| `ClbHttp4xx`          | 4xx status codes returned by CLB | Total number of 4xx status codes returned by the CLB instance and real servers in the statistical period.This metric is available to layer-7 listeners only. | Count/min | 60s、300s、3600s     |
| `ClbHttp5xx`          | 5xx status codes returned by CLB | Total number of 5xx status codes returned by the CLB instance and real servers in the statistical period.This metric is available to layer-7 listeners only. | Count/min | 60s、300s、3600s     |
| `Http2xx`             | 2xx status codes | Number of 2xx status codes returned by real servers in the statistical period.This metric is available to layer-7 listeners only. | Count/min | 60s、300s、3600s     |
| `Http3xx`             | 3xx status codes | Number of 3xx status codes returned by real servers in the statistical period.This metric is available to layer-7 listeners only. | Count/min | 60s、300s、3600s     |
| `Http4xx`             | 4xx status codes | Number of 4xx status codes returned by real servers in the statistical period.This metric is available to layer-7 listeners only. | Count/min | 60s、300s、3600s |
| `Http5xx`             | 5xx status codes | Number of 5xx status codes returned by real servers in the statistical period.This metric is available to layer-7 listeners only. | Count/min | 60s、300s、3600s     |
| `UnhealthRsCount`     | Health check exceptions | Number of health check exceptions of the CLB instance in the statistical period. | -          | 60s、300s            |
| `InDropBits`          | Dropped inbound bandwidth | Bandwidth dropped when the client accesses CLB over the public network within a reference period.This metric is supported by only standard accounts but not traditional accounts. | Byte | 60s、300s、3600s |
| `OutDropBits`         | Dropped outbound traffic | Bandwidth dropped when the CLB instance accesses the public network in the statistical period.This metric is supported by only standard accounts but not traditional accounts. | Byte | 60s、300s、3600s |
| `InDropPkts`          | Dropped inbound packets | Number of data packets dropped when the client accesses the CLB instance over the public network in the statistical period.This metric is supported by only standard accounts. | Count/s | 60s、300s、3600s |
| `OutDropPkts`         | Dropped outbound packets | Number of data packets dropped when the CLB instance accesses the public network in the statistical period.This metric is supported by only standard accounts but not traditional accounts. | Count/s | 60s、300s、3600s |
| `DropQps`             | Dropped QPS | Number of requests dropped by the CLB instance or listener in the statistical period.This metric is available to layer-7 listeners only and supported by only standard accounts but not traditional accounts. | - | 60s、300s |

## 对象 {#object}

The collected Tencent Cloud ECS object data structure can see the object data from 「Infrastructure-Custom」

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
