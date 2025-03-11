---
title: 'AWS Timestream'
tags: 
  - AWS
summary: 'The metrics displayed for AWS Timestream include the number of system errors (internal service errors), the total number of invalid requests for the current AWS region and account, the elapsed time and sample count of successful requests, the amount of data stored in memory, and the amount of data stored on magnetic storage.'
__int_icon: 'icon/aws_timestream'
dashboard:

  - desc: 'Built-in views for AWS Timestream'
    path: 'dashboard/en/aws_timestream'

monitor:
  - desc: 'Monitors for AWS Timestream'
    path: 'monitor/en/aws_timestream'

---

<!-- markdownlint-disable MD025 -->
# AWS **Timestream**
<!-- markdownlint-enable -->


The metrics displayed for AWS **Timestream** include the number of system errors (internal service errors), the total number of invalid requests for the current AWS region and account, the elapsed time and sample count of successful requests, the amount of data stored in memory, and the amount of data stored on magnetic storage.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func manually, refer to [Manual Func Deployment](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Prepare an Amazon Cloud AK that meets the requirements (for simplicity, you can directly grant `CloudWatchReadOnlyAccess` read-only permissions).

To synchronize monitoring data from AWS **Timestream**, install the corresponding collection script: "Guance Integration (AWS-**Timestream** Collection)" (ID: `guance_aws_timestream`).

After clicking 【Install】, enter the required parameters: AWS AK ID, AWS AK SECRET, account_name.

Click 【Deploy Startup Script】. The system will automatically create a `Startup` script set and configure the startup scripts accordingly. Ensure that the 'regions' in the startup script match the actual regions where your instances are located.

Once enabled, you can view the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

> If you need to collect logs, enable the corresponding log collection script. If you need to collect billing data, enable the cloud billing collection script.

By default, we collect some configurations; see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"} for details.

### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have been configured for automatic triggers and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if the corresponding monitoring data exists.

## Metrics {#metric}

After configuring Amazon Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration:

[Amazon Cloud Monitoring AWS **Timestream** Metric Details](https://docs.aws.amazon.com/zh_cn/timestream/latest/developerguide/metrics-dimensions.html){:target="_blank"}

| Metric Name | Description | Unit | Valid Statistics |
| :---: | :---: | :---: | :---: |
| `SystemErrors` | Requests to **Timestream** that generate system errors within a specified time period. System errors typically indicate internal service errors. | Count | Sum, SampleCount (displayed as SampleCount in the Amazon **Timestream** console) |
| `UserErrors` | **Timestream** requests that generate InvalidRequest errors within a specified time period. InvalidRequest usually indicates client-side errors, such as invalid parameter combinations, attempts to update non-existent tables, or incorrect request signatures. UserErrors represent the total number of invalid requests for the current AWS region and account. | Count | Sum, SampleCount (displayed as SampleCount in the Amazon **Timestream** console) |
| `SuccessfulRequestLatency` | Successful requests to **Timestream** within a specified time period. SuccessfulRequestLatency can provide two types of information: the runtime of successful requests (Minimum, Maximum, Sum, or Average). The number of successful requests (SampleCount). SuccessfulRequestLatency only reflects activity within **Timestream**, not network latency or client activity. | Milliseconds | Average, Minimum, Maximum, Sum, SampleCount (displayed as SampleCount in the Amazon **Timestream** console) |
| `MemoryCumulativeBytesMetered` | Amount of data stored in memory, in bytes. | Bytes | Average |
| `MagneticCumulativeBytesMetered` | Amount of data stored on magnetic storage, in bytes. | Bytes | Average |
