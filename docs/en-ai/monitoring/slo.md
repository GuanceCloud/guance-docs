# SLO
---

In the cloud era, major service providers have issued relevant Service-Level Agreements (SLAs) to ensure the quality of services provided and clarify responsibilities. Guance SLO monitoring focuses on various DevOps Metrics, testing whether system service availability meets target needs. This not only helps users monitor the quality of services provided by vendors but also protects vendors from the impact of SLA violations.

## Concept Explanation

| Term      | Description                          |
| :--------- | :---------------------------------- |
| SLA       | Service-Level Agreement, which refers to the service commitment made by the system service provider (Provider) to the customer (Customer). You can rate the service quality SLA of the vendor and monitor the compliance rate in real-time.  |
| SLI       | Service Level Indicator, a measurement metric used to measure system stability. Guance SLI supports setting one or more measurement metrics based on monitors. |
| SLO   | Service Level Objective, the smallest unit for processing SLA ratings in Guance, representing the target number of successful SLI accumulations within a time window. SLOs are often converted into error budgets to calculate tolerable errors, with abnormal events during each detection cycle deducting from the allowable error duration. (For example: assuming an SLO detection cycle of 5 minutes, if abnormal events cover 3 minutes, the deduction is 3 minutes). |

![](img/image_4.png)

## Creating an SLO 

Navigate to **Monitors > SLO** and customize the creation of SLO tasks.

![](img/7.slo_2.png)

1. Name: The name of the SLO task. Supports up to 64 characters.
2. Detection Frequency: The frequency at which SLO checks occur, i.e., monitoring whether anomalies occur in the monitors within a certain time range. Currently supports 5 minutes, 10 minutes.
3. SLI: The uptime of monitors will be used as a metric to measure system stability. Thus, you can add one or more monitors as measurement metrics.
4. Compliance Rate: The target percentage (0-100%) of the SLO, using a 7-day reference period.
    - Target: When **Minimum Target Percentage >= Compliance Rate < Target Percentage**, it is considered that the SLA is unhealthy, generating a **Warning** event;
    - Minimum Target: When **Compliance Rate < Minimum Target Percentage**, it is considered that the SLA is non-compliant, generating an **Urgent** event.
5. Alert Policy: After selecting an associated [alert policy](alert-setting.md), corresponding alert notifications will be sent once an anomaly is detected.
6. Description: Descriptive information, supporting up to 256 characters.

**Note**: Once SLO configuration is saved, the SLO name, target, and detection cycle cannot be changed.

When creating or editing an SLO task, you can also add [tags](../management/global-label.md) in the top-left corner for the current task, achieving data linkage within the current workspace via global tags.

![](img/slo_tag.png)

## SLO List

In the workspace's **Monitors > SLO**, you can view all SLO monitoring tasks' metrics data under the current workspace, including associated monitors, targets, downtime, compliance rates, error budgets, etc., and perform operations such as enabling, disabling, editing, viewing related events, exporting dashboards, etc.

![](img/5.slo_1.png)

### List Fields

| <div style="width: 110px">Field</div> | Description |
| --- | --- |
| Monitor | The number of monitors associated with the SLI, i.e., metrics measuring service performance. |
| Target | The target percentage of service availability set when creating the SLO task. |
| Compliance Rate (7 days) | The percentage of time the system was free of anomalies during the evaluation period (Compliance Rate = System Anomaly-Free Time / Evaluation Period * 100%):<br><li>When Minimum Target Percentage <= Percentage < Target Percentage, it is considered SLA **Unhealthy**, displayed as an orange compliance rate;<br><li>When Percentage < Minimum Target Percentage, it is considered SLA **Non-Compliant**, displayed as a red compliance rate. |
| Downtime (7 days) | The downtime of the monitor / used budget. |
| Error Budget (7 days) | The remaining tolerable error time for the current SLO (assuming the target SLO is set to 95%, meaning there is a 5% tolerance rate, defaulting to a 7-day period, i.e., default: Error Budget = 7 days * 5% = 21 minutes), displayed as:<br><li>Green: Remaining tolerable error time >= 0;<br><li>Red: Remaining tolerable error time < 0. |

### Operation Instructions

- Search Bar: In the SLO list, you can search for SLOs by name.
- Batch Operations: You can batch **Enable**, **Disable**, or **Delete** specific SLOs.
- Enable/Disable: New SLOs are enabled by default; you can choose to disable an SLO or re-enable a disabled SLO.
- Edit: Supports re-editing existing SLO tasks; however, the SLO name, target, and detection frequency cannot be modified.

- Delete: Supports deleting existing SLO tasks.
    - **Note**: Deleting an SLO task may cause its associated dashboard SLO data to become invalid.

- View Related Events: Alert events triggered by SLO tasks are stored uniformly under the corresponding task. Clicking can directly navigate to all unresolved events triggered by the SLO task.

- Export to Dashboard: Supports exporting SLO monitoring tasks as views to the **Dashboard** for synchronized SLO monitoring in the dashboard.
    - **Note**: The time range of the SLO view in the dashboard defaults to align with the dashboard, while the SLO list defaults to calculating the SLO compliance rate for the past 7 days.

## SLO Details

Guance supports viewing detailed SLO information by clicking on an SLO task, including SLO compliance rates and SLI anomaly records.

![](img/image_6.png)

| Field | Description |
| --- | --- |
| Past 7 Days SLA | Compliance rate for the past 7 days based on the current access time. |
| Annual SLA | Compliance rate for this year (calendar year) based on the current access time. |
| Last Year SLA | Compliance rate for the last year (calendar year) based on the current access time. |
| SLI Anomaly Records | Anomalies triggered by monitors under the current SLO task. |

???+ abstract "Obtaining SLO via DQL Expression"

    Abnormal time reference query:

    `df_slo_cost` represents **deducted minutes**, summing the values gives the **abnormal time**. Replace `df_slo_id` accordingly:

    ```
    E::`slo`:(sum(`df_slo_costslo_cost`)) { `df_slo_id` = 'monitor_c36bb56f274b4242866fe7259f1859c0' }
    ```

    If querying the SLO value for 7 days, the DQL expression is as follows:

    ```
    eval((10080-A)/10080 *100, A="E::`slo`:(sum(`df_slo_cost`)) { `df_slo_id` = 'monitor_c36bb56f274b4242866fe7259f1859c0'}")
    ```

    <u>Example:</u>

    In the following figure, the SLO value for the past 7 days of the SLO task is `80.496%`.

    <img src="../img/slo-1.png" width="60%" >

    Navigate to **Shortcut > Query Tool**, select **DQL Query**, enter the query statement for the 7-day SLO value, and the query result matches the value shown above.

    <img src="../img/slo-2.png" width="60%" >

    :warning: When using **Query Tool > DQL Query**, ensure the time range in the top-right corner matches the time range for obtaining the SLO value; `slo_id` can be viewed in the **Events > Event Details Page**:

    <img src="../img/slo-3.png" width="60%" >