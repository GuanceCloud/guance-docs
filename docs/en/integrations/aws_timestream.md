---
title: 'AWS Timestream'
tags: 
  - AWS
summary: 'The displayed metrics of AWS Timestream include the number of system errors (internal service errors), the total number of invalid requests for the current AWS region and account, the elapsed time and sample count of successful requests, the amount of data stored in memory, and the amount of data stored on magnetic storage, etc.'
__int_icon: 'icon/aws_timestream'
dashboard:

  - desc: 'AWS Timestream built-in views'
    path: 'dashboard/en/aws_timestream'

monitor:
  - desc: 'AWS Timestream monitors'
    path: 'monitor/en/aws_timestream'

---

<!-- markdownlint-disable MD025 -->
# AWS **Timestream**
<!-- markdownlint-enable -->


The displayed metrics of AWS **Timestream** include the number of system errors (internal service errors), the total number of invalid requests for the current AWS region and account, the elapsed time and sample count of successful requests, the amount of data stored in memory, and the amount of data stored on magnetic storage, etc.

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - managed Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func manually, refer to [Manual Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare an Amazon Cloud AK that meets the requirements in advance (for simplicity, you can directly grant `CloudWatchReadOnlyAccess` permission to CloudWatch).

To synchronize monitoring data for AWS **Timestream**, we install the corresponding collection script: 「Guance Integration (AWS-**Timestream** Collection)」(ID: `guance_aws_timestream`).

After clicking 【Install】, input the corresponding parameters: AWS AK ID, AWS AK SECRET, account_name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script. In the startup script, ensure that 'regions' matches the actual regions where the instances are located.

Once enabled, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to immediately run it without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

> To collect corresponding logs, you need to enable the corresponding log collection script. If you want to collect billing information, you need to enable the cloud billing collection script.


We collect some configurations by default; for details, see [Configuration of Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the corresponding automatic trigger configurations. You can also check the corresponding task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if there are corresponding monitoring data.

## Metrics {#metric}

After configuring Amazon CloudWatch, the default metric set is as follows. More metrics can be collected through configuration:

[Amazon CloudWatch AWS **Timestream** Metric Details](https://docs.aws.amazon.com/zh_cn/timestream/latest/developerguide/metrics-dimensions.html){:target="_blank"}


| Metric Name | Description | Unit | Valid Statistics |
| :---: | :---: | :---: | :---: |
| `SystemErrors` | Requests to **Timestream** that generate system errors within the specified time period. System errors usually indicate internal service errors. | Count | Sum Total, SampleCount Data Samples (displayed as Sample Count in the Amazon **Timestream** console) |
| `UserErrors` | **Timestream** requests that generate InvalidRequest errors within the specified time period. InvalidRequest typically indicates client-side errors, such as invalid parameter combinations, attempts to update non-existent tables, or incorrect request signatures. UserErrors represent the total number of invalid requests for the current AWS region and account. | Count | Sum Total, SampleCount Data Samples (displayed as Sample Count in the Amazon **Timestream** console) |
| `SuccessfulRequestLatency` | Successful requests to **Timestream** within the specified time period. SuccessfulRequestLatency can provide two types of information: the runtime of successful requests (Minimum, Maximum, Sum, or Average). The number of successful requests (SampleCount). SuccessfulRequestLatency only reflects activities within **Timestream** and does not consider network latency or client activity. | Milliseconds | Average, Minimum, Maximum, Sum, SampleCount Data Samples (displayed as Sample Count in the Amazon **Timestream** console) |
| `MemoryCumulativeBytesMetered` | Amount of data stored in memory, measured in bytes. | Bytes | Average |
| `MagneticCumulativeBytesMetered` | Amount of data stored on magnetic storage, measured in bytes. | Bytes | Average |