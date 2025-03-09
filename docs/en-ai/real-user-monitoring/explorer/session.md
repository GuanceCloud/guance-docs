# Session (Session)

---

View a series of details about user access sessions, including user access time, page path visited, number of operations, access paths, and error messages that occurred.

In the Session Explorer, you can:

- Visually review the browsing experience of users accessing your business application to intuitively understand user behavior;
- Combine performance details of user visits to quickly understand and track page loading and resource errors when users access your business application, helping to rapidly identify and optimize code issues in the application.


## Explorer

In the Session Explorer, you can view session duration, session type (real user visit "user"), number of pages visited, number of operations, number of errors, the first page the user accessed, and the last page browsed.

???- quote "Definition of Session Duration"

    When a user starts browsing a web application, the user session begins. It aggregates all RUM events collected during the user's browsing using a unique `session_id` attribute.
    
    **Note**: The session resets after 15 minutes of inactivity.

![](../img/12.rum_explorer_1.png)

## Details Page

Click on the data details page in the list to view information such as property fields, session details, extended fields, and bound built-in views for the current application.

![](../img/12.rum_explorer_1.1.png)

### Property Filtering

When you click on a property field, you can perform quick filtering with the following actions:

| Action           | Description                                                                 |
| ------------------ | ------------------------------------------------------------------------------- |
| Filter Field Value | Adds this field to the Explorer to view all data related to this field.         |
| Inverse Filter     | Adds this field to the Explorer to view all data except for this field.         |
| Add to Display Columns | Adds this field to the Explorer list for viewing.                            |
| Copy              | Copies this field to the clipboard.                                             |

![](../img/12.rum_explorer_1.4.png)

### Session

Session details include user visit duration, visit type, service type, and visit details.

- Visit types include actions (action), pages (view), and error messages (error). Clicking the corresponding type icon will redirect you to the respective detail page.

![](../img/session-talk.gif)

- Click the icon to the right of the time to switch between different user visit timestamps.

![](../img/12.rum_explorer_1.2.png)

- Click the sort icon :octicons-triangle-up-16: & :octicons-triangle-down-16:, you can sort columns in ascending/descending order (default is descending).

![](../img/session-talk-1.gif)

### Extended Fields

:material-numeric-1-circle-outline: In the search bar, enter the field name or value to quickly locate it;

:material-numeric-2-circle-outline: After checking the alias, you can view it after the field name; select as needed;

:material-numeric-3-circle-outline: In the trace details page, you can view relevant field properties under **Extended Fields**:

| Field           | Attribute                                                                 |
| ------------------ | ------------------------------------------------------------------------------- |
| Filter Field Value | Adds this field to the Explorer to view all data related to this field, allowing you to filter and view the related trace list in the trace Explorer. |
| Inverse Filter     | Adds this field to the Explorer to view all data except for this field.         |
| Add to Display Columns | Adds this field to the Explorer list for viewing.                            |
| Copy              | Copies this field to the clipboard.                                             |

![](../img/extension.gif)

### Bound Views

<<< custom_key.brand_name >>> supports setting up or deleting built-in views (user views) to the details page. Click to bind a built-in view to add a new view to the current details page.

![](../img/1.rum_session_11.png)

> For more details, refer to [Bind Built-in View](../../scene/built-in-view/bind-view.md).