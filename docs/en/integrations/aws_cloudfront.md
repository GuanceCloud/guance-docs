---
title: 'AWS CloudFront'
tags: 
  - AWS
summary: 'The core performance Metrics of AWS CloudFront include total requests, data transfer volume, HTTP error rate, cache hit rate, and latency. These can help users evaluate and optimize the performance of their content delivery network.'
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

The core performance Metrics of AWS CloudFront include total requests, data transfer volume, HTTP error rate, cache hit rate, and latency. These can help users evaluate and optimize the performance of their content delivery network.

## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deploy Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

#### Managed Edition Enablement Script

1. Log in to the <<< custom_key.brand_name >>> console
2. Click on the 【Manage】 menu, select 【Cloud Account Management】
3. Click 【Add Cloud Account】, select 【AWS】, fill in the required information on the interface; if cloud account information has been configured before, skip this step
4. Click 【Test】, after a successful test, click 【Save】. If the test fails, check whether the related configuration information is correct and retest
5. In the 【Cloud Account Management】 list, you can see the added cloud accounts. Click on the corresponding cloud account to enter the details page
6. Click the 【Integration】 button on the cloud account details page. Under the `Not Installed` list, find `AWS CloudFront`, click the 【Install】 button, and follow the installation interface to complete the installation.


#### Manual Enablement Script

1. Log in to the Func console, click 【Script Market】, enter the official script market, search for `guance_aws_cloudfront`

2. After clicking 【Install】, input the corresponding parameters: AWS AK ID, AK Secret, and account name.

3. Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup scripts.

4. After enabling, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to immediately execute once without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the corresponding automatic trigger configurations. You can also view the corresponding task records and logs to check for any abnormalities.
2. In <<< custom_key.brand_name >>>, under 「Infrastructure / Custom」, check if there is asset information.
3. In <<< custom_key.brand_name >>>, under 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon-CloudWatch, the default Measurement set is as follows. More Metrics can be collected through configuration. [Amazon Cloud Monitoring Metrics Details](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/viewing-cloudfront-metrics.html#monitoring-console.distributions-additional){:target="_blank"}

### Monitoring Metrics

| Metric English Name      | Metric Chinese Name             | Meaning                        |
| --------------- | ---------------------- | --------------------------- |
| **Requests** | Requests            | Total number of viewer requests received by CloudFront for all HTTP methods and HTTP and HTTPS requests. |
| **Bytes downloaded** | Bytes Downloaded | Total number of bytes downloaded by viewers for GET, HEAD, and OPTIONS requests. |
| **Bytes uploaded** | Bytes Uploaded | Total number of bytes uploaded by viewers using POST and PUT requests via CloudFront to your origin location. |
| **4xx error rate** | 4xx Errors | Percentage of all viewer requests that resulted in HTTP status codes 4xx. |
| **5xx error rate** | 5xx Errors | Percentage of all viewer requests that resulted in HTTP status codes 5xx. |
| **Total error rate** | Total Errors | Percentage of all viewer requests that resulted in HTTP status codes 4xx or 5xx. |

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

> *Note: The fields in `tags` and `fields` may change with subsequent updates*

</example>