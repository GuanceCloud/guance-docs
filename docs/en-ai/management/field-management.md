# Field Management
---

Guance supports unified management of field data in the current workspace, including [official fields](#official) and [custom fields](#custom). You can view field descriptions in different [application scenarios](#case) on the Guance console to help quickly understand the meaning of fields for application.

![](img/3.field_1.png)

## Official Fields {#official}

Official fields are default fields provided by Guance. You can view all official fields under **Management > Field Management**, including field names, field types, and detailed descriptions.

**Note**: Official fields cannot be modified or deleted.


## Custom Fields {#custom}

Custom fields are fields added by users based on collected data, including collected metrics, labels, fields sliced via Pipeline, etc.

### Adding Fields

You can add new fields under **Management > Field Management** by clicking **Add Field**:

<img src="../img/field-1.png" width="60%" >

| Information | Description |
| ----------- | ------------------------------------ |
| Field Name  | Required, must not exceed 128 characters; if a duplicate name exists, an error will occur. |
| Alias       | Required, a descriptive name for the field. |
| Source      | Includes common fields, logs, base objects, resource catalogs, events, APM, RUM, security checks, network. |
| Type        | Includes int, float, boolean, string, long. |
| Unit        | Includes percentage, length, custom units, etc.<br/>:warning: After creating a field, the unit will automatically display wherever the field is applied, such as monitors, Explorers, charts, etc. |
| Description | Further supplementary explanation and description of the field. |

### List Operations

After creating fields, you can perform the following operations on custom fields:

<div class="grid" markdown>

=== "Settings"

    Click :octicons-gear-24: to configure display columns:

    <img src="../img/field-2.png" width="60%" >

=== "Edit"

    You can update the field name, field type, and field description for the current field.

=== "Delete"

    Click :fontawesome-regular-trash-can: to delete the current field.

=== "Search"

    In the search box, you can perform fuzzy searches for field names.

=== "Override"

    When creating a new field that conflicts with an official field, you can choose to override the official field. After overriding, the field becomes a custom field, which can be edited and deleted.

    **Note**: If you delete this custom field, the original overridden official field will reappear and will no longer support editing or deletion.

</div>


## Application Scenarios {#case}

After data is reported to the Guance workspace, you can first provide explanations for the reported field data under **Field Management** to facilitate quick understanding and application of the fields by other team members when they use them for data queries and analysis.

=== "Scenarios > Dashboard"

    In the workspace **Scenarios > Dashboard**, select a chart, and in the **Query** section, you can view field descriptions.

    <img src="../img/3.field_9.png" width="70%" >

    **Note**: Units are not displayed when selecting `count` or `count_distinct` functions.

=== "Explorer"

    In the Explorer, you can view fields and their corresponding information under **Explorer > Quick Filter, Add Display Columns**.

    <font size=3>*Quick Filter*</font>

    <img src="../img/quick-filter.png" width="60%" >

    <font size=3>*Add Display Column*</font>

    <img src="../img/display.png" width="60%" >

    <font size=3>*Analysis Dimensions*</font>

    <img src="../img/dimension.png" width="70%" >

=== "Monitoring > Monitors"

    In the workspace **Monitoring > Monitors**, select a monitor, and in the **Detection Metrics** section, you can view field descriptions.

    ![](img/3.field_9.1.gif)

    **Note**: Units are not displayed if the detection metric selects the `count` or `count_distinct` function.

=== "Shortcuts > Query Tool"

    In the workspace **Shortcuts > Query Tool**, switch to **Simple Query** to view field descriptions.

    ![](img/3.field_9.2.png)

=== "Metrics > Metric Analysis"

    In the workspace **Metrics > Metric Analysis**, you can view field descriptions in simple queries.

    <img src="../img/3.field_9.3.png" width="70%" >