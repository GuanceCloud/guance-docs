---
title: 'Amazon EC2 Spot'
tags: 
  - AWS
summary: 'Amazon EC2 Spot, including request capacity pools, target capacity pools, and aborted capacities.'
__int_icon: 'icon/aws_ec2_spot'
dashboard:

  - desc: 'Built-in views for Amazon EC2 Spot'
    path: 'dashboard/en/aws_ec2_spot'

monitor:
  - desc: 'Amazon EC2 Spot'
    path: 'monitor/en/aws_ec2_spot'

---

<!-- markdownlint-disable MD025 -->
# Amazon EC2 Spot
<!-- markdownlint-enable -->


Amazon EC2 Spot, including request capacity pools, target capacity pools, and aborted capacities.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data for Amazon EC2 Spot, install the corresponding collection script: 「Guance Integration (AWS-EC2 Spot Collection)」(ID: `guance_aws_ec2_spot`)

After clicking 【Install】, enter the required parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Additionally, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.


### Verification

1. In 「Management / Automatic Trigger Configuration」confirm whether the corresponding task has the appropriate automatic trigger configuration. You can also check the task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」check if asset information exists.
3. On the Guance platform, under 「Metrics」check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon EC2 Spot, the default metric set is as follows. More metrics can be collected through configuration [AWS Cloud Monitoring Metric Details](https://docs.aws.amazon.com/zh_cn/AWSEC2/latest/UserGuide/spot-fleet-cloudwatch-metrics.html){:target="_blank"}


| Metric                                                         | Description                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| `AvailableInstancePoolsCount`                                        | The specified Spot capacity pools in the Spot fleet request |
| `BidsSubmittedForCapacity`                                        | Capacity for which Amazon EC2 has submitted Spot fleet requests |
| `EligibleInstancePoolCount`                                | The specified Spot capacity pools in the Spot fleet request that Amazon EC2 can fulfill. |
| `FulfilledCapacity`                             | Capacity that Amazon EC2 has fulfilled      |
| `MaxPercentCapacityAllocation`                               | The maximum PercentCapacityAllocation across all Spot instance pools in the Spot fleet request |
| `PercentCapacityAllocation`                               | Capacity allocated to the specified Spot capacity pool |
| `TargetCapacity`                           | Target capacity for the Spot fleet request                    |
| `TerminatingCapacity`                                 | Capacity terminated because the provisioned capacity exceeds the target capacity             |

</input_content>
</input>
</input>