# Alibaba Cloud IDaaS Single Sign-On Example
---


## Use Cases

Alibaba Cloud IDaaS (CloudShield) is a provider of identity recognition and access management solutions. <<< custom_key.brand_name >>> supports federated identity authentication based on SAML 2.0 (Security Assertion Markup Language 2.0), which is an open standard used by many authentication providers (Identity Provider, IdP). You can integrate CloudShield with <<< custom_key.brand_name >>> through federated identity authentication based on SAML 2.0 to achieve automatic login (single sign-on) into the <<< custom_key.brand_name >>> platform to access corresponding workspace resources without creating separate <<< custom_key.brand_name >>> accounts for enterprises/teams.

## Steps {#step1}

1. Create an application in Alibaba Cloud IDaaS

**Note**: Before creating the application, you need to first register an account and create your organization on the [IDaaS Platform (CloudShield)](https://yundun.console.aliyun.com/).

1) Open and enter the IDaaS console, go to **Add Application > Standard Protocol**, and select to create a SAML2.0 SSO application. (Here we use <<< custom_key.brand_name >>> as an example)

![](../img/06_aliyun_01.png)

![](../img/06_aliyun_02.png)

2) After creating the application, click **Manage** to enter the application configuration interface. Before configuring single sign-on, you can prepare the application accounts and authorization.

① Add application accounts

![](../img/06_aliyun_03.png)

![](../img/06_aliyun_04.png)

② In this example, default authorization allows all members to access. If special authorization is required, you can click **Authorization** to modify the permission settings.

![](../img/06_aliyun_05.png)


1) After configuring the application accounts and authorization, click to enter the **Single Sign-On** page, locate the **Application Configuration Information** module, and click **Download** to obtain the IdP metadata file.

![](../img/06_aliyun_06.png)

2. Enable SSO single sign-on in <<< custom_key.brand_name >>> and update configurations on the IDaaS platform

1) Enable SSO single sign-on, in the <<< custom_key.brand_name >>> workspace **Management > Member Management > SSO Management**, click **Enable**.

> Refer to [Create SSO](../../management/sso/index.md).

**Note**: For account security considerations, <<< custom_key.brand_name >>> supports only one SSO configuration per workspace. If you have already configured SAML 2.0 previously, we will consider the last updated SAML2.0 configuration as the final single sign-on verification entry.

![](../img/1.sso_enable.png)

2) Upload the **metadata document** downloaded in [Step 1](#step1), configure the **domain (email suffix domain)**, select the **role**, and you can obtain the identity provider's **Entity ID** and **Assertion URL**, download the Service Provider Metadata data (you can save it via right-click after accessing the link information through a browser).

**Note**: The domain is used for email domain mapping between <<< custom_key.brand_name >>> and the identity provider to achieve single sign-on, i.e., the email suffix domain of the user must match the domain added in <<< custom_key.brand_name >>>.

![](../img/1.sso_enable_2.png)

1) Update the single sign-on configuration of the application on the IDaaS side

① Import the Metadata file of the Service Provider (SP) obtained in Step 2.

② After importing the Metadata, click **Parse** to automatically import the ACS URL and Entity ID parameters below.

③ Change the configuration at **Application Account** to **IDaaS Account / Email**.

④ Click to expand [Advanced Configuration]. (In the SaaS environment, assertion signature is enabled by default, while in the Deployment Edition (PaaS) environment, this parameter is disabled by default. After configuring the application information, you need to manually enable this parameter.)

⑤ Add a new **Assertion Attribute**, Key = "Email", Value = "user.email"

⑥ Click Save Configuration

![](../img/06_aliyun_09.png)

![](../img/06_aliyun_10.png)

3. Obtain the single sign-on URL

1) Access <<< custom_key.brand_name >>> through [**Single Sign-On**](https://<<< custom_key.studio_main_site_auth >>>/login/sso) and input the email address to get the login link. As shown below:

![](../img/06_aliyun_11.png)

![](../img/06_aliyun_12.png)

2) Through the **Login URL** provided on the SSO login configuration details page, click to visit. As shown below:

![](../img/06_aliyun_13.png)


4. Click the link to be redirected to the IDaaS platform to input username and password. After successful verification, you can log in to <<< custom_key.brand_name >>>. After logging in, as shown below:

1) Input username and password to log in on the IDaaS platform.

![](../img/06_aliyun_14.png)

2) After successful login, the <<< custom_key.brand_name >>> page will be displayed.

**Note**: If multiple workspaces are configured with the same identity provider SSO single sign-on, users can switch to different workspaces to view data by clicking the workspace option in the upper-left corner of <<< custom_key.brand_name >>> after logging in through SSO.

![](../img/06_aliyun_15.png)