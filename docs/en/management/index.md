---
icon: zy/management
---
# Workspace Management
---

Workspace is the basic operation unit of Guance. In the workspace of Guance, you can use the basic functions provided by Guance, such as scenes, events, metrics, infrastructure, logs, APM, RUM, synthetic tests, CI visibility, security check, monitoring and workspace management.

## Create a Workspace

You can join one or more workspaces by creating or being invited. Before joining the workspace, you need to [register Guance account](https://auth.guance.com/businessRegister). After the registration is completed, the system will create a workspace for you by default and give the **Owner** permission.

After entering the workspace, you can create a new workspace by clicking **Account > Create Workspace** in the lower left corner.

![](img/3.space_management_3.png)

Or you can create a new workspace by clicking **Workspace Name > New Workspace** in the upper left corner. You can also switch to another workspace by clicking on the workspace.

![](img/3.space_management_1.png)



In the following dialog box, enter a workspace name and description, and click OK to create a new workspace. If you need to create an SLS-only workspace, you can open Guance exclusive plan in Alibaba Cloud Market. For more details, please refer to the doc [Guance exclusive plan in Alibaba Cloud Market](../billing/commercial-aliyun-sls.md).

![](img/3.space_management_4.png)

## Workspace Management

Workspace management is the setting, management and operation of the current workspace. After joining the workspace and being assigned permissions, you can manage the basic information, member permissions, SSO login, data permissions, API Key, notification objects, inner views, charts and snapshot sharing of the space through **Management**.

In Guance workspace, Enter **Management > Basic Settings**, In Settings, you can view the current Guance plan, security operation audit and other information. If you are the owner or administrator of the current workspace, you can modify the space name and remarks, change the space Token, modify the description, configure the migration, set the key metrics of the war room, set the IP white list, change the data storage policy, delete the measurement and delete the custom object.
![](img/3.space_management_6.png)

### Notes

Guance supports setting comments for the current workspace, which helps users get information such as workspace name more clearly.

In **Management > Basic Settings > Basic Information**, set the comments information to be viewed.

![](img/3.space_management_7.1.png)

After setting up, you can view the comments information in the upper left workspace.

![](img/3.space_management_7.png)

Click on the workspace name to view all workspaces and their notes, and click the **Edit** button to add or modify the notes.

![](img/3.space_management_7.2.png)

### Replace Token

Guance supports the current space owner and administrator to copy/change the Token in the space, and customize the expiration time of the current Token. Enter **Management > Basic Settings > Replace Token**, select the expiration time and confirm **Replac**, and Guance  will automatically generate a new Token, and the old Token will expire within the specified time.

Note:

- Changing Token triggers **Action Events** and **Notifications**, for details, refer to [audition](../management/operation-audit.md) and [notification](../management/system-notification.md).
- After replacing the Token, the original Token will expire within the specified time. The failure time includes: immediate failure, 10 minutes, 6 hours, 12 hours and 24 hours. Immediate invalidation is generally used for Token leakage. After immediate invalidation is selected, the original Token will stop data reporting immediately. If anomaly detection is set, events and alarm notifications cannot be triggered until the original Token is modified into a newly generated Token in `datakit.conf` of DataKit collector. Refer to the doc [getting started with DataKit](../datakit/datakit-conf.md).

![](/Users/wendy/dataflux-doc/docs/zh/management/img/datakit.png)

### Configure Migration {#export-import}

Guance supports owners and administrators to import and export configuration files of dashboards, custom explorers and monitors in the current workspace with one click, enter **Management > Basic Settings**, and select export or import operations in Configuration Migration.

![](/Users/wendy/dataflux-doc/docs/zh/management/img/1-space-management-2.png)

> **Note**: The current workspace supports importing JSON configurations for dashboards, custom explorers and monitors from other workspaces.

### IP White List

Guance supports configuring IP whitelist for workspace to restrict visiting users. After opening the IP whitelist, only the IP sources in the whitelist can log in normally, and requests from other sources will be denied access.

IP whitelist can only be set by administrators and owners, and owners are not restricted by IP whitelist access.

IP white list writing specification is as follows:

- Multiple IP lines need to be broken. Only one IP or network segment can be filled in each line, and up to 1000 IP lines can be added
- Specify IP address: 192.168.0.1, indicating that access to the IP address of 192.168.0.1 is allowed
- Specifies the IP segment: 192.168.0.0/24, indicating that IP address access from 192.168.0.1 to 192.168.0.255 is allowed.
- All IP addresses: 0.0.0.0/0

![](/Users/wendy/dataflux-doc/docs/zh/management/img/6.space_ip_1.png)

### Change Data Storage Policy

Guance supports owners and administrators to change the data storage strategy in the space, enter **Management > Basic Settings**, click **Change**, select the required data storage time, and click OK to change the data storage time in the current workspace. Refer to the doc [data storage policy](../billing/billing-method/data-storage.md).

### Delete Measurement

Guance supports the owner and administrator to delete the measurement in the space, enter **Management > Basic Settings**, click Delete Measurement, enter the query and select the measurement name (fuzzy matching is supported), and click OK to enter the deletion queue to wait for deletion.
**Note:**

1. Only space owners and administrators are allowed to do this;

1. Once the measurement is deleted, it cannot be restored. Please operate carefully

1. When deleting a measurement, a system notification event will be generated, such as the user created the task of deleting a measurement, the task of deleting a measurement was successfully executed, and the task of deleting a measurement failed.

  

![](/Users/wendy/dataflux-doc/docs/zh/management/img/11.metric_1.png)

### Delete Custom Object

Guance supports owners and administrators to delete specified custom object categories and all custom objects, enter **Management > Basic Settings**, click **Delete Custom Objects**, and select the method of deleting custom objects to delete corresponding object data.

● Specify Custom Object Classification: Only the data under the selected object classification will be deleted, and the index will not be deleted
● All custom objects: Delete all custom object data and indexes

![](/Users/wendy/dataflux-doc/docs/zh/management/img/7.custom_cloud_3.png)

## Lock Workspace {#lock}

Guance Business Workspace settles expenses by binding Guance [Expense Center](../billing/cost-center/index.md) account or cloud account. If the account of Expense Center is in arrears or the subscription of the cloud market is abnormal, the workspace will be locked. After the workspace is locked, the new data will stop being reported. Guance provides a buffer period of 14 days, during which you can continue to view and analyze the historical data, and continue to use Guance by unlocking the lock status.

???+ attention

    Workspace locking instructions:
    
    - The account of Guance Expense Center is divided into personal authentication and enterprise authentication.
        - Personal authentication: the arrears of the expense center account will trigger the locking of the associated workspace
        - Enterprise certification: settlement is carried out according to the billing cycle. After the bill is generated, the customer will be notified by email and a settlement cycle of 14 days will be provided. If the settlement is not completed after 14 days, the associated workspace will be locked.
    - Cloud accounts are divided into Alibaba Cloud account settlement and AWS account settlement. For more details, please refer to the doc [expense settlement method](../billing/billing-account/index.md)
        - Alibaba Cloud Account Settlement: The closure or expiration of an instance of [Alibaba Cloud market subscription](../billing/commercial-aliyun.md) triggers the associated workspace lock
        - AWS account settlement: Cancellation or invalidation of items in [AWS Cloud marketplace subscription](../billing/billing-account/aws-account.md#subscribe) triggers associated workspace locking


- After the workspace is locked, the countdown of the 14-day buffer period will be prompted. Within the countdown of 14 days, new data will stop being reported. Users can close the locking prompt box and continue to view and analyze historical data.

![](img/9.workspace_lock_1.png)

- After the 14-day countdown, the workspace is prompted to be locked. At this time, the data in the workspace is cleared with one click, and Guance cannot be used any more. You can unlock Guance Expense Center by clicking **Unlock Now** before the countdown ends, and you can continue to use Guance after unlocking.

![](img/9.workspace_lock_2.png)

### Unlock Workspace

On the Workspace Lock Prompt page, Click **Unlock Now** to avoid boarding the **Workspace Management** page of Guance Expense Center. You can [change settlement method](../billing/billing-account/index.md) for the current workspace, or click **Guance Expense Center** in the upper left corner to enter the homepage to recharge the current account. For more recharge methods, please refer to the doc [account wallet](../billing/cost-center/account-wallet/index.md).

???+ attention

- If Guance expense center account is settled, it is divided into personal authentication account and enterprise authentication account.
    - The personal authentication account will be deducted automatically after recharging. If the balance after deduction is greater than or equal to 0, the locked workspace will be unlocked.
    - After the enterprise authentication account is recharged, it will be settled according to the bill. After settlement, it will unlock the locked related workspace.
- For cloud account settlement, in **Workspace Management > Change Settlement Method**, rebind the cloud account, or re-subscribe to the related cloud account, or select Guance Expense Center for settlement, and the locked related workspace will be unlocked automatically.

![](img/9.workspace_lock_3.png)

### Dissolve Workspace

On the workspace locking prompt page, it is supported to delete the workspace by clicking **Dissolve**. After the workspace is deleted, it cannot be restored. Please operate carefully.

![](img/9.workspace_lock_4.png)

## Data Isolation and Data Authorization

If your company has multiple departments that need to isolate data, you can create multiple workspaces and invite related departments or stakeholders to join the corresponding workspaces.

If you need to view the data of different workspaces in all departments in a unified way, you can authorize the data of multiple workspaces to the current workspace by configuring data authorization, and query and display them through the scene dashboard and chart components of notes. For more configuration details, please refer to the doc [data authorization](https://preprod-docs.cloudcare.cn/management/data-authorization/).
