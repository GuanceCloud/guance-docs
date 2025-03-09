# Synthetic Tests Explorer
---

Synthetic Tests provide you with all data details of dial testing tasks through the Explorer, such as DNS, SSL, TTFB performance test results for web sites, and response details and failure reasons for failed dial tests.

## Query and Analysis

You can query and analyze dial test data in various ways:

- Customize the [time range](../getting-started/function-details/explorer-search.md#time) for data display;

- In the Explorer search bar, support for [multiple search and filter methods](../getting-started/function-details/explorer-search.md);

- In the Explorer > Shortcut, edit [filter fields](../getting-started/function-details/explorer-search.md#quick-filter);

- Customize adding, editing, deleting, and dragging display columns via [display columns](../getting-started/function-details/explorer-search.md#columns).

- In the Explorer [analysis panel](../getting-started/function-details/explorer-search.md#analysis), support multi-dimensional analysis statistics based on 1-3 tags and multiple types of data chart analysis.

### Distribution Chart

<<< custom_key.brand_name >>> will count the number of dial test data within a selected time range. You can view the number of dial test data with different statuses at different time intervals using a stacked bar chart.

Different data types have different data statuses; for http (Synthetic Tests) data, the statuses include:

- `OK`: Successful request;
- `FAIL`: Failed request.

### Data Export

In the Synthetic Tests Explorer list, you can first filter out the desired data to export and then view and analyze it. Supported export formats include CSV files to local devices or exporting to scenario dashboards or notes.

If you need to export a specific data entry, open the data detail page and click the :material-tray-arrow-up: icon in the top-right corner.

<!--
## HTTP Dial Testing

In the Synthetic Tests **Explorer**, select **HTTP Dial Testing** to view the data results of all configured HTTP dial testing tasks.

![](img/4.dailtesting_explorer_2.png)

In the Synthetic Tests Explorer list, click on the dial test data you want to view to see the corresponding dial test data details, including attributes, test performance, response details, response headers, response content, etc.

![](img/4.dailtesting_explorer_3.png)

When clicking on an attribute field, the following operations are supported:

| Field | Description |
| --- | --- |
| Filter Field Value | Add this field to the Explorer to view all data related to this field. |
| Reverse Filter Field Value | Add this field to the Explorer to view all other data except this field. |
| Add to Display Columns | Add this field to the Explorer list for viewing. |
| Copy | Copy this field to the clipboard. |

![](img/1.dailtesting_explorer_2.png)

## TCP Dial Testing

In the Synthetic Tests **Explorer**, select **TCP Dial Testing** to view the data results of all configured TCP dial testing tasks.

![](img/4.dailtesting_explorer_4.png)

In the Synthetic Tests Explorer list, click on the dial test data you want to view to see the corresponding dial test data details, including attributes, test performance, response details, traceroute results, etc.

![](img/4.dailtesting_explorer_5.png)

## ICMP Dial Testing

In the Synthetic Tests **Explorer**, select **ICMP Dial Testing** to view the data results of all configured ICMP dial testing tasks.

![](img/4.dailtesting_explorer_7.png)

In the Synthetic Tests Explorer list, click on the dial test data you want to view to see the corresponding dial test data details, including attributes, response details, etc.

![](img/4.dailtesting_explorer_8.png)

## WEBSOCKET Dial Testing

In the Synthetic Tests **Explorer**, select **WEBSOCKET Dial Testing** to view the data results of all configured WEBSOCKET dial testing tasks.

![](img/4.dailtesting_explorer_9.png)

In the Synthetic Tests Explorer list, click on the dial test data you want to view to see the corresponding dial test data details, including attributes, sent messages, response details, response headers, response content, etc.

![](img/4.dailtesting_explorer_10.png)

-->