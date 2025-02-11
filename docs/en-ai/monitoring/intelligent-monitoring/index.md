# Intelligent Monitoring
---

Intelligent monitoring provides a mechanism for quickly identifying abnormal nodes, which is crucial for business analysis, user behavior analysis, and root cause analysis of faults. It is suitable for business-related metrics and highly volatile metrics. By building analytical scenarios, it enables critical dimension positioning for multi-dimensional metrics; after identifying the business dimensions, it rapidly analyzes anomalies by focusing on service calls and resource dependencies within microservices.

Configure intelligent monitoring with various smart detection rules. Set the detection scope and notification recipients, and use intelligent detection algorithms to identify abnormal data and predict future trends.

**Note**: Unlike traditional monitoring methods, intelligent monitoring does not require configuring detection thresholds or trigger rules. Simply set the detection scope and notification recipients to start monitoring instantly, using intelligent algorithms to identify and locate anomalies, supporting anomaly interval analysis and reporting.

Intelligent monitors in the workspace can be viewed and managed through the Guance platform's **Intelligent Monitoring**.

## Usage Notes

:material-numeric-1-circle: Data Storage

1. Due to the need for data conversion, enabling log and application intelligent detection will generate new Time Series based on the number of detected dimensions (Service, Source) filtered by the current monitoring configuration * the number of detection Metrics (premise: Metrics are valid).

Metrics for intelligent monitoring detection:

- Log Intelligent Detection: Error Log Count (`error_log_count`), Log Count (`log_count`);
- Application Intelligent Detection: P90 Latency (`p90`), Error Request Count (`error_request_count`), Request Count (`request_count`).

2. To reduce overhead, the Time Series generated from log and application intelligent detection uses minimal storage logic, retaining only the detection dimensions, Mearsurement names, and detection Metrics, without storing the monitor's filtering conditions. Therefore, if the monitor's filtering conditions are modified, new Time Series will be generated, potentially leading to duplicate billing for Time Series on the day of modification, which takes effect immediately.

3. To improve algorithm accuracy and achieve optimal detection results, **set the metric retention period to the longest 30 days (default configuration is 7 days) before enabling intelligent monitoring**.

4. To view the stored Metrics from log and application intelligent detection, go to Current Monitoring Alert Event > Extended Fields > `df_event_report` > Report Content > `smart_monitor_metric:smart_apm_ff5cf0ea792f4bac72ca1afdcd431c82`.

![Detail Report](../img/detail-report.png)

:material-numeric-2-circle: Algorithm Explanation: Intelligent monitoring uses the [ADTK](https://adtk.readthedocs.io/en/stable/install.html) library's time-series-based anomaly detection algorithm.

The system compares time series values with those from previous time windows. If a value changes significantly compared to its previous average or median, that time point is identified as an anomaly. Additionally, the system calculates the expected normal range for the current detection dimensions based on historical data, considering the time of day and day of the week. This allows the system to validate whether detected anomalies are truly valid.

## Rule Types {#detect}

Currently, Guance supports multiple intelligent detection rules, covering different data scopes.

| <div style="width: 170px">Rule Name</div> | <div style="width: 120px">Data Scope</div> | Basic Description |
| --- | --- | --- |
| [Host Intelligent Detection](./host-intelligent-detection.md) | Metrics (M) | Automatically detects host anomalies using intelligent algorithms, including CPU and memory issues. |
| [Log Intelligent Detection](./log-intelligent-monitoring.md) | Logs (L) | Automatically detects anomalies in logs using intelligent algorithms, including log counts and error log counts. |
| [Application Intelligent Detection](./application-intelligent-detection.md) | Traces (T) | Automatically detects anomalies in applications using intelligent algorithms, including request counts, error request counts, and request latency. |
| [User Access Intelligent Detection](./rum-intelligent-detection.md) | User Access Data (R) | Automatically detects anomalies in websites/apps using intelligent algorithms, including page performance analysis, error analysis, and metrics such as LCP, FID, CLS, Loading Time, etc. |
| [Kubernetes Intelligent Detection](./k8s.md) | Metrics (M) | Automatically detects anomalies in Kubernetes using intelligent algorithms, including total Pod count, Pod restarts, API QPS, etc. |
| [Cloud Bill Intelligent Monitoring](./cloud-bill-detection.md) | Cloud Bill (B) | Automatically detects account billing anomalies across different cloud providers using intelligent algorithms, including billing costs. |

## Configuration Steps

1. Set corresponding detection conditions for different [detection rules](#detect);

2. Fill in [event notification](../monitor/monitor-rule.md#notice) content as needed;
3. Configure [alert policies](../monitor/monitor-rule.md#alert);
4. Set [operation permissions](../monitor/monitor-rule.md#permission);
5. Click Save.

## Billing Details

Host, log, and application intelligent detection run every 10 minutes, with each execution counting as 10 calls. User access intelligent detection counts as 100 calls per execution.

> For more details, see [Triggers](../../billing-method/billing-item.md#trigger).