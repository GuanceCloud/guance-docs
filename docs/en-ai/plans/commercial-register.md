# Register for Commercial Plan from the Official Website
---

On the [Guance official website](https://www.guance.com/), click **[Free Register](https://auth.guance.com/businessRegister)**, fill in the relevant information to become a Guance user.

## Step 1: Basic Information {#info}

1. Select the site;
2. Define your username and login password;
3. Enter your email address and verification code sent via email;
4. Enter your phone number;
5. Click **Next**.

![](img/commercial-register-1.png)

### Site Explanation {#site}

Guance provides multiple registration sites. You can choose the appropriate site based on your current cloud environment or billing method.

**Note**:

- Accounts and data across different sites are independent and cannot be shared or transferred. Please choose carefully;

- When registering for the Commercial Plan, you can set up the corresponding [billing method](../billing/billing-account/index.md) based on the selected site, which can be modified as needed later.


| Site               | Login URL                                  | Provider                |
|--------------------|--------------------------------------------|-------------------------|
| China Region 1 (Hangzhou) | [https://auth.guance.com/](https://auth.guance.com/login/pwd) | Alibaba Cloud (China Hangzhou) |
| China Region 2 (Ningxia)   | [https://aws-auth.guance.com/](https://aws-auth.guance.com/login/pwd) | AWS (China Ningxia) |
| China Region 4 (Guangzhou) | [https://cn4-auth.guance.com/](https://cn4-auth.guance.com/login/pwd) | Huawei Cloud (China Guangzhou) |
| China Region 6 (Hong Kong) | [https://cn6-auth.guance.com/](https://cn6-auth.guance.com/login/pwd) | Alibaba Cloud (International) |
| Overseas Region 1 (Oregon) | [https://us1-auth.guance.com/](https://us1-auth.guance.com/) | AWS (US Oregon) |
| Europe Region 1 (Frankfurt) | [https://eu1-auth.guance.com/](https://eu1-auth.guance.com/login/pwd) | AWS (Frankfurt) |
| Asia-Pacific Region 1 (Singapore) | [https://ap1-auth.guance.com/](https://ap1-auth.guance.com/login/pwd) | AWS (Singapore) |

## Step 2: Corporate Information {#corporate}

1. Enter the company name;
2. Read and agree to the relevant agreements;
3. Click **More Information** to optionally fill in additional corporate details;
4. Click **Register**.

**Note**: Completing this step means you have successfully registered a Guance account. The next step will guide you to **set up a workspace under this account**.

![](img/11.account_center_4.png)

## Step 3: Choose Setup Method {#methods}

Based on the site chosen in [Step 1](#info), the third step will display the default setup page accordingly.

1. Enter the workspace name;
2. Define the workspace language;
3. Choose the [setup method](#specific_method) as needed.

### Setup Methods {#specific_method}

#### Direct Setup with Guance {#guanceyun}

Set up the workspace directly using your Guance account.

After successful setup, all charges incurred within the workspace will be billed directly to your Guance account.

#### Setup via Huawei Cloud Store {#huawei-cloud}

You need to purchase the Commercial Plan of Guance from Huawei Cloud first, then set up the workspace using your Huawei Cloud account. All charges incurred within the workspace will be billed directly to your Huawei Cloud account.

1. [**Go to Huawei Cloud for Free Setup**](./commercial-huaweiyun.md#purchase), purchase Guance service;
2. Enter the workspace name;
3. Select the workspace language;
4. Enter the Huawei Cloud account ID;
5. Click **Setup**, complete registration.

![](img/1.register_guance-1.png)

#### Setup via Alibaba Cloud Market {#aliyun}

You need to purchase the Commercial Plan of Guance from Alibaba Cloud first, then set up the workspace using your Alibaba Cloud account. All charges incurred within the workspace will be billed directly to your Alibaba Cloud account.

1. [**Go to Alibaba Cloud for Free Setup of Guance Service**](./commercial-aliyun.md#purchase), purchase Guance service;
2. Enter the workspace name;
3. Select the workspace language;
4. Enter the account ID and product instance ID;
5. Click **Setup**, complete registration.

![](img/1.register_aliyun.png)

<!-- 
???+ warning "Alibaba Cloud users can also use the following methods:"
    
    - You can directly purchase Guance from [Alibaba Cloud Market](https://market.aliyun.com/products/56838014/cmgj00053362.html) and set up Guance through a single sign-on.
    
    > For more detailed steps, refer to [Alibaba Cloud Market Setup of Guance Commercial Plan](commercial-aliyun.md).
    
    - If you are an Alibaba Cloud SLS user and need to use SLS storage in Guance, you can directly purchase the Exclusive Plan from [Alibaba Cloud Market Exclusive Plan](https://market.aliyun.com/products/56838014/cmgj00060481.html) and set up the Exclusive Plan through a single sign-on.
    
    > For more detailed steps, refer to [Alibaba Cloud Market Setup of Guance Exclusive Plan](commercial-aliyun-sls.md) and [Differences between Commercial Plan and Exclusive Plan](../billing/faq.md#_5).
-->

#### Setup via AWS Marketplace {#aws}

You need to purchase the Commercial Plan of Guance from AWS first, then set up the workspace using your AWS account. All charges incurred within the workspace will be billed directly to your AWS account.

1. Enter the workspace name;
2. Select the workspace language;
3. Click **Setup**.

![](img/1.register_aws.png)

In the pop-up window, [subscribe to Guance on AWS Marketplace (China region)](./commercial-aws.md#subscribe), after completing the subscription on the marketplace, return to Guance and click **Confirm** to complete registration.

![](img/aws-market.png)

#### Setup via Microsoft Azure Marketplace {#azure}

You need to purchase the Commercial Plan of Guance from Microsoft Azure Marketplace first, then set up the workspace using your Azure account. All charges incurred within the workspace will be billed directly to your Azure account.

1. Enter the workspace name;
2. Select the workspace language;
3. Click **Setup**.

![](img/register_azure.png)

In the pop-up window, [subscribe to Guance on Microsoft Azure Marketplace](./commercial-azure.md#subscribe), after completing the subscription on the marketplace, return to Guance and click **Confirm** to complete registration.

![](img/register_azure-1.png)

### Synchronize Creation of Billing Center Account {#sync}

The **initial username and password for the [Billing Center](https://boss.guance.com/)** are the same as those for Guance (i.e., the username/password you entered in Step 1). The account systems of the two platforms are independent, so modifying the username/password on one platform will not affect the other.

By selecting this option during the above setup methods, you can synchronize the creation of a Billing Center account.

## Step 4: Setup Successful {#success}

Completing the above steps will successfully set up the Commercial Plan of Guance.

![](img/1.sls_8.png)

After logging into the workspace, you can view the version information of the current workspace in the [Paid Plans and Billing](../billing/index.md#billing) module.

If you only completed Step 2 during registration, you will be prompted to create a workspace when logging in. Select the type of workspace you want to create to complete the registration and login.