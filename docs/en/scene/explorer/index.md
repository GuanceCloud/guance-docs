# Viewers
---

## Overview

Guance Cloud's Scene Custom Viewer provides you with a quickly buildable log viewer. You can build a custom based log viewer with your space members to customize your viewing needs, and you can also export and share the finished viewer with others to share the viewer template.

## New viewer

Go to 「Scene」 - 「Viewer」 and click 「+New Viewer」 to start creating custom viewers.

![](../img/explorer.png)

- Blank viewer: Create a blank viewer, which can be customized later
- Custom Templates: Import custom viewer templates for use
- Built-in viewer template: the system provides the viewer template, no need to configure, ready to use.

![](../img/9.logviewer_2.png)

Select 「+New Blank Viewer」 and complete the custom viewer name and label to create a new viewer.

- Viewer name: The viewer name cannot be repeated in the workspace and supports a maximum length of 64 characters

- Custom labels: Support for users to create their own labels." Guance Cloud" dashboard and viewers share a set of tag data, click 「tag」 to search for the corresponding viewer

- Data type: Users need to choose the data type of the viewer, you can choose log, application performance, user access, security patrol, Profile, which are 5 types of data types. After saving, it cannot be changed.

  - When selecting the user access type, you need to select the application first, and the selection cannot be changed after saving.

- Visibility: The viewer "creator" can customize the viewing rights of the current viewer, including "public" and "only visible to you".

  - Public: Viewers that are open to all members in the space, other members' viewing and editing permissions are not affected.
  - Visible only: **Non-public viewer** that can only be viewed by the viewer "creator", other members do not have viewing privileges.

  Note: **Non-public viewers** that are shared as links are not visible to non-creators.

![](../img/5.browser_1.png)



## Viewer Configuration

- In the newly created viewer, select the data range to start editing the viewer. **The following is an example of a log viewer**.

- Data Range: used to select the source of the logs, you need to install DataKit first and configure the corresponding log collector.
- Filtering: filtering log content based on fields.
- Search: keyword search based on log sources and filtered results to filter the log display content.
- Time-series chart: used to display the trend changes of data at equal time intervals, and can also be used to analyze the role and impact between multiple groups of indicator data. Support custom chart query, and display as line chart, area chart or bar chart, please refer to [Chart Query](../visual-chart/chart-query.md) and [Time Series Chart] (../visual-chart/timeseries-chart.md) for details
- Chart synchronization search: used to filter whether the content of the search is synchronized to the chart, the default is on. When there is content in the search box, turn off the switch, that is, the chart query back to the default state; turn on the switch, that is, the chart query is affected by the filtered content.
- shortcut filtering: default display host, status two fields; support user-defined shortcut filtering list.
- data list: default configuration time, content two fields, support user-defined display list fields.

![](../img/explorer001.png)

- Configuration display column: custom configuration display column, support manual input or drop-down selection; support the selection of 「Approximate text analysis」 viewer field, the default use message field corresponding to the content of approximate text analysis

![](../img/6.log_explorer_6.png)

## View and analyze the created viewers

After the viewer is created, you can query and analyze the log data with the following functions to help you locate the problem quickly.

- Search: Keyword search, field filtering, correlation search, fuzzy search based on field tags, log text
- Analysis: Filter search based on analysis dimensions
- Quick filtering: Quick filtering of log data based on field tags
- Formatting configuration: Hide sensitive log data content or highlight the log data content you need to view, also can be replaced by the original log content for quick filtering
- Show Columns: Customize the columns in the data list

- Settings button: set logs to view multiple rows and export to CSV
- Copy Log Content: Use "Mouse Hover" to expand the log content to view the entire log content, and click "Copy" button to copy the entire log content to the pasteboard. If you can expand the log, the system will format the log in JSON, if not, the log will be displayed normally.

![](../img/explorer02.png)

### Formatting configuration

The formatting configuration allows you to hide sensitive log data content or highlight the log data content you need to view, and also allows you to quickly filter by replacing the original log content.

In the viewer's formatting configuration, add a mapping, enter the following, and click Save to replace the original log content containing "48043" with the format you want to display.

- Field: e.g. content
- Matching method: such as match (currently supports `=`, `! =`, `match`, `not match`)
- Match content: e.g. 48043
- Show as content: such as xxxxxxx

Note: Viewer formatting configuration is only available for administrators and above.

![](../img/5.browser_5.png)



## Editor Viewers

"The viewer can be bookmarked, modified, exported and deleted by clicking on the buttons under Actions on the right. On the left side, you can group viewers by "Filter" and "Filter by Tag" to get quick results. In the viewer list, click on the viewer name to edit the viewer.

![](../img/explorer.png)

## Import/export/copy viewer

Guance Cloud supports copying the current viewer as a new viewer for editing; it supports exporting Json files as templates to share the data monitoring scheme of the current viewer to achieve the value of using templates repeatedly, and the exported viewer Json files can be edited by importing a new one or overwriting the original template.

![](../img/explorer003.png)

## Save Snapshot

Guance Cloud supports the shortcut key (Windows: Ctrl+K / Mac OS: Cmd+K) to quickly save the current log content as a snapshot for sharing, or choose to save it by clicking 「Save Snapshot」 in the 「Settings」 button.

![](../img/explorer004.png)

After a snapshot is saved, you can click the 「Snapshot icon」 in the top left corner of the viewer to view the list of saved snapshots, and support sharing, copying links and deleting snapshots.

![](../img/explorer005.png)

For more details, please refer to the documentation [Quick Build Custom Log Viewer](custom-explorer.md).
