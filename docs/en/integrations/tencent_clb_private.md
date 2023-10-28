---
title: 'Tencent CLB Private'
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/tencent_clb'
dashboard:

  - desc: 'Tencent Cloud CLB Private Monitoring View'
    path: 'dashboard/zh/tencent_clb_private'

monitor:
  - desc: 'Tencent Cloud CLB Private Monitor'
    path: 'monitor/zh/tencent_clb_private'

---


<!-- markdownlint-disable MD025 -->
# Tencent CLB Private
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to monitor the cloud ,The data of the cloud asset is synchronized to the observation cloud。


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Tencent AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  Tencent CLB Private resources, we install the corresponding collection script：「Guance Integration（Tencent Cloud - CLBCollect）」(ID：`guance_tencentcloud_clb`)

Click 【Install】 and enter the corresponding parameters: Tencent AK, Tencent account name.。

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

In addition, the corresponding automatic trigger configuration is displayed in「Management / Crontab Config」。tap【Run】，It can be executed immediately once, without waiting for a periodic time。After a while, you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Tencent Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Tencent Cloud Monitor Metrics Details](https://cloud.tencent.com/document/product/248/51899){:target="_blank"}

| English index name      | Chinese index name                 | Metric specification                                                    | Unit   | Statistical granularity         |
| ---------- | -------------------------- | ------------------------------------------------------------ |--------| ---------------- |
| `ClientConnum` | Number of active connections from client to LB   | The number of active connections from the client to the load balancer or listener at a given time in the statistical granularity. | Number | 10s, 60s, 300s   |
| `ClientInactiveConn` | Number of inactive connections from client to LB | The number of inactive connections from the client to the load balancer or listener at a given time in the statistical granularity. | Number | 10s, 60s, 300s   |
| `ClientConcurConn` | Number of concurrent connections from client to LB   | The number of concurrent connections from the client to the load balancer or listener at a time in the statistical granularity. | Number | 10s, 60s, 300s   |
| `ClientNewConn` | Number of new connections from client to LB   | The number of new connections from the client to the load balancer or listener in the statistical granularity.     | Number/Second | 10s, 60s, 300s   |
| `ClientInpkg` | Packet input rate from client to LB       | Indicates the number of packets sent by the client to the load balancer per second in the statistics granularity.         | Number/Second | 10s, 60s, 300s   |
| `ClientOutpkg` | Packet output rate from client to LB       | In the statistics granularity, load balancing indicates the number of packets sent to clients per second.         | Number/Second | 10s, 60s, 300s   |
| `ClientAccIntraffic` | Inbound traffic from client to LB       | Indicates the inbound traffic of clients to load balancing in the statistics granularity.                   | MB     | 10s, 60s, 300s   |
| `ClientAccOuttraffic` | Outbound traffic from client to LB       | In the statistics period, load balancing indicates the outgoing traffic to clients.                   | MB     | 10s, 60s, 300s   |
| `ClientOuttraffic` | Outbound bandwidth from client to LB       | Bandwidth used by load balancing to send packets to clients in the statistics granularity.               | Mbps   | 10s, 60s, 300s   |
| `ClientIntraffic` | Inbound bandwidth from client to LB       | Bandwidth that the client sends to load balancing in the statistics period.                   | Mbps   | 10s, 60s, 300s   |
| `OutTraffic` | Outbound bandwidth from LB to backend          | Bandwidth used by the back-end RS to flow out to load balancing in the statistical granularity.             | Mbps   | 60s, 300s        |
| `InTraffic`  | Inbound bandwidth from LB to backend          | Within the statistical granularity, the bandwidth used by load balancing to flow into the back-end RS.             | Mbps   | 60s, 300s        |
| `OutPkg`     | Packet output rate from LB to backend          | The number of packets sent by the back-end RS to the load balancer per second in the statistical granularity.       | Number/Second | 60s, 300s        |
| `InPkg`      | Packet input rate from LB to backend          | In the statistical granularity, the load balances the number of packets sent per second to the back-end RS.       | Number/Second | 60s, 300s        |
| `ConNum`     | Number of connections from LB to backend          | The number of connections from load balancing to back-end RS within the statistical granularity.                 | Number | 60s, 300s        |
| `NewConn`    | Number of new connections from LB to backend      | The number of new connections from load balancing to back-end RS in the statistical granularity.             | Number/Second | 60s, 300s        |
| `DropTotalConns` | Number of dropped connections                 | The number of connections dropped on the load balancer or listener in the statistical granularity. This metric is supported only for standard accounts, but not for traditional accounts. For details about how to determine an account type, see [Determine account type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. | Number | 10s, 60s, 300s   |
| `InDropBits` | Dropped inbound bandwidth                 | In the statistics period, bandwidth discarded when the client accesses the load balancer through the Intranet. This metric is supported only for standard accounts, but not for traditional accounts. For details about how to determine an account type, see [Determine account type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. | Byte   | 10s, 60s, 300s   |
| `OutDropBits` | Dropped outbound bandwidth                 | Bandwidth discarded when the load balancer accesses the Intranet in the statistics period. This metric is supported only for standard accounts, but not for traditional accounts. For details about how to determine an account type, see [Determine account type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. | Byte   | 10s, 60s, 300s   |
| `InDropPkts` | Dropped inbound data packets             | In the statistics period, packets discarded by clients accessing load balancing through the Intranet are displayed. This metric is supported only for standard accounts, but not for traditional accounts. For details about how to determine an account type, see [Determine account type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. | Number/Second | 10s, 60s, 300s   |
| `OutDropPkts` | Dropped outbound data packets             | In the statistics period, the load balancer discarded packets when accessing the Intranet. This metric is supported only for standard accounts, but not for traditional accounts. For details about how to determine an account type, see [Determine account type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. | Number/Second    | 10s, 60s, 300s   |
| `DropQps`    | Dropped QPS                   | The number of requests dropped on the load balancer or listener in the statistical granularity. This metric is unique to Layer 7 listeners. This metric is supported only for standard accounts, but not for traditional accounts. For details about how to determine an account type, see [Determine account type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. | Number      | 60s, 300s        |
| `IntrafficVipRatio` | Inbound bandwidth utilization rate               | Bandwidth usage used by clients to access load balancing through the Intranet in the statistics granularity. This metric is supported only for standard accounts, but not for traditional accounts. For details about how to determine an account type, see [Determine account type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. This metric is in the beta test stage, if you need to use it, please submit a [work order application](https://console.cloud.tencent.com/workorder/category?level1_id=6&level2_id=163&source=0&data_title=负载均衡CLB&level3_id=1071&queue=96&scene_code=34639&step=2){:target="_blank"}. | %      | 10s, 60s, 300s   |
| `OuttrafficVipRatio` | Outbound bandwidth utilization rate               | Bandwidth usage used by load balancing to access the Intranet in the statistics period. This metric is supported only for standard accounts, but not for traditional accounts. For details about how to determine an account type, see [Determine account type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}. This metric is in the beta test stage, if you need to use it, please submit a [work order application](https://console.cloud.tencent.com/workorder/category?level1_id=6&level2_id=163&source=0&data_title=负载均衡CLB&level3_id=1071&queue=96&scene_code=34639&step=2){:target="_blank"}. | %      | 10s, 60s, 300s   |
| `ReqAvg`     | Average request time               | Average request time for load balancing in the statistics granularity. This metric is unique to Layer 7 listeners. | Millisecond     | 60s, 300s        |
| `ReqMax`     | Maximum request time               | Maximum request time for load balancing in the statistics granularity. This metric is unique to Layer 7 listeners. | Millisecond     | 60s, 300s        |
| `RspAvg`     | Average response time               | The average response time of load balancing in the statistical granularity. This metric is unique to Layer 7 listeners. | Millisecond     | 60s, 300s        |
| `RspMax`     | Maximum response time               | Maximum response time of load balancing in the statistics granularity. This metric is unique to Layer 7 listeners. | Millisecond     | 60s, 300s        |
| `RspTimeout` | Number of response timeouts               | Indicates the number of load balancing response timeouts in the statistics period. This metric is unique to Layer 7 listeners. | Number/Minute   | 60s, 300s        |
| `SuccReq`    | Number of successful requests per minute           | Indicates the number of successful requests balanced per minute in the statistics period. This metric is unique to Layer 7 listeners. | Number/Minute  | 60s, 300s        |
| `TotalReq`   | Number of requests per second                 | Number of load balancing requests per second in the statistics granularity. This metric is unique to Layer 7 listeners. | Number      | 60s, 300s        |
| `ClbHttp3xx` | Number of 3xx status codes returned by CLB      | In the statistics granularity, the number of 3xx status codes returned by the load balancer (sum of the load balancer and back-end server return codes). This metric is unique to Layer 7 listeners. | Number/Minute  | 60s, 300s        |
| `ClbHttp4xx` | Number of 4xx status codes returned by CLB      | In the statistics granularity, the number of 4xx status codes returned by the load balancer (sum of the load balancer and back-end server return codes). This metric is unique to Layer 7 listeners. | Number/Minute  | 60s, 300s        |
| `ClbHttp5xx` | Number of 5xx status codes returned by CLB      | In the statistics granularity, the number of 5xx status codes returned by the load balancer (sum of the load balancer and back-end server return codes). This metric is unique to Layer 7 listeners. | Number/Minute  | 60s, 300s        |
| `Http2xx`    | Number of 2xx status codes                 | Indicates the number of 2xx status codes returned by the back-end server in the statistics granularity. This metric is unique to Layer 7 listeners. | Number/Minute  | 60s, 300s        |
| `Http3xx`    | Number of 3xx status codes                 | Indicates the number of 3xx status codes returned by the back-end server in the statistics granularity. This metric is unique to Layer 7 listeners. | Number/Minute  | 60s, 300s        |
| `Http4xx`    | Number of 4xx status codes                 | Indicates the number of 4xx status codes returned by the back-end server in the statistics granularity. This metric is unique to Layer 7 listeners. | Number/Minute  | 60s, 300s        |
| `Http5xx`    | Number of 5xx status codes                 | Indicates the number of 5xx status codes returned by the back-end server in the statistics granularity. This metric is unique to Layer 7 listeners. | Number/Minute  | 60s, 300s        |
| `UnhealthRsCount` | Number of health check anomalies             | Number of health check anomalies of load balancing in the statistical period. Procedure.                   | Number      | 60s, 300s        |

## Object {#object}
The collected Tencent Cloud CLB Private object data structure can be seen from the「Infrastructure-Custom」object data

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

