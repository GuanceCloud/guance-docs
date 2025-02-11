# Error (Errors)
---

You can view front-end errors emitted by the browser during the user's application usage, including error types and error contents.

In the Error Explorer, you can:

- View all error types and their related error details in one place;
- Through Sourcemap conversion, deobfuscate the code to facilitate error troubleshooting and help users solve problems faster.

## Explorer List

### All Errors

In the Error Explorer, you can quickly view the page address, code error type, error content, etc., when a user accesses.

- Error content "Load failed": i.e., errors with no `response`; the default SDK adds "Load failed";
- Error content "Network request failed": i.e., errors returned by `response`.

![](../img/12.rum_explorer_6.png)

### Cluster Analysis {#analysis}

If you need to view frequently occurring errors, you can go to **User Access Monitoring > Explorer > Error** in the Guance workspace and select the **Cluster Analysis** list.

Cluster analysis involves similarity computation based on clustering fields for all error trace data. According to the selected time range in the upper right corner, it analyzes 10,000 data points within that period, clustering similar error traces and extracting common patterns to help quickly identify abnormal traces and locate issues.

By default, it clusters based on the `error_message` field, but you can customize up to three clustering fields.

![](../img/error0725.png)

- In the cluster analysis list, you can click any error to view all associated Errors and enter the detail page for further analysis;

- On the cluster analysis page, clicking the sort icon :octicons-triangle-up-16: & :octicons-triangle-down-16:, you can sort the document count in ascending/descending order (default is descending).

## Detail Page

Clicking on the data detail page in the list, you can view detailed information about the user's access errors, including error details, extended fields, and associated traces.

![](../img/12.rum_explorer_2.5.png)

### Source

In **Source**, you can view Session / View / Action details of the current Error, and filter/copy the current Session ID / View ID / Action ID.

### Error Distribution Chart

The error distribution chart aggregates similar errors and automatically selects appropriate time intervals based on the selected time range in the Explorer, displaying the trend of error distribution over time to help you visually identify frequent error occurrences and quickly pinpoint issues.

### Error Details {#error}

In the error details, you can view the specific content of the error.

#### Sourcemap Conversion

When deploying applications in production, to prevent code leaks and other security issues, files are generally transformed and compressed during the packaging process. While these measures ensure code safety, they also obfuscate collected error stack information, making it difficult to directly pinpoint issues and complicating subsequent bug fixes.

Guance provides Sourcemap functionality for applications, supporting the deobfuscation of code to facilitate error troubleshooting and help users resolve issues faster.

> You can configure this via RUM [Sourcemap Configuration](../sourcemap/set-sourcemap.md) or [Datakit Collector Sourcemap Conversion](../../integrations/rum.md#sourcemap). After configuration, you can view the parsed code and original code in the error details.

**Note**: Currently, only Web applications support Sourcemap configuration in RUM.

##### Parsed Code Example

Configuring Sourcemap conversion in RUM, parsed code example:

![](../img/1.rum_error_4.png)

##### Original Code Example

![](../img/1.rum_error_5.png)

Using Datakit collector to configure Sourcemap conversion, parsed code example:

![](../img/sourcemap_02.png)

**Note**: If users configure Sourcemap in both RUM and Datakit collector, the parsed format from RUM will be displayed.

### Extended Fields

:material-numeric-1-circle-outline: In the search bar, you can input field names or values to quickly locate them;

:material-numeric-2-circle-outline: Checking field aliases allows you to view them after the field name; you can choose as needed.

:material-numeric-3-circle-outline: In the trace detail page, you can view relevant field attributes under **Extended Fields**:

| Field | Attribute |
| ------- | ------------------------------------ |
| Filter Field Value | Adds the field to the Explorer to view all data related to the field; you can filter and view related traces in the trace Explorer. |
| Reverse Filter Field Value | Adds the field to the Explorer to view data excluding the field. |
| Add to Display Columns | Adds the field to the Explorer list for viewing. |
| Copy | Copies the field to the clipboard. |

![](../img/extension-1.gif)

## Issue Auto Discovery {#issue}

Based on data monitored by Guance for RUM Errors, when you enable the **Issue Auto Discovery** configuration, the system will statistically analyze abnormal data according to different grouping dimensions and track similar issues automatically, ultimately generating Issues. This helps you obtain context and root causes of issues, significantly reducing the average time to resolve problems.

![](../img/auto-issue-rum.png)

:material-numeric-1-circle-outline: Data Source: The entry point for enabling this configuration on the current configuration page.

:material-numeric-2-circle-outline: Grouping Dimensions: Based on configured field content combinations, including `app_name`, `env`, `version`, `error_type`.

Based on these dimensions, you can add filtering conditions, and Guance will query and categorize data that meets the criteria.

<img src="../img/issue-filter-rum.png" width="70%" >

:material-numeric-3-circle-outline: Detection Frequency: Guance will query data within the time range based on the frequency you select, including 5 minutes, 10 minutes, 15 minutes, 30 minutes, and 1 hour.

:material-numeric-4-circle-outline: Issue Definition: After enabling this configuration, Issues will be presented based on the definitions here. To avoid missing information, [fill in sequentially](../exception/issue.md#concepts).

In the **Title** and **Description** sections of an Issue, you can use the following template variables:

| Variable | Meaning |
| --- | --- |
| `count` | Count |
| `app_name` | Application Name |
| `env` | Environment |
| `version` | Version |
| `error_type` | Error Type |
| `error_message` | Error Content |
| `error_stack` | Error Stack Trace |

### Viewing Issues {#display}

After saving and enabling the configuration, auto-discovered Issues will be displayed in **Console > [Incident](../../exception/issue.md#auto)**.

![](../img/issue-auto.png)

## Further Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Effectively Respond to Anomalies Using Issue Auto Discovery**</font>](../../application-performance-monitoring/issue-auto-generate.md)

</div>