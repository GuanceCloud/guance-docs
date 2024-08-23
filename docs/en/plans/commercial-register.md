# Register Commercial Plan
---

You can go to [Guance official website](https://www.guance.one/), [register now](https://auth.guance.com/en/businessRegister) as a Guance user.

## Step 1: Basic Information {#info}

On the basic information page, select the site and enter the registration information.

![](img/commercial-register-1.png)

<!--
### Site {#site}

Guance provides multiple registration sites, and you can select corresponding sites according to your current cloud environment or settlement methods.

???+ warning

    - The accounts and data of different sites are independent of each other, so it is impossible to share and migrate data with each other. Please choose carefully.
    - When registering the Commercial Plan, the corresponding default settlement method will be set according to the site you choose, which can be modified as needed later.<br/>
    > Refer to the doc [Billing Settlement Methods](../billing/billing-account/index.md).

| Site    | Login Address URL    |  Operator |Default Settlement Method           |
| ----------------- | ---------------- | ------------------ |--- |
| China 1 (Hangzhou)   | [https://auth.guance.com/](https://auth.guance.one/login/pwd) |Alibaba Cloud (Hangzhou, China) | [Alibaba Cloud account settlement](#aliyun)    |
| China 2 (Ningxia)   | [https://aws-auth.guance.com/](https://aws-auth.guance.com/login/pwd) |AWS (Ningxia, China) | [AWS account settlement](#aws)        |
| China 4 (Guangzhou)   | [https://cn4-auth.guance.com/](https://cn4-auth.guance.com/login/pwd) | Huawei Cloud (Guangzhou, China) |[Guance account settlement](#guanceyun) |
| Overseas Region 1 (Oregon) | [https://us1-auth.guance.com/](https://us1-auth.guance.com/) | AWS (Oregon, USA) |[AWS account settlement](#aws)      |


### User Name

When registering [Guance studio account](https://auth.guance.com/businessRegister) on this page, you will be registered with [Guance Billing Center account](https://boss.guance.com/) with **the same user name**, and the user name account of the Billing Center will be checked for uniqueness, which cannot be modified once registered.

> Refer to the doc [Billing Center](../billing/cost-center/index.md).

#### Bind Billing Center User Name Account

When registering on this page, you can directly bind the user name account of the Billing Center. After entering the user name, select **Do you still want to register with this user name?**.

![](img/9.billing_account_1.png)

Enter the user name, account number and password of the Billing Center.

![](img/9.billing_account_2.png)

**Username** can no longer be modified after the binding is completed, please be careful.

![](img/9.billing_account_3.png)
-->

## Step 2: Enterprise Info

On the **Enterprise Information** page, enter necessary information and click **Continue**.

![](img/11.account_center_4.png)

## Step 3: Create Workspace

> Refer to the doc [Guance Expense Settlement](../billing/billing-account/index.md).

### Workspace Name

Workspace is a collaborative space for Guance data insight. Customize your workspace names.

### Workspace Language

Workspace language options will affect templates such as events, alarms and short messages in the workspace. If English is selected, the above corresponding template will be used by default. Once created, the template language of this workspace cannot be modified, so please choose carefully.


### Workspace Style

Guance has designed four workspace styles: Dev, Ops, Test and Default. When you select a specific style and complete the registration, Guance will show you the corresponding function menu style in the workspace.

> Go check [different styles of workspace function menu](../management/index.md#create).

If you need to set the menu, you can go to **Management > Advanced Settings > [Function Menu](../management/settings/customized-menu.md)** to modify it.

### Four Settlement Methods

#### Guance Billing Center account Settlement

Guance provides the Billing Center account settlement of Guance by default, and all expenses incurred in the workspace will be settled directly from the balance of vouchers and Huawei Cloud stored-value cards purchased by your [Guance Billing Center account settlement](../billing/billing-account/enterprise-account.md).

You can enter **Workspace Name** in the dialog box below, select **Workspace Language** and click OK to complete the registration.

![](img/4.register_language_2.2.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Guance Billing Center account Settlement</font>](./billing-account/enterprise-account.md)

</div>

#### Alibaba Cloud Account Settlement {#aliyun}

Guance provides Alibaba Cloud account settlement, and all expenses incurred in the workspace will be settled directly from your Alibaba Cloud account.

You can **Select Opening Method**, fill in **Workspace Name**, select **Workspace Language**, [go to Alibaba Cloud to open Guance service for free](https://market.aliyun.com/products/56838014/cmgj00053362.html) to obtain and fill in [Ali user ID](../billing/billing-account/aliyun-account.md#uid) and [commodity instance ID](../billing/billing-account/aliyun-account.md#entity-id), and click OK to complete the registration.

???+ warning "Alibaba Cloud users can directly open Guance in the following ways:"
    
    - You can purchase Guance directly from [Guance in Alibaba Cloud market](https://market.aliyun.com/products/56838014/cmgj00053362.html), and open Guance directly through login-free registration.
  
    > Please refer to the document [Open Guance Commercial Plan in Alibaba Cloud Market](commercial-aliyun.md).

    - If you are an Alibaba Cloud SLS user and need to use SLS storage in Guance, you can purchase [Guance Exclusive Plan directly at Alibaba Cloud market](https://market.aliyun.com/products/56838014/cmgj00060481.html), and open Guance Exclusive Plan directly through login-free registration.

    > Please refer to the doc [Open Guance Independent Plan at Alibaba Cloud market](commercial-aliyun-sls.md) and [Difference between Guance Commercial Plan and Guance Independent Plan](../billing/faq.md#_5).

![](img/4.register_language_1.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Alibaba Cloud Account Settlement</font>](./billing-account/aliyun-account.md)

<br/>

</div>

#### AWS Account Settlement

Guance provides AWS account settlement, and all expenses incurred in the workspace will be settled directly from your AWS account.

You can subscribe to Guance on AWS by clicking on [Go to Amazon Cloud marketplace to subscribe](../billing/billing-account/aws-account.md#subscribe) in **Choose how to Open it**. After completing the subscription, enter **Workspace Name** in the dialog box below, select **Workspace Language** and click **Register** to complete the registration.

![](img/4.register_language_2.1.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; AWS Account Settlement</font>](./billing-account/aws-account.md)

<br/>

</div>

#### Huawei Cloud Account Settlement {#huawei-cloud}

If you choose [Huawei Cloud Account for settlement](./billing-account/huawei-account.md) when registering, all expenses incurred in the workspace will be settled directly from your Huawei Cloud Account.

Click **[Go to Huawei Cloud to open free Guance service](../billing/billing-account/huawei-account.md#market)** and then subscribe to Guance services at Huawei Yunyun Store and open Huawei Cloud Account for settlement.

![](img/huawei-create.png)

You can also open Guance directly in the following way:
    
Go directly to [Huawei Cloud KooGallery](https://marketplace.huaweicloud.com/intl), purchase SaaS version of Guance, and open Guance directly through login-free registration.

### Synchronize Creation of Billing Center Account

<u>The initial user name and password of the Billing Center are the same as those of Guance (that is, the user name/password you filled in in the first step)</u>, and the account systems of the two platforms are independent of each other. Subsequent modification of the user name/password will not affect the other platform.


When checked, you can create a Billing Center account for you simultaneously.


## Step 4: Open Successfully

After selecting the opening mode, if the registration is successful, it will be prompted to successfully open Guance.

![](img/inter-1.sls_8.png)

After logging in to the workspace, you can view the version information of the current workspace in the Billing module of Guance.

![](img/12.billing_1.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Introduction of Billing Module in Commercial Plan</font>](../billing/commercial.md#_4)

<br/>

</div>

If you have only completed the second step when registering, you will be prompted to create a workspace when logging in. Select the workspace type to be created to complete the registration and login.

![](img/4.register_language_3.png)

## Start Using Guance

After registering for the first time to enter the workspace, you can watch the introduction video of Guance, or you can click **Get Startted with Installing DataKit** to install and configure the first DataKit.

![](img/1-free-start-1109.png)
