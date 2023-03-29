# Membership Management
---

## Overview  
Guance supports to manage all members of the current space uniformly, including adding/editing/deleting space members and modifying member permissions.

> Only **Owner**, **Administrator** and custom roles of the workspace that are authorized with **Member Management** permissions manage members uniformly. See the doc [Role Management](role-management.md) for more details.

## Operations on Member

### Search Member

Here is a quick access to relevant member lists through searching and filtering.

- Search: Support searching for members' mailboxes, names and login types
- Filter: Support filtering members' roles, member groups and login types

![](img/8.member_10.png)

### Batch Modify Member Permissions

In **Member Management**, click **Batch Modify Permissions** and select the member that needs to batch modify permissions, then click **Modify** and select permissions for the member in the pop-up dialog box and then **Confirm**.

> Only **Owner** and **Administrator** can modify member permissions in batch.

![](img/8.member_3.png)

### Modify/Delete Members

- Select the member to be modified, and click the **Modify** button on the right to modify permissions and member groups for the member. Multiple roles can be configured for the member.
- Select the member to be deleted, and click the **Delete** button on the right.

> Only **Owner** and **Administrator** can delete members. **Owner** itself cannot be deleted, but can be deleted by transferring **Owner** to **Administrator**.

### Invite Members

In the current workspace, Owner, Administrator and custom roles authorized with **Member Management** permissions can invite registered users of the observation cloud to become new members in the workspace.

Through **Management > Member Management > Invite Members**, enter the email address of the invited member, enter, and click **Confirm** to send the current workspace invitation notification to the invited member. After the members complete the authentication, they can enter.

- Support inviting multiple members at the same time;
- Support for selecting one or more roles to set permissions for new members, or you can create custom roles for members first through [role management](role-management.md).

![](img/8.member_1.png)

### Membership Details

After members are invited into the workspace, click any member to check and view the information of members in **Member Management**, including member name, creation/update time, mailbox, role and role permissions.

![](img/8.member_7.png)

Click the **Edit** button on the right side of the member to support the selection of role permissions and member groups.

![](img/8.member_8.png)

## SSO Management

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; SSO Management doc</font>](./sso/index.md)

<br/>

</div>

## Operations on Member Group

Member groups can indirectly assume the role of alarm notification objects. When enterprises need to set different alarm policies for different teams, they can use this function so that relevant teams can obtain and solve problems at the first time. See [Alarm Policy](../monitoring/alert-setting.md) for more information.

In member management, click **Member Group Management** to enter the member group editing page.

![](img/8.member_9.png)

### Create/Edit Member Group

Enter **Member Group Management > Create Member Group**.

![](img/1-member-3.jpeg)

In the list to be added on the left, all members that are not in this member group are displayed. You can click the search box to search for added members.

![](img/1-member-4.jpeg)

Check the member and click **Confirm** to add the member to the **Member List** on the right.

![](img/1-member-5.jpeg)

![](img/1-member-6.jpeg)

**Note**: When adding members, it will verify whether the name of the member group is duplicate. If the duplicate name cannot be saved, the input box will be marked red and prompt that the name of the member group is duplicate.

### Delete Member Group

Touch a row of member groups, and the **Delete** button will be displayed on the right side. After clicking the **Delete** button, the second confirmation pop-up window will be displayed.

![](img/1-member-1.jpeg)

Click OK to delete the member group.

![](img/1-member-2.png)

### Use Case

You can apply the newly created member group in **Alarm Policy Management** and **Notification Object Management** of **Monitoring**.

1. When you create a new alarm configuration, you can select the newly created member group in **Alarm Notification Object**.

![](img/1-member-management-1.jpeg)

2. When you create a new notification object, you can select the newly created member group in SMS and Mail groups.

![](img/1-member-management-2.png)

