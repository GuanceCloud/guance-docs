---
icon: zy/billing
---
# Billing
---

Guance provides three plans: Experience Plan, Commercial Plan and Private Cloud Deployment Edition. In Billing, you can view the Guance plan, the usage of [billing item](billing-method/index.md), the balance of the settlement account, recharge the account, change the settlement method, change the bound mailbox, view the bill list, and go to [expense center](cost-center/index.md)」for more account details.

## Experience Plan

You can [register Guance Experience Plan](https://auth.guance.com/businessRegister). After registration, check the daily experience quota and usage of each billing item in Guance Workspace on the "Payment Plan and Billing" page. If you need to [upgrade to commercial plan](commercial-plan.md), you can click the "Upgrade" button.

???+ attention

    - The upgraded commercial plan only supports the current workspace owner to view and operate;
    - There is no charge if the experience plan is not upgraded. Once upgraded to the commercial plan, it cannot be refunded;
    - If the experience plan is upgraded to the commercial plan, the collected data will continue to be reported to Guance workspace, but the data collected during the experience plan will not be viewed;
    - Timeseries and backup log statistics are full data, and other billing items are incremental data; Incremental data statistics reset the free quota at 0 o'clock every day, which is valid on the same day;
    - If the data quota is fully used for different billing items in the experience plan, the data will stop being reported and updated; Infrastructure and event data still support reporting updates, and you can still see infrastructure list data and event data.

![](img/9.upgrade_1.png)

## Commercial Plan

You can [sign up for Guance Commercial Plan](https://auth.guance.com/businessRegister). After registration, check the balance of the settlement account, recharge the account, change the settlement method, change the bound mailbox, view the bill list, use the statistical view, or go to the「[expense center](cost-center/index.md)」to see more account details on the Billing page of Guance workspace.

![](img/12.billing_1.png)

#### Settlement Account Overview

In the settlement account overview, you can view the settlement account name, cash account balance, voucher balance, stored value card balance, and recharge the account.

- Recharge: Click to recharge the account.
- Cost Center: Click to jump to open the Guance cost center;
- Settlement method: Click to change the settlement method, including [Guance enterprise account settlement](billing-account/enterprise-account.md), [AWS cloud account settlement](billing-account/aws-account.md) and [Alibaba cloud account settlement](billing-account/aliyun-account.md);
- Change binding: Click to change the Guance billing account in the workspace, **The premise is that the current account and the new account must belong to the same enterprise, that is, the enterprise authentication of the two accounts in the Guance expense center must be the same**;

> Note: "Recharge", "Expense Center", "Settlement Method" and "Change Binding" buttons only support the current workspace owner to view and operate.

#### Usage Statistics

In "Usage Statistics", you can view the statistical data of charging items DataKit, network (host), timeseries, log data, backup log data capacity, application performance Trace, application performance Profile, user access PV, dialing times, task scheduling and SMS as of now and as of yesterday.

#### Billing List

In the "Bill List": you can view the "Accumulated Consumption Amount" and the consumption amount of each billing item, and at the same time, you can view the daily expense statistics according to different months. See the doc [billing method](billing-method/index.md) for more billing items.

#### Use Statistics View

In the Usage Statistics View, you can visually view the usage of each billing item.


## Private Cloud Deployment {#cloudpaas}

If you need to experience the Guance Community Plan or use the Guance Private Cloud Deployment Plan, you can click "Upgrade" on the "Payment Plan and Billing" page of the Experience Plan to enter the package upgrade. On the "Package Upgrade" page, you can view the introduction of private cloud deployment plan and community plan of Guance. You can click "Learn Details" for more plan details.

![](img/10.account_3.png)

Or click "Contact Us", fill in the company and applicant information and submit it. The account manager will contact you later.

![](img/10.account_4.png)



