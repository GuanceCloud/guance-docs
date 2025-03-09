# Billing Settlement Method
---

<<< custom_key.brand_name >>> supports settlement through a **Billing Center account** or **cloud account**. Under the cloud account settlement model, multiple site cloud bills can be consolidated into one cloud account for settlement.


![](../img/billing-index-1.png)

## Deduction Order

1. If you choose to settle with <<< custom_key.brand_name >>> Billing Center account, the deduction order for pay-as-you-go billing is: standard coupons > discount coupons > prepaid cards > cash > prepaid card balance (negative value for overdue payments). Among these, SMS and Test consumption can only be paid using cash, prepaid cards, or prepaid card balance.
2. If you choose cloud account settlement, the deduction order for pay-as-you-go billing is: standard coupons > discount coupons > prepaid cards > cloud account cash balance. Among these, SMS and Test consumption can only be paid using prepaid cards and cloud account cash balance.
3. Once the workspace settlement method is set to cloud account settlement, it cannot be changed to other settlement methods (such as changing from [Alibaba Cloud Account A] to [Alibaba Cloud Account B] or from [AWS Account] to [Alibaba Cloud Account]), unless the associated cloud account subscription is canceled or released.

## Billing Center Account Settlement

You can directly recharge and settle through the Billing Center account on the <<< custom_key.brand_name >>> Billing Center platform. One Billing Center account can be associated with multiple workspaces for fee settlement.

In <<< custom_key.brand_name >>> Billing Center, you can recharge in cash, manage coupons, manage prepaid cards, change settlement methods, and also manage accounts, view detailed bills, account balances, bound workspaces, and other related information through the Billing Center.

## Cloud Account Settlement {#cloud-account}

You can recharge and settle through a cloud account. One cloud account supports associating multiple workspaces across multiple sites for fee settlement.

**Note**: Cloud account settlement supports prioritizing the use of coupons or prepaid cards provided by <<< custom_key.brand_name >>> for payment. After the fees in coupons or prepaid cards are exhausted, the cloud account fees will continue to be deducted.