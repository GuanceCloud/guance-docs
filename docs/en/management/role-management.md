# Role Management
---

If you need to set different <<< custom_key.brand_name >>> access permissions for employees in your enterprise to achieve permission isolation between different employees, you can use the role management feature of <<< custom_key.brand_name >>>. **Role Management** provides users with an intuitive permission management entry point, supporting flexible adjustment of permission scopes for different roles, creating new roles for users, assigning permission scopes to roles, and meeting the permission needs of different users.

## Roles

### Default Roles {#default-roles}

If different teams within an enterprise need to view and operate different <<< custom_key.brand_name >>> feature modules, and require distinguishing between different role permissions, you can invite members to join the current workspace and set role permissions for them to control the <<< custom_key.brand_name >>> feature modules they can access and operate.

<<< custom_key.brand_name >>> provides four default member roles by default and has renamed these default roles as shown in the following table:

| Old Role Name | New Role Name |
| ------------- | ------------- |
| Owner         | Owner         |
| Administrator | Administrator |
| Standard Member | Standard     |
| Read-only Member | Read-only    |

**Note**: Default roles cannot be deleted or have their permission scope changed.

#### Permission Description

> For the permission scope of different default roles, refer to the [Permission List](role-list.md).

| **Role**      | **Description**                                                     |
| ------------- | ------------------------------------------------------------------- |
| Owner         | The owner of the current workspace, with all operation permissions within the workspace, supports adjusting other members' role permissions. If the granted role permissions include "Token View," then an authorization review process is initiated. For more details, refer to [Permission Change Review](#upgrade).<br />**Note**:<br /><li>The workspace creator is the default Owner.<br /><li>There can only be one Owner per workspace.<br /><li>The Owner cannot leave the workspace.<br /><li>The Owner can transfer permissions to workspace members, and after successful transfer, the original Owner will be downgraded to Administrator. |
| Administrator | The administrator of the current workspace, with read/write permissions for the workspace, supports adjusting the role permissions of other members except the Owner. |
| Standard      | A standard member of the current workspace, with read/write permissions for the workspace. |
| Read-only     | A read-only member of the current workspace, who can only view the data in the workspace without write permissions. |

### Custom Roles {#customized-roles}

In addition to default roles, <<< custom_key.brand_name >>> supports creating new roles in role management and assigning permission scopes to meet the permission needs of different users.

In the <<< custom_key.brand_name >>> workspace **Management > Role Management**, you can create a new role.

> For the permission scope of custom roles, refer to the [Permission List](role-list.md).

**Note**: Only Owner and Administrator can create custom roles.

![](img/8.member_6.png)

#### Modify/Delete/Clone Role {#operations}

You can perform the following operations on custom roles:

- Click the **Edit** button to adjust the role's permissions;

- Click :fontawesome-regular-trash-can:, if the role is not associated with any member accounts, it can be deleted;

- Click :octicons-copy-24: to clone an existing role to create a new role;

    - By cloning an existing role, you can reduce operational steps, quickly add or remove permissions, and create a new role based on the existing role's permissions.

![](img/clone.png)

#### Role Details Page

Click any custom role to view its detailed information, including role name, creation/update time, creator/updater, description, and role permissions. You can click the **Edit** button on the right side of the role to modify the role's permissions.

![](img/8.member_13.1.png)

### Permission Change Review {#upgrade}

When setting role permissions for workspace members, if the granted role permissions include "Token View," a verification message will be sent to the <<< custom_key.brand_name >>> Billing Center to initiate the permission change review process:

- If the Billing Center **accepts** the verification, the permission change is successful;
- If the Billing Center **rejects** the verification, the permission change fails, and the original role permissions remain unchanged;
- If the Billing Center does not review it for a long time, you can change the member to another role, and the original permission change request becomes invalid after the change is successful.

> For more permission details, refer to the [Permission List](role-list.md).

???+ warning

    - Currently, only Owner and Administrator have the "Token View" permission. If a Commercial Plan workspace member needs to be promoted to Administrator, it must be reviewed by the <<< custom_key.brand_name >>> Billing Center.
    - Free Plan workspace members can be directly promoted to Administrator without review by the <<< custom_key.brand_name >>> Billing Center.

#### Example of Promoting to Administrator in Commercial Plan

In the <<< custom_key.brand_name >>> workspace **Management > Member Management**, select the member you want to promote to Administrator, click the **Edit** button on the right side, choose Administrator in the **Role** dropdown in the pop-up dialog, and click **Confirm**.

**Note**: <<< custom_key.brand_name >>> only supports Owner and Administrator roles granting Administrator permissions to workspace members. Only the Owner role can approve Administrator permissions in the Billing Center.

![](img/11.role_upgrade_1.png)

- If you are the Administrator role of the current workspace, when promoting a member, you need to notify the <<< custom_key.brand_name >>> Billing Center administrator to [log in to the Billing Center](https://<<< custom_key.boss_domain >>>/) for operation;
- If you are the Owner role of the current workspace, you can directly click **Go to Billing Center Review** and operate without logging into the <<< custom_key.brand_name >>> Billing Center.

![](img/11.role_upgrade_2.png)

In the <<< custom_key.brand_name >>> Billing Center message center, click **Accept**:

![](img/11.role_upgrade_3.png)

In the **Operation Confirmation** dialog box, click **Confirm**:

![](img/11.role_upgrade_4.png)

You can see that the promotion request has been accepted:

![](img/11.role_upgrade_5.png)

Return to the <<< custom_key.brand_name >>> workspace member management, and you will see that the workspace member has been upgraded to Administrator:

![](img/11.role_upgrade_6.png)

<<< custom_key.brand_name >>> supports viewing all members with pending Administrator role approval in the member management list. Click the ![](img/4.member_admin_2.png) icon next to the member's role, and you can click **Billing Center** in the prompt dialog box to perform the review operation.

**Note**: Only the Owner role can approve Administrator permissions for workspace members.

![](img/4.member_admin_1.png)

## Permission List

<<< custom_key.brand_name >>> supports setting permissions for custom roles within the workspace to meet the permission needs of different users.

> For more details, refer to the document [Permission List](role-list.md).

**Note**: Permissions are currently only set for workspace feature operations.