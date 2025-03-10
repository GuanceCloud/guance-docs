---
title: 'Tencent Cloud COS'
tags: 
  - Tencent Cloud
summary: 'Use the script packages in the Script Market of Guance series to synchronize cloud monitoring and cloud asset data to Guance'
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

Use the script packages in the Script Market of Guance series to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with the script installation

If you deploy Func on your own, refer to [Deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data of Tencent Cloud COS cloud resources, we install the corresponding collection script:「Guance Integration (Tencent Cloud-COS Collection)」(ID: `guance_tencentcloud_cos`)

In 「Manage / Script Market」, click 【Install】, then enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.

By default, we collect some configurations, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"} for details.


### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding task has an automatic trigger configuration, and check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, under 「Infrastructure / Custom」check if there is asset information.
3. On the Guance platform, under 「Metrics」check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud COS collection, the default collected metrics set is as follows. You can collect more metrics through configuration [Tencent Cloud Monitoring Metrics Details](https://cloud.tencent.com/document/product/248/45140){:target="_blank"}

### Request Metrics

| Metric Name           | Metric Description               | Metric Meaning                                                     | Unit | Dimensions          |
| -------------------- | ------------------------ | ------------------------------------------------------------ | ---- | ------------- |
| StdReadRequests      | Standard Storage Read Requests   | Number of read requests for standard storage type, calculated by the number of request instructions sent | Count   | appid, bucket |
| StdWriteRequests     | Standard Storage Write Requests  | Number of write requests for standard storage type, calculated by the number of request instructions sent | Count   | appid, bucket |
| MazStdReadRequests   | Multi-AZ Standard Storage Read Requests | Number of read requests for multi-AZ standard storage type, calculated by the number of request instructions sent | Count   | appid, bucket |
| MazStdWriteRequests  | Multi-AZ Standard Storage Write Requests | Number of write requests for multi-AZ standard storage type, calculated by the number of request instructions sent | Count   | appid, bucket |
| IaReadRequests       | Infrequent Access Storage Read Requests | Number of read requests for infrequent access storage type, calculated by the number of request instructions sent | Count   | appid, bucket |
| IaWriteRequests      | Infrequent Access Storage Write Requests | Number of write requests for infrequent access storage type, calculated by the number of request instructions sent | Count   | appid, bucket |
| MazIaReadRequests    | Multi-AZ Infrequent Access Storage Read Requests | Number of read requests for multi-AZ infrequent access storage type, calculated by the number of request instructions sent | Count   | appid, bucket |
| MazIaWriteRequests   | Multi-AZ Infrequent Access Storage Write Requests | Number of write requests for multi-AZ infrequent access storage type, calculated by the number of request instructions sent | Count   | appid, bucket |
| DeepArcReadRequests  | Deep Archive Storage Read Requests | Number of read requests for deep archive storage type, calculated by the number of request instructions sent | Count   | appid, bucket |
| DeepArcWriteRequests | Deep Archive Storage Write Requests | Number of write requests for deep archive storage type, calculated by the number of request instructions sent | Count   | appid, bucket |
| ItReadRequests       | Intelligent Tiering Storage Read Requests | Number of read requests for intelligent tiering storage type, calculated by the number of request instructions sent | Count   | appid, bucket |
| ItWriteRequests      | Intelligent Tiering Storage Write Requests | Number of write requests for intelligent tiering storage type, calculated by the number of request instructions sent | Count   | appid, bucket |
| TotalRequests        | Total Requests                  | Total number of read and write requests for all storage types, calculated by the number of request instructions sent | Count   | appid, bucket |
| GetRequests          | Total GET Requests              | Total number of GET requests for all storage types, calculated by the number of request instructions sent | Count   | appid, bucket |
| PutRequests          | Total PUT Requests              | Total number of PUT requests for all storage types, calculated by the number of request instructions sent | Count   | appid, bucket |

### Storage Metrics

| Metric Name                   | Metric Description                        | Unit | Dimensions          |
| ---------------------------- | --------------------------------- | ---- | ------------- |
| Size                         | Bucket Storage Capacity             | B    | Name |


### Traffic Metrics

| Metric Name                    | Metric Description           | Metric Meaning                                                 | Unit | Dimensions          |
| ----------------------------- | -------------------- | -------------------------------------------------------- | ---- | ------------- |
| InternetTraffic               | External Downstream Traffic | Traffic generated from downloading data from COS to clients over the internet | B    | appid, bucket |
| InternetTrafficUp             | External Upstream Traffic   | Traffic generated from uploading data from clients to COS over the internet | B    | appid, bucket |
| InternalTraffic               | Internal Downstream Traffic | Traffic generated from downloading data from COS to clients over Tencent Cloud's internal network | B    | appid, bucket |
| InternalTrafficUp             | Internal Upstream Traffic   | Traffic generated from uploading data from clients to COS over Tencent Cloud's internal network | B    | appid, bucket |
| CdnOriginTraffic              | CDN Origin Traffic           | Traffic generated from transferring data from COS to Tencent Cloud CDN edge nodes | B    | appid, bucket |
| InboundTraffic                | Total Upload Traffic         | Total traffic generated from uploading data from clients to COS over the internet and Tencent Cloud's internal network | B    | appid, bucket |
| CrossRegionReplicationTraffic | Cross-region Replication Traffic | Traffic generated from transferring data from one region's bucket to another region's bucket | B    | appid, bucket |

### Response Code Metrics

| Metric Name      | Metric Description     | Metric Meaning                                        | Unit | Dimensions          |
| --------------- | -------------- | ----------------------------------------------- | ---- | ------------- |
| 2xxResponse     | 2xx Status Codes     | Number of requests returning status code 2xx                     | Count   | appid, bucket |
| 3xxResponse     | 3xx Status Codes     | Number of requests returning status code 3xx                     | Count   | appid, bucket |
| 4xxResponse     | 4xx Status Codes     | Number of requests returning status code 4xx                     | Count   | appid, bucket |
| 5xxResponse     | 5xx Status Codes     | Number of requests returning status code 5xx                     | Count   | appid, bucket |
| 2xxResponseRate | 2xx Status Code Ratio | Percentage of requests returning status code 2xx out of total requests | %    | appid, bucket |
| 3xxResponseRate | 3xx Status Code Ratio | Percentage of requests returning status code 3xx out of total requests | %    | appid, bucket |
| 4xxResponseRate | 4xx Status Code Ratio | Percentage of requests returning status code 4xx out of total requests | %    | appid, bucket |
| 5xxResponseRate | 5xx Status Code Ratio | Percentage of requests returning status code 5xx out of total requests | %    | appid, bucket |
| 400Response     | 400 Status Code     | Number of requests returning status code 400                     | Count   | appid, bucket |
| 403Response     | 403 Status Code     | Number of requests returning status code 403                     | Count   | appid, bucket |
| 404Response     | 404 Status Code     | Number of requests returning status code 404                     | Count   | appid, bucket |
| 400ResponseRate | 400 Status Code Ratio | Percentage of requests returning status code 400 out of total requests | %    | appid, bucket |
| 403ResponseRate | 403 Status Code Ratio | Percentage of requests returning status code 403 out of total requests | %    | appid, bucket |
| 404ResponseRate | 404 Status Code Ratio | Percentage of requests returning status code 404 out of total requests | %    | appid, bucket |
| 500ResponseRate | 500 Status Code Ratio | Percentage of requests returning status code 500 out of total requests | %    | appid, bucket |
| 501ResponseRate | 501 Status Code Ratio | Percentage of requests returning status code 501 out of total requests | %    | appid, bucket |
| 502ResponseRate | 502 Status Code Ratio | Percentage of requests returning status code 502 out of total requests | %    | appid, bucket |
| 503ResponseRate | 503 Status Code Ratio | Percentage of requests returning status code 503 out of total requests | %    | appid, bucket |

## Objects {#object}

The structure of collected Tencent Cloud COS object data can be viewed under 「Infrastructure - Custom」

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