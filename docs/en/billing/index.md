---
icon: zy/billing
---
# Billing
---

## Plan Instructions


Guance currently offers three plans: Experience, Commercial, and Deployment.

- The Experience and Commercial plans provided on the public cloud both use a **pay-as-you-go** billing method, with no difference in core functionality.

    - The [Experience plan has limitations on the scale of data that can be connected](../plans/trail.md#trail-vs-commercial), while Commercial users support a larger scale of data connection and more flexible data storage timelines.

- The Private Cloud Deployment plan also offers a Community plan (i.e., Experience) and a Commercial plan.

    - The Commercial plan allows flexible selection of various billing methods such as **pay-as-you-go, subscription, and licensing**.

???+ abstract "How to View the Current Workspace plan"

    - All roles: You can view it in Guance Console **Management > Settings > Basic Information > Current Plan**;
    - Owners, Administrators: You can also view it in Guance Console **Billing**.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Public Cloud Commercial plan</font>](../plans/commercial.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Public Cloud Experience plan</font>](../plans/trail.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Private Cloud Deployment plan</font>](../deployment/deployment-description.md#_4)

</div>

## Billing Center

There are two independent but interrelated account systems for data volume statistics that operate in conjunction to implement usage-based billing and cost settlement processes for **Commercial users**:

- The [Guance Console](https://console.guance.com/) account allows you to tally the data volume scale and billing details of the current workspace, synchronizing it with the designated Billing Center account.
- The [Guance Billing Center](https://boss.guance.com/) account can be bound with the `Workspace ID` to achieve **unified cost management at the workspace level** and offers various cost settlement methods for your selection.

![](img/billing-index-1.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Billing Center</font>](./cost-center/index.md)

</div>

Methods to view cost information:

- In the console [**Billing**](#billing) module, view the settlement account overview, usage statistics, billing details, usage analysis, data forwarding usage analysis, etc.;
- Log in to the [Guance Billing Center](https://boss.guance.com/) to view more detailed information.

???- warning "Workspace Role Difference"

    - Owner: In **Billing**, there are buttons for **recharge**, **Billing Center**, **settlement method**, **change binding**;
    - Administrator: In **Billing**, there are no above-mentioned buttons;
    - Other members: No **Billing** module, that is, no permission to view cost information.

![](img/12.billing_1.png)

## Billing {#billing}

### Settlement Account Overview {#account}

In the settlement account overview, you can view the settlement account name, cash account balance, voucher balance, prepaid card balance, and perform operations such as account recharge.

- Recharge: Click to recharge the account;
- Billing Center: Click to open Guance Billing Center;
- Settlement Method: Click to change the settlement method, including [Guance Billing Center Account Settlement](../billing/billing-account/enterprise-account.md), [AWS Account Settlement](../billing/billing-account/aws-account.md), [Alibaba Cloud Account Settlement](../billing/billing-account/aliyun-account.md), and [Huawei Cloud Account Settlement](../billing/billing-account/huawei-account.md);
- Change Binding: Click to change the workspace's Guance billing account, **provided that the current account and the new account must belong to the same enterprise, i.e., the enterprise certification of the two accounts in the Guance Billing Center must be the same**.
- Set High Consumption Alert: After setting the alert, when the billing item's <u>daily bill is greater than the alert threshold</u>, an email notification will be sent to the Owner and Administrator.

    - Select [Billing Item](./billing-method/index.md#item), and set the **alert threshold**, click **OK**, after adding, you will receive an email notification of **Guance High Consumption Alert**; Billing item alert notifications will not be sent repeatedly.

    ![](img/billing.gif)

???+ warning "Operation Permissions"

    - Buttons for **recharge**, **Billing Center**, **settlement method**, **change binding** are only accessible and operable by the current workspace Owner;
    - **Setting High Consumption Alert** is supported by both Owner and Administrator.

### Usage Statistics

You can view the statistical data of billing items up to the current time and up to yesterday, including: DataKit, Network (host), Timeline, Log data, Backup log data capacity, Application Performance Trace, Application Performance Profile, User visit PV, Dial test times, Task scheduling, SMS, and Central Pipeline processing traffic.

![](img/consumption.png)

### billing details

In the **billing details**: you can view the **cumulative consumption amount** and the consumption amount of each billing item, and you can check the cost statistics by today, yesterday, this week, last week, this month, last month, and this year.

> For more information on the billing methods of various billing items, please refer to [Billing Methods](billing-method/index.md).

![](img/consumption-2.png)

### Usage Analysis

In **Usage Analysis**, you can visually view the usage of each billing item.

![](img/consumption-1.gif)

### Data Forwarding Usage Analysis {#transmit}

In the **Data Forwarding Usage Analysis** module, you can view the data forwarding quantity of all data forwarding rules in the current workspace. You can also check the forwarding quantity statistics by today, yesterday, this week, last week, this month, last month, and this year.

**Note**:

- If the forwarding rule is saved to the Guance backup log module, the corresponding data saving policy is displayed, and others are shown as `-`.
- This section only lists the data forwarding rules in the workspace with a forwarding quantity > 0.

![](img/comm_01.png)


## Usage-Based Billing Method

The commercial plan users of the Guance workspace adopt a **pay-as-you-go** billing method, which comprehensively calculates the current cost based on different dimensions such as billing cycles, billing items, billing prices, and billing modes.

Owners and administrators of the workspace can view the data connection situation and corresponding billing details of the workspace in the Guance Console **Billing** module; other member roles do not have access to the **Billing** module.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Usage-Based Billing Method</font>](./billing-method/index.md)

</div>

## Cost Settlement Methods

After the Guance Console calculates the billing details of the current workspace, it will synchronize and push it to the bound Guance Billing Center account for subsequent cost settlement processes.

Currently, various settlement methods are supported, including the Guance Billing Center account, cloud accounts, which include Alibaba Cloud, AWS, and Huawei Cloud accounts. Under the cloud account settlement model, it supports the consolidation of cloud bills from multiple sites into a single cloud account for settlement.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Cost Settlement Methods</font>](./billing-account/index.md)

</div>
