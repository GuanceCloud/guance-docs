# Cross-Workspace Authorization
---

Guance organizes data by workspace, ensuring that data within each workspace is independent and secure. Additionally, Guance supports cross-workspace data authorization, allowing you to <u>authorize multiple workspaces' data to the current workspace</u>. This enables querying and displaying the data through dashboard and notebook chart components. If you have multiple workspaces, configuring data authorization allows you to view all workspace data from a single workspace.

The ability to query data from other workspaces within the same site means users can consolidate and query data from all workspaces within the same site from one workspace. Note that this feature is limited to workspaces within the same site.

## Adding Data Authorization {#site}

Navigate to **Management > Cross-Workspace Authorization > Authorize To**, and click **Add Authorization**:

![](img/management-data-1.png)

:material-numeric-1-circle-outline: Enter the Workspace ID:

Let's assume a scenario where you need to authorize data from Workspace A to Workspace B (e.g., Guance) for viewing.

In the Guance Workspace B (e.g., Guance), go to **Management > Settings > Workspace ID**, and click **Copy** to obtain its ID.

<img src="../img/9.dataauth_11.png" width="70%" >

:material-numeric-2-circle-outline: Select Data Scope: This includes logs, APM, Metrics, basic objects, Resource Catalog, events, RUM, Security Check, network, profile; multi-selection is supported.

- Log Indexes: If you choose a data scope that includes log data (i.e., all or logs), you can further select the indexes you want to authorize for viewing.

**Note**: These indexes include default indexes and all log indexes. **External indexes are not included**.

![](img/9.dataauth_11.png)

<!--
:material-numeric-2-circle-outline: Select Role: You can choose any role in the current workspace except "Owner". When the authorized workspace accesses data, it will be granted access based on the selected role's permissions.

For example, if Workspace A has roles 1 and 2, and you authorize data viewing permissions from Workspace A to Workspace B with roles 1 and 2, then members of Workspace B accessing A’s data will see data based on the permission scopes of these two roles.
-->

After adding, you can view the authorized workspaces in the **Authorization List**. For example, you can see Workspace B (e.g., Guance) which has been authorized to view data from Workspace A.

![](img/3.data_1.png)

To delete an authorization, click **Delete** on the right side or choose **Batch Delete**.

![](img/3.data_2.png)


## Data Linkage

After Workspace B (e.g., Guance) obtains data authorization, you can open **Scenarios > [Dashboard](../scene/dashboard/index.md)** or **[Notebook](../scene/note.md)**, select a chart component, and in **Advanced Settings > Space Authorization**, choose the authorized Workspace A (as shown below). Then you can use **[Chart Query](../scene/visual-chart/chart-query.md)** to view and analyze data from the authorized Workspace A.

![](img/9.dataauth_7.png)

<!--
<u>Dashboard Example:</u>

The top three charts with data display query results from the authorized Workspace A (e.g., Development----); the bottom three charts show data gaps from the current Workspace B (e.g., DataFlux), indicating data gaps in this workspace.

![](img/9.dataauth_8.png)
-->

## Email Notifications

Owners and administrators of the corresponding workspaces will receive email notifications when data authorizations are added or removed.

<img src="../img/9.dataauth_9.png" width="70%" >


## Audit Events

Adding or removing data authorizations generates audit events. Navigate to **Management > Basic Settings > Security > Operation Audit**, and click **View** to see all audit events for the current workspace.

<!--
![](img/9.dataauth_12.png)
-->