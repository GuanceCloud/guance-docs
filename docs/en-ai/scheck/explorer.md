# Security Check Explorer
---
- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64

## Introduction

Guance supports you in monitoring, querying, and correlating all security check events through the "Security Check" feature. This helps you detect vulnerabilities, anomalies, and risks promptly while improving the quality of inspections, problem analysis, and resolution capabilities.

## Summary

In the "Security Check" - "Summary," Guance provides a default security check monitoring view. You can filter by host, security check level, and category to view an overview of security check events on different hosts. This includes the number of events at different levels and visual chart analyses, as well as top lists for different categories and rules of security check events.

![](img/2.scheck_1.png)

Additionally, you can use the "Jump" button to navigate to the corresponding built-in view page for further inspection and modification. For more information, refer to [Built-in Views](../management/built-in-view/index.md).

![](img/2.scheck_2.png)

## Data Query and Analysis

In the "Security Check" - "Explorer," you can query security check events by selecting time ranges, search keywords, and using filters.

![](img/2.scheck_4.png)

### Inspection Event Statistics

Guance will count the number of inspection events with different statuses based on the selected time range. You can view the number of inspection events at different time points via stacked bar charts. The system supports exporting these statistics to dashboards, notes, or copying them to the clipboard.

![](img/2.scheck_3.png)

### Time Controls

The Guance Explorer defaults to showing data from the last 15 minutes. Using the "Time Control" in the top-right corner, you can select the time range for data display. For more details, refer to the [Time Control Documentation](../getting-started/necessary-for-beginners/explorer-search.md#time).

### Search and Filters

In the Explorer search bar, various search methods are supported, including keyword search, wildcard search, associated search, and JSON search. You can also filter values using `labels/attributes`, including positive filtering, negative filtering, fuzzy matching, reverse fuzzy matching, checking for existence or non-existence. For more information on searching and filtering, refer to the [Explorer Search and Filter Documentation](../getting-started/necessary-for-beginners/explorer-search.md).

### Quick Filters

In the Explorer quick filters, you can edit "Quick Filters" and add new filter fields. After adding, you can select field values for quick filtering. For more information on quick filters, refer to the [Quick Filter Documentation](../getting-started/necessary-for-beginners/explorer-search.md#quick-filter).

### Custom Display Columns

When viewing lists, you can customize columns by adding, editing, deleting, and dragging display columns. When hovering over the display columns in the Explorer, click the "Settings" button to perform operations such as sorting in ascending or descending order, moving columns left or right, adding columns to quick filters, grouping, or removing columns. For more information on customizing display columns, refer to the [Display Columns Documentation](../getting-started/necessary-for-beginners/explorer-search.md#columns).

### Data Export

The inspection event list supports exporting current list data to CSV files on local devices or exporting to scene dashboards or notes via the settings button above the list.

### Save Snapshot

Guance supports creating quickly accessible data copies through the snapshot feature. By using snapshots, you can quickly restore data to a specific point in time and its display logic.

You can search and filter data, choose a time range, add display columns, and then click the "Snapshot" icon in the top-left corner of the Explorer. Click "Save Snapshot" to save the currently displayed data. In the historical snapshots, you can share snapshots, copy snapshot links, or delete snapshots. For more detailed information, refer to the [Snapshot Documentation](../getting-started/function-details/snapshot.md).

## Inspection Event Details

When clicking on the label "host" or attribute fields, you can perform quick filtering actions such as "Filter Field Values," "Negative Filter Field Values," "Add to Display Columns," and "Copy."

- "Filter Field Values": Adds the field to the Explorer to view all related data.
- "Negative Filter Field Values": Adds the field to the Explorer to view data excluding this field.
- "Add to Display Columns": Adds the field to the Explorer list for viewing.
- "Copy": Copies the field to the clipboard.

![](img/2.scheck_6.png)

### Recommendations

Click on the inspection event you want to view. In the detail pane that slides out, you can view handling recommendations for the security check event, including theoretical basis, risk items, audit methods, remediation measures, etc.

![](img/2.scheck_7.png)

### Associated Inspections

In the inspection event details page, you can match associated events by selecting tags (including: host, category, rule). You can also search for related events based on the name and content of the event.

![](img/2.scheck_8.png)

### Associated Hosts

In the security check details page, click on "Host" below to view the metrics and attribute views of related hosts (associated field: host).

Note: To view related hosts in process details, you need to match the "host" field; otherwise, you cannot see the related host's page in process details.

- **Metrics View**: View the performance metrics status of the related host **from 30 minutes before the end of the inspection event to 30 minutes after the log ends**, including CPU, memory, and other performance metric views.

![](img/2.scheck_10.png)

- **Attribute View**: Helps you trace back to the actual state of the host object when the inspection data was generated. You can view the latest object data **within 10 minutes before the end of the inspection event**, including basic host information and integration runtime conditions. If cloud host collection is enabled, you can also view cloud provider information.

Note: Guance defaults to saving the most recent 48 hours of historical data for host objects. If no corresponding historical data is found for the current log time, you will not be able to view the attribute view of the associated host.

![](img/2.scheck_11.png)