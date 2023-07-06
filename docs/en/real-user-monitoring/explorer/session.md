# Session
---

## Overview

The Session explorer supports viewing a range of details about a user's access session, including the time of the user's access, the path to the page accessed, the number of operations accessed, the access path and the error messages that occurred.

In the Session explorer, you can.

- Visualize the browsing experience of a user accessing a business application and visualize the user's operational behavior.
- Combined with the performance details of user access, you can quickly understand and track the performance of page loading, resource errors, etc. when users access the business application, helping to quickly identify and optimize the code problems of the application.

## Precondition

Guance supports collecting errors, resources, requests, performance metrics, etc. by means of introducing SDK scripts. For details, you can refer to [Rum Collector Configuration](... /... /datakit/rum.md).

## Session Explorer

In the Real User Monitoring explorer, you can switch to the "session explorer" to query and analyze the session data during user access. You can view the session duration (i.e., the time from when a user opens an application to when it is closed), the session type (real user access "user"), the number of page accesses, the number of actions, the number of errors, the initial page visited by the user and the last pages viewed, etc.

![](../img/7.rum_session_3.png)

## Session Detail

Click on the data you need to view in the Session explorer, and in the row out details page, you can view information about the current application's property fields, session details, extended fields, and bound built-in views.

### Property Filter

When the mouse clicks on a property field, it supports "Filter Field Value", "Reverse Filter Field Value", "Add to Display Column" and "Copy " for quick filtering view.

- "Filter field value", that is, add the field to the explorer to view all the data associated with the field
- "Reverse filter field value", that is , add the field to the explorer to see data other than that field
- "Add to display column", that is, add the field to the explorer list for viewing
- "Copy", that is, copy the field to the clipboard 

![](../img/1.rum_session_3.png)



### Session Detail

Session details include user access duration, access type, service type, and access details. The access type includes access action, access path (view), and error message (error). Click the data of view and action type to open the corresponding page access performance details, and click the data of error type to open the corresponding error details.

![](../img/7.rum_session_1.png)

Click on the toggle icon to the right of the time to toggle through the user's access time points.

![](../img/7.rum_session_2.png)

#### Performance Detail

In the session details page, click "view", "action" type data to view the corresponding page access performance details, including long tasks, duration, etc., support filtering and searching, support viewing extended fields, related Fetch/XHR, errors, logs, support binding built-in views, etc. For more details, please refer to [View Explorer](view.md).

![](../img/1.rum_session_4.png)

#### Error Detail

Click on the data of the error type to open the corresponding error details. For more details, please refer to the [error explorer](error.md).

![](../img/1.rum_session_8.png)

### Extended Field

Extension fields include application ID, browser, browser version, system version, etc., and support quick filtering by selecting extension fields.

![](../img/1.rum_session_10.png)



### Binding View

Bound views support the distribution and performance of related data through bound visualizations, such as the Web Application Overview . More details can be found in the document [Binding Built-in Views](... /... /scene/built-in-view/bind-view.md).

![](../img/1.rum_session_11.png)
