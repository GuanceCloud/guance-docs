# Explorer
---

The <<< custom_key.brand_name >>> Explorer can be used within various feature modules such as infrastructure, events, logs, APM, RUM PV, CI visualization, Synthetic Tests, Security Check. As one of the key tools for data observability, the Explorer provides multiple search and filtering methods and supports combining them to obtain final data results. This article will detail the functionality of the Explorer to help you quickly and accurately retrieve data and locate fault issues.

## Search {#search}

### Text Search {#text}

Searches generally consist of two parts: <u>terms</u> and <u>operators</u>. Wildcard queries are supported, where `*` matches 0 or more arbitrary characters, and `?` matches 1 arbitrary character. To combine multiple terms into a complex query, [Boolean operators](#bool) (AND/OR/NOT) can be used. The Explorer uses the [query_string()](../../dql/funcs.md#query_string) query syntax.

Terms can be single words or phrases. For example:

- Single word: guance;
- Multiple words: guance test; (equivalent to guance AND test)
- Phrase: "guance test"; (using double quotes converts a group of words into a phrase)

*Search Query Example:*

![](../img/0620.gif)

### JSON Search {#json}

**Prerequisites for Use**:

1. Workspace created after `June 23, 2022`;
2. Used in the log viewer.

By default, precise searches are performed on the content of `message`, which must be in **JSON format**. Logs in other formats do not support this search method. The search format is `@key:value`. If it's multi-level JSON, use `.` to connect, i.e., `@key1.key2:value`, as shown below.

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

???+ warning "Note"

    When the search content contains `.` (e.g., `trace.id`), directly using the `@key1.key2:value` format will cause the system to recognize `trace` and `id` as two separate keys instead of one whole. To avoid this issue, use the `@\"key1.xxx\":value` format, such as `@\"trace.id\":value`, so the system correctly identifies the complete key name.


## Filtering {#filter}

In the Explorer, you can perform filter queries based on `field names` and `field values`.

???+ warning "Note"

    The main difference between filtering and searching is whether there is a <u>: colon separator</u> in the input content. If it exists, it is judged as a filtering condition; if not, it is considered a search condition.

### Operator Description {#operator}

Different types of fields support different operators, as follows:

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
| `not regexp`      | Reverse regular expression match, uses target string to match regular expressions, example: `-attribute:/value.*/`                  |
| `>`      | Greater than, example: `attribute:>value`                |
| `>=`      | Greater than or equal to, example: `attribute:>=value`                  |
| `<`      | Less than, example: `attribute:<value`                  |
| `<=`      | Less than or equal to, example: `attribute:<=value`               |
| `[xx - xx]`      | Range, example: `attribute:[1 - 100]`               |

### Wildcard Description {#wildcard}

Supports `*` or `?` wildcard queries, where `*` matches 0 or more arbitrary characters, and `?` matches 1 arbitrary character.

```
Value: guanceyun

# Only suffix * matching is used, suitable when the string prefix is fixed and precise, while the latter part dynamically changes
attribute:guance*    // * matches yun

# Only ? matching is used, suitable when only certain fixed position characters are dynamically updated
attribute:gua?ceyun   // ? matches n

# ? * combined usage
attribute:gua?ce*   // ? matches n ,* matches yun

# Mixed * usage
attribute:gua*e*   // First * matches nc, second * matches yun
```

## Special Character Search Handling {#character}

In the Explorer, some characters have special meanings, such as `space` being used to separate multiple words. Therefore, if the search content includes any of the following characters, special handling is required: `space`, `:`, `"`, `“`, `\`, `(`, `)`, `[`, `]`, `{`, `}`.

### :material-numeric-1-circle: Convert text into a phrase

1. Add `"` double quotes around the text to turn it into a phrase;
2. In this writing style, the content within double quotes will be matched as a whole, and wildcards will not take effect;
3. If the text contains `\` or `"`, this method cannot be used for searching; please use [Method Two](#method-two).

*Example Explanation: Searching the field name `cmdline`, field value `nginx: worker process`:*

- Search

```
"nginx: worker process"   // Successful search, precise match of words
```

```
"nginx * process"   // Failed search, because * in double quotes is not treated as a wildcard
```

- Filter

```
cmdline:"nginx: worker process"   // Successful search, precise match of words
```

```
cmdline:"nginx: worker*"  // Failed search, because * in double quotes is not treated as a wildcard
```

### :material-numeric-2-circle: Escape characters {#method-two}

1. Add `\` before special characters;
2. If the text itself contains `\`, the processing methods for search and filter differ: three additional `\` are required for escaping during search; only one `\` is needed for filtering.

*Example Explanation: Searching the field name `cmdline`, field value `E:\software_installer\vm\vmware-authd.exe`:*

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

Supports further <u>combination of search and filter conditions</u> in the form of `AND/OR/NOT`.

![](../img/13.search_4.png)

| Logical Relationship | Description                                    | Note |
| -------- | --------------------------------- | --- |
| a AND b  | Takes the intersection of the results before and after the query | Search and filter conditions default to connecting with AND. Among them, `AND` can be replaced by `space`, i.e., `a` AND `b` = `a` `b`.   |
| a OR b   | Takes the union of the results before and after the query        | Returns results containing either a or b. Example: `a` OR `b:value`  |
| NOT c    | Excludes current query results          | NOT is mostly used in search writing; exclusion logic in filters uses `≠` instead. |

## Search/Filtering Precautions

### Grouping

Use parentheses `()` to increase the priority of data query conditions, meaning that if `()` exists in the query, the search and filter conditions within `()` will be executed first. Within `()`, the query priority still follows `NOT > AND > OR`.

### Handwritten Mode

Support switching the search box to "Handwritten Mode"
This handwritten mode covers all Explorers (except dashboards/custom Explorers). In the new mode, UI interactions allow adding search and filter conditions and freely switch between handwritten mode, without making any changes to the content before switching modes, truly enabling real-time switching and restoration between UI and handwritten input.


## Analysis Mode {#analysis}

In the Explorer analysis panel, multi-dimensional aggregation queries can be performed on data for statistical analysis, reflecting the distribution characteristics and trends of data at different dimensions over time.

Click **Analyze**, to enter the data chart analysis mode, including time series graphs, top lists, pie charts, and treemaps. You can also choose different time intervals to display data.

![](../img/5.log_analysis.gif)

**Data Display Explanation:**

- Data Points: Data points refer to the coordinates of data values. Time series line and area charts automatically aggregate into data points based on the selected time range, with no more than 360 data points; bar charts have no more than 60 data points.
- Data Range: Data range refers to the value range of each data point, i.e., the interval range from the coordinate point of the current data point back to the previous data point, taking the value of the data within that range.

> In chart analysis mode, refer to [Operations](../../logs/explorer.md#charts) to manage charts.

## Quick Filters {#quick-filter}

In the Explorer, you can edit **Quick Filters** to add new **filter fields**. Two configuration methods are supported: <u>workspace-level filter items and personal-level filter items</u>.

Quick filters support preset fields. Newly added fields default to the field type in field management, or text format if they do not exist in field management.

<div class="grid" markdown>

=== "Workspace-Level Filter Items"

    Configured by administrators/owners. Click the quick filter gear icon :octicons-gear-24:, select to configure workspace-level filter items, supporting adding fields, editing field aliases, adjusting field order, deleting fields.

    **Note**: Workspace-level filter items can be viewed by all members of the workspace, but normal members and standard members do not support editing, deleting, or moving positions.

    ![](../img/5.explorer_search_7.png)

=== "Personal-Level Filter Items"

    All members can configure local browser-based quick filters. Click the pencil icon :material-pencil: on the right side of the quick filter to configure personal-level filter items, supporting adding fields, editing field aliases, adjusting field order, deleting fields.

    **Note**: Personal-level filter items can only be viewed by the current individual, and other workspace members cannot view them.

    ![](../img/5.explorer_search_8.gif)

</div>

- Click the illustrated icon to hide the quick filter column:

<img src="../../img/expand.png" width="60%" >

- Click the icon in the figure below to quickly add the field to the data list, click again to remove.

<img src="../../img/12.quick_filter_4.png" width="60%" >

### Related Operations

<div class="grid" markdown>

=== "Select All"

    By default, all labels of quick filter items are fully checked, indicating no filtering has been applied.

=== "Clear Filters"

    Click the **Clear Filters** button in the upper right corner of the quick filter item to cancel the value filtering of the label, restoring to full selection.

=== "Uncheck/Check"

    Click the checkbox in front of the quick filter item label to **uncheck** or **check** the value. By default, unchecking the checkbox indicates selecting the opposite value, continuing to uncheck other checkboxes indicates reverse multi-selection.

    ![](../img/12.quick_filter_1.png)

=== "Only Select This Item/Uncheck"

    Click the row where the label value is located to indicate positive single selection of this value **only select this item**, continue checking other value checkboxes to indicate positive multi-selection; when positively single-selecting a value, clicking the row again **unchecks** and cancels all filters.

    ![](../img/12.quick_filter_1.1.png)

=== "Positive Selection & Negative Selection"

    If a label has both positive and negative selection states simultaneously, the label is grayed out and cannot be operated in the quick filter.

    ![](../img/12.quick_filter_2.png)

=== "Quick Filter Item Search"

    When there are more than 10 label fields in the quick filter, search can be performed based on **field name** or **display name** for fuzzy matching.

    ![](../img/12.quick_filter_5.1.png)

=== "Field Value Search"

    If there are more than 10 field attribute values in the quick filter, you can input text for real-time search, supporting clicking fuzzy matching and reverse fuzzy matching for filtering.

    ![](../img/12.quick_filter_3.png)

=== "Top 5 Query Values"

    Click the gear icon :octicons-gear-24: in the upper right corner of the quick filter item, select **Top 5 Query Values** to view the percentage statistics of the top five field attribute values for the current filter item. In the leaderboard, you can hover the mouse to view quantity statistics, and click the **Positive Filter** and **Negative Filter** buttons to filter data queries in the form of `key:value` for the current ranking field attribute values.

    ![](../img/8.explorer_1.png)

=== "Dimensional Analysis"

    After clicking, the current Explorer switches to analysis mode, and the field is automatically included in the "Analysis Dimension" for querying:

    ![](../img/analysis-mode.gif)

=== "Duration"

    If the quick filter in the Explorer includes a `duration` field, you can manually adjust the maximum/minimum values for query analysis. Notes include:

    - The **duration** of the quick filter defaults to the smallest and largest durations in the trace data list;
    - Supports dragging the progress bar to adjust the maximum/minimum values, with the values in the input box changing synchronously;
    - Supports manually entering the maximum/minimum values, pressing Enter or clicking outside the input box to filter and search;
    - Input boxes turn red when input is invalid, preventing searches; correct format: pure "numbers" or "numbers+ns/μs/ms/s/min";
    - If no unit is entered for the search, the system automatically appends "s" to the number and then filters and searches;
    - If a unit is manually entered, the system directly performs the search.

    ![](../img/9.apm_explorer_6.png)

</div>

## Filter History {#filter-history}

<<< custom_key.brand_name >>> supports viewing filter and search history through **Filter History**, which can be applied across different Explorers within the current workspace.

- Open Filter History: Supported by clicking the icon to the right of the search bar above the Explorer, or directly via shortcut keys `(Mac OS: shift+cmd+k / Windows: shift+ctrl+k)` to quickly open the filter history;
- Hide Filter History: Click the close button `x` or press the `esc` key to hide the filter history.

![](../img/logexplorer-1.png)

**Note**: Filter history is only supported for viewing the current user's filter and search conditions in the local browser.


### Operation Instructions

In the Explorer's filter history, up to 100 filter and search conditions can be viewed, and you can switch between filter and search conditions using the keyboard arrow keys (↑ ↓). Pressing the `enter` key adds the selected condition to the filter.

- Pin to Filter: Hover over the filter history and pin frequently used filter/search conditions using the "Pin to Filter" button on the right;
- Add to Filter: Click the filter/search condition to add it to the Explorer for filtering, supporting multiple selections;
- Remove from Filter: After adding to the filter, clicking the same filter/search condition again removes it from the filter;

![](../img/linkexplorer-1.png)

- Apply Filter History Across Different Explorers: When browsing the filter history `-source: default` (as shown in the figure) in **Logs > Explorer**, you can directly use it in other Explorers like traces for filtering and searching.

![](../img/linkexplorer.png)


## Time Widget {#time}

<<< custom_key.brand_name >>> supports controlling the data display range of the current Explorer via the time widget. Users can manually input a time range, or quickly select a built-in time range for the current Explorer, or customize the time range.

### Manually Input Time Range

The time widget supports interval displays by default, allowing you to manually input the time range format by clicking the time widget. It supports **dynamic time** and **static time**. After input, press Enter or click any blank area to filter and view corresponding data according to the entered time range.

![](../img/12.time_1.png)

=== "Dynamic Time"

    Dynamic time ranges support four units: seconds, minutes, hours, days, such as 1s, 1m, 1h, 1d, etc. As shown in the figure below, input 20m.

    ![](../img/7.timestamp_6.png)

    Pressing Enter returns the time range to the last 20 minutes, i.e., the Explorer displays data from the last 20 minutes.

    ![](../img/7.timestamp_6.1.png)

=== "Static Date Time"

    Standard date time format supports multiple write methods, with time precision down to seconds. Delimiters `~`, `-`, `,` allow spaces before and after, and commas must be English commas.

    - `2022/08/04 09:30:00~2022/08/04 10:00:00` 
    - `2022/08/04 09:30:00-2022/08/04 10:00:00` 
    - `2022/08/04 09:30:00,2022/08/04 10:00:00` 

    Click the time widget to directly input and modify the standard time format, and press Enter to display the data according to the current time range.

    ![](../img/7.timestamp_7.png)

=== "Static Timestamp Time"

    Timestamp ranges support multiple write methods, with timestamps supporting millisecond-level inputs. Delimiters `~`, `-`, `,` allow spaces before and after, and commas must be English commas.

    - `1659576600000~1659578400000` 
    - `1659576600000-1659578400000` 
    - `1659576600000,1659578400000` 

    Click the time widget and input the start and end timestamps as shown in the figure below.

    ![](../img/7.timestamp_5.png)

    Pressing Enter returns the time range and filters out corresponding data displayed in the Explorer according to this time range.

    ![](../img/7.timestamp_5.1.png)

=== "Notes"

    - If the format does not meet the input requirements, the correct time range cannot be returned, such as the start time being later than the end time or incorrect input of `hour:minute:second` format.

    ![](../img/7.timestamp_8.png)

    - The tooltip and text input box of the time widget are linked in real time. If the input time range exceeds 4 digits (including time intervals, absolute times, and timestamps), the time widget tooltip shows `-`.

    ![](../img/7.timestamp_9.png)

    After pressing Enter, the time range is displayed.

    ![](../img/7.timestamp_10.png)

### Quick Filter Time Range

You can quickly select corresponding time ranges for data viewing by clicking **More** in the time widget. The time widget presets multiple quick filter time ranges, including dropdown options like "Last 15 Minutes, Last 1 Hour, Last 1 Day," and dynamic times like "30s, 45m, 3d."

![](../img/12.time_1.png)

Hovering over dynamic times allows real-time linkage with the input box content. Clicking views the data content corresponding to the selected time range.

![](../img/12.time_3.png)

### Custom Time Range

Besides the preset time ranges, you can click **Custom Time** in the time widget to select a time range, including the date and specific time, and click **Apply** to filter data according to the customized time range.

???+ warning 

    - The start and end times of the custom time range must follow the `hour:minute:second` format, e.g., `15:01:09`;  
    - The start time of the custom time range cannot be later than the end time;  
    - The query records of the custom time range can be viewed in the **Custom Time Query History**, supporting up to the last 20 absolute time records. Click any historical record to quickly filter and view corresponding data content.

![](../img/12.time_4.png)

### URL Time Range {#url}

In addition to the time range provided by the time widget, <<< custom_key.brand_name >>> also supports modifying the `time` parameter in the browser's URL directly to query data for the current workspace Explorer. It supports four units: seconds, minutes, hours, and days, such as time=30s, time=20m, time=6h, time=2d, etc. As shown in the figure below, modifying `time=2h` in the browser causes the Explorer to display data from the last 2 hours.

???+ warning 

    - Each unit can only be used independently, not combined;  
    - When the selected or browser-entered time range is greater than or equal to 1d, the Explorer automatically stops playback mode.

![](../img/4.url_1.png)

### Lock Time Range {#fixed}

<<< custom_key.brand_name >>> supports locking a fixed query time range via the :octicons-pin-24: lock icon in the time widget. After setting, all Explorers/Dashboards default to displaying the current time range.

As shown in the figure below, if the locked time is "Last 45 Minutes," then all Explorers/Dashboards display data for "Last 45 Minutes" according to the current locked time.

![](../img/12.time_fix_1.png)

### Set Time Zone {#zone}

<<< custom_key.brand_name >>> supports setting the current display time zone in the **Time Widget** to switch to the corresponding workspace time zone for data viewing.

![](../img/12.time_zone_1.png)

Enter **Time Widget > Time Zone Settings**, in the **Modify Time Zone** window:

- Displays "Browser Time" by default, which is the local time detected by the browser;      
- After the owner or administrator sets "[Workspace Time Zone](../../management/index.md#workspace)," members can choose the configured workspace time zone.

![](../img/zone.png)

???+ warning 

    - Only the Owner and Administrator of the current workspace have the **Workspace Time Zone** configuration permissions;  

    - After setting a new time zone, all workspaces under your current account will display according to the set time zone, please proceed with caution.

You can also modify it in **[Account Management](../../management/index.md#personal#zone)**.


## Auto Refresh {#refresh}

Helps quickly obtain real-time Explorer data. Available frequencies: 5s, 10s, 30s, 1m, 5m, 30m, 1h.

If auto-refresh is not needed, select Off (disable) to turn it off.

![](../img/refresh-1.png)

???+ abstract "Impact of Time Widget on Refresh Frequency"

    The following two situations of the time widget affect refresh frequency:

    - Selected time range exceeds 1 hour
    - Selected time range is an absolute time

    In these cases, if you reselect a relative time range less than 1 hour, the refresh frequency will automatically revert to the last configuration.

**Note**: All Explorers share one refresh configuration.


## Display Columns {#columns}

The Explorer supports selecting the number of rows to expand and view log data:

- Customize adding, editing, deleting, and dragging display columns;
- Use keyboard arrow keys (↑ ↓) to select and add display columns;
- Keyword search for fields;
- Define display columns as preset fields, so data reported after pipeline cutting can be displayed directly.

![](../img/7.log_column_4.png)

### Time Column {#time-column}

If the Explorer has a time column, it can be directly checked in the display column configuration to show or hide it in the list.

<img src="../../img/time_column.png" width="80%" >


### Adding Display Columns

In the drop-down box for adding display columns, select fields to add to the display columns. Alternatively, directly search for the target field.

If the target field is not found in the drop-down box, you can directly input the field name in "Add Display Column" and press Enter to complete the addition.

<img src="../../img/7.log_column_1.png" width="80%" >


### Display Column Operations

In the [Standard Mode](../../logs/manag-explorer.md#mode) of the Explorer list, hover over the display column and click the settings button to perform the following operations on the display column.

![](../img/8.showlist_3.png)

| Operation      | Description                          |
| ----------- | ------------------------------------ |
| Ascending/Descending Sort      | Sorts the values of the current field in ascending or descending order.                          |
| Move Column Left/Right      | Moves left or right based on the current display column.                          |
| Add Column Left/Right      | Adds a new display column to the left or right based on the current column.                          |
| Replace Column      | Replaces the current display column at the current position.                          |
| Add to Filter      | If the current display column is not present in the quick filter on the left, clicking will add it as a new quick filter item.                          |
| Enter [Analysis Mode](#analysis)      | Directly incorporates the field into the filter in analysis mode.           |
| Remove Column      | Removes the current display column.                 |



## Save Snapshot {#snapshot}

You can perform searches and filters on the currently displayed data, select a time range, add display columns, etc., then click the snapshot icon in the upper left corner of the Explorer and click **Save Snapshot** to save the data content currently displayed in the Explorer.

> For more details on snapshot usage, refer to [Snapshot](./snapshot.md).

<img src="../../img/6.snapshot_1.png" width="60%" >



## Export {#export}

In the Explorer, you can perform searches and filters on the currently displayed data, select a time range, add display columns, etc., then click the :octicons-gear-24: on the right side of the Explorer to export the data content currently displayed in the Explorer. You can **Export to CSV File**, **Export to Dashboard**, and **Export to Notebook** for data viewing and analysis.

<img src="../../img/3.explorer_export_1.png" width="70%" >


To export a specific data entry, open the details page of that entry and click the :material-tray-arrow-up: icon in the upper right corner.

<img src="../../img/export-log-0808.png" width="70%" >

### Export to CSV File {#csv}

![](../img/export-explorer.png)

You can choose to export 1k, 5k, 10k, 50k, or 100k data entries.

## Charts {#chart}

- Chart Export: In the Explorer chart, you can hover the mouse over the chart and click **Export** to export or copy the chart to the dashboard or notebook for display and analysis;
- Chart Time Interval: In the Explorer chart, you can select the chart's time interval to view the corresponding chart data.

![](../img/4.explorer_chart_1.png)

- Collapse/Expand Chart:

![](../img/expand-distribution.gif)