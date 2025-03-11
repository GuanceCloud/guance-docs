# Custom
---

Besides hosts, containers and processes, Guance supports customizing new infrastructure types and reporting relevant data to the Guance console.

Guance supports you in classifying custom infrastructure types, helping you track and store custom data of the same type.

## Add

In the Guance workspace, you can create new custom and customize its names and fields through **Infrastructure > Custom > Add Custom**.

<img src="../img/1.custom_1.png" width="70%" >

1. Custom: This is the name when conducting custom data reporting. When reporting data, you need to ensure that the name matches the naming used during data reporting.

2. Alias: This is the name under which the current custom is displayed in the list of custom infrastructure types.

3. Required Attributes: The fields that must be included in the data; the `name` field of the custom is added by default. If the reported data does not include the fields you have set, it will not be reported to Guance, thus filtering out non-standard data.


## Data Report

After adding custom, you can proceed with custom data reporting. Before that, you need to install and connect DataKit and DataFlux Func, and then report data to DataKit through DataFlux Func. Finally, the data will be reported to the Guance workspace through DataKit.

> See [Custom Data Report](data-reporting.md) for the specific operation process.

**Note:**

- Custom fields in the **Required Attributes** are required when reporting data. If any of the required fields are missing in the reported data, the data will not be uploaded to the Guance workspace.

- If the reported data type does not match the defined field data type, the data will not be uploaded to the Guance workspace. For example, if a field is defined as a character type in DataFlux Func, but the reported data type is an integer, the data will not be uploaded to the Guance workspace.

- Custom will be cleared after 48 hours of being offline.

## Modify 

In the category list on the page, you can click the :material-dots-vertical: button:
- **Settings** for existing categories, including changing the alias of existing categories and adding/removing fields;
- Add the current custom to the secondary menu for easy access.

<img src="../img/11.custom_2.png" width="70%" >

**Note:** After adding fields, the original data remains unchanged, and the data reported later must contain the newly added fields.

## Delete

Guance supports Owner and Administrator to delete the specified custom classification and all custom, enter **Management > Settings > Delete Custom Objects**, and select the method of deleting custom to delete the corresponding data.

- All custom: Delete all custom data and indexes.
- Specify custom classification: Only the data under the selected classification will be deleted, and the index will not be deleted.

**Note**: Once all custom are deleted, all data and indexes reported to infrastructure customization will be deleted and cannot be recovered. All set custom classification data need to be re-reported, and all custom are limited to be deleted 5 times a day.

![](../img/7.custom_cloud_3.png)

## Filter {#filter}

You can add filters for custom.

Click on **Add workspace-level filter** and the settings button to start adding.

**Note**: Workspace-level filters can only be added by the workspace Owner and Administrator.

<img src="../img/filter.png" width="60%" >

Click on the edit button to add personal-level filters. Adding them will not affect the explorer layout for other members of the workspace.

> See [Filter](../../getting-started/function-details/explorer-search.md#quick-filter).


## Details Page

After custom data is reported, click on the name in the custom list to bring up the details page and view the detailed information, including the name, category, attributes, etc.

![](../img/11.custom_4.png)

### Information

By clicking on the tab `Host` on the custom details page, you can do the following:

- Add to Filter: add the tag to the Container List Explorer to view all Container data associated with the host.

- Copy: copy the contents of the label to the local clipboard. 

- View related logs/containers/processes/links/inspection: view all logs related to corresponding data.

<!-- 

![](../img/11.custom_5.png)
-->
### Customize Inner Views

Guance supports setting up binding or deleting inner views (user views) to the details page of custom infrastructure. After binding the inner views, the bound views can be viewed in the details of the custom.

**Note:** Before binding a inner view, you need to confirm whether the view variable in the bound inner view has a field related to the classification, such as `host`. See [Binding Inner Views](../../scene/inner-view/bind-view.md).

## More Readings

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Powerful Explorer**</font>](../billing/cost-center/workspace-management.md#lock)

</div>

<!--

## Data Query and Analysis

Enter the Custom explorer, and Guance supports you to query and analyze custom data by searching, filtering, sorting and grouping.

- The :octicons-search-24: search bar supports multiple search methods including keyword search, wildcard search, associated search, and JSON search. It also supports filtering values using `tags/attributes`, including positive filtering, negative filtering, fuzzy matching, reverse fuzzy matching, existence, and non-existence filtering methods.

- The left side :octicons-search-24: search categories can be matched with relevant categories using keywords.

> For more searching and filtering, see [Searching and Filtering for Explorer](../../getting-started/function-details/explorer-search.md#search).

![](../img/11.custom_10.png)

### Columns

On the custom host list page, you can customize the addition, editing, deletion and dragging of columns for display columns.

> See [Display Column Description](../../getting-started/necessary-for-beginners/explorer-search.md#columns).

![](../img/11.custom_6.png)

### Export

In the custom list, Guance enables you to export the data of the current object list as CSV files, dashboards or notes through :material-cog:.

![](../img/11.custom_7.png)

### Analysis Mode

Custom explorer analysis bar in infrastructure supports multi-dimensional analysis and statistics based on **1-3 tags** to reflect the distribution characteristics of data in different dimensions, and supports various data chart analysis methods, including ranking list, pie chart and rectangular tree chart. 

> See [Analysis Mode in Explorer](../getting-started/necessary-for-beginners/explorer-search.md#analysis).

![](../img/4.jichusheshi_4.png)
-->