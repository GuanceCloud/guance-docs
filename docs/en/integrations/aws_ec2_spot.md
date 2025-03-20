---
title: 'Amazon EC2 Spot'
tags: 
  - AWS
summary: ' Amazon EC2 Spot, including request capacity pools, target capacity pools, and abort capacity.'
__int_icon: 'icon/aws_ec2_spot'
dashboard:

  - desc: 'Amazon EC2 Spot built-in views'
    path: 'dashboard/en/aws_ec2_spot'

monitor:
  - desc: 'Amazon EC2 Spot'
    path: 'monitor/en/aws_ec2_spot'

---

<!-- markdownlint-disable MD025 -->
# Amazon EC2 Spot
<!-- markdownlint-enable -->


 Amazon EC2 Spot, including request capacity pools, target capacity pools, and abort capacity.


## Configuration {#config}

### Install Func

It is recommended to enable the <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func manually, refer to [Manual Deployment of Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data for Amazon EC2 Spot, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (AWS-EC2 Spot Collection)" (ID: `guance_aws_ec2_spot`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK and Amazon account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.



### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration. You can also check the corresponding task records and logs for any anomalies.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if there is any asset information.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there is any corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon EC2 Spot, the default metric set is as follows. You can collect more metrics through configuration. [Details of AWS Cloud Monitoring Metrics](https://docs.aws.amazon.com/en_us/AWSEC2/latest/UserGuide/spot-fleet-cloudwatch-metrics.html){:target="_blank"}



| Metric                                                         | Description                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| `AvailableInstancePoolsCount`                                        | The Spot capacity pools specified in the Spot fleet request |
| `BidsSubmittedForCapacity`                                        | Capacity for which Amazon EC2 has submitted Spot fleet requests |
| `EligibleInstancePoolCount`                                | The Spot capacity pools specified in the Spot fleet request that Amazon EC2 can fulfill |
| `FulfilledCapacity`                             | Capacity that Amazon EC2 has fulfilled      |
| `MaxPercentCapacityAllocation`                               | Maximum PercentCapacityAllocation across all Spot pools specified in the Spot fleet request |
| `PercentCapacityAllocation`                               | Capacity allocated to the Spot capacity pool for the specified dimension |
| `TargetCapacity`                           | Target capacity for the Spot fleet request                    |
| `TerminatingCapacity`                                 | Capacity terminating because the provisioned capacity exceeds the target capacity             |