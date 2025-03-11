---
title: 'AWS Auto Scaling'
tags: 
  - AWS
summary: 'AWS Auto Scaling, including instance counts, capacity units, warm pools, etc.'
__int_icon: 'icon/aws_auto_scaling'
dashboard:

  - desc: 'Built-in views for AWS Auto Scaling'
    path: 'dashboard/en/aws_auto_scaling'

monitor:
  - desc: 'Monitors for AWS Auto Scaling'
    path: 'monitor/en/aws_auto_scaling'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_auto_scaling'
---

<!-- markdownlint-disable MD025 -->
# AWS Auto Scaling
<!-- markdownlint-enable -->

AWS Auto Scaling, including instance counts, capacity units, warm pools, etc.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data from AWS Auto Scaling, install the corresponding collection script: "Guance Integration (AWS-Auto Scaling Collection)" (ID: `guance_aws_auto_scaling`).

After clicking 【Install】, enter the required parameters: Amazon AK and Amazon account name.

Click 【Deploy Startup Script】. The system will automatically create a `Startup` script set and configure the startup scripts accordingly.

Additionally, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

### Verification

1. Confirm in 「Manage / Automatic Trigger Configuration」 whether the corresponding tasks have the automatic trigger configurations, and check the task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring AWS Auto Scaling, the default metric set is as follows. You can collect more metrics by configuring them. Refer to [AWS Cloud Monitoring Metrics Details](https://docs.aws.amazon.com/zh_cn/autoscaling/ec2/userguide/viewing-monitoring-graphs.html){:target="_blank"}

| Metric                                                        | Description                                                         |
| :------------------------------------------------------------ | :------------------------------------------------------------------ |
| `GroupMinSize`                                                | Minimum size of the Auto Scaling group                              |
| `GroupMaxSize`                                                | Maximum size of the Auto Scaling group                              |
| `GroupDesiredCapacity`                                        | Number of instances the Auto Scaling group attempts to maintain     |
| `GroupInServiceInstances`                                     | Number of instances running as part of the Auto Scaling group. This metric does not include instances in pending or terminating states |
| `GroupPendingInstances`                                       | Number of instances in the pending state. Pending instances are not yet available. This metric does not include instances in available or terminating states |
| `GroupStandbyInstances`                                       | Number of instances in the Standby state. Instances in this state are still running but cannot be effectively used |
| `GroupTerminatingInstances`                                   | Number of instances currently in the termination process. This metric does not include instances in available or pending states |
| `GroupTotalInstances`                                         | Total number of instances in the Auto Scaling group. This metric identifies instances in available, pending, and terminating states |
| `GroupTotalCapacity`                                          | Total number of capacity units in the Auto Scaling group            |
| `GroupPendingCapacity`                                        | Number of capacity units pending processing                         |
| `GroupStandbyCapacity`                                        | Number of capacity units in the Standby state                       |
| `GroupTerminatingCapacity`                                    | Number of capacity units currently in the termination process       |
| `WarmPoolMinSize`                                             | Minimum size of the warm pool                                       |
| `GroupAndWarmPoolDesiredCapacity`                             | Desired capacity combining the Auto Scaling group and warm pool     |
| `WarmPoolPendingCapacity`                                     | Number of capacities pending in the warm pool. This metric does not include instances in running, pending, or terminating states |
| `WarmPoolTerminatingCapacity`                                 | Number of capacities in the termination process in the warm pool. This metric does not include instances in running, stopped, or pending states |
| `WarmPoolWarmedCapacity`                                      | Number of capacities that can enter the Auto Scaling group during horizontal scaling. This metric does not include instances in pending or terminating states |
| `WarmPoolTotalCapacity`                                       | Total capacity of the warm pool, including instances in running, stopped, pending, or terminating states |
| `GroupAndWarmPoolDesiredCapacity`                             | Desired capacity combining the Auto Scaling group and warm pool     |
| `GroupAndWarmPoolTotalCapacity`                               | Total capacity combining the Auto Scaling group and warm pool. This includes instances in running, stopped, pending, terminating, or in-service states |
