# View (Page)
---

You can view user access environments, trace back the user's operation paths, break down the response times of user operations, and understand the performance metrics of a series of backend application calls caused by user operations.

In the View Explorer, you can:

- Track user access data for each page, including loading time, dwell time, etc.;
- Combine data from resource requests, resource errors, logs, and other related resources on each page to comprehensively analyze the performance of user access to business applications. This helps quickly identify and optimize code issues in the application.


## Explorer

In the View Explorer, you can quickly view the page URL, page load type, page load time, user dwell time, and more during user visits.

![](../img/12.rum_explorer_2.png)

## Details Page

By clicking on the details page of the data in the list, you can view detailed performance information about the pages visited by users, including attributes, sources, performance details, trace details, error details, associated logs, etc.

![](../img/12.rum_explorer_1.5.png)

### Sources

The **Sources** section supports viewing session details for the current View, allowing you to filter/copy and view the current Session ID.

![](../img/12.rum_explorer_2.6.png)

### Performance

The **Performance** page helps you view the frontend page performance when users access specific applications, including page load time, content rendering time, interaction time, input delay, etc. For example, the LCP (Largest Contentful Paint) metric reached 8.4 seconds, while the recommended time is within 2.5 seconds, indicating that the page loading speed is slow and needs optimization.

![](../img/12.rum_explorer_2.2.png)

For events on the current page, you can choose to display the most recent 50, 100, 200 entries, or all entries:

<img src="../../img/12.rum_explorer_2.5.png" width="70%" >

### Extended Fields

Attributes define the properties and characteristics of data objects, specifying the value of each attribute.

:material-numeric-1-circle-outline: In the search bar, you can enter field names or values to quickly search and locate;

:material-numeric-2-circle-outline: After checking the field alias, you can view it after the field name as needed;

:material-numeric-3-circle-outline: In the trace details page, you can view relevant field attributes of the current trace under **Extended Fields**:

| Action              | Description                                             |
|---------------------|---------------------------------------------------------|
| Filter field values | Add this field to the explorer to view all data related to this field. |
| Reverse filter      | Add this field to the explorer to view all data except for this field. |
| Add to display columns | Add this field to the explorer list for viewing.          |
| Copy                | Copy this field to the clipboard.                          |

![](../img/view-explorer.gif)

### Associated Fetch/XHR

Switching to **Fetch/XHR**, you can view every network request made by the user to the backend application during their visit, including the occurrence time, request trace, and duration.

![](../img/4.rum_view_3.png)

If a network request has a corresponding `trace_id`, there will be a small icon before the request, which you can click to jump to the corresponding trace detail page.

![](../img/view-1.gif)

Clicking on a data row allows you to choose to view the related trace or resource for that data entry.

![](../img/4.rum_view_3_1.png)

### Associated Errors

Switching to **Errors**, you can view error data, error types, and error occurrence times during the user visit.

<img src="../../img/12.rum_explorer_2.4.png" width="80%" >

Clicking on an error message will redirect you to the corresponding error detail page.

> For more error details, refer to [Error Explorer](error.md).

### Associated Logs

Through the **Logs** section at the bottom of the details page, you can view logs and log counts based on the current user visit for the **last hour**, and perform keyword searches, multi-label filtering, and time sorting on these related logs.

- If you need to view more detailed log information: you can click on the log content to jump to the corresponding log detail page, or click **Jump to** **Logs** to view all logs related to the host.
- If you need to view more log fields or complete log content: you can customize and adjust the **maximum number of displayed rows** and **display columns** via the associated log explorer.

**Note**: To enhance user query experience, Guance automatically saves user browsing settings in **Logs** (including "maximum number of displayed rows", "display columns") so that **Associated Logs** remains consistent with **Logs**. However, custom adjustments made in **Associated Logs** are not saved after exiting the page.

![](../img/4.rum_view_7.png)

### Bind Views

Guance supports binding or removing built-in views (user views) to the details page. Clicking on bind built-in view adds a new view to the current details page.

> For more details, refer to the documentation [Bind Built-in View](../../scene/built-in-view/bind-view.md).

![](../img/1.rum_view_6.png)