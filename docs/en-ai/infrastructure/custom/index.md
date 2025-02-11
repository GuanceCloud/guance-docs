# Resource Catalog
---

In addition to hosts, containers, and processes, you can create custom resources by combining attributes, associated views, JSON text configurations, and using the DataKit API and DataFlux Func to report any data to Guance. This includes cloud vendor resources, various business data from enterprises, and other arbitrary data that needs monitoring. Ultimately, this data is visualized and managed uniformly in the custom resource Explorer of the frontend console for association analysis.

By creating Explorer templates tailored to different resource classes, the data will apply the [created templates](#start) upon being ingested into the console. You can use these Explorer templates for viewing and analyzing Resource Catalog data. If no match is found, the official template library's templates will be applied.

**Note**:

1. Whether or not a resource has an Explorer template **does not affect** the reporting and reception of data;
2. Templates support configuring "mandatory properties"; data must contain these fields to be received, which can be used for data filtering and interception.

## Data Reporting

**Prerequisite**: Install DataKit and DataFlux Func.

After adding resource classification, you can proceed with custom data reporting. Report data to DataKit via DataFlux Func, and ultimately report data to the Guance workspace through DataKit.

> For detailed operation steps, refer to [Resource Catalog Data Reporting](data-reporting.md).

**Note**:

1. Custom fields in the **mandatory properties** are required when reporting data. If the reported data lacks these mandatory fields, it will not be reported to the Guance workspace;
2. If the data type of the reported data does not match the defined field data type, the data cannot be reported to the Guance workspace. For example, if the field type is defined as string in DataFlux Func but the data type reported is integer, the data will not be reported to the Guance workspace;
3. Resource catalogs that go offline for 48 hours will be cleared.

## Creating a Resource Viewer {#create}

You can create a viewer in the following ways:

:material-numeric-1-circle: Custom New: Click to directly enter the new page.

:material-numeric-2-circle: Import Viewer Template: Import a template and then edit it.

### Start Configuration {#start}

#### Default Configuration

<img src="../img/default-config.png" width="70%" >

1. Optionally choose whether to group resources;
2. Define the name of the resource class for data reporting;
3. Mandatory Properties: Fields that must be included in the data; by default, the `name` field of the object is added. If the reported data does not contain the fields you set, it will not be reported to Guance, thus filtering out non-conforming data;
4. Enter an alias for the resource class. After configuration, the list will prioritize displaying the alias;
5. Viewer display configuration:
    - Default columns: Headers displayed by default in the viewer table;
    - Default quick filters: Filtering fields displayed by default in the quick filter on the left side of the viewer;
    - Detail page linked view: Define the display name of the view, select the view, and optionally fill in the associated fields to bind built-in views or pages;
    - Color fill fields: List of fields used for color filling in cell mode. If not configured, all numeric fields will be listed by default;
    - Group analysis fields: List of fields available for grouping analysis in cell mode. If not configured, all string fields will be listed by default.
6. Click Confirm.

**Note**:

- Built-in views include all views; if there are duplicates, user views take precedence over system views;
- Built-in pages include viewer lists (such as logs, traces, containers), network topology, etc.

#### JSON Configuration

<img src="../img/json-config.png" width="70%" >

When switching from default configuration to JSON configuration, if you choose:

- Yes: Automatically populate the current content into JSON configuration;
- No: Only basic configuration will be provided after entering JSON mode.

1. Optionally choose whether to group resources;
2. Add mandatory properties;
3. Modify JSON configuration as needed;
4. Click Confirm.

## Resource Classification

<img src="../img/11.custom_2.png" width="60%" >

In the resource classification list on the left side of the page, you can perform the following operations:

- In the search bar, input the resource name for quick location;
- Click the :material-dots-vertical: button:
    - Modify or export existing object classifications;
    - [Delete](#delete) the viewer template;
    - Add the resource classification to a secondary menu for easier viewing.
- Click the collapse/expansion button to collapse the resource classification to meet display preferences.
- Add groups: Categorize resource viewers. After adding, click the button on the right side of individual resources to move the current resource to the target group.
    - Click the button on the right side of the group to modify the group name;
    - Delete the group and choose whether to "only delete the group" or "synchronously delete all viewer templates under the group".

**Note**: After adding fields, existing object data remains unchanged, but subsequently reported data must include the newly added fields.

### Deletion {#delete}

Deleting a viewer template here does not delete the data. If data continues to be reported, the default viewer template will be automatically applied.

To completely delete the data, go to **Management > Delete Resource Catalog** for deletion operations.

- Specific resource catalog classification: Only delete the data under the selected object classification without deleting the index;
- All resource catalogs: Delete all resource catalog data and indexes.

**Note**:

1. Only Owners and Administrators can perform deletion operations;
2. Once all resource catalogs are deleted, all data and indexes reported to custom infrastructure will be deleted and cannot be recovered. All resource catalog classification data settings need to be re-reported, with a limit of 5 deletions per day.

### Cross-Workspace Query {#cross_workspace}

Select all workspaces associated with the account to query resource list data across spaces.

<img src="../img/custom_list.png" width="60%" >

## Resource Catalog Viewer

View and analyze the resource catalog in list or cell mode.

![](../img/explorer-mode.gif)

### Quick Filters {#filter}

You can add filter items to the resource catalog.

**Note**: Space-level filter items can only be added by the current workspace Owner and Administrator.

1. Click the **Add Space-Level Filter Item** button;
2. Search or directly add fields in the dropdown box;
3. Click Confirm.

<img src="../img/filter.png" width="80%" >

> For more details, refer to [Viewer Quick Filters](../../getting-started/function-details/explorer-search.md#quick-filter).

### Detail Page

After resource catalog data is reported, clicking the name in the viewer resource catalog list on the right will slide out the detail page to view detailed information about the object, including object name, extended attributes, associated views, etc.

![](../img/11.custom_4.png)

#### Basic Attributes

View all attribute fields attached to the resource catalog data.

#### Associated Views

Set up binding or deletion of built-in views (system views, user views) to the infrastructure resource catalog detail page.

**Note**: Before binding built-in views, ensure that the [bound built-in view](../../scene/built-in-view/bind-view.md) contains fields related to the resource catalog, such as `host`.

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Power of the Viewer**</font>](../../billing-center/workspace-management.md#workspace-lock)

</div>

</font>