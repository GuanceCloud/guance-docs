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
  - desc: 'AWS Auto Scaling monitors'
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

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - hosted Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

#### Hosted Subscription Script

1. Log in to the <<< custom_key.brand_name >>> console.
2. Click on the 【Manage】 menu and select 【Cloud Account Management】.
3. Click 【Add Cloud Account】, select 【AWS】, and fill in the required information on the interface. If cloud account information has been configured before, skip this step.
4. Click 【Test】. After a successful test, click 【Save】. If the test fails, check whether the related configuration information is correct and retest.
5. In the 【Cloud Account Management】 list, you can see the added cloud accounts. Click on the corresponding cloud account and go to the details page.
6. Click the 【Integration】 button on the cloud account details page. In the `Not Installed` list, find `AWS Auto Scaling`, click the 【Install】 button, and follow the prompts to complete the installation.


#### Manual Subscription Script

1. Log in to the Func console, click 【Script Market】, enter the official script market, and search for:`guance_aws_auto_scaling`

2. After clicking 【Install】, input the corresponding parameters: AWS AK ID, AK Secret, and account name.

3. Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script automatically.

4. After enabling, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.



### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding task has an automatic trigger configuration. You can also view the corresponding task records and logs to check for any abnormalities.
2. In <<< custom_key.brand_name >>>, under 「Infrastructure / Custom」, check if there is asset information.
3. In <<< custom_key.brand_name >>>, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring AWS Auto Scaling, the default metric set is as follows. You can collect more metrics through configuration. [Details of AWS Cloud Monitoring Metrics](https://docs.aws.amazon.com/zh_cn/autoscaling/ec2/userguide/viewing-monitoring-graphs.html){:target="_blank"}



| Metric                                                        | Description                                                         |
| :------------------------------------------------------------ | :------------------------------------------------------------------ |
| `GroupMinSize`                                           | Minimum size of the Auto Scaling group |
| `GroupMaxSize`                                           | Maximum size of the Auto Scaling group |
| `GroupDesiredCapacity`                                         | Number of instances that the Auto Scaling group attempts to maintain |
| `GroupInServiceInstances`                                     | Number of instances running as part of the Auto Scaling group. This metric does not include instances in pending or terminating states |
| `GroupPendingInstances`                                       | Number of instances in the pending state. Pending instances are not yet available. This metric does not include instances in available or terminated states |
| `GroupStandbyInstances`                                  | Number of instances in Standby state. Instances in this state are still running but cannot be effectively used |
| `GroupTerminatingInstances`                                   | Number of instances currently in the termination process. This metric does not include instances in available or pending states |
| `GroupTotalInstances`                                    | Total number of instances in the Auto Scaling group. This metric identifies instances in available, pending, and terminating states |
| `GroupTotalCapacity`                                        | Total number of capacity units in the Auto Scaling group |
| `GroupPendingCapacity`                                              | Number of capacity units pending processing |
| `GroupStandbyCapacity`                                      | Number of capacity units in Standby state |
| `GroupTerminatingCapacity`                                          | Number of capacity units currently in the termination process |
| `GroupTotalCapacity`                                        | Total number of capacity units in the Auto Scaling group |
| `WarmPoolMinSize`                                     | Minimum size of the warm pool |
| `GroupAndWarmPoolDesiredCapacity`                                               | Desired capacity combining the Auto Scaling group and the warm pool |
| `WarmPoolPendingCapacity`                                          | Number of capacities pending in the warm pool. This metric does not include instances in running, pending, or terminating states |
| `WarmPoolTerminatingCapacity`                                  | Number of capacities in the termination process in the warm pool. This metric does not include instances in running, stopped, or pending states |
| `WarmPoolWarmedCapacity`                                     | Number of capacities that can enter the Auto Scaling group during horizontal scaling. This metric does not include instances in pending or terminating states |
| `WarmPoolTotalCapacity`                                   | Total capacity of the warm pool, including instances in running, stopped, pending, or terminating states |
| `GroupAndWarmPoolDesiredCapacity`                                    | Desired capacity combining the Auto Scaling group and the warm pool |
| `GroupAndWarmPoolTotalCapacity`                           | Total capacity combining the Auto Scaling group and the warm pool. This includes instances in running, stopped, pending, terminating, or in-service states |