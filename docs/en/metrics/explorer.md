# Metric Analysis
---

## Introduction

After the Guance Cloud data collection is reported to the workspace, the metrics and other data types (log, basic object, custom object, event, application performance, user access, security inspection, network, Profile, etc.) can be queried and analyzed on the "Metrics" - "Metric Analysis" page.

## Metric Query

"Metrics Analysis" supports users to visually query metrics data in the form of time sequence diagram based on three ways: "Simple Query", "Expression Query" and "DQL Query". Support three viewing modes: area chart, line chart and histogram. For more data query instructions, please refer to the [chart query](../scene/visual-chart/chart-query.md#query) 。

![](img/4.changelog_1.2.png)



### Time Interval

"Time Interval" is the length of time between time sequence diagram data points. By switching the time interval in the upper right corner of the viewer, you can pinpoint the [time interval](../scene/visual-chart/timeseries-chart.md#advanced-setting) to milliseconds, seconds, minutes, days, weeks, and months. Specifically, it includes 1 millisecond, 50 milliseconds, 15 seconds, 30 seconds, 1 minute, 5 minutes, 10 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 1 day, 1 week, 1 month, etc.

???+ info

    As [time control](../getting-started/necessary-for-beginners/explorer-search.md#time) would affect the data display range of Metrics Analysis, the customizable time interval would be automatically adjusted according to the time control range. If you choose to view the last 15 minutes of metric data, you would not be able to select "1 hour" as the time interval.




### Legends

Legend is an auxiliary element of chart, which supports distinguishing data based on different colors, points and shapes.

- In the Metric Analysis viewer, click Legend, which can be used to filter the data in the chart.

- In the Metric Analysis viewer, you can hide or adjust the legend position to the bottom or right by using the top right corner ![](img/icon1.png) of the viewer.



### Color

In order to make better use of lines, points and surfaces with different colors to represent the data trends of different metrics, Guance Cloud supports clicking the "Color" button :art: in the upper right corner of the viewer to modify the legend color.

### Export

After querying the data and returning the results on "Metric Analysis", you can directly click the "Export" button :material-export-variant: and export the chart to the specified **dashboard**, **notes** or **clipboard**.

