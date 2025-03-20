---
title: 'AWS Simple Queue Service'
tags: 
  - AWS
summary: 'The displayed metrics of AWS Simple Queue Service include the approximate Exist time of the oldest un-deleted message in the queue, the number of delayed messages that cannot be read immediately, the number of messages in flight state, the number of messages that can be retrieved from the queue, etc.'
__int_icon: 'icon/aws_sqs'
dashboard:

  - desc: 'Built-in views of AWS Simple Queue Service'
    path: 'dashboard/en/aws_sqs'

monitor:
  - desc: 'Monitor for AWS Simple Queue Service'
    path: 'monitor/en/aws_sqs'

---

<!-- markdownlint-disable MD025 -->
# AWS Simple Queue Service
<!-- markdownlint-enable -->


The displayed metrics of AWS Simple Queue Service include the approximate Exist time of the oldest un-deleted message in the queue, the number of delayed messages that cannot be read immediately, the number of messages in flight state, the number of messages that can be retrieved from the queue, etc.


## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare the required Amazon cloud AK in advance (for simplicity, you can directly grant CloudWatch read-only permission `CloudWatchReadOnlyAccess`).

To synchronize the monitoring data of AWS Simple Queue Service, we install the corresponding collection script: 「Guance Integration (AWS-Simple Queue Service Collection)」(ID: `guance_aws_sqs`)

After clicking 【Install】, input the corresponding parameters: AWS AK ID, AWS AK SECRET, account_name.

Click 【Deploy Start Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding start script. In the start script, make sure that 'regions' matches the actual regions where the instances are located.

After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

> If you need to collect the corresponding logs, you also need to enable the corresponding log collection script. If you need to collect billing information, you need to enable the cloud billing collection script.


We default to collecting some configurations, for details, see the metric column [Customize Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs to see if there are any abnormalities.
2. On the Guance platform, in 「Infrastructure / Custom」, check if there is asset information.
3. On the Guance platform, in 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}

After configuring Amazon CloudWatch, the default Measurement set is as follows. You can collect more metrics through configuration:

[Amazon CloudWatch AWS Simple Queue Service Metric Details](https://docs.aws.amazon.com/en_us/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-available-cloudwatch-metrics.html){:target="_blank"}


| Metric Name | Description | Unit | Valid Statistics |
| :---: | :---: | :---: | :---: |
| `ApproximateAgeOfOldestMessage` | The approximate Exist time of the oldest un-deleted message in the queue. **Note**: When a message is received three times (or more) and not processed, it will move to the back of the queue, and the ApproximateAgeOfOldestMessage metric will indicate the second oldest message that has not been received more than three times. This happens even if the queue has a re-drive policy. Since a single poison pill message (received multiple times but never deleted) can distort this metric, the expiration date of the poison pill message will not be included in the metric until the poison pill message is successfully used. If the queue has a re-drive policy, when the configured maximum receive count is reached, the message will move to the dead-letter queue. When the message moves to the dead-letter queue, the ApproximateAgeOfOldestMessage metric for the dead-letter queue indicates the time the message moved to the dead-letter queue (not the original send time of the message). Reporting standard: reports non-negative values if the queue is active. | Seconds | Average, Minimum, Maximum, Sum, Data Sample (displayed as sample count in the Amazon SQS console) |
| `ApproximateNumberOfMessagesDelayed` | The number of delayed messages in the queue that cannot be read immediately. This occurs if the queue is configured as a delay queue or if the delay parameter was used to send the message. Reporting standard: reports non-negative values if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Sample (displayed as sample count in the Amazon SQS console) |
| `ApproximateNumberOfMessagesNotVisible` | The number of messages in flight state. Messages are considered in flight if they have been sent to a client but not yet deleted or have not yet reached the end of their visibility window. Reporting standard: reports non-negative values if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Sample (displayed as sample count in the Amazon SQS console) |
| `ApproximateNumberOfMessagesVisible` | The number of messages that can be retrieved from the queue. Reporting standard: reports non-negative values if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Sample (displayed as sample count in the Amazon SQS console) |
| `NumberOfEmptyReceives` | The number of ReceiveMessage API calls that did Not return a message. Reporting standard: reports non-negative values if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Sample (displayed as sample count in the Amazon SQS console) |
| `NumberOfMessagesDeleted` | The number of messages deleted from the queue. Reporting standard: reports non-negative values if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Sample (displayed as sample count in the Amazon SQS console) |
| `NumberOfMessagesReceived` | The number of messages returned by calling the ReceiveMessage operation. Reporting standard: reports non-negative values if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Sample (displayed as sample count in the Amazon SQS console) |
| `NumberOfMessagesSent` | The number of messages added to the queue. Reporting standard: reports non-negative values if the queue is active. | Count | Average, Minimum, Maximum, Sum, Data Sample (displayed as sample count in the Amazon SQS console) |
| `SentMessageSize` | The size of messages added to the queue. Reporting standard: reports non-negative values if the queue is active. | Bytes | Average, Minimum, Maximum, Sum, Data Sample (displayed as sample count in the Amazon SQS console) |