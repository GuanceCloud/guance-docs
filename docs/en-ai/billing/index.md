---
icon: zy/billing
---
# Billing Plans and Invoices
---

## Version Description

Guance currently offers three versions: Free Plan, Commercial Plan, and Private Cloud Deployment Plan.

- Public cloud provides both the Free Plan and Commercial Plan, both adopting the <font color=coral>**pay-as-you-go**</font> billing method, with no difference in core functionalities.

    - [The data volume limit for the Free Plan](../plans/trail.md#trail-vs-commercial) is restricted. <u>The Commercial Plan supports larger data volumes and more flexible data retention periods.</u>

- The Private Cloud Deployment Plan also offers Community Edition (equivalent to the Free Plan) and Commercial Plan.

    - The Commercial Plan can choose from multiple billing methods such as <u>pay-as-you-go, subscription, and license-based</u>.

### View Version

- All members: view it in the Guance console under **Management > Workspace Settings > Basic Information > Current Version**;

- Owners and administrators: view it in the Guance console under [**Billing Plans and Invoices**](#billing).

## Billing Plans and Invoices {#billing}

Guance public cloud follows the principle of purchasing on demand and paying based on usage.

In the Billing Plans and Invoices section, you can view the current settlement account's cash balance, voucher balance, etc., and analyze statistics for various billing items including Time Series, logs, network, APM Trace, APM Profile, RUM PV, Triggers, session replay, etc. Additionally, you can analyze costs from three aspects: invoice details, usage, and data forwarding usage.

### Settlement Account Overview {#account}

View the settlement account name, cash account balance, voucher balance, prepaid card balance, set high spending alerts, or go directly to the [Billing Center](../billing-center/index.md).

#### Set High Spending Alerts {#alert}

<font size=2>**Note**: Only Owners and Administrators have permission to perform this operation.</font>

- Total threshold alert: set an overall spending threshold for the current workspace. Once the total consumption amount of all billing items exceeds this threshold, Guance will automatically send a warning email to the member.

- Individual billing item alert: set an alert for a single billing item. When the daily invoice amount of a specific billing item exceeds the set warning threshold, Guance will automatically send a warning email to the member.

<img src="img/billing.png" width="50%" >

1. Fill in the total warning threshold as needed;
2. Select [billing item](../billing-method/billing-item.md#item) and enter the **warning threshold**;
3. Choose notification members; whether the actual invoice amount exceeds the set warning threshold for the total threshold or individual billing item, a warning email will be sent to the members;
4. Click **Confirm**.

**Note**: The Owner role is not subject to restrictions on selecting notification recipients. That is, regardless of whether the Owner is selected as a notification recipient, Guance will send an email notification to the Owner when the warning condition is triggered.

### Usage Statistics

View the statistics for each billing item up to the current time and up to yesterday, including: active DataKit, network (hosts), Time Series, log data, backup log data capacity, APM Trace, APM Profile, RUM PV, Synthetic Tests, Triggers, SMS, session replay, scheduled reports, log write traffic, sensitive data scanning, central Pipeline processing traffic.

### Invoice Details

View detailed consumption data for each product by dimensions such as billing mode, usage, payable amount, overdue amount, etc., and view cost statistics by different months.

![](img/consumption-2.png)

### Usage Analysis

Visually view the usage of each billing item.

![](img/consumption-1.png)

### Data Forwarding Usage Analysis {#transmit}

View the number of data forwarding rules for the current workspace. You can also view statistics by today, yesterday, this week, last week, this month, last month, and this year.

**Note**:

- If the forwarding rule saves data to Guance's backup logs, it displays the corresponding data retention policy. If saved to external storage, it shows as `-`.
- This lists only the data forwarding rules that exist within the workspace and have a forwarding quantity > 0.

![](img/comm_01.png)

## [Billing Center](../billing-center/index.md)

???- warning "Workspace Role Differences"

    - Owner: has the **Billing Center** button;   
    - Administrator: does not have the above button;  
    - Other members: do not have the **Billing Plans and Invoices** module, i.e., they do not have permission to view billing information.

Guance has two independent operating and interconnected account systems that jointly implement usage-based billing and fee settlement processes for **Commercial Plan users**:

- [Guance Console](https://console.guance.com/) account, which can track the scale of data volume access and invoice details for the current workspace, synchronized to the designated Billing Center account.
- [Guance Billing Center](https://boss.guance.com/) account, which can be bound via `Workspace ID` to achieve **unified fee management at the workspace level**, providing multiple payment options for you to choose from.

![](img/billing-index-1.png)

## Usage-Based Billing Method

The Guance Commercial Plan adopts the **pay-as-you-go** [billing method](../billing-method/index.md), calculating the current fee situation through various dimensions such as billing cycle, billing item, billing price, and billing mode.

## Fee Settlement Method

After Guance calculates the detailed invoice for the current workspace, it synchronizes and pushes it to the bound Guance Billing Center account for subsequent fee settlement processes.

Currently supported are Guance Billing Center accounts and cloud accounts for various [settlement methods](./billing-account/index.md), including Alibaba Cloud, AWS, Huawei Cloud, and Microsoft Cloud account settlements. Under the cloud account settlement model, multiple site cloud invoices can be consolidated into one cloud account for settlement.