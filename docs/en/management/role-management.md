# Role Management
---

If you need to set different access rights for employees in the enterprise to achieve permission isolation among different employees, you can use the role management function of Guance. Role management provides users with an intuitive access to authority management, supports free adjustment of authority scope corresponding to different roles, supports the creation of new roles for users and gives authority scope to roles to meet the authority needs of different users.

## Role

### Default Role

If different teams in an enterprise need to view and operate different Guance function modules and need to distinguish different role permissions, they can invite members to join the current workspace and set role permissions for them to control Guance function modules that the members can access and operate.

Guance provides four member roles by default, as shown in the following table.

> Default roles cannot be removed and permission range changes are not supported.

| New Role Name     |
| ------------- |
| Owner         |
| Administrator |
| Standard      |
| Read-only     |

#### Permission Description

Permission ranges for different default roles can be found in the doc [permission list](role-list.md).

| **Roles** | **Description**                                                     |
| -------- | ------------------------------------------------------------ |
| Owner | The owner of the current workspace has all the operation permissions in the workspace, and supports adjusting the role permissions of other members. If the granted role permissions include "Token View", the authorization audit process will be initiated. For details, please refer to [permission change audit](#upgrade).<br />**Notes:**<br /><li>Workspace creator defaults to Owner.<br /><li>There can only be one Owner in a workspace.<br /><li> Owner cannot exit workspace.<br /><li> Owner can transfer permissions to space members. After successful transfer, the original Owner is demoted to Administrator.|
| Administrator | Administrator of the current workspace has read and write permissions of the workspace. The role is able to adjust the permissions of other member roles except Owner. |
| Standard | Standard member of the current workspace have read and write permissions to the workspace.                 |
| Read-only | Read-only member of the current workspace can view the data of the workspace, and has no write permission. |

### Custom Roles

In addition to the default roles, Guance supports the creation of new roles in role management, and gives permission scope to the roles to meet the permission needs of different users.

A new role can be created in the observation cloud workspace **Management > Member Management > Role Management**.

Refer to the doc [permission list](role-list.md) for permission scopes for custom roles.

> Custom roles are only Owner and Administrator can be created.

![](img/8.member_6.png)

#### Modify/Remove Custom Roles

In **Role Management**, click the **Edit** button on the right side of the user-defined role to adjust the permissions of the role. Click the **Delete** button. If the role is not associated with the member account, it can be deleted.

![](img/8.member_4.png)

#### Custom Role Details Page

In **Role Management**, click any custom role to view the detailed information of the role, including role name, creation/update time, creator/update person, description and role permissions. Click the **Edit** button on the right side of the role to modify role permissions.

![](img/8.member_13.1.png)

### Permission Change Audit {#upgrade}

When setting role permissions for workspace members, if the granted role permissions include the permission of "Token View", a verification message will be sent to Guance expense center to initiate the permission change audit process:

- If the cost center accepts the verification, the permission change is successful;
- If the cost center rejects the verification, the permission change fails and the original role permission continues to be maintained;
- If the expense center has not been approved, the member can be modified to another role. After the modification is successful, the original permission change approval application will become invalid.

See the doc [permission list](role-list.md) for more permissions details.

> - At present, only Owner and Administrator have "Token View" permission. If commercial workspace members need to refer to Administrator, they need to go to Guance expense center for review.
> - Experience workspace members can directly raise the right to Administrator without going to Guance expense center for review.

#### Example of Administrator of Business Plan 

In the Guance workspace **Management > Member Management**, select the member that needs to be promoted to Administrator, click the **Edit** button on the right, select **Role** as Administrator in the pop-up dialog box, and click OK.

> Guance only allows Owner and Administrator gives Administrator permission to the current workspace member.

![](img/11.role_upgrade_1.png)

Prompt for permission verification:

- If the current workspace Owner is the administrator of the Guance expense center, you can directly click and go to the expense center for review without logging in to the Guance expense center for operation;
- If the current workspace Owner is not the administrator of the Guance expense center, it is necessary to notify the administrator of the Guance expense center [log in to the expense center](https://boss.guance.com/).

![](img/11.role_upgrade_2.png)

In the message center of the Guance expense center, click **Accept**.

![](img/11.role_upgrade_3.png)

In the **Action Confirmation** dialog box, click **OK**.

![](img/11.role_upgrade_4.png)

It can be seen that the petition has been accepted.

![](img/11.role_upgrade_5.png)

Returning to **Member Management**, you can see that the workspace member is already Administrator.

![](img/11.role_upgrade_6.png)

## Permissions

Guance supports setting permissions for custom roles in the workspace to meet the permission requirements of different users. For more details, please refer to the doc [permission list](role-list.md).

> Presently permissions are only for setting permissions for functional operations within the workspace.