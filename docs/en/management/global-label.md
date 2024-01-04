# Global Labels

Global labels refer to labels that can be directly called within the Guance workspace. Through global labels, data that meets the requirements can be classified, filtered, and linked globally.

**Note**: Only owners, administrators and custom roles with the permission can view this feature.

## Setup

<img src="../img/label.png" width="50%" >

1. Name: Required; the name must be unique and cannot be duplicated; it can be any text format.  
2. Description: Optional; limited to 100 characters.  
3. Color: The first color block is the default color, and you can customize your selection.  
4. Continue to creat the next one: You can continue creating labels, and the popup window will not close after clicking **Confirm**.  

**Note**: If you select this button, it will remain selected throughout the label creation process. The status will only be canceled if you manually uncheck it or close the popup window.

## Label List

The created labels can be viewed in the **Management > Global Labels** list page. You can also perform the following operations on the list page:

- Edit: You can update the name and description of existing labels.  
- Delete: Deletes the current label.  
- Batch Operations: Can delete multiple selected labels in batch.  
- Search: In the search box, you can enter the label name for quick search and positioning.  

![](img/label-1.png)


## Use Cases

<div class="grid" markdown>

=== "Dashboards"

    :material-numeric-1-circle-outline: When modifying the dashboard or viewing the explorer page, open the dropdown menu under the custom labels to search or add global labels:

    <img src="../img/label-2.png" width="60%" >

    <img src="../img/label-5.png" width="60%" >

    **Note**: If you do not have permission to create labels, you can only search for labels here.

    :material-numeric-2-circle-outline: In label filtering, you can view all the labels associated with the current page dashboard.

    <img src="../img/label-3.png" width="60%" >

=== "Infrastructure > Host"

    On Host Details page > Information > Label, click on the dropdown:

    <img src="../img/label-4.png" width="70%" >

=== "Monitors"

    Enter the new monitor creation page and you can search or add global labels:

    <img src="../img/label-6.png" width="60%" >

</div>