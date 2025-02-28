---
title: 'AWS Auto Scaling'
tags: 
  - AWS
summary: 'Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance'
__int_icon: 'icon/aws_auto_scaling'
dashboard:

  - desc: 'AWS Auto Scaling Monitoring View'
    path: 'dashboard/en/aws_auto_scaling'

monitor:
  - desc: 'AWS Auto Scaling Monitor'
    path: 'monitor/en/aws_auto_scaling'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/en/aws_auto_scaling'
---

<!-- markdownlint-disable MD025 -->
# AWS Auto Scaling
<!-- markdownlint-enable -->


AWS Auto Scaling includes metrics such as connection count, request count, latency, and slow queries for automatic scaling.


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of AWS Auto Scaling, we install the corresponding collection script：「Guance Integration（AWS-Auto ScalingCollect）」(ID：`guance_aws_auto_scaling`)

Click 【Install】 and enter the corresponding parameters: Aws AK, Aws account name.。

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure AWS Auto Scaling monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Aws Cloud Monitor Metrics Details](https://docs.aws.amazon.com/autoscaling/ec2/userguide/viewing-monitoring-graphs.html){:target="_blank"}



| Metric                                                         | Metric Description                                                     |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| `GroupMinSize`                                        | The minimum size of the auto scaling group |
| `GroupMaxSize`                                        | The maximum size of the auto scaling group |
| `GroupDesiredCapacity`                                          | The number of instances that the Auto Scaling group attempts to maintain |
| `GroupInServiceInstances`                                              | The number of instances running as part of the Auto Scaling group. This metric does not include instances in a suspended or terminated state      |
| `GroupPendingInstances`                                        | The number of instances in a suspended state. Suspended instances are not yet available. This metric does not include instances in an available or terminated state |
| `GroupStandbyInstances`                                   | The number of instances in Standby state. Instances in this state are still running but cannot be effectively used |
| `GroupTerminatingInstances`                                       | The number of instances currently in the termination process. This metric does not include instances in an available or suspended state                    |
| `GroupTotalInstances`                                  | The total number of instances in the Auto Scaling group. This metric is used to identify the count of instances in available, suspended, and terminated states             |
| `GroupTotalCapacity`                                          | The total capacity units in the Auto Scaling group                     |
| `GroupPendingCapacity`                                                      | The number of pending capacity units |
| `GroupStandbyCapacity`                                        | The number of capacity units in Standby state |
| `GroupTerminatingCapacity`                                             | The number of capacity units currently in the termination process |
| `GroupTotalCapacity`                                           | The total number of capacity units in the Auto Scaling group |
| `WarmPoolMinSize`                                     | The minimum size of the warm pool |
| `GroupAndWarmPoolDesiredCapacity`                                                 | The combined desired capacity of the Auto Scaling group and the warm pool |
| `WarmPoolPendingCapacity`                                          | The number of pending capacity units in the warm pool. This metric does not include instances in running, suspended, or terminated states |
| `WarmPoolTerminatingCapacity`                                  | The number of capacity units in the warm pool that are currently in the termination process. This metric does not include instances in running, stopped, or suspended states |
| `WarmPoolWarmedCapacity`                                     | The number of capacity units that can enter the Auto Scaling group during horizontal scaling. This metric does not include instances in a suspended or terminated state |
| `WarmPoolTotalCapacity`                                   | The total capacity of the warm pool, including instances in running, stopped, suspended, or terminated states |
| `GroupAndWarmPoolDesiredCapacity`                                    | The combined desired capacity of the Auto Scaling group and the warm pool |
| `GroupAndWarmPoolTotalCapacity`                           | The total combined capacity of the Auto Scaling group and the warm pool. This includes instances in running, stopped, suspended, terminated, or in-service states |
