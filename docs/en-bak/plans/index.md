---
icon: zy/plans
---
# About Guance
---


![](img/background.png)

## How is traffic generated in the workspace settled?

When various services are invoked within the workspace, corresponding traffic data is generated. The settlement of this part involves two processes:

:material-numeric-1-circle: **Data Volume Statistics**: The scale of data generated by the workspace is tallied.

:material-numeric-2-circle: **Billing Details Generation**: Billing details are created based on the actual traffic.

Traffic data is produced within the workspace and is **stored separately under the workspace, and synchronized to the billing center to generate invoices**.

Therefore: The two processes are carried out independently in the workspace and billing center, with fee synchronization achieved through the association of the billing center account ID.

<img src="img/background-1.png" width="60%">

## Two Essential Accounts for Cost Settlement

:material-numeric-1-circle: **Guance Console Account**: Bound to the workspace, it tallies the scale of data access and billing details under this account; can be synchronized to a specified billing center account.

:material-numeric-2-circle: **Guance Billing Center Account**: Can be bound to one/multiple workspaces to achieve unified cost management.

**Note**: A workspace can be billed individually or multiple workspaces can be bound for joint billing.

### Why do we need two accounts?

The settlement process mainly includes two aspects. On one hand, the workspace is created under the Guance console account, and data traffic storage and statistics are carried out within this workspace. On the other hand, the billing center account is bound to the workspace to obtain the billing data under the corresponding workspace, which is then settled according to the user-selected method.

<img src="img/background-2.png" width="70%">


Use Case:

![](img/background-3.png)

## What settlement methods does Guance support?

:material-numeric-1-circle: Enter the [Billing Center](https://boss.guance.com/) and settle directly with the billing center account. You only need to recharge or purchase prepaid cards in the billing center account to complete bill payment.

:material-numeric-2-circle: Support cloud suppliers account settlement: Huawei Cloud, Alibaba Cloud, and AWS.

## How to activate Guance?

| Account Registration Entry |  |  |
| --- | --- | --- |
| [Guance Official Website Registration](./commercial-register.md) |  |  |
| cloud supplier Registration | [Huawei Cloud Marketplace Activation](./commercial-huaweiyun.md) | [AWS Marketplace Activation](./commercial-aws.md) |
|  | [Alibaba Cloud Marketplace Activation](./commercial-aliyun.md) | [Alibaba Cloud International Cloud Marketplace Activation](./en-alicloud.md) |

## FAQ

:material-chat-question: What is the difference between activating Guance on the official website and through a cloud supplier?

Both channels can activate Guance services normally. The main difference lies in the **selectability of settlement methods after service activation**.

- When activating on the Guance official website, you can choose either the Guance billing center or the cloud supplier account for settlement;  
- When activating through a corresponding cloud supplier, you can only settle with that cloud supplier account.

So, if you have a preferred settlement method in mind, you can choose the activation channel based on the settlement method.

:material-chat-question: How to bind the billing center account and the workspace?

- If you are a new user, during the registration process on the Guance official website, you will create the Guance console account, billing center account, and workspace at the same time, and the workspace will be automatically bound to the account.

- If you are settling through a cloud supplier channel, after successfully ordering the Guance service on the cloud supplier platform, there will be a process to bind the workspace, where you can choose the workspace to bind as needed.

:material-chat-question: Why is it necessary to use two accounts?

The workspace is created under the console account, and when settling fees for the workspace, multiple workspaces can be combined for settlement. The two processes are carried out separately, hence two accounts are needed to control them respectively.

:material-chat-question: How to determine if you have an Guance console account and a billing center account?

The Guance console account is used to log in to the official website: https://www.guance.com. **The only voucher for the account is the email address**.

The billing center account can be viewed in **Guance Workspace > Payment Plans & Bills**. If there is a billing center account, the settlement account can be displayed normally; or you can directly log in to the billing center platform: https://boss.guance.com. **The only voucher for the billing center account is the username**.

:material-chat-question: I have activated the Guance trial plan, how to upgrade to the commercial plan?

You can check the [documentation](./trail.md).
