# Built-in Views
---

Built-in views are view templates recorded in the Guance platform, including [**system views**](#system) and [**user views**](#user). You can directly apply system views to scenarios or customize them as new built-in views.


## System Views {#system}

System views are official view templates provided by Guance. They include Docker monitoring views, JVM monitoring views, Kafka monitoring views, Mysql Activity monitoring views, Alibaba Cloud Redis monitoring views, etc., supporting you to create them with one click and promptly start data insights for monitored objects.

    
![](../img/4.view_1_1.png)

System views support creating a new system view template as a dashboard directly through the **built-in template library** within **scenes**. If you need to customize this template, you can modify the system view already added to the dashboard.

- Click into the **Scenes > Built-in Views > System Views** page, where you can use the **Clone** button to create the current view as a new dashboard or new user view.

<img src="../img/4.view_1.png" width="60%" >

- In **Scenes > Built-in Views > System Views**, you can export a specific view.

**Note**: Besides the system views bound to the Explorer by Guance itself, if other system views have been previously bound to the Explorer's view, the binding relationship can be deleted.


## User Views {#user}

User views are templates of views customized and saved by users. They support creation, modification, export, cloning, and deletion. They also support editing bindings to link services, applications, log sources, projects, tags, etc., associated with views bound to the Explorer.

> For detailed operations, refer to [Binding Built-in Views](../../scene/built-in-view/bind-view.md).

**Note**: Currently, Guance only supports manually binding user views to the Explorer's view. To bind a system view, you need to first clone it as a user view. If a system view and a user view have the same name, the user view will be prioritized when displayed in the Explorer.
    
![](../img/4.view_3.png)

- Create a new user view: Click **Create New User View** to create a custom user view template;
- Edit: User views support re-editing names or bindings to link services, applications, log sources, projects, etc. By clicking the drop-down button in the top-right corner of the view and selecting **Edit**;
- Clone: User views can be cloned into a new **user view**. Select the user view to clone, click the drop-down button in the top-right corner, choose "Clone View", input the user view name, and a new view with the same content but a different name will be generated in the current list;
- Export: Supports exporting created user views as JSON files, which can be used to import into different workspaces or built-in views. Click **Export View** to directly export as a JSON file;
- Delete: Select the user view to delete, click the drop-down button in the top-right corner, and select **Delete** to remove the view.

**Note**:

- User views cannot have duplicate names within the same workspace;
- Operations such as adding, modifying, cloning, and deleting user views are only supported by standard members, administrators, and owners.


## Related Operations

### Export View JSON

Guance can export views directly as JSON files, which can be used to import new view templates into different workspace dashboards or user views.

In the Guance workspace **Management > Built-in Views > System Views/User Views**, select **Export View JSON** under settings to generate a JSON file;

![](../img/3.view_2.png)


### Import View JSON

When customizing user views, Guance supports importing JSON files as new view templates. Click **Import View JSON**:

![](../img/3.view_4.png)

**Note**:

- Importing a View JSON file will overwrite the existing view, and once overwritten, it cannot be restored. Please proceed with caution;
- Importing View JSON is only supported for user views; system views cannot be imported via JSON files.


### Export to Dashboard

Guance user views can be directly exported to scene dashboards. Under settings, select **Export to Dashboard**;

![](../img/3.view_3.png)

Input the dashboard name, select custom tags (for filtering dashboards), and click confirm.

![](../img/3.view_6.png)


### Pin

When authorized to view data from several other workspaces in the current accessed workspace, you can choose to pin an authorized workspace A, setting it as the default workspace for querying view data.

<img src="../img/view-pin.png" width="60%" >

At the same time, if the Explorer details page binds this user view, it will default to querying and displaying data from the pinned workspace. As shown below:

![](../img/pin-example.png)