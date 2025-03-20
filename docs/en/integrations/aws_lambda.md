---
title: 'AWS Lambda'
tags: 
  - AWS
summary: 'The displayed Metrics for AWS Lambda include cold start time, execution time, concurrent executions, and memory usage. These Metrics reflect the response speed, scalability, and resource utilization of the Lambda functions.'
__int_icon: 'icon/aws_lambda'

dashboard:
  - desc: 'AWS Lambda built-in Views'
    path: 'dashboard/en/aws_lambda'

monitor:
  - desc: 'AWS Lambda Monitors'
    path: 'monitor/en/aws_lambda'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_lambda'
---


<!-- markdownlint-disable MD025 -->
# AWS Lambda
<!-- markdownlint-enable -->

The displayed Metrics for AWS Lambda include cold start time, execution time, concurrent executions, and memory usage. These Metrics reflect the response speed, scalability, and resource utilization of the Lambda functions.


## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - Extensions - DataFlux Func (Automata): All prerequisites will be automatically installed, please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare an Amazon Cloud AK that meets the requirements in advance (for simplicity, you can directly grant CloudWatch read-only permission `CloudWatchReadOnlyAccess`).

To synchronize ECS cloud resource monitoring data, we install the corresponding collection script: "Guance Integration (AWS-Lambda Collection)" (ID: `guance_aws_lambda`)

After clicking 【Install】, input the corresponding parameters: AWS AK ID, AWS AK SECRET.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set, and automatically configure the corresponding startup script. In the startup script, ensure that 'regions' match the actual regions where the instances are located.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute it once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

> If you want to collect the corresponding LOGs, you also need to enable the corresponding log collection script. If you want to collect billing information, you need to enable the cloud billing collection script.


