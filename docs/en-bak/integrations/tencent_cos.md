---
title: 'Tencent Cloud COS'
tags: 
  - Tencent Cloud
summary: 'Use the 「Guance Synchronization」 series of script packages in the script market to synchronize data from cloud monitoring cloud assets to the Guance cloud.'
__int_icon: 'icon/tencent_cos'
dashboard:

  - desc: 'Tencent Cloud COS Monitoring View'
    path: 'dashboard/zh/tencent_cos'

monitor:
  - desc: 'Tencent Cloud COS Monitor'
    path: 'monitor/zh/tencent_cos'

---


<!-- markdownlint-disable MD025 -->
# Tencent Cloud COS
<!-- markdownlint-enable -->

Use the 「Guance Synchronization」 series of script packages in the script market to synchronize data from cloud monitoring cloud assets to the Guance.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）


To synchronize the monitoring data of ECS cloud resources, we install the corresponding collection script：「Guance Collection (Tencent Cloud-COS Collection)」(ID：`guance_tencentcloud_cos`)


Click 【Install】 and enter the corresponding parameters: Aliyun AK, Aliyun account name.

Click [Deploy Startup Scripts], the system will automatically create the `Startup` script set and automatically configure the corresponding startup scripts.

You can see the corresponding auto-trigger configuration in "Management / Auto-trigger Configuration" after you turn it on. Click "Execute" to execute the task immediately without waiting for the regular time. Wait for a while, you can check the record and log of the executed task.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist.
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists.
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists.

