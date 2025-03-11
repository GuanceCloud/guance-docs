---
title: 'AWS S3'
tags: 
  - AWS
summary: 'Use the script packages in the script market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/aws_s3'
dashboard:

  - desc: 'Built-in views for AWS S3'
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

Use the script packages in the script market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance.


## Configuration {#config}

### Install Func

It is recommended to enable the hosted version of Func under Guance Integration - Extension: all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant read-only permissions `ReadOnlyAccess`)

To synchronize AWS S3 monitoring data, install the corresponding collection script: "Guance Integration (AWS-S3 Collection)" (ID: `guance_aws_s3`)

After clicking [Install], enter the corresponding parameters: Amazon AK, Amazon account name.

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Additionally, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click [Execute] to immediately execute it without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

By default, we collect some configurations. For more details, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have corresponding automatic trigger configurations, and check the corresponding task records and logs for any anomalies.
2. On the Guance platform, in "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, in "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. You can collect more metrics through configuration. [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/en_us/AmazonS3/latest/userguide/metrics-dimensions.html){:target="_blank"}

### Daily Storage Metrics for Amazon S3 Buckets in CloudWatch

The `AWS/S3` namespace contains the following daily storage metrics for buckets.

| Metric              | Description                                                         |
| :------------------ | :------------------------------------------------------------------- |
| `BucketSizeBytes`   | The amount of data stored in the bucket across the following storage classes (in bytes): S3 Standard (`STANDARD`), S3 Intelligent-Tiering (`INTELLIGENT_TIERING`), S3 Standard-Infrequent Access (`STANDARD_IA`), S3 OneZone-Infrequent Access (`ONEZONE_IA`), Reduced Redundancy Storage (RRS) (`REDUCED_REDUNDANCY`), S3 Glacier Instant Retrieval (`GLACIER_IR`), S3 Glacier Deep Archive (`DEEP_ARCHIVE`), S3 Glacier Flexible Retrieval (`GLACIER`). This value is calculated by aggregating the size of all objects and metadata (both current and non-current objects) in the bucket, including all parts of multipart uploads that have not been completed. Valid storage type filter conditions: `StandardStorage`, `IntelligentTieringFAStorage`, `IntelligentTieringIAStorage`, `IntelligentTieringAAStorage`, `IntelligentTieringAIAStorage`, `IntelligentTieringDAAStorage`, `StandardIAStorage`, `StandardIASizeOverhead`, `StandardIAObjectOverhead`, `OneZoneIAStorage`, `OneZoneIASizeOverhead`, `ReducedRedundancyStorage`, `GlacierInstantRetrievalSizeOverhead`, `GlacierInstantRetrievalStorage`, `GlacierStorage`, `GlacierStagingStorage`, `GlacierObjectOverhead`, `GlacierS3ObjectOverhead`, `DeepArchiveStorage`, `DeepArchiveObjectOverhead`, `DeepArchiveS3ObjectOverhead`, and `DeepArchiveStagingStorage` (see `StorageType` dimension). Unit: bytes Valid statistics: Average |
| `NumberOfObjects`   | The total number of objects stored in all storage classes in the bucket. This value is calculated by counting all objects (including current and non-current objects), delete markers, and all parts of multipart uploads that have not been completed. Valid storage type filter condition: `AllStorageTypes` (see `StorageType` dimension). Unit: count Valid statistics: Average |

### Request Metrics for Amazon S3 in CloudWatch

The `AWS/S3` namespace contains the following request metrics. These metrics include non-billable requests (such as GET requests from COPY and Replication).

