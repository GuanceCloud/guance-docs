---
title     : 'AWS Firehose HTTP Endpoint'
summary   : 'Send Firehose logs or metrics to Guance'
tags      :
  - 'Amazon Firehose'
  - 'HTTP Endpoint'
  - 'Kinesis Data Stream'

---


This article primarily introduces three methods for creating a custom `HTTP Endpoint` in Firehose to receive `log` and `metric` data.

1. Send Kinesis Stream data to Firehose
2. Send CloudWatch Log data to Firehose
3. Send CloudWatch metric stream data to Firehose


## Sending Kinesis Stream to Firehose {#stream}

Using the [Amazon Agent](https://github.com/awslabs/amazon-kinesis-agent) or the [AWS SDK](https://github.com/aws/aws-sdk-java-v2) to send logs to a Kinesis Stream, both can forward logs to Guance via Firehose.

### Create Data Stream {#creat_stream}

Create a data stream in Amazon Kinesis by entering a data stream name.

If a data stream has already been created, there is no need to create it again.

### Create Firehose Delivery Stream {#creat_firehose}

In Amazon Data Firehose, choose *Create Firehose Delivery Stream*

Source: `Amazon Kinesis Data Streams`

Target: `HTTP Endpoint`

Important configurations for the HTTP endpoint:

- Select a source, which must be: `Amazon Kinesis Data Streams`
- Select target: `HTTP Endpoint`
- Firehose name: customizable or use the default.
- Source settings: select the previously created data stream.
- Target settings HTTP endpoint URL: must use https protocol with port 443, and logs must include the parameter `category=logging`, for example: `https://openway.guance.com/v1/input/firehose?category=logging`.
- Access key: enter user token such as: `tkn_zxxzxxzxx`
- Content encoding (optional).
- Parameters: set `source` for subsequent pipeline operations, e.g., `source=my_source` or add service name `service=my_service`
- Use default values for subsequent settings.

> Note, the token and parameter `source` are mandatory.

### Subsequent Pipeline Processing {#pipeline}

After log data is sent to Guance, it will be displayed as plain text. You can create a Pipeline script based on the pre-configured `source`.


## Sending CloudWatch Log Data to Firehose {#cloudwatch-log}

You need to use CLI, and before that, you should set environment variables:

```shell
export AWS_ACCESS_KEY_ID=<AK>
export AWS_SECRET_ACCESS_KEY=<SK>
export AWS_DEFAULT_REGION=<us-west-2>
```

### Create Log Group and Log Stream {#creat-log-group}

This can be done through CLI or the console.

### Create Stream and Role {#creat-log-role}

During practice, it was found that using CLI to create streams and roles and assign role permissions is necessary.

[Read the CLI operation documentation carefully](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/SubscriptionFilters.html#DestinationKinesisExample). Only the first six steps need to be completed:

1. Create stream
2. View stream
3. Create IAM policy
4. Create role
5. Create permission policy
6. Assign role permissions

> Carefully read the document; the red-marked parts in the document examples need to be filled in manually.

The following steps can be performed via the console, which is more intuitive:

In the log group list interface, select the log group and click into the operation interface, **Actions** choose **Subscription Filters** then choose **Create Kinesis Subscription Filter** to enter the creation page.

**Target** select the data stream created via CLI

**Grant Permissions** select the role name created via CLI


At this point, the connection from CloudWatch to Stream has been established. The next step is to create a Firehose to send stream data to the HTTP Endpoint.

### Create Firehose

On the **Create Firehose Delivery Stream** page, note the following:

Source: `Amazon Kinesis Data Streams`

Target: `HTTP Endpoint`

Firehose stream name: default is fine

Kinesis data stream: the stream created via CLI

Record transformation (Lambda): create a function, choose **General Amazon Data Firehose processing**. In the function creation search for `Process records sent to an Firehose stream` and create the function name. Return to the Firehose creation page, refresh, and select the created function.

Target settings: set HTTP endpoint URL: must use https protocol with port 443, and logs must include the parameter `category=logging`, for example: `https://openway.guance.com/v1/input/firehose?category=logging`.

Access key: user token starting with `tkn`

Add parameters: define `source = apache_xx` `service=my_service`

Finally, create the Firehose delivery stream.

When logs are sent from the log stream to the Kinesis stream, the data is compressed once, so decompression is required before sending to the HTTP endpoint, which is why configuring `Lambda` is necessary.

## Sending CloudWatch Metric Stream Data to Firehose {#cloudwatch-metric}

### Create Firehose {#firehose}

When selecting the **source**, choose `Direct PUT`

When selecting the **target**, choose `HTTP Endpoint`

HTTP Endpoint configuration:

Target settings: set HTTP endpoint URL: must use https protocol with port 443, and metrics must include the parameter `category=metric`, for example: `https://openway.guance.com/v1/input/firehose?category=metric`

Access key: user token starting with `tkn`

Add parameters: define `source = apache_xx` `service=my_service`

Use default values for the rest.

> Two points to note: the source must be `Direct PUT`, and the request parameter must be `category=metric`

## Create Metric Stream

In `CloudWatch` metrics, choose **Streams**, then choose to create a **Metric Stream**

Points to note:

1. Choose **Custom destination Firehose**
2. Select the Firehose stream created with **Direct PUT** as the source name.
3. (Optional) Service role
4. (Required) Change output format to `OpenTelemetry 1.0`
5. Metrics to stream: selectable

After creation, metrics will be streamed to the Firehose target.

## Other Reference Documents {#docs}

- [What is Amazon Data Firehose](https://docs.aws.amazon.com/firehose/latest/dev/what-is-this-service.html){:target="_blank"}
- [HTTP endpoint Request and Response Data](https://docs.aws.amazon.com/firehose/latest/dev/httpdeliveryrequestresponse.html){:target="_blank"}
- [Use Metric Streams](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Metric-Streams.html){:target="_blank"}
- [OPenTelemetry 1.0.0](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-metric-streams-formats-opentelemetry-100.html){:target="_blank"}