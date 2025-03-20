---
title: 'Alibaba Cloud DDoS New BGP High Defense'
tags: 
  - Alibaba Cloud
summary: 'The displayed Metrics of Alibaba Cloud DDoS New BGP High Defense include attack protection capability, cleaning capability, response time, and reliability. These Metrics reflect the performance and credibility of the New BGP High Defense service when dealing with large-scale DDoS attacks.'
__int_icon: 'icon/aliyun_newbgp_ddos'
dashboard:
  - desc: 'Built-in views for Alibaba Cloud DDoS New BGP High Defense'
    path: 'dashboard/en/aliyun_newbgp_ddos/'

---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud DDoS New BGP High Defense
<!-- markdownlint-enable -->

The displayed Metrics of Alibaba Cloud DDoS New BGP High Defense include attack protection capability, cleaning capability, response time, and reliability. These Metrics reflect the performance and credibility of the New BGP High Defense service when dealing with large-scale DDoS attacks.

## Configuration {#config}

### Install Func

It is recommended to enable the <<< custom_key.brand_name >>> integration - Expansion - DataFlux Func (Automata): all prerequisites will be automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)
> Note: Before using this collector, you must install the "<<< custom_key.brand_name >>> Integration Core Package" and its corresponding third-party dependency packages.

To synchronize the monitoring data of DDoS cloud resources, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Alibaba Cloud-DDoS High Defense Collection)" (ID: `guance_aliyun_ddoscoo`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the regular time. After a short wait, you can view the execution task records and corresponding logs.

We default collect some configurations, details are shown in the Metrics section.

[Customize Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs to check for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}

After configuring Alibaba Cloud - Cloud Monitoring, the default Measurement set is as follows, and more Metrics can be collected through configuration. [Alibaba Cloud Cloud Monitoring Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_newbgpddos/newbgpddos?){:target="_blank"}

| MetricName | Description  | Unit | Dimensions |
| ---- | --------------------  | :---: | :----: |
|`Active_connection`| Number of active connections  | count | userId,InstanceId,ip |
|`AttackTraffic`| Attack traffic on high defense IP  | bit/s | userId,InstanceId,ip |
|`Back_Traffic`| Backsource traffic on high defense IP  | bit/s | userId,InstanceId,ip |
|`In_Traffic`| Incoming traffic on high defense IP  | bit/s | userId,InstanceId,ip |
|`Inactive_connection`| Number of inactive connections  | count | userId,InstanceId,ip |
|`New_connection`| Number of new connections  | count | userId,InstanceId,ip |
|`Out_Traffic`| Outgoing traffic on high defense IP  | bit/s | userId,InstanceId,ip |
|`qps`| QPS  | countS | userId,InstanceId,ip |
|`qps_ratio_down`| QPS decrease rate  | % | userId,InstanceId,ip |
|`qps_ratio_up`| QPS growth rate  | % | userId,InstanceId,ip |
|`resp2xx`| 2XX status code  | count | userId,InstanceId,ip |
|`resp2xx_ratio`| Proportion of 2XX status codes  | % | userId,InstanceId,ip |
|`resp3xx`| 3XX status code  | count | userId,InstanceId,ip |
|`resp3xx_ratio`| Proportion of 3XX status codes  | % | userId,InstanceId,ip |
|`resp404`| 404 status code  | count | userId,InstanceId,ip |
|`resp404_ratio`| Proportion of 404 status codes  | % | userId,InstanceId,ip |
|`resp4xx`| 4XX status code  | count | userId,InstanceId,ip |
|`resp4xx_ratio`| Proportion of 4XX status codes  | % | userId,InstanceId,ip |
|`resp502`| 502 status code  | count | userId,InstanceId,ip |
|`resp503`| 503 status code  | count | userId,InstanceId,ip |
|`resp504`| 504 status code  | count | userId,InstanceId,ip |
|`resp5xx`| 5XX status code  | count | userId,InstanceId,ip |
|`resp5xx_ratio`| Proportion of 5XX status codes  | % | userId,InstanceId,ip |
|`upstream_resp2xx`| 2XX backsource status code  | count | userId,InstanceId,ip |
|`upstream_resp2xx_ratio`| Proportion of 2XX backsource status codes  | % | userId,InstanceId,ip |
|`upstream_resp3xx`| 3XX backsource status code  | count | userId,InstanceId,ip |
|`upstream_resp3xx_ratio`| Proportion of 3XX backsource status codes  | % | userId,InstanceId,ip |
|`upstream_resp4xx`| 4XX backsource status code  | count | userId,InstanceId,ip |
|`upstream_resp4xx_ratio`| Proportion of 4XX backsource status codes  | % | userId,InstanceId,ip |
|`upstream_resp5xx`| 5XX backsource status code  | count | userId,InstanceId,ip |
|`upstream_resp5xx_ratio`| Proportion of 5XX backsource status codes  | % | userId,InstanceId,ip |
|`upstream_resp404`| 404 backsource status code  | count | userId,InstanceId,ip |
|`upstream_resp404_ratio`| Proportion of 404 backsource status codes  | % | userId,InstanceId,ip |


## Objects {#object}

The object data structure of the collected Alibaba Cloud DDoS New BGP High Defense objects can be seen in "Infrastructure - Custom".



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