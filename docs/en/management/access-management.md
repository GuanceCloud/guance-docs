# Permission Management
---

Guance supports customizing member permissions through **Member Management**. Currently, four types of membership are supported, namely **Owner**, **Administrator**, **Standard** and **Read-only**.


## Membership


| **Roles** | **Description** |
| --- | --- |
| Owner | The owner of the current workspace has the highest operation authority, and can specify the current workspace Administrator and carry out any space configuration management, including upgrading the space payment plan and dissolving the current space.<br /><br />**Note:**<br />- Workspace creator defaults to Owner <br/>- A workspace can only have one Owner<br />- Owner cannot exit the workspace<br />- Owner can transfer permissions to workspace members. After successful transfer, the original Owner is demoted to Administrator<br />- If the current Owner is no longer in the workspace, the earliest Administrator is upgraded to Owner<br /> |
| Administrator | The Administrator of the current workspace can set the user rights as Read-only or Standard, and has the rights of space configuration management, including: accessing the payment plan and list of the current workspace; operating the basic settings of workspace, member management and notification object management; managing data collection, disabling/enabling, editing and deleting; excluding the upgrade space payment plan, dissolve the current space.<br /><br />**Note**: Administrators cannot manipulate the **Dangerous Actions** content (adjust storage policies and delete measurement) |
| Standard | Standard members are able to view, edit, store and share workspace data. |
| Read-only | Read-only members can only view the data in the workspace, and have no permission to modify, edit, save and other operations on the data. |


## Modify Permissions

Guance supports pre-setting membership when inviting members, or changing membership through **Management** > **Member Management**.

- The current workspace Owner can set any membership or transfer the Owner identity to other workspace members.
   - When upgrading the current workspace member to Administrator, the Owner needs to send a verification message to Guance expense center at the same time. If the expense center side **Accepts** the verification, the member's permission will be changed to Administrator; If the Expense Center side **Rejects** the verification, the member's right raising fails.
   - Owner does not need additional validation when upgrading the current workspace member to Read-only or Standard.
- The current workspace Administrator can define Read-only and Standard identities, and cannot modify other Administrator identities.
- If the current workspace is upgraded to commercial plan, upgrading to Administrator requires the Owner to verify in the expense center before it can take effect.

![](img/7.member_1.png)


### Example of Commercial Plan Administrator Authorization Audit

In Guance workspace **Management** > **Member Management**, select the member who needs to be promoted to Administrator, click the **Edit** button on the right, select **Permission** as **Administrator** in the pop-up dialog box, and click **OK**.

Note: Guance only supports Owner to give Administrator rights to current workspace members.<br />![](img/1.limit_2.png)<br />Prompt for permission verification:

- If the current workspace Owner is the Administrator of Guance expense center, you can directly go to the expense center for review without logging in to Guance expense center for operation;
- If the current workspace Owner is not the Administrator of Guance expense center, it is necessary to notify the Administrator of Guance expense center [log in to the expense center](https://boss.guance.com/) for operation.

Note: The members of Guance commercial plan of the workspace need to jump to Guance expense center for review when they go to the Administrator; The free plan does not need to be reviewed by Guance expense center. <br />![](img/1.limit_3.png)<br />In the message center of Guance expense center, click **Accept**. <br />![](img/1.limit_4.png)<br />In the action confirmation dialog box, click **OK**.<br />![](img/1.limit_5.png)<br />You can see that the application has been accepted.<br />![](img/1.limit_6.png)<br />Return to Guance workspace member management, and you can see that workspace members are already Administrator.<br />![](img/1.limit_7.png)


---




