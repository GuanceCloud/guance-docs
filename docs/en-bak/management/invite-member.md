# Invite Members

In the current workspace, the Owner, Administrator and custom roles with Member Management permission are able to invite registered users of Guance to become new members of the workspace.

## Invitation Methods

You can invite members through the following two methods:

### :material-numeric-1-circle: Member Management Page

![](img/8.member_1.png)

Go to **Management > Member Management > Invite Members**. In the current window, enter the email address of the invited member and press Enter. Click **Confirm** to send the invitation notification to the invited member for the current workspace. Once the member completes the authentication, they can access.

- Support inviting multiple members at the same time.  
- Support selecting one or more roles to set permissions for new members. You can also create custom roles for members through [Roles](role-management.md).

### :material-numeric-2-circle: Navigation Quick Access {#navigation}

I. On the left navigation bar of the current workspace, click on **Invite Members**:

**Note**: By default, only Read-only members do not have this permission. Other roles have this permission configuration.

<img src="../img/invite.png" width="60%" >

II. Fill in the email of the member to be invited and assign them a role, then click **Confirm**.

<img src="../img/invite-1.png" width="60%" >

After the invitation notification is sent, if the **Settings > Invitation Approval** button is not enabled in the workspace, the invited member can directly enter the workspace.

![](img/invite-2.png)

If it is enabled, you need to go to **Management > Member Management > Invitation history** to process it. **By default, they will not be added to a workspace and require the workspace owner or administrator to click on approval to join**.

## Invitation History

On this page, you can view all the member invitation actions in the current workspace, including their email, assigned role, inviter, invitation time, approval status and other information.

![](img/invite-4.png)

### Invitation List

On the invitation history page, the following operations are supported:

:material-numeric-1-circle-outline: In the upper status bar, it supports filtering according to different status and locking the range quickly.

<img src="../img/invite-3.png" width="70%" >

The meanings of different status values are as follows:

| Status      | Description              |
| ----------- | ------------- |
| Invited      | The invitation has been sent, but the invited members have not yet applied to join the current workspace using the invitation link.              |
| Need Approval      | The invited members have applied to join a workspace and are currently awaiting approval.<br />:warning: Approval actions are only supported in this state.              |
| Joined      | Approved, indicating the status after approval.              |
| Rejected      | Not approved, indicating the status after rejection.             |
| Expired      | Currently, the invitation link for Guance is valid for 1 day. If the invited member does not apply to join before the invitation link expires, the invitation record will display this status.              |

**Note**: If approval is granted and the assigned role for the member no longer exists, the member will be assigned the **Read-only Member** role by default.


:material-numeric-2-circle-outline: In the search bar, you can search by nickname, name or email.

:material-numeric-3-circle-outline: In the action column, if a member's invitation is in the pending approval status, you can choose to approve it or reject it.  

:material-numeric-4-circle-outline: Bulk operations: Click on the :material-square-outline: next to the email, if a member's invitation is in the pending approval status, you can select multiple ones to approve or reject.