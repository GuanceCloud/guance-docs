# Role Management
---

If you need to set different <<< custom_key.brand_name >>> access permissions for employees in your company to achieve permission isolation between different employees, you can use the role management feature of <<< custom_key.brand_name >>>. **Role Management** provides users with an intuitive permission management entry point, supporting free adjustment of the permission scope for different roles, creating new roles for users, assigning permission scopes to roles, and meeting the permission needs of different users.

## Roles

### Default Roles {#default-roles}

If different teams within a company need to view and operate different <<< custom_key.brand_name >>> feature modules and require distinguishing between different role permissions, members can be invited to join the current workspace and their role permissions can be set to control the <<< custom_key.brand_name >>> feature modules they can access and operate.

<<< custom_key.brand_name >>> provides four default member roles by default, and these default roles have been renamed as follows:


| Old Role Name | New Role Name    |
| ------------- | ----------------- |
| Owner         | Owner            |
| Administrator | Administrator    |
| Standard Member | Standard       |
| Read-only Member | Read-only     |

**Note**: Default roles cannot be deleted nor does their permission scope support changes.

#### Permission Description

> The permission scope of different default roles can be referenced in the [Permission List](role-list.md) document.

| **Role** | **Description**                                                     |
| -------- | ------------------------------------------------------------------|
| Owner | The owner of the current workspace, possessing all operational permissions within the workspace, supports adjusting other member role permissions. If the granted role permissions include "Token View," then an authorization review process is initiated; details can be found in [Permission Change Review](#upgrade).<br />**Note**:<br /><li>The workspace creator defaults to Owner <br /><li>A workspace can only have one Owner <br /><li>Owner cannot leave the workspace<br /><li>Owner can transfer permissions to workspace members, after successful transfer, the original Owner is downgraded to Administrator |
| Administrator | The administrator of the current workspace, having read-write permissions for the workspace, supports adjusting the role permissions of other members except Owner. |
| Standard | The standard member of the current workspace, having read-write permissions for the workspace.                 |
| Read-only | The read-only member of the current workspace, able only to view data in the workspace, without write permissions. |

### Custom Roles {#customized-roles}

In addition to the default roles, <<< custom_key.brand_name >>> supports creating new roles in Role Management and assigning permission scopes to meet the permission needs of different users.

To create a new role, navigate to **Management > Role Management** in the <<< custom_key.brand_name >>> workspace.

> For more information on the permission scope of custom roles, refer to the [Permission List](role-list.md).

**Note**: Only Owner and Administrator can create custom roles.

![](img/8.member_6.png)

#### Modify/Delete/Clone Role {#operations}

You can perform the following actions on custom roles:

- Click the **Edit** button to adjust the role's permissions;

- Click :fontawesome-regular-trash-can:, if the role is not associated with any member accounts, it can be deleted;

- Click :octicons-copy-24: to clone an existing role to create a new role;

    - Based on the permissions of an existing role, cloning reduces operational steps, quickly adding or removing permissions and creating a role.

![](img/clone.png)

#### Role Details Page

Clicking on any custom role allows you to view detailed information about that role, including the role name, creation/update time, creator/updater, description, and role permissions. You can click the **Edit** button on the right side of the role to modify its permissions.

![](img/8.member_13.1.png)

### Permission Change Review {#upgrade}

When setting role permissions for workspace members, if the granted role permissions include the "Token View" permission, a verification message will be sent to the <<< custom_key.brand_name >>> Billing Center to initiate the permission change review process:

- If the Billing Center **accepts** the verification, the permission change succeeds;
- If the Billing Center **rejects** the verification, the permission change fails, and the original role permissions remain unchanged;
- If the Billing Center does not review for a long time, the member's role can be modified to another role, and upon successful modification, the original permission change review application becomes invalid.

> For more permission details, refer to the [Permission List](role-list.md).

???+ warning

    - Currently, only Owner and Administrator have the "Token View" permission. If Commercial Plan workspace members need to be promoted to Administrator, the <<< custom_key.brand_name >>> Billing Center must review it;
    - Free Plan workspace members can be directly promoted to Administrator without requiring a review at the <<< custom_key.brand_name >>> Billing Center.

#### Example of Promoting to Administrator in Commercial Plan

In the <<< custom_key.brand_name >>> workspace **Management > Member Management**, select the member who needs to be promoted to Administrator, click the **Edit** button on the right side, choose Administrator in the pop-up dialog box under **Role**, and click **Confirm**.

**Note**: <<< custom_key.brand_name >>> only supports Owner and Administrator roles granting Administrator permissions to current workspace members, and only the Owner role can approve Administrator permissions in the Billing Center.

![](img/11.role_upgrade_1.png)

- If you are the Administrator role of the current workspace, when promoting a member, you need to notify the <<< custom_key.brand_name >>> Billing Center administrator to [log in to the Billing Center](https://<<< custom_key.boss_domain >>>/) to perform the operation;
- If you are the Owner role of the current workspace, you can directly click **Go to Billing Center for Review** to perform the operation without logging into the <<< custom_key.brand_name >>> Billing Center.

![](img/11.role_upgrade_2.png)

In the message center of the <<< custom_key.brand_name >>> Billing Center, click **Accept**:

![](img/11.role_upgrade_3.png)

In the **Operation Confirmation** dialog box, click **Confirm**:

![](img/11.role_upgrade_4.png)

You can see that the promotion request has been accepted:

![](img/11.role_upgrade_5.png)

Returning to the <<< custom_key.brand_name >>> workspace member management, you can see that the workspace member has become an Administrator:

![](img/11.role_upgrade_6.png)

<<< custom_key.brand_name >>> supports viewing all members in the member management list who have not passed the Administrator role review. Clicking the ![](img/4.member_admin_2.png) icon to the right of the member's role opens a prompt dialog where you can click **Billing Center** to perform the review operation.

**Note**: Only the Owner role can approve Administrator permissions for the current workspace members.

![](img/4.member_admin_1.png)

## Permission List

<<< custom_key.brand_name >>> supports setting permissions for custom roles within the workspace to meet the permission needs of different users.

> For more details, refer to the [Permission List](role-list.md) documentation.

**Note**: Permissions currently apply only to functional operations within the workspace.