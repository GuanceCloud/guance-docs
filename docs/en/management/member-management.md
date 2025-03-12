# Member Management
---

<<< custom_key.brand_name >>> supports unified management of all members in the current workspace through member management, including setting role permissions, inviting members and assigning permissions, configuring teams, and setting up SSO single sign-on.

> Only workspace Owners, Administrators, and custom roles authorized with **Member Management** permissions can manage members uniformly. For more details on roles, refer to [Role Management](role-management.md).

![](img/8.member_10.png)

## Member-Related Operations

![](img/8.member_3.png)

### Search Members

Supports quick retrieval of relevant member lists via search and shortcut filters.

- Search: Supports searching for members by email, name, nickname, and login type.
- Shortcut Filters: Supports filtering members by role, team, and login type.

### Batch Operations {#batch}

Click the icon :material-crop-square: next to the username to batch modify permissions or batch delete members.

**Note**: Only Owners and Administrators can perform batch operations.


### Delete Members
     
Select the member you want to delete and click the :fontawesome-regular-trash-can: button on the right.

Only Owners and Administrators can delete members. The Owner role itself cannot be deleted; it can only be downgraded to an Administrator before deletion.

### Edit Members {#edit}

Select the member you want to modify and click the edit button on the right to <u>set nicknames, configure roles and teams</u>.

**Note**: Only Owners can use the notes feature.

### Invite Members

You can invite registered users of <<< custom_key.brand_name >>> to become new members of the workspace.

> <<< custom_key.brand_name >>> currently supports inviting members from two entry points. For more information, refer to [Invitation Entry Points and Invitation Records](./invite-member.md).

### Member Details

After a member is invited into the workspace, in **Member Management**, click any member to slide over and view their information, including member name, creation/update time, email, role, and role permissions.

![](img/8.member_7.png)

Click the **Edit** button on the right side of the member to select role permissions and teams.

![](img/8.member_8.png)

???+ abstract "SSO Management"

    In addition to **inviting members**, <<< custom_key.brand_name >>> supports managing employee information in the local IDP (Identity Provider) by configuring SSO single sign-on to access <<< custom_key.brand_name >>> without needing user synchronization between <<< custom_key.brand_name >>> and the enterprise IDP. Enterprise employees can log in and access <<< custom_key.brand_name >>> with specified roles.

    > In Member Management, click into **SSO Management** for more information, refer to the documentation [SSO Management](sso/index.md).

    <img src="../img/9.member_sso_1.png" width="70%" >

## Team-Related Operations

In Member Management, click **Team Management** to enter the team editing page.

![](img/8.member_9.png)

???+ abstract "Benefits of Teams"

    If an enterprise needs to set different alert strategies for different teams so that relevant teams can promptly receive and resolve fault issues, they can create teams and assign related team members to those teams, then set the alert notification targets as these teams in the alert strategy.

    > For more alert strategy settings, refer to [Alert Strategies](../monitoring/alert-setting.md).

### Create/Edit Teams

Enter **Team Management > Create Team**:

<img src="../img/1-member-3.png" width="70%" >

Customize the team name; in the left pending list, all members not in this team are displayed. You can click the search box to search for members to add. Select the member and click **Confirm** to add them to the right-hand **Member List**.

<img src="../img/1-member-4.png" width="70%" >

**Note**: When adding members, it will verify if the team name is duplicated. Duplicate names cannot be saved.

### Delete Teams

Tap a row of the team, and a :fontawesome-regular-trash-can: icon appears on the right. Clicking it shows a confirmation dialog;

Click **Confirm** to delete the team:

<img src="../img/1-member-2.png" width="60%" >

### Use Cases

You can apply newly created teams in **Monitoring** under **Alert Strategy Management** and **Notification Targets Management**.

:material-numeric-1-circle-outline: When creating a new alert configuration, you can choose the newly created team in the **Alert Notification Targets**.

<img src="../img/1-member-management-1.png" width="60%" >

:material-numeric-2-circle-outline: When creating new notification targets, you can choose the newly created team in SMS and email groups.

<img src="../img/1-member-management-2.png" width="60%" >