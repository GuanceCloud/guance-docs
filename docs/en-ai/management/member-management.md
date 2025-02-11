# Member Management
---

Guance supports unified management of all members within the current workspace through member management, including setting role permissions, inviting members and setting their permissions, configuring teams, and setting up SSO single sign-on.

> Only workspace Owner, Administrator, and custom roles authorized with **Member Management** permissions can manage members uniformly. For more details on roles, refer to [Role Management](role-management.md).

![](img/8.member_10.png)

## Member-Related Operations

![](img/8.member_3.png)

### Search Members

Supports quickly obtaining relevant member lists through search and quick filtering.

- Search: Supports searching for members by email, name, nickname, and login type.
- Quick Filtering: Supports filtering members by role, team, and login type.

### Batch Operations {#batch}

Click the icon :material-crop-square: next to the username to batch modify permissions or batch delete members.

**Note**: Only Owners and Administrators can perform batch operations.

### Delete Members

Select the member(s) you wish to delete and click the :fontawesome-regular-trash-can: button on the right.

Only Owners and Administrators can delete members. The Owner role itself cannot be deleted; it can be removed by demoting the current Owner to an Administrator and then deleting them.

### Edit Members {#edit}

Select the member you want to modify and click the edit button on the right to set the member's nickname, configure roles and teams.

**Note**: Only Owners can use the note function.

### Invite Members

You can invite registered users of Guance to become new members of the workspace.

> Guance currently supports inviting members from two entry points. For more information, refer to [Invitation Entry Points and Invitation Records](./invite-member.md).

### Member Details

After a member is invited into the workspace, in **Member Management**, click any member to slide and view the member's information, including name, creation/update time, email, role, and role permissions.

![](img/8.member_7.png)

Click the **Edit** button on the right side of the member to choose role permissions and teams.

![](img/8.member_8.png)

???+ abstract "SSO Management"

    In addition to **inviting members**, Guance supports managing employee information in the local IDP (Identity Provider) and accessing Guance through SSO single sign-on configuration without synchronizing users between Guance and the enterprise IDP. Enterprise employees can log in and access Guance with specified roles.

    > In Member Management, click into **SSO Management**. Refer to the documentation [SSO Management](sso/index.md) for more information.

    <img src="../img/9.member_sso_1.png" width="70%" >

## Team-Related Operations

In Member Management, click **Team Management** to enter the team editing page.

![](img/8.member_9.png)

???+ abstract "Benefits of Teams"

    If an enterprise needs to set different alert strategies for different teams so that relevant teams can promptly receive and resolve issues, it can create teams and add related team members to those teams. Then, in the alert strategy settings, set the alert notification targets to these teams.

    > For more alert strategy settings, refer to [Alert Strategy](../monitoring/alert-setting.md).

### Create/Edit Teams

Enter **Team Management > Create Team**:

<img src="../img/1-member-3.png" width="70%" >

Customize the team name; in the left pending list, all members not in this team are displayed. You can click the search box to search for members to add. Select the member and click **Confirm** to add the member to the right **Member List**.

<img src="../img/1-member-4.png" width="70%" >

**Note**: When adding members, it will check if the team name is duplicated. Duplicates cannot be saved.

### Delete Teams

Tap a row of the team, and the right side shows :fontawesome-regular-trash-can:. Clicking it displays a confirmation dialog;

Click **Confirm** to delete the team:

<img src="../img/1-member-2.png" width="60%" >

### Application Scenarios

You can apply newly created teams in the **Monitoring** sections of **Alert Strategy Management** and **Notification Targets Management**.

:material-numeric-1-circle-outline: When creating a new alert configuration, you can select newly created teams in the **Alert Notification Targets**.

<img src="../img/1-member-management-1.png" width="60%" >

:material-numeric-2-circle-outline: When creating notification targets, you can select newly created teams in SMS and email groups.

<img src="../img/1-member-management-2.png" width="60%" >