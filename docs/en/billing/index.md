---
icon: zy/billing
---
# Billing and Paid Plans
---

## Plans

<<< custom_key.brand_name >>> offers three versions: Free Plan, Commercial Plan, and Private Cloud Deployment Plan.

- The public cloud provides both Free Plan and Commercial Plan, both of which adopt the <font color=coral>**pay-as-you-go**</font> billing method. There is no difference in core functionalities.

    - [The data intake capacity for the Free Plan](../plans/trail.md#trail-vs-commercial) is limited, while <u>Commercial Plan users can access larger data volumes and more flexible data retention periods</u>.

- The private cloud deployment plan also offers Community Edition (equivalent to Free Plan) and Commercial Plan.

    - The Commercial Plan allows flexible choices among <u>pay-as-you-go, subscription, and license-based</u> billing methods.

### View Version

- All member roles: view it in <<< custom_key.brand_name >>> Console under **Manage > Workspace Settings > Basic Information > Current Version**;

- Owners and Administrators: view it in <<< custom_key.brand_name >>> Console under [**Billing and Paid Plans**](#billing).

## Billing and Paid Plans {#billing}

<<< custom_key.brand_name >>> Public Cloud follows the principle of purchasing on demand and paying as you go.

In the Billing and Paid Plans section, you can view the cash balance, coupon balance, etc., of your current settlement account, and analyze statistics for various billable items such as Time Series, logs, network, APM Trace, APM Profile, RUM PV, Triggers, session replays, etc. Additionally, you can analyze costs from three aspects: detailed billing, usage volume, and data forwarding usage.

### Account Overview {#account}

View the account name, cash balance, coupon balance, prepaid card balance, set high spending alerts, or go directly to the [Billing Center](../billing-center/index.md).

#### Set High Spending Alerts {#alert}

<font size=2>**Note**: Only Owners and Administrators have permission to perform this operation.</font>

- Total Threshold Alert: set an overall spending threshold for the current workspace. Once the total spending amount for all billable items in the workspace **exceeds** this threshold, <<< custom_key.brand_name >>> will automatically send a warning email to the member.

- Single Billable Item Alert: set alerts for individual billable items. When the **daily billing amount exceeds the set alert threshold**, <<< custom_key.brand_name >>> will automatically send a warning email to the member.

<img src="img/billing.png" width="50%" >

1. Fill in the total alert threshold as needed;
2. Select the [billable item](../billing-method/billing-item.md#item) and enter the **alert threshold**;
3. Choose notification members; whether the actual billing amount of the total threshold or a single billable item exceeds the set alert threshold, a warning email will be sent to the members;
4. Click **Confirm**.

**Note**: The Owner role is not restricted by the selection of notification targets. That is, regardless of whether the Owner is selected as a notification target, <<< custom_key.brand_name >>> will send a warning email to the Owner when the alert condition is triggered.

### Usage Statistics

View statistics for each billable item up to the current time and up to yesterday, including: active DataKit, network (host), Time Series, log-type data, backup log data capacity, APM Trace, APM Profile, RUM PV, API Synthetic Tests, Triggers, SMS, session replays, scheduled reports, log write traffic, sensitive data scanning, central Pipeline processing traffic.

### Detailed Billing

View consumption data for each product according to dimensions such as billing mode, usage volume, payable amount, overdue amount, etc., and view cost statistics by different months.

![](img/consumption-2.png)

### Usage Analysis

View the usage of each billable item through visualizations.

![](img/consumption-1.png)

### Data Forwarding Usage Analysis {#transmit}

View the number of data forwardings for all data forwarding rules in the current workspace. You can also view statistics by today, yesterday, this week, last week, this month, last month, and this year.

**Note**:

- If the forwarding rule saves to <<< custom_key.brand_name >>>'s backup logs, it shows the corresponding data retention policy. If saved to external storage, it displays as `-`.
- This list only includes data forwarding rules that exist within the workspace and have a forwarding count > 0.

![](img/comm_01.png)

## [Billing Center](../billing-center/index.md)

???- warning "Workspace Role Differences"

    - Owner: has the **Billing Center** button;
    - Administrator: does not have the above button;
    - Other members: do not have the **Billing and Paid Plans** module, meaning they do not have permission to view billing information.

<<< custom_key.brand_name >>> has two independently operating but interconnected account systems that together enable usage-based billing and payment processes for **Commercial Plan users**:

- [<<< custom_key.brand_name >>> Console](https://<<< custom_key.studio_main_site >>>/) account, which can track the data intake scale and detailed billing of the current workspace and synchronize it with the designated Billing Center account.
- [<<< custom_key.brand_name >>> Billing Center](https://<<< custom_key.boss_domain >>>/) account, which can be bound via `Workspace ID` to achieve **unified billing management at the workspace level** and offers multiple billing settlement options.

![](img/billing-index-1.png)

## Usage-Based Billing Method

<<< custom_key.brand_name >>> Commercial Plan adopts the **pay-as-you-go** [billing method](../billing-method/index.md). Through dimensions such as billing cycle, billable items, billing price, and billing model, it comprehensively calculates the current fee situation.

## Payment Settlement Method

After calculating the detailed billing for the current workspace, <<< custom_key.brand_name >>> synchronizes it to the bound <<< custom_key.brand_name >>> Billing Center account for subsequent payment settlement.

Currently supported are <<< custom_key.brand_name >>> Billing Center accounts and cloud accounts for various [settlement methods](./billing-account/index.md), including Alibaba Cloud, AWS, Huawei Cloud, and Microsoft Cloud accounts. Under the cloud account settlement model, multiple site cloud bills can be consolidated into one cloud account for settlement.