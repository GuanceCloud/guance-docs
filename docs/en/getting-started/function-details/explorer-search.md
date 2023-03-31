# Powerful Explorers
---

Explorers of Guance include Infrastructure, Events, Logs, APM, RUM, CI Visibility, Synthetic Tests, Security Check and so on. <br/><br/>Explorers provide a variety of search and filtering methods, custom selection time range, data display column addition, ascending and descending order viewing, export and other functions to help you quickly and accurately retrieve data and locate problems.

## Search {#search}

### Keyword Search

Explorers support entering keywords in the search field for retrieval and the entered keywords will be highlighted in the query results, as shown in the following figure.

![](../img/13.search_1.png)

### Wildcard Search

Explorers support entering wildcard characters for fuzzy match search, such as entering `global*` in the log search field, and returning log data with "global" in the keyword, which can be followed by any number of characters, as shown in the figure.

![](../img/8.search_2.png)

### Association Search

Association search based on AND/OR/NOT logic is supported in the explorers and can be used in conjunction with wildcard searches.

| Logical Relation | Description                                                         |
| -------- | ------------------------------------------------------------ |
| a AND b  | The returned result should contain both a and b. The more keywords you enter, the more accurate the data matching range will be. Where `AND` can be replaced by `space` or `,` i.e. `a, b` = `a b` = `a AND b` |
| a OR b   | The returned result should contain any keyword of a or b.                     |
| NOT c    | The return result needs to contain no keyword c.                                   |

![](../img/13.search_4.png)


###  JSON Search {#json}

>Precondition: Support sites "China 1 (Hangzhou)", "China 3 (Zhangjiakou)" and "China 4 (Guangzhou)". Workspace needs to be created after `June 23, 2022`. JSON search function only supports log explorer at present.

- The content of the message is retrieved accurately by default, and the message is required to be in json format, which is not supported by log content in other formats.
- The json search format is: `@key:value`, or `@ key1.key2: value` for multi-level json available "." inheritance, as shown in the figure.

![](../img/7.log_json.png)

### DQL Search {#dql}

> Precondition: The DQL search feature currently only supports log explorer use.

In the log explorer, you can switch small icons by clicking ![](../img/8.explorer_2.1.png) on the search bar and switch to DQL manual input query mode. It supports custom input filters and search criteria.

- Filter criteria: Support any combination of `and/or`, the use of `()` parentheses to indicate the priority of performing searches, `=`, `! =` and other operators;
- Search criteria: Support string queries using the DQL function `query_string ()` such as entering `message = query_string ()` to search log contents.

See [DQL Definition](../../dql/define.md) for more DQL syntax.

<u>Example</u>

**Example 1:**

```json
source = nginx and status != OK
```

In this example, the source and status of the log are filtered, and it is important to note that **the field value filtered by is case sensitive**, and the result returned is as follows:

![](../img/8.explorer_3.1.png)

**Example 2 ：**

```json
message = query_string("debug OR 200" )
```

In this example, the contents of the log are queried, and multiple conditional combinations `AND` / `OR` of log fields (key) are supported. See [query_string()](../../dql/funcs.md#query_string) for more DQL syntax. This example returns the following result:

![](../img/8.explorer_3.2.png)

**Example 3 ：**

```json
source in ['kube-controller-manager','http_dial_testing'] and (status != 'unknown' or host != 'izbp152ke14timzud0du15z') and message = query_string('500')
```

In this example, the source, status, host and content of the log are searched and filtered, and the results are as follows:

- Log status is not equal to `unknown` or host is not equal to `izbp152ke14timzud0du15z`;
- Log sources are limited to `kube-controller-manager` and `http_dial_testing`;
- The log content needs to include the keyword `500`;

![](../img/8.explorer_3.png)

### Field Filter {#filter}

In the explorer, you can filter the value of a `label/attribute`. Six filtering methods are supported: **Forward Filter, Reverse Filter, Fuzzy Match, Reverse Fuzzy Match, Existence and Nonexistence**.

- You can filter by clicking the drop-down, or manually enter the label content according to the specified format and press **Enter** to filter.
- Multiple field filters, such as positive selection, negative selection, fuzzy matching and reverse fuzzy matching, are placed in the drop-down of four labels, and each label has an `and` relationship.
- If a label has both positive and negative selection states, it is inoperable to gray the label in shortcut filtering.

![](../img/5.explorer_search_1.png)

=== "Positive Filter"

    A forward filter search in the form of `key: value`, for example, a search in the log explorer for `status: error` returns all log data whose status belongs to error.

    ![](../img/positive_selection.gif)

=== "Reverse Filter"

    Reverse filter search in the form of `-key: value`. For example, a search in the log explorer for `-status: info` returns all log data whose status **is not equal to** info.

    ![](../img/reverse_selection.gif)

    *Manually enter the label content for reverse selection*

    ![](../img/reverse_selection2.gif)

=== "Fuzzy Match"

    A Wildcard Matching search is performed in the form `*key:value`, and wildcard characters can be written in value for value matching. For example, a search in the log explorer for `*host:prd-*` returns all log data with host names beginning with `prd-`.

    > Note: If there is a left* match for a value in a fuzzy match query, it will easily lead to query timeout. Please use it carefully.

    ![](../img/wildcard_matching.gif)

    *Manually enter tag content for fuzzy matching*

    ![](../img/wildcard_matching2.gif)

=== "Reverse Fuzzy Match"

    Reverse Fuzzy Match searches for Not Wildcard Matching in the form of `-*key:value`, and wildcard characters can be written in value for value matching. For example, a search in the log explorer for `-*service:k8s*` returns log data for all services that do not begin with `k8s`. It supports manual input tag content for reverse fuzzy matching.

    ![](../img/5.explorer_search_2.png)

=== "Exist"

    A field Exist search in the form of `key:*`, for example, a search in the log explorer for `service:*` returns log data for all existing service fields.

    ![](../img/16.search_1.png)

=== "Not Exist"

    A Not Exist search in the form of `-key:*`, for example, a search in the log explorer for `-service:*` returns log data for all non-existent service fields. As can be seen from the following figure, logs that do not contain services have a total of 396 records, and the data comes from the log data of synthetic tests.

    ![](../img/16.search_2.png)


=== "Numeric Operator Filter"

    Searches are performed in the form of `key:operator value`, which includes `equal to, greater than or equal to, less than or equal to, greater than, less than, and not equal to`. For example, a search in the RUM View explorer for `loading_time>=2s` returns all View data with a load time greater than or equal to 2 seconds.

    ![](../img/16.search_3.png)

    Filtering through operator intervals is supported, as shown in the following figure.

    ![](../img/16.search_4.png)

=== "Edit Filter"

    The selected label supports the following two editing methods:

    **1. Click the tab:**
    
    You can modify the filter criteria in the pop-up dialog box. The operation mode is as follows:  

    - `Equal to`: Namely positive filtering. It supports drop-down selection of label values, or manually enter label values and press Enter to determine;
    - `Not equal to`: Namely reverse filtering. It supports drop-down selection of label values, or manually enter label values and press Enter to determine;
    - `Fuzzy Matching`: Wildcard Matching, which supports input wildcard characters for fuzzy matching search, and separates multiple values with ",";
    - `Fuzzy mismatch`: Not Wildcard Matching, which supports input wildcard characters for fuzzy mismatch search, and separates multiple values with ",";
    - `Existence`: Exist, which supports search to return all data with filtered fields;
    - `Not Exist`: Suppor search to return all data for which filter fields do Not Exist;
    - `Numeric operator`: Namely `equal to, greater than or equal to, less than or equal to, greater than, less than, not equal to`, it supports interval filtering, and separates multiple values with ",".

    > Note: label tabs do not support pop-up editing.

    ![](../img/edit_filter.png)

    ![](../img/16.search_5.png)

    **2. Double-click the tab:**
    
    You can manually edit a single filter, but you cannot modify multiple filters at the same time. As shown below:

    - [key:value] Radio tag

    ![](../img/double_click1.png)

    - [key:xx] Multiple-choice tag

    ![](../img/double_click2.png)

## Analysis Schema Description {#analysis}

In the explorer analysis column, multi-dimensional analysis and statistics based on **1 to 3 tags** are supported to reflect the distribution characteristics and trends of data in different dimensions and at different times. Guance supports a variety of data chart analysis methods, including time sequence chart, ranking list, pie chart and rectangular tree chart.

**Data display**

- Data point: Data point refers to the coordinate point where the data value is located. The line chart and area chart of the timing chart will be automatically aggregated into data points according to the time range you choose, and the number of data points will not exceed 360 points; The number of data points in the histogram shall not exceed 60.
- Data range: Data range refers to the value range of each data point, that is, the coordinate point of the current data point is pushed forward to the coordinate point of the previous data point as the interval range, and the data value in this range is taken.

![](../img/5.log_analysis.gif)

## Quick Filter Description {#quick-filter}

### Custom Filter Fields

It supports editing **Quick Filter** to add new **Filter Fields** in the explorer. Two configuration modes are supported: spatial filter items and personal filter items.

> It supports preset fields in shortcut filtering. The newly added fields default to the field type in field management. If there is no field type in field management, it defaults to text format.

=== "Spatial Filter Items"

    It is configured by the administrator/owner. Click the **Settings** button next to the shortcut filter to configure the space-level filter items. It supports adding fields, editing field aliases, adjusting field order and deleting fields.

    > Note: Space-level filter items, all members of the workspace can be viewed, but normal members and standard members do not support editing, deleting, moving locations.

    ![](../img/5.explorer_search_7.png)

=== "Individual Filter Items"

    All members can configure shortcut filter items based on local browser. Click **Edit** on the right side of shortcut filter to configure personal filter items. It supports adding fields, editing field aliases, adjusting field order and deleting fields.

    > Note: Individual-level filters are available only to the current individual, not to other members of the workspace.

    ![](../img/5.explorer_search_8.png)

### Operating Instructions

=== "Select All"

    By default, the label values of all shortcut filter items are checked, indicating that no filtering has been performed.

=== "Empty Filter"

    Click the **Clear Filter** button in the upper right corner of the shortcut filter item to cancel the value filter of this label, that is, restore all selection.

=== "Cancel/Check"

    Click the check box in front of the shortcut filter item label value to **Cancel** or **Check** the value. By default, uncheck the previous check box, indicating that the value is reversed, and continue to uncheck other check boxes, indicating that it is reversed multiple selection.

    ![](../img/12.quick_filter_1.png)

=== "Select this item only/Unselect it"

    Click on the line where the label value is located, indicating that this value is selected positively **Check this item only**, and continue to check the check boxes of other values, indicating that it is selected positively; When a value is positively selected, click **Unselect** on the row where the value is located again to cancel all filtering.

    ![](../img/12.quick_filter_1.1.png)

=== "Positive Election & Anti-Election"

    If a label has both positive and negative selection states, it is inoperable to gray the label in shortcut filtering.

    ![](../img/12.quick_filter_2.png)

=== "Quick Filter Item Search"

    When the shortcut filter item has more than 10 labeled fields, fuzzy search according to **Field Name** or **Display Name** is supported.

    ![](../img/12.quick_filter_5.1.png)

=== "Field Value Search"

    If the shortcut filter item exceeds 10 field attribute values, it supports real-time search of input text and supports clicking fuzzy matching and reverse fuzzy matching for filtering.

    ![](../img/12.quick_filter_3.png)

=== "Field Value Quantity Statistics Ranking {#top5}"

    Click the **Settings** button in the upper right corner of the shortcut filter item, and select **Query Value TOP 5** to view the statistical quantity percentage of the top five field attribute values of the current filter item. In the ranking list, it is supported to view the quantity statistics by hovering the mouse, and to click the buttons of **Forward Filter** and **Reverse Filter** to carry out data filtering query on the field attribute values of the current ranking in the form of `key: value`.

    ![](../img/8.explorer_1.png)

=== "Add/Remove Display Columns"

    Click the **Settings** button in the upper right corner of the shortcut filter item to **Add/Remove Display Columns**. The custom added personal filter item fields support editing display names and deleting fields.

    ![](../img/12.quick_filter_4.png)

=== "Duration"

    If the shortcut filter in the explorer includes the Duration field, you can manually adjust the maximum/minimum values for query analysis. Notes are as follows:

    - The **Duration** of the shortcut filter defaults to the minimum value of the progress bar, and the maximum value is the minimum and maximum duration in the link data list;
    - Support dragging the progress bar to adjust the maximum/minimum value, and the values in the input box change synchronously;
    - Support manual input of maximum/minimum value, press enter key or click outside the input box for filtering search;
    - When the input is not standard, the input box turns red, and no search is carried out. The correct format is pure "number" or "number + ns/μ s/ms/s/min";
    - If no unit is entered for search, the default is to directly fill in "s" after the entered number and then filter the search;
    - If you enter units manually, search directly.

    ![](../img/9.apm_explorer_6.png)

## Filter History Description {#filter-history}

Guance supports saving the search condition history of explorer `key:value` in Filter History, which is applied to different explorers in the current workspace. For example, Filter History is saved in log explorer, which can be directly used in other explorers such as links.

- Open filter history: Support to quickly open filter history by clicking the expansion icon in the lower-right corner of the explorer, or directly through the shortcut key (Mac OS: shift + cmd + k/Windows: shift + ctrl + k);
- Close the filter history: Click the close button `x` or use the `escc` button to close the filter history.

> Note: Filter history only supports saving the current user's search criteria in the local browser.

![](../img/1.filter_history_2.png)

### Operating Instructions

Guance saves up to 100 search criteria in the explorer filter history, and supports switching keys (↑ ↓) up and down on the keyboard to switch and select search criteria, and finally clicks the keyboard `enter` to add to the filter.

- Fixed to Filter: The mouse is placed on the screening history, and the top search criteria can be set through the **Fixed to Filter** button on the right;
- Add to Filter: Click search criteria to add to the explorer for filtering, which supports multiple choices;
- Cancel Filter: After adding to the filter, click **Search Criteria** again to cancel the filter.

![](../img/1.filter_history_1.png)

- Apply filter history in different explorers: Filter history is saved in the log explorer and can be used directly in other explorers such as links.

![](../img/filter_history.gif)



## Time Control Description {#time}

Guance supports controlling the data display range of the current explorer through time control. Users can manually enter the time range, quickly select the built-in time range of the current explorer, or set the time range by customization.

### Enter Time Range Manually

The time control supports interval display by default, and supports clicking the time control to view the format of manually input time range, including **Dynamic Time** and **Static Time**. After input, **Enter** or **Click any blank area** can filter and view the corresponding data according to the input time range.

![](../img/12.time_1.png)

=== "Dynamic Time"

    The dynamic time range supports four units: seconds, minutes, hours and days, such as 1s, 1m, 1h, 1d, etc. Input 20m as shown in the following figure.

    ![](../img/7.timestamp_6.png)

    Enter can return the data in the last 20 minutes, that is, the explorer displays the last 20 minutes.

    ![](../img/7.timestamp_6.1.png)

=== "Date Static Time"

    The date standard time format supports the following writing methods. The time format is accurate to the second level. Spaces are allowed before and after the spacers `~`, `-`, `,`, and commas must be English commas.

    -  `2022/08/04 09:30:00~2022/08/04 10:00:00` 
    -  `2022/08/04 09:30:00-2022/08/04 10:00:00` 
    -  `2022/08/04 09:30:00,2022/08/04 10:00:00` 

    Click on the time control, you can directly input and modify the standard time format, and display the corresponding data according to the current time range after **Enter**.

    ![](../img/7.timestamp_7.png)

=== "Timestamp Static Time"

    The timestamp range supports the following writing methods. The timestamp supports millisecond input. Spaces are allowed before and after the spacers `~`, `-`, `,`, and commas must be English commas.

    - `1659576600000~1659578400000` 
    - `1659576600000-1659578400000` 
    - `1659576600000,1659578400000` 

    Click the time control and enter the start and end timestamps as shown in the following figure.

    ![](../img/7.timestamp_5.png)

    **Enter** can return to the time range, and filter out the corresponding data according to this time range and display it in the explorer.

    ![](../img/7.timestamp_5.1.png)

=== "Notes"

    - If the format does not conform to the input requirements, the correct time range cannot be returned, such as the start time is later than the end time, and the format input does not conform to `hours:minutes:seconds`.

    ![](../img/7.timestamp_8.png)

    - The prompt box of the time control and the text input box are linked in real time. If the input time range exceeds 4 digits (including time interval, absolute time and timestamp), the prompt box of the time control displays `-`.

    ![](../img/7.timestamp_9.png)

    Display the time range after carriage return.

    ![](../img/7.timestamp_10.png)

### Quick Filter Time Range

You can click **More** in the time control to quickly select the corresponding time range for data viewing. A variety of shortcut filter time ranges are preset in the time control, including "last 15 minutes, last 1 hour, last 1 day, etc." in the drop-down list and "30s, 45m, 3d, etc." in the dynamic time.

![](../img/12.time_1.png)

When the mouse is placed on the dynamic time, it can be linked with the input box in real time, and the data content in the corresponding time range can be viewed by clicking.

![](../img/12.time_3.png)

### Custom Time Range

In addition to the preset time range, you can click **Custom Time** in the time control to select a time range, including date and specific time, and click **Apply** to filter data according to the customized time range.

???+ attention 

    - The start and end times of the custom time range should be entered in the format `Hours:Minutes:Seconds`, such as `15:01:09`.
    - The start time of the custom time range cannot be later than the end time.
    - Query records of custom time range can be viewed in **Custom Time Query History**, and up to 20 recent historical absolute time records can be viewed. Click any historical record to quickly filter and view the corresponding data content.

![](../img/12.time_4.png)

### Time Range of URL {#url}

In addition to the time range selection provided by the time control, Guance also supports directly modifying the time range of the `time` parameter of the current workspace explorer in the URL of the browser for data query, and supports four units of seconds, minutes, hours and days, such as time=30s, time=20m, time=6h, time=2d, etc. As shown in the following figure, modify `time=2h` in the browser, and the explorer displays the data of the last 2 hours.

???+ attention 

    - Each unit can only be used independently, not in combination.
    - When selected or entered in the browser for a time range greater than or equal to 1d, the explorer automatically stops playing mode.

![](../img/4.url_1.png)

### Lock Time Range {#fixed}

Guance supports in time control by clicking ![](../img/12.time_fix_2.png) to lock the icon and set a fixed query time range, and all explorers/dashboards default to the current time range.

As shown in the following figure, if the lock time is "last 45 minutes", all explorers/dashboards will query and display the data of "last 45 minutes" according to the current lock time.

![](../img/12.time_fix_1.png)

### Set Time Zone {#zone}

Guance supports setting the current display time zone in the time control, or you can modify it in [Account Management](../../management/account-management.md#zone), and the default provides `(UTC+08:00) Beijing` time zone.

> Note: After setting the new time zone, all workspaces where your current account is located will be displayed according to the set time zone.

![](../img/12.time_zone_1.png)

### Explorer Auto Refresh

In Guance workspace, click **Account** to turn on/off **Explorer Auto Refresh**.

- Open: The data of the explorer is automatically refreshed according to the default data refresh time of 30 seconds of the time control. For example, if you select the last 15 minutes, refresh once according to 30 seconds to display the data of the last 15 minutes.
- Close: When the time control of the explorer enters, turn off the automatic refresh for 30 seconds. If you select the last 15 minutes, the content data of the absolute time of the 15 minutes will be displayed without automatic refresh. You can click the **Play** button to refresh and view the data of the last 15 minutes.

> Note: Explorer automatic refresh only works for local browsers.

![](../img/7.timestamp_1.png)

Click the **Pause** button to exit the real-time data refresh mode and lock the current time range to absolute time.

> For example, if the time range is selected as "last 15 minutes", when the **Pause** button is clicked, the overall time range of the explorer is adjusted forward to 15 minutes.

![](../img/7.timestamp_7.png)


## Display Column Description {#columns}

Explorers support selecting the number of rows to display to expand the view log Message data, clicking **Display Column** to add, edit, delete and drag display columns. They also support selecting and adding display columns by switching keys up and down on the keyboard, searching keywords in **Display Column**, and customizing display columns as preset fields in **Display Column**. After cutting fields and reporting data through Pipeline, the reported data can be directly displayed.

![](../img/7.log_column_4.png)

### Add Display Column

In the explorer display column, it supports matching search for input fields, selects the first searched field by default, and supports selecting and adding display columns by switching keys up and down (↑ ↓) on the keyboard.

![](../img/7.log_column_1.png)

If the input field does not exist, it can be distinguished by "dividing line", and prompt "create and add" display column, which will be used as default field after creation, and the reported data can be directly displayed after cutting the field and reporting the data through Pipeline.

![](../img/7.log_column_2.png)


### Operating Instructions

In the explorer list, when the mouse is placed on the display column, you can click the **Settings** button of the display column, which supports ascending, descending, moving columns to the left, moving columns to the right, adding columns to the left, adding columns to the right, replacing columns, adding to shortcut filtering, adding to grouping, removing columns and other operations.

- Ascending/descending: Display the value of the current field in ascending or descending order;
- Move column to left/right: Move column to left or right. If moving column is not supported, this operation will not be displayed;
- Add columns to the left/right: Add a new display column to the left or right based on the current column. Search is supported. If adding columns is not supported, the operation will not be displayed;
- Replace Column: Replace the current displayed column at the current position. Search is supported. If replacement column is not supported, the operation will not be displayed;
- Add to shortcut filter: If there is no current display column in the shortcut filter on the left, click to add the display column as a new shortcut filter item, and click the **Settings** button of the shortcut filter item to remove the display column.
- Add to Grouping: Displays the contents of the Grouping Explorer based on the currently displayed column as a grouping field;
- Remove Column: Remove the currently displayed column.

![](../img/8.showlist_3.png)

If the contents of the displayed column are not completely displayed, it is supported to place the mouse on the dividing line on the right side of the displayed column and "double-click the dividing line" to expand the contents of the column, as shown in the `source` column in the following figure.

![](../img/8.showlist_4.png)

## Save Snapshot Instructions {#snapshot}

In Metrics, Logs, Events, APM, RUM, cloud dialing test, Security Check and other explorers, You can search and filter the currently displayed data, select a time range, add viewing columns, and so on. Then click the **Snapshot** icon in the upper left corner of the explorer, and click **Save Snapshot** to save the data content displayed by the current explorer. It supports operations such as **Share Snapshot, Copy Snapshot Link and Delete Snapshot** for the saved snapshot in the historical snapshot. For more details on snapshot usage, refer to the documentation [Snapshot](../../management/snapshot.md).

![](../img/6.snapshot_1.png)



## Export Instructions {#export}

In the explorer, you can search and filter the currently displayed data, select the time range, add viewing columns and other operations, and then click the **Settings** button on the right side of the explorer to export the data content currently displayed in the explorer. It supports **Export to CSV File**, **Export to Dashboard** and **Export to Notes** for data viewing and analysis.

![](../img/3.explorer_export_1.png)



## Chart Description {#chart}

- Chart Export: In the explorer chart, you can hover to the chart with the mouse, and click the **Export** button to export or copy the chart to the dashboard and notes for display and analysis;
- Chart Time Interval: In Explorer Chart, you can select the chart time interval to view the corresponding chart data.

![](../img/4.explorer_chart_1.png)
