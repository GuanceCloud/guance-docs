---
icon: zy/billing
---
# Billing

---

## Plans

Provides three versions: Free Plan, Commercial Plan, and Private Cloud Deployment Plan.

- Public Cloud: Free Plan, Commercial Plan. Both adopt the <font color=coral>**pay-as-you-go**</font> billing method. There is no difference in core functionalities, but the latter supports larger-scale data ingestion and more flexible storage durations.

- Private Cloud Deployment Plan: Community Edition (Free Plan) and Commercial Plan. The latter offers multiple billing methods such as pay-as-you-go, subscription, and license-based.


## Billing {#billing}

<<< custom_key.brand_name >>> public cloud version follows the principle of purchasing on demand and paying based on usage.

In the billing module, you can view the settlement account balance, usage statistics for billable items, and analyze costs from three aspects: detailed bills, monthly bills, usage, and data forwarding usage.

### Settlement Account Overview {#account}

View the settlement account name, cash account balance, voucher balance, prepaid card balance, and set high consumption alerts or go directly to the [Billing Center](../billing-center/index.md).

#### Set High Consumption Alerts {#alert}

???+ warning "Note"

    Only Owner and Administrator can perform this operation.

- Total Threshold Alert: Set an overall consumption threshold for the workspace. When exceeded, email alerts are sent to members.

- Single Billable Item Alert: Set alerts for individual billable items. Email alerts are sent when daily bill amounts exceed thresholds.

<img src="img/billing.png" width="50%" >

1. Enter the total alert threshold;
2. Select [billable item](../billing-method/billing-item.md#item) and input the **alert threshold**;
3. Select notified members. If either the total threshold or the actual bill amount for a single billable item exceeds the set alert threshold, warning emails will be sent to members;
4. Click **Confirm**.

???+ warning "Note"

    The Owner role is not restricted by the selection of notification targets and will receive email notifications when alerts are triggered.



### Usage Statistics

View statistics for each billable item **up to the current moment** and **up to yesterday**.

> For information on billable items and pricing models, see [Billing Methods](../billing-method/index.md).


### Detailed Bills

Displays consumption data for each product by dimensions such as billing mode, usage volume, payable amount, overdue amount, etc., and allows viewing of cost statistics by month.

Supports one-click “hide 0-yuan bills” and exporting detailed bills for selected months or the last 12 months into CSV files.

### Monthly Bill {#monthly_bill}

Displays total bill statistics on a monthly basis. Dimensions include total monthly consumption, cash consumption, cloud account consumption, voucher consumption, prepaid card consumption, and total overdue amount.

Supports one-click “hide 0-yuan bills” and exporting detailed bills for selected months or the last 12 months into CSV files.

### Usage Analysis

Visualizes the usage of each billable item using line chart graphs.


### Data Forwarding Usage Analysis {#transmit}

View the forwarding quantities for all data forwarding rules within the workspace. You can view statistics by time dimensions such as today, yesterday, this week, last week, this month, last month, this year, etc.

???+ warning "Note"

    - If the forwarding rule saves to <<< custom_key.brand_name >>> backup logs, the corresponding data retention policy is displayed; otherwise, it shows as `-`.
    - Only lists rules that exist and have a forwarding quantity > 0.


## Billing Center

???- warning "Workspace Role Differences Explanation"

    - Owner: Has the **Billing Center** button;
    - Administrator: Does not have the above button;
    - Other members: No access permission to the **Plans & Billing** module.

<<< custom_key.brand_name >>> provides two independently operating, interconnected account systems for commercial plan users to achieve usage-based billing and cost settlement:

- [Console](https://<<< custom_key.studio_main_site >>>/) account, which tracks workspace data ingestion scale, detailed bills, etc., synchronized to a specified billing center account.
- [Billing Center](https://<<< custom_key.boss_domain >>>/) account, bound via `workspace ID`, enables unified cost management at the workspace level and supports various cost settlement methods.

![](img/billing-index-1.png)