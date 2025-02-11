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

We recommend enabling the Guance integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize SLS monitoring data, install the corresponding collection script: 「Guance Integration (Alibaba Cloud - Cloud Monitoring)」(ID: `guance_aliyun_monitor`)

After clicking 【Install】, enter the required parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Once enabled, you can see the corresponding automatic trigger configurations in 「Management / Automatic Trigger Configurations」. Click 【Execute】to run it immediately without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

> If you need to collect logs, enable the corresponding log collection script. If you need to collect billing data, enable the cloud billing collection script.

We have collected some configurations by default; see the Metrics section for details.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Verification

1. In 「Management / Automatic Trigger Configurations」, confirm whether the corresponding tasks have the automatic trigger configurations. You can also check the task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitoring Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id               | Metric Name              | Dimensions                                            | Statistics | Unit         |
| ---- | :---:                | :----:                                                | ----       | ----         |
| `AlarmIPCount`          | Error IP Count           | `userId,project,logstore,alarm_type,source_ip`        | Count      | Frequency    |
| `AlarmPV`               | Client Error Count       | `userId,project,logstore`                             | Sum        | Frequency    |
| `AlarmUV`               | Client Error Machine Count | `userId,project,logstore`                             | Count      | Frequency    |
| `ConsumerGroupFallBehind` | Consumer Lag Duration    | `userId,project,logstore,consumerGroup`               | Maximum    | Second       |
| `FailedLines`           | Client Parsing Failed Lines | `userId,project,logstore`                             | Sum        | Lines        |
| `InflowLine`            | Write Line Count         | `userId,project,logstore`                             | Sum        | Lines/Minute |
| `LogCodeQPS`            | Service Status           | `userId,project,logstore,status`                      | Count      | Count        |
| `LogInflow`             | Incoming Traffic         | `userId,project,logstore`                             | Sum        | bytes        |
| `LogMethodQPS`          | Operation Count          | `userId,project,logstore,method`                      | Count      | Count        |
| `LogOutflow`            | Outgoing Traffic         | `userId,project,logstore`                             | Sum        | bytes        |
| `NetFlow`               | Network Incoming Traffic | `userId,project,logstore`                             | Sum        | bytes        |
| `SuccessdByte`          | Client Parsing Success Traffic | `userId,project,logstore`                            | Sum        | bytes        |
| `SuccessdLines`         | Client Parsing Success Lines | `userId,project,logstore`                            | Sum        | Lines        |
| `SumQPS`                | Overall QPS              | `userId,project,logstore`                             | Count      | Count        |