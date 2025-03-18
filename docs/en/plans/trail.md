# Public Cloud Free Plan
---

## Differences Between Free Plan and Commercial Plan {#trail-vs-commercial}

Public cloud offers both the Free Plan and Commercial Plan, both of which adopt the <font color=coral>**pay-as-you-go**</font> billing method.

The Free Plan has restrictions on the scale of data that can be ingested. After [upgrading to the Commercial Plan](#upgrade-commercial), larger volumes of data can be ingested with more flexible custom data retention periods.

???+ warning "Free Plan Usage Guidelines"

    - The Free Plan does not incur charges unless upgraded; **once upgraded to the Commercial Plan, it cannot be reverted**;
    - If you upgrade from the Free Plan to the Commercial Plan, data collection will continue to report to the <<< custom_key.brand_name >>> workspace, but **data collected during the Free Plan period will no longer be accessible**;
    - Upgrading to the Commercial Plan is only available for the current workspace owner to view and operate;
    - Backup logs are counted as full data, while other billing items are incremental data; the free quota resets at 0:00 every day and is valid for that day;
    - If any billing item reaches its limit under the Free Plan, data reporting will stop until the next day; infrastructure and event data still support updates, allowing you to see infrastructure list data and event data;
    - Due to data security concerns, the Free Plan workspace **does not support snapshot sharing**.

Differences in supported services between the Free Plan and Commercial Plan:

| **Difference** | <div style="width: 200px">Item</div> | **Free Plan** | **Commercial Plan** |
| -------------- | ---------------- | ------------- | ------------------- |
| Data           | Daily data reporting limit | Limited data, excess data will not be reported | Unlimited |
|                | Data retention policy | 7-day rotation | Customizable [retention policy](../billing-method/data-storage.md) |
|                | Time Series | 3000 entries | Unlimited |
|                | Log data | 1 million entries per day<br/>Log data scope: events, security checks, logs<br/>(excluding Synthetic Tests log data) | Unlimited |
|                | APM Trace | 8000 entries per day | Unlimited |
|                | APM Profile | 60 entries per day | Unlimited |
|                | RUM PV | 2000 entries per day | Unlimited |
|                | Trigger calls | 100,000 calls per day | Unlimited |
|                | Synthetic Tests | 200,000 tests per day | Unlimited |
|                | Session Replay | 1000 sessions per day | Unlimited |
| Features       | Infrastructure | :heavy_check_mark: | :heavy_check_mark: |
|                | Logs | :heavy_check_mark: | :heavy_check_mark: |
|                | Backup logs | / | :heavy_check_mark: |
|                | APM | :heavy_check_mark: | :heavy_check_mark: |
|                | RUM | :heavy_check_mark: | :heavy_check_mark: |
|                | CI Visualization | :heavy_check_mark: | :heavy_check_mark: |
|                | Security Check | :heavy_check_mark: | :heavy_check_mark: |
|                | Monitoring | :heavy_check_mark: | :heavy_check_mark: |
|                | Synthetic Tests | China region (200,000 tests per day) | Global tests |
|                | SMS alert notifications | / | :heavy_check_mark: |
|                | DataFlux Func | :heavy_check_mark: | :heavy_check_mark: |
|                | Account permissions | Read-only, standard permissions can be elevated to admin without review | Read-only, standard permissions can be elevated to admin with Billing Center admin review |
| Services      | Basic services | Community, phone, ticket support (5 x 8 hours) | Community, phone, ticket support (5 x 8 hours) |
|                | Training services | Regular observability training | Regular observability training |
|                | Expert services | / | Professional product technical expert support |
|                | Value-added services | / | Professional internet operation services |
|                | Monitoring digital war room | / | Customizable |

## Registering for the Free Plan {#register-trail}

On the [<<< custom_key.brand_name >>> website](https://<<< custom_key.brand_main_domain >>>/), click [**Get Started Free**](https://<<< custom_key.studio_main_site_auth >>>/businessRegister), fill in the relevant information, and you can become a <<< custom_key.brand_name >>> user.

### Step 1: Basic Information

1. Select site;
2. Define username and login password;
3. Enter email information and enter the verification code sent;
4. Enter phone number;
5. Click **Next**.

![](img/commercial-register-1.png)

## Step 2: Corporate Information {#corporate}

1. Enter company name;
2. Read and agree to the relevant agreements;
3. Click **More Information**, and fill in additional corporate details as needed;
4. Click Register.

**Note**: Completing this step means you have **successfully registered a <<< custom_key.brand_name >>> account**. The next step will guide you to **activate a workspace under this account**.

![](img/11.account_center_4.png)

## Step 3: Activate Free Plan

1. Click the top-right corner of the current page to switch to the **Activate Free Plan Workspace** page;

2. Enter workspace name;
3. Select workspace language;
4. It is recommended to check the agreement and **synchronize the creation of a Billing Center account**;
5. Click Register to activate successfully.

![](img/switch.png)

![](img/8.register_5.png)

### Query Free Quotas

Owners and administrators of <<< custom_key.brand_name >>> workspaces can view daily free quotas and their usage for each billing item in the **Billing** module.

![](img/9.upgrade_1.png)

## Upgrade to Commercial Plan {#upgrade-commercial}

Upgrade Notes:

- After successfully upgrading from the Free Plan to the Commercial Plan, **it cannot be reverted**;
- Data collected during the Free Plan period will no longer be accessible after upgrading.

### Prerequisites

- Register a [<<< custom_key.brand_name >>> Console](https://<<< custom_key.studio_main_site >>>/) account and have a Free Plan workspace;
- Synchronize the creation of a [<<< custom_key.brand_name >>> Billing Center](https://<<< custom_key.boss_domain >>>/) account to connect with subsequent billing functions.

???- abstract "What is a Billing Center account?"

    The [Billing Center](../billing-center/index.md) is <<< custom_key.brand_name >>>'s payment settlement platform. Only by registering an account on this platform can you perform account recharges, payment settlements, and bill management.

### Start Upgrade {#upgrade-entry}

In the workspace navigation bar, click **Upgrade Now**:

<img src="../img/upgrade-plan.png" width="50%" >

Or go directly to **Billing** and click **Upgrade Now**.

If you are the Owner of the current workspace, clicking will take you directly to the upgrade page:

![](img/upgrade-plan-1.png)

Other members need to contact the workspace Owner for the upgrade. If you have a <<< custom_key.brand_name >>> Billing Center account, you can directly bind the space in the Billing Center to achieve version upgrades.

1. Enter the **Plan Upgrade** page;
2. Click **Upgrade**;
3. Begin [binding the <<< custom_key.brand_name >>> Billing Center account](#bind-billing).

### Bind Billing Center Account {#bind-billing}

If you selected to create a Billing Center account synchronously during the Free Plan activation process, the system has already created a Billing Center account with the same name as your current account.

![](img/check_for_billing_account.png)

1. Enter the username;
2. Enter the binding email;
3. Get the verification code;
4. Click Bind.

![](img/9.upgrade_3.png)

If you did not select this option at the time, you need to register a Billing Center account first.

Fill in the basic and corporate information to complete registration.

![](img/7.biling_account_5.png)

## View Upgraded Version

Return to <<< custom_key.brand_name >>> Billing to see that the current workspace has been upgraded to the **Commercial Plan**.

Click the top-right **Billing Center** to automatically redirect to the <<< custom_key.brand_name >>> Billing Center.

![](img/9.upgrade_10.png)

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Quick Start Guide for <<< custom_key.brand_name >>> Products**</font>](../getting-started/index.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **How to Change the Billing Method?**</font>](../billing/faq/settlement-bill.md#switch)

</div>

</font>