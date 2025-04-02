---
title: 'AWS API Gateway'
tags: 
  - AWS
summary: 'The displayed metrics for AWS API Gateway include request response time, throughput, concurrent connections, and error rate. These metrics reflect the performance and reliability of API Gateway when handling API requests and traffic management.'
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

The displayed metrics for AWS API Gateway include request response time, throughput, concurrent connections, and error rate. These metrics reflect the performance and reliability of API Gateway when handling API requests and traffic management.


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - managed Func: all prerequisites are automatically installed. Please continue with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Please prepare the required Amazon AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

#### Managed Edition Activation Script

1. Log in to <<< custom_key.brand_name >>> console
2. Click on the 【Manage】 menu, select 【Cloud Account Management】
3. Click 【Add Cloud Account】, select 【AWS】, fill in the required information on the interface. If cloud account information has been configured before, skip this step
4. Click 【Test】, if the test is successful, click 【Save】. If the test fails, check whether the related configuration information is correct and retest
5. In the 【Cloud Account Management】 list, you can see the added cloud accounts. Click the corresponding cloud account to enter the details page
6. Click the 【Integration】 button on the cloud account details page. Under the `Not Installed` list, find `AWS API Gateway`, click the 【Install】 button, and an installation interface will pop up for installation.


#### Manual Activation Script

1. Log in to the Func console, click 【Script Market】, enter the official script market, and search for `guance_aws_gateway`

2. After clicking 【Install】, input the corresponding parameters: AWS AK ID, AK Secret, and account name.

3. Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

4. After enabling, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can view the corresponding task records and logs to check for any abnormalities.
2. In <<< custom_key.brand_name >>>, 「Infrastructure / Custom」, check whether there is asset information.
3. In <<< custom_key.brand_name >>>, 「Metrics」, check whether there are corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon-CloudWatch, the default metric sets are as follows. You can collect more metrics through configuration [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/apigateway/latest/developerguide/api-gateway-metrics-and-dimensions.html){:target="_blank"}

### Instance Metrics

The `AWS/ApiGateway` namespace includes the following instance metrics.

| Metric                  | Description                                                         |
| :---------------------- | :------------------------------------------------------------------ |
| `4XXError`             | Captures the number of client errors during a given period. The Sum statistic represents this metric, i.e., the total count of 4XXError errors during the given period. The Average statistic represents the 4XXError error rate, i.e., the total count of 4XXError errors divided by the total number of requests during that period. The denominator corresponds to the Count metric (see below). Unit: Count |
| `5XXError`             | Captures the number of server-side errors during a given period. The Sum statistic represents this metric, i.e., the total count of 5XXError errors during the given period. The Average statistic represents the 5XXError error rate, i.e., the total count of 5XXError errors divided by the total number of requests during that period. The denominator corresponds to the Count metric (see below). Unit: Count |
| `Count`                | Total number of API requests during a given period. The SampleCount statistic represents this metric. Unit: Count |
| `Latency`              | The time taken from when API Gateway receives a request from the client until it returns the response to the client. Latency includes integration latency and other API Gateway overheads. Unit: Millisecond |

## Objects {#object}

The collected AWS API Gateway object data structure can be viewed under 「Infrastructure - Custom」

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
> Tip 1: The value of `ApiId` is the instance ID, used as unique identification.