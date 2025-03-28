# Invite Members

In the current workspace, Owners, Administrators, and custom roles authorized with **Member Management** permissions can invite registered <<< custom_key.brand_name >>> users to become new members of the workspace.

## Invitation Entry Points

You can invite members through the following two entry points:

### :material-numeric-1-circle: Member Management Page

![](img/8.member_1.png)

Go to **Management > Member Management > Invite Members**, in the current window, enter the email address of the invited member and press Enter. Click **Confirm** to send an invitation notification for the current workspace to the invited member. After the member completes verification, they can enter.

- Supports inviting multiple members at once.
- Supports selecting one or more roles to set permissions for new members. You can also create custom roles for members via [Role Management](role-management.md).

### :material-numeric-2-circle: Navigation Bar Shortcut {#navigation}

1. In the left navigation bar of the current workspace, click **Invite Members**:

**Note**: By default, only members with roles other than **Read-only Member** have this permission.

<img src="../img/invite.png" width="60%" >

2. Enter the email of the invited member and assign a role, then click **Confirm**.

<img src="../img/invite-1.png" width="60%" >

After sending the invitation notification, if the **Settings > Invitation Approval** button is not enabled, the invited member can directly enter the workspace.

<img src="../img/invite-2.png" width="70%" >

If it is enabled, you need to go to **Management > Invitation Records** for processing. <u>By default, the member will not be added to any workspace and requires approval from the workspace owner or administrator to join</u>.

## Invitation Records

On this page, you can view all member invitation actions within the current workspace, including their emails, assigned roles, inviter, invitation time, and approval status.

![](img/invite-4.png)

### Record List

On the invitation records page, the following operations are supported:

:material-numeric-1-circle-outline: In the top status bar, filter by different statuses to quickly narrow down the scope.

<img src="../img/invite-3.png" width="70%" >

The meanings of different status values are as follows:

| Status Value | Meaning |
| ------------ | ------- |
| Pending Response | The invitation has been sent, but the invited member has not yet applied to join the current workspace via the invitation link. |
| Pending Approval | The invited member has applied to join a workspace and is awaiting approval; <br />:warning: Only supports approval operations in this state. |
| Approved | Approved, indicating the post-approval status. |
| Rejected | Not approved, indicating the post-approval status. |
| Expired | Currently, <<< custom_key.brand_name >>> invitation links are valid for 1 day. If the invited member does not apply to join before the link expires, the invitation record will show this status. |

**Note**: If the assigned role no longer exists when approval is granted, the member will be assigned the **Read-only Member** role by default.

:material-numeric-2-circle-outline: In the 🔍 search bar, you can search by nickname, name, or email.

:material-numeric-3-circle-outline: In the action column, if a member's invitation is in the "Pending Approval" status, you can choose to approve or reject it.

:material-numeric-4-circle-outline: Batch Operations: Click the :material-square-outline: next to the email. If a member's invitation is in the "Pending Approval" status, you can batch select to approve or reject them.