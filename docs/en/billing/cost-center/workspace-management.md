# Workspace Management
---

Workspace is the basic operation unit of Guance SAAS products, and users can join one or more workspaces by creating/inviting. In a workspace, users can use the basic functions provided by Guance, such as scene data insight, event management, metric management, infrastructure monitoring, log monitoring, application performance monitoring, user access monitoring, availability monitoring, security check, monitoring, workspace management, etc.

In the Guance Expense Center, one account can bind multiple Guance workspaces. In "Manage Workspace", it is supported to view all workspaces bound under the account, and to modify the settlement methods of bound workspaces, including Guance expense center account, Amazon cloud account and Alibaba cloud account.

Note: The settlement method of workspace only supports changing once a month.

![](../img/15.aws_3.png)

## Change Settlement Method

In the "Manage Workspace" of the Guance Expense Center, click "Change Settlement Method" on the right to change the settlement method for the current workspace, and support the account settlement of the Guance Expense Center and the cloud account settlement.

![](../img/10.account_11.png)

### Guance Enterprise Account Settlement

Guance enterprise account is an independent account dedicated by Guance expense center to manage the billing related generated by using Guance products, and one expense center account can be associated with multiple workspace billing. See the doc [Guance enterprise account settlement](../../billing/billing-account/enterprise-account.md).


### Cloud Account Settlement

Cloud account settlement includes Amazon Cloud account settlement and Alibaba Cloud account settlement. For more details, please refer to the doc [AWS account settlement](../../billing/billing-account/aws-account.md) and [Alibaba Cloud account settlement](../../billing/billing-account/aliyun-account.md).


### Change Settlement Method and Choose it at Will

By default, only "Guance Enterprise Account" and "Alibaba Cloud Account" can be selected for the workspace registered and logged in through "Alibaba Cloud Site", and only "Guance Enterprise Account" and "AWS Account" can be selected for the workspace registered and logged in through "AWS Site". For more site selection, refer to the doc [choosing a registered site](../../getting-started/necessary-for-beginners/select-site.md).

If you need to change the settlement method arbitrarily, you need to open "Select Settlement Method Arbitrarily". After opening, all users' workspaces in Guance can choose the settlement methods of "Guance Enterprise Account", "Alibaba Cloud Account" and "AWS Account" at will.

**Note: To open "Arbitrary Selection of Settlement Method", you need to contact the Guance account manager to make changes in the member management of the Guance billing platform.**


### Example of Changing Settlement Method


#### Change Amazon Cloud Settlement Method (subscribe to Guance at AWS)

In the "Manage Workspace" of the Guance Expense Center, click "Change Settlement Method" on the right.

![](../img/10.account_11.png)

Select Amazon Cloud Account to pay, click "Subscribe to Amazon Cloud Market", you can enter the homepage of Guance in Amazon Cloud, and click "Continue Subscription".

![](../img/8.space_4.png)



Enter your account, username and password in Amazon Cloud to log in.

![](../img/8.space_5.png)

After logging in, click "Subscribe" on the page of Amazon Cloud to which Guance belongs.

![](../img/8.space_8.png)

In the pop-up dialog box, click "Set up your account".

![](../img/8.space_9.png)

After the account is established, it will automatically jump to the Guance Expense Center. After selecting the workspace, click "Confirm Submission".

![](../img/8.space_10.png)

Select the workspace, confirm the submission, and view the subscribed cloud account and related settlement workspace in the "Account Management"-"Cloud Account" of the Guance Expense Center.

![](../img/15.aws_5.png)

Return to the management workspace of the Guance expense center to confirm whether the operation was successful.

![](../img/15.aws_4.png)

After the operation is confirmed to be successful, you can view the updated settlement method in the administrative workspace.

![](../img/15.aws_3.png)

#### Unsubscribe from Guance at AWS

Log in to Amazon Cloud and select "Your Marketplace Software" in the upper right corner of the account.

![](../img/8.space_13.png)

Find the subscribed Guance service in Manage Subscription and click Manage.

![](../img/8.space_14.png)

Enter the Guance service management page and click "Action"-"Unsubscribe".

![](../img/8.space_15.png)

In the pop-up dialog box, click "Yes, unsubscribe".

![](../img/8.space_16.png)

After unsubscribing successfully, Guance service was cancelled in Amazon Cloud Management Subscription.

![](../img/8.space_17.png)

Note: After Amazon Cloud cancels its subscription to Guance service, it will bind all workspaces for account settlement in Guance expense center, delete the associated cloud account, modify the current cloud account settlement to Guance expense center account settlement, and notify the user by mail.


