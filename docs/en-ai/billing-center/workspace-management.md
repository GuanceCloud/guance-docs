# Workspace Management
---

In the <<< custom_key.brand_name >>> Billing Center, one account can be linked to multiple <<< custom_key.brand_name >>> workspaces. In **Manage Workspaces**, you can view all workspaces linked under the account and modify the billing method for the linked workspaces, including four types of billing methods: <<< custom_key.brand_name >>> Billing Center account, AWS account, Alibaba Cloud account, and Huawei Cloud account.

**Note**: The billing method for a workspace can only be changed once a month.

![](img/15.aws_3.png)

## Changing Billing Method

In <<< custom_key.brand_name >>> Billing Center **Manage Workspaces**, click **Change Billing Method** on the right side to change the [billing method](../billing-account/index.md) for the current workspace. This supports four billing methods: <<< custom_key.brand_name >>> Billing Center account, AWS account, Alibaba Cloud account, and Huawei Cloud account.

![](img/10.account_11.png)

### <<< custom_key.brand_name >>> Billing Center Account Billing

The <<< custom_key.brand_name >>> Billing Center account is an independent account specifically used by <<< custom_key.brand_name >>> Billing Center to manage charges related to using <<< custom_key.brand_name >>> products. One billing center account can be associated with multiple workspace billings.

> For more details, refer to [<<< custom_key.brand_name >>> Billing Center Account Billing](../../billing/billing-account/enterprise-account.md).

### Cloud Account Billing

Cloud account billing includes [AWS account billing](../../billing/billing-account/aws-account.md), [Alibaba Cloud account billing](../../billing/billing-account/aliyun-account.md), and [Huawei Cloud account billing](../../billing/billing-account/huawei-account.md).

### Arbitrary Selection of Billing Method

By default, workspaces registered and logged in via the **Alibaba Cloud site** can only choose between the **<<< custom_key.brand_name >>> Billing Center account** and **Alibaba Cloud account** billing methods. Workspaces registered and logged in via the **AWS site** can only choose between the **<<< custom_key.brand_name >>> Billing Center account** and **AWS account** billing methods.

> For more site selection options, refer to the document [Site Description](../commercial-register.md#site).

If you need to arbitrarily change the billing method, you need to enable **Arbitrary Selection of Billing Method**. Once enabled, all <<< custom_key.brand_name >>> user workspaces can arbitrarily choose from the **<<< custom_key.brand_name >>> Billing Center account**, **Alibaba Cloud account**, **AWS account**, and **Huawei Cloud account** billing methods.

**Note**: Enabling **Arbitrary Selection of Billing Method** requires contacting your <<< custom_key.brand_name >>> customer manager to make changes in the <<< custom_key.brand_name >>> billing platform member management.


## Workspace Locking {#workspace-lock}

### Locking {#lock}

<<< custom_key.brand_name >>> Commercial Plan workspaces are billed through binding a <<< custom_key.brand_name >>> [Billing Center](../billing-center/index.md) account or cloud account.

If there are situations such as <u>account arrears or abnormal cloud market subscriptions</u>, it will trigger the action to lock the workspace. <<< custom_key.brand_name >>> provides a <font color=coral>14</font>-day grace period countdown. After 14 days, the workspace will be fully locked, and new data will stop being reported.

- Within the 14-day countdown, you can continue to view and analyze historical data and can [unlock the locked state](#unlock) to continue using <<< custom_key.brand_name >>>;

![](img/9.workspace_lock_1.png)

- After the 14-day countdown ends, a workspace lock notification will be displayed, and at this point, the workspace data will be cleared with one click. If you still need to use <<< custom_key.brand_name >>> products, you can choose to switch workspaces or directly click below to create a new workspace.

![](img/9.workspace_lock_2.png)
    
???+ abstract "Workspace Locking Explanation"

    - The <<< custom_key.brand_name >>> Billing Center account settles according to the [billing](../cost-center/billing-management.md) cycle. After the invoice is generated, you will receive an email notification about the invoice generation. If your account has arrears, you will also be provided with a <font color=coral>14</font>-day settlement period. Near the end of the 14 days, another countdown email notification will be sent to you. If no settlement occurs after 14 days, the relevant workspace will be locked.


### Unlocking {#unlock}

As mentioned above, on the workspace lock notification page, click **Unlock Immediately** to redirect to the <<< custom_key.brand_name >>> Billing Center's **Workspace Management** page without logging in. You can [change the billing method](../../billing/billing-account/index.md) for the current workspace, or click the **<<< custom_key.brand_name >>> Billing Center** in the top-left corner to enter the homepage and recharge your account.

> For more recharge methods, refer to the document [Account Wallet](../../billing/cost-center/account-wallet/index.md).

???+ abstract "Different Unlock Scenarios"

    - For enterprise-certified accounts, recharging will settle according to the invoice. After settlement, the relevant workspace will be unlocked;

    - For cloud account billing, in **Workspace Management > Change Billing Method**, you can rebind the cloud account, resubscribe to the relevant cloud account, or choose to settle through the <<< custom_key.brand_name >>> Billing Center. After completing these operations, the relevant workspace will automatically unlock.

![](img/9.workspace_lock_3.png)

### Dissolution

Within the 14-day grace period countdown, you can manually delete the workspace by clicking **Dissolve** on the workspace lock notification page. Once deleted, the workspace cannot be restored; please proceed with caution.

![](img/9.workspace_lock_4.png)