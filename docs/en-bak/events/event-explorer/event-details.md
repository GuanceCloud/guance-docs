# Event Details
---


In the event Explorer or uncovered event Explorer before recovery, click on any event to view event details, including basic properties, extended fields, alert notifications, history records, associated events and SLOs.


On the event details page, you can:

- Click on the **Monitor** option in the top right corner to view and adjust the [monitoring configuration](https://www.notion.so/monitoring/monitor/index.md);
- Click on the **Export** button in the top right corner to choose between **Export JSON file** and **Export PDF file** options, in order to obtain all the key data associated with the current event.

## Information {#attribute}


Display the detection dimensions, detection metrics, historical trends and event content for viewing events.

![](../img/5.event_8.png)

:material-numeric-1-circle-outline: Detection Dimension: Guance supports query of all detection dimensions.

<img src="../../img/event-1.png" width="70%" >

:material-numeric-2-circle-outline: Detection Metrics: Query statement for detection metrics configured in the monitor.

:material-numeric-3-circle-outline: Historical Trend: The historical trend of detection result values for currently unresolved events. Click **Get Chart Query** to obtain the current query.

## Extend Fields {#event-extension}

![](../img/event-extension.png)

:material-numeric-1-circle-outline: In the search bar, you can enter the field name or value to quickly locate it.

:material-numeric-2-circle-outline: After selecting the field alias, you can view it next to the field name. You can choose as needed.

:material-numeric-3-circle-outline: You can view the relevant field attributes of the current event.

| Fields      | Attributes                          |
| ----------- | ------------------------------------ |
| Filter      | Add this field to the explorer to view all data related to this field. You can use the link explorer to filter and view the list of links related to this field. <font size=2>*See Figure 1.*</font>                       |
| Reverse filter      | Add this field to the explorer to view other data excluding this field.                          |
| Copy      | Copy this field to the clipboard.                          |


## Alerting {#alarm}

Display information such as the type and name of notification object and whether the notification was sent successfully. Click to expand and display detailed information about the alert notification object, supporting hover to copy.

- If the alert is in mute mode, it will be displayed as Mute.
- If the alert is sent normally, the corresponding notification object label will be displayed. Hover to display the specific notification object name.

**Note**: During the mute period, the alert notification will not be sent repeatedly to the relevant objects.

## History {#history}

Display the host of the detection object, the abnormal/recovery time and the duration.

![](../img/5.event_11.png)


## Related Events {#relevance}

Support to view associated events by filtering fields and selected time components.

![](../img/5.event_12.png)


## Related Dashboards {#relevance}

If an associated dashboard is configured in the monitor, you can view the associated dashboard.

![](../img/5.event_13.png)



## Related SLO {#relevance}

If an SLO is configured in the monitor, you can view the associated SLO, including SLO name, monitor, compliance rate, error budget, target and other information.

![](../img/5.event_14.png)

<!--

## 智能巡检事件详情页

若事件来源于智能巡检事件，您可以在事件详情页查看智能巡检的事件详情，如以下示意图是 Pod 的智能巡检，您可以在事件详情查看事件概览、异常 Pod 、container 状态、错误日志等信息。

> 更多详情，可参考 [智能巡检](../monitoring/bot-obs/index.md)。

![](../img/5.event_16.png)

同时您也可以查看为该智能巡检添加的 Kubernets 指标视图（关联字段：`df_dimension_tags`）。

> 更多详情，可参考 [绑定内置视图](../scene/built-in-view/bind-view.md)。

![](../img/5.event_17.png)
-->
