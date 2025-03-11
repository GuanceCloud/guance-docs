---
title: 'AWS MediaConvert'
tags: 
  - AWS
summary: 'AWS MediaConvert, including data transfer, video errors, job counts, padding, etc.'
__int_icon: 'icon/aws_mediaconvert'
dashboard:

  - desc: 'Built-in views for AWS MediaConvert'
    path: 'dashboard/en/aws_mediaconvert'

monitor:
  - desc: 'Monitors for AWS MediaConvert'
    path: 'monitor/en/aws_mediaconvert'

---

<!-- markdownlint-disable MD025 -->
# AWS MediaConvert
<!-- markdownlint-enable -->


AWS MediaConvert, including data transfer, video errors, job counts, padding, etc.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize monitoring data from AWS MediaConvert, we install the corresponding collection script: "Guance Integration (AWS-MediaConvert Collection)" (ID: `guance_aws_mediaconvert`).

After clicking 【Install】, enter the required parameters: Amazon AK and Amazon account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Additionally, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if there is any asset information.
3. On the Guance platform, under "Metrics", check if there is any corresponding monitoring data.

## Metrics {#metric}
After configuring AWS MediaConvert, the default metric set is as follows. You can collect more metrics through configuration [AWS MediaConvert Metrics Details](https://docs.amazonaws.cn/mediaconvert/latest/ug/what-is.html){:target="_blank"}

### Metrics

| TH | TH | TH |
| -- | -- | -- |
| `AvgBitrateBottom` | Average data transfer rate | B/S |
| `AvgBitrateTop` | Maximum data transfer rate | B/S |
| `BlackVideoDetectedRatio` | Black screen percentage | % |
| `BlackVideoDetected` | Black screen occurrence time | seconds |
| `Errors` | Number of video errors | count |
| `JobsCanceledCount` | Number of canceled jobs | count |
| `JobsCompletedCount` | Number of completed jobs | count |
| `JobsErroredCount` | Number of errored jobs | count |
| `QVBRAvgQualityHighBitrate` | Video variable bitrate | % |
| `SDOutputDuration` | Standard definition output detection | seconds |
| `StandbyTime` | Standby time | seconds |
| `VideoPaddingInsertedRatio` | Video padding ratio | % |
| `VideoPaddingInserted` | Whether video padding occurred | count |
