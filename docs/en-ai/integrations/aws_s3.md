---
title: 'AWS S3'
tags: 
  - AWS
summary: 'Use the script packages in the script market of Guance series to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/aws_s3'
dashboard:

  - desc: 'Built-in view for AWS S3'
    path: 'dashboard/en/aws_s3'

monitor:
  - desc: 'AWS S3 Monitor'
    path: 'monitor/en/aws_s3'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_s3'
---


<!-- markdownlint-disable MD025 -->
# AWS S3
<!-- markdownlint-enable -->

Use the script packages in the script market of Guance series to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable Guance Integration - Extension - Hosted Func: all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant read-only access `ReadOnlyAccess`)

To synchronize AWS S3 monitoring data, we install the corresponding collection script: "Guance Integration (AWS-S3 Collection)" (ID: `guance_aws_s3`)

After clicking [Install], enter the corresponding parameters: Amazon AK, Amazon account name.

Click [Deploy Startup Script], the system will automatically create a `Startup` script set and configure the startup script accordingly.

In addition, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click [Execute] to immediately execute once without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

We have collected some configurations by default. For more details, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration. You can also check the corresponding task records and logs to ensure there are no anomalies.
2. On the Guance platform, in "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, in "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
Configure Amazon CloudWatch properly, and the default metric sets are as follows. You can collect more metrics through configuration. See [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/AmazonS3/latest/userguide/metrics-dimensions.html){:target="_blank"}

### Daily Storage Metrics for Amazon S3 Buckets in CloudWatch

The `AWS/S3` namespace contains the following daily storage metrics for buckets.

| Metric              | Description                                                         |
| :---------------- | :----------------------------------------------------------- |
| `BucketSizeBytes` | The amount of data stored in the bucket across the following storage classes (in bytes): S3 Standard (`STANDARD`) S3 Intelligent-Tiering (`INTELLIGENT_TIERING`) S3 Standard-Infrequent Access (`STANDARD_IA`) S3 OneZone-Infrequent Access (`ONEZONE_IA`) Reduced Redundancy Storage (RRS) (`REDUCED_REDUNDANCY`) S3 Glacier Instant Retrieval (`GLACIER_IR`) S3 Glacier Deep Archive (`DEEP_ARCHIVE`) S3 Glacier Flexible Retrieval (`GLACIER`). This value is calculated by aggregating the sizes of all objects and metadata (current and non-current objects) in the bucket, including the sizes of all parts of multipart uploads that have not been completed. Valid storage type filter conditions: `StandardStorage`, `IntelligentTieringFAStorage`, `IntelligentTieringIAStorage`, `IntelligentTieringAAStorage`, `IntelligentTieringAIAStorage`, `IntelligentTieringDAAStorage`, `StandardIAStorage`, `StandardIASizeOverhead`, `StandardIAObjectOverhead`, `OneZoneIAStorage`, `OneZoneIASizeOverhead`, `ReducedRedundancyStorage`, `GlacierInstantRetrievalSizeOverhead`, `GlacierInstantRetrievalStorage`, `GlacierStorage`, `GlacierStagingStorage`, `GlacierObjectOverhead`, `GlacierS3ObjectOverhead`, `DeepArchiveStorage`, `DeepArchiveObjectOverhead`, `DeepArchiveS3ObjectOverhead`, and `DeepArchiveStagingStorage` (please refer to the `StorageType` dimension). Unit: bytes Valid statistics: Average |
| `NumberOfObjects` | The total number of objects across all storage classes stored in the bucket. This value is calculated by counting all objects (including current and non-current objects), delete markers, and all parts of multipart uploads that have not been completed in the bucket. Valid storage type filter condition: `AllStorageTypes` (please refer to the `StorageType` dimension). Unit: count Valid statistics: Average |

### Request Metrics for Amazon S3 in CloudWatch

The `AWS/S3` namespace contains the following request metrics. These metrics include non-billable requests (such as GET requests from COPY and Replication).

