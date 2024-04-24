---
title: 'AWS Lambda'
tags: 
  - AWS
summary: 'Use the " Official Script Market " series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'
__int_icon: 'icon/aws_lambda'
dashboard:

  - desc: 'AWS Lambda dashboard'
    path: 'dashboard/zh/aws_lambda'

monitor:
  - desc: 'AWS Lambda monitor'
    path: 'monitor/zh/aws_lambda'

---


<!-- markdownlint-disable MD025 -->
# AWS Lambda
<!-- markdownlint-enable -->

Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission for CloudWatch `CloudWatchReadOnlyAccess`）

To synchronize the monitoring data of AWS ELB cloud resources, we install the corresponding collection script：「Guance Integration（AWS-LambdaCollect）」(ID：`guance_aws_lambda`)

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

Then, in the collection script, add the collector_configs and cloudwatch_change the regions in configs to the actual regions

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure AWS Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/lambda/latest/dg/monitoring-metrics.html){:target="_blank"}

### Metric

The following section describes the types of Lambda metrics available on the CloudWatch console.

### Invocation metrics

| metric                                              | Description                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `Invocations`                           | The number of times that your function code is invoked, including successful invocations and invocations that result in a function error. Invocations aren't recorded if the invocation request is throttled or otherwise results in an invocation error. The value of Invocations equals the number of requests billed. |
| `Errors`                           | The number of invocations that result in a function error. Function errors include exceptions that your code throws and exceptions that the Lambda runtime throws. The runtime returns errors for issues such as timeouts and configuration errors. To calculate the error rate, divide the value of Errors by the value of Invocations. Note that the timestamp on an error metric reflects when the function was invoked, not when the error occurred. |
| `DeadLetterErrors`                           |  For asynchronous invocation, the number of times that Lambda attempts to send an event to a dead-letter queue (DLQ) but fails. Dead-letter errors can occur due to misconfigured resources or size limits. |
| `DestinationDeliveryFailures`                           | For asynchronous invocation and supported event source mappings, the number of times that Lambda attempts to send an event to a destination but fails. For event source mappings, Lambda supports destinations for stream sources (DynamoDB and Kinesis). Delivery errors can occur due to permissions errors, misconfigured resources, or size limits. Errors can also occur if the destination you have configured is an unsupported type such as an Amazon SQS FIFO queue or an Amazon SNS FIFO topic. |
| `Throttles`                           | The number of invocation requests that are throttled. When all function instances are processing requests and no concurrency is available to scale up, Lambda rejects additional requests with a TooManyRequestsException error. Throttled requests and other invocation errors don't count as either Invocations or Errors. |
| `ProvisionedConcurrencyInvocations`                           | The number of times that your function code is invoked using provisioned concurrency. |
| `ProvisionedConcurrencySpilloverInvocations`                           | The number of times that your function code is invoked using standard concurrency when all provisioned concurrency is in use. |
| `RecursiveInvocationsDropped`                           | The number of times that Lambda has stopped invocation of your function because it's detected that your function is part of an infinite recursive loop. Lambda recursive loop detection monitors how many times a function is invoked as part of a chain of requests by tracking metadata added by supported AWS SDKs. If your function is invoked as part of a chain of requests more than 16 times, Lambda drops the next invocation. |

### Performance metrics

Performance metrics provide performance details about a single function invocation. For example, the Duration metric indicates the amount of time in milliseconds that your function spends processing an event. To get a sense of how fast your function processes events, view these metrics with the Average or Max statistic.

| metric                                              | Description                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `Duration`                         | The amount of time that your function code spends processing an event. The billed duration for an invocation is the value of Duration rounded up to the nearest millisecond. |
| `PostRuntimeExtensionsDuration`    | The cumulative amount of time that the runtime spends running code for extensions after the function code has completed. |
| `IteratorAge`                    | For DynamoDB, Kinesis, and Amazon DocumentDB event sources, the age of the last record in the event. This metric measures the time between when a stream receives the record and when the event source mapping sends the event to the function. |
| `OffsetLag`                           | For self-managed Apache Kafka and Amazon Managed Streaming for Apache Kafka (Amazon MSK) event sources, the difference in offset between the last record written to a topic and the last record that your function's consumer group processed. Though a Kafka topic can have multiple partitions, this metric measures the offset lag at the topic level. |

### Concurrency metrics

Lambda reports concurrency metrics as an aggregate count of the number of instances processing events across a function, version, alias, or AWS Region. To see how close you are to hitting concurrency limits, view these metrics with the Max statistic.

| metric                                              | Description                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `ConcurrentExecutions`    | The number of function instances that are processing events. If this number reaches your concurrent executions quota for the Region, or the reserved concurrency limit on the function, then Lambda throttles additional invocation requests. |
| `ProvisionedConcurrentExecutions`    | The number of function instances that are processing events using provisioned concurrency. For each invocation of an alias or version with provisioned concurrency, Lambda emits the current count. |
| `ProvisionedConcurrencyUtilization`    |  For a version or alias, the value of ProvisionedConcurrentExecutions divided by the total amount of provisioned concurrency allocated. For example, .5 indicates that 50 percent of allocated provisioned concurrency is in use. |
| `UnreservedConcurrentExecutions`    | For a Region, the number of events that functions without reserved concurrency are processing. |

### Asynchronous invocation metrics

Asynchronous invocation metrics provide details about asynchronous invocations from event sources and direct invocations. You can set thresholds and alarms to notify you of certain changes. For example, when there's an undesired increase in the number of events queued for processing (AsyncEventsReceived). Or, when an event has been waiting a long time to be processed (AsyncEventAge).

| metric                                              | Description                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `AsyncEventsReceived`    | The number of events that Lambda successfully queues for processing. This metric provides insight into the number of events that a Lambda function receives. Monitor this metric and set alarms for thresholds to check for issues. For example, to detect an undesirable number of events sent to Lambda, and to quickly diagnose issues resulting from incorrect trigger or function configurations. Mismatches between AsyncEventsReceived and Invocations can indicate a disparity in processing, events being dropped, or a potential queue backlog. |
| `AsyncEventAge`    | The time between when Lambda successfully queues the event and when the function is invoked. The value of this metric increases when events are being retried due to invocation failures or throttling. Monitor this metric and set alarms for thresholds on different statistics for when a queue buildup occurs. To troubleshoot an increase in this metric, look at the Errors metric to identify function errors and the Throttles metric to identify concurrency issues. |
| `AsyncEventsDropped`    | The number of events that are dropped without successfully executing the function. If you configure a dead-letter queue (DLQ) or OnFailure destination, then events are sent there before they're dropped. Events are dropped for various reasons. For example, events can exceed the maximum event age or exhaust the maximum retry attempts, or reserved concurrency might be set to 0. To troubleshoot why events are dropped, look at the Errors metric to identify function errors and the Throttles metric to identify concurrency issues. |

## Object {#object}

The collected AWS Lambda object data structure can be seen from the [ Infrastructure - Custom]  object data

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

> *Note: The fields in 'tags' and' fields' may change with subsequent updates*
