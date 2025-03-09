# Intelligent Monitoring
---

Intelligent monitoring provides a mechanism for quickly identifying abnormal nodes for business analysis, user behavior analysis, and root cause analysis of faults. It is suitable for business-related metrics and highly volatile metrics. By building an analytical scenario to locate critical dimensions for multi-dimensional metrics; after pinpointing the dimensional scope of the business, it focuses on service calls and resource dependencies within microservices to rapidly identify and analyze anomalies.

Configure monitoring through various intelligent detection rules. Set the detection range and notification recipients, using intelligent detection algorithms to identify abnormal data and predict future trends.

**Note**: Unlike traditional monitoring models, intelligent monitoring does not require configuring detection thresholds or trigger rules. Simply set the detection range and notification recipients to enable monitoring with one click. Through intelligent algorithms, it identifies and locates anomalies, supporting analysis and reporting of abnormal intervals.

The intelligent monitors in the workspace can be viewed and managed via the <<< custom_key.brand_name >>> platform's **Intelligent Monitoring**.

## Usage Notes

:material-numeric-1-circle: Data Storage

1. Due to the need for data migration, enabling log and application intelligent detection will generate new time series based on the number of detected dimensions (Service, Source) filtered by the current monitoring configuration * the number of detection metrics (premise: metrics are valid).

Intelligent monitoring detection metrics:

- Log intelligent detection: Error log count (`error_log_count`), log count (`log_count`);
- Application intelligent detection: P90 latency (`p90`), error request count (`error_request_count`), request count (`request_count`).

2. To reduce overhead, log and application intelligent detection time series use minimal storage logic, retaining only the detection dimensions, measurement names, and detection metrics. Monitoring filter conditions are not stored. Therefore, if the monitoring filter conditions are modified, new time series will be generated, which may result in duplicate billing for time series on the day of modification. Changes take effect immediately.

3. To improve algorithm accuracy and achieve optimal detection results, **set the metric retention period to the maximum of 30 days (default is 7 days) before enabling intelligent monitoring**.

4. To view the metrics (Metrics) stored from log and application intelligent detection, go to Current Monitoring Alert Event > Extended Fields > `df_event_report` > Report Content > `smart_monitor_metric:smart_apm_ff5cf0ea792f4bac72ca1afdcd431c82`.

![Detail Report](../img/detail-report.png)

:material-numeric-2-circle: Algorithm Explanation: Intelligent monitoring uses the [ADTK](https://adtk.readthedocs.io/en/stable/install.html) library, which is based on time-series anomaly detection.

This monitoring system compares time series values with those from the previous time window. If a value shows an abnormally large change compared to its previous average or median, that time point is identified as an anomaly. Additionally, the system calculates the expected normal range for the current detection dimension based on past data. This expected range is determined by the time of day and day of the week. This way, the system can verify whether detected anomalies are truly valid.

## Rule Types {#detect}

Currently, <<< custom_key.brand_name >>> supports multiple intelligent detection rules, each covering different data ranges.

| <div style="width: 170px">Rule Name</div> | <div style="width: 120px">Data Range</div> | Basic Description |
| --- | --- | --- |
| [Host Intelligent Detection](./host-intelligent-detection.md) | Metrics (M) | Automatically detects host anomalies using intelligent algorithms, such as CPU and memory issues. |
| [Log Intelligent Detection](./log-intelligent-monitoring.md) | Logs (L) | Automatically detects anomalies in logs using intelligent algorithms, including log volume and error log counts. |
| [Application Intelligent Detection](./application-intelligent-detection.md) | Traces (T) | Automatically detects anomalies in applications using intelligent algorithms, including request volume, error requests, and request latency. |
| [User Access Intelligent Detection](./rum-intelligent-detection.md) | User Access Data (R) | Automatically detects anomalies in websites/APPs using intelligent algorithms, including page performance analysis, error analysis, and metrics like LCP, FID, CLS, Loading Time, etc. |
| [Kubernetes Intelligent Detection](./k8s.md) | Metrics (M) | Automatically detects anomalies in Kubernetes using intelligent algorithms, including total Pod count, Pod restarts, API QPS, etc. |
| [Cloud Billing Intelligent Monitoring](./cloud-bill-detection.md) | Cloud Billing (B) | Automatically detects anomalies in cloud accounts' billing fees using intelligent algorithms, including billing costs. |

## Configuration

1. Set corresponding detection conditions for different [detection rules](#detect);
2. Fill in [event notification](../monitor/monitor-rule.md#notice) content as needed;
3. Configure [alert strategies](../monitor/monitor-rule.md#alert);
4. Set [operation permissions](../monitor/monitor-rule.md#permission);
5. Click save.

## Billing Details

Host, log, and application intelligent detection runs every 10 minutes, with each execution counted as 10 API calls. User access intelligent detection is billed at 100 API calls per execution.

> For more details, see [Task Triggers](../../billing-method/billing-item.md#trigger).