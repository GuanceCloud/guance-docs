# Built-in Views
---

Built-in views are view templates recorded in the <<< custom_key.brand_name >>> platform, including [**system views**](#system) and [**user views**](#user). You can directly apply system views to scenarios or customize them as new built-in views.


## System Views {#system}

System views are official view templates provided by <<< custom_key.brand_name >>>, including Docker monitoring views, JVM monitoring views, Kafka monitoring views, Mysql Activity monitoring views, Alibaba Cloud Redis monitoring views, etc. These templates support one-click creation, enabling immediate insights into the data of monitored objects.

    
![](../img/4.view_1_1.png)

System views support creating a new system view template as a dashboard directly through the **built-in template library** within a **scenario**. If you need to customize this template, you can modify the system view that has been added to the dashboard.

- Click to enter the **Scenario > Built-in Views > System Views** page, where you can use the **Clone** button to create a new dashboard or a new user view from the current view.

<img src="../img/4.view_1.png" width="60%" >

- In **Scenario > Built-in Views > System Views**, you can export a specific view.



**Note**: Apart from the system views bound to the Explorer by <<< custom_key.brand_name >>> itself, if any other system views have been previously bound as Explorer views, the binding relationship can be deleted.
    


## User Views {#user}

User views are templates created by users for saving customized views. They support creation, modification, export, cloning, and deletion, as well as editing linked services, applications, log sources, projects, tags, etc., associated with the Explorer-bound views.

> For specific operations, refer to [Binding Built-in Views](../../scene/built-in-view/bind-view.md).

**Note**: Currently, <<< custom_key.brand_name >>> only supports manually binding user views as Explorer views. If you need to bind system views, you must first clone them as user views. If a system view and a user view have the same name, the user view will take precedence in the Explorer display.
    
![](../img/4.view_3.png)

- Creating a user view: Click **Create User View** to create a user-defined view template;
- Editing: User views support re-editing names or linking services, applications, log sources, projects, etc. Click the dropdown button in the top-right corner of the view and select **Edit**;
- Cloning: User views can be cloned into a new **user view**. Select the user view to clone, click the dropdown button in the top-right corner, choose "Clone View", input a new user view name, and a new view with identical content but a different name will be generated in the current list;
- Exporting: Supports exporting created user views. Click **Export View** to directly export as a JSON file for importing into different workspace scenarios or built-in views;
- Deleting: Select the user view to delete, click the dropdown button in the top-right corner, and choose **Delete** to remove the view.

**Note**:

- User views within the same workspace cannot have duplicate names;
- Operations such as adding, modifying, cloning, and deleting user views are only supported by standard members, administrators, and owners.


## Related Operations

### Export View JSON

<<< custom_key.brand_name >>> can export views directly as JSON files, which can be used to import into scenario dashboards or user views in different workspaces.

In <<< custom_key.brand_name >>> workspace **Management > Built-in Views > System Views/User Views**, select **Export View JSON** under settings to generate a JSON file;

![](../img/3.view_2.png)


### Import View JSON

When customizing user views, <<< custom_key.brand_name >>> supports importing JSON files as new view templates. Click **Import View JSON**:

![](../img/3.view_4.png)

**Note**:

- Importing a JSON file will overwrite existing views. Once overwritten, recovery is not possible; please proceed with caution;
- Importing JSON files is only supported for user views, not system views.


### Export to Dashboard

<<< custom_key.brand_name >>> user views can be directly exported to scenario dashboards. Under settings, select **Export to Dashboard**;

![](../img/3.view_3.png)

Input the dashboard name, select custom tags (for filtering dashboards), and click OK.

![](../img/3.view_6.png)


### Pin

If authorized to view data from several other workspaces in the current workspace, you can choose to pin workspace A, making it the default workspace for querying view data.

<img src="../img/view-pin.png" width="60%" >

At the same time, if the Explorer detail page is bound to this user view, it will default to querying and displaying data from the pinned workspace. As shown below:

![](../img/pin-example.png)