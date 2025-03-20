---
title: 'AWS ECS'
tags: 
  - AWS
summary: 'Amazon ECS features integrated with Amazon Web Services Fargate serverless compute engine, using Guance to monitor its service runtime.'
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

Amazon ECS features integrated with Amazon Web Services `Fargate` serverless compute engine, using Guance to monitor its service runtime.

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - hosted Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-hosted Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize EC2 cloud resource monitoring data, we install the corresponding collection script: 「Guance Integration (AWS-ECS Collection)」(ID: `guance_aws_ecs`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

We collect some configurations by default. For details, see the Metrics section [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, in 「Infrastructure / Custom」, check if there is asset information.
3. On the Guance platform, in 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. You can collect more metrics through configuration. [Amazon CloudWatch Metrics Details](https://docs.amazonaws.cn/AmazonECS/latest/developerguide/viewing_cloudwatch_metrics.html){:target="_blank"}

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