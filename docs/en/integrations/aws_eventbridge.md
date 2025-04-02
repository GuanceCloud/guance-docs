---
title: 'AWS EventBridge'
tags: 
  - AWS
summary: 'The displayed Metrics for AWS EventBridge include event delivery latency, throughput, event scale, and scalability. These Metrics reflect the performance and reliability of EventBridge when handling large-scale event streams and real-time data delivery.'
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

**AWS** **EventBridge** Metrics include event delivery latency, throughput, event scale, and scalability. These Metrics reflect the performance and reliability of **EventBridge** when handling large-scale event streams and real-time data delivery.


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - managed Func: all prerequisites are automatically installed. Please continue with script installation.

If you deploy Func manually, refer to [Manual Deployment of Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)


#### Managed Version Activation Script

1. Log in to the <<< custom_key.brand_name >>> console.
2. Click on the 【Manage】 menu and select 【Cloud Account Management】.
3. Click 【Add Cloud Account】, choose 【AWS】, and fill in the required information on the interface. If you have already configured cloud account information, skip this step.
4. Click 【Test】, and after a successful test, click 【Save】. If the test fails, check whether the related configuration information is correct and retest.
5. In the 【Cloud Account Management】 list, you can see the added cloud accounts. Click on the corresponding cloud account to enter the details page.
6. Click the 【Integration】 button on the cloud account details page. Under the `Not Installed` list, find `AWS EventBridge`, click the 【Install】 button, and follow the prompts to complete the installation.

#### Manual Activation Script

1. Log in to the Func console, click 【Script Market】, go to the official script market, and search for `guance_aws_eventbridge`.

2. After clicking 【Install】, input the relevant parameters: AWS AK ID, AK Secret, and account name.

3. Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

4. After enabling, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding tasks have been configured with automatic triggers. You can also view the task records and logs to check for any abnormalities.
2. In <<< custom_key.brand_name >>>, under 「Infrastructure / Custom」, check if there is any asset information.
3. In <<< custom_key.brand_name >>>, under 「Metrics」, check if there are any corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default Metric sets are as follows. You can collect more Metrics through configuration. [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/en_us/eventbridge/latest/userguide/eb-monitoring.html){:target="_blank"}

### Instance Metrics

The `AWS/Events` namespace includes the following instance Metrics.

| Metric                     | Description                                                         |
|:-----------------------| :----------------------------------------------------------- |
| `Invocations`          | The number of times rules invoke targets in response to events. This includes both successful and failed invocations but does not include throttled or retried attempts until they permanently fail. It does not include DeadLetterInvocations. Note: EventBridge only sends this metric to CloudWatch when it is not zero. Valid dimension: RuleName. Unit: Count |
| `TriggeredRules`       | The number of rules that have run and matched any events. You will not see this metric until after the rule has triggered CloudWatch. Valid dimension: RuleName. Unit: Count |

## Objects {#object}

The collected AWS EventBridge object data structure can be viewed under 「Infrastructure - Custom」

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

> *Note: Fields in `tags` may change with subsequent updates*

</example>