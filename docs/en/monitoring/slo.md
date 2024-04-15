# SLO
---

In the context of the cloud era, major service providers have released Service Level Agreements (SLAs) to ensure the quality of the services provided and clarify rights and responsibilities. Guance SLO monitoring is **based on various DevOps metrics to test whether the availability of the system services meets the target requirements**. This not only helps users monitor the quality of services provided by service providers, but also protects service providers from the impact of SLA violations.

## Concepts

| Term | Description |
| --- | --- |
| SLA | Service-Level Agreement, which refers to the commitment of system service providers (Providers) to customers (Customers). You can rate the service quality SLA of service providers and monitor the compliance rate of the service in real time. |
| SLI | Service Level Indicator, which refers to the measurement indicator used to measure system stability. Guance SLI supports setting one or more measurement indicators based on monitors. |
| SLO | Service Level Objective, the smallest unit for handling SLA rating in Guance, is the target for the cumulative number of successful SLIs within a time window. We often convert SLO into an error budget to calculate the acceptable number of errors, and the time of abnormal events that occur in each detection period will be deducted from the fault-tolerant duration. (As shown in the figure below: assuming the SLO detection period is 5 minutes, according to the superposition, the coverage time of abnormal events is 3 minutes, and the deduction limit is 3 minutes). |

![](img/image_4.png)

## Setup

Guance supports creating new SLO tasks through the SLO module of the monitor.

![](img/7.slo_2.png)

- Name: SLO task name. Support up to 64 characters. 

- Target: SLO target percentage (0-100%), support selecting two targets, including Target and Minimum target: 

    - Target: When the SLO percentage is less than the target percentage and greater than or equal to the minimum target percentage, it is considered as an <u>unhealthy</u> SLA. 
    - Minimum target: When the SLO percentage is less than the minimum target percentage, it is considered as an <u>unqualified</u> SLA. 

- SLI: The normal running time of the monitor will be used as the indicator to measure the system stability. You can customize adding one or more monitors as measurement indicators. 

- Exception Notice Receiver: Alert notification objects under [alerting strategies](alert-setting.md), supporting notification methods such as space members, email groups, WeCom, DingTalk and Lark bots and SMS. 

- Mute Notification: If an event is not very urgent but the alert notification frequency is high, you can reduce the notification frequency by setting mute notification.
    - **Note**: After muting notification is set, events will continue to occur, but notifications will not be sent, and the generated events will be stored in [Event](../events/index.md). 

- Detection Frequency: SLO detection frequency, that is, within a certain time range as a cycle, monitor whether there are abnormal events in the monitors in the SLO task. Currently, two detection frequencies of 5 minutes and 10 minutes are supported. 

- Description: Descriptive information, support up to 256 characters. 

**Note**: Once the SLO configuration is saved, the SLO name, target and detection period cannot be changed.

## SLO List

In the **Monitor > SLO** of the workspace, you can view the compliance rate of existing SLO monitoring tasks, the target service level, etc., and also edit tasks, view related events, and export dashboards.

![](img/5.slo_1.png)

### List Fields

| Field | Description |
| --- | --- |
| Monitor | The number of monitors associated with SLIs, which measures the performance of services. |
| Compliance Rate | The percentage of time without abnormal system time in the given assessment period (compliance rate = time without abnormal system time / assessment period * 100%):<br><li>When the minimum target percentage <= percentage < target percentage, it is considered as an unhealthy SLA, and the compliance rate is displayed in yellow; <br><li>When percentage < minimum target percentage, it is considered as an unqualified SLA, and the compliance rate is displayed in red. |  |
| Downtime | The time of monitor exceptions/used quota. |
| Remaining Quota | The remaining fault-tolerant duration of the current SLO (assuming the target SLO is set to 95%, that is, there is a 5% fault-tolerant rate, and the default period is the last 7 days, that is, the default remaining quota = 7 days * 5% = 21 minutes), displayed as:<br><li>Green: The remaining fault-tolerant duration is >= 0;<br><li>Red: The remaining fault-tolerant duration is < 0. |  
| Target | The target percentage of service availability set when creating the SLO task. |

### Options

- Search Bar: In the SLO list, you can search based on the SLO name. 

- Batch Operation: Click :material-crop-square: next to the Name to batch Enable, Disable, or Delete specific SLOs. 

- Enable/Disable: Guance supports enabling/disabling existing SLOs. Newly created SLOs are enabled by default. You can disable SLOs or restart disabled SLOs. 

- Edit: Guance supports re-editing existing SLO tasks, but does not support modifying the SLO name, target, and detection period. 

- Delete: Guance supports deleting existing SLO tasks. 

    - **Note**: Once an SLO task is deleted, the SLO data associated with its dashboard may become invalid. 

- View Related Events: Alert events triggered by SLO tasks are stored under the corresponding SLO task. By clicking View Related Events, you can directly jump to all unrecovered events triggered by this SLO task. 

- Export to Dashboard: Support exporting SLO monitoring tasks as views to Dashboards for synchronous SLO monitoring on the dashboards.
    
    - **Note**: The time range of the SLO view in the dashboard defaults to the same as that of the dashboard, while the SLO list defaults to calculating the compliance rate for the last 7 days. 

## SLO Details

Guance supports viewing SLO details by clicking on an SLO task, including SLO compliance rate and SLI exception records.

![img/image_6.png](img/image_6.png)

| Field | Description |
| --- | --- |
| SLA in the Past 7 Days | Obtains the compliance rate of the past 7 days based on the current access time. |
| SLA for the Whole Year | Obtains the compliance rate for this year (calendar year) based on the current access time. |
| SLA in the Past Year | Obtains the compliance rate for the past year (calendar year) based on the current access time. |
| SLI Exception Records | Exception events triggered by the monitors under the current SLO task. |

???- abstract "Obtaining SLOs by DQL Expressions"

    The query for obtaining exception time is as follows:

    `slo_cost` represents the **deducted number of minutes**, and the values are added together to obtain **the exception time**. `slo_id` needs to be replaced:

    ```
    M::`slo`:(sum(`slo_cost`)) { `slo_id` = 'monitor_c36bb56f274b4242866fe7259f1859c0' }
    ```

    If you want to query the SLO value for 7 days, the DQL expression is as follows:

    ```
    eval((10080-A)/10080 *100, A="M::`slo`:(sum(`slo_cost`)) { `slo_id` = 'monitor_c36bb56f274b4242866fe7259f1859c0'}")
    ```

    <u>Example:</u>

    In the figure below, the SLO value of the exception time in the past 7 days of the SLO task is `80.496%`.

    <img src="../img/slo-1.png" width="60%" >

    Go to **Quick Entry > Query Tool**, select **DQL Query**, enter the query statement for the SLO value of the 7-day period, and the query result is consistent with the value in the above figure.

    <img src="../img/slo-2.png" width="60%" >

    :warning: When using the **Query Tool > DQL Query**, ensure that the time range in the upper right corner is consistent with the time range for obtaining the SLO value; `slo_id` can be viewed in the **Events > Event Details** page:

    <img src="../img/slo-3.png" width="60%" >
