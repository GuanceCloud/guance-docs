# Inner Views

---

Inner views are view templates recorded on the Guance platform, including **[System Views](#system)** and **[User Views](#user)**. You can directly apply system views to scenes or customize them into new inner views.

## System Views {#system}

System views are official view templates provided by Guance, including Docker Monitoring Views, JVM Monitoring Views, Kafka Monitoring Views, etc. They allow you to create with one click and start data insights for monitoring targets instantly.

System views can be created in **Scenes** through the **Inner Template Library**. If you need to customize the template, you can modify the system view that has been added to the dashboard.

In the Guance workspace **Management > Inner Views**, you can export views, clone views as user views for editing and use.

**Note**: In addition to the system views bound by Guance itself, if other system views have been bound as explorer views, you can click **Delete** to unbind the relationship.


## User Views {#user}

User views are views saved as templates after users customize them. They support creation, modification, export, cloning, and deletion, and allow editing binding services, applications, log sources, projects, tags, etc., associated with explorer-bound views.

> For specific operations, see [Binding Inner Views](../../scene/built-in-view/bind-view.md).

**Note**: Currently, Guance only supports manual binding of user views as explorer views. If you need to bind system views, you need to clone system views as user views first. If system views and user views have the same name, user views are displayed first in the explorer.

![](../img/4.view_3.png)

- Create: Click **Create** to create a user-customized view template;
- Edit: User views support re-editing names or binding services, applications, log sources, projects, etc. Click the dropdown button in the upper right corner of the view and choose **Edit**;
- Clone: User views support cloning into a new **User View**. Select the user view to be cloned, click the dropdown button in the upper right corner of the view, select "Clone view", enter the user view name to generate a new view with the same content and different name under the current list;
- Export: Supports exporting created user views. Click **Export View** to directly export as a JSON file for different workspace scenes or inner view imports;
- Delete: Select the user view to be deleted, click the dropdown button in the upper right corner of the view, choose **Delete** to remove the view.

**Notes**:

- User views under the same workspace cannot have the same name;
- Only standard members, administrators, and owners support operations such as adding, modifying, cloning, and deleting user views.

## Related Operations

### Export View JSON

Guance can directly export as a JSON file through **Export View JSON**. The exported JSON file can be used for the import of scene dashboards or user views in different workspaces. 

In Guance workspace **Management > Inner Views > System Views/User Views**, select **Export View JSON** under settings to generate a JSON file;

![](../img/3.view_2.png)


### Import View JSON

When customizing user views, Guance supports importing JSON files as new view templates. click **Import View JSON**.

![](../img/3.view_4.png)


**Note**:

- Importing view JSON files will overwrite the original view, and once overwritten, it cannot be recovered. Please operate carefully;
- Importing view JSON only supports user views, system views cannot import view JSON files.


### Export to Dashboard

User views of Guance can directly export views to the scene dashboard. Select **Export to Dashboard** under Settings;


![](../img/3.view_3.png)

Enter the dashboard name, choose custom tags (to filter dashboards), click Confirm.

![](../img/3.view_6.png)


