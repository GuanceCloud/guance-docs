---
title: 'AWS Lambda'
tags: 
  - AWS
summary: 'The displayed metrics for AWS Lambda include cold start time, execution time, concurrent executions, and memory usage. These metrics reflect the response speed, scalability, and resource utilization of Lambda functions.'
__int_icon: 'icon/aws_lambda'

dashboard:
  - desc: 'Built-in Views for AWS Lambda'
    path: 'dashboard/en/aws_lambda'

monitor:
  - desc: 'AWS Lambda Monitor'
    path: 'monitor/en/aws_lambda'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_lambda'
---


<!-- markdownlint-disable MD025 -->
# AWS Lambda
<!-- markdownlint-enable -->

The displayed metrics for AWS Lambda include cold start time, execution time, concurrent executions, and memory usage. These metrics reflect the response speed, scalability, and resource utilization of Lambda functions.


## Configuration {#config}

### Install Func

We recommend enabling Guance integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Prepare an Amazon Cloud AK that meets the requirements in advance (for simplicity, you can directly grant CloudWatch read-only permissions `CloudWatchReadOnlyAccess`).

To synchronize ECS cloud resource monitoring data, install the corresponding collection script: "Guance Integration (AWS-Lambda Collection)" (ID: `guance_aws_lambda`)

After clicking 【Install】, enter the required parameters: AWS AK ID, AWS AK SECRET.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup scripts. Ensure that 'regions' in the startup script match the actual regions of the instances.

After enabling, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】to run it immediately without waiting for the scheduled time. Wait a moment, then view the execution task records and corresponding logs.

> If you need to collect logs, enable the corresponding log collection script. If you need to collect billing data, enable the cloud billing collection script.


By default, we collect some configurations; for more details, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. Confirm in "Manage / Automatic Trigger Configuration" whether the corresponding tasks have the automatic trigger configuration, and check the task records and logs for any anomalies.
2. In the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. In the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration:

[Amazon Cloud Monitoring Lambda Metrics Details](https://docs.aws.amazon.com/en_us/lambda/latest/dg/monitoring-metrics.html){:target="_blank"}


### Invocation Metrics

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `Invocations`                           | The number of times the function code is invoked, including successful invocations and those that result in function errors. Invocations are not recorded if the invocation request is throttled or results in an error. The value of Invocations equals the number of billed requests. |
| `Errors`                           | The number of invocations that result in function errors. Function errors include exceptions thrown by your code and those raised by the Lambda runtime. Runtime returns errors due to issues like timeouts and configuration errors. To calculate the error rate, divide the value of Errors by Invocations. Note that the timestamp on the error metric reflects the time when the function was invoked, not the time when the error occurred. |
| `DeadLetterErrors`                           | For asynchronous invocations, the number of times Lambda fails to send events to the dead-letter queue (DLQ). Misconfigured resources or size limits may cause dead letter errors. |
| `DestinationDeliveryFailures`                           | For asynchronous invocations and supported event source mappings, the number of times Lambda fails to send events to the destination. For event source mappings, Lambda supports targets for stream sources (DynamoDB and Kinesis). Permission errors, misconfigured resources, or size limits may cause delivery failures. If you configure unsupported target types, such as Amazon SQS FIFO queues or Amazon SNS FIFO topics, this error may occur. |
| `Throttles`                           | The number of throttled invocation requests. When all function instances are handling requests and there is no available concurrency for scaling out, Lambda rejects other requests, resulting in TooManyRequestsException errors. Throttled requests and other invocation errors are not counted as Invocations or Errors. |
| `ProvisionedConcurrencyInvocations`                           | The number of times the function code is invoked using provisioned concurrency. |
| `ProvisionedConcurrencySpilloverInvocations`                           | The number of times the function code is invoked using standard concurrency when all provisioned concurrency is in use. |
| `RecursiveInvocationsDropped`                           | The number of times Lambda stops invoking your function because it detects that your function is part of an infinite recursion loop. Lambda monitors the number of times your function is invoked as part of a request chain using metadata added by supported AWS SDKs. If your function is invoked more than 16 times as part of a request chain, Lambda interrupts the next invocation. |

### Performance Metrics

Performance metrics provide detailed information about individual function invocations. For example, the Duration metric indicates the amount of time (in milliseconds) the function spends processing an event. To understand how quickly the function processes events, use Average or Max statistics to view these metrics.

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `Duration`                         | The amount of time the function code spends processing an event. The billed duration for the invocation is the rounded-to-the-nearest-millisecond value of Duration. |
| `PostRuntimeExtensionsDuration`    | The cumulative time the runtime spends running extension code after the function code completes. |
| `IteratorAge`                    | For event source mappings that read from streams, the age of the last record in the event. This metric measures the time between when the stream receives the record and when the event source mapping sends the event to the function. |
| `OffsetLag`                           | For self-managed Apache Kafka and Amazon Managed Streaming for Apache Kafka (Amazon MSK) event sources, the difference in offset between the last record written to the topic and the last record processed by the function's consumer group. Although Kafka topics can contain multiple partitions, this metric still measures offset lag at the topic level. |

### Concurrency Metrics

Lambda reports concurrency metrics as the total count of instances processing events across functions, versions, aliases, or AWS regions. To see how close you are to concurrency limits, use Max statistics to view these metrics.

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `ConcurrentExecutions`    | The number of function instances currently processing events. If this number reaches the concurrency execution quota for the region or the reserved concurrency limit configured on the function, Lambda will throttle other invocation requests. |
| `ProvisionedConcurrentExecutions`    | The number of function instances processing events using provisioned concurrency. For each invocation of an alias or version with provisioned concurrency, Lambda emits the current count. |
| `ProvisionedConcurrencyUtilization`    | For versions or aliases, the ratio of ProvisionedConcurrentExecutions to the total allocated provisioned concurrency. For example, .5 indicates that 50% of the allocated provisioned concurrency is in use. |
| `UnreservedConcurrentExecutions`    | For a region, the number of events processed by functions that do not have reserved concurrency. |

### Asynchronous Invocation Metrics

Asynchronous invocation metrics provide details about asynchronous invocations from event sources and direct invocations. You can set thresholds and alerts to notify you of certain changes. For example, when the number of events queued for processing unexpectedly increases (AsyncEventsReceived), or when an event takes a long time to complete processing (AsyncEventAge).

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `AsyncEventsReceived`    | The number of events successfully queued by Lambda for processing. This metric gives insight into the number of events received by the Lambda function. Monitor this metric and set threshold alerts to detect issues. For example, detect the number of bad events sent to Lambda and quickly diagnose problems caused by incorrect triggers or function configurations. A mismatch between AsyncEventsReceived and Invocations may indicate differences in processing, dropped events, or potential queue backlog. |
| `AsyncEventAge`    | The time between when Lambda successfully queues the event and when it invokes the function. This metric's value increases when events are retried due to invocation failures or throttling. Monitor this metric and set alerts for different statistics when queues build up. To address increases in this metric, review the Errors metric to identify function errors and the Throttles metric to determine concurrency issues. |
| `AsyncEventsDropped`    | The number of events dropped without successfully executing the function. If you configure a dead-letter queue (DLQ) or OnFailure target, events are sent there before being dropped. Events are dropped for various reasons. For example, events may exceed the maximum event age or exhaust the maximum retry attempts, or reserved concurrency may be set to 0. To address dropped events, review the Errors metric to identify function errors and the Throttles metric to determine concurrency issues.

## Objects {#object}

The collected AWS Lambda object data structure can be viewed under "Infrastructure - Custom".

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
    "AvailabilityZones"   : "{Availability Zones JSON data}",
    "message"             : "{Instance JSON data}"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.account_name` is the instance ID, used for unique identification.
