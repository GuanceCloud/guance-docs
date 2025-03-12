---
title: 'AWS EventBridge'
tags: 
  - AWS
summary: 'Use the「Guance   Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance .'
__int_icon: 'icon/aws_eventbridge'
dashboard:
  - desc: 'AWS EventBridge Monitoring View'
    path: 'dashboard/en/aws_eventbridge'
monitor:
  - desc: 'AWS EventBridge Monitor'
    path: 'monitor/en/aws_eventbridge'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/en/aws_eventbridge'
---


<!-- markdownlint-disable MD025 -->
# AWS EventBridge
<!-- markdownlint-enable -->

Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance .


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of AWS EventBridge cloud resources, we install the corresponding collection script: `ID:guance_awsguance_aws_eventbridge_gateway`


Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

Then, in the collection script, add the collector_configs and cloudwatch_change the regions in configs to the actual regions

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance  platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance  platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure AWS Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-monitoring.html){:target="_blank"}

### Metric

`AWS/ApiGateway` The namespace includes the following instance metrics 。

| Metric                 | Description                                                         |
|:-------------------| :----------------------------------------------------------- |
| `Invocations`      | The number of times a target is invoked by a rule in response to an event. This includes successful and failed invocations, but does not include throttled or retried attempts until they fail permanently. It does not include DeadLetterInvocations.Note:EventBridge only sends this metric to CloudWatch if it isn't zero.Valid Dimensions: RuleNameUnits: Count |
| `TriggeredRules`   | The number of rules that have run and matched with any event.You won't see this metric in CloudWatch until a rule is triggered.Valid Dimensions: RuleNameUnits: Count |

## Object {#object}

The collected AWS EventBridge object data structure, You can see the object data from「Infrastructure - Customization」


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

> *Note: The fields in 'tags' may change with subsequent updates*

