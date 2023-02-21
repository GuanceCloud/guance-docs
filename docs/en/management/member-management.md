# Membership Management
---

Guance supports to manage all members of the current space uniformly, including adding/editing/deleting space members and modifying member permissions.

> Only **Owner**, **Administrator** and custom roles of the workspace that are authorized with **Member Management** permissions manage members uniformly. See the doc [role management](role-management.md) for more details.

## Member Search and Operation Management

### Search Member

Member management supports quick access to relevant member lists through search and quick filtering.

- Search: Support searching for members' mailboxes, names and login types
- Quick Filtering: Support filtering members' roles, member groups and login types

![](img/8.member_10.png)

### Batch Modify Member Permissions

In member management, click **Batch Modify Permissions**, select the member that needs to batch modify permissions, click **Modify**, select permissions for the member in the pop-up dialog box and then **Confirm**.

> Only **Owner** and **Administrator** can modify member permissions in batch.

![](img/8.member_3.png)

### Modify/Delete Members

- In member management, select the member to be modified, and click the **Modify** button on the right to modify permissions and member groups for the member. Multiple roles can be configured for the member.
- In member management, select the member to be deleted, and click the **Delete** button on the right.

> Only Owner and Administrator can delete members. Owner itself cannot be deleted, but can be deleted by transferring Owner to Administrator.

## Invite Members

In the current space, Owner, Administrator and custom roles authorized with **Member Management** permissions can invite registered users of the observation cloud to become new members in the workspace.

Through **Management > Member Management > Invite Members**, enter the email address of the invited member, enter, and click OK to send the current workspace invitation notification to the invited member. After the members complete the authentication, they can enter.

- Support inviting multiple members at the same time;
- Support for selecting one or more roles to set permissions for new members, or you can create custom roles for members first through [role management](role-management.md).

![](img/8.member_1.png)

### Membership Details

After members are invited into the workspace, click any member to check and view the information of members in **Member Management**, including member name, creation/update time, mailbox, role and role permissions.

![](img/8.member_7.png)

Click the **Edit** button on the right side of the member to support the selection of role permissions and member groups.

![](img/8.member_8.png)

## SSO Management

In addition to inviting members, Guance supports enterprises to manage employee information in local IdP (identity provider), and access Guance by configuring SSO. Without user synchronization between Guance and the enterprise IdP, enterprise employees can log in to access Guance through designated roles.

In member management, click to enter **SSO Management**, and you can:

- Set up single sign-on for employees based on enterprise domain name: as long as employees who meet the unified identity authentication of enterprises can single sign-on to Guance, the access rights can choose read-only members or standard members;
- Based on the enterprise domain name and SAML mapping relationship, provide a more detailed single sign-on scheme for enterprises: after SAML mapping is turned on, it supports the dynamic allocation of access rights for enterprise employees, and employees can access Guance according to the assigned role rights;
- Set the single sign-on member session retention time

See the doc [SSO Management](sso/index.md).

![](img/9.member_sso_1.png)

## Membership Group Management

If an enterprise needs to set different alarm policies for different teams, so that relevant teams can obtain and solve fault problems at the first time, it can set a member group, and relevant team members to the member group, and then set the alarm notification object as the member group in the alarm strategy. Refer to the doc [alarm policy](../monitoring/alert-setting.md).

In member management, click **Member Group Management** to enter the member group editing page.

![](img/8.member_9.png)

### New/Edit Member Group

Enter **Member Group Management > New Member Group**.

![](img/1-member-3.jpeg)

In the list to be added on the left, all members that are not in this member group are displayed. You can click the search box to search for added members.

![](img/1-member-4.jpeg)

Check the member and click OK to add the member to the **Member List** on the right.

![](img/1-member-5.jpeg)

![](img/1-member-6.jpeg)

**Note**: When adding members, it will verify whether the name of the member group is duplicate. If the duplicate name cannot be saved, the input box will be marked red and prompt that the name of the member group is duplicate.

### Delete Member Group

Touch a row of member groups, and the **Delete** button will be displayed on the right side. After clicking the **Delete** button, the second confirmation pop-up window will be displayed.

![](img/1-member-1.jpeg)

Click OK to delete the member group.

![](img/1-member-2.png)

### Application Scenarios

You can apply the newly created member group in **Alarm Policy Management** and **Notification Object Management** of **Monitoring**.

1.When you create a new alarm configuration, you can select the newly created member group in **Alarm Notification Object**.

![](img/1-member-management-1.jpeg)

2.When you create a new notification object, you can select the newly created member group in SMS and Mail groups.

![](img/1-member-management-2.png)

