# Explorer
---

The Guance Explorer can be used within various functional modules such as infrastructure, events, logs, APM, RUM, CI visualization, Synthetic Tests, Security Check, etc. As one of the essential tools for data observability, the Explorer provides multiple search and filtering methods and supports combining them to obtain final data results. This article will detail the features of the Explorer to help you quickly and accurately retrieve data and locate issues.

## Search {#search}

### Text Search {#text}

Searches generally consist of two parts: <u>terms</u> and <u>operators</u>. Wildcard queries are supported, with `*` matching 0 or more arbitrary characters and `?` matching exactly one arbitrary character. To combine multiple terms into a complex query, Boolean operators (AND/OR/NOT) can be used. The Explorer uses the [query_string()](../../dql/funcs.md#query_string) query syntax.

Terms can be single words or phrases. For example:

- Single word: guance;
- Multiple words: guance test; (equivalent to guance AND test)
- Phrase: "guance test"; (using double quotes converts a set of words into a phrase)

*Search Query Example:*

![](../img/0620.gif)

### JSON Search {#json}

**Prerequisites**:
 
1. Workspace created after `June 23, 2022`;
2. Used in the log Explorer.

By default, it performs an exact search on the content of `message`, which must be in **JSON format**. Other formats are not supported by this search method. The search format is `@key:value`; for multi-level JSON, use `.` to connect keys, e.g., `@key1.key2:value`.

![](../img/7.log_json.png)

*Scenario Example:*

```
Message content:
{
    __namespace:tracing,
    cluster_name_k8s:k8s-demo,
    meta:{    
        service:ruoyi-mysql-k8s,
        name:mysql.query,
        resource:select dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark 
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
**Note**: When the search content contains `.` like `trace.id`, if you directly input `@key1.key2:value`, the system would interpret `trace` and `id` as two separate `keys`. In this case, you should input it as `@\"key1.xxx\":value`.
-->
## Filtering {#filter}

In the Explorer, you can filter data based on `field names` and `field values`.

**Note**: The main difference between filtering and searching is whether there is a <u>: colon separator</u> in the input content. If present, it is treated as a filter condition; otherwise, it is treated as a search condition.

### Operator Explanation {#operator}

Different types of fields support different operators, as shown below:

- String field operators: `=`, `≠`, `match`, `not match`, `wildcard`, `not wildcard`, `exist`, `not exist`, `regexp`, `not regexp`;
- Numeric field operators: `=`, `≠`, `>`, `>=`, `<`, `<=`, `[xx TO xx]`, `exist`, `not exist`.

![](../img/0620-1.png)

| Operator | Description |
| ----------- | ---------------- |
| `=`      | Equal, example: `attribute:value`                   |
| `≠`      | Not equal, example: `-attribute:value`               |
| `match`      | Contains, example: `attribute:~value`                  |
| `not match`     | Does not contain, example: `-attribute:~value`                  |
| `wildcard`      | Contains, requires wildcard for fuzzy search, example: `attribute:*value*`         |
| `not wildcard`      | Does not contain, requires wildcard for reverse fuzzy search, example: `attribute:*value*`    |
| `exist`      | Exists, filters data where the specified field exists, example: `attribute:*`                  |
| `not exist`      | Does not exist, filters data where the specified field does not exist, example: `-attribute:*`        |
| `regexp`      | Regular expression match, uses regex to match target strings, example: `attribute:/value.*/`               |
| `not regexp`      | Reverse regular expression match, matches regex using target string, example: `-attribute:/value.*/`                  |
| `>`      | Greater than, example: `attribute:>value`                |
| `>=`      | Greater than or equal to, example: `attribute:>=value`                  |
| `<`      | Less than, example: `attribute:<value`                  |
| `<=`      | Less than or equal to, example: `attribute:<=value`               |
| `[xx - xx]`      | Range, example: `attribute:[1 - 100]`               |

### Wildcard Explanation {#wildcard}

Supports `*` or `?` wildcards, where `*` matches 0 or more arbitrary characters, and `?` matches exactly one arbitrary character.

```
Value: guanceyun

# Using suffix * match, suitable when the prefix string is fixed and precise while the latter part changes dynamically
attribute:guance*    // * matches yun

# Using ? match, suitable when only specific position characters change dynamically
attribute:gua?ceyun   // ? matches n

# Combining ? and *
attribute:gua?ce*   // ? matches n, * matches yun

# Mixed usage of *
attribute:gua*e*   // First * matches nc, second * matches yun
```

## Special Character Handling {#character}

In the Explorer, some characters have special meanings, for example, `space` is used to separate multiple words. Therefore, if the search content includes the following characters, special handling is required: `space`, `:`, `"`, `“`, `\`, `(`, `)`, `[`, `]`, `{`, `}`.

### :material-numeric-1-circle: Converting Text to Phrase

1. Enclose text in `"` double quotes to turn it into a phrase;
2. Under this format, double quotes enclose the content as a whole for matching searches, and wildcards do not take effect;
3. If the text contains `\` or `"`, this method cannot be used for retrieval; please use [Method Two](#method-two).

*Example: Field name `cmdline`, field value `nginx: worker process`:*

- Search

```
"nginx: worker process"   // Successful retrieval, exact match of words
```

```
"nginx * process"   // Failed retrieval, because * inside double quotes is not recognized as a wildcard
```

- Filter

```
cmdline:"nginx: worker process"   // Successful retrieval, exact match of words
```

```
cmdline:"nginx: worker*"  // Failed retrieval, because * inside double quotes is not recognized as a wildcard
```

### :material-numeric-2-circle: Escaping Characters {#method-two}

1. Add `\` before special characters;
2. If the text itself contains `\`, the processing methods for search and filter differ: for search, add three `\` before the character to escape; for filter, just add one `\`.

*Example: Field name `cmdline`, field value `E:\software_installer\vm\vmware-authd.exe`:*

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

| Logical Relation | Description                                    | Note |
| -------- | --------------------------------- | --- |
| a AND b  | Intersection of preceding and following query results | Search and filter conditions are connected by AND by default. `AND` can be replaced with a space, i.e., `a` AND `b` = `a` `b`.   |
| a OR b   | Union of preceding and following query results        | Returns results that include either a or b. Example: `a` OR `b:value`  |
| NOT c    | Exclude current query results          | NOT is commonly used in search syntax, while exclusion logic in filters uses `≠` instead. |

## Search/Filter Precautions

### Grouping

Parentheses `()` can be used to prioritize data query conditions, meaning any conditions enclosed in `()` are evaluated first. Within `()`, the evaluation order remains `NOT > AND > OR`.

### Handwritten Mode

Supports switching the search box to "handwritten mode"
This handwritten mode covers all Explorers (except dashboards and custom Explorers). In the new mode, UI interactions allow adding search and filter conditions, and users can switch freely between UI and handwritten modes without changing existing content, achieving real-time switching and restoration between UI and handwritten input.


## Analysis Mode {#analysis}

In the Explorer's analysis panel, multi-dimensional aggregation queries and statistical analyses can be performed on data to reflect distribution characteristics and trends over time.

Click **Analysis** to enter the data chart analysis mode, including time series charts, top lists, pie charts, and treemaps. You can also choose different time intervals to display data.

![](../img/5.log_analysis.gif)

**Data Display Explanation:**

- Data Point: A data point refers to the coordinate point of a data value. Time series line and area charts automatically aggregate data points based on the selected time range, with no more than 360 data points; bar charts have no more than 60 data points.
- Data Range: The range of each data point refers to the interval from the current data point back to the previous data point. It takes the value of the data within this range.

> In chart analysis mode, refer to [Operations](../../logs/explorer.md#charts) to manage charts.

## Quick Filters {#quick-filter}

The Explorer supports editing **Quick Filters** to add new **filter fields**. There are two configuration methods: <u>workspace-level filters and user-level filters</u>.

Quick Filters support preset fields. New fields default to the field type in field management. If the field type is not defined in field management, they default to text format.

<div class="grid" markdown>

=== "Workspace-Level Filters"

    Configured by administrators/owners. Click the gear icon :octicons-gear-24: next to Quick Filters, select configure workspace-level filters, supporting adding, editing aliases, adjusting order, and deleting fields.

    **Note**: Workspace-level filters are visible to all workspace members, but standard members cannot edit, delete, or move them.

    ![](../img/5.explorer_search_7.png)

=== "User-Level Filters"

    All members can configure local browser-based quick filters. Click the pencil icon :material-pencil: next to Quick Filters to configure user-level filters, supporting adding, editing aliases, adjusting order, and deleting fields.

    **Note**: User-level filters are only visible to the individual user, not to other workspace members.

    ![](../img/5.explorer_search_8.gif)

</div>

- Click the illustrated icon to collapse the quick filter column:

<img src="../../img/expand.png" width="60%" >

- Click the icon shown below to quickly add the field to the data list, click again to remove.

<img src="../../img/12.quick_filter_4.png" width="60%" >

### Related Operations

<div class="grid" markdown>

=== "Select All"

    By default, all quick filter tags are checked, indicating no filtering has been applied.

=== "Clear Filters"

    Click the **Clear Filters** button in the upper right corner of the quick filter to cancel the value filtering of the tag, restoring full selection.

=== "Uncheck/Check"

    Click the checkbox in front of the quick filter tag value to **uncheck** or **check** it. By default, unchecking the checkbox indicates excluding this value. Continuing to uncheck other checkboxes represents reverse multi-selection.

    ![](../img/12.quick_filter_1.png)

=== "Select Only This Item/Uncheck"

    Clicking the tag value row selects this value **only**, continuing to check other checkboxes represents positive multi-selection; when positively selecting a certain value, clicking the row again **unchecks** all selections.

    ![](../img/12.quick_filter_1.1.png)

=== "Positive & Negative Selection"

    If a tag has both positive and negative selection states, it is grayed out and non-operable in the quick filter.

    ![](../img/12.quick_filter_2.png)

=== "Quick Filter Search"

    When quick filter items exceed 10 tags, support fuzzy search by **field name** or **display name**.

    ![](../img/12.quick_filter_5.1.png)

=== "Field Value Search"

    If quick filter items exceed 10 attribute values, support real-time text input search, supporting clicking fuzzy match and reverse fuzzy match for filtering.

    ![](../img/12.quick_filter_3.png)

=== "Top 5 Query Values"

    Click the gear icon :octicons-gear-24: in the upper right corner of the quick filter, select **Top 5 Query Values**, to view the top five attribute value statistics percentages. In the leaderboard, hover the mouse to view statistics and click the **positive filter** and **negative filter** buttons to filter data using `key:value`.

    ![](../img/8.explorer_1.png)

=== "Dimensional Analysis"

    Clicking switches the current Explorer to analysis mode, automatically using this field in "analysis dimensions" for queries.

    ![](../img/analysis-mode.gif)

=== "Duration"

    If the quick filter includes a `duration` field, you can manually adjust the maximum/minimum values for query analysis. Notes:

    - Default minimum and maximum values of the progress bar are the smallest and largest durations in the trace data list;
    - Supports dragging the progress bar to adjust maximum/minimum values, with input box values synchronously changing;
    - Supports manually entering maximum/minimum values, press Enter or click outside the input box to filter search;
    - Input becomes red if incorrect, not performing search; correct format: pure "number" or "number+ns/μs/ms/s/min";
    - If no unit is entered, "s" is added by default for filtering search;
    - If units are manually entered, direct search is performed.

    ![](../img/9.apm_explorer_6.png)

</div>

## Filter History {#filter-history}

Guance supports viewing filter and search history in the **Filter History**, applicable across different Explorers in the current workspace.

- Open Filter History: Supported through the icon to the right of the search bar at the top of the Explorer, or via shortcuts `(Mac OS: shift+cmd+k / Windows: shift+ctrl+k)`.
- Collapse Filter History: Click the close button `x` or use the `esc` key to collapse the filter history.

![](../img/logexplorer-1.png)

**Note**: Filter history is only viewable in the current user's local browser.

### Operation Instructions

Up to 100 filter/search conditions can be viewed in the Explorer filter history. Use keyboard up/down arrows (↑ ↓) to switch between conditions, and press `enter` to add to filters.

- Pin to Filter: Hover over filter history and pin conditions using the "Pin to Filter" button;
- Add to Filter: Click a filter/search condition to apply it to the Explorer for filtering, supporting multi-selection;
- Remove from Filter: After adding to filters, click the condition again to remove it.

![](../img/linkexplorer-1.png)

- Apply Filter History Across Different Explorers: When browsing `-source: default` filter history in **Logs > Explorer** (as shown), you can directly use these filters in other Explorers like Traces.

![](../img/linkexplorer.png)

## Auto Refresh {#refresh}

Helps quickly obtain real-time Explorer data.

Refresh frequencies available: 5s, 10s, 30s, 1m, 5m, 30m, 1h.

To disable auto-refresh, select Off (关闭).

![](../img/refresh-1.png)

**Note**: All Explorers share one refresh configuration.

## Time Control {#time}

Guance supports controlling the data display range of the current Explorer via the time control. Users can manually input time ranges, quickly select built-in time ranges, or customize settings.

### Manually Input Time Range

The time control defaults to interval display, supporting manual input of time ranges, including **dynamic time** and **static time**. Press Enter or click anywhere outside to apply the entered time range.

![](../img/12.time_1.png)

=== "Dynamic Time"

    Dynamic time ranges support seconds, minutes, hours, and days, such as 1s, 1m, 1h, 1d, etc. For example, entering 20m.

    ![](../img/7.timestamp_6.png)

    Press Enter to return a time range of the last 20 minutes, displaying data from the last 20 minutes in the Explorer.

    ![](../img/7.timestamp_6.1.png)

=== "Date Static Time"

    Standard date and time format supports multiple writing styles, accurate to the second level. Interval separators `~`, `-`, `,` allow spaces before and after, and commas must be English commas.

    - `2022/08/04 09:30:00~2022/08/04 10:00:00` 
    - `2022/08/04 09:30:00-2022/08/04 10:00:00` 
    - `2022/08/04 09:30:00,2022/08/04 10:00:00` 

    Click the time control to directly input and modify the standard time format. Press Enter to display data according to the current time range.

    ![](../img/7.timestamp_7.png)

=== "Timestamp Static Time"

    Timestamp ranges support multiple writing styles, allowing millisecond-level inputs. Interval separators `~`, `-`, `,` allow spaces before and after, and commas must be English commas.

    - `1659576600000~1659578400000` 
    - `1659576600000-1659578400000` 
    - `1659576600000,1659578400000` 

    Click the time control and enter the start and end timestamps as shown.

    ![](../img/7.timestamp_5.png)

    Press Enter to return the time range and display corresponding data in the Explorer.

    ![](../img/7.timestamp_5.1.png)

=== "Notes"

    - If the format does not meet input requirements, it will not return the correct time range, such as start time being later than end time, or not conforming to the `hour:minute:second` format.

    ![](../img/7.timestamp_8.png)

    - The time control tooltip and text input box are linked in real-time. If the input time range exceeds four digits (including time intervals, absolute times, and timestamps), the time control tooltip displays `-`.

    ![](../img/7.timestamp_9.png)

    Press Enter to display the time range.

    ![](../img/7.timestamp_10.png)

### Quick Select Time Range

You can quickly select corresponding time ranges by clicking **More** in the time control. Predefined quick select time ranges include dropdown options like "last 15 minutes, last 1 hour, last 1 day," and dynamic times like "30s, 45m, 3d."

![](../img/12.time_1.png)

Hovering over dynamic times allows real-time synchronization with the input box. Click to view data within the selected time range.

![](../img/12.time_3.png)

### Custom Time Range

Besides predefined time ranges, you can click **Custom Time** in the time control to select date and specific times, then click **Apply** to filter data based on the custom time range.

???+ warning 

    - Custom time range start and end times must follow the `hour:minute:second` format, e.g., `15:01:09`;
    - Start time cannot be later than end time;
    - Custom time range query records can be viewed in **Custom Time Query History**, supporting up to 20 recent absolute time records. Click any historical record to quickly filter and view corresponding data.

![](../img/12.time_4.png)

### URL Time Range {#url}

In addition to the time ranges provided by the time control, Guance supports modifying the `time` parameter in the browser URL for data queries, supporting seconds, minutes, hours, and days, such as time=30s, time=20m, time=6h, time=2d. For example, modifying `time=2h` in the browser URL displays data from the last 2 hours in the Explorer.

???+ warning 

    - Each unit can only be used independently, not combined;
    - When the selected or input time range is greater than or equal to 1d, the Explorer stops playback mode automatically.

![](../img/4.url_1.png)

### Lock Time Range {#fixed}

Guance supports locking a fixed query time range via the :octicons-pin-24: lock icon in the time control. Once set, all Explorers/Dashboards default to displaying data within the locked time range.

For example, if the locked time is "last 45 minutes," all Explorers/Dashboards will display data from the last 45 minutes.

![](../img/12.time_fix_1.png)

### Set Time Zone {#zone}

Guance supports setting the current displayed time zone via the **Time Control** to switch to the corresponding workspace time zone for data viewing.

![](../img/12.time_zone_1.png)

Enter **Time Control > Time Zone Settings**, in the **Modify Time Zone** window:

- Defaults to "Browser Time," i.e., the local browser-detected time;
- After the owner or administrator sets the "[Workspace Time Zone](../../management/index.md#workspace)," members can choose the configured workspace time zone.

![](../img/zone.png)

???+ warning 

    - Only the Owner and Administrator of the current workspace have **Workspace Time Zone** configuration permissions;

    - Setting a new time zone affects all workspaces under your account, so please proceed with caution.

You can also modify this in **[Account Management](../../management/index.md#personal#zone)**.

## Display Columns {#columns}

The Explorer supports choosing the number of rows to expand and view log `message` data:

- Supports clicking **Display Columns** to customize adding, editing, deleting, and dragging display columns;
- Supports using keyboard up/down arrow keys (↑ ↓) to select and add display columns;
- Supports keyword search in **Display Columns**;
- Supports customizing display columns as preset fields, which can directly display reported data after pipeline field slicing and reporting.

![](../img/7.log_column_4.png)

### Time Column {#time-column}

If the Explorer contains a time column, you can directly check it in the display column configuration:

<img src="../../img/time_column.png" width="60%" >

### Adding Display Columns

In the Explorer display columns, support entering fields for matching search, defaulting to the first matched field. Use keyboard up/down arrow keys (↑ ↓) to select and add display columns.

<img src="../../img/7.log_column_1.png" width="60%" >

If the entered field does not exist, it can be distinguished by a "divider" and prompts **Create and Add** display columns. After creation, it serves as a preset field, and subsequent pipeline field slicing and reporting can directly display reported data.

<img src="../../img/7.log_column_2.png" width="60%" >

### Related Operations

When hovering over display columns in the Explorer list, click the gear icon :octicons-gear-24: next to the display column to perform the following operations.

| Operation      | Description                          |
| ----------- | ------------------------------------ |
| Sort Ascending/Descending      | Sorts the current field's values in ascending/descending order.                          |
| Move Column Left/Right      | Moves the current display column left/right if supported.                          |
| Add Column Left/Right      | Adds new display columns left/right of the current column, supporting search if supported.                          |
| Replace Column      | Replaces the current display column at its current position, supporting search if supported.                          |
| Add to Quick Filters      | Adds the display column as a new quick filter item if not already present, and can be removed via the :octicons-gear-24: button.                          |
| Add to Group      | Uses the current display column as a grouping field to display grouped Explorer content.                          |
| Remove Column      | Removes the current display column.                          |

![](../img/8.showlist_3.png)

If the content of a display column is incomplete, you can drag the right divider to expand the column content:

![](../img/8.showlist_4.gif)

## Save Snapshot {#snapshot}

After performing searches, filters, selecting time ranges, and adding display columns, you can save the current Explorer data by clicking the snapshot icon in the upper-left corner of the Explorer and then clicking **Save Snapshot**.

> More details about snapshot usage can be found in [Snapshot](./snapshot.md).

<img src="../../img/6.snapshot_1.png" width="60%" >

## Export {#export}

In the Explorer, you can export the currently displayed data after performing searches, filters, selecting time ranges, and adding display columns. Click the gear icon :octicons-gear-24: on the right side of the Explorer to export data to CSV files, Dashboards, or Notes for viewing and analysis.

<img src="../../img/3.explorer_export_1.png" width="70%" >

To export a specific data entry, open the detailed page of that entry and click the upload icon :material-tray-arrow-up: in the upper-right corner.

<img src="../../img/export-log-0808.png" width="70%" >

### Export to CSV File {#csv}

![](../img/export-explorer.png)

You can choose to export 1k, 5k, 10k, 50k, or 100k data entries.

## Charts {#chart}

- Chart Export: In the Explorer chart, hover over the chart and click **Export** to export or copy the chart to Dashboards or Notes for display and analysis;
- Chart Time Interval: In the Explorer chart, you can choose the time interval to view corresponding chart data.

![](../img/4.explorer_chart_1.png)

- Collapse/Expand Chart:

![](../img/expand-distribution.gif)