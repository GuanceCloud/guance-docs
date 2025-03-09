# Security Check Explorer
---
- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64

## Introduction

<<< custom_key.brand_name >>> supports you in monitoring, querying, and correlating all inspection events through the "Security Check". It helps you improve the quality of inspections, problem analysis, and handling by promptly identifying vulnerabilities, anomalies, and risks.

## Overview

In the "Security Check" - "Overview", <<< custom_key.brand_name >>> provides a default security inspection monitoring view. You can view an overview of inspection events for different hosts by filtering hosts, inspection levels, and categories. This includes the number of inspection events at different levels and visual chart analyses, as well as top lists for inspection events based on different categories and rules.

![](img/2.scheck_1.png)

You can also use the "Jump" button to navigate to the corresponding built-in view page and clone or modify the view. For more information, refer to [Built-in Views](../management/built-in-view/index.md).

![](img/2.scheck_2.png)

## Data Query and Analysis

In the "Security Check" - "Explorer", you can query inspection events by selecting time ranges, searching keywords, and applying filters.

![](img/2.scheck_4.png)

### Inspection Event Statistics

<<< custom_key.brand_name >>> will count the number of inspection events with different statuses based on the selected time range. You can view the number of inspection events at different time points using a stacked bar chart. The statistics support different time intervals and exporting to dashboards, notes, and clipboard.

![](img/2.scheck_3.png)

### Time Widget

The <<< custom_key.brand_name >>> Explorer defaults to displaying data from the last 15 minutes. Using the "Time Widget" in the top-right corner, you can select the time range for data display. For more details, refer to the [Time Widget Documentation](../getting-started/necessary-for-beginners/explorer-search.md#time).

### Search and Filtering

In the Explorer search bar, various search methods are supported, including keyword search, wildcard search, associated search, JSON search, and filtering by `labels/attributes`. Filters include positive and negative matching, fuzzy matching, existence checks, and more. For more information, refer to [Search and Filter in Explorer](../getting-started/necessary-for-beginners/explorer-search.md).

### Quick Filters

In the Explorer quick filter section, you can edit "Quick Filters" and add new filter fields. After adding, you can select field values for quick filtering. For more information, refer to [Quick Filters](../getting-started/necessary-for-beginners/explorer-search.md#quick-filter).

### Custom Display Columns

When viewing lists, you can customize columns by adding, editing, deleting, and dragging display columns. Clicking the "Settings" button when hovering over display columns allows operations like sorting, moving columns, adding to quick filters, grouping, and removing columns. For more information, refer to [Display Column Documentation](../getting-started/necessary-for-beginners/explorer-search.md#columns).

### Data Export

The inspection event list supports exporting current list data as CSV files to local devices or exporting to scene dashboards or notes via the settings button above the list.

### Save Snapshot

<<< custom_key.brand_name >>> supports creating accessible data copies. Using the snapshot feature, you can quickly reproduce instant copies of data, restoring it to a specific point in time and display logic.

After performing searches, filtering, selecting time ranges, and adding display columns, click the "Snapshot" icon in the top-left corner of the Explorer and then "Save Snapshot" to save the current data content. In the history snapshots, you can perform actions like sharing snapshots, copying snapshot links, and deleting snapshots. For more detailed information, refer to the [Snapshot Documentation](../getting-started/function-details/snapshot.md).

## Inspection Event Details

When clicking on the "host" label or property fields, you can perform quick filtering actions such as "Filter Field Value," "Negative Filter Field Value," "Add to Display Columns," and "Copy."

- "Filter Field Value": Adds the field to the Explorer to view all related data.
- "Negative Filter Field Value": Adds the field to the Explorer to view all other data except for that field.
- "Add to Display Columns": Adds the field to the Explorer list.
- "Copy": Copies the field to the clipboard.

![](img/2.scheck_6.png)

### Recommendations

Click on the inspection event you want to view. In the detail panel, you can see recommendations for handling the security inspection event, including theoretical foundations, risk items, audit methods, and remediation measures.

![](img/2.scheck_7.png)

### Associated Inspections

In the inspection event detail page, you can match associated events by selecting tags (including: host, category, rule). You can also search for related events based on event names and content.

![](img/2.scheck_8.png)

### Associated Hosts

In the security inspection detail page, click on "Host" below to view the metrics and attribute views of related hosts (associated field: host).

Note: To view related hosts in process details, the "host" field must match; otherwise, the related host page will not be visible in process details.

- **Metrics View**: View the performance metrics status of related hosts **from 30 minutes before the end of this inspection event to 30 minutes after the log ends**, including CPU, memory, and other performance metrics.

![](img/2.scheck_10.png)

- **Attribute View**: Helps you trace back to the actual state of the host object when the inspection data was generated. You can view the latest object data within 10 minutes before the end of this inspection event, including basic host information and integration runtime status. If cloud host collection is enabled, you can also view cloud provider information.

Note: <<< custom_key.brand_name >>> retains historical data of host objects for the past 48 hours by default. If no historical data corresponding to the current log time is found, you will not be able to view the attribute view of the associated host.

![](img/2.scheck_11.png)