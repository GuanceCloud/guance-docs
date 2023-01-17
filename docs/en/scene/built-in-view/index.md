# Built-in view
---


## Introduction

The built-in views are view templates recorded in the Guance Cloud platform, including both system and user views, and you can apply the system view directly to the scenario or customize it as a new built-in view.


## System View

System view is the official view template provided by "Guance Cloud", including Docker monitoring view, JVM monitoring view, Kafka monitoring view, etc. It can be created with one click to provide timely data insight for monitoring objects.

System view supports creating a new system view template as a dashboard directly through the "built-in template library" in 「 Scene」. If you need to make custom changes to this template, you can make custom changes to the system view that has been added to the dashboard.

In the Observation Cloud Workspace "Administration" - "Built-in Views", you can export views, clone views as user views for editing and use.<br />Note: In addition to the system view bound to the viewer, if another system view has been bound to the viewer, you can delete the binding relationship by clicking the "Delete Binding" button.<br />![](../img/4.view_1.png)


## User View

User view is a user-defined view after saving as a template to use the view, support new, modify, export, clone and delete, support editing binding link services, applications, log sources, projects, tags and other associations in the viewer binding related views, the specific operation can refer to the document [binding built-in views](../../scene/built-in-view/bind-view.md) .<br />Note: At present, Guance Cloud only supports manually binding user view to viewer view, if you need to bind system view, you need to clone system view to user view first, if system view and user view have the same name, user view will be displayed in viewer first.<br />![](../img/4.view_3.png)

- New User View: Click 「New User View」 to create a user-defined view template.
- Edit: The user view supports re-editing the name or binding the link service, application, log source, project and other associations. By clicking on the![](../img/image.png)and select "Edit".
- Cloning: The user view can be cloned into a new "user view" by selecting the user view to be cloned and clicking ![](../img/image.png) and select "Clone View", enter the user view name to create a new view with the same content and different name under the current list.
- Export: Support exporting the created user view, click 「Export View」 to export it directly to json file, which can be used for different workspace scenes or built-in view import.
- Delete: Select the user view to be deleted by clicking on ![](../img/image.png) and select "Delete" to delete the view.

**Caution.**

- No renaming of user views in the same workspace
- Add, modify, clone and delete operations of user views are only supported for standard members, administrators and owners


## Exporting view templates

- “The "Guance Cloud" can be exported directly to json files via 「Export View JSON」, and the exported json files can be used for importing scenario dashboards or user views in different workspaces. Both the System View and User View of the built-in view support 「Export View JSON」.

- System view: In the Guance Cloud workspace 「Management」 - 「Built-in view」 - 「System view」, select 「Export view JSON」 under Settings to generate a json file.

![](../img/3.view_2.png)

- User View: Generate a json file by selecting "Export View JSON" under Settings in 「Manage」 - 「Built-in View」 - 「User View」 in the Guance Cloud Workspace.

Note: The user view supports 「Export View JSON」 in both preview and edit states.<br />![](../img/3.view_3.png)


## Import View Template

When customizing user views, Guance Cloud supports importing json files as new view templates, that is, you can import any json files supported by Guance Cloud as user views. The specific operation steps are as follows:

- In Edit mode, click Import View JSON.

![](../img/3.view_4.png)

- Import the json code into the view and click “OK” to create the user view.

**       Note:**

   - **When importing the view json file, the original view will be overwritten. Once overwritten, it cannot be restored. Please operate carefully**
   - **"Import View JSON" only supports user views, system views cannot import view json files**

![](../img/3.view_5.png)

## Exporting views to dashboards

The "Guance Cloud" user view can be exported directly to the scene dashboard through 「Export to Dashboard」, as follows.

- In the Guance Cloud workspace, 「Management」 - 「Built-in Views」 - 「User Views」 select 「Export to Dashboard」 under Settings

Note: The user view supports 「Export to Dashboard」 in both preview and edit states.<br />![](../img/3.view_3.png)

- Enter the dashboard name, select the custom tab (used to filter the dashboard) and click OK.

![](../img/3.view_6.png)

- After confirming completion, you can see the name of the exported dashboard in the dashboard list

![](../img/3.view_8.png)

- Click on the dashboard name to see the same content as the user view.

![](../img/3.view_7.png)