| Metric                  | Description                                                         |
| :---------------------- | :------------------------------------------------------------------- |
| `AllRequests`           | The total number of HTTP requests made to an Amazon S3 bucket regardless of type. If a metric is configured for a specific filter, it will only return HTTP requests that meet the filter criteria. Unit: count Valid statistics: Sum |
| `GetRequests`           | The number of HTTP GET requests made to objects in an Amazon S3 bucket. This does not include list operations. For each COPY object request source, this metric increments. Unit: count Valid statistics: Sum Note Requests facing paginated lists (e.g., [List Multipart Uploads](https://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadListMPUpload.html){:target="_blank"}, [List Parts](https://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadListParts.html){:target="_blank"}, [GET Bucket Object Version](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETVersion.html){:target="_blank"} and other requests) are not included in this metric. |
| `PutRequests`           | The number of HTTP PUT requests made to objects in an Amazon S3 bucket. For each COPY object request destination, this metric increments. Unit: count Valid statistics: Sum |
| `DeleteRequests`        | The number of HTTP `DELETE` requests made to objects in an Amazon S3 bucket. This metric includes [delete multiple objects](https://docs.aws.amazon.com/AmazonS3/latest/API/multiobjectdeleteapi.html){:target="_blank"} requests. It shows the number of requests issued, not the number of objects deleted. Unit: count Valid statistics: Sum |
| `HeadRequests`          | The number of HTTP `HEAD` requests made to an Amazon S3 bucket. Unit: count Valid statistics: Sum |
| `PostRequests`          | The number of HTTP `POST` requests made to an Amazon S3 bucket. Unit: count Valid statistics: Sum Note [delete multiple objects](https://docs.aws.amazon.com/AmazonS3/latest/API/multiobjectdeleteapi.html){:target="_blank"} and [SELECT Object Content](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"} requests are not included in this metric. |
| `SelectRequests`        | The number of Amazon S3 [SELECT Object Content](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"} requests made for objects in an Amazon S3 bucket. Unit: count Valid statistics: Sum |
| `SelectBytesScanned`    | The number of bytes scanned using Amazon S3 [SELECT Object Content](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"} requests in an Amazon S3 bucket. Unit: bytes Valid statistics: Average (bytes per request), Sum (bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `SelectBytesReturned`   | The number of bytes returned using Amazon S3 [SELECT Object Content](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"} requests in an Amazon S3 bucket. Unit: bytes Valid statistics: Average (bytes per request), Sum (bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `ListRequests`          | The number of HTTP requests listing bucket contents. Unit: count Valid statistics: Sum |
| `BytesDownloaded`       | The number of bytes downloaded for requests made to an Amazon S3 bucket (the response includes the body). Unit: bytes Valid statistics: Average (bytes per request), Sum (bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `BytesUploaded`         | The number of bytes uploaded for requests made to an Amazon S3 bucket (the request includes the body). Unit: bytes Valid statistics: Average (bytes per request), Sum (bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `4xxErrors`             | The number of HTTP 4xx client error status code requests made to an Amazon S3 bucket with values of 0 or 1. Average statistics show the error rate, Sum statistics show the count of this type of error per period. Unit: count Valid statistics: Average (number reported per request), Sum (number reported per period), Min, Max, Sample Count |
| `5xxErrors`             | The number of HTTP 5xx server error status code requests made to an Amazon S3 bucket with values of 0 or 1. Average statistics show the error rate, Sum statistics show the count of this type of error per period. Unit: count Valid statistics: Average (number reported per request), Sum (number reported per period), Min, Max, Sample Count |
| `FirstByteLatency`      | The time taken per request from when Amazon S3 bucket receives a complete request until it starts returning a response. Unit: milliseconds Valid statistics: Average, Sum, Min, Max (same as p100), Sample Count, any percentile between p0.0 and p100 |
| `TotalRequestLatency`   | The time taken per request from receiving the first byte to sending the last byte to an Amazon S3 bucket. This metric includes the time taken to receive the request body and send the response body (not included in `FirstByteLatency`). Unit: milliseconds Valid statistics: Average, Sum, Min, Max (same as p100), Sample Count, any percentile between p0.0 and p100 |

### S3 Replication Metrics in CloudWatch

You can use S3 replication metrics to monitor replication progress by tracking pending bytes, pending operations, and replication latency. For more information, see [Monitoring Progress Using Replication Metrics](https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-metrics.html){:target="_blank"}.

Note:

You can enable alerts for replication metrics in Amazon CloudWatch. When setting up alerts for replication metrics, set the **Missing data treatment (丢失数据处理)** field to **Treat missing data as ignore (maintain the alarm state) [将丢失的数据视为忽略（保持警报状态）]**.

| Metric                           | Description                                                         |
| :------------------------------- | :------------------------------------------------------------------- |
| `ReplicationLatency`             | The maximum number of seconds the replication target AWS region lags behind the source AWS region for a given replication rule. Unit: seconds Valid statistics: Max |
| `BytesPendingReplication`        | The total number of bytes of objects pending replication for a given replication rule. Unit: bytes Valid statistics: Max |
| `OperationsPendingReplication`   | The number of operations pending replication for a given replication rule. Unit: count Valid statistics: Max |
| `OperationsFailedReplication`    | The number of failed replication operations for a given replication rule. Unit: count Valid statistics: Sum (total failed operations), Average (failure rate), Sample Count (total replication operations) |

### S3 Storage Lens Usage and Activity Metrics in CloudWatch

You can publish S3 Storage Lens usage and activity metrics to Amazon CloudWatch to create a unified operational view on CloudWatch [dashboards](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Dashboards.html){:target="_blank"}. S3 Storage Lens metrics are published to the `AWS/S3/Storage-Lens` namespace in CloudWatch. CloudWatch publishing options are available for S3 Storage Lens dashboards upgraded to advanced metrics and recommendations.

For a list of S3 Storage Lens metrics published to CloudWatch, see [Amazon S3 Storage Lens Metrics Glossary](https://docs.aws.amazon.com/en_us/AmazonS3/latest/userguide/storage_lens_metrics_glossary.html){:target="_blank"}. For a complete list of dimensions, see [Dimensions](https://docs.aws.amazon.com/en_us/AmazonS3/latest/userguide/storage-lens-cloudwatch-metrics-dimensions.html#storage-lens-cloudwatch-dimensions){:target="_blank"}.

### S3 Object Lambda Request Metrics in CloudWatch

S3 Object Lambda includes the following request metrics.

| Metric                     | Description                                                         |
| :------------------------- | :------------------------------------------------------------------- |
| `AllRequests`              | The total number of HTTP requests made to an Amazon S3 bucket using an Object Lambda access point. Unit: count Valid statistics: Sum |
| `GetRequests`              | The number of HTTP `GET` requests made to objects using an Object Lambda access point. This metric does not include list operations. Unit: count Valid statistics: Sum |
| `BytesUploaded`            | The number of bytes uploaded to an Amazon S3 bucket using an Object Lambda access point (the request includes the body). Unit: bytes Valid statistics: Average (bytes per request), Sum (bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `PostRequests`             | The number of HTTP `POST` requests made to an Amazon S3 bucket using an Object Lambda access point. Unit: count Valid statistics: Sum |
| `PutRequests`              | The number of HTTP `PUT` requests made to objects in an Amazon S3 bucket using an Object Lambda access point. Unit: count Valid statistics: Sum |
| `DeleteRequests`           | The number of HTTP `DELETE` requests made to objects in an Amazon S3 bucket using an Object Lambda access point. This metric includes [delete multiple objects](https://docs.aws.amazon.com/AmazonS3/latest/API/multiobjectdeleteapi.html){:target="_blank"} requests. It shows the number of requests issued, not the number of objects deleted. Unit: count Valid statistics: Sum |
| `BytesDownloaded`          | The number of bytes downloaded for requests made to an Amazon S3 bucket using an Object Lambda access point (the response includes the body). Unit: bytes Valid statistics: Average (bytes per request), Sum (bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `FirstByteLatency`         | The time taken per request from when an Amazon S3 bucket receives a complete request via an Object Lambda access point until it starts returning a response. This metric depends on the run time of the function transforming the object before returning bytes to the Object Lambda access point. Unit: milliseconds Valid statistics: Average, Sum, Min, Max (same as p100), Sample Count, any percentile between p0.0 and p100 |
| `TotalRequestLatency`      | The time taken per request from receiving the first byte to sending the last byte to an Object Lambda access point. This metric includes the time taken to receive the request body and send the response body (not included in `FirstByteLatency`). Unit: milliseconds Valid statistics: Average, Sum, Min, Max (same as p100), Sample Count, any percentile between p0.0 and p100 |
| `HeadRequests`             | The number of HTTP `HEAD` requests made to an Amazon S3 bucket using an Object Lambda access point. Unit: count Valid statistics: Sum |
| `ListRequests`             | The number of HTTP `GET` requests listing Amazon S3 bucket contents. This metric includes both `List` and `ListV2` operations. Unit: count Valid statistics: Sum |
| `4xxErrors`                | The number of HTTP 4xx server error status code requests made to an Amazon S3 bucket using an Object Lambda access point with values of 0 or 1. Average statistics show the error rate, Sum statistics show the count of this type of error per period. Unit: count Valid statistics: Average (number reported per request), Sum (number reported per period), Min, Max, Sample Count |
| `5xxErrors`                | The number of HTTP 5xx server error status code requests made to an Amazon S3 bucket using an Object Lambda access point with values of 0 or 1. Average statistics show the error rate, Sum statistics show the count of this type of error per period. Unit: count Valid statistics: Average (number reported per request), Sum (number reported per period), Min, Max, Sample Count |
| `ProxiedRequests`          | The number of HTTP requests made to an Object Lambda access point that returns standard Amazon S3 API responses (these requests do not have a Lambda function configured). Unit: count Valid statistics: Sum |
| `InvokedLambda`            | The number of HTTP requests made to S3 objects where a Lambda function is invoked. Unit: count Valid statistics: Sum |
| `LambdaResponseRequests`   | The number of `WriteGetObjectResponse` requests made by the Lambda function. This metric applies only to `GetObject` requests. |
| `LambdaResponse4xx`        | The number of HTTP 4xx client errors that occur when calling `WriteGetObjectResponse` from a Lambda function. This metric provides the same information as `4xxErrors` but applies only to `WriteGetObjectResponse` calls. |
| `LambdaResponse5xx`        | The number of HTTP 5xx server errors that occur when calling `WriteGetObjectResponse` from a Lambda function. This metric provides the same information as `5xxErrors` but applies only to `WriteGetObjectResponse` calls. |

### Amazon S3 on Outposts Metrics in CloudWatch

For a list of metrics used for S3 on Outposts in CloudWatch, see [CloudWatch metrics (CloudWatch 指标)](https://docs.aws.amazon.com/en_us/AmazonS3/latest/userguide/S3OutpostsCapacity.html#S3OutpostsCloudWatchMetrics){:target="_blank"}.

### Amazon S3 Dimensions in CloudWatch

The following dimensions are used to filter Amazon S3 metrics.

| Dimension          | Description                                                         |
| :----------------- | :------------------------------------------------------------------- |
| `BucketName`       | Filters data only for identified buckets.                           |
| `StorageType`      | Filters data stored in the bucket based on the following storage types: `StandardStorage` – Number of bytes for objects in the `STANDARD` storage class. `IntelligentTieringAAStorage` – Number of bytes for objects in the archive access tier of the `INTELLIGENT_TIERING` storage class. `IntelligentTieringAIAStorage` – Number of bytes for objects in the instant access tier of the `INTELLIGENT_TIERING` storage class. `IntelligentTieringDAAStorage` – Number of bytes for objects in the deep archive access tier of the `INTELLIGENT_TIERING` storage class. `IntelligentTieringFAStorage` – Number of bytes for objects in the frequent access tier of the `INTELLIGENT_TIERING` storage class. `IntelligentTieringIAStorage` – Number of bytes for objects in the infrequent access tier of the `INTELLIGENT_TIERING` storage class. `StandardIAStorage` – Number of bytes for objects in the "standard-infrequent access" (`STANDARD_IA`) storage class. `StandardIASizeOverhead` – Number of bytes for objects smaller than 128KB in the `STANDARD_IA` storage class. `IntAAObjectOverhead` – For each object in the archive access tier of the `INTELLIGENT_TIERING` storage class, S3 Glacier adds 32KB of storage for indexing and related metadata. This additional data is required to identify and restore objects. Additional storage is charged at S3 Glacier rates. `IntAAS3ObjectOverhead` – For each object in the archive access tier of the `INTELLIGENT_TIERING` storage class, Amazon S3 uses 8KB of storage for the object's name and other metadata. Additional storage is charged at S3 Standard rates. `IntDAAObjectOverhead` – For each object in the deep archive access tier of the `INTELLIGENT_TIERING` storage class, S3 Glacier adds 32KB of storage for indexing and related metadata. This additional data is required to identify and restore objects. Additional storage is charged at S3 Glacier Deep Archive rates. `IntDAAS3ObjectOverhead` – For each object in the deep archive access tier of the `INTELLIGENT_TIERING` storage class, Amazon S3 adds 8KB of storage for indexing and related metadata. This additional data is required to identify and restore objects. Additional storage is charged at S3 Standard rates. `OneZoneIAStorage` – Number of bytes for objects in the "S3 One Zone-Infrequent Access" (`ONEZONE_IA`) storage class. `OneZoneIASizeOverhead` – Number of bytes for objects smaller than 128KB in the `ONEZONE_IA` storage class. `ReducedRedundancyStorage` – Number of bytes for objects in the low redundancy storage (RRS) class. `GlacierInstantRetrievalSizeOverhead` – Number of bytes for objects smaller than 128KB in the S3 Glacier Instant Retrieval storage class. `GlacierInstantRetrievalStorage` – Number of bytes for objects in the S3 Glacier Instant Retrieval storage class. `GlacierStorage` – Number of bytes for objects in the S3 Glacier Flexible Retrieval storage class. `GlacierStagingStorage` – Number of bytes for multipart objects' parts before completing a `CompleteMultipartUpload` request in the S3 Glacier Flexible Retrieval storage class. `GlacierObjectOverhead` – For each archive object, S3 Glacier adds 32KB of storage for indexing and related metadata. This additional data is required to identify and restore objects. Additional storage is charged at S3 Glacier Flexible Retrieval rates. `GlacierS3ObjectOverhead` – For each object archived to S3 Glacier Flexible Retrieval, Amazon S3 uses 8KB of storage for the object's name and other metadata. Additional storage is charged at S3 Standard rates. `DeepArchiveStorage` – Number of bytes for objects in the S3 Glacier Deep Archive storage class. `DeepArchiveObjectOverhead` – For each archive object, S3 Glacier adds 32KB of storage for indexing and related metadata. This additional data is required to identify and restore objects. Additional storage is charged at S3 Glacier Deep Archive rates. `DeepArchiveS3ObjectOverhead` – For each object archived to S3 Glacier Deep Archive, Amazon S3 uses 8KB of storage for the object's name and other metadata. Additional storage is charged at S3 Standard rates. `DeepArchiveStagingStorage` – Number of bytes for multipart objects' parts before completing a `CompleteMultipartUpload` request in the S3 Glacier Deep Archive storage class. |
| `FilterId`         | Filters the metric configuration specified for request metrics on the bucket. When creating a metric configuration, you need to specify a filter ID (e.g., prefix, tag, or access point). For more information, see [Creating a Metric Configuration](https://docs.aws.amazon.com/AmazonS3/latest/userguide/metrics-configurations.html){:target="_blank"}. |

### S3 Storage Lens Dimensions in CloudWatch

For a list of dimensions used to filter S3 Storage Lens metrics in CloudWatch, see [Dimensions](https://docs.aws.amazon.com/en_us/AmazonS3/latest/userguide/storage-lens-cloudwatch-metrics-dimensions.html#storage-lens-cloudwatch-dimensions){:target="_blank"}.

### S3 Object Lambda Request Dimensions in CloudWatch

The following dimensions are used to filter data from Object Lambda access points.

| Dimension              | Description                                                         |
| :--------------------- | :------------------------------------------------------------------- |
| `AccessPointName`      | The name of the access point being requested.                       |
| `DataSourceARN`        | The source from which Object Lambda access point retrieves data. If the request invokes a Lambda function, this refers to the Lambda ARN. Otherwise, it refers to the access point ARN. |

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
    "Grants"      : "{JSON data}",
    "message"     : "{instance JSON data}"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: `tags.name` value is the instance name, used as unique identification.
>
> Tip 2: `fields.message` is a JSON serialized string.
>
> Tip 3: `fields.Grants` is the bucket access control list.
