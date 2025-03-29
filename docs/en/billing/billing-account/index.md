# Billing Settlement Methods
---

Settlement is supported through a **Billing Center account** or a **cloud account**. Under the cloud account settlement model, bills from multiple sites can be consolidated and settled under one cloud account.


![](../img/billing-index-1.png)

## Deduction Order for Settlement

- Billing Center account settlement: The deduction order for invoices is regular coupons > discount coupons > prepaid cards > cash > prepaid card balance (negative value for overdue payment). SMS and TESTING consumption by volume is limited to cash, prepaid cards, or prepaid card balances.
- Cloud account settlement: The deduction order for invoices is regular coupons > discount coupons > prepaid cards > cloud account cash balance. SMS and TESTING consumption by volume is limited to prepaid cards and cloud account cash balance.

???+ warning "Note"

    After selecting cloud account settlement, it cannot be changed to another settlement method unless the bound cloud account is unsubscribed or released.

## Billing Center Account Settlement

On the <<< custom_key.brand_name >>> Billing Center platform, Billing Center accounts can be used to recharge and settle payments for multiple associated workspaces.

On this platform, you can perform cash recharges, coupon management, prepaid card management, change settlement methods, as well as manage accounts, view detailed invoices, account balances, and information about the linked workspaces.

## Cloud Account Settlement {#cloud-account}

Recharge and settle payments via a cloud account; one cloud account can be associated with multiple workspaces across multiple sites for fee settlement. Cloud account settlement supports prioritizing the use of <<< custom_key.brand_name >>> provided coupons or prepaid cards for deductions, and after they are exhausted, it will continue to deduct fees from the cloud account.