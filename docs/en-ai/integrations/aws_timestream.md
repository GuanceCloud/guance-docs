---
title: 'AWS Timestream'
tags: 
  - AWS
summary: 'The metrics displayed by AWS Timestream include the number of system errors (internal service errors), the sum of invalid requests for the current AWS region and account, the elapsed time and sample count of successful requests, the amount of data stored in memory, and the amount of data stored on magnetic storage.'
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


The metrics displayed by AWS **Timestream** include the number of system errors (internal service errors), the sum of invalid requests for the current AWS region and account, the elapsed time and sample count of successful requests, the amount of data stored in memory, and the amount of data stored on magnetic storage.

## Configuration {#config}

### Install Func

We recommend enabling Guance integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare an Amazon Cloud AK that meets the requirements (for simplicity, you can directly grant `CloudWatchReadOnlyAccess` permissions)

To synchronize monitoring data from AWS **Timestream**, we install the corresponding collection script: 「Guance Integration (AWS-**Timestream** Collection)」(ID: `guance_aws_timestream`)

After clicking 【Install】, enter the required parameters: AWS AK ID, AWS AK SECRET, account_name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the startup scripts accordingly. Ensure that the 'regions' in the startup script match the actual regions of the instances.

Once enabled, you can see the corresponding automatic trigger configuration under 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect logs, enable the corresponding log collection script. If you need to collect billing information, enable the cloud billing collection script.


By default, we collect some configurations; for more details, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. Confirm in 「Management / Automatic Trigger Configuration」whether the corresponding tasks have been configured for automatic triggers, and check the task records and logs for any anomalies.
2. In the Guance platform, go to 「Infrastructure / Custom」to check if asset information exists.
3. In the Guance platform, go to 「Metrics」to check if the corresponding monitoring data exists.

## Metrics {#metric}

After configuring Amazon CloudWatch, the default metric set is as follows. You can collect more metrics through configuration:

[Amazon CloudWatch AWS **Timestream** Metrics Details](https://docs.aws.amazon.com/zh_cn/timestream/latest/developerguide/metrics-dimensions.html){:target="_blank"}


| Metric Name | Description | Unit | Valid Statistics |
| :---: | :---: | :---: | :---: |
| `SystemErrors` | Requests to **Timestream** that generated system errors during the specified time period. System errors usually indicate internal service errors. | Count | Sum, SampleCount (displayed as SampleCount in the Amazon **Timestream** console) |
| `UserErrors` | **Timestream** requests that generated InvalidRequest errors during the specified time period. InvalidRequest usually indicates client-side errors, such as invalid parameter combinations, attempts to update non-existent tables, or incorrect request signatures. UserErrors represent the sum of invalid requests for the current AWS region and account. | Count | Sum, SampleCount (displayed as SampleCount in the Amazon **Timestream** console) |
| `SuccessfulRequestLatency` | Successful requests to **Timestream** within the specified time period. SuccessfulRequestLatency can provide two types of information: the runtime of successful requests (Minimum, Maximum, Sum, or Average). The number of successful requests (SampleCount). SuccessfulRequestLatency only reflects activities within **Timestream**, not considering network latency or client activity. | Milliseconds | Average, Minimum, Maximum, Sum, SampleCount (displayed as SampleCount in the Amazon **Timestream** console) |
| `MemoryCumulativeBytesMetered` | Amount of data stored in memory, in bytes. | Bytes | Average |
| `MagneticCumulativeBytesMetered`| Amount of data stored on magnetic storage, in bytes. | Bytes | Average |