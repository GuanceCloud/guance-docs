# Explorer
---

Guance's **Scenarios > Custom Explorer** provides you with a log viewer that can be quickly set up. You can collaborate with workspace members to build custom log viewers, tailor your viewing needs, and export completed viewers to share templates with others.

> Click to learn more about [the powerful features of the Explorer](../../getting-started/function-details/explorer-search.md).

## Create a New Explorer

1. Navigate to **Scenarios > Explorer**, click **Create New Explorer**, and start creating a custom explorer.

![](../img/5.explorer_custom_2.png)

- Blank Explorer: Create an empty explorer which can be customized later.
- Custom Template: Import a custom template for use.
- Built-in Templates: System-provided templates that require no configuration and are ready to use immediately.

![](../img/9.logviewer_2.png)

2. Select **Create Blank Explorer** and complete the custom explorer name and tags to create a new explorer.

- Explorer Name: The explorer name within the workspace cannot be repeated and supports a maximum length of 64 characters.

- Custom Tags: Users can create exclusive tags. Guance's dashboards and explorers share the same tag data; clicking **Tags** allows searching for corresponding explorers.

- Data Type: Users need to select the data type for the explorer. Choose from logs, APM, RUM, Security Check, Profile. **Cannot be changed after saving**;

    - When selecting RUM, you must first choose the application. Once selected and saved, it cannot be changed.

- Visibility: The creator of the explorer can customize the viewing permissions, including **Public** and **Private**;

    - Public: An explorer open to all members of the workspace, where other members' viewing and editing permissions remain unaffected.
    - Private: An explorer visible only to the creator, with no viewing permissions for other members.

**Note**: Non-public explorers shared via link are not visible to non-creators.

![](../img/5.explorer_custom_1.png)

## Configure the Explorer

After creating the explorer, you can configure it:

<u>The following uses a log explorer as an example:</u>

![](../img/explorer001.png)

- Data Scope: Used to select the source of logs. You need to install DataKit and configure the corresponding log collector.
- Search/Filter: Based on the log source and filter results, perform keyword searches and filter the displayed log content.
- [Time Series Chart](../visual-chart/timeseries-chart.md): Used to display trends in data at equal time intervals and analyze the interactions between multiple metrics. You can customize [chart queries](../visual-chart/chart-query.md) and display them as line charts, area charts, or bar charts.
- Chart Sync Search: Used to synchronize search content with the chart. By default, it is enabled. When there is content in the search box, turning off the switch will revert the chart query to its default state; turning it on will apply the filtered content to the chart query.
- Quick Filters: Default fields displayed are `Host` and `Status`. Supports user-defined quick filter lists.
- Data List: Default fields configured are `Time` and `Content`. Supports user-defined display list fields.
- Configure Display Columns: Customize display columns, supporting manual input or dropdown selection. Supports choosing **Approximate Text Analysis** explorer fields, using the `message` field by default for approximate text analysis.

<img src="../img/6.log_explorer_6.png" width="60%" >

## List Operations

You can manage the explorer list with the following operations:

### Search & Filter

In the explorer list, use the top **Search Bar** and left-side **Filters** and **Tag Filters** to group and view explorers for quick query results.

### Batch Operations

In the explorer list, you can batch delete or export specific explorers.

![](../img/explorer-1.gif)

### Add Explorer to Navigation Menu {#menu}

In the scenario explorer list, you can add the current explorer to the navigation menu under Infrastructure, Metrics, Logs, APM, RUM, Synthetic Tests, Security Check, CI Visualization.

<u>Example:</u>

1. In the explorer list, select the explorer you want to add, such as the **MySQL Explorer Template**, click the **Edit** option in the right-hand **Actions** menu, and choose **Add to Menu**;

![](../img/10.custom_explorer_1.png)

2. Choose to add it to the **Logs** menu;

<img src="../img/10.custom_explorer_2.png" width="60%" >

3. After adding, you can view the custom explorer in the **Logs** navigation menu;

![](../img/10.custom_explorer_3.png)

4. If you have [Scenario Configuration Management Permissions](../../management/role-list.md), you can click **Edit Custom Explorer** to return to the custom explorer for editing.

## Cross-Workspace Query {#cross-workspace}

If a workspace is granted access to another workspace, you can switch workspaces in the current explorer to view corresponding chart information.

![](../img/explorer-workspace.png)

## Settings 

<img src="../img/0809-op.png" width="60%" >

### Create a New Issue

You can create an Issue from anomalies observed in the current dashboard.

> For more related operations, refer to [How to Manually Create an Issue at the View Level](../../exception/issue.md#dashboards). For more information about Issues, see [Incident](../../exception/index.md).

### Save Snapshot

Use the shortcut `(Windows: Ctrl+K / Mac OS: Cmd+K)` in the dashboard to quickly save a snapshot, or click **Save Snapshot** in the **Settings** button to save the current dashboard snapshot.

![](../img/explorer004.png)

After saving the snapshot, click the snapshot icon in the top-left corner of the explorer to view the list of saved snapshots, which supports sharing, copying links, and deleting snapshots.

![](../img/explorer005.png)

> For more details, refer to [Snapshot](../../getting-started/function-details/snapshot.md).

### Import/Export/Copy Explorer

Guance supports copying the current explorer as a new one for editing; exporting JSON files as templates to share the current monitoring solution, enabling reuse of templates. Exported JSON files can be imported to create new or overwrite existing templates for editing.

## Use Explorer to Analyze Data

After configuring the explorer, you can use the following features in the data list to query and analyze log data, helping you quickly pinpoint issues.

| Operation        | Description                                                                 |
| ------------------ | ----------------------------------------------------------------------------- |
| Search           | Perform keyword searches, field filters, associated searches, and fuzzy searches based on field tags and log text. |
| Analyze          | Perform filtered searches based on analysis dimensions.                                           |
| Quick Filters     | Quickly filter log data based on field tags.                                                 |
| Display Columns   | Customize the displayed columns in the data list.                                               |
| Formatting Config | Hide sensitive log data or highlight necessary log data. Also, replace original log content for quick filtering. |
| Export to CSV File | To export a specific data entry, open the detail page of that entry and click the :material-tray-arrow-up: icon in the top-right corner. |
| Export to Dashboard/Notes | Export the current log data to a dashboard or notes for viewing. |

![](../img/explorer02.png)