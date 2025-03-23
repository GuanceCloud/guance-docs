# Public Cloud Free Plan
---

## Differences Between Free Plan and Commercial Plan {#trail-vs-commercial}

The Free Plan and Commercial Plan provided by the public cloud both adopt a <font color=coral>**pay-as-you-go**</font> billing method.

The Free Plan has limitations on the scale of data that can be connected. After [upgrading to the Commercial Plan](#upgrade-commercial), you can connect larger amounts of data with more flexible customization of data retention periods.

???+ warning "Free Plan Usage Notes"

    - The Free Plan incurs no charges if not upgraded, **once upgraded to the Commercial Plan, it cannot be reverted**;
    - If the Free Plan is upgraded to the Commercial Plan, collected data will continue to be reported to the <<< custom_key.brand_name >>> workspace, but **data collected during the Free Plan period will no longer be viewable**;
    - Upgrading to the Commercial Plan is only accessible for the current workspace owner to view and operate;
    - Backup logs count total data, all other billing items are incremental data; incremental data statistics reset the free quota at 0 o'clock daily, valid for the day;
    - If the Free Plan reaches full capacity for any billing item, data reporting will stop until the next cycle; infrastructure and event data types will still allow updates, allowing you to still see infrastructure lists and event data;
    - Due to data content security concerns, the Free Plan workspace **does not support snapshot sharing** functionality.

Differences in service scope supported by the Free Plan and Commercial Plan:

| **Difference** | <div style="width: 200px">Item</div>  | **Free Plan**    | **Commercial Plan**   |
| -------- | ---------------- | ---------- | --------- |
| Data         | Daily data reporting limit | Limited data reporting, excess data will not be reported       | Unlimited |
|          | Data storage strategy     | 7-day rotation        | Customizable [storage strategy](../billing-method/data-storage.md) |
|          | Time Series | 3000 entries | Unlimited    |
|          | Log data | 1 million entries per day<br/>Log data range: events, security checks, logs<br/>(excluding logs from synthetic tests) | Unlimited    |
|          | APM Trace  | 8000 per day | Unlimited    |
|          | APM Profile  | 60 per day | Unlimited    |
|          | RUM PV  | 2000 per day | Unlimited    |
|          | Triggers | 100,000 times per day | Unlimited    |
|          | Synthetic Tests tasks | 200,000 times per day | Unlimited    |
|          | SESSION REPLAY | 1000 per day | Unlimited    |
| Features      | Infrastructure         | :heavy_check_mark: | :heavy_check_mark:    |
|          | LOG            | :heavy_check_mark:| :heavy_check_mark: | 
|          | Backup Logs         | /     | :heavy_check_mark: | 
|          | APM     | :heavy_check_mark: | :heavy_check_mark: | 
|          | RUM     | :heavy_check_mark: | :heavy_check_mark: | 
|          | CI Visualization    | :heavy_check_mark: | :heavy_check_mark: | 
|          | Security Check         | :heavy_check_mark: | :heavy_check_mark: | 
|          | Monitoring      | :heavy_check_mark: | :heavy_check_mark: | 
|          | Synthetic Tests       | China region testing (200,000 times per day)      | Global testing       |
|          | SMS alert notifications     | /     | :heavy_check_mark: | 
|          | DataFlux Func    | :heavy_check_mark: | :heavy_check_mark: | 
|          | Account permissions         | Read-only, standard privileges elevated to admin without approval | Read-only, standard privileges elevated to admin with Billing Center admin approval           |
| Services     | Basic services         | Community, phone, ticket support (5 x 8 hours)     | Community, phone, ticket support (5 x 8 hours)      |
|          | Training services         | Regular observability training              | Regular observability training      |
|          | Expert services         | /     | Professional product technical expert support       |
|          | Value-added services         | /     | Professional internet operation and maintenance services         |
|          | Warroom monitoring screen   | /     | Customizable   |

## Enabling Free Plan {#register-trail}

On the [<<< custom_key.brand_name >>> official website](https://<<< custom_key.brand_main_domain >>>/), click [**Start Free**](https://<<< custom_key.studio_main_site_auth >>>/businessRegister), fill in the relevant information to become a <<< custom_key.brand_name >>> user.

### Step One: Basic Information

1. Select site;
2. Define username and login password;
3. Input email information and enter the verification code sent;
4. Input phone number;
5. Click **Next**.

![](img/commercial-register-1.png)

## Step Two: Corporate Information {#corporate}

1. Enter company name;
2. Read and agree to related agreements;
3. Click **More Information**, where you can fill in other corporate details as needed;
4. Click Register.

**Note**: Completing step two means **successfully registering a <<< custom_key.brand_name >>> account**. The following third step will guide you through **activating a workspace under this account**.

![](img/11.account_center_4.png)

## Step Three: Enable Free Plan

1. Click the top-right corner switch to go to the **Enable Free Plan Workspace** page;

2. Input workspace name;
3. Select workspace language;
4. It's recommended to check the agreement and **synchronize creation of Billing Center account**;
5. Click Register to successfully activate.


![](img/switch.png)

![](img/8.register_5.png)

### Query Free Quotas

The owner or administrator of the <<< custom_key.brand_name >>> workspace can check the daily free quotas and their usage for each billing item in the **Billing** module.

![](img/9.upgrade_1.png)

## Upgrade to Commercial Plan {#upgrade-commercial}

Upgrade notes:

- After successfully upgrading from the Free Plan to the Commercial Plan, **there is no rollback**;
- Collected data will continue to be reported to the <<< custom_key.brand_name >>> workspace, but **data collected during the Free Plan period will no longer be viewable**.

### Prerequisites

- Already registered for the [<<< custom_key.brand_name >>> console](https://<<< custom_key.studio_main_site >>>/) account with an existing Free Plan workspace;
- Synchronized creation of [<<< custom_key.brand_name >>> Billing Center](https://<<< custom_key.boss_domain >>>/) account, linking to subsequent fee settlement functions.


???- abstract "What is a Billing Center account?"

    The [Billing Center](../billing-center/index.md) is <<< custom_key.brand_name >>>'s payment settlement platform. Only by registering an account on this platform can you perform account recharges, payment settlements, and bill management operations.


### Start Upgrading {#upgrade-entry}

In the workspace navigation bar, click **Upgrade Now**:

<img src="../img/upgrade-plan.png" width="50%" >

Or directly navigate to **Plans & Billing**, then click **Upgrade Now**.

If you are the Owner of the current workspace, clicking will directly take you to the upgrade page:

![](img/upgrade-plan-1.png)

Other members will need to contact the workspace Owner to proceed with the upgrade. If you own a <<< custom_key.brand_name >>> Billing Center account, you can directly bind the space within the Billing Center to achieve the version upgrade.

1. Enter the **Plan Upgrade** page;
2. Click **Upgrade**;
3. Begin [binding the <<< custom_key.brand_name >>> Billing Center account](#bind-billing).


### Binding Billing Center Account {#bind-billing}

If you selected the option to synchronize creation of a Billing Center account during the activation of the Free Plan, the system has already created a Billing Center account with the same name as your current account.

![](img/check_for_billing_account.png)

1. Input the username;
2. Input binding email;
3. Obtain verification code;
4. Click bind.

![](img/9.upgrade_3.png)

If you did not select this option at the time, you will need to register a Billing Center account first.

Fill in basic and corporate information to complete registration.

![](img/7.biling_account_5.png)


## View Upgraded Version

Return to <<< custom_key.brand_name >>> Plans & Billing, you'll see the current workspace has been upgraded to the **Commercial Plan**.

Click the top-right **Billing Center** to automatically redirect to the <<< custom_key.brand_name >>> Billing Center.

![](img/9.upgrade_10.png)

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **<<< custom_key.brand_name >>> Product Service Quick Start**</font>](../getting-started/index.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **How to Change Settlement Method?**</font>](../billing/faq/settlement-bill.md#switch)

</div>

</font>