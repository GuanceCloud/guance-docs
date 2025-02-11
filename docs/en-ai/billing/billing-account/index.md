# Billing Settlement Method
---

Guance supports settlement through a **Billing Center Account** or a **Cloud Account**. Under the cloud account settlement model, multiple site cloud bills can be consolidated into one cloud account for settlement.

![](../img/billing-index-1.png)

## Deduction Order for Settlement

1. If you choose to settle using the Guance Billing Center Account, the deduction order for pay-as-you-go billing is: Standard Vouchers > Discount Vouchers > Prepaid Cards > Cash > Prepaid Card Balance (negative balance). Among these, SMS and dial testing pay-as-you-go consumption can only be paid using cash and prepaid cards or prepaid card balances.
2. If you choose to settle using a Cloud Account, the deduction order for pay-as-you-go billing is: Standard Vouchers > Discount Vouchers > Prepaid Cards > Cloud Account Cash Balance. Among these, SMS and dial testing pay-as-you-go consumption can only be paid using prepaid cards and the cloud account cash balance.
3. Once the workspace settlement method is set to cloud account settlement, it cannot be changed to another settlement method (e.g., from [Alibaba Cloud Account A] to [Alibaba Cloud Account B] or from [AWS Account] to [Alibaba Cloud Account]), unless the associated cloud account is unsubscribed or released.

## Billing Center Account Settlement

You can directly recharge and settle payments on the Guance Billing Center platform using a Billing Center Account. One Billing Center Account can be linked to multiple workspaces for fee settlement.

In the Guance Billing Center, you can perform operations such as cash recharges, manage vouchers, manage prepaid cards, change settlement methods, and more. Additionally, through the Billing Center, you can manage accounts, view detailed invoices, account balances, and information about associated workspaces.

## Cloud Account Settlement {#cloud-account}

You can recharge and settle payments using a Cloud Account. One Cloud Account can support linking multiple workspaces across multiple sites for fee settlement.

**Note**: Cloud account settlement supports prioritizing the use of vouchers or prepaid cards provided by Guance for deductions. After the funds in the vouchers or prepaid cards are exhausted, the remaining charges will be deducted from the cloud account.