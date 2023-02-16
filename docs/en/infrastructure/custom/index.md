# Customization
---

## Introduction

In addition to hosts, containers and processes, the Guance allows you to customize new object classifications and report related object data to the Guance console. With Customization of Infrastructure, you can view all custom object data reported to the workspace.

## Custom Object Classification

Guance supports you to customize object classification, and helps you track and store custom report object data of the same class. By observing the cloud workbench, you can add object classifications, modify existing object classifications and delete existing object classifications.

### Add Object Classification

In the Guance workspace, you can create new object classes and customize object class names and object fields through Infrastructure-Customize-Add Object Classes.

- Object classification: Custom object classification name, that is, “object classification name”. When user-defined object data is reported. You need to make **“object classification name” consistent with the naming when reporting data** after reporting data.
- Alias: Add an alias to the current object class, that is, the name of the current object class displayed in the custom object list.
- Default properties: Add custom fields and field aliases required by the object, and add the `name` field of the object by default. During data submission, the user-defined field is required for data submission under this object category.

![](../img/1.custom_1.png)

### Custom Object Data Reporting

After adding custom object classification, you can report custom data. When reporting custom object data, it is necessary to install and connect DataKit and DataFlux Func first, then report data to DataKit through DataFlux Func, and finally report data to Guance workspace through DataKit. Please refer to the document [custom object data reporting](data-reporting.md) for the specific operation process.

**Note:**

1. The user-defined fields in "Default Attributes" are required fields when reporting data. If the required fields are missing, the reported data will not be reported to the Guance workspace.
1. If the reported data contains required fields and other fields, the non-required fields are displayed as data labels.
1. If the reported data type does not match the defined field data type, the data cannot be reported to the Guance workspace. For example, in DataFlux Func, the field type is defined as character type and the data type is integer type when reporting, so the data cannot be reported to the Guance workspace.

### Modify Object Classification

From "Infrastructure"-"Customize", in the object classification list on the left side of the page, you can click "More" to "set up" existing object classification, including changing existing object classification aliases and adding/deleting fields.

![](../img/11.custom_2.png)

**Note:** After adding fields, the original object data remains unchanged, and the data reported later must contain the newly added fields.

### Delete Object Classification

Guance supports **Owner** and **Administrator** to delete the specified custom object classification and all custom objects, enter "Management"-"Basic Settings", click "Delete Custom Objects", and select the method of deleting custom objects to delete the corresponding object data.

- Specify custom object classification: Only the data under the selected object classification will be deleted, and the index will not be deleted.
- All custom objects: Delete all custom object data and indexes.

Note: Once all custom objects are deleted, all data and indexes reported to infrastructure customization will be deleted and cannot be recovered. All set custom object classification data need to be re-reported, and all custom objects are limited to be deleted 5 times a day.

![](../img/7.custom_cloud_3.png)



## Custom Object Details Page

After the user-defined object data is reported, click the name in the user-defined object list to draw a detailed page to view the detailed information of the object, including object name, object classification, attribute label and so on.

![](../img/11.custom_4.png)

### Base Properties

By clicking on the underlying property tab "Host" on the custom object details page, you can do the following:

- "Add to Filter", that is, add the tag to the Container List Explorer to view all Container data associated with the host
- "Copy", that is, copy the contents of the label to the local clipboard 
- "View related logs", that is, view all logs related to this host
- "View dependent containers", that is, view all containers associated with this host
- "View related processes", that is, view all processes related to this host
- "View related links", that is, view all links related to this host
- "View related inspection", that is, view all inspection data related to this host

![](../img/11.custom_5.png)

### Customize Built-in Views

Guance supports "managing"-"built-in views" in the Guance workspace, setting bindings or deleting built-in views (system view, user view) to the infrastructure custom object details page. After binding the built-in view, you can view the bound built-in view in custom object Details.

**Note:** Before binding a built-in view, you need to confirm whether the view variable in the bound built-in view has a field related to the object classification, such as `host`. For more configuration details, see [binding built-in views](../../scene/built-in-view/bind-view.md).

## Data Query and Analysis

Enter the "Custom" explorer, and Guance supports you to query and analyze custom object data by searching, filtering, sorting and grouping.

- “ :octicons-search-24: Search” at the top of the page supports keyword search, wildcard search, association search, JSON search and other search methods, and it supports value screening through `tags/attributes`, including forward screening, reverse screening, fuzzy matching, reverse fuzzy matching, existence and nonexistence and other screening methods. For more searching and filtering, refer to the doc [searching and filtering for the explorer](../../getting-started/necessary-for-beginners/explorer-search.md#search).
- “ :octicons-search-24: search object classification” on the left side of the page supports matching related object classification by keywords.

![](../img/11.custom_10.png)

### Custom Display Columns

On the Custom Host Object List page, you can customize to add, edit, delete and drag display columns through Display Columns. When the mouse is placed on the display column of the explorer, click the "Settings" button to support ascending, descending, moving columns to the left, moving columns to the right, adding columns to the left, adding columns to the right, replacing columns, adding to shortcut filtering, adding to grouping, removing columns and other operations. For more custom display columns, refer to the documentation [display column description](../../getting-started/necessary-for-beginners/explorer-search.md#columns).

![](../img/11.custom_6.png)

### Data Export

In the custom object list, the guance enables you to export the data of the current object list as CSV files, dashboards, or notes through「:material-cog:settings」.

![](../img/11.custom_7.png)

### Analysis Mode

Custom explorer analysis bar in infrastructure supports multi-dimensional analysis and statistics based on **1-3 tags** to reflect the distribution characteristics of data in different dimensions, and supports various data chart analysis methods, including ranking list, pie chart and rectangular tree chart. For more details, please refer to the document [查看器的分析模式](../getting-started/necessary-for-beginners/explorer-search.md#analysis) 。

![](../img/4.jichusheshi_4.png)

#### 
