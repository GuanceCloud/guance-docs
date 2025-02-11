---
title: 'AWS EventBridge'
tags: 
  - AWS
summary: 'The metrics displayed for AWS EventBridge include event delivery latency, throughput, event scale, and scalability. These metrics reflect the performance and reliability of EventBridge in handling large-scale event streams and real-time data delivery.'
__int_icon: 'icon/aws_eventbridge'
dashboard:

  - desc: 'AWS EventBridge Monitoring View'
    path: 'dashboard/en/aws_eventbridge'

monitor:
  - desc: 'AWS EventBridge Monitor'
    path: 'monitor/en/aws_eventbridge'

---


<!-- markdownlint-disable MD025 -->
# AWS EventBridge
<!-- markdownlint-enable -->

The metrics displayed for **AWS** **EventBridge** include event delivery latency, throughput, event scale, and scalability. These metrics reflect the performance and reliability of **EventBridge** in handling large-scale event streams and real-time data delivery.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data from AWS EventBridge cloud resources, we install the corresponding collection script: "Guance Integration (AWS-EventBridge Collection)" (ID: `guance_aws_eventbridge`).

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup scripts.

Then, in the collection script, change the regions in `collector_configs` and `cloudwatch_configs` to the actual regions.

Additionally, in the "Management / Automatic Trigger Configuration," view the corresponding automatic trigger configuration. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

By default, we collect some configurations; for more details, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration," confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and you can also check the task records and logs for any abnormalities.
2. On the Guance platform, under "Infrastructure / Custom," check if there is asset information.
3. On the Guance platform, under "Metrics," check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. You can collect more metrics through configuration. [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/eventbridge/latest/userguide/eb-monitoring.html){:target="_blank"}

### Instance Metrics

The `AWS/Events` namespace includes the following instance metrics.

| Metric                     | Description                                                         |
|:-----------------------| :----------------------------------------------------------- |
| `Invocations`          | The number of times targets are invoked in response to events. This includes successful and failed invocations but does not include throttled or retried attempts until they permanently fail. It does not include DeadLetterInvocations. Note: EventBridge only sends this metric to CloudWatch when it is non-zero. Valid dimensions: RuleName. Unit: Count |
| `TriggeredRules`       | The number of rules that have run and matched any events. You will not see this metric before the rule triggers CloudWatch. Valid dimensions: RuleName. Unit: Count|

## Objects {#object}

The structure of the collected AWS EventBridge object data can be seen in "Infrastructure - Custom."

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