---
title: 'AWS Simple Queue Service'
tags: 
  - AWS
summary: 'The displayed Metrics for AWS Simple Queue Service include the approximate Exist time of the oldest message not deleted in the queue, the number of delayed messages that cannot be read immediately, the number of messages in flight, the number of messages that can be retrieved from the queue, etc.'
__int_icon: 'icon/aws_sqs'
dashboard:

  - desc: 'Built-in View for AWS Simple Queue Service'
    path: 'dashboard/en/aws_sqs'

monitor:
  - desc: 'Monitor for AWS Simple Queue Service'
    path: 'monitor/en/aws_sqs'

---

<!-- markdownlint-disable MD025 -->
# AWS Simple Queue Service
<!-- markdownlint-enable -->


The displayed Metrics for AWS Simple Queue Service include the approximate Exist time of the oldest message not deleted in the queue, the number of delayed messages that cannot be read immediately, the number of messages in flight, the number of messages that can be retrieved from the queue, etc.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare an Amazon Cloud AK that meets the requirements in advance (for simplicity, you can directly grant CloudWatch read-only permission `CloudWatchReadOnlyAccess`).

To synchronize the monitoring data of AWS Simple Queue Service, we install the corresponding collection script: 「Guance Integration (AWS-Simple Queue Service Collection)」(ID: `guance_aws_sqs`)

After clicking 【Install】, enter the required parameters: AWS AK ID, AWS AK SECRET, account_name.

Click 【Deploy Startup Script】 and the system will automatically create a `Startup` script set and configure the corresponding startup scripts. Ensure that the 'regions' in the startup script match the actual regions where the instances are located.

Once enabled, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect logs, you should also enable the corresponding log collection script. If you need to collect billing data, enable the cloud billing collection script.


By default, we collect some configurations. For more details, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding task has an automatic trigger configuration and check the task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}

After configuring Amazon Cloud Monitoring, the default Mearsurement set is as follows. You can collect more Metrics through configuration:

[Amazon Cloud Monitoring AWS Simple Queue Service Metrics Details](https://docs.aws.amazon.com/zh_cn/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-available-cloudwatch-metrics.html){:target="_blank"}


| Metric Name | Description | Unit | Valid Statistics |
| :---: | :---: | :---: | :---: |
| `ApproximateAgeOfOldestMessage` | The approximate Exist time of the oldest message not deleted in the queue. **Note**: When a message is received three times (or more) and not processed, it moves to the back of the queue, and the ApproximateAgeOfOldestMessage metric indicates the second oldest message that has not been received more than three times. Even if the queue has a dead-letter queue policy, this operation occurs. Due to a single poison pill message (received multiple times but never deleted), this metric does not include the poison pill message's age until it is successfully processed. If the queue has a dead-letter queue policy, when the configured maximum receive count is reached, the message moves to the dead-letter queue. When a message moves to the dead-letter queue, the ApproximateAgeOfOldestMessage metric of the dead-letter queue indicates the time the message moved to the dead-letter queue (not the original send time). Reporting standard: reports non-negative values if the queue is active. | Seconds | Average, Minimum, Maximum, Sum, Data Samples (displayed as sample count in the Amazon SQS console) |
| `ApproximateNumberOfMessagesDelayed` | The number of delayed messages that cannot be read immediately. This happens if the queue is configured as a delay queue or the delay parameter is used to send messages. Reporting standard: reports non-negative values if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Samples (displayed as sample count in the Amazon SQS console) |
| `ApproximateNumberOfMessagesNotVisible` | The number of messages in flight. Messages are considered in flight if they have been sent to the client but not yet deleted or have not yet reached the end of their visibility window. Reporting standard: reports non-negative values if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Samples (displayed as sample count in the Amazon SQS console) |
| `ApproximateNumberOfMessagesVisible` | The number of messages that can be retrieved from the queue. Reporting standard: reports non-negative values if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Samples (displayed as sample count in the Amazon SQS console) |
| `NumberOfEmptyReceives` | The number of ReceiveMessage API calls that did not return any messages. Reporting standard: reports non-negative values if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Samples (displayed as sample count in the Amazon SQS console) |
| `NumberOfMessagesDeleted` | The number of messages deleted from the queue. Reporting standard: reports non-negative values if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Samples (displayed as sample count in the Amazon SQS console) |
| `NumberOfMessagesReceived` | The number of messages returned by calling the ReceiveMessage operation. Reporting standard: reports non-negative values if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Samples (displayed as sample count in the Amazon SQS console) |
| `NumberOfMessagesSent` | The number of messages added to the queue. Reporting standard: reports non-negative values if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Samples (displayed as sample count in the Amazon SQS console) |
| `SentMessageSize` | The size of messages added to the queue. Reporting standard: reports non-negative values if the queue is active. | Bytes | Average, Minimum, Maximum, Sum, Data Samples (displayed as sample count in the Amazon SQS console) |
