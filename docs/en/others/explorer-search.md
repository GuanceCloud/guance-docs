# Explorer Search
---

During the process of data retrieval in various Explorers, we can use multiple search and filtering methods, such as fuzzy search, associated search, forward filtering, reverse filtering, etc. Below, we will provide detailed explanations.

## Search Instructions

### Keyword Search

Explorers support entering keywords in the search bar for retrieval. The search results will highlight the entered keywords as shown in the figure below.

![](img/13.search_1.png)

### Wildcard Search

Explorers support entering wildcards for fuzzy matching searches, such as entering `global*` in the log search bar, which returns log data containing "global". The characters after global can be any number of characters, as shown in the figure.

![](img/8.search_2.png)

### Associated Search

Explorers support related searches using AND/OR/NOT logic, which can be combined with wildcard searches.

| Logical Relationship | Description                                                         |
| -------- | ------------------------------------------------------------ |
| a AND b  | Returns results that include both a and b. The more keywords you enter, the more precise the data match becomes. `AND` can be replaced by `space` or `,`, i.e., `a,b` = `a b` = `a AND b`. |
| a OR b   | Returns results that contain either a or b.                     |
| NOT c    | Returns results that do not contain keyword c.                   |


### JSON Search

> Prerequisite: Workspace must have been created after `June 23, 2022`.

Currently, the JSON search feature is only available for the Log Explorer, with instructions as follows:

- By default, it performs an exact search on the content of `message`, requiring `message` to be in JSON format. Other formats of log content are not supported.
- JSON search format is: `@key:value`, if multi-level JSON is used, it can be connected with `"."`, i.e., `@key1.key2:value`, as shown in the figure.


### Field Filtering

In Explorers, you can filter values based on `labels/attributes` using four filtering methods: forward filtering, reverse filtering, wildcard matching, and inverse wildcard matching.

- You can filter by clicking the dropdown or manually entering label content in the specified format and pressing Enter.
- Forward selection, reverse selection, wildcard matching, and inverse wildcard matching are placed under four different dropdown labels, each having an `and` relationship between them.
- If a label has both forward and reverse selection states simultaneously, the label will be grayed out and uneditable in quick filters.

![](img/5.explorer_search_1.png)

#### Forward Filtering

Perform forward filtering searches using the form `key:value`, for example: searching for `status:error` in the Log Explorer returns all logs where the status is error.

![](img/positive_selection.gif)


#### Reverse Filtering

Perform reverse filtering searches using the form `-key:value`. For example: searching for `-status:info` in the Log Explorer returns all logs where the status **is not equal** to info.

![](img/reverse_selection.gif)

*Manually inputting label content for reverse selection*
![](img/reverse_selection2.gif)


#### Wildcard Matching (Wildcard Matching)

Perform wildcard matching searches using the form `*key:value`, allowing wildcard entry in value for matching. For example: searching for `*host:prd-*` in the Log Explorer returns all logs where the hostname starts with `prd-`.

![](img/wildcard_matching.gif)

*Manually inputting label content for wildcard matching*
![](img/wildcard_matching2.gif)

#### Inverse Wildcard Matching (Not Wildcard Matching)

Perform inverse wildcard matching searches using the form `-*key:value`, allowing wildcard entry in value for matching. For example: searching for `-*service:k8s*` in the Log Explorer returns all logs where the service does not start with `k8s`. Supports manual input of label content for inverse wildcard matching.

![](img/5.explorer_search_2.png)

#### Editing Filters

Selected labels support the following two editing methods:

##### Single-click Label

Single-clicking the label allows modification of the filtering condition in the popup dialog box. (Note: label tags do not support pop-up editing.)

- Operation Method:  

  - `Equal`: i.e., forward filtering, supports selecting label values from the dropdown or manually entering label values and confirming with Enter;
  - `Not Equal`: i.e., reverse filtering, supports selecting label values from the dropdown or manually entering label values and confirming with Enter;
  - `Wildcard Matching`: i.e., Wildcard Matching, supports entering wildcards for fuzzy matching searches, multiple values are separated by “,”

