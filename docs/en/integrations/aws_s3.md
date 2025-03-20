---
title: 'AWS S3'
tags: 
  - AWS
summary: 'Use the script market "Guance cloud sync" series of script packages to synchronize cloud monitoring and cloud asset data to Guance.'
__int_icon: 'icon/aws_s3'
dashboard:

  - desc: 'AWS S3 built-in views'
    path: 'dashboard/en/aws_s3'

monitor:
  - desc: 'AWS S3 monitor'
    path: 'monitor/en/aws_s3'

cloudCollector:
  desc: 'Cloud collector'
  path: 'cloud-collector/en/aws_s3'
---


<!-- markdownlint-disable MD025 -->
# AWS S3
<!-- markdownlint-enable -->

Use the script market "Guance cloud sync" series of script packages to synchronize cloud monitoring and cloud asset data to Guance.


## Configuration {#config}

### Install Func

It is recommended to activate Guance integration - extension - hosted Func: all prerequisites will be automatically installed, please proceed with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize AWS S3 monitoring data, we install the corresponding collection script: "Guance Integration (AWS-S3 Collection)" (ID: `guance_aws_s3`)

After clicking [Install], enter the corresponding parameters: Amazon AK, Amazon account name.

Click [Deploy Startup Script], the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click [Execute] to immediately execute it once without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.

