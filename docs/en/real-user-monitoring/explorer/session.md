# Session

---

You can view a series of details about the user's visit session, including the user's visit time, visit page path, visit operation count, visit path and error messages encountered.

In the Session explorer, you can:

- Visually view the browsing experience of users accessing the business application, intuitively understand user's actions.
- Combine with the performance details of user's visit, quickly understand and track the performance situation of page loading, resource errors, etc. when users access the business application, to help quickly discover and optimize the code issues of the application.

## Explorer

In the Session explorer, you can view the session duration, session type (real user visit "user"), page visit count, operation count, error count, the initial page visited by the user, and the last page viewed by the user.

???- quote "Definition of session duration"

    When users start browsing the web application, the user session begins. It uses the unique `session_id` attribute to aggregate all RUM events collected during the user's browsing.

    **Note**: The session will be reset after 15 minutes of inactivity.

![](../img/12.rum_explorer_1.png)

## Details Page

Click on the data details page in the list to view the current application's attributes, session details and bound inner views.

![](../img/12.rum_explorer_1.1.png)


![](../img/12.rum_explorer_1.4.png)

### Session

Session details include session duration, visit type, service type and visit details.

- Visit type includes visit actions (action), visit path (view), and error messages encountered (error), etc. Click on the corresponding type icon to jump to the corresponding details page.

![](../img/session-talk.gif)

- Click on the icon on the right side of the time to switch and view the user's visit time point.

![](../img/12.rum_explorer_1.2.png)

- Click on the sort icon :octicons-triangle-up-16: & :octicons-triangle-down-16: to sort each column in ascending/descending order (default is descending).

![](../img/session-talk-1.gif)


### Attributes

:material-numeric-1-circle-outline: In the search bar, you can enter the field name or value to quickly search and locate.

:material-numeric-2-circle-outline: After selecting the field alias, you can view it after the field name. You can choose as needed.

:material-numeric-3-circle-outline: On the link details page, you can view the related field properties of the current link in the **Attributes**:

| Field | Property |
| --- | --- |
| Filter Field Value | Add the field to the explorer to view all data related to that field, and filter and view the list of links related to that field in the link explorer. |
| Reverse Filter Field Value | Add the field to the explorer to view data other than that field. |
| Add to Displayed Columns | Add the field to the explorer list for viewing. |
| Copy | Copy the field to the clipboard. |

![](../img/extension.gif)

### Bind Views

Guance supports setting bound or deleting inner views (user views) to the details page. Click on [**Bind View**](../../scene/inner-view/bind-view.md) to add a new view to the current details page.

![](../img/1.rum_session_11.png)
