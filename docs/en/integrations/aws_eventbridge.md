---
title: 'AWS EventBridge'
tags: 
  - AWS
summary: 'The displayed Metrics of AWS EventBridge include event delivery latency, throughput, event size, and scalability. These Metrics reflect the performance and reliability of EventBridge when handling large-scale event streams and real-time data delivery.'
__int_icon: 'icon/aws_eventbridge'
dashboard:

  - desc: 'AWS EventBridge Monitoring View'
    path: 'dashboard/en/aws_eventbridge'

monitor:
  - desc: 'AWS EventBridge Monitor'
    path: 'monitor/en/aws_eventbridge'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_eventbridge'
---


<!-- markdownlint-disable MD025 -->
# AWS EventBridge
<!-- markdownlint-enable -->

**AWS** **EventBridge** display Metrics include event delivery latency, throughput, event size, and scalability. These Metrics reflect the performance and reliability of **EventBridge** when handling large-scale event streams and real-time data delivery.


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data for AWS EventBridge cloud resources, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (AWS-EventBridge Collection)" (ID: `guance_aws_eventbridge`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

Then, in the collection script, change the regions in collector_configs and cloudwatch_configs to the actual regions.

In addition, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.

We default collect some configurations, for details, see the Metrics column [Custom Cloud Object Metrics Configuration](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding automatic trigger configuration exists for the corresponding task. You can also check the corresponding task records and logs to check for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon-CloudWatch, the default Measurement set is as follows. You can collect more Metrics through configuration [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/eventbridge/latest/userguide/eb-monitoring.html){:target="_blank"}

### Instance Metrics

The `AWS/Events` namespace includes the following instance Metrics.

| Metric                     | Description                                                         |
|:-----------------------| :----------------------------------------------------------- |
| `Invocations`          | The number of times rules invoke targets in response to events. This includes successful and failed invocations, but does not include throttling or retry attempts until they permanently fail. It does not include DeadLetterInvocations. Note: EventBridge only sends this metric to CloudWatch when it is not zero. Valid dimensions: RuleName. Unit: Count |
| `TriggeredRules`       | The number of rules that have run and matched any events. You will not see this metric until after rules have triggered CloudWatch. Valid dimensions: RuleName. Unit: Count|
## Objects {#object}

The collected AWS EventBridge object data structure can be seen in "Infrastructure - Custom"

```json
{
  "measurement": "aws_eventbridge",
  "tags": {
    "Arn":             "arn:aws-cn:events:cn-north-1:294654068288:rule/hn-test-lambda",
    "class":           "aws_eventbridge",
    "cloud_provider":  "aws",
    "EventBusName":    "default",
    "name":            "arn:aws-cn:events:cn-north-1:294654068288:rule/hn-test-lambda",
    "RegionId":        "cn-north-1",
    "RuleName":        "hn-test-lambda"
  }
}
```

> *Note: Fields in `tags` may vary with subsequent updates*

</translated_content>