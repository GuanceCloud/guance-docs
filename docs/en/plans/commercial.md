# Public Cloud Commercial Plan
---

## Open Commercial Plan

- [Register Commercial Plan directly in Guance](commercial-register.md)
- [Upgrade from Experience Plan workspace to Commercial Plan workspace](commercial-version.md)
- [Open Guance Commercial Plan in Alibaba Cloud market](commercial-aliyun.md)
- [Open Guance Commercial Plan in Huawei Cloud KooGallery](/billing/commercial-huaweiyun.md)

## Preconditions for Billing and Settlement

Users of Guance Commercial Plan need to successfully register two accounts, namely <u>Guance studio account and Billing Center account</u>, before they can carry out the subsequent usage billing and expense settlement process.

- [Guance studio](https://console.guance.com/) account, which can count the data volume, access scale and bill details in the current space and synchronize to the designated Billing Center account.
- [Guance Billing Center](https://boss.guance.com/) account, which can be bound through `workspace ID` to <u>realize unified expense management at workspace level, and provide a variety of expense settlement methods</u> for you to choose from.

???+ warning

    - If you have directly [register Commercial Plan](../billing/commercial-register.md) users, the system will automatically help you register Guance Billing Center users with the same user name when registering.
    - If you are registered as an experience user and have not yet registered as an Guance Billing Center user, you will be prompted to register in the operation [upgrading to Commercial Plan](../billing/commercial-version.md).

![](img/billing-index-1.png)


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Billing Center</font>](./cost-center/index.md)

<br/>

</div>

## Billing

The owner of the Guance workspace and view the expense:

- In the **Studio > Billing** module, view information such as settlement account overview, usage statistics, billing details, usage statistics view, etc.
- Login to [Guance Billing Center](https://boss.guance.com/) for more details.

???+ warning "Workspace role difference description"

    - Owner: In **Billing**, there are **Recharge, Billing Center, Change Settlement and Change Account** buttons.<br/>
    - Administrator: In **Billing**, the above button is not available.<br/>
    - Other members: There is no **Billing** module, that is, there is no permission to view the expenses.

![](img/12.billing_1.png)

### Overview of Settlement Accounts

In the settlement account overview, you can view the settlement account name, cash account balance, voucher balance and stored-value card balance and recharge the account.

- Recharge: Click to recharge the account.
- Billing Center: Click to jump to open the Guance Billing Center.
- Change Settlement: Click to change the settlement method, including [Guance Cloud Billing Center account settlement](./billing-account/enterprise-account.md), [AWS account settlement](./billing-account/aws-account.md), [Alibaba Cloud account settlement](./billing-account/aliyun-account.md) and [Huawei Cloud account settlement](./commercial-huaweiyun.md)
- Change Account: Click to change the Guance billing account in the workspace, <u>provided that the current account and the new account must belong to the same enterprise, that is, the enterprise authentication of the two accounts in the Guance Billing Center must be the same</u>.
- Set High Consumption Alert: After setting the alert, when the daily bill of billing item is greater than the alert threshold, an email notification will be sent to Owner and Administrator.

    - Select **Billing Item** and **Warning Threshold** and click **Confirm**. After the addition is completed, you will receive the email notification of high consumption warning notification; **Billing Item** alert notifications will not be sent repeatedly.

    ![](img/billing.gif)

???+ warning "On Permissions"

    - **Recharge, Billing Center, Change Settlement and Change Account** buttons only support the current workspace owner to view and operate.
    - **Set High Consumption Alert** function only support Owner and Administrator operations.

### Usage Statistics

In **Usage Statistics**, you can view the statistical data of charging items DataKit, network (host), timeline, log data, backup log data capacity, application performance Trace, application performance Profile, user access PV, dialing times, task dialing and SMS as of now and as of yesterday.

### Billing Details

In the **Billing Details**: you can view the accumulated consumption amount and the consumption amount of each billing item; meanwhile, you can view the daily expense statistics according to different months. 

> See the doc [Billing Methods](billing-method/index.md).

![](img/consumption-2.png)

### Usage Analysis

In the **Usage Statistics View**, you can visually view the usage of each billing item.

![](img/consumption-1.png)

### Consumption Analysis

In Consumption Analysis, you can view Yesterday Cost and Total Cost, or you can view statistical consumption analysis based on the selected time range.

![](img/consumption.png)