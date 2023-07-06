# Chart Sharing
---

## Introduction

Guance supports sharing of visual charts such as time series charts, pie charts, overview charts, etc., which can be used to insert charts into the code of platforms other than Guance for visual data presentation and analysis. The shared charts are synchronized in real time with the chart changes in the "Guance" even if they are embedded in other platforms.
## Share Charts

You can share the visual charts made in 「Scene」-「Dashboard」, and the shared charts are uniformly stored in 「Management」-「Sharing Management」-「Chart Sharing」.

**Note: The share chart function only supports space owners, administrators and standard members to operate, read-only members cannot view the shared chart function. **

![](../img/chart026.png)

Select 「Chart Query Time」 and click 「Get」 to get the embed code.

![](../img/2.table_share_2.png)

Guance will generate the embedding code according to the chart query time, such as the chart query time is the last 15 minutes, that is, after embedding other platforms, the chart displays the query results according to the last 15 minutes.

**Note:**

- **If the chart is set to 「lock time」, the 「chart query time」 will be shown as that lock time and cannot be changed;**
- **The 「width」 and 「height」 of the chart are displayed as the size of the view by default, which can be modified by the embedded code;**
- **If the chart is associated with a view variable, the chart sharing will be done according to the currently selected view variable, such as the currently associated view variable host (host), the chart sharing will be done according to the currently selected host, **

![](../img/2.table_share_3.png)

## View chart sharing list

The charts shared by "Guance" in the scene view are stored in 「Management」 - 「Sharing Management」 - 「Chart Sharing」. For more details, please refer to [ Share Management](../../management/share-management.md)

![](../img/chart027.png)

### View Charts
Click 「View Chart」 to enlarge the preview of the shared visual chart.

![](../img/2.table_share_5.png)

### View Embed Code
Click 「View Embed Code」 to view and copy embed codes that can be used on other platforms.

![](../img/2.table_share_6.png)

### Cancel Sharing
When you click 「Unshare」, visual charts shared and embedded in other platforms will be invalidated, and charts that have been shared to other platforms will indicate that the charts have been invalidated.

![](../img/chart028.png)

