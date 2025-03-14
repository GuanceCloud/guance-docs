---
title: 'AWS Simple Queue Service'
tags: 
  - AWS
summary: 'AWS Simple Queue Service displaed metrics include the approximate age of the oldest non-deleted message in the queue, the number of messages in the queue that are delayed and not available for reading immediately, the number of messages that are in flight, the number of messages to be processed, and so on.'
__int_icon: 'icon/aws_sqs'
dashboard:
  - desc: 'AWS Simple Queue Service dashboard'
    path: 'dashboard/en/aws_sqs'
monitor:
  - desc: 'AWS Simple Queue Service monitor'
    path: 'monitor/en/aws_sqs'

---

<!-- markdownlint-disable MD025 -->
# AWS Simple Queue Service
<!-- markdownlint-enable -->


AWS Simple Queue Service displaced metrics include the approximate age of the oldest non-deleted message in the queue, the number of messages in the queue that are delayed and not available for reading immediately, the number of messages that are in flight, the number of messages to be processed, and so on.


## Config {#config}

### Install Func

Recommend opening [ Integrations - Extension - DataFlux Func (Automata) ]: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip: Please prepare AWS AK that meets the requirements in advance (For simplicity's sake, you can directly grant the global read-only permission for CloudWatch `CloudWatchReadOnlyAccess`)

To synchronize the monitoring data of AWS Simple Queue Service cloud resources, we install the corresponding collection script: `ID:guance_aws_sqs`

Click [Install] and enter the corresponding parameters: Alibaba Cloud AK ID, Alibaba Cloud AK SECRET and Account Name.

Tap [Deploy startup Script],The system automatically creates `Startup` script sets,And automatically configure the corresponding startup script.

Then, in the collection script, add the collector_configs and cloudwatch_change the regions in configs to the actual regions

After this function is enabled, you can view the automatic triggering configuration in [Management / Crontab Config]. Click[Run],you can immediately execute once, without waiting for a regular time. After a while, you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

After configure AWS Simple Queue Service monitoring, the default metric set is as follows. You can collect more metrics by configuring them:

[Available CloudWatch metrics for Amazon SQS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-available-cloudwatch-metrics.html){:target="_blank"}


| Metric  | Description | Units | Valid Statistics |
| :---: | :---: | :---: | :---: |
| `ApproximateAgeOfOldestMessage` | The approximate age of the oldest non-deleted message in the queue. Note: After a message is received three times (or more) and not processed, the message is moved to the back of the queue and the ApproximateAgeOfOldestMessage metric points at the second-oldest message that hasn't been received more than three times. This action occurs even if the queue has a redrive policy. Because a single poison-pill message (received multiple times but never deleted) can distort this metric, the age of a poison-pill message isn't included in the metric until the poison-pill message is consumed successfully. When the queue has a redrive policy, the message is moved to a dead-letter queue after the configured maximum number of receives. When the message is moved to the dead-letter queue, the ApproximateAgeOfOldestMessage metric of the dead-letter queue represents the time when the message was moved to the dead-letter queue (not the original time the message was sent). For FIFO queues, the message is not moved to the back of the queue because this will break the FIFO order guarantee. The message will instead go to the DLQ if there is one configured. Otherwise it will block the message group until successfully deleted or until it expires. Reporting Criteria: A non-negative value is reported if the queue is active. | Seconds | Average, Minimum, Maximum, Sum, Data Samples (displays as Sample Count in the Amazon SQS console) |
| `ApproximateNumberOfMessagesDelayed` | The number of messages in the queue that are delayed and not available for reading immediately. This can happen when the queue is configured as a delay queue or when a message has been sent with a delay parameter.Reporting Criteria: A non-negative value is reported if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Samples (displays as Sample Count in the Amazon SQS console)  |
| `ApproximateNumberOfMessagesNotVisible` | The number of messages that are in flight. Messages are considered to be in flight if they have been sent to a client but have not yet been deleted or have not yet reached the end of their visibility window. Reporting Criteria: A non-negative value is reported if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Samples (displays as Sample Count in the Amazon SQS console) |
| `ApproximateNumberOfMessagesVisible` | The number of messages to be processed. Reporting Criteria: A non-negative value is reported if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Samples (displays as Sample Count in the Amazon SQS console) |
| `NumberOfEmptyReceives`| The number of ReceiveMessage API calls that did not return a message. Reporting Criteria: A non-negative value is reported if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Samples (displays as Sample Count in the Amazon SQS console)  |
| `NumberOfMessagesDeleted` |The number of messages deleted from the queue. Reporting Criteria: A non-negative value is reported if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Samples (displays as Sample Count in the Amazon SQS console) |
| `NumberOfMessagesReceived`|  The number of messages returned by calls to the ReceiveMessage action.Reporting Criteria: A non-negative value is reported if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Samples (displays as Sample Count in the Amazon SQS console) |
| `NumberOfMessagesSent`| The number of messages added to a queue. Reporting Criteria: A non-negative value is reported if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Samples (displays as Sample Count in the Amazon SQS console) |
| `SentMessageSize` | The size of messages added to a queue. Reporting Criteria: A non-negative value is reported if the queue is active. | Bytes | Average, Minimum, Maximum, Sum, Data Samples (displays as Sample Count in the Amazon SQS console) |
