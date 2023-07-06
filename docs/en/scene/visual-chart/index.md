# Visualization Chart
---

More than 20 standard visualization charts are built into "Guance": including [timeseries-chart](timeseries-chart.md), [overview-chart](overview-chart.md), [table-chart](table-chart.md), [rectangular-tree chart] ( treemap.md), [funnel-chart](funnel-chart.md), [pie-chart](pie-chart.md), [bar-chart](bar-chart.md), [histogram](histogram.md), [SLO](slo-chart.md), [leaderboard]( leaderboard.md), [dashboard](dashboard.md), [scatter-plot](scatter-plot.md), [bubble-chart](bubble-chart.md), [china-map](china-map.md), [world-map](world-map.md), [cellular-map]( cellular-map.md), [text](text.md), [picture](picture.md), [video](video.md)), [command-panel](command-panel.md), [IFrame](iframe.md), [log-stream](log-stream.md), [log-stream](log-stream.md) [object-list](object-list.md), [alert-statistics](alert-statistics.md), etc., which can quickly create different dashboards according to different business requirements and meet the demand for personalized and comprehensive display of data.

## Add a chart

Once the dashboard is created, you can add a new chart to the dashboard by clicking 「Add Chart」 in the upper right corner.

![](../img/chart004.png)

Support adding global variables to charts to complete dynamic filtering of charts. For details, please click [View Variable](... /view-variable.md) for more details. After adding the chart, click 「Finish adding」 in the upper right corner.

![](../img/chart005.png)

## Set up charts

### Modification

In the chart, click the 「Settings」 button and select 「Modify」 to edit the chart.

![](../img/chart006.png)

When editing a chart, you can add or adjust [chart-query](chart-query.md), view and copy [chart-json](chart-json.md) code, add [chart-link](chart-link.md), view event associations, adjust chart styles and settings, and more.

![](../img/chart007.png)

##### Lock time
If you select "Last 15 minutes" for the lock time in the chart settings.

![](../img/chart008.png)

When previewing a chart, the selected lock time will appear in the upper right corner of the chart, and you can select the lock time to view your data as you see fit. More information on lock times can be found in the specific chart description.

![](../img/chart009.png)

##### Auto Align

If you select "Auto Align" for the time interval in the chart settings.

![](../img/chart010.png)

When previewing a chart, a time interval option will appear in the upper right corner of the chart, so you can select the time interval to view your data as you see fit. More information about time intervals can be found in the specific chart description.

![](../img/chart011.png)

### Combination Charts

In the chart, click on the 「Settings」 button and select 「Combination Charts」 to add other charts as a new combination chart. Combination charts are generally used to combine multiple charts with different results of an metric to help users understand the comparative results of the metric, and to combine different types of charts at will.

![](../img/chart012.png)

In the combined chart, click the 「Settings」button and select 「Modify」 to edit the combined chart; select 「Modify Main Title」 to edit the title of the combined chart and support hiding the main title.

![](../img/chart013.png)

### Share

In the chart, click the 「Settings」 button and select 「Share」 to share the visual chart you made. The shared charts are stored in 「Management」 - 「Share Management」 - 「Chart Sharing」.For more details, please refer to the document [chart-share](chart-share.md).

**Note: The Share Charts feature is only supported for space owners, administrators and standard members to operate. Read-only members cannot view the Share Charts feature.**

### Copy/Paste

In the chart, click the 「Settings」 button and select 「Copy」 to make a copy of the created visual chart. The successfully copied chart can be pasted to other dashboards or used in notes.

### Cloning

In the chart, click the 「Settings」 button and select 「Clone」 to clone the visual chart created. The cloned chart can be edited directly in the current dashboard, helping users save time in re-creating new charts.

### Delete

In the chart, click the 「Settings」 button and select 「Delete」 to delete the visual chart you created. Once a chart is deleted, it cannot be restored and needs to be recreated.

![](../img/chart014.png)

## Analysis of charts

In the dashboard, click the 「Analyze」 button on the chart or double-click on the chart margin to zoom in on the chart for viewing and analysis.

- Support for viewing data information of the chart by mouse hover (hover).
- Support for viewing metric trends for a specific time range by selecting [timeseries](timeseries-chart.md).
- Support for viewing [DQL query statements](chart-query.md), [similar trend metrics](timeseries-chart.md) and related correlation analysis links such as logs, containers, processes, links, etc. by clicking on the chart, and support for custom correlation [chart links](chart-link.md).
- When host information is present in the chart query and 「by host」 is selected as a grouping condition in the chart query, you can also view the associated host monitoring view.

**Note: **Built-in links are turned off by default and can be turned on for display when editing charts.

![](../img/2.scene_3.png)

