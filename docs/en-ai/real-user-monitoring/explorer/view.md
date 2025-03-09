# View (Page)
---

You can view user access environments, trace back user operation paths, break down response times for user operations, and understand the performance metrics of a series of backend application calls triggered by user operations.

In the View Explorer, you can:

- Track user access data for each page, including loading time, dwell time, etc.;
- Combine data related to resource requests, resource errors, logs, etc., associated with each page to comprehensively analyze the performance of business applications during user visits. This helps quickly identify and optimize code issues in the application.


## Explorer

In the View Explorer, you can quickly view the page URL, page load type, page load time, user dwell time, etc., during user visits.

![](../img/12.rum_explorer_2.png)

## Details Page

Click on the details page of the data you want to view in the list. You can see detailed performance information about the pages users visited, including attributes, sources, performance details, trace details, error details, related logs, etc.

![](../img/12.rum_explorer_1.5.png)

### Sources

The **Sources** section allows you to view session details for the current View, filter or copy the current Session ID.

![](../img/12.rum_explorer_2.6.png)

### Performance

The **Performance** page helps you view frontend page performance when users access specific applications, including page load time, content rendering time, interaction time, input delay, etc. As shown in the following figure, the LCP (Largest Contentful Paint) metric reached 8.4 seconds, while the recommended time is within 2.5 seconds, indicating that the page load speed is slow and needs optimization.

![](../img/12.rum_explorer_2.2.png)

For events on the current page, you can choose to display the most recent 50, 100, 200 entries, or all entries:

<img src="../../img/12.rum_explorer_2.5.png" width="70%" >

### Extended Fields

Properties are characteristics and features of data objects, defining the value of each property.

:material-numeric-1-circle-outline: In the search bar, you can enter field names or values to quickly search and locate;

:material-numeric-2-circle-outline: After checking the field alias, you can view it after the field name as needed;

:material-numeric-3-circle-outline: In the trace details page, you can view relevant field properties of the current trace under **Extended Fields**:

| Action         | Description                                                                 |
| --------------- | ----------------------------------------------------------------------------- |
| Filter Field Values | Add this field to the explorer to view all data related to this field.       |
| Reverse Filter Field Values | Add this field to the explorer to view all data except this field.      |
| Add to Display Columns | Add this field to the explorer list for viewing.                           |
| Copy           | Copy this field to the clipboard.                                             |

![](../img/view-explorer.gif)

### Associated Fetch/XHR

Switching to **Fetch/XHR**, you can view every network request made by the user to the backend application during their visit, including the occurrence time, request trace, and duration.

![](../img/4.rum_view_3.png)

If a network request has a corresponding `trace_id`, there will be a small icon prompt before the request. Clicking it will redirect you to the details page of the corresponding trace.

![](../img/view-1.gif)

Clicking on a data row, you can choose to view the related trace or resource for that data:

![](../img/4.rum_view_3_1.png)

### Associated Errors

Switching to **Errors**, you can view error data information, error types, and error occurrence times that appeared during the user's visit.

<img src="../../img/12.rum_explorer_2.4.png" width="80%" >

Clicking on an error message will redirect you to the details page of the corresponding error.

> For more error details, refer to [Error Explorer](error.md).

### Associated Logs

Through the **Logs** at the bottom of the details page, you can view logs and log counts based on the current user visit for the **last hour** and perform keyword searches, multi-label filtering, and time sorting on these related logs.

- To view more detailed log information: You can click on the log content to jump to the corresponding log details page or click **Jump** to **Logs** to view all logs related to the host.
- To view more log fields or more complete log content: You can customize and adjust the **maximum number of displayed rows** and **display columns** through the associated log explorer.

**Note**: To enhance user query experience, <<< custom_key.brand_name >>> defaults to saving user browsing settings in **Logs** (including "maximum number of displayed rows", "display columns") immediately so that **Associated Logs** remains consistent with **Logs**. However, custom adjustments made in **Associated Logs** are not saved after exiting the page.

![](../img/4.rum_view_7.png)

### Binding Views

<<< custom_key.brand_name >>> supports setting bindings or deleting built-in views (user views) to the details page. Clicking to bind a built-in view adds a new view to the current details page.

> For more details, refer to the documentation [Binding Built-in Views](../../scene/built-in-view/bind-view.md).

![](../img/1.rum_view_6.png)