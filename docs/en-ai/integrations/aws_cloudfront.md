---
title: 'AWS CloudFront'
tags: 
  - AWS
summary: 'The core performance Metrics of AWS CloudFront include total requests, data transfer volume, HTTP error rate, cache hit rate, and latency. These can help users evaluate and optimize the performance of the content delivery network.'
__int_icon: 'icon/aws_cloudfront'
dashboard:

  - desc: 'Built-in Views for AWS CloudFront'
    path: 'dashboard/en/aws_cloudfront'

monitor:
  - desc: 'Monitors for AWS CloudFront'
    path: 'monitor/en/aws_cloudfront'
---

<!-- markdownlint-disable MD025 -->
# AWS CloudFront
<!-- markdownlint-enable -->

The core performance Metrics of AWS CloudFront include total requests, data transfer volume, HTTP error rate, cache hit rate, and latency. These can help users evaluate and optimize the performance of the content delivery network.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-hosted Func Deployment](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`).

To synchronize monitoring data from AWS CloudFront cloud resources, we install the corresponding collection script: "Guance Integration (AWS-Gateway Collection)" (ID: `guance_aws_cloudfront`).

After clicking 【Install】, enter the required parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】. The system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Additionally, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations. For details, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-cloudfront/){:target="_blank"}

### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding automatic trigger configuration exists for the task and check the task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon Cloud Monitoring, the default Mearsurement sets are as follows. You can collect more Metrics through configuration. [Amazon Cloud Monitoring Metrics Details](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/viewing-cloudfront-metrics.html#monitoring-console.distributions-additional){:target="_blank"}

### Monitoring Metrics

| Metric English Name      | Metric Chinese Name             | Meaning                        |
| --------------- | ---------------------- | --------------------------- |
| **Requests** | Number of Requests            | Total number of viewer requests received by CloudFront for all HTTP methods and HTTP and HTTPS requests. |
| **Bytes downloaded** | Downloaded Bytes | Total number of bytes downloaded by viewers for GET, HEAD, and OPTIONS requests. |
| **Bytes uploaded** | Uploaded Bytes | Total number of bytes uploaded by viewers using POST and PUT requests through CloudFront to your origin. |
| **4xx error rate** | 4xx Errors | Percentage of all viewer requests that responded with an HTTP status code of 4xx. |
| **5xx error rate** | 5xx Errors | Percentage of all viewer requests that responded with an HTTP status code of 5xx. |
| **Total error rate** | Total Errors | Percentage of all viewer requests that responded with an HTTP status code of 4xx or 5xx. |

## Objects {#object}

An example of reported data is as follows:

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

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*