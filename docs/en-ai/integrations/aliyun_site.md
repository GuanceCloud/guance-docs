---
title: 'Alibaba Cloud Site Monitoring'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud Site Monitoring primarily retrieves site dial testing information.'
__int_icon: 'icon/aliyun_site'
dashboard:
  - desc: 'Alibaba Cloud - Site Monitoring'
    path: 'dashboard/en/aliyun_site/'
---

<!-- markdownlint-disable MD025 -->

# Alibaba Cloud Site Monitoring
<!-- markdownlint-enable -->

Alibaba Cloud Site Monitoring primarily retrieves site dial testing information.


## Configuration {#config}

### Install Func

We recommend enabling the Guance Integration - Extensions - Managed Func: all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-hosted Func Deployment](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

We install the corresponding collection script: "Guance Integration (Alibaba Cloud - Site Monitoring Task Collection)" (ID: `guance_aliyun_site_monitor_task`)

After clicking [Install], enter the required parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Additionally, you can view the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click [Execute] to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

We collect some default configurations; see the Metrics section for details.

[Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the automatic trigger configuration and check the task records and logs for any anomalies.
2. In the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. In the Guance platform, under "Metrics", check if the corresponding monitoring data exists.

## Metrics {#metric}

After configuring the Alibaba Cloud - Site Monitoring Task Collection, the default metric set is as follows. You can find more information through the [Alibaba Cloud Site Monitoring Log Details](https://help.aliyun.com/zh/cms/developer-reference/api-cms-2019-01-01-describesitemonitorlog?spm=a2c4g.11186623.0.i8){:target="_blank"}


### Labels

| Label Name | Description |
| --- | --- |
| Address | Site Address |
| TaskName | Dial Testing Task Name |
| countryCN | Country Chinese Name |
| countryEN | Country English Name |
| cityCN | City Chinese Name |
| cityEN | City English Name |
| provinceCN | Province Chinese Name |
| provinceEN | Province English Name |
| areaCN | Area Chinese Name |
| areaEN | Area English Name |


### Metrics `aliyun_site_monitor`

| Metric | Description | Unit |
| --- | --- | --- |
| `HTTPResponseCode` | HTTP response code | int |
| `HTTPConnectTime` | HTTP connection time | seconds |
| `HTTPDNSTime` | DNS resolution time | seconds |
| `HTTPDownloadTime` | HTTP download time | seconds |
| `HTTPDownloadSpeed` | HTTP download speed | Frequency |
| `HTTPDownloadSize` | HTTP download size | bytes |
| `SSLConnectTime` | SSL connection time | seconds |
| `redirectTime` | Redirect time | seconds |
| `redirectCount` | Redirect count | count |
| `tcpConnectTime` | TCP connection time | seconds |
| `TotalTime` | Total response time | seconds |