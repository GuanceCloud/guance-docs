# User Management
---

Guance's backend management system supports unified management of all workspace members.


## Members


### Adding Members {#add}

#### Creating User Accounts

<img src="../img/17.deployment_2.png" width="70%" >

1. On the **User** page, click **Add User** in the top-right corner.
2. In the pop-up dialog, fill in the member information and click **Confirm** to add a new user.
3. If you need to add more users, click **Continue Creating Next** directly.

#### Inviting via Email {#via-email}

<img src="../img/17.deployment_2_1.png" width="70%" >

1. Enter the email addresses to be added, using spaces, commas, or semicolons to separate multiple emails. The system will automatically generate an 8-character initial password for the email user and send it to the email address.
2. Select the group.
3. Click **Add Workspace** to assign a workspace to the added member and set the group.

### Managing Members

1. Click the user's **Workspace** to enter workspace member management and modify the member's group information and associated workspace.

2. Disable/Enable Members: Click **Batch Operations** to disable or enable selected members' account statuses in bulk; batch modifications are supported.

3. Click **Reset Password** to change the workspace member's password.

4. Click **Edit** next to the account to enter the edit member information page. You can modify the user's email, name, and contact phone number; you can also add/edit/delete the user's associated workspaces and corresponding roles.


### Deleting Members {#delete}

When deleting an account, if the account has the owner role in any workspace, you must first remove this role:

<img src="../img/de-owner.png" width="60%" >

Under the premise that the current account is not an owner, the deletion operation can be completed:

<img src="../img/de-owner-1.png" width="60%" >


???+ warning "Precautions for Deleting Accounts:"

    1. Deletion operations can be performed on both local accounts and single sign-on (SSO) accounts.
    2. After an SSO account is deleted, if the same account logs in through the SSO entry, the account will be recreated.

### Editing Members {#edit}

In addition to modifying the member's email, name, and contact phone number, you can also add extended attributes. This helps platform administrators manage better.

<img src="../img/de-owner-attribute.png" width="60%" >

When configuring attributes, two scenarios may occur for different users:

- Local users can configure attributes directly on the edit page.
- SSO users have their third-party attributes automatically appended to Guance via the `userinfo` interface, and these attributes cannot be edited or deleted.
- SSO users can add custom attribute information, which can later be edited.

**Note**:

1. Attribute information will be displayed in the member management section of the Guance console;
2. All attribute information will eventually be synchronized to Webhook and corresponding event content areas;
3. If the added attribute fields include a contact phone number, the phone number will receive alert notifications; otherwise, the contact phone number in the user information will be used.


## Groups {#team}

### Creating a Group

Click **Add Group** in the top-right corner to open the creation window:

![](img/user-1.png)

Enter the group name and optionally choose whether to add members to all workspaces under the current group. Click **Confirm** to create the group successfully. You can later modify role permissions in the operation bar > manage workspace.

### Group List

1. In the search bar, you can input the group name to search and locate it;
2. Hover over the **Members** and **Workspaces** columns to display detailed information;
3. Click **Edit** to modify the current group;
4. Click **Delete**, if the group has members, they will automatically exit the group's workspaces after deletion;
5. In the operation bar, click **Manage Workspaces** to uniformly assign workspaces and grant corresponding roles to the group's members.

<img src="../img/user-2.png" width="70%" >