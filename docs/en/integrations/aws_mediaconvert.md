---
title: 'AWS MediaConvert'
tags: 
  - AWS
summary: 'AWS MediaConvert, including data transfer, video errors, job counts, padding, etc.'
__int_icon: 'icon/aws_mediaconvert'
dashboard:

  - desc: 'AWS MediaConvert built-in views'
    path: 'dashboard/en/aws_mediaconvert'

monitor:
  - desc: 'AWS MediaConvert monitors'
    path: 'monitor/en/aws_mediaconvert'

---

<!-- markdownlint-disable MD025 -->
# AWS MediaConvert
<!-- markdownlint-enable -->


AWS MediaConvert, including data transfer, video errors, job counts, padding, etc.


## Configuration {#config}

### Install Func

It is recommended to enable the <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data of AWS MediaConvert, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (AWS-MediaConvert Collection)" (ID: `guance_aws_mediaconvert`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK and Amazon account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script automatically.

In addition, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.



### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and you can check the corresponding task records and logs to see if there are any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, in "Infrastructure / Custom", check if asset information exists.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring AWS MediaConvert, the default metric set is as follows. You can collect more metrics through configuration. [AWS MediaConvert Metric Details](https://docs.amazonaws.cn/mediaconvert/latest/ug/what-is.html){:target="_blank"}

### Metrics

| TH | TH | TH |
| -- | -- | -- |
| `AvgBitrateBottom` | Average data transfer rate | B/S |
| `AvgBitrateTop` | Maximum data transfer rate | B/S |
| `BlackVideoDetectedRatio` | Black screen percentage | % |
| `BlackVideoDetected` | Black screen occurrence time | seconds |
| `Errors` | Number of video errors | count |
| `JobsCanceledCount` | Number of jobs canceled | count |
| `JobsCompletedCount` | Number of completed jobs | count |
| `JobsErroredCount` | Number of errored jobs | count |
| `QVBRAvgQualityHighBitrate` | Video variable bitrate | % |
| `SDOutputDuration` | Standard definition output detection | seconds |
| `StandbyTime` | Standby time | seconds |
| `VideoPaddingInsertedRatio` | Video padding ratio | % |
| `VideoPaddingInserted` | Whether video padding occurred | count |