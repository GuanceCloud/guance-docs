---
title: 'AWS EventBridge'
tags: 
  - AWS
summary: 'The displayed Metrics of AWS EventBridge include event delivery latency, throughput, event scale, and scalability. These Metrics reflect the performance and reliability of EventBridge in processing large-scale event streams and real-time data delivery.'
__int_icon: 'icon/aws_eventbridge'
dashboard:

  - desc: 'AWS EventBridge monitoring view'
    path: 'dashboard/en/aws_eventbridge'

monitor:
  - desc: 'AWS EventBridge monitor'
    path: 'monitor/en/aws_eventbridge'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_eventbridge'
---


<!-- markdownlint-disable MD025 -->
# AWS EventBridge
<!-- markdownlint-enable -->

**AWS** **EventBridge** display Metrics include event delivery latency, throughput, event scale, and scalability. These Metrics reflect the performance and reliability of **EventBridge** in processing large-scale event streams and real-time data delivery.


## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Please prepare a qualified Amazon AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data for AWS EventBridge cloud resources, we install the corresponding collection script: "Guance integration (AWS-EventBridge collection)" (ID: `guance_aws_eventbridge`)

After clicking 【Install】, enter the required parameters: Amazon AK and Amazon account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup scripts automatically.

Then, in the collection script, change the regions in `collector_configs` and `cloudwatch_configs` to the actual regions.

Additionally, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

We default collect some configurations, for details see the Metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configuration, and you can also check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, in "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, in "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default Mearsurement sets are as follows. You can collect more Metrics through configuration [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/eventbridge/latest/userguide/eb-monitoring.html){:target="_blank"}

### Instance Metrics

The `AWS/Events` namespace includes the following instance Metrics.

| Metric                     | Description                                                         |
|:-----------------------| :----------------------------------------------------------- |
| `Invocations`          | The number of times rules invoke targets in response to events. This includes successful and failed invocations but does not include throttled or retried attempts until they permanently fail. It does not include DeadLetterInvocations. Note: EventBridge only sends this metric to CloudWatch when it is not zero. Valid dimension: RuleName. Unit: Count |
| `TriggeredRules`       | The number of rules that have run and matched any events. You will not see this metric until after the rule has triggered in CloudWatch. Valid dimension: RuleName. Unit: Count|
## Objects {#object}

The collected AWS EventBridge object data structure can be seen from "Infrastructure - Custom".

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

> *Note: Fields in `tags` may change with subsequent updates.*