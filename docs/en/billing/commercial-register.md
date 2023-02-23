# Register Commercial Plan
---

You can go to [Guance official website](https://www.guance.com/), [register now](https://auth.guance.com/businessRegister) as a Guance user.

## Step 1: Basic Information {#info}

On the basic information page, select the site and enter the registration information.

![](img/commercial-register-1.png)

### Site {#site}

Guance provides multiple registration sites, and you can select corresponding sites according to your current cloud environment or settlement methods.

???+ attention

    - The accounts and data of different sites are independent of each other, so it is impossible to share and migrate data with each other. Please choose carefully.
    - When registering the commercial plan, the corresponding default settlement method will be set according to the site you choose, which can be modified as needed later.<br/>
    > Refer to the doc [<expense settlement method>](../billing/billing-account/index.md).

| Site    | Login Address URL    |  Operator |Default Settlement Method           |
| ----------------- | ---------------- | ------------------ |--- |
| China 1 (Hangzhou)   | [https://auth.guance.com/](https://auth.guance.com/login/pwd) |Alibaba Cloud (Hangzhou, China) | [Alibaba Cloud account settlement](#aliyun)    |
| China 2 (Ningxia)   | [https://aws-auth.guance.com/](https://aws-auth.guance.com/login/pwd) |AWS (Ningxia, China) | [AWS account settlement](#aws)        |
| China 4 (Guangzhou)   | [https://cn4-auth.guance.com/](https://cn4-auth.guance.com/login/pwd) | Huawei Cloud (Guangzhou, China) |[Guance account settlement](#guanceyun) |
| Overseas Region 1 (Oregon) | [https://us1-auth.guance.com/](https://us1-auth.guance.com/) | AWS (Oregon, USA) |[AWS account settlement](#aws)      |

### User Name

When registering [Guance studio account](https://auth.guance.com/businessRegister) on this page, you will be registered with [Guance expense center account](https://boss.guance.com/) with **the same user name**, and the user name account of the expense center will be checked for uniqueness, which cannot be modified once registered.

> Refer to the doc [<expense center>](../billing/cost-center/index.md).

#### Bind Expense Center User Name Account

When registering on this page, you can directly bind the user name account of the expense center. After entering the user name, select "Do you still want to register with this user name?" .

![](img/9.billing_account_1.png)

Enter the user name, account number and password of the expense center.

![](img/9.billing_account_2.png)

**Username** can no longer be modified after the binding is completed, please be careful.

![](img/9.billing_account_3.png)

## Step 2: Enterprise Info

On the **Enterprise Information** page, enter relevant information and click **Register**.

![](img/11.account_center_4.png)

## Step 3: Select Opening Method

Depending on the site selected in [Step 1: Basic Info](#info), the third step displays the corresponding default opening mode page.

> Refer to the doc [<Guance expense settlement>](../billing/billing-account/index.md).

### Workspace Name

Workspace is a collaborative space for Guance data insight. Users can query and analyze data in the workspace, and support custom workspace names.

### Workspace Language

Workspace language options will affect templates such as events, alarms and short messages in the workspace. If English is selected, the above corresponding template will be used by default. Once created, the template language of this workspace cannot be modified, so please choose carefully.

### Alibaba Cloud Account Settlement {#aliyun}

If you select **China 1 (Hangzhou)** site when registering, Guance will provide Alibaba Cloud account settlement by default, and all expenses incurred in the workspace will be settled directly from your Alibaba Cloud account.

You can **Select Opening Method**, fill in **Workspace Name**, select **Workspace Language**, [go to Alibaba Cloud to open Guance service for free](https://market.aliyun.com/products/56838014/cmgj00053362.html) to obtain and fill in [Ali user ID](../billing/billing-account/aliyun-account.md#uid) and [commodity instance ID](../billing/billing-account/aliyun-account.md#entity-id), and click OK to complete the registration.

???+ attention

    For Alibaba Cloud users, you can also directly open Guance for use in the following ways.
    
    - You can purchase Guance directly from [Guance in Alibaba Cloud market](https://market.aliyun.com/products/56838014/cmgj00053362.html), and open Guance directly through login-free registration.<br/>
    > For more details, please refer to the document [<open Guance commercial plan in Alibaba Cloud Market>](commercial-aliyun.md)
    - If you are an Alibaba Cloud SLS user and need to use SLS storage in Guance, you can purchase [Guance exclusive plan directly at Alibaba Cloud market](https://market.aliyun.com/products/56838014/cmgj00060481.html), and open Guance exclusive plan directly through login-free registration. <br/>
    > For more detailed steps, please refer to the documentation [<open Guance exclusive at Alibaba Cloud market>](commercial-aliyun-sls.md) and [<difference between Guance commercial plan and Guance exclusive plan>](../billing/faq.md#_5).

![](img/4.register_language_1.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Alibaba Cloud account settlement doc</font>](./billing-account/aliyun-account.md)

<br/>

</div>

### AWS Account Settlement

If you select "China 2 (Ningxia)" and "Overseas 1 (Oregon)" sites when registering, Guance will provide AWS account settlement by default, and all expenses incurred in the workspace will be settled directly from your AWS account.

You can subscribe to Guance on AWS by clicking on [Go to Amazon Cloud Marketplace to Subscribe](../billing/billing-account/aws-account.md#subscribe) in **Choose how to Open it**. After completing the subscription, enter **Workspace Name** in the dialog box below, select **Workspace Language** and click OK to complete the registration.

![](img/4.register_language_2.1.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; AWS account settlement doc</font>](./billing-account/aws-account.md)

<br/>

</div>

### Guance Enterprise Account Settlement

If you select the "China 4 (Guangzhou)" site when registering, Guance will provide the enterprise account settlement of Guance by default, and all expenses incurred in the workspace will be settled directly from the balance of vouchers and Huawei Cloud stored-value cards purchased by your [Guance enterprise account settlement](../billing/billing-account/enterprise-account.md).

You can enter **Workspace Name** in the dialog box below, select **Workspace Language** and click OK to complete the registration.

![](img/4.register_language_2.2.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Guance enterprise account settlement doc</font>](./billing-account/enterprise-account.md)

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Huawei Cloud stored-value cards settlement doc</font>](./billing-account/huaweicloud-account.md)

</div>

## Step 4: Open Successfully

After selecting the opening mode, if the registration is successful, it will be prompted to successfully open Guance.

![](img/1.sls_8.png)

After logging in to the workspace, you can view the version information of the current workspace in the Billing module of Guance.

![](img/12.billing_1.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; introduction of Billing module in commercial plan</font>](../billing/commercial.md#_4)

<br/>

</div>

If you have only completed the second step when registering, you will be prompted to create a workspace when logging in. Select the workspace type to be created to complete the registration and login.

![](img/4.register_language_3.png)

## Start Using Guance

After registering for the first time to enter the workspace, you can watch the introduction video of Guance, or you can click **Get Startted with Installing DataKit** to install and configure the first DataKit.

![](img/1-free-start-1109.png)
