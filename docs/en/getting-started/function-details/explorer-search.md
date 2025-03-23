# Explorer
---

The <<< custom_key.brand_name >>> Explorer can be used within infrastructure, events, logs, APM, RUM PV, CI visualization, Synthetic Tests, Security Check and other Features modules. As one of the important tools for data observability, the Explorer provides various search and filtering methods and supports combining them to obtain final data results. This article will provide a detailed introduction to the Explorer's Features to help you quickly and accurately retrieve data and locate fault issues.

## Search {#search}

### Text Search {#text}

Searches are generally composed of <u>terms</u> and <u>operators</u>. Wildcard queries are supported, where `*` matches zero or more arbitrary characters and `?` matches one arbitrary character. To combine multiple terms into a complex query, you can use [Boolean operators](#bool) (AND/OR/NOT). The Explorer uses the [query_string()](../../dql/funcs.md#query_string) query syntax.

Terms can be single words or phrases. For example:

- Single word: guance;
- Multiple words: guance test; (equivalent to guance AND test)
- Phrase: "guance test"; (using double quotes converts a group of words into a phrase)

*Search Query Example:*

![](../img/0620.gif)

### JSON Search {#json}

**Prerequisites for Use:**

1. Workspace created after `June 23, 2022`;
2. Used in the Logs Explorer.

By default, precise searches are performed on the content of `message`, and the `message` must be in **JSON format**. Other formats of log content are not supported by this search method. The search format is `@key:value`; if it’s multi-level JSON, use “.” as the connector, i.e., `@key1.key2:value`, as shown in the figure below.

![](../img/7.log_json.png)

*Scenario Example:*

```
Message information:
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
@cluster_name_k8s:k8s-demo     // Precise match
@cluster_name_k8s:k?s*        // Fuzzy match

# Query meta.service = ruoyi-mysql-k8s
@meta.service:ruoyi-mysql-k8s   // Precise match
@meta.service:ruoyi?mysql*   // Fuzzy match
```

<!--
**Note**: When the search content includes `.` such as `trace.id`, if entered directly as `@key1.key2:value`, the system will interpret `trace` and `id` as two separate keys (although they are actually one). In this case, input in the format `@\"key1.xxx\":value`, i.e., `@\"key1.xxx\":value`.
-->
## Filtering {#filter}

In the Explorer, you can perform filter queries based on `field names` and `field values`.

**Note**: The main difference between filtering and searching is whether there is a <u>: colon separator</u> in the input content. If it exists, it is judged as a filtering condition; if not, it is considered a search condition.

### Operator Description {#operator}

Different types of fields support different operators, as shown below:

- String field operators: `=`, `≠`, `match`, `not match`, `wildcard`, `not wildcard`, `exist`, `not exist`, `regexp`, `not regexp`;
- Numeric field operators: `=`, `≠`, `>`, `>=`, `<`, `<=`, `[xx TO xx]`, `exist`, `not exist`.

![](../img/0620-1.png)

| Operator      | Description                  |
| ----------- | ---------------- |
| `=`      | Equal, example: `attribute:value`                   |
| `≠`      | Not equal, example: `-attribute:value`               |
| `match`      | Contains, example: `attribute:~value`                  |
| `not match`     | Does not contain, example: `-attribute:~value`                  |
| `wildcard`      | Contains, requires wildcard for fuzzy search, example: `attribute:*value*`         |
| `not wildcard`      | Does not contain, requires wildcard for reverse fuzzy search, example: `attribute:*value*`    |
| `exist`      | Exists, filters out data with specified field, example: `attribute:*`                  |
| `not exist`      | Does not exist, filters out data without specified field, example: `-attribute:*`        |
| `regexp`      | Regular expression match, uses regular expressions to match target strings, example: `attribute:/value.*/`               |
| `not regexp`      | Reverse regular expression match, uses target string to match regular expression, example: `-attribute:/value.*/`                  |
| `>`      | Greater than, example: `attribute:>value`                |
| `>=`      | Greater than or equal to, example: `attribute:>=value`                  |
| `<`      | Less than, example: `attribute:<value`                  |
| `<=`      | Less than or equal to, example: `attribute:<=value`               |
| `[xx - xx]`      | Range, example: `attribute:[1 - 100]`               |

### Wildcard Explanation {#wildcard}

Supports `*` or `?` wildcard queries, `*` matches zero or more arbitrary characters, `?` matches one arbitrary character.

```
Value: guanceyun

# Only suffix * matching is used, suitable when the prefix of a value string is fixed and precise, while the latter part changes dynamically.
attribute:guance*    // * matches yun

# Only ? matching is used, suitable when only individual fixed-position characters update dynamically.
attribute:gua?ceyun   // ? matches n

# ? * combined usage
attribute:gua?ce*   // ? matches n , * matches yun

# Mixed * usage
attribute:gua*e*   // First * matches nc , second * matches yun
```

## Special Character Search Processing {#character}

In the Explorer, some characters have special meanings, such as `space` which separates multiple words. Therefore, if the search content contains the following characters, special processing is required: `space`, `:`, `"`, `“`, `\`, `(`, `)`, `[`, `]`, `{`, `}`.

### :material-numeric-1-circle: Convert text into a phrase

1. Add `"` double quotes around the text, converting the text into a phrase;
2. Under this format, the content within double quotes is treated as a whole for matching search, wildcards will not work;
3. If the text contains `\` or `"`, this method cannot be used for searching; please refer to [Method Two](#method-two).

*Example: Field name `cmdline`, field value `nginx: worker process`:*

- Search

```
"nginx: worker process"   // Successful search, precise match of words
```

```
"nginx * process"   // Failed search, because * in double quotes is not recognized as a wildcard
```

- Filter

```
cmdline:"nginx: worker process"   // Successful search, precise match of words
```

```
cmdline:"nginx: worker*"  // Failed search, because * in double quotes is not recognized as a wildcard
```

### :material-numeric-2-circle: Escape characters {#method-two}

1. Add `\` before special characters;
2. If the search text itself contains `\`, the handling methods for search and filtering differ: for search, add three `\` before the character to escape it; for filtering, adding one `\` is sufficient.

*Example: Field name `cmdline`, field value `E:\software_installer\vm\vmware-authd.exe`:*

- Search

```
E\:\\\\software_installer\\\\vm\\\\vmware-authd.exe     // Successful search, precise match of words
```

```
E\:\\\\software_installer*exe     // Successful search, wildcard fuzzy match
```

- Filter

```
cmdline:E\:\\software_installer\\vm\\vmware-authd.exe    // Successful search, precise match of words
```

```
cmdline:E\:\\software_installer*exe    // Successful search, wildcard fuzzy match
```

## Boolean Operators {#bool}

Supports further <u>combination of search and filter</u> using `AND/OR/NOT`.

![](../img/13.search_4.png)

| Logical Relationship | Description                                    | Note |
| -------- | --------------------------------- | --- |
| a AND b  | Intersection of preceding and succeeding query results | Search and filter conditions are connected by default with AND. Among them, `AND` can be replaced with `space`, i.e., `a` AND `b` = `a` `b`.   |
| a OR b   | Union of preceding and succeeding query results        | Returns results containing either a or b. Example: `a` OR `b:value`  |
| NOT c    | Exclude current query results          | NOT is mostly used in search writing, exclusion logic in filters is replaced by `≠`. |

## Search/Filtering Notes

### Grouping

Use parentheses `()` to increase the priority of data query conditions, meaning that parts enclosed by `()` will execute their query logic first. Inside `()`, the query precedence follows `NOT > AND > OR`.

### Handwritten Mode

Supports switching the search box to "Handwritten Mode". This hand-written mode covers all Explorers (except dashboards/custom Explorers), allowing UI interaction to add search/filter conditions and switch freely between handwritten and UI modes without making any changes to the content before switching modes, truly enabling real-time switching and restoration between UI and handwritten inputs.


## Analysis Mode {#analysis}

In the analysis bar of the Explorer, multi-dimensional aggregation queries and analysis statistics based on data are supported, reflecting the distribution characteristics and trends of data at different times under different dimensions.

Click **Analysis** to enter the data chart analysis method, including time series graphs, Top Lists, pie charts, and rectangular tree maps. You can also choose different time intervals to display data.

![](../img/5.log_analysis.gif)

**Data Display Explanation:**

- Data Points: Data points refer to the coordinate points where data values are located. Time series line and area charts will automatically aggregate data points based on your selected time range, with no more than 360 data points; the number of data points for bar charts does not exceed 60.
- Data Range: The data range refers to the value range of each data point, i.e., the interval range from the current data point's coordinate point pushed forward to the previous data point's coordinate point, taking the value of the data within that range.

> In chart analysis mode, you can refer to [Actions](../../logs/explorer.md#charts) to manage charts.

## Quick Filter {#quick-filter}

The Explorer supports editing **Quick Filters** to add new **filter fields**. There are two configuration methods: <u>workspace-level filter items and personal-level filter items</u>.

In quick filters, preset fields are supported. Newly added fields default to the field type in field management; if there is none in field management, they default to text format.

<div class="grid" markdown>

=== "Workspace-Level Filter Items"

    Configured by administrators/owners, click the :octicons-gear-24: next to the quick filter, select workspace-level filter item configuration, supporting adding new fields, editing field aliases, adjusting field order, deleting fields.

    **Note**: Workspace-level filter items are viewable by all members of the workspace, but ordinary members and standard members do not support editing, deleting, or moving positions.

    ![](../img/5.explorer_search_7.png)

=== "Personal-Level Filter Items"

    All members can configure local browser-based quick filter items, click the :material-pencil: on the right side of the quick filter to configure personal-level filter items, supporting adding new fields, editing field aliases, adjusting field order, deleting fields.

    **Note**: Personal-level filter items are only viewable by the current individual, and other workspace members cannot view them.

    ![](../img/5.explorer_search_8.gif)

</div>

- Click the icon shown to collapse the quick filter column:

<img src="../../img/expand.png" width="60%" >

- Click the icon shown below to quickly add the field to the data list, clicking again will remove it.

<img src="../../img/12.quick_filter_4.png" width="60%" >

### Related Actions

<div class="grid" markdown>

=== "Select All"

    By default, all labels of quick filter items are fully checked, indicating no filtering has been applied.

=== "Clear Filters"

    Click the **Clear Filters** button in the upper-right corner of the quick filter to cancel the value filtering of the label, restoring full selection.

=== "Deselect/Select"

    Click the checkbox in front of the quick filter item label to **Deselect** or **Select** that value. By default, deselecting the checkbox in front indicates selecting the opposite value, continuing to deselect other checkboxes represents reverse multi-selection.

    ![](../img/12.quick_filter_1.png)

=== "Only Select This Item/Cancel Selection"

    Click the row where the label value is located to indicate positive single selection of this value **Only Select This Item**, continue checking other value checkboxes to represent positive multi-selection; when a value is positively single-selected, click the row of that value again **Cancel Selection**, cancel all filters.

    ![](../img/12.quick_filter_1.1.png)

=== "Positive & Negative Selection"

    If a label has both positive and negative selection states simultaneously, then in the quick filter, the label is grayed out and non-operational.

    ![](../img/12.quick_filter_2.png)

=== "Quick Filter Item Search"

    When the quick filter exceeds 10 label fields, support fuzzy search by **Field Name** or **Display Name**.

    ![](../img/12.quick_filter_5.1.png)

=== "Field Value Search"

    If the quick filter exceeds 10 field attribute values, support real-time search by entering text, supporting click fuzzy matching and reverse fuzzy matching for filtering.

    ![](../img/12.quick_filter_3.png)

=== "Top 5 Query Values"

    Click the :octicons-gear-24: in the upper-right corner of the quick filter, select **Top 5 Query Values**, to view the percentage statistics of the top five ranking field attribute values. In the leaderboard, support mouse hover to view quantity statistics, support clicking **Positive Filtering** and **Negative Filtering** buttons to filter data queries in the form of `key:value` for the currently ranked field attribute values.

    ![](../img/8.explorer_1.png)

=== "Dimension Analysis"

    Clicking switches the current Explorer to analysis mode, automatically importing the field into "Analysis Dimensions" for querying.

    ![](../img/analysis-mode.gif)

=== "Duration"

    If the quick filter in the Explorer includes a `duration` field, you can manually adjust the maximum/minimum values for query analysis. Notes are as follows:

    - The **Duration** progress bar in the quick filter defaults to the minimum and maximum duration of the trace data list;
    - Support dragging the progress bar to adjust the maximum/minimum values, the values in the input boxes change synchronously;
    - Support manually entering maximum/minimum values, press Enter or click outside the input box to filter and search;
    - If the input format is incorrect, the input box turns red and no search is performed, correct format: pure "number" or "number+ns/μs/ms/s/min";
    - If no unit is entered during the search, "s" is appended to the entered number by default, then the filter and search is performed;
    - If a unit is manually entered, the search is performed directly.

    ![](../img/9.apm_explorer_6.png)

</div>

## Filter History {#filter-history}

<<< custom_key.brand_name >>> supports viewing filter/search history in **Filter History**, and applying it to different Explorers within the current workspace.

- Open Filter History: Supported by clicking the icon to the right of the search bar above the Explorer, or directly via shortcut key `(Mac OS: shift+cmd+k / Windows: shift+ctrl+k)` to quickly open the filter history;
- Collapse Filter History: Click the close button `x` or use the `esc` key to collapse the filter history.

![](../img/logexplorer-1.png)

**Note**: Filter history is only supported for viewing the current user's filter/search conditions in the local browser.


### Operation Instructions

In the Explorer's filter history, up to 100 filter/search conditions can be viewed, and you can switch between filter/search conditions using the keyboard arrow keys (↑ ↓). Press the keyboard `enter` to add to the filter.

- Pin to Filter: Place the mouse over the filter history, and you can pin filter/search conditions to the top via the "Pin to Filter" button on the right;
- Add to Filter: Click the filter/search condition to add it to the Explorer for filtering, supporting multi-selection;
- Cancel Filter: After adding to the filter, click the filter/search condition again to cancel the filter;

![](../img/linkexplorer-1.png)

- Apply Filter History in Different Explorers: When browsing `-source: default` filter history (as shown in the figure above) in **Logs > Explorer**, you can directly use it in link explorers and other Explorers for filtering and searching.

![](../img/linkexplorer.png)


## Time Widget {#time}

<<< custom_key.brand_name >>> supports controlling the data display range of the current Explorer through the Time Widget. Users can manually input time ranges, or quickly select built-in time ranges for the current Explorer, or set custom time ranges.

### Manually Input Time Range

The Time Widget supports interval display by default, and supports viewing the manual input time range format by clicking the Time Widget, including **dynamic time** and **static time**. After inputting, press Enter or click any blank area to filter and view corresponding data according to the input time range.

![](../img/12.time_1.png)

=== "Dynamic Time"

    Dynamic time ranges support seconds, minutes, hours, and days in 4 units, such as 1s, 1m, 1h, 1d, etc., as shown in the figure below input 20m.

    ![](../img/7.timestamp_6.png)

    Pressing Enter returns a time range of the last 20 minutes, i.e., the Explorer displays data from the last 20 minutes.

    ![](../img/7.timestamp_6.1.png)

=== "Static Date Time"

    Standard date time formats support multiple write-ups, with time formats precise to the second level, and delimiters `~`, `-`, `,` allow spaces before and after input, commas must be English commas.

    - `2022/08/04 09:30:00~2022/08/04 10:00:00`
    - `2022/08/04 09:30:00-2022/08/04 10:00:00`
    - `2022/08/04 09:30:00,2022/08/04 10:00:00`

    Click the Time Widget, you can directly input and modify the standard time format, press Enter to display the corresponding data according to the current time range.

    ![](../img/7.timestamp_7.png)

=== "Static Timestamp Time"

    Timestamp ranges support multiple write-ups, timestamps support millisecond-level input, delimiters `~`, `-`, `,` allow spaces before and after input, commas must be English commas.

    - `1659576600000~1659578400000`
    - `1659576600000-1659578400000`
    - `1659576600000,1659578400000`

    Click the Time Widget, and input the start and end timestamps as shown in the figure below.

    ![](../img/7.timestamp_5.png)

    Pressing Enter returns the time range and filters out corresponding data displayed in the Explorer according to this time range.

    ![](../img/7.timestamp_5.1.png)

=== "Precautions"

    - If the format does not meet the input requirements, the correct time range cannot be returned, such as start time later than end time, not conforming to `hour:minute:second` format input, etc.

    ![](../img/7.timestamp_8.png)

    - The tooltip and text input box of the Time Widget are linked in real time. If the input time range exceeds 4 digits (including time intervals, absolute times, and timestamps), the Time Widget tooltip shows `-`.

    ![](../img/7.timestamp_9.png)

    Pressing Enter displays the time range.

    ![](../img/7.timestamp_10.png)

### Quick Filter Time Range

You can quickly select corresponding time ranges for data viewing by clicking **More** in the Time Widget. The Time Widget presets multiple quick filter time ranges, including dropdown lists like "Last 15 Minutes, Last 1 Hour, Last 1 Day", etc., and dynamic times like "30s, 45m, 3d", etc.

![](../img/12.time_1.png)

Hovering over dynamic times allows real-time linkage with the input box content, clicking views data content corresponding to the time range.

![](../img/12.time_3.png)

### Custom Time Range

In addition to the preset time ranges, you can click **Custom Time** in the Time Widget to select time ranges, including dates and specific times, and click **Apply** to filter data according to the custom time range.

???+ warning 

    - Start and end times for custom time ranges must follow the `hour:minute:second` format, such as `15:01:09`;
    - The start time for custom time ranges cannot be later than the end time;
    - Query records for custom time ranges can be viewed in the **Custom Time Query History**, supporting viewing of up to the most recent 20 absolute time record histories. Click any historical record to quickly filter and view corresponding data content.

![](../img/12.time_4.png)

### Time Range in URL {#url}

In addition to the time range selection provided by the Time Widget, <<< custom_key.brand_name >>> also supports directly modifying the `time` parameter in the browser's URL for data queries in the current workspace Explorer, supporting seconds, minutes, hours, and days in 4 units, such as time=30s, time=20m, time=6h, time=2d, etc. As shown in the figure below, modifying `time=2h` in the browser displays data from the last 2 hours in the Explorer.

???+ warning 

    - Each unit can only be used independently, combinations are not allowed;
    - When the selected or browser-entered time range is greater than or equal to 1d, the Explorer automatically stops playback mode.

![](../img/4.url_1.png)

### Lock Time Range {#fixed}

<<< custom_key.brand_name >>> supports setting a fixed query time range by clicking the :octicons-pin-24: lock icon in the Time Widget. After setting, all Explorers/Dashboards default to displaying the current time range.

As shown in the figure below, if the locked time is "Last 45 Minutes", then all Explorers/Dashboards will query and display data from "Last 45 Minutes" according to the current locked time.

![](../img/12.time_fix_1.png)

### Set Time Zone {#zone}

<<< custom_key.brand_name >>> supports setting the current display time zone in the **Time Widget** to switch to the corresponding workspace time zone for data viewing.

![](../img/12.time_zone_1.png)

Enter **Time Widget > Time Zone Settings**, in the **Modify Time Zone** window:

- Default display "Browser Time", i.e., the local browser detected time;
- After the owner or administrator sets "[Workspace Time Zone](../../management/index.md#workspace)", members can choose the configured workspace time zone.

![](../img/zone.png)

???+ warning 

    - Only the Owner and Administrator of the current workspace have the **Workspace Time Zone** configuration permissions;

    - After setting a new time zone, all workspaces under your current account will display according to the set time zone, please proceed with caution.

You can also modify in **[Account Management](../../management/index.md#personal#zone)**.


## Auto Refresh {#refresh}

Helps quickly obtain real-time Explorer data. Optional frequencies: 5s, 10s, 30s, 1m, 5m, 30m, 1h.

If auto-refresh is not needed, select Off (disable) to turn it off.

![](../img/refresh-1.png)

???+ abstract "Impact of Time Widget on Refresh Frequency"

    The following two situations of the Time Widget affect refresh frequency:

    - Selected time range exceeds 1 hour
    - Selected time range is absolute time

    At this time, if you reselect a relative time range less than 1 hour, the refresh frequency will automatically revert to the previous configuration.

**Note**: All Explorers share one refresh configuration.


## Display Columns {#columns}

The Explorer supports selecting the number of rows to expand and view log data:

- You can customize adding, editing, deleting, and dragging display columns;
- You can use the keyboard arrow keys (↑ ↓) to select and add display columns;
- You can search fields by keyword;
- You can define display columns as preset fields, and after reporting data through Pipeline field cutting, the reported data can be displayed directly.

![](../img/7.log_column_4.png)

### Time Column {#time-column}

If the Explorer has a time column, you can directly check it in the display column configuration to choose whether to show it in the list.

<img src="../../img/time_column.png" width="80%" >


### Add Display Column

In the drop-down box for adding display columns, select the field to add to the display column. Or directly search and locate the target field.

If the target field is not found in the drop-down box, you can directly input the field name in "Add Display Column" and press Enter to complete the addition.

<img src="../../img/7.log_column_1.png" width="80%" >


### Display Column Operations

Under the [Standard Mode](../../logs/manag-explorer.md#mode) of the Explorer list, when hovering over the display column, click the settings button to perform the following operations on the display column.

![](../img/8.showlist_3.png)

| Operation      | Description                          |
| ----------- | ------------------------------------ |
| Ascending/Descending Order      | Sorts the current field values in ascending or descending order.                          |
| Move Column Left/Right      | Moves left or right based on the current display column.                          |
| Add Column Left/Right      | Adds a new display column left or right based on the current column.                          |
| Replace Column      | Replaces the current display column at the current position.                          |
| Add to Filter      | If the current display column is not present in the left quick filter, click to add it as a new quick filter item.                          |
| Enter [Analysis Mode](#analysis)      | Directly incorporates the field into the filter in analysis mode.           |
| Remove Column      | Removes the current display column.                 |



## Save Snapshot {#snapshot}

You can perform searches and filters on the currently displayed data, choose the time range, add display columns, etc., then click the snapshot small icon in the upper-left corner of the Explorer, and click **Save Snapshot** to save the currently displayed data content in the Explorer.

> For more details on snapshot usage, refer to [Snapshot](./snapshot.md).

<img src="../../img/6.snapshot_1.png" width="60%" >



## Export {#export}

In the Explorer, you can perform searches and filters on the currently displayed data, choose the time range, add display columns, etc., then click the :octicons-gear-24: on the right side of the Explorer to export the currently displayed data content. You can **Export to CSV File**, **Export to Dashboard**, and **Export to Note** for data viewing and analysis.

<img src="../../img/3.explorer_export_1.png" width="70%" >


To export a specific piece of data, open the detail page of that data, and click the :material-tray-arrow-up: icon in the upper-right corner.

<img src="../../img/export-log-0808.png" width="70%" >

### Export to CSV File {#csv}

![](../img/export-explorer.png)

You can choose to export 1k, 5k, 10k, 50k, or 100k data quantities.

## Charts {#chart}

- Chart Export: In the Explorer chart, you can hover over the chart with your mouse, click **Export** to export or copy the chart to the dashboard or note for display and analysis;
- Chart Time Interval: In the Explorer chart, you can choose the chart's time interval to view the corresponding chart data.

![](../img/4.explorer_chart_1.png)

- Collapse/Expand Chart:

![](../img/expand-distribution.gif)