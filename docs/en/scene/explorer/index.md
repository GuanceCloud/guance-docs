# Explorers
---


Guance's scene custom explorer provides you with a quickly buildable log explorer. You can build a custom based log explorer with your space members to customize your viewing needs, and you can also export and share the finished explorer with others to share the explorer template.

## Create Explorers

Go to **Scene > Explorer** and click **+Create** to start creating custom explorers.

![](../img/explorer.png)

- Blank explorer: Create a blank explorer, which can be customized later.
- Custom templates: Import custom explorer templates.
- Inner explorer template: The system provides the explorer template, which is no need to configure and ready to use.

![](../img/9.logexplorer_2.png)

Select **Create** and complete the custom explorer name and label to create a new explorer.

- Explorer name: It supports a maximum length of 64 characters and cannot be repeated in the workspace.

- Custom labels: It supports for users to create their own labels. Guance dashboard and explorers share a set of label data, click Label to search for the corresponding explorer.

- Data type: Users need to choose the data type of the explorer, you can choose log, application performance, user access, security check, Profile, which are 5 types of data types. **It cannot be changed once saved.**

    - When selecting the user access type, you need to select the application first, and the selection cannot be changed once saved.

- Visibility: The explorer creator can customize the viewing rights of the current explorer, including **Public** and **Only Visible to You**.

    - Public: explorers that are open to all members in the space, other members' viewing and editing permissions are not affected.
    - Only Visible to You: **Non-public explorer** that can only be viewed by the explorer creator, other members do not have viewing privileges.

    **Note**: **Non-public explorers** that are shared as links are not visible to non-creators.

![](../img/5.browser_1.png)


## Configure Explorers 

Now you can begin to configure the new explorer. 

![](../img/explorer001.png)

1. Data Range: used to select the source of the logs. You need to install DataKit first and configure the corresponding log collector.

2. Search & Filter: namely keyword search and filter based on log sources and filtered results, thus filtering the log display content.

3. [Timeseries chart](../visual-chart/timeseries-chart.md): used to display the trend changes of data at equal time intervals, and it can also be used to analyze the role and impact between multiple groups of metric data. The chart supports custom [chart query](../visual-chart/chart-query.md) and displays as line chart, area chart or bar chart.

4. Chart synchronization search: used to filter whether the search content is synchronized to the chart, which is turned on by default. When there is content in the search box, if the switch is turned off, the chart query returns to the default state; If the switch is turned on, the chart query is affected by the filtering content;

5. Shortcut filtering: default display two fields, `host` and `status`; it supports user-defined shortcut filtering list.

6. Data list: default configure two fields, `time` and `content`; it supports user-defined display list fields.

7. Configuration display column: when customizing display column, it supports manual input or drop-down selection, the selection of **Approximate text analysis** explorer field and the default use message field corresponding to the content of approximate text analysis

<img src="../img/6.log_explorer_6.png" width="60%" >

## Related Operations

The following operations are supported.

![](../img/5.explorer_custom_2.1.png)

### Search and Filter

In the explorer list, explorers can be grouped through **Search Bar** at the top and **Filter** and **Tag Filter** at the left in order to quickly get query results.

### Bulk Operations

In the explorer list, you can perform bulk delete or export actions for specific explorers.

### Add Explorer Guiding Menu {#menu}

In the explorer list, click **Edit** under the **Operate** menu on the right, and select **Add to Menu** to add the current explorer to events, infrastructure, metrics, logs, APM, RUM, synthetic tests, security check and CI visibility.

<u>Example:</u>

:material-numeric-1-circle-outline: In the explorer list, select the explorer you want to add, such as *front performance*, click on the Edit option under the Actions menu on the right side, and select Add to Menu.

![](../img/10.custom_explorer_1.png)

:material-numeric-2-circle-outline: Choose to add the explorer to Logs:

<img src="../img/10.custom_explorer_2.png" width="60%" >

:material-numeric-3-circle-outline: After adding, you can view the added custom explorer in the Logs navigation menu.

![](../img/10.custom_explorer_3.png)

:material-numeric-4-circle-outline: If you have [permission to manage scene configurations](../../management/role-list.md), you can click on Edit Custom Explorer to return to the custom explorer for editing.


## Cross Workspace Query {#cross-workspace}

If a workspace is granted access to other workspaces, you can switch workspaces in the current explorer to view corresponding chart information.

<img src="../img/explorer-workspace.png" width="60%" >

## Settings 

<img src="../img/0809-op.png" width="60%" >

### New Issue

You can create an Issue for the abnormal phenomena observed in the current dashboard.
 
> For more related operations, see [how to manually create an Issue at the view level](../../exception/issue.md#dashboards). For more information about Issues, see [Incident](../../exception/index.md).

### Save as a Snapshot

Guance supports the shortcut key (Windows: Ctrl+K / Mac OS: Cmd+K) to quickly save the current log content as a snapshot for sharing, or choose to save it by clicking **Save as a Snapshot** in the **Setting** button.

![](../img/explorer004.png)

After a snapshot is saved, you can click the Snapshot icon in the top left corner of the explorer to view the list of saved snapshots, which can be shared, copied (as links) and deleted.

<img src="../img/explorer005.png" width="70%" >

> See [Snapshots](../../getting-started/function-details/snapshot.md).

## Import/Export/Copy 

Guance supports copying the current explorer as a new explorer for editing; it supports exporting Json files as templates to share the data monitoring scheme of the current explorer to achieve the value of using templates repeatedly, and the exported explorer Json files can be edited by importing a new one or overwriting the original template.



## Apply Explorers

After the explorer is created, you can query and analyze the log data with the following functions.

1. Search: keyword search, field filtering, correlation search and fuzzy search based on field tags and log text.

2. Analysis: filter search based on analysis dimensions.

3. Quick filtering: quick filtering of log data based on field tags.

4. Columns: customize the columns in the data list.

5. Formatting configuration: hide sensitive log data content or highlight the log data content you need to view, also can be replaced by the original log content for quick filtering.

6. Download as CSV: If you need to export certain data, open the details page of that data, and click on the :material-tray-arrow-up: icon at the top right corner.

7. Export to Dashboards & Notes: Export the current log data to a dashboard/note for viewing.

![](../img/explorer02.png)

> See [Explorers](../../getting-started/function-details/explorer-search.md).


<!--
### Formatting Configuration

The formatting configuration allows you to hide sensitive log data content or highlight the log data content you need to view, and also allows you to quickly filter by replacing the original log content.

In the explorer's formatting configuration, add a mapping, enter the following, and click save to replace the original log content containing "48043" with the format you want to display.

- Field: e.g. content
- Matching method: such as match (currently supports `=`, `! =`, `match`, `not match`)
- Match content: e.g. 48043
- Show as content: such as xxxxxxx

Note: explorer formatting configuration is only available for administrators and above.

![](../img/5.browser_5.png)


-->


