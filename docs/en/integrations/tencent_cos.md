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
| StdReadRequests      | 标准存储读请求           | Number of standard storage type read requests, the number of requests is calculated based on the number of request commands sent | count   | appid、bucket |
| StdWriteRequests     | 标准存储写请求           | Number of standard storage type write requests, the number of requests is calculated based on the number of request commands sent | count   | appid、bucket |
| MazStdReadRequests   | 多 AZ 标准存储读请求     | Number of read requests for multiple AZ standard storage types, with the number of requests calculated based on the number of request commands sent | count   | appid、bucket |
| MazStdWriteRequests  | 多 AZ 标准存储写请求     | Number of write requests to multiple AZ standard storage types, with the number of requests counted based on the number of request commands sent | count   | appid、bucket |
| IaReadRequests       | 低频存储读请求           | Low-frequency storage type read request count, the request count is calculated based on the number of request commands sent | count   | appid、bucket |
| IaWriteRequests      | 低频存储写请求           | Low-frequency storage type write request count, the request count is calculated based on the number of request commands sent | count   | appid、bucket |
| MazIaReadRequests    | 多 AZ 低频存储读请求     | Multi-AZ low-frequency storage type read request count, the request count is calculated based on the number of request commands sent | count   | appid、bucket |
| MazIaWriteRequests   | 多 AZ 低频存储写请求     | Multi-AZ low-frequency storage type write request count, the request count is calculated based on the number of request commands sent | count   | appid、bucket |
| DeepArcReadRequests  | 深度归档存储读请求       | Number of read requests for deep archive storage types, with the number of requests calculated based on the number of request commands sent | count   | appid、bucket |
| DeepArcWriteRequests | 深度归档存储写请求       | Number of deep archive storage type write requests, the number of requests is calculated based on the number of request commands sent | count   | appid、bucket |
| ItReadRequests       | 智能分层存储读请求       | Intelligent hierarchical storage type read request count, the request count is calculated based on the number of request commands sent | count   | appid、bucket |
| ItWriteRequests      | 智能分层存储写请求       | Intelligent tiered storage type write request count, request count is calculated based on the number of request commands sent | count   | appid、bucket |
Intelligent tiered storage type write request count, request count is calculated based on the number of request commands sent | count   | appid、bucket |
| TotalRequests        | 总请求数                 | Total number of read and write requests for all storage types, with the number of requests calculated based on the number of request commands sent | count   | appid、bucket |
| GetRequests          | GET 类总请求数           | Total number of requests for all storage type GET classes, the number of requests is calculated based on the number of request commands sent | count   | appid、bucket |
| PutRequests          | PUT 类总请求数           | Total number of requests for all storage type PUT classes, the number of requests is calculated according to the number of request commands sent | count   | appid、bucket |

### Storage class

| Metric name                   | 指标中文名                        | Unit | Dimensions          |
| ---------------------------- | --------------------------------- | ---- | ------------- |
| Size                   | bucket存储容量                |  B   | Name |


### Traffic class

| Metric name                    | 指标中文名           | Implication                                                 | Unit | Dimensions          |
| ----------------------------- | -------------------- | -------------------------------------------------------- | ---- | ------------- |
| InternetTraffic               | 外网下行流量         | Traffic generated by data downloading from COS to clients over the Internet              | B    | appid、bucket |
| InternetTrafficUp             | 外网上行流量         | Traffic generated by the uploading of data from the client to the COS over the Internet              | B    | appid、bucket |
| InternalTraffic               | 内网下行流量         | Traffic generated by the data being downloaded from the COS to the client via Tencent Cloud intranet          | B    | appid、bucket |
| InternalTrafficUp             | 内网上行流量         | Traffic generated by uploading data from client to COS via Tencent Cloud intranet          | B    | appid、bucket |
| CdnOriginTraffic              | CDN 回源流量         | Traffic generated by the transmission of data from COS to the edge nodes of Tencent Cloud CDN           | B    | appid、bucket |
| InboundTraffic                | 外网、内网上传总流量 | Traffic generated by data uploaded from clients to COS via Internet, Tencent Cloud intranet  | B    | appid、bucket |
| CrossRegionReplicationTraffic | 跨地域复制流量       | Traffic generated by the transfer of data from storage buckets in one geographic region to storage buckets in another geographic region | B    | appid、bucket |

### Return code class (computing)

| Metric name      | 指标中文名     | Implication                                        | Unit | Dimensions          |
| --------------- | -------------- | ----------------------------------------------- | ---- | ------------- |
| 2xxResponse     | 2xx 状态码     | Returns the number of requests with status code 2xx                     | count   | appid、bucket |
| 3xxResponse     | 3xx 状态码     | Returns the number of requests with status code 3xx                     | count   | appid、bucket |
| 4xxResponse     | 4xx 状态码     | Returns the number of requests with status code 4xx                     | count   | appid、bucket |
| 5xxResponse     | 5xx 状态码     | Returns the number of requests with status code 5xx                     | count   | appid、bucket |
| 2xxResponseRate | 2xx 状态码占比 | Returns the number of requests with status code 2xx as a percentage of the total number of requests | %    | appid、bucket |
| 3xxResponseRate | 3xx 状态码占比 | Returns the number of requests with status code 3xx as a percentage of the total number of requests | %    | appid、bucket |
| 4xxResponseRate | 4xx 状态码占比 | Returns the number of requests with status code 4xx as a percentage of the total number of requests | %    | appid、bucket |
| 5xxResponseRate | 5xx 状态码占比 | Returns the number of requests with status code 5xx as a percentage of the total number of requests | %    | appid、bucket |
| 400Response     | 400 状态码     | Returns the number of requests with status code 400                     | count   | appid、bucket |
| 403Response     | 403 状态码     | Returns the number of requests with status code 403                     | count   | appid、bucket |
| 404Response     | 404 状态码     | Returns the number of requests with status code 404                     | count   | appid、bucket |
| 400ResponseRate | 400 状态码占比 | Returns the number of requests with status code 400 as a percentage of the total number of requests | %    | appid、bucket |
| 403ResponseRate | 403 状态码占比 | Returns the number of requests with status code 403 as a percentage of the total number of requests | %    | appid、bucket |
| 404ResponseRate | 404 状态码占比 | Returns the number of requests with status code 404 as a percentage of the total number of requests | %    | appid、bucket |
| 500ResponseRate | 500 状态码占比 | Returns the number of requests with status code 500 as a percentage of the total number of requests | %    | appid、bucket |
| 501ResponseRate | 501 状态码占比 | Returns the number of requests with status code 501 as a percentage of the total number of requests | %    | appid、bucket |
| 502ResponseRate | 502 状态码占比 | Returns the number of requests with status code 502 as a percentage of the total number of requests | %    | appid、bucket |
| 503ResponseRate | 503 状态码占比 | Returns the number of requests with status code 503 as a percentage of the total number of requests | %    | appid、bucket |

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

