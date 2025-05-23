---
title     : 'AWS Lambda Extension'
summary   : 'Extend data collection through AWS Lambda'
tags:
  - 'AWS'
__int_icon      : 'icon/awslambda'
dashboard :
  - desc  : 'None'
    path  : '-'
monitor   :
  - desc  : 'None'
    path  : '-'
---


:fontawesome-brands-linux: :material-kubernetes: :material-docker:

---

[:octicons-tag-24: Version-1.34.0](../datakit/changelog.md#cl-1.34.0) · [:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

The AWS Lambda collector collects AWS Lambda metrics and logs through the Lambda extension.

## Installation {#installation}

### Adding a Datakit Layer {#layer}

- [Create a Layer via Zip](https://docs.aws.amazon.com/lambda/latest/dg/creating-deleting-layers.html#layers-create){:target="_blank"}

    - Zip download links:
        - [Linux amd64](https://static.guance.com/datakit/datakit_aws_extension-linux-amd64.zip)
        - [Linux arm64](https://static.guance.com/datakit/datakit_aws_extension-linux-arm64.zip)

    - Open the Lambda console [Layers page](https://console.aws.amazon.com/lambda/home#/layers){:target="_blank"}.
    - Select **Create layer**.
    - Under **Layer configuration**, enter the layer name in **Name**.
    - Choose **Upload a .zip file**. Then, select **Upload** to choose the local .zip file.
    - Select **Create**.

- [Add a Layer via ARN](https://docs.aws.amazon.com/lambda/latest/dg/adding-layers.html){:target="_blank"}

    - Open the Lambda console [Functions page](https://console.aws.amazon.com/lambda/home#/functions){:target="_blank"}.
    - Select the function you want to configure.
    - Under **Layers**, select **Add Layer**.
    - Under **Select a layer**, choose **ARN** as the layer source.
    - Enter the ARN in the text box, select **Verify**, and then choose **Add**.

### Configure the Required Environment Variables {#env}

- ENV_DATAWAY=`https://openway.guance.com?token=<your-token>`

## Metrics {#metric}



### `awslambda-metric`

- Tags


| Tag | Description |
|  ----  | --------|
|`aws_account_id`|AWS Account ID.|
|`aws_lambda_function_memory_size`|Configured memory size for the Lambda function.|
|`aws_lambda_function_name`|Lambda function name.|
|`aws_lambda_function_version`|Lambda function version.|
|`aws_lambda_initialization_type`|Initialization type of the Lambda function.|
|`aws_region`|AWS region where the function is executed.|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`billed_duration_ms`|Billed duration in milliseconds.|int|ms|
|`duration_ms`|Total duration in milliseconds.|int|ms|
|`errors`|Errors count.|int|count|
|`init_duration_ms`|Initialization duration in milliseconds.|int|ms|
|`invocations`|Invocation count.|int|count|
|`max_memory_used_mb`|Maximum memory used in MB.|int|Mb|
|`memory_size_mb`|Memory size configured for the Lambda function in MB.|int|Mb|
|`out_of_memory`|Out of memory errors count.|int|count|
|`post_runtime_duration`|Duration of the post-runtime phase in milliseconds.|int|ms|
|`produced_bytes`|Bytes produced.|int|B|
|`response_duration_ms`|Response duration in milliseconds.|int|ms|
|`response_latency`|Response latency in milliseconds.|int|ms|
|`runtime_duration_ms`|Duration of the runtime in milliseconds.|int|ms|
|`timeouts`|Timeouts count.|int|count|



### `awslambda-logging`

- Tags


| Tag | Description |
|  ----  | --------|
|`aws_log_from`|log sources, currently only function are supported|

- Metrics


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`message`|Log message.|string|-|



### Collector Support {#input}

- OpenTelemetry
- statsd
- ddtrace # Currently, only Go is supported. Due to special operations required by ddtrace in the lambda environment, you need to add `tracer.WithLambdaMode(false)`.
