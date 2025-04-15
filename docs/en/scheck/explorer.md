# Security Check Explorer
---
- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64

## Introduction

<<< custom_key.brand_name >>> supports you in monitoring, querying, and correlating all security check events through "Security Check". It helps you improve the quality of security checks, problem analysis, and issue resolution while promptly identifying vulnerabilities, anomalies, and risks.

## Overview

In "Security Check" - "Overview", <<< custom_key.brand_name >>> provides a default security check monitoring view for you. You can filter by HOST, security check level, and security check category to view an overview of security check events occurring on different hosts. This includes the number of security check events of different levels and visual chart analysis, as well as rankings of security check events by category and rule.

![](img/2.scheck_1.png)

At the same time, you can use the "Jump" button to navigate to the corresponding built-in view page of the overview page for viewing and cloning and modifying the view. For more information, refer to [Built-in Views](../management/built-in-view/index.md).

![](img/2.scheck_2.png)

## Data Query and Analysis

In "Security Check" - "Explorer", you can query security check events through selecting a time range, search keywords, and filtering.

![](img/2.scheck_4.png)

### Security Check Event Statistics

<<< custom_key.brand_name >>> will count the number of security check events with different statuses based on the selected time range. You can view the number of security check events at different points in time using stacked bar charts. It supports selecting different time intervals to view statistics on the number of security check events, exporting to dashboards, notes, and copying to the clipboard.

![](img/2.scheck_3.png)

### Time Widget

The <<< custom_key.brand_name >>> explorer defaults to displaying data from the last 15 minutes. Through the "Time Widget" in the top-right corner, you can select the time range for data display.

### Search and Filter

In the explorer's search bar, it supports various search methods such as keyword search, wildcard search, related search, JSON search, and filtering by `tags/attributes`. This includes positive filtering, negative filtering, fuzzy matching, reverse fuzzy matching, Exist and Not exist filtering. For more details on search and filtering, refer to the documentation [Explorer Search and Filtering](../getting-started/necessary-for-beginners/explorer-search.md).

### Quick Filters

In the explorer quick filters, it supports editing "Quick Filters" and adding new filter fields. After adding, you can choose the field values for quick filtering. For more details on quick filters, refer to the documentation [Quick Filters](../getting-started/necessary-for-beginners/explorer-search.md#quick-filter).

### Custom Display Columns

When viewing the list, you can customize the addition, editing, deletion, and dragging of display columns via "Display Columns". When hovering over the explorer's display columns with the mouse, clicking the "Settings" button allows operations such as ascending order, descending order, moving columns left or right, adding columns to the left or right, replacing columns, adding to quick filters, adding to groups, and removing columns. For more details on custom display columns, refer to the documentation [Display Column Description](../getting-started/necessary-for-beginners/explorer-search.md#columns).


### Data Export

The security check event list supports exporting the current list data as a CSV file to a local device or exporting it to a scenario dashboard or note via the settings button above the list.

### Save Snapshot

<<< custom_key.brand_name >>> supports creating easily accessible data copies. Through the snapshot feature, you can quickly reproduce instant copied data snapshots and restore data to a certain point in time and a specific data display logic.

You can perform searches and filters on the currently displayed data, select a time range, add display columns, etc., then click the "Snapshot" small icon in the upper-left corner of the explorer and click "Save Snapshot" to save the content currently displayed in the explorer. In historical snapshots, you can perform operations such as "Share Snapshot", "Copy Snapshot Link", and "Delete Snapshot". For more detailed introductions, refer to the documentation [Snapshot](../getting-started/function-details/snapshot.md).

## Security Check Event Details

When you click on the label "HOST" or an attribute field, you can quickly filter and view by "Filtering Field Values", "Reverse Filtering Field Values", "Add to Display Columns", and "Copy". You can directly enter the host-related data explorer by clicking "View Related Logs", "View Related Containers", "View Related Processes", and "View Related Traces" for correlation analysis of the host.

- "Filter Field Value": Adds the field to the explorer to view all data related to this field.
- "Reverse Filter Field Value": Adds the field to the explorer to view data other than this field.
- "Add to Display Columns": Adds the field to the explorer list for viewing.
- "Copy": Copies the field to the clipboard.

![](img/2.scheck_6.png)

### Suggestions

Click on the security check event you want to view. In the detail page that appears, you can view handling suggestions for this security check event, including the theoretical basis for the occurrence of the security check event, risk items, audit methods, remediation measures, etc.

![](img/2.scheck_7.png)

### Correlated Checks

In the correlated checks section of the security check event detail page, you can match associated events by selecting tags (including: HOST, category, rule). At the same time, you can search for related events based on the name and content of the event.

![](img/2.scheck_8.png)

### Correlated Hosts

In the security check detail page, clicking "HOST" below allows you to view the Metrics view and attributes view of related hosts (associated field: HOST).

Note: To view related hosts in process details, you need to match the "HOST" field; otherwise, you cannot see the page of related hosts in process details.

- Metrics View: You can view the HOST performance Metrics status **from 30 minutes before the end of this security check event to 30 minutes after the log ends**, including CPU, memory, and other HOST performance Metrics views related to the HOST.

![](img/2.scheck_10.png)

- Attributes View: Helps you trace back to the actual state of the HOST object when the security check data was generated. It supports viewing the latest object data of the related HOST **within 10 minutes before the end of this security check event**, including basic HOST information and integration operation conditions. If cloud HOST collection is enabled, you can also view cloud vendor information.

Note: <<< custom_key.brand_name >>> defaults to saving the most recent 48 hours of historical data for HOST objects. If no corresponding HOST historical data is found for the current log time, you will not be able to view the attributes view of the related HOST.

![](img/2.scheck_11.png)