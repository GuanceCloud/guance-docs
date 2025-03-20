---
title: 'Alibaba Cloud Site Monitoring'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud Site Monitoring primarily collects site dial test information.'
__int_icon: 'icon/aliyun_site'
dashboard:
  - desc: 'Alibaba Cloud - Site Monitoring'
    path: 'dashboard/en/aliyun_site/'
---

<!-- markdownlint-disable MD025 -->

# Alibaba Cloud Site Monitoring
<!-- markdownlint-enable -->

Alibaba Cloud Site Monitoring primarily collects site dial test information.


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation.

If you deploy Func yourself, refer to [Self-deploy Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

We install the corresponding collection script: <<< custom_key.brand_name >>> Integration (Alibaba Cloud - Site Monitoring Task Collection) (ID: `guance_aliyun_site_monitor_task`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We default to collecting some configurations; for details, see the Metrics section.

[Configure custom cloud object metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have corresponding automatic trigger configurations, and at the same time, check the corresponding task records and logs for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}

After configuring Alibaba Cloud - Site Monitoring Task Collection, the default metric sets are as follows. You can find more information through [Alibaba Cloud Site Monitoring Log Details](https://help.aliyun.com/zh/cms/developer-reference/api-cms-2019-01-01-describesitemonitorlog?spm=a2c4g.11186623.0.i8){:target="_blank"}


### Labels

| Label Name | Description |
| -- | -- |
| Address | Site Address |
| TaskName| Dial Test Task Name|
| countryCN| Country Chinese Name|
| countryEN | Country English Name|
| cityCN| City Chinese Name|
| cityEN| City English Name|
| provinceCN| Province Chinese Name|
| provinceEN| Province English Name|
| areaCN| Area Chinese Name|
| areaEN| Area English Name|


### Metric `aliyun_site_monitor`

| Metric | Description | Unit |
| -- | -- | -- |
| `HTTPResponseCode` | HTTP response code | int |
| `HTTPConnectTime` | HTTP connection time| seconds|
| `HTTPDNSTime`| DNS resolution time| seconds|
|`HTTPDownloadTime`| HTTP download time| seconds |
|`HTTPDownloadSpeed`| HTTP download speed| Frequency |
|`HTTPDownloadSize`| HTTP download size| bytes |
|`SSLConnectTime`| SSL connection time| seconds |
|`redirectTime`| Redirect time | seconds |
|`redirectCount`| Redirect count | count|
|`tcpConnectTime`| TCP connection time| seconds |
|`TotalTime`| Total response time| seconds |