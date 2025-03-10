---
title: 'Alibaba Cloud Site Monitoring'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud Site Monitoring primarily obtains site dial test information.'
__int_icon: 'icon/aliyun_site'
dashboard:
  - desc: 'Alibaba Cloud - Site Monitoring'
    path: 'dashboard/en/aliyun_site/'
---

<!-- markdownlint-disable MD025 -->

# Alibaba Cloud Site Monitoring
<!-- markdownlint-enable -->

Alibaba Cloud Site Monitoring primarily obtains site dial test information.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

We install the corresponding collection script: "Guance Integration (Alibaba Cloud - Site Monitoring Task Collection)" (ID: `guance_aliyun_site_monitor_task`).

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Additionally, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

We collect some configurations by default, as detailed in the metrics section.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations. You can also check the task records and logs to see if there are any abnormalities.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if the corresponding monitoring data exists.

## Metrics {#metric}

After configuring the Alibaba Cloud - Site Monitoring Task Collection, the default metric set is as follows. For more information, see [Alibaba Cloud Site Monitoring Log Details](https://help.aliyun.com/zh/cms/developer-reference/api-cms-2019-01-01-describesitemonitorlog?spm=a2c4g.11186623.0.i8){:target="_blank"}


### Labels

| Label Name | Description |
| --- | --- |
| Address | Site address |
| TaskName | Dial test task name |
| countryCN | Country Chinese name |
| countryEN | Country English name |
| cityCN | City Chinese name |
| cityEN | City English name |
| provinceCN | Province Chinese name |
| provinceEN | Province English name |
| areaCN | Area Chinese name |
| areaEN | Area English name |


### Metric `aliyun_site_monitor`

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