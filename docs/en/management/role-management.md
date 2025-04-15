# Role Management
---

If you need to set different <<< custom_key.brand_name >>> access permissions for employees in your company to achieve permission isolation between different employees, you can use <<< custom_key.brand_name >>>'s role management feature. **Role Management** provides users with an intuitive permission management interface, supporting the adjustment of permission scopes for different roles, creation of new roles for users, and assignment of permission scopes to roles, meeting the permission needs of different users.

## Roles

### Default Roles {#default-roles}

If different teams within a company need to view or operate different <<< custom_key.brand_name >>> Features modules and require distinction between different role permissions, members can be invited into the current workspace and their role permissions set to control which <<< custom_key.brand_name >>> Features modules they can access and operate.

<<< custom_key.brand_name >>> provides four default member roles by default, and these default roles have been renamed as shown in the following table:

| Old Role Name | New Role Name    |
| ------------- | ----------------- |
| Owner         | Owner            |
| Administrator | Administrator    |
| Standard Member | Standard       |
| Read-only Member | Read-only     |

**Note**: Default roles cannot be deleted and do not support changes to their permission scope.

#### Permission Description {#descrip}

> For the permission scope of different default roles, refer to the [Permission List](role-list.md) document.

| **Role** | **Description**                                                     |
| -------- | ------------------------------------------------------------------|
| Owner    | The owner of the current workspace, having all operation permissions within the workspace, supports adjusting other member role permissions. If the granted role permissions include "Token View," then an authorization review process is initiated; for more details, refer to [Permission Change Review](#upgrade).<br />**Note**:<br /><li>The workspace creator defaults to Owner<br /><li>A workspace can only have one Owner<br /><li>An Owner cannot leave the workspace<br /><li>An Owner can transfer permissions to workspace members, and after a successful transfer, the original Owner will be downgraded to Administrator |
| Administrator | The administrator of the current workspace, having read/write permissions within the workspace, supports adjusting the role permissions of other members except the Owner. |
| Standard | The standard member of the current workspace, having read/write permissions within the workspace.                 |
| Read-only | The read-only member of the current workspace, able only to view data within the workspace without write permissions. |

### Custom Roles {#customized-roles}

In addition to the default roles, <<< custom_key.brand_name >>> supports creating new roles in Role Management and assigning permission scopes to meet the needs of different users.

In the <<< custom_key.brand_name >>> workspace **Management > Role Management**, you can create a new role.

> For the permission scope of custom roles, refer to the [Permission List](role-list.md).

**Note**: Only Owners and Administrators can create custom roles.

![](img/8.member_6.png)

#### Modify/Delete/Clone Roles {#operations}

You can perform the following operations on custom roles:

- Click the **Edit** button to adjust the role's permissions;

- Click :fontawesome-regular-trash-can:, if the role is not associated with any member accounts, it can be deleted;

- Click :octicons-copy-24:, to clone an existing role and create a new role;

    - Based on the permissions of an existing role, cloning reduces operational steps, quickly adding/removing permissions and creating roles.

![](img/clone.png)

#### Role Details Page

Clicking on any custom role allows you to view detailed information about that role, including the role name, creation/update time, creator/updater, description, and role permissions. You can click the **Edit** button to the right of the role to modify the role's permissions.

![](img/8.member_13.1.png)

### Permission Change Review {#upgrade}

When setting role permissions for workspace members, if the granted role permissions include the "Token View" permission, a verification message will be sent to the <<< custom_key.brand_name >>> Billing Center, initiating the permission change review process:

- If the Billing Center **accepts** the verification, the permission change succeeds;
- If the Billing Center **rejects** the verification, the permission change fails, and the original role permissions remain unchanged;
- If the Billing Center does not review for a long time, you can modify the member's role to another one. After a successful modification, the original permission change review application becomes invalid.

> For more details on permissions, refer to the [Permission List](role-list.md).

???+ warning

    - Currently, only Owners and Administrators have "Token View" permissions. If Commercial Plan workspace members need to be promoted to Administrator, they must be reviewed at the <<< custom_key.brand_name >>> Billing Center.
    - Free Plan workspace members can directly be promoted to Administrator without needing to be reviewed at the <<< custom_key.brand_name >>> Billing Center.

#### Example of Promoting to Administrator in Commercial Plan

In the <<< custom_key.brand_name >>> workspace **Management > Member Management**, select the member who needs to be promoted to Administrator, click the **Edit** button on the right side, choose Administrator for the **Role** in the pop-up dialog box, and click **Confirm**.

**Note**: <<< custom_key.brand_name >>> only supports Owners and Administrators granting Administrator permissions to current workspace members, and only the Owner role can approve Administrator permissions in the Billing Center.

![](img/11.role_upgrade_1.png)

- If you are the Administrator role for the current workspace, when promoting a member, you need to notify the <<< custom_key.brand_name >>> Billing Center administrator to [log in to the Billing Center](https://<<< custom_key.boss_domain >>>/) to perform the operation;
- If you are the Owner role for the current workspace, you can directly click **Go to Billing Center for Approval**, eliminating the need to log into the <<< custom_key.brand_name >>> Billing Center to perform the operation.

![](img/11.role_upgrade_2.png)

In the <<< custom_key.brand_name >>> Billing Center message center, click **Accept**:

![](img/11.role_upgrade_3.png)

In the **Operation Confirmation** dialog box, click **Confirm**:

![](img/11.role_upgrade_4.png)

You can see that the promotion request has been accepted:

![](img/11.role_upgrade_5.png)

Returning to the <<< custom_key.brand_name >>> workspace member management, you can see that the workspace member has now become an Administrator:

![](img/11.role_upgrade_6.png)

<<< custom_key.brand_name >>> supports viewing all members in the member management list who have not yet passed the Administrator role review. Click the ![](img/4.member_admin_2.png) icon to the right of the member role, and you can click **Billing Center** in the prompt dialog box to perform the review operation.

**Note**: Only the Owner role can approve Administrator permissions for the current workspace members.

![](img/4.member_admin_1.png)

## Permission List

<<< custom_key.brand_name >>> supports setting permissions for custom roles within the workspace to meet the permission needs of different users.

> For more details, refer to the [Permission List](role-list.md) documentation.

**Note**: Currently, permissions are only set for workspace function operations.