# Attribute Claims

In **Management > Attribute Claims**, you can see the attribute information in JSON format. Guance will preset two fixed attribute fields: `organization` and `business`.

![](img/claim.png)

- `organization`: Automatically generated by the system; it is the organization ID, a unique ID generated by the cost center account bound to the current workspace. All Business Edition workspaces belong to an organization. If multiple workspaces are bound to the same cost account, the ID will also be the same.
    
    - **Note**: For Deployment Edition users, `organization` has a unified fixed ID.

- `business`: Cannot be deleted; it has business attributes that you can filter and view in the workspace list.

![](img/claim-3.png)

Click the edit button on the right to enter the attribute claim editing page:

<img src="../img/claim-1.png" width="60%" >

As shown in the figure, `organization` cannot be edited or deleted; you can edit `business`.

Click **Add Attribute** to customize attributes. Both the attribute name (`key`) and value (`value`) are required.

## Use Cases

When you configure custom fields in attribute claim, these fields will be synchronized in scenes where event notifications are sent externally.
