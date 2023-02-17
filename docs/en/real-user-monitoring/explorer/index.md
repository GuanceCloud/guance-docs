# Explorer
---

## Overview

The Real User Monitoring explorer helps you view and analyze the details of users accessing applications. Open "Real User Monitoring" in the Guance workspace, clicking on any application and then you can know the impact of each user's session, page performance, resources, long tasks, errors in operation and delays on users through the "Explorer", which helps you to fully understand and improve the running status and usage of the application through search, filtering and correlation analysis, and improve the user experience.

Guance Real User Monitoring explorer include Session, View, Resource, Action, Long Task and Error.

| Explorer Type | Overview |
| --- | --- |
| Session | View a series of details of user access, including user access time, access page path, access operands, access path, error messages, and so on |
| View | Viewing the user's access environment, tracing the user's operation path, decomposing the response time of the user's operation, and understanding the performance metrics of a series of call chains of the back-end application caused by the user's operation |
| Resource | View the information of various resources loaded on the web page, including status code, request method, resource address, loading time, and so on |
| Action | View the user's operation interaction during using the application, including operation type, page operation details, operation time, and so on |
| Long Task | View long tasks that block the main thread for more than 50ms during the use of the application, including page address, task time consumption, and so on. |
| Error | View the front-end errors issued by the browser during the user's use of the application, including error types, error contents, and so on |

## Explorer Description

In the explorer, Guance supports querying and analyzing user access data by selecting time range, searching keywords, filtering and so on.

### Time Control

Guance explorer displays the data of the last 15 minutes by default, and you can select the time range of data display through the "Time Control" in the upper right corner. See the documentation [Time Control Description](../../getting-started/necessities-for-beginners/explorer-search.md # time) for more details.

### Search and Filter

In the explorer search bar, it supports keyword search, wildcard search, correlation search, JSON search and other search methods, and supports value filtering through ` tags/attributes `, including forward filtering, reverse filtering, fuzzy matching, reverse fuzzy matching, existence and nonexistence and other filtering methods. For more searches and filters, refer to the document [Searching and Filtering](../../getting-started/necessary-for-beginners/explorer-search.md).

### Analysis Mode

In the explorer analysis column, multi-dimensional analysis and statistics based on **1-3 tags ** are supported to reflect the distribution characteristics and trends of data in different dimensions and at different times. Guance supports a variety of data chart analysis methods, including time sequence chart, ranking list, pie chart and rectangular tree chart. For more details, please refer to the document [analysis Mode](../../getting-started/necessary-for-beginners/explorer-search.md # analysis).

### User Access Data DistributionChart

In the data distribution chart of the explorer, according to the selected time range statistics, the corresponding time interval is automatically selected to show the distribution trend of user access quantity at each time point; If the data is filtered, the distribution trend after filtering will be displayed synchronously, which will help you intuitively view the user access data at different time points.

### Quick Filter

In the explorer quick filter, support editing "quick filter" and adding new filter fields. After adding, you can select their field values for quick filtering. For more shortcut filters, refer to the document [Quick Filter](../../getting-started/necessities-for-beginners/explorer-search.md # quick-filter).

### Custom Display Column

When viewing the list, you can customize to add, edit, delete and drag display columns through Display Columns. When the mouse is placed on the display column of the explorer, click the "Settings" button to support ascending, descending, moving columns to the left, moving columns to the right, adding columns to the left, adding columns to the right, replacing columns, adding to shortcut filtering, adding to grouping, removing columns and other operations. For more custom display columns, refer to the documentation [Display Column Description](../../getting-started/necessities-for-beginners/explorer-search.md # columns).

### Error Data Alert

The status of users accessing data can be divided into two types: warning and info. If the data type accessed by users is warning, that is, the data has errors, the data list in the explorer is prompted :warning: , which helps you quickly identify the performance problems when users access, including network problems, page loading errors, page DOM parsing errors, etc.
