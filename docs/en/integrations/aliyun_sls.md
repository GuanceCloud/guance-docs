---
title: 'Alibaba Cloud SLS'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud SLS Metrics display, including service status, log traffic, number of operations, total QPS, etc.'
__int_icon: 'icon/aliyun_sls'
dashboard:
  - desc: 'Alibaba Cloud SLS built-in views'
    path: 'dashboard/en/aliyun_sls/'

---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud SLS
<!-- markdownlint-enable -->

Alibaba Cloud SLS Metrics display, including service status, log traffic, number of operations, total QPS, etc.


## Configuration {#config}

### Install Func

It is recommended to enable the <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize SLS monitoring data, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Alibaba Cloud - Cloud Monitor)" (ID: `guance_aliyun_monitor`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, you also need to enable the corresponding log collection script. If you need to collect billing information, you need to enable the cloud billing collection script.

We default collect some configurations, details see the metrics section.



[Configure custom cloud object metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and check the corresponding task records and logs for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, in "Infrastructure / Custom", check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, in "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitor, the default metric set is as follows. You can collect more metrics through configuration [Alibaba Cloud Cloud Monitor Metrics Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id               |    Metric Name     |                  Dimensions                  | Statistics | Unit         |
| ---- | :---:    | :----: | ---- | ---- |
| `AlarmIPCount`          |   Error Occurring IP Statistics   | `userId,project,logstore,alarm_type,source_ip` | Count      | Frequency    |
| `AlarmPV`               |   Client-side Error Count   |           `userId,project,logstore`           | Sum        | Frequency    |
| `AlarmUV`               |  Number of Client-side Error Machines  |           `userId,project,logstore`           | Count      | Frequency    |
| `ConsumerGroupFallBehind` |    Consumer Lag Duration    |    `userId,project,logstore,consumerGroup`    | Maximum    | Second       |
| `FailedLines`           | Number of Client-side Parsing Failed Lines |           `userId,project,logstore`           | Sum        | Lines        |
| `InflowLine`            |      Number of Written Lines      |           `userId,project,logstore`           | Sum        | Lines/Minute |
| `LogCodeQPS`            |      Service Status      |        `userId,project,logstore,status`        | Count      | Count        |
| `LogInflow`             |      Incoming Traffic      |           `userId,project,logstore`           | Sum        | bytes        |
| `LogMethodQPS`          |      Number of Operations      |        `userId,project,logstore,method`        | Count      | Count        |
| `LogOutflow`            |      Outgoing Traffic      |           `userId,project,logstore`           | Sum        | bytes        |
| `NetFlow`               |    Network Incoming Traffic    |           `userId,project,logstore`           | Sum        | bytes        |
| `SuccessdByte`          | Client-side Successfully Parsed Traffic |           `userId,project,logstore`           | Sum        | bytes        |
| `SuccessdLines`         | Client-side Successfully Parsed Lines |           `userId,project,logstore`           | Sum        | Lines        |
| `SumQPS`                |      Total QPS       |           `userId,project,logstore`           | Count      | Count        |