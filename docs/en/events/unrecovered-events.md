# Unrecovered Event Explorer
---

## Overview

In "Events", Guance Cloud displays "Unrecovered Event Explorer" for you by default, and you can view all unrecovered events continuously triggered in the space, as well as data volume statistics and alarm information details of unrecovered events under different alarm levels. The unrecovered event query is the last 48 hours data, which supports manual refresh.

In the unrecovered event explorer, you can:

- Count the number of events in different alarm states, and quickly filter them by clicking on alarm states, including "unrecovered (df_status ! = ok)", "critical", "error", "warning" and "nodata"
- Keyword search, tag filter, field filter, correlation search, etc. for events based on tags, fields, and text (including log text)
- View information about the current alarm event, including the detection dimension of the event, the time the alarm started, the duration of the alarm, and the trend of events over the last 6 hours.

## Query and Analysis

In the unrecovered event explorer, it supports querying event data by refreshing the time range, searching keywords, and filtering to help you quickly locate which time range, which function module, and which behavior triggered the event among all events.

![](img/5.event_6.png)

### Time Control

The unrecovered event explorer queries the last 48 hours of data by default, you can manually refresh to view the current last 48 hours of event data.

### Search & Filter

In the unrecovered event explorer search field, it supports various search methods such as keyword search, wildcard search, correlation search, etc. It supports value filtering by `tags/attributes`, including forward filtering, reverse filtering, fuzzy matching, reverse fuzzy matching, existence and non-existence, etc. More search and filtering can be found in the document [Searching and Filtering](. /getting-started/necessary-for-beginners/explorer-search.md).

### Quick Filter

You can quickly filter the data by checking the fields of the quick filter through the quick filter on the left side of the list, more quick filters can be found in the document [Quick Filter](. /getting-started/necessary-for-beginners/explorer-search.md#quick-filter).

> Note: Adding custom filter fields is not supported in the unrecovered event explorer.

### Filter History

Click the "Filter History" icon in the lower right corner to view the history of search criteria saved as `key:value`, which supports applying to different explorers of the current workspace. For more details, please refer to the documentation [Filter History](../getting-started/necessary-for-beginners/explorer-search.md#filter-history).

### Data Status

In the unrecovered event explorer, based on the monitor's trigger condition configuration will generate "unrecovered (df_status ! = ok)", "critical", "important", "warning", "no data" status statistics, for more details, please refer to the document [Event Level Description](. /monitoring/monitor/event-level-description.md), you can also refer to [Threshold-Detection](. /monitoring/monitor/threshold-detection.md) to configure a monitor and set trigger conditions for the monitor.

### Event Information

In the unrecovered event explorer, you can view information about the current alarm event, including the detection dimension of the event, the time the alarm started, the duration of the alarm, the detection dimension, the detection query statement, and expand to view the last 6 hours of abnormal trends in event occurrences.	

> **Note**: Event exception trends are displayed via the window function.

   - The display of the time period affected by the abnormal event is displayed as a dashed border display effect
   - When the detection library rule type is threshold, log, application performance indicator, user access indicator detection, security check, abnormal process, and cloud dialing test detection, you can view the relevant abnormal detection indicator data, including emergency, error, and warning, according to the color block corresponding to different alarm levels.
   - When the detection library rule type is mutation or interval, the time point of the current event trigger can be quickly identified according to the "vertical line" of the chart.

### Detection Dimension

In the unrecovered event explorer, click on the event detection dimension to jump to view related hosts, containers, processes, logs, traces, profiles, RUM, availability testing, security check, CI, etc. If there is no related data, the corresponding jump link is not clickable. Inspection dimension supports filtering view by "Filter field value", "Reverse filter field value" and "Copy".

- "Filter Field Value", add this tag to the event explorer to see all event data associated with this host
- "Reverse Filter Field Values", add this tag to the event explorer to see all event data related to other hosts besides this one
- "Copy", copy the content of this tag to the clipboard 

![](img/event003.png)

### Recovery Event {#recover}

A recovery event is an event with a normal event status (df_sub_status = ok). You can set event recovery rules in [monitor](... /monitoring/monitor/index.md) to set event recovery rules when configuring trigger conditions, or to perform event recovery manually.

The recovery events include four scenarios: recovery, no data recovery, no data considered recovery, and manual recovery, as shown in the following table.

| Name                        | df_status | Description                                                  |
| :-------------------------- | :-------- | :----------------------------------------------------------- |
| recovery                    | ok        | If the previous detection process has triggered the "emergency" "important" "warning" 3 kinds of abnormal events, according to the front-end configuration of N times to make a judgment, no "emergency" "important" "warning" event within the number of detections, then it is considered to recover and generate normal recovery events |
| no data recovery            | ok        | If the previous detection process because the data stopped reporting triggered no data exception event, the new data re-reporting is judged to recover to generate no data recovery event |
| no data considered recovery | ok        | If there is no data in the detection data, then the condition is considered normal and a recovery event is generated. |
| manual recovery             | ok        | OK events generated by the user manually clicking Restored   |

#### Manual Recovery

In the unrecovered event explorer, mouse over the event and you can see the "Recovered" button on the right side of the event.

![](img/5.event_4.png)

By clicking "Restored", the event is manually restored to normal, and a restored event is generated, which can be viewed by the corresponding operator in the event list.

![](img/5.event_5.png)

### Save Snapshot

In the upper left corner of the unrecovered event explorer, click the "View History Snapshot" icon to directly save the snapshot data of the current event. With the snapshot function, you can quickly reproduce an instant copy of the data copy information and restore the data to a certain point in time and a certain data presentation logic. For more details, please refer to the documentation [Snapshot](... /management/snapshot.md).

## Event Detail Page

In the Unrecovered Events explorer, click on any event and you can swipe sideways to open the event details, including basic attributes, alarm notifications, status & trends, history, associated events, and associated SLOs.The event details page supports jumping to the monitor associated with the current event and exporting the key information of the event to a PDF or JSON file. More details can be found in the documentation [Event Detail](event-details.md). 
