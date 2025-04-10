# Built-in Views
---

A view is a tool used for displaying and analyzing data, helping users quickly obtain and understand insights from the data. Views can be used for:

- Data Monitoring: Use [system views](#system) to monitor key metrics and system operational status in real time, such as Docker, JVM, etc.
- Data Analysis: Utilize [user views](#user) for custom analysis, exploring data in depth to uncover potential issues and trends.
- Data Sharing: Bind views to Explorers to ensure data consistency and accessibility.

## System Views {#system}

System views are official view templates provided by the system, covering various monitoring scenarios such as Docker, JVM, Kafka, etc.

<img src="../img/built_in_system_view.png" width="70%" >

1. Go to Scenario > Built-in Views > System Views;
2. Click to enter a specific view;
3. You can choose to directly create it as a [new dashboard](../dashboard/index.md#blank) or a [new user view](./bind-view.md);
4. Click confirm, and you can reuse this system view.


## User Views {#user}

[Customize and save](../../scene/built-in-view/bind-view.md) view templates.


???+ warning "Note"

    - User views under the same workspace are not allowed to have duplicate names;
    - Currently, only manual binding of user views to Explorer views is supported. To bind system views, first clone them as user views. If system views and user views have the same name, the Explorer will prioritize displaying the user view.


## Manage Views

### Export View JSON

Select built-in views > System Views/User Views, click "Export View JSON" to generate a JSON file. This file can be used to import scene dashboards or user views into other workspaces.


### Import View JSON

When customizing user views, click "Import View JSON" to use the JSON file as a new view template.

???+ warning "Note"

    Importing will overwrite the original view and cannot be undone, and only supports user views.



### Export to Dashboard

User views can be directly exported to scene dashboards.

1. Click "Settings";
2. Select "Export to Dashboard";
3. Enter a name and select tags;
4. Click confirm.


### Pin

If the current workspace is authorized to access data from other workspaces, you can pin target workspace A in the view to make it the default query space.

<img src="../img/view-pin.png" width="70%" >

If the Explorer details page is bound to this user view, it will display data according to the pinned workspace by default.

<img src="../img/pin-example.png" width="70%" >