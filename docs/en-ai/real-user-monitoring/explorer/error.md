# Error (Errors)
---

You can view frontend errors emitted by the browser during user application usage, including error types and error messages.

In the Error Explorer, you can:

- View all error types and their related error details in one place;
- Through Sourcemap transformation, deobfuscate the code to facilitate error troubleshooting by locating the source code, helping users solve problems faster.


## Explorer List

### All Errors

In the Error Explorer, you can quickly view page addresses, code error types, and error contents when users access the application.

- Error content Load failed: This means there was no `response` for the request; the default SDK includes Load failed;
- Error content Network request failed: This means the `response` returned an error.

![](../img/12.rum_explorer_6.png)

### Pattern Analysis {#analysis}

If you need to view frequently occurring errors, you can go to <<< custom_key.brand_name >>> Workspace **RUM PV > Explorer > Error**, and select the **Pattern Analysis** list.

Pattern analysis involves similarity computation based on clustering fields for all error trace data. It fixes the current time period according to the selected time range in the upper right corner and retrieves 10,000 records within that time frame for pattern analysis. Similar errors are aggregated, and common patterns are extracted and counted to help quickly identify abnormal traces and locate issues.

By default, it aggregates based on the `error_message` field, but you can customize up to 3 clustering fields.

![](../img/error0725.png)

- In the Pattern Analysis list, you can click any error to view all associated Errors, and clicking a trace will take you to the detail page for analysis;

- On the Pattern Analysis page, clicking the sorting icon :octicons-triangle-up-16: & :octicons-triangle-down-16:, you can sort documents in ascending/descending order (default is descending).

## Detail Page

Clicking the detail page of the data in the list allows you to view detailed information about the error encountered during user access, including error details, extended fields, and associated traces.

![](../img/12.rum_explorer_2.5.png)

### Source

In **Source**, you can view Session / View / Action details for the current Error, and filter/copy the current Session ID / View ID / Action ID.

### Error Distribution Chart

The Error Distribution Chart aggregates similar errors and automatically selects the appropriate time interval based on the selected time range in the Explorer, displaying the distribution trend of errors to help you visually identify frequent error occurrences or time ranges, and quickly locate error issues.

### Error Details {#error}

In the Error Details, you can view the specific content of the error.

#### Sourcemap Transformation

When applications are released in production environments, to prevent code leakage and other security issues, files are typically transformed and compressed during the packaging process. While these measures ensure code security, they also obfuscate the collected error stack information, making it difficult to directly pinpoint issues and complicating subsequent bug troubleshooting.

<<< custom_key.brand_name >>> provides Sourcemap functionality for applications, supporting deobfuscation of code to facilitate error troubleshooting by locating the source code, helping users solve problems faster.

> You can configure this via RUM [Sourcemap Configuration](../sourcemap/set-sourcemap.md) or [Datakit Collector Sourcemap Transformation](../../integrations/rum.md#sourcemap). After configuration, you can view the parsed code and original code in the Error Details.

**Note**: Currently, only Web-type applications support Sourcemap configuration in RUM.

##### Parsed Code Example

Example of parsed code after configuring Sourcemap in RUM:

![](../img/1.rum_error_4.png)

##### Original Code Example

![](../img/1.rum_error_5.png)

Example of parsed code using Datakit Collector Sourcemap transformation:

![](../img/sourcemap_02.png)

**Note**: If users configure Sourcemap in both RUM and Datakit Collector, the parsed format from RUM configuration will be displayed.

### Extended Fields

:material-numeric-1-circle-outline: In the search bar, you can enter field names or values to quickly search and locate;

:material-numeric-2-circle-outline: After checking field aliases, you can view them after the field name; choose as needed.

:material-numeric-3-circle-outline: In the trace detail page, you can view relevant field attributes of the current trace under **Extended Fields**:

| Field | Property |
| ------- | ------------------------------------ |
| Filter Field Value | Adds this field to the Explorer to view all data related to this field, allowing you to filter and view related trace lists in the Trace Explorer. |
| Reverse Filter Field Value | Adds this field to the Explorer to view all data except those related to this field. |
| Add to Display Columns | Adds this field to the Explorer list for viewing. |
| Copy | Copies this field to the clipboard. |

![](../img/extension-1.gif)

## Issue Auto Discovery {#issue}

Based on data generated from <<< custom_key.brand_name >>> monitoring RUM Errors, when you enable the **Issue Auto Discovery** configuration, the system will statistically analyze corresponding anomaly data based on different grouping dimensions and perform stack trace tracking for subsequent similar issues, ultimately condensing them into Issues. Issues generated through this entry point help you obtain context and root causes of the problem, significantly reducing the average time to resolve issues.

![](../img/auto-issue-rum.png)

:material-numeric-1-circle-outline: Data Source: The enabling entry point on the current configuration page.

:material-numeric-2-circle-outline: Grouping Dimensions: Based on combined configuration fields, including `app_name`, `env`, `version`, `error_type`.

Based on grouping dimensions, additional filtering conditions can be added, and <<< custom_key.brand_name >>> will further query and classify data that meet the criteria.

<img src="../img/issue-filter-rum.png" width="70%" >

:material-numeric-3-circle-outline: Detection Frequency: <<< custom_key.brand_name >>> will query data within the time range based on the selected frequency, which includes 5 minutes, 10 minutes, 15 minutes, 30 minutes, and 1 hour.

:material-numeric-4-circle-outline: Issue Definition: After enabling this configuration, Issues will be presented according to the definitions here. To avoid missing information, [fill in sequentially](../exception/issue.md#concepts).

In the **Title** and **Description** sections of the Issue, the following template variables are supported:

| Variable | Meaning |
| --- | --- |
| `count` | Statistical count |
| `app_name` | Application name |
| `env` | Environment |
| `version` | Version |
| `error_type` | Error type |
| `error_message` | Error message |
| `error_stack` | Error stack |

### Viewing Issues {#display}

After saving and enabling the configuration, automatically discovered Issues will be displayed in the **Console > [Incident](../../exception/issue.md#auto)** section.

![](../img/issue-auto.png)

## Further Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Using the Issue Auto Discovery Feature to Quickly Respond to Anomalies**</font>](../../application-performance-monitoring/issue-auto-generate.md)

</div>