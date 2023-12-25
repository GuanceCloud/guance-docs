# Intelligent Monitoring
---

Intelligent monitoring provides a mechanism for quickly identifying abnormal nodes for business analysis, user behavior analysis, and root cause analysis of failures. It is suitable for business metrics and metrics with high volatility. By analyzing the scenarios, it constructs a key dimension for locating multidimensional metrics. After locating the business dimension, it quickly analyzes and identifies exceptions based on the service calls and resource dependencies within microservices. 

Monitoring is configured using detection rules such as [Host Detection](host-intelligent-detection.md), [Logs Detection](log-intelligent-monitoring.md), and [Application Detection](application-intelligent-detection.md). Set the detection scope and notification recipients, and use intelligent detection algorithms to identify abnormal data and predict future trends.

**Notes**: In contrast to traditional monitoring modes, intelligent monitoring does not require configuring detection thresholds and triggering rules. It only requires setting the detection scope and notification recipients to enable monitoring with one click. It uses intelligent algorithms to identify and locate exceptions, and supports analysis and reporting of abnormal intervals.

The intelligent monitoring tool in the workspace can be accessed and managed through the **Intelligent Monitoring** feature of the cloud platform.

![image](../img/intelligent-detection01.png)

## Setup {#new}

You can set detection rules for different monitoring scenarios using **Intelligent Monitoring**.

![](../img/intelligent-detection02.png)

### Detection Rules {#detect}

Currently, Guance supports three types of intelligent detection rules, each covering a different range of data.

| Rule Name | Data Range | Description |
| --- | --- | --- |
| Host Detection | Metrics(M)  | Automatically detect host anomalies using intelligent algorithms, including CPU and memory anomalies. |
| Logs Detection | Logs(L) | Automatically detect anomalies in logs using intelligent algorithms, including log count and error log count. |
| Application Detection | Traces(T)  | Automatically detect anomalies in applications using intelligent algorithms, including request count, error request count, and request latency. |


|                   <font color=coral size=3>:fontawesome-regular-circle-down: &nbsp;**Learn More**</font>                         |                                                              |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| [Host Detection](host-intelligent-detection.md){ .md-button .md-button--primary } | [Logs Detection](log-intelligent-monitoring.md){ .md-button .md-button--primary } | [Application Detection](application-intelligent-detection.md){ .md-button .md-button--primary } |

### Billing

The intelligent monitoring performs 100 detections for each execution.

> See [How Triggers bill](../../billing/billing-method/billing-item.md#trigger).