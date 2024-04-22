---
title: 'Amazon EC2 Spot'
tags: 
  - AWS
summary: 'Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance'
__int_icon: 'icon/aws_ec2_spot'
dashboard:

  - desc: 'Amazon EC2 Spot Monitoring View'
    path: 'dashboard/zh/aws_ec2_spot'

monitor:
  - desc: 'Amazon EC2 Spot Monitor'
    path: 'monitor/zh/aws_ec2_spot'

---

<!-- markdownlint-disable MD025 -->
# Amazon EC2 Spot
<!-- markdownlint-enable -->


Amazon EC2 Spot includes concepts such as request capacity pool, target capacity pool, and interrupted capacity.


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of Amazon EC2 Spot, we install the corresponding collection script：「Guance Integration（AWS-EC2 SpotCollect）」(ID：`guance_aws_ec2_spot`)

Click 【Install】 and enter the corresponding parameters: Aws AK, Aws account name.。

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Amazon EC2 Spot monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Aws Cloud Monitor Metrics Details](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-fleet-cloudwatch-metrics.html){:target="_blank"}



| Metric                                                         | Metric Description                                                     |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| `AvailableInstancePoolsCount`                                        | The Spot capacity pool specified in a Spot fleet request's queue |
| `BidsSubmittedForCapacity`                                        | The capacity for which Amazon EC2 has submitted a Spot fleet request |
| `EligibleInstancePoolCount`                                | The Spot capacity pool specified in a Spot fleet request that Amazon EC2 can fulfill |
| `FulfilledCapacity`                             | The capacity that Amazon EC2 has executed      |
| `MaxPercentCapacityAllocation`                               | The maximum value of PercentCapacityAllocation across all Spot instance pools specified in a Spot Fleet request for Spot instances |
| `PercentCapacityAllocation`                               | The capacity allocated for the specified dimension of Spot capacity pool |
| `TargetCapacity`                           | The target capacity of a Spot fleet request                    |
| `TerminatingCapacity`                                 | The capacity that is terminated due to the reserved capacity being greater than the target capacity |