![](img/edit_filter.png)

##### Double-click Label

Double-clicking the label allows manual editing of a single filtering condition without modifying multiple ones at the same time, as shown below.

**[key:value] Single-select Label**
![](img/double_click1.png)

**[key:xx items] Multi-select Label**
![](img/double_click2.png)



## Quick Filter Instructions {#quick-filter}

By default, all label values are selected, indicating no filtering has been applied.

1. Clicking the checkbox before the label value indicates "cancelling" or "selecting" this value;
2. Clicking the "Clear Filters" button in the top-right corner cancels the value filtering for this label;
3. By default, unchecking the preceding checkbox indicates reverse selection of this value, continuing to uncheck other checkboxes indicates reverse multi-selection;
4. Clicking the row where the label value is located indicates forward single-selection of this value "only select this item", continuing to check the checkboxes of other values indicates forward multi-selection;
   ![](img/5.explorer_search_3.png)
5. When a forward single-selection of a certain value has been made, clicking the row where this value is located again "cancels the selection", canceling all filters;
   ![](img/5.explorer_search_4.png)

6. If a label has both forward and reverse selection states simultaneously, this label is grayed out and uneditable in quick filters.

![](img/5.explorer_search_5.png)

7. If quick filters exceed 10 attribute values, text input is supported for real-time search, supporting clicks on wildcard matching and inverse wildcard matching for filtering.

   ![](img/5.explorer_search_6.png)



### Custom Filter Fields

In Explorers, you can edit "Quick Filters" to add new "Filter Fields". Two configuration methods are supported: workspace-level filter items and personal-level filter items.

#### Workspace-Level Filter Items

Configured by administrators/owners, click the "Settings" button next to the quick filter to configure workspace-level filter items, supporting adding fields, editing field aliases, adjusting field order, deleting fields.

Note: Workspace-level filter items can be viewed by all members of the workspace, but regular members and standard members do not support editing, deleting, or moving positions.



#### Personal-Level Filter Items

All members can configure local browser-based quick filters, click the "Edit" button to the right of the quick filter to configure personal-level filter items, supporting adding fields, editing field aliases, adjusting field order, deleting fields.

Note: Personal-level filter items are visible only to the current individual, other workspace members cannot view them.

![](img/5.explorer_search_8.png)



## Time Component Instructions

<<< custom_key.brand_name >>> supports controlling the data display range of the current Explorer through the time component. Users can quickly select built-in time ranges for the current Explorer or customize the time range via "start time" and "end time".

**Time Range**

The "Quick Select" presets multiple time ranges, including relative times (yesterday, last week, last month, etc.) and nearby times (last 15 minutes, last hour, last day, etc.).

**Data Refresh Time**

<<< custom_key.brand_name >>>'s data refresh time for the time component defaults to 30 seconds.

![](img/4.url_3.png)

Click the "Pause" button to exit the real-time data refresh mode, locking the current time range to absolute time.

> For example: If the time range is set to "last 15 minutes," then after clicking the "Pause" button, the Explorer's time range shifts back 15 minutes.

![](img/4.url_4.png)

### URL Time Range {#url}

Besides the time range provided by the time control, <<< custom_key.brand_name >>> also supports directly modifying the `time` parameter in the browser's URL to query data for the current workspace Explorer, supporting 4 units: seconds, minutes, hours, and days, such as time=30s, time=20m, time=6h, time=2d, as shown in the figure below where the browser modifies `time=2h`, displaying data from the last 2 hours.

Note:

- Each unit can only be used independently, combinations are not allowed.
- When the selected or entered time range in the browser is greater than or equal to 1d, the Explorer automatically stops playback mode.

![](img/4.url_1.png)