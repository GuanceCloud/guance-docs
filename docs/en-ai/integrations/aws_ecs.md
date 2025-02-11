---
title: 'AWS ECS'
tags: 
  - AWS
summary: 'Amazon ECS integrates with the Amazon Web Services Fargate serverless computing engine, and uses Guance to monitor its service runtime.'
__int_icon: 'icon/aws_ecs'
dashboard:
  - desc: 'AWS ECS'
    path: 'dashboard/en/aws_ecs'
monitor:
  - desc: 'No'
    path: '-'
---

<!-- markdownlint-disable MD025 -->
# AWS ECS
<!-- markdownlint-enable -->

Amazon ECS integrates with the Amazon Web Services `Fargate` serverless computing engine, and uses Guance to monitor its service runtime.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data of EC2 cloud resources, we install the corresponding collection script: 「Guance Integration (AWS-ECS Collection)」(ID: `guance_aws_ecs`)

After clicking 【Install】, enter the required parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Additionally, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations; for more details, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}

### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, in 「Infrastructure / Custom」, check if there is asset information.
3. On the Guance platform, in 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric sets are as follows. You can collect more metrics by configuring [Amazon CloudWatch Metrics Details](https://docs.amazonaws.cn/AmazonECS/latest/developerguide/viewing_cloudwatch_metrics.html){:target="_blank"}

### Instance Metrics

Metrics related to `AWS/ECS`.

| Metric                    | Description                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `CPUUtilization`    | The service CPU utilization rate (a metric filtered by ClusterName and ServiceName) is calculated by dividing the total number of CPU units used by tasks belonging to the service by the total number of CPU units reserved for tasks belonging to the service. This metric applies to tasks using `Fargate` and EC2 launch types. Unit: Percentage |
| `MemoryUtilization`       | The service memory utilization rate (a metric filtered by ClusterName and ServiceName) is calculated by dividing the total amount of memory used by tasks belonging to the service by the total amount of memory reserved for tasks belonging to the service. This metric applies to tasks using `Fargate` and EC2 launch types. Unit: Percentage |


## Objects {#object}

The structure of collected AWS ECS object data can be viewed in 「Infrastructure - Custom」

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
    "message"            : "{Instance JSON data}",
    "pendingTasksCount": 0,
    "registeredContainerInstancesCount": 0,
    "runningTasksCount": 1,
    "statistics": "[]"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates*