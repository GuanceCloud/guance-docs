# Explorer Search
---

During the process of data retrieval in various Explorers, we can use multiple search and filtering methods, such as fuzzy search, associated search, positive filtering, negative filtering, etc. Below is a detailed explanation.

## Search Instructions

### Keyword Search

The Explorer supports entering keywords in the search bar for retrieval. The query results will highlight the entered keywords, as shown in the following figure.

![](img/13.search_1.png)

### Wildcard Search

The Explorer supports entering wildcards for fuzzy matching searches. For example, entering `global*` in the log search bar returns log data containing "global". Any number of characters can follow "global", as shown in the figure.

![](img/8.search_2.png)

### Associated Search

The Explorer supports logical AND/OR/NOT associated searches, which can be combined with wildcard searches.

| Logical Relationship | Description                                                         |
| -------------------- | ------------------------------------------------------------------- |
| a AND b             | Results must include both a and b. More input keywords lead to more precise matches. `AND` can be replaced by `space` or `,`, i.e., `a,b` = `a b` = `a AND b` |
| a OR b              | Results must include either a or b                                  |
| NOT c               | Results must not include keyword c                                  |

![](img/13.search_4.png)

### JSON Search

> Prerequisite: Workspace needs to be created after `June 23, 2022`

Currently, the JSON search feature is only available for the log Explorer, with the following instructions:

- It performs an exact match on the content of `message`, which must be in JSON format; other formats are not supported.
- JSON search format is: `@key:value`. For multi-level JSON, use `.` to connect keys, e.g., `@key1.key2:value`.

![](img/7.log_json.png)

### Field Filtering

In the Explorer, you can filter values based on `labels/attributes` using four filtering methods: positive filtering, negative filtering, wildcard matching, and reverse wildcard matching.

- You can click the dropdown to filter or manually enter label content in the specified format and press Enter to filter.
- Positive selection, negative selection, wildcard matching, and reverse wildcard matching are placed under four separate dropdowns, each tag being an `and` relationship.
- If a label has both positive and negative states, it will be grayed out and uneditable in quick filters.

![](img/5.explorer_search_1.png)

#### Positive Filtering

Filtering is done using the `key:value` format. For example, searching for `status:error` in the log Explorer returns all logs where the status is error.

![](img/positive_selection.gif)

#### Negative Filtering

Filtering is done using the `-key:value` format. For example, searching for `-status:info` in the log Explorer returns all logs where the status is **not** info.

![](img/reverse_selection.gif)

*Manually entering label content for negative selection*
![](img/reverse_selection2.gif)

#### Wildcard Matching (Wildcard Matching)

Filtering is done using the `*key:value` format, allowing wildcards in the value for matching. For example, searching for `*host:prd-*` in the log Explorer returns all logs where the hostname starts with `prd-`.

![](img/wildcard_matching.gif)

*Manually entering label content for wildcard matching*
![](img/wildcard_matching2.gif)

#### Reverse Wildcard Matching (Not Wildcard Matching)

Filtering is done using the `-*key:value` format, allowing wildcards in the value for matching. For example, searching for `-*service:k8s*` in the log Explorer returns all logs where the service does not start with `k8s`. Supports manual entry of label content for reverse wildcard matching.

![](img/5.explorer_search_2.png)

#### Editing Filters

Selected labels support two editing methods:

##### Single-click Label

Single-clicking a label opens a dialog box where you can modify the filter conditions. (Note: Label tags do not support dialog editing.)

- Operations:

  - `Equal`: Positive filtering, supports selecting tag values from the dropdown or manually entering and confirming with Enter.
  - `Not Equal`: Negative filtering, supports selecting tag values from the dropdown or manually entering and confirming with Enter.
  - `Wildcard Matching`: Supports entering wildcards for fuzzy matching, multiple values separated by `,`.

![](img/edit_filter.png)

##### Double-click Label

Double-clicking a label allows editing individual filter conditions, not multiple at once. As shown below:

**[key:value] Single-selection Label**
![](img/double_click1.png)

**[key:xx items] Multi-selection Label**
![](img/double_click2.png)

## Quick Filter Instructions {#quick-filter}

By default, all label values are selected, indicating no filtering has been applied.

1. Clicking the checkbox before a label value indicates "deselect" or "select" that value;
2. Clicking the "Clear Filters" button in the top-right corner cancels the value filtering for that label;
3. Deselecting the checkbox by default indicates a negative selection of that value, continuing to deselect other checkboxes indicates multiple negative selections;
4. Clicking a row of a label value indicates a single positive selection of that value "only select this item", continuing to check other value checkboxes indicates multiple positive selections;
   ![](img/5.explorer_search_3.png)
5. When a label has both positive and negative states, it is grayed out and uneditable in quick filters.

![](img/5.explorer_search_5.png)

6. If quick filters exceed 10 attribute values, you can input text for real-time search and click to perform wildcard and reverse wildcard matching for filtering.

   ![](img/5.explorer_search_6.png)

### Custom Filter Fields

In the Explorer, you can edit "Quick Filters" to add new "filter fields." Two configuration methods are supported: workspace-level filters and personal-level filters.

#### Workspace-Level Filters

Configured by administrators/owners. Click the "Settings" button next to Quick Filters to configure workspace-level filters, supporting adding fields, editing field aliases, adjusting field order, and deleting fields.

Note: Workspace-level filters are visible to all workspace members, but regular members and standard members cannot edit, delete, or move them.

![](img/5.explorer_search_7.png)

#### Personal-Level Filters

All members can configure browser-based quick filters. Click the "Edit" button next to Quick Filters to configure personal-level filters, supporting adding fields, editing field aliases, adjusting field order, and deleting fields.

Note: Personal-level filters are only visible to the current user and not to other workspace members.

![](img/5.explorer_search_8.png)

## Time Component Instructions

<<< custom_key.brand_name >>> supports controlling the data display range of the current Explorer via time components. Users can quickly select built-in time ranges or customize the time range using "Start Time" and "End Time".

**Time Range**

"Quick Select" presets multiple time ranges, including relative times (yesterday, last week, last month, etc.) and recent times (last 15 minutes, last 1 hour, last 1 day, etc.).

**Data Refresh Interval**

<<< custom_key.brand_name >>> time component data refresh interval defaults to 30 seconds.

![](img/4.url_3.png)

Clicking the "Pause" button exits real-time data refresh mode and locks the current time range to absolute time.

> For example, if the time range is set to "last 15 minutes," clicking the "Pause" button shifts the Explorer's time range forward by 15 minutes.

![](img/4.url_4.png)

### URL Time Range {#url}

In addition to the time ranges provided by the time component, <<< custom_key.brand_name >>> also supports modifying the `time` parameter directly in the browser URL to query data for the current workspace Explorer. It supports seconds, minutes, hours, and days, such as `time=30s`, `time=20m`, `time=6h`, `time=2d`, etc., as shown in the figure below where modifying `time=2h` displays data for the last 2 hours.

Note:

- Each unit can only be used independently, not combined.
- When the selected or entered time range is greater than or equal to 1 day, the Explorer automatically stops playback mode.

![](img/4.url_1.png)