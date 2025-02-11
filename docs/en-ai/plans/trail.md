# Public Cloud Free Plan
---

## Differences Between Free Plan and Commercial Plan {#trail-vs-commercial}

The Free Plan and Commercial Plan provided by the public cloud both adopt the <font color=coral>**pay-as-you-go**</font> billing method.

The Free Plan has limitations on the scale of data that can be ingested. After [upgrading to the Commercial Plan](#upgrade-commercial), you can ingest larger volumes of data with more flexible options for customizing data retention periods.

???+ warning "Free Plan Usage Notes"

    - The Free Plan is free until upgraded; **once upgraded to the Commercial Plan, it cannot be reverted**;
    - If you upgrade from the Free Plan to the Commercial Plan, data collection will continue to be reported to the Guance workspace, but **data collected during the Free Plan period will no longer be accessible**;
    - Upgrading to the Commercial Plan is only available to the current workspace owner for viewing and operation;
    - Backup logs are calculated based on total data volume, while other billing items are incremental data. Incremental data statistics reset the free quota at 0:00 every day and are valid for the day;
    - If the Free Plan's data quotas for different billing items reach their limits, data reporting will stop updating; however, infrastructure and event data will still be reported and updated, allowing you to see infrastructure list data and event data;
    - Due to data content security concerns, the Free Plan workspace **does not support snapshot sharing** functionality.

Differences in supported services between the Free Plan and Commercial Plan:

| **Difference** | <div style="width: 200px">Item</div>  | **Free Plan**    | **Commercial Plan**   |
| -------- | ---------------- | ---------- | --------- |
| Data         | Daily Data Reporting Limit | Limited data, excess data will not be reported       | Unlimited |
|          | Data Storage Policy     | 7-day rotation        | Customizable [storage policy](../billing-method/data-storage.md) |
|          | Time Series | 3000 entries | Unlimited    |
|          | Log Data | 1 million entries per day<br/>Log data scope: events, Security Check, logs<br/>(excluding logs from Synthetic Tests) | Unlimited    |
|          | APM Trace  | 8,000 entries per day | Unlimited    |
|          | APM Profile  | 60 entries per day | Unlimited    |
|          | RUM PV  | 2,000 entries per day | Unlimited    |
|          | Trigger Calls | 100,000 calls per day | Unlimited    |
|          | Synthetic Test Tasks | 200,000 calls per day | Unlimited    |
|          | Session Replay | 1,000 sessions per day | Unlimited    |
| Features      | Infrastructure         | :heavy_check_mark: | :heavy_check_mark:    |
|          | Logs            | :heavy_check_mark:| :heavy_check_mark: | 
|          | Backup Logs         | /     | :heavy_check_mark: | 
|          | APM     | :heavy_check_mark: | :heavy_check_mark: | 
|          | RUM     | :heavy_check_mark: | :heavy_check_mark: | 
|          | CI Visualization    | :heavy_check_mark: | :heavy_check_mark: | 
|          | Security Check         | :heavy_check_mark: | :heavy_check_mark: | 
|          | Monitoring      | :heavy_check_mark: | :heavy_check_mark: | 
|          | Synthetic Tests       | China region dial testing (200,000 calls per day)      | Global dial testing       |
|          | SMS Alert Notifications     | /     | :heavy_check_mark: | 
|          | DataFlux Func    | :heavy_check_mark: | :heavy_check_mark: | 
|          | Account Permissions         | Read-only, standard permissions can be elevated to admin without review | Read-only, standard permissions can be elevated to admin with review by billing center admin           |
| Services     | Basic Services         | Community, phone, ticket support (5 x 8 hours)     | Community, phone, ticket support (5 x 8 hours)      |
|          | Training Services         | Regular observability training              | Regular observability training      |
|          | Expert Services         | /     | Professional product and technical expert support       |
|          | Value-added Services         | /     | Professional internet operations service         |
|          | Monitoring Digital Warroom   | /     | Customizable   |

## Activating the Free Plan {#register-trail}

On the [Guance official website](https://www.guance.com/), click [**Start Free**](https://auth.guance.com/businessRegister), fill in the required information, and you will become a Guance user.

### Step One: Basic Information

1. Select the site;
2. Define your username and login password;
3. Enter email information and fill in the verification code sent;
4. Enter your phone number;
5. Click **Next**.

![](img/commercial-register-1.png)

## Step Two: Company Information {#corporate}

1. Enter the company name;
2. Read and agree to the relevant agreements;
3. Click **More Information**, and you can fill in other company-related information as needed;
4. Click Register.

**Note**: Completing step two means **successfully registering a Guance account**. The next step three will guide you to **activate the workspace under this account**.

![](img/11.account_center_4.png)

## Step Three: Activate the Free Plan

1. Click the top-right corner of the current page to switch to the **Activate Free Plan Workspace** page;

2. Enter the workspace name;
3. Choose the workspace language;
4. It is recommended to check the agreement and **synchronize the creation of a billing center account**;
5. Click Register to successfully activate.

![](img/switch.png)

![](img/8.register_5.png)

### Checking Free Quotas

Owners and administrators of the Guance workspace can view the daily free quotas and usage for each billing item in the **Billing Plan and Invoices** module.

![](img/9.upgrade_1.png)

## Upgrade to Commercial Plan {#upgrade-commercial}

Upgrade Notes:

- Once the Free Plan is successfully upgraded to the Commercial Plan, **it cannot be reverted**;
- Data collection will continue to be reported to the Guance workspace, but **data collected during the Free Plan period will no longer be accessible**.

### Prerequisites

- You have registered a [Guance Console](https://console.guance.com/) account and have a Free Plan workspace;
- Synchronize the creation of a [Guance Billing Center](https://boss.guance.com/) account to connect with subsequent billing settlement functions.


???- abstract "What is a Billing Center Account?"

    The [Billing Center](../billing-center/index.md) is Guance's payment and settlement platform. Only accounts registered on this platform can perform account recharges, payments, invoice management, etc.


### Start Upgrading {#upgrade-entry}

In the workspace navigation bar, click **Upgrade Now**:

<img src="../img/upgrade-plan.png" width="50%" >

Or directly go to **Billing Plan and Invoices** and click **Upgrade Now**.

If you are the Owner of the current workspace, clicking will directly take you to the upgrade page:

![](img/upgrade-plan-1.png)

Other members need to contact the workspace Owner for an upgrade. If you have a Guance Billing Center account, you can directly enter the billing center to bind the space, thus achieving version upgrades.

1. Enter the **Plan Upgrade** page;
2. Click **Upgrade**;
3. Start [binding the Guance Billing Center account](#bind-billing).


### Binding the Billing Center Account {#bind-billing}

If you selected the option to create a billing center account simultaneously when activating the Free Plan, the system has already created a billing center account with the same name as your current account.

![](img/check_for_billing_account.png)

1. Enter the username;
2. Enter the binding email;
3. Get the verification code;
4. Click Bind.

![](img/9.upgrade_3.png)

If you did not select this option at the time, you need to register a billing center account first.

Fill in the basic information and company information to complete registration.

![](img/7.biling_account_5.png)


## View Upgraded Version

Return to the Guance billing plan and invoices, and you will see that the current workspace has been upgraded to the **Commercial Plan**.

Click the **Billing Center** in the top right corner to automatically redirect to the Guance Billing Center.

![](img/9.upgrade_10.png)

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Quick Start Guide for Guance Products**</font>](../getting-started/index.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **How to Change Settlement Method?**</font>](../billing/faq/settlement-bill.md#switch)

</div>

</font>