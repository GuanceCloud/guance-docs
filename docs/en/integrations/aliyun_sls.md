---
title: 'Alibaba Cloud SLS'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud SLS metrics display, including service status, log traffic, operation counts, overall QPS, etc.'
__int_icon: 'icon/aliyun_sls'
dashboard:
  - desc: 'Built-in views for Alibaba Cloud SLS'
    path: 'dashboard/en/aliyun_sls/'

---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud SLS
<!-- markdownlint-enable -->

Alibaba Cloud SLS metrics display, including service status, log traffic, operation counts, overall QPS, etc.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize SLS monitoring data, install the corresponding collection script: 「Guance Integration (Alibaba Cloud - Cloud Monitoring)」(ID: `guance_aliyun_monitor`)

After clicking 【Install】, enter the required parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Once enabled, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

> If you need to collect logs, enable the corresponding log collection script. If you need to collect billing data, enable the cloud billing collection script.

We default to collecting some configurations; see the Metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the corresponding automatic trigger configurations. You can also check the task records and logs for any abnormalities.
2. On the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitoring, the default metric set is as follows. More metrics can be collected through configuration. [Alibaba Cloud Cloud Monitoring Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id               | Metric Name           | Dimensions                                        | Statistics | Unit         |
| ----------------------- | --------------------- | ------------------------------------------------- | ---------- | ------------ |
| `AlarmIPCount`          | Error IP Count        | `userId,project,logstore,alarm_type,source_ip`     | Count      | Frequency    |
| `AlarmPV`               | Client Error Count    | `userId,project,logstore`                         | Sum        | Frequency    |
| `AlarmUV`               | Client Error Machine Count | `userId,project,logstore`                        | Count      | Frequency    |
| `ConsumerGroupFallBehind` | Consumer Lag Time   | `userId,project,logstore,consumerGroup`            | Maximum    | Second       |
| `FailedLines`           | Client Parse Failed Lines | `userId,project,logstore`                        | Sum        | Lines        |
| `InflowLine`            | Write Line Count      | `userId,project,logstore`                         | Sum        | Lines/Minute |
| `LogCodeQPS`            | Service Status        | `userId,project,logstore,status`                  | Count      | Count        |
| `LogInflow`             | Inbound Traffic       | `userId,project,logstore`                         | Sum        | Bytes        |
| `LogMethodQPS`          | Operation Count       | `userId,project,logstore,method`                  | Count      | Count        |
| `LogOutflow`            | Outbound Traffic      | `userId,project,logstore`                         | Sum        | Bytes        |
| `NetFlow`               | Network Inbound Traffic | `userId,project,logstore`                        | Sum        | Bytes        |
| `SuccessdByte`          | Client Parse Success Traffic | `userId,project,logstore`                       | Sum        | Bytes        |
| `SuccessdLines`         | Client Parse Success Lines | `userId,project,logstore`                       | Sum        | Lines        |
| `SumQPS`                | Total QPS             | `userId,project,logstore`                         | Count      | Count        |
