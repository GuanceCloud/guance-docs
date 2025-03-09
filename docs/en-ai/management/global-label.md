# Global Labels

Global labels refer to tags that can be directly invoked within the <<< custom_key.brand_name >>> workspace. Through global labels, data can be categorized, filtered, and filtered according to requirements, ultimately achieving global data linkage.

**Note**: Only Owner, Administrator, and custom roles can view this feature.

![](img/label-7.png)

## Create Labels

<img src="../img/label.png" width="50%" >

1. Name: Required; names must be unique and cannot be repeated; they can be in any text format;
2. Description: Optional; length should not exceed 100 characters;
3. Color: The first color block is the default color, but you can customize it;
4. Continue creating the next one: You can continue creating labels, and the popup will remain open after clicking confirm.

**Note**: If you check this option, it will remain checked during the label creation process unless you manually uncheck it or close the popup.

## Manage Labels

After creating labels, you can view them on the **Manage > Global Labels** list page. You can also perform the following operations on this page:

1. Edit: Update the name and description of existing labels;
2. Delete: Remove the current label;
3. Batch operations: Bulk delete multiple selected labels;
4. Search: Enter a label name in the search box to quickly locate it.

![](img/label-1.png)

## Use Cases

<div class="grid" markdown>

=== "Dashboard"

    :material-numeric-1-circle-outline: When modifying dashboards or Explorer pages, open the custom label dropdown to search for or add global labels:

    <img src="../img/label-2.png" width="60%" >

    <img src="../img/label-5.png" width="60%" >

    **Note**: If you do not have permission to create labels, you can only search for existing labels here.

    :material-numeric-2-circle-outline: In the label filter, you can view all labels associated with the current dashboard page.

    <img src="../img/label-3.png" width="50%" >

=== "Infrastructure > Hosts"

    On the **Host Details Page > Basic Information > Labels**, click the dropdown:

    ![](img/label-4.png)

=== "Monitors"

    When entering the monitor creation page, you can search for or add global labels:

    <img src="../img/label-6.png" width="60%" >

</div>