---
title: 'Alibaba Cloud CDN'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud CDN performance Metrics display, including requests per second, downstream traffic, edge bandwidth, response time, back-to-source bandwidth, status codes, etc.'
__int_icon: 'icon/aliyun_cdn'
dashboard:
  - desc: 'Alibaba Cloud CDN built-in views'
    path: 'dashboard/en/aliyun_cdn/'

monitor:
  - desc: 'Alibaba Cloud CDN monitors'
    path: 'monitor/en/aliyun_cdn/'
---


<!-- markdownlint-disable MD025 -->
# Alibaba Cloud CDN
<!-- markdownlint-enable -->

Alibaba Cloud CDN performance Metrics display, including requests per second, downstream traffic, edge bandwidth, response time, back-to-source bandwidth, status codes, etc.

## Configuration {#config}

### Install Func

It is recommended to activate Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> It is recommended to deploy the GSE version



### Installation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize the monitoring data of CDN cloud resources, we install the corresponding collection script: "Guance Integration (Alibaba Cloud-CDN Collection)" (ID: `guance_aliyun_cdn`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

> If you need to collect the corresponding logs, enable the corresponding log collection script. If you need to collect bills, enable the cloud bill collection script.


We default to collecting some configurations, details can be seen in the Metrics section.

[Configure custom cloud object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and at the same time, check the corresponding task records and logs to see if there are any abnormalities.
2. On the Guance platform, under "Infrastructure / Custom", check if there is any asset information.
3. On the Guance platform, under "Metrics", check if there is any corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitor, the default Measurement set is as follows. You can collect more Metrics through configuration. [Alibaba Cloud Cloud Monitor Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id           |        Metric Name        | Dimensions                                                | Statistics              | Unit         |
| ---- | :----: | ------ | ------ | ---- |
| `BPS`              |         Bandwidth Peak          | userId,instanceId                                         | Average,Minimum,Maximum | bits/s       |
| `BPS_isp`           |     Edge Network Bandwidth(isp)     | userId,instanceId,protocol,continent,country,province,isp | Value                   | bits/s       |
| `EsCode4xx`         |  EdgeScript Rule Exception Count   | userId,instanceId                                         | Sum                     | Count        |
| `EsCode4xxRatio`    |  EdgeScript Rule Exception Ratio   | userId,instanceId                                         | Value                   | %            |
| `GroupBPS`          |    (Group Dimension) Bandwidth Peak     | userId,groupId                                            | Sum                     | bits/s       |
| `GroupInternetOut`  |    (Group Dimension) Downstream Traffic     | userId,groupId                                            | Sum                     | bytes        |
| `InternetOut`       |         Downstream Traffic          | userId,instanceId                                         | Average,Maximum,Minimum | bytes        |
| `InternetOut_isp`   |       Downstream Traffic(isp)       | userId,instanceId,protocol,continent,country,province,isp | Value                   | bytes        |
| `QPS`               |       Requests Per Second        | userId,instanceId                                         | Average,Minimum,Maximum | Count        |
| `QPS_isp`           |     Requests Per Second(isp)     | userId,instanceId,protocol,continent,country,province,isp | Value                   | Count        |
| `UserQPS`           |      User Dimension Edge QPS      | userId                                                    | Average                 | count        |
| `Usercode4xx`       | User Dimension Edge Status Code 4XX Ratio | userId                                                    | Average                 | %            |
| `Usercode5xx`       | User Dimension Edge Status Code 5XX Ratio | userId                                                    | Average                 | %            |
| `UserhitRate`       |    User Dimension Edge Hit Rate     | userId                                                    | Average                 | %            |
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
| `l1_acc`            |      Edge Accumulated Request Count       | userId,instanceId                                         | Maximum,Average,Minimum | count |
| `l1_acc_isp`        |    Edge Accumulated Request Count(isp)    | userId,instanceId,protocol,continent,country,province,isp | Value                   | Count |
| `ori_acc`           |      Back-to-Source Accumulated Request Count       | userId,instanceId                                         | Maximum,Average,Minimum | count |
| `ori_bps`           |       Back-to-Source Network Bandwidth        | userId,instanceId                                         | Maximum,Average,Minimum | bits/s |
| `ori_code_ratio_1xx` |     Back-to-Source Status Code 1XX Ratio     | userId,instanceId                                         | Maximum,Average,Minimum | % |
| `ori_code_ratio_2xx` |     Back-to-Source Status Code 2XX Ratio     | userId,instanceId                                         | Maximum,Average,Minimum | % |
| `ori_code_ratio_3xx` |     Back-to-Source Status Code 3XX Ratio     | userId,instanceId                                         | Maximum,Average,Minimum | % |
| `ori_code_ratio_499` |     Back-to-Source Status Code 499 Ratio     | userId,instanceId                                         | Maximum,Average,Minimum | % |
| `ori_code_ratio_4xx` |     Back-to-Source Status Code 4XX Ratio     | userId,instanceId                                         | Maximum,Average,Minimum | % |
| `ori_code_ratio_5xx` |     Back-to-Source Status Code 5XX Ratio     | userId,instanceId                                         | Maximum,Average,Minimum | % |
| `rt`                |       Edge Response Time        | userId,instanceId                                         | Maximum,Average,Minimum | milliseconds |
| `rt_isp`            |     Edge Response Time(isp)     | userId,instanceId,protocol,continent,country,province,isp | Average,Maximum,Minimum | milliseconds |
| `user_code_count_499` | User Dimension Edge Status Code 499 Count | userId                                                    | Average,Maximum,Minimum | % |

## Objects {#object}

The collected Alibaba Cloud SLB object data structure can be viewed under "Infrastructure - Custom".

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
    "message"       : "{Instance JSON data}"
  }
}

```