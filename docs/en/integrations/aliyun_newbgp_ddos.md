---
title: 'Aliyun DDoS New BGP High Defense'
tags: 
  - Alibaba Cloud
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'
__int_icon: 'icon/aliyun_nat'
dashboard:
  - desc: 'Aliyun DDoS New BGP high defense Monitoring View'
    path: 'dashboard/zh/aliyun_newbgp_ddos/'

---

<!-- markdownlint-disable MD025 -->
# Aliyun DDoS New BGP High Defense
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）
> Tip: Before using this collector, you must install the 「Guance Integration Core 核心包」 and its supporting third-party dependencies.

To synchronize the monitoring data of DDoS New BGP High Defense cloud resources, we install the corresponding collection script：「Guance Integration（Aliyun -DDoS high defense Collect）」(ID：`guance_aliyun_ddoscoo`)

Click "Install" and enter the corresponding parameters: Aliyun AK, Aliyun account name.

Click "Deploy Startup Scripts", the system will automatically create the `Startup` script set and automatically configure the corresponding startup scripts.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click "Run"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs.

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Configure Aliyun - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Aliyun Monitor Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_newbgpddos/newbgpddos?){:target="_blank"}

| MetricName | Description  | Unit | Dimensions |
| ---- | --------------------  | :---: | :----: |
|`Active_connection`| Number of active connections  | count | userId,InstanceId,ip |
|`AttackTraffic`| High Defense IP Attack Traffic  | bit/s | userId,InstanceId,ip |
|`Back_Traffic`| High Defense IP **Backhaul** Traffic  | bit/s | userId,InstanceId,ip |
|`In_Traffic`| High Defense IP Incoming Traffic  | bit/s | userId,InstanceId,ip |
|`Inactive_connection`| Number of inactive connections  | count | userId,InstanceId,ip |
|`New_connection`| Number of new connections  | count | userId,InstanceId,ip |
|`Out_Traffic`| High-defense IP outgoing traffic  | bit/s | userId,InstanceId,ip |
|`qps`| QPS  | countS | userId,InstanceId,ip |
|`qps_ratio_down`| QPS Chained Rate of Decline  | % | userId,InstanceId,ip |
|`qps_ratio_up`| QPS chain growth rate  | % | userId,InstanceId,ip |
|`resp2xx`| 2XX status code  | count | userId,InstanceId,ip |
|`resp2xx_ratio`| 2XX Status Code Percentage  | % | userId,InstanceId,ip |
|`resp3xx`| 3XX Status Code  | count | userId,InstanceId,ip |
|`resp3xx_ratio`| 3XX Status Code Percentage  | % | userId,InstanceId,ip |
|`resp404`| 404 status code  | count | userId,InstanceId,ip |
|`resp404_ratio`| Percentage of 404 status codes  | % | userId,InstanceId,ip |
|`resp4xx`| 4XX Status Code  | count | userId,InstanceId,ip |
|`resp4xx_ratio`| 4XX Status Code Percentage  | % | userId,InstanceId,ip |
|`resp502`| 502 Status Code  | count | userId,InstanceId,ip |
|`resp503`| 503 Status Code  | count | userId,InstanceId,ip |
|`resp504`| 504 Status Code  | count | userId,InstanceId,ip |
|`resp5xx`| 5xx Status Code  | count | userId,InstanceId,ip |
|`resp5xx_ratio`| 5XX Status Code Percentage  | % | userId,InstanceId,ip |
|`upstream_resp2xx`| 2XX Back to Source Status Code  | count | userId,InstanceId,ip |
|`upstream_resp2xx_ratio`| 2XX Return to Source Status Code Percentage  | % | userId,InstanceId,ip |
|`upstream_resp3xx`| 3XX Back to Source Status Code  | count | userId,InstanceId,ip |
|`upstream_resp3xx_ratio`| 3XX Return to Source Status Code Percentage  | % | userId,InstanceId,ip |
|`upstream_resp4xx`| 4XX Back to Source Status Code  | count | userId,InstanceId,ip |
|`upstream_resp4xx_ratio`| 4XX Return to Source Status Code Percentage  | % | userId,InstanceId,ip |
|`upstream_resp5xx`| 5XX Back to Source Status Code  | count | userId,InstanceId,ip |
|`upstream_resp5xx_ratio`| 5XX Return to Source Status Code Percentage  | % | userId,InstanceId,ip |
|`upstream_resp404`| 404 Return to Source Status Code  | count | userId,InstanceId,ip |
|`upstream_resp404_ratio`| Percentage of 404 return-to-origin status codes  | % | userId,InstanceId,ip |


## Object {#object}

The collected Alibaba Cloud DDoS New BGP High Defense object data structure can see the object data from 「Infrastructure-Custom」

```json
{
  "measurement": "aliyun_ddoscoo",
  "tags": {
    "name"      : "rg-acfm2pz25js****",
    "InstanceId": "rg-acfm2pz25js****",
    "RegionId"  : "cn-hangzhou",
    "Status"    : "1",
    "Edition"   : "9",
    "IpVersion" : "Ipv4",
    "Enabled"   : "1"
  },
  "fields": {
    "ExpireTime": "1637812279000",
    "CreateTime": "1637812279000",
    "message"   : "{Instance JSON data}"
  }
}

```
