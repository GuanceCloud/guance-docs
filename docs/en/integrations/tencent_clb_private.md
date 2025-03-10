---
title: 'Tencent Cloud CLB Private'
tags: 
  - Tencent Cloud
summary: 'Use the script packages in the script market of the Guance cloud synchronization series to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/tencent_clb'
dashboard:

  - desc: 'Tencent Cloud CLB Private built-in view'
    path: 'dashboard/zh/tencent_clb_private'

monitor:
  - desc: 'Tencent Cloud CLB Private monitor'
    path: 'monitor/zh/tencent_clb_private'

---


<!-- markdownlint-disable MD025 -->
# Tencent Cloud CLB Private
<!-- markdownlint-enable -->

Use the script packages in the script market of the Guance cloud synchronization series to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation

If you deploy Func on your own, refer to [Deploy Func on Your Own](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant read-only access `ReadOnlyAccess`)

To synchronize the monitoring data of Tencent Cloud CLB, we install the corresponding collection script: "Guance Integration (Tencent Cloud-CLB Collection)" (ID: `guance_tencentcloud_clb`)

After clicking 【Install】, enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

Additionally, you can see the corresponding automatic trigger configuration in the "Management / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. Wait a moment, you can check the execution task records and corresponding logs.

By default, we collect some configurations, see the metrics section for details [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding automatic trigger configuration exists for the task, and check the task records and logs for any abnormalities.
2. On the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Tencent Cloud Cloud Monitoring Metric Details](https://cloud.tencent.com/document/product/248/51899){:target="_blank"}

| Metric Name      | Description                                                     | Unit    | Statistical Granularity |
| ---------- | ------------------------------------------------------------ | ------- | ---------------- |
| `ClientConnum` | Number of active connections from client to LB   | Count      | 10s、60s、300s   |
| `ClientInactiveConn` | Number of inactive connections from client to LB | Count      | 10s、60s、300s   |
| `ClientConcurConn` | Number of concurrent connections from client to LB   | Count      | 10s、60s、300s   |
| `ClientNewConn` | Number of new connections from client to LB   | Count/Second   | 10s、60s、300s   |
| `ClientInpkg` | Number of incoming packets from client to LB       | Count/Second   | 10s、60s、300s   |
| `ClientOutpkg` | Number of outgoing packets from client to LB       | Count/Second   | 10s、60s、300s   |
| `ClientAccIntraffic` | Amount of incoming traffic from client to LB       | MB      | 10s、60s、300s   |
| `ClientAccOuttraffic` | Amount of outgoing traffic from client to LB       | MB      | 10s、60s、300s   |
| `ClientOuttraffic` | Outbound bandwidth from LB to client       | Mbps    | 10s、60s、300s   |
| `ClientIntraffic` | Inbound bandwidth from client to LB       | Mbps    | 10s、60s、300s   |
| `OutTraffic` | Outbound bandwidth from LB to backend          | Mbps    | 60s、300s        |
| `InTraffic` | Inbound bandwidth from LB to backend          | Mbps    | 60s、300s        |
| `OutPkg`   | Number of outgoing packets from LB to backend          | Count/Second   | 60s、300s        |
| `InPkg`    | Number of incoming packets from LB to backend          | Count/Second   | 60s、300s        |
| `ConNum`   | Number of connections from LB to backend          | Count      | 60s、300s        |
| `NewConn`  | Number of new connections from LB to backend      | Count/Minute | 60s、300s        |
| `DropTotalConns` | Number of dropped connections                 | Count      | 10s、60s、300s   |
| `InDropBits` | Dropped inbound bandwidth                 | Bytes    | 10s、60s、300s   |
| `OutDropBits` | Dropped outbound bandwidth                 | Bytes    | 10s、60s、300s   |
| `InDropPkts` | Dropped incoming packets             | Count/Second   | 10s、60s、300s   |
| `OutDropPkts` | Dropped outgoing packets             | Count/Second   | 10s、60s、300s   |
| `DropQps`  | Dropped QPS                   | Count      | 60s、300s        |
| `IntrafficVipRatio` | Inbound bandwidth utilization               | %       | 10s、60s、300s   |
| `OuttrafficVipRatio` | Outbound bandwidth utilization               | ％      | 10s、60s、300s   |
| `ReqAvg`   | Average request time               | Milliseconds    | 60s、300s        |
| `ReqMax`   | Maximum request time               | Milliseconds    | 60s、300s        |
| `RspAvg`   | Average response time               | Milliseconds    | 60s、300s        |
| `RspMax`   | Maximum response time               | Milliseconds    | 60s、300s        |
| `RspTimeout` | Number of response timeouts               | Count/Minute | 60s、300s        |
| `SuccReq`  | Successful requests per minute           | Count/Minute | 60s、300s        |
| `TotalReq` | Requests per second                 | Count      | 60s、300s        |
| `ClbHttp3xx` | Number of 3xx status codes returned by CLB      | Count/Minute | 60s、300s        |
| `ClbHttp4xx` | Number of 4xx status codes returned by CLB      | Count/Minute | 60s、300s        |
| `ClbHttp5xx` | Number of 5xx status codes returned by CLB      | Count/Minute | 60s、300s        |
| `Http2xx`  | Number of 2xx status codes                 | Count/Minute | 60s、300s        |
| `Http3xx`  | Number of 3xx status codes                 | Count/Minute | 60s、300s        |
| `Http4xx`  | Number of 4xx status codes                 | Count/Minute | 60s、300s        |
| `Http5xx`  | Number of 5xx status codes                 | Count/Minute | 60s、300s        |
| `UnhealthRsCount` | Number of unhealthy health checks             | Count      | 60s、300s        |

## Objects {#object}
The collected Tencent Cloud CLB Private object data structure can be viewed in "Infrastructure - Custom"

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