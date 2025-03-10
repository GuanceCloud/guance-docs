---
title: 'Aliyun Site Monitor'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud site monitoring mainly obtains site call testing information'
__int_icon: 'icon/aliyun_site'
dashboard:
  - desc: 'Aliyun - Site Monitor'
    path: 'dashboard/zh/aliyun_site/'
---

<!-- markdownlint-disable MD025 -->

# Aliyun - Site Monitor
<!-- markdownlint-enable -->

Alibaba Cloud site monitoring mainly obtains site call testing information


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance (For simplicity's sake,，You can directly grant the global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of Aliyun **Site monitoring task collection** Standard resources,we install the corresponding collection script:「Guance Integration（Aliyun - **Site monitoring task collection** ）」(ID：`guance_aliyun_site_monitor_task`)

Click "Install" and enter the corresponding parameters: Aliyun AK, Aliyun account name.

Tap "Deploy startup Script"，The system automatically creates Startup script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」. Click "Run", you can immediately execute once, without waiting for a regular time. After a while, you can view task execution records and corresponding logs.

We have collected some configurations by default, see the index column for details

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Alibaba Cloud - Site Monitor. The default metric set is as follows. You can monitor log details through [Alibaba Cloud Site Monitor](https://help.aliyun.com/zh/cms/developer-reference/api-cms-2019-01-01-describesitemonitorlog?spm=a2c4g.11186623.0.i8){:target="_blank"} View more information.

### Tags

| Tag Name | Description |
| -- | -- |
| Address | site address |
| TaskName| Site monitoring task name|
| countryCN| Chinese name of the country|
| countryEN | English name of the country|
| cityCN| Chinese name of the city|
| cityEN| English name of the city|
| provinceCN| Chinese name of the province|
| provinceEN| English name of the province|
| areaCN| Chinese name of the area|
| areaEN| English name of the area|


### Metric of `aliyun_site_monitor`

| Metric | Description | Unit |
| -- | -- | -- |
| `HTTPResponseCode` | http response code | int |
| `HTTPConnectTime` | http connection time| seconds|
| `HTTPDNSTime`| DNS resolution time | seconds|
|`HTTPDownloadTime`| http download time| seconds |
|`HTTPDownloadSpeed`| http download speed| Frequency |
|`HTTPDownloadSize`| http download size| bytes |
|`SSLConnectTime`| ssl connection time| seconds |
|`redirectTime`| redirect time | seconds |
|`redirectCount`| redirect count | count|
|`tcpConnectTime`| tcp connection time | seconds |
|`TotalTime`|total response time| seconds |
