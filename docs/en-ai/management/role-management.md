# Role Management
---

If you need to set different access permissions for employees in your company to achieve permission isolation among different employees, you can use the role management feature of Guance. **Role Management** provides users with an intuitive permission management interface, supporting flexible adjustment of permission scopes for different roles, creation of new roles for users, and assignment of permission scopes to roles, meeting the permission needs of different users.

## Roles

### Default Roles {#default-roles}

If different teams within a company need to access and operate different modules of Guance, they can invite members to join the current workspace and set role permissions to control the modules that members can access and operate.

Guance provides four default member roles by default and has renamed these default roles as follows:

| Old Role Name | New Role Name    |
| ------------- | ---------------- |
| Owner         | Owner            |
| Administrator | Administrator    |
| Standard      | Standard         |
| Read-only     | Read-only        |

**Note**: Default roles cannot be deleted or have their permission scope changed.

#### Permission Description

> For the permission scope of different default roles, refer to the [Permission List](role-list.md).

| **Role**       | **Description**                                                     |
| -------------- | ------------------------------------------------------------------- |
| Owner          | The owner of the current workspace, with all operation permissions within the workspace. Supports adjusting other member role permissions. If the granted role permissions include "Token View," it initiates an authorization review process. Refer to [Permission Change Review](#upgrade) for details.<br />**Note**:<br /><li>The workspace creator is the default Owner <br /><li>There can only be one Owner per workspace <br /><li>The Owner cannot leave the workspace<br /><li>The Owner can transfer ownership to a workspace member, and after successful transfer, the original Owner will be demoted to Administrator  |
| Administrator  | The administrator of the current workspace, with read/write permissions within the workspace. Supports adjusting the role permissions of members other than the Owner. |
| Standard       | A standard member of the current workspace, with read/write permissions within the workspace. |
| Read-only      | A read-only member of the current workspace, who can only view data within the workspace without write permissions. |

### Custom Roles {#customized-roles}

In addition to default roles, Guance supports creating new roles in role management and assigning permission scopes to meet the permission needs of different users.

In the Guance workspace **Management > Role Management**, you can create a new role.

> For the permission scope of custom roles, refer to the [Permission List](role-list.md).

**Note**: Only Owners and Administrators can create custom roles.

![](img/8.member_6.png)

#### Modify/Delete/Clone Roles {#operations}

You can perform the following operations on custom roles:

- Click the **Edit** button to adjust the role's permissions;
- Click :fontawesome-regular-trash-can:, if the role is not associated with any member accounts, it can be deleted;
- Click :octicons-copy-24: to clone an existing role to create a new role;

    - By cloning an existing role, you can reduce steps and quickly add or remove permissions while creating a role.

![](img/clone.png)

#### Role Details Page

Click any custom role to view detailed information about the role, including role name, creation/update time, creator/updater, description, and role permissions. You can click the **Edit** button on the right side of the role to modify its permissions.

![](img/8.member_13.1.png)

### Permission Change Review {#upgrade}

When setting role permissions for workspace members, if the granted role permissions include "Token View" permission, a verification message will be sent to the Guance billing center to initiate a permission change review process:

- If the billing center **accepts** the verification, the permission change succeeds;
- If the billing center **rejects** the verification, the permission change fails, and the original role permissions remain unchanged;
- If the billing center does not review for a long time, you can change the member to another role, and the original permission change request will become invalid after a successful change.

> For more permission details, refer to the [Permission List](role-list.md).

???+ warning

    - Currently, only Owners and Administrators have "Token View" permission. If a Commercial Plan workspace member needs to be promoted to Administrator, it requires approval from the Guance billing center;
    - Free Plan workspace members can be directly promoted to Administrator without needing approval from the Guance billing center.

#### Example of Promoting to Administrator in Commercial Plan

In the Guance workspace **Management > Member Management**, select the member who needs to be promoted to Administrator, click the **Edit** button on the right side, choose Administrator in the **Role** dropdown, and click **Confirm**.

**Note**: Guance only allows Owners and Administrators to grant Administrator permissions to workspace members. Only the Owner can approve Administrator permissions in the billing center.

![](img/11.role_upgrade_1.png)

- If you are an Administrator of the current workspace, when promoting a member, you need to notify the billing center administrator to [log in to the billing center](https://boss.guance.com/) for operation;
- If you are the Owner of the current workspace, you can directly click **Go to Billing Center Review** to operate without logging into the Guance billing center.

![](img/11.role_upgrade_2.png)

In the Guance billing center message center, click **Accept**:

![](img/11.role_upgrade_3.png)

In the **Operation Confirmation** dialog box, click **Confirm**:

![](img/11.role_upgrade_4.png)

You can see that the promotion request has been accepted:

![](img/11.role_upgrade_5.png)

Return to the Guance workspace member management, and you will see that the member has been upgraded to Administrator:

![](img/11.role_upgrade_6.png)

Guance supports viewing all members awaiting Administrator approval in the member management list. Click the ![](img/4.member_admin_2.png) icon next to the member's role, and you can click **Billing Center** in the prompt dialog to perform the approval operation.

**Note**: Only the Owner can approve Administrator permissions for workspace members.

![](img/4.member_admin_1.png)

## Permission List

Guance supports setting permissions for custom roles within the workspace to meet the permission needs of different users.

> For more details, refer to the [Permission List](role-list.md).

**Note**: Permissions are currently set only for operations within the workspace.