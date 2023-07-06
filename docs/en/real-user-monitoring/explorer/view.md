# View
---

## Overview

The View explorer supports viewing the user access environment, retracing the user's action path, breaking down the response time of user actions, and understanding the performance metrics of a series of call chains to the back-end application as a result of user actions.

In the View explorer, you can.

- Track user access data for each page, including load time, dwell time, and more.
- Combine resource requests, resource errors, logs, and other data associated with each page to comprehensively analyze the performance of user access to business applications, helping to quickly identify and optimize application code issues.

## Precondition

Guance supports collecting errors, resources, requests, performance metrics, etc. by means of introducing SDK scripts. For details, you can refer to [Rum Collector Configuration](... /... /datakit/rum.md).

## View Explorer

In the Real User Monitoring explorer, you can switch to "view explorer" to query and analyze the page performance data during user access, you can quickly view the page address, page load type, page load time, user dwell time, etc. during user access.

![](../img/1.rum_view_0.png)

## View Detail

Click on the data you need to view in the list, and the page performance details accessed by the user are displayed in the scratch detail page, including attributes, performance details, link details, error details, associated logs, etc.

### Property Field

Properties are the nature and characteristics of the data object that defines the value of each property. When the mouse clicks on an attribute field, it supports "Filter Field Value", "Reverse Filter Field Value", "Add to Display Column" and "Copy " for quick filtering view.

- "Filter field value", that is, add the field to the explorer to view all the data associated with the field
- "Reverse filter field value", that is , add the field to the explorer to see data other than that field
- "Add to display column", that is, add the field to the explorer list for viewing
- "Copy", that is, copy the field to the clipboard 

![](../img/1.rum_view_7.png)

### Performance Detail

The "Performance" page helps you see the page performance of the front-end when users visit a given application, including page load time, content drawing time, interaction time, input latency, etc. As an example, the figure below shows that the LCP ([Maximum Content Drawing Time](web/app-analysis.md)) metric reaches 8.79 seconds, while the recommended time is within 2.5 seconds, indicating that the page speed is slow to load and needs to be optimized. The performance details page supports filtering and searching to help users quickly locate resources and content.

![](../img/4.rum_view_2.png)

Click on an error in the performance details (data with the "error" flag in the View list) to see the details corresponding to the error.

![](../img/4.rum_view_6.png)

### Extended Field

When the extended field is selected with the mouse, click the drop-down icon in front of it to display the "Filter Field Value", "Reverse Filter Field Value", "Add to Display Column" and "Copy" icons for quick filtering view.

![](../img/18.rum_1.png)

### Associated Fetch/XHR

When switching to "Fetch/XHR", it supports viewing every network request sent to the back-end application when the user accesses, including the time of occurrence, the link of the request and the duration.

![](../img/4.rum_view_3.png)

If the corresponding trace_id exists for a network request, a small icon will be prompted before the request, click on the request to jump to the details page of the corresponding link.

![](../img/4.rum_view_4.png)

### Association error

When you switch to Errors, you can view information about the error data that appeared at the time of the user's visit, the type of error, and when the error occurred.

![](../img/4.rum_view_5.png)

Click on the error message to jump to the details page of the corresponding error. For more error details, please refer to the document [Error Explorer](error.md).

![](../img/4.rum_view_6.png)

### Associated Log

Through "Logs" at the bottom of the detail page, you can view the logs and the number of logs based on the **last 1 hour** accessed by the current user, and perform keyword search, multi-tab filtering and time-sorting on these related logs, etc.

- If you need to view more detailed log information, you can click on the log content to jump to the corresponding log detail page, or click "Jump" to "Logs" to view all logs related to this host.
- If you need to view more log fields or more complete log content, you can customize the "Maximum number of rows" and "Display columns" through the "Display Columns" of the associated log explorer.
  **Note: For a smoother user query experience, Guance saves the user's browsing settings (including "Maximum number of rows" and "Display columns") in "Logs" by default, so that the "Associated Log" are consistent with the "Logs". However, the custom adjustments made in the associated log are not saved after exiting the page. **

### Binding View

Bound views support the distribution and performance of related data through bound visualizations, such as the Web Application Overview . More details can be found in the document [Binding Built-in Views](... /... /scene/built-in-view/bind-view.md).

![](../img/1.rum_view_6.png)
