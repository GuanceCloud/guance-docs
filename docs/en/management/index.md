---
icon: zy/management
---
# Workspace Management
---

Workspace is the basic operation unit of Guance. This feature interpretation part will show you workspace-related operations and personal settings.

## Workspace

### Join
 
Afetr you have [registered a Guance account](https://auth.guance.com/businessRegister), you will join a workspace the system created by default, in which you enojoy the **Owner** permission. Of course, you can join one or more workspaces by creating or being invited.

- After entering the workspace, you can create a new workspace by clicking **Account > Create Workspace** in the lower left corner.

![](img/3.space_management_3.png)

- Or you can create a new workspace by clicking **Workspace Name > Create Workspace** in the upper left corner. You can also switch to another workspace by clicking on the workspace.

![](img/3.space_management_1.png)



In the following dialog box, enter a workspace name and description, and click **Confirm** to create a new workspace. If you need to create a SLS workspace of Exclusive Plan, you can open Guance Exclusive Plan in Alibaba Cloud Market. For more details, please refer to the doc [Guance Exclusive Plan in Alibaba Cloud Market](../billing/commercial-aliyun-sls.md).

> Workspace language options affect templates for events, alarms and text messages in the workspace. If you select English, the above corresponding template will be used by default. Once created, the template language of this workspace cannot be modified, so please choose carefully.

![](img/3.space_management_4.png)

### Lock {#lock}

Guance Commercial Workspace settles expenses by binding Guance [Expense Center](../billing/cost-center/index.md) account or cloud account. If the account of Expense Center is in arrears or the subscription of the cloud market is abnormal, the workspace will be locked. After the workspace is locked, the new data will stop being reported.

???+ attention

    Workspace locking instructions:
    
    - The account number of the Guance expense center is settled according to the billing cycle. After the bill is generated, the customer will be notified by email and a 14-day settlement cycle will be provided. If the settlement is not completed after 14 days, the associated workspace will be locked.              
    - Cloud accounts are divided into Alibaba Cloud account settlement and AWS account settlement. For more details, please refer to the doc [expense settlement method](../billing/billing-account/index.md)
        - Alibaba Cloud Account Settlement: The closure or expiration of an instance of [Alibaba Cloud market subscription](../billing/commercial-aliyun.md) triggers the associated workspace lock
        - AWS account settlement: Cancellation or invalidation of items in [AWS Cloud marketplace subscription](../billing/billing-account/aws-account.md#subscribe) triggers associated workspace locking


- After the workspace is locked, the countdown of the 14-day buffer period will be prompted. Within the countdown of 14 days, new data will stop being reported. Users can close the locking prompt box and continue to view and analyze historical data.

![](img/9.workspace_lock_1.png)

- After the 14-day countdown, the workspace is prompted to be locked. At this time, the data in the workspace is cleared with one click, and Guance cannot be used any more. You can unlock Guance Expense Center by clicking **Unlock Now** before the countdown ends, and you can continue to use Guance after unlocking.

![](img/9.workspace_lock_2.png)

### Unlock

On the Workspace Lock Prompt page, Click **Unlock Now** to jump to the **Workspace Management** page of Guance Expense Center without loging. You can [change settlement method](../billing/billing-account/index.md) for the current workspace, or click **Guance Expense Center** in the upper left corner to enter the homepage to recharge the current account. For more recharge methods, please refer to the doc [Account Wallet](../billing/cost-center/account-wallet/index.md).

???+ attention

    - After the enterprise authentication account is recharged, it will be settled according to the bill. After settlement, it will unlock the locked related workspace.     
    - For cloud account settlement, in **Workspace Management > Change Settlement Method**, you can rebind the cloud account, re-subscribe to the related cloud account, or select Guance Expense Center for settlement, and then the locked related workspace will be unlocked automatically.

![](img/9.workspace_lock_3.png)

### Dissolve

On the workspace locking prompt page, it is supported to delete the workspace by clicking **Dissolve**. After the workspace is deleted, it cannot be restored. Please operate carefully.

![](img/9.workspace_lock_4.png)


## Data Isolation and Authorization

If your company has multiple departments that need to isolate data, you can create multiple workspaces and invite related departments or stakeholders to join the corresponding workspaces.

If you need to view the data of different workspaces in all departments in a unified way, you can authorize the data of multiple workspaces to the current workspace by configuring [data authorization](data-authorization.md), and query and display them through the scene dashboard and chart components of notes.

## Settings

After joining the workspace and being assigned permissions, you can see a series of settings.
 
![](img/3.space_management_6.png)

### Remark

In **Management > Basic Settings > Basic Information**, set the comments information to be viewed.

![](img/3.space_management_7.1.png)

After setting up, you can view the comments information in the upper left workspace.

![](img/3.space_management_7.png)

Click on the workspace name to view all workspaces and their remarks, and click **Edit** to add or modify the notes.

![](img/3.space_management_7.2.png)

### Replace Token

Guance supports the current space owner and administrator to copy/change the Token in the space, and customize the expiration time of the current Token. 

Enter **Replace Token**, select the expiration time and confirm **Replace**. Then Guance will automatically generate a new Token and the old Token will expire within the specified time.

Note:

- Changing Token triggers **Action Events** and **Notifications**. See [Audit](../management/operation-audit.md) and [Notification](../management/system-notification.md) for more information.  
- After replaced, the original Token will expire within the specified time. The failure time includes: immediate failure, 10 minutes, 6 hours, 12 hours and 24 hours.<br/>
> Immediate invalidation is generally used for Token leakage. After it is selected, the original Token will stop data reporting immediately. If anomaly detection is set, events and alarm notifications cannot be triggered until the original Token is modified into a newly generated Token in `datakit.conf` of DataKit collector. See [Getting Started with DataKit](../datakit/datakit-conf.md) for more information.

![](img/datakit.png)

### Configure Migration {#export-import}

Owners and administrators can import and export configuration files of dashboards, custom explorers and monitors in the current workspace.   
Enter **Configuration Migration** and select **Export** or **Import**.

When importing, if there are dashboards, explorers and monitors with duplicate names in the current workspace, the user can choose whether to **Skip**, **Still Create** and **Cancel** according to your actual needs.

- Skip: **only create files with non-duplicate name**.  
- Still Create: Create the corresponding dashboard, explorers and monitor according to the imported file name.  
- Cancel: Cancel this file import operation, that is, no file import.

> **Note**: The current workspace supports importing JSON configurations for dashboards, custom explorers and monitors from other workspaces.

![](img/5.input_rename_1.png)

### Advanced Settings

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Key Metrics</font>](key-metrics.md#)

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Feature Menu</font>](customized-menu.md#)

### IP White List

IP whitelist is used to restrict visiting users. After opening the IP whitelist, only the IP sources in the whitelist can log in normally, and requests from other sources will be denied access.

> IP whitelist can only be set by administrators and owners, and owners are not restricted by IP whitelist access.

IP white list writing specification is as follows:

- Multiple IP lines need to be broken. Only one IP or network segment can be filled in each line, and up to 1000 IP lines can be added
- Specified IP address: **192.168.0.1**, indicating that access to the IP address of 192.168.0.1 is allowed.
- Specified IP segment: **192.168.0.0/24**, indicating that IP address access from 192.168.0.1 to 192.168.0.255 is allowed.
- All IP addresses: **0.0.0.0/0**.

![](img/6.space_ip_1.png)

### Change Data Storage Policy

Guance supports owners to change the data storage strategy in the space, enter **Management > Basic Settings**, click **Change**, select the required data storage time, and click OK to change the data storage time in the current workspace. See [Data Storage Policy](../billing/billing-method/data-storage.md) for more information.

### Delete Measurement

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Delete Measurement</font>](collection.md#delete)

<br/>

</div>

### Delete Custom Object

Owners and administrators can delete specified custom object categories and all custom objects, click **Delete** and select the method of deleting custom objects to delete corresponding object data.

- Specify custom object classification: Only the data under the selected object classification will be deleted, and the index will not be deleted.  
- All custom objects: Delete all custom object data and indexes.

![](img/7.custom_cloud_3.png)


