# Explorer
---

The <<< custom_key.brand_name >>> Explorer can be used within various functional modules such as infrastructure, events, logs, APM, RUM, CI visualization, Synthetic Tests, Security Check. As one of the important tools for data observability, the Explorer provides multiple search and filtering methods and supports combining them to obtain final data results. This document will detail the features of the Explorer to help you quickly and accurately retrieve data and locate issues.

## Search {#search}

### Text Search {#text}

A search typically consists of two parts: <u>terms</u> and <u>operators</u>. Wildcard queries are supported, where `*` matches 0 or more arbitrary characters, and `?` matches exactly one arbitrary character. To combine multiple terms into a complex query, Boolean operators (AND/OR/NOT) can be used. The Explorer uses the [query_string()](../../dql/funcs.md#query_string) query syntax.

Terms can be single words or phrases. For example:

- Single word: guance;
- Multiple words: guance test; (equivalent to guance AND test)
- Phrase: "guance test"; (using double quotes converts a group of words into a phrase)

*Search Query Example:*

![](../img/0620.gif)

### JSON Search {#json}

**Prerequisites:**

1. Workspace created after June 23, 2022;
2. Used in the log Explorer.

By default, it performs an exact search on the content of `message`, which must be in **JSON format**. Other formats of log content are not supported by this search method. The search format is `@key:value`. If it's multi-level JSON, use `.` to connect keys, i.e., `@key1.key2:value`.

![](../img/7.log_json.png)

*Scenario Example:*

```
Message content:
{
    __namespace: tracing,
    cluster_name_k8s: k8s-demo,
    meta: {
        service: ruoyi-mysql-k8s,
        name: mysql.query,
        resource: select dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark 
                from sys_dict_data
 }
}

# Query cluster_name_k8s = k8s-demo
@cluster_name_k8s:k8s-demo     // Exact match
@cluster_name_k8s:k?s*        // Fuzzy match

# Query meta.service = ruoyi-mysql-k8s
@meta.service:ruoyi-mysql-k8s   // Exact match
@meta.service:ruoyi?mysql*   // Fuzzy match
```

<!--
**Note**: When the search content contains `.`, such as `trace.id`, if directly input as `@key1.key2:value`, the system will treat `trace` and `id` as two separate keys. In this case, input in the format `@\"key1.xxx\":value`.
-->
## Filtering {#filter}

In the Explorer, you can filter data by `field name` and `field value`.

**Note**: The main difference between filtering and searching is whether there is a <u>: colon separator</u> in the input content. If it exists, it is treated as a filtering condition; otherwise, it is treated as a search condition.

### Operator Explanation {#operator}

Different types of fields support different operators, as shown below:

- String field operators: `=`, `≠`, `match`, `not match`, `wildcard`, `not wildcard`, `exist`, `not exist`, `regexp`, `not regexp`;
- Numeric field operators: `=`, `≠`, `>`, `>=`, `<`, `<=`, `[xx TO xx]`, `exist`, `not exist`.

![](../img/0620-1.png)

| Operator | Description |
| -------- | ----------- |
| `=`      | Equals, example: `attribute:value`                   |
| `≠`      | Not equals, example: `-attribute:value`               |
| `match`  | Contains, example: `attribute:~value`                  |
| `not match` | Does not contain, example: `-attribute:~value`                  |
| `wildcard` | Contains, using wildcards for fuzzy queries, example: `attribute:*value*`         |
| `not wildcard` | Does not contain, using wildcards for reverse fuzzy queries, example: `attribute:*value*`    |
| `exist`  | Exists, filters data that has the specified field, example: `attribute:*`                  |
| `not exist` | Does not exist, filters data that does not have the specified field, example: `-attribute:*`        |
| `regexp` | Regular expression match, using regular expressions to match target strings, example: `attribute:/value.*/`               |
| `not regexp` | Reverse regular expression match, using target strings to match regular expressions, example: `-attribute:/value.*/`                  |
| `>`      | Greater than, example: `attribute:>value`                |
| `>=`     | Greater than or equal to, example: `attribute:>=value`                  |
| `<`      | Less than, example: `attribute:<value`                  |
| `<=`     | Less than or equal to, example: `attribute:<=value`               |
| `[xx - xx]` | Range, example: `attribute:[1 - 100]`               |

### Wildcard Explanation {#wildcard}

Supports `*` or `?` wildcard queries, where `*` matches 0 or more arbitrary characters, and `?` matches exactly one arbitrary character.

```
Value: guanceyun

# Using only suffix * matching, suitable when the prefix string is fixed and precise, and the latter part changes dynamically
attribute:guance*    // * matches yun

# Using only ? matching, suitable when only individual fixed position characters change dynamically
attribute:gua?ceyun   // ? matches n

# Combining ? and *
attribute:gua?ce*   // ? matches n, * matches yun

# Mixing *
attribute:gua*e*   // First * matches nc, second * matches yun
```

## Special Character Handling {#character}

Some characters have special meanings in the Explorer, such as `space` used to separate multiple words. Therefore, if the search content includes any of the following characters, special handling is required: `space`, `:`, `"`, `“`, `\`, `(`, `)`, `[`, `]`, `{`, `}`.

### :material-numeric-1-circle: Convert text to a phrase

1. Enclose the text in `"` double quotes to convert it into a phrase.
2. In this format, the quoted content is matched as a whole, and wildcards do not apply.
3. If the text contains `\` or `"`, this method cannot be used for searching; please use [Method Two](#method-two).

*Example: Searching the field name `cmdline`, with the field value `nginx: worker process`:*

- Search

```
"nginx: worker process"   // Successful retrieval, exact match of words
```

```
"nginx * process"   // Failed retrieval, because * inside double quotes is not considered a wildcard
```

- Filter

```
cmdline:"nginx: worker process"   // Successful retrieval, exact match of words
```

```
cmdline:"nginx: worker*"  // Failed retrieval, because * inside double quotes is not considered a wildcard
```

### :material-numeric-2-circle: Escape special characters {#method-two}

1. Add `\` before special characters.
2. If the search text itself contains `\`, the handling differs between search and filter modes: In search mode, add three `\` before the character for escaping; in filter mode, add one `\`.

*Example: Searching the field name `cmdline`, with the field value `E:\software_installer\vm\vmware-authd.exe`:*

- Search

```
E\:\\\\software_installer\\\\vm\\\\vmware-authd.exe     // Successful retrieval, exact match of words
```

```
E\:\\\\software_installer*exe     // Successful retrieval, wildcard fuzzy match
```

- Filter

```
cmdline:E\:\\software_installer\\vm\\vmware-authd.exe    // Successful retrieval, exact match of words
```

```
cmdline:E\:\\software_installer*exe    // Successful retrieval, wildcard fuzzy match
```

## Boolean Operators {#bool}

Supports combining searches and filters using `AND/OR/NOT`.

![](../img/13.search_4.png)

| Logical Relationship | Description                                    | Note |
| -------------------- | ---------------------------------------------- | ---- |
| a AND b              | Intersection of both query results            | Search and filter conditions are connected by AND by default. `AND` can be replaced by a space, i.e., `a` AND `b` = `a` `b`. |
| a OR b               | Union of both query results                   | Returns results containing either keyword a or b. Example: `a` OR `b:value` |
| NOT c                | Excludes current query results                | NOT is mainly used in search syntax. For exclusion logic in filters, use `≠` instead. |

## Search/Filter Precautions

### Grouping

Use parentheses `()` to increase the priority of data query conditions. Conditions within `()` are evaluated first. Inside `()`, the evaluation order remains `NOT > AND > OR`.

### Handwriting Mode

Supports switching the search box to "handwriting mode". This feature covers all Explorers except dashboards and custom Explorers. In the new mode, users can switch freely between UI interaction and handwriting input for adding search and filter conditions, without changing any previous content. Real-time switching between UI and handwritten input is truly achieved.

## Analysis Mode {#analysis}

In the analysis panel of the Explorer, you can perform multi-dimensional aggregation queries and statistical analyses based on data to reflect distribution characteristics and trends across different dimensions and time periods.

Click **Analysis** to enter the data chart analysis mode, including time series charts, top lists, pie charts, and treemaps. You can also choose different time intervals to display data.

![](../img/5.log_analysis.gif)

**Data Display Explanation:**

- Data Point: A data point refers to the coordinate point of a data value. Time series line and area charts automatically aggregate data points based on the selected time range, with no more than 360 points. Bar charts have no more than 60 data points.
- Data Range: The range of values for each data point, calculated as the interval between the current data point and the previous one, taking the value within this range.

> In chart analysis mode, refer to [Operations](../../logs/explorer.md#charts) to manage charts.

## Quick Filters {#quick-filter}

The Explorer supports editing **Quick Filters** to add new **filter fields**. There are two configuration methods: <u>workspace-level filter items and personal-level filter items</u>.

Quick Filters support preset fields. Newly added fields default to the field type in field management. If not present in field management, they default to text format.

<div class="grid" markdown>

=== "Workspace-Level Filter Items"

    Configured by administrators/owners. Click the gear icon :octicons-gear-24: next to Quick Filters and choose to configure workspace-level filter items. Supports adding new fields, editing field aliases, adjusting field order, and deleting fields.

    **Note**: Workspace-level filter items are viewable by all workspace members, but ordinary and standard members cannot edit, delete, or move them.

    ![](../img/5.explorer_search_7.png)

=== "Personal-Level Filter Items"

    All members can configure browser-local quick filters. Click the pencil icon :material-pencil: next to Quick Filters to configure personal-level filter items. Supports adding new fields, editing field aliases, adjusting field order, and deleting fields.

    **Note**: Personal-level filter items are visible only to the current user and not to other workspace members.

    ![](../img/5.explorer_search_8.gif)

</div>

- Click the icon shown to collapse the Quick Filters column:

<img src="../../img/expand.png" width="60%" >

- Click the icon shown to quickly add the field to the data list, and click again to remove it.

<img src="../../img/12.quick_filter_4.png" width="60%" >

### Related Operations

<div class="grid" markdown>

=== "Select All"

    By default, all Quick Filter labels are checked, indicating no filtering has been applied.

=== "Clear Filters"

    Click the **Clear Filters** button in the upper right corner of Quick Filters to cancel the label value filtering, restoring the full selection.

=== "Uncheck/Check"

    Click the checkbox in front of the Quick Filter label value to **uncheck** or **check** it. By default, unchecking the checkbox indicates selecting the opposite value. Continue unchecking other checkboxes to perform reverse multi-selection.

    ![](../img/12.quick_filter_1.png)

=== "Select Only This Item/Uncheck"

    Click the row of the label value to indicate positive single selection **Select Only This Item**. Continue checking other checkboxes to perform positive multi-selection. When positively single-selecting a value, clicking the row again **Unchecks** and cancels all filters.

    ![](../img/12.quick_filter_1.1.png)

=== "Positive & Negative Selection"

    If a label has both positive and negative states simultaneously, it is grayed out and not operable in Quick Filters.

    ![](../img/12.quick_filter_2.png)

=== "Quick Filter Search"

    When Quick Filters exceed 10 label fields, support fuzzy search by **field name** or **display name**.

    ![](../img/12.quick_filter_5.1.png)

=== "Field Value Search"

    If Quick Filters exceed 10 field attribute values, support real-time text input for fuzzy matching and reverse fuzzy matching.

    ![](../img/12.quick_filter_3.png)

=== "Top 5 Values"

    Click the gear icon :octicons-gear-24: in the upper right corner of Quick Filters, then choose **Top 5 Values** to view the top five field attribute value statistics percentages. In the leaderboard, support mouse hover to view statistics, and click **Positive Filter** or **Negative Filter** buttons to filter data by `key:value`.

    ![](../img/8.explorer_1.png)

=== "Dimension Analysis"

    Clicking switches the current Explorer to analysis mode, automatically adding the field to the "Analysis Dimension" for querying.

    ![](../img/analysis-mode.gif)

=== "Duration"

    If the Quick Filters include a `duration` field, you can manually adjust the maximum/minimum values for query analysis. Notes:

    - The default minimum and maximum values of **Duration** in Quick Filters are the smallest and largest durations in the trace data list.
    - Support dragging the slider to adjust maximum/minimum values, with the input box values synchronizing changes.
    - Support manually entering maximum/minimum values, pressing Enter or clicking outside the input box to filter search.
    - Input boxes turn red if the format is incorrect, preventing search. Correct format: pure "number" or "number+ns/μs/ms/s/min".
    - If no unit is entered, "s" is appended to the number for filtering.
    - If a unit is manually entered, direct search occurs.

    ![](../img/9.apm_explorer_6.png)

</div>

## Filter History {#filter-history}

<<< custom_key.brand_name >>> supports viewing filter and search history in **Filter History**, which can be applied across different Explorers in the current workspace.

- Open Filter History: Access by clicking the icon next to the search bar at the top of the Explorer, or use the shortcut `(Mac OS: shift+cmd+k / Windows: shift+ctrl+k)` to quickly open Filter History.
- Collapse Filter History: Click the close button `x` or press `esc` to collapse Filter History.

![](../img/logexplorer-1.png)

**Note**: Filter History is only viewable locally in the current user's browser.

### Operation Instructions

In the Explorer's Filter History, up to 100 filter/search conditions can be viewed. Use the keyboard arrow keys (↑ ↓) to switch between conditions, and press `enter` to add them to the filter.

- Pin to Filter: Hover over a condition in Filter History and click the "Pin to Filter" button to pin filter/search conditions.
- Add to Filter: Click a filter/search condition to add it to the Explorer for filtering, supporting multi-selection.
- Remove Filter: After adding to the filter, click the condition again to remove the filter.

![](../img/linkexplorer-1.png)

- Apply Filter History in Different Explorers: When browsing `-source: default` in **Logs > Explorer** (as shown above), you can directly use the same filter/search conditions in other Explorers like Traces.

![](../img/linkexplorer.png)

## Auto Refresh {#refresh}

Helps quickly obtain real-time data in the Explorer.

Available frequencies: 5s, 10s, 30s, 1m, 5m, 30m, 1h.

To disable auto-refresh, choose Off (disabled).

![](../img/refresh-1.png)

**Note**: All Explorers share one refresh configuration.

## Time Widget {#time}

<<< custom_key.brand_name >>> supports controlling the data display range of the current Explorer via the Time Widget. Users can manually enter time ranges or quickly select built-in time ranges or set custom time ranges.

### Manually Enter Time Range

The Time Widget defaults to interval display, supporting clicking the widget to manually enter time ranges, including **dynamic time** and **static time**. Press Enter or click anywhere outside to filter data according to the entered time range.

![](../img/12.time_1.png)

=== "Dynamic Time"

    Dynamic time ranges support seconds, minutes, hours, and days, e.g., 1s, 1m, 1h, 1d, etc. Entering 20m as shown below.

    ![](../img/7.timestamp_6.png)

    Press Enter to return to the last 20 minutes, displaying data from the last 20 minutes in the Explorer.

    ![](../img/7.timestamp_6.1.png)

=== "Static Date Time"

    Standard date-time format supports multiple write-ups, with time precision down to seconds. Interval separators `~`, `-`, `,` allow spaces before and after, and commas must be English commas.

    - `2022/08/04 09:30:00~2022/08/04 10:00:00`
    - `2022/08/04 09:30:00-2022/08/04 10:00:00`
    - `2022/08/04 09:30:00,2022/08/04 10:00:00`

    Click the Time Widget to directly input and modify the standard time format. Press Enter to display data according to the current time range.

    ![](../img/7.timestamp_7.png)

=== "Static Timestamp Time"

    Timestamp ranges support multiple write-ups, with millisecond precision. Interval separators `~`, `-`, `,` allow spaces before and after, and commas must be English commas.

    - `1659576600000~1659578400000`
    - `1659576600000-1659578400000`
    - `1659576600000,1659578400000`

    Click the Time Widget to input start and end timestamps as shown below.

    ![](../img/7.timestamp_5.png)

    Press Enter to return the time range and display corresponding data in the Explorer.

    ![](../img/7.timestamp_5.1.png)

=== "Precautions"

    - If the format does not meet requirements, it will not return the correct time range, such as start time later than end time or incorrect `hour:minute:second` format input.

    ![](../img/7.timestamp_8.png)

    - The tooltip and text input box of the Time Widget are linked in real-time. If the input time range exceeds four digits (including time intervals, absolute times, and timestamps), the Time Widget tooltip shows `-`.

    ![](../img/7.timestamp_9.png)

    Press Enter to show the time range.

    ![](../img/7.timestamp_10.png)

### Quick Select Time Range

You can click **More** in the Time Widget to quickly select corresponding time ranges for data viewing. The Time Widget presets multiple quick select time ranges, including drop-down options like "Last 15 Minutes, Last 1 Hour, Last 1 Day," and dynamic times like "30s, 45m, 3d."

![](../img/12.time_1.png)

Hovering over dynamic times will link in real-time with the input box content. Click to view data within the corresponding time range.

![](../img/12.time_3.png)

### Custom Time Range

Besides preset time ranges, you can click **Custom Time** in the Time Widget to select a time range, including dates and specific times. Click **Apply** to filter data according to the custom time range.

???+ warning 

    - Start and end times for custom time ranges must follow the `hour:minute:second` format, e.g., `15:01:09`;  
    - The start time for custom time ranges cannot be later than the end time;  
    - Custom time range query records can be viewed in **Custom Time Query History**, supporting up to the last 20 absolute time records. Click any historical record to quickly filter and view corresponding data.

![](../img/12.time_4.png)

### URL Time Range {#url}

In addition to the time range selection provided by the Time Widget, <<< custom_key.brand_name >>> supports modifying the `time` parameter in the browser URL to query data in the current workspace Explorer. It supports seconds, minutes, hours, and days units, e.g., time=30s, time=20m, time=6h, time=2d, etc. As shown below, modifying `time=2h` in the browser displays data from the last 2 hours in the Explorer.

???+ warning 

    - Each unit can only be used independently, not combined;  
    - When the selected or browser-input time range is greater than or equal to 1d, the Explorer stops playback mode automatically.

![](../img/4.url_1.png)

### Lock Time Range {#fixed}

<<< custom_key.brand_name >>> supports locking a fixed query time range by clicking the :octicons-pin-24: lock icon in the Time Widget. Once set, all Explorers/Dashboards default to displaying data within the locked time range.

As shown below, if the locked time is "Last 45 Minutes," all Explorers/Dashboards will display data for "Last 45 Minutes."

![](../img/12.time_fix_1.png)

### Set Time Zone {#zone}

<<< custom_key.brand_name >>> supports setting the current displayed time zone in the **Time Widget** to switch to the corresponding workspace time zone for data viewing.

![](../img/12.time_zone_1.png)

Enter **Time Widget > Time Zone Settings**, in the **Modify Time Zone** window:

- Default display is "Browser Time," i.e., the local browser-detected time;
- After the owner or administrator sets "[Workspace Time Zone](../../management/index.md#workspace)" settings, members can choose configured workspace time zones.

![](../img/zone.png)

???+ warning 

    - Only Owners and Administrators of the current workspace have **Workspace Time Zone** configuration permissions;

    - After setting a new time zone, all workspaces under your account will display data according to the newly set time zone. Please operate with caution.

You can also modify it in **[Account Management](../../management/index.md#personal#zone)**.


## Display Columns {#columns}

The Explorer supports choosing the number of rows to expand and view log data:

- Customize adding, editing, deleting, and dragging display columns;
- Use keyboard arrow keys (↑ ↓) to select and add display columns;
- Search fields by keywords;
- Define display columns as preset fields, allowing direct display of reported data after Pipeline slicing and reporting.

![](../img/7.log_column_4.png)

### Time Column {#time-column}

If the Explorer has a time column, you can directly check it in the display column configuration to choose whether to show it in the list.

<img src="../../img/time_column.png" width="80%" >


### Adding Display Columns

In the dropdown menu for adding display columns, select fields to add to the display columns. Or directly search for and locate the target field.

If the target field is not found in the dropdown menu, you can directly input the field name in "Add Display Columns" and press Enter to complete the addition.

<img src="../../img/7.log_column_1.png" width="80%" >


### Display Column Operations

In the Explorer list's [Standard Mode](../../logs/manag-explorer.md#mode), hover over the display column and click the settings button to perform the following operations on the display column.

![](../img/8.showlist_3.png)

| Operation | Description |
| --------- | ------------ |
| Sort Asc/Desc | Sort the current field values in ascending or descending order. |
| Move Left/Right | Move the current display column left or right. |
| Add Column Left/Right | Add a new display column to the left or right of the current column. |
| Replace Column | Replace the current display column at its current position. |
| Add to Filter | If the quick filter on the left does not have the current display column, click to add it as a new quick filter item. |
| Enter [Analysis Mode](#analysis) | Directly use this field in the filtering section of Analysis Mode. |
| Remove Column | Remove the current display column. |


## Save Snapshot {#snapshot}

You can perform searches and filters on the currently displayed data, select a time range, add view columns, and then click the snapshot icon in the upper left corner of the Explorer to save the current displayed data content.

> For more details on snapshot usage, refer to [Snapshots](./snapshot.md).

<img src="../../img/6.snapshot_1.png" width="60%" >


## Export {#export}

In the Explorer, you can perform searches and filters on the currently displayed data, select a time range, add view columns, and then click the :octicons-gear-24: on the right side of the Explorer to export the currently displayed data content. You can **export to CSV file**, **export to dashboard**, or **export to notebook** for data viewing and analysis.

<img src="../../img/3.explorer_export_1.png" width="70%" >

If you need to export a specific data entry, open the detail page of that entry and click the :material-tray-arrow-up: icon in the upper right corner.

<img src="../../img/export-log-0808.png" width="70%" >

### Export to CSV File {#csv}

![](../img/export-explorer.png)

You can choose to export 1k, 5k, 10k, 50k, or 100k data entries.

## Charts {#chart}

- Chart Export: In the Explorer chart, you can hover over the chart and click **Export** to export or copy the chart to a dashboard or notebook for display and analysis.
- Chart Time Interval: In the Explorer chart, you can choose the time interval to view the corresponding chart data.

![](../img/4.explorer_chart_1.png)

- Collapse/Expand Chart:

![](../img/expand-distribution.gif)