# SLO
---

In the cloud era, major service providers all release relevant Service-Level Agreements (SLA) to ensure the quality of services provided and clarify responsibilities. <<< custom_key.brand_name >>> SLO monitoring revolves around various DevOps metrics, testing whether the system's service availability meets target requirements. This not only helps users monitor the quality of services provided by service providers but also protects service providers from the impact of SLA violations.

## Concepts

| Term      | Description                          |
| :--------- | :---------------------------------- |
| SLA       | Service-Level Agreement, a commitment made by a service provider (Provider) to its customers (Customer). You can rate the service quality SLA of the service provider, and monitor the compliance rate in real-time.  |
| SLI       | Service Level Indicator, a measurement metric used to gauge system stability. <<< custom_key.brand_name >>> SLI supports setting one or more measurement metrics based on monitors. |
| SLO   | Service Level Objective, the smallest unit for <<< custom_key.brand_name >>> to process SLA ratings, which is the goal for the cumulative success count of SLIs within a time window. We often convert SLOs into error budgets to calculate tolerable errors, where the duration of abnormal events in each detection cycle will be deducted from the allowable error time (as shown in the figure: assuming an SLO detection cycle of 5 minutes, with abnormal event coverage time totaling 3 minutes, deducting 3 minutes). |

![](img/image_4.png)

## Create SLO 

Navigate to **Monitors > SLO** and customize the creation of SLO tasks.

![](img/7.slo_2.png)

1. Name: The name of the SLO task. Supports up to 64 characters.
2. Detection Frequency: The frequency at which SLO checks occur. This means monitoring whether any anomalies occur in the monitors within a certain time range. Currently supports 5 minutes, 10 minutes.
3. SLI: The uptime of the monitors will serve as the metric for measuring system stability. Therefore, you can add one or more monitors as measurement metrics.
4. Compliance Rate: The SLO target percentage (0-100%), using a 7-day time reference dimension.
    - Target: When **Minimum Target Percentage >= Compliance Rate < Target Percentage**, it is considered that the SLA is unhealthy, and a **Warning** event will be generated;
    - Minimum Target: When **Compliance Rate < Minimum Target Percentage**, it is considered that the SLA is non-compliant, and a **Critical** event will be generated.
5. Alert Strategy: After selecting an associated [alert strategy](alert-setting.md), alerts can be sent when anomalies are detected.
6. Description: Descriptive information, supporting up to 256 characters.

**Note**: Once the SLO configuration is saved, the SLO name, target, and detection period cannot be changed.

When creating or editing an SLO task, you can also add [labels](../management/global-label.md) in the top-left corner for the current task to achieve data linkage across the current workspace via global labels.

![](img/slo_tag.png)

## SLO List

In the workspace's **Monitors > SLO**, you can view all SLO monitoring task metrics data under the current workspace, including associated monitors, targets, downtime, compliance rates, error budgets, etc., and perform operations such as enabling, disabling, editing, viewing related events, exporting dashboards, etc.

![](img/5.slo_1.png)

### List Fields

| <div style="width: 110px">Field</div> | Description |
| --- | --- |
| Monitors | The number of monitors associated with the SLI, i.e., the metrics for measuring service performance. |
| Target | The target percentage of service availability set when creating the SLO task. |
| Compliance Rate (7 Days) | The percentage of time without anomalies over a given evaluation period (Compliance Rate = System Uptime / Evaluation Period * 100%):<br><li>When Minimum Target Percentage <= Percentage < Target Percentage, it is considered that the SLA is **Unhealthy**, displayed as an orange compliance rate;<br><li>When Percentage < Minimum Target Percentage, it is considered that the SLA is **Non-compliant**, displayed as a red compliance rate. |
| Downtime (7 Days) | The time during which the monitor was abnormal / used quota. |
| Error Budget (7 Days) | The remaining allowable error time for the current SLO (assuming the target SLO is set to 95%, meaning there is a 5% error tolerance rate, defaulting to the past 7 days as the cycle, i.e., default: Error Budget = 7 days * 5% = 21 minutes), displayed as:<br><li>Green: Remaining allowable error time >= 0;<br><li>Red: Remaining allowable error time < 0. |

### Operation Instructions

- Search Bar: In the SLO list, you can search and locate based on the SLO name.
- Batch Operations: You can enable, disable, or delete specific SLOs in bulk.
- Enable/Disable: New SLOs are enabled by default. You can choose to disable an SLO or re-enable a disabled SLO.
- Edit: Editing existing SLO tasks is supported; however, modifying the SLO name, target, and detection frequency is not allowed.
- Delete: Deleting existing SLO tasks is supported.
    - **Note**: Deleting an SLO task may cause the associated dashboard SLO data to become invalid.
- View Related Events: Alert events triggered by the SLO task are stored under the corresponding task. Clicking this will directly navigate to all unresolved events triggered by the SLO task.
- Export to Dashboard: Exporting the SLO monitoring task as a view to the **Dashboard** is supported, allowing SLO monitoring to be synchronized on the dashboard.
    - **Note**: The time range of the SLO view in the dashboard defaults to align with the dashboard, while the SLO list calculates the 7-day compliance rate by default.

## SLO Details

<<< custom_key.brand_name >>> supports viewing SLO details by clicking on the SLO task, including the SLO compliance rate and SLI anomaly records.

![](img/image_6.png)

| Field | Description |
| --- | --- |
| Last 7 Days SLA | Compliance rate for the past 7 days based on the current access time. |
| Annual SLA | Compliance rate for the current year (calendar year) based on the current access time. |
| Past Year SLA | Compliance rate for the past year (calendar year) based on the current access time. |
| SLI Anomaly Records | Abnormal events triggered by the monitors under the current SLO task. |

???+ abstract "Obtain SLO via DQL Expression"

    Abnormal time reference query:

    `df_slo_cost` represents **deducted minutes**, summing these values gives the **abnormal time**, replace `df_slo_id` accordingly:

    ```
    E::`slo`:(sum(`df_slo_costslo_cost`)) { `df_slo_id` = 'monitor_c36bb56f274b4242866fe7259f1859c0' }
    ```

    If querying the SLO value for 7 days, the DQL expression is as follows:

    ```
    eval((10080-A)/10080 *100, A="E::`slo`:(sum(`df_slo_cost`)) { `df_slo_id` = 'monitor_c36bb56f274b4242866fe7259f1859c0'}")
    ```

    <u>Example:</u>

    In the figure below, the SLO value for the last 7 days of the SLO task is `80.496%`.

    <img src="../img/slo-1.png" width="60%" >

    Go to **Shortcut > Query Tool**, select **DQL Query**, input the query statement for the 7-day SLO value, and the query result matches the value in the above figure.

    <img src="../img/slo-2.png" width="60%" >

    :warning: When using **Query Tool > DQL Query**, ensure the time range in the top-right corner matches the time range for obtaining the SLO value; `slo_id` can be viewed in the **Events > Event Details Page**:

    <img src="../img/slo-3.png" width="60%" >