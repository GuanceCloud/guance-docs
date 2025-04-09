# Cross-Workspace Authorization
---

<<< custom_key.brand_name >>> operates on a per-workspace basis, with data in each workspace being independent to ensure data security. Additionally, <<< custom_key.brand_name >>> supports cross-workspace data authorization, allowing <u>data from multiple workspaces to be authorized for access by the current workspace</u>. This enables querying and displaying data through scenario dashboards and chart components in notes. If you have multiple workspaces, configuring data authorization allows you to view data from all workspaces within a single workspace.

The ability to query data from other workspaces within the same site means that users can consolidate and query data from all workspaces within the same site in one workspace. Note that this feature is limited to workspaces within the same site.

## Adding Data Authorization {#site}

Go to **Manage > Cross-Workspace Authorization > Authorize To**, and click **Add Authorization**:



:material-numeric-1-circle-outline: Enter Workspace ID:

Let's assume a scenario where you need to authorize data from Workspace A to Workspace B (e.g., Guance) for viewing.

In <<< custom_key.brand_name >>> Workspace B (e.g., Guance), go to **Manage > Settings > Workspace ID**, and click **Copy** to obtain its ID.


:material-numeric-2-circle-outline: Select Data Scope: This includes logs, APM, Metrics, base objects, resource catalogs, events, RUM, security checks, network, and profile; multiple selections are supported.

- Log Indexes: If you select log data (i.e., all or logs) as part of your data scope, you can choose the specific indexes you want to authorize for viewing.

**Note**: The indexes here include default indexes and all log indexes. **External indexes are not included**.



After adding, you can view the authorized workspaces in the **Authorization List** that have been granted access to view data from Workspace A (e.g., Guance).



If you need to remove a data authorization for a workspace, you can click **Delete** on the right side or choose **Batch Delete**.



## Data Linkage

Once Workspace B (e.g., Guance) is authorized, it can open **Scenarios > [Dashboard](../scene/dashboard/index.md)** or **[Notes](../scene/note.md)**, select a chart component, and in **Advanced Settings > Space Authorization**, choose the authorized workspace A (as shown below). Then, you can use **[Chart Query](../scene/visual-chart/chart-query.md)** to view and analyze data from the authorized workspace A (as shown below).



## Email Notifications

When data authorization is added or removed, the owners and administrators of the corresponding workspaces will receive email notifications.



## Audit Events

Adding or removing data authorizations generates audit events. Go to **Manage > Basic Settings > Security > Operation Audit**, click **View**, and you can see all audit events for the current workspace.

