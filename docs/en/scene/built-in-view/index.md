# Inner Dashboards
---


## Overview

Inner dashboards are view templates recorded in the Guance platform, including **system view and user view**, and you can apply the system view directly to the scenario or customize it as a new inner dashboard.


## System View

### What is it?
System view is the official view template provided by Guance, including Docker monitoring view and JVM monitoring view, Kafka monitoring view. It can be created with one click to provide timely data insight for monitoring objects.

### What can you do with it?
System view supports creating a new system view template as a dashboard directly through the **Inner Template Library** in **Scene**. If you need to make custom changes to this template, you can make custom changes to the system view that has been added to the dashboard.

### How to use it?
In the Guance Workspace **Management > Inner Dashboards**, you can export views, clone views as user views for editing and use.<br />Note: In addition to the system view bound to the explorer, if another system view has been bound to the explorer, you can delete the binding relationship by clicking the **Delete Binding** button.<br />![](../img/4.view_1.png)


## User View

### What is it?
User view, namely a user-defined view after saving as a template to use the view.

### What can you do with it?
You are available to create, modify, export, clone and delete user views. Meanwhile, you can edit binding link services, applications, log sources, projects, tags and other associations in the explorer binding related views, the specific operation can refer to the document [binding inner dashboards](../../scene/built-in-view/bind-view.md).

> Note: At present, Guance only supports manually binding user view to explorer view, if you need to bind system view, you need to clone system view to user view first, if system view and user view have the same name, user view will be displayed in explorer first.<br />![](../img/4.view_3.png)

**ATTENTION:**

- Renaming of user views in the same workspace **IS NOT ALLOWED**.
- Add, modify, clone and delete operations of user views **ARE ONLY SUPPORTED FOR** standard members, administrators and owners.

As mentioned before, you are available to create, edit, clone and delete user view. Also, you can import or export user view. <u>The function would be discussed in the following text.</u>

## Exporting View Templates

- Guance can be exported directly to json files via **Export View JSON**, and the exported json files can be used for importing scenario dashboards or user views in different workspaces. Both the **System View** and **User View** of the inner dashboard support the function.

- System view: In the Guance workspace **Management > Inner dashboard > System View**, select **Export View JSON** under **Setting** to generate a json file.

![](../img/3.view_2.png)

- User view: Generate a json file by selecting **Export View JSON** under **Setting** in **Management > Inner dashboard > User View** in the Guance Workspace.

> Note: The user view supports 「Export View JSON」 in both preview and edit states.<br />![](../img/3.view_3.png)


## Import View Templates

When customizing user views, you can import any json files supported by Guance as user views. The specific operation steps are as follows:

- In **Edit** mode, click **Import View JSON**.

![](../img/3.view_4.png)

- Import the json code into the view and click **OK** to create the user view.

**Note:**

   - **When importing the view json file, the original view will be overwritten and cannot be restored. Please operate carefully.**
   - **The operation only available to user views; System views cannot import view json files.**

![](../img/3.view_5.png)

## Exporting Views to Dashboards

User view can be exported directly to the scene dashboard through **Export to Dashboard**.

- In the Guance workspace, **Management > Inner dashboards > User Views** select **Export to Dashboard** under **Setting**.

> Note: The user view supports **Export to Dashboard** in both preview and edit states.<br />![](../img/3.view_3.png)

- Enter the dashboard name, select the custom tab (used to filter the dashboard) and click OK.

![](../img/3.view_6.png)

- After confirming completion, you can see the name of the exported dashboard in the dashboard list.

![](../img/3.view_8.png)

- Click on the dashboard name to see the same content as the user view.

![](../img/3.view_7.png)



