---
title: 'Alibaba Cloud CDN'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud CDN performance metrics display, including hits per second, downstream traffic, edge bandwidth, response time, origin bandwidth, status codes, etc.'
__int_icon: 'icon/aliyun_cdn'
dashboard:
  - desc: 'Alibaba Cloud CDN built-in views'
    path: 'dashboard/en/aliyun_cdn/'

monitor:
  - desc: 'Alibaba Cloud CDN monitor'
    path: 'monitor/en/aliyun_cdn/'
---


<!-- markdownlint-disable MD025 -->
# Alibaba Cloud CDN
<!-- markdownlint-enable -->

Alibaba Cloud CDN performance metrics display, including hits per second, downstream traffic, edge bandwidth, response time, origin bandwidth, status codes, etc.

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> It is recommended to deploy the GSE version



### Install Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data of CDN cloud resources, we install the corresponding collection script: "Guance Integration (Alibaba Cloud-CDN Collection)" (ID: `guance_aliyun_cdn`)

Click 【Install】, then enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】 and the system will automatically create a `Startup` script set and configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect logs, you should also enable the corresponding log collection script. If you need to collect billing information, you need to enable the cloud billing collection script.


We default to collecting some configurations; see the Metrics section for details.

[Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have been configured with automatic triggers and check the task records and logs for any anomalies.
2. On the Guance platform, in "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, in "Metrics", check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Alibaba Cloud Cloud Monitoring, the default metric sets are as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitoring Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id           |        Metric Name        | Dimensions                                                | Statistics              | Unit         |
| ---- | :----: | ------ | ------ | ---- |
| `BPS`              |         Peak Bandwidth          | userId,instanceId                                         | Average,Minimum,Maximum | bits/s       |
| `BPS_isp`           |     Edge Network Bandwidth(isp)     | userId,instanceId,protocol,continent,country,province,isp | Value                   | bits/s       |
| `EsCode4xx`         |  EdgeScript Rule Anomaly Count   | userId,instanceId                                         | Sum                     | Count        |
| `EsCode4xxRatio`    |  EdgeScript Rule Anomaly Ratio   | userId,instanceId                                         | Value                   | %            |
| `GroupBPS`          |    (Group Dimension) Peak Bandwidth     | userId,groupId                                            | Sum                     | bits/s       |
| `GroupInternetOut`  |    (Group Dimension) Downstream Traffic     | userId,groupId                                            | Sum                     | bytes        |
| `InternetOut`       |         Downstream Traffic          | userId,instanceId                                         | Average,Maximum,Minimum | bytes        |
| `InternetOut_isp`   |       Downstream Traffic(isp)       | userId,instanceId,protocol,continent,country,province,isp | Value                   | bytes        |
| `QPS`               |       Hits Per Second        | userId,instanceId                                         | Average,Minimum,Maximum | Count        |
| `QPS_isp`           |     Hits Per Second(isp)     | userId,instanceId,protocol,continent,country,province,isp | Value                   | Count        |
| `UserQPS`           |      User-Dimensional Edge QPS      | userId                                                    | Average                 | count        |
| `Usercode4xx`       | User-Dimensional Edge Status Code 4XX Ratio | userId                                                    | Average                 | %            |
| `Usercode5xx`       | User-Dimensional Edge Status Code 5XX Ratio | userId                                                    | Average                 | %            |
| `UserhitRate`       |    User-Dimensional Edge Hit Rate     | userId                                                    | Average                 | %            |
| `code1xx`           |     Edge Status Code 1XX Ratio     | userId,instanceId                                         | Maximum                 | %            |
| `code1xx_isp`       |  Edge Status Code 1XX Ratio(isp)   | userId,instanceId,protocol,continent,country,province,isp | Value                   | %            |
| `code2xx`           |     Edge Status Code 2XX Ratio     | userId,instanceId                                         | Maximum                 | %            |
| `code2xx_isp`       |  Edge Status Code 2XX Ratio(isp)   | userId,instanceId,protocol,continent,country,province,isp | Value                   | %            |
| `code3xx`           |     Edge Status Code 3XX Ratio     | userId,instanceId                                         | Maximum                 | %            |
| `code3xx_isp`       |  Edge Status Code 3XX Ratio(isp)   | userId,instanceId,protocol,continent,country,province,isp | Value                   | %            |
| `code4xx`           |     Edge Status Code 4XX Ratio     | userId,instanceId                                         | Average,Minimum,Maximum | %            |
| `code4xx_isp`       |  Edge Status Code 4XX Ratio(isp)   | userId,instanceId,protocol,continent,country,province,isp | Value                   | %            |
| `code5xx`           |     Edge Status Code 5XX Ratio     | userId,instanceId                                         | Average,Minimum,Maximum | %            |
| `code5xx_isp`       |  Edge Status Code 5XX Ratio(isp)   | userId,instanceId,protocol,continent,country,province,isp | Value                   | % |
| `code_count_499`    |     Edge Status Code 499 Count     | userId,instanceId                                         | Average,Maximum,Minimum | count        |
| `code_count_499_isp` |  Edge Status Code 499 Count(isp)   | userId,instanceId,protocol,continent,country,province,isp | Value                   | Count |
| `code_ratio_1`      |  (Deprecated) Edge Status Code 1XX Ratio  | userId,domain_name                                        | Maximum                 | % |
| `code_ratio_2`      |  (Deprecated) Edge Status Code 2XX Ratio  | userId,domain_name                                        | Maximum                 | % |
| `code_ratio_3`      |  (Deprecated) Edge Status Code 3XX Ratio  | userId,domain_name                                        | Maximum                 | % |
| `code_ratio_499`    |     Edge Status Code 499 Ratio     | userId,instanceId                                         | Average,Maximum,Minimum | % |
| `code_ratio_499_isp` |  Edge Status Code 499 Ratio(isp)   | userId,instanceId,protocol,continent,country,province,isp | Value                   | % |
| `hitRate`           |      Edge Byte Hit Rate       | userId,instanceId                                         | Average,Maximum         | % |
| `l1_acc`            |      Edge Cumulative Request Count       | userId,instanceId                                         | Maximum,Average,Minimum | count |
| `l1_acc_isp`        |    Edge Cumulative Request Count(isp)    | userId,instanceId,protocol,continent,country,province,isp | Value                   | Count |
| `ori_acc`           |      Origin Cumulative Request Count       | userId,instanceId                                         | Maximum,Average,Minimum | count |
| `ori_bps`           |       Origin Network Bandwidth        | userId,instanceId                                         | Maximum,Average,Minimum | bits/s |
| `ori_code_ratio_1xx` |     Origin Status Code 1XX Ratio     | userId,instanceId                                         | Maximum,Average,Minimum | % |
| `ori_code_ratio_2xx` |     Origin Status Code 2XX Ratio     | userId,instanceId                                         | Maximum,Average,Minimum | % |
| `ori_code_ratio_3xx` |     Origin Status Code 3XX Ratio     | userId,instanceId                                         | Maximum,Average,Minimum | % |
| `ori_code_ratio_499` |     Origin Status Code 499 Ratio     | userId,instanceId                                         | Maximum,Average,Minimum | % |
| `ori_code_ratio_4xx` |     Origin Status Code 4XX Ratio     | userId,instanceId                                         | Maximum,Average,Minimum | % |
| `ori_code_ratio_5xx` |     Origin Status Code 5XX Ratio     | userId,instanceId                                         | Maximum,Average,Minimum | % |
| `rt`                |       Edge Response Time        | userId,instanceId                                         | Maximum,Average,Minimum | milliseconds |
| `rt_isp`            |     Edge Response Time(isp)     | userId,instanceId,protocol,continent,country,province,isp | Average,Maximum,Minimum | milliseconds |
| `user_code_count_499` | User-Dimensional Edge Status Code 499 Count | userId                                                    | Average,Maximum,Minimum | % |

## Object {#object}

The collected Alibaba Cloud SLB object data structure can be viewed in "Infrastructure - Custom".

```json
{
  "measurement": "aliyun_cdn",
  "tags": {
    "name"          : "xxxxx.com",
    "CdnType"       : "web",
    "DomainName"    : "xxxxx.com",
    "DomainStatus"  : "online",
    "SslProtocol"   : "on",
    "CertName"      : "xxxxx.com",
    "Status"        : "success",
    "CertType"      : "free",
    "CertDomainName": "xxxxx.com",

  },
  "fields": {
    "CertExpireTime": "2022-12-13T16:00:00Z",
    "GmtCreated"    : "2022-12-13T16:00:00Z",
    "message"       : "{instance JSON data}"
  }
}

```