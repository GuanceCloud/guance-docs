# Explorer
---

<<< custom_key.brand_name >>>'s **Scenarios > Custom Explorer** provides you with a log viewer that can be quickly set up. You can collaborate with workspace members to build customized log viewers tailored to your needs. Additionally, you can export completed viewers and share them with others, allowing for the sharing of viewer templates.

> Click to learn more about [the powerful features of Explorer](../../getting-started/function-details/explorer-search.md).

## Create a New Viewer

1. Navigate to **Scenarios > Explorer**, click **Create**, and start creating a custom viewer.

![](../img/5.explorer_custom_2.png)

- Blank Viewer: Create a blank viewer that can be customized later.
- Custom Template: Import a custom viewer template for use.
- Built-in Viewer Templates: System-provided viewer templates that require no configuration and are ready to use immediately.

![](../img/9.logviewer_2.png)

2. Select **Create Blank Viewer**, complete the custom viewer name and tags, and a new viewer will be created.

- Viewer Name: The viewer name must be unique within the workspace and supports a maximum length of 64 characters;

- Custom Tags: Users can create exclusive tags. <<< custom_key.brand_name >>>'s dashboard and explorer share the same tag data. Clicking **Tags** allows you to search for corresponding viewers;

- Data Type: Users need to select the data type for the viewer, choosing from logs, APM, RUM PV, Security Check, Profile. **Cannot be changed after saving**;

    - When selecting RUM PV, you need to first choose an application. Once selected and saved, it cannot be changed.

- Visibility Scope: The creator of the viewer can customize the viewing permissions, including **Public** and **Only Visible to Me**;

    - Public: Viewers available to all members within the workspace, with no restrictions on other members' viewing or editing rights;
    - Only Visible to Me: Non-public viewers visible only to the creator, with no viewing permissions for other members.

**Note**: Non-public viewers shared via links are not visible to non-creators.

![](../img/5.explorer_custom_1.png)

## Configure the Viewer

After creating the viewer, you can configure it:

<u>The following uses a log viewer as an example:</u>

![](../img/explorer001.png)

- Data Range: Used to select the source of logs; requires installing DataKit and configuring the corresponding log collector;
- Search/Filter: Based on the log source and filter results, perform keyword searches and filter the displayed log content;
- [Time Series Chart](../visual-chart/timeseries-chart.md): Displays trends in data over equal time intervals and analyzes the impact between multiple metric sets. You can customize [chart queries](../visual-chart/chart-query.md) and display them as line charts, area charts, or bar charts;
- Chart Sync Search: Used to determine if the search content is synchronized to the chart. It is enabled by default. When there is content in the search box, turning off the switch returns the chart query to its default state; enabling the switch means the chart query is affected by the filter content;
- Quick Filters: Defaults to displaying `Host, Status` fields; users can customize quick filter lists;
- Data List: Defaults to configuring `Time, Content` fields; users can customize the displayed list fields;
- Configure Display Columns: Customize display columns, supporting manual input or dropdown selection. Supports selecting **Similar Text Analysis** viewer fields, defaulting to using the `message` field content for similar text analysis.

<img src="../img/6.log_explorer_6.png" width="60%" >

## Options

You can manage the viewer list with the following operations:

### Search & Filter

In the viewer list, you can group and view viewers through the top **Search Bar** and left-side **Filters** and **Tag Filters** to quickly obtain query results.

### Batch Operations

In the viewer list, you can batch delete or export specific viewers.

![](../img/explorer-1.gif)

### Add Viewer Navigation Menu {#menu}

In the scenario viewer list, you can add the current viewer to the navigation menus for Infrastructure, Metrics, Logs, APM, RUM PV, Synthetic Tests, Security Check, CI Visualization.

<u>Example:</u>

1. In the viewer list, select the viewer you want to add, such as the **MySQL Viewer Template**, click the **Edit** option under the right-side **Actions** menu, and choose **Add to Menu**;

![](../img/10.custom_explorer_1.png)

2. Choose to add it to the **Logs** menu;

<img src="../img/10.custom_explorer_2.png" width="60%" >

3. After adding, you can view the custom viewer in the **Logs** navigation menu;

![](../img/10.custom_explorer_3.png)

4. If you have [scenario configuration management permissions](../../management/role-list.md), you can click **Edit Custom Viewer** to return to the custom viewer for editing.



## Cross-Workspace Query {#cross-workspace}

If a workspace has been granted access to other workspaces, you can switch workspaces in the current viewer to view corresponding chart information.

![](../img/explorer-workspace.png)

## Settings 

<img src="../img/0809-op.png" width="60%" >

### Create an Issue

You can create an Issue based on anomalies observed in the current dashboard.

> For more related operations, refer to [How to Manually Create an Issue at the View Level](../../exception/issue.md#dashboards). For more information about Issues, refer to [Incident](../../exception/index.md).

### Save Snapshot

Use the shortcut `(Windows: Ctrl+K / Mac OS: Cmd+K)` in the dashboard to quickly save a snapshot, or click **Save Snapshot** in the **Settings** button to save the current dashboard snapshot.

![](../img/explorer004.png)

After saving a snapshot, you can click the snapshot icon in the top-left corner of the viewer to view the saved snapshots list, which supports sharing, copying links, and deleting snapshots.

![](../img/explorer005.png)

> For more details, refer to [Snapshot](../../getting-started/function-details/snapshot.md).


### Import/Export/Copy Viewer

<<< custom_key.brand_name >>> supports copying the current viewer as a new viewer for editing; exporting JSON files as templates to share the current viewer's monitoring solution, enabling repeated use of templates. Exported JSON files can be imported to create new or overwrite existing templates for editing.


## Use Viewer to Analyze Data

After configuring the viewer, in the data list, you can use the following functions to query and analyze log data, helping you quickly pinpoint issues.

| Operation | Description |
| --------- | ----------- |
| Search    | Perform keyword searches, field filtering, associated searches, and fuzzy searches based on field labels and log text. |
| Analyze   | Perform filter searches based on analysis dimensions. |
| Quick Filters | Quickly filter log data based on field labels. |
| Display Columns | Customize the display columns of the data list. |
| Formatting Configuration | Hide sensitive log data or highlight important log data content, and perform quick filtering by replacing original log content. |
| Export to CSV File | To export a specific data entry, open the detail page of that data and click the :material-tray-arrow-up: icon in the top-right corner. |
| Export to Dashboard/Notes | Export the current log data to the dashboard/notes for viewing. |

![](../img/explorer02.png)