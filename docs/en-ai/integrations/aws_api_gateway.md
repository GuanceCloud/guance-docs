---
title: 'AWS API Gateway'
tags: 
  - AWS
summary: 'The displayed metrics of AWS API Gateway include request response time, throughput, concurrent connections, and error rate. These metrics reflect the performance and reliability of API Gateway in handling API requests and traffic management.'
__int_icon: 'icon/aws_api_gateway'
dashboard:

  - desc: 'AWS API Gateway Monitoring View'
    path: 'dashboard/en/aws_api_gateway'

monitor:
  - desc: 'AWS API Gateway Monitor'
    path: 'monitor/en/aws_api_gateway'

---

# AWS API Gateway

The displayed metrics of AWS API Gateway include request response time, throughput, concurrent connections, and error rate. These metrics reflect the performance and reliability of API Gateway in handling API requests and traffic management.

## Configuration {#config}

### Install Func

We recommend enabling Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a qualified Amazon AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data for AWS API Gateway cloud resources, we install the corresponding collection script: "Guance Integration (AWS-Gateway Collection)" (ID: `guance_aws_gateway`)

After clicking [Install], enter the required parameters: Amazon AK, Amazon account name.

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Then, in the collection script, change the regions in `collector_configs` and `cloudwatch_configs` to the actual regions.

Additionally, in the "Management / Automatic Trigger Configuration" section, you can see the corresponding automatic trigger configuration. Click [Execute] to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations. For more details, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-gateway/){:target="_blank"}

### Verification

1. In "Management / Automatic Trigger Configuration," confirm that the corresponding tasks have been configured and check the task records and logs for any anomalies.
2. In the Guance platform, under "Infrastructure / Custom," check if asset information exists.
3. In the Guance platform, under "Metrics," check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. You can collect more metrics through configuration. [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/apigateway/latest/developerguide/api-gateway-metrics-and-dimensions.html){:target="_blank"}

### Instance Metrics

The `AWS/ApiGateway` namespace includes the following instance metrics.

| Metric                    | Description                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `4XXError`    | Captures the number of client errors during a given period. The Sum statistic represents this metric, i.e., the total count of 4XXError errors during the period. The Average statistic represents the 4XXError error rate, which is the total count of 4XXError errors divided by the total number of requests during the period. The denominator corresponds to the Count metric (see below). Unit: Count |
| `5XXError`       | Captures the number of server-side errors during a given period. The Sum statistic represents this metric, i.e., the total count of 5XXError errors during the period. The Average statistic represents the 5XXError error rate, which is the total count of 5XXError errors divided by the total number of requests during the period. The denominator corresponds to the Count metric (see below). Unit: Count |
| `Count`      | Total number of API requests during a given period. The SampleCount statistic represents this metric. Unit: Count |
| `Latency`     | Time taken from when API Gateway receives a request from the client until it returns a response to the client. Latency includes integration latency and other API Gateway overhead. Unit: Millisecond  |

## Objects {#object}

The structure of collected AWS API Gateway object data can be viewed in "Infrastructure / Custom".

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

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: `ApiId` value is the instance ID, used for unique identification.