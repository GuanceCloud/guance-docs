# Field Management
---

Guance supports unified management of field data in current workspace, including **system fields** and **custom fields**. You can view field descriptions in scene chart query, monitor detection metrics, simple query mode of DQL query and metric analysis.

![](img/3.field_1.png)

## System Fields

System fields are the default fields officially provided by Guance. You can view all system fields in the workspace **Management > Field Management**, including field names, field types and detailed descriptions of fields.

**Note: System fields do not support modification and deletion.**


## Custom Fields

Custom fields are added by users according to collected data, including collected metrics, labels, fields cut by Pipeline and so on.

### Create Fields

You can create a new field by entering the field name, field type and field description in the pop-up dialog box in the workspace **Management > Field Management**, clicking **Create**. The field types include the following:

- Text: Fields can be of type string, keyword, txt, displayed in text format.
- Numeric: Fields can be of type int, boolean, float, long, displayed in numeric format.
- Time: When the field value is a timestamp, it is displayed as a date value.
- Percentage: Multiply the field value by 100 and display it as a percentage.

**Note: In the explorer display column, the field value will be converted according to the field type. For example, when the field value is "0.8" and the field type is selected as Percentage, the field value displayed in the explorer display column is "80%".**

![](img/3.field_2.png)

### Edit Fields

After the field is created, you can click :material-square-edit-outline: small icon in the workspace **Management > Field Management**, and update the field name, field type and field description in the pop-up dialog box.

![](img/3.field_3.png)



### Delete Fields

After the field is created, you can click the :material-delete: small icon in the workspace **Management > Field Management**, and confirm to delete the field in the pop-up dialog box.


![](img/3.field_4.png)

### Search Fields

In the workspace **Management > Field Management**, you can use the search box in the upper right corner to conduct a fuzzy search for field names.

![](img/3.field_5.png)

### Replace System Fields

When creating a new field, if it conflicts with the system field, you can choose to overwrite and replace the system field, such as the "host" field.

![](img/3.field_6.png)

System fields are overwritten and replaced to become custom fields, which you can edit and delete. As you can see in the following figure, "host" can be edited and deleted after overwriting.

![](img/3.field_7.png)

After the override replacement system field is deleted, redisplay the system field. For example, after deleting the custom field "host" in the above figure, you can see that the "host" field is a system field, and editing and deleting are no longer supported.

![](img/3.field_8.png)

## Field Description Use Case

After the data is reported to Guance workspace, you can explain the reported field data in **Field Management** first, so that other team members can quickly understand the meaning of the field and apply the field when using the field for data query and analysis.

### View Field Descriptions in the Scene Chart Query

In Workspace **Scene > Dashboard**, select a chart, and in Query, you can view the field description. Such as "host".

![](img/3.field_9.png)

### View Field Descriptions in Monitor

In the workspace **Monitors > Monitor**, select a monitor, and in **Detect Metrics**, you can view the field description. Such as "host".

![](img/3.field_9.1.png)



### View Field Descriptions in a DQL Query

In the workspace **Shortcults > DQL Query**, switch to **Simple Query** to view the field description. Such as "host".

![](img/3.field_9.2.png)



### View Field Descriptions in Metric Analysis

In the workspace **Metrics > Metric Analysis**, you can view the field description in a simple query. Such as "host".

![](img/3.field_9.3.png)
