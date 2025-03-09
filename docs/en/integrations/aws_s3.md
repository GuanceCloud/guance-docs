---
title: 'AWS S3'
tags: 
  - AWS
summary: 'Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud'
__int_icon: 'icon/aws_s3'
dashboard:
  - desc: 'AWS S3 Monitoring View'
    path: 'dashboard/en/aws_s3'
monitor:
  - desc: 'AWS S3 Monitor'
    path: 'monitor/en/aws_s3'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/en/aws_s3'
---


<!-- markdownlint-disable MD025 -->
# AWS S3
<!-- markdownlint-enable -->

Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of AWS S3, install the corresponding collection script: `ID:guance_aws_s3`

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metrics {#metric}

After configuring Amazon CloudWatch, the default metric set includes the following metrics. You can collect more metrics by configuring it [Amazon S3 CloudWatch Metrics Details](https://docs.aws.amazon.com/en_us/AmazonS3/latest/userguide/metrics-dimensions.html){:target="_blank"}

<!-- markdownlint-disable MD013 -->
### Amazon S3 daily storage metrics for buckets in CloudWatch
<!-- markdownlint-enable -->

The `AWS/S3` namespace includes the following daily storage metrics for buckets.

| Metric            | Description                                                  |
| :---------------- | :----------------------------------------------------------- |
| `BucketSizeBytes` | The amount of data in bytes that is stored in a bucket in the following storage classes:S3 Standard (`STANDARD`)S3 Intelligent-Tiering (`INTELLIGENT_TIERING`)S3 Standard-Infrequent Access (`STANDARD_IA`)S3 OneZone-Infrequent Access (`ONEZONE_IA`)Reduced Redundancy Storage (RRS) (`REDUCED_REDUNDANCY`)S3 Glacier Instant Retrieval (`GLACIER_IR`)S3 Glacier Deep Archive (`DEEP_ARCHIVE`)S3 Glacier Flexible Retrieval (`GLACIER`)This value is calculated by summing the size of all objects and metadata in the bucket (both current and noncurrent objects), including the size of all parts for all incomplete multipart uploads to the bucket.Valid storage-type filters: `StandardStorage`, `IntelligentTieringFAStorage`, `IntelligentTieringIAStorage`, `IntelligentTieringAAStorage`, `IntelligentTieringAIAStorage`, `IntelligentTieringDAAStorage`, `StandardIAStorage`, `StandardIASizeOverhead`, `StandardIAObjectOverhead`, `OneZoneIAStorage`, `OneZoneIASizeOverhead`, `ReducedRedundancyStorage`, `GlacierInstantRetrievalSizeOverhead` `GlacierInstantRetrievalStorage`, `GlacierStorage`, `GlacierStagingStorage`, `GlacierObjectOverhead`, `GlacierS3ObjectOverhead`, `DeepArchiveStorage`, `DeepArchiveObjectOverhead`, `DeepArchiveS3ObjectOverhead`, and `DeepArchiveStagingStorage` (see the `StorageType` dimension)Units: BytesValid statistics: Average |
| `NumberOfObjects` | The total number of objects stored in a bucket for all storage classes. This value is calculated by counting all objects in the bucket, which includes current and noncurrent objects, delete markers, and the total number of parts for all incomplete multipart uploads to the bucket.Valid storage type filters: `AllStorageTypes` (see the `StorageType` dimension)Units: CountValid statistics: Average |

### Amazon S3 request metrics in CloudWatch

The `AWS/S3` namespace includes the following request metrics. These metrics include non-billable requests (in the case of GET requests from COPY and Replication).

| Metric                | Description                                                  |
| :-------------------- | :----------------------------------------------------------- |
| `AllRequests`         | The total number of HTTP requests made to an Amazon S3 bucket, regardless of type. If you're using a metrics configuration with a filter, then this metric returns only the HTTP requests that meet the filter's requirements.Units: CountValid statistics: Sum |
| `GetRequests`         | The number of HTTP GET requests made for objects in an Amazon S3 bucket. This doesn't include list operations. This metric is incremented for the source of each COPY object request.Units: CountValid statistics: SumNotePaginated list-oriented requests, such as [List Multipart Uploads](https://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadListMPUpload.html), [List Parts](https://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadListParts.html), [Get Bucket Object versions](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETVersion.html), and others, are not included in this metric. |
| `PutRequests`         | The number of HTTP PUT requests made for objects in an Amazon S3 bucket. This metric is incremented for the destination of each COPY object request.Units: CountValid statistics: Sum |
| `DeleteRequests`      | The number of HTTP `DELETE` requests made for objects in an Amazon S3 bucket. This metric also includes [Delete Multiple Objects](https://docs.aws.amazon.com/AmazonS3/latest/API/multiobjectdeleteapi.html){:target="_blank"} requests. This metric shows the number of requests made, not the number of objects deleted.Units: CountValid statistics: Sum |
| `HeadRequests`        | The number of HTTP `HEAD` requests made to an Amazon S3 bucket.Units: CountValid statistics: Sum |
| `PostRequests`        | The number of HTTP `POST` requests made to an Amazon S3 bucket.Units: CountValid statistics: SumNote[Delete Multiple Objects](https://docs.aws.amazon.com/AmazonS3/latest/API/multiobjectdeleteapi.html){:target="_blank"} and [SELECT Object Content](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"} requests are not included in this metric. |
| `SelectRequests`      | The number of Amazon S3 [SELECT Object Content](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"} requests made for objects in an Amazon S3 bucket.Units: CountValid statistics: Sum |
| `SelectBytesScanned`  | The number of bytes of data scanned with Amazon S3 [SELECT Object Content](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"} requests in an Amazon S3 bucket.Units: BytesValid statistics: Average (bytes per request), Sum (bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `SelectBytesReturned` | The number of bytes of data returned with Amazon S3 [SELECT Object Content](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectSELECTContent.html){:target="_blank"} requests in an Amazon S3 bucket.Units: BytesValid statistics: Average (bytes per request), Sum (bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `ListRequests`        | The number of HTTP requests that list the contents of a bucket.Units: CountValid statistics: Sum |
| `BytesDownloaded`     | The number of bytes downloaded for requests made to an Amazon S3 bucket, where the response includes a body.Units: BytesValid statistics: Average (bytes per request), Sum (bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `BytesUploaded`       | The number of bytes uploaded for requests made to an Amazon S3 bucket, where the request includes a body.Units: BytesValid statistics: Average (bytes per request), Sum (bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `4xxErrors`           | The number of HTTP 4xx client error status code requests made to an Amazon S3 bucket with a value of either 0 or 1. The Average statistic shows the error rate, and the Sum statistic shows the count of that type of error, during each period.Units: CountValid statistics: Average (reports per request), Sum (reports per period), Min, Max, Sample Count |
| `5xxErrors`           | The number of HTTP 5xx server error status code requests made to an Amazon S3 bucket with a value of either 0 or 1. The Average statistic shows the error rate, and the Sum statistic shows the count of that type of error, during each period.Units: CountValid statistics: Average (reports per request), Sum (reports per period), Min, Max, Sample Count |
| `FirstByteLatency`    | The per-request time from the complete request being received by an Amazon S3 bucket to when the response starts to be returned.Units: MillisecondsValid statistics: Average, Sum, Min, Max (same as p100), Sample Count, any percentile between p0.0 and p100 |
| `TotalRequestLatency` | The elapsed per-request time from the first byte received to the last byte sent to an Amazon S3 bucket. This metric includes the time taken to receive the request body and send the response body, which is not included in `FirstByteLatency`.Units: MillisecondsValid statistics: Average, Sum, Min, Max (same as p100), Sample Count, any percentile between p0.0 and p100 |

### S3 Replication metrics in CloudWatch

You can monitor the progress of replication with S3 Replication metrics by tracking bytes pending, operations pending, and replication latency. For more information, see [Monitoring progress with replication metrics](https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-metrics.html){:target="_blank"}.

Note

You can enable alarms for your replication metrics in Amazon CloudWatch. When you set up alarms for your replication metrics, set the **Missing data treatment** field to **Treat missing data as ignore (maintain the alarm state)**.

| Metric                         | Description                                                  |
| :----------------------------- | :----------------------------------------------------------- |
| `ReplicationLatency`           | The maximum number of seconds by which the replication destination AWS Region is behind the source AWS Region for a given replication rule.Units: SecondsValid statistics: Max |
| `BytesPendingReplication`      | The total number of bytes of objects pending replication for a given replication rule.Units: BytesValid statistics: Max |
| `OperationsPendingReplication` | The number of operations pending replication for a given replication rule.Units: CountValid statistics: Max |
| `OperationsFailedReplication`  | The number of operations that failed to replicate for a given replication rule.Units: CountValid statistics: Sum (total number of failed operations), Average (failure rate), Sample Count (total number of replication operations) |

### S3 Storage Lens metrics in CloudWatch

You can publish S3 Storage Lens usage and activity metrics to Amazon CloudWatch to create a unified view of your operational health in [CloudWatch dashboards](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Dashboards.html){:target="_blank"}. S3 Storage Lens metrics are published to the `AWS/S3/Storage-Lens` namespace in CloudWatch. The CloudWatch publishing option is available for S3 Storage Lens dashboards that have been upgraded to advanced metrics and recommendations.

For a list of S3 Storage Lens metrics that are published to CloudWatch, see [Amazon S3 Storage Lens metrics glossary](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens_metrics_glossary.html){:target="_blank"}. For a complete list of dimensions, see [Dimensions](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-lens-cloudwatch-metrics-dimensions.html#storage-lens-cloudwatch-dimensions){:target="_blank"}.

### S3 Object Lambda request metrics in CloudWatch

S3 Object Lambda includes the following request metrics.

| Metric                   | Description                                                  |
| :----------------------- | :----------------------------------------------------------- |
| `AllRequests`            | The total number of HTTP requests made to an Amazon S3 bucket by using an Object Lambda Access Point.Units: CountValid statistics: Sum |
| `GetRequests`            | The number of HTTP `GET` requests made for objects by using an Object Lambda Access Point. This metric does not include list operations.Units: CountValid statistics: Sum |
| `BytesUploaded`          | The number of bytes uploaded to an Amazon S3 bucket by using an Object Lambda Access Point, where the request includes a body.Units: BytesValid statistics: Average (bytes per request), Sum (bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `PostRequests`           | The number of HTTP `POST` requests made to an Amazon S3 bucket by using an Object Lambda Access Point.Units: CountValid statistics: Sum |
| `PutRequests`            | The number of HTTP `PUT` requests made for objects in an Amazon S3 bucket by using an Object Lambda Access Point.Units: CountValid statistics: Sum |
| `DeleteRequests`         | The number of HTTP `DELETE` requests made for objects in an Amazon S3 bucket by using an Object Lambda Access Point. This metric includes [Delete Multiple Objects](https://docs.aws.amazon.com/AmazonS3/latest/API/multiobjectdeleteapi.html) requests. This metric shows the number of requests made, not the number of objects deleted.Units: CountValid statistics: Sum |
| `BytesDownloaded`        | The number of bytes downloaded for requests made to an Amazon S3 bucket by using an Object Lambda Access Point, where the response includes a body.Units: BytesValid statistics: Average (bytes per request), Sum (bytes per period), Sample Count, Min, Max (same as p100), any percentile between p0.0 and p99.9 |
| `FirstByteLatency`       | The per-request time from the complete request being received by an Amazon S3 bucket through an Object Lambda Access Point to when the response starts to be returned. This metric is dependent on the AWS Lambda function's running time to transform the object before the function returns the bytes to the Object Lambda Access Point.Units: MillisecondsValid statistics: Average, Sum, Min, Max (same as p100), Sample Count, any percentile between p0.0 and p100 |
| `TotalRequestLatency`    | The elapsed per-request time from the first byte received to the last byte sent to an Object Lambda Access Point. This metric includes the time taken to receive the request body and send the response body, which is not included in `FirstByteLatency`.Units: MillisecondsValid statistics: Average, Sum, Min, Max (same as p100), Sample Count, any percentile between p0.0 and p100 |
| `HeadRequests`           | The number of HTTP `HEAD` requests made to an Amazon S3 bucket by using an Object Lambda Access Point.Units: CountValid statistics: Sum |
| `ListRequests`           | The number of HTTP `GET` requests that list the contents of an Amazon S3 bucket. This metric includes both `List` and `ListV2` operations.Units: CountValid statistics: Sum |
| `4xxErrors`              | The number of HTTP 4xx server error status code requests made to an Amazon S3 bucket by using an Object Lambda Access Point with a value of either 0 or 1. The Average statistic shows the error rate, and the Sum statistic shows the count of that type of error, during each period.Units: CountValid statistics: Average (reports per request), Sum (reports per period), Min, Max, Sample Count |
| `5xxErrors`              | The number of HTTP 5xx server error status code requests made to an Amazon S3 bucket by using an Object Lambda Access Point with a value of either 0 or 1. The Average statistic shows the error rate, and the Sum statistic shows the count of that type of error, during each period.Units: CountValid statistics: Average (reports per request), Sum (reports per period), Min, Max, Sample Count |
| `ProxiedRequests`        | The number of HTTP requests to an Object Lambda Access Point that return the standard Amazon S3 API response. (Such requests do not have a Lambda function configured.)Units: CountValid statistics: Sum |
| `InvokedLambda`          | The number of HTTP requests to an S3 object where a Lambda function was invoked.Units: CountValid statistics: Sum |
| `LambdaResponseRequests` | The number of `WriteGetObjectResponse` requests made by the Lambda function. This metric applies only to `GetObject` requests. |
| `LambdaResponse4xx`      | The number of HTTP 4xx client errors that occur when calling `WriteGetObjectResponse` from a Lambda function. This metric provides the same information as `4xxErrors`, but only for `WriteGetObjectResponse` calls. |
| `LambdaResponse5xx`      | The number of HTTP 5xx server errors that occur when calling `WriteGetObjectResponse` from a Lambda function. This metric provides the same information as `5xxErrors`, but only for `WriteGetObjectResponse` calls. |

### Amazon S3 on Outposts metrics in CloudWatch

For a list of metrics in CloudWatch that are used for S3 on Outposts buckets, see [CloudWatch metrics](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3OutpostsCapacity.html#S3OutpostsCloudWatchMetrics){:target="_blank"}.

### Amazon S3 dimensions in CloudWatch

The following dimensions are used to filter Amazon S3 metrics.

| Dimension     | Description                                                  |
| :------------ | :----------------------------------------------------------- |
| `BucketName`  | This dimension filters the data that you request for the identified bucket only. |
| `StorageType` | This dimension filters the data that you have stored in a bucket by the following types of storage:`StandardStorage` – The number of bytes used for objects in the `STANDARD` storage class.`IntelligentTieringAAStorage` – The number of bytes used for objects in the Archive Access tier of the `INTELLIGENT_TIERING` storage class.`IntelligentTieringAIAStorage` – The number of bytes used for objects in the Archive Instant Access tier of the `INTELLIGENT_TIERING` storage class.`IntelligentTieringDAAStorage` – The number of bytes used for objects in the Deep Archive Access tier of the `INTELLIGENT_TIERING` storage class.`IntelligentTieringFAStorage` – The number of bytes used for objects in the Frequent Access tier of the `INTELLIGENT_TIERING` storage class.`IntelligentTieringIAStorage` – The number of bytes used for objects in the Infrequent Access tier of the `INTELLIGENT_TIERING` storage class.`StandardIAStorage` – The number of bytes used for objects in the Standard-Infrequent Access (`STANDARD_IA`) storage class.`StandardIASizeOverhead` – The number of bytes used for objects smaller than 128 KB in the `STANDARD_IA` storage class.`IntAAObjectOverhead` – For each object in the `INTELLIGENT_TIERING` storage class in the Archive Access tier, S3 Glacier adds 32 KB of storage for index and related metadata. This extra data is necessary to identify and restore your object. You are charged S3 Glacier rates for this additional storage.`IntAAS3ObjectOverhead` – For each object in the `INTELLIGENT_TIERING` storage class in the Archive Access tier, Amazon S3 uses 8 KB of storage for the name of the object and other metadata. You are charged S3 Standard rates for this additional storage.`IntDAAObjectOverhead` – For each object in the `INTELLIGENT_TIERING` storage class in the Deep Archive Access tier, S3 Glacier adds 32 KB of storage for index and related metadata. This extra data is necessary to identify and restore your object. You are charged S3 Glacier Deep Archive storage rates for this additional storage.`IntDAAS3ObjectOverhead` – For each object in the `INTELLIGENT_TIERING` storage class in the Deep Archive Access tier, Amazon S3 adds 8 KB of storage for index and related metadata. This extra data is necessary to identify and restore your object. You are charged S3 Standard rates for this additional storage.`OneZoneIAStorage` – The number of bytes used for objects in the S3 One Zone-Infrequent Access (`ONEZONE_IA`) storage class.`OneZoneIASizeOverhead` – The number of bytes used for objects smaller than 128 KB in the `ONEZONE_IA` storage class.`ReducedRedundancyStorage` – The number of bytes used for objects in the Reduced Redundancy Storage (RRS) class.`GlacierInstantRetrievalSizeOverhead` – The number of bytes used for objects smaller than 128 KB in the S3 Glacier Instant Retrieval storage class.`GlacierInstantRetrievalStorage` – The number of bytes used for objects in the S3 Glacier Instant Retrieval storage class.`GlacierStorage` – The number of bytes used for objects in the S3 Glacier Flexible Retrieval storage class.`GlacierStagingStorage` – The number of bytes used for parts of multipart objects before the `CompleteMultipartUpload` request is completed on objects in the S3 Glacier Flexible Retrieval storage class.`GlacierObjectOverhead` – For each archived object, S3 Glacier adds 32 KB of storage for index and related metadata. This extra data is necessary to identify and restore your object. You are charged S3 Glacier Flexible Retrieval rates for this additional storage.`GlacierS3ObjectOverhead` – For each object archived to S3 Glacier Flexible Retrieval, Amazon S3 uses 8 KB of storage for the name of the object and other metadata. You are charged S3 Standard rates for this additional storage.`DeepArchiveStorage` – The number of bytes used for objects in the S3 Glacier Deep Archive storage class.`DeepArchiveObjectOverhead` – For each archived object, S3 Glacier adds 32 KB of storage for index and related metadata. This extra data is necessary to identify and restore your object. You are charged S3 Glacier Deep Archive rates for this additional storage.`DeepArchiveS3ObjectOverhead` – For each object archived to S3 Glacier Deep Archive, Amazon S3 uses 8 KB of storage for the name of the object and other metadata. You are charged S3 Standard rates for this additional storage.`DeepArchiveStagingStorage` – The number of bytes used for parts of multipart objects before the `CompleteMultipartUpload` request is completed on objects in the S3 Glacier Deep Archive storage class. |
| `FilterId`    | This dimension filters metrics configurations that you specify for the request metrics on a bucket. When you create a metrics configuration, you specify a filter ID (for example, a prefix, a tag, or an access point). For more information, see [Creating a metrics configuration](https://docs.aws.amazon.com/AmazonS3/latest/userguide/metrics-configurations.html){:target="_blank"}. |

### S3 Storage Lens dimensions in CloudWatch

For a list of dimensions that are used to filter S3 Storage Lens metrics in CloudWatch, see [Dimensions](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-lens-cloudwatch-metrics-dimensions.html#storage-lens-cloudwatch-dimensions){:target="_blank"}.

### S3 Object Lambda request dimensions in CloudWatch

The following dimensions are used to filter data from an Object Lambda Access Point.

| Dimension         | Description                                                  |
| :---------------- | :----------------------------------------------------------- |
| `AccessPointName` | The name of the access point of which requests are being made. |
| `DataSourceARN`   | The source the Object Lambda Access Point is retrieving the data from. If the request invokes a Lambda function this refers to the Lambda ARN. Otherwise this refers to the access point ARN. |

## Object {#object}

The collected AWS S3 object data structure can be viewed in "Infrastructure - Custom" under the object data.

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

> *Note: The fields in `tags` and `fields` may be subject to changes in subsequent updates.*
>
> Tip 1: The value of `tags.name` is the instance name and serves as a unique identifier.
>
> Tip 2: `fields.message` is a JSON-serialized string.
>
> Tip 3: `fields.Grants` represents the bucket access control list.
