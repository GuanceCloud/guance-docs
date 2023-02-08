# Usability Explorer
---

## Introduction

Guance supports you to view all the data details returned by the dialing task through the "Explorer", which helps you find problems in advance, locate problems and improve the user experience.

## Query and Analysis

Guance supports a variety of ways to query and analyze the dial-up data, including selecting data sources, searching, screening, statistics and export. Query dialing test data by selecting time range, searching keywords and screening.

### Time Control

Guance Explorer displays the data of the last 15 minutes by default, and you can select the time range of data display through the "Time Control" in the upper right corner. See the documentation [time control description](../getting-started/necessary-for-beginners/explorer-search.md#time) for more details.

### Search and Filter

In the explorer search bar, it supports keyword search, wildcard search, association search, JSON search and other search methods, and supports value filtering through `tag/attribute` , including forward filtering, reverse filtering, fuzzy matching, reverse fuzzy matching, existence and nonexistence and other filtering methods. For more searches and filters, refer to the document [search and filter for the explorer](../getting-started/necessary-for-beginners/explorer-search.md).

### Quick Filter

In the explorer shortcut filter, support editing "shortcut filter" and adding new filter fields. After adding, you can select their field values for quick filtering. For more shortcut filters, please refer to the document [shortcut filter](../getting-started/necessary-for-beginners/explorer-search.md#quick-filter).

### Custom Display Columns

In the Usability Monitoring Explorer list, you can customize to add, edit, delete and drag display columns through Display Columns. When the mouse is placed on the display column of the viewer, click the "Settings" button to support ascending, descending, moving columns to the left, moving columns to the right, adding columns to the left, adding columns to the right, replacing columns, adding to shortcut filtering, adding to grouping, removing columns and other operations. See the documentation [display column description](../getting-started/necessary-for-beginners/explorer-search.md#columns).

### Analysis

In the explorer analysis column, multi-dimensional aggregation analysis and statistics based on **1-3 tags** are supported to reflect the distribution characteristics and trends of data in different dimensions and at different times. Observation cloud supports a variety of data chart analysis methods, including time sequence chart, ranking list, pie chart and rectangular tree chart. For more details, please refer to the document [analysis mode for the explorer](../getting-started/necessary-for-beginners/explorer-search.md#analysis).

### Dial Test Statistics

 Guance will count the number of dialing data in a certain period of time according to the selected time range. You can view the amount of dialing data in different states in different time periods by stacking histograms.

Different data types have different data states. The states of http (API dial test) data include,

- `OK`: Successful request
- `FAIL`: Failed request

### Data Export

In the Usability Monitor Explorer list, you can filter out the data you want to export and then view and analyze it. It supports exporting CSV files to local devices or exporting them to scene dashboards or notes.

## HTTP Dial Test

In the Usability Monitor Explorer, select HTTP Dial Test to view the data results of all configured HTTP Dial Test tasks.

![](img/4.dailtesting_explorer_2.png)

In the Availability Monitoring Explorer list, click the dialing test data you want to view the corresponding dialing test data details. You can view the data details such as attributes, test performance, response details, response headers and response contents.

![](img/4.dailtesting_explorer_3.png)

When the mouse clicks on the property field, it supports "Filter Field Value", "Reverse Filter Field Value", "Add to Display Column" and "Copy" for quick filter viewing.

- "Filter field value", that is, add the field to the explorer to view all the data related to the field
- "Reverse filter field value", that is, add this field to the explorer to view other data besides this field
- "Add to display column", that is, add the field to the explorer list for viewing
- "Copy", that is, copy the field to the clipboard


![](img/1.dailtesting_explorer_2.png)

## TCP Dial Test

In the Usability Monitoring Explorer, select TCP Dial Test to view the data results of all configured TCP Dial Test tasks.

![](img/4.dailtesting_explorer_4.png)

In the Usability Monitoring Explorer list, click the dialing test data you want to view the corresponding dialing test data details, and you can view the data details such as attributes, test performance, response details and route tracking results.

![](img/4.dailtesting_explorer_5.png)

## ICMP Dial Test

In the Usability Monitoring Explorer, select ICMP Dial Test to view the data results of all configured ICMP Dial Test tasks.

![](img/4.dailtesting_explorer_7.png)

In the Usability Monitoring Explorer list, click the dial test data you want to view to view the corresponding dial test data details, and you can view the data details such as attributes and response details.

![](img/4.dailtesting_explorer_8.png)

## WEBSOCKET Dial Test

In the Usability Monitor Explorer, select "WEBSOCKET Dialing Test" to view the data results of all configured WEBSOCKET dialing test tasks.

![](img/4.dailtesting_explorer_9.png)

In the Usability Monitor Explorer list, click the dialing test data you want to view the corresponding dialing test data details. You can view the data details such as attributes, sending messages, response details, response headers and response contents.

![](img/4.dailtesting_explorer_10.png)

