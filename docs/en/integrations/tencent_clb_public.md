---
title: 'Tencent Cloud CLB Public'
tags: 
  - Tencent Cloud
summary: 'Use the script packages in the script market of the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/tencent_clb'
dashboard:

  - desc: 'Built-in view for Tencent Cloud CLB Public'
    path: 'dashboard/en/tencent_clb_public'

monitor:
  - desc: 'Tencent Cloud CLB Public Monitor'
    path: 'monitor/en/tencent_clb_public'

---


<!-- markdownlint-disable MD025 -->
# Tencent Cloud CLB Public
<!-- markdownlint-enable -->

Use the script packages in the script market of the "Guance Cloud Sync" series to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable Guance Integration - Extension - DataFlux Func (Automata): All prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Deploy Func on Your Own](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize monitoring data for CLB_Public cloud resources, install the corresponding collection script: "Guance Integration (Tencent Cloud CLB Collection)" (ID: `guance_tencentcloud_clb`)

Click [Install], then enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Additionally, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click [Execute] to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations. For more details, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any abnormalities.
2. On the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Details of Tencent Cloud Cloud Monitoring Metrics](https://cloud.tencent.com/document/product/248/51898){:target="_blank"}

| Metric Name          | Metric Description                                                     | Unit        | Statistical Granularity             |
| ------------------- | ------------------------------------------------------------ | ----------- | -------------------- |
| `ClientConnum`        | Number of active connections from client to LB   | Count          | 10s、60s、300s       |
| `ClientInactiveConn`  | Number of inactive connections from client to LB | Count          | 10s、60s、300s       |
| `ClientConcurConn`    | Number of concurrent connections from client to LB   | Count          | 10s、60s、300s       |
| `ClientNewConn`       | Number of new connections from client to LB   | Connections per second     | 10s、60s、300s       |
| `ClientInpkg`         | Number of inbound packets from client to LB       | Packets per second       | 10s、60s、300s       |
| `ClientOutpkg`        | Number of outbound packets from client to LB       | Packets per second       | 10s、60s、300s       |
| `ClientAccIntraffic`  | Amount of inbound traffic from client to LB       | MB          | 10s、60s、300s       |
| `ClientAccOuttraffic` | Amount of outbound traffic from client to LB       | MB          | 10s、60s、300s       |
| `ClientIntraffic`     | Inbound bandwidth from client to LB       | Mbps        | 10s、60s、300s       |
| `ClientOuttraffic`    | Outbound bandwidth from client to LB       | Mbps        | 10s、60s、300s       |
| `InTraffic`           | Inbound bandwidth from LB to backend RS          | Mbps        | 10s、60s、300s、3600 |
| `OutTraffic`          | Outbound bandwidth from backend RS to LB          | Mbps        | 10s、60s、300s、3600 |
| `InPkg`               | Number of inbound packets from LB to backend RS          | Packets per second       | 10s、60s、300s、3600 |
| `OutPkg`              | Number of outbound packets from backend RS to LB          | Packets per second       | 10s、60s、300s、3600 |
| `ConNum`              | Number of connections from LB to backend RS          | Count          | 60s、300s、3600s     |
| `NewConn`             | Number of new connections from LB to backend RS      | Connections per minute     | 60s、300s、3600s     |
| `DropTotalConns`      | Number of dropped connections                 | Count          | 60s、300s、3600s     |
| `IntrafficVipRatio`   | Inbound bandwidth utilization               | %           | 60s、300s、3600s     |
| `OuttrafficVipRatio`  | Outbound bandwidth utilization               | ％          | 60s、300s、3600s     |
| `ReqAvg`              | Average request time               | Milliseconds        | 60s、300s、3600s     |
| `ReqMax`              | Maximum request time               | Milliseconds        | 60s、300s、3600s     |
| `RspAvg`              | Average response time               | Milliseconds        | 60s、300s、3600s     |
| `RspMax`              | Maximum response time               | Milliseconds        | 60s、300s、3600s     |
| `RspTimeout`          | Number of response timeouts               | Counts per minute     | 60s、300s、3600s     |
| `SuccReq`             | Number of successful requests per minute           | Counts per minute     | 60s、300s、3600s     |
| `TotalReq`            | Number of requests per second                 | Count          | 60s、300s、3600s     |
| `ClbHttp3xx`          | Number of 3xx status codes returned by CLB      | Counts per minute     | 60s、300s、3600s     |
| `ClbHttp4xx`          | Number of 4xx status codes returned by CLB      | Counts per minute     | 60s、300s、3600s     |
| `ClbHttp5xx`          | Number of 5xx status codes returned by CLB      | Counts per minute     | 60s、300s、3600s     |
| `Http2xx`             | Number of 2xx status codes returned by backend server                 | Counts per minute     | 60s、300s、3600s     |
| `Http3xx`             | Number of 3xx status codes returned by backend server                 | Counts per minute     | 60s、300s、3600s     |
| `Http4xx`             | Number of 4xx status codes returned by backend server             | Counts per minute | 60s、300s、3600s |
| `Http5xx`             | Number of 5xx status codes returned by backend server                 | Counts per minute     | 60s、300s、3600s     |
| `UnhealthRsCount`     | Number of unhealthy checks             | Count          | 60s、300s            |
| `InDropBits`          | Dropped inbound bandwidth | Number of dropped requests on LB or listener. This metric is unique to Layer 7 listeners and only supported by standard account types, not traditional account types. Account type judgment method can be found at [Judge Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}.| Bytes | 60s、300s、3600s |
| `OutDropBits`         | Dropped outbound bandwidth | Number of dropped requests on LB or listener. This metric is unique to Layer 7 listeners and only supported by standard account types, not traditional account types. Account type judgment method can be found at [Judge Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"} | Bytes | 60s、300s、3600s |
| `InDropPkts`          | Dropped inbound packets | Number of dropped requests on LB or listener. This metric is unique to Layer 7 listeners and only supported by standard account types, not traditional account types. Account type judgment method can be found at [Judge Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"} | Packets per second | 60s、300s、3600s |
| `OutDropPkts`         | Dropped outbound packets | Number of dropped requests on LB or listener. This metric is unique to Layer 7 listeners and only supported by standard account types, not traditional account types. Account type judgment method can be found at [Judge Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"} | Packets per second | 60s、300s、3600s |
| `DropQps`             | Dropped QPS | Number of dropped requests on LB or listener. This metric is unique to Layer 7 listeners and only supported by standard account types, not traditional account types. Account type judgment method can be found at [Judge Account Type](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"} | Count | 60s、300s |

## Objects {#object}
The structure of collected Tencent Cloud CLB Public object data, which can be seen in "Infrastructure - Custom"

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
