---
title: 'Tencent CLB Private'
summary: 'Use the「观测云云同步」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/tencent_clb'
dashboard:

  - desc: '腾讯云 CLB Private 内置视图'
    path: 'dashboard/zh/tencent_clb_private'

monitor:
  - desc: '腾讯云 CLB Private 监控器'
    path: 'monitor/zh/tencent_clb_private'

---


<!-- markdownlint-disable MD025 -->
# Tencent CLB Private
<!-- markdownlint-enable -->

Use the「Guance Cloud Synchronization」series script package in the script market to monitor the cloud ,The data of the cloud asset is synchronized to the observation cloud。


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Tencent AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  Tencent CLB Private resources, we install the corresponding collection script：「观测云集成（腾讯云-CLB采集）」(ID：`guance_tencentcloud_clb`)

Click 【Install】 and enter the corresponding parameters: Tencent AK, Tencent account name.。

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

In addition, the corresponding automatic trigger configuration is displayed in「Management / Crontab Config」。tap【Run】，It can be executed immediately once, without waiting for a periodic time。After a while, you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Tencent Cloud - cloud monitoring. The default indicator set is as follows. You can collect more indicators by configuring them [Tencent Cloud Monitor Metrics Details](https://cloud.tencent.com/document/product/248/51899){:target="_blank"}

| Index English name      | Index Chinese name                 | Indicator specification                                                    | unit   | Statistical granularity         |
| ---------- | -------------------------- | ------------------------------------------------------------ |--------| ---------------- |
| ClientConnum | 客户端到 LB 的活跃连接数   | The number of active connections from the client to the load balancer or listener at a given time in the statistical granularity. | number | 10s、60s、300s   |
| ClientInactiveConn | 客户端到 LB 的非活跃连接数 | The number of inactive connections from the client to the load balancer or listener at a given time in the statistical granularity。 | number | 10s、60s、300s   |
| ClientConcurConn | 客户端到 LB 的并发连接数   | The number of concurrent connections from the client to the load balancer or listener at a time in the statistical granularity。 | number | 10s、60s、300s   |
| ClientNewConn | 客户端到 LB 的新建连接数   | The number of new connections from the client to the load balancer or listener in the statistical granularity。     | number/s | 10s、60s、300s   |
| ClientInpkg | 客户端到 LB 的入包量       | Indicates the number of packets sent by the client to the load balancer per second in the statistics granularity。         | number/s | 10s、60s、300s   |
| ClientOutpkg | 客户端到 LB 的出包量       | In the statistics granularity, load balancing indicates the number of packets sent to clients per second。         | number/s | 10s、60s、300s   |
| ClientAccIntraffic | 客户端到 LB 的入流量       | Indicates the inbound traffic of clients to load balancing in the statistics granularity。                   | MB     | 10s、60s、300s   |
| ClientAccOuttraffic | 客户端到 LB 的出流量       | In the statistics period, load balancing indicates the outgoing traffic to clients。                   | MB     | 10s、60s、300s   |
| ClientOuttraffic | 客户端到 LB 的出带宽       | Bandwidth used by load balancing to send packets to clients in the statistics granularity。               | Mbps   | 10s、60s、300s   |
| ClientIntraffic | 客户端到 LB 的入带宽       | Bandwidth that the client sends to load balancing in the statistics period。                   | Mbps   | 10s、60s、300s   |
| OutTraffic | LB 到后端的出带宽          | Bandwidth used by the back-end RS to flow out to load balancing in the statistical granularity。             | Mbps   | 60s、300s        |
| InTraffic  | LB 到后端的入带宽          | Within the statistical granularity, the bandwidth used by load balancing to flow into the back-end RS。             | Mbps   | 60s、300s        |
| OutPkg     | LB 到后端的出包量          | The number of packets sent by the back-end RS to the load balancer per second in the statistical granularity。       | number/s | 60s、300s        |
| InPkg      | LB 到后端的入包量          | In the statistical granularity, the load balances the number of packets sent per second to the back-end RS。       | number/s | 60s、300s        |
| ConNum     | LB 到后端的连接数          | The number of connections from load balancing to back-end RS within the statistical granularity。                 | number | 60s、300s        |
| NewConn    | LB 到后端的新建连接数      | The number of new connections from load balancing to back-end RS in the statistical granularity。             | number/s | 60s、300s        |
| DropTotalConns | 丢弃连接数                 | The number of connections dropped on the load balancer or listener in the statistical granularity. This indicator is supported only for standard accounts, but not for traditional accounts. For details about how to determine an account type, see [判断账户类型](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}。 | number | 10s、60s、300s   |
| InDropBits | 丢弃入带宽                 | In the statistics period, bandwidth discarded when the client accesses the load balancer through the Intranet. This indicator is supported only for standard accounts, but not for traditional accounts. For details about how to determine an account type, see [判断账户类型](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}。 | byte   | 10s、60s、300s   |
| OutDropBits | 丢弃出带宽                 | Bandwidth discarded when the load balancer accesses the Intranet in the statistics period. This indicator is supported only for standard accounts, but not for traditional accounts. For details about how to determine an account type, see [判断账户类型](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}。 | byte   | 10s、60s、300s   |
| InDropPkts | 丢弃流入数据包             | In the statistics period, packets discarded by clients accessing load balancing through the Intranet are displayed. This indicator is supported only for standard accounts, but not for traditional accounts. For details about how to determine an account type, see [判断账户类型](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}。 | number/s | 10s、60s、300s   |
| OutDropPkts | 丢弃流出数据包             | In the statistics period, the load balancer discarded packets when accessing the Intranet. This indicator is supported only for standard accounts, but not for traditional accounts. For details about how to determine an account type, see [判断账户类型](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}。 | number/s    | 10s、60s、300s   |
| DropQps    | 丢弃 QPS                   | The number of requests dropped on the load balancer or listener in the statistical granularity. This indicator is unique to Layer 7 listeners. This indicator is supported only for standard accounts, but not for traditional accounts. For details about how to determine an account type, see [判断账户类型](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}。 | number      | 60s、300s        |
| IntrafficVipRatio | 入带宽利用率               | Bandwidth usage used by clients to access load balancing through the Intranet in the statistics granularity. This indicator is supported only for standard accounts, but not for traditional accounts. For details about how to determine an account type, see [判断账户类型](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}。此指标处于内测阶段，如需使用，请提交 [工单申请](https://console.cloud.tencent.com/workorder/category?level1_id=6&level2_id=163&source=0&data_title=负载均衡CLB&level3_id=1071&queue=96&scene_code=34639&step=2){:target="_blank"}。 | %      | 10s、60s、300s   |
| OuttrafficVipRatio | 出带宽利用率               | Bandwidth usage used by load balancing to access the Intranet in the statistics period. This indicator is supported only for standard accounts, but not for traditional accounts. For details about how to determine an account type, see [判断账户类型](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}。此指标处于内测阶段，如需使用，请提交 [工单申请](https://console.cloud.tencent.com/workorder/category?level1_id=6&level2_id=163&source=0&data_title=负载均衡CLB&level3_id=1071&queue=96&scene_code=34639&step=2){:target="_blank"}。 | ％      | 10s、60s、300s   |
| ReqAvg     | 平均请求时间               | Average request time for load balancing in the statistics granularity. This indicator is unique to Layer 7 listeners。 | ms     | 60s、300s        |
| ReqMax     | 最大请求时间               | Maximum request time for load balancing in the statistics granularity. This indicator is unique to Layer 7 listeners。 | ms     | 60s、300s        |
| RspAvg     | 平均响应时间               | The average response time of load balancing in the statistical granularity. This indicator is unique to Layer 7 listeners。 | ms     | 60s、300s        |
| RspMax     | 最大响应时间               | Maximum response time of load balancing in the statistics granularity. This indicator is unique to Layer 7 listeners。 | ms     | 60s、300s        |
| RspTimeout | 响应超时个数               | Indicates the number of load balancing response timeouts in the statistics period. This indicator is unique to Layer 7 listeners。 |number/min   | 60s、300s        |
| SuccReq    | 每分钟成功请求数           | Indicates the number of successful requests balanced per minute in the statistics period. This indicator is unique to Layer 7 listeners。 | number/min  | 60s、300s        |
| TotalReq   | 每秒请求数                 | Number of load balancing requests per second in the statistics granularity. This indicator is unique to Layer 7 listeners。 | number      | 60s、300s        |
| ClbHttp3xx | CLB 返回的 3xx 状态码      | In the statistics granularity, the number of 3xx status codes returned by the load balancer (sum of the load balancer and back-end server return codes). This indicator is unique to Layer 7 listeners。 | number/min  | 60s、300s        |
| ClbHttp4xx | CLB 返回的 4xx 状态码      | In the statistics granularity, the number of 4xx status codes returned by the load balancer (sum of the load balancer and back-end server return codes). This indicator is unique to Layer 7 listeners。 | number/min  | 60s、300s        |
| ClbHttp5xx | CLB 返回的 5xx 状态码      | In the statistics granularity, the number of 5xx status codes returned by the load balancer (sum of the load balancer and back-end server return codes). This indicator is unique to Layer 7 listeners。 | number/min  | 60s、300s        |
| Http2xx    | 2xx 状态码                 | Indicates the number of 2xx status codes returned by the back-end server in the statistics granularity. This indicator is unique to Layer 7 listeners。 | number/min  | 60s、300s        |
| Http3xx    | 3xx 状态码                 | Indicates the number of 3xx status codes returned by the back-end server in the statistics granularity. This indicator is unique to Layer 7 listeners。 | number/min  | 60s、300s        |
| Http4xx    | 4xx 状态码                 | Indicates the number of 4xx status codes returned by the back-end server in the statistics granularity. This indicator is unique to Layer 7 listeners。 | number/min  | 60s、300s        |
| Http5xx    | 5xx 状态码                 | Indicates the number of 5xx status codes returned by the back-end server in the statistics granularity. This indicator is unique to Layer 7 listeners。 | number/min  | 60s、300s        |
| UnhealthRsCount | 健康检查异常数             | Number of health check anomalies of load balancing in the statistical period. Procedure。                   | number      | 60s、300s        |

## Object {#object}
The collected Tencent Cloud CLB Private object data structure can be seen from the「基础设施-自定义」object data

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
    "listeners" : "{监听器 JSON 数据}",
    "message"   : "{实例 JSON 数据}"
  }
}
```

