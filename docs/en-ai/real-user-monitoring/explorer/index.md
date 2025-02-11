# User Access Explorer
---

The User Access Monitoring Explorer helps you view and analyze detailed information about user visits to your application.

In **User Access Monitoring > Application List > Explorer**, you can understand each user session, page performance, resources, long tasks, errors in operations, and the impact of delays on users. This allows you to comprehensively understand and improve the operational status and usage of your application through search, filtering, and correlation analysis.

The Guance User Access Monitoring Explorer includes the following types:

| Explorer Type | Overview |
| --- | --- |
| [Session (Session)](session.md) | View a series of details about user visits, including visit time, page path, number of actions, visit path, and error messages that occurred. |
| [View (Page)](view.md) | View user access environments, trace user operation paths, break down response times for user operations, and understand performance metrics of backend application calls triggered by user operations. |
| [Resource (Resource)](resource.md) | View various resource information loaded on web pages, including status codes, request methods, resource addresses, and loading times. |
| [Action (Operation)](action.md) | View user interactions during application use, including operation types, page operation details, and operation durations. |
| [Long Task (Long Task)](long-task.md) | View long tasks that block the main thread for more than 50ms during user application use, including page addresses and task durations. |
| [Error (Error)](error.md) | View frontend errors issued by the browser during user application use, including error types and error contents. |

## Prerequisites for Viewing

Guance collects errors, resources, requests, and performance metrics through introducing SDK scripts.

> For specific operating methods, refer to [RUM Collector Configuration](../../integrations/rum.md).

## Query and Analysis

- **[Time Control](../../getting-started/function-details/explorer-search.md#time)**: By default, it displays data from the last 15 minutes.

- In the Explorer search bar, you can use [multiple search and filter methods](../../getting-started/function-details/explorer-search.md).

- In the [Analysis Panel](../../getting-started/function-details/explorer-search.md#analysis), you can perform multi-dimensional analysis based on 1-3 tags and support various data chart analysis methods.

- In the Trace Explorer [Quick Filter](../../getting-started/function-details/explorer-search.md#quick-filter), you can edit and add filter fields.

- You can customize columns by adding, editing, deleting, and dragging display columns via [Displayed Columns](../../getting-started/function-details/explorer-search.md#columns).

### User Access Data Distribution Chart

In the data distribution chart of the Explorer, you can automatically select the appropriate time interval based on the selected time range to show the trend of user access volume at each time point. If data has been filtered, it will display the filtered distribution trend, helping you intuitively view user access data at different time points.

### Error Data Indicators

User access data status is divided into two types: <u>warning (warning) and normal (info)</u>. If the user access data type is warning, indicating an error in the data, a :warning: icon will appear before the data list in the Explorer, helping you quickly identify performance issues during user visits, including network issues, page loading errors, and page DOM parsing errors.