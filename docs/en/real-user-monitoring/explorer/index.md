# User Access Explorer
---

The User Access Monitoring Explorer helps you view and analyze detailed information about user visits to your application.

In **User Access Monitoring > Application List > Explorer**, you can understand each user session, page performance, resources, long tasks, errors in operations, and the impact of delays on users. This helps you comprehensively understand and improve the operational status and usage of your application through search, filtering, and correlation analysis.

<<< custom_key.brand_name >>>'s User Access Monitoring Explorers include the following types:

| Explorer Type | Overview |
| --- | --- |
| [Session](session.md) | View a series of details about user visits, including visit times, page paths, number of operations, visit paths, and error messages. |
| [View (Page)](view.md) | View user access environments, trace user operation paths, break down response times for user actions, and understand performance metrics of backend application calls triggered by user operations. |
| [Resource](resource.md) | View information about various resources loaded on web pages, including status codes, request methods, resource addresses, and loading times. |
| [Action](resource.md) | View user interactions during application use, including operation types, detailed page operations, and operation durations. |
| [Long Task](long-task.md) | View long tasks that block the main thread for more than 50ms during user application use, including page addresses and task durations. |
| [Error](error.md) | View frontend errors reported by browsers during user application use, including error types and error contents. |

## Prerequisites for Viewing

<<< custom_key.brand_name >>> collects errors, resources, requests, performance metrics, etc., by introducing an SDK script.

> For specific operating methods, refer to [RUM Collector Configuration](../../integrations/rum.md).

## Querying and Analysis

- **[Time Widget](../../getting-started/function-details/explorer-search.md#time)**: By default, it displays data from the last 15 minutes.

- In the Explorer's search bar, [multiple search and filter methods](../../getting-started/function-details/explorer-search.md) are supported.

- In the Explorer's [analysis panel](../../getting-started/function-details/explorer-search.md#analysis), you can perform multi-dimensional statistical analysis based on 1-3 labels and support multiple types of data chart analysis.

- In the trace Explorer's [quick filters](../../getting-started/function-details/explorer-search.md#quick-filter), you can edit and add filter fields.

- You can customize columns by [adding, editing, deleting, or dragging display columns](../../getting-started/function-details/explorer-search.md#columns).

### User Access Data Distribution Chart

In the data distribution chart of the Explorer, you can automatically select appropriate time intervals based on the selected time range to display the trend of user access volumes at each time point. If data has been filtered, the filtered distribution trend will be displayed simultaneously, helping you intuitively view user access data at different time points.

### Error Data Indicators

User access data statuses are divided into two types: <u>warning (warning) and normal (info)</u>. If the user access data type is warning, indicating an error in the data, a :warning: icon will appear before the data list in the Explorer to help you quickly identify performance issues during user visits, such as network problems, page load errors, and DOM parsing errors.