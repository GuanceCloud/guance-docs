---
title: 'AWS API Gateway'
tags: 
  - AWS
summary: 'Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'
__int_icon: 'icon/aws_api_gateway'
dashboard:

  - desc: 'AWS API Gateway Monitoring View'
    path: 'dashboard/en/aws_api_gateway'

monitor:
  - desc: 'AWS API Gateway Monitor'
    path: 'monitor/en/aws_api_gateway'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/en/aws_api_gateway'
---


<!-- markdownlint-disable MD025 -->
# AWS API Gateway
<!-- markdownlint-enable -->

Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of AWS API Gateway cloud resources, we install the corresponding collection script：「Guance Integration（AWS-GatewayCollect）」(ID：`guance_aws_gateway`)

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

Then, in the collection script, add the collector_configs and cloudwatch_change the regions in configs to the actual regions

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-gateway/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure AWS Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-metrics-and-dimensions.html){:target="_blank"}

### Metric

`AWS/ApiGateway` The namespace includes the following instance metrics 。

| Metric                    | Description                                                         |
| :---------------------- | :----------------------------------------------------------- |
| `4XXError`    | Number of client errors captured during the given period。 Sum The statistical data represents the total count of 4XXError errors within a given period for this metric. The Average statistical data represents the 4XXError error rate, which is the total count of 4XXError errors divided by the total number of requests during that period. The denominator corresponds to the Count metric (see below)。 Unit: Count |
| `5XXError`       | Number of server-side errors captured during a given period。 Sum Sum The statistical data represents the total count of 5XXError errors within a given period for this metric. The Average statistical data represents the 5XXError error rate, which is the total count of 5XXError errors divided by the total number of requests during that period. The denominator corresponds to the Count metric (see below)。 Unit: Count |
| `Count`      | The total number of API requests within a given interval。 SampleCount Statistical data represents this metric。 Unit: Count |
| `Latency`     | The time elapsed from when the API Gateway receives a request from the client to when it returns the response to the client. Delay includes integration delay and other API Gateway overhead。Unit: Millisecond  |

## Object {#object}

The collected AWS API Gateway object data structure, You can see the object data from「Infrastructure-Custom」

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

> *Note: The fields in 'tags' and' fields' may change with subsequent updates*
>
> Tip 1: The 'ApiId' value is the instance ID and serves as a unique identifier
