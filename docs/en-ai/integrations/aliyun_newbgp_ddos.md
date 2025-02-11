---
title: 'Alibaba Cloud DDoS New BGP High Defense'
tags: 
  - Alibaba Cloud
summary: 'The display metrics of Alibaba Cloud DDoS New BGP High Defense include attack protection capability, cleaning capability, response time, and reliability. These metrics reflect the performance and credibility of the new BGP high defense service in dealing with large-scale DDoS attacks.'
__int_icon: 'icon/aliyun_newbgp_ddos'
dashboard:
  - desc: 'Built-in views for Alibaba Cloud DDoS New BGP High Defense'
    path: 'dashboard/en/aliyun_newbgp_ddos/'

---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud DDoS New BGP High Defense
<!-- markdownlint-enable -->

The display metrics of Alibaba Cloud DDoS New BGP High Defense include attack protection capability, cleaning capability, response time, and reliability. These metrics reflect the performance and credibility of the new BGP high defense service in dealing with large-scale DDoS attacks.

## Configuration {#config}

### Install Func

We recommend enabling Guance integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)
> Note: Before using this collector, you must install the "Guance Integration Core Package" and its associated third-party dependency packages

Sync monitoring data for DDoS cloud resources by installing the corresponding collection script: "Guance Integration (Alibaba Cloud-DDoS High Defense Collection)" (ID: `guance_aliyun_ddoscoo`)

After clicking [Install], enter the required parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Once enabled, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click [Execute] to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

We default collect some configurations; see the Metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations. You can also check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}

After configuring Alibaba Cloud Cloud Monitoring, the default metric set is as follows. More metrics can be collected through configuration. [Alibaba Cloud Cloud Monitoring Metric Details](https://cms.console.aliyun.com/metric-meta/acs_newbgpddos/newbgpddos?){:target="_blank"}

| MetricName | Description  | Unit | Dimensions |
| ---- | --------------------  | :---: | :----: |
|`Active_connection`| Active connections  | count | userId,InstanceId,ip |
|`AttackTraffic`| Attack traffic of high-defense IP  | bit/s | userId,InstanceId,ip |
|`Back_Traffic`| Return traffic of high-defense IP  | bit/s | userId,InstanceId,ip |
|`In_Traffic`| Incoming traffic of high-defense IP  | bit/s | userId,InstanceId,ip |
|`Inactive_connection`| Inactive connections  | count | userId,InstanceId,ip |
|`New_connection`| New connections  | count | userId,InstanceId,ip |
|`Out_Traffic`| Outgoing traffic of high-defense IP  | bit/s | userId,InstanceId,ip |
|`qps`| QPS  | countS | userId,InstanceId,ip |
|`qps_ratio_down`| QPS decrease rate  | % | userId,InstanceId,ip |
|`qps_ratio_up`| QPS increase rate  | % | userId,InstanceId,ip |
|`resp2xx`| 2XX status code  | count | userId,InstanceId,ip |
|`resp2xx_ratio`| Percentage of 2XX status code  | % | userId,InstanceId,ip |
|`resp3xx`| 3XX status code  | count | userId,InstanceId,ip |
|`resp3xx_ratio`| Percentage of 3XX status code  | % | userId,InstanceId,ip |
|`resp404`| 404 status code  | count | userId,InstanceId,ip |
|`resp404_ratio`| Percentage of 404 status code  | % | userId,InstanceId,ip |
|`resp4xx`| 4XX status code  | count | userId,InstanceId,ip |
|`resp4xx_ratio`| Percentage of 4XX status code  | % | userId,InstanceId,ip |
|`resp502`| 502 status code  | count | userId,InstanceId,ip |
|`resp503`| 503 status code  | count | userId,InstanceId,ip |
|`resp504`| 504 status code  | count | userId,InstanceId,ip |
|`resp5xx`| 5XX status code  | count | userId,InstanceId,ip |
|`resp5xx_ratio`| Percentage of 5XX status code  | % | userId,InstanceId,ip |
|`upstream_resp2xx`| Upstream 2XX status code  | count | userId,InstanceId,ip |
|`upstream_resp2xx_ratio`| Percentage of upstream 2XX status code  | % | userId,InstanceId,ip |
|`upstream_resp3xx`| Upstream 3XX status code  | count | userId,InstanceId,ip |
|`upstream_resp3xx_ratio`| Percentage of upstream 3XX status code  | % | userId,InstanceId,ip |
|`upstream_resp4xx`| Upstream 4XX status code  | count | userId,InstanceId,ip |
|`upstream_resp4xx_ratio`| Percentage of upstream 4XX status code  | % | userId,InstanceId,ip |
|`upstream_resp5xx`| Upstream 5XX status code  | count | userId,InstanceId,ip |
|`upstream_resp5xx_ratio`| Percentage of upstream 5XX status code  | % | userId,InstanceId,ip |
|`upstream_resp404`| Upstream 404 status code  | count | userId,InstanceId,ip |
|`upstream_resp404_ratio`| Percentage of upstream 404 status code  | % | userId,InstanceId,ip |

## Objects {#object}

The object data structure of Alibaba Cloud DDoS New BGP High Defense collected can be seen in "Infrastructure - Custom"

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
    "message"   : "{instance JSON data}"
  }
}
```