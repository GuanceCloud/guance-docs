# Error Tracking
---

<<< custom_key.brand_name >>> provides an APM error data analysis Explorer, where you can quickly view the historical trends and distribution of similar errors in the chain under **APM > Error Tracking** to help rapidly pinpoint performance issues.

The Error Tracking Explorer includes two lists: **All Errors** and **Pattern Analysis**:

- [All Errors](#errors): Used for<u>comprehensively viewing all</u> chain errors that occur in the project application;

- [Pattern Analysis](#analysis): Used for<u>quickly viewing the most frequent</u> chain errors that need to be resolved.

> <<< custom_key.brand_name >>> Explorer offers powerful query and analysis capabilities. Refer to [Explorer Details](../getting-started/function-details/explorer-search.md).

## All Errors {#errors}

In the <<< custom_key.brand_name >>> workspace under **APM > Error Tracking**, select the **All Errors** list to view and analyze error data from all chains.

**Note:** The statistics for all errors are based on spans with `status=error` and containing the `error_type` field.

![](img/1.apm_error_12.png)

### Correlation Analysis

In the Error Tracking Explorer, you can click any error to view the corresponding error trace details, including service, error type, error content, error distribution chart, error details, trace details, extended attributes, and associated logs, hosts, networks, etc.

<div class="grid" markdown>

=== "Error Distribution Chart"

    In the Error Explorer details page > Error Distribution Chart, based on the fields `error_message` and `error_type`, **similar errors are aggregated and statistically analyzed according to the selected time range, automatically adjusting the time interval to display the error distribution trend**, helping you intuitively identify frequent error occurrences or time ranges and quickly locate trace issues.

    ![](img/1.apm_error_11.1.png)

=== "Error Details"

    Use error details information to quickly pinpoint error issues.

    ![](img/1.apm_error_14.png)

=== "Trace Details"

    This tab displays error information that occurred under the current service trace.

    ![](img/1.apm_error_13.png)

</div>

## Pattern Analysis {#analysis}

If you need to view higher-frequency errors, in the <<< custom_key.brand_name >>> workspace under **APM > Error Tracking**, select the **Pattern Analysis** list.

Pattern Analysis performs similarity calculations on all error trace data based on clustering fields, fixing the current time range as selected in the upper right corner, and retrieves 10,000 records within this time frame for cluster analysis. Similar errors are aggregated, common patterns extracted and counted to help quickly identify abnormal traces and locate issues.

By default, aggregation is based on the `error_message` field, but up to three custom clustering fields can be input.

![](img/1.apm_error_10.0.png)

### Pattern Analysis Details

- In the Pattern Analysis list, you can click any error to view all associated error traces, and clicking a trace will lead you to the error trace detail page for analysis.

![](img/1.apm_error_10.png)

- On the Pattern Analysis page, clicking the sort icon :octicons-triangle-up-16: & :octicons-triangle-down-16: allows ascending/descending sorting by document count (default descending).

![](img/error-1.png)

- To export a specific data entry, open its detail page and click the :material-tray-arrow-up: icon in the top-right corner.

<img src="../img/error-0809.png" width="70%" >

## Automatic Issue Discovery {#issue}

Based on data generated from <<< custom_key.brand_name >>> monitoring APM error tracking, when you enable the **Automatic Issue Discovery** configuration, the system will aggregate and track stack traces for subsequent similar issues, automatically condensing them into Issues. This helps you intuitively obtain the context and root cause of the issue, significantly reducing the average time to resolve problems.

### Start Configuration

<font size=2>**Note**: Before enabling this configuration, you must **first configure rules**. Otherwise, it cannot be enabled.</font>

![](img/auto-issue.png)

:material-numeric-1-circle-outline: Data Source: The activation entry on the current configuration page.

:material-numeric-2-circle-outline: Grouping Dimensions: Based on configured field content combinations for classification and statistical aggregation, including `service`, `version`, `resource`, `error_type`.

For the data source, you can add filtering conditions to narrow down the data range, allowing <<< custom_key.brand_name >>> to further query and refine the available data.

<img src="../img/issue-filter.png" width="70%" >

:material-numeric-3-circle-outline: Detection Frequency: <<< custom_key.brand_name >>> queries data within the time range based on the frequency you choose, including 5 minutes, 10 minutes, 15 minutes, 30 minutes, and 1 hour.

:material-numeric-4-circle-outline: Issue Definition: After enabling this configuration, Issues will be presented according to the definitions here. To avoid missing information, [fill out sequentially](../exception/issue.md#concepts).

In the **Title** and **Description** sections of the Issue, the following template variables are supported:

| Variable | Meaning |
| --- | --- |
| `count` | Count |
| `service` | Service Name |
| `version` | Version |
| `resource` | Resource Name |
| `error_type` | Error Type |
| `error_message` | Error Content |
| `error_stack` | Error Stack |

### View Issues {#display}

After saving and enabling the configuration, automatically discovered Issues will be displayed in the **Console > [Incident](../exception/issue.md#auto)** section.

![](img/issue-auto.png)

## Further Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Quick Response to Anomalies Using Automatic Issue Discovery**</font>](./issue-auto-generate.md)

</div>

<!--
At the same time, based on different grouping dimensions, Issues generated from this source will be categorized as new issues, recurring issues, or regression issues for easier identification.

- New Issue: Does not have the same grouping dimension as any historical Issue.

![](img/auto-issue-1.png)

- Recurring Issue: Has the same grouping dimension as a historical Issue with a status of Open or Pending. Newly discovered data will be appended directly to this Issue's reply section.

![](img/auto-issue-2.png)

- Regression Issue: Has the same grouping dimension as a historical Issue with a status of Resolved. The Issue status will change from Resolved to Open, and newly discovered data will be appended directly to this Issue's reply section.
-->