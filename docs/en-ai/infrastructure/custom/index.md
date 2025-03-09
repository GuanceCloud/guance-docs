# Resource Catalog
---

In addition to hosts, containers, and processes, you can create custom resources by combining properties, associated views, JSON text configurations, and using the DataKit API and DataFlux Func to report any data to <<< custom_key.brand_name >>>, including cloud vendor cloud resource data, various business data of enterprises, and other arbitrary data that needs monitoring. Ultimately, this data is managed and analyzed in a unified visual manner through the custom resource Explorer in the front-end console.

By creating viewer templates that conform to the characteristics of different resource classes, once the data is connected to the console, it will prioritize applying the [created templates](#start). You can use these viewer templates to view and analyze Resource Catalog data. If no match is found, the official template library's templates will be applied.

**Note**:

1. Whether or not a resource has a viewer template **does not affect** the reporting and reception of data;
2. Templates support configuring "mandatory attributes," meaning the data must include these fields for it to be received, which can be used for data filtering and interception.

## Data Reporting

**Prerequisite**: Install DataKit and DataFlux Func.

After adding resource catalog classifications, you can proceed with custom data reporting. Report data from DataFlux Func to DataKit, which ultimately reports the data to the <<< custom_key.brand_name >>> workspace.

> For detailed steps, refer to [Resource Catalog Data Reporting](data-reporting.md).

**Note**:

1. Custom fields in **mandatory attributes** are required fields when reporting data. If the reported data lacks these required fields, it will not be reported to the <<< custom_key.brand_name >>> workspace;
2. If the data type of the reported data does not match the defined field data type, it will not be reported to the <<< custom_key.brand_name >>> workspace. For example, if the field type is defined as string in DataFlux Func but the data type reported is integer, this data will not be reported to the <<< custom_key.brand_name >>> workspace;
3. Resource catalogs offline for 48 hours will be cleared.

## Create a Resource Viewer {#create}

You can create a viewer in the following ways:

:material-numeric-1-circle: Custom Creation: Click to directly enter the creation page.

:material-numeric-2-circle: Import Viewer Template: Import a template and then edit it.

### Start Configuration {#start}

#### Default Configuration

<img src="../img/default-config.png" width="70%" >

1. Choose whether to group resources as needed;
2. Define the resource class name for resource catalog data reporting;
3. Mandatory Attributes: Fields that must be included in the data; the `name` field of the object is added by default. If the reported data does not contain the fields you set, it will not be reported to <<< custom_key.brand_name >>>, thus filtering out non-conforming data;
4. Enter an alias for the resource class, which will be displayed preferentially in the list after configuration;
5. Viewer Display Configuration:
    - Default Columns: The headers displayed by default in the viewer table;
    - Default Quick Filters: The filter fields displayed by default in the quick filters on the left side of the viewer;
    - Detail Page Associated Views: Define the display name of the view, select the view, and fill in the associated fields as needed to bind built-in views or pages;
    - Color Fill Fields: A list of fields used for color filling in hexagonal map mode; if not configured, all numeric fields are listed by default;
    - Group Analysis Fields: A list of fields that can be selected for group analysis in hexagonal map mode; if not configured, all string fields are listed by default;
6. Click Confirm.

**Note**:

- Built-in views include all views; if there are duplicates, user views take precedence over system views;
- Built-in pages include viewer lists (such as logs, traces, containers), network topology, and other page templates.

#### JSON Configuration

<img src="../img/json-config.png" width="70%" >

When switching from default configuration to JSON configuration, choose:

- Yes: Automatically carry over the current content to JSON configuration;
- No: Only basic configuration is provided when entering JSON mode.

1. Choose whether to group resources as needed;
2. Add mandatory attributes;
3. Modify JSON configuration as needed;
4. Click Confirm.

## Resource Classes

<img src="../img/11.custom_2.png" width="60%" >

In the resource class list on the left side of the page, you can perform the following operations:

- In the search bar, input the resource name for quick location;
- Click the :material-dots-vertical: button:
    - Modify or export existing object classes;
    - [Delete](#delete) the viewer template;
    - Add the resource class to a secondary menu for easier viewing.
- Click the expand/collapse button to hide the resource class to meet display preferences.
- Add Groups: Categorize resource viewers. After adding, click the button on the right side of a single resource to move the current resource to the target group.
    - Click the button on the right side of the group to modify the group name;
    - Delete groups and choose whether to "only delete the group" or "synchronously delete all viewer templates under the group."

**Note**: Adding fields does not change existing object data; newly reported data must include the added fields.

### Delete {#delete}

Deleting a viewer template here does not delete the data. If data continues to be reported, it will automatically apply the default viewer template.

If you want to completely delete the data, go to **Manage > Delete Resource Catalog** to perform the deletion operation.

- Specific Resource Catalog Classifications: Only delete data under the selected object classification without deleting indexes;
- All Resource Catalogs: Delete all resource catalog data and indexes.

**Note**:

1. Only Owners and Administrators can perform deletion operations;
2. Once all resource catalogs are deleted, all data and indexes reported to custom infrastructure will be deleted and cannot be recovered. All settings for resource catalog classification data need to be re-reported, with a limit of 5 deletions per day.

### Cross-Workspace Query {#cross_workspace}

Select all workspaces associated with your account to query resource list data across spaces.

<img src="../img/custom_list.png" width="60%" >

## Resource Catalog Viewer

View and analyze resource catalogs in list or hexagonal map form.

![](../img/explorer-mode.gif)

### Quick Filter {#filter}

You can add filter items to the resource catalog.

**Note**: Space-level filter items can only be added by the current workspace Owner and Administrator.

1. Click the **Add Space-Level Filter Item** button;
2. Search or directly add fields in the dropdown box;
3. Click Confirm.

<img src="../img/filter.png" width="80%" >

> For more details, refer to [Viewer Quick Filters](../../getting-started/function-details/explorer-search.md#quick-filter).

### Detail Page

After resource catalog data is reported, clicking the name in the right-side viewer resource catalog list will slide out a detail page showing detailed information about the object, including object name, extended attributes, and associated views.

![](../img/11.custom_4.png)

#### Basic Attributes

View all attribute fields attached to the resource catalog data.

#### Associated Views

Set up binding or removal of built-in views (system views, user views) to the infrastructure resource catalog detail page.

**Note**: Before binding built-in views, ensure that the view variables in the [bound built-in view](../../scene/built-in-view/bind-view.md) contain fields related to the resource catalog, such as `host`.

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **The Power of Viewers**</font>](../../billing-center/workspace-management.md#workspace-lock)

</div>

</font>