# Availability Explorer
---

Guance supports you in viewing all data details returned by dial testing tasks through the **Explorer**, helping you identify and troubleshoot issues early to enhance user experience.

## Query and Analysis

Guance supports multiple methods for querying and analyzing dial testing data, including selecting data sources, searching, filtering, statistics, exporting, etc. You can query dial testing data by choosing a time range, search keywords, and filtering methods.

### Time Controls

The Guance Explorer defaults to displaying data from the past 15 minutes, but you can also customize the [time range](../getting-started/function-details/explorer-search.md#time) for data display.

### Search and Filtering

In the Explorer search bar, you can use [multiple search and filtering methods](../getting-started/function-details/explorer-search.md).

### Quick Filters

In the Explorer quick filters, you can edit [quick filters](../getting-started/function-details/explorer-search.md#quick-filter) and add new filter fields.

### Custom Display Columns

In the Synthetic Tests Explorer list, you can customize columns by adding, editing, deleting, or dragging display columns via **[display columns](../getting-started/function-details/explorer-search.md#columns)**.

### Analysis

In the Explorer [analysis panel](../getting-started/function-details/explorer-search.md#analysis), you can perform multi-dimensional analysis and statistical calculations based on ^^1-3 tags^^ and support various data chart analysis methods.

### Dial Testing Statistics

Guance will count the number of dial testing data points that exist within the selected time range. You can view the number of dial testing data points with different statuses over different time periods using a stacked bar chart.

Different data types have different statuses. For HTTP (Synthetic Tests) data, the statuses include:

- `OK`: Successful requests;
- `FAIL`: Failed requests;

### Data Export

In the Synthetic Tests Explorer list, you can first filter the data you want to export for viewing and analysis. You can export CSV files to local devices or export them to scenario dashboards or notes.

To export a specific data point, open its detail page and click the :material-tray-arrow-up: icon in the top-right corner.

## HTTP Synthetic Tests

In the Synthetic Tests **Explorer**, select **HTTP Synthetic Tests** to view the results of all configured HTTP synthetic testing tasks.

![](img/4.dailtesting_explorer_2.png)

In the Synthetic Tests Explorer list, click on the dial test data you want to view to see detailed information such as attributes, test performance, response details, response headers, and response content.

![](img/4.dailtesting_explorer_3.png)

When you click on an attribute field with your mouse, the following operations are supported:

| Field | Description |
| --- | --- |
| Filter by field value | Adds this field to the Explorer to view all data related to this field. |
| Exclude field value | Adds this field to the Explorer to view all data except for this field. |
| Add to display columns | Adds this field to the Explorer list for viewing. |
| Copy | Copies this field to the clipboard. |

![](img/1.dailtesting_explorer_2.png)

## TCP Synthetic Tests

In the Synthetic Tests **Explorer**, select **TCP Synthetic Tests** to view the results of all configured TCP synthetic testing tasks.

![](img/4.dailtesting_explorer_4.png)

In the Synthetic Tests Explorer list, click on the dial test data you want to view to see detailed information such as attributes, test performance, response details, and route tracking results.

![](img/4.dailtesting_explorer_5.png)

## ICMP Synthetic Tests

In the Synthetic Tests **Explorer**, select **ICMP Synthetic Tests** to view the results of all configured ICMP synthetic testing tasks.

![](img/4.dailtesting_explorer_7.png)

In the Synthetic Tests Explorer list, click on the dial test data you want to view to see detailed information such as attributes and response details.

![](img/4.dailtesting_explorer_8.png)

## WebSocket Synthetic Tests

In the Synthetic Tests **Explorer**, select **WebSocket Synthetic Tests** to view the results of all configured WebSocket synthetic testing tasks.

![](img/4.dailtesting_explorer_9.png)

In the Synthetic Tests Explorer list, click on the dial test data you want to view to see detailed information such as attributes, sent messages, response details, response headers, and response content.

![](img/4.dailtesting_explorer_10.png)