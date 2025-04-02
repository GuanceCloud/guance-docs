---
title: 'AWS ECS'
tags: 
  - AWS
summary: 'Amazon ECS features are integrated with Amazon Web Services Fargate serverless computing engine, using <<< custom_key.brand_name >>> to monitor the service runtime.'
__int_icon: 'icon/aws_ecs'
dashboard:
  - desc: 'AWS ECS'
    path: 'dashboard/en/aws_ecs'
monitor:
  - desc: 'No'
    path: '-'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_ecs'
---

<!-- markdownlint-disable MD025 -->
# AWS ECS
<!-- markdownlint-enable -->

Amazon ECS features are integrated with Amazon Web Services `Fargate` serverless computing engine, using <<< custom_key.brand_name >>> to monitor the service runtime.

## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - managed Func: all prerequisites will be automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}


### Enable Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

#### Managed Version Enable Script

1. Log in to <<< custom_key.brand_name >>> Console.
2. Click on the 【Manage】 menu and select 【Cloud Account Management】.
3. Click 【Add Cloud Account】, choose 【AWS】, and fill in the required information on the interface. If the cloud account information has already been configured, skip this step.
4. Click 【Test】. After a successful test, click 【Save】. If the test fails, check whether the related configuration information is correct and retest.
5. In the 【Cloud Account Management】 list, you can see the added cloud accounts. Click on the corresponding cloud account to enter the details page.
6. Click the 【Integration】 button on the cloud account details page. Under the `Not Installed` list, find `AWS ECS`, click the 【Install】 button, and follow the installation interface to complete the installation.


#### Manual Enable Script

1. Log in to the Func Console, click 【Script Market】, enter the official script market, and search for `guance_aws_ecs`.
2. After clicking 【Install】, input the corresponding parameters: AWS AK ID, AK Secret, and account name.
3. Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.
4. After enabling, you can see the corresponding automatic trigger configuration under 「Management / Automatic Trigger Configuration」. Click 【Execute】 to immediately execute once without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.


### Verification

1. Confirm in 「Management / Automatic Trigger Configuration」 whether the corresponding task has the corresponding automatic trigger configuration. You can also check the corresponding task records and logs for any anomalies.
2. In <<< custom_key.brand_name >>>, 「Infrastructure / Custom」, check if there is asset information.
3. In <<< custom_key.brand_name >>>, 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. More metrics can be collected through configuration. [Amazon CloudWatch Metric Details](https://docs.amazonaws.cn/AmazonECS/latest/developerguide/viewing_cloudwatch_metrics.html){:target="_blank"}

### Instance Metrics

`AWS/ECS` related metrics.

| Metric                    | Description                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `CPUUtilization`    | Service CPU utilization (a metric filtered by ClusterName and ServiceName) is calculated by dividing the total number of CPU units used by tasks belonging to the service by the total number of CPU units reserved for tasks belonging to the service. The service CPU utilization metric applies to tasks using `Fargate` and EC2 launch types. Unit: Percentage |
| `MemoryUtilization`       | Service memory utilization (a metric filtered by ClusterName and ServiceName) is calculated by dividing the total amount of memory used by tasks belonging to the service by the total amount of memory reserved for tasks belonging to the service. The service memory utilization metric applies to tasks using `Fargate` and EC2 launch types. Unit: Percentage |


## Objects {#object}

The collected AWS ECS object data structure can be viewed from 「Infrastructure - Custom」.

```json
{
  "measurement": "aws_ecs",
  "tags": {
      "RegionId": "cn-northwest-1",
      "clusterArn": "arn:aws-cn:***",
      "clusterName": "Harry_NodeJs",
      "name": "Harry_NodeJs",
      "status": "ACTIVE"
  },
  "fields": {
    "activeServicesCount": 1,
    "configuration": "{}",
    "message"            : "{Instance JSON Data}",
    "pendingTasksCount": 0,
    "registeredContainerInstancesCount": 0,
    "runningTasksCount": 1,
    "statistics": "[]"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*