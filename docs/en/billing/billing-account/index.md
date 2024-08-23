# Settlement Methods
---

Guance supports various billing methods including the Guance Billing Center account and cloud account settlement, the latter including Alibaba Cloud, AWS, and Huawei Cloud account settlements. Under the cloud account settlement model, it supports the consolidation of cloud bills from multiple sites into a single cloud account for settlement.


![](../img/billing-index-1.png)

???+ warning "Account Settlement Deduction Order"

    1. If you choose to settle with the Guance Billing Center account, the deduction order for Guance pay-as-you-go bills is: regular vouchers, discount vouchers, prepaid cards, cash, and prepaid card balance (negative value for arrears); the pay-as-you-go consumption for SMS and dial testing can only be paid with cash and prepaid cards or prepaid card balance.
    2. If you choose to settle with a cloud account, the deduction order for Guance pay-as-you-go bills is: regular vouchers, discount vouchers, prepaid cards, and cash balance of the cloud account. The pay-as-you-go consumption for SMS and dial testing can only be paid with prepaid cards and the cash balance of the cloud account.
    3. Once the settlement method for a workspace is set to cloud account settlement, it cannot be changed to other settlement methods (such as from `Alibaba Cloud Account A` to `Alibaba Cloud Account B` or from `AWS Account` to `Alibaba Cloud Account`, etc.) unless the bound cloud account cancels the subscription or is released.

## Guance Billing Center account Settlement

You can directly settle by recharging at the Guance [Billing Center](../../billing-center/index.md) through [the Guance Billing Center account](enterprise-account.md), and a single Billing Center account can be associated with multiple workspaces for cost settlement.

<!--
In Guance Billing Center, you can recharge the Billing Center account in cash, manage vouchers, stored-value cards and change settlement methods. At the same time, you can also manage the account through the Billing Center, and view the bill details, account balance, tied workspace and other related information.
-->

## Cloud Account Settlement {#cloud-account}

You can settle by recharging through a cloud account, and a single cloud account supports the association of multiple workspaces, and workspaces from multiple sites for cost settlement.

Guance currently supports three types of cloud account settlement methods, namely [Huawei Cloud account](huawei-account.md), [Alibaba Cloud account](aliyun-account.md), and [AWS account](aws-account.md).

**Note**: Cloud account settlement supports the priority use of vouchers or prepaid cards provided by Guance for deduction. After the fees in the vouchers or prepaid cards are exhausted, then continue to deduct the fees from the cloud account.
