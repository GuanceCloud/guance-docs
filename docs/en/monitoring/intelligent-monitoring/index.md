# Intelligent Monitoring
---

Intelligent monitoring provides a mechanism for quickly identifying abnormal nodes for business analysis, user behavior analysis, and root cause analysis of failures. It is suitable for business metrics and metrics with high volatility. By analyzing the scenarios, it constructs a key dimension for locating multidimensional metrics. After locating the business dimension, it quickly analyzes and identifies exceptions based on the service calls and resource dependencies within microservices. 

Monitoring is configured using detection rules such as [Host Detection](host-intelligent-detection.md), [Logs Detection](log-intelligent-monitoring.md), [APM Detection](application-intelligent-detection.md) and [RUM Detection](rum-intelligent-detection.md). Set the detection scope and notification recipients, and use intelligent detection algorithms to identify abnormal data and predict future trends.

**Notes**: In contrast to traditional monitoring modes, intelligent monitoring does not require configuring detection thresholds and triggering rules. It only requires setting the detection scope and notification recipients to enable monitoring with one click. It uses intelligent algorithms to identify and locate exceptions, and supports analysis and reporting of abnormal intervals.

The intelligent monitoring tool in the workspace can be accessed and managed through the **Intelligent Monitoring** feature of the cloud platform.

![](../img/intelligent-detection01.png)

## Usage Instructions

:material-numeric-1-circle: Data Storage

I. Due to the need for data transfer, the number of new timelines will be generated after enabling log and APM detection, that is, **the number of detection dimensions (Service, Source) filtered by the current monitoring configuration filter conditions * the number of detection metrics (premise: the metric is a valid value)**.

detection metrics:         

- Logs detection: `error_log_count`, `log_count`;
- APM detection: `p90`, `error_request_count`, `request_count`.

II. To reduce overheads, logs and APM detection transcription timelines adopt the minimum storage logic, only retaining the detection dimension, measurement name and detection metric, and do not store the monitor's filter conditions. Therefore, given the current storage transcription logic, if the monitor's filter conditions configuration is changed, a new timeline will be generated, so there may be duplicate timeline charges on the day the monitor's filter conditions configuration is changed, and it will take effect immediately after the modification.

III. To improve algorithm accuracy and achieve the best detection effect, please **set the metric storage cycle to a maximum of 30 days before enabling intelligent monitoring (default configuration is 7 days)**.

IV. If you need to view the metric data (Metric) transcribed by log and application intelligent detection, you can go to the current monitoring alert event > Extend Fields > `df_event_report` > report content > `smart_monitor_metric:smart_apm_ff5cf0ea792f4bac72ca1afdcd431c82`.

<img src="../img/detail-report.png" width="70%" >


:material-numeric-2-circle: Algorithm Explanation: Intelligent monitoring uses the algorithm of the anomaly [ADTK](https://adtk.readthedocs.io/en/stable/install.html) based on time series.
    
This monitoring system compares the time series value with its previous time window value. If a value changes anomalously large compared to its previous average or median, then this time point is identified as an anomaly. At the same time, the system will calculate the expected normal range of the current detection dimension based on past data. This expected range is determined based on the time of day and a specific day of the week. In this way, the system can verify whether the anomalies detected by the data are truly valid.


## Setup {#new}

You can set detection rules for different monitoring scenarios using **Intelligent Monitoring**.

![](../img/intelligent-detection02.png)

### Detection Rules {#detect}

Currently, Guance supports three types of intelligent detection rules, each covering a different range of data.

| Rule Name | Data Range | Description |
| --- | --- | --- |
| Host Detection | Metrics(M)  | Automatically detect host anomalies using intelligent algorithms, including CPU and memory anomalies. |
| Logs Detection | Logs(L) | Automatically detect anomalies in logs using intelligent algorithms, including log count and error log count. |
| Application Detection](application-intelligent-detection.md) | Traces(T)  | Automatically detect anomalies in applications using intelligent algorithms, including request count, error request count, and request latency. |


|                   <font color=coral size=3>:fontawesome-regular-circle-down: &nbsp;**Learn More**</font>             |        |         
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| [Host Detection](host-intelligent-detection.md){ .md-button .md-button--primary } | [Logs Detection](log-intelligent-monitoring.md){ .md-button .md-button--primary } |
| [APM Detection](application-intelligent-detection.md){ .md-button .md-button--primary } | [RUM Detection](rum-intelligent-detection.md){ .md-button .md-button--primary } | 

### Billing

The host, logs, and APM detection are performed every 10 minutes, each detection is calculated as 10 triggers; each detection performed by user access intelligence is calculated as 100 triggers.

> See [How Triggers bill](../../billing/billing-method/billing-item.md#trigger).