---
title: 'AWS ECS'
tags: 
  - AWS
summary: 'The Amazon ECS feature is integrated with the Amazon Cloud Technology Fargate serverless computing engine, using observation clouds to monitor the operational status of its services.'
__int_icon: 'icon/aws_ecs'
dashboard:
  - desc: 'AWS ECS'
    path: 'dashboard/en/aws_ecs'
monitor:
  - desc: 'No'
    path: '-'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/en/aws_ecs'
---

<!-- markdownlint-disable MD025 -->
# AWS ECS
<!-- markdownlint-enable -->

The Amazon ECS feature is integrated with the Amazon Cloud Technology `Fargate` serverless computing engine, using observation clouds to monitor the operational status of its services.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,[Refer to](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of ElastiCache Redis cloud resources, we install the corresponding collection script: `ID:guance_aws_ecs`

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」.Click[Run],you can immediately execute once, without waiting for a regular time.After a while,you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Configure AWS Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Amazon CloudWatch Metrics Details](https://docs.amazonaws.cn/AmazonECS/latest/developerguide/viewing_cloudwatch_metrics.html){:target="_blank"}

### Service Metrics

`AWS/ECS` 。

| Metrics                    | dimension                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `CPUUtilization`    | Service CPU utilization (metrics that are filtered by ClusterName and ServiceName) is measured as the total CPU units in use by the tasks that belong to the service, divided by the total number of CPU units that are reserved for the tasks that belong to the service. Service CPU utilization metrics are used for tasks using both the `Fargate` and the EC2 launch type. Unit: Percent.|
| `MemoryUtilization`       | Service memory utilization (metrics that are filtered by ClusterName and ServiceName) is measured as the total memory in use by the tasks that belong to the service, divided by the total memory that is reserved for the tasks that belong to the service. Service memory utilization metrics are used for tasks using both the `Fargate` and EC2 launch types.Unit: Percent. |


## Object {#object}

Collected AWS ElastiCache Redis object data structure, you can see the object data from the "Infrastructure - Customize"

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
    "message"            : "{}",
    "pendingTasksCount": 0,
    "registeredContainerInstancesCount": 0,
    "runningTasksCount": 1,
    "statistics": "[]"
  }
}
```

> *Note: Fields in `tags`, `fields` are subject to change with subsequent updates.*
