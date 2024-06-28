# Powerful Explorers
---

Explorers of Guance can be used in features including Infrastructure, Events, Logs, APM, RUM, CI Visibility, Synthetic Tests, Security Check, etc. 

As one of the important tools for data observability, Explorers of Guance provide a variety of search and filter methods and supports combined use to obtain the final data results. This article will introduce major explorer features to help you quickly and accurately retrieve data and locate faults.

## Search {#search}

Search generally consists of <u>terms and operators</u>. Wildcard query is supported, `?` means matching any character and `*` matching 0 or more characters; To combine multiple terms into a complex query, you can use [Boolean operator](#bool).

Terms can be words or phrases. For example:

- Word: guance;  
- Phrase: "guance test"  

<font color=coral>**Note:**</font> Using double quotation marks can convert a group of words into phrases.


<u>*Query sample (here, the example enters the search content for the explorer):*</u>

![](../img/0620.gif)

```
# Word
guance  // Precise search
guanc[e   // There is a special character writing example (no need to add/escape)   

# Word wildcard search (for performance reasons, Guance does not support prefix * writing for the time being, and if there is wildcard search, the following writing is supported)
guance*
gua?ce*  
gua*ce

# Phrase (the contents enclosed in double quotation marks are collectively referred to as phrases, and the contents of double quotation marks in this way will initiate a matching search as a whole)
"guance test"  // Query full-text index field, there is a match result of "guance test" content
"guance 127.0.0.1" // Sample writing when special characters exist
```

### JSON Search {#json}

<font color=coral>**Precondition**</font>: Sites "China 1 (Hangzhou)", "China 3 (Zhangjiakou)" and "China 4 (Guangzhou)" are supported. Workspace needs to be created after `June 23, 2022`. JSON search function <u>only supports log explorer</u> at present.

- By default, the content of `message` is retrieved accurately, and it is required that `message` is in JSON format, which is not supported by log content in other formats; 
- The json search format is: `@key:value`, or `@ key1.key2: value` for multi-level json available "." inheritance, as shown in the figure.

![](../img/7.log_json.png)

<u>*JSON search example:*</u>

```
message is as follows:
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
@cluster_name_k8s:k8s-demo     // Precise search
@cluster_name_k8s:k?s*        // Wildcard search

# Query service = ruoyi-mysql-k8s under meta
@meta.service:ruoyi-mysql-k8s   // Precise search
@meta.service:ruoyi?mysql*   // Wildcard search
```

## Filter {#filter}

In the explorer, you can filter the format of `tags/attributes`, splicing them in the order of `field operator values`.

<font color=coral>**Note:**</font> The biggest difference between filtering and searching is whether there is a <u>colon spacer</u> in the input content. If there is a colon spacer, it will be judged as a filtering condition. If not, it will be a search condition (if there is a double quotation mark in the search content, it can be changed into a phrase).

### Field

You can view the official field information provided by Guance by default on the **[Management > Field Management](../../management/field-management.md)** page.

### Operator

Guance supports filtering for <u>string OR numeric type fields</u>.

- String field operator: `=` `≠` `wildcard` `not wildcard` `exist` `not exist`;  
- Numeric field operator: `=` `≠` `>` `>=` `<` `<=` `[xx TO xx]` `exist` `not exist`.

![](../img/0620-1.png)

| Operator      | Description                  |
| ----------- | ---------------- |
| `=`     | Equal, example: `key:value`, `=` and `≠` can be combined with the following other operators.                  |
| `≠`      | Not equal, example: `-key:value`, `=` and `≠` can be combined with the following other operators.                  |
| `wildcard`      | [Wildcard match](#wildcard), example: `key:value*`. Reverse filtering is achieved by superimposing `≠`.                 |
| `exist`      | Exist, filter all data that exists with the current key. The result is returned. Example: `key:*`. Reverse filtering is realized by superimposing `≠`.                 |
| `>`      | Greater than, example: `key:>value`. Reverse filtering is realized by superimposing `≠`.                  |
| `>=`      | Greater than or equal, example: `key:>=value`. Reverse filtering is realized by superimposing `≠`.                  |
| `<`      | Less than, example: `key:<value`. Reverse filtering is realized by superimposing `≠`.                  |
| `<=`      | Less than or equal to, example: `key:<=value`. Reverse filtering is realized by superimposing `≠`.                  |
| `[xx - xx]`      | Duration, example: `key:[1 - 100]`. Reverse filtering is realized by superimposing `≠`.                 |

#### Wildcard {#wildcard}

`?` or `*` wildcard query is supported, `?` means matches any character, `*` matches zero or multiple characters:

```
Value: guanceyun

# Only the suffix * matching is used. This scenario is suitable for the case where the string of a certain value prefix is fixed and accurate, and the second half changes dynamically
key:guance*    // * matches yun

# Use only ? match, this scenario is suitable for cases where only a few fixed-position characters are dynamically updated
key:gua?ceyun   // ? matches n

# ? * overlay use
key:gua?ce*   // ? matches n, * matches yun

# * mixed use
key:gua*e*   // the first * matches nc, and the second * matches yun
```


### Value

AND and OR operator combination queries are supported.

```
# Precise search
key:(value1 AND value2 OR value3)

# Contain wildcard match    
key:(value1 OR test* OR value3)

# Contain * exist      
key:(value1 OR * OR value3)          // Equivalent to key:* 
key:(value1 AND *)                  // Equivalent to key:value1
key:(value1 AND * OR value3)        // Equivalent to key:(value1 OR value3)
```

## Boolean Operator {#bool}

The form of `AND/OR/NOT` supports further <u>combination of association search</u>.

![](../img/13.search_4.png)

| Logical Relation | Description                                    | Notes |
| -------- | --------------------------------- | --- |
| a AND b  | Take the intersection of the query results before and after | By default, AND is used for connection between search AND filter conditions. `AND` can use `Spaces`, that is, `a` AND `b` = `a` `b`.   |
| a OR b   | Take the union of the query results before and after        | The returned result should contain either a or b keyword. Example: `a` OR `b:value`.  |
| NOT c    | Exclude current query results          | NOT is mostly used in search writing, and the exclusion logic at screening is replaced by `≠`. |

## Search/Filter Notes

### Grouping

Use parentheses `()` to prioritize the data query criteria, i.e. the query logic in `()` takes precedence over the filter criteria if there is a selected part of the search in the query `()`. The query priority within `()` is still executed as `NOT > AND > OR`.

### Handwriting Mode

<font color=coral>**Note:**</font> The new version of DQL handwriting mode previously supported by **Log > Explorer** will be offline after it goes online.

This handwriting mode covers all explorers (<u>except dashboard/custom explorer</u>). In the new mode, UI interaction is supported to add search, filter conditions and handwriting mode can be switched freely, and no changes will be made to the content before mode switching, thus realizing real-time switching and restoration of UI and handwriting input.



## Analysis Mode {#analysis}

In the explorer analysis column, multi-dimensional analysis and statistics based on <u>1 to 3 tags</u> are supported to reflect the distribution characteristics and trends of data in different dimensions and at different times.

**Data display:**

- **Data point**: Data point refers to the coordinate point where the data value is located. The line chart and area chart of the timing chart will be automatically aggregated into data points according to the time range you choose, and the number of data points will <u>not exceed 360 points</u>; The number of data points in the histogram shall <u>not exceed 60</u>.
- **Data range**: Data range refers to the value range of each data point, that is, the coordinate point of the current data point is pushed forward to the coordinate point of the previous data point as the interval range, and the data value in this range is taken.

![](../img/5.log_analysis.gif)

## Quick Filter {#quick-filter}

### Custom Filter Fields

It supports editing **Quick Filter** to add new **Fields** in the explorer. Two configuration modes are supported: spatial filter items and personal filter items.

Preset fields in shortcut filtering is available. The newly added fields default to the field type in field management. If there is no field type in field management, it defaults to text format.

=== "Spatial Filter Items"

    It is configured by the <u>Administrator and Owner</u>. Click :fontawesome-solid-gear: to configure the space-level filter items. You can add and delete fields, edit field aliases and adjust field order.

    <font color=coral>**Note:**</font> All members of the workspace can view space-level filter items, but permissions of standard members and below cannot edit, delete and move locations.

    ![](../img/5.explorer_search_7.png)

=== "Individual Filter Items"

    <u>All members</u> can configure shortcut filter items based on local browser. Click :material-pencil: to configure personal filter items. You can add and delete fields, edit field aliases and adjust field order.

    <font color=coral>**Note:**</font> Individual-level filters are available only to the current individual, not to other members of the workspace.

    ![](../img/5.explorer_search.png)

### Operating Instructions

=== "Select All"

    By default, the label values of all shortcut filter items are checked, indicating that no filtering has been performed.

=== "Empty Filter"

    Click the **Clear Filter** button in the upper right corner of the shortcut filter item to cancel the value filter of this label, that is, restore all selection.

=== "Cancel/Check"

    Click the check box in front of the shortcut filter item label value to **Cancel** or **Check** the value. By default, uncheck the previous check box indicates that the value is reversed, and continue to uncheck other check boxes indicates reversed multiple selection.

    ![](../img/12.quick_filter_1.gif)

=== "Check this only/Uncheck"

    **Check this only** indicates that this value is selected positively, and continue to check other values indicates multiple positive selection; When a value is positively selected, click **Unselect** on the row where the value is located again to cancel all filtering.

    ![](../img/12.quick_filter_1.1.gif)

=== "Positive Election & Anti-Election"

    If a label has both positive and negative selection states, it is inoperable in shortcut filtering.

    ![](../img/12.quick_filter_2.png)

=== "Quick Filter Item Search"

    When the shortcut filter item has more than 10 labeled fields, fuzzy search according to **Field Name** or **Display Name** is supported.

    ![](../img/12.quick_filter.png)

=== "Field Value Search"

    If the shortcut filter item exceeds 10 field attribute values, it supports real-time search of input text and supports clicking fuzzy matching and reverse fuzzy matching for filtering.

    ![](../img/12.quick_filter_3.png)

=== "Field Value Quantity Statistics Ranking {#top5}"

    Click :fontawesome-solid-gear: and select **Query TOP 5 Value** to view the statistical quantity percentage of the top five field attribute values of the current filter item. In the ranking list, it is supported to view the quantity statistics and to click the buttons of **Filter** and **Reverse Filter** to carry out data filtering query on the field attribute values of the current ranking in the form of `key: value`.

    ![](../img/8.explorer_1.png)

=== "Add/Remove Display Columns"

    Click :fontawesome-solid-gear: to **Add/Remove Columns**. The custom added personal filter item fields support editing display names and deleting fields.

    ![](../img/12.quick_filter_4.gif)

=== "Duration"

    If the shortcut filter in the explorer includes the Duration field, you can manually adjust the maximum/minimum values for query analysis. 
    
    <font color=coral>**Note:**</font>

    - The **Duration** of the shortcut filter defaults to the minimum value of the progress bar, and the maximum value is the minimum and maximum duration in the link data list;
    - Dragging the progress bar to adjust the maximum/minimum value, and the values in the input box change synchronously;
    - Manual input of maximum/minimum value is supported, press enter key or click outside the input box for filtering search;
    - When the input is not standard, the input box turns red, and no search is carried out. The correct format is pure "number" or "number + ns/μ s/ms/s/min";
    - If no unit is entered for search, the default is to directly fill in "s" after the entered number and then filter the search;
    - If you enter units manually, search directly.

    ![](../img/9.apm_explorer_6.png)

## Filtering History {#filter-history}

Filtering History, where you can view filter and searching history, can be applied to different explorers in the current workspace.

- Open filtering history: you can quickly open filter history by clicking the expansion icon in the lower-right corner of the explorer, or directly through the shortcut key (`Mac OS: shift + cmd + k/Windows: shift + ctrl + k`);
- Close filtering history: click the close button `x` or use the `esc` button to close the filter history.

<font color=coral>**Note:**</font> Filtering history only supports saving the current user's search criteria in the local browser.

![](../img/1.filter_history_2.png)

### Operating Instructions

Guance saves up to 100 search criteria in the explorer filter history. You can switch keys (↑ ↓) up and down on the keyboard to switch and select search criteria, and then click the keyboard `enter` to add to the filter.

- Fixed to Filter: The mouse is placed on the screening history, and the top search criteria can be set through the **Fixed to Filter** button on the right;
- Add to Filter: Click search criteria to add to the explorer for filtering, which supports multiple choices;
- Cancel Filter: After adding to the filter, click **Search Criteria** again to cancel the filter.

![](../img/1.filter_history_1.png)

- Apply filter history in different explorers: Filter history is saved in the log explorer and can be used directly in other explorers.

<!--
![](../img/filter_history.gif)
-->


## Time Control {#time}

Guance supports controlling the data display range of the current explorer through time control. You can manually enter the time range, quickly select the built-in time range of the current explorer, or set the time range by customization.

### Enter Time Range Manually

The time control supports interval display by default, and you can click the time control to view the format of manually input time range, including **Dynamic Time** and **Static Time**. After input, **Enter** or **Click any blank area** can filter and view the corresponding data according to the input time range.

![](../img/12.time_1.png)

=== "Dynamic Time"

    The dynamic time range supports four units: seconds, minutes, hours and days, such as 1s, 1m, 1h, 1d, etc. Input 30s as shown in the following figure.

    Enter, then return the data in the last 20 minutes, that is, the explorer displays the last 20 minutes.

    <img src="../../img/7.timestamp_6.1.png" width="70%" >

=== "Static Time"

    The standard time format supports the following writing methods. The time format is accurate to the second level. Spaces are allowed before and after the spacers `~`, `-`, `,`, and commas must be English commas.

    -  `2022/08/04 09:30:00~2022/08/04 10:00:00` 
    -  `2022/08/04 09:30:00-2022/08/04 10:00:00` 
    -  `2022/08/04 09:30:00,2022/08/04 10:00:00` 

    Click on the time control, you can directly input and modify the standard time format and display the corresponding data according to the current time range after **Enter**.

    <img src="../../img/7.timestamp_7.png" width="70%" >

=== "Timestamp Static Time"

    The timestamp range supports the following writing methods. The timestamp supports millisecond input. Spaces are allowed before and after the spacers `~`, `-`, `,`, and commas must be English commas.

    - `1659576600000~1659578400000` 
    - `1659576600000-1659578400000` 
    - `1659576600000,1659578400000` 

    Click the time control and enter the start and end timestamps as shown in the following figure.

    **Enter** and return to the time range. Filter out the corresponding data according to this time range and display it in the explorer.

    ![](../img/7.timestamp_5.1.gif)

=== "Notes"

    - If the format does not conform to the input requirements, the correct time range cannot be returned, such as the start time is later than the end time, and the format input does not conform to `hours:minutes:seconds`.

    <img src="../../img/7.timestamp_8.png" width="80%" >

    - The prompt box of the time control and the text input box are linked in real time. If the input time range <u>exceeds 4 digits</u> (including time interval, absolute time and timestamp), the prompt box of the time control displays `-`.

    <img src="../../img/7.timestamp_9.png" width="80%" >

    Display the time range after Enter.

    <img src="../../img/7.timestamp_10.png" width="80%" >

### Quick Filter Time Range

You can click **More** in the time control to quickly select the corresponding time range for data viewing. A variety of shortcut filter time ranges are preset in the time control, including "last 15 minutes, last 1 hour, last 1 day, etc." in the drop-down list and "30s, 45m, 3d, etc." in the dynamic time.

The dynamic time can be linked with the content of the input box in real time, and the data content of the corresponding time range can be viewed by clicking. 


![](../img/0706.timestamp.gif)

### Custom Time Range

In addition to the preset time range, you can click **Custom Time** in the time control to select a time range, including date and specific time, and click **Apply** to filter data according to the customized time range.

???+ attention 

    - The start and end times of the custom time range should be entered in the format `Hours:Minutes:Seconds`, such as `15:01:09`.
    - The start time of the custom time range cannot be later than the end time.
    - Query records of custom time range can be viewed in **Custom Time Query History**, and up to 20 recent historical absolute time records can be viewed. Click any historical record to quickly filter and view the corresponding data content.

![](../img/12.time_4.png)

### Time Range of URL {#url}

In addition to the time range selection provided by the time control, Guance also supports directly modifying the time range of the `time` parameter of the current workspace explorer in the URL of the browser for data query. Four units of seconds, minutes, hours and days are supported, such as time=30s, time=20m, time=6h, time=2d, etc. 

As shown in the following figure, modify `time=2h` in the browser, and the explorer displays the data of the last 2 hours.

???+ attention 

    - Each unit can only be used independently, not in combination.
    - When selected or entered in the browser for a time range greater than or equal to 1d, the explorer automatically stops playing mode.

![](../img/4.url_1.png)

### Lock Time Range {#fixed}

Guance supports in time control by clicking ![](../img/12.time_fix_2.png) to lock the icon and set a fixed query time range, and all Explorers/Dashboards default to the current time range.

As shown in the following figure, if the lock time is "last 45 minutes", all Explorers/Dashboards will query and display the data of "last 45 minutes" according to the current lock time.

![](../img/12.time_fix_1.png)

### Set Time Zone {#zone}

Guance supports setting the current display time zone in the time control, thereby switching to the corresponding workspace time zone to view the data.

![](../img/12.time_zone_1.png)

Enter **time control > Change t9ijme settings**:

- The default display is **Browser Time**, that is, the time detected by the local browser;       
- After Owner or Administrator sets **[Workspace Time Zone](../../management/index.md#workspace)**, members can select the configured workspace time zone.

<img src="../../img/zone.png" width="70%" >

???+ attention

    - Only Owner and Administrator of the current workspace have **Workspace Time Zone** configuration permissions;

    - After setting the new time zone, all workspaces where your current account is located will be displayed according to the set time zone.

You can also modify it in **[Account Management](../../management/index.md#zone)**.

### Explorer Auto Refresh

In Guance workspace, click **Account** to turn on/off **Explorer Auto Refresh**.

- Open: The data of the explorer is automatically refreshed according to the default data refresh time of 30 seconds of the time control. For example, if you select the last 15 minutes, refresh once according to 30 seconds to display the data of the last 15 minutes.
- Close: When the time control of the explorer enters, turn off the automatic refresh for 30 seconds. If you select the last 15 minutes, the content data of the absolute time of the 15 minutes will be displayed without automatic refresh. You can click the **Play** button to refresh and view the data of the last 15 minutes.

<font color=coral>**Note:**</font> Explorer automatic refresh only works for local browsers.

<img src="../../img/7.timestamp_1.png" width="70%" >

Click the **Pause** button to exit the real-time data refresh mode and lock the current time range to absolute time.

<!--
For example, if the time range is selected as "last 15 minutes", when the **Pause** button is clicked, the overall time range of the explorer is adjusted forward to 15 minutes.

![](../img/7.timestamp_7.png)
-->

## Display Column {#columns}

Explorers support:

-  selecting the number of rows to display to expand the view log Message data;  
-  clicking **Column** to add, edit, delete and drag display columns;  
-  selecting and adding display columns by switching keys up and down on the keyboard;  
-  searching keywords in **Column**;  
-  customizing display columns as preset fields in **Column**. After cutting fields and reporting data through Pipeline, the reported data can be directly displayed.

![](../img/7.log_column_4.png)

### Add Column

In the explorer display column, matching search for input fields is supported and the first searched field is selected by default. You can select and addi display columns by switching keys up and down (↑ ↓) on the keyboard.


If the input field does not exist, it prompts **Create and add** display column, which will be used as default field after creation, and the reported data can be directly displayed after cutting the field and reporting the data through Pipeline.

![](../img/0706.column.gif)


### Operating Instructions

In the explorer list, when the mouse is placed on the display column, you can click the **Settings** button of the display column, which supports the following operations:

| Operations      | Description                          |
| ----------- | ------------------------------------ |
| Ascending/descending      | Display the value of the current field in ascending or descending order.                          |
| Move column to left/right      | Move column to left or right. If moving is not supported, this operation will not be displayed.                          |
| Add columns to the left/right      | Add a new display column to the left or right based on the current column. Search is supported. If adding is not supported, this operation will not be displayed.                          |
| Replace Column      | Replace the current displayed column at the current position. Search is supported. If replacement column is not supported, this operation will not be displayed.                          |
| Add to shortcut filter      | If there is no current display column in the shortcut filter on the left, click to add the display column as a new shortcut filter item, and click :fontawesome-solid-gear: of the shortcut filter item to remove the display column.                          |
| Add to Grouping      | Display the contents of the grouping explorer based on the currently displayed column as a grouping field.                          |
| Remove Column      | Remove the currently displayed column.                          |


![](../img/8.showlist_3.png)

If the contents of the displayed column are not completely displayed, it is supported to hover on the dividing line on the right side of the displayed column and double-click to expand the contents, as shown in the `source` column in the following figure.

![](../img/8.showlist_4.gif)

## Save Snapshot {#snapshot}

In Explorers, You can perform a series of operations as mentioned above and **Save Snapshot** of the data content displayed by the current explorer. 

> For more details on snapshot usage, refer to the documentation [Snapshot](../function-details/snapshot.md).

![](../img/snapshot_1.png)



## Export {#export}

In the explorer, you can search and filter the currently displayed data, select the time range, add viewing columns and other operations, and then click the **Settings** button on the right side of the explorer to export the data content currently displayed in the explorer.

 It supports **Export to CSV File**, **Export to Dashboard** and **Export to Notes** for data viewing and analysis.

![](../img/3.explorer_export_1.png)



## Chart {#chart}

- Chart Export: In the explorer chart, you can click :material-tray-arrow-up: to export or copy the chart to the dashboard and notes;
- Chart Time Interval: In the explorer chart, you can select the chart time interval to view the corresponding chart data.

![](../img/4.explorer_chart_1.png)



