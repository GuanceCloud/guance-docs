---
title: 'Tencent Cloud COS'
tags: 
  - Tencent Cloud
summary: 'Use the "Guance Cloud Sync" series script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance'
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

Use the "Guance Cloud Sync" series script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable the Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with the script installation

If you deploy Func on your own, refer to [Deploy Func on Your Own](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant read-only access `ReadOnlyAccess`)

To synchronize monitoring data of Tencent Cloud COS cloud resources, we install the corresponding collection script: "Guance Integration (Tencent Cloud-COS Collection)" (ID: `guance_tencentcloud_cos`)

In the "Management / Script Market", click [Install], then enter the required parameters: Tencent Cloud AK, Tencent Cloud account name.

Click [Deploy Startup Script], the system will automatically create a `Startup` script set and configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click [Execute] to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

We have collected some configurations by default; see the metrics section for details [Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if there is any asset information.
3. On the Guance platform, under "Metrics", check if there is any corresponding monitoring data.

## Metrics {#metric}
After configuring the Tencent Cloud COS collector, the default collected metric sets are as follows. You can collect more metrics through configuration [Tencent Cloud Cloud Monitoring Metrics Details](https://cloud.tencent.com/document/product/248/45140){:target="_blank"}

### Request Class

| Metric English Name | Metric Chinese Name | Metric Meaning                                                     | Unit | Dimensions     |
| -------------------- | ------------------- | ------------------------------------------------------------------ | ---- | ------------- |
| StdReadRequests      | Standard Storage Read Requests | Number of read requests for standard storage type, counted based on the number of request instructions sent | Times | appid, bucket |
| StdWriteRequests     | Standard Storage Write Requests | Number of write requests for standard storage type, counted based on the number of request instructions sent | Times | appid, bucket |
| MazStdReadRequests   | Multi-AZ Standard Storage Read Requests | Number of read requests for multi-AZ standard storage type, counted based on the number of request instructions sent | Times | appid, bucket |
| MazStdWriteRequests  | Multi-AZ Standard Storage Write Requests | Number of write requests for multi-AZ standard storage type, counted based on the number of request instructions sent | Times | appid, bucket |
| IaReadRequests       | Infrequent Access Storage Read Requests | Number of read requests for infrequent access storage type, counted based on the number of request instructions sent | Times | appid, bucket |
| IaWriteRequests      | Infrequent Access Storage Write Requests | Number of write requests for infrequent access storage type, counted based on the number of request instructions sent | Times | appid, bucket |
| MazIaReadRequests    | Multi-AZ Infrequent Access Storage Read Requests | Number of read requests for multi-AZ infrequent access storage type, counted based on the number of request instructions sent | Times | appid, bucket |
| MazIaWriteRequests   | Multi-AZ Infrequent Access Storage Write Requests | Number of write requests for multi-AZ infrequent access storage type, counted based on the number of request instructions sent | Times | appid, bucket |
| DeepArcReadRequests  | Deep Archive Storage Read Requests | Number of read requests for deep archive storage type, counted based on the number of request instructions sent | Times | appid, bucket |
| DeepArcWriteRequests | Deep Archive Storage Write Requests | Number of write requests for deep archive storage type, counted based on the number of request instructions sent | Times | appid, bucket |
| ItReadRequests       | Intelligent Tiering Storage Read Requests | Number of read requests for intelligent tiering storage type, counted based on the number of request instructions sent | Times | appid, bucket |
| ItWriteRequests      | Intelligent Tiering Storage Write Requests | Number of write requests for intelligent tiering storage type, counted based on the number of request instructions sent | Times | appid, bucket |
| TotalRequests        | Total Requests | Total number of read and write requests for all storage types, counted based on the number of request instructions sent | Times | appid, bucket |
| GetRequests          | GET Total Requests | Total number of GET requests for all storage types, counted based on the number of request instructions sent | Times | appid, bucket |
| PutRequests          | PUT Total Requests | Total number of PUT requests for all storage types, counted based on the number of request instructions sent | Times | appid, bucket |

### Storage Class

| Metric English Name | Metric Chinese Name | Unit | Dimensions     |
| -------------------- | ------------------- | ---- | ------------- |
| Size                | Bucket Storage Capacity | B   | Name |

### Traffic Class

| Metric English Name | Metric Chinese Name | Metric Meaning                                                 | Unit | Dimensions     |
| -------------------- | ------------------- | -------------------------------------------------------------- | ---- | ------------- |
| InternetTraffic     | Outbound Internet Traffic | Traffic generated by downloading data from COS to clients via the internet | B    | appid, bucket |
| InternetTrafficUp   | Inbound Internet Traffic | Traffic generated by uploading data from clients to COS via the internet | B    | appid, bucket |
| InternalTraffic     | Outbound Internal Network Traffic | Traffic generated by downloading data from COS to clients via Tencent Cloud's internal network | B    | appid, bucket |
| InternalTrafficUp   | Inbound Internal Network Traffic | Traffic generated by uploading data from clients to COS via Tencent Cloud's internal network | B    | appid, bucket |
| CdnOriginTraffic    | CDN Origin Traffic | Traffic generated by transmitting data from COS to Tencent Cloud CDN edge nodes | B    | appid, bucket |
| InboundTraffic      | Total Inbound Internet and Internal Network Traffic | Traffic generated by uploading data from clients to COS via the internet and Tencent Cloud's internal network | B    | appid, bucket |
| CrossRegionReplicationTraffic | Cross-Region Replication Traffic | Traffic generated by transmitting data from one region's bucket to another region's bucket | B    | appid, bucket |

### Response Code Class

| Metric English Name | Metric Chinese Name | Metric Meaning                                        | Unit | Dimensions     |
| -------------------- | ------------------- | ----------------------------------------------------- | ---- | ------------- |
| 2xxResponse         | 2xx Status Codes | Number of requests returning status code 2xx | Times | appid, bucket |
| 3xxResponse         | 3xx Status Codes | Number of requests returning status code 3xx | Times | appid, bucket |
| 4xxResponse         | 4xx Status Codes | Number of requests returning status code 4xx | Times | appid, bucket |
| 5xxResponse         | 5xx Status Codes | Number of requests returning status code 5xx | Times | appid, bucket |
| 2xxResponseRate     | 2xx Status Code Ratio | Ratio of requests returning status code 2xx to total requests | %    | appid, bucket |
| 3xxResponseRate     | 3xx Status Code Ratio | Ratio of requests returning status code 3xx to total requests | %    | appid, bucket |
| 4xxResponseRate     | 4xx Status Code Ratio | Ratio of requests returning status code 4xx to total requests | %    | appid, bucket |
| 5xxResponseRate     | 5xx Status Code Ratio | Ratio of requests returning status code 5xx to total requests | %    | appid, bucket |
| 400Response         | 400 Status Code | Number of requests returning status code 400 | Times | appid, bucket |
| 403Response         | 403 Status Code | Number of requests returning status code 403 | Times | appid, bucket |
| 404Response         | 404 Status Code | Number of requests returning status code 404 | Times | appid, bucket |
| 400ResponseRate     | 400 Status Code Ratio | Ratio of requests returning status code 400 to total requests | %    | appid, bucket |
| 403ResponseRate     | 403 Status Code Ratio | Ratio of requests returning status code 403 to total requests | %    | appid, bucket |
| 404ResponseRate     | 404 Status Code Ratio | Ratio of requests returning status code 404 to total requests | %    | appid, bucket |
| 500ResponseRate     | 500 Status Code Ratio | Ratio of requests returning status code 500 to total requests | %    | appid, bucket |
| 501ResponseRate     | 501 Status Code Ratio | Ratio of requests returning status code 501 to total requests | %    | appid, bucket |
| 502ResponseRate     | 502 Status Code Ratio | Ratio of requests returning status code 502 to total requests | %    | appid, bucket |
| 503ResponseRate     | 503 Status Code Ratio | Ratio of requests returning status code 503 to total requests | %    | appid, bucket |

## Objects {#object}

The structure of the collected Tencent Cloud COS object data can be viewed in "Infrastructure - Custom"

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
    "message"     : "{instance JSON data}"
  }
}
```