# Metrics Analysis
---

After data collection and reporting from Guance to the workspace, you can perform data queries and analysis on metrics and other data types (logs, basic objects, resource catalog, events, APM, RUM, security check, network, Profiling, etc.) on the **Metrics > Metrics Analysis** page.

## Metrics Query {#query}

Metrics analysis supports users in querying metric data using five methods: simple query, expression query, DQL query, PromQL query, and adding a data source. These queries can be visualized in four viewing modes: <u>area chart, line chart, bar chart, and table chart</u>.

Among these, the table chart supports queries in **time series mode, grouped mode, and query tool**. The results returned by the **query tool** are consistent with those of **Shortcut > Query Tool**. When you choose time series mode, you can select different [time intervals](#interval) to display query data:

![Analysis Image](../img/analysis.png)

When you choose **query tool** mode and add multiple queries, the first data result is returned by default when the status is enabled; up to 1000 records can be exported.

![](img/met-exp02.png)

Related operations:

- Enable/disable query

- Copy query

- Edit DQL query/switch back to visual editing mode

> For more data query instructions, refer to [Chart Query](../scene/visual-chart/chart-query.md#query) and [Query Tool](../dql/define.md).

![](img/4.changelog_1.2.gif)

## Time Interval {#interval}

The time interval is the time length between data points in a [time series chart](../scene/visual-chart/timeseries-chart.md). By switching the [time interval](../scene/visual-chart/timeseries-chart.md#advanced-setting) in the top-right corner of the Explorer, you can set the time interval to 10 seconds, 20 seconds, 30 seconds, 1 minute, 5 minutes, or 10 minutes.

**Note**: Since the [time component](../getting-started/function-details/explorer-search.md#time) affects the data display range of metrics analysis, customizable time intervals will automatically adjust based on the time component range. For example, if you choose to view metrics data for the last 15 minutes, you cannot select "1 hour" as the time interval.

## Legends

**Legends** are auxiliary elements of charts that support distinguishing data based on different colors, points, and shapes. By clicking the :fontawesome-solid-table-list: icon in the top-right corner of the Explorer, you can hide or adjust the legend position to the bottom or right side.

## Colors

To better represent different trends of metric data using lines, points, and areas of different colors, click the **Colors** button :art: in the top-right corner of the Explorer to modify the legend colors.

## Export

After performing data queries in **Metrics Analysis** and obtaining results, you can directly click the **Export** button :material-export-variant: to choose exporting the chart to dashboards & notes or copying it to the clipboard.

When using the table chart for visualization, in addition to the above three export paths, you can also choose to **export to CSV file**.

![](img/chart-1.png)