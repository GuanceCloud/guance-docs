# Membership Management
---


Guance supports to manage all members of the current workspace uniformly, including adding/editing/deleting workspace members and modifying member permissions.

> Only **Owner**, **Administrator** and custom roles of the workspace that are authorized with **Member Management** permissions manage members uniformly. See [Roles](role-management.md) for more details.

![](img/8.member_10.png)

## Operations on Members

![](img/8.member_3.png)

### Search

Here is a quick access to relevant member lists through searching and filtering.

- Search by members' mailboxes, names and login types;
- Filter by members' roles, Teams and login types.


### Batch Operation {#batch}

Click the icon :material-crop-square: to batch edit or delete member permissions.

**Note**: Only **Owner** and **Administrator** can modify member permissions in batch.


### Delete

Select the members you want to delete and click on the :fontawesome-regular-trash-can: button on the right side.

**Note**: Only the Owner and Administrators can delete members. The Owner role itself cannot be deleted. To delete an Owner, you need to downgrade it to an Administrator first.

### Edit {#edit}

Select the member you want to edit and click the edit button to <u>set the member's nickname, configure roles and teams</u>.

**Note**: Only the Owner can use the comments feature.

### Invite

You can invite registered users of Guance to become new members within the workspace.

> Guance currently supports inviting members from two entrances. For more information, see [Invitation Entrances and Invitation Records](./invite-member.md).

### Member Details

After members are invited into the workspace, click any member to check and view the information of members in **Member Management**, including member name, creation/update time, mailbox, role and role permissions.

![](img/8.member_7.png)

Click the Edit button on the right side of the member to select role permissions and teams.

![](img/8.member_8.png)

???+ abstract "SSO Management"

    In addition to inviting members, Guance supports enterprises to manage employee information in their local IDP (Identity Provider) and access Guance through [SSO](sso/index.md) (Single Sign-On) configuration, without the need for user synchronization between Guance and the enterprise IDP. Enterprise employees can log in and access Guance with specified roles.

    <img src="../img/9.member_sso_1.png" width="70%" >

## Operations on Team

Enter **Member Management > Team Management**.

![](img/8.member_9.png)

???+ abstract "The Magic of Teams"

    If a company needs to set different alerting strategies for different teams so that the relevant teams can receive and resolve fault issues in a timely manner, they can do so by setting up teams and adding team members to those teams. Then, in the alerting strategy, set the alert notification recipients to the respective teams.

    > For more information on setting up alerting strategies, see [Alert Setting](../monitoring/alert-setting.md).

### Create/Edit

Enter **Team Management > Create**.

<img src="../img/1-member-3.png" width="70%" >

Customize team name; on the left side of the "To be added" list, display all members who are not in this team. You can click on the search box to search for members to be added. Check the member and click **Confirm** to add the member to the **Member List** on the right side.

<img src="../img/1-member-4.png" width="70%" >

**Note**: When adding members, the team name will be checked for duplicates. If there is a duplicate, it cannot be saved.

### Delete

Tap on a team row, and on the right side, it will display :fontawesome-regular-trash-can:. Clicking it will show a confirmation popup;

Click **Confirm** to delete the team:

<img src="../img/1-member-2.png" width="60%" >

### Use Cases

You can apply the newly created team in **Monitoring > Alert Strategies / Notification Targets**.

:material-numeric-1-circle-outline: When configuring alert strategies, you can select the newly created team in **Notification Targets**.

<img src="../img/1-member-management-1.png" width="60%" >

:material-numeric-2-circle-outline: When creating notification targets, you can select the newly created team in SMS and email groups.

<img src="../img/1-member-management-2.png" width="60%" >