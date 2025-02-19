---
title: '腾讯云 COS'
tags: 
  - 腾讯云
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
__int_icon: 'icon/tencent_cos'
dashboard:

  - desc: '腾讯云 COS 内置视图'
    path: 'dashboard/zh/tencent_cos'

monitor:
  - desc: '腾讯云 COS 监控器'
    path: 'monitor/zh/tencent_cos'

---


<!-- markdownlint-disable MD025 -->
# 腾讯云 COS
<!-- markdownlint-enable -->

使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的腾讯云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步腾讯云 COS 云资源的监控数据，我们安装对应的采集脚本：「观测云集成（腾讯云-COS采集）」(ID：`guance_tencentcloud_cos`)

在「管理 / 脚本市场」中，点击【安装】后，输入相应的参数：腾讯云 AK、腾讯云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好腾讯云 COS采集后,默认采集的指标集如下, 可以通过配置的方式采集更多的指标 [腾讯云云监控指标详情](https://cloud.tencent.com/document/product/248/45140){:target="_blank"}

### 请求类

| 指标英文名           | 指标中文名               | 指标含义                                                     | 单位 | 维度          |
| -------------------- | ------------------------ | ------------------------------------------------------------ | ---- | ------------- |
| StdReadRequests      | 标准存储读请求           | 标准存储类型读取请求次数，请求次数根据发送请求指令的次数来计算 | 次   | appid、bucket |
| StdWriteRequests     | 标准存储写请求           | 标准存储类型写入请求次数，请求次数根据发送请求指令的次数来计算 | 次   | appid、bucket |
| MazStdReadRequests   | 多 AZ 标准存储读请求     | 多AZ标准存储类型读取请求次数，请求次数根据发送请求指令的次数来计算 | 次   | appid、bucket |
| MazStdWriteRequests  | 多 AZ 标准存储写请求     | 多AZ标准存储类型写入请求次数，请求次数根据发送请求指令的次数来计算 | 次   | appid、bucket |
| IaReadRequests       | 低频存储读请求           | 低频存储类型读取请求次数，请求次数根据发送请求指令的次数来计算 | 次   | appid、bucket |
| IaWriteRequests      | 低频存储写请求           | 低频存储类型写入请求次数，请求次数根据发送请求指令的次数来计算 | 次   | appid、bucket |
| MazIaReadRequests    | 多 AZ 低频存储读请求     | 多 AZ 低频存储类型读取请求次数，请求次数根据发送请求指令的次数来计算 | 次   | appid、bucket |
| MazIaWriteRequests   | 多 AZ 低频存储写请求     | 多 AZ 低频存储类型写入请求次数，请求次数根据发送请求指令的次数来计算 | 次   | appid、bucket |
| DeepArcReadRequests  | 深度归档存储读请求       | 深度归档存储类型读取请求次数，请求次数根据发送请求指令的次数来计算 | 次   | appid、bucket |
| DeepArcWriteRequests | 深度归档存储写请求       | 深度归档存储类型写入请求次数，请求次数根据发送请求指令的次数来计算 | 次   | appid、bucket |
| ItReadRequests       | 智能分层存储读请求       | 智能分层存储类型读取请求次数，请求次数根据发送请求指令的次数来计算 | 次   | appid、bucket |
| ItWriteRequests      | 智能分层存储写请求       | 智能分层存储类型写入请求次数，请求次数根据发送请求指令的次数来计算 | 次   | appid、bucket |
智能分层存储类型写入请求次数，请求次数根据发送请求指令的次数来计算 | 次   | appid、bucket |
| TotalRequests        | 总请求数                 | 所有存储类型的读写总请求次数，请求次数根据发送请求指令的次数来计算 | 次   | appid、bucket |
| GetRequests          | GET 类总请求数           | 所有存储类型 GET 类总请求次数，请求次数根据发送请求指令的次数来计算 | 次   | appid、bucket |
| PutRequests          | PUT 类总请求数           | 所有存储类型 PUT 类总请求次数，请求次数根据发送请求指令的次数来计算 | 次   | appid、bucket |

### 存储类

| 指标英文名                   | 指标中文名                        | 单位 | 维度          |
| ---------------------------- | --------------------------------- | ---- | ------------- |
| Size                   | bucket存储容量                |  B   | Name |


### 流量类

| 指标英文名                    | 指标中文名           | 指标含义                                                 | 单位 | 维度          |
| ----------------------------- | -------------------- | -------------------------------------------------------- | ---- | ------------- |
| InternetTraffic               | 外网下行流量         | 数据通过互联网从 COS 下载到客户端产生的流量              | B    | appid、bucket |
| InternetTrafficUp             | 外网上行流量         | 数据通过互联网从客户端上传到 COS 产生的流量              | B    | appid、bucket |
| InternalTraffic               | 内网下行流量         | 数据通过腾讯云内网从 COS 下载到客户端产生的流量          | B    | appid、bucket |
| InternalTrafficUp             | 内网上行流量         | 数据通过腾讯云内网从客户端上传到 COS 产生的流量          | B    | appid、bucket |
| CdnOriginTraffic              | CDN 回源流量         | 数据从 COS 传输到腾讯云 CDN 边缘节点产生的流量           | B    | appid、bucket |
| InboundTraffic                | 外网、内网上传总流量 | 数据通过互联网、腾讯云内网从客户端上传到 COS 产生的流量  | B    | appid、bucket |
| CrossRegionReplicationTraffic | 跨地域复制流量       | 数据从一个地域的存储桶传输到另一个地域的存储桶产生的流量 | B    | appid、bucket |

### 返回码类

| 指标英文名      | 指标中文名     | 指标含义                                        | 单位 | 维度          |
| --------------- | -------------- | ----------------------------------------------- | ---- | ------------- |
| 2xxResponse     | 2xx 状态码     | 返回状态码为 2xx 的请求次数                     | 次   | appid、bucket |
| 3xxResponse     | 3xx 状态码     | 返回状态码为 3xx 的请求次数                     | 次   | appid、bucket |
| 4xxResponse     | 4xx 状态码     | 返回状态码为 4xx 的请求次数                     | 次   | appid、bucket |
| 5xxResponse     | 5xx 状态码     | 返回状态码为 5xx 的请求次数                     | 次   | appid、bucket |
| 2xxResponseRate | 2xx 状态码占比 | 返回状态码为 2xx 的请求次数在总请求次数中的占比 | %    | appid、bucket |
| 3xxResponseRate | 3xx 状态码占比 | 返回状态码为 3xx 的请求次数在总请求次数中的占比 | %    | appid、bucket |
| 4xxResponseRate | 4xx 状态码占比 | 返回状态码为 4xx 的请求次数在总请求次数中的占比 | %    | appid、bucket |
| 5xxResponseRate | 5xx 状态码占比 | 返回状态码为 5xx 的请求次数在总请求次数中的占比 | %    | appid、bucket |
| 400Response     | 400 状态码     | 返回状态码为 400 的请求次数                     | 次   | appid、bucket |
| 403Response     | 403 状态码     | 返回状态码为 403 的请求次数                     | 次   | appid、bucket |
| 404Response     | 404 状态码     | 返回状态码为 404 的请求次数                     | 次   | appid、bucket |
| 400ResponseRate | 400 状态码占比 | 返回状态码为 400 的请求次数在总请求次数中的占比 | %    | appid、bucket |
| 403ResponseRate | 403 状态码占比 | 返回状态码为 403 的请求次数在总请求次数中的占比 | %    | appid、bucket |
| 404ResponseRate | 404 状态码占比 | 返回状态码为 404 的请求次数在总请求次数中的占比 | %    | appid、bucket |
| 500ResponseRate | 500 状态码占比 | 返回状态码为 500 的请求次数在总请求次数中的占比 | %    | appid、bucket |
| 501ResponseRate | 501 状态码占比 | 返回状态码为 501 的请求次数在总请求次数中的占比 | %    | appid、bucket |
| 502ResponseRate | 502 状态码占比 | 返回状态码为 502 的请求次数在总请求次数中的占比 | %    | appid、bucket |
| 503ResponseRate | 503 状态码占比 | 返回状态码为 503 的请求次数在总请求次数中的占比 | %    | appid、bucket |

## 对象 {#object}

采集到的腾讯云 COS 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "tencentcloud_cos",
  "tags": {
    "name"      : "smart-xxxx",
    "RegionId"  : "ap-nanjing",
    "BucketType": "cos",
    "Location"  : "ap-nanjing"
  },
  "fields": {
    "CreationDate": "2022-04-20T03:12:08Z",
    "message"     : "{实例 JSON 数据}"
  }
}
```

