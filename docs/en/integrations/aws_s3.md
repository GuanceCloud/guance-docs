---
title: 'AWS S3'
tags: 
  - AWS
summary: 'Use the series of script packages in the script market named 「<<< custom_key.brand_name >>> Cloud Sync」 to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>'
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

Use the series of script packages in the script market named 「<<< custom_key.brand_name >>> Cloud Sync」 to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>


## Configuration {#config}

### Install Func

It is recommended to activate <<< custom_key.brand_name >>> Integration - Extension - Managed Func: all prerequisites will be automatically installed. Please proceed with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Script Installation

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

#### Managed Version Script Activation

1. Log in to the <<< custom_key.brand_name >>> console.
2. Click on the 【Manage】 menu and select 【Cloud Account Management】.
3. Click 【Add Cloud Account】, choose 【AWS】, and fill in the required information on the interface. If cloud account information has been configured before, skip this step.
4. Click 【Test】. After a successful test, click 【Save】. If the test fails, check whether the relevant configuration information is correct and retest.
5. In the 【Cloud Account Management】 list, you can see the added cloud accounts. Click the corresponding cloud account and go to the details page.
6. On the cloud account details page, click the 【Integration】 button. Under the `Not Installed` list, find `AWS S3`, click the 【Install】 button, and follow the prompts to install it.

#### Manual Script Activation

1. Log in to the Func console, click 【Script Market】, enter the official script market, and search for `guance_aws_s3`.
2. After clicking 【Install】, input the corresponding parameters: AWS AK ID, AK Secret, and account name.
3. Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.
4. After enabling, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the regular time interval. Wait a moment, and you can view the execution task records and corresponding logs.

### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and at the same time, you can check the corresponding task records and logs for any abnormalities.
2. In <<< custom_key.brand_name >>>, under "Infrastructure / Custom", check if there are asset information entries.
3. In <<< custom_key.brand_name >>>, under "Metrics", check if there are corresponding monitoring data entries.

