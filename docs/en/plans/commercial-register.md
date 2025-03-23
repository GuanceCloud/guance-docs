# Register for the Commercial Plan from the Official Website
---

On the [<<< custom_key.brand_name >>> official website](https://<<< custom_key.brand_main_domain >>>/), click **[Free Registration](https://<<< custom_key.studio_main_site_auth >>>/businessRegister)**, and after filling out the relevant information, you will become a <<< custom_key.brand_name >>> user.

## Step One: Basic Information {#info}

1. Select site;
2. Define username and login password;
3. Enter email information and fill in the verification code sent;
4. Enter phone number;
5. Click **Next**.

![](img/commercial-register-1.png)

### Site Description {#site}

<<< custom_key.brand_name >>> provides multiple registration sites; you can choose the corresponding site based on your current cloud environment or settlement method, etc.

**Note**:

- Accounts and data from different sites are independent of each other and cannot be shared or transferred. Please choose carefully;

- While registering for the Commercial Plan, you can set up the corresponding [settlement method](../billing/billing-account/index.md) according to the selected site, which can be modified as needed later.

<<<% if custom_key.brand_key == 'truewatch' %>>>

| Site       | Login URL                          | Provider           |
|------------|------------------------------------|--------------------|
| Americas 1 (Oregon) | [https://us1-auth.<<< custom_key.brand_main_domain >>>/](https://us1-auth.<<< custom_key.brand_main_domain >>>/) | AWS (US Oregon) |
| Europe 1 (Frankfurt) | [https://eu1-auth.<<< custom_key.brand_main_domain >>>/](https://eu1-auth.<<< custom_key.brand_main_domain >>>/login/pwd) | AWS (Frankfurt) |
| Asia-Pacific 1 (Singapore) | [https://ap1-auth.<<< custom_key.brand_main_domain >>>/](https://ap1-auth.<<< custom_key.brand_main_domain >>>/login/pwd) | AWS (Singapore) |
| Africa 1 (South Africa) | [https://za1-auth.<<< custom_key.brand_main_domain >>>/](https://za1-auth.<<< custom_key.brand_main_domain >>>/login/pwd) | Huawei Cloud (South Africa) |
| Indonesia 1 (Jakarta) | [https://id1-auth.<<< custom_key.brand_main_domain >>>/](https://id1-auth.<<< custom_key.brand_main_domain >>>/login/pwd) | Tencent Cloud (Jakarta) |

<<<% else %>>>

| Site         | Login URL                          | Provider              |
|--------------|------------------------------------|-----------------------|
| China 1 (Hangzhou) | [https://auth.<<< custom_key.brand_main_domain >>>/](https://auth.<<< custom_key.brand_main_domain >>>/login/pwd) | Alibaba Cloud (China Hangzhou) |
| China 2 (Ningxia) | [https://aws-auth.<<< custom_key.brand_main_domain >>>/](https://aws-auth.<<< custom_key.brand_main_domain >>>/login/pwd) | AWS (China Ningxia) |
| China 4 (Guangzhou) | [https://cn4-auth.<<< custom_key.brand_main_domain >>>/](https://cn4-auth.<<< custom_key.brand_main_domain >>>/login/pwd) | Huawei Cloud (China Guangzhou) |
| China 6 (Hong Kong) | [https://cn6-auth.<<< custom_key.brand_main_domain >>>/](https://cn6-auth.<<< custom_key.brand_main_domain >>>/login/pwd) | Alibaba Cloud (International Site) |
| Americas 1 (Oregon) | [https://us1-auth.<<< custom_key.brand_main_domain >>>/](https://us1-auth.<<< custom_key.brand_main_domain >>>/) | AWS (US Oregon) |
| Europe 1 (Frankfurt) | [https://eu1-auth.<<< custom_key.brand_main_domain >>>/](https://eu1-auth.<<< custom_key.brand_main_domain >>>/login/pwd) | AWS (Frankfurt) |
| Asia-Pacific 1 (Singapore) | [https://ap1-auth.<<< custom_key.brand_main_domain >>>/](https://ap1-auth.<<< custom_key.brand_main_domain >>>/login/pwd) | AWS (Singapore) |
| Africa 1 (South Africa) | [https://za1-auth.<<< custom_key.brand_main_domain >>>/](https://za1-auth.<<< custom_key.brand_main_domain >>>/login/pwd) | Huawei Cloud (South Africa) |
| Indonesia 1 (Jakarta) | [https://id1-auth.<<< custom_key.brand_main_domain >>>/](https://id1-auth.<<< custom_key.brand_main_domain >>>/login/pwd) | Tencent Cloud (Jakarta) |

<<<% endif %>>>

## Step Two: Corporate Information {#corporate}

1. Enter company name;
2. Read and agree to related agreements;
3. Click **More Information**, where you can fill in additional corporate-related information as needed;
4. Click register.

**Note**: Completing step two means that you have successfully registered a <<< custom_key.brand_name >>> account. The following third step will guide you to activate the workspace under this account.

![](img/11.account_center_4.png)


## Step Three: Choose Activation Method {#methods}

Based on the site chosen in [Step One](#info), the third step will display the corresponding default activation method page.

1. Enter workspace name;
2. Define workspace language;
3. Choose [activation method](#specific_method) as needed.

### Activation Method {#specific_method}

#### Direct Activation via <<< custom_key.brand_name >>> {#guanceyun}

That is, directly create a workspace through the <<< custom_key.brand_name >>> account.

After successful activation, all costs generated within the workspace will be settled directly from your <<< custom_key.brand_name >>> account.


#### Activation via Huawei Cloud Store {#huawei-cloud}

You must first purchase the commercial version product of <<< custom_key.brand_name >>> on Huawei Cloud and activate the workspace through your Huawei Cloud account. All subsequent costs generated within the workspace will be directly settled from your Huawei Cloud account.

1. [**Go to Huawei Cloud Free Activation**](./commercial-huaweiyun.md#purchase), purchase <<< custom_key.brand_name >>> services;
2. Enter workspace name;
3. Select workspace language;
4. Enter Huawei Cloud Account ID;
5. Click activate, complete registration.

![](img/1.register_guance-1.png)


#### Activation via Alibaba Cloud Market {#aliyun}

You must first purchase the commercial version product of <<< custom_key.brand_name >>> on Alibaba Cloud and activate the workspace through your Alibaba Cloud account. All subsequent costs generated within the workspace will be directly settled from your Alibaba Cloud account.

1. [**Go to Alibaba Cloud Free Activation <<< custom_key.brand_name >>> Services**](./commercial-aliyun.md#purchase), purchase <<< custom_key.brand_name >>> services;
2. Enter workspace name;
3. Select workspace language;
4. Enter Account ID and Product Instance ID;
5. Click activate, complete registration.

![](img/1.register_aliyun.png)

<!--
???+ warning "Alibaba Cloud users can also use the following methods for activation:"
    
    - You can directly purchase <<< custom_key.brand_name >>> on [Alibaba Cloud Market <<< custom_key.brand_name >>>](https://market.aliyun.com/products/56838014/cmgj00053362.html) and activate <<< custom_key.brand_name >>> directly through a single sign-on registration.
    
    > For more detailed steps, refer to [Activate the Commercial Version of <<< custom_key.brand_name >>> via Alibaba Cloud Market](commercial-aliyun.md).
    
    - If you are an Alibaba Cloud SLS user and need to use SLS storage with <<< custom_key.brand_name >>>, you can directly purchase the exclusive version of <<< custom_key.brand_name >>> on [Alibaba Cloud Market <<< custom_key.brand_name >>> Exclusive Edition](https://market.aliyun.com/products/56838014/cmgj00060481.html) and activate the exclusive version of <<< custom_key.brand_name >>> directly through a single sign-on registration.
    
    > For more detailed steps, refer to [Activate the Exclusive Version of <<< custom_key.brand_name >>> via Alibaba Cloud Market](commercial-aliyun-sls.md), [Differences Between the Commercial Version and the Exclusive Version of <<< custom_key.brand_name >>>](../billing/faq.md#_5).
-->


#### Activation via Amazon Web Services Marketplace {#aws}

You must first purchase the commercial version product of <<< custom_key.brand_name >>> on AWS and activate the workspace through your AWS account. All subsequent costs generated within the workspace will be directly settled from your AWS account.

1. Fill in workspace name;
2. Select workspace language;
3. Click activate.

![](img/1.register_aws.png)

In the pop-up window, [go to the Amazon Web Services Marketplace (China Region) Subscription](./commercial-aws.md#subscribe <<< custom_key.brand_name >>> -subscribe), after completing the subscription on the cloud marketplace, return to <<< custom_key.brand_name >>> test and click **Confirm** to complete registration.

![](img/aws-market.png)



#### Activation via Microsoft Azure Marketplace {#azure}

You must first purchase the commercial version product of <<< custom_key.brand_name >>> on Microsoft Azure Marketplace and activate the workspace through your Microsoft Azure account. All subsequent costs generated within the workspace will be directly settled from your Microsoft Azure account.

1. Fill in workspace name;
2. Select workspace language;
3. Click activate.

![](img/register_azure.png)


In the pop-up window, [go to Microsoft Azure Marketplace Subscription](./commercial-azure.md#subscribe), after completing the subscription on the cloud marketplace, return to <<< custom_key.brand_name >>> test and click **Confirm** to complete registration.

![](img/register_azure-1.png)


### Synchronized Creation of Billing Center Account {#sync}

The **initial username and password of the Billing Center** are the same as <<< custom_key.brand_name >>> (i.e., the username/password you filled out in the first step). The account systems of the two platforms are independent. Subsequent modifications to the username/password will not affect the other platform.

In the above activation methods, selecting this option will synchronize the creation of a billing center account for you.

## Step Four: Activation Successful {#success}

After completing the above steps, you will successfully activate the Commercial Plan of <<< custom_key.brand_name >>>.

![](img/1.sls_8.png)

After logging into the workspace, you can view the version information of the current workspace in the <<< custom_key.brand_name >>> [Billing and Plans](../billing/index.md#billing) module.

If you only completed step two during registration, you will be prompted to create a workspace when logging in. Select the type of workspace you need to create to complete registration and login.