We default collect some configurations, for details see metrics column [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and you can also check the corresponding task records and logs to check for any abnormalities.
2. On the Guance platform, in "Infrastructure / Custom", check if there is any asset information.
3. On the Guance platform, in "Metrics", check if there are any corresponding monitoring data.

## Metrics {#metric}
Configure Amazon - CloudWatch properly, the default metric sets are as follows. You can collect more metrics through configuration [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/en_us/AmazonS3/latest/userguide/metrics-dimensions.html){:target="_blank"}

### Daily Storage Metrics for Amazon S3 Buckets in CloudWatch

The `AWS/S3` namespace contains the following daily storage metrics for buckets.

| Metric              | Description                                                         |
| :---------------- | :----------------------------------------------------------- |
| `BucketSizeBytes` | The amount of data stored in the following storage classes in bytes: S3 Standard (`STANDARD`) S3 Intelligent-Tiering (`INTELLIGENT_TIERING`) S3 Standard-Infrequent Access (`STANDARD_IA`) S3 OneZone-Infrequent Access (`ONEZONE_IA`) Reduced Redundancy Storage (RRS) (`REDUCED_REDUNDANCY`) S3 Glacier Instant Retrieval (`GLACIER_IR`) S3 Glacier Deep Archive (`DEEP_ARCHIVE`) S3 Glacier Flexible Retrieval (`GLACIER`). This value is calculated by aggregating the sizes of all objects and metadata (current and non-current objects) in the bucket, including the sizes of all parts of multipart uploads to the bucket that have not been completed. Valid storage type filter conditions: `StandardStorage`, `IntelligentTieringFAStorage`, `IntelligentTieringIAStorage`, `IntelligentTieringAAStorage`, `IntelligentTieringAIAStorage`, `IntelligentTieringDAAStorage`, `StandardIAStorage`, `StandardIASizeOverhead`, `StandardIAObjectOverhead`, `OneZoneIAStorage`, `OneZoneIASizeOverhead`, `ReducedRedundancyStorage`, `GlacierInstantRetrievalSizeOverhead`, `GlacierInstantRetrievalStorage`, `GlacierStorage`, `GlacierStagingStorage`, `GlacierObjectOverhead`, `GlacierS3ObjectOverhead`, `DeepArchiveStorage`, `DeepArchiveObjectOverhead`, `DeepArchiveS3ObjectOverhead`, and `DeepArchiveStagingStorage` (see `StorageType` dimension). Unit: Bytes Valid statistics: Average |

| `NumberOfObjects` | Total number of objects stored in all storage classes in the bucket. This value is calculated by counting the total number of all objects (including current and non-current objects), delete markers, and all parts of all multipart uploads to the bucket that have not been completed. Valid storage type filter condition: `AllStorageTypes` (see `StorageType` dimension). Unit: Count Valid statistics: Average |

### Amazon S3 CloudWatch Request Metrics in CloudWatch

The `AWS/S3` namespace contains the following request metrics. These metrics include non-billable requests (GET requests from COPY and Replication).

| Metric                  | Description                                                         |
| :-------------------- | :----------------------------------------------------------- |
| `AllRequests`         | Total number of HTTP requests made to an Amazon S3 bucket regardless of type. If you configure a metric for a specific filter, the metric will only return HTTP requests that meet the filter's criteria. Unit: Count Valid statistics: Sum |
| `GetRequests`         | Number of HTTP GET requests made to objects in an Amazon S3 bucket. This does not include listing operations. For each source of a COPY object request, this metric increments. Unit: Count Valid statistics: Sum Note: Requests aimed at paginated listings (e.g., [List Multipart Uploads](https://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadListMPUpload.html){:target="_blank"}, [List Parts](https://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadListParts.html){:target="_blank"}, [Get Bucket Object Versions](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETVersion.html){:target="_blank"} and other requests) are not included in this metric. |
| `PutRequests`         | Number of HTTP PUT requests made to objects in an Amazon S3 bucket. For each target of a COPY object request, this metric increments. Unit: Count Valid statistics: Sum |
| `DeleteRequests`      | Number of HTTP `DELETE` requests made to objects in an Amazon S3 bucket. This metric also includes [Delete Multiple Objects](https://docs.aws.amazon.com/AmazonS3/latest/API/multiobjectdeleteapi.html){:target="_blank"} requests. This metric shows the number of requests issued, not the number of deleted objects. Unit: Count Valid statistics: Sum |
| `HeadRequests`        | Number of HTTP `HEAD` requests made to an Amazon S3 bucket. Unit: Count Valid statistics: Sum |
| `PostRequests`        | Number of HTTP `POST` requests made to an Amazon S3 bucket. Unit: Count Valid statistics: Sum Note: [Delete Multiple Objects](https://docs.aws.amazon.com/AmazonS3/latest/API/multiobjectdeleteapi.html){:target="_blank"} and [SELECT Object Content](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"} requests are not included in this metric. |
| `SelectRequests`      | Number of Amazon S3 [SELECT Object Content](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"} requests made for objects in an Amazon S3 bucket. Unit: Count Valid statistics: Sum |
| `SelectBytesScanned`  | Number of bytes scanned using Amazon S3 [SELECT Object Content](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"} requests in an Amazon S3 bucket. Unit: Bytes Valid statistics: Average (number of bytes per request), Sum (number of bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `SelectBytesReturned` | Number of bytes returned using Amazon S3 [SELECT Object Content](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"} requests in an Amazon S3 bucket. Unit: Bytes Valid statistics: Average (number of bytes per request), Sum (number of bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `ListRequests`        | Number of HTTP requests to list bucket contents. Unit: Count Valid statistics: Sum    |
| `BytesDownloaded`     | Number of bytes downloaded for requests made to an Amazon S3 bucket (the response includes a body). Unit: Bytes Valid statistics: Average (number of bytes per request), Sum (number of bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `BytesUploaded`       | Number of bytes uploaded for requests made to an Amazon S3 bucket (the request includes a body). Unit: Bytes Valid statistics: Average (number of bytes per request), Sum (number of bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `4xxErrors`           | Number of HTTP 4xx client error status code requests made to an Amazon S3 bucket with values of 0 or 1. Average statistics show the error rate, Sum statistics show the count of such errors per period. Unit: Count Valid statistics: Average (number of reports per request), Sum (number of reports per period), Min, Max, Sample Count |
| `5xxErrors`           | Number of HTTP 5xx server error status code requests made to an Amazon S3 bucket with values of 0 or 1. Average statistics show the error rate, Sum statistics show the count of such errors per period. Unit: Count Valid statistics: Average (number of reports per request), Sum (number of reports per period), Min, Max, Sample Count |
| `FirstByteLatency`    | Time per request from receiving a complete request on an Amazon S3 bucket to starting to return a response. Unit: Milliseconds Valid statistics: Average, Sum, Min, Max (same as p100), Sample Count, any percentile between p0.0 and p100 |
| `TotalRequestLatency` | Time per request from receiving the first byte to sending the last byte to an Amazon S3 bucket. This metric includes the time taken to receive the request body and send the response body (not included in `FirstByteLatency`). Unit: Milliseconds Valid statistics: Average, Sum, Min, Max (same as p100), Sample Count, any percentile between p0.0 and p100 |

### S3 Replication Metrics in CloudWatch

You can use S3 replication metrics to monitor the progress of replication by tracking pending bytes, pending operations, and replication latency. For more details, see [Monitoring Progress Using Replication Metrics](https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-metrics.html){:target="_blank"}.

Note:

You can enable alarms for replication metrics in Amazon CloudWatch. When setting alarms for replication metrics, set the **Missing data treatment** field to **Treat missing data as ignore (maintain the alarm state)**.

| Metric                           | Description                                                         |
| :----------------------------- | :----------------------------------------------------------- |
| `ReplicationLatency`           | Maximum number of seconds that the replication destination AWS region lags behind the source AWS region for a given replication rule. Unit: Seconds Valid statistics: Max |
| `BytesPendingReplication`      | Total number of bytes of objects pending replication for a given replication rule. Unit: Bytes Valid statistics: Max |
| `OperationsPendingReplication` | Number of pending replication operations for a given replication rule. Unit: Count Valid statistics: Max      |
| `OperationsFailedReplication`  | Number of failed replication operations for a given replication rule. Unit: Count Valid statistics: Sum (total number of failed operations), Average (failure rate), Sample Count (total number of replication operations) |

### S3 Storage Lens Usage and Activity Metrics in CloudWatch

You can publish S3 Storage Lens usage and activity metrics to Amazon CloudWatch to create a unified operational view in CloudWatch [dashboards](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Dashboards.html){:target="_blank"}. S3 Storage Lens metrics are published to the `AWS/S3/Storage-Lens` namespace in CloudWatch. The CloudWatch publishing option is available for S3 Storage Lens dashboards upgraded to advanced metrics and recommendations.

For a list of S3 Storage Lens metrics published to CloudWatch, see [Amazon S3 Storage Lens Metrics Glossary](https://docs.aws.amazon.com/en_us/AmazonS3/latest/userguide/storage_lens_metrics_glossary.html){:target="_blank"}. For a complete list of dimensions, see [Dimensions](https://docs.aws.amazon.com/en_us/AmazonS3/latest/userguide/storage-lens-cloudwatch-metrics-dimensions.html#storage-lens-cloudwatch-dimensions){:target="_blank"}.

### S3 Object Lambda Request Metrics in CloudWatch

S3 Object Lambda includes the following request metrics.

| Metric                     | Description                                                         |
| :----------------------- | :----------------------------------------------------------- |
| `AllRequests`            | Total number of HTTP requests made to an Amazon S3 bucket using an object Lambda access point. Unit: Count Valid statistics: Sum |
| `GetRequests`            | Number of HTTP `GET` requests made for objects using an object Lambda access point. This metric does not include listing operations. Unit: Count Valid statistics: Sum |
| `BytesUploaded`          | Number of bytes uploaded to an Amazon S3 bucket using an object Lambda access point (the request includes a body). Unit: Bytes Valid statistics: Average (number of bytes per request), Sum (number of bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `PostRequests`           | Number of HTTP `POST` requests made to an Amazon S3 bucket using an object Lambda access point. Unit: Count Valid statistics: Sum |
| `PutRequests`            | Number of HTTP `PUT` requests made for objects in an Amazon S3 bucket using an object Lambda access point. Unit: Count Valid statistics: Sum |
| `DeleteRequests`         | Number of HTTP `DELETE` requests made for objects in an Amazon S3 bucket using an object Lambda access point. This metric includes [Delete Multiple Objects](https://docs.aws.amazon.com/AmazonS3/latest/API/multiobjectdeleteapi.html){:target="_blank"} requests. This metric shows the number of requests issued, not the number of deleted objects. Unit: Count Valid statistics: Sum |
| `BytesDownloaded`        | Number of bytes downloaded for requests made to an Amazon S3 bucket using an object Lambda access point (the response includes a body). Unit: Bytes Valid statistics: Average (number of bytes per request), Sum (number of bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `FirstByteLatency`       | Time per request from receiving a complete request on an Amazon S3 bucket via an object Lambda access point to starting to return a response. This metric depends on the runtime of the AWS Lambda function transforming the object before returning bytes to the object Lambda access point. Unit: Milliseconds Valid statistics: Average, Sum, Min, Max (same as p100), Sample Count, any percentile between p0.0 and p100 |
| `TotalRequestLatency`    | Time per request from receiving the first byte to sending the last byte to an object Lambda access point. This metric includes the time taken to receive the request body and send the response body (not included in `FirstByteLatency`). Unit: Milliseconds Valid statistics: Average, Sum, Min, Max (same as p100), Sample Count, any percentile between p0.0 and p100 |
| `HeadRequests`           | Number of HTTP `HEAD` requests made to an Amazon S3 bucket using an object Lambda access point. Unit: Count Valid statistics: Sum |
| `ListRequests`           | Number of HTTP `GET` requests to list the contents of an Amazon S3 bucket. This metric includes both `List` and `ListV2` operations. Unit: Count Valid statistics: Sum |
| `4xxErrors`              | Number of HTTP 4xx server error status code requests made to an Amazon S3 bucket using an object Lambda access point with values of 0 or 1. Average statistics show the error rate, Sum statistics show the count of such errors per period. Unit: Count Valid statistics: Average (number of reports per request), Sum (number of reports per period), Min, Max, Sample Count |
| `5xxErrors`              | Number of HTTP 5xx server error status code requests made to an Amazon S3 bucket using an object Lambda access point with values of 0 or 1. Average statistics show the error rate, Sum statistics show the count of such errors per period. Unit: Count Valid statistics: Average (number of reports per request), Sum (number of reports per period), Min, Max, Sample Count |
| `ProxiedRequests`        | Number of HTTP requests made to an object Lambda access point returning standard Amazon S3 API responses. (These requests do not have a configured Lambda function.) Unit: Count Valid statistics: Sum |
| `InvokedLambda`          | Number of HTTP requests made to S3 objects where a Lambda function is invoked. Unit: Count Valid statistics: Sum |
| `LambdaResponseRequests` | Number of `WriteGetObjectResponse` requests made by a Lambda function. This metric applies only to `GetObject` requests. |
| `LambdaResponse4xx`      | Number of HTTP 4xx client errors that occur when a Lambda function calls `WriteGetObjectResponse`. This metric provides the same information as `4xxErrors`, but applies only to `WriteGetObjectResponse` calls. |
| `LambdaResponse5xx`      | Number of HTTP 5xx server errors that occur when a Lambda function calls `WriteGetObjectResponse`. This metric provides the same information as `5xxErrors`, but applies only to `WriteGetObjectResponse` calls. |

### Amazon S3 on Outposts Metrics in CloudWatch

For a list of metrics used for S3 on Outposts in CloudWatch, see [CloudWatch metrics (CloudWatch metrics)](https://docs.aws.amazon.com/en_us/AmazonS3/latest/userguide/S3OutpostsCapacity.html#S3OutpostsCloudWatchMetrics){:target="_blank"}.

### Amazon S3 Dimensions in CloudWatch

The following dimensions are used to filter Amazon S3 metrics.

| Dimension          | Description                                                         |
| :------------ | :----------------------------------------------------------- |
| `BucketName`  | This dimension filters data requested only for identified buckets.                         |
| `StorageType` | This dimension filters data stored in your bucket by the following storage types: `StandardStorage` – Number of bytes for objects in the `STANDARD` storage class. `IntelligentTieringAAStorage` – Number of bytes for objects in the archive access tier of the `INTELLIGENT_TIERING` storage class. `IntelligentTieringAIAStorage` – Number of bytes for objects in the archive instant access tier of the `INTELLIGENT_TIERING` storage class. `IntelligentTieringDAAStorage` – Number of bytes for objects in the deep archive access tier of the `INTELLIGENT_TIERING` storage class. `IntelligentTieringFAStorage` – Number of bytes for objects in the frequent access tier of the `INTELLIGENT_TIERING` storage class. `IntelligentTieringIAStorage` – Number of bytes for objects in the infrequent access tier of the `INTELLIGENT_TIERING` storage class. `StandardIAStorage` – Number of bytes for objects in the "Standard - Infrequent Access Tier (`STANDARD_IA`)" storage class. `StandardIASizeOverhead` – Number of bytes for objects smaller than 128KB in the `STANDARD_IA` storage class. `IntAAObjectOverhead` – For each object in the archive access tier of the `INTELLIGENT_TIERING` storage class, S3 Glacier adds 32KB of storage for indexing and related metadata. This extra data is needed to identify and restore objects. Additional storage is charged at the S3 Glacier rate. `IntAAS3ObjectOverhead` – For each object in the archive access tier of the `INTELLIGENT_TIERING` storage class, Amazon S3 uses 8KB of storage as the name for the object and other metadata. Additional storage is charged at the S3 Standard rate. `IntDAAObjectOverhead` – For each object in the deep archive access tier of the `INTELLIGENT_TIERING` storage class, S3 Glacier adds 32KB of storage for indexing and related metadata. This extra data is needed to identify and restore objects. Additional storage is charged at the S3 Glacier Deep Archive storage rate. `IntDAAS3ObjectOverhead` – For each object in the deep archive access tier of the `INTELLIGENT_TIERING` storage class, Amazon S3 adds 8KB of storage for indexing and related metadata. This extra data is needed to identify and restore objects. Additional storage is charged at the S3 Standard rate. `OneZoneIAStorage` – Number of bytes for objects in the "S3 One Zone - Infrequent Access Tier (`ONEZONE_IA`)" storage class. `OneZoneIASizeOverhead` – Number of bytes for objects smaller than 128KB in the `ONEZONE_IA` storage class. `ReducedRedundancyStorage` – Number of bytes for objects in the low redundancy storage (RRS) class. `GlacierInstantRetrievalSizeOverhead` – Number of bytes for objects smaller than 128KB in the S3 Glacier Instant Retrieval storage class. `GlacierInstantRetrievalStorage` – Number of bytes for objects in the S3 Glacier Instant Retrieval storage class. `GlacierStorage` – Number of bytes for objects in the S3 Glacier Flexible Retrieval storage class. `GlacierStagingStorage` – Number of bytes for individual parts of multipart objects in the S3 Glacier Flexible Retrieval storage class until the `CompleteMultipartUpload` request is completed. `GlacierObjectOverhead` – For each archive object, S3 Glacier adds 32KB of storage for indexing and related metadata. This extra data is needed to identify and restore objects. Additional storage is charged at the S3 Glacier Flexible Retrieval rate. `GlacierS3ObjectOverhead` – For each object archived to S3 Glacier Flexible Retrieval, Amazon S3 uses 8KB of storage for the name of the object and other metadata. Additional storage is charged at the S3 Standard rate. `DeepArchiveStorage` – Number of bytes for objects in the S3 Glacier Deep Archive storage class. `DeepArchiveObjectOverhead` – For each archive object, S3 Glacier adds 32KB of storage for indexing and related metadata. This extra data is needed to identify and restore objects. Additional storage is charged at the S3 Glacier Deep Archive rate. `DeepArchiveS3ObjectOverhead` – For each object archived to S3 Glacier Deep Archive, Amazon S3 uses 8KB of storage for the name of the object and other metadata. Additional storage is charged at the S3 Standard rate. `DeepArchiveStagingStorage` - Number of bytes for individual parts of multipart objects in the S3 Glacier Deep Archive storage class until the `CompleteMultipartUpload` request is completed. |
| `FilterId`    | This dimension filters the metrics configuration specified for request metrics on the bucket. When creating a metrics configuration, you need to specify a filter ID (for example, prefix, tag, or access point). For more details, see [Creating Metrics Configurations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/metrics-configurations.html){:target="_blank"}. |

### S3 Storage Lens Dimensions in CloudWatch

For a list of dimensions used to filter S3 Storage Lens metrics in CloudWatch, see [Dimensions](https://docs.aws.amazon.com/en_us/AmazonS3/latest/userguide/storage-lens-cloudwatch-metrics-dimensions.html#storage-lens-cloudwatch-dimensions){:target="_blank"}.

### S3 Object Lambda Request Dimensions in CloudWatch

The following dimensions are used to filter data from object Lambda access points.

| Dimension              | Description                                                         |
| :---------------- | :----------------------------------------------------------- |
| `AccessPointName` | Name of the access point being requested.                             |
| `DataSourceARN`   | Source from which object Lambda access point is retrieving data. If the request invokes a Lambda function, this refers to the Lambda ARN. Otherwise, it refers to the access point ARN. |

## Objects {#object}

The collected AWS S3 object data structure can be viewed under "Infrastructure - Custom".

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

> *Note: Fields in `tags`, `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance name, used for unique identification.
>
> Tip 2: `fields.message` is a JSON serialized string.
>
> Tip 3: `fields.Grants` is the bucket access control list.