# Roles
---


If you need to set different Guance access permissions for employees in your organization to achieve permission isolation between different employees, you can use the role management feature of the Guance. Role management provides users with an intuitive entry for permission management, supporting the flexible adjustment of the permission scope corresponding to different roles, creating new roles for users, and assigning permission scopes to roles to meet the permission needs of different users.

## Roles

### Default Roles {#default-roles}

If different teams in an enterprise need to view and operate different Guance function modules and need to distinguish different role permissions, they can invite members to join the current workspace and set role permissions for them to control Guance function modules that the members can access and operate.

Guance provides four member roles by default, as shown in the following table.

**Note**: Default roles cannot be removed and permission range changes are not supported.

| Role Name     |
| ------------- |
| Owner         |
| Administrator |
| Standard      |
| Read-only     |

#### Permission Description

Permission ranges for different default roles can be found in the doc [permission list](role-list.md).

| **Roles** | **Description**                                                     |
| -------- | ------------------------------------------------------------ |
| Owner | The owner of the current workspace has all the operation permissions in the workspace, including adjusting the role permissions of other members. If the granted role permissions include "Token View", the authorization audit process will be initiated. <br />For details, see [Permission Change Review](#upgrade).<br /><br />**Notes:**<br /><li>Workspace creator defaults to Owner.<br /><li>There can only be one Owner in a workspace.<br /><li> Owner cannot exit workspace.<br /><li> Owner can transfer permissions to space members. After successful transferred, the original Owner is demoted to Administrator.|
| Administrator | Administrator of the current workspace has read and write permissions of the workspace. The role is able to adjust the permissions of other member roles except Owner. |
| Standard | Standard member of the current workspace have read and write permissions to the workspace.                 |
| Read-only | Read-only member of the current workspace can view the data of the workspace, and has no write permission. |

### Custom Roles {#customized-roles}

In addition to the default roles, Guance supports the creation of new roles in role management, and gives permission scope to the roles to meet the permission needs of different users.

A new role can be created in Guance workspace **Management > Roles**.

**Note**: Custom roles can only be created by Owner and Administrator.

> See [Permission List](role-list.md) for permission scopes for custom roles.


![](img/8.member_6.png)

#### Edit/Delete/Clone {#operations}

- Click **Edit** to adjust the permissions of the role;  

- Click :fontawesome-regular-trash-can: to delete some role that is not associated with the member account;

- Click :octicons-copy-24: to clone an existing role and create a new role;
    
    - **Note**: Cloning a role based on existing role permissions can reduce operational steps, quickly add or remove permissions, and create a new role.

![](img/clone.png)

#### Details Page

Click on any custom role to view its detailed information, including role name, creation/update time, creator/updater, description, and role permissions. You can click the **Edit** button on the right side of the role to modify its permissions.

![](img/8.member_13.1.png)

### Permission Change Review {#upgrade}

When setting role permissions for workspace members, if the granted role permissions include the permission of "Token View", a verification message will be sent to Guance Billing Center to initiate the permission change audit process:

- If the Billing Center **accepts** the verification, the permission change is successful;
- If the Billing Center **rejects** the verification, the permission change fails and the original role permission continues to be maintained;
- If the Billing Center **has not been approved**, the member can be modified to another role. After the modification is successful, the original permission change approval application will become invalid.

> See [Permission List](role-list.md) for more information.

**Notes**:

- At present, only Owner and Administrator have "Token View" permission. If Commercial workspace members need to refer to Administrator, they need to go to Guance Billing Center for review.

- Members from Experience Plan workspace can directly raise the right to Administrator without going to Guance Billing Center for review.

#### Example: Privilege Escalation of Administrator

In the Guance Commercial Plan workspace, enter **Management > Member Management**, select the member that needs to be promoted to Administrator, click the **Edit** button on the right and select **Role** as Administrator in the pop-up dialog box, and click Confirm.

**Note**: Guance only supports assigning Administrator permissions to current workspace members with the Owner and Administrator roles. Only users with the Owner role can approve Administrator permissions in the Billing Center.

![](img/11.role_upgrade_1.png)


- If the current workspace Owner is not the Administrator of the Guance Billing Center or the Administrator promotes the right for members, it is necessary to notify the Administrator of the Guance Billing Center to [log in to the Billing Center](https://bill.guance.one/) for operation; Or you can view the members that need to be authorized in **Member Management** and click **Billing Center** to operate.
- If the current workspace Owner is the administrator of the Guance Billing Center, then you can directly click **Jump to the Billing Center for Review** without logging in for operation;

![](img/11.role_upgrade_2.png)

<!-- 

In the message center of the Guance Billing Center, click **Accept**.

![](img/11.role_upgrade_3.png)

In the **Action Confirmation** dialog box, click **Confirm**.

![](img/11.role_upgrade_4.png)

It can be seen that the petition has been accepted.

![](img/11.role_upgrade_5.png)

Returning to **Member Management**, you can see that the workspace member is already Administrator.

![](img/11.role_upgrade_6.png)

-->

**Note**: Only users with the Owner role and Administrator permissions approved as members of the current workspace can perform the review.

![](img/4.member_admin_1.png)

## Permission List

Guance supports setting permissions for custom roles in the workspace to meet the permission requirements of different users. 

> For more details, see [Permission List](role-list.md).

**Note**: Presently you can only set permissions for functional operations within the workspace.