We default to collecting some configurations; for more details, see [Configuration Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and you can check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, in "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, in "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon Cloud Monitoring, the default Measurement sets are as follows. You can collect more Metrics through configuration:

[Amazon Cloud Monitoring Lambda Metric Details](https://docs.aws.amazon.com/en_us/lambda/latest/dg/monitoring-metrics.html){:target="_blank"}


### Invocation Metrics

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :------------------------------------------------------------------ |
| `Invocations`                           | The number of times the function code was invoked, including successful invocations and those that resulted in function errors. Invocations are not recorded for throttled requests or requests that result in invocation errors. The value of Invocations equals the number of billed requests. |
| `Errors`                           | The number of invocations that resulted in function errors. Function errors include exceptions raised by your code and exceptions raised by the Lambda runtime. The runtime returns errors due to issues such as timeouts and configuration errors. To calculate the error rate, divide the value of Errors by the value of Invocations. Note that the timestamp on the error metric reflects the time the function was invoked, not the time the error occurred. |
| `DeadLetterErrors`                           | For asynchronous invocations, the number of times Lambda attempted to send events to a dead-letter queue (DLQ) but failed. Dead-letter errors may occur due to misconfigured resources or size limits. |
| `DestinationDeliveryFailures`                           | For asynchronous invocations and supported event source mappings, the number of times Lambda attempted to send events to destinations but failed. For event source mappings, Lambda supports targets for stream sources (DynamoDB and Kinesis). Delivery failures may occur due to permission errors, misconfigured resources, or size limits. This error may also occur if the configured target is an unsupported target type, such as an Amazon SQS FIFO queue or an Amazon SNS FIFO topic. |
| `Throttles`                           | The number of throttled invocation requests. When all function instances are handling requests and no concurrency is available for scaling out, Lambda rejects additional requests and returns a TooManyRequestsException error. Throttled requests and other invocation errors are not counted as Invocations or Errors. |
| `ProvisionedConcurrencyInvocations`                           | The number of times the function code was invoked using provisioned concurrency. |
| `ProvisionedConcurrencySpilloverInvocations`                           | The number of times the function code was invoked using standard concurrency when all provisioned concurrency is in use. |
| `RecursiveInvocationsDropped`                           | The number of times Lambda stopped invoking your function because it detected that your function was part of an infinite recursion loop. Lambda recursion detection monitors how many times a function is invoked as part of a request chain by tracking metadata added by supported AWS SDKs. If your function is invoked more than 16 times as part of a request chain, Lambda interrupts the next invocation. |

### Performance Metrics

Performance Metrics provide detailed information about the performance of individual function invocations. For example, the Duration Metric indicates the amount of time (in milliseconds) that the function spent processing the event. To understand how quickly your function processes events, use Average or Max statistics to view these Metrics.

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :------------------------------------------------------------------ |
| `Duration`                         | The amount of time the function code spent processing the event. The billed duration for the invocation is the Duration value rounded up to the nearest millisecond. |
| `PostRuntimeExtensionsDuration`    | The accumulated amount of time the runtime spends running extensions code after the function code completes. |
| `IteratorAge`                    | For event source mappings that read from streams, the age of the last record in the event. This Metric measures the amount of time between when the stream receives the record and when the event source mapping sends the event to the function. |
| `OffsetLag`                           | For self-managed Apache Kafka and Amazon Managed Streaming for Apache Kafka (Amazon MSK) event sources, the difference in offsets between the last record written to the topic and the last record processed by the function's consumer group. Although Kafka topics can contain multiple partitions, this Metric still measures offset lag at the topic level. |

### Concurrency Metrics

Lambda reports concurrency Metrics as the total count of instances across functions, versions, aliases, or AWS Regions that are processing events. To see how close you are to the concurrency limit, use Max statistics to view these Metrics.

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :------------------------------------------------------------------ |
| `ConcurrentExecutions`    | The number of function instances currently processing events. If this number reaches the regional concurrency execution quota or the reserved concurrency limit configured on the function, Lambda will throttle additional invocation requests. |
| `ProvisionedConcurrentExecutions`    | The number of function instances using provisioned concurrency to process events. For each invocation of an alias or version with provisioned concurrency, Lambda emits the current count. |
| `ProvisionedConcurrencyUtilization`    | For a version or alias, the ratio of ProvisionedConcurrentExecutions to the total allocated provisioned concurrency. For example, .5 indicates that 50% of the allocated provisioned concurrency is in use. |
| `UnreservedConcurrentExecutions`    | For a Region, the number of events processed by functions that do not have reserved concurrency. |

### Asynchronous Invocation Metrics

Asynchronous invocation Metrics provide details about asynchronous invocations from event sources and direct invocations. You can set thresholds and alarms to notify you of certain changes. For example, when the number of events queued for processing unexpectedly increases (AsyncEventsReceived), or when an event takes a long time to complete processing (AsyncEventAge).

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :------------------------------------------------------------------ |
| `AsyncEventsReceived`    | The number of events successfully queued for processing by Lambda. This Metric gives insight into the number of events received by the Lambda function. Monitor this Metric and set threshold alerts to check for issues. For example, detect bad events sent to Lambda and quickly diagnose problems caused by incorrect triggers or function configurations. A mismatch between AsyncEventsReceived and Invocations may indicate discrepancies in processing, dropped events, or potential queue backlogs. |
| `AsyncEventAge`    | The amount of time between when Lambda successfully queues the event and when it invokes the function. This Metric's value increases when events are retried due to invocation failures or throttling. Monitor this Metric and set threshold alerts for different statistics when queue buildup occurs. To address issues with this Metric increasing, review the Errors Metric to identify function errors and the Throttles Metric to determine concurrency issues. |
| `AsyncEventsDropped`    | The number of events dropped without successfully executing the function. If you configure a dead-letter queue (DLQ) or OnFailure target, events are sent there before being dropped. Events are dropped for various reasons. For example, events may exceed the maximum event age or exhaust the maximum retry attempts, or reserved concurrency may be set to 0. To address issues with events being dropped, review the Errors Metric to identify function errors and the Throttles Metric to determine concurrency issues. |

## Objects {#object}

Collected AWS Lambda object data structure, which can be viewed in "Infrastructure - Custom"

```json
{
  "measurement": "aws_lambda",
  "tags": {
    "account_name"      :"AWS_Lambda",
    "class"             :"aws_lambda",
    "cloud_provider"    :"aws",
    "FunctionName"      :"dataflux-alb",
    "name"              :"dataflux-alb",
    "PackageType"       :"Zip",
    "RegionId"          :"cn-northwest-1",
    "RevisionId"        :"5e52ff51-615a-4ecb-96b7-40083a7b4b62",
    "Role"              :"arn:aws-cn:iam::294654068288:role/service-role/s3--guance-role-3w34zo42",
    "Runtime"           :"python3.7",
    "Version"           :"$LATEST"
  },
  "fields": {
    "CreatedTime"         : "2022-03-09T06:13:31Z",
    "ListenerDescriptions": "{JSON data}",
    "AvailabilityZones"   : "{Availability Zone JSON data}",
    "message"             : "{Instance JSON data}"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.account_name` is the instance ID, used as unique identification.