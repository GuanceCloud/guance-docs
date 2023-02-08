# Membership Management
---

Guance supports the current space owner/administrator to manage all members of the current space uniformly through "management"-"member management", including adding/editing/deleting space members and modifying member permissions.

## Invite Members

Within the current space, the space "owner" and "administrator" can invite registered users of Guance to become new members of the workspace.

- Through "Management"-"Member Management"-"Invite Members", enter the email address of the invited member, enter, and click "OK" to send the current workspace invitation notification to the invited member. After the members complete the authentication, they can enter.

![](img/1.member_2.png)

- When adding new members, the default member permissions of Guance are read-only members, and you can set the permissions of new members by "Edit".

![](img/1.member_1.png)



## Rights Management

Guance currently supports four kinds of membership permissions, namely "owner", "administrator", "standard member" and "read-only member".

Note: Users who log in through SSO authorization will be identified as SSO users, and the default permission is "read-only member", which supports upgrading permission to "administrator".

| **Role** | **Description**                                                     |
| -------- | ------------------------------------------------------------ |
| Owner   | The owner of the current workspace has the highest operation authority, and can specify the current space "administrator" and carry out any space configuration management, including upgrading the space payment plan and dissolving the current space.<br />**Notes:**<br /><li>Workspace creator defaults to "owner"<br /><li>A workspace can only have one "owner"<br /><li> "Owner" cannot exit workspace<br /><li> The "owner" can transfer the authority to the space member, and the original "owner" will be demoted to "administrator" after successful transfer<br /><li>If the current "owner" is no longer in the workspace, the earliest administrator is upgraded to "owner"<br /> |
| Administrator   | The administrator of the current workspace can set the user rights as "read-only member" or "standard member", and has the rights of space configuration management, including: accessing the payment plan and list of the current workspace; operating the basic settings of workspace, member management and notification object management; managing data collection, disabling/enabling, editing and deleting; excluding the upgrade space payment plan, dissolve the current space.<br />**Notes**: Administrators cannot manipulate the "dangerous actions" content (adjust storage policies and delete measurements) |
| Standard member | You can only view the data in the workspace, and have no right to modify, edit, save and other operations on the data.                 |
| Read-only member | You are allowed to view, edit, store and share workspace data |


### Modify Permissions

Guance supports pre-setting membership when inviting members, or changing membership through "management"-"member management".

- The current workspace "owner" can set any membership or transfer the "owner" identity to other workspace members
    - If the current workspace is upgraded to the commercial plan, the "owner" needs to send a verification message to Guance expense center when upgrading the current workspace member to the "administrator". If the expense center side "accepts" the verification, the member's permission will be changed to "administrator"; If the cost center side "rejects" the verification, the member's right raising fails
    - "Owner" does not need additional validation when upgrading the current workspace member to "read-only member" or "standard member"
- The current workspace "manager" can define "read-only member" and "standard member" identities, and cannot modify other administrator identities

![](img/1.member_1.png)


### Example of Commercial Plan Administrator Authorization Audit

In the Guance workspace "Management"-"Member Management", select the member who needs to be promoted to administrator, click the "Edit" button on the right, select "Permission" as "Administrator" in the pop-up dialog box, and click "OK".

Note: Guance only supports "owner" to give "administrator" rights to current workspace members.

![](img/1.limit_2.png)

Prompt for permission verification:

- If the current workspace owner is the administrator of the Guance expense center, you can directly click "Go to the expense center for review" without logging in to the Guance expense center for operation;
- If the current workspace owner is not the administrator of the Guance expense center, it is necessary to notify the administrator of the Guance expense center [log in to the expense center](https://boss.guance.com/).

Note: The members of Guance commercial version of the workspace need to jump to Guance expense center for review when they go to the "administrator"; The free version does not need to be reviewed by Guance Expense Center.

![](img/1.limit_3.png)

In the message center of Guance expense center, click "Accept".

![](img/1.limit_4.png)

In the "Action Confirmation" dialog box, click "OK".

![](img/1.limit_5.png)

It can be seen that the petition has been accepted.

![](img/1.limit_6.png)

Return to Guance workspace member management, and you can see that the workspace member is already an "administrator".

![](img/1.limit_7.png)




## 搜索成员

成员管理支持账号类型筛选，包括「全部」、「SSO账号」和「普通账号」，支持基于类型筛选结果进行搜索，您可以通过成员邮箱或姓名快速匹配相关成员。

![](img/1.member_3.png)


## 修改/删除成员

在当前空间内，"拥有者”和“管理员”可在「管理」-「成员管理」页面中，删除已添加的成员。

![](img/1.member_3.png)

## 成员分组

在成员管理页面，点击「成员组管理」，可进入成员组编辑页面。

![](img/1-member-7.png)

### 新建/编辑成员组

进入「成员组管理」-「新建成员组」。

![](img/1-member-3.png)

在左侧待添加列表里，显示所有不在这个成员组内的成员，您可以点击搜索框搜索代添加成员。

![](img/1-member-4.png)

勾选该成员，点击「确定」后即可将该成员添加至右侧「成员列表」。

![](img/1-member-5.png)

![](img/1-member-6.png)

**注意**：在进行添加成员操作时会验证成员组名称是否重复，重名则无法保存，输入框标红并提示成员组名称重复。

### 删除成员组

轻触一行成员组，右侧显示删除按钮，点击删除键后，显示二次确认弹窗。

![](img/1-member-1.png)

点击「确定」，即可删除该成员组。

![](img/1-member-2.png)

### 应用场景

您可以在「监控」的「告警策略管理」和「通知对象管理」中应用已新建的成员组。

1.在您新建告警配置时，支持在「告警通知对象」中选择已新建的成员组。

![](img/1-member-management-1.png)

2.在您新建通知对象时，支持在短信和邮件组选择已新建的成员组。

![](img/1-member-management-2.png)