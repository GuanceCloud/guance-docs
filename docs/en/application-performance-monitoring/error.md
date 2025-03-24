# Error Tracking
---


<<< custom_key.brand_name >>> provides an application performance monitoring error data analysis explorer, where you can quickly view the historical trends and distribution of similar errors in the trace under **Application Performance Monitoring > Error Tracking**, helping to quickly pinpoint performance issues.

The Error Tracking Explorer includes two lists: **All Errors** and **Pattern Analysis**:

- [All Errors](#errors): Used for<u> overall viewing of all </u>trace errors that occur in the project application;  

- [Pattern Analysis](#analysis): Used for<u> quickly viewing the most frequent occurrences </u>of trace errors that need to be resolved

> <<< custom_key.brand_name >>> Explorer provides powerful query and analysis functions. Please refer to [Explorer Description](../getting-started/function-details/explorer-search.md).

## All Errors {#errors}

In <<< custom_key.brand_name >>> workspace **Application Performance Monitoring > Error Tracking**, select the **All Errors** list to view and analyze error data from all traces.

**Note:** The statistics for all errors are based on the error status `status=error` and contain the `error_type` field in Span.

![](img/1.apm_error_12.png)

### AI Error Analysis {#ai}

<<< custom_key.brand_name >>> provides a one-click capability to parse error data. It uses large models to automatically extract key information from the data and combines it with online search engines and operations knowledge bases to quickly analyze possible causes of failures and provide preliminary solutions.

1. Click on a single data point to expand the details page;
2. Click AI Error Analysis in the top-right corner;
3. Start anomaly analysis.

<img src="../img/apm_error_ai.png" width="70%" >

### Correlation Analysis

In the Error Tracking Explorer, you can click any error to view the corresponding error trace details, including services, error types, error content, error distribution charts, error details, trace details, extended attributes, as well as associated logs, hosts, networks, etc.

<div class="grid" markdown>

=== "Error Distribution Chart"

    In the error explorer detail page > Error Distribution Chart, based on the fields `error_message` and `error_types`, **aggregate statistics for similar error traces within the selected time range of the error explorer, and automatically select the appropriate time interval to display the error distribution trend**, helping you intuitively see the time points or ranges when errors frequently occur, quickly locating trace issues.

    ![](img/1.apm_error_11.1.png)

=== "Error Details"

    Use error detail information to quickly locate error issues.

    ![](img/1.apm_error_14.png)

=== "Trace Details"

    This tab displays the error information occurring under the current service trace.

    ![](img/1.apm_error_13.png)

</div>

## Pattern Analysis {#analysis}

If you need to view errors with higher frequency, you can choose the **Pattern Analysis** list in <<< custom_key.brand_name >>> workspace **Application Performance Monitoring > Error Tracking**.

Pattern Analysis performs similarity calculations on all trace data based on clustering fields. According to the selected time range in the upper-right corner, it fixes the current time period and retrieves 10,000 data entries within that period for cluster analysis. Similar error traces are aggregated, and common patterns are extracted and counted to help quickly identify abnormal traces and locate problems.

By default, aggregation is done based on the `error_message` field, but up to 3 custom clustering fields can be input.

![](img/1.apm_error_10.0.png)


### Pattern Analysis Details

- In the pattern analysis list, you can click any error to view all related error traces, and clicking the trace will take you to the error trace details page for analysis;  

![](img/1.apm_error_10.png)

- On the pattern analysis page, click the sort icon :octicons-triangle-up-16: & :octicons-triangle-down-16: to sort the document quantity in ascending/descending order (default descending).

![](img/error-1.png)

- If you need to export a particular data entry, open its details page and click the :material-tray-arrow-up: icon in the top-right corner.

<img src="../img/error-0809.png" width="70%" >

## Automatic Issue Discovery {#issue}

Based on <<< custom_key.brand_name >>>'s monitoring data from APM Error Tracking, once you enable the **Automatic Issue Discovery** configuration, the system will statistically aggregate corresponding anomaly data according to different grouping dimensions and perform stack tracing for subsequent similar issues, automatically condensing them into Issues. Issues generated through this entry will help you intuitively obtain the context and root cause of the problem, significantly reducing the average time to resolve issues.

### Start Configuration

<font size=2>**Note**: Before enabling this configuration, you must **configure rules first**. Otherwise, it will not support enabling.</font>

![](img/auto-issue.png)

:material-numeric-1-circle-outline: Data Source: i.e., the activation entry of the current configuration page.

:material-numeric-2-circle-outline: Composite Dimensions: Classification and statistics based on configured field combinations, including `service`, `version`, `resource`, `error_type`.

For the data source, you can add filtering conditions to filter the data, and <<< custom_key.brand_name >>> will further query the data that meets the conditions, narrowing down the scope of available data.

<img src="../img/issue-filter.png" width="70%" >

:material-numeric-3-circle-outline: Detection Frequency: <<< custom_key.brand_name >>> will query the data time range based on the frequency you select, including 5 minutes, 10 minutes, 15 minutes, 30 minutes, and 1 hour.

:material-numeric-4-circle-outline: Issue Definition: After enabling this configuration, Issues will be presented externally based on the definition here. To avoid missing information, [fill out sequentially](../exception/issue.md#concepts).

In both the **Title** and **Description** sections of the Issue, the following template variables are supported:

| Variable | Meaning |
| --- | --- |
| `count` | Statistical count |
| `service` | Service name |
| `version` | Version |
| `resource` | Resource name |
| `error_type` | Error type |
| `error_message` | Error content |
| `error_stack` | Error stack |

### View Issues {#display}

After saving the configuration and enabling it, the Issues automatically discovered and generated by the system will be displayed in **Console > [Incident Tracking](../exception/issue.md#auto)**.

![](img/issue-auto.png)

## Further Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Quickly Respond to Anomalies Using the Automatic Issue Discovery Feature**</font>](./issue-auto-generate.md)

</div>


<!--
Meanwhile, based on different composite dimensions, Issues generated from this source will be categorized into new issues, duplicate issues, and regression issues, making it easier for you to distinguish between them.

- New issue: No **identical composite dimension** exists in historical Issues.

![](img/auto-issue-1.png)

- Duplicate issue: There **exists an identical composite dimension** in historical Issues and the Issue status is Open or Pending. Meanwhile, newly discovered data content via automatic detection will be directly appended to the reply section of this Issue.

![](img/auto-issue-2.png)

- Regression issue: There **exists an identical composite dimension** in historical Issues and the Issue status is Resolved. The system will change the status of this Issue from Resolved to Open. Meanwhile, newly discovered data content via automatic detection will be directly appended to the reply section of this Issue.
-->