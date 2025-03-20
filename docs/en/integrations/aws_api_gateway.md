---
title: 'AWS API Gateway'
tags: 
  - AWS
summary: 'The displayed Metrics for AWS API Gateway include request response time, throughput, concurrent connections, and error rate. These Metrics reflect the performance and reliability of API Gateway when handling API requests and traffic management.'
__int_icon: 'icon/aws_api_gateway'
dashboard:

  - desc: 'AWS API Gateway monitoring view'
    path: 'dashboard/en/aws_api_gateway'

monitor:
  - desc: 'AWS API Gateway monitor'
    path: 'monitor/en/aws_api_gateway'

cloudCollector:
  desc: 'Cloud collector'
  path: 'cloud-collector/en/aws_api_gateway'
---


<!-- markdownlint-disable MD025 -->
# AWS API Gateway
<!-- markdownlint-enable -->

The displayed Metrics for AWS API Gateway include request response time, throughput, concurrent connections, and error rate. These Metrics reflect the performance and reliability of API Gateway when handling API requests and traffic management.


## Configuration {#config}

### Install Func

It is recommended to activate the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data of AWS API Gateway cloud resources, we install the corresponding collection script: "Guance Integration (AWS-Gateway Collection)" (ID: `guance_aws_gateway`)

After clicking 【Install】, input the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

Then, in the collection script, change the regions in collector_configs and cloudwatch_configs to the actual regions.

In addition, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a while, you can check the execution task records and corresponding logs.

We default to collecting some configurations; for more details, see the Metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-gateway/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding automatic trigger configuration exists for the task, and at the same time, you can check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon-CloudWatch, the default Measurement set is as follows. You can collect more Metrics through configuration [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/apigateway/latest/developerguide/api-gateway-metrics-and-dimensions.html){:target="_blank"}

### Instance Metrics

The `AWS/ApiGateway` namespace includes the following instance Metrics.

| Metric                    | Description                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `4XXError`    | The number of client errors captured during a given period. The Sum statistic represents this Metric, i.e., the total count of 4XXError errors during the given period. The Average statistic represents the 4XXError error rate, i.e., the total count of 4XXError errors divided by the total number of requests during the period. The denominator corresponds to the Count Metric (see below). Unit: Count |
| `5XXError`       | The number of server-side errors captured during a given period. The Sum statistic represents this Metric, i.e., the total count of 5XXError errors during the given period. The Average statistic represents the 5XXError error rate, i.e., the total count of 5XXError errors divided by the total number of requests during the period. The denominator corresponds to the Count Metric (see below). Unit: Count |
| `Count`      | The total number of API requests during a given period. The SampleCount statistic represents this Metric. Unit: Count |
| `Latency`     | The time it takes from when API Gateway receives a request from the client until it returns a response to the client. Latency includes integration latency and other API Gateway overheads. Unit: Millisecond  |

## Objects {#object}

The collected AWS API Gateway object data structure can be viewed in "Infrastructure - Custom".

```json
{
  "measurement": "aws_gateway",
  "tags": {
    "account_name"   : "AWS",
    "api_name"       : "helloworld-API",
    "ApiId"          : "c72z3thtq8",
    "ApiKeySelectionExpression": "$request.header.x-api-key",
    "class"          : "aws_gateway",
    "cloud_provider" : "aws",
    "create_time"    : "2023/08/07 14:29:19",
    "CreatedDate"    : "2022-11-11T09:17:35Z",
    "date"           : "2023/08/07 14:29:19",
    "date_ns"        :"0",
    "Description"    :"Created by AWS Lambda",
    "instance_tags"  :"{}",
    "name"           :"c72z3thtq8",
    "ProtocolType"   :"HTTP",
    "region_id"      :"cn-northwest-1"
  }
}
```

> *Note: Fields in `tags` and `fields` may vary with subsequent updates.*
>
> Tip 1: The value of `ApiId` is the instance ID, used as a unique identifier.