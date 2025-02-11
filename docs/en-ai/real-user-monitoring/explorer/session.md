# Session (Session)

---

View a series of details about user access sessions, including user access time, visited page paths, number of operations, access paths, and error messages that occurred.

In the Session Explorer, you can:

- Visually view the browsing experience of users accessing your business application to intuitively understand user behavior;
- Combine performance details of user visits to quickly understand and track page loading, resource errors, and other performance issues during user access to the business application, helping to quickly identify and optimize code problems in the application.


## Explorer

In the Session Explorer, you can view session duration, session type (real user visit "user"), number of pages visited, number of operations, number of errors, the first page visited by the user, and the last page viewed.

???- quote "Definition of Session Duration"

    When a user begins browsing a web application, the user session starts. It aggregates all RUM events collected during the user's browsing using a unique `session_id` attribute.
    
    **Note**: The session will reset after 15 minutes of inactivity.

![](../img/12.rum_explorer_1.png)

## Details Page

Click on the data detail page in the list to view information such as the property fields, session details, extended fields, and bound built-in views of the current application.

![](../img/12.rum_explorer_1.1.png)

### Property Filtering

When you click on a property field, you can quickly filter and view data using the following actions:

| Action      | Description                          |
| ----------- | ------------------------------------ |
| Filter Field Value      | Add this field to the Explorer to view all data related to this field.  |
| Inverse Filter Field Value      | Add this field to the Explorer to view all data except for this field. |
| Add to Display Columns   | Add this field to the Explorer list for viewing. |
| Copy      | Copy this field to the clipboard.                           |

![](../img/12.rum_explorer_1.4.png)

### Session

Session details include user visit duration, visit type, service type, and visit details.

- Visit types include actions (action), pages (view), and error messages (error). Clicking on the corresponding type icon will redirect you to the respective detail page.

![](../img/session-talk.gif)

- Click the icon to the right of the time to switch and view the user's visit timestamps.

![](../img/12.rum_explorer_1.2.png)

- Click the sorting icons :octicons-triangle-up-16: & :octicons-triangle-down-16:, you can sort columns in ascending/descending order (default is descending).

![](../img/session-talk-1.gif)

### Extended Fields

:material-numeric-1-circle-outline: In the search bar, enter the field name or value to quickly locate it;

:material-numeric-2-circle-outline: After checking the alias of the field, you can view it after the field name; choose as needed;

:material-numeric-3-circle-outline: In the trace detail page, you can view relevant field properties under **Extended Fields**:

| Field      | Property                          |
| ----------- | ------------------------------------ |
| Filter Field Value      | Add this field to the Explorer to view all data related to this field, which can be filtered in the trace Explorer to view the list of related traces.                         |
| Inverse Filter Field Value      | Add this field to the Explorer to view all data except for this field.                          |
| Add to Display Columns      | Add this field to the Explorer list for viewing.                          |
| Copy      | Copy this field to the clipboard.                          |

![](../img/extension.gif)

### Bound Views

Guance supports binding or deleting built-in views (user views) to the detail page. Click to bind a built-in view to add a new view to the current detail page.

![](../img/1.rum_session_11.png)

> For more details, refer to [Bind Built-in View](../../scene/built-in-view/bind-view.md).