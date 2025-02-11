# Explorer Search
---

During the process of retrieving data in various Explorers, we can use multiple search and filtering methods such as fuzzy search, associated search, positive filtering, negative filtering, etc. Below, we provide detailed explanations for each method.

## Search Instructions

### Keyword Search

The Explorer supports entering keywords in the search bar to retrieve data. The query results will highlight the entered keywords, as shown in the following image.

![](img/13.search_1.png)

### Wildcard Search

The Explorer supports entering wildcards for fuzzy matching searches. For example, entering `global*` in the log search bar returns log data containing "global", with any number of characters following global, as shown in the figure.

![](img/8.search_2.png)

### Associated Search

The Explorer supports performing associated searches using AND/OR/NOT logic, which can be combined with wildcard searches.

| Logical Relationship | Description                                                                 |
| -------------------- | --------------------------------------------------------------------------- |
| a AND b              | Returns results that include both a and b. More keywords mean more precise matches. `AND` can be replaced by `space` or `,`, i.e., `a,b` = `a b` = `a AND b`. |
| a OR b               | Returns results that include either keyword a or b.                         |
| NOT c                | Returns results that do not include keyword c.                             |

![](img/13.search_4.png)

### JSON Search

> Prerequisite: Workspace must have been created after June 23, 2022.

Currently, the JSON search feature is only available for the log Explorer, with the following usage instructions:

- By default, it performs exact searches on the content of `message`, provided that the message is in JSON format. Logs in other formats are not supported.
- JSON search format is `@key:value`. For multi-level JSON, use `.` to connect levels, e.g., `@key1.key2:value`.

![](img/7.log_json.png)

### Field Filtering

In the Explorer, you can filter values based on `labels/attributes` using four types of filters: positive filtering, negative filtering, wildcard matching, and negative wildcard matching.

- You can select from dropdown menus or manually enter label content in the specified format and press Enter to apply the filter.
- Positive selection, negative selection, wildcard matching, and negative wildcard matching are placed under four separate dropdown labels, each having an `AND` relationship.
- If a label has both positive and negative states simultaneously, it will be grayed out and non-operational in quick filters.

![](img/5.explorer_search_1.png)

#### Positive Filtering

Perform positive filtering using the `key:value` format. For example, searching for `status:error` in the log Explorer returns all logs where the status is error.

![](img/positive_selection.gif)

#### Negative Filtering

Perform negative filtering using the `-key:value` format. For example, searching for `-status:info` in the log Explorer returns all logs where the status is **not** info.

![](img/reverse_selection.gif)

*Manually entering label content for negative selection*
![](img/reverse_selection2.gif)

#### Wildcard Matching

Perform wildcard matching using the `*key:value` format. You can use wildcards in the value for matching. For example, searching for `*host:prd-*` in the log Explorer returns all logs where the hostname starts with `prd-`.

![](img/wildcard_matching.gif)

*Manually entering label content for wildcard matching*
![](img/wildcard_matching2.gif)

#### Negative Wildcard Matching

Perform negative wildcard matching using the `-*key:value` format. You can use wildcards in the value for matching. For example, searching for `-*service:k8s*` in the log Explorer returns all logs where the service does not start with `k8s`. Supports manual entry for negative wildcard matching.

![](img/5.explorer_search_2.png)

#### Editing Filters

Selected labels support two editing methods:

##### Single Click on Label

Single-clicking a label opens a dialog box where you can modify the filter conditions. (Note: Label tags do not support dialog editing.)

- Operators:

  - `Equals`: Positive filtering, supporting dropdown selection or manual input followed by Enter.
  - `Not Equals`: Negative filtering, supporting dropdown selection or manual input followed by Enter.
  - `Wildcard Matching`: Supports entering wildcards for fuzzy matching, with multiple values separated by commas.

![](img/edit_filter.png)

##### Double Click on Label

Double-clicking a label allows you to edit the individual filter condition directly, without modifying multiple conditions at once. As shown below:

**[key:value] Single Selection Label**
![](img/double_click1.png)

**[key:xx Items] Multiple Selection Label**
![](img/double_click2.png)


## Quick Filter Instructions {#quick-filter}

By default, all label values are selected, indicating no filtering applied.

1. Clicking the checkbox before a label value cancels or selects that value.
2. Click the "Clear Filters" button in the top-right corner to cancel the value filtering for that label.
3. Unchecking the checkbox by default indicates negative selection of that value. Continuing to uncheck other checkboxes indicates negative multi-selection.
4. Clicking on a row of a label value selects that value positively ("select this item only"). Continuing to check other checkboxes indicates positive multi-selection.
   ![](img/5.explorer_search_3.png)
5. Clicking on the same row again when a single value is positively selected cancels all filtering.
   ![](img/5.explorer_search_4.png)

6. If a label has both positive and negative states simultaneously, it will be grayed out and non-operational in quick filters.

![](img/5.explorer_search_5.png)

7. If quick filters exceed 10 attribute values, you can enter text for real-time search, supporting clicking on wildcard matching and negative wildcard matching for filtering.

   ![](img/5.explorer_search_6.png)


### Custom Filter Fields

In the Explorer, you can add new "filter fields" to "Quick Filters". Two configuration methods are supported: workspace-level filters and user-level filters.

#### Workspace-Level Filters

Configured by administrators/owners, click the "Settings" button next to Quick Filters to configure workspace-level filters. This supports adding new fields, editing field aliases, adjusting field order, and deleting fields.

Note: Workspace-level filters are visible to all workspace members, but regular members and standard members cannot edit, delete, or move these fields.

![](img/5.explorer_search_7.png)

#### User-Level Filters

All members can configure browser-based quick filters locally. Click the "Edit" button next to Quick Filters to configure user-level filters. This supports adding new fields, editing field aliases, adjusting field order, and deleting fields.

Note: User-level filters are visible only to the current user and not to other workspace members.

![](img/5.explorer_search_8.png)


## Time Component Instructions

Guance supports controlling the data display range of the current Explorer via time components. Users can quickly select built-in time ranges or customize the time range using "Start Time" and "End Time".

**Time Range**

The "Quick Select" option presets multiple time ranges, including relative times (yesterday, last week, last month, etc.) and recent times (last 15 minutes, last hour, last day, etc.).

**Data Refresh Time**

The data refresh interval for Guance's time component is set to 30 seconds by default.

![](img/4.url_3.png)

Clicking the "Pause" button exits the real-time data refresh mode and locks the current time range to absolute time.

> For example, if the time range is set to "Last 15 Minutes," clicking the "Pause" button adjusts the entire time range forward by 15 minutes.

![](img/4.url_4.png)

### URL Time Range {#url}

In addition to selecting time ranges via the time control, Guance also supports modifying the `time` parameter in the browser URL to query data within the current workspace Explorer. Supported units include seconds, minutes, hours, and days, such as time=30s, time=20m, time=6h, time=2d, etc.

Note:

- Each unit can only be used independently, not in combination.
- When the selected or entered time range is greater than or equal to 1d, the Explorer automatically stops playback mode.

![](img/4.url_1.png)