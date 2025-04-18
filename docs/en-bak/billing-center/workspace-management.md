# Workspace Management
---
<!--
Workspace is the basic operation unit of Guance SAAS products, and users can join one or more workspaces by creating/inviting. In a workspace, users can use the basic functions provided by Guance, such as scene data insight, event management, metric management, infrastructure monitoring, log monitoring, APM, RUM, synthetic tests, security check, monitoring, workspace management, etc.
-->

In the Guance Billing Center, one account can bind multiple Guance workspaces. In **Workspace Management**, it is supported to view all workspaces bound under the account, and to modify the settlement methods of bound workspaces, including Guance Billing Center account, AWS cloud account, Alibaba cloud account and Huawei Cloud account.

<font color=coral>**Note:**</font> The settlement method of workspace only supports changing once a month.

![](../img/15.aws_3.png)

## Change Settlement Methods

In the **Workspace Management** of the Guance Billing Center, click **Change Settlement Method** on the right to change the settlement method for the current workspace.

<!--
![](../img/10.account_11.png)
-->

### Guance Billing Center Account Settlement

Guance Billing Center account is an independent account dedicated by Guance Billing Center to manage the billing related generated by using Guance products, and one Billing Center account can be associated with multiple workspace billing. 

> See the doc [Guance Billing Center account Settlement](../../billing/billing-account/enterprise-account.md).


### Cloud Account Settlement

Cloud account settlement includes [AWS account settlement](../../billing/billing-account/aws-account.md), [Alibaba Cloud account settlement](../../billing/billing-account/aliyun-account.md) and [Huawei Cloud Account settlement](../billing-account/huawei-account.md).


### Change and Choose Settlement Method

By default, only Guance Billing Center account and Alibaba Cloud Account can be selected for the workspace registered and logged in through Alibaba Cloud Site, and only Guance Billing Center account and AWS Account can be selected for the workspace registered and logged in through AWS Site. 

> For more site selection, refer to the doc [Choosing a Registered Site](../../getting-started/necessary-for-beginners/select-site.md).

If you need to change the settlement method arbitrarily, you need to open Select Settlement Method Arbitrarily. After opening, all users' workspaces in Guance can choose the settlement methods of Guance Billing Center account and other three cloud accounts at will.

<font color=coral>**Note:**</font> To open **Arbitrary Selection of Settlement Method**, you need to contact the Guance account manager to make changes in the member management of Guance billing platform.

## Lock {#lock}

**Guance Commercial Workspace** settles expenses by binding Guance [Billing Center](../billing/cost-center/index.md) account or cloud account. 

If the account of Billing Center is <u>in arrears or the subscription of the cloud market is abnormal</u>, the action of locking the workspace will be triggered. Guance provides a <font color=coral>14-day countdown</font> to the buffer period. After 14 days, the workspace will be completely locked and new data will stop being reported.

- In the 14-day countdown, you can continue to view and analyze historical data, and you can unlock the state and continue to use Guance;
- After the 14-day countdown, the workspace is prompted to be locked. At this time, the data in the workspace is cleared with one click, and Guance cannot be used any more.


???+ warning "Workspace Locking Instructions"

    - The account number of the Guance Billing Center is settled according to the [billing cycle](./billing-management.md). After the bill is generated, you will receive <u>an email notification of bill generation</u>. If your account is in arrears, a <font color=coral>14-day settlement period</font> will be provided at the same time, and a countdown email notification will be sent to you again near the end of 14 days. If it is not settled after 14 days, the relevant workspace will be locked.        

    - Cloud accounts are divided into Alibaba Cloud account settlement, AWS account settlement and Huawei Cloud account settlement. 

        - Alibaba Cloud Account Settlement: Closure or expiration of instances subscribed in Alibaba Cloud Market will trigger the locking of the associated workspace;
        - AWS account settlement: Cancellation or invalidation of products subscribed in AWS cloud market will trigger locking of associated workspace;
        - Huawei Cloud Account Settlement: Closure or freezing of goods purchased in Huawei Koogallery will trigger locking of associated workspace.

    > For more details, please refer to the doc [Expense Settlement Methods](../billing/billing-account/index.md).


### Unlock {#unlock}

As mentioned above, on the Workspace Lock Prompt page, click **Unlock Now** to jump to the **Workspace Management** page of the Guance Billing Center without logging in. You can click [Change Settlement](../billing-account/index.md) to the current workspace, or click **Billing Center** in the upper left corner to enter the homepage.

> For more recharge methods, see [Account Wallet](../cost-center/account-wallet/index.md).

???+ info "Different Unlock Situations"

    - After recharging, the enterprise certification account will be settled according to the bill. After settlement, the relevant workspace will be unlocked;  
    - For cloud account settlement, in **Workspace Management > Change Settlement**, you can rebind the cloud account, re-subscribe to the related cloud account, or select the Billing Center for settlement, and the related workspace will be unlocked automatically after the operation is completed.


### Dissolve

On the workspace locking prompt page, it is supported to delete the workspace by clicking **Confirm**. After the workspace is deleted, it cannot be restored. Please operate carefully.

<!--
![](../img/dissolve.png)
-->
