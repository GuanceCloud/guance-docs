# Metric Analysis
---


After the Guance data collection is reported to the workspace, metrics and other data types (log, basic object, custom object, event, application performance, user access, security inspection, network and Profile) can be queried and analyzed on the **Metrics** > **Metric Analysis** page.

## Metric Query

Metric Analysis supports users to visually query metric data in the form of time sequence diagram based on three ways: **Simple Query**, **Expression Query**, **DQL Query** and **PromQL Query**. The data can be visualized in four viewing modes: area chart, line chart, bar chart and table.

Among them, the table chart supports querying and analyzing data in both **time mode and group mode**. When you select the time mode, you can choose different time intervals to display the queried data.

<img src="../img/analysis.png" width="70%" >

> For more information on data querying, see [Chart Query](../scene/visual-chart/chart-query.md#query).

![](img/4.changelog_1.2.gif)



## Time Interval {#interval}

The time interval is the length of time between data points in a [timeseries chart](../scene/visual-chart/timeseries-chart.md). By switching the time interval in the upper right corner of the explorer, you can set the [time interval](../scene/visual-chart/timeseries-chart.md#advanced-setting) to be precise to 10 seconds, 20 seconds, 30 seconds, 1 minute, 5 minutes, and 10 minutes.

**Note**: As [time control](../getting-started/necessary-for-beginners/explorer-search.md#time) would affect the data display range of **Metric Analysis**, the customizable time interval would be automatically adjusted according to the time control range. If you choose to view the last 15 minutes of metric data, you would not be able to select "1 hour" as the time interval.



## Legends

Legend is an auxiliary element of chart, which supports distinguishing data based on different colors, points and shapes. By checking the :fontawesome-solid-table-list: in the top right corner of the explorer, you can hide or adjust the position of the legend to the bottom or right side.



## Color

In order to better utilize different colors of lines, points, and areas to represent the data trends of different indicators, click the Color button :art: in the top right corner of the explorer to modify the legend colors.

## Export


In Metrics Analysis, after performing a data query and obtaining the results, you can directly click on the Export button :material-export-variant: to choose exporting the chart to a dashboard & note or copying it to the clipboard.

When visualizing with a table chart, in addition to the three export options mentioned above, you can also choose to Download as CSV.


![](img/chart-1.png)