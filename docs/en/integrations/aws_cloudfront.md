---
title: 'AWS CloudFront'
summary: 'Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'
__int_icon: 'icon/aws_cloudfront'
dashboard:

  - desc: 'AWS CloudFront Monitoring View'
    path: 'dashboard/zh/aws_cloudfront'

monitor:
  - desc: 'AWS CloudFront Monitor'
    path: 'monitor/zh/aws_cloudfront'
---

<!-- markdownlint-disable MD025 -->
# AWS CloudFront
<!-- markdownlint-enable -->

Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.

## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of AWS API Gateway cloud resources, we install the corresponding collection script：「Guance Integration（AWS-GatewayCollect）」(ID：`guance_aws_cloudfront`)

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudfront/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists


## Metric {#metric}
Configure AWS Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/viewing-cloudfront-metrics.html#monitoring-console.distributions-additional){:target="_blank"}

### monitoring metrics

| English name of the metric      | Meaning                        |
| --------------- | ---------------------- | --------------------------- |
| **Requests** | The total number of viewer requests received by CloudFront, for all HTTP methods and for both HTTP and HTTPS requests. |
| **Bytes downloaded** | The total number of bytes downloaded by viewers for GET, HEAD, and OPTIONS requests. |
| **Bytes uploaded** | The total number of bytes that viewers uploaded to your origin with CloudFront, using POST and PUT requests. |
| **4xx error rate** | The percentage of all viewer requests for which the response's HTTP status code is 4xx. |
| **5xx error rate** | The percentage of all viewer requests for which the response's HTTP status code is 5xx. |
| **Total error rate** | The percentage of all viewer requests for which the response's HTTP status code is 4xx or 5xx. |

## Object {#object}

Examples of reported data are as follows：

```json
{
  "measurement": "aws_cloudfront",
  "tags": {
    "ARN": "arn:aws-cn:cloudfront::F",
    "DomainName": "d3q33pv83.cloudfront.cn",
    "Id": "E183FMUG1QDCZF",
    "Status": "Deployed",
    "name": "E183FMUG1ZF"
  },
  "fields": {
    "CreatedDate"              : "2022-03-09T06:13:31Z",
    "ApiKeySelectionExpression": "$request.header.",
    "DisableSchemaValidation"  : "xxxxx",
    "Description"              : "Created by AWS Lambda"
  }
}


```

> *Note: The fields in 'tags' and' fields' may change with subsequent updates*

