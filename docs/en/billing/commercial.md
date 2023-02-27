# Public Cloud Commercial Plan
---

## Open Commercial Plan

- [Register the commercial plan directly in Guance](commercial-register.md)
- [Upgrade from experience plan workspace to commercial plan workspace](commercial-version.md)
- [Open Guance Commercial plan in Alibaba Cloud market](commercial-aliyun.md)

## Preconditions for Billing and Settlement

Commercial users of the Guance workspace need to successfully register two accounts, namely **Guance studio account and expense center account**, before they can carry out the subsequent usage billing and expense settlement process.

- [Guance studio](https://console.guance.com/) account, which can count the data volume, access scale and bill details in the current space and synchronize to the designated expense center account.
- [Guance expense center](https://boss.guance.com/) account, which can be bound through `workspace ID` to **realize unified expense management at workspace level, and provide a variety of expense settlement methods** for you to choose from.

???+ attention

    - If you have directly [register commercial plan](../billing/commercial-register.md) users, the system will automatically help you register Guance expense center users with the same user name when registering.
    - If you are registered as an experience user and have not yet registered as an Guance expense center user, you will be prompted to register in the operation [upgrading to commercial plan](../billing/commercial-version.md).

![](img/billing-index-1.png)


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Expense center doc</font>](./cost-center/index.md)

<br/>

</div>

## Billing

the owner of the Guance workspace and view the expense:

- In the **Studio > Billing** module, view information such as settlement account overview, usage statistics, bill list, usage statistics view, etc.
- Login to [Guance expense center](https://boss.guance.com/) for more details.

???+ attention "Workspace role difference description"

    - Owner: In **Billing**, there are **Recharge, Expense Center, Settlement Method and Change Binding** buttons.<br/>
    - Administrator: In **Billing**, the above button is not available.<br/>
    - Other members: There is no **Billing** module, that is, there is no permission to view the expenses.

![](img/12.billing_1.png)

### Overview of Settlement Accounts

In the settlement account overview, you can view the settlement account name, cash account balance, voucher balance and stored-value card balance and recharge the account.

- Recharge: Click to recharge the account.
- Cost Center: Click to jump to open the Guance expense center;
- Settlement method: Click to change the settlement method, including [Guance Cloud enterprise account settlement](billing-account/enterprise-account.md), [Amazon Cloud account settlement](billing-account/aws-account.md) and [Alibaba Cloud account settlement](billing-account/aliyun-account.md);
- Change binding: Click to change the Guance billing account in the workspace, **provided that the current account and the new account must belong to the same enterprise, that is, the enterprise authentication of the two accounts in the Guance billing center must be the same**.

> Note: **Recharge, Expense Center, Settlement Method and Change Binding** buttons only support the current workspace owner to view and operate.

### Usage Statistics

In **Usage Statistics**, you can view the statistical data of charging items DataKit, network (host), timeline, log data, backup log data capacity, application performance Trace, application performance Profile, user access PV, dialing times, task dialing and SMS as of now and as of yesterday.

### Billing List

In the **Billing List**: you can view the **Accumulated Consumption Amount** and the consumption amount of each billing item, and at the same time, you can view the daily expense statistics according to different months. See the documentation [billing methods](billing-method/index.md).

### Use Statistics View

In the **Usage Statistics View**, you can visually view the usage of each billing item.