| Metric                  | Description                                                         |
| :-------------------- | :----------------------------------------------------------- |
| `AllRequests`         | The total number of HTTP requests made to an Amazon S3 bucket regardless of type. If you configure a metric for a specific filter condition, it returns only HTTP requests that meet the filter condition's criteria. Unit: count Valid statistics: Sum |
| `GetRequests`         | The number of HTTP GET requests made to objects in an Amazon S3 bucket. This does not include list operations. This metric increments for each source of a COPY object request. Unit: count Valid statistics: Sum Note: Requests for paginated lists (e.g., [List Multipart Uploads](https://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadListMPUpload.html){:target="_blank"}, [List Parts](https://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadListParts.html){:target="_blank"}, [GET Bucket Object Versions](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETVersion.html){:target="_blank"} and other requests) are not included in this metric. |
| `PutRequests`         | The number of HTTP PUT requests made to objects in an Amazon S3 bucket. This metric increments for each target of a COPY object request. Unit: count Valid statistics: Sum |
| `DeleteRequests`      | The number of HTTP `DELETE` requests made to objects in an Amazon S3 bucket. This metric includes [delete multiple objects](https://docs.aws.amazon.com/AmazonS3/latest/API/multiobjectdeleteapi.html){:target="_blank"} requests. It shows the number of requests issued rather than the number of deleted objects. Unit: count Valid statistics: Sum |
| `HeadRequests`        | The number of HTTP `HEAD` requests made to an Amazon S3 bucket. Unit: count Valid statistics: Sum |
| `PostRequests`        | The number of HTTP `POST` requests made to an Amazon S3 bucket. Unit: count Valid statistics: Sum Note: [delete multiple objects](https://docs.aws.amazon.com/AmazonS3/latest/API/multiobjectdeleteapi.html){:target="_blank"} and [SELECT Object Content](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"} requests are not included in this metric. |
| `SelectRequests`      | The number of Amazon S3 [SELECT Object Content](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"} requests made to objects in an Amazon S3 bucket. Unit: count Valid statistics: Sum |
| `SelectBytesScanned`  | The number of bytes scanned using Amazon S3 [SELECT Object Content](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"} requests in an Amazon S3 bucket. Unit: bytes Valid statistics: Average (bytes per request), Sum (bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `SelectBytesReturned` | The number of bytes returned using Amazon S3 [SELECT Object Content](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"} requests in an Amazon S3 bucket. Unit: bytes Valid statistics: Average (bytes per request), Sum (bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `ListRequests`        | The number of HTTP requests to list bucket contents. Unit: count Valid statistics: Sum    |
| `BytesDownloaded`     | The number of bytes downloaded for requests made to an Amazon S3 bucket (the response includes the body). Unit: bytes Valid statistics: Average (bytes per request), Sum (bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `BytesUploaded`       | The number of bytes uploaded for requests made to an Amazon S3 bucket (the request includes the body). Unit: bytes Valid statistics: Average (bytes per request), Sum (bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `4xxErrors`           | The number of HTTP 4xx client error status code requests made to an Amazon S3 bucket. Average statistics show the error rate, and Sum statistics show the count of such errors per period. Unit: count Valid statistics: Average (number of reports per request), Sum (number of reports per period), Min, Max, Sample Count |
| `5xxErrors`           | The number of HTTP 5xx server error status code requests made to an Amazon S3 bucket. Average statistics show the error rate, and Sum statistics show the count of such errors per period. Unit: count Valid statistics: Average (number of reports per request), Sum (number of reports per period), Min, Max, Sample Count |
| `FirstByteLatency`    | The time taken per request from when Amazon S3 bucket receives a complete request until it starts returning the response. Unit: milliseconds Valid statistics: Average, Sum, Min, Max (same as p100), Sample Count, any percentile between p0.0 and p100 |
| `TotalRequestLatency` | The total time taken per request from receiving the first byte to sending the last byte to the Amazon S3 bucket. This metric includes the time taken to receive the request body and send the response body (not included in `FirstByteLatency`). Unit: milliseconds Valid statistics: Average, Sum, Min, Max (same as p100), Sample Count, any percentile between p0.0 and p100 |

### Replication Metrics in CloudWatch

You can use S3 replication metrics to monitor the progress of replication by tracking pending bytes, pending operations, and replication latency. For more details, see [Monitoring Progress Using Replication Metrics](https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-metrics.html){:target="_blank"}.

Note:

You can enable alarms for replication metrics in Amazon CloudWatch. When setting up alarms for replication metrics, set the **Missing data treatment (丢失数据处理)** field to **Treat missing data as ignore (maintain the alarm state) [将丢失的数据视为忽略（保持警报状态）]**.

| Metric                           | Description                                                         |
| :----------------------------- | :----------------------------------------------------------- |
| `ReplicationLatency`           | The maximum number of seconds by which the replication destination AWS region lags behind the source AWS region for a given replication rule. Unit: seconds Valid statistics: Max |
| `BytesPendingReplication`      | The total number of bytes of objects pending replication for a given replication rule. Unit: bytes Valid statistics: Max |
| `OperationsPendingReplication` | The number of pending replication operations for a given replication rule. Unit: count Valid statistics: Max      |
| `OperationsFailedReplication`  | The number of failed replication operations for a given replication rule. Unit: count Valid statistics: Sum (total number of failed operations), Average (failure rate), Sample Count (total number of replication operations) |

### S3 Storage Lens Metrics in CloudWatch

You can publish S3 Storage Lens usage and activity metrics to Amazon CloudWatch to create a unified view of operational health on CloudWatch [dashboards](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Dashboards.html){:target="_blank"}. S3 Storage Lens metrics are published to the `AWS/S3/Storage-Lens` namespace in CloudWatch. CloudWatch publishing options are available for S3 Storage Lens dashboards upgraded to advanced metrics and recommendations.

For a list of S3 Storage Lens metrics published to CloudWatch, see [Amazon S3 Storage Lens Metrics Glossary](https://docs.aws.amazon.com/zh_cn/AmazonS3/latest/userguide/storage_lens_metrics_glossary.html){:target="_blank"}. For a complete list of dimensions, see [Dimensions](https://docs.aws.amazon.com/zh_cn/AmazonS3/latest/userguide/storage-lens-cloudwatch-metrics-dimensions.html#storage-lens-cloudwatch-dimensions){:target="_blank"}.

### S3 Object Lambda Request Metrics in CloudWatch

S3 Object Lambda includes the following request metrics.

| Metric                     | Description                                                         |
| :----------------------- | :----------------------------------------------------------- |
| `AllRequests`            | The total number of HTTP requests made to an Amazon S3 bucket using an Object Lambda access point. Unit: count Valid statistics: Sum |
| `GetRequests`            | The number of HTTP `GET` requests made to objects using an Object Lambda access point. This metric does not include list operations. Unit: count Valid statistics: Sum |
| `BytesUploaded`          | The number of bytes uploaded to an Amazon S3 bucket using an Object Lambda access point (the request includes the body). Unit: bytes Valid statistics: Average (bytes per request), Sum (bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `PostRequests`           | The number of HTTP `POST` requests made to an Amazon S3 bucket using an Object Lambda access point. Unit: count Valid statistics: Sum |
| `PutRequests`            | The number of HTTP `PUT` requests made to objects in an Amazon S3 bucket using an Object Lambda access point. Unit: count Valid statistics: Sum |
| `DeleteRequests`         | The number of HTTP `DELETE` requests made to objects in an Amazon S3 bucket using an Object Lambda access point. This metric includes [delete multiple objects](https://docs.aws.amazon.com/AmazonS3/latest/API/multiobjectdeleteapi.html){:target="_blank"} requests. It shows the number of requests issued rather than the number of deleted objects. Unit: count Valid statistics: Sum |
| `BytesDownloaded`        | The number of bytes downloaded for requests made to an Amazon S3 bucket using an Object Lambda access point (the response includes the body). Unit: bytes Valid statistics: Average (bytes per request), Sum (bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p100 |
| `FirstByteLatency`       | The time taken per request from when Amazon S3 bucket receives a complete request via an Object Lambda access point until it starts returning the response. This metric depends on the runtime of the AWS Lambda function performing transformations on the object before returning bytes to the Object Lambda access point. Unit: milliseconds Valid statistics: Average, Sum, Min, Max (same as p100), Sample Count, any percentile between p0.0 and p100 |
| `TotalRequestLatency`    | The total time taken per request from receiving the first byte to sending the last byte to the Object Lambda access point. This metric includes the time taken to receive the request body and send the response body (not included in `FirstByteLatency`). Unit: milliseconds Valid statistics: Average, Sum, Min, Max (same as p100), Sample Count, any percentile between p0.0 and p100 |
| `HeadRequests`           | The number of HTTP `HEAD` requests made to an Amazon S3 bucket using an Object Lambda access point. Unit: count Valid statistics: Sum |
| `ListRequests`           | The number of HTTP `GET` requests to list the contents of an Amazon S3 bucket. This metric includes both `List` and `ListV2` operations. Unit: count Valid statistics: Sum |
| `4xxErrors`              | The number of HTTP 4xx server error status code requests made to an Amazon S3 bucket using an Object Lambda access point. Average statistics show the error rate, and Sum statistics show the count of such errors per period. Unit: count Valid statistics: Average (number of reports per request), Sum (number of reports per period), Min, Max, Sample Count |
| `5xxErrors`              | The number of HTTP 5xx server error status code requests made to an Amazon S3 bucket using an Object Lambda access point. Average statistics show the error rate, and Sum statistics show the count of such errors per period. Unit: count Valid statistics: Average (number of reports per request), Sum (number of reports per period), Min, Max, Sample Count |
| `ProxiedRequests`        | The number of HTTP requests made to an Object Lambda access point that returns standard Amazon S3 API responses. (These requests do not have a configured Lambda function.) Unit: count Valid statistics: Sum |
| `InvokedLambda`          | The number of HTTP requests to S3 objects in which a Lambda function is invoked. Unit: count Valid statistics: Sum |
| `LambdaResponseRequests` | The number of `WriteGetObjectResponse` requests issued by the Lambda function. This metric applies only to `GetObject` requests. |
| `LambdaResponse4xx`      | The number of HTTP 4xx client errors that occur when the Lambda function calls `WriteGetObjectResponse`. This metric provides the same information as `4xxErrors` but applies only to `WriteGetObjectResponse` calls. |
| `LambdaResponse5xx`      | The number of HTTP 5xx server errors that occur when the Lambda function calls `WriteGetObjectResponse`. This metric provides the same information as `5xxErrors` but applies only to `WriteGetObjectResponse` calls. |

### Metrics for Amazon S3 on Outposts in CloudWatch

For a list of metrics used for S3 on Outposts in CloudWatch, see [CloudWatch Metrics](https://docs.aws.amazon.com/zh_cn/AmazonS3/latest/userguide/S3OutpostsCapacity.html#S3OutpostsCloudWatchMetrics){:target="_blank"}.

### Dimensions for Amazon S3 in CloudWatch

The following dimensions are used to filter Amazon S3 metrics.

| Dimension          | Description                                                         |
| :------------ | :----------------------------------------------------------- |
| `BucketName`  | This dimension filters data for requests only for identified buckets.                         |
| `StorageType` | This dimension filters data stored in the bucket by the following storage types: `StandardStorage` – Number of bytes for objects in the `STANDARD` storage class. `IntelligentTieringAAStorage` – Number of bytes for objects in the archive access tier of the `INTELLIGENT_TIERING` storage class. `IntelligentTieringAIAStorage` – Number of bytes for objects in the instant access tier of the `INTELLIGENT_TIERING` storage class. `IntelligentTieringDAAStorage` – Number of bytes for objects in the deep archive access tier of the `INTELLIGENT_TIERING` storage class. `IntelligentTieringFAStorage` – Number of bytes for objects in the frequent access tier of the `INTELLIGENT_TIERING` storage class. `IntelligentTieringIAStorage` – Number of bytes for objects in the infrequent access tier of the `INTELLIGENT_TIERING` storage class. `StandardIAStorage` – Number of bytes for objects in the `STANDARD_IA` storage class. `StandardIASizeOverhead` – Number of bytes for objects smaller than 128KB in the `STANDARD_IA` storage class. `IntAAObjectOverhead` – For each object in the archive access tier of the `INTELLIGENT_TIERING` storage class, S3 Glacier adds 32KB of storage for indexing and related metadata. This additional data is required for identifying and restoring objects. Additional storage is charged at S3 Glacier rates. `IntAAS3ObjectOverhead` – For each object in the archive access tier of the `INTELLIGENT_TIERING` storage class, Amazon S3 uses 8KB of storage for naming the object and other metadata. Additional storage is charged at S3 Standard rates. `IntDAAObjectOverhead` – For each object in the deep archive access tier of the `INTELLIGENT_TIERING` storage class, S3 Glacier adds 32KB of storage for indexing and related metadata. This additional data is required for identifying and restoring objects. Additional storage is charged at S3 Glacier Deep Archive rates. `IntDAAS3ObjectOverhead` – For each object in the deep archive access tier of the `INTELLIGENT_TIERING` storage class, Amazon S3 adds 8KB of storage for indexing and related metadata. Additional storage is charged at S3 Standard rates. `OneZoneIAStorage` – Number of bytes for objects in the `ONEZONE_IA` storage class. `OneZoneIASizeOverhead` – Number of bytes for objects smaller than 128KB in the `ONEZONE_IA` storage class. `ReducedRedundancyStorage` – Number of bytes for objects in the low redundancy storage (RRS) class. `GlacierInstantRetrievalSizeOverhead` – Number of bytes for objects smaller than 128KB in the S3 Glacier Instant Retrieval storage class. `GlacierInstantRetrievalStorage` – Number of bytes for objects in the S3 Glacier Instant Retrieval storage class. `GlacierStorage` – Number of bytes for objects in the S3 Glacier Flexible Retrieval storage class. `GlacierStagingStorage` – Number of bytes for individual parts of multipart objects in the S3 Glacier Flexible Retrieval storage class before completing a `CompleteMultipartUpload` request. `GlacierObjectOverhead` – For each archived object, S3 Glacier adds 32KB of storage for indexing and related metadata. Additional storage is charged at S3 Glacier Flexible Retrieval rates. `GlacierS3ObjectOverhead` – For each archived object in the S3 Glacier Flexible Retrieval storage class, Amazon S3 uses 8KB of storage for naming the object and other metadata. Additional storage is charged at S3 Standard rates. `DeepArchiveStorage` – Number of bytes for objects in the S3 Glacier Deep Archive storage class. `DeepArchiveObjectOverhead` – For each archived object, S3 Glacier adds 32KB of storage for indexing and related metadata. Additional storage is charged at S3 Glacier Deep Archive rates. `DeepArchiveS3ObjectOverhead` – For each archived object in the S3 Glacier Deep Archive storage class, Amazon S3 adds 8KB of storage for indexing and related metadata. Additional storage is charged at S3 Standard rates. `DeepArchiveStagingStorage` - Number of bytes for individual parts of multipart objects in the S3 Glacier Deep Archive storage class before completing a `CompleteMultipartUpload` request. |
| `FilterId`    | This dimension filters the metric configuration specified for requests on the bucket. When creating a metric configuration, you need to specify a filter condition ID (e.g., prefix, tag, or access point). For more details, see [Creating Metric Configurations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/metrics-configurations.html){:target="_blank"}. |

### Dimensions for S3 Storage Lens Metrics in CloudWatch

For a list of dimensions used to filter S3 Storage Lens metrics in CloudWatch, see [Dimensions](https://docs.aws.amazon.com/zh_cn/AmazonS3/latest/userguide/storage-lens-cloudwatch-metrics-dimensions.html#storage-lens-cloudwatch-dimensions){:target="_blank"}.

### Dimensions for S3 Object Lambda Request Metrics in CloudWatch

The following dimensions are used to filter data from Object Lambda access points.

| Dimension              | Description                                                         |
| :---------------- | :----------------------------------------------------------- |
| `AccessPointName` | The name of the access point to which requests are being made.                             |
| `DataSourceARN`   | The source from which Object Lambda access point retrieves data. If the request invokes a Lambda function, this refers to the Lambda ARN. Otherwise, it refers to the access point ARN. |

## Objects {#object}

The structure of collected AWS S3 object data can be viewed in "Infrastructure - Custom".

```json
{
  "measurement": "aws_s3",
  "tags": {
    "name"              : "dataxxxx",
    "RegionId"          : "cn-northwest-1",
    "LocationConstraint": "cn-northwest-1",
    "Name"              : "dataxxxx"
  },
  "fields": {
    "CreationDate": "2022-03-09T06:13:31Z",
    "Grants"      : "{JSON Data}",
    "message"     : "{Instance JSON Data}"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance name, used as a unique identifier.
>
> Tip 2: `fields.message` is a JSON serialized string.
>
> Tip 3: `fields.Grants` is the bucket access control list.