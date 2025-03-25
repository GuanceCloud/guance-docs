---
title: '华为云 WAF Web应用防火墙'
tags: 
  - 华为云
summary: '采集华为云 WAF 指标数据'
__int_icon: 'icon/huawei_waf'
dashboard:
  - desc: '华为云 WAF 内置视图'
    path: 'dashboard/zh/huawei_waf/'

monitor:
  - desc: '华为云 WAF 监控器'
    path: 'monitor/zh/huawei_waf/'
---

采集 华为云 WAF 指标数据

## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/)

> 推荐部署GSE版

### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步华为云 WAF 监控数据，我们安装对应的采集脚本：「<<< custom_key.brand_name >>>集成（华为云-WAF 采集）」(ID：`guance_huaweicloud_waf`)

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在 Func 中「开发」里找到脚本「<<< custom_key.brand_name >>>集成（华为云-WAF 采集）」，展开修改此脚本，找 collector_configs 和 monitor_configs 分别编辑下面 region_projects 中的内容，将地域和 Project ID,更改为实际的地域和 Project ID，再点击保存发布。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}

采集华为云 WAF 指标, 可以通过配置的方式采集更多的指标 [华为云 WAF 指标详情](https://support.huaweicloud.com/usermanual-waf/waf_01_0372.html){:target="_blank"}

| **指标ID**            |          **指标名称**   | **指标含义** | **取值范围**      | **测量对象** | **监控周期（原始指标）** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `requests`            |  请求量   | 该指标用于统计测量对象近5分钟内WAF返回的请求量的总数。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `waf_http_2xx`            |  WAF返回码（2XX）   | 该指标用于统计测量对象近5分钟内WAF返回的2XX状态码的数量。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `waf_http_3xx`            |  WAF返回码（3XX）   | 该指标用于统计测量对象近5分钟内WAF返回的3XX状态码的数量。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `waf_http_4xx`            |  WAF返回码（4XX）   | 该指标用于统计测量对象近5分钟内WAF返回的4XX状态码的数量。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `waf_http_5xx`            |  WAF返回码（5XX）   | 该指标用于统计测量对象近5分钟内WAF返回的5XX状态码的数量。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `waf_fused_counts`            |  WAF熔断量   | 该指标用于统计测量对象近5分钟内被WAF熔断保护的请求数量。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `inbound_traffic`            |  入网总流量   | 该指标用于统计测量对象近5分钟内总入带宽的大小。单位：Mbit  | ≥0 Mbit | 防护域名 | 5分钟             |
| `outbound_traffic`            |  出网总流量   | 该指标用于统计测量对象近5分钟内总出带宽的大小。单位：Mbit  | ≥0 Mbit | 防护域名 | 5分钟             |
| `waf_process_time_0`            |  WAF处理时延-区间[0-10ms)   | 该指标用于统计测量对象近5分钟内WAF处理时延在区间[0-10ms)内的总数量。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `waf_process_time_10`            |  WAF处理时延-区间[10-20ms)   | 该指标用于统计测量对象近5分钟内WAF处理时延在区间[10-20ms)内的总数量。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `waf_process_time_20`            |  WAF处理时延-区间[20-50ms)   | 该指标用于统计测量对象近5分钟内WAF处理时延在区间[20-50ms)内的总数量。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `waf_process_time_50`            | WAF处理时延-区间[50-100ms)   | 该指标用于统计测量对象近5分钟内WAF处理时延在区间[50-100ms)内的总数量。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `waf_process_time_100`            |  WAF处理时延-区间[100-1000ms)   | 该指标用于统计测量对象近5分钟内WAF处理时延在区间[100-1000ms)内的总数量。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `waf_process_time_1000`            |  WAF处理时延-区间[1000+ms)   | 该指标用于统计测量对象近5分钟内WAF处理时延在区间[1000+ms)内的总数量。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `qps_peak`            |  QPS峰值   | 该指标用于统计近5分钟内防护域名的QPS峰值。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `qps_mean`            |  QPS均值   | 该指标用于统计近5分钟内防护域名的QPS均值。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `waf_http_0`            |  无返回的WAF状态码   | 该指标用于统计测量对象近5分钟内WAF无返回的状态响应码的数量。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `upstream_code_2xx`            |  业务返回码（2XX）   | 该指标用于统计测量对象近5分钟内业务返回的2XX系列状态响应码的数量。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `upstream_code_3xx`            |  业务返回码（3XX）   | 该指标用于统计测量对象近5分钟内业务返回的3XX系列状态响应码的数量。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `upstream_code_4xx`            |  业务返回码（4XX）   | 该指标用于统计测量对象近5分钟内业务返回的4XX系列状态响应码的数量。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `upstream_code_5xx`            |  业务返回码（5XX）   | 该指标用于统计测量对象近5分钟内业务返回的5XX系列状态响应码的数量。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `upstream_code_0`            |  无返回的WAF状态码   | 该指标用于统计测量对象近5分钟内WAF无返回的状态响应码的数量。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `inbound_traffic_peak`            |  入网流量的峰值  | 该指标用于统计近5分钟内防护域名入网流量的峰值。单位：Mbit/s  | ≥0 Mbit/s  | 防护域名 | 5分钟             |
| `inbound_traffic_mean`            |  入网流量的均值  | 该指标用于统计近5分钟内防护域名入网流量的均值。单位：Mbit/s  | ≥0 Mbit/s  | 防护域名 | 5分钟             |
| `outbound_traffic_peak`            |  出网流量的峰值  | 该指标用于统计近5分钟内防护域名出网流量的峰值。单位：Mbit/s  | ≥0 Mbit/s  | 防护域名 | 5分钟             |
| `outbound_traffic_mean`            |  出网流量的均值  | 该指标用于统计近5分钟内防护域名出网流量的均值。单位：Mbit/s  | ≥0 Mbit/s  | 防护域名 | 5分钟             |
| `attacks`            |  攻击总次数  | 该指标用于统计近5分钟内防护域名攻击请求量的总数。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `crawlers`            |  爬虫攻击次数  | 该指标用于统计近5分钟内防护域名爬虫攻击请求量的总数。单位：次  |  ≥0 次  | 防护域名 | 5分钟             |
| `base_protection_counts`            |  web基础防护次数  | 该指标用于统计近5分钟内由Web基础防护规则防护的攻击数量。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `precise_protection_counts`            |  精准防护次数  | 该指标用于统计近5分钟内由精准防护规则防护的攻击数量。单位：次  | ≥0 次  | 防护域名 | 5分钟             |
| `cc_protection_counts`            |  cc防护次数  | 该指标用于统计近5分钟内由CC防护规则防护的攻击数量。单位：次  | ≥0 次 | 防护域名 | 5分钟             |

## 对象 {#object}

采集到的华为云 WAF 对象数据结构, 可以从「基础设施-自定义」里看到对象数据。

```json
{
  "measurement": "huaweicloud_waf",
  "tags": {
    "RegionId"          : "cn-south-1",
    "hostname"          : "xxxxxxxxx.cn",
    "id"                : "9c877f3c83594d10af5aec52bcc1c707",
    "paid_type"         : "prePaid",
    "project_id"        : "756ada1aa17e4049b2a16ea41912e52d"
  },
  "fields": {
    "flag"              : "[JSON 数据]",
    "proxy"             : "False",
    "timestamp"         : "1731653371361",
    "protect_status"    : "1",
    "access_status"     : "1",
    "exclusive_ip"      : "False",
    "web_tag"           : "waf"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 ：`id`值为防护域名 ID，作为唯一识别
