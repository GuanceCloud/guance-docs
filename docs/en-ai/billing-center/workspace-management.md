# Workspace Management
---

In the Guance billing center, a single account can be associated with multiple Guance workspaces. In **Manage Workspaces**, you can view all workspaces linked to your account and modify the billing method for each workspace, including four types of billing methods: Guance billing center account, AWS account, Alibaba Cloud account, and Huawei Cloud account.

**Note**: The billing method for a workspace can only be changed once per month.

![](img/15.aws_3.png)

## Change Billing Method

In the Guance billing center **Manage Workspaces**, click **Change Billing Method** on the right side to change the [billing method](../billing-account/index.md) for the current workspace. You can choose from four billing methods: Guance billing center account, AWS account, Alibaba Cloud account, and Huawei Cloud account.

![](img/10.account_11.png)

### Guance Billing Center Account Billing

The Guance billing center account is a dedicated account used by the Guance billing center to manage charges related to the use of Guance products. A single billing center account can be associated with multiple workspace billings.

> For more details, refer to [Guance Billing Center Account Billing](../../billing/billing-account/enterprise-account.md).


### Cloud Account Billing

Cloud account billing includes [AWS account billing](../../billing/billing-account/aws-account.md), [Alibaba Cloud account billing](../../billing/billing-account/aliyun-account.md), and [Huawei Cloud account billing](../../billing/billing-account/huawei-account.md).


### Arbitrary Selection of Billing Method

By default, workspaces registered and logged in through the **Alibaba Cloud site** can only choose between **Guance billing center account** and **Alibaba Cloud account** billing methods. Workspaces registered and logged in through the **AWS site** can only choose between **Guance billing center account** and **AWS account** billing methods.

> For more site selection options, refer to the documentation [Site Description](../commercial-register.md#site).

If you need to arbitrarily change the billing method, you need to enable **Arbitrary Selection of Billing Method**. After enabling, all user workspaces in Guance can freely choose between **Guance billing center account**, **Alibaba Cloud account**, **AWS account**, and **Huawei Cloud account** billing methods.

**Note**: Enabling **Arbitrary Selection of Billing Method** requires contacting a Guance customer manager to make changes in the Guance billing platform membership management.


## Workspace Lock {#workspace-lock}

### Lock {#lock}

Commercial Plan workspaces in Guance are billed by associating a Guance [billing center](../billing-center/index.md) account or cloud account.

If there are issues such as an overdue billing center account or abnormal cloud market subscription, it will trigger the action to lock the workspace. Guance provides a 14-day grace period countdown. After 14 days, the workspace will be fully locked, and new data reporting will stop.

- Within the 14-day countdown, you can continue to view and analyze historical data and can [unlock the workspace](#unlock) to continue using Guance;

![](img/9.workspace_lock_1.png)

- After the 14-day countdown ends, the workspace will be locked, and its data will be cleared with one click. If you still need to use Guance products, you can choose to switch workspaces or directly click below to create a new workspace.

![](img/9.workspace_lock_2.png)
    
???+ abstract "Workspace Lock Explanation"

    - The Guance billing center account is settled according to the [invoice](../cost-center/billing-management.md) cycle. After the invoice is generated, you will receive an email notification of the invoice generation. If your account is overdue, you will also be provided with a 14-day settlement period. Near the end of the 14 days, another countdown email notification will be sent to you. If the account remains unsettled after 14 days, the relevant workspace will be locked.


### Unlock {#unlock}

As mentioned above, on the workspace lock prompt page, click **Unlock Immediately** to redirect to the **Workspace Management** page of the Guance billing center without logging in. You can [change the billing method](../../billing/billing-account/index.md) for the current workspace or click the **Guance Billing Center** in the top-left corner to enter the homepage and recharge the current account.

> For more recharge methods, refer to the documentation [Account Wallet](../../billing/cost-center/account-wallet/index.md).

???+ abstract "Different Unlock Scenarios"

    - After recharging an enterprise-certified account, it will be settled according to the invoice. After settlement, the relevant workspace will be unlocked;

    - For cloud account billing, in **Workspace Management > Change Billing Method**, you can rebind the cloud account, resubscribe to the relevant cloud account, or choose to settle through the Guance billing center. After completing the operation, the relevant workspace will automatically unlock.

![](img/9.workspace_lock_3.png)

### Dissolve

Within the 14-day grace period countdown, you can manually delete the workspace by clicking **Dissolve** on the workspace lock prompt page. Deleted workspaces cannot be recovered, so please proceed with caution.

![](img/9.workspace_lock_4.png)