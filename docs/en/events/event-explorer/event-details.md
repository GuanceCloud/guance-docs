# Event Details
---


In the [Unrecovered Events Explorer](./unrecovered-events.md) or [All Events Explorer](./event-list.md), click any event data to view event details, including basic attributes, extended fields, alert notifications, history records, etc.



## Basic Attributes {#attribute}

- Detection Dimensions: Specific properties used to identify and classify events during event detection.
    
    - You can query all detection dimensions. Clicking allows you to view related detection content and supports the following operations:

        - Filter Field Values: Filter based on field values of detection dimensions to view event data related to that field.   
        - Reverse Filter Field Values: Perform a reverse filter based on field values of detection dimensions to view other event data excluding this field.               
        - Copy: Copies the label content to the clipboard.               

<img src="../../img/event_detection_dimension.png" width="80%" >

- Event Content: Based on the [Event Content Description](../../monitoring/monitor/mutation-detection.md#event-content) defined in the monitor configuration page.

- Detection Metrics: The detection metric query statement configured when setting up the monitor.

- Historical Trend: Displays the historical trend of detection results for the current unrecovered event. Click **Get Chart Query** to obtain the current query statement.


<img src="../../img/event-query.png" width="80%" >

## Extended Fields {#event-extension}

You can manage the attribute fields contained in this event data through the following operations:

![](../img/event-extension-1.gif)

1. In the search bar, you can quickly search and locate by entering the field name or value;

2. After checking the field alias, it will be displayed after the field name; you can choose as needed.

3. On the event details page, you can view the relevant field attributes of the current event under **Extended Fields**:

| <div style="width: 110px">Field</div>      | Attribute                          |
| ----------- | ------------------------------------ |
| Filter Field Value      | Adds this field to the explorer's search bar to view all data related to this field. You can filter and view the related trace list in the [Trace Explorer](../../application-performance-monitoring/explorer/explorer-analysis.md).                         |
| Reverse Filter Field Value      | Adds this field to the explorer's search bar to view data other than this field.                          |
| Copy      | Copies this field to the clipboard.                          |

![](../img/event-extension.png)

## Alert Notifications {#alarm}


Displays information such as notification target type, notification target name, and whether the notification was successfully sent. Click to expand and display detailed information about the alert notification target, supporting hover-to-copy.

![](../img/5.event_10.png)

- If the alert is in a mute state, "Mute" will be displayed;
- If the alert is sent normally, it will display the corresponding notification object marker, hovering over the icon displays the specific notification object name.

**Note**: During the mute period, alert notifications will not be resent to the relevant objects.


## History Records {#history}

Displays the host of the detection object, abnormal/recovery time, and duration.

![](../img/5.event_11.png)

Clicking on a data entry opens the corresponding explorer and automatically includes `df_fault_id` for query filtering.

![](../img/3.event_13.1.png)



## Related Events {#relevance}

Supports viewing associated events within a certain time period based on four filtering fields.

| <div style="width: 110px">Field</div>      | Description           |
| :------- | :----------- |
| Same Fault ID      | `df_fault_id`; A special ID marker used to record the entire process from triggering an abnormal event to normally triggering a recovery event for a specific detection dimension.           |
| Same Monitor      | `df_monitor_checker_id`           |
| Same Detection Dimension      |  `df_dimension_tags`           |
| Same Level      | `df_status`           |

![](../img/5.event_12.gif)

## Associated SLO {#relevance}

If SLO is configured in monitoring, you can view the associated SLO, including SLO name, monitor, compliance rate, error budget, target, etc.

![](../img/5.event_14.png)

## Associated Dashboards {#relevance}

If dashboards are configured in the monitor, you can view the associated dashboards.

![](../img/5.event_13.png)



## Related Queries {#related-query}

In the related queries section, you can view all queries associated with the current event.

![](../img/5.event_9.png)

## Bind Built-in Views {#inner_view}

<<< custom_key.brand_name >>> supports binding or deleting built-in views (user views) to the event details page. Click to bind a built-in view, which adds a new view to the current event details page.

<img src="../../img/event-view.png" width="70%" >