## Metric {#metric}
Configure Tencent Cloud COS monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Tencent Cloud Monitor Metrics Details](https://cloud.tencent.com/document/product/248/45140){:target="_blank"}

### Request class

| Metric name           | Chinese Metric name               | Implication                                                     | Unit | Dimensions          |
| -------------------- | ------------------------ | ------------------------------------------------------------ | ---- | ------------- |
| StdReadRequests      | Standard storage read requests           | Number of standard storage type read requests, the number of requests is calculated based on the number of request commands sent | count   | appid、bucket |
| StdWriteRequests     | Standard storage write requests           | Number of standard storage type write requests, the number of requests is calculated based on the number of request commands sent | count   | appid、bucket |
| MazStdReadRequests   | Multi AZ standard storage read requests     | Number of read requests for multiple AZ standard storage types, with the number of requests calculated based on the number of request commands sent | count   | appid、bucket |
| MazStdWriteRequests  | Multi AZ standard storage write requests     | Number of write requests to multiple AZ standard storage types, with the number of requests counted based on the number of request commands sent | count   | appid、bucket |
| IaReadRequests       | Low frequency storage read requests           | Low-frequency storage type read request count, the request count is calculated based on the number of request commands sent | count   | appid、bucket |
| IaWriteRequests      | Low frequency storage write requests           | Low-frequency storage type write request count, the request count is calculated based on the number of request commands sent | count   | appid、bucket |
| MazIaReadRequests    | Multi AZ low frequency storage read requests     | Multi-AZ low-frequency storage type read request count, the request count is calculated based on the number of request commands sent | count   | appid、bucket |
| MazIaWriteRequests   | Multi AZ low frequency storage write requests     | Multi-AZ low-frequency storage type write request count, the request count is calculated based on the number of request commands sent | count   | appid、bucket |
| DeepArcReadRequests  | Deep archive storage read requests       | Number of read requests for deep archive storage types, with the number of requests calculated based on the number of request commands sent | count   | appid、bucket |
| DeepArcWriteRequests | Deep archive storage write requests       | Number of deep archive storage type write requests, the number of requests is calculated based on the number of request commands sent | count   | appid、bucket |
| ItReadRequests       | Intelligent tiered storage read requests       | Intelligent hierarchical storage type read request count, the request count is calculated based on the number of request commands sent | count   | appid、bucket |
| ItWriteRequests      | Intelligent tiered storage write requests       | Intelligent tiered storage type write request count, request count is calculated based on the number of request commands sent | count   | appid、bucket |
Intelligent tiered storage type write request count, request count is calculated based on the number of request commands sent | count   | appid、bucket |
| TotalRequests        | Total number of requests                 | Total number of read and write requests for all storage types, with the number of requests calculated based on the number of request commands sent | count   | appid、bucket |
| GetRequests          | Total number of GET class requests           | Total number of requests for all storage type GET classes, the number of requests is calculated based on the number of request commands sent | count   | appid、bucket |
| PutRequests          | Total number of PUT class requests           | Total number of requests for all storage type PUT classes, the number of requests is calculated according to the number of request commands sent | count   | appid、bucket |

### Storage class

| Metric name                   | Chinese Metric name                        | Unit | Dimensions          |
| ---------------------------- | --------------------------------- | ---- | ------------- |
| Size                   | Bucket storage capacity                |  B   | Name |


### Traffic class

| Metric name                    | Chinese Metric name           | Implication                                                 | Unit | Dimensions          |
| ----------------------------- | -------------------- | -------------------------------------------------------- | ---- | ------------- |
| InternetTraffic               | Internet downstream traffic         | Traffic generated by data downloading from COS to clients over the Internet              | B    | appid、bucket |
| InternetTrafficUp             | Internet upstream traffic         | Traffic generated by the uploading of data from the client to the COS over the Internet              | B    | appid、bucket |
| InternalTraffic               | Intranet downstream traffic         | Traffic generated by the data being downloaded from the COS to the client via Tencent Cloud intranet          | B    | appid、bucket |
| InternalTrafficUp             | Intranet upstream traffic         | Traffic generated by uploading data from client to COS via Tencent Cloud intranet          | B    | appid、bucket |
| CdnOriginTraffic              | CDN back to source traffic         | Traffic generated by the transmission of data from COS to the edge nodes of Tencent Cloud CDN           | B    | appid、bucket |
| InboundTraffic                | Total upload traffic of external network and internal network | Traffic generated by data uploaded from clients to COS via Internet, Tencent Cloud intranet  | B    | appid、bucket |
| CrossRegionReplicationTraffic | Cross-region replication traffic       | Traffic generated by the transfer of data from storage buckets in one geographic region to storage buckets in another geographic region | B    | appid、bucket |

### Return code class (computing)

| Metric name      | Chinese Metric name     | Implication                                        | Unit | Dimensions          |
| --------------- | -------------- | ----------------------------------------------- | ---- | ------------- |
| 2xxResponse     | 2xx status code     | Returns the number of requests with status code 2xx                     | count   | appid、bucket |
| 3xxResponse     | 3xx status code     | Returns the number of requests with status code 3xx                     | count   | appid、bucket |
| 4xxResponse     | 4xx status code     | Returns the number of requests with status code 4xx                     | count   | appid、bucket |
| 5xxResponse     | 5xx status code     | Returns the number of requests with status code 5xx                     | count   | appid、bucket |
| 2xxResponseRate | 2xx status code ratio | Returns the number of requests with status code 2xx as a percentage of the total number of requests | %    | appid、bucket |
| 3xxResponseRate | 3xx status code ratio | Returns the number of requests with status code 3xx as a percentage of the total number of requests | %    | appid、bucket |
| 4xxResponseRate | 4xx status code ratio | Returns the number of requests with status code 4xx as a percentage of the total number of requests | %    | appid、bucket |
| 5xxResponseRate | 5xx status code ratio | Returns the number of requests with status code 5xx as a percentage of the total number of requests | %    | appid、bucket |
| 400Response     | 400 status code     | Returns the number of requests with status code 400                     | count   | appid、bucket |
| 403Response     | 403 status code     | Returns the number of requests with status code 403                     | count   | appid、bucket |
| 404Response     | 404 status code     | Returns the number of requests with status code 404                     | count   | appid、bucket |
| 400ResponseRate | 400 status code ratio | Returns the number of requests with status code 400 as a percentage of the total number of requests | %    | appid、bucket |
| 403ResponseRate | 403 status code ratio | Returns the number of requests with status code 403 as a percentage of the total number of requests | %    | appid、bucket |
| 404ResponseRate | 404 status code ratio | Returns the number of requests with status code 404 as a percentage of the total number of requests | %    | appid、bucket |
| 500ResponseRate | 500 status code ratio | Returns the number of requests with status code 500 as a percentage of the total number of requests | %    | appid、bucket |
| 501ResponseRate | 501 status code ratio | Returns the number of requests with status code 501 as a percentage of the total number of requests | %    | appid、bucket |
| 502ResponseRate | 502 status code ratio | Returns the number of requests with status code 502 as a percentage of the total number of requests | %    | appid、bucket |
| 503ResponseRate | 503 status code ratio | Returns the number of requests with status code 503 as a percentage of the total number of requests | %    | appid、bucket |

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
    "message"     : "{Instance JSON data}"
  }
}
```

