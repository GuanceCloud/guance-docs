---
title: 'AWS Auto Scaling'
tags: 
  - AWS
summary: 'AWS Auto Scaling, including the number of instances, capacity units, warm pools, etc.'
__int_icon: 'icon/aws_auto_scaling'
dashboard:

  - desc: 'Built-in views for AWS Auto Scaling'
    path: 'dashboard/en/aws_auto_scaling'

monitor:
  - desc: 'AWS Auto Scaling monitor'
    path: 'monitor/en/aws_auto_scaling'

cloudCollector:
  desc: 'Cloud collector'
  path: 'cloud-collector/en/aws_auto_scaling'
---

<!-- markdownlint-disable MD025 -->
# AWS Auto Scaling
<!-- markdownlint-enable -->


 AWS Auto Scaling, including the number of instances, capacity units, warm pools, etc.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize AWS Auto Scaling monitoring data, we install the corresponding collection script: "Guance Integration (AWS-Auto Scaling Collection)" (ID: `guance_aws_auto_scaling`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK and Amazon account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute it without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.



### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and at the same time, you can view the corresponding task records and log checks for any abnormalities.
2. On the Guance platform, in "Infrastructure / Custom", check if there is any asset information.
3. On the Guance platform, in "Metrics", check if there are any corresponding monitoring data.

## Metrics {#metric}
After configuring AWS Auto Scaling, the default metric sets are as follows. You can collect more metrics through configuration [Details of AWS Cloud Monitoring Metrics](https://docs.aws.amazon.com/zh_cn/autoscaling/ec2/userguide/viewing-monitoring-graphs.html){:target="_blank"}



| Metric                                                        | Description                                                         |
| :------------------------------------------------------------ | :------------------------------------------------------------------ |
| `GroupMinSize`                                        | Minimum size of the Auto Scaling group |
| `GroupMaxSize`                                        | Maximum size of the Auto Scaling group |
| `GroupDesiredCapacity`                                          | Number of instances that the Auto Scaling group attempts to maintain |
| `GroupInServiceInstances`                                              | Number of instances running as part of the Auto Scaling group. This metric does not include instances in pending or terminating states      |
| `GroupPendingInstances`                                        | Number of instances in pending state. Pending instances are not yet available. This metric does not include instances in available or terminated states |
| `GroupStandbyInstances`                                   | Number of instances in Standby state. Instances in this state are still running but cannot be effectively used |
| `GroupTerminatingInstances`                                       | Number of instances currently in the termination process. This metric does not include instances in available or pending states                    |
| `GroupTotalInstances`                                  | Total number of instances in the Auto Scaling group. This metric identifies the number of instances in available, pending, and terminating states             |
| `GroupTotalCapacity`                                          | Total number of capacity units in the Auto Scaling group                     |
| `GroupPendingCapacity`                                                      | Number of capacity units pending processing |
| `GroupStandbyCapacity`                                        | Number of capacity units in Standby state |
| `GroupTerminatingCapacity`                                             | Number of capacity units currently in the termination process |
| `GroupTotalCapacity`                                           | Total number of capacity units in the Auto Scaling group |
| `WarmPoolMinSize`                                     | Minimum size of the warm pool |
| `GroupAndWarmPoolDesiredCapacity`                                                 | Combined desired capacity of the Auto Scaling group and warm pool |
| `WarmPoolPendingCapacity`                                          | Number of capacities pending in the warm pool. This metric does not include instances in running, pending, or terminating states |
| `WarmPoolTerminatingCapacity`                                  | Number of capacities in the termination process in the warm pool. This metric does not include instances in running, stopped, or pending states |
| `WarmPoolWarmedCapacity`                                     | Number of capacities that can enter the Auto Scaling group during horizontal scaling. This metric does not include instances in pending or terminating states |
| `WarmPoolTotalCapacity`                                   | Total capacity of the warm pool, including instances in running, stopped, pending, or terminating states |
| `GroupAndWarmPoolDesiredCapacity`                                    | Combined desired capacity of the Auto Scaling group and warm pool |
| `GroupAndWarmPoolTotalCapacity`                           | Combined total capacity of the Auto Scaling group and warm pool. This includes instances in running, stopped, pending, terminating, or in-service states |