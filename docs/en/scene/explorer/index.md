# Explorers
---

## Overview

Guance Cloud's Scene Custom explorer provides you with a quickly buildable log explorer. You can build a custom based log explorer with your space members to customize your viewing needs, and you can also export and share the finished explorer with others to share the explorer template.

## New explorer

Go to 「Scene」 - 「Explorer」 and click 「+New Explorer」 to start creating custom explorers.

![](../img/explorer.png)

- Blank explorer: Create a blank explorer, which can be customized later
- Custom Templates: Import custom explorer templates for use
- Built-in explorer template: the system provides the explorer template, no need to configure, ready to use.

![](../img/9.logviewer_2.png)

Select 「+New Blank Explorer」 and complete the custom explorer name and label to create a new explorer.

- explorer name: The explorer name cannot be repeated in the workspace and supports a maximum length of 64 characters

- Custom labels: Support for users to create their own labels." Guance Cloud" dashboard and explorers share a set of tag data, click 「tag」 to search for the corresponding explorer

- Data type: Users need to choose the data type of the explorer, you can choose log, application performance, user access, security patrol, Profile, which are 5 types of data types. After saving, it cannot be changed.

  - When selecting the user access type, you need to select the application first, and the selection cannot be changed after saving.

- Visibility: The explorer "creator" can customize the viewing rights of the current explorer, including "public" and "only visible to you".

  - Public: explorers that are open to all members in the space, other members' viewing and editing permissions are not affected.
  - Visible only: **Non-public explorer** that can only be viewed by the explorer "creator", other members do not have viewing privileges.

  Note: **Non-public explorers** that are shared as links are not visible to non-creators.

![](../img/5.browser_1.png)



## explorer Configuration

- In the newly created explorer, select the data range to start editing the explorer. **The following is an example of a log explorer**.

- Data Range: used to select the source of the logs, you need to install DataKit first and configure the corresponding log collector.
- Filtering: filtering log content based on fields.
- Search: keyword search based on log sources and filtered results to filter the log display content.
- Time-series chart: used to display the trend changes of data at equal time intervals, and can also be used to analyze the role and impact between multiple groups of indicator data. Support custom chart query, and display as line chart, area chart or bar chart, please refer to [Chart Query](../visual-chart/chart-query.md) and [Time Series Chart] (../visual-chart/timeseries-chart.md) for details
- Chart synchronization search: used to filter whether the content of the search is synchronized to the chart, the default is on. When there is content in the search box, turn off the switch, that is, the chart query back to the default state; turn on the switch, that is, the chart query is affected by the filtered content.
- shortcut filtering: default display host, status two fields; support user-defined shortcut filtering list.
- data list: default configuration time, content two fields, support user-defined display list fields.

![](../img/explorer001.png)

- Configuration display column: custom configuration display column, support manual input or drop-down selection; support the selection of 「Approximate text analysis」 explorer field, the default use message field corresponding to the content of approximate text analysis

![](../img/6.log_explorer_6.png)

## View and analyze the created explorers

After the explorer is created, you can query and analyze the log data with the following functions to help you locate the problem quickly.

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

In the explorer's formatting configuration, add a mapping, enter the following, and click Save to replace the original log content containing "48043" with the format you want to display.

- Field: e.g. content
- Matching method: such as match (currently supports `=`, `! =`, `match`, `not match`)
- Match content: e.g. 48043
- Show as content: such as xxxxxxx

Note: explorer formatting configuration is only available for administrators and above.

![](../img/5.browser_5.png)



## Editor explorers

"The explorer can be bookmarked, modified, exported and deleted by clicking on the buttons under Actions on the right. On the left side, you can group explorers by "Filter" and "Filter by Tag" to get quick results. In the explorer list, click on the explorer name to edit the explorer.

![](../img/explorer.png)

## Import/export/copy explorer

Guance Cloud supports copying the current explorer as a new explorer for editing; it supports exporting Json files as templates to share the data monitoring scheme of the current explorer to achieve the value of using templates repeatedly, and the exported explorer Json files can be edited by importing a new one or overwriting the original template.

![](../img/explorer003.png)

## Save Snapshot

Guance Cloud supports the shortcut key (Windows: Ctrl+K / Mac OS: Cmd+K) to quickly save the current log content as a snapshot for sharing, or choose to save it by clicking 「Save Snapshot」 in the 「Settings」 button.

![](../img/explorer004.png)

After a snapshot is saved, you can click the 「Snapshot icon」 in the top left corner of the explorer to view the list of saved snapshots, and support sharing, copying links and deleting snapshots.

![](../img/explorer005.png)

For more details, please refer to the documentation [Quick Build Custom Log explorer](custom-explorer.md).
