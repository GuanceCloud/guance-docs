---
title: '阿里云 DDoS 新BGP高防'
tags: 
  - 阿里云
summary: '阿里云DDoS新BGP高防的展示指标包括攻击防护能力、清洗能力、响应时间和可靠性，这些指标反映了新BGP高防服务在应对大规模DDoS攻击时的性能表现和可信度。'
__int_icon: 'icon/aliyun_newbgp_ddos'
dashboard:
  - desc: '阿里云 DDoS 新BGP高防 内置视图'
    path: 'dashboard/zh/aliyun_newbgp_ddos/'

---

<!-- markdownlint-disable MD025 -->
# 阿里云 DDoS 新BGP高防
<!-- markdownlint-enable -->

阿里云DDoS新BGP高防的展示指标包括攻击防护能力、清洗能力、响应时间和可靠性，这些指标反映了新BGP高防服务在应对大规模DDoS攻击时的性能表现和可信度。

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）
> 提示：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包

同步 DDoS 云资源的监控数据，我们安装对应的采集脚本：「观测云集成（阿里云-DDoS高防采集）」(ID：`guance_aliyun_ddoscoo`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置好阿里云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [阿里云云监控指标详情](https://cms.console.aliyun.com/metric-meta/acs_newbgpddos/newbgpddos?){:target="_blank"}

| MetricName | Description  | Unit | Dimensions |
| ---- | --------------------  | :---: | :----: |
|`Active_connection`| 活跃连接数  | count | userId,InstanceId,ip |
|`AttackTraffic`| 高防IP攻击流量  | bit/s | userId,InstanceId,ip |
|`Back_Traffic`| 高防IP回源流量  | bit/s | userId,InstanceId,ip |
|`In_Traffic`| 高防IP入流量  | bit/s | userId,InstanceId,ip |
|`Inactive_connection`| 非活跃连接数  | count | userId,InstanceId,ip |
|`New_connection`| 新建连接数  | count | userId,InstanceId,ip |
|`Out_Traffic`| 高防IP出流量  | bit/s | userId,InstanceId,ip |
|`qps`| QPS  | countS | userId,InstanceId,ip |
|`qps_ratio_down`| QPS环比下降率  | % | userId,InstanceId,ip |
|`qps_ratio_up`| QPS环比增长率  | % | userId,InstanceId,ip |
|`resp2xx`| 2XX状态码  | count | userId,InstanceId,ip |
|`resp2xx_ratio`| 2XX状态码占比  | % | userId,InstanceId,ip |
|`resp3xx`| 3XX状态码  | count | userId,InstanceId,ip |
|`resp3xx_ratio`| 3XX状态码占比  | % | userId,InstanceId,ip |
|`resp404`| 404状态码  | count | userId,InstanceId,ip |
|`resp404_ratio`| 404状态码占比  | % | userId,InstanceId,ip |
|`resp4xx`| 4XX状态码  | count | userId,InstanceId,ip |
|`resp4xx_ratio`| 4XX状态码占比  | % | userId,InstanceId,ip |
|`resp502`| 502状态码  | count | userId,InstanceId,ip |
|`resp503`| 503状态码  | count | userId,InstanceId,ip |
|`resp504`| 504状态码  | count | userId,InstanceId,ip |
|`resp5xx`| 5XX状态码  | count | userId,InstanceId,ip |
|`resp5xx_ratio`| 5XX状态码占比  | % | userId,InstanceId,ip |
|`upstream_resp2xx`| 2XX回源状态码  | count | userId,InstanceId,ip |
|`upstream_resp2xx_ratio`| 2XX回源状态码占比  | % | userId,InstanceId,ip |
|`upstream_resp3xx`| 3XX回源状态码  | count | userId,InstanceId,ip |
|`upstream_resp3xx_ratio`| 3XX回源状态码占比  | % | userId,InstanceId,ip |
|`upstream_resp4xx`| 4XX回源状态码  | count | userId,InstanceId,ip |
|`upstream_resp4xx_ratio`| 4XX回源状态码占比  | % | userId,InstanceId,ip |
|`upstream_resp5xx`| 5XX回源状态码  | count | userId,InstanceId,ip |
|`upstream_resp5xx_ratio`| 5XX回源状态码占比  | % | userId,InstanceId,ip |
|`upstream_resp404`| 404回源状态码  | count | userId,InstanceId,ip |
|`upstream_resp404_ratio`| 404回源状态码占比  | % | userId,InstanceId,ip |


## 对象 {#object}

采集到的阿里云 DDoS 新BGP高防 对象数据结构, 可以从「基础设施-自定义」里看到对象数据



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
    "message"   : "{实例 JSON 数据}"
  }
}

```
