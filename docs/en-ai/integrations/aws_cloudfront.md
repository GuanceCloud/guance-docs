---
title: 'AWS CloudFront'
tags: 
  - AWS
summary: 'The core performance Metrics of AWS CloudFront include total requests, data transfer volume, HTTP error rate, cache hit rate, and latency. These can help users evaluate and optimize the performance of their content delivery network.'
__int_icon: 'icon/aws_cloudfront'
dashboard:

  - desc: 'Built-in Views for AWS CloudFront'
    path: 'dashboard/en/aws_cloudfront'

monitor:
  - desc: 'AWS CloudFront Monitor'
    path: 'monitor/en/aws_cloudfront'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_cloudfront'
---

<!-- markdownlint-disable MD025 -->
# AWS CloudFront
<!-- markdownlint-enable -->

The core performance Metrics of AWS CloudFront include total requests, data transfer volume, HTTP error rate, cache hit rate, and latency. These can help users evaluate and optimize the performance of their content delivery network.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with script installation.

If you deploy Func on your own, refer to [Self-hosted Func Deployment](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data from AWS CloudFront cloud resources, we install the corresponding collection script: "Guance Integration (AWS-Gateway Collection)" (ID: `guance_aws_cloudfront`)

After clicking 【Install】, enter the required parameters: Amazon AK and Amazon account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the startup scripts accordingly.

Additionally, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations; for more details, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudfront/){:target="_blank"}

### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding tasks have the automatic trigger configuration, and check the task records and logs for any abnormalities.
2. On the Guance platform, under 「Infrastructure / Custom」, check if there is asset information.
3. On the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon Cloud Monitoring, the default Mearsurement set is as follows. You can collect more metrics by configuring [Amazon Cloud Monitoring Metric Details](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/viewing-cloudfront-metrics.html#monitoring-console.distributions-additional){:target="_blank"}

### Monitoring Metrics

| Metric Name      | Metric Description             | Meaning                        |
| --------------- | ---------------------- | --------------------------- |
| **Requests** | Total Requests            | The total number of viewer requests for all HTTP methods and HTTP and HTTPS requests received by CloudFront. |
| **Bytes downloaded** | Bytes Downloaded | The total number of bytes downloaded by viewers for GET, HEAD, and OPTIONS requests. |
| **Bytes uploaded** | Bytes Uploaded | The total number of bytes uploaded to your origin via CloudFront using POST and PUT requests by viewers. |
| **4xx error rate** | 4xx Errors | The percentage of all viewer requests that resulted in HTTP status codes 4xx. |
| **5xx error rate** | 5xx Errors | The percentage of all viewer requests that resulted in HTTP status codes 5xx. |
| **Total error rate** | Total Errors | The percentage of all viewer requests that resulted in HTTP status codes 4xx or 5xx. |

## Objects {#object}

Example of reported data:

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

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*