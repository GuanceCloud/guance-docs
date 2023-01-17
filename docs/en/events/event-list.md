# Event Explorer
---

## Overview

In "Events", you can view the full list of events in the current workspace by switching the viewer in the upper left corner to the Event Explorer.

In the event explorer, you can.

- Count the number of events with different alert levels at different points in time in the current event explorer by stacking bar charts

- Keyword search, tag filtering, field filtering, correlation search, etc. for events based on labels, fields and texts

- Aggregation event analysis based on selected field grouping

## Query and Analysis

In event explorer, it supports querying event data by selecting time range, searching keywords, filtering, etc., which helps you quickly locate which time range, which function module and which event triggered by this behavior among all events.

![](img/5.event_7.gif)

### Time Control

The event explorer displays the last 15 minutes of data by default. The "Time Control" in the upper right corner allows you to select the time range for data display. For more details, please refer to the documentation [Time control description](... /getting-started/necessary-for-beginners/explorer-search.md#time).

### Search & Filter

In the event explorer search field, it supports various search methods such as keyword search, wildcard search, correlation search, etc. It supports value filtering by `tags/attributes`, including forward filtering, reverse filtering, fuzzy matching, reverse fuzzy matching, existence and non-existence, etc. More search and filtering can be found in the document [Searching and Filtering](. /getting-started/necessary-for-beginners/explorer-search.md).

### Analysis Mode

In the event explorer analysis column, it supports multi-dimensional analysis based on the tag field to reflect the aggregated event statistics under different analysis dimensions, click on the aggregated event to view the aggregated event details, more can refer to the document [Aggregated Event Details](event-details.md) .

### Quick Filter

With the Quick Filter on the left side of the list, you can quickly filter the data by checking the fields of the Quick Filter, and support custom filter fields, more quick filters can be found in the document [Quick Filter](. /getting-started/necessary-for-beginners/explorer-search.md#quick-filter).

### Filter History

Click the "Filter History" icon in the lower right corner to view the history of search criteria saved as `key:value`, which supports applying to different explorers of the current workspace. For more details, please refer to the documentation [Filter History](../getting-started/necessary-for-beginners/explorer-search.md#filter-history).

### Event Export

In the event explorer, click "Export" to export the current Event Viewer data to CSV, Dashboard and Notes.

### Save Snapshot

In the upper left corner of the event explorer, click the "View History Snapshot" icon to directly save the snapshot data of the current event. With the snapshot function, you can quickly reproduce an instant copy of the data copy information and restore the data to a certain point in time and a certain data presentation logic. For more details, please refer to the documentation [Snapshot](... /management/snapshot.md).

## Event Detail Page

In the Unrecovered Events explorer, click on any event and you can swipe sideways to open the event details, including basic attributes, alarm notifications, status & trends, history, associated events, and associated SLOs.The event details page supports jumping to the monitor associated with the current event and exporting the key information of the event to a PDF or JSON file. More details can be found in the documentation [Event Detail](event-details.md). 