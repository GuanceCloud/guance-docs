---
title: 'Tencent Cloud COS'
summary: 'Use the 「Observation Cloud Synchronization」 series of script packages in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/tencent_cos'
dashboard:

  - desc: 'Tencent Cloud COS 内置视图'
    path: 'dashboard/zh/tencent_cos'

monitor:
  - desc: 'Tencent Cloud COS 监控器'
    path: 'monitor/zh/tencent_cos'

---


<!-- markdownlint-disable MD025 -->
# Tencent Cloud COS
<!-- markdownlint-enable -->

Use the 「Observation Cloud Synchronization」 series of script packages in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of ECS cloud resources, we install the corresponding collection script：「观测云集成（腾讯云-COS采集）」(ID：`guance_tencentcloud_cos`)

Click 【Install】 and enter the corresponding parameters: Aliyun AK, Aliyun account name.

Click [Deploy Startup Scripts], the system will automatically create the `Startup` script set and automatically configure the corresponding startup scripts.

You can see the corresponding auto-trigger configuration in "Management / Auto-trigger Configuration" after you turn it on. Click "Execute" to execute the task immediately without waiting for the regular time. Wait for a while, you can check the record and log of the executed task.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist.
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists.
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists.

## Metric {#metric}
Configure Tencent Cloud COS monitoring. The default indicator set is as follows. You can collect more indicators by configuring them [Tencent Cloud Monitor Metrics Details](https://cloud.tencent.com/document/product/248/45140){:target="_blank"}

### Request class

| Metric name           | 指标中文名               | Implication                                                     | Unit | Dimensions          |
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

### Storage class

| 指标英文名                   | 指标中文名                        | 单位 | 维度          |
| ---------------------------- | --------------------------------- | ---- | ------------- |
| Size                   | bucket存储容量                |  B   | Name |


### Traffic class

| 指标英文名                    | 指标中文名           | 指标含义                                                 | 单位 | 维度          |
| ----------------------------- | -------------------- | -------------------------------------------------------- | ---- | ------------- |
| InternetTraffic               | 外网下行流量         | 数据通过互联网从 COS 下载到客户端产生的流量              | B    | appid、bucket |
| InternetTrafficUp             | 外网上行流量         | 数据通过互联网从客户端上传到 COS 产生的流量              | B    | appid、bucket |
| InternalTraffic               | 内网下行流量         | 数据通过腾讯云内网从 COS 下载到客户端产生的流量          | B    | appid、bucket |
| InternalTrafficUp             | 内网上行流量         | 数据通过腾讯云内网从客户端上传到 COS 产生的流量          | B    | appid、bucket |
| CdnOriginTraffic              | CDN 回源流量         | 数据从 COS 传输到腾讯云 CDN 边缘节点产生的流量           | B    | appid、bucket |
| InboundTraffic                | 外网、内网上传总流量 | 数据通过互联网、腾讯云内网从客户端上传到 COS 产生的流量  | B    | appid、bucket |
| CrossRegionReplicationTraffic | 跨地域复制流量       | 数据从一个地域的存储桶传输到另一个地域的存储桶产生的流量 | B    | appid、bucket |

### Return code class (computing)

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

## Object {#object}

Collected Tencent Cloud COS object data structure, you can see the object data from "Infrastructure - Customize".

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

