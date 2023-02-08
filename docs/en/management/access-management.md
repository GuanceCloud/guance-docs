# Rights Management
---

Guance supports customizing member permissions through Member Management. Currently, four types of membership are supported, namely "owner", "administrator", "standard member" and "read-only member".


## Membership

Guance currently supports four kinds of membership, namely "Owner", "Administrator", "Standard Member" and "Read-Only Member".

| **Roles** | **Description** |
| --- | --- |
| Owner | The owner of the current workspace has the highest operation authority, and can specify the current space "administrator" and carry out any space configuration management, including upgrading the space payment plan and dissolving the current space.<br /><br />**Note:**<br />- Workspace creator defaults to owner <br/>- A workspace can only have one owner<br />- Owner cannot exit the workspace<br />- Owner can transfer permissions to space members. After successful transfer, the original owner is demoted to "administrator"<br />- If the current "owner" is no longer in the workspace, the earliest administrator is upgraded to "owner"<br /> |
| Administrator | The administrator of the current workspace can set the user rights as "read-only member" or "standard member", and has the rights of space configuration management, including: accessing the payment plan and list of the current workspace; operating the basic settings of workspace, member management and notification object management; managing data collection, disabling/enabling, editing and deleting; excluding the upgrade space payment plan, dissolve the current space.<br /><br />**Note**: Administrators cannot manipulate the "dangerous actions" content (adjust storage policies and delete measurement) |
| Standard member | You are allowed to view, edit, store and share workspace data. |
| Read-only member | You can only view the data in the workspace, and have no right to modify, edit, save and other operations on the data. |


## Modify permissions

Guance supports pre-setting membership when inviting members, or changing membership through "Management"-"Member Management".

- The current workspace "owner" can set any membership or transfer the "owner" identity to other workspace members
   - When upgrading the current workspace member to "administrator", the "owner" needs to send a verification message to Guance expense center at the same time. If the expense center side "accepts" the verification, the member's permission will be changed to "administrator"; If the cost center side "rejects" the verification, the member's right raising fails
   - "Owner" does not need additional validation when upgrading the current workspace member to "read-only member" or "standard member"
- The current workspace "manager" can define "read-only member" and "standard member" identities, and cannot modify other administrator identities
- If the current workspace is upgraded to commercial plan, upgrading to "administrator" requires the owner to verify in the expense center before it can take effect

![](img/7.member_1.png)


### Example of Commercial Plan Administrator Authorization Audit

In Guance workspace "Management"-"Member Management", select the member who needs to be promoted to administrator, click the "Edit" button on the right, select "Permission" as "Administrator" in the pop-up dialog box, and click "OK".

Note: Guance only supports "owner" to give "administrator" rights to current workspace members.<br />![](img/1.limit_2.png)<br />Prompt for permission verification:

- If the current workspace owner is the administrator of Guance expense center, you can directly click "Go to the expense center for review" without logging in to Guance expense center for operation;
- If the current workspace owner is not the administrator of Guance expense center, it is necessary to notify the administrator of Guance expense center [log in to the expense center](https://boss.guance.com/) for operation.

Note: The members of Guance commercial plan of the workspace need to jump to Guance expense center for review when they go to the "administrator"; The free version does not need to be reviewed by Guance expense center. <br />![](img/1.limit_3.png)<br />In the message center of Guance expense center, click Accept. <br />![](img/1.limit_4.png)<br />In the action confirmation dialog box, click OK.<br />![](img/1.limit_5.png)<br />You can see that the application has been accepted.<br />![](img/1.limit_6.png)<br />Return to Guance workspace member management, and you can see that workspace members are already "administrators."<br />![](img/1.limit_7.png)


---




