---
title: '阿里云 CDN'
tags: 
  - 阿里云
summary: '阿里云 CDN 性能指标展示，包括每秒访问次数、下行流量、边缘带宽、响应时间、回源带宽、状态码等。'
__int_icon: 'icon/aliyun_cdn'
dashboard:
  - desc: '阿里云 CDN 内置视图'
    path: 'dashboard/zh/aliyun_cdn/'

monitor:
  - desc: '阿里云 CDN 监控器'
    path: 'monitor/zh/aliyun_cdn/'
---


<!-- markdownlint-disable MD025 -->
# 阿里云 CDN
<!-- markdownlint-enable -->

阿里云 CDN 性能指标展示，包括每秒访问次数、下行流量、边缘带宽、响应时间、回源带宽、状态码等。

## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> 推荐部署GSE版



### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 CDN 云资源的监控数据，我们安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（阿里云-CDN采集）」(ID：`guance_aliyun_cdn`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。


我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好阿里云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [阿里云云监控指标详情](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id           |        Metric Name        | Dimensions                                                | Statistics              | Unit         |
| ---- | :----: | ------ | ------ | ---- |
| `BPS`              |         带宽峰值          | userId,instanceId                                         | Average,Minimum,Maximum | bits/s       |
| `BPS_isp`           |     边缘网络带宽(isp)     | userId,instanceId,protocol,continent,country,province,isp | Value                   | bits/s       |
| `EsCode4xx`         |  EdgeScript规则异常次数   | userId,instanceId                                         | Sum                     | Count        |
| `EsCode4xxRatio`    |  EdgeScript规则异常占比   | userId,instanceId                                         | Value                   | %            |
| `GroupBPS`          |    (分组维度)带宽峰值     | userId,groupId                                            | Sum                     | bits/s       |
| `GroupInternetOut`  |    (分组维度)下行流量     | userId,groupId                                            | Sum                     | bytes        |
| `InternetOut`       |         下行流量          | userId,instanceId                                         | Average,Maximum,Minimum | bytes        |
| `InternetOut_isp`   |       下行流量(isp)       | userId,instanceId,protocol,continent,country,province,isp | Value                   | bytes        |
| `QPS`               |       每秒访问次数        | userId,instanceId                                         | Average,Minimum,Maximum | Count        |
| `QPS_isp`           |     每秒访问次数(isp)     | userId,instanceId,protocol,continent,country,province,isp | Value                   | Count        |
| `UserQPS`           |      用户维度边缘QPS      | userId                                                    | Average                 | count        |
| `Usercode4xx`       | 用户维度边缘状态码4XX占比 | userId                                                    | Average                 | %            |
| `Usercode5xx`       | 用户维度边缘状态码5XX占比 | userId                                                    | Average                 | %            |
| `UserhitRate`       |    用户维度边缘命中率     | userId                                                    | Average                 | %            |
| `code1xx`           |     边缘状态码1XX占比     | userId,instanceId                                         | Maximum                 | %            |
| `code1xx_isp`       |  边缘状态码1XX占比(isp)   | userId,instanceId,protocol,continent,country,province,isp | Value                   | %            |
| `code2xx`           |     边缘状态码2XX占比     | userId,instanceId                                         | Maximum                 | %            |
| `code2xx_isp`       |  边缘状态码2XX占比(isp)   | userId,instanceId,protocol,continent,country,province,isp | Value                   | %            |
| `code3xx`           |     边缘状态码3XX占比     | userId,instanceId                                         | Maximum                 | %            |
| `code3xx_isp`       |  边缘状态码3XX占比(isp)   | userId,instanceId,protocol,continent,country,province,isp | Value                   | %            |
| `code4xx`           |     边缘状态码4XX占比     | userId,instanceId                                         | Average,Minimum,Maximum | %            |
| `code4xx_isp`       |  边缘状态码4XX占比(isp)   | userId,instanceId,protocol,continent,country,province,isp | Value                   | %            |
| `code5xx`           |     边缘状态码5XX占比     | userId,instanceId                                         | Average,Minimum,Maximum | %            |
| `code5xx_isp`       |  边缘状态码5XX占比(isp)   | userId,instanceId,protocol,continent,country,province,isp | Value                   | % |
| `code_count_499`    |     边缘状态码499个数     | userId,instanceId                                         | Average,Maximum,Minimum | count        |
| `code_count_499_isp` |  边缘状态码499个数(isp)   | userId,instanceId,protocol,continent,country,province,isp | Value                   | Count |
| `code_ratio_1`      |  (废弃)边缘状态码1XX占比  | userId,domain_name                                        | Maximum                 | % |
| `code_ratio_2`      |  (废弃)边缘状态码2XX占比  | userId,domain_name                                        | Maximum                 | % |
| `code_ratio_3`      |  (废弃)边缘状态码3XX占比  | userId,domain_name                                        | Maximum                 | % |
| `code_ratio_499`    |     边缘状态码499占比     | userId,instanceId                                         | Average,Maximum,Minimum | % |
| `code_ratio_499_isp` |  边缘状态码499占比(isp)   | userId,instanceId,protocol,continent,country,province,isp | Value                   | % |
| `hitRate`           |      边缘字节命中率       | userId,instanceId                                         | Average,Maximum         | % |
| `l1_acc`            |      边缘累加请求数       | userId,instanceId                                         | Maximum,Average,Minimum | count |
| `l1_acc_isp`        |    边缘累加请求数(isp)    | userId,instanceId,protocol,continent,country,province,isp | Value                   | Count |
| `ori_acc`           |      回源累加请求数       | userId,instanceId                                         | Maximum,Average,Minimum | count |
| `ori_bps`           |       回源网络带宽        | userId,instanceId                                         | Maximum,Average,Minimum | bits/s |
| `ori_code_ratio_1xx` |     回源状态码1XX占比     | userId,instanceId                                         | Maximum,Average,Minimum | % |
| `ori_code_ratio_2xx` |     回源状态码2XX占比     | userId,instanceId                                         | Maximum,Average,Minimum | % |
| `ori_code_ratio_3xx` |     回源状态码3XX占比     | userId,instanceId                                         | Maximum,Average,Minimum | % |
| `ori_code_ratio_499` |     回源状态码499占比     | userId,instanceId                                         | Maximum,Average,Minimum | % |
| `ori_code_ratio_4xx` |     回源状态码4XX占比     | userId,instanceId                                         | Maximum,Average,Minimum | % |
| `ori_code_ratio_5xx` |     回源状态码5XX占比     | userId,instanceId                                         | Maximum,Average,Minimum | % |
| `rt`                |       边缘响应时间        | userId,instanceId                                         | Maximum,Average,Minimum | milliseconds |
| `rt_isp`            |     边缘响应时间(isp)     | userId,instanceId,protocol,continent,country,province,isp | Average,Maximum,Minimum | milliseconds |
| `user_code_count_499` | 用户维度边缘状态码499个数 | userId                                                    | Average,Maximum,Minimum | % |

## 对象 {#object}

采集到的阿里云 SLB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

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
    "message"       : "{实例 JSON 数据}"
  }
}

```