## Metrics {#metric}
After configuring Amazon-CloudWatch, the default metric sets are as follows. You can collect more metrics through configuration. [Details about Amazon CloudWatch Metrics](https://docs.aws.amazon.com/en_us/AmazonS3/latest/userguide/metrics-dimensions.html){:target="_blank"}

### Daily Storage Metrics for Amazon S3 Buckets in CloudWatch

The `AWS/S3` namespace includes the following daily storage metrics for buckets.

| Metric              | Description                                                         |
| :------------------ | :-------------------------------------------------------------------|
| `BucketSizeBytes`   | The amount of data stored in the bucket across the following storage classes (in bytes): S3 Standard (`STANDARD`) S3 Intelligent-Tiering (`INTELLIGENT_TIERING`) S3 Standard-Infrequent Access (`STANDARD_IA`) S3 OneZone-Infrequent Access (`ONEZONE_IA`) Reduced Redundancy Storage (RRS) (`REDUCED_REDUNDANCY`) S3 Glacier Instant Retrieval (`GLACIER_IR`) S3 Glacier Deep Archive (`DEEP_ARCHIVE`) S3 Glacier Flexible Retrieval (`GLACIER`). This value is calculated by aggregating the sizes of all objects and metadata (current and non-current objects) in the bucket, including the sizes of all parts uploaded but not completed in multipart uploads. Valid storage type filter conditions: `StandardStorage`, `IntelligentTieringFAStorage`, `IntelligentTieringIAStorage`, `IntelligentTieringAAStorage`, `IntelligentTieringAIAStorage`, `IntelligentTieringDAAStorage`, `StandardIAStorage`, `StandardIASizeOverhead`, `StandardIAObjectOverhead`, `OneZoneIAStorage`, `OneZoneIASizeOverhead`, `ReducedRedundancyStorage`, `GlacierInstantRetrievalSizeOverhead`, `GlacierInstantRetrievalStorage`, `GlacierStorage`, `GlacierStagingStorage`, `GlacierObjectOverhead`, `GlacierS3ObjectOverhead`, `DeepArchiveStorage`, `DeepArchiveObjectOverhead`, `DeepArchiveS3ObjectOverhead`, and `DeepArchiveStagingStorage` (see `StorageType` dimension). Units: Bytes Valid statistics: Average |
| `NumberOfObjects`    | The total number of objects stored in all storage classes within the bucket. This value is calculated by counting all objects (including current and non-current objects), delete markers, and all parts of multipart uploads that were initiated but not completed. Valid storage type filter conditions: `AllStorageTypes` (see `StorageType` dimension). Units: Count Valid statistics: Average |

### Request Metrics for Amazon S3 in CloudWatch

The `AWS/S3` namespace includes the following request metrics. These metrics include non-billable requests (such as GET requests from COPY and Replication).

| Metric                  | Description                                                         |
| :---------------------- | :-------------------------------------------------------------------|
| `AllRequests`           | Total number of HTTP requests made to an Amazon S3 bucket regardless of the type. If you configure a metric for a specific filter condition, the metric will only return HTTP requests that meet the filter condition's requirements. Units: Count Valid statistics: Sum |
| `GetRequests`           | Number of HTTP GET requests made to objects in an Amazon S3 bucket. This does not include list operations. For each source of a COPY object request, this metric increments. Units: Count Valid statistics: Sum Note Requests facing paginated lists (e.g., [List Multipart Uploads](https://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadListMPUpload.html){:target="_blank"}, [List Parts](https://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadListParts.html){:target="_blank"}, [Get Bucket Object Versions](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETVersion.html){:target="_blank"} and other requests) are not included in this metric. |
| `PutRequests`           | Number of HTTP PUT requests made to objects in an Amazon S3 bucket. For each target of a COPY object request, this metric increments. Units: Count Valid statistics: Sum |
| `DeleteRequests`        | Number of HTTP `DELETE` requests made to objects in an Amazon S3 bucket. This metric also includes [Delete Multiple Objects](https://docs.aws.amazon.com/AmazonS3/latest/API/multiobjectdeleteapi.html){:target="_blank"} requests. This metric shows the number of requests issued, not the number of objects deleted. Units: Count Valid statistics: Sum |
| `HeadRequests`          | Number of HTTP `HEAD` requests made to an Amazon S3 bucket. Units: Count Valid statistics: Sum |
| `PostRequests`          | Number of HTTP `POST` requests made to an Amazon S3 bucket. Units: Count Valid statistics: Sum Note [Delete Multiple Objects](https://docs.aws.amazon.com/AmazonS3/latest/API/multiobjectdeleteapi.html){:target="_blank"} and [SELECT Object Content](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"} requests are not included in this metric. |
| `SelectRequests`        | Number of Amazon S3 [SELECT Object Content](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"} requests made to objects in an Amazon S3 bucket. Units: Count Valid statistics: Sum |
| `SelectBytesScanned`    | Number of bytes scanned using Amazon S3 [SELECT Object Content](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"} requests in an Amazon S3 bucket. Units: Bytes Valid statistics: Average (number of bytes per request), Sum (number of bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `SelectBytesReturned`   | Number of bytes returned using Amazon S3 [SELECT Object Content](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"} requests in an Amazon S3 bucket. Units: Bytes Valid statistics: Average (number of bytes per request), Sum (number of bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `ListRequests`          | Number of HTTP requests to list the contents of a bucket. Units: Count Valid statistics: Sum    |
| `BytesDownloaded`       | Number of bytes downloaded for requests made to an Amazon S3 bucket (response contains body). Units: Bytes Valid statistics: Average (number of bytes per request), Sum (number of bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `BytesUploaded`         | Number of bytes uploaded for requests made to an Amazon S3 bucket (request contains body). Units: Bytes Valid statistics: Average (number of bytes per request), Sum (number of bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `4xxErrors`            | Number of HTTP 4xx client error status code requests made to an Amazon S3 bucket with values of 0 or 1. Average statistics show the error rate, Sum statistics show the count of such errors per period. Units: Count Valid statistics: Average (number of reports per request), Sum (number of reports per period), Min, Max, Sample Count |
| `5xxErrors`            | Number of HTTP 5xx server error status code requests made to an Amazon S3 bucket with values of 0 or 1. Average statistics show the error rate, Sum statistics show the count of such errors per period. Units: Count Valid statistics: Average (number of reports per request), Sum (number of reports per period), Min, Max, Sample Count |
| `FirstByteLatency`      | Time taken per request from when Amazon S3 bucket receives a complete request until it begins returning a response. Units: Milliseconds Valid statistics: Average, Sum, Min, Max (same as p100), Sample Count, any percentile between p0.0 and p100 |
| `TotalRequestLatency`   | Time taken per request from receiving the first byte to sending the last byte to an Amazon S3 bucket. This metric includes the time spent receiving the request body and sending the response body (not included in `FirstByteLatency`). Units: Milliseconds Valid statistics: Average, Sum, Min, Max (same as p100), Sample Count, any percentile between p0.0 and p100 |

### S3 Replication Metrics in CloudWatch

You can use S3 replication metrics to monitor the progress of replication by tracking pending bytes, pending operations, and replication lag. For more details, see [Monitoring Progress Using Replication Metrics](https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-metrics.html){:target="_blank"}.

Note:

You can enable alerts for replication metrics in Amazon CloudWatch. When setting up alarms for replication metrics, set the **Missing data treatment** field to **Treat missing data as ignore (maintain the alarm state)**.

| Metric                           | Description                                                         |
| :------------------------------- | :-------------------------------------------------------------------|
| `ReplicationLatency`             | Maximum number of seconds the replication destination AWS region lags behind the source AWS region for a given replication rule. Units: Seconds Valid statistics: Max |
| `BytesPendingReplication`        | Total number of bytes for objects pending replication for a given replication rule. Units: Bytes Valid statistics: Max |
| `OperationsPendingReplication`   | Number of operations pending replication for a given replication rule. Units: Count Valid statistics: Max      |
| `OperationsFailedReplication`    | Number of operations failed during replication for a given replication rule. Units: Count Valid statistics: Sum (total number of failed operations), Average (failure rate), Sample Count (total number of replication operations) |

### S3 Storage Lens Metrics in CloudWatch

You can publish S3 Storage Lens usage and activity metrics to Amazon CloudWatch to create a unified view of operations on CloudWatch [dashboards](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Dashboards.html){:target="_blank"}. S3 Storage Lens metrics are published to the `AWS/S3/Storage-Lens` namespace in CloudWatch. CloudWatch publishing options are available for S3 Storage Lens dashboards upgraded to advanced metrics and recommendations.

For a list of S3 Storage Lens metrics published to CloudWatch, see [Amazon S3 Storage Lens Metrics Glossary](https://docs.aws.amazon.com/en_us/AmazonS3/latest/userguide/storage_lens_metrics_glossary.html){:target="_blank"}. For a complete list of dimensions, see [Dimensions](https://docs.aws.amazon.com/en_us/AmazonS3/latest/userguide/storage-lens-cloudwatch-metrics-dimensions.html#storage-lens-cloudwatch-dimensions){:target="_blank"}.

### S3 Object Lambda Request Metrics in CloudWatch

S3 Object Lambda includes the following request metrics.

| Metric                     | Description                                                         |
| :------------------------ | :-------------------------------------------------------------------|
| `AllRequests`              | Total number of HTTP requests made to an Amazon S3 bucket using an object Lambda access point. Units: Count Valid statistics: Sum |
| `GetRequests`              | Number of HTTP `GET` requests made to objects using an object Lambda access point. This metric does not include list operations. Units: Count Valid statistics: Sum |
| `BytesUploaded`            | Number of bytes uploaded to an Amazon S3 bucket using an object Lambda access point (request contains body). Units: Bytes Valid statistics: Average (number of bytes per request), Sum (number of bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `PostRequests`             | Number of HTTP `POST` requests made to an Amazon S3 bucket using an object Lambda access point. Units: Count Valid statistics: Sum |
| `PutRequests`              | Number of HTTP `PUT` requests made to objects in an Amazon S3 bucket using an object Lambda access point. Units: Count Valid statistics: Sum |
| `DeleteRequests`           | Number of HTTP `DELETE` requests made to objects in an Amazon S3 bucket using an object Lambda access point. This metric includes [Delete Multiple Objects](https://docs.aws.amazon.com/AmazonS3/latest/API/multiobjectdeleteapi.html){:target="_blank"} requests. This metric shows the number of requests issued, not the number of objects deleted. Units: Count Valid statistics: Sum |
| `BytesDownloaded`          | Number of bytes downloaded for requests made to an Amazon S3 bucket using an object Lambda access point (response contains body). Units: Bytes Valid statistics: Average (number of bytes per request), Sum (number of bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `FirstByteLatency`         | Time taken per request from when Amazon S3 bucket receives a complete request via an object Lambda access point until it begins returning a response. This metric depends on the runtime of the AWS Lambda function transforming the object before returning bytes to the object Lambda access point. Units: Milliseconds Valid statistics: Average, Sum, Min, Max (same as p100), Sample Count, any percentile between p0.0 and p100 |
| `TotalRequestLatency`      | Time taken per request from receiving the first byte to sending the last byte to an object Lambda access point. This metric includes the time spent receiving the request body and sending the response body (not included in `FirstByteLatency`). Units: Milliseconds Valid statistics: Average, Sum, Min, Max (same as p100), Sample Count, any percentile between p0.0 and p100 |
| `HeadRequests`             | Number of HTTP `HEAD` requests made to an Amazon S3 bucket using an object Lambda access point. Units: Count Valid statistics: Sum |
| `ListRequests`             | Number of HTTP `GET` requests to list the contents of an Amazon S3 bucket. This metric includes both `List` and `ListV2` operations. Units: Count Valid statistics: Sum |
| `4xxErrors`               | Number of HTTP 4xx server error status code requests made to an Amazon S3 bucket using an object Lambda access point with values of 0 or 1. Average statistics show the error rate, Sum statistics show the count of such errors per period. Units: Count Valid statistics: Average (number of reports per request), Sum (number of reports per period), Min, Max, Sample Count |
| `5xxErrors`               | Number of HTTP 5xx server error status code requests made to an Amazon S3 bucket using an object Lambda access point with values of 0 or 1. Average statistics show the error rate, Sum statistics show the count of such errors per period. Units: Count Valid statistics: Average (number of reports per request), Sum (number of reports per period), Min, Max, Sample Count |
| `ProxiedRequests`         | Number of HTTP requests made to an object Lambda access point that returns standard Amazon S3 API responses. (These requests do not have a Lambda function configured.) Units: Count Valid statistics: Sum |
| `InvokedLambda`           | Number of HTTP requests made to S3 objects where a Lambda function is invoked. Units: Count Valid statistics: Sum |
| `LambdaResponseRequests`  | Number of `WriteGetObjectResponse` requests made by the Lambda function. This metric applies only to `GetObject` requests. |
| `LambdaResponse4xx`       | Number of HTTP 4xx client errors that occur when calling `WriteGetObjectResponse` from the Lambda function. This metric provides the same information as `4xxErrors` but applies only to `WriteGetObjectResponse` calls. |
| `LambdaResponse5xx`       | Number of HTTP 5xx server errors that occur when calling `WriteGetObjectResponse` from the Lambda function. This metric provides the same information as `5xxErrors` but applies only to `WriteGetObjectResponse` calls. |

### Amazon S3 on Outposts Metrics in CloudWatch

For a list of metrics used for S3 on Outposts in CloudWatch, see [CloudWatch metrics](https://docs.aws.amazon.com/en_us/AmazonS3/latest/userguide/S3OutpostsCapacity.html#S3OutpostsCloudWatchMetrics){:target="_blank"}.

### Amazon S3 Dimensions in CloudWatch

The following dimensions are used to filter Amazon S3 metrics.

| Dimension          | Description                                                         |
| :---------------- | :-------------------------------------------------------------------|
| `BucketName`      | This dimension filters data requested only for identified buckets.    |
| `StorageType`     | This dimension filters data stored in your bucket by the following storage types: `StandardStorage` – number of bytes for objects in the `STANDARD` storage class. `IntelligentTieringAAStorage` – number of bytes for objects in the archive access tier of the `INTELLIGENT_TIERING` storage class. `IntelligentTieringAIAStorage` – number of bytes for objects in the archive instant access tier of the `INTELLIGENT_TIERING` storage class. `IntelligentTieringDAAStorage` – number of bytes for objects in the deep archive access tier of the `INTELLIGENT_TIERING` storage class. `IntelligentTieringFAStorage` – number of bytes for objects in the frequent access tier of the `INTELLIGENT_TIERING` storage class. `IntelligentTieringIAStorage` – number of bytes for objects in the infrequent access tier of the `INTELLIGENT_TIERING` storage class. `StandardIAStorage` – number of bytes for objects in the "Standard - Infrequent Access Tier (`STANDARD_IA`)". `StandardIASizeOverhead` – number of bytes for objects smaller than 128KB in the `STANDARD_IA` storage class. `IntAAObjectOverhead` – S3 Glacier adds 32KB of storage for index and related metadata for each object in the archive access tier of the `INTELLIGENT_TIERING` storage class. This additional data is needed to identify and restore objects. Additional storage charges apply at S3 Glacier rates. `IntAAS3ObjectOverhead` – Amazon S3 uses 8KB of storage for the name of each object and other metadata in the archive access tier of the `INTELLIGENT_TIERING` storage class. Additional storage charges apply at S3 Standard rates. `IntDAAObjectOverhead` – S3 Glacier adds 32KB of storage for index and related metadata for each object in the deep archive access tier of the `INTELLIGENT_TIERING` storage class. Additional storage charges apply at S3 Glacier Deep Archive rates. `IntDAAS3ObjectOverhead` – Amazon S3 uses 8KB of storage for the name of each object and other metadata in the deep archive access tier of the `INTELLIGENT_TIERING` storage class. Additional storage charges apply at S3 Standard rates. `OneZoneIAStorage` – number of bytes for objects in the "S3 Single Zone - Infrequent Access Tier (`ONEZONE_IA`)". `OneZoneIASizeOverhead` – number of bytes for objects smaller than 128KB in the `ONEZONE_IA` storage class. `ReducedRedundancyStorage` – number of bytes for objects in the low redundancy storage (RRS) class. `GlacierInstantRetrievalSizeOverhead` – number of bytes for objects smaller than 128KB in the S3 Glacier Instant Retrieval storage class. `GlacierInstantRetrievalStorage` – number of bytes for objects in the S3 Glacier Instant Retrieval storage class. `GlacierStorage` – number of bytes for objects in the S3 Glacier Flexible Retrieval storage class. `GlacierStagingStorage` – number of bytes for individual parts of multi-part objects before completing a `CompleteMultipartUpload` request in the S3 Glacier Flexible Retrieval storage class. `GlacierObjectOverhead` – S3 Glacier adds 32KB of storage for index and related metadata for each archive object. Additional storage charges apply at S3 Glacier Flexible Retrieval rates. `GlacierS3ObjectOverhead` – Amazon S3 uses 8KB of storage for the name of each object and other metadata archived to S3 Glacier Flexible Retrieval. Additional storage charges apply at S3 Standard rates. `DeepArchiveStorage` – number of bytes for objects in the S3 Glacier Deep Archive storage class. `DeepArchiveObjectOverhead` – S3 Glacier adds 32KB of storage for index and related metadata for each archive object. Additional storage charges apply at S3 Glacier Deep Archive rates. `DeepArchiveS3ObjectOverhead` – Amazon S3 uses 8KB of storage for the name of each object and other metadata archived to S3 Glacier Deep Archive. Additional storage charges apply at S3 Standard rates. `DeepArchiveStagingStorage` - number of bytes for individual parts of multi-part objects before completing a `CompleteMultipartUpload` request in the S3 Glacier Deep Archive storage class. |
| `FilterId`        | This dimension filters the metrics configuration specified for request metrics on the bucket. When creating a metrics configuration, you need to specify a filter condition ID (e.g., prefix, tag, or access point). For more information, see [Creating Metrics Configurations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/metrics-configurations.html){:target="_blank"}. |

### S3 Storage Lens Dimensions in CloudWatch

For a list of dimensions used to filter S3 Storage Lens metrics in CloudWatch, see [Dimensions](https://docs.aws.amazon.com/en_us/AmazonS3/latest/userguide/storage-lens-cloudwatch-metrics-dimensions.html#storage-lens-cloudwatch-dimensions){:target="_blank"}.

### S3 Object Lambda Request Dimensions in CloudWatch

The following dimensions are used to filter data from object Lambda access points.

| Dimension              | Description                                                         |
| :-------------------- | :-------------------------------------------------------------------|
| `AccessPointName`     | Name of the access point being requested.                           |
| `DataSourceARN`        | Source from which the object Lambda access point is retrieving data. If the request invokes a Lambda function, this refers to the Lambda ARN. Otherwise, it refers to the access point ARN. |

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
    "Grants"      : "{JSON data}",
    "message"     : "{Instance JSON data}"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance name, used for unique identification.
>
> Tip 2: `fields.message` is a JSON serialized string.
>
> Tip 3: `fields.Grants` represents the bucket access control list.