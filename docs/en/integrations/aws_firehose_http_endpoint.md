---
title     : 'AWS Firehose HTTP Endpoint'
summary   : 'AWS Kinesis Firehose Logging and Metrics Data Reception Guide'
tags      :
  - 'Amazon Firehose'
  - 'HTTP Endpoint'
  - 'Kinesis Data Stream'

---


This guide provides detailed instructions on how to send Logging and Metrics data to AWS Kinesis Firehose through three methods and configure a custom HTTP Endpoint to receive this data.

## Sending Kinesis Stream Data to Firehose {#kinesis-stream-to-firehose}

### Creating a Data Stream {#create-stream}

Create a data stream in Amazon Kinesis and enter a stream name. If a stream already exists, there is no need to create it again.

### Creating a Firehose Stream {#create-firehose}

In Amazon Kinesis Data Firehose, select "Create Firehose delivery stream".

- **Source**: Amazon Kinesis Data Streams
- **Destination**: HTTP Endpoint

HTTP Endpoint Configuration Notes:

- **Firehose Name**: Customizable or use the default.
- **Source Settings**: Select the previously created data stream.
- **Destination Settings**:
    - HTTP Endpoint URL: Must be HTTPS protocol on port 443, e.g., `https://your-endpoint/v1/input/firehose?category=logging`.
    - Access Key: Fill in the user token, e.g., `tkn_xxxxxx`.
    - **Parameters**: Set `source` for subsequent Pipeline operations, e.g., `source=my_source` or `service=my_service`.

### Subsequent Pipeline Processing {#pipeline-processing}

After logging data is sent to the observability platform, it will be displayed in plaintext. Pipeline scripts can be created for processing based on the preconfigured `source`.

## Sending CloudWatch Log Data to Firehose {#cloudwatch-log-to-firehose}

### Creating a Log Group and Log Stream {#create-log-group-and-stream}

Create a log group and log stream via the AWS CLI or console.

### Creating a Firehose Stream and IAM Role {#create-firehose-and-role}

Use the AWS CLI to create a Firehose stream and IAM role, and assign necessary permissions. For detailed steps, refer to the [AWS Official Documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/SubscriptionFilters.html#DestinationKinesisExample).

### Configuring CloudWatch Subscription Filters {#configure-cloudwatch-subscription}

Select a log group from the log group list, click "Actions," and select "Subscription Filters." Then, choose "Create Kinesis subscription filter."

- **Destination**: Select the data stream created via the CLI.
- **Grant Permissions**: Select the role name created via the CLI.

### Creating Firehose with Lambda {#create-firehose-with-lambda}

When creating a Firehose stream, select the following configuration:

- **Source**: Amazon Kinesis Data Streams
- **Destination**: HTTP Endpoint
- **Firehose Stream Name**: Default is acceptable
- **Kinesis Data Stream**: The stream created via the CLI
- **Transform Records (Lambda)**: Create a function and select "Common Amazon Data Firehose processing." Search for `Process records sent to an Firehose stream` when creating the function and select the function name to create. Then, return to the Firehose creation page, refresh, and select the created function.

HTTP Endpoint Configuration:

- **Destination Settings**: HTTPS protocol on port 443, e.g., `https://your-endpoint/v1/input/firehose?category=logging`.
- **Access Key**: User token.
- **Add Parameters**: Define `source` and `service`.

Logs are compressed when sent from the log stream to the Kinesis stream, so decompression is required before sending to the HTTP endpoint. This is why Lambda is configured.

## CloudWatch Metric to Firehose {#metric-to-firehose}

### Creating a Firehose Stream {#create-firehose-for-metrics}

When selecting a source, choose "Direct PUT."

When selecting a destination, choose "HTTP Endpoint."

HTTP Endpoint Configuration:

- **Destination Settings**: HTTPS protocol on port 443, e.g., `https://your-endpoint/v1/input/firehose?category=metric`.
- **Access Key**: User token.
- **Add Parameters**: Define `source` and `service`.

### Creating a Metric Stream {#create-metric-stream}

In CloudWatch Metrics, select "Streams" and choose "Create Metric Stream."

Notes:

1. **Destination**: Select custom settings for Firehose.
2. **Firehose Stream**: Select the name with Direct PUT as the source just created.
3. **(Optional) Service Role**: Configure as needed.
4. **(Required) Change Output Format**: OpenTelemetry 1.0.
5. **Metrics to Stream**: Choose as desired.

After creation, metrics will be streamed to the Firehose destination.

## Additional Reference Documents {#additional-docs}

- [What is Amazon Data Firehose](https://docs.aws.amazon.com/firehose/latest/dev/what-is-this-service.html){:target="_blank"}
- [HTTP Endpoint Request and Response Data](https://docs.aws.amazon.com/firehose/latest/dev/httpdeliveryrequestresponse.html){:target="_blank"}
- [Using Metric Streams](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Metric-Streams.html){:target="_blank"}
- [OpenTelemetry 1.0.0](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-metric-streams-formats-opentelemetry-100.html){:target="_blank"}

---

This is an optimized and formatted version of the original Markdown document, including the addition of a table of contents, detailed steps, adjusted heading levels, and formatting enhancements. I hope this is helpful!

