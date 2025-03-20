---
title: 'Tencent Cloud COS'
tags: 
  - Tencent Cloud
summary: 'Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>'
__int_icon: 'icon/tencent_cos'
dashboard:

  - desc: 'Tencent Cloud COS built-in views'
    path: 'dashboard/en/tencent_cos'

monitor:
  - desc: 'Tencent Cloud COS monitor'
    path: 'monitor/en/tencent_cos'

---


<!-- markdownlint-disable MD025 -->
# Tencent Cloud COS
<!-- markdownlint-enable -->

Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> Integration - Extension - DataFlux Func (Automata): all prerequisites will be automatically installed, please continue with the script installation

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare the required Tencent Cloud AK in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize the monitoring data of Tencent Cloud COS cloud resources, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Tencent Cloud-COS Collection)" (ID: `guance_tencentcloud_cos`)

In the "Manage / Script Market", click 【Install】, then enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We default collect some configurations, details are listed under the metrics section [Customize Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configuration, and check the corresponding task records and logs for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, in "Infrastructure / Custom", check if there is any asset information.
3. On the <<< custom_key.brand_name >>> platform, in "Metrics", check if there is any corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud COS collection, the default collected metric sets are as follows. You can collect more metrics through configuration [Tencent Cloud Cloud Monitoring Metric Details](https://cloud.tencent.com/document/product/248/45140){:target="_blank"}

### Request Type

| Metric English Name          | Metric Chinese Name            | Metric Meaning                                                   | Unit | Dimension        |
| ---------------------------- | ----------------------------- | --------------------------------------------------------------- | ---- | ---------------- |
| StdReadRequests             | Standard Storage Read Requests | Number of read requests for standard storage type, calculated based on the number of request instructions sent | Times | appid, bucket   |
| StdWriteRequests            | Standard Storage Write Requests | Number of write requests for standard storage type, calculated based on the number of request instructions sent | Times | appid, bucket   |
| MazStdReadRequests          | Multi-AZ Standard Storage Read Requests | Number of read requests for multi-AZ standard storage type, calculated based on the number of request instructions sent | Times | appid, bucket   |
| MazStdWriteRequests         | Multi-AZ Standard Storage Write Requests | Number of write requests for multi-AZ standard storage type, calculated based on the number of request instructions sent | Times | appid, bucket   |
| IaReadRequests              | Infrequent Access Storage Read Requests | Number of read requests for infrequent access storage type, calculated based on the number of request instructions sent | Times | appid, bucket   |
| IaWriteRequests             | Infrequent Access Storage Write Requests | Number of write requests for infrequent access storage type, calculated based on the number of request instructions sent | Times | appid, bucket   |
| MazIaReadRequests           | Multi-AZ Infrequent Access Storage Read Requests | Number of read requests for multi-AZ infrequent access storage type, calculated based on the number of request instructions sent | Times | appid, bucket   |
| MazIaWriteRequests          | Multi-AZ Infrequent Access Storage Write Requests | Number of write requests for multi-AZ infrequent access storage type, calculated based on the number of request instructions sent | Times | appid, bucket   |
| DeepArcReadRequests         | Deep Archive Storage Read Requests | Number of read requests for deep archive storage type, calculated based on the number of request instructions sent | Times | appid, bucket   |
| DeepArcWriteRequests        | Deep Archive Storage Write Requests | Number of write requests for deep archive storage type, calculated based on the number of request instructions sent | Times | appid, bucket   |
| ItReadRequests              | Intelligent Tiering Storage Read Requests | Number of read requests for intelligent tiering storage type, calculated based on the number of request instructions sent | Times | appid, bucket   |
| ItWriteRequests             | Intelligent Tiering Storage Write Requests | Number of write requests for intelligent tiering storage type, calculated based on the number of request instructions sent | Times | appid, bucket   |
| TotalRequests               | Total Requests                 | Total number of read and write requests for all storage types, calculated based on the number of request instructions sent | Times | appid, bucket   |
| GetRequests                 | Total GET Requests             | Total number of GET requests for all storage types, calculated based on the number of request instructions sent | Times | appid, bucket   |
| PutRequests                 | Total PUT Requests             | Total number of PUT requests for all storage types, calculated based on the number of request instructions sent | Times | appid, bucket   |

### Storage Type

| Metric English Name          | Metric Chinese Name            | Unit | Dimension        |
| ---------------------------- | ----------------------------- | ---- | ---------------- |
| Size                   | Bucket Storage Capacity      | B    | Name |


### Traffic Type

| Metric English Name                | Metric Chinese Name           | Metric Meaning                                           | Unit | Dimension        |
| --------------------------------- | ---------------------------- | -------------------------------------------------------- | ---- | ---------------- |
| InternetTraffic                    | External Downstream Traffic   | Traffic generated when data is downloaded from COS to the client via the internet | B    | appid, bucket   |
| InternetTrafficUp                  | External Upstream Traffic     | Traffic generated when data is uploaded from the client to COS via the internet | B    | appid, bucket   |
| InternalTraffic                   | Internal Downstream Traffic   | Traffic generated when data is downloaded from COS to the client via Tencent Cloud's internal network | B    | appid, bucket   |
| InternalTrafficUp                 | Internal Upstream Traffic     | Traffic generated when data is uploaded from the client to COS via Tencent Cloud's internal network | B    | appid, bucket   |
| CdnOriginTraffic                  | CDN Origin Traffic           | Traffic generated when data is transmitted from COS to Tencent Cloud CDN edge nodes | B    | appid, bucket   |
| InboundTraffic                    | Total External and Internal Upload Traffic | Traffic generated when data is uploaded from the client to COS via the internet or Tencent Cloud's internal network | B    | appid, bucket   |
| CrossRegionReplicationTraffic     | Cross-Region Replication Traffic | Traffic generated when data is transmitted from one region's bucket to another region's bucket | B    | appid, bucket   |

### Response Code Type

| Metric English Name       | Metric Chinese Name        | Metric Meaning                                       | Unit | Dimension        |
| ------------------------- | ------------------------- | ---------------------------------------------------- | ---- | ---------------- |
| 2xxResponse              | 2xx Status Codes          | Number of requests returning status code 2xx          | Times | appid, bucket   |
| 3xxResponse              | 3xx Status Codes          | Number of requests returning status code 3xx          | Times | appid, bucket   |
| 4xxResponse              | 4xx Status Codes          | Number of requests returning status code 4xx          | Times | appid, bucket   |
| 5xxResponse              | 5xx Status Codes          | Number of requests returning status code 5xx          | Times | appid, bucket   |
| 2xxResponseRate          | 2xx Status Code Ratio     | Percentage of requests returning status code 2xx out of total requests | %    | appid, bucket   |
| 3xxResponseRate          | 3xx Status Code Ratio     | Percentage of requests returning status code 3xx out of total requests | %    | appid, bucket   |
| 4xxResponseRate          | 4xx Status Code Ratio     | Percentage of requests returning status code 4xx out of total requests | %    | appid, bucket   |
| 5xxResponseRate          | 5xx Status Code Ratio     | Percentage of requests returning status code 5xx out of total requests | %    | appid, bucket   |
| 400Response              | 400 Status Code           | Number of requests returning status code 400          | Times | appid, bucket   |
| 403Response              | 403 Status Code           | Number of requests returning status code 403          | Times | appid, bucket   |
| 404Response              | 404 Status Code           | Number of requests returning status code 404          | Times | appid, bucket   |
| 400ResponseRate          | 400 Status Code Ratio     | Percentage of requests returning status code 400 out of total requests | %    | appid, bucket   |
| 403ResponseRate          | 403 Status Code Ratio     | Percentage of requests returning status code 403 out of total requests | %    | appid, bucket   |
| 404ResponseRate          | 404 Status Code Ratio     | Percentage of requests returning status code 404 out of total requests | %    | appid, bucket   |
| 500ResponseRate          | 500 Status Code Ratio     | Percentage of requests returning status code 500 out of total requests | %    | appid, bucket   |
| 501ResponseRate          | 501 Status Code Ratio     | Percentage of requests returning status code 501 out of total requests | %    | appid, bucket   |
| 502ResponseRate          | 502 Status Code Ratio     | Percentage of requests returning status code 502 out of total requests | %    | appid, bucket   |
| 503ResponseRate          | 503 Status Code Ratio     | Percentage of requests returning status code 503 out of total requests | %    | appid, bucket   |

## Objects {#object}

The collected Tencent Cloud COS object data structure can be seen in "Infrastructure - Custom"

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