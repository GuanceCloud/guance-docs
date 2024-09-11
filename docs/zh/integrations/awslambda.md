---
title     : 'AWS Lambda Extention'
summary   : '通过 awslambda 扩展采集数据'
__int_icon      : 'icon/awslambda'
dashboard :
  - desc  : '暂无'
    path  : '-'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# AWSLambda
<!-- markdownlint-enable -->

---

:fontawesome-brands-linux: :material-kubernetes: :material-docker:

---

[:octicons-tag-24: Version-1.4.6](../datakit/changelog.md#cl-1.34.0) · [:octicons-beaker-24: Experimental](../datakit/index.md#experimental)

AWS Lambda 采集器是通过 AWS Lambda Extension 的方式采集 AWS Lambda 的指标与日志。

## 安装 {#installation}

### 添加 Datakit 层 {#layer}

- [通过 Zip 创建层](https://docs.aws.amazon.com/zh_cn/lambda/latest/dg/creating-deleting-layers.html#layers-create){:target="_blank"}

    - zip 下载地址：
        - amd64： <https://static.guance.com/datakit/datakit_aws_extension-linux-amd64.zip>
        - arm64：<https://static.guance.com/datakit/datakit_aws_extension-linux-arm64.zip>

    - 打开 Lambda 控制台的 [Layers page](https://console.amazonaws.cn/lambda/home#/layers){:target="_blank"}（层页面）。
    - 选择 **Create layer**（创建层）。
    - 在 **Layer configuration**（层配置）下，在 **Name**（名称）中，输入层的名称。
    - 请选择 **Upload a .zip file**（上传 .zip 文件）。然后，选择 **Upload**（上载）以选择本地 .zip 文件。
    - 选择 **Create**（创建）。

- [通过 ARN 添加层](https://docs.aws.amazon.com/zh_cn/lambda/latest/dg/adding-layers.html){:target="_blank"}

    - 打开 Lambda 控制台的[函数页面](https://console.amazonaws.cn/lambda/home#/functions){:target="_blank"}。
    - 选择要配置的函数。
    - 在**层**下，选择**添加层**。
    - 在**选择层**下，选择 **ARN** 层源。
    - 请在文本框中输入 ARN 并选择**验证**。然后，选择**添加**。

### 配置所需的环境变量

- ENV_DATAWAY=`https://openway.guance.com?token=<your-token>`

## 指标 {#metric}



### `awslambda-metric`

- 标签


| Tag | Description |
|  ----  | --------|
|`aws_account_id`|AWS Account ID.|
|`aws_lambda_function_memory_size`|Configured memory size for the Lambda function.|
|`aws_lambda_function_name`|Lambda function name.|
|`aws_lambda_function_version`|Lambda function version.|
|`aws_lambda_initialization_type`|Initialization type of the Lambda function.|
|`aws_region`|AWS region where the function is executed.|

- 指标列表


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

- 标签


| Tag | Description |
|  ----  | --------|
|`aws_log_from`|log sources, currently only function are supported|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`message`|Log message.|string|-|



### 采集器支持 {#input}

- OpenTelemetry
- statsd
- ddtrace # 目前只支持 golang。由于 ddtrace 在 lambda 环境下会有特殊操作，需要添加 `tracer.WithLambdaMode(false)`。
