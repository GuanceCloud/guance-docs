# Error Tracking
---

Guance provides an APM error data analysis Explorer, where you can quickly view the historical trends and distribution of similar errors in traces under **APM > Error Tracking**. This helps in rapidly pinpointing performance issues.

The Error Tracking Explorer includes two lists: **All Errors** and **Cluster Analysis**:

- [All Errors](#errors): Used for<u>overall viewing of all</u> trace errors that occur in the application project;

- [Cluster Analysis](#analysis): Used for<u>quickly viewing the most frequent</u> trace errors that need to be resolved

> The Guance Explorer provides powerful query and analysis capabilities; refer to [Explorer Details](../getting-started/function-details/explorer-search.md).

## All Errors {#errors}

In the Guance workspace under **APM > Error Tracking**, select the **All Errors** list to view and analyze all trace error data.

**Note:** The statistics for all errors are based on Spans with `status=error` and contain the `error_type` field.

![](img/1.apm_error_12.png)

### Correlation Analysis

In the Error Tracking Explorer, you can click any error to view detailed information about the corresponding error trace, including service, error type, error content, error distribution chart, error details, trace details, extended attributes, and associated logs, hosts, networks, etc.

<div class="grid" markdown>

=== "Error Distribution Chart"

    In the Error Details page > Error Distribution Chart, based on the fields `error_message` and `error_type`, **similar errors are aggregated and statistically grouped by similarity within the selected time range, automatically adjusting the time interval to display the distribution trend of errors**, helping you intuitively identify time points or ranges with frequent errors, thus quickly locating trace issues.

    ![](img/1.apm_error_11.1.png)

=== "Error Details"

    Use error detail information to quickly locate error issues.

    ![](img/1.apm_error_14.png)

=== "Trace Details"

    This tab displays error information occurring under the current service trace.

    ![](img/1.apm_error_13.png)

</div>

## Cluster Analysis {#analysis}

If you need to view errors with higher occurrence frequency, you can choose the **Cluster Analysis** list in the Guance workspace under **APM > Error Tracking**.

Cluster Analysis involves similarity calculations on all trace data based on clustering fields. It selects a fixed time range and retrieves 10,000 data points within that range for cluster analysis, aggregating similar trace errors and extracting common patterns to help quickly identify abnormal traces and pinpoint issues.

By default, it aggregates based on the `error_message` field, but up to three custom clustering fields can be input.

![](img/1.apm_error_10.0.png)

### Cluster Analysis Details

- In the Cluster Analysis list, you can click any error to view all related error traces, and clicking a trace will take you to the error trace details page for analysis;

![](img/1.apm_error_10.png)

- On the Cluster Analysis page, clicking the sorting icon :octicons-triangle-up-16: & :octicons-triangle-down-16: allows you to sort document counts in ascending/descending order (default is descending).

![](img/error-1.png)

- To export a specific data point, open its details page and click the :material-tray-arrow-up: icon in the top-right corner.

<img src="../img/error-0809.png" width="70%" >

## Issue Auto Discovery {#issue}

Based on data from monitoring APM error tracking, when you enable the **Issue Auto Discovery** configuration, the system will aggregate and track stack traces for similar issues, condensing them into Issues. These Issues provide context and root causes, significantly reducing average resolution time.

### Configuration Setup

<font size=2>**Note**: Before enabling this configuration, you must **configure rules first**. Otherwise, enabling is not supported.</font>

![](img/auto-issue.png)

:material-numeric-1-circle-outline: Data Source: The entry point for enabling the current configuration.

:material-numeric-2-circle-outline: Grouping Dimensions: Based on configured fields, this includes `service`, `version`, `resource`, `error_type`.

For data sources, you can add filtering conditions to narrow down the data set.

<img src="../img/issue-filter.png" width="70%" >

:material-numeric-3-circle-outline: Detection Frequency: Guance queries data based on selected intervals such as 5 minutes, 10 minutes, 15 minutes, 30 minutes, and 1 hour.

:material-numeric-4-circle-outline: Issue Definition: After enabling this configuration, Issues will be presented according to the definitions here. To avoid missing information, [fill out sequentially](../exception/issue.md#concepts).

In both the **Title** and **Description** sections of an Issue, the following template variables are supported:

| Variable | Meaning |
| --- | --- |
| `count` | Count |
| `service` | Service name |
| `version` | Version |
| `resource` | Resource name |
| `error_type` | Error type |
| `error_message` | Error message |
| `error_stack` | Error stack |

### View Issues {#display}

After saving and enabling the configuration, automatically discovered Issues will be displayed in **Console > [Incident](../exception/issue.md#auto)**.

![](img/issue-auto.png)

## Further Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Efficiently Respond to Anomalies Using Issue Auto Discovery**</font>](./issue-auto-generate.md)

</div>

<!--
Additionally, depending on the grouping dimensions, Issues generated from this source will be categorized as new, recurring, or regressed issues for easier identification.

- New Issue: No matching combination dimensions exist in historical Issues.

![](img/auto-issue-1.png)

- Recurring Issue: Matching combination dimensions exist in historical Issues with status Open or Pending. Newly discovered data will be appended directly to this Issue's reply section.

![](img/auto-issue-2.png)

- Regressed Issue: Matching combination dimensions exist in historical Issues with status Resolved. The Issue status will change from Resolved to Open, and newly discovered data will be appended directly to this Issue's reply section.
-->