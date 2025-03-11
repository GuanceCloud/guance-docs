# View
---

ou can view the user's browsing environment, trace their actions, analyze the response time of their actions, and understand the performance metrics of the backend application's call chain.

In the View explorer, you can:

- Track user access data for each page, including load time and duration.
- Analyze the performance of user access to the business application by combining data such as resource requests, resource errors, and logs, to quickly identify and optimize code issues in the application.

## Explorer

![](../img/12.rum_explorer_2.png)

In the View explorer, you can quickly view the page address, page load type, page load time, and user duration during user access.


## Details Page

Click on the data in the list to view the performance details of the accessed page, including attributes, sources, performance, link, error and associated logs.

![](../img/12.rum_explorer_1.5.png)

### Source

In the **Source** section, you can view the session details for the current View, and filter/copy the current Session ID.

![](../img/12.rum_explorer_2.6.png)

### Performance

The **Performance** page helps you view the front-end page performance when users access a specific application. This includes page load time, content rendering time, interaction time, input delay, etc. In the example below, the CLS (Cumulative Layout Shift) metric is 0.0006 seconds, indicating that the page is excellent.

![](../img/12.rum_explorer_2.2.png)


### Attributes

Attributes define the nature and characteristics of data objects, and define the value of each attribute.

:material-numeric-1-circle-outline: In the search bar, you can enter the field name or value to quickly search and locate.

:material-numeric-2-circle-outline: After selecting the field alias, you can view it after the field name. You can choose as needed.

:material-numeric-3-circle-outline: On the link details page, you can view the related field attributes of the current link in the **Attributes** section:

| <div style="width: 110px">Options</div> | Description |
| --- | --- |
| Filter | Add the field to the explorer to view all data related to the field. |
| Reverse Filter  | Add the field to the explorer to view data other than the field. |
| Add to columns | Add the field to the explorer list for viewing. |
| Copy | Copy the field to the clipboard. |

![](../img/view-explorer.gif)

### Related Fetch/XHR

When switching to **Fetch/XHR**, you can view every network request made to the backend application during user access, including the time of occurrence, the link of the request, and the duration.

![](../img/4.rum_view_3.png)

If there is a corresponding `trace_id` for the network request, there will be a small icon indicating it before the request. Clicking on it will jump to the details page of the corresponding link.

![](../img/view-1.gif)

### Related Errors

When switching to **Errors**, you can view the error data information, error type, and error occurrence time that occurred during the user's visit.

![](../img/12.rum_explorer_2.4.png)

Clicking on the error information will jump to the details page of the corresponding error.

> For more error details, refer to the [Error Explorer](error.md).

### Related Logs

Through the **Logs** section at the bottom of the details page, you can view the logs and the number of logs based on the current user's visit within the <font color=coral>last 1 hour</font>. You can perform keyword searches, multi-tag filtering, and time sorting on these related logs.

- If you need to view more detailed log information: you can click on the log content to jump to the corresponding log details page, or jump to **Logs** to view all logs related to that host.
- If you need to view more log fields or more complete log content: you can customize the **Max Display Rows** and **Display Columns** through the associated log explorer.

**Note**: For a smoother user querying experience, Guance automatically saves the user's browsing settings in the **Logs** (including "Max Display Rows" and "Display Columns"), so that the **Related Logs** are consistent with the **Logs**. However, any custom adjustments made in the **Related Logs** will not be saved after leaving the page.

![](../img/4.rum_view_7.png)

### Bind Views

Guance supports binding or deleting inner views (user views) to the details page. Click on [**Bind View**](../../scene/inner-view/bind-view.md) to add a new view to the current details page.