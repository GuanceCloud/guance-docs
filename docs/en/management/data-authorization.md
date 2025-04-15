# Cross-Workspace Authorization
---


<<< custom_key.brand_name >>> operates on a workspace basis, with each workspace's data being independent to ensure data security. At the same time, it supports cross-workspace data authorization, **allowing multiple workspaces' data to be authorized to the current workspace**, enabling queries and displays through scenario dashboards and chart components in notes. After configuring data authorization, you can view all workspace data from one workspace.


The function of querying other workspace data within the same site inside a workspace allows users to aggregate queries for all workspace data within the same site in one workspace. Note that this feature is limited to workspaces within the same site.


???+ warning "Note"

    Multi-site simultaneous queries are not supported.

    
## Add Authorization {#site}

1. Go to **Management > Cross-Workspace Authorization > Authorize To**;
2. Click **Add Authorization**;
3. Select the authorized site;
4. Enter the authorized workspace ID;
5. Define the data scope;
6. Confirm.


???+ abstract "How to Obtain Workspace ID"

    Go to **Management > Settings > Workspace ID**, click **Copy**, and you will obtain the workspace ID.

    <img src="../img/get_workspace_id.png" width="70%" >

### Data Scope

Includes cloud billing, logs, application performance, metrics, basic objects, resource catalogs, events, user access, security checks, networks, profile; supports multi-selection.

- Log indexes: If the selected data scope includes log data (i.e., selecting "All", "Logs"), you can continue to select the indexes you need to authorize for viewing.

???+ warning "Note"

    The indexes here include default indexes and all log indexes. **External indexes are not included.**


## View Authorization

- Authorized To: Add authorizations for other workspaces in this workspace;

- Can View: Add authorizations for this workspace in other workspaces.


In the authorization list, you can perform the following operations for management:

- Filter lists by site;
- Search and locate by entering workspace name or ID;
- Delete data authorization for a specific workspace;
- Re-edit authorization rules via the edit button;
- When adding or deleting data authorizations, the system will generate audit events and send email notifications to the owners and administrators of the corresponding workspaces.



## Use Cases

After successfully adding cross-workspace authorization, you can use the following entries within the workspace for cross-space queries.


<div class="grid" markdown>

=== "Dashboard"


    <img src="../img/data_auth_dashboard.png" width="70%" >

    ---

=== "Chart Query"

    <img src="../img/data_auth_chart.png" width="70%" >

    ---


=== "Built-in Views"

    <img src="../img/data_auth_inner_view.png" width="70%" >

    ---

=== "Log Explorers"

    <img src="../img/data_auth_log_explorer.png" width="70%" >

    ---

=== "Error Tracking"

    <img src="../img/data_auth_log_error.png" width="70%" >

    ---

=== "Resource Catalogs"

    <img src="../img/data_auth_resource_catalog.png" width="70%" >

    ---


</div>