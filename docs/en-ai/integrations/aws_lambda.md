---
title: 'AWS Lambda'
tags: 
  - AWS
summary: 'The displayed metrics for AWS Lambda include cold start time, execution time, concurrent executions, and memory usage. These metrics reflect the response speed, scalability, and resource utilization of Lambda functions.'
__int_icon: 'icon/aws_lambda'

dashboard:
  - desc: 'Built-in View for AWS Lambda'
    path: 'dashboard/en/aws_lambda'

monitor:
  - desc: 'AWS Lambda Monitor'
    path: 'monitor/en/aws_lambda'

---


<!-- markdownlint-disable MD025 -->
# AWS Lambda
<!-- markdownlint-enable -->

The displayed metrics for AWS Lambda include cold start time, execution time, concurrent executions, and memory usage. These metrics reflect the response speed, scalability, and resource utilization of Lambda functions.


## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Prepare an Amazon Cloud AK that meets the requirements in advance (for simplicity, you can directly grant CloudWatch read-only permissions `CloudWatchReadOnlyAccess`)

To synchronize ECS cloud resource monitoring data, we install the corresponding collection script: "Guance Integration (AWS-Lambda Collection)" (ID: `guance_aws_lambda`)

After clicking 【Install】, enter the required parameters: AWS AK ID, AWS AK SECRET.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup script. Ensure that 'regions' in the startup script matches the actual regions of the instances.

After enabling, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, enable the log collection script. If you need to collect billing information, enable the cloud billing collection script.


By default, we collect some configurations; for more details, see [Configuration of Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」confirm whether the corresponding tasks have the automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, in 「Infrastructure / Custom」check if asset information exists.
3. On the Guance platform, in 「Metrics」check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. You can collect more metrics through configuration:

[Amazon CloudWatch Lambda Metrics Details](https://docs.aws.amazon.com/zh_cn/lambda/latest/dg/monitoring-metrics.html){:target="_blank"}


### Invocation Metrics

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `Invocations`                           | The number of times the function code is invoked, including successful invocations and those that result in function errors. Invocations are not recorded if the request is throttled or results in an error. The value of Invocations equals the number of billed requests. |
| `Errors`                           | The number of invocations that result in function errors. Function errors include exceptions raised by your code and those raised by the Lambda runtime. The runtime returns errors due to issues like timeouts and configuration errors. To calculate the error rate, divide the value of Errors by Invocations. Note that the timestamp on the error metric reflects when the function was invoked, not when the error occurred. |
| `DeadLetterErrors`                           | For asynchronous invocations, the number of times Lambda fails to send events to a dead-letter queue (DLQ). Misconfigured resources or size limits may cause dead-letter errors. |
| `DestinationDeliveryFailures`                           | For asynchronous invocations and supported event source mappings, the number of times Lambda fails to send events to destinations. For event source mappings, Lambda supports targets from stream sources (DynamoDB and Kinesis). Permission errors, misconfigured resources, or size limits may cause delivery failures. If you configure unsupported target types, such as Amazon SQS FIFO queues or Amazon SNS FIFO topics, this error may occur. |
| `Throttles`                           | The number of throttled invocation requests. When all function instances are handling requests and no additional concurrency is available for scaling, Lambda rejects other requests and returns a TooManyRequestsException error. Throttled requests and other invocation errors are not counted as Invocations or Errors. |
| `ProvisionedConcurrencyInvocations`                           | The number of times the function code is invoked using provisioned concurrency. |
| `ProvisionedConcurrencySpilloverInvocations`                           | The number of times the function code is invoked using standard concurrency when all provisioned concurrency is in use. |
| `RecursiveInvocationsDropped`                           | The number of times Lambda stops invoking your function because it detects that your function is part of an infinite recursion loop. Lambda's recursion detection monitors how many times a function is invoked as part of a request chain by tracking metadata added by supported AWS SDKs. If your function is invoked more than 16 times as part of a request chain, Lambda interrupts the next invocation. |

### Performance Metrics

Performance metrics provide detailed information about the performance of individual function invocations. For example, the Duration metric indicates the amount of time the function spends processing an event (in milliseconds). To understand how quickly the function processes events, use Average or Max statistics to view these metrics.

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `Duration`                         | The amount of time the function code spends processing an event. The billed duration for an invocation is the rounded Duration value to the nearest millisecond. |
| `PostRuntimeExtensionsDuration`    | The cumulative time spent running extensions after the function code completes. |
| `IteratorAge`                    | For event source mappings that read from streams, the age of the last record in the event. This metric measures the time between when the stream receives the record and when the event source mapping sends the event to the function. |
| `OffsetLag`                           | For self-managed Apache Kafka and Amazon Managed Streaming for Apache Kafka (Amazon MSK) event sources, the difference in offsets between the last record written to the topic and the last record processed by the function's consumer group. Although Kafka topics can contain multiple partitions, this metric still measures offset lag at the topic level. |

### Concurrency Metrics

Lambda reports concurrency metrics as the total number of instances processing events across functions, versions, aliases, or AWS regions. To see how close you are to the concurrency limit, use Max statistics to view these metrics.

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `ConcurrentExecutions`    | The number of function instances currently processing events. If this number reaches the regional concurrency execution quota or the reserved concurrency limit configured on the function, Lambda will throttle other invocation requests. |
| `ProvisionedConcurrentExecutions`    | The number of function instances processing events using provisioned concurrency. For each invocation of an alias or version with provisioned concurrency, Lambda emits the current count. |
| `ProvisionedConcurrencyUtilization`    | For a version or alias, the ratio of ProvisionedConcurrentExecutions to the total allocated provisioned concurrency. For example, .5 indicates that 50% of the allocated provisioned concurrency is in use. |
| `UnreservedConcurrentExecutions`    | For a region, the number of events processed by functions without reserved concurrency. |

### Asynchronous Invocation Metrics

Asynchronous invocation metrics provide details about asynchronous invocations from event sources and direct invocations. You can set thresholds and alerts to notify you of certain changes. For example, when the number of events queued for processing unexpectedly increases (AsyncEventsReceived). Or, when an event takes a long time to complete processing (AsyncEventAge).

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `AsyncEventsReceived`    | The number of events successfully queued for processing by Lambda. This metric provides insight into the number of events received by the Lambda function. Monitor this metric and set threshold alerts to detect issues. For instance, detect the number of bad events sent to Lambda and quickly diagnose problems caused by incorrect triggers or function configurations. A mismatch between AsyncEventsReceived and Invocations may indicate discrepancies in processing, dropped events, or potential queue backlog. |
| `AsyncEventAge`    | The time between when Lambda successfully queues an event and when it invokes the function. When events are retried due to invocation failure or throttling, this metric's value increases. Monitor this metric and set alerts for different statistics' thresholds when queue buildup occurs. To address an increase in this metric, review the Errors metric to identify function errors and the Throttles metric to determine concurrency issues. |
| `AsyncEventsDropped`    | The number of events dropped without successful function execution. If you configure a dead-letter queue (DLQ) or OnFailure target, events are sent there before being dropped. Events are dropped for various reasons. For example, events may exceed the maximum event age or exhaust the maximum retry attempts, or reserved concurrency may be set to 0. To address dropped events, review the Errors metric to identify function errors and the Throttles metric to determine concurrency issues. |

## Objects {#object}

The collected AWS Lambda object data structure can be viewed in 「Infrastructure - Custom」

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
> Note 1: The value of `tags.account_name` is the instance ID, used as a unique identifier