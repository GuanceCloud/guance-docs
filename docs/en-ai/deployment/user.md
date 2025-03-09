# User Management
---

<<< custom_key.brand_name >>> backend management system supports unified management of all workspace members.


## Members


### Add Member {#add}

#### Create User Account

<img src="../img/17.deployment_2.png" width="70%" >

1. On the **Users** page, click **Add User** at the top right.
2. In the pop-up dialog box, enter member information and click **Confirm** to add a new user.
3. If you need to add more users, click **Continue Creating Next** directly.

#### Invite via Email {#via-email}

<img src="../img/17.deployment_2_1.png" width="70%" >

1. Enter the email addresses to be added, multiple emails can be separated by spaces, commas, or semicolons. The system will automatically generate an 8-character initial password for the email user and send it to the email address.
2. Select a group.
3. Click **Add Workspace** to assign workspaces and set groups for the added members.


### Manage Members

1. Click the **Workspace** that the user belongs to, and enter the workspace member management to modify the group information and assigned workspaces for the member.

2. Disable/Enable Members: Click **Batch Operations**, and you can disable or enable the selected members' account status in one go; batch modifications are supported.

3. Click **Reset Password** to change the password for the workspace member.

4. Click **Edit** next to the account, enter the edit member information page. You can modify the user's email, name, and contact phone number; you can also add/edit/delete the user's assigned workspaces and corresponding roles.


### Delete Member {#delete}

When deleting an account, if the account has the owner role in a workspace, you need to remove this role first:

<img src="../img/de-owner.png" width="60%" >

Under the premise that the current account is not an owner, the deletion operation can be completed:

<img src="../img/de-owner-1.png" width="60%" >


???+ warning "Precautions for Deleting Accounts:"

    1. Deletion operations can be performed on both local accounts and single sign-on (SSO) accounts.
    2. After an SSO account is deleted, if the same account logs in through the SSO entry point, the account will be recreated.

### Edit Member {#edit}

In addition to modifying the member's email, name, and contact phone number, you can also add extended attributes to them. Based on these attributes, platform administrators can manage better.

<img src="../img/de-owner-attribute.png" width="60%" >

When configuring attributes, there are two scenarios for different users:
    
- Local users can directly configure attributes on the edit page.
- During SSO login, third-party user attributes are automatically appended to <<< custom_key.brand_name >>> via the `userinfo` interface; these attributes cannot be edited or deleted again.
- SSO users can customize and add attribute information, which can be edited later.

**Note**:

1. Attribute information will be displayed in the member management section of the <<< custom_key.brand_name >>> console;

2. All attribute contents will eventually be synchronized to Webhook outputs and corresponding event content areas;

3. If the added attribute fields include a contact phone number, notifications can be received via this phone number after synchronization; otherwise, notifications will be received via the contact phone number in the user information.

## Groups {#team}

### Create Group

Click **Add Group** at the top right to open the creation window:

![](img/user-1.png)

Enter the group name, and optionally choose whether to add members to all workspaces under the current group, then click confirm to create successfully. Subsequently, you can modify role permissions in the Actions > Manage Workspaces section.

### Group List


1. In the search bar, you can input the group name to search and locate;
2. Hover over the **Members** and **Workspaces** columns to display detailed information;
3. Click Edit to modify the current group;
4. Click Delete, if the group has members, they will automatically exit the associated workspaces after deletion;
5. In the Actions column, click Manage Workspaces to uniformly assign workspaces and grant corresponding roles to the members of the group.

<img src="../img/user-2.png" width="70%" >