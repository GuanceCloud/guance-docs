# Page Management

After entering a dashboard page, you can manage the dashboard through the following operations.

## Card Properties Information {#metadata}

Upon entering a specific dashboard, you can view the illustrated information at the top of the page under `metadata`.

![Dashboard Metadata](../../img/dashboard-metadata.png)

In addition to viewing the current dashboard's ID, identifier ID, creator, creation time, updater, and update time, you can also directly click to modify the name, description, labels, and visibility range of the current dashboard here.

If necessary, click delete here, confirm again, and the current dashboard will be deleted.

**Note**: If the current dashboard page is saved as a snapshot and shared externally, non-logged-in users cannot view the card properties information here.

## Add Charts

After creating a dashboard, you can add charts to it.

After selecting a chart, click **Complete Addition**.

![](../img/2.dashboard_4.png)

### Grouping {#group}

You can categorize the charts within the dashboard.

1. Click Group;
2. Enter the group name;
3. Select the group color as needed;
4. Click Confirm.

![](../img/dashboard-group.png)

To modify this group, hover over and click the settings button on the right side.

![](../img/dashboard-group-1.png)

## Cross-Workspace Query {#cross-workspace}

If a workspace is granted access to other workspaces, you can switch workspaces in the dashboard to view corresponding chart information.

**Note**: If the charts in the dashboard have already configured workspace query settings, these settings take precedence over global dashboard or Explorer configurations.

![](../img/dashboard-workspace.png)

### Pin {#pin}

When the current workspace is authorized to view data from several other workspaces, you can choose to pin an authorized workspace A, making it the default workspace for querying data.

![Pin Workspace](../../img/pin.png)

**Note**:

1. Only one workspace can be designated as the default option each time, so setting another workspace as the default will invalidate the previous default.
2. You can unpin other workspaces; after canceling, the current workspace will be used by default to fill in query data.
3. Read-only members do not support this operation.

## Full-Screen Mode

Guance automatically hides the left and top navigation bars and displays the view in full screen. Press the **ESC** key to exit full-screen mode.

![](../img/2.dashboard_2.png)

## Auto Refresh {#refresh}

Helps you quickly obtain real-time dashboard data.

Available frequencies: 5s, 10s, 30s, 1m, 5m, 30m, 1h.

If auto-refresh is not needed, select Off (Disabled).

**Note**: All dashboards and views share one refresh configuration.

## Settings

After creating a dashboard, click :octicons-gear-24: to perform the following operations on the dashboard.

![](../img/2.dashboard_3.png)

### Create New Issue 

You can create an Issue based on anomalies observed in the current dashboard.

> For more related operations, refer to [How to Manually Create an Issue at the View Level](../../exception/issue.md#dashboards). For more information about Issues, refer to [Incident](../../exception/index.md).

### Save Snapshot 

1. Enter the snapshot name;
2. Choose the visibility scope;
3. Select the time range, which will be automatically filled when opening the snapshot again;
4. Click Confirm.

Besides opening the save page via the button, you can also use the shortcut keys `(Windows: Ctrl+K / Mac OS: Cmd+K)` to quickly save a snapshot. After saving, you can view it in **Shortcut > Snapshots**.

> For more details, refer to [Snapshot](../../getting-started/function-details/snapshot.md).

### Save to Built-in View

1. The view name defaults to the current dashboard name but can be modified;
2. Choose binding relationships, such as `label:*`;
3. Click Confirm.

**Note**: In the same workspace, user views are not allowed to have duplicate names.

After saving, you can view the saved dashboard view "CPU Monitoring View" in **Scenarios > Built-in Views > User Views**.

Additionally, because the binding relationship `label:*` is set, the bound built-in view "CPU Monitoring View" can be viewed on the details pages of hosts and containers where "Label Attributes" are set in infrastructure settings.

![](../img/2.dashboard_6.png)

### Export/Import Dashboard JSON

You can export the current dashboard's JSON file or import a JSON file to overwrite the current dashboard.

**Note**: Importing a dashboard JSON will overwrite the existing dashboard, and once overwritten, it cannot be restored.

![](../img/2.dashboard_7.png)

### Clone Dashboard

1. Enter the cloned dashboard name;
2. Choose the visibility scope of the dashboard;
3. Click **Confirm**, and you can view the cloned dashboard in the dashboard list.

## Historical Versions

Guance will display historical operation records of this dashboard within the past three months.

> For more details, refer to [Snapshot Historical Versions](./history-version.md).