---
title: 'AWS Lambda'
tags: 
  - AWS
summary: 'The displayed Metrics for AWS Lambda include cold start time, execution time, number of concurrent executions, and memory usage. These metrics reflect the response speed, scalability, and resource utilization of Lambda functions.'
__int_icon: 'icon/aws_lambda'

dashboard:
  - desc: 'AWS Lambda built-in views'
    path: 'dashboard/en/aws_lambda'

monitor:
  - desc: 'AWS Lambda monitors'
    path: 'monitor/en/aws_lambda'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_lambda'
---


<!-- markdownlint-disable MD025 -->
# AWS Lambda
<!-- markdownlint-enable -->

The displayed Metrics for AWS Lambda include cold start time, execution time, number of concurrent executions, and memory usage. These metrics reflect the response speed, scalability, and resource utilization of Lambda functions.


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare an Amazon Web Services Access Key (AK) that meets the requirements in advance (for simplicity, you can directly grant CloudWatch read-only permission `CloudWatchReadOnlyAccess`).

#### Script for enabling the managed version

1. Log in to the <<< custom_key.brand_name >>> console.
2. Click on the 【Manage】 menu and select 【Cloud Account Management】.
3. Click 【Add Cloud Account】, choose 【AWS】, and fill out the required information on the interface. If a cloud account has already been configured, skip this step.
4. Click 【Test】, and after a successful test, click 【Save】. If the test fails, check whether the related configuration information is correct and retest.
5. In the 【Cloud Account Management】 list, you can see the added cloud account. Click on the corresponding cloud account to enter the details page.
6. On the cloud account details page, click the 【Integration】 button. Under the `Not Installed` list, find `AWS Lambda`, click the 【Install】 button, and follow the prompts to complete the installation.

#### Manual activation script

1. Log in to the Func console, click 【Script Market】, go to the official script market, and search for: `guance_aws_lambda`.

2. After clicking 【Install】, input the corresponding parameters: AWS AK ID, AK Secret, and account name.

3. Click 【Deploy Startup Script】, and the system will automatically create a `Startup` Measurement set and automatically configure the corresponding startup scripts.

4. After enabling, you can see the corresponding automatic trigger configurations under 「Manage / Automatic Trigger Configurations」. Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.


### Verification

1. In 「Manage / Automatic Trigger Configurations」, confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and check the task records and logs to ensure there are no abnormalities.
2. In <<< custom_key.brand_name >>>, under 「Infrastructure / Custom」, check if asset information exists.
3. In <<< custom_key.brand_name >>>, under 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon-Cloud Monitoring, the default Measurement set is as follows. You can collect more Metrics through configuration:

[Amazon Cloud Monitoring Lambda Metrics Details](https://docs.aws.amazon.com/en_us/lambda/latest/dg/monitoring-metrics.html){:target="_blank"}


### Invocation Metrics

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :------------------------------------------------------------------ |
| `Invocations`                           | The number of times function code is invoked, including successful invocations and those that result in function errors. If invocation requests are throttled or result in invocation errors, they are not recorded as invocations. The value of Invocations equals the number of billed requests. |
| `Errors`                           | The number of invocations that result in function errors. Function errors include exceptions caused by your code and those raised by the Lambda runtime. The runtime returns errors due to issues like timeouts and configuration errors. To calculate the error rate, divide the value of Errors by the value of Invocations. Note that the timestamp on the error metric reflects the time when the function was invoked, not the time when the error occurred. |
| `DeadLetterErrors`                           | For asynchronous invocations, the number of times Lambda attempts to send events to a dead-letter queue (DLQ) but fails. Misconfigured resources or size limits may cause dead-letter errors. |
| `DestinationDeliveryFailures`                           | For asynchronous invocations and supported event source mappings, the number of times Lambda attempts to send events to destinations but fails. For event source mappings, Lambda supports targets for stream sources (DynamoDB and Kinesis). Permission errors, misconfigured resources, or size limits may cause delivery failures. This error occurs if you configure unsupported target types, such as Amazon SQS FIFO queues or Amazon SNS FIFO topics. |
| `Throttles`                           | The number of throttled invocation requests. When all function instances are handling requests and there is no available concurrency for scaling, Lambda rejects additional requests and returns a TooManyRequestsException error. Throttled requests and other invocation errors are not counted as Invocations or Errors. |
| `ProvisionedConcurrencyInvocations`                           | The number of times function code is invoked using provisioned concurrency. |
| `ProvisionedConcurrencySpilloverInvocations`                           | The number of times function code is invoked using standard concurrency when all provisioned concurrency is in use. |
| `RecursiveInvocationsDropped`                           | The number of times Lambda stops invoking your function because it detects that your function is part of an infinite recursion loop. Lambda recursion detection monitors how many times your function is invoked as part of a request chain by tracking metadata added by supported AWS SDKs. If your function is invoked more than 16 times as part of a request chain, Lambda interrupts the next invocation. |

### Performance Metrics

Performance Metrics provide detailed information about the performance of individual function invocations. For example, the Duration metric indicates the amount of time spent by the function processing an event (in milliseconds). To understand how quickly your function processes events, use Average or Max statistics to view these metrics.

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :------------------------------------------------------------------ |
| `Duration`                         | The amount of time spent by function code processing an event. The billed duration for an invocation is the rounded-to-the-nearest-millisecond value of Duration. |
| `PostRuntimeExtensionsDuration`    | The cumulative amount of time spent by the runtime running extensions code after the function code completes. |
| `IteratorAge`                    | For event source mappings reading from streams, the age of the last record in the event. This metric measures the time between when the stream receives the record and when the event source mapping sends the event to the function. |
| `OffsetLag`                           | For self-managed Apache Kafka and Amazon Managed Streaming for Apache Kafka (Amazon MSK) event sources, the difference in offsets between the last record written to the topic and the last record processed by the function's consumer group. Despite Kafka topics potentially containing multiple partitions, this metric still measures offset lag at the topic level. |

### Concurrency Metrics

Lambda reports concurrency Metrics as the total number of instances handling events across functions, versions, aliases, or AWS regions. To see how close you are to the concurrency limit, use Max statistics to view these Metrics.

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :------------------------------------------------------------------ |
| `ConcurrentExecutions`    | The number of function instances currently processing events. If this number reaches the regional concurrency execution quota or the reserved concurrency limit configured on the function, Lambda will throttle additional invocation requests. |
| `ProvisionedConcurrentExecutions`    | The number of function instances using provisioned concurrency to handle events. For each invocation of an alias or version with provisioned concurrency, Lambda emits the current count. |
| `ProvisionedConcurrencyUtilization`    | For a version or alias, the ProvisionedConcurrentExecutions value divided by the total allocated provisioned concurrency. For example, .5 indicates that 50% of the allocated provisioned concurrency is in use. |
| `UnreservedConcurrentExecutions`    | For a region, the number of events handled by functions without reserved concurrency. |

### Asynchronous Invocation Metrics

Asynchronous invocation Metrics provide details about asynchronous invocations from event sources and direct invocations. You can set thresholds and alarms to notify you of certain changes. For example, when the number of events queued for processing unexpectedly increases (AsyncEventsReceived), or when an event takes a long time to be processed (AsyncEventAge).

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :------------------------------------------------------------------ |
| `AsyncEventsReceived`    | The number of events successfully queued for processing by Lambda. This metric provides insight into the number of events received by the Lambda function. Monitor this metric and set threshold alerts to check for issues. For instance, detect the number of malformed events sent to Lambda and quickly diagnose problems caused by incorrect triggers or function configurations. Any mismatch between AsyncEventsReceived and Invocations might indicate discrepancies in processing, dropped events, or potential queue backlogs. |
| `AsyncEventAge`    | The time between when Lambda successfully queues an event and when the function is called. This metric's value increases when events are retried due to invocation failure or throttling. Monitor this metric and set threshold alerts for different statistics when queue buildup occurs. To address issues causing this metric to increase, review the Errors metric to identify function errors and the Throttles metric to determine concurrency issues. |
| `AsyncEventsDropped`    | The number of events dropped without successfully executing the function. If you configure a dead-letter queue (DLQ) or OnFailure target, the event is sent there before being dropped. Events are dropped for various reasons. For example, the event may exceed the maximum event age or exhaust the maximum retry count, or reserved concurrency may be set to 0. To address issues causing this metric to increase, review the Errors metric to identify function errors and the Throttles metric to determine concurrency issues. |

## Objects {#object}

The collected AWS Lambda object data structure can be viewed in the 「Infrastructure - Custom」 section.

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
> Tip 1: The value of `tags.account_name` is the instance ID, used for unique identification.