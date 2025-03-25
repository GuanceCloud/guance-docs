---
icon: zy/billing
---
# Billing and Payment Plans
---

## Plans

<<< custom_key.brand_name >>> currently offers three versions: Free Plan, Commercial Plan, and Private Cloud Deployment Plan.

- The Free Plan and Commercial Plan available on the public cloud both adopt the <font color=coral>**pay-as-you-go**</font> billing method, with no difference in core functionalities.

    - [The data intake scale for the Free Plan](../plans/trail.md#trail-vs-commercial) is limited. <u>The Commercial Plan supports a larger scale of data intake and more flexible data retention options.</u>

- The Private Cloud Deployment Plan also provides a Community Edition (i.e., Free Plan) and a Commercial Plan.

    - The Commercial Plan offers flexible choices such as <u>pay-as-you-go, subscription-based, and license-based</u> billing methods.

### View Version

- All member roles: In <<< custom_key.brand_name >>> Console **Manage > Workspace Settings > Basic Information > Current Version**;

- Owners, Administrators: In <<< custom_key.brand_name >>> Console [**Billing and Payment Plans**](#billing) section.


## Payment Plans and Billing {#billing}

<<< custom_key.brand_name >>> Public Cloud adheres to the principle of pay-as-you-go.

In the Payment Plans and Billing section, you can view the current settlement account's cash balance, voucher balance, etc., and analyze statistics for various billing items including Time Series, LOGs, NETWORK, APM Traces, APM Profiles, RUM PVs, Triggers, SESSION REPLAYs, and more. Additionally, you can perform cost analysis from three aspects: bill details, usage, and data forwarding usage.

### Account Overview {#account}

View the settlement account name, cash account balance, voucher balance, prepaid card balance, set up high consumption alerts, or go directly to the [Billing Center](../billing-center/index.md).

#### Set High Consumption Alerts {#alert}

<font size=2>**Note**: Only Owner and Administrator have the authority to perform this operation.</font>

- Total Threshold Alert: Set an overall consumption threshold for the current workspace. Once the total consumption amount of all billing items in the workspace **exceeds** this threshold, <<< custom_key.brand_name >>> will automatically send an email alert to the member.

- Single Billing Item Alert: Set an alert for individual billing items. When the **daily bill amount of a billing item exceeds the set alert threshold**, <<< custom_key.brand_name >>> will automatically send an email alert to the member.


<img src="img/billing.png" width="50%" >

1. Fill in the total warning threshold as needed;
2. Select [billing item](../billing-method/billing-item.md#item) and input the **warning threshold**;
3. Select notified members; whether the actual bill amount exceeds the set warning threshold for the total threshold or individual billing items, warning emails will be sent to the members;
4. Click **Confirm**.

**Note**: The Owner role is not restricted by the selection of notification targets. That is, regardless of whether the Owner is selected as a notification target, <<< custom_key.brand_name >>> will send an email notification to the Owner when the warning conditions are triggered.



### Usage Statistics

View the statistics of each billing item **up to the present** and **up to yesterday**, including: active DataKit, NETWORK (HOST), Time Series, log class data, backup log data capacity, APM Trace, APM Profile, RUM PV, API Tests, Triggers, SMS, SESSION REPLAY, scheduled reports, log write traffic, sensitive data scan, central Pipeline processing traffic.


### Bill Details

View detailed consumption data of each product according to dimensions such as billing mode, usage, payable amount, overdue amount, etc., and view fee statistics for different months.


![](img/consumption-2.png)

### Usage Analysis

View the usage status of each billing project through visualization.

![](img/consumption-1.png)

### Data Forwarding Usage Analysis {#transmit}

View the number of data forwardings for all data forwarding rules in the current workspace. You can also check the quantity statistics according to seven time dimensions: today, yesterday, this week, last week, this month, last month, this year.

**Note**:

- If the forwarding rule is saved to <<< custom_key.brand_name >>>'s backup logs, the corresponding data retention strategy will be displayed. If it is saved to external storage, it will be shown as `-`.
- Only lists the data forwarding rules that exist within the workspace and have a forwarding count > 0.

![](img/comm_01.png)

## [Billing Center](../billing-center/index.md)

???- warning "Workspace Role Differences"

    - Owner: Has the **Billing Center** button;
    - Administrator: Does not have the above button;
    - Other Members: Do not have the **Payment Plans and Billing** module, i.e., no permission to view billing information.

<<< custom_key.brand_name >>> has two independent but interconnected account systems that together implement usage-based billing and fee settlement processes for **Commercial Plan users**:

- [<<< custom_key.brand_name >>> Console](https://<<< custom_key.studio_main_site >>>/) account, which can track the data intake scale and detailed bills of the current workspace, synchronized to the designated billing center account.
- [<<< custom_key.brand_name >>> Billing Center](https://<<< custom_key.boss_domain >>>/) account, which can be bound via `Workspace ID` to achieve **unified fee management at the workspace level** and provides multiple billing settlement options.

![](img/billing-index-1.png)



## Usage-Based Billing Method

<<< custom_key.brand_name >>> Commercial Plan adopts the **pay-as-you-go** [billing method](../billing-method/index.md). Through various dimensions such as billing cycle, billing items, billing price, and billing model, the current fee situation is comprehensively calculated.



## Fee Settlement Methods

After <<< custom_key.brand_name >>> calculates the detailed bill for the current workspace, it synchronizes and pushes it to the bound <<< custom_key.brand_name >>> Billing Center account for subsequent fee settlement processes.

Currently supports <<< custom_key.brand_name >>> Billing Center accounts and various cloud accounts as [settlement methods](./billing-account/index.md), including Alibaba Cloud, AWS, Huawei Cloud, Microsoft Cloud account settlements. Under the cloud account settlement mode, multiple site cloud bills can be consolidated under one cloud account for settlement.