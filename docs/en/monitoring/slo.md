# SLO
---

## Overview

Under the background of cloud era, all major service providers have issued relevant service level agreements (SLA) to ensure the quality of services provided and clarify their rights and responsibilities. Guance SLO monitoring is to test whether the availability of system services meets the target needs around various metrics of DevOps, which can not only help users monitor the service quality provided by service providers, but also protect service providers from SLA violations.

## Nouns Explanation 

**SLA（Service-Level Agreement）**: That is, service level agreement, which refers to a service commitment made by the system service Provider to the Customer. Guance supports SLA scoring of service quality of service providers and monitors the service compliance rate in real time.

**SLI（Service Level Metric）**: A measurement metric that is chosen to measure the stability of the system. The Guance SLI supports setting one or more measurement metrics based on the monitor.

**SLO（Service Level Objective）:** The smallest unit of SLA scoring processing in Guance, and is the target of SLI cumulative success number in a time window. We often convert SLO into error budget, which is used to calculate the number of tolerable errors, and the time of abnormal events in each detection cycle will be deducted from the fault-tolerant time. (As shown in the following figure: Assuming that the SLO detection period is 5 minutes, according to the superposition, the coverage time of abnormal events is 3 minutes, and the deduction amount is 3 minutes)

![](img/image_4.png)

## New SLO

Guance supports custom creation of new SLO tasks through the SLO module of "Monitor".

![](img/7.slo_2.png)

???+ warning

    Once the SLO configuration is saved, the SLO name, target, and detection period cannot be changed.

| **Field** | **Description** |
| --- | --- |
| Name | SLO task name. Supports up to 64 character input. |
| Goal | Percentage of SLO goals (0-100%), which supports the selection of two goals, including "goal" and "minimum goal",<br><li>Goal: SLO Percentage < Goal Percentage and > = Minimum Goal Percentage is identified as **unhealthy** SLA<br><li>Minimum target: When the SLO percentage is less than the minimum target percentage, it is considered as **substandard ** SLA |
| SLI | An metric to measure the stability of a system. Support user-defined addition of one or more monitors as measurement metrics |
| Exception Notification Object | Alarm notification object, support space members, mail groups, enterprise WeChat robots, Dingding robots, flying book robots, SMS and other notification methods. For details, please refer to [alarm settings](alert-setting.md) |
| Notice Silence | If the same event is not very urgent, but the alarm notification frequency is high, the notification frequency can be reduced by setting the notification silence. **Note: Events will continue to be generated after notification silence is set, but notifications will not be sent again, and generated events will be stored in event management** |
| Detection frequency | SLO detection frequency, that is, to monitor whether abnormal events occur in the monitor of SLO task with a certain time range as a period. At present, it supports two detection frequencies: 5 minutes and 10 minutes. |
| Description | Descriptive information, up to 256 characters. |

## SLO List

In the "Monitor"-"SLO" of the workspace, you can view the task compliance rate, target service level, etc. of existing SLO monitoring tasks, edit tasks, view related events and export dashboards.

### Query

The SLO list supports searching based on the SLO name in the search box.

![](img/monitor6.png)

### List Field
| **Field** | **Description** |
| --- | --- |
| Monitor | The number of monitors associated with the SLI, a measure of service performance |
| Examination cycle | The measurement period of the metric. Recent 7 days by default|
| Compliance rate | The percentage of the total time to meet the system abnormality in a given assessment period (compliance rate = system abnormality time/assessment period * 100%)<li>When the percentage < target percentage, and > = minimum target percentage, it is identified as **unhealthy** SLA, which is shown as yellow compliance rate <li>Minimum target: When the percentage is less than the minimum target percentage, it is identified as **non-compliance** SLA, which is displayed as red compliance rate
 |
| Remaining quota | The remaining fault-tolerant time of the current SLO (assuming that the target SLO is set to 95%, that is, there is a fault-tolerant rate of 5%, and the last 7 days are the cycle by default, that is, the default remaining quota = 7 days * 5% = 21 minutes) is displayed as<li> green: remaining fault-tolerant time > = 0<li>red: remaining fault-tolerant time > 0 |
| Objectives | Target percentage of service availability set when creating SLO task |


### Operating Instructions

| **Operation** | **Description** |
| --- | --- |
| Edit | Guance supports re-editing of existing SLO tasks, but does not support modification of SLO name, target and detection period |
| Delete | Guance supports deletion of existing SLO tasks<br>**Note**: Deletion of an SLO task may invalidate its associated Dashboard SLO data |
| View related events | The alarm events triggered by the SLO task will be uniformly stored under the corresponding "SLO" task, and all the unrecovered events triggered by the SLO task can be directly jumped through the "View Related Events" operation |
| Export to dashboard | Guance supports exporting SLO as view to dashboard |


## SLO Details

Guance enables you to view SLO details, including SLO compliance rates and SLI exception records, by clicking on the SLO task.
![](img/image_6.png)

| **Field** | **Description** |
| --- | --- |
| SLA in the past 7 days | Get the compliance rate of nearly 7 days according to the current visit time |
| Annual SLA | Get the compliance rate of this year (natural year) according to the current visit time |
| SLA in recent year | Get the compliance rate of the last year (natural year) according to the current visit time |
| SLI Exception Record | Based on the abnormal event triggered by the monitor under the current SLO task |


## Export to Dashboard

In the SLO list, you support exporting SLO monitoring tasks as views to the dashboard to help you synchronize SLO monitoring on the dashboard.

???+ attention
    
    The time range of the SLO view in the dashboard is consistent with that of the dashboard by default, while the SLO list calculates the last 7-day SLO compliance rate by default.
