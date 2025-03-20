---
title: 'AWS CloudFront'
tags: 
  - AWS
summary: 'The core performance Metrics of AWS CloudFront include the total number of requests, data transfer volume, HTTP error rate, cache hit rate, and latency. These can help users evaluate and optimize the performance of the content delivery network.'
__int_icon: 'icon/aws_cloudfront'
dashboard:

  - desc: 'AWS CloudFront built-in views'
    path: 'dashboard/en/aws_cloudfront'

monitor:
  - desc: 'AWS CloudFront monitors'
    path: 'monitor/en/aws_cloudfront'

cloudCollector:
  desc: 'Cloud Collector'
  path: 'cloud-collector/en/aws_cloudfront'
---

<!-- markdownlint-disable MD025 -->
# AWS CloudFront
<!-- markdownlint-enable -->

The core performance Metrics of AWS CloudFront include the total number of requests, data transfer volume, HTTP error rate, cache hit rate, and latency. These can help users evaluate and optimize the performance of the content delivery network.

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data for AWS CloudFront cloud resources, we install the corresponding collection script: "Guance Integration (AWS-Gateway Collection)" (ID: `guance_aws_cloudfront`).

After clicking 【Install】, enter the corresponding parameters: Amazon AK and Amazon account name.

Click 【Deploy Start Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding start-up script.

In addition, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We collect some configurations by default; for more details, see the Metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudfront/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and at the same time, you can check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, under "Infrastructure / Custom", check if there is any asset information.
3. On the Guance platform, under "Metrics", check if there is any corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default Measurement set is as follows. You can collect more Metrics through configuration. [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/viewing-cloudfront-metrics.html#monitoring-console.distributions-additional){:target="_blank"}

### Monitoring Metrics

| Metric English Name      | Metric Chinese Name             | Meaning                        |
| --------------- | ---------------------- | --------------------------- |
| **Requests** | Requests            | The total number of viewer requests received by CloudFront for all HTTP methods and both HTTP and HTTPS requests. |
| **Bytes downloaded** | Bytes Downloaded | The total number of bytes downloaded by viewers for GET, HEAD, and OPTIONS requests. |
| **Bytes uploaded** | Bytes Uploaded | The total number of bytes uploaded by viewers through CloudFront to your origin using POST and PUT requests. |
| **4xx error rate** | 4xx Error Rate | The percentage of all viewer requests that received HTTP status codes in the 4xx range. |
| **5xx error rate** | 5xx Error Rate | The percentage of all viewer requests that received HTTP status codes in the 5xx range. |
| **Total error rate** | Total Error Rate | The percentage of all viewer requests that received HTTP status codes in the 4xx or 5xx range. |

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

> *Note: Fields in `tags` and `fields` may change with subsequent updates*