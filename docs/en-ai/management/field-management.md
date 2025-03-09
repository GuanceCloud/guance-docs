# Field Management
---

<<< custom_key.brand_name >>> supports unified management of field data in the current workspace, including [official fields](#official) and [custom fields](#custom). You can view field descriptions in different [use cases](#case) in the <<< custom_key.brand_name >>> console to help quickly understand the meaning of fields for application.

![](img/3.field_1.png)

## Official Fields {#official}

Official fields are the default fields provided by <<< custom_key.brand_name >>>. You can view all official fields under **Management > Field Management**, including field names, field types, and detailed descriptions.

**Note**: Official fields cannot be modified or deleted.


## Custom Fields {#custom}

Custom fields are fields added by users based on collected data, including collected metrics, tags, fields split via Pipeline, etc.

### Create Field

You can go to **Management > Field Management** and click **Create Field**:

<img src="../img/field-1.png" width="60%" >

| Information      | Description                          |
| ----------- | ------------------------------------ |
| Field Name      | Required, must not exceed 128 characters; if a duplicate name exists, an error will occur.                      |
| Alias      | Required, descriptive name of the field.                         |
| Source      | Includes common fields, logs, base objects, resource catalog, events, APM, RUM, security check, network.                         |
| Type      | Includes int, float, boolean, string, long.                          |
| Unit      | Includes percentage, length, custom units, etc.<br/>:warning: After the field is created, all places where the field is applied will automatically display the unit, for example: monitors, explorers, charts, etc.                          |
| Description      | Further supplementary explanation and description of the current field.                          |


### List Operations

After creating fields, you can perform the following operations on custom fields:

<div class="grid" markdown>

=== "Settings"

    Click :octicons-gear-24: to set up display columns:

    <img src="../img/field-2.png" width="60%" >

=== "Edit"

    You can update the field name, field type, and field description for the current field.

=== "Delete"

    Click :fontawesome-regular-trash-can: to delete the current field.

=== "Search"

    In the search box, you can perform fuzzy searches for field names.

=== "Override"

    When creating a new field, if it conflicts with an official field, you can choose to override the official field. After overriding, the field becomes a custom field, which you can edit and delete.
    
    **Note**: If you delete this custom field, the originally overridden field will reappear as an official field and will no longer support editing or deletion.

</div>


## Use Cases {#case}

After data is reported to the <<< custom_key.brand_name >>> workspace, you can provide explanations for the reported field data in **Field Management** to help other team members quickly understand the meaning of the fields when using them for data queries and analysis.

=== "Use Case > Dashboard"

    In the workspace **Use Case > Dashboard**, select a chart, and in **Query**, you can view field descriptions.

    <img src="../img/3.field_9.png" width="70%" >

    **Note**: Units are not displayed when selecting `count` or `count_distinct` functions.

=== "Explorer"

    In the explorer, you can view fields and their corresponding information in **Explorer > Quick Filter, Add Display Columns**.

    <font size=3>*Quick Filter*</font>

    <img src="../img/quick-filter.png" width="60%" >

    <font size=3>*Add Display Columns*</font>

    <img src="../img/display.png" width="60%" >

    <font size=3>*Analysis Dimensions*</font>

    <img src="../img/dimension.png" width="70%" >

=== "Monitoring > Monitors"

    In the workspace **Monitoring > Monitors**, select a monitor, and in **Detection Metrics**, you can view field descriptions.

    ![](img/3.field_9.1.gif)

    **Note**: Units are not displayed if the detection metric selects the `count` or `count_distinct` function.

=== "Shortcut > Query Tool"

    In the workspace **Shortcut > Query Tool**, switch to **Simple Query** to view field descriptions.

    ![](img/3.field_9.2.png)

=== "Metrics > Metric Analysis"

    In the workspace **Metrics > Metric Analysis**, you can view field descriptions in simple queries.

    <img src="../img/3.field_9.3.png" width="70%" >