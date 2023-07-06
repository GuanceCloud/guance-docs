# Event Association
---

## Introduction

Guance supports "add filter field" to match the abnormal events associated with the selected field, so as to achieve the purpose of displaying data in association with events.This feature helps users to view trends while sensing if there are relevant events generated during data fluctuations to help them locate problems from another perspective.

Currently, only time series and histograms are supported.

## Example

The query object of the timing diagram is "host CPU IOwait". When "host:DESKTOP-NEN89U3" is added as a filter for event association, users can check whether "host:DESKTOP-NEN89U3" has an alarm event by shading the color block while viewing the timing diagram. alarm event exists.For more filters, please refer to [Explorer Description](../../getting-started/necessary-for-beginners/explorer-search.md)

![](../img/11.chart_1.3.png)

The timeseries diagram with the completed event association configuration will be shown with shaded blocks on the timeseries if there are event records; in analysis mode, click on the highlighted shaded blocks to view the abnormal events associated with the selected field (e.g. "host:DESKTOP-NEN89U3").

![](../img/11.chart_1.4.png)

