# Explorers
---

## Overview

Guance's scene custom explorer provides you with a quickly buildable log explorer. You can build a custom based log explorer with your space members to customize your viewing needs, and you can also export and share the finished explorer with others to share the explorer template.

## Related Operations

You can collect, search, filter, modify, export, and delete some explorer.

![](../img/5.explorer_custom_2.1.png)

### Search and Filter Explorers

In the explorer list, explorers can be grouped through **Search Bar** at the top and **Filter** and **Tag Filter** at the left in order to quickly get query results.

### Add Explorer Guiding Menu {#menu}

In the explorer list, click **Edit** under the **Operate** menu on the right, and select **Add to Menu** to add the current explorer to events, infrastructure, metrics, logs, APM, RUM, synthetic tests, security check and CI visibility.

After the addition is completed, you can view the added custom explorer in the guiding menu of the corresponding function module. If you have permission for **Scene Configuration Management**, you can jump back to the Scene to edit custom explorer. See the doc [role management](../../management/role-management.md).

![](../img/.png)

### Edit Explorers

In the explorers list, click any explorer name to edit.

## Import/Export/Copy Explorers

Guance supports copying the current explorer as a new explorer for editing; it supports exporting Json files as templates to share the data monitoring scheme of the current explorer to achieve the value of using templates repeatedly, and the exported explorer Json files can be edited by importing a new one or overwriting the original template.

![](../img/explorer003.png)

## Save Snapshot

Guance supports the shortcut key (Windows: Ctrl+K / Mac OS: Cmd+K) to quickly save the current log content as a snapshot for sharing, or choose to save it by clicking **Save Snapshot** in the **Setting** button.

![](../img/explorer004.png)

After a snapshot is saved, you can click the Snapshot icon in the top left corner of the explorer to view the list of saved snapshots, which can be shared, copied (as links) and deleted.

![](../img/explorer005.png)

For more details, please refer to the documentation [Bind Inner Dashboards](custom-explorer.md).

## Create Explorers

Go to **Scene > Explorer** and click **+Create Explorer** to start creating custom explorers.

![](../img/explorer.png)

- Blank explorer: Create a blank explorer, which can be customized later.
- Custom templates: Import custom explorer templates.
- Inner explorer template: The system provides the explorer template, which is no need to configure and ready to use.

![](../img/9.logexplorer_2.png)

Select **+New Blank Explorer** and complete the custom explorer name and label to create a new explorer.

- Explorer name: It supports a maximum length of 64 characters and cannot be repeated in the workspace.

- Custom labels: It supports for users to create their own labels. Guance dashboard and explorers share a set of label data, click Label to search for the corresponding explorer.

- Data type: Users need to choose the data type of the explorer, you can choose log, application performance, user access, security check, Profile, which are 5 types of data types. **It cannot be changed once saved.**

  - When selecting the user access type, you need to select the application first, and the selection cannot be changed once saved.

- Visibility: The explorer creator can customize the viewing rights of the current explorer, including **Public** and **Only Visible to You**.

  - Public: explorers that are open to all members in the space, other members' viewing and editing permissions are not affected.
  - Only Visible to You: **Non-public explorer** that can only be viewed by the explorer creator, other members do not have viewing privileges.

  Note: **Non-public explorers** that are shared as links are not visible to non-creators.

![](../img/5.browser_1.png)



## Configure Explorers 

Now you can begin to configure the new explorer. **The following is an example.**

- Data Range: used to select the source of the logs. You need to install DataKit first and configure the corresponding log collector.
- Filtering: filtering log content based on fields.
- Search: namely keyword search based on log sources and filtered results, thus filtering the log display content.
- Timeseries chart: used to display the trend changes of data at equal time intervals, and it can also be used to analyze the role and impact between multiple groups of metric data. The chart supports custom chart query and displays as line chart, area chart or bar chart, please refer to [chart query](../visual-chart/chart-query.md) and [timeseries chart](../visual-chart/timeseries-chart.md) for details.
- Chart synchronization search: used to filter whether the search content is synchronized to the chart, which is turned on by default. When there is content in the search box, if the switch is turned off, the chart query returns to the default state; If the switch is turned on, the chart query is affected by the filtering content;
- Shortcut filtering: default display two fields, host and status; it supports user-defined shortcut filtering list.
- Data list: default configure two fields, time and content; it supports user-defined display list fields.

![](../img/explorer001.png)

- Configuration display column: when customizing display column, it supports manual input or drop-down selection, the selection of **Approximate text analysis** explorer field and the default use message field corresponding to the content of approximate text analysis

![](../img/6.log_explorer_6.png)

## Apply Explorers

After the explorer is created, you can query and analyze the log data with the following functions.

- Search: keyword search, field filtering, correlation search and fuzzy search based on field tags and log text.
- Analysis: filter search based on analysis dimensions.
- Quick filtering: quick filtering of log data based on field tags.
- Formatting configuration: hide sensitive log data content or highlight the log data content you need to view, also can be replaced by the original log content for quick filtering.
- Show columns: customize the columns in the data list.
- Setting: set logs to view multiple rows and export to CSV.
- Copy log content: hover to log content to expand the whole log content and click **Copy** button to copy the entire log content to the pasteboard. If you can expand the log, the system will format the log in JSON, if not, the log will be displayed normally.

![](../img/explorer02.png)

### Formatting Configuration

The formatting configuration allows you to hide sensitive log data content or highlight the log data content you need to view, and also allows you to quickly filter by replacing the original log content.

In the explorer's formatting configuration, add a mapping, enter the following, and click save to replace the original log content containing "48043" with the format you want to display.

- Field: e.g. content
- Matching method: such as match (currently supports `=`, `! =`, `match`, `not match`)
- Match content: e.g. 48043
- Show as content: such as xxxxxxx

Note: explorer formatting configuration is only available for administrators and above.

![](../img/5.browser_5.png)





