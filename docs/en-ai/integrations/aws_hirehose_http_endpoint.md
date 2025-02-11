---
title     : 'AWS Firehose HTTP Endpoint'
summary   : 'Send Firehose logs or metrics to Guance'
tags      :
  - 'Amazon Firehose'
  - 'HTTP Endpoint'
  - 'Kinesis Data Stream'

---


This article mainly introduces three ways to send `log` and `metric` data received by a custom `HTTP Endpoint` in Firehose.

1. Send Kinesis Stream data to Firehose
2. Send CloudWatch Log data to Firehose
3. Send CloudWatch metric stream data to Firehose


## Sending Kinesis Stream to Firehose {#stream}

Using the [Amazon Agent proxy](https://github.com/awslabs/amazon-kinesis-agent) or the [AWS SDK](https://github.com/aws/aws-sdk-java-v2) to send logs to the Kinesis Stream, you can then use Firehose to send logs to Guance.

### Create Data Stream {#creat_stream}

Create a data stream in Amazon Kinesis by entering a data stream name.

If the data stream has already been created, there is no need to recreate it.

### Create Firehose Stream {#creat_firehose}

In Amazon Data Firehose, select *Create Firehose Stream*

Choose Source: `Amazon Kinesis Data Streams`

Target: `HTTP Endpoint`

HTTP endpoint configuration notes:

- Choose a source, which must be: `Amazon Kinesis Data Streams`
- Choose Target: `HTTP Endpoint`
- Firehose Name: Can be customized or use the default value.
- Source settings: Select a previously created data stream.
- Target setting HTTP endpoint URL: Must use HTTPS protocol and port must be 443. Logs must carry the parameter `category=logging`, for example: `https://openway.guance.com/v1/input/firehose?category=logging`.
- Access key: Enter the user token, such as `tkn_zxxzxxzxx`
- Content encoding (optional).
- Parameters: Set `source` for subsequent pipeline operations, for example: `source=my_source` or add service name `service=my_service`
- Use default values for subsequent settings.

> Note, token and parameter `source` are mandatory.

### Subsequent Pipeline Processing {#pipeline}

After log data is sent to Guance, it will be displayed in plain text. You can create a Pipeline script based on the pre-configured `source`.


## Sending CloudWatch Log Data to Firehose {#cloudwatch-log}

You need to use the CLI, and set environment variables beforehand:

```shell
export AWS_ACCESS_KEY_ID=<AK>
export AWS_SECRET_ACCESS_KEY=<SK>
export AWS_DEFAULT_REGION=<us-west-2>
```

### Create Log Group, Log Stream {#creat-log-group}

This can be done via CLI or the console.

### Create Stream, Role {#creat-log-role}

In practice, it is found that using CLI to create streams and roles and assign role permissions is necessary.

[Read the CLI operation documentation carefully](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/SubscriptionFilters.html#DestinationKinesisExample) and follow the first six steps:

1. Create Stream
2. View Stream
3. Create IAM File
4. Create Role
5. Create Permission Policy
6. Assign Role Permissions

> Carefully read the document, and manually fill in the highlighted parts in the examples.

The following steps can be performed via the console for better visibility:

In the log group list interface, select the log group and click into the operation interface. Under **Actions**, choose **Subscription Filter** and then **Create Kinesis Subscription Filter** to enter the creation page.

**Target** Select the data stream created via CLI

**Grant Permissions** Select the role name created via CLI


With the connection from CloudWatch to Stream established, the next step is to create Firehose to send stream data to the HTTP Endpoint.

### Create Firehose

On the **Create Firehose Stream** page, note the following:

Choose Source: `Amazon Kinesis Data Streams`

Target: `HTTP Endpoint`

Firehose stream name: Default is fine

Kinesis data stream: The stream created via CLI

Record transformation (Lambda): Create a function, select **General Amazon Data Firehose Processing**. In the function creation search for `Process records sent to an Firehose stream`, select and create a function name. Return to the Firehose creation page, refresh and select the created function.

Target settings: Target HTTP endpoint URL: Must use HTTPS protocol and port must be 443. Logs must carry the parameter `category=logging`, for example: `https://openway.guance.com/v1/input/firehose?category=logging`.

Access key: User token starting with `tkn`

Add parameters: Define `source = apache_xx` and `service=my_service` here.

Finally, create the Firehose stream.

When logs are sent from the log stream to the Kinesis stream, the data is compressed once, so it needs to be decompressed before sending to the HTTP endpoint, which is why configuring `Lambda` is necessary.

## Sending CloudWatch Metric Stream Data to Firehose {#cloudwatch-metric}

### Create Firehose {#firehose}

When selecting the **Source**, choose `Direct PUT`

When selecting the **Target**, choose `HTTP Endpoint`

HTTP Endpoint Configuration:

Target settings: Target HTTP endpoint URL: Must use HTTPS protocol and port must be 443. Metrics must carry the parameter `category=metric`, for example: `https://openway.guance.com/v1/input/firehose?category=metric`

Access key: User token starting with `tkn`

Add parameters: Define `source = apache_xx` and `service=my_service` here.

Use default settings for the rest.

> Two points to note: Source should be `Direct PUT`, request parameter should be `category=metric`

## Create Metric Stream

In `CloudWatch` metrics, choose **Streams**, and create a **Metric Stream**

Key points to note:

1. Target selection **Custom Settings for Firehose**
2. Firehose stream selection of the name with source **Direct PUT** just created.
3. (Optional) Service Role
4. (Required) Change output format to `OpenTelemetry 1.0`
5. Metrics to stream: Can be chosen freely

After creation, metrics will be streamed to the Firehose target.

## Additional Reference Documents {#docs}

- [What is Amazon Data Firehose](https://docs.aws.amazon.com/firehose/latest/dev/what-is-this-service.html){:target="_blank"}
- [HTTP Endpoint Request and Response Data](https://docs.aws.amazon.com/firehose/latest/dev/httpdeliveryrequestresponse.html){:target="_blank"}
- [Use Metric Streams](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Metric-Streams.html){:target="_blank"}
- [OPenTelemetry 1.0.0](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-metric-streams-formats-opentelemetry-100.html){:target="_blank"}