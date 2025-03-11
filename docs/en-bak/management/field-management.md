# Fields
---

Guance supports unified management of field data in current workspace, including **system fields** and **custom fields**. You can view field descriptions in scene chart query, monitor detection metrics, simple query mode of DQL query and metric analysis.

![](img/3.field_1.png)

## System Fields {#official}

System fields are the default fields officially provided by Guance. You can view all system fields in the workspace **Management > Fields**, including field names, field types and detailed descriptions of fields.

**Note**: System fields cannot be edited and deleted.


## Custom Fields {#custom}

Custom fields are added by users according to collected data, including collected metrics, labels, fields cut by Pipeline and so on.

### Setup

Enter **Management > Fields > Create**:

<img src="../img/field-1.png" width="60%" >

- Field Name: Required, must not exceed 128 characters; an error will occur if there are duplicate names. 

- Alias: Required, descriptive name for the field. 

- Field Source: Contains common fields, Logs, Infrastructure, Custom, Events, APM, RUM, Security Check, and Network. 

- Type: Contain int, float, boolean, string, long. 

- Unit: Contain percentage, length, custom units, etc. 
 
    - After the field is created, the unit will be automatically displayed in all places where the field is applied, such as monitors, Explorers, and charts. 

- Description: Further explanation and information about the current field. 

### List Options

After creating a field, you can perform the following options on custom fields:

<div class="grid" markdown>

=== "Settings"


    Click :fontawesome-solid-gear: to configure the displayed columns:

    <img src="../img/field-2.png" width="60%" >


=== "Edit"


    You can update the field name, field type, and field description for the current field.

=== "Delete"


    Click :fontawesome-regular-trash-can: to delete the current field.

=== "Search"

    In the search box, you can perform a fuzzy search for field names.


=== "Override"


    When creating a new field, if there is a conflict with an official field, you can choose to override the official field. After overriding, the field will become a custom field, and you can edit and delete it.

    **Note**: If you delete this custom field, the originally overridden field will be displayed again as an official field. Editing and deleting will no longer be supported.


</div>

## Use Cases {#case}

After reporting data to the Guance workspace, you can first explain the field data reported in the **Fields** to facilitate other team members to quickly understand the meaning and apply the field when querying and analyzing data.

=== "Scenes > Dashboard"


    In the workspace **Scenes > Dashboard**, select a chart, and in the **Query** section, you can view the field explanation.

    <img src="../img/3.field_9.png" width="70%" >

    **Note**: When selecting `count` or `count_distinct` functions, the unit will not be displayed.


=== "Explorers"


    In the Explorer, you can view the fields and their corresponding field information in **Explorer > Quick Filters, Add Displayed Columns**.

    <font size=3>***Quick Filters***</font>

    <img src="../img/quick-filter.png" width="60%" >

    <font size=3>***Add Displayed Columns***</font>

    <img src="../img/display.png" width="60%" >

    <font size=3>***Analysis Dimensions***</font>

    <img src="../img/dimension.png" width="70%" >


=== "Monitors"


    In the workspace **Monitors**, select a monitor and in the **Detection Metrics** section, you can view the field explanation.

    ![](img/3.field_9.1.gif)

    **Note**: If the detection metric selects the `count` or `count_distinct` function, the unit will not be displayed.


=== "Quick Entry > Query Tool"


    In the workspace **Quick Entry > Query Tool**, switch to **Simple Query** to view the field explanation.

    ![](img/3.field_9.2.png)


=== "Metrics > Metrics Analysis"

    In the workspace **Metrics > Metrics Analysis**, you can view the field explanation in the simple query.

    <img src="../img/3.field_9.3.png" width="70%" >