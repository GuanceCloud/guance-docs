# Data Authorization

---


Guance organizes data based on workspaces, with each workspace containing independent data to ensure data security. Additionally, Guance supports cross-workspace data authorization, **allowing data from multiple workspaces to be authorized and accessed in the current workspace** for querying and display purposes using dashboard and chart components. If you have multiple workspaces, after configuring data authorization, you can view data from all workspaces in one workspace.

Furthermore, considering that users may have multiple workspaces in different sites of Guance, in order to meet the user's need to query data from all workspaces in one workspace, Guance supports **authorization for querying cross-workspace data within the same site**.

## Add Authorization {#site}

Enter **Management > Data Authorization > Shared**, click on **Add**:

![](img/management-data-1.png)

:material-numeric-1-circle-outline: Select the site:

The following site options are provided by default: CN1 (Hangzhou), CN2 (Ningxia), CN3 (Zhangjiakou), CN4 (Guangzhou), CN6 (Hong Kong), US1 (Oregon), EU1 (Frankfurt), AP1 (Singapore).

You can also support manual input configuration (SaaS version only), in the format of the corresponding site's domain name address, for example: https://cn3-auth.guance.com/. To ensure the authorization takes effect, please enter a site URL that can be accessed publicly.

:material-numeric-2-circle-outline: Enter the workspace ID:

Let's assume a case where we need to authorize the data from workspace A to be viewed by workspace B (e.g. DataFlux).

In the Guance workspace B (e.g. DataFlux), click **Management > Settings > Workspace ID**, click **Copy** to obtain its ID.

<img src="../img/9.dataauth_11.png" width="70%" >

:material-numeric-3-circle-outline: Select the role: You can select any role in the current workspace except for "Owner". When the authorized workspace views the data, the data access permissions will be assigned based on the selected role's scope.

For example, if workspace A has Role 1 and Role 2, and you authorize workspace B with the data viewing permissions of workspace A and specify the permissions scope under Role 1 and Role 2, then when members of workspace B query data from workspace A, the data listing and desensitization will be performed based on the data access scope assigned to these two roles in workspace A.


After adding, you can view the authorized workspace B (e.g. DataFlux) that has permission to view the data of the current workspace A in the Authorization List.

![](img/3.data_1.png)

If you need to revoke the data authorization for a certain workspace, you can click **Delete** on the right or select **Bulk Delete**.

![](img/3.data_2.png)


## Data Association

After workspace B (e.g. DataFlux) is granted data authorization, you can open **Scenes > [Dashboard](../scene/dashboard.md)** or **[Note](../scene/note.md)**, select a chart component, and in the **Advanced Settings > Data Authorize**, choose the authorized workspace A (e.g. Development-----), and then you can use **[Chart Query](../scene/visual-chart/chart-query.md)** to view and analyze the data of the authorized workspace A (e.g. Development-----).

![](img/9.dataauth_7.png)


## Mail Notification

When data authorization is added or deleted, the Owner and Administrators of the corresponding workspace will receive email notifications.


## Audit Events

Both adding and deleting data will generate audit events. To view all the audit events for the current workspace, go to **Management > Basic Settings > Security > Operation Audit** and click **View** for all audit events in the current workspace.






