---
title: '腾讯云 CLB Private'
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
icon: 'icon/tencent_clb'
dashboard:

  - desc: '腾讯云 CLB Private 内置视图'
    path: 'dashboard/zh/tencent_clb_private'

monitor:
  - desc: '腾讯云 CLB Private 监控器'
    path: 'monitor/zh/tencent_clb_private'

---



# 腾讯云 CLB Private

使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func ](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的腾讯云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步云资源的监控数据，我们一般情况下要安装两个脚本，一个采集对应云资产基本信息的脚本，一个是采集云监控信息的脚本。

如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。

分别在「管理 / 脚本市场」中，依次点击并按照对应的脚本包：

- 「观测云集成（腾讯云-云监控采集）」(ID：`guance_tencentcloud_monitor`)
- 「观测云集成（腾讯云-CLB采集）」(ID：`guance_tencentcloud_clb`)

点击【安装】后，输入相应的参数：腾讯云 AK、腾讯云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好腾讯云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [腾讯云云监控指标详情](https://cloud.tencent.com/document/product/248/51899){:target="_blank"}

| 指标英文名          | 指标中文名                 | 指标说明                                                     | 单位    | 统计粒度         |
| ------------------- | -------------------------- | ------------------------------------------------------------ | ------- | ---------------- |
| ClientConnum        | 客户端到 LB 的活跃连接数   | 在统计粒度内的某一时刻，从客户端到负载均衡或监听器上的活跃连接数。 | 个      | 10s、60s、300s   |
| ClientInactiveConn  | 客户端到 LB 的非活跃连接数 | 在统计粒度内的某一时刻，从客户端到负载均衡或监听器上的非活跃连接数。 | 个      | 10s、60s、300s   |
| ClientConcurConn    | 客户端到 LB 的并发连接数   | 在统计粒度内的某一时刻，从客户端到负载均衡或监听器上的并发连接数。 | 个      | 10s、60s、300s   |
| ClientNewConn       | 客户端到 LB 的新建连接数   | 在统计粒度内，从客户端到负载均衡或监听器上的新建连接数。     | 个/秒   | 10s、60s、300s   |
| ClientInpkg         | 客户端到 LB 的入包量       | 在统计粒度内，客户端向负载均衡每秒发送的数据包数量。         | 个/秒   | 10s、60s、300s   |
| ClientOutpkg        | 客户端到 LB 的出包量       | 在统计粒度内，负载均衡向客户端每秒发送的数据包数量。         | 个/秒   | 10s、60s、300s   |
| ClientAccIntraffic  | 客户端到 LB 的入流量       | 在统计粒度内，客户端流入到负载均衡的流量。                   | MB      | 10s、60s、300s   |
| ClientAccOuttraffic | 客户端到 LB 的出流量       | 在统计粒度内，负载均衡流出到客户端的流量。                   | MB      | 10s、60s、300s   |
| ClientOuttraffic    | 客户端到 LB 的出带宽       | 在统计粒度内，负载均衡流出到客户端所用的带宽。               | Mbps    | 10s、60s、300s   |
| ClientIntraffic     | 客户端到 LB 的入带宽       | 在统计粒度内，客户端流入到负载均衡的带宽。                   | Mbps    | 10s、60s、300s   |
| OutTraffic          | LB 到后端的出带宽          | 在统计粒度内，后端 RS 流出到负载均衡所用的带宽。             | Mbps    | 60s、300s        |
| InTraffic           | LB 到后端的入带宽          | 在统计粒度内，负载均衡流入到后端 RS 所用的带宽。             | Mbps    | 60s、300s        |
| OutPkg              | LB 到后端的出包量          | 在统计粒度内，后端 RS 向负载均衡每秒发送的数据包数量。       | 个/秒   | 60s、300s        |
| InPkg               | LB 到后端的入包量          | 在统计粒度内，负载均衡向后端 RS 每秒发送的数据包数量。       | 个/秒   | 60s、300s        |
| ConNum              | LB 到后端的连接数          | 在统计粒度内，从负载均衡到后端 RS 的连接数。                 | 个      | 60s、300s        |
| NewConn             | LB 到后端的新建连接数      | 在统计粒度内，从负载均衡到后端 RS 的新建连接数。             | 个/分钟 | 60s、300s        |
| DropTotalConns      | 丢弃连接数                 | 在统计粒度内，负载均衡或监听器上丢弃的连接数。此指标仅标准账户类型支持，传统账户类型不支持，账户类型判断方式请参见 [判断账户类型](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}。 | 个      | 10s、60s、300s   |
| InDropBits          | 丢弃入带宽                 | 在统计粒度内，客户端通过内网访问负载均衡时丢弃的带宽。此指标仅标准账户类型支持，传统账户类型不支持，账户类型判断方式请参见 [判断账户类型](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}。 | 字节    | 10s、60s、300s   |
| OutDropBits         | 丢弃出带宽                 | 在统计粒度内，负载均衡访问内网时丢弃的带宽。此指标仅标准账户类型支持，传统账户类型不支持，账户类型判断方式请参见 [判断账户类型](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}。 | 字节    | 10s、60s、300s   |
| InDropPkts          | 丢弃流入数据包             | 在统计粒度内，客户端通过内网访问负载均衡时丢弃的数据包。此指标仅标准账户类型支持，传统账户类型不支持，账户类型判断方式请参见 [判断账户类型](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}。 | 个/秒   | 10s、60s、300s   |
| OutDropPkts         | 丢弃流出数据包             | 在统计粒度内，负载均衡访问内网时丢弃的数据包。此指标仅标准账户类型支持，传统账户类型不支持，账户类型判断方式请参见 [判断账户类型](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}。 | 个/秒   | 10s、60s、300s   |
| DropQps             | 丢弃 QPS                   | 在统计粒度内，负载均衡或监听器上丢弃的请求数。此指标为七层监听器独有指标。此指标仅标准账户类型支持，传统账户类型不支持，账户类型判断方式请参见 [判断账户类型](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}。 | 个      | 60s、300s        |
| IntrafficVipRatio   | 入带宽利用率               | 在统计粒度内，客户端通过内网访问负载均衡所用的带宽利用率。 此指标仅标准账户类型支持，传统账户类型不支持，账户类型判断方式请参见 [判断账户类型](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}。此指标处于内测阶段，如需使用，请提交 [工单申请](https://console.cloud.tencent.com/workorder/category?level1_id=6&level2_id=163&source=0&data_title=负载均衡 CLB&level3_id=1071&queue=96&scene_code=34639&step=2){:target="_blank"}。 | %       | 10s、60s、300s   |
| OuttrafficVipRatio  | 出带宽利用率               | 在统计粒度内，负载均衡访问内网所用的带宽使用率。此指标仅标准账户类型支持，传统账户类型不支持，账户类型判断方式请参见 [判断账户类型](https://cloud.tencent.com/document/product/1199/49090#judge){:target="_blank"}。此指标处于内测阶段，如需使用，请提交 [工单申请](https://console.cloud.tencent.com/workorder/category?level1_id=6&level2_id=163&source=0&data_title=负载均衡 CLB&level3_id=1071&queue=96&scene_code=34639&step=2){:target="_blank"}。 | ％      | 10s、60s、300s   |
| ReqAvg              | 平均请求时间               | 在统计粒度内，负载均衡的平均请求时间。此指标为七层监听器独有指标。 | 毫秒    | 60s、300s        |
| ReqMax              | 最大请求时间               | 在统计粒度内，负载均衡的最大请求时间。 此指标为七层监听器独有指标。 | 毫秒    | 60s、300s        |
| RspAvg              | 平均响应时间               | 在统计粒度内，负载均衡的平均响应时间。此指标为七层监听器独有指标。 | 毫秒    | 60s、300s        |
| RspMax              | 最大响应时间               | 在统计粒度内，负载均衡的最大响应时间。此指标为七层监听器独有指标。 | 毫秒    | 60s、300s        |
| RspTimeout          | 响应超时个数               | 在统计粒度内，负载均衡响应超时的个数。 此指标为七层监听器独有指标。 | 个/分钟 | 60s、300s        |
| SuccReq             | 每分钟成功请求数           | 在统计粒度内，负载均衡每分钟的成功请求数。此指标为七层监听器独有指标。 | 个/分钟 | 60s、300s        |
| TotalReq            | 每秒请求数                 | 在统计粒度内，负载均衡每秒钟的请求数。  此指标为七层监听器独有指标。 | 个      | 60s、300s        |
| ClbHttp3xx          | CLB 返回的 3xx 状态码      | 在统计粒度内，负载均衡返回 3xx 状态码的个数（负载均衡和后端服务器返回码之和）。此指标为七层监听器独有指标。 | 个/分钟 | 60s、300s        |
| ClbHttp4xx          | CLB 返回的 4xx 状态码      | 在统计粒度内，负载均衡返回 4xx 状态码的个数（负载均衡和后端服务器返回码之和）。此指标为七层监听器独有指标。 | 个/分钟 | 60s、300s        |
| ClbHttp5xx          | CLB 返回的 5xx 状态码      | 在统计粒度内，负载均衡返回 5xx 状态码的个数（负载均衡和后端服务器返回码之和）。此指标为七层监听器独有指标。 | 个/分钟 | 60s、300s        |
| ClbHttp404          | CLB 返回的 404 状态码      | 在统计粒度内，负载均衡返回 404 状态码的个数（负载均衡和后端服务器返回码之和）。此指标为七层监听器独有指标。 | 个/分钟 | 60s、300s        |
| ClbHttp499          | CLB 返回的 499 状态码      | 在统计粒度内，负载均衡返回 499 状态码的个数（负载均衡和后端服务器返回码之和）。此指标为七层监听器独有指标。 | 个/分钟 | 60s、300s        |
| ClbHttp502          | CLB 返回的 502 状态码      | 在统计粒度内，负载均衡返回 502 状态码的个数（负载均衡和后端服务器返回码之和）。此指标为七层监听器独有指标。 | 个/分钟 | 60s、300s        |
| ClbHttp503          | CLB 返回的 503 状态码      | 在统计粒度内，负载均衡返回 503 状态码的个数（负载均衡和后端服务器返回码之和）。此指标为七层监听器独有指标。 | 个/分钟 | 60s、300s        |
| ClbHttp504          | CLB 返回的 504 状态码      | 在统计粒度内，负载均衡返回 504 状态码的个数（负载均衡和后端服务器返回码之和）。此指标为七层监听器独有指标。 | 个/分钟 | 60s、300s        |
| Http2xx             | 2xx 状态码                 | 在统计粒度内，后端服务器返回 2xx 状态码的个数。此指标为七层监听器独有指标。 | 个/分钟 | 60s、300s        |
| Http3xx             | 3xx 状态码                 | 在统计粒度内，后端服务器返回 3xx 状态码的个数。此指标为七层监听器独有指标。 | 个/分钟 | 60s、300s        |
| Http4xx             | 4xx 状态码                 | 在统计粒度内，后端服务器返回 4xx 状态码的个数。 此指标为七层监听器独有指标。 | 个/分钟 | 60s、300s        |
| Http5xx             | 5xx 状态码                 | 在统计粒度内，后端服务器返回 5xx 状态码的个数。此指标为七层监听器独有指标。 | 个/分钟 | 60s、300s        |
| Http404             | 404 状态码                 | 在统计粒度内，后端服务器返回 404 状态码的个数。此指标为七层监听器独有指标。 | 个/分钟 | 60s、300s        |
| Http499             | 499 状态码                 | 在统计粒度内，后端服务器返回 499 状态码的个数。此指标为七层监听器独有指标。 | 个/分钟 | 60s、300s        |
| Http502             | 502 状态码                 | 在统计粒度内，后端服务器返回 502 状态码的个数。 此指标为七层监听器独有指标。 | 个/分钟 | 60s、300s        |
| Http503             | 503 状态码                 | 在统计粒度内，后端服务器返回 503 状态码的个数。此指标为七层监听器独有指标。 | 个/分钟 | 60s、300s        |
| Http504             | 504 状态码                 | 在统计粒度内，后端服务器返回 504 状态码的个数。此指标为七层监听器独有指标。 | 个/分钟 | 60s、300s        |
| OverloadCurConn     | SNAT 并发连接数            | 在统计周期内，负载均衡的 SNAT IP 每分钟的并发连接数。此指标处于内测阶段，如需使用，请提交 [内测申请](https://cloud.tencent.com/apply/p/z2b346gxli){:target="_blank"}。 | 个/分钟 | 60s              |
| ConnRatio           | SNAT 端口使用率            | 在统计周期内，负载均衡的 SNAT IP 的端口使用率。 端口使用率 = SNAT 并发连接数 / (SNAT IP 数 × 55000 × RS 个数）。此指标处于内测阶段，如需使用，请提交 [内测申请](https://cloud.tencent.com/apply/p/z2b346gxli){:target="_blank"}。 | %       | 60s              |
| SnatFail            | SNAT 失败数                | 在统计周期内，负载均衡的 SNAT IP 与后端 RS 每分钟建立连接的失败次数。此指标处于内测阶段，如需使用，请提交 [内测申请](https://cloud.tencent.com/apply/p/z2b346gxli){:target="_blank"}。 | 个/分钟 | 60s              |
| UnhealthRsCount     | 健康检查异常数             | 在统计周期内，负载均衡的健康检查异常个数。                   | 个      | 60s、300s        |
| ConcurConnVipRatio  | 并发连接数利用率           | 在统计粒度内的某一时刻，从客户端到负载均衡或监听器上的并发连接数相比性能容量型规格的并发连接数性能上限的利用率。此指标仅性能容量型实例支持，共享型实例不支持。 | %       | 10s、60s、300s   |
| NewConnVipRatio     | 新建连接数利用率           | 在统计粒度内的某一时刻，从客户端到负载均衡或监听器上的新建连接数相比性能容量型规格的新建连接数性能上限的利用率。此指标仅性能容量型实例支持，共享型实例不支持。 | %       | 10s、 60s、 300s |

## 对象 {#object}
采集到的腾讯云 CLB Private 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```
{
  "measurement": "tencentcloud_clb",
  "tags": {
    "name"            : "lb-xxxx",
    "RegionId"        : "ap-shanghai",
    "LoadBalancerId"  : "lb-xxxx",
    "LoadBalancerName": "lb-xxxx",
    "Address"         : "81.xxxx",
    "LoadBalancerType": "Private",
    "Status"          : "1",
    "VpcId"           : "vpc-xxxx",
    "Zone"            : "ap-shanghai-3",
    "ChargeType"      : "POSTPAID_BY_HOUR"
  },
  "fields": {
    "CreateTime": "2022-04-27 15:19:49",
    "listeners" : "{监听器 JSON 数据}",
    "message"   : "{实例 JSON 数据}"
  }
}
```
