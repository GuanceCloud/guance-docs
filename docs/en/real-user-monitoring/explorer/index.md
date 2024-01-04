# Explorer
---

The RUM Explorer can help you view and analyze detailed information about user access to your application.

In the **RUM > Explorers**, you can learn about the impact of each user session, page performance, resources, long tasks, errors in operations, and delays on users. It helps you gain a comprehensive understanding of the running status and usage of your application through search, filtering, and correlation analysis.

The following types of explorers are available in the RUM in Guance:

| <div style="width: 110px">Explorer Type</div> | Overview |
| --- | --- |
| [Session](session.md) | View a series of details about user access, including access time, access page path, number of access operations, access path and error messages encountered. |
| [View](view.md) | View user access environment, trace user operation paths, break down response times for user operations and understand the performance metrics of a series of backend application invocation chains caused by user operations. |
| [Resource](resource.md) | View various resource information loaded on web pages, including status codes, request methods, resource addresses and loading times. |
| [Action](resource.md) | View user interaction during application usage, including operation types, page operation details and operation times. |
| [Long Task](long-task.md) | View long tasks that block the main thread for more than 50ms during application usage, including page addresses and task times. |
| [Error](error.md) | View front-end errors issued by browsers during application usage, including error types and error contents. |

## Precondition

Guance collects errors, resources, requests and performance metrics by introducing SDK scripts.

> For specific operation methods, see [Rum Collector Configuration](../../integrations/rum.md).

## Options

In the explorer, Guance supports querying and analyzing RUM data through time range selection, keyword search, filtering, and other methods.

- [Time Widget](../../getting-started/function-details/explorer-search.md#time): By default, the explorer displays data for the last 15 minutes.

- [Search and Filter](../../getting-started/function-details/explorer-search.md): The explorer search bar supports multiple search and filtering methods.

- [Analysis Mode](../../getting-started/function-details/explorer-search.md#analysis): In the explorer Analysis Bar, you can perform multidimensional analysis and statistics based on 1-3 tags, and support multiple data chart analysis methods.

- [Quick Filter](../../getting-started/function-details/explorer-search.md#quick-filter): Editing and adding filter fields are supported.

- [Columns](../../getting-started/function-details/explorer-search.md#columns): You can customize the display columns by adding, editing, deleting and dragging the display columns.

### Data Distribution Chart

In the explorer's data distribution chart, you can automatically select the corresponding time interval to display the distribution trend of the number of user accesses at each time point based on the selected time range. If you filter the data, the filtered distribution trend will be displayed synchronously, helping you intuitively view RUM data at different time points.


### Error Data Prompt

RUM data is classified as `warning` and `info`. If the RUM data is of the warning type, indicating that there is an error in the data, a :warning: prompt will be displayed in front of the data list in the explorer, helping you quickly identify performance issues that occur during user access, including network issues, page loading errors, and page DOM parsing